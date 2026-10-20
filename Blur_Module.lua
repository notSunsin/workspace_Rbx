-- Decompiled with Potassium's decompiler.

local v1 = {};
local TweenService = game:GetService("TweenService");
local Blur = game.Lighting.Blur;

function v1.Blur(p2, p3) -- Line: 4
    -- upvalues: TweenService (copy), Blur (copy)
    local v4 = TweenService:Create(Blur, TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), {
        Size = p2
    });
    v4:Play();
    game.Debris:AddItem(v4, p3);
end;

return v1;