-- Decompiled with Potassium's decompiler.

local utils = script.Parent.Parent.utils;
local updateIn = require(utils.updateIn);
local maybeFreeze = require(utils.maybeFreeze);

return function(p1: table, p2: table, p3: function, p4: any) -- Line: 29
    -- upvalues: maybeFreeze (copy), updateIn (copy)
    return maybeFreeze(updateIn(p1, p2, p3, p4));
end;