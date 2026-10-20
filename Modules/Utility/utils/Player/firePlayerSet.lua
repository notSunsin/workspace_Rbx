-- Decompiled with Potassium's decompiler.

return function(p1: any, p2: userdata, ...) -- Line: 1, Name: firePlayerSet
    for _, v in pairs(p1.list) do
        p2:FireClient(v, ...);
    end;
end;