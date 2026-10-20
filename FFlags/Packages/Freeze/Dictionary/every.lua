-- Decompiled with Potassium's decompiler.

local every = require(script.Parent.Parent.utils.every);

return function(p1: table, p2: function) -- Line: 16, Name: every
    -- upvalues: every (copy)
    return every(p1, p2);
end;