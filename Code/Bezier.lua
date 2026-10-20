-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(...) -- Line: 125
    -- upvalues: u1 (copy)
    local u2 = { ... };
    assert(#u2 >= 3, "Must have at least 3 points");
    local v3 = #u2 == 3;
    local v4 = #u2 == 4;
    local v5 = {};
    local Vector3_new = Vector3.new;
    local lerp = Vector3_new().lerp;
    local u6 = nil;
    local v7 = {};

    local function CreatePoint(p8) -- Line: 150
        -- upvalues: Vector3_new (copy), lerp (copy)
        return {
            p8.X,
            p8.Y,
            p8.Z,

            ToVector3 = function(p9) -- Line: 153, Name: ToVector3
                -- upvalues: Vector3_new (ref)
                return Vector3_new(p9[1], p9[2], p9[3]);
            end,

            lerp = function(p10, p11, p12) -- Line: 156, Name: lerp
                -- upvalues: lerp (ref)
                return lerp(p10:ToVector3(), p11:ToVector3(), p12);
            end
        };
    end;

    local u13, u14, u15;

    if v3 or v4 then
        u13 = v7;
        u14 = 0;
        u15 = nil;
    else
        for i = 1, #u2 - 1 do
            local v16 = CreatePoint(u2[i]);
            local v17 = { v16, CreatePoint(u2[i + 1]), (CreatePoint(v16)) };
            v7[#v7 + 1] = v17;
            local _ = i;
        end;

        u13 = v7;

        for i = #v7, 2, -1 do
            local _ = i;
            local v18 = {};

            for i2 = 1, i - 1 do
                local v19 = v7[i2];
                local v20 = { v19[3], v7[i2 + 1][3], (CreatePoint(v19[3])) };
                v18[i2] = v20;
                u13[#u13 + 1] = v20;
                local _ = i2;
            end;

            v7 = v18;
        end;

        u15 = v7[1];
        u14 = #u13;
    end;

    if v3 then
        local u21 = u2[1];
        local u22 = u2[2];
        local u23 = u2[3];

        function v5.Get(p24, p25, p26) -- Line: 201
            -- upvalues: u21 (copy), u22 (copy), u23 (copy)
            if p26 then
                p25 = p25 < 0 and 0 or (p25 > 1 and 1 or p25);
            end;

            return (1 - p25) * (1 - p25) * u21 + 2 * (1 - p25) * p25 * u22 + p25 * p25 * u23;
        end;
    elseif v4 then
        local u27 = u2[1];
        local u28 = u2[2];
        local u29 = u2[3];
        local u30 = u2[4];

        function v5.Get(p31, p32, p33) -- Line: 213
            -- upvalues: u27 (copy), u28 (copy), u29 (copy), u30 (copy)
            if p33 then
                p32 = p32 < 0 and 0 or (p32 > 1 and 1 or p32);
            end;

            return (1 - p32) * (1 - p32) * (1 - p32) * u27 + 3 * (1 - p32) * (1 - p32) * p32 * u28 + 3 * (1 - p32) * p32 * p32 * u29 + p32 * p32 * p32 * u30;
        end;
    else
        function v5.Get(p34, p35, p36) -- Line: 222
            -- upvalues: u14 (ref), u13 (copy), u15 (ref)
            if p36 then
                p35 = p35 < 0 and 0 or (p35 > 1 and 1 or p35);
            end;

            for i = 1, u14 do
                local v37 = u13[i];
                local v38 = v37[1]:lerp(v37[2], p35);
                local v39 = v37[3];
                local Y = v38.Y;
                local Z = v38.Z;
                v39[1] = v38.X;
                v39[2] = Y;
                v39[3] = Z;
                local _ = i;
            end;

            return u15[3]:ToVector3();
        end;
    end;

    function v5.GetLength(p40, p41) -- Line: 240
        -- upvalues: u6 (ref)
        if not u6 then
            local Path = p40:GetPath(p41 or 0.1);
            local v42 = 0;

            for i = 2, #Path do
                v42 = v42 + (Path[i - 1] - Path[i]).Magnitude;
                local _ = i;
            end;

            u6 = v42;
        end;

        return u6;
    end;

    function v5.GetPath(p43, p44) -- Line: 256
        local v45 = type(p44) == "number";
        assert(v45, "Must provide a step increment");
        local v46;

        if p44 > 0 then
            v46 = p44 < 1;
        else
            v46 = false;
        end;

        assert(v46, "Step out of domain; should be between 0 and 1 (exclusive)");
        local v47 = {};
        local v48 = 0;

        for i = 0, 1, p44 do
            v47[#v47 + 1] = p43:Get(i);
            v48 = i;
            local v49 = v48;
            local v50 = v48;
            v48 = v49;
            v50 = v49;
        end;

        if v48 < 1 then
            v47[#v47 + (1 - v48 < p44 * 0.5 and 0 or 1)] = p43:Get(1);
        end;

        return v47;
    end;

    function v5.GetPathByNumberSegments(p51, p52) -- Line: 275
        local v53 = type(p52) == "number";
        assert(v53, "Must provide number of segments");
        assert(p52 > 0, "Number of segments must be greater than 0");

        return p51:GetPath(1 / p52);
    end;

    function v5.GetPathBySegmentLength(p54, p55) -- Line: 282
        local v56 = type(p55) == "number";
        assert(v56, "Must provide a segment length");
        assert(p55 > 0, "Segment length must be greater than 0");
        local v57 = p54:GetLength() / p55 + 0.5;

        return p54:GetPathByNumberSegments((math.floor(v57)));
    end;

    function v5.GetPoints(p58) -- Line: 292
        -- upvalues: u2 (copy)
        return u2;
    end;

    return setmetatable(v5, u1);
end;

return u1;