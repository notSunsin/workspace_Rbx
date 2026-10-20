-- Decompiled with Potassium's decompiler.

local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: number, p2: any) -- Line: 9, Name: create
    -- upvalues: deprecationWarning (copy)
    deprecationWarning("List." .. script.Name, "table.create");

    return table.create(p1, p2);
end;