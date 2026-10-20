-- Decompiled with Potassium's decompiler.

local None = require(script.Parent.Parent.None);

return function(...) -- Line: 4
    -- upvalues: None (copy)
    local v1 = {};

    for i = 1, select("#", ...) do
        local v2 = select(i, ...);
        local v3;

        if v2 == nil then
            v3 = i;
        else
            local v4 = type(v2) == "table";
            assert(v4, "Expected table");
            v3 = i;

            for i2, v in v2 do
                if v == None then
                    v1[i2] = nil;
                else
                    v1[i2] = v;
                end;
            end;
        end;
    end;

    return v1;
end;