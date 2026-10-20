-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");

return {
    CreateBubble = function(p1, p2, p3, p4, p5, p6) -- Line: 9, Name: CreateBubble
        -- upvalues: TweenService (copy)
        local v7 = script.BubbleMesh:Clone();
        v7.CFrame = p1;
        v7.Anchored = true;
        v7.CanCollide = false;
        v7.Massless = true;
        v7.Material = Enum.Material.Glass;
        v7.Size = p2;
        v7.Transparency = p3;
        v7.Parent = workspace:FindFirstChild("Effects") or workspace;
        local Highlight = Instance.new("Highlight");
        Highlight.Enabled = false;
        Highlight.Parent = v7;
        game:GetService("Debris"):AddItem(v7, p5);
        TweenService:Create(v7, TweenInfo.new(p5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
            Transparency = p6,
            Size = p4
        }):Play();
    end
};