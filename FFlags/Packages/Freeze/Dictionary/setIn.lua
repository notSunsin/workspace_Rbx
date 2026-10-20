-- Decompiled with Potassium's decompiler.

local setIn = require(script.Parent.Parent.utils.setIn);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: table, p3: any) -- Line: 24, Name: setIn
    -- upvalues: maybeFreeze (copy), setIn (copy)
    return maybeFreeze(setIn(p1, p2, p3));
end;