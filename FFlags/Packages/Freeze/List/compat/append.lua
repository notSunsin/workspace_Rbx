-- Decompiled with Potassium's decompiler.

local push = require(script.Parent.Parent.push);
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: table, ...) -- Line: 10, Name: append
    -- upvalues: deprecationWarning (copy), push (copy)
    deprecationWarning("List." .. script.Name, "List.push");

    return push(p1, ...);
end;