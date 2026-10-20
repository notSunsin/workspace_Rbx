-- Decompiled with Potassium's decompiler.

return function(p1: userdata) -- Line: 1, Name: getModelCornerVectors
    local _, v2 = p1:GetBoundingBox();
    local v3 = Vector3.new(v2.X, v2.Y, v2.Z) / 2;
    local v4 = Vector3.new(-v2.X, v2.Y, v2.Z) / 2;

    return {
        v3,
        -v3,
        v4,
        -v4
    };
end;