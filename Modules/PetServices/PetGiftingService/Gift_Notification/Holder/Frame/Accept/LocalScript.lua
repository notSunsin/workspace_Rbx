-- Decompiled with Potassium's decompiler.

local Hover = game.SoundService.Hover;
local Click = game.SoundService.Click;
script.Parent.MouseEnter:Connect(function() -- Line: 3
    -- upvalues: Hover (copy)
    Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Hover.Playing = true;
    Hover.TimePosition = 0;
end);
script.Parent.MouseButton1Click:Connect(function() -- Line: 8
    -- upvalues: Click (copy)
    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Click.Playing = true;
    Click.TimePosition = 0;
end);