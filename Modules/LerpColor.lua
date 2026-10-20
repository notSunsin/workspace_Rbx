-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3: number) -- Line: 3, Name: GetInterpolatedColor
    local v4, v5, v6 = p2:ToHSV();
    local v7, v8, v9 = p1:ToHSV();

    if math.abs(v4 - v7) > 0.5 then
        if v7 < v4 then
            v7 = v7 + 1;
        else
            v4 = v4 + 1;
        end;
    end;

    return Color3.fromHSV((v4 + (v7 - v4) * p3) % 1, v5 + (v8 - v5) * p3, v6 + (v9 - v6) * p3);
end;