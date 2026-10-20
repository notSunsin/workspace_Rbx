-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");

local function BrightenColorHSV(p1, p2: number) -- Line: 3
    local v3, v4, v5 = p1:ToHSV();
    local math_clamp_ret = math.clamp(v5 + p2, 0, 1);

    return Color3.fromHSV(v3, v4, math_clamp_ret);
end;

return function(p6: userdata, p7: number) -- Line: 9, Name: SetupBrightnessAnimation
    -- upvalues: TweenService (copy)
    if not p6:GetAttribute("DefaultColor") then
        p6:SetAttribute("DefaultColor", p6.BackgroundColor3);
    end;

    local Attribute = p6:GetAttribute("DefaultColor");
    local v8, v9, v10 = Attribute:ToHSV();
    local math_clamp_ret = math.clamp(v10 + (p7 or 0.1), 0, 1);
    local Color3_fromHSV_ret = Color3.fromHSV(v8, v9, math_clamp_ret);
    local SENSOR = p6:FindFirstChild("SENSOR", true);
    p6:FindFirstChild("UIScale", true);
    local u11 = TweenService:Create(p6, TweenInfo.new(0.25), {
        BackgroundColor3 = Color3_fromHSV_ret
    });
    local u12 = TweenService:Create(p6, TweenInfo.new(0.25), {
        BackgroundColor3 = Attribute
    });
    SENSOR.MouseEnter:Connect(function() -- Line: 28
        -- upvalues: u11 (copy)
        u11:Play();
    end);
    SENSOR.MouseLeave:Connect(function() -- Line: 32
        -- upvalues: u12 (copy)
        u12:Play();
    end);

    return SENSOR;
end;