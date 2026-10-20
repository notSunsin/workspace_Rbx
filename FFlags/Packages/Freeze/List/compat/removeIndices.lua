-- Decompiled with Potassium's decompiler.

local remove = require(script.Parent.Parent:FindFirstChild("remove"));
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: table, ...) -- Line: 10, Name: removeIndices
    -- upvalues: deprecationWarning (copy), remove (copy)
    deprecationWarning("List." .. script.Name, "List.remove");

    return remove(p1, ...);
end;