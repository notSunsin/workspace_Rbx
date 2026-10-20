-- Decompiled with Potassium's decompiler.

local u1 = {};

for _, child in pairs(script.Parent:GetChildren()) do
    if child:IsA("ImageButton") then
        table.insert(u1, child);
    end;
end;

for _, v in pairs(u1) do
    local Click = game.SoundService.Click;
    local Hover = game.SoundService.Hover;
    v.MouseButton1Down:Connect(function() -- Line: 10
        -- upvalues: Click (copy)
        Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Click.TimePosition = 0;
        Click.Playing = true;
    end);
    local UserInputService = game:GetService("UserInputService");
    v.MouseEnter:Connect(function() -- Line: 16
        -- upvalues: UserInputService (copy), Hover (copy)
        if UserInputService.TouchEnabled == false then
            Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Hover.TimePosition = 0;
            Hover.Playing = true;
        end;
    end);
    v.MouseButton1Click:Connect(function() -- Line: 23
        -- upvalues: u1 (copy), v (copy)
        for _, v2 in pairs(u1) do
            if v2.LayoutOrder <= v.LayoutOrder then
                v2.ImageColor3 = Color3.new(1, 1, 1);
                script.Parent.Parent.Parent.Parent.Parent.Rating_Val.Value = v.LayoutOrder;
            else
                v2.ImageColor3 = Color3.new(0, 0, 0);
            end;
        end;
    end);
end;