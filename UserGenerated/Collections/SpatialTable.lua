-- Decompiled with Potassium's decompiler.

local function hash(p1: number, p2: number, p3: number) -- Line: 45
    return (bit32.band(p1, 262143) * 262144 + bit32.band(p3, 262143)) * 131072 + bit32.band(p2, 131071);
end;

local function quantize(p4: vector, p5: number) -- Line: 49
    return p4.X // p5, p4.Y // p5, p4.Z // p5;
end;

local function key(p6: vector, p7: number) -- Line: 53
    local v8 = p6.Y // p7;
    local v9 = p6.Z // p7;

    return (bit32.band(p6.X // p7, 262143) * 262144 + bit32.band(v9, 262143)) * 131072 + bit32.band(v8, 131071);
end;

local v10 = {};
local table_freeze_ret = table.freeze({
    __index = v10
});

function v10.Insert(p11, p12, p13) -- Line: 63
    local v14 = typeof(p12) == "Vector3";
    assert(v14);
    local Epsilon = p11.Epsilon;
    local v15 = p12.Y // Epsilon;
    local v16 = p12.Z // Epsilon;
    local v17 = (bit32.band(p12.X // Epsilon, 262143) * 262144 + bit32.band(v16, 262143)) * 131072 + bit32.band(v15, 131071);
    local v18 = {
        Pos = p12,
        Value = p13
    };
    local Table = p11.Table;

    if not Table[v17] then
        Table[v17] = {};
    end;

    table.insert(Table[v17], v18);
end;

function v10.Remove(p19, p20, p21) -- Line: 75
    local v22 = typeof(p20) == "Vector3";
    assert(v22);
    local Epsilon = p19.Epsilon;
    local v23 = p20.Y // Epsilon;
    local v24 = p20.Z // Epsilon;
    local v25 = (bit32.band(p20.X // Epsilon, 262143) * 262144 + bit32.band(v24, 262143)) * 131072 + bit32.band(v23, 131071);
    local v26 = p19.Table[v25];

    if not v26 then
        return;
    end;

    for i = #v26, 1, -1 do
        local v27;

        if v26[i].Value == p21 then
            table.remove(v26, i);
            v27 = i;
        else
            v27 = i;
        end;
    end;

    if #v26 == 0 then
        p19.Table[v25] = nil;
    end;
end;

function v10.Collect(p28, p29, p30) -- Line: 94
    local v31 = typeof(p29) == "Vector3";
    assert(v31);
    local v32;

    if p30 == nil then
        v32 = true;
    elseif type(p30) == "number" and p30 > 0 then
        v32 = math.floor(p30) == p30;
    else
        v32 = false;
    end;

    assert(v32);
    local Epsilon = p28.Epsilon;
    local v33 = p29.X // Epsilon;
    local v34 = p29.Y // Epsilon;
    local v35 = p29.Z // Epsilon;
    local Table = p28.Table;
    local v36 = p30 or 1;
    local v37 = {};
    local v38 = 0;

    for i = -v36, v36 do
        local v39 = i;

        for i2 = -v36, v36 do
            local v40 = i2;

            for i3 = -v36, v36 do
                local v41 = Table[(bit32.band(v33 + v39, 262143) * 262144 + bit32.band(v35 + i3, 262143)) * 131072 + bit32.band(v34 + v40, 131071)];
                local v42;

                if v41 then
                    v42 = i3;

                    for _, v in ipairs(v41) do
                        v38 = v38 + 1;
                        v37[v38] = v.Value;
                    end;
                else
                    v42 = i3;
                end;
            end;
        end;
    end;

    v37.n = v38;

    return v37;
end;

function v10.Query(p43, p44, p45) -- Line: 122
    local v46 = typeof(p44) == "Vector3";
    assert(v46);
    local v47;

    if p45 == nil then
        v47 = true;
    elseif type(p45) == "number" and p45 > 0 then
        v47 = math.floor(p45) == p45;
    else
        v47 = false;
    end;

    assert(v47);
    local Epsilon = p43.Epsilon;
    local v48 = p44.X // Epsilon;
    local v49 = p44.Y // Epsilon;
    local v50 = p44.Z // Epsilon;
    local Table = p43.Table;
    local v51 = p45 or 1;
    local v52 = nil;
    local v53 = nil;

    for i = -v51, v51 do
        local v54 = i;

        for i2 = -v51, v51 do
            local v55 = i2;

            for i3 = -v51, v51 do
                local v56 = Table[(bit32.band(v48 + v54, 262143) * 262144 + bit32.band(v50 + i3, 262143)) * 131072 + bit32.band(v49 + v55, 131071)];
                local v57;

                if v56 then
                    v57 = i3;

                    for _, v in ipairs(v56) do
                        local Magnitude = (v.Pos - p44).Magnitude;

                        if not v52 or Magnitude < v52 then
                            v53 = v.Value;
                            v52 = Magnitude;
                        end;
                    end;
                else
                    v57 = i3;
                end;
            end;
        end;
    end;

    return v53;
end;

table.freeze(v10);

return table.freeze({
    new = function(p58: number?, p59: any) -- Line: 156, Name: new
        -- upvalues: table_freeze_ret (copy)
        local v60;

        if p58 == nil then
            v60 = true;
        elseif type(p58) == "number" then
            v60 = p58 > 0;
        else
            v60 = false;
        end;

        assert(v60);

        return setmetatable({
            Table = {},
            Epsilon = p58 or 10
        }, table_freeze_ret);
    end
});