-- Decompiled with Potassium's decompiler.

local isValueObject = require(script.Parent.isValueObject);

return function(p1, p2) -- Line: 4
    -- upvalues: isValueObject (copy)
    if p1 == p2 or p1 ~= p1 and p2 ~= p2 then
        return true;
    end;

    if not (p1 and p2) then
        return false;
    end;

    if typeof(p1) == "function" and typeof(p2) == "function" then
        p1 = p1();
        p2 = p2();

        if p1 == p2 or p1 ~= p1 and p2 ~= p2 then
            return true;
        end;

        if not (p1 and p2) then
            return false;
        end;
    end;

    local v3 = isValueObject(p1) and isValueObject(p2) and p1.equals(p2);

    return v3 and true or false;
end;