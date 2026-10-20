-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);

local function removeSingle(p1: table, p2: number) -- Line: 4
    local v3 = #p1;
    local table_create_ret = table.create(v3 - 1);

    if p2 < 1 then
        p2 = p2 + (v3 + 1);
    end;

    if p2 <= 0 or v3 < p2 then
        return p1;
    end;

    local v4 = 1;

    for i, v in p1 do
        if i ~= p2 then
            table_create_ret[v4] = v;
            v4 = v4 + 1;
        end;
    end;

    return table_create_ret;
end;

return function(p5: table, ...) -- Line: 44, Name: remove
    -- upvalues: removeSingle (copy), maybeFreeze (copy)
    local v6 = { ... };

    if #v6 == 1 then
        return removeSingle(p5, v6[1]);
    end;

    local v7 = #p5;
    local v8 = {};
    local v9 = 0;

    for _, v in v6 do
        local v10;

        if v < 1 then
            v10 = v + (v7 + 1);
        else
            v10 = v;
        end;

        if v10 > 0 and v7 >= v10 then
            v8[v10] = true;
            v9 = v9 + 1;
        end;
    end;

    if v9 == 0 then
        return p5;
    end;

    local table_create_ret = table.create((math.max(1, v7 - v9)));
    local v11 = 1;

    for i, v in p5 do
        if not v8[i] then
            table_create_ret[v11] = v;
            v11 = v11 + 1;
        end;
    end;

    return maybeFreeze(table_create_ret);
end;