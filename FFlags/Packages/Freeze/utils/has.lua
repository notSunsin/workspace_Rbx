-- Decompiled with Potassium's decompiler.

local isImmutable = require(script.Parent.isImmutable);
local isDataStructure = require(script.Parent.isDataStructure);

return function(p1, p2) -- Line: 5
    -- upvalues: isImmutable (copy), isDataStructure (copy)
    if isImmutable(p1) then
        return p1:has(p2);
    end;

    local v3 = isDataStructure(p1) and p1[p2] ~= nil;

    return v3;
end;