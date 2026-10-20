-- Decompiled with Potassium's decompiler.

return function(p1: number, p2: number) -- Line: 1, Name: RoundToNearestNumber
    return math.floor(p1 / p2 + 0.5) * p2;
end;