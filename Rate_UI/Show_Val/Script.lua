-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local Parent = script.Parent.Parent;
local u1 = TweenService:Create(Parent.CanvasGroup, TweenInfo_new_ret, {
    GroupTransparency = 0
});
local u2 = TweenService:Create(Parent, TweenInfo_new_ret, {
    StudsOffset = Vector3.new(5.25, 0, 0)
});
local u3 = TweenService:Create(Parent, TweenInfo_new_ret, {
    Size = UDim2.new(Parent.Size.X.Scale * 1.1, 0, Parent.Size.Y.Scale * 1.1, 0)
});
local u4 = TweenService:Create(Parent.CanvasGroup, TweenInfo_new_ret, {
    GroupTransparency = 1
});
Parent.CanvasGroup.GroupTransparency = 1;

function UPD()
    -- upvalues: Parent (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), TweenInfo_new_ret (copy)
    if script.Parent.Value == true then
        Parent.StudsOffset = Vector3.new(3, 0, 0);
        u1:Play();
        u2:Play();

        return;
    end;

    u3:Play();
    u4:Play();
    game.Debris:AddItem(script.Parent.Parent, TweenInfo_new_ret.Time);
end;

UPD();
script.Parent:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 21
    UPD();
end);