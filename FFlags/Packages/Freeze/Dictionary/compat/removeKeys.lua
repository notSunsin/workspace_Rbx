-- Decompiled with Potassium's decompiler.

local remove = require(script.Parent.Parent:FindFirstChild("remove"));
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: table, ...) -- Line: 10, Name: removeKeys
    -- upvalues: deprecationWarning (copy), remove (copy)
    deprecationWarning("Dictionary." .. script.Name, "Dictionary.remove");

    return remove(p1, ...);
end;