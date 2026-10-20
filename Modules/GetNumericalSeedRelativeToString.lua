-- Decompiled with Potassium's decompiler.

return function(p1: string) -- Line: 1, Name: GetNumericalSeedRelativeToString
    local v2 = 0;

    for i = 1, #p1 do
        v2 = (v2 * 31 + string.byte(p1, i)) % 4294967296;
        local _ = i;
    end;

    return v2;
end;