-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(p1: table, p2: any) -- Line: 14, Name: removeValue
    -- upvalues: maybeFreeze (copy)
    local v3 = {};
    local v4 = false;

    for i, v in p1 do
        if v == p2 then
            v4 = true;
        else
            v3[i] = v;
        end;
    end;

    if v4 then
        return maybeFreeze(v3);
    end;

    return p1;
end;