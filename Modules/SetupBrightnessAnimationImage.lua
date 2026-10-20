-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");

local function BrightenColorHSV(p1, p2: number) -- Line: 3
    local v3, v4, v5 = p1:ToHSV();
    local math_clamp_ret = math.clamp(v5 + p2, 0, 1);

    return Color3.fromHSV(v3, v4, math_clamp_ret);
end;

return function(p6: userdata) -- Line: 9, Name: SetupBrightnessAnimation
    -- upvalues: TweenService (copy)
    local InletTexture = p6:FindFirstChild("InletTexture", true);

    if not p6:GetAttribute("DefaultColor") then
        p6:SetAttribute("DefaultColor", InletTexture.ImageColor3);
    end;

    local Attribute = p6:GetAttribute("DefaultColor");
    local v7, v8, v9 = Attribute:ToHSV();
    local math_clamp_ret = math.clamp(v9 + 0.1, 0, 1);
    local Color3_fromHSV_ret = Color3.fromHSV(v7, v8, math_clamp_ret);
    local SENSOR = p6:FindFirstChild("SENSOR", true);
    p6:FindFirstChild("UIScale", true);
    local u10 = TweenService:Create(InletTexture, TweenInfo.new(0.25), {
        ImageColor3 = Color3_fromHSV_ret
    });
    local u11 = TweenService:Create(InletTexture, TweenInfo.new(0.25), {
        ImageColor3 = Attribute
    });
    SENSOR.MouseEnter:Connect(function() -- Line: 29
        -- upvalues: u10 (copy)
        u10:Play();
    end);
    SENSOR.MouseLeave:Connect(function() -- Line: 33
        -- upvalues: u11 (copy)
        u11:Play();
    end);

    return SENSOR;
end;