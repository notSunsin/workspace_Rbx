-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: function, p3: any, p4: boolean) -- Line: 3, Name: reduce
    local v5 = #p1 + 1;

    for i, v in p1 do
        local v6;

        if p4 then
            v6 = p1[v5 - i];
        else
            v6 = v;
        end;

        p3 = p2(p3, v6, i);
    end;

    return p3;
end;