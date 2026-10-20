-- Decompiled with Potassium's decompiler.

local findKey = require(script.Parent.findKey);
local is = require(script.Parent.is);

return function(p1, u2) -- Line: 4
    -- upvalues: findKey (copy), is (copy)
    return findKey(p1, function(p3) -- Line: 5
        -- upvalues: is (ref), u2 (copy)
        return is(p3, u2);
    end);
end;