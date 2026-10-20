-- Decompiled with Potassium's decompiler.

local u1 = {};

function u1.DeepCopy(p2, p3) -- Line: 8
    -- upvalues: u1 (copy)
    local table_clone_ret = table.clone(p3);

    for i, v in table_clone_ret do
        if type(v) == "table" then
            table_clone_ret[i] = u1:DeepCopy(v);
        end;
    end;

    return table_clone_ret;
end;

function u1.MakeTable(p4, ...) -- Line: 19
    local u5 = {};

    local function flatten(p6) -- Line: 22
        -- upvalues: flatten (copy), u5 (copy)
        if typeof(p6) == "table" then
            for _, v in p6 do
                flatten(v);
            end;

            return;
        end;

        table.insert(u5, p6);
    end;

    for _, v in { ... } do
        if typeof(v) == "table" then
            for _, v2 in v do
                flatten(v2);
            end;
        else
            table.insert(u5, v);
        end;
    end;

    return u5;
end;

function u1.SetSubtract(p7, p8, p9) -- Line: 43
    local v10 = {};
    local v11 = {};

    for _, v in ipairs(p9) do
        v10[v] = true;
    end;

    for _, v in ipairs(p8) do
        if not v10[v] then
            table.insert(v11, v);
        end;
    end;

    return v11;
end;

return u1;