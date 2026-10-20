-- Decompiled with Potassium's decompiler.

local mergeIn = require(script.Parent.Parent.utils.mergeIn);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: table, ...) -- Line: 25, Name: mergeIn
    -- upvalues: maybeFreeze (copy), mergeIn (copy)
    return maybeFreeze(mergeIn(p1, p2, ...));
end;