-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: number, p3: any) -- Line: 21, Name: get
    if type(p2) == "number" and p2 < 0 then
        p2 = #p1 + (p2 + 1);
    end;

    return p1[p2] or p3;
end;