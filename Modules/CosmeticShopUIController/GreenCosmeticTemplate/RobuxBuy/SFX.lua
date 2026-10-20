-- Decompiled with Potassium's decompiler.

local Hover = game.SoundService.Hover;
local Click = game.SoundService.Click;
local UserInputService = game:GetService("UserInputService");
game:GetService("TweenService");
TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);

if UserInputService.TouchEnabled == false then
    script.Parent.MouseEnter:Connect(function() -- Line: 7
        -- upvalues: Hover (copy)
        Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Hover.TimePosition = 0;
        Hover.Playing = true;
    end);
end;

script.Parent.MouseButton1Click:Connect(function() -- Line: 13
    -- upvalues: Click (copy)
    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Click.TimePosition = 0;
    Click.Playing = true;
end);