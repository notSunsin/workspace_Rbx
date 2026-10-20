-- Decompiled with Potassium's decompiler.

local function deepCopy(p1: any, p2: table?) -- Line: 3
    -- upvalues: deepCopy (copy)
    if type(p1) ~= "table" then
        return p1;
    end;

    local v3 = p2 or {};

    if v3[p1] then
        return v3[p1];
    end;

    local v4 = {};
    v3[p1] = v4;

    for i, v in pairs(p1) do
        v4[deepCopy(i, v3)] = deepCopy(v, v3);
    end;

    return v4;
end;

return deepCopy;