-- Decompiled with Potassium's decompiler.

local remove = require(script.Parent.Parent:FindFirstChild("remove"));
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: table, p2: number) -- Line: 10, Name: removeIndex
    -- upvalues: deprecationWarning (copy), remove (copy)
    deprecationWarning("List." .. script.Name, "List.remove");

    return remove(p1, p2);
end;