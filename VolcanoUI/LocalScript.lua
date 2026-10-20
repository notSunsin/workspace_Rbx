-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local UIScale = script_Parent.Holder.UIScale;
script_Parent.Holder.Visible = true;
game.TweenService:Create(UIScale, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
    Scale = 1
}):Play();
game.TweenService:Create(script_Parent.Holder.Frame.Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
    GroupTransparency = 0
}):Play();
task.wait(5);
game.TweenService:Create(UIScale, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
    Scale = 0
}):Play();
task.wait(1);
script_Parent:Destroy();