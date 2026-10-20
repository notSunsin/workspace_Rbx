-- Decompiled with Potassium's decompiler.

local isImmutable = require(script.Parent.isImmutable);
local isDataStructure = require(script.Parent.isDataStructure);
local shallowCopy = require(script.Parent.shallowCopy);

return function(p1, p2) -- Line: 6
    -- upvalues: isDataStructure (copy), isImmutable (copy), shallowCopy (copy)
    if not isDataStructure(p1) then
        error("Cannot update non-data-structure value: " .. tostring(p1));
    end;

    if isImmutable(p1) then
        if not p1.remove then
            error("Cannot update immutable value without .remove() method: " .. tostring(p1));
        end;

        return p1:remove(p2);
    end;

    if not p1[p2] then
        return p1;
    end;

    local v3 = shallowCopy(p1);

    if #v3 > 0 then
        table.remove(p1, p2);

        return v3;
    end;

    p1[p2] = nil;

    return v3;
end;