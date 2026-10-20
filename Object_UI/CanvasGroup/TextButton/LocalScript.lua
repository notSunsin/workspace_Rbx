-- Decompiled with Potassium's decompiler.

local Hover = game.SoundService.Hover;
local Click = game.SoundService.Click;
local BackgroundColor3 = script.Parent.BackgroundColor3;
local UserInputService = game:GetService("UserInputService");
UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 6
    -- upvalues: Click (copy)
    if p1.KeyCode == Enum.KeyCode.ButtonR2 or p1.KeyCode == Enum.KeyCode.E then
        script.Parent.Parent.Parent.Start_Val.Value = true;
        Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Click.TimePosition = 0;
        Click.Playing = true;
        script.Parent.BackgroundColor3 = Color3.new(0, 0.7, 0);
    end;
end);
UserInputService.InputEnded:Connect(function(p3, p4) -- Line: 15
    -- upvalues: BackgroundColor3 (copy)
    if p3.KeyCode == Enum.KeyCode.ButtonR2 or p3.KeyCode == Enum.KeyCode.E then
        script.Parent.Parent.Parent.Start_Val.Value = false;
        script.Parent.BackgroundColor3 = BackgroundColor3;
    end;
end);
script.Parent.MouseButton1Down:Connect(function() -- Line: 21
    -- upvalues: Click (copy)
    script.Parent.Parent.Parent.Start_Val.Value = true;
    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Click.TimePosition = 0;
    Click.Playing = true;
    script.Parent.BackgroundColor3 = Color3.new(0, 0.7, 0);
end);
script.Parent.MouseLeave:Connect(function() -- Line: 29
    -- upvalues: BackgroundColor3 (copy)
    script.Parent.Parent.Parent.Start_Val.Value = false;
    script.Parent.BackgroundColor3 = BackgroundColor3;
end);
script.Parent.MouseButton1Up:Connect(function() -- Line: 34
    -- upvalues: BackgroundColor3 (copy)
    script.Parent.Parent.Parent.Start_Val.Value = false;
    script.Parent.BackgroundColor3 = BackgroundColor3;
end);
script.Parent.MouseEnter:Connect(function() -- Line: 39
    -- upvalues: Hover (copy)
    Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Hover.TimePosition = 0;
    Hover.Playing = true;
    script.Parent.BackgroundColor3 = Color3.new(0.3, 1, 0.3);
end);