-- Decompiled with Potassium's decompiler.

local equalObjects = require(script.Parent.equalObjects);

local function compareDeep(p1, p2) -- Line: 4
    -- upvalues: compareDeep (copy)
    if type(p1) ~= "table" or type(p2) ~= "table" then
        return p1 == p2;
    end;

    for i, v in pairs(p1) do
        if not compareDeep(p2[i], v) then
            return false;
        end;
    end;

    for i, v in pairs(p2) do
        if not compareDeep(p1[i], v) then
            return false;
        end;
    end;

    return true;
end;

return function(...) -- Line: 24, Name: equalsDeep
    -- upvalues: equalObjects (copy), compareDeep (copy)
    if equalObjects(...) then
        return true;
    end;

    local v3 = select("#", ...);
    local v4 = select(1, ...);

    for i = 2, v3 do
        if not compareDeep(v4, (select(i, ...))) then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;