-- Decompiled with Potassium's decompiler.

local filter = require(script.Parent.filter);

return function(p1: table, u2: function) -- Line: 17, Name: filterNot
    -- upvalues: filter (copy)
    return filter(p1, function(p3, p4) -- Line: 18
        -- upvalues: u2 (copy)
        return not u2(p3, p4);
    end);
end;