-- Decompiled with Potassium's decompiler.

local updateIn = require(script.Parent.updateIn);
local merge = require(script.Parent.merge);

return function(p1: table, p2: any, ...) -- Line: 5
    -- upvalues: updateIn (copy), merge (copy)
    local u3 = { ... };

    return updateIn(p1, p2, function(p4) -- Line: 7
        -- upvalues: merge (ref), u3 (copy)
        return merge(p4, table.unpack(u3));
    end, {});
end;