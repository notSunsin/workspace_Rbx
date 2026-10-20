-- Decompiled with Potassium's decompiler.

local map = require(script.Parent.Parent.utils.map);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: function) -- Line: 22, Name: map
    -- upvalues: maybeFreeze (copy), map (copy)
    return maybeFreeze(map(p1, p2));
end;