-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Particle2D = require(ReplicatedStorage.Code.Particle2D);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local u2 = false;
local u3 = {};

local function EmoteEffect(u4: any, u5: number, p6: any) -- Line: 22
    -- upvalues: TweenService (copy), Particle2D (copy)
    if u4:GetAttribute("Unlocking") then
        return;
    end;

    u4:SetAttribute("Unlocking", true);
    u4.Icon.UIScale.Scale = 1.2;
    TweenService:Create(u4.Icon.UIScale, TweenInfo.new(u5 * 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Scale = 0
    }):Play();
    task.wait(u5 * 0.3);

    if not u4.Parent then
        return;
    end;

    TweenService:Create(u4.Icon, TweenInfo.new(u5 * 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(u4.Frame.Circle, TweenInfo.new(u5 * 0.3), {
        ImageTransparency = 0
    }):Play();
    local Random_new_ret = Random.new(os.time());
    task.spawn(function() -- Line: 36
        -- upvalues: Random_new_ret (copy), u4 (copy), TweenService (ref), u5 (copy), Particle2D (ref)
        for i = 1, 25 do
            local v7 = Random_new_ret:NextNumber(0, 359);
            local v8 = Random_new_ret:NextInteger(10, 15);
            local u9 = Random_new_ret:NextInteger(1, 0) == 1 and script.Sparkle:Clone() or script.Sparkle2:Clone();
            local v10 = Random_new_ret:NextNumber(-50, 50);
            local math_rad_ret = math.rad(v7);
            local v11 = v10 * math.cos(math_rad_ret);
            local math_rad_ret2 = math.rad(v7);
            local v12 = v10 * math.sin(math_rad_ret2);
            u9.Position = UDim2.new(0.5, v11, 0.5, v12);
            u9.Size = UDim2.new(0, v8, 0, v8);
            u9.Parent = u4;
            local u13 = Random_new_ret:NextNumber(0, 0.5);
            task.spawn(function() -- Line: 50
                -- upvalues: TweenService (ref), u9 (copy), u5 (ref), u13 (copy)
                TweenService:Create(u9, TweenInfo.new(u5 * 1), {
                    ImageTransparency = u13
                }):Play();
                task.wait(u5 * 1);
                TweenService:Create(u9, TweenInfo.new(u5 * 1), {
                    ImageTransparency = 1
                }):Play();
            end);
            local UDim2_new_ret = UDim2.new(0, 500 * Random_new_ret:NextNumber(-1, 1), 0, 700 * Random_new_ret:NextInteger(-1, 1));
            local UDim2_new_ret2 = UDim2.new(0, 500 * Random_new_ret:NextNumber(-1, 1), 0, 700);
            Particle2D.createParticle(u9, 3, UDim2_new_ret, 45, UDim2_new_ret2, UDim2.new(0, 5, 0, 5), 0, 0);
            task.wait(0.05);
            local _ = i;
        end;
    end);
    TweenService:Create(u4.Frame.Circle.UIScale, TweenInfo.new(u5 * 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1.4
    }):Play();
    task.delay(u5 * 0.3, function() -- Line: 66
        -- upvalues: u4 (copy), TweenService (ref), u5 (copy)
        if not u4.Parent then
            return;
        end;

        TweenService:Create(u4.Frame.Circle, TweenInfo.new(u5 * 0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end);
    TweenService:Create(u4.Icon, TweenInfo.new(u5 * 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ImageTransparency = 0
    }):Play();

    for i = 1, 3 do
        local v14 = Random_new_ret:NextNumber(0, 359);
        local v15 = Random_new_ret:NextInteger(30, 45);
        local u16 = script.Sparkle:Clone();
        local v17 = (Random_new_ret:NextNumber(0, 1) == 0 and -1 or 1) * 50;
        local math_rad_ret = math.rad(v14);
        local v18 = v17 * math.cos(math_rad_ret);
        local math_rad_ret2 = math.rad(v14);
        local v19 = v17 * math.sin(math_rad_ret2);
        u16.Position = UDim2.new(0.5, v18, 0.5, v19);
        u16.Size = UDim2.new(0, v15, 0, v15);
        u16.Parent = u4;
        local u20 = Random_new_ret:NextNumber(0, 0.5);
        task.spawn(function() -- Line: 85
            -- upvalues: TweenService (ref), u16 (copy), u20 (copy)
            TweenService:Create(u16, TweenInfo.new(0.1), {
                ImageTransparency = u20
            }):Play();
            task.wait(1);
            TweenService:Create(u16, TweenInfo.new(1), {
                ImageTransparency = 1
            }):Play();
        end);
        local UDim2_new_ret = UDim2.new(0, 1600 * Random_new_ret:NextNumber(-1, 1), 0, 1600 * Random_new_ret:NextNumber(-1, 1));
        local UDim2_new_ret2 = UDim2.new(0, 0, 0, 150);
        Particle2D.createParticle(u16, 3, UDim2_new_ret, 45, UDim2_new_ret2, UDim2.new(0, 5, 0, 5), 0, 0, nil, 0.5);
        local _ = i;
    end;

    TweenService:Create(u4.Icon.UIScale, TweenInfo.new(u5 * 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1.1
    }):Play();
    TweenService:Create(u4.Frame.Shockwave1, TweenInfo.new(1), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(u4.Frame.Shockwave1, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }):Play();
    TweenService:Create(u4.Frame.Shockwave1.UIScale, TweenInfo.new(1), {
        Scale = 2
    }):Play();
    TweenService:Create(u4.Frame.Shockwave2, TweenInfo.new(1), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(u4.Frame.Shockwave2.UIScale, TweenInfo.new(1), {
        Scale = 2
    }):Play();
    TweenService:Create(u4.Frame.Shockwave2, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }):Play();
    u4.Icon.ImageTransparency = 0;
    u4.Icon.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255));
    TweenService:Create(u4.Frame.Sunburst2, TweenInfo.new(0.3), {
        ImageTransparency = 0
    }):Play();
    TweenService:Create(u4.Frame.Sunburst, TweenInfo.new(0.3), {
        ImageTransparency = 0
    }):Play();
    u4.Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
    u4.MouseEnter:Connect(function() -- Line: 119
        -- upvalues: TweenService (ref), u4 (copy)
        TweenService:Create(u4.UIScale, TweenInfo.new(0.25), {
            Scale = 1.2
        }):Play();
    end);
    u4.MouseLeave:Connect(function() -- Line: 122
        -- upvalues: TweenService (ref), u4 (copy)
        TweenService:Create(u4.UIScale, TweenInfo.new(0.25), {
            Scale = 1
        }):Play();
    end);
    TweenService:Create(u4.TextLabel, TweenInfo.new(0.4), {
        TextTransparency = 0
    }):Play();
    TweenService:Create(u4.TextLabel.UIStroke, TweenInfo.new(0.4), {
        Transparency = 0
    }):Play();
    task.delay(0.6, function() -- Line: 128
        -- upvalues: Random_new_ret (copy), u4 (copy), TweenService (ref), Particle2D (ref)
        local v21 = 8;

        while v21 > 0 do
            local v22 = Random_new_ret:NextNumber(0, 359);
            local v23 = Random_new_ret:NextInteger(10, 15);
            local u24 = script.Sparkle:Clone();
            local v25 = Random_new_ret:NextNumber(-50, 50);
            local math_rad_ret = math.rad(v22);
            local v26 = v25 * math.cos(math_rad_ret);
            local math_rad_ret2 = math.rad(v22);
            local v27 = v25 * math.sin(math_rad_ret2);
            u24.Position = UDim2.new(0.5, v26, 0.5, v27);
            u24.Size = UDim2.new(0, v23, 0, v23);
            u24.Parent = u4;
            local u28 = Random_new_ret:NextNumber(0, 0.5);
            task.spawn(function() -- Line: 146
                -- upvalues: TweenService (ref), u24 (copy), u28 (copy)
                TweenService:Create(u24, TweenInfo.new(1), {
                    ImageTransparency = u28
                }):Play();
                task.wait(2);
                TweenService:Create(u24, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
            end);
            local UDim2_new_ret = UDim2.new(0, 0, 0, 0);
            local UDim2_new_ret2 = UDim2.new(0, 0, 0, 150);
            Particle2D.createParticle(u24, 3, UDim2_new_ret, (Random_new_ret:NextInteger(1, 0) == 0 and -1 or 1) * Random_new_ret:NextNumber(20, 45), UDim2_new_ret2, UDim2.new(0, 5, 0, 5), 0, 0, nil, 0);
            v21 = v21 - 1;
            task.wait(0.4);
        end;
    end);
end;

function u3.UnlockItems(p29) -- Line: 162
    -- upvalues: u2 (ref), Players (copy), TweenService (copy), ItemImageFinder (copy), ItemNameFinder (copy), EmoteEffect (copy)
    if u2 then
        return;
    end;

    u2 = true;
    local u30 = script.ScreenGui:Clone();
    local UnlockedEmotes = u30.UnlockedEmotes;
    UnlockedEmotes.Visible = true;
    local LocalPlayer = Players.LocalPlayer;
    u30.Parent = LocalPlayer.PlayerGui;
    TweenService:Create(UnlockedEmotes, TweenInfo.new(0.4), {
        Transparency = 0.4
    }):Play();
    UnlockedEmotes.Activated:Connect(function() -- Line: 176
        -- upvalues: u2 (ref), u30 (copy)
        u2 = false;
        u30:Destroy();
    end);
    UnlockedEmotes.ClickToContinue.Activated:Connect(function() -- Line: 181
        -- upvalues: u2 (ref), u30 (copy)
        u2 = false;
        u30:Destroy();
    end);
    task.wait(0.4);

    if not u30:IsDescendantOf(LocalPlayer.PlayerGui) then
        warn("Menu destroyed");

        return;
    end;

    UnlockedEmotes.Title.Position = UDim2.new(0.5, 0, 0, 30);
    TweenService:Create(UnlockedEmotes.Title, TweenInfo.new(0.6), {
        TextTransparency = 0,
        Position = UDim2.new(0.5, 0, 0, 36)
    }):Play();
    TweenService:Create(UnlockedEmotes.Title.UIStroke, TweenInfo.new(0.6), {
        Transparency = 0
    }):Play();
    local Template = UnlockedEmotes.EmoteHolder.Scroller.Template;

    for i, v in p29 do
        local u31 = Template:Clone();
        u31.LayoutOrder = i;
        u31.Visible = true;
        u31.Icon.Image = ItemImageFinder(v.Value, v.Type);
        u31.TextLabel.Text = ItemNameFinder(v.Value, v.Type);
        u31.Parent = UnlockedEmotes.EmoteHolder.Scroller;
        task.spawn(function() -- Line: 208
            -- upvalues: EmoteEffect (ref), u31 (copy)
            EmoteEffect(u31, 1);
        end);
        task.wait(0.3);
    end;

    if not UnlockedEmotes.Parent then
        return;
    end;

    TweenService:Create(UnlockedEmotes.ClickToContinue, TweenInfo.new(0.6), {
        TextTransparency = 0,
        Position = UDim2.new(0.5, 0, 1, -30)
    }):Play();
    TweenService:Create(UnlockedEmotes.ClickToContinue.UIStroke, TweenInfo.new(0.6), {
        Transparency = 0
    }):Play();
end;

function u3.Start(p32) -- Line: 219
    -- upvalues: u1 (copy), RunService (copy), CollectionService (copy)
    u1:Add(task.spawn(function() -- Line: 220
        -- upvalues: RunService (ref), CollectionService (ref)
        while true do
            local v33 = RunService.Heartbeat:Wait();

            for _, v in CollectionService:GetTagged("SpinTemplate") do
                local v34 = v:GetAttribute("Speed") or -90;
                local v35 = v:GetAttribute("Direction") or 1;
                v.Rotation = v.Rotation + v34 * v35 * v33;
            end;
        end;
    end));
end;

local u36 = false;
EventRotationController.EventUpdated:Connect(function(p37: string, p38: string) -- Line: 233, Name: OnEventUpdated
    -- upvalues: u1 (copy), u36 (ref), u3 (copy)
    if p38 ~= "LunarGlowEvent" then
        u1:Clean();
        u36 = false;

        return;
    end;

    if u36 then
        return;
    end;

    u36 = true;
    u1:Clean();
    task.spawn(u3.Start, u3);
end);

return u3;