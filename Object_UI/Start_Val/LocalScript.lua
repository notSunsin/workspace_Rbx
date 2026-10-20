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
local Purchase_Object = game.ReplicatedStorage.GameEvents.Purchase_Object;
local Object_ID = script.Parent.Parent.Object_ID;
local Green_VAL = game.Players.LocalPlayer.PlayerGui.Gradient_UI.Green_VAL;
local Red_VAL = game.Players.LocalPlayer.PlayerGui.Gradient_UI.Red_VAL;
local Error = game.SoundService.Error;
u1.Completed:Connect(function() -- Line: 28
    -- upvalues: u3 (ref), Purchase_Object (copy), Object_ID (copy), Green_VAL (copy), Red_VAL (copy), Error (copy)
    if time() - u3 >= 0.95 then
        if script.Parent.Parent.Cost_Val.Value <= game.Players.LocalPlayer.leaderstats["$"].Value then
            Purchase_Object:FireServer(Object_ID.Value);
            Green_VAL.Value = true;
        else
            Red_VAL.Value = true;
            Error.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Error.TimePosition = 0;
            Error.Playing = true;
        end;

        script.Parent.Value = false;
    end;
end);