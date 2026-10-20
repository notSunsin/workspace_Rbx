-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

local function flattenImpl(p1: table, p2: number?) -- Line: 4
    -- upvalues: flattenImpl (copy)
    local v3 = {};

    for i, v in p1 do
        if type(v) == "table" and (not p2 or p2 > 0) then
            local v4;

            if p2 then
                v4 = p2 - 1;
            else
                v4 = p2;
            end;

            local v5 = flattenImpl(v, v4);

            for i2, v2 in pairs(v3) do
                v5[i2] = v2;
            end;

            v3 = v5;
        else
            v3[i] = v;
        end;
    end;

    return v3;
end;

return function(p6: table, p7: number?) -- Line: 45, Name: flatten
    -- upvalues: maybeFreeze (copy), flattenImpl (copy)
    return maybeFreeze((flattenImpl(p6, p7)));
end;