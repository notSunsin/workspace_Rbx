-- Decompiled with Potassium's decompiler.

local updateIn = require(script.Parent.updateIn);
local None = require(script.Parent.Parent.None);

return function(p1, p2, u3) -- Line: 4
    -- upvalues: updateIn (copy), None (copy)
    return updateIn(p1, p2, function() -- Line: 5
        -- upvalues: u3 (copy)
        return u3;
    end, None);
end;