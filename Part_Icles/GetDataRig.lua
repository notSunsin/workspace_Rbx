-- Decompiled with Potassium's decompiler.

local v1 = {};

local function asRange(p2, p3) -- Line: 11
    if typeof(p2) == "NumberRange" then
        return p2;
    end;

    if typeof(p2) == "number" then
        return NumberRange.new(p2);
    end;

    return p3;
end;

function v1.readRocks(p4, p5, p6, p7) -- Line: 17
    p4.PartLife = p6:GetAttribute("PartLife") or 0;
    p4.Lifetime = p6:GetAttribute("Lifetime") or NumberRange.new(3);
    p4.Rate = p6:GetAttribute("Rate") or 2;
    p4.BurstMode = p6:GetAttribute("BurstMode") or "Directional";
    p4.EmissionDirection = p7(Enum.NormalId, p6:GetAttribute("EmissionDirection"), Enum.NormalId.Top);
    p4.SpreadAngle = p6:GetAttribute("SpreadAngle") or Vector2.new(25, 25);
    p4.Speed = p6:GetAttribute("Speed");
    local Attribute = p6:GetAttribute("ChunkCount");
    local NumberRange_new_ret = NumberRange.new(6, 10);

    if typeof(Attribute) == "NumberRange" then
        NumberRange_new_ret = Attribute;
    elseif typeof(Attribute) == "number" then
        NumberRange_new_ret = NumberRange.new(Attribute);
    end;

    p4.ChunkCount = NumberRange_new_ret;
    local Attribute2 = p6:GetAttribute("ChunkScale");
    local NumberRange_new_ret2 = NumberRange.new(0.5, 1.5);

    if typeof(Attribute2) == "NumberRange" then
        NumberRange_new_ret2 = Attribute2;
    elseif typeof(Attribute2) == "number" then
        NumberRange_new_ret2 = NumberRange.new(Attribute2);
    end;

    p4.ChunkScale = NumberRange_new_ret2;
    local Attribute3 = p6:GetAttribute("PosX");
    local NumberRange_new_ret3 = NumberRange.new(0);

    if typeof(Attribute3) == "NumberRange" then
        NumberRange_new_ret3 = Attribute3;
    elseif typeof(Attribute3) == "number" then
        NumberRange_new_ret3 = NumberRange.new(Attribute3);
    end;

    p4.PosX = NumberRange_new_ret3;
    local Attribute4 = p6:GetAttribute("PosY");
    local NumberRange_new_ret4 = NumberRange.new(0);

    if typeof(Attribute4) == "NumberRange" then
        NumberRange_new_ret4 = Attribute4;
    elseif typeof(Attribute4) == "number" then
        NumberRange_new_ret4 = NumberRange.new(Attribute4);
    end;

    p4.PosY = NumberRange_new_ret4;
    local Attribute5 = p6:GetAttribute("PosZ");
    local NumberRange_new_ret5 = NumberRange.new(0);

    if typeof(Attribute5) == "NumberRange" then
        NumberRange_new_ret5 = Attribute5;
    elseif typeof(Attribute5) == "number" then
        NumberRange_new_ret5 = NumberRange.new(Attribute5);
    end;

    p4.PosZ = NumberRange_new_ret5;
    p4.PosMode = p6:GetAttribute("PosMode") or "Local";
    p4.PosXEven = p6:GetAttribute("PosXEven") == true;
    p4.PosYEven = p6:GetAttribute("PosYEven") == true;
    p4.PosZEven = p6:GetAttribute("PosZEven") == true;
    p4.Gravity = p6:GetAttribute("Gravity") or 196.2;
    local Attribute6 = p6:GetAttribute("Bounciness");
    local NumberRange_new_ret6 = NumberRange.new(0.3, 0.5);

    if typeof(Attribute6) == "NumberRange" then
        NumberRange_new_ret6 = Attribute6;
    elseif typeof(Attribute6) == "number" then
        NumberRange_new_ret6 = NumberRange.new(Attribute6);
    end;

    p4.Bounciness = NumberRange_new_ret6;
    p4.Friction = p6:GetAttribute("Friction") or 0.3;
    local Attribute7 = p6:GetAttribute("TumbleSpeed");
    local NumberRange_new_ret7 = NumberRange.new(90, 360);

    if typeof(Attribute7) == "NumberRange" then
        NumberRange_new_ret7 = Attribute7;
    elseif typeof(Attribute7) == "number" then
        NumberRange_new_ret7 = NumberRange.new(Attribute7);
    end;

    p4.TumbleSpeed = NumberRange_new_ret7;
    p4.SinkOut = p6:GetAttribute("SinkOut") ~= false;
    p4.InheritFloor = p6:GetAttribute("InheritFloor") == true;
    p4.Scale = p6:GetAttribute("Scale");
    p4.Color = p6:GetAttribute("Color");
    p4.Brightness = p6:GetAttribute("Brightness");
    p4.Transparency = p6:GetAttribute("Transparency");
    p4.Timescale = p6:GetAttribute("Timescale");
    p4.Pool = p6:GetAttribute("Pool");

    return p4;
end;

function v1.readRope(p8, p9, p10, p11) -- Line: 54
    p8.PartLife = p10:GetAttribute("PartLife") or 0;
    p8.Lifetime = p10:GetAttribute("Lifetime") or NumberRange.new(2);
    p8.Rate = p10:GetAttribute("Rate") or 1;
    local Attribute = p10:GetAttribute("SegmentCount");
    local NumberRange_new_ret = NumberRange.new(12);

    if typeof(Attribute) == "NumberRange" then
        NumberRange_new_ret = Attribute;
    elseif typeof(Attribute) == "number" then
        NumberRange_new_ret = NumberRange.new(Attribute);
    end;

    p8.SegmentCount = NumberRange_new_ret;
    p8.PinMode = p10:GetAttribute("PinMode") or "BothEnds";
    local Target = p9:FindFirstChild("Target");
    p8.Target = Target and (Target:IsA("ObjectValue") and Target.Value) or nil;
    local Attribute2 = p10:GetAttribute("RopeLength");
    local NumberRange_new_ret2 = NumberRange.new(0);

    if typeof(Attribute2) == "NumberRange" then
        NumberRange_new_ret2 = Attribute2;
    elseif typeof(Attribute2) == "number" then
        NumberRange_new_ret2 = NumberRange.new(Attribute2);
    end;

    p8.RopeLength = NumberRange_new_ret2;
    p8.Slack = p10:GetAttribute("Slack") or 1.2;
    p8.Stiffness = p10:GetAttribute("Stiffness") or 4;
    p8.Damping = p10:GetAttribute("Damping") or 0.03;
    p8.Gravity = p10:GetAttribute("Gravity") or Vector3.new(0, -40, 0);
    local Attribute3 = p10:GetAttribute("WindAmplitude");
    local NumberRange_new_ret3 = NumberRange.new(0);

    if typeof(Attribute3) == "NumberRange" then
        NumberRange_new_ret3 = Attribute3;
    elseif typeof(Attribute3) == "number" then
        NumberRange_new_ret3 = NumberRange.new(Attribute3);
    end;

    p8.WindAmplitude = NumberRange_new_ret3;
    p8.WindFrequency = p10:GetAttribute("WindFrequency") or 2;
    p8.SpawnTarget = p10:GetAttribute("SpawnTarget") or "Start";
    local Attribute4 = p10:GetAttribute("PosX");
    local NumberRange_new_ret4 = NumberRange.new(0);

    if typeof(Attribute4) == "NumberRange" then
        NumberRange_new_ret4 = Attribute4;
    elseif typeof(Attribute4) == "number" then
        NumberRange_new_ret4 = NumberRange.new(Attribute4);
    end;

    p8.PosX = NumberRange_new_ret4;
    local Attribute5 = p10:GetAttribute("PosY");
    local NumberRange_new_ret5 = NumberRange.new(0);

    if typeof(Attribute5) == "NumberRange" then
        NumberRange_new_ret5 = Attribute5;
    elseif typeof(Attribute5) == "number" then
        NumberRange_new_ret5 = NumberRange.new(Attribute5);
    end;

    p8.PosY = NumberRange_new_ret5;
    local Attribute6 = p10:GetAttribute("PosZ");
    local NumberRange_new_ret6 = NumberRange.new(0);

    if typeof(Attribute6) == "NumberRange" then
        NumberRange_new_ret6 = Attribute6;
    elseif typeof(Attribute6) == "number" then
        NumberRange_new_ret6 = NumberRange.new(Attribute6);
    end;

    p8.PosZ = NumberRange_new_ret6;
    p8.PosXEven = p10:GetAttribute("PosXEven") == true;
    p8.PosYEven = p10:GetAttribute("PosYEven") == true;
    p8.PosZEven = p10:GetAttribute("PosZEven") == true;
    p8.PosMode = p10:GetAttribute("PosMode") or "Local";
    local Attribute7 = p10:GetAttribute("RotX");
    local NumberRange_new_ret7 = NumberRange.new(0);

    if typeof(Attribute7) == "NumberRange" then
        NumberRange_new_ret7 = Attribute7;
    elseif typeof(Attribute7) == "number" then
        NumberRange_new_ret7 = NumberRange.new(Attribute7);
    end;

    p8.RotX = NumberRange_new_ret7;
    local Attribute8 = p10:GetAttribute("RotY");
    local NumberRange_new_ret8 = NumberRange.new(0);

    if typeof(Attribute8) == "NumberRange" then
        NumberRange_new_ret8 = Attribute8;
    elseif typeof(Attribute8) == "number" then
        NumberRange_new_ret8 = NumberRange.new(Attribute8);
    end;

    p8.RotY = NumberRange_new_ret8;
    local Attribute9 = p10:GetAttribute("RotZ");
    local NumberRange_new_ret9 = NumberRange.new(0);

    if typeof(Attribute9) == "NumberRange" then
        NumberRange_new_ret9 = Attribute9;
    elseif typeof(Attribute9) == "number" then
        NumberRange_new_ret9 = NumberRange.new(Attribute9);
    end;

    p8.RotZ = NumberRange_new_ret9;
    p8.RotXEven = p10:GetAttribute("RotXEven") == true;
    p8.RotYEven = p10:GetAttribute("RotYEven") == true;
    p8.RotZEven = p10:GetAttribute("RotZEven") == true;
    p8.RotOrder = p10:GetAttribute("RotOrder") or "Global";
    p8.GrowIn = p10:GetAttribute("GrowIn") or 0;
    p8.DeathMode = p10:GetAttribute("DeathMode") or "None";
    p8.DeathWindow = p10:GetAttribute("DeathWindow") or 0.2;
    p8.BendStiffness = p10:GetAttribute("BendStiffness") or 0;
    p8.ThicknessProfile = p10:GetAttribute("ThicknessProfile");
    p8.MotionDirection = p11(Enum.NormalId, p10:GetAttribute("MotionDirection"), Enum.NormalId.Front);
    p8.MotionTarget = p10:GetAttribute("MotionTarget") or "Start";
    p8.Speed = p10:GetAttribute("Speed");
    p8.Acceleration = p10:GetAttribute("Acceleration") or Vector3.new(0, 0, 0);
    p8.Drag = p10:GetAttribute("Drag") or 0;
    p8.PosOffsetX = p10:GetAttribute("PosOffsetX");
    p8.PosOffsetY = p10:GetAttribute("PosOffsetY");
    p8.PosOffsetZ = p10:GetAttribute("PosOffsetZ");
    p8.Turbulence = p10:GetAttribute("Turbulence");
    p8.TurbulenceFrequency = p10:GetAttribute("TurbulenceFrequency") or 1;
    p8.DisplacementMode = p10:GetAttribute("DisplacementMode") or "Global";
    local Attribute10 = p10:GetAttribute("LaunchSpeed");
    local NumberRange_new_ret10 = NumberRange.new(40);

    if typeof(Attribute10) == "NumberRange" then
        NumberRange_new_ret10 = Attribute10;
    elseif typeof(Attribute10) == "number" then
        NumberRange_new_ret10 = NumberRange.new(Attribute10);
    end;

    p8.LaunchSpeed = NumberRange_new_ret10;
    p8.EmissionDirection = p11(Enum.NormalId, p10:GetAttribute("EmissionDirection"), Enum.NormalId.Front);
    p8.SpreadAngle = p10:GetAttribute("SpreadAngle") or Vector2.new(0, 0);
    p8.Color = p10:GetAttribute("Color");
    p8.Brightness = p10:GetAttribute("Brightness");
    p8.Transparency = p10:GetAttribute("Transparency");
    p8.Thickness = p10:GetAttribute("Thickness");
    p8.Timescale = p10:GetAttribute("Timescale");
    p8.Pool = p10:GetAttribute("Pool");

    return p8;
end;

return v1;