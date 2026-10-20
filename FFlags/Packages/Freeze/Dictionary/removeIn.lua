-- Decompiled with Potassium's decompiler.

local removeIn = require(script.Parent.Parent.utils.removeIn);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: table) -- Line: 16, Name: removeIn
    -- upvalues: maybeFreeze (copy), removeIn (copy)
    return maybeFreeze(removeIn(p1, p2));
end;