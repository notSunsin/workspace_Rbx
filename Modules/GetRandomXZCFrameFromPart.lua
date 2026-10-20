-- Decompiled with Potassium's decompiler.

return function(p1: userdata) -- Line: 13, Name: GetRandomXZCFrameFromPart
    local Size = p1.Size;
    local v2 = (math.random() - 0.5) * Size.X;
    local v3 = (math.random() - 0.5) * Size.Z;
    local Vector3_new_ret = Vector3.new(v2, 0, v3);

    return p1.CFrame * CFrame.new(Vector3_new_ret);
end;