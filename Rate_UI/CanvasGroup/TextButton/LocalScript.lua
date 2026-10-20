-- Decompiled with Potassium's decompiler.

local Hover = game.SoundService.Hover;
local Click = game.SoundService.Click;
local UserInputService = game:GetService("UserInputService");
UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 5
    -- upvalues: Click (copy)
    if p1.KeyCode == Enum.KeyCode.ButtonR2 or p1.KeyCode == Enum.KeyCode.E then
        script.Parent.Parent.Parent.Start_Val.Value = true;
        Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Click.TimePosition = 0;
        Click.Playing = true;
    end;
end);
UserInputService.InputEnded:Connect(function(p3, p4) -- Line: 13
    if p3.KeyCode == Enum.KeyCode.ButtonR2 or p3.KeyCode == Enum.KeyCode.E then
        script.Parent.Parent.Parent.Start_Val.Value = false;
    end;
end);
script.Parent.MouseButton1Down:Connect(function() -- Line: 18
    -- upvalues: Click (copy)
    script.Parent.Parent.Parent.Start_Val.Value = true;
    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Click.TimePosition = 0;
    Click.Playing = true;
end);
script.Parent.MouseLeave:Connect(function() -- Line: 25
    script.Parent.Parent.Parent.Start_Val.Value = false;
end);
script.Parent.MouseButton1Up:Connect(function() -- Line: 29
    script.Parent.Parent.Parent.Start_Val.Value = false;
end);
script.Parent.MouseEnter:Connect(function() -- Line: 33
    -- upvalues: Hover (copy)
    Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Hover.TimePosition = 0;
    Hover.Playing = true;
end);