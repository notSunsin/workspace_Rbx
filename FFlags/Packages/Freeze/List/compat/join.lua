-- Decompiled with Potassium's decompiler.

local merge = require(script.Parent.Parent.merge);
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(...) -- Line: 10, Name: join
    -- upvalues: deprecationWarning (copy), merge (copy)
    deprecationWarning("List." .. script.Name, "List.merge");

    return merge(...);
end;