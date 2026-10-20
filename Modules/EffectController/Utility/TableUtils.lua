-- Decompiled with Potassium's decompiler.

local function deepCopy(p1) -- Line: 2
    -- upvalues: deepCopy (copy)
    if typeof(p1) ~= "table" then
        return p1;
    end;

    local v2 = {};

    for i, v in pairs(p1) do
        v2[i] = deepCopy(v);
    end;

    return v2;
end;

local function deepEquals(p3, p4) -- Line: 13
    -- upvalues: deepEquals (copy)
    if typeof(p3) ~= "table" or typeof(p4) ~= "table" then
        return p3 == p4;
    end;

    for i, v in pairs(p3) do
        if not deepEquals(v, p4[i]) then
            return false;
        end;
    end;

    for i, v in pairs(p4) do
        if not deepEquals(v, p3[i]) then
            return false;
        end;
    end;

    return true;
end;

return {
    deepCopy = deepCopy,
    deepEquals = deepEquals,

    getDictionaryLength = function(p5) -- Line: 30, Name: getDictionaryLength
        local v6 = 0;

        for _, _ in p5 do
            v6 = v6 + 1;
        end;

        return v6;
    end
};