-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3, p4) -- Line: 1, Name: quadraticBezier
    local v5 = 1 - p1;

    return v5 * v5 * p2 + 2 * v5 * p1 * p3 + p1 * p1 * p4;
end;