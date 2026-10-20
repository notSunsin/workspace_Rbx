-- Decompiled with Potassium's decompiler.

return function(p1: number) -- Line: 2, Name: GenerateRandomString
    local v2 = "";

    for i = 1, p1 or 5 do
        local math_random_ret = math.random(62);
        v2 = v2 .. ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"):sub(math_random_ret, math_random_ret);
        local _ = i;
    end;

    return v2;
end;