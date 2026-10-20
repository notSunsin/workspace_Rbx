-- Decompiled with Potassium's decompiler.

local reverse = require(script.Parent.Parent.reverse);
local find = require(script.Parent.Parent.find);
local deprecationWarning = require(script.Parent.Parent.Parent.utils.deprecationWarning);

return function(p1: table, p2: function, p3: userdata?) -- Line: 11, Name: findWhereLast
    -- upvalues: deprecationWarning (copy), reverse (copy), find (copy)
    assert(p3 == nil, "[Freeze] findWhereLast\'s `from` argument is not supported.");
    deprecationWarning("List." .. script.Name, "List.reverse and then List.find");

    return find(reverse(p1), p2);
end;