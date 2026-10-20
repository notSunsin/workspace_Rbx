-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local TweenInfo_new_ret2 = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local Hold_Down_Val = script.Parent.Parent.CanvasGroup.TextButton.Hold_Down_Val;
local u1 = TweenService:Create(Hold_Down_Val, TweenInfo_new_ret, {
    Size = UDim2.new(1, 0, 1, 0)
});
local u2 = TweenService:Create(Hold_Down_Val, TweenInfo_new_ret2, {
    BackgroundTransparency = 0.5
});
local u3 = time();
script.Parent:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 8
    -- upvalues: u3 (ref), u1 (copy), Hold_Down_Val (copy), u2 (copy)
    u3 = time();

    if script.Parent.Value ~= true then
        u1:Cancel();
        u2:Cancel();
        Hold_Down_Val.BackgroundTransparency = 1;

        return;
    end;

    u1:Cancel();
    Hold_Down_Val.Size = UDim2.new(0, 0, 1, 0);
    Hold_Down_Val.BackgroundTransparency = 1;
    u1:Play();
    u2:Play();
    u3 = time();
end);
local Send_Rating = game.ReplicatedStorage.GameEvents.Send_Rating;
local _ = game.Players.LocalPlayer.PlayerGui.Gradient_UI.Green_VAL;
local _ = game.Players.LocalPlayer.PlayerGui.Gradient_UI.Red_VAL;
local _ = game.SoundService.Error;
u1.Completed:Connect(function() -- Line: 27
    -- upvalues: u3 (ref), Send_Rating (copy)
    if time() - u3 >= 0.95 then
        script.Parent.Parent.Show_Val.Value = false;
        local v4 = game.Players:FindFirstChild(script.Parent.Parent.PLR_1.Value);

        if v4 and v4.Character then
            local Show_The_Val = v4.Character:FindFirstChild("Show_The_Val");
            local Character_Highlight_Click = v4.Character:FindFirstChild("Character_Highlight_Click");

            if Show_The_Val and Character_Highlight_Click then
                Show_The_Val.Value = false;
                Character_Highlight_Click.Value = false;
            end;
        end;

        Send_Rating:FireServer(script.Parent.Parent.PLR_1.Value, script.Parent.Parent.Rating_Val.Value);
    end;
end);