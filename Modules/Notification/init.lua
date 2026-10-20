-- Decompiled with Potassium's decompiler.

local Frame = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Top_Notification"):WaitForChild("Frame");
local TweenService = game:GetService("TweenService");
local Notification = game.SoundService.Notification;
require(game.ReplicatedStorage.Modules.Chalk);
local script_NotificationCondenser = require(script.NotificationCondenser);
local script_PetNotificationFilter = require(script.PetNotificationFilter);
local Notification_UI_Mobile = game.ReplicatedStorage.Notification_UI_Mobile;
local Notification_UI = game.ReplicatedStorage.Notification_UI;
local SettingsService = require(game.ReplicatedStorage.Modules.Settings.SettingsService);
local u1 = {};
local u2 = {};

local function ActivateNotificationFrame(p3) -- Line: 31
    -- upvalues: TweenService (copy), Notification (copy)
    local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    TweenService:Create(p3.TextLabel, TweenInfo_new_ret2, {
        Position = p3.TextLabel.Position
    }):Play();
    TweenService:Create(p3.ImageLabel, TweenInfo_new_ret, {
        ImageTransparency = 0.5
    }):Play();
    TweenService:Create(p3.TextLabel, TweenInfo_new_ret, {
        TextTransparency = 0
    }):Play();
    TweenService:Create(p3.TextLabel, TweenInfo_new_ret, {
        TextStrokeTransparency = 0
    }):Play();
    Notification.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Notification.Playing = true;
    Notification.TimePosition = 0;
end;

local function DeactivateNotificationFrame(p4) -- Line: 49
    -- upvalues: TweenService (copy), u2 (copy)
    local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    TweenService:Create(p4.TextLabel, TweenInfo_new_ret2, {
        Position = p4.TextLabel.Position + UDim2.new(0, 0, 0.2, 0)
    }):Play();
    TweenService:Create(p4.ImageLabel, TweenInfo_new_ret, {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(p4.TextLabel, TweenInfo_new_ret, {
        TextTransparency = 1
    }):Play();
    TweenService:Create(p4.TextLabel, TweenInfo_new_ret, {
        TextStrokeTransparency = 1
    }):Play();
    game.Debris:AddItem(p4, TweenInfo_new_ret.Time);
    u2[p4] = nil;
end;

local function CreateNotificationFrame(p5, p6, p7) -- Line: 68
    -- upvalues: Frame (copy)
    local v8 = p5:Clone();
    v8.TextLabel.Text = p6;
    v8:SetAttribute("OG", p6);
    v8:SetAttribute("NotificationTimer", p7);
    local IntValue = Instance.new("IntValue");
    IntValue.Name = "VAL_OBJ";
    IntValue.Value = 1;
    IntValue.Parent = v8;
    local _ = v8.TextLabel.Position;
    v8.ImageLabel.ImageTransparency = 1;
    v8.TextLabel.TextTransparency = 1;
    v8.TextLabel.TextStrokeTransparency = 1;
    v8.Parent = Frame;

    return v8;
end;

task.spawn(function() -- Line: 97
    -- upvalues: Frame (copy), DeactivateNotificationFrame (copy), u1 (copy), Notification_UI_Mobile (copy), Notification_UI (copy), CreateNotificationFrame (copy), ActivateNotificationFrame (copy)
    while true do
        for _, child in Frame:GetChildren() do
            if child:IsA("Frame") and (child.Name == "Notification_UI" or child.Name == "Notification_UI_Mobile") then
                local Attribute = child:GetAttribute("NotificationTimer");

                if Attribute and type(Attribute) == "number" then
                    local v9 = Attribute - 1;

                    if v9 <= 0 then
                        child:SetAttribute("NotificationTimer", nil);
                        local Attribute2 = child:GetAttribute("CondenseKey");
                        DeactivateNotificationFrame(child);

                        if Attribute2 then
                            local v10 = u1[Attribute2] or {};

                            if #v10 >= 1 then
                                local v11 = v10[1];
                                table.remove(v10, 1);
                                local u12 = CreateNotificationFrame(v11.IsMobile and Notification_UI_Mobile or Notification_UI, v11.Text, v11.Duration);
                                u12:SetAttribute("CondenseKey", Attribute2);
                                task.spawn(function() -- Line: 123
                                    -- upvalues: ActivateNotificationFrame (ref), u12 (copy)
                                    task.wait(0.4);
                                    ActivateNotificationFrame(u12);
                                end);
                            end;
                        end;
                    else
                        child:SetAttribute("NotificationTimer", v9);
                    end;
                end;
            end;
        end;

        task.wait(1);
    end;
end);

local function CreateNotification(p13: boolean, p14: string, p15: boolean?, p16: number?) -- Line: 146
    -- upvalues: SettingsService (copy), script_PetNotificationFilter (copy), Notification_UI_Mobile (copy), Notification_UI (copy), script_NotificationCondenser (copy), Frame (copy), u2 (copy), u1 (copy), CreateNotificationFrame (copy), ActivateNotificationFrame (copy)
    if not SettingsService:GetSetting("ToggleNotifications") then
        return;
    end;

    if SettingsService:GetSetting("PetNotifications") == false and script_PetNotificationFilter:IsPetNotification(p14) then
        return;
    end;

    local v17 = p16 or 3.5;
    local v18 = p13 and Notification_UI_Mobile or Notification_UI;
    local CondenseKey = script_NotificationCondenser:GetCondenseKey(p14);
    local v19 = nil;

    if CondenseKey then
        for _, child in ipairs(Frame:GetChildren()) do
            if child:IsA("Frame") and child:GetAttribute("CondenseKey") == CondenseKey.Rule.Key then
                v19 = child;
                break;
            end;
        end;

        if v19 then
            if p13 then
                local v20 = u1[CondenseKey.Rule.Key] or {};
                table.insert(v20, {
                    Text = p14,
                    Duration = v17,
                    IsMobile = p13
                });
                u1[CondenseKey.Rule.Key] = v20;

                return;
            end;

            local v21 = u2[v19] or {};
            local v22 = {};

            for _, v in ipairs(v21) do
                v22[v.Plain] = true;
            end;

            if not v22[CondenseKey.Variant.Plain] then
                table.insert(v21, CondenseKey.Variant);
            end;

            u2[v19] = v21;

            if #v21 >= 2 then
                v19.TextLabel.RichText = true;
                v19.TextLabel.Text = script_NotificationCondenser:BuildCondensedText(v21, CondenseKey.Rule.Suffix, CondenseKey.Rule.PluralSuffix);
            end;

            v19:SetAttribute("NotificationTimer", v17);

            return;
        end;
    elseif not p15 then
        for _, child in Frame:GetChildren() do
            if child:IsA("Frame") and (child.Name == v18.Name and child:GetAttribute("OG") == p14) then
                v19 = child;
                break;
            end;
        end;

        if v19 then
            local VAL_OBJ = v19:FindFirstChild("VAL_OBJ");

            if VAL_OBJ then
                VAL_OBJ.Value = VAL_OBJ.Value + 1;
                v19.TextLabel.Text = `{p14} [X{VAL_OBJ.Value}]`;
            end;

            v19:SetAttribute("NotificationTimer", v17);

            return;
        end;
    end;

    local v23 = CreateNotificationFrame(v18, p14, v17);

    if CondenseKey then
        v23:SetAttribute("CondenseKey", CondenseKey.Rule.Key);
        u2[v23] = { CondenseKey.Variant };
    end;

    ActivateNotificationFrame(v23);
end;

if game:GetService("UserInputService").TouchEnabled then
    game.ReplicatedStorage:WaitForChild("GameEvents").Notification.OnClientEvent:Connect(function(...) -- Line: 254
        -- upvalues: CreateNotification (copy)
        CreateNotification(true, ...);
    end);
else
    game.ReplicatedStorage:WaitForChild("GameEvents").Notification.OnClientEvent:Connect(function(...) -- Line: 259
        -- upvalues: CreateNotification (copy)
        CreateNotification(false, ...);
    end);
end;

return {
    CreateNotification = function(p24: table, p25: string, p26: boolean?, p27: number?) -- Line: 268, Name: CreateNotification
        -- upvalues: CreateNotification (copy)
        CreateNotification(game.UserInputService.TouchEnabled, p25, p26, p27);
    end
};