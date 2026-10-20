-- Decompiled with Potassium's decompiler.

return function(p1: table, p2: any) -- Line: 3
    for _, v in p1 do
        if v == p2 then
            return true;
        end;
    end;

    return false;
end;