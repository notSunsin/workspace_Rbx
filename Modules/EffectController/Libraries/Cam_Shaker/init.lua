-- Decompiled with Potassium's decompiler.

local Shake = require(script:WaitForChild("Shake"));
local workspace_CurrentCamera = workspace.CurrentCamera;
local Settings = require(script:WaitForChild("Settings"));
local DD = Settings.DD;
local Min_Distance = Settings.Min_Distance;
local Check_Can_Shake = require(script:WaitForChild("Check_Can_Shake"));
local u1 = {
    punch_shake = {
        FadeInTime = 0,
        Frequency = 0.05,
        Amplitude = 0.35,
        SustainTime = 0.145,
        FadeOutTime = 0.15,
        RotationInfluence = Vector3.new(0.1, 0.1, 0.1),
        PositionInfluence = Vector3.new(0.4, 0.4, 0.4)
    },
    tiny_shake = {
        FadeInTime = 0,
        Frequency = 0.07,
        Amplitude = 0.25,
        SustainTime = 0.05,
        FadeOutTime = 0.2,
        RotationInfluence = Vector3.new(0.1, 0.1, 0.1),
        PositionInfluence = Vector3.new(0.5, 0.5, 0.5)
    },
    tiny_shake_less_aggresive = {
        FadeInTime = 0,
        Frequency = 0.15,
        Amplitude = 0.25,
        SustainTime = 0.1,
        FadeOutTime = 0.3,
        RotationInfluence = Vector3.new(0.1, 0.1, 0.1),
        PositionInfluence = Vector3.new(0.5, 0.5, 0.5)
    },
    medium_shake = {
        FadeInTime = 0,
        Frequency = 0.055,
        Amplitude = 0.98,
        SustainTime = 0.14,
        FadeOutTime = 0.5,
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25),
        PositionInfluence = Vector3.new(3.5, 3.5, 3.5)
    },
    medium_shake_longer = {
        FadeInTime = 0,
        Frequency = 0.1,
        Amplitude = 0.4,
        SustainTime = 0.9,
        FadeOutTime = 0.75,
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25),
        PositionInfluence = Vector3.new(3.5, 3.5, 3.5)
    },
    medium_tiny_shake = {
        FadeInTime = 0,
        Frequency = 0.1,
        Amplitude = 0.5,
        SustainTime = 0.14,
        FadeOutTime = 0.5,
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25),
        PositionInfluence = Vector3.new(3.5, 3.5, 3.5)
    },
    medium_tiny_shake2 = {
        FadeInTime = 0,
        Frequency = 0.15,
        Amplitude = 0.4,
        SustainTime = 0.14,
        FadeOutTime = 0.5,
        RotationInfluence = Vector3.new(0.15, 0.15, 0.15),
        PositionInfluence = Vector3.new(1, 1, 1)
    },
    activate_shake_less_aggresive = {
        FadeInTime = 0,
        Frequency = 0.22,
        Amplitude = 0.1,
        SustainTime = 0.2,
        FadeOutTime = 0.4,
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25),
        PositionInfluence = Vector3.new(0.5, 0.5, 0.5)
    },
    activate_shake = {
        FadeInTime = 0,
        Frequency = 0.15,
        Amplitude = 0.25,
        SustainTime = 0.1,
        FadeOutTime = 0.5,
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25),
        PositionInfluence = Vector3.new(1, 1, 1)
    }
};
local u2 = typeof;

return function(p3, p4) -- Line: 93
    -- upvalues: Check_Can_Shake (copy), u2 (copy), u1 (copy), Shake (copy), workspace_CurrentCamera (copy), Min_Distance (copy), DD (copy)
    if Check_Can_Shake() ~= true then
        return;
    end;

    local u5;

    if p3 == nil or p4 ~= nil then
        u5 = p3;
        p3 = p4;
    else
        u5 = nil;
    end;

    if u2(p3) ~= "table" and u1[p3] then
        p3 = u1[p3];
    end;

    if p3 == nil then
        return;
    end;

    if u2(p3) == "table" then
        local Value = Enum.RenderPriority.Camera.Value;
        local u6 = Shake.new();

        if p3 then
            for i, v in pairs(p3) do
                u6[i] = v;
            end;
        end;

        u6:Start();
        u6:BindToRenderStep(Shake.NextRenderName(), Value, function(p7, p8, p9) -- Line: 129
            -- upvalues: u6 (copy), u5 (ref), workspace_CurrentCamera (ref), Min_Distance (ref), DD (ref)
            local v10 = u6.center_pos or u5;

            if typeof(u5) == "BasePart" or typeof(u5) == "Part" then
                v10 = u5.Position;
            end;

            if v10 ~= nil then
                local math_clamp_ret = math.clamp((workspace_CurrentCamera.CFrame.Position - v10).Magnitude, Min_Distance, 999999);
                p7 = u6.InverseSquare(p7, math_clamp_ret) * DD;
                p8 = u6.InverseSquare(p8, math_clamp_ret) * DD;
            end;

            local v11 = workspace_CurrentCamera;
            v11.CFrame = v11.CFrame * (CFrame.new(p7) * CFrame.Angles(p8.X, p8.Y, p8.Z));

            if p9 == true then
                u6:Stop();
                u6:Destroy();
            end;
        end);

        return u6;
    end;
end;