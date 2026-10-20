-- Decompiled with Potassium's decompiler.

local v1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local InsertionPoint = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Notifications").InsertionPoint;
local NotificationTemplate = InsertionPoint:WaitForChild("NotificationTemplate");
local SetupHoverAnimations = require(ReplicatedStorage.Modules.SetupHoverAnimations);
local PlayHoverSound = require(ReplicatedStorage.Modules.PlayHoverSound);
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local u2 = 0;

function v1.CreateNotification(p3: table, u4: table) -- Line: 39
    -- upvalues: u2 (ref), NotificationTemplate (copy), WaitForDescendant (copy), TweenService (copy), SetupHoverAnimations (copy), PlayHoverSound (copy), InsertionPoint (copy)
    u2 = u2 + 1;
    local v5 = u4.Text or "Notification Text!";
    local v6 = u4.Icon or "rbxassetid://13488010851";
    u4.Id = u4.Id or u2;
    local v7 = u4.EnabledComponents or {
        OptionSet = true,
        Confirm = true,
        Decline = true,
        IconSet = true
    };
    local u8 = NotificationTemplate:Clone();
    u8.Visible = true;
    local UIScale = u8:WaitForChild("UIScale");
    WaitForDescendant(u8, "NOTIFICATION_TEXT").Text = v5;
    WaitForDescendant(u8, "NOTIFICATION_ICON").Image = v6;
    local v9 = WaitForDescendant(u8, "NOTIFICATION_OPTION_SET");
    local v10 = WaitForDescendant(v9, "NOTIFICATION_CONFIRM");
    local v11 = WaitForDescendant(v9, "NOTIFICATION_DECLINE");
    local v12 = WaitForDescendant(u8, "NOTIFICATION_ICON_SET");
    v9.Visible = v7.OptionSet;
    v10.Parent.Visible = v7.Confirm;

    local function Show() -- Line: 77
        -- upvalues: TweenService (ref), UIScale (copy)
        TweenService:Create(UIScale, TweenInfo.new(0.2), {
            Scale = 1.5
        }):Play();
    end;

    local function HideAndDestroy() -- Line: 83
        -- upvalues: TweenService (ref), UIScale (copy), u8 (copy)
        local v13 = TweenService:Create(UIScale, TweenInfo.new(0.2), {
            Scale = 0
        });
        v13:Play();
        v13.Completed:Once(function() -- Line: 89
            -- upvalues: u8 (ref)
            u8:Destroy();
        end);
    end;

    if v7.Confirm then
        local v14 = SetupHoverAnimations(v10);
        local OnConfirm = u4.OnConfirm;
        v14.MouseEnter:Connect(function() -- Line: 99
            -- upvalues: PlayHoverSound (ref)
            PlayHoverSound();
        end);
        v14.MouseButton1Down:Connect(function() -- Line: 103
            -- upvalues: OnConfirm (copy), u4 (copy), HideAndDestroy (copy)
            if OnConfirm then
                OnConfirm(u4);
            end;

            HideAndDestroy();
        end);
    end;

    v11.Parent.Visible = v7.Decline;

    if v7.Decline then
        local v15 = SetupHoverAnimations(v11);
        local OnDecline = u4.OnDecline;
        v15.MouseEnter:Connect(function() -- Line: 116
            -- upvalues: PlayHoverSound (ref)
            PlayHoverSound();
        end);
        v15.MouseButton1Down:Connect(function() -- Line: 120
            -- upvalues: OnDecline (copy), u4 (copy), HideAndDestroy (copy)
            if OnDecline then
                OnDecline(u4);
            end;

            HideAndDestroy();
        end);
    end;

    v12.Visible = v7.IconSet;
    u8.Parent = InsertionPoint;
    TweenService:Create(UIScale, TweenInfo.new(0.2), {
        Scale = 1.5
    }):Play();
    local Lifetime = u4.Lifetime;

    if Lifetime then
        task.delay(Lifetime, function() -- Line: 134
            -- upvalues: HideAndDestroy (copy)
            HideAndDestroy();
        end);
    end;

    return u4;
end;

return v1;