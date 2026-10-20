-- Decompiled with Potassium's decompiler.

return function(p1: any, p2: function) -- Line: 3
    local v3 = 0;

    for i, v in p1 do
        v3 = v3 + 1;

        if p2(v, i) == false then
            break;
        end;
    end;

    return v3;
end;