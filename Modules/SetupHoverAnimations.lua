-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");

return function(p1: userdata, p2: number?) -- Line: 4, Name: SetupHoverAnimations
    -- upvalues: TweenService (copy)
    local SENSOR = p1:FindFirstChild("SENSOR", true);
    local UIScale = p1:FindFirstChild("UIScale", true);
    local v3 = p2 or 0.05;
    local Scale = UIScale.Scale;
    local u4 = TweenService:Create(UIScale, TweenInfo.new(0.25), {
        Scale = Scale * (1 + v3)
    });
    local u5 = TweenService:Create(UIScale, TweenInfo.new(0.25), {
        Scale = Scale * (1 - v3)
    });
    local u6 = TweenService:Create(UIScale, TweenInfo.new(0.25), {
        Scale = Scale
    });
    SENSOR.MouseButton1Down:Connect(function() -- Line: 25
        -- upvalues: u5 (copy)
        u5:Play();
    end);
    SENSOR.MouseButton1Up:Connect(function() -- Line: 29
        -- upvalues: u4 (copy)
        u4:Play();
    end);
    SENSOR.MouseEnter:Connect(function() -- Line: 33
        -- upvalues: u4 (copy)
        u4:Play();
    end);
    SENSOR.MouseLeave:Connect(function() -- Line: 37
        -- upvalues: u6 (copy)
        u6:Play();
    end);

    return SENSOR;
end;