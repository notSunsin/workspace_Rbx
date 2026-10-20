-- Decompiled with Potassium's decompiler.

local slice = require(script.Parent.Parent.utils.slice);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: number?, p3: number?) -- Line: 29, Name: slice
    -- upvalues: maybeFreeze (copy), slice (copy)
    return maybeFreeze(slice(p1, p2, p3));
end;