-- Decompiled with Potassium's decompiler.

local Hover = game.SoundService.Hover;
local Click = game.SoundService.Click;
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local u1 = TweenService:Create(script.Parent, TweenInfo_new_ret, {
    Size = UDim2.new(1, 0, 1, 0)
});
local u2 = TweenService:Create(script.Parent, TweenInfo_new_ret, {
    Size = UDim2.new(0.9, 0, 0.9, 0)
});
script.Parent.Size = UDim2.new(0.9, 0, 0.9, 0);

if UserInputService.TouchEnabled == false then
    script.Parent.MouseEnter:Connect(function() -- Line: 10
        -- upvalues: Hover (copy), u1 (copy)
        Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Hover.TimePosition = 0;
        Hover.Playing = true;
        u1:Play();
    end);
    script.Parent.MouseLeave:Connect(function() -- Line: 16
        -- upvalues: u2 (copy)
        u2:Play();
    end);
end;

script.Parent.Parent.Activated:Connect(function() -- Line: 20
    -- upvalues: Click (copy)
    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Click.TimePosition = 0;
    Click.Playing = true;
end);