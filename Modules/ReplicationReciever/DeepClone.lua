-- Decompiled with Potassium's decompiler.

local function DeepCopy(p1) -- Line: 2
    -- upvalues: DeepCopy (copy)
    local table_clone_ret = table.clone(p1);

    for i, v in table_clone_ret do
        if type(v) == "table" then
            table_clone_ret[i] = DeepCopy(v);
        end;
    end;

    return table_clone_ret;
end;

return DeepCopy;