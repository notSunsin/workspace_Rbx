-- Decompiled with Potassium's decompiler.

return function(p1, p2) -- Line: 1, Name: normalRandom
    local math_random_ret = math.random();
    local math_random_ret2 = math.random();
    local v3 = math.log(math_random_ret) * -2;

    return p1 + math.sqrt(v3) * math.cos(6.283185307179586 * math_random_ret2) * p2;
end;