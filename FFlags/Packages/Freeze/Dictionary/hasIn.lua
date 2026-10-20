-- Decompiled with Potassium's decompiler.

local getIn = require(script.Parent.Parent.utils.getIn);
local None = require(script.Parent.Parent.None);

return function(p1: table, p2: table) -- Line: 16, Name: hasIn
    -- upvalues: getIn (copy), None (copy)
    return getIn(p1, p2, None) ~= None;
end;