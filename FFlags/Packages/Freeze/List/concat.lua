-- Decompiled with Potassium's decompiler.

local None = require(script.Parent.Parent.None);
local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

return function(...) -- Line: 16, Name: concat
    -- upvalues: None (copy), maybeFreeze (copy)
    local v1 = {};
    local v2 = 1;

    for i = 1, select("#", ...) do
        local v3 = select(i, ...);
        local v4;

        if v3 == nil or (type(v3) ~= "table" or #v3 <= 0) then
            v4 = i;
        else
            v4 = i;

            for _, v in ipairs(v3) do
                if v ~= None then
                    v1[v2] = v;
                    v2 = v2 + 1;
                end;
            end;
        end;
    end;

    return maybeFreeze(v1);
end;