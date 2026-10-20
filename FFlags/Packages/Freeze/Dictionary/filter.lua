-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: function) -- Line: 16, Name: filter
    -- upvalues: maybeFreeze (copy)
    local v3 = {};

    for i, v in p1 do
        if p2(v, i) == true then
            v3[i] = v;
        end;
    end;

    return maybeFreeze(v3);
end;