-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

local function flatten(p1: table, p2: number?) -- Line: 27
    -- upvalues: flatten (copy), maybeFreeze (copy)
    local v3 = {};
    local v4 = 1;

    for _, v in p1 do
        if type(v) == "table" and (not p2 or p2 > 0) then
            local v5;

            if p2 then
                v5 = p2 - 1;
            else
                v5 = p2;
            end;

            local v6 = flatten(v, v5);

            for i = 1, #v6 do
                v3[v4] = v6[i];
                v4 = v4 + 1;
                local _ = i;
            end;
        else
            v3[v4] = v;
            v4 = v4 + 1;
        end;
    end;

    return maybeFreeze(v3);
end;

return flatten;