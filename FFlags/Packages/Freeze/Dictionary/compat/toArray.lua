-- Decompiled with Potassium's decompiler.

local values = require(script.Parent.Parent.values);
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: table) -- Line: 10, Name: toArray
    -- upvalues: deprecationWarning (copy), values (copy)
    deprecationWarning("Dictionary." .. script.Name, "Dictionary.values");

    return values(p1);
end;