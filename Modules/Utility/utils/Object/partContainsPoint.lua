-- Decompiled with Potassium's decompiler.

return function(p1: userdata, p2: vector) -- Line: 1, Name: partContainsPoint
    local v3 = p1.Size * 0.5;
    local v4 = p1.CFrame:PointToObjectSpace(p2);
    local v5;

    if math.abs(v4.X) <= v3.X and math.abs(v4.Y) <= v3.Y then
        v5 = math.abs(v4.Z) <= v3.Z;
    else
        v5 = false;
    end;

    return v5;
end;