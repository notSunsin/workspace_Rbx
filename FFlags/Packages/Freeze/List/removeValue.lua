-- Decompiled with Potassium's decompiler.

local maybeFreeze = require(script.Parent.Parent.utils.maybeFreeze);
local toSet = require(script.Parent.toSet);

local function removeValues(p1: table, ...) -- Line: 5
    -- upvalues: toSet (copy), maybeFreeze (copy)
    local v2 = toSet({ ... });
    local v3 = {};
    local v4 = 1;
    local v5 = false;

    for _, v in ipairs(p1) do
        if v2[v] then
            v5 = true;
        else
            v3[v4] = v;
            v4 = v4 + 1;
        end;
    end;

    if v5 then
        return maybeFreeze(v3);
    end;

    return p1;
end;

return function(p6: table, ...) -- Line: 36, Name: removeValue
    -- upvalues: maybeFreeze (copy), removeValues (copy)
    local v7 = { ... };

    if #v7 ~= 1 then
        return removeValues(p6, ...);
    end;

    local v8 = v7[1];
    local table_create_ret = table.create(#p6);
    local v9 = false;

    for _, v in p6 do
        if v == v8 then
            v9 = true;
        else
            table.insert(table_create_ret, v);
        end;
    end;

    if v9 then
        return maybeFreeze(table_create_ret);
    end;

    return p6;
end;