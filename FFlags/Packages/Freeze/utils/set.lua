-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 2
    if p1[p2] == p3 then
        return p1;
    end;

    local table_clone_ret = table.clone(p1);
    table_clone_ret[p2] = p3;

    return table_clone_ret;
end;