-- Decompiled with Potassium's decompiler.

return function(p1, p2: number) -- Line: 1, Name: BrightenColorHSV
    local v3, v4, v5 = p1:ToHSV();
    local math_clamp_ret = math.clamp(v5 + p2, 0, 1);

    return Color3.fromHSV(v3, v4, math_clamp_ret);
end;