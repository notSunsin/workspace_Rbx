-- Decompiled with Potassium's decompiler.

local update = require(script.Parent.Parent.utils.update);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: any, p3: function, p4: any) -- Line: 24, Name: update
    -- upvalues: maybeFreeze (copy), update (copy)
    return maybeFreeze(update(p1, p2, p3, p4));
end;