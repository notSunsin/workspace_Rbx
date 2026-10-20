-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");

return {
    Play = function(p1: userdata, p2: number) -- Line: 8, Name: Play
        -- upvalues: TweenService (copy)
        local v3 = p2 / 16 * 0.30000000000000004 + 0.35;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.Position = UDim2.new(0.5, 0, 0.42, 0);
        TextLabel.Size = UDim2.new(0.6, 0, v3, 0);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
        TextLabel.TextStrokeTransparency = 0;
        TextLabel.TextScaled = true;
        TextLabel.Font = Enum.Font.GothamBold;
        TextLabel.Text = `🎉 TIER {p2} UNLOCKED 🎉`;
        TextLabel.TextTransparency = 0;
        TextLabel.ZIndex = 101;
        TextLabel.Parent = p1;
        TweenService:Create(TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.75, 0, v3 + 0.04, 0)
        }):Play();
        task.wait(0.8);
        TweenService:Create(TextLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.36, 0)
        }):Play();
        task.wait(0.6);
        TextLabel:Destroy();
    end
};