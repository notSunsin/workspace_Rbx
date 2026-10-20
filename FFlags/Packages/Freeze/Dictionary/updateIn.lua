-- Decompiled with Potassium's decompiler.

local updateIn = require(script.Parent.Parent.utils.updateIn);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: table, p3: function, p4: any) -- Line: 31, Name: updateIn
    -- upvalues: maybeFreeze (copy), updateIn (copy)
    return maybeFreeze(updateIn(p1, p2, p3, p4));
end;