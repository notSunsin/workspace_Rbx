-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local TweenInfo_new_ret2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local CanvasGroup = script.Parent.CanvasGroup;
CanvasGroup.Position = UDim2.new(0.5, 0, 0.4, 0);
TweenService:Create(CanvasGroup, TweenInfo_new_ret, {
    Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play();
CanvasGroup.GroupTransparency = 1;
TweenService:Create(CanvasGroup, TweenInfo_new_ret, {
    GroupTransparency = 0
}):Play();
local EVENT_SFX = game.SoundService.EVENT_SFX;
EVENT_SFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
EVENT_SFX.TimePosition = 0;
EVENT_SFX.Playing = true;
task.wait(math.random(5, 7));
TweenService:Create(CanvasGroup, TweenInfo_new_ret2, {
    Position = UDim2.new(0.5, 0, 0.6, 0)
}):Play();
TweenService:Create(CanvasGroup, TweenInfo_new_ret2, {
    GroupTransparency = 1
}):Play();
game.Debris:AddItem(script.Parent, TweenInfo_new_ret2.Time);