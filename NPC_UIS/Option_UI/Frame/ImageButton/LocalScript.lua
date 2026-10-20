-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local UIPadding = script.Parent.Parent.Frame.Text_Element.UIPadding;
local u1 = TweenService:Create(UIPadding, TweenInfo_new_ret, {
    PaddingLeft = UDim.new(0.04, 0)
});
local u2 = TweenService:Create(UIPadding, TweenInfo_new_ret, {
    PaddingLeft = UDim.new(0, 0)
});
local ImageLabel = script.Parent.Parent.ImageLabel;
local ImageTransparency = script.Parent.Parent.ImageLabel.ImageTransparency;
local u3 = TweenService:Create(ImageLabel, TweenInfo_new_ret, {
    ImageTransparency = 0
});
local u4 = TweenService:Create(ImageLabel, TweenInfo_new_ret, {
    ImageTransparency = ImageTransparency
});
local Hover = game.SoundService.Hover;
script.Parent.MouseEnter:Connect(function() -- Line: 12
    -- upvalues: Hover (copy), u1 (copy), u3 (copy)
    Hover.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
    Hover.Playing = true;
    Hover.TimePosition = 0;
    u1:Play();
    u3:Play();
end);
script.Parent.MouseLeave:Connect(function() -- Line: 19
    -- upvalues: u2 (copy), u4 (copy)
    u2:Play();
    u4:Play();
end);