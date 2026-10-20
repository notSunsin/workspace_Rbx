-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local _ = Players.LocalPlayer;
local HighlightRemote = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("HighlightRemote");
local u9 = {
    CreateHighlight = function(p1, p2, p3, p4, p5, p6, p7) -- Line: 11, Name: CreateHighlight
        -- upvalues: Debris (copy)
        if not (p2 and p2:IsA("Model")) then
            return;
        end;

        local math_min_ret = math.min(p3 or 3, 6);
        local v8 = p5 or Color3.new(1, 1, 1);
        local _ = p6 == true;
        local _ = typeof(p7) == "number" and math.clamp(p7, 0, 1);
        local Highlight = Instance.new("Highlight");
        Highlight.FillColor = p4 or Color3.new();
        Highlight.OutlineColor = v8;
        Highlight.FillTransparency = p4 and 0 or 1;
        Highlight.OutlineTransparency = 0;
        Highlight.Adornee = p2;
        Highlight.Parent = p2;
        Debris:AddItem(Highlight, math_min_ret);
    end
};
HighlightRemote.OnClientEvent:Connect(function(p10, p11, p12, p13, p14, p15) -- Line: 39
    -- upvalues: u9 (copy)
    u9:CreateHighlight(p10, p11, p12, p13, p14, p15);
end);

return u9;