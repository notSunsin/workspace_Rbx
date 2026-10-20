-- Decompiled with Potassium's decompiler.

local isImmutable = require(script.Parent.isImmutable);

return function(p1) -- Line: 4
    -- upvalues: isImmutable (copy)
    if isImmutable(p1) then
        return p1:clone();
    end;

    return table.clone(p1);
end;