-- Decompiled with Potassium's decompiler.

local removeValue = require(script.Parent.Parent.removeValue);
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: table, ...) -- Line: 10, Name: removeValues
    -- upvalues: deprecationWarning (copy), removeValue (copy)
    deprecationWarning("List." .. script.Name, "List.removeValue");

    return removeValue(p1, ...);
end;