-- Decompiled with Potassium's decompiler.

local None = require(script.Parent.Parent.None);
local get = require(script.Parent.get);

return function(p1: table, p2: table, p3: any) -- Line: 5
    -- upvalues: get (copy), None (copy)
    local v4 = 0;

    while v4 ~= #p2 do
        v4 = v4 + 1;
        p1 = get(p1, p2[v4], None);

        if p1 == None then
            return p3;
        end;
    end;

    return p1;
end;