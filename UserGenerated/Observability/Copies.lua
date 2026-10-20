-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Op = Observability.Op;
local TemplateNext = Observability.TemplateNext;
local u1 = {};
u1.__index = u1;

function u1.new(p2: number) -- Line: 63
    -- upvalues: u1 (copy)
    return setmetatable({
        PathCount = 0,
        NextKey = 1,
        TemplateCount = 0,
        LastAddId = 0,
        LastOffset = 0,
        ClassStride = p2 + 1,
        KeyOf = {},
        Paths = {},
        Templates = {}
    }, u1);
end;

function u1.refValue(p3: number?, p4: number) -- Line: 82
    if p3 then
        return p3 - p4;
    end;

    return false;
end;

function u1.differs(p5: table?, p6: table?, p7: table?, p8: number, p9: any, p10: any) -- Line: 89
    if p6 then
        local v11 = p6[p8];
        p6[p8] = p10;

        if p5 then
            return v11 ~= p10;
        end;
    end;

    if p7 then
        p7 = p7[p8] == p9;
    end;

    return not p7;
end;

local function closest(p12: table, p13: table?) -- Line: 110
    local v14 = p12[#p12];

    if not p13 then
        return v14, -1;
    end;

    local v15 = (1 / 0);

    for i = #p12, 1, -1 do
        local Values = p12[i].Values;
        local v16 = i;
        local v17 = 0;

        for i2, v in p13 do
            if Values[i2] ~= v then
                v17 = v17 + 1;

                if v15 <= v17 then
                    break;
                end;
            end;
        end;

        if v17 < v15 then
            v14 = p12[v16];

            if v17 == 0 then
                v15 = v17;
                break;
            end;

            v15 = v17;
        end;
    end;

    return v14, v15;
end;

local function writeDrop(p18: any, p19: table?) -- Line: 138
    -- upvalues: Op (copy), Codec (copy)
    p18:u8(Op.DropTemplates);

    if not p19 then
        Codec.varuint(p18, 0);

        return;
    end;

    Codec.varuint(p18, #p19);

    for _, v in p19 do
        Codec.varuint(p18, v.Id);
    end;
end;

function u1.WriteHead(p20: table, p21: any, p22: number, p23: number, p24: number, p25: string, p26: boolean, p27: table?) -- Line: 156
    -- upvalues: Op (copy), Codec (copy), closest (copy), TemplateNext (copy), writeDrop (copy)
    local v28 = (p20.KeyOf[p23] or -(p23 + 1)) * p20.ClassStride + p24;
    local v29 = p20.Paths[v28];

    if v29 then
        v29 = v29[p25];
    end;

    local v30 = v29 ~= nil;

    if not v29 then
        if p20.PathCount >= 65536 then
            if p20.TemplateCount > 0 then
                p21:u8(Op.DropTemplates);
                Codec.varuint(p21, 0);
            end;

            table.clear(p20.Paths);
            table.clear(p20.Templates);
            p20.PathCount = 0;
            p20.TemplateCount = 0;
        end;

        local v31 = p20.Paths[v28];

        if not v31 then
            v31 = {};
            p20.Paths[v28] = v31;
        end;

        v29 = p20.NextKey;
        p20.NextKey = p20.NextKey + 1;
        p20.PathCount = p20.PathCount + 1;
        v31[p25] = v29;
    end;

    p20.KeyOf[p22] = v29;
    local v32;

    if p26 and v30 then
        v32 = p20.Templates[v29];
    else
        v32 = nil;
    end;

    if not v32 or p23 >= p22 then
        local v33 = p26 and v30;

        if v33 then
            local v34 = p20.Templates[v29];

            if v34 then
                p20.TemplateCount = p20.TemplateCount - #v34;
            end;

            if p20.TemplateCount >= 8192 then
                p21:u8(Op.DropTemplates);
                Codec.varuint(p21, 0);
                table.clear(p20.Templates);
                p20.TemplateCount = 0;
            elseif v34 then
                writeDrop(p21, v34);
            end;

            p21:u8(Op.TemplateNext);
            p21:u8(TemplateNext.Add);
        end;

        p21:u8(Op.Add);
        Codec.varuint(p21, p22);
        Codec.varuint(p21, p23);
        Codec.varuint(p21, p24);
        Codec.str(p21, p25);
        p20.LastAddId = p22;

        if not v33 then
            return nil, nil;
        end;

        p20.TemplateCount = p20.TemplateCount + 1;
        local v35 = {};
        p20.Templates[v29] = {
            {
                Id = p22,
                ParentId = p23,
                Values = v35
            }
        };

        return nil, v35;
    end;

    local v36, v37 = closest(v32, p27);
    local v38;

    if v37 > 0 and (v36.ParentId == p23 and #v32 < 8) then
        v38 = p20.TemplateCount < 8192;
    else
        v38 = false;
    end;

    if v38 then
        p21:u8(Op.TemplateNext);
        p21:u8(TemplateNext.Keep);
    end;

    local v39 = p22 - v36.Id;
    local v40 = v39 - p20.LastOffset;
    p21:u8(Op.Copy);
    Codec.varuint(p21, p22 - p20.LastAddId);
    Codec.varuint(p21, p22 - p23);
    local v41;

    if v40 >= 0 then
        v41 = v40 * 2;
    else
        v41 = -v40 * 2 - 1;
    end;

    Codec.varuint(p21, v41);
    p20.LastOffset = v39;
    p20.LastAddId = p22;

    if v38 then
        local v42 = {
            Id = p22,
            ParentId = p23,
            Values = table.clone(v36.Values)
        };
        table.insert(v32, v42);
        p20.TemplateCount = p20.TemplateCount + 1;

        return v42, v42.Values;
    end;

    v36.Id = p22;
    v36.ParentId = p23;
    local table_find_ret = table.find(v32, v36);

    if table_find_ret ~= #v32 then
        table.remove(v32, table_find_ret);
        table.insert(v32, v36);
    end;

    return v36, v36.Values;
end;

function u1.Forget(p43: table, p44: number) -- Line: 260
    p43.KeyOf[p44] = nil;
end;

return u1;