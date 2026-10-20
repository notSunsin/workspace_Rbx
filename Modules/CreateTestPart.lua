-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 1, Name: CreateTestPart
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.Size = Vector3.new(0.5, 0.5, 0.5);
    Part.Shape = Enum.PartType.Ball;
    Part.Transparency = 0.5;
    Part.Color = Color3.fromRGB(255, 0, 0);
    Part.Material = Enum.Material.Neon;
    Part.Position = p1;
    Part.CanQuery = false;
    Part.Name = "TestPart";
    local SphereHandleAdornment = Instance.new("SphereHandleAdornment");
    SphereHandleAdornment.Adornee = Part;
    SphereHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Never;
    SphereHandleAdornment.Radius = 0.5;
    SphereHandleAdornment.AlwaysOnTop = true;
    SphereHandleAdornment.Parent = Part;
    task.delay(0.2, function() -- Line: 19
        -- upvalues: SphereHandleAdornment (copy)
        SphereHandleAdornment.ZIndex = 99;
    end);
    Part.Parent = workspace;

    return Part;
end;