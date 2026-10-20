-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3, p4) -- Line: 1, Name: solveIK
    local v5 = p1:pointToObjectSpace(p2);
    local unit = v5.unit;
    local magnitude = v5.magnitude;
    local v6 = (Vector3.new(0, 0, -1)):Cross(unit);
    local math_acos_ret = math.acos(-unit.Z);
    local v7 = p1 * CFrame.fromAxisAngle(v6, math_acos_ret);

    if magnitude < math.max(p4, p3) - math.min(p4, p3) then
        return v7 * CFrame.new(0, 0, math.max(p4, p3) - math.min(p4, p3) - magnitude), -1.5707963267948966, 3.141592653589793;
    end;

    if p3 + p4 < magnitude then
        return v7 * CFrame.new(0, 0, p3 + p4 - magnitude), 1.5707963267948966, 0;
    end;

    local v8 = -math.acos((-(p4 * p4) + p3 * p3 + magnitude * magnitude) / (2 * p3 * magnitude));
    local math_acos_ret2 = math.acos((p4 * p4 - p3 * p3 + magnitude * magnitude) / (2 * p4 * magnitude));

    return v7, v8 + 1.5707963267948966, math_acos_ret2 - v8;
end;