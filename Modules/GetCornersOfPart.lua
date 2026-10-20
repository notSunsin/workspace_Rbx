-- Decompiled with Potassium's decompiler.

return function(p1: userdata) -- Line: 1, Name: GetCornersOfPart
    local Size = p1.Size;
    local CFrame2 = p1.CFrame;

    return {
        CFrame2 * CFrame.new(Size.X / 2, Size.Y / 2, Size.Z / 2),
        CFrame2 * CFrame.new(-Size.X / 2, Size.Y / 2, Size.Z / 2),
        CFrame2 * CFrame.new(Size.X / 2, -Size.Y / 2, Size.Z / 2),
        CFrame2 * CFrame.new(-Size.X / 2, -Size.Y / 2, Size.Z / 2),
        CFrame2 * CFrame.new(Size.X / 2, Size.Y / 2, -Size.Z / 2),
        CFrame2 * CFrame.new(-Size.X / 2, Size.Y / 2, -Size.Z / 2),
        CFrame2 * CFrame.new(Size.X / 2, -Size.Y / 2, -Size.Z / 2),
        CFrame2 * CFrame.new(-Size.X / 2, -Size.Y / 2, -Size.Z / 2)
    };
end;