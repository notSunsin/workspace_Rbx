-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 1, Name: uniformVectorSphere
    local v2 = {};

    for i = 0, p1 - 1 do
        local v3 = 1 - i / (p1 - 1) * 2;
        local math_sqrt_ret = math.sqrt(1 - v3 * v3);
        local v4 = 2.399963229728653 * i;
        local v5 = math.cos(v4) * math_sqrt_ret;
        local v6 = math.sin(v4) * math_sqrt_ret;
        local Vector3_new_ret = Vector3.new(v5, v3, v6);
        table.insert(v2, Vector3_new_ret);
        local _ = i;
    end;

    return v2;
end;