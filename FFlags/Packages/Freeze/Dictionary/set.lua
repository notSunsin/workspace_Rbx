-- Decompiled with Potassium's decompiler.

local set = require(script.Parent.Parent.utils.set);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: any, p3: any) -- Line: 16, Name: set
    -- upvalues: maybeFreeze (copy), set (copy)
    if p2 == nil then
        return p1;
    end;

    return maybeFreeze(set(p1, p2, p3));
end;