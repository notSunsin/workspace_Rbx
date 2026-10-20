-- Decompiled with Potassium's decompiler.

return function(p1: vector, p2: vector, p3: vector) -- Line: 1, Name: getDirectedDistance
    return (p2 - p1):Dot(p3.Unit);
end;