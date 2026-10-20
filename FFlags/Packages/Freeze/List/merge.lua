-- Decompiled with Potassium's decompiler.

local merge = require(script.Parent.Parent.utils.merge);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(...) -- Line: 21, Name: merge
    -- upvalues: maybeFreeze (copy), merge (copy)
    return maybeFreeze(merge(...));
end;