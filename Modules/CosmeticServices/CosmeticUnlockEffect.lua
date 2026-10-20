-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local PlaySound = require(ReplicatedStorage.Modules.PlaySound);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};
local u2 = nil;
local u3 = 0;
local Random_new_ret = Random.new();

local function GetEffectGui() -- Line: 24
    -- upvalues: u2 (ref), LocalPlayer (copy)
    if not (u2 and u2.Parent) then
        u2 = Instance.new("ScreenGui");
        u2.Name = "CosmeticUnlockEffectGui";
        u2.ResetOnSpawn = false;
        u2.IgnoreGuiInset = true;
        u2.ScreenInsets = Enum.ScreenInsets.None;
        u2.DisplayOrder = 100;
        u2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        u2.Parent = LocalPlayer:WaitForChild("PlayerGui");
    end;

    return u2;
end;

local function GetTargetOffset(p4: userdata, p5: userdata) -- Line: 39
    return p4.AbsolutePosition + p4.AbsoluteSize / 2 - p5.AbsolutePosition;
end;

local function PlayGhost(p6: string, p7: userdata, p8: function?) -- Line: 43
    -- upvalues: GetEffectGui (copy), TweenService (copy), PlaySound (copy), Random_new_ret (copy)
    local v9 = GetEffectGui();
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "CosmeticUnlockGhost";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = p6;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Position = UDim2.fromScale(0.5, 0.45);
    ImageLabel.Size = UDim2.fromOffset(110, 110);
    ImageLabel.ZIndex = 10;
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = 0;
    UIScale.Parent = ImageLabel;
    ImageLabel.Parent = v9;
    local v10 = TweenService:Create(UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    });
    v10:Play();
    v10.Completed:Wait();
    task.wait(0.35);

    if not p7.Parent then
        ImageLabel:Destroy();

        return;
    end;

    local v11 = p7.AbsolutePosition + p7.AbsoluteSize / 2 - v9.AbsolutePosition;
    local v12 = TweenService:Create(ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ImageTransparency = 0.2,
        Position = UDim2.fromOffset(v11.X, v11.Y),
        Size = UDim2.fromOffset(26, 26)
    });
    v12:Play();
    v12.Completed:Wait();
    ImageLabel:Destroy();
    PlaySound("rbxassetid://139578759536123", Random_new_ret:NextNumber(0.9, 1.3)).Volume = 0.35;

    if p8 then
        p8();
    end;
end;

function v1.Play(p13: table, p14: table, p15: userdata?, p16: function?) -- Line: 89
    -- upvalues: u3 (ref), PlayGhost (copy)
    if not p15 or #p14 == 0 then
        return;
    end;

    local os_clock_ret = os.clock();
    local math_max_ret = math.max(0, u3 - os_clock_ret);
    local math_min_ret = math.min(#p14, 8);

    for i = 1, math_min_ret do
        task.delay(math_max_ret + (i - 1) * 0.12, PlayGhost, p14[i], p15, p16);
        local _ = i;
    end;

    u3 = os_clock_ret + math_max_ret + math_min_ret * 0.12;
end;

return v1;