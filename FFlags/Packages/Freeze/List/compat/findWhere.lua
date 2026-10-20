-- Decompiled with Potassium's decompiler.

local find = require(script.Parent.Parent.find);
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: table, p2: function, p3: userdata) -- Line: 10, Name: findWhere
    -- upvalues: deprecationWarning (copy), find (copy)
    assert(p3 == nil, "[Freeze] findWhere\'s `from` argument is not supported.");
    deprecationWarning("List." .. script.Name, "List.find");

    return find(p1, p2);
end;