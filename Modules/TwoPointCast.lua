-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1, Name: TwoPointRaycast
    local Magnitude = (p1 - p2).Magnitude;
    local v4 = CFrame.lookAt(p1, p2).LookVector * Magnitude;

    return workspace:Raycast(p1, v4, p3);
end;