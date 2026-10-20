-- Decompiled with Potassium's decompiler.

local u3 = {
    MakeChanced = function(p1: any, p2: number) -- Line: 7, Name: MakeChanced
        p1.Chance = p2;

        return p1;
    end
};

local function PrepareTable(p4: table) -- Line: 12
    local v5 = 0;
    local v6 = {};

    for _, v in pairs(p4) do
        local v7 = v.Chance or 1;
        v5 = v5 + v7;
        table.insert(v6, {
            Item = v,
            Chance = v7
        });
    end;

    return v6, v5;
end;

local function PickFromPrepared(p8: table, p9: number, p10: userdata?) -- Line: 25
    if p9 == 0 then
        return nil;
    end;

    local v11 = (p10 or Random.new()):NextNumber() * p9;
    local v12 = 0;

    for _, v in ipairs(p8) do
        v12 = v12 + v.Chance;

        if v11 <= v12 then
            return v.Item;
        end;
    end;

    return p8[#p8].Item;
end;

function u3.One(p13: table, p14: userdata?) -- Line: 46
    -- upvalues: PrepareTable (copy), PickFromPrepared (copy)
    local v15, v16 = PrepareTable(p13);
    local v17 = PickFromPrepared(v15, v16, p14 or Random.new());

    if not v17 then
        error("PickRandom.One: No item found. Input table is probably empty");
    end;

    return v17;
end;

function u3.List(p18: table, p19: number, p20: boolean?) -- Line: 61
    -- upvalues: PrepareTable (copy), PickFromPrepared (copy), u3 (copy)
    if p20 == nil then
        p20 = false;
    end;

    local v21 = {};

    if p20 then
        local v22, v23 = PrepareTable(p18);

        for i = 1, p19 do
            local v24 = PickFromPrepared(v22, v23);
            local v25;

            if v24 then
                table.insert(v21, v24);
                v25 = i;
            else
                v25 = i;
            end;
        end;

        return v21;
    end;

    local v26 = {};

    for i, v in pairs(p18) do
        v26[i] = v;
    end;

    for i = 1, p19 do
        if next(v26) == nil then
            break;
        end;

        local v27 = u3.One(v26);
        local v28;

        if v27 then
            table.insert(v21, v27);
            v28 = i;

            for i2, v in pairs(v26) do
                if v == v27 then
                    v26[i2] = nil;
                    break;
                end;
            end;
        else
            v28 = i;
        end;
    end;

    return v21;
end;

return u3;