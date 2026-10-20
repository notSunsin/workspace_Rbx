-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local BeeColonyStateController = require(ReplicatedStorage.Modules.BeeEventV2Controllers.BeeColonyStateController);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
local Notification = require(ReplicatedStorage.Modules.Notification);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local Trove = require(ReplicatedStorage.Modules.Trove);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local WaspWaveSurvivalConfig = require(ReplicatedStorage.Data.BeeEvent.WaspWaveSurvivalConfig);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local Spring = require(ReplicatedStorage.Modules.Spring);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
local MarketplaceService = game:GetService("MarketplaceService");
local PurchaseID = require(ReplicatedStorage.Data.DevProductIds).SkipWaspDungeonIgnition.PurchaseID;
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local SlotServiceTypes = require(ReplicatedStorage.Types.SlotServiceTypes);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local WaspWaveSurvival = ReplicatedStorage.GameEvents:WaitForChild("WaspWaveSurvival");
local RequestStart = WaspWaveSurvival:WaitForChild("RequestStart");
local RequestExit = WaspWaveSurvival:WaitForChild("RequestExit");
local RequestClaim = WaspWaveSurvival:WaitForChild("RequestClaim");
local GetState = WaspWaveSurvival:WaitForChild("GetState");
local StateChanged = WaspWaveSurvival:WaitForChild("StateChanged");
local u1 = {
    States = {}
};
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local WaspWaveSurvivalUI = PlayerGui:WaitForChild("WaspWaveSurvivalUI");
local CurrentWave = WaspWaveSurvivalUI.RunProgress.Wave.CurrentWave;
local RemainingWaves = WaspWaveSurvivalUI.RunProgress.Main.RemainingWaves;
local Content = WaspWaveSurvivalUI.RunProgress.Main.Bar.Content;
local Victory = WaspWaveSurvivalUI:FindFirstChild("Victory");
local v2 = nil;
local v3 = nil;
local u4 = nil;
local u5 = {};
local u6 = nil;
local u7 = false;
local u8, v9;

if Victory then
    Victory.Visible = false;
    u8 = Victory:FindFirstChild("Rewards");

    if u8 then
        u8 = u8:FindFirstChild("Rewards");
    end;

    if not (u8 and u8:IsA("Frame")) then
        u8 = v2;
    end;

    v9 = Victory:FindFirstChild("ClaimButton");

    if v9 then
        v9 = v9:FindFirstChild("SENSOR");
    end;

    if v9 then
        if not v9:IsA("GuiObject") then
            v9 = v3;
        end;
    else
        v9 = v3;
    end;

    if u8 then
        for _, child in u8:GetChildren() do
            if child.Name == "RewardTemplate" and child:IsA("Frame") then
                u4 = u4 or child:Clone();
                child:Destroy();
            end;
        end;
    end;
else
    u8 = v2;
    v9 = v3;
end;

if v9 then
    local function onClaim() -- Line: 86
        -- upvalues: Victory (copy), RequestExit (copy)
        if Victory then
            Victory.Visible = false;
        end;

        RequestExit:FireServer();
    end;

    if v9:IsA("GuiButton") then
        v9.Activated:Connect(onClaim);
    else
        v9.InputBegan:Connect(function(p10: userdata) -- Line: 95
            -- upvalues: Victory (copy), RequestExit (copy)
            if p10.UserInputType == Enum.UserInputType.MouseButton1 or p10.UserInputType == Enum.UserInputType.Touch then
                if Victory then
                    Victory.Visible = false;
                end;

                RequestExit:FireServer();
            end;
        end);
    end;
end;

local WaveProgress = WaspWaveSurvivalUI.WaveProgress;
local RemainingWasps = WaveProgress.Main.RemainingWasps;
local Bar = WaveProgress.Main.Bar;
local u11 = {
    Teleport_UI = true,
    Hud_UI = true
};
local u12 = {};

local function SetRunGameplayUIHidden(p13: boolean) -- Line: 115
    -- upvalues: u11 (copy), PlayerGui (copy), u12 (copy)
    for i in u11 do
        local v14 = PlayerGui:FindFirstChild(i);

        if v14 and v14:IsA("ScreenGui") then
            if p13 then
                if u12[v14] == nil then
                    u12[v14] = v14.Enabled;
                end;

                v14.Enabled = false;
            else
                local v15 = u12[v14];

                if v15 ~= nil then
                    v14.Enabled = v15;
                end;

                u12[v14] = nil;
            end;
        end;
    end;
end;

local u16 = nil;

local function SetWaspSurvivalLoopEnabled(p17: boolean) -- Line: 140
    -- upvalues: u16 (ref), SoundData (copy), SoundService (copy)
    if p17 then
        if not u16 then
            local WaspSurvival = SoundData.Events.Honey2026.WaspSurvival;

            if typeof(WaspSurvival) ~= "string" or WaspSurvival == "" then
                return;
            end;

            local Sound = Instance.new("Sound");
            Sound.Name = "WaspWaveSurvivalLoop";
            Sound.SoundId = WaspSurvival;
            Sound.Looped = true;
            Sound.Volume = 0.5;
            Sound.Parent = SoundService;
            u16 = Sound;
        end;

        if u16 and not u16.IsPlaying then
            u16:Play();
        end;
    elseif u16 then
        u16:Stop();
        u16:Destroy();
        u16 = nil;
    end;
end;

local function RefreshRunGameplayUI() -- Line: 168
    -- upvalues: LocalPlayer (copy), SetRunGameplayUIHidden (copy), WaspWaveSurvivalUI (copy), SetWaspSurvivalLoopEnabled (copy)
    local v18 = LocalPlayer:GetAttribute("InWaspWaveSurvival") == true;
    LocalPlayer:SetAttribute("NormalMusicSuppressed", v18);
    SetRunGameplayUIHidden(v18);
    WaspWaveSurvivalUI.Enabled = v18;
    SetWaspSurvivalLoopEnabled(v18);
end;

local u19 = false;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;
local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = {};
local u31 = nil;
local u32 = nil;
local u33 = nil;
local u34 = 0;
local u35 = false;
local u36 = nil;
local u37 = false;
local u38 = false;
local u39 = nil;
local u40 = nil;
local u41 = 0;
local u42 = nil;
local u43 = {};
local u44 = {};
local u45 = nil;
local u46 = nil;
local u47 = nil;
local u48 = nil;
local u49 = false;
local u50 = 0;
local u51 = WaspWaveSurvivalConfig.MaxWaves or 100;
local u52 = 0;
local u53 = 0;
local u54 = nil;
local u55 = 0;
local u56 = 0;
local u57 = 0;
local u58 = true;
local u59 = 0;
local u60 = 0;
local u61 = false;
local u62 = false;
local u63 = 0;
local u64 = 0;
local u65 = false;
local u66 = false;
local u67 = {};
local u68 = nil;
local u69 = nil;
local u70 = true;
local u71 = nil;
local u72 = false;
local u73 = "";
local u74 = nil;

local function ForceBeeColonyFollowPlayerForDungeon() -- Line: 267
    -- upvalues: u74 (ref), SettingsService (copy)
    if u74 == nil then
        u74 = SettingsService:GetSetting("BeeColonyFollowPlayer");
    end;

    SettingsService:SetSetting("BeeColonyFollowPlayer", true);
end;

local function RestoreBeeColonyFollowPlayerAfterDungeon() -- Line: 275
    -- upvalues: u74 (ref), SettingsService (copy)
    if u74 == nil then
        return;
    end;

    SettingsService:SetSetting("BeeColonyFollowPlayer", u74);
    u74 = nil;
end;

local function CondenseRewards(p75: table?) -- Line: 284
    local v76 = {};

    if typeof(p75) ~= "table" then
        return v76;
    end;

    local v77 = {};

    for _, v in p75 do
        if typeof(v) == "table" and (v.Type ~= nil and v.Value ~= nil) then
            local v78 = tostring(v.Type) .. "|" .. tostring(v.Value);
            local v79 = tonumber(v.Quantity) or 1;
            local v80 = v77[v78];

            if v80 then
                local v81 = v76[v80];
                v81.Quantity = v81.Quantity + v79;
            else
                table.insert(v76, {
                    Type = v.Type,
                    Value = v.Value,
                    Quantity = v79
                });
                v77[v78] = #v76;
            end;
        end;
    end;

    return v76;
end;

local function FormatQuantityBadge(p82) -- Line: 311
    -- upvalues: CommaFormatNumber (copy)
    local v83 = tonumber(p82) or 0;

    return v83 <= 0 and "" or "x" .. CommaFormatNumber(v83);
end;

local function EnsureConclusionQuantityLabel(p84: userdata) -- Line: 321
    local QuantityLabel = p84:FindFirstChild("QuantityLabel");

    if QuantityLabel and QuantityLabel:IsA("TextLabel") then
        return QuantityLabel;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "QuantityLabel";
    TextLabel.AnchorPoint = Vector2.new(1, 1);
    TextLabel.Position = UDim2.new(1, 0, 1, 0);
    TextLabel.Size = UDim2.new(1, 0, 0.3, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "";
    TextLabel.TextScaled = true;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.ZIndex = (p84:IsA("GuiObject") and (p84.ZIndex or 215) or 215) + 10;
    TextLabel.Parent = p84;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "UIStroke";
    UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
    UIStroke.Thickness = 0.06;
    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function RewardHoverUuid(p85) -- Line: 355
    return "WaspReward_" .. tostring(p85.Type) .. "_" .. tostring(p85.Value);
end;

local function PopulateVictoryRewards(p86: table) -- Line: 359
    -- upvalues: CondenseRewards (copy), u8 (ref), u4 (ref), u44 (copy), GiveServiceCommon (copy), CommaFormatNumber (copy), ItemInfoHover (copy)
    local v87 = CondenseRewards(p86);

    if not (u8 and u4) then
        return;
    end;

    for _, child in u8:GetChildren() do
        if child.Name == "RewardTemplate" and child:IsA("Frame") then
            local Details = child:FindFirstChild("Details");

            if Details then
                Details = Details:FindFirstChild("Sunrays");
            end;

            local v88 = Details and (Details:IsA("ImageLabel") and table.find(u44, Details));

            if v88 then
                table.remove(u44, v88);
            end;

            child:Destroy();
        end;
    end;

    for _, v in v87 do
        local v89 = u4:Clone();
        local Reward = v89:FindFirstChild("Reward");

        if Reward and Reward:IsA("ImageLabel") then
            local success, result = pcall(function() -- Line: 380
                -- upvalues: GiveServiceCommon (ref), v (copy)
                return GiveServiceCommon:GetImage(v);
            end);
            Reward.Image = success and result and result or "";
        end;

        local QuantityLabel = v89:FindFirstChild("QuantityLabel");

        if QuantityLabel and QuantityLabel:IsA("TextLabel") then
            local v90 = tonumber(v.Quantity) or 0;
            QuantityLabel.Text = v90 <= 0 and "" or "x" .. CommaFormatNumber(v90);
        end;

        local Details = v89:FindFirstChild("Details");

        if Details then
            Details = Details:FindFirstChild("Sunrays");
        end;

        if Details and Details:IsA("ImageLabel") then
            table.insert(u44, Details);
        end;

        v89.Parent = u8;
        local u91 = "WaspReward_" .. tostring(v.Type) .. "_" .. tostring(v.Value);
        v89:SetAttribute("UUID", u91);
        local success, result = pcall(function() -- Line: 398
            -- upvalues: ItemInfoHover (ref), u91 (copy), v (copy)
            ItemInfoHover:AddItemFromRewardWithQuantity(u91, v);
        end);

        if not success then
            warn("[WaspWaveSurvival] Victory hover register failed:", result, v);
        end;
    end;
end;

local function GetEndsAt() -- Line: 407
    -- upvalues: GameConfigController (copy)
    local Config = GameConfigController:GetConfig("WaspWaveSurvival_EndsAtUnix");

    return tonumber(Config) or 0;
end;

local function FormatRemaining(p92: number) -- Line: 412
    if p92 <= 0 then
        return "Event Ended!";
    end;

    local v93 = p92 // 86400;

    if v93 >= 1 then
        return ("Leaving in %d %s!"):format(v93, v93 == 1 and "Day" or "Days");
    end;

    local v94 = p92 // 3600;

    if v94 >= 1 then
        return ("Leaving in %d %s!"):format(v94, v94 == 1 and "Hour" or "Hours");
    end;

    local v95 = p92 // 60;

    if v95 >= 1 then
        return ("Leaving in %d %s!"):format(v95, v95 == 1 and "Minute" or "Minutes");
    end;

    return ("Leaving in %d %s!"):format(p92, p92 == 1 and "Second" or "Seconds");
end;

local function SetTimerText(p96: string) -- Line: 429
    -- upvalues: u22 (ref), u23 (ref)
    if u22 then
        u22.Text = p96;
    end;

    if u23 then
        u23.Text = p96;
    end;
end;

local function FormatElapsed(p97: number) -- Line: 434
    local math_floor_ret = math.floor(p97);
    local math_max_ret = math.max(0, math_floor_ret);
    local v98 = math_max_ret // 3600;
    local v99 = math_max_ret % 3600 // 60;
    local v100 = math_max_ret % 60;

    if v98 > 0 then
        return string.format("%02d:%02d:%02d", v98, v99, v100);
    end;

    return string.format("%02d:%02d", v99, v100);
end;

local function FormatOpensIn(p101: number) -- Line: 451
    local math_floor_ret = math.floor(p101);
    local math_max_ret = math.max(0, math_floor_ret);
    local v102 = math_max_ret // 3600;
    local v103 = math_max_ret % 3600 // 60;
    local v104 = math_max_ret % 60;

    if v102 > 0 then
        return string.format("Opens in %02d:%02d:%02d", v102, v103, v104);
    end;

    return string.format("Opens in %02d:%02d", v103, v104);
end;

local function FormatRejoinIn(p105: number) -- Line: 462
    local math_floor_ret = math.floor(p105);
    local math_max_ret = math.max(0, math_floor_ret);
    local v106 = math_max_ret // 3600;
    local v107 = math_max_ret % 3600 // 60;
    local v108 = math_max_ret % 60;

    if v106 > 0 then
        return string.format("Rejoin in %02d:%02d:%02d", v106, v107, v108);
    end;

    return string.format("Rejoin in %02d:%02d", v107, v108);
end;

local function FormatIgniteIn(p109: number) -- Line: 476
    local math_floor_ret = math.floor(p109);
    local math_max_ret = math.max(0, math_floor_ret);
    local v110 = math_max_ret // 3600;
    local v111 = math_max_ret % 3600 // 60;
    local v112 = math_max_ret % 60;

    if v110 > 0 then
        return string.format("Ignite in %02d:%02d:%02d", v110, v111, v112);
    end;

    return string.format("Ignite in %02d:%02d", v111, v112);
end;

local function FormatWarmingUp(p113: number) -- Line: 489
    local math_floor_ret = math.floor(p113);
    local math_max_ret = math.max(0, math_floor_ret);
    local v114 = math_max_ret // 3600;
    local v115 = math_max_ret % 3600 // 60;
    local v116 = math_max_ret % 60;

    if v114 > 0 then
        return string.format("Warming %02d:%02d:%02d", v114, v115, v116);
    end;

    return string.format("Warming %02d:%02d", v115, v116);
end;

local function FormatSkipIgnite(p117: number) -- Line: 504
    local math_floor_ret = math.floor(p117);
    local math_max_ret = math.max(0, math_floor_ret);
    local v118 = math_max_ret // 3600;
    local v119 = math_max_ret % 3600 // 60;
    local v120 = math_max_ret % 60;

    if v118 > 0 then
        return string.format("Skip - Ignites in %d:%02d:%02d", v118, v119, v120);
    end;

    return string.format("Skip - Ignites in %d:%02d", v119, v120);
end;

local function FormatPortalCountdown(p121: number) -- Line: 515
    local math_floor_ret = math.floor(p121);
    local math_max_ret = math.max(0, math_floor_ret);
    local v122 = math_max_ret // 3600;
    local v123 = math_max_ret % 3600 // 60;
    local v124 = math_max_ret % 60;

    if v122 > 0 then
        return string.format("%d:%02d:%02d", v122, v123, v124);
    end;

    return string.format("%d:%02d", v123, v124);
end;

local function FindWaspDungeonPortal() -- Line: 529
    -- upvalues: CollectionService (copy)
    local Interaction = workspace:FindFirstChild("Interaction");

    if Interaction then
        Interaction = Interaction:FindFirstChild("UpdateItems");
    end;

    if Interaction then
        Interaction = Interaction:FindFirstChild("WaspDungeonPortal");
    end;

    if Interaction then
        return Interaction;
    end;

    for _, v in CollectionService:GetTagged("BizzyBee2026") do
        local WaspDungeonPortal = v:FindFirstChild("WaspDungeonPortal", true);

        if WaspDungeonPortal then
            return WaspDungeonPortal;
        end;
    end;

    return workspace:FindFirstChild("WaspDungeonPortal", true);
end;

local function FindPortalTimerLabel() -- Line: 548
    -- upvalues: u6 (ref), FindWaspDungeonPortal (copy)
    if u6 and u6.Parent then
        return u6;
    end;

    local v125 = FindWaspDungeonPortal();

    if v125 then
        v125 = v125:FindFirstChild("RewardsAttachment");
    end;

    if v125 then
        v125 = v125:FindFirstChild("Timer");
    end;

    if v125 then
        v125 = v125:FindFirstChild("Label");
    end;

    if not (v125 and v125:IsA("TextLabel")) then
        return nil;
    end;

    u6 = v125;

    return u6;
end;

local function SetPortalTimerText(p126: string?) -- Line: 566
    -- upvalues: FindPortalTimerLabel (copy)
    local v127 = FindPortalTimerLabel();

    if not v127 then
        return;
    end;

    local v128 = v127:FindFirstAncestorOfClass("BillboardGui");
    local TextShadow = v127:FindFirstChild("TextShadow");

    if p126 == nil or p126 == "" then
        if v128 then
            v128.Enabled = false;
        end;

        v127.Visible = false;

        if TextShadow and TextShadow:IsA("TextLabel") then
            TextShadow.Visible = false;
        end;

        return;
    end;

    if v128 then
        v128.Enabled = true;

        if string.find(p126, "\n") then
            v128.Size = UDim2.fromScale(20, 3.5);
        else
            v128.Size = UDim2.fromScale(20, 2);
        end;
    end;

    v127.Visible = true;
    v127.Text = p126;

    if TextShadow and TextShadow:IsA("TextLabel") then
        TextShadow.Visible = true;
        TextShadow.Text = p126;
    end;
end;

local function GetPortalTimerText() -- Line: 606
    -- upvalues: u66 (ref), u62 (ref), u61 (ref), u65 (ref)
    if u66 then
        return u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
    end;

    return nil;
end;

local function UpdatePortalTimerLabel() -- Line: 630
    -- upvalues: SetPortalTimerText (copy), u66 (ref), u62 (ref), u61 (ref), u65 (ref)
    local v129;

    if u66 then
        v129 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
    else
        v129 = nil;
    end;

    SetPortalTimerText(v129);
end;

local function NotifyPortalReady() -- Line: 634
    -- upvalues: u7 (ref), Notification (copy)
    if u7 then
        return;
    end;

    u7 = true;
    Notification:CreateNotification("The portal is ready. You can enter the dungeon now.");
end;

local function GetLocalPortal() -- Line: 644
    -- upvalues: FindWaspDungeonPortal (copy)
    local v130 = FindWaspDungeonPortal();

    if v130 then
        v130 = v130:FindFirstChild("Portal");
    end;

    return v130;
end;

local function SyncPortalParticles() -- Line: 649
    -- upvalues: FindWaspDungeonPortal (copy), u61 (ref)
    local v131 = FindWaspDungeonPortal();

    if v131 then
        v131 = v131:FindFirstChild("Portal");
    end;

    if not v131 then
        return;
    end;

    local v132 = u61 == true;

    for _, v in v131:QueryDescendants("ParticleEmitter") do
        if typeof(v) == "Instance" and v:IsA("ParticleEmitter") then
            v.Enabled = v132;
        end;
    end;
end;

local function ApplyPortalSnapshot(p133) -- Line: 662
    -- upvalues: u61 (ref), u62 (ref), u66 (ref), u65 (ref), u63 (ref), u64 (ref), u7 (ref), Notification (copy), SyncPortalParticles (copy), SetPortalTimerText (copy)
    local v134 = u61 and not u62;
    u66 = true;

    if p133.PortalIgnited ~= nil then
        u61 = p133.PortalIgnited == true;
    end;

    if p133.PortalReady ~= nil then
        u62 = p133.PortalReady == true;
    end;

    if p133.PortalCanIgnite ~= nil then
        u65 = p133.PortalCanIgnite == true;
    end;

    local v135 = tonumber(p133.PortalWarmupRemaining);

    if v135 then
        u63 = math.max(0, v135);
    end;

    local v136 = tonumber(p133.PortalIgniteCooldownRemaining);

    if v136 then
        u64 = math.max(0, v136);
    end;

    if u61 and not u62 then
        u7 = false;
    end;

    if u62 and (v134 and not u7) then
        u7 = true;
        Notification:CreateNotification("The portal is ready. You can enter the dungeon now.");
    end;

    SyncPortalParticles();
    local v137;

    if u66 then
        v137 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
    else
        v137 = nil;
    end;

    SetPortalTimerText(v137);
end;

local function FindParticipateLabel() -- Line: 701
    -- upvalues: u68 (ref), u24 (ref)
    if u68 and u68.Parent then
        return u68;
    end;

    if not u24 then
        return nil;
    end;

    local Title = u24:FindFirstChild("Title");

    if Title and Title:IsA("TextLabel") then
        u68 = Title;

        return u68;
    end;

    for _, child in ipairs(u24:GetChildren()) do
        if child:IsA("TextLabel") then
            u68 = child;

            return u68;
        end;
    end;

    for _, descendant in ipairs(u24:GetDescendants()) do
        if descendant:IsA("TextLabel") then
            u68 = descendant;

            return u68;
        end;
    end;

    if not (u24:IsA("TextLabel") or u24:IsA("TextButton")) then
        return nil;
    end;

    u68 = u24;

    return u68;
end;

local function CaptureParticipateOriginals() -- Line: 734
    -- upvalues: u72 (ref), u24 (ref), u70 (ref), u71 (ref), u67 (copy), FindParticipateLabel (copy), u69 (ref)
    if u72 or not u24 then
        return;
    end;

    u72 = true;
    u70 = u24.Active;
    local success, result = pcall(function() -- Line: 738
        -- upvalues: u24 (ref)
        return u24.AutoButtonColor;
    end);

    if success then
        u71 = result;
    end;

    local function snapInst(p138: userdata) -- Line: 740
        -- upvalues: u67 (ref)
        if u67[p138] then
            return;
        end;

        local v139 = {};

        if p138:IsA("ImageButton") or p138:IsA("ImageLabel") then
            v139.ImageColor3 = p138.ImageColor3;
        end;

        if p138:IsA("GuiButton") or p138:IsA("Frame") then
            v139.BackgroundColor3 = p138.BackgroundColor3;
        end;

        if p138:IsA("TextLabel") or p138:IsA("TextButton") then
            v139.TextColor3 = p138.TextColor3;
        end;

        if p138:IsA("UIGradient") then
            v139.GradientColor = p138.Color;
        end;

        if p138:IsA("UIStroke") then
            v139.StrokeColor = p138.Color;
        end;

        u67[p138] = v139;
    end;

    snapInst(u24);

    for _, descendant in ipairs(u24:GetDescendants()) do
        snapInst(descendant);
    end;

    local v140 = FindParticipateLabel();

    if v140 then
        u69 = v140.Text;
    end;
end;

local function DarkenColor(p141) -- Line: 767
    return Color3.new(p141.R * 0.4, p141.G * 0.4, p141.B * 0.4);
end;

local function DarkenColorSequence(p142: userdata) -- Line: 771
    -- upvalues: DarkenColor (copy)
    local v143 = {};

    for _, v in ipairs(p142.Keypoints) do
        table.insert(v143, ColorSequenceKeypoint.new(v.Time, DarkenColor(v.Value)));
    end;

    return ColorSequence.new(v143);
end;

local function ApplyParticipateDarkened() -- Line: 779
    -- upvalues: u24 (ref), u67 (copy), DarkenColorSequence (copy)
    if not u24 then
        return;
    end;

    for i, v in u67 do
        if i.Parent then
            if v.ImageColor3 then
                local ImageColor3 = v.ImageColor3;
                i.ImageColor3 = Color3.new(ImageColor3.R * 0.4, ImageColor3.G * 0.4, ImageColor3.B * 0.4);
            end;

            if v.BackgroundColor3 then
                local BackgroundColor3 = v.BackgroundColor3;
                i.BackgroundColor3 = Color3.new(BackgroundColor3.R * 0.4, BackgroundColor3.G * 0.4, BackgroundColor3.B * 0.4);
            end;

            if v.GradientColor then
                i.Color = DarkenColorSequence(v.GradientColor);
            end;

            if v.StrokeColor then
                local StrokeColor = v.StrokeColor;
                i.Color = Color3.new(StrokeColor.R * 0.4, StrokeColor.G * 0.4, StrokeColor.B * 0.4);
            end;
        end;
    end;

    pcall(function() -- Line: 791
        -- upvalues: u24 (ref)
        u24.AutoButtonColor = false;
    end);
end;

local function RestoreParticipateOriginal() -- Line: 794
    -- upvalues: u24 (ref), u67 (copy), u70 (ref), u71 (ref)
    if not u24 then
        return;
    end;

    for i, v in u67 do
        if i.Parent then
            if v.ImageColor3 then
                i.ImageColor3 = v.ImageColor3;
            end;

            if v.BackgroundColor3 then
                i.BackgroundColor3 = v.BackgroundColor3;
            end;

            if v.TextColor3 then
                i.TextColor3 = v.TextColor3;
            end;

            if v.GradientColor then
                i.Color = v.GradientColor;
            end;

            if v.StrokeColor then
                i.Color = v.StrokeColor;
            end;
        end;
    end;

    u24.Active = u70;

    if u71 ~= nil then
        pcall(function() -- Line: 806
            -- upvalues: u24 (ref), u71 (ref)
            u24.AutoButtonColor = u71;
        end);
    end;
end;

local function SetParticipateText(p144: string) -- Line: 810
    -- upvalues: FindParticipateLabel (copy)
    local v145 = FindParticipateLabel();

    if not v145 then
        return;
    end;

    v145.Text = p144;
    local TextShadow = v145:FindFirstChild("TextShadow");

    if TextShadow and TextShadow:IsA("TextLabel") then
        TextShadow.Text = p144;
    end;
end;

local function RestoreParticipateText() -- Line: 820
    -- upvalues: u69 (ref), FindParticipateLabel (copy)
    if u69 == nil then
        return;
    end;

    local v146 = u69;
    local v147 = FindParticipateLabel();

    if not v147 then
        return;
    end;

    v147.Text = v146;
    local TextShadow = v147:FindFirstChild("TextShadow");

    if TextShadow and TextShadow:IsA("TextLabel") then
        TextShadow.Text = v146;
    end;
end;

local function UpdateParticipateButton() -- Line: 825
    -- upvalues: u24 (ref), CaptureParticipateOriginals (copy), u60 (ref), FindParticipateLabel (copy), ApplyParticipateDarkened (copy), u73 (ref), u62 (ref), RestoreParticipateOriginal (copy), u61 (ref), u63 (ref), u64 (ref)
    if not u24 then
        return;
    end;

    CaptureParticipateOriginals();

    if u60 > 0 then
        local math_floor_ret = math.floor(u60);
        local math_max_ret = math.max(0, math_floor_ret);
        local v148 = math_max_ret // 3600;
        local v149 = math_max_ret % 3600 // 60;
        local v150 = math_max_ret % 60;
        local v151;

        if v148 > 0 then
            v151 = string.format("Rejoin in %02d:%02d:%02d", v148, v149, v150);
        else
            v151 = string.format("Rejoin in %02d:%02d", v149, v150);
        end;

        local v152 = FindParticipateLabel();

        if v152 then
            v152.Text = v151;
            local TextShadow = v152:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = v151;
            end;
        end;

        ApplyParticipateDarkened();

        return;
    end;

    if u73 and not u73.IsBeeSlot then
        local v153 = FindParticipateLabel();

        if v153 then
            v153.Text = "Switch to Honey Garden";
            local TextShadow = v153:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = "Switch to Honey Garden";
            end;
        end;

        ApplyParticipateDarkened();

        return;
    end;

    if u62 then
        RestoreParticipateOriginal();
        local v154 = FindParticipateLabel();

        if not v154 then
            return;
        end;

        v154.Text = "Enter Portal";
        local TextShadow = v154:FindFirstChild("TextShadow");

        if TextShadow and TextShadow:IsA("TextLabel") then
            TextShadow.Text = "Enter Portal";
        end;

        return;
    end;

    if u61 then
        local math_floor_ret = math.floor(u63);
        local math_max_ret = math.max(0, math_floor_ret);
        local v155 = math_max_ret // 3600;
        local v156 = math_max_ret % 3600 // 60;
        local v157 = math_max_ret % 60;
        local v158;

        if v155 > 0 then
            v158 = string.format("Skip - Ignites in %d:%02d:%02d", v155, v156, v157);
        else
            v158 = string.format("Skip - Ignites in %d:%02d", v156, v157);
        end;

        local v159 = FindParticipateLabel();

        if v159 then
            v159.Text = v158;
            local TextShadow = v159:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = v158;
            end;
        end;

        RestoreParticipateOriginal();

        return;
    end;

    if u64 <= 0 then
        RestoreParticipateOriginal();
        local v160 = FindParticipateLabel();

        if not v160 then
            return;
        end;

        v160.Text = "Ignite Portal";
        local TextShadow = v160:FindFirstChild("TextShadow");

        if TextShadow and TextShadow:IsA("TextLabel") then
            TextShadow.Text = "Ignite Portal";
        end;

        return;
    end;

    local math_floor_ret = math.floor(u64);
    local math_max_ret = math.max(0, math_floor_ret);
    local v161 = math_max_ret // 3600;
    local v162 = math_max_ret % 3600 // 60;
    local v163 = math_max_ret % 60;
    local v164;

    if v161 > 0 then
        v164 = string.format("Ignite in %02d:%02d:%02d", v161, v162, v163);
    else
        v164 = string.format("Ignite in %02d:%02d", v162, v163);
    end;

    local v165 = FindParticipateLabel();

    if v165 then
        v165.Text = v164;
        local TextShadow = v165:FindFirstChild("TextShadow");

        if TextShadow and TextShadow:IsA("TextLabel") then
            TextShadow.Text = v164;
        end;
    end;

    ApplyParticipateDarkened();
end;

local function GetLocalPlayerBeeState() -- Line: 871
    -- upvalues: LocalPlayer (copy), BeeColonyStateController (copy)
    local v166 = `Player_{LocalPlayer.UserId}`;

    return BeeColonyStateController.State.BeeStates[v166];
end;

local function HasAnyLiveBee() -- Line: 878
    -- upvalues: LocalPlayer (copy), BeeColonyStateController (copy)
    local v167 = `Player_{LocalPlayer.UserId}`;
    local v168 = BeeColonyStateController.State.BeeStates[v167];

    if not v168 then
        return false;
    end;

    for _, v in v168 do
        local v169;

        if v then
            v169 = v.Server;
        else
            v169 = v;
        end;

        if v169 and (v169.Health and (v169.Health > 0 and v169.WaspWaveSurvivalDead ~= true)) then
            return true;
        end;
    end;

    return false;
end;

local function AllBeesDead() -- Line: 892
    -- upvalues: LocalPlayer (copy), BeeColonyStateController (copy)
    local v170 = `Player_{LocalPlayer.UserId}`;
    local v171 = BeeColonyStateController.State.BeeStates[v170];

    if not v171 then
        return false;
    end;

    local v172 = false;

    for _, v in v171 do
        v172 = true;
        local v173;

        if v then
            v173 = v.Server;
        else
            v173 = v;
        end;

        if v173 and (v173.Health and (v173.Health > 0 and v173.WaspWaveSurvivalDead ~= true)) then
            return false;
        end;
    end;

    return v172;
end;

local function IsBeeAtFullHealth(p174) -- Line: 909
    -- upvalues: BeeRegistry (copy), LocalPlayer (copy)
    if p174 then
        p174 = p174.Server;
    end;

    if not p174 then
        return false;
    end;

    local v175 = BeeRegistry[p174.BeeName];

    if not (v175 and v175.Stats) then
        return false;
    end;

    local MaxHealth = v175.Stats.MaxHealth;

    if p174.Player == `Player_{LocalPlayer.UserId}` then
        MaxHealth = MaxHealth + (LocalPlayer:GetAttribute("BeeHealthBonus") or 0);
    end;

    return MaxHealth <= (p174.Health or 0);
end;

local function HasInjuredBee() -- Line: 923
    -- upvalues: LocalPlayer (copy), BeeColonyStateController (copy), IsBeeAtFullHealth (copy)
    local v176 = `Player_{LocalPlayer.UserId}`;
    local v177 = BeeColonyStateController.State.BeeStates[v176];

    if not v177 then
        return false;
    end;

    for _, v in v177 do
        if not IsBeeAtFullHealth(v) then
            return true;
        end;
    end;

    return false;
end;

local u178 = false;

local function ShakeParticipateButton() -- Line: 939
    -- upvalues: u178 (ref), u24 (ref), TweenService (copy)
    if u178 or not (u24 and u24.Parent) then
        return;
    end;

    u178 = true;
    local Rotation = u24.Rotation;
    task.spawn(function() -- Line: 943
        -- upvalues: TweenService (ref), u24 (ref), Rotation (copy), u178 (ref)
        for _, v in ipairs({ 7, -7, 7, -7, 3.5, -3.5, 0 }) do
            TweenService:Create(u24, TweenInfo.new(0.04, Enum.EasingStyle.Linear), {
                Rotation = Rotation + v
            }):Play();
            task.wait(0.04);
        end;

        u24.Rotation = Rotation;
        u178 = false;
    end);
end;

local u179 = false;

local function SetupParticipateHoverGrow() -- Line: 957
    -- upvalues: u179 (ref), u24 (ref), TweenService (copy)
    if u179 or not u24 then
        return;
    end;

    u179 = true;
    local ParticipateHoverScale = u24:FindFirstChild("ParticipateHoverScale");

    if not ParticipateHoverScale then
        ParticipateHoverScale = Instance.new("UIScale");
        ParticipateHoverScale.Name = "ParticipateHoverScale";
        ParticipateHoverScale.Scale = 1;
        ParticipateHoverScale.Parent = u24;
    end;

    local TweenInfo_new_ret = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    u24.MouseEnter:Connect(function() -- Line: 970
        -- upvalues: TweenService (ref), ParticipateHoverScale (ref), TweenInfo_new_ret (copy)
        TweenService:Create(ParticipateHoverScale, TweenInfo_new_ret, {
            Scale = 1.06
        }):Play();
    end);
    u24.MouseLeave:Connect(function() -- Line: 973
        -- upvalues: TweenService (ref), ParticipateHoverScale (ref), TweenInfo_new_ret (copy)
        TweenService:Create(ParticipateHoverScale, TweenInfo_new_ret, {
            Scale = 1
        }):Play();
    end);
end;

local function FetchEventScheduleFromServer() -- Line: 978
    -- upvalues: GetState (copy), ApplyPortalSnapshot (copy), u60 (ref), UpdateParticipateButton (copy)
    local success, result = pcall(function() -- Line: 979
        -- upvalues: GetState (ref)
        return GetState:InvokeServer();
    end);

    if not success or typeof(result) ~= "table" then
        return false;
    end;

    ApplyPortalSnapshot(result);
    local v180 = tonumber(result.DefeatLockoutRemaining);

    if v180 then
        u60 = math.max(0, v180);
    end;

    UpdateParticipateButton();

    return true;
end;

local function ComputeTimePassed() -- Line: 994
    -- upvalues: u49 (ref), u53 (ref)
    return not u49 and 0 or (u53 <= 0 and 0 or workspace:GetServerTimeNow() - u53);
end;

local function SetLabelWithShadow(p181: userdata?, p182: string) -- Line: 1001
    if not p181 then
        return;
    end;

    p181.Text = p182;
    local TextShadow = p181:FindFirstChild("TextShadow");

    if TextShadow and TextShadow:IsA("TextLabel") then
        TextShadow.Text = p182;
    end;
end;

local function FormatWavesRemaining(p183: number) -- Line: 1010
    local math_floor_ret = math.floor(p183);
    local math_max_ret = math.max(0, math_floor_ret);

    return `{math_max_ret} {math_max_ret == 1 and "Wave" or "Waves"} Remaining`;
end;

local function UpdateWaspWaveSurvivalUI() -- Line: 1016
    -- upvalues: LocalPlayer (copy), WaspWaveSurvivalUI (copy), WaveProgress (copy), RemainingWaves (copy), u51 (ref), CurrentWave (copy), RemainingWasps (copy), Spring (copy), Bar (copy), Content (copy), u33 (ref), u54 (ref), u55 (ref), u50 (ref), u57 (ref), u56 (ref)
    local v184 = LocalPlayer:GetAttribute("InWaspWaveSurvival") == true;
    WaspWaveSurvivalUI.Enabled = v184;

    if not v184 then
        WaveProgress.Visible = false;
        local v185 = RemainingWaves;
        local math_floor_ret = math.floor(u51);
        local math_max_ret = math.max(0, math_floor_ret);
        local v186 = `{math_max_ret} {math_max_ret == 1 and "Wave" or "Waves"} Remaining`;

        if v185 then
            v185.Text = v186;
            local TextShadow = v185:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = v186;
            end;
        end;

        local v187 = CurrentWave;

        if v187 then
            v187.Text = "Wave 0";
            local TextShadow = v187:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = "Wave 0";
            end;
        end;

        local v188 = RemainingWasps;

        if v188 then
            v188.Text = "0/0 Wasps Left";
            local TextShadow = v188:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = "0/0 Wasps Left";
            end;
        end;

        Spring.target(Bar, 1, 3, {
            Size = UDim2.fromScale(0, Bar.Size.Y.Scale)
        });
        Spring.target(Content, 1, 3, {
            Size = UDim2.fromScale(0, 1)
        });

        return;
    end;

    local RunProgress = WaspWaveSurvivalUI:FindFirstChild("RunProgress");

    if u33 ~= nil then
        WaveProgress.Visible = false;

        if RunProgress and RunProgress:IsA("GuiObject") then
            RunProgress.Visible = false;
        end;

        return;
    end;

    if RunProgress and (RunProgress:IsA("GuiObject") and not RunProgress.Visible) then
        RunProgress.Visible = true;
    end;

    local v189 = false;

    if u54 == "Preparing" and u55 > 0 then
        local v190 = u55 - workspace:GetServerTimeNow();
        local math_ceil_ret = math.ceil(v190);
        local math_max_ret = math.max(0, math_ceil_ret);

        if math_max_ret > 0 then
            v189 = true;
            local v191 = CurrentWave;
            local v192 = `Starting in {math_max_ret}...`;

            if v191 then
                v191.Text = v192;
                local TextShadow = v191:FindFirstChild("TextShadow");

                if TextShadow and TextShadow:IsA("TextLabel") then
                    TextShadow.Text = v192;
                end;
            end;
        else
            local v193 = CurrentWave;
            local v194 = `Wave {math.max(1, u50)}`;

            if v193 then
                v193.Text = v194;
                local TextShadow = v193:FindFirstChild("TextShadow");

                if TextShadow and TextShadow:IsA("TextLabel") then
                    TextShadow.Text = v194;
                end;
            end;
        end;
    else
        local v195 = CurrentWave;
        local v196 = `Wave {math.max(1, u50)}`;

        if v195 then
            v195.Text = v196;
            local TextShadow = v195:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = v196;
            end;
        end;
    end;

    WaveProgress.Visible = not v189;
    local math_max_ret = math.max(0, u51 - u50);
    local v197 = RemainingWaves;
    local math_floor_ret = math.floor(math_max_ret);
    local math_max_ret2 = math.max(0, math_floor_ret);
    local v198 = `{math_max_ret2} {math_max_ret2 == 1 and "Wave" or "Waves"} Remaining`;

    if v197 then
        v197.Text = v198;
        local TextShadow = v197:FindFirstChild("TextShadow");

        if TextShadow and TextShadow:IsA("TextLabel") then
            TextShadow.Text = v198;
        end;
    end;

    local v199 = u51 <= 0 and 0 or math.clamp(u50 / u51, 0, 1);
    Spring.target(Content, 1, 3, {
        Size = UDim2.fromScale(v199, 1)
    });
    local v200 = math.clamp(u51 <= 0 and 1 or math_max_ret / u51, 0, 1) * 0.3333333333333333;
    Content.BackgroundColor3 = Color3.fromHSV(v200, 0.95, 0.82);
    local math_max_ret3 = math.max(0, u57);
    local math_clamp_ret = math.clamp(u56, 0, math_max_ret3);
    local v201 = RemainingWasps;
    local v202 = `{math_clamp_ret}/{math_max_ret3} Wasps Left`;

    if v201 then
        v201.Text = v202;
        local TextShadow = v201:FindFirstChild("TextShadow");

        if TextShadow and TextShadow:IsA("TextLabel") then
            TextShadow.Text = v202;
        end;
    end;

    Spring.target(Bar, 1, 3, {
        Size = UDim2.fromScale(math_max_ret3 <= 0 and 0 or math_clamp_ret / math_max_ret3, Bar.Size.Y.Scale)
    });
end;

local function UpdateStatsDisplay() -- Line: 1083
    -- upvalues: u49 (ref), u47 (ref), u50 (ref), u51 (ref), u48 (ref), u52 (ref), u46 (ref), u53 (ref)
    if u49 then
        local v203 = u47;
        local string_format_ret = string.format("%d/%d", u50, u51);

        if v203 then
            v203.Text = string_format_ret;
            local TextShadow = v203:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = string_format_ret;
            end;
        end;

        local v204 = u48;
        local v205 = tostring(u52);

        if v204 then
            v204.Text = v205;
            local TextShadow = v204:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = v205;
            end;
        end;

        local v206 = u46;
        local v207 = not u49 and 0 or (u53 <= 0 and 0 or workspace:GetServerTimeNow() - u53);
        local math_floor_ret = math.floor(v207);
        local math_max_ret = math.max(0, math_floor_ret);
        local v208 = math_max_ret // 3600;
        local v209 = math_max_ret % 3600 // 60;
        local v210 = math_max_ret % 60;
        local v211;

        if v208 > 0 then
            v211 = string.format("%02d:%02d:%02d", v208, v209, v210);
        else
            v211 = string.format("%02d:%02d", v209, v210);
        end;

        if not v206 then
            return;
        end;

        v206.Text = v211;
        local TextShadow = v206:FindFirstChild("TextShadow");

        if TextShadow and TextShadow:IsA("TextLabel") then
            TextShadow.Text = v211;
        end;
    else
        local v212 = u47;
        local string_format_ret = string.format("0/%d", u51);

        if v212 then
            v212.Text = string_format_ret;
            local TextShadow = v212:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = string_format_ret;
            end;
        end;

        local v213 = u48;

        if v213 then
            v213.Text = "0";
            local TextShadow = v213:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = "0";
            end;
        end;

        local v214 = u46;

        if not v214 then
            return;
        end;

        v214.Text = "00:00";
        local TextShadow = v214:FindFirstChild("TextShadow");

        if TextShadow and TextShadow:IsA("TextLabel") then
            TextShadow.Text = "00:00";
        end;
    end;
end;

local function ApplyRunStateSnapshot(p215) -- Line: 1095
    -- upvalues: u51 (ref), u49 (ref), u50 (ref), u52 (ref), u53 (ref), u54 (ref), u55 (ref), u56 (ref), u57 (ref), UpdateStatsDisplay (copy), UpdateWaspWaveSurvivalUI (copy)
    if not p215 then
        return;
    end;

    if p215.MaxWaves then
        u51 = p215.MaxWaves;
    end;

    if p215.Active then
        u49 = true;
        u50 = p215.Wave or 0;
        u52 = p215.TotalKilled or 0;
        u53 = p215.StartedAt or 0;
        u54 = p215.Phase or u54;
        u55 = p215.StartsAt or 0;
        u56 = p215.ActiveWasps or 0;
        u57 = p215.MaxWasps or 0;
    else
        u49 = false;
        u50 = 0;
        u52 = 0;
        u53 = 0;
        u54 = nil;
        u55 = 0;
        u56 = 0;
        u57 = 0;
    end;

    UpdateStatsDisplay();
    UpdateWaspWaveSurvivalUI();
end;

local function CloseParticipation() -- Line: 1128
    -- upvalues: u21 (ref)
    if u21 then
        u21.Visible = false;
    end;
end;

local function OpenParticipation() -- Line: 1132
    -- upvalues: u21 (ref), ConfirmationPromptController (copy), u20 (ref), UpdateParticipateButton (copy)
    if not u21 then
        warn("[WaspWaveSurvival] OpenParticipation no-op: Participation = nil");

        return;
    end;

    ConfirmationPromptController:Close();

    if u20 then
        u20.Enabled = true;
    end;

    u21.Visible = true;
    UpdateParticipateButton();
end;

local function LockUI() -- Line: 1149
end;

local function TryStart() -- Line: 1167
    -- upvalues: u19 (ref), RequestStart (copy), u74 (ref), SettingsService (copy), Notification (copy), u66 (ref), u61 (ref), u62 (ref), u65 (ref), u7 (ref), u63 (ref), u64 (ref), SyncPortalParticles (copy), SetPortalTimerText (copy), SetRunGameplayUIHidden (copy), WaspWaveSurvivalUI (copy), u21 (ref), u58 (ref), u59 (ref), UpdateParticipateButton (copy), TimeHelper (copy), u60 (ref)
    if u19 then
        return;
    end;

    u19 = true;
    local success, result = pcall(function() -- Line: 1170
        -- upvalues: RequestStart (ref)
        return RequestStart:InvokeServer();
    end);
    u19 = false;

    if not success then
        if u74 ~= nil then
            SettingsService:SetSetting("BeeColonyFollowPlayer", u74);
            u74 = nil;
        end;

        warn("Wasp Wave Survival RequestStart errored:", result);

        return;
    end;

    if typeof(result) ~= "table" then
        if u74 ~= nil then
            SettingsService:SetSetting("BeeColonyFollowPlayer", u74);
            u74 = nil;
        end;

        warn("Wasp Wave Survival RequestStart returned non-table result; server may be initializing");
        Notification:CreateNotification("Wasp Wave Survival isn\'t ready yet. Try again in a moment.");

        return;
    end;

    if result.Success then
        u66 = true;
        u61 = false;
        u62 = false;
        u65 = false;
        u7 = false;
        u63 = 0;
        u64 = 0;
        SyncPortalParticles();
        local v216;

        if u66 then
            v216 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
        else
            v216 = nil;
        end;

        SetPortalTimerText(v216);
        SetRunGameplayUIHidden(true);
        WaspWaveSurvivalUI.Enabled = true;

        if u21 then
            u21.Visible = false;
        end;

        return;
    end;

    if u74 ~= nil then
        SettingsService:SetSetting("BeeColonyFollowPlayer", u74);
        u74 = nil;
    end;

    if result.Code == "Unavailable" then
        u66 = true;
        u65 = false;
        local v217;

        if u66 then
            v217 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
        else
            v217 = nil;
        end;

        SetPortalTimerText(v217);
        u58 = false;
        local v218 = tonumber(result.AvailableIn);

        if v218 then
            u59 = math.max(0, v218);
        end;

        UpdateParticipateButton();
        Notification:CreateNotification((`Wasp Wave Survival opens in {TimeHelper:GenerateColonFormatFromTime(result.AvailableIn)}.`));

        return;
    end;

    if result.Code == "DefeatedLockout" then
        u66 = true;
        u65 = false;
        local v219;

        if u66 then
            v219 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
        else
            v219 = nil;
        end;

        SetPortalTimerText(v219);
        local v220 = tonumber(result.LockoutRemaining);

        if v220 then
            u60 = math.max(0, v220);
        end;

        UpdateParticipateButton();
        Notification:CreateNotification((`You were defeated. You can rejoin when Wasp Wave Survival reopens in {TimeHelper:GenerateColonFormatFromTime(u60)}.`));

        return;
    end;

    if result.Code == "PortalIgnited" then
        u66 = true;
        u65 = false;
        u61 = true;
        u62 = false;
        u7 = false;
        local v221 = tonumber(result.WarmupRemaining) or 0;
        u63 = math.max(0, v221);
        u64 = 0;
        UpdateParticipateButton();
        SyncPortalParticles();
        local v222;

        if u66 then
            v222 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
        else
            v222 = nil;
        end;

        SetPortalTimerText(v222);
        Notification:CreateNotification((`Portal ignited. Come back in {TimeHelper:GenerateColonFormatFromTime(u63)} to enter.`));

        return;
    end;

    if result.Code == "PortalWarmingUp" then
        u66 = true;
        u65 = false;
        u61 = true;
        u62 = false;
        u7 = false;
        local v223 = tonumber(result.WarmupRemaining) or 0;
        u63 = math.max(0, v223);
        UpdateParticipateButton();
        SyncPortalParticles();
        local v224;

        if u66 then
            v224 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
        else
            v224 = nil;
        end;

        SetPortalTimerText(v224);
        Notification:CreateNotification((`The portal is warming up. Come back in {TimeHelper:GenerateColonFormatFromTime(u63)}.`));

        return;
    end;

    if result.Code ~= "PortalIgniteCooldown" then
        if result.Code == "NotBeeFarmSlot" then
            Notification:CreateNotification("You need to be on your Bee Farm Slot to start Wasp Wave Survival.");

            return;
        end;

        if result.Code == "AlreadyInRun" then
            Notification:CreateNotification("You are already in Wasp Wave Survival.");

            if u21 then
                u21.Visible = false;

                return;
            end;
        elseif result.Code == "EventEnded" then
            Notification:CreateNotification("Wasp Wave Survival has ended.");

            if u21 then
                u21.Visible = false;

                return;
            end;
        else
            warn("Wasp Wave Survival failed:", result.Code, result);
            Notification:CreateNotification((`Could not start Wasp Wave Survival. Reason: {tostring(result.Code)}`));
        end;

        return;
    end;

    u66 = true;
    u65 = false;
    u61 = false;
    u62 = false;
    u7 = false;
    u63 = 0;
    local v225 = tonumber(result.IgniteCooldownRemaining) or 0;
    u64 = math.max(0, v225);
    UpdateParticipateButton();
    SyncPortalParticles();
    local v226;

    if u66 then
        v226 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
    else
        v226 = nil;
    end;

    SetPortalTimerText(v226);
    Notification:CreateNotification((`You can ignite the portal again in {TimeHelper:GenerateColonFormatFromTime(u64)}.`));
end;

local function GetBeeSlotKey() -- Line: 1302
    -- upvalues: SlotServiceTypes (copy)
    for i, v in SlotServiceTypes.SpecialSlotEntries do
        if v.DataFlag == "IsBeeSlot" then
            return i;
        end;
    end;

    return nil;
end;

local function OnParticipateClicked() -- Line: 1311
    -- upvalues: u60 (ref), u178 (ref), u24 (ref), TweenService (copy), Notification (copy), TimeHelper (copy), u73 (ref), SlotServiceTypes (copy), SaveSlotController (copy), u61 (ref), u62 (ref), MarketController (copy), PurchaseID (copy), u64 (ref), LocalPlayer (copy), BeeColonyStateController (copy), TryStart (copy), IsBeeAtFullHealth (copy), u38 (ref), ConfirmationPromptController (copy), u74 (ref), SettingsService (copy)
    if u60 > 0 then
        if not u178 and (u24 and u24.Parent) then
            u178 = true;
            local Rotation = u24.Rotation;
            task.spawn(function() -- Line: 943
                -- upvalues: TweenService (ref), u24 (ref), Rotation (copy), u178 (ref)
                for _, v in ipairs({ 7, -7, 7, -7, 3.5, -3.5, 0 }) do
                    TweenService:Create(u24, TweenInfo.new(0.04, Enum.EasingStyle.Linear), {
                        Rotation = Rotation + v
                    }):Play();
                    task.wait(0.04);
                end;

                u24.Rotation = Rotation;
                u178 = false;
            end);
        end;

        Notification:CreateNotification((`You were defeated. You can rejoin when Wasp Wave Survival reopens in {TimeHelper:GenerateColonFormatFromTime(u60)}.`));

        return;
    end;

    if not (u73 and u73.IsBeeSlot) then
        local v227 = nil;

        for i, v in SlotServiceTypes.SpecialSlotEntries do
            if v.DataFlag == "IsBeeSlot" then
                v227 = i;
                break;
            end;
        end;

        if v227 then
            if SaveSlotController:IsSpecialSlotOptedIn(v227) then
                SaveSlotController:ChangeSlots(v227);
            else
                SaveSlotController:OptInToSpecialSlot(v227);
            end;

            Notification:CreateNotification("Switching to your Honey Garden...");

            return;
        end;

        if not u178 and (u24 and u24.Parent) then
            u178 = true;
            local Rotation = u24.Rotation;
            task.spawn(function() -- Line: 943
                -- upvalues: TweenService (ref), u24 (ref), Rotation (copy), u178 (ref)
                for _, v in ipairs({ 7, -7, 7, -7, 3.5, -3.5, 0 }) do
                    TweenService:Create(u24, TweenInfo.new(0.04, Enum.EasingStyle.Linear), {
                        Rotation = Rotation + v
                    }):Play();
                    task.wait(0.04);
                end;

                u24.Rotation = Rotation;
                u178 = false;
            end);
        end;

        Notification:CreateNotification("Switch to your Honey Garden. You need your bees to help you fight.");

        return;
    end;

    if u61 and not u62 then
        pcall(function() -- Line: 1338
            -- upvalues: MarketController (ref), PurchaseID (ref)
            MarketController:PromptPurchase(PurchaseID, Enum.InfoType.Product);
        end);

        return;
    end;

    if u64 > 0 and not u62 then
        if not u178 and (u24 and u24.Parent) then
            u178 = true;
            local Rotation = u24.Rotation;
            task.spawn(function() -- Line: 943
                -- upvalues: TweenService (ref), u24 (ref), Rotation (copy), u178 (ref)
                for _, v in ipairs({ 7, -7, 7, -7, 3.5, -3.5, 0 }) do
                    TweenService:Create(u24, TweenInfo.new(0.04, Enum.EasingStyle.Linear), {
                        Rotation = Rotation + v
                    }):Play();
                    task.wait(0.04);
                end;

                u24.Rotation = Rotation;
                u178 = false;
            end);
        end;

        Notification:CreateNotification((`You can ignite the portal again in {TimeHelper:GenerateColonFormatFromTime(u64)}.`));

        return;
    end;

    local v228 = `Player_{LocalPlayer.UserId}`;

    if BeeColonyStateController.State.BeeStates[v228] then
        local v229 = next;
        local v230 = `Player_{LocalPlayer.UserId}`;

        if v229(BeeColonyStateController.State.BeeStates[v230]) ~= nil then
            if not u62 then
                TryStart();

                return;
            end;

            local v231 = `Player_{LocalPlayer.UserId}`;
            local v232 = BeeColonyStateController.State.BeeStates[v231];
            local v233;

            if v232 then
                v233 = false;

                for _, v in v232 do
                    if not IsBeeAtFullHealth(v) then
                        v233 = true;
                        break;
                    end;
                end;
            else
                v233 = false;
            end;

            if v233 then
                if u38 then
                    return;
                end;

                u38 = true;
                ConfirmationPromptController:Open({
                    Title = "Bees Not at Full Health",
                    Header = "Some of your bees aren\'t at full health.",
                    Middle = "Are you sure you want to enter the dungeon?",
                    Footer = "They may not survive the wasp waves."
                }, {
                    ConfirmCallback = function() -- Line: 1373, Name: ConfirmCallback
                        -- upvalues: u38 (ref), u74 (ref), SettingsService (ref), TryStart (ref)
                        u38 = false;

                        if u74 == nil then
                            u74 = SettingsService:GetSetting("BeeColonyFollowPlayer");
                        end;

                        SettingsService:SetSetting("BeeColonyFollowPlayer", true);
                        TryStart();
                    end,

                    RejectCallback = function() -- Line: 1378, Name: RejectCallback
                        -- upvalues: u38 (ref)
                        u38 = false;
                    end
                });

                return;
            end;

            if u74 == nil then
                u74 = SettingsService:GetSetting("BeeColonyFollowPlayer");
            end;

            SettingsService:SetSetting("BeeColonyFollowPlayer", true);
            TryStart();

            return;
        end;
    end;

    if not u178 and (u24 and u24.Parent) then
        u178 = true;
        local Rotation = u24.Rotation;
        task.spawn(function() -- Line: 943
            -- upvalues: TweenService (ref), u24 (ref), Rotation (copy), u178 (ref)
            for _, v in ipairs({ 7, -7, 7, -7, 3.5, -3.5, 0 }) do
                TweenService:Create(u24, TweenInfo.new(0.04, Enum.EasingStyle.Linear), {
                    Rotation = Rotation + v
                }):Play();
                task.wait(0.04);
            end;

            u24.Rotation = Rotation;
            u178 = false;
        end);
    end;

    Notification:CreateNotification("You need bees to help you fight!");
end;

local function BuildRewardPool() -- Line: 1390
    -- upvalues: WaspWaveSurvivalConfig (copy)
    local u234 = {};
    local u235 = {};

    local function tryAdd(p236) -- Line: 1394
        -- upvalues: u235 (copy), u234 (copy)
        if not (p236 and p236.Type) then
            return;
        end;

        local v237 = tostring(p236.Type) .. "|" .. tostring(p236.Value);

        if u235[v237] then
            return;
        end;

        u235[v237] = true;
        table.insert(u234, p236);
    end;

    local Rewards = WaspWaveSurvivalConfig.Rewards;

    if not Rewards then
        return u234;
    end;

    if Rewards.Guaranteed then
        for _, v in Rewards.Guaranteed do
            if v.Rewards then
                for _, v4 in v.Rewards do
                    if v4 then
                        if v4.Type then
                            local v238 = tostring(v4.Type) .. "|" .. tostring(v4.Value);

                            if not u235[v238] then
                                u235[v238] = true;
                                table.insert(u234, v4);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    if Rewards.ChaseItems then
        for _, v in Rewards.ChaseItems do
            local Reward = v.Reward;

            if Reward then
                if Reward.Type then
                    local v239 = tostring(Reward.Type) .. "|" .. tostring(Reward.Value);

                    if not u235[v239] then
                        u235[v239] = true;
                        table.insert(u234, Reward);
                    end;
                end;
            end;
        end;
    end;

    return u234;
end;

local function PaintSlot(p240: userdata, u241: any) -- Line: 1425
    -- upvalues: GiveServiceCommon (copy)
    if not u241 then
        p240.Image = "";

        return;
    end;

    local success, result = pcall(function() -- Line: 1430
        -- upvalues: GiveServiceCommon (ref), u241 (copy)
        return GiveServiceCommon:GetImage(u241);
    end);
    p240.Image = success and result and result or "";
    local Parent = p240.Parent;

    if not Parent then
        return;
    end;

    Parent:SetAttribute("UUID", "WaspReward_" .. tostring(u241.Type) .. "_" .. tostring(u241.Value));
end;

local function TweenImageTransparency(p242: userdata, p243: number, p244: number) -- Line: 1441
    -- upvalues: RunService (copy)
    local ImageTransparency = p242.ImageTransparency;
    local v245 = 0;

    while v245 < p244 do
        v245 = v245 + RunService.RenderStepped:Wait();
        local math_min_ret = math.min(v245 / p244, 1);
        p242.ImageTransparency = ImageTransparency + (p243 - ImageTransparency) * math_min_ret;
    end;

    p242.ImageTransparency = p243;
end;

local function AnimateSlotSwap(p246: userdata, p247: any) -- Line: 1454
    -- upvalues: TweenImageTransparency (copy), PaintSlot (copy)
    TweenImageTransparency(p246, 1, 0.25);
    PaintSlot(p246, p247);
    TweenImageTransparency(p246, 0, 0.25);
end;

local function StartSunraysSpin() -- Line: 1460
    -- upvalues: u44 (copy), RunService (copy)
    if #u44 == 0 then
        return;
    end;

    RunService.RenderStepped:Connect(function(p248) -- Line: 1462
        -- upvalues: u44 (ref)
        local v249 = 30 * p248;

        for _, v in u44 do
            v.Rotation = (v.Rotation + v249) % 360;
        end;
    end);
end;

local function StartPrimarySubjectBop() -- Line: 1470
    -- upvalues: u45 (ref), RunService (copy)
    if not u45 then
        return;
    end;

    local u250 = 0;
    RunService.RenderStepped:Connect(function(p251) -- Line: 1475
        -- upvalues: u250 (ref), u45 (ref)
        u250 = u250 + p251;
        local v252 = math.sin(u250 * 2 * 3.141592653589793 / 2) * 0.04000000000000001 + 0.19;
        u45.Position = UDim2.new(0.04, 0, v252, 0);
    end);
end;

local function StartRewardRotator() -- Line: 1482
    -- upvalues: BuildRewardPool (copy), u39 (ref), ItemInfoHover (copy), u43 (copy), PaintSlot (copy), AnimateSlotSwap (copy)
    local u253 = BuildRewardPool();
    u39 = u253;
    ItemInfoHover:AddRewardTable("WaspReward", u253);
    local u254 = #u43;

    if u254 == 0 then
        return;
    end;

    if #u253 == 0 then
        for _, v in u43 do
            local Parent = v.Parent;

            if Parent and Parent:IsA("GuiObject") then
                Parent.Visible = false;
            end;
        end;

        return;
    end;

    local math_min_ret = math.min(u254, #u253);

    for i = 1, u254 do
        local Parent = u43[i].Parent;
        local v255;

        if i <= math_min_ret then
            if Parent and Parent:IsA("GuiObject") then
                Parent.Visible = true;
            end;

            PaintSlot(u43[i], u253[i]);
            v255 = i;
        elseif Parent and Parent:IsA("GuiObject") then
            Parent.Visible = false;
            v255 = i;
        else
            v255 = i;
        end;
    end;

    if #u253 <= u254 then
        return;
    end;

    task.spawn(function() -- Line: 1514
        -- upvalues: u253 (copy), u254 (copy), u43 (ref), AnimateSlotSwap (ref)
        local v256 = 0;

        while true do
            task.wait(8);
            v256 = (v256 + #u253 - 1) % #u253;

            for i = 1, u254 do
                task.delay((i - 1) * 0.1, AnimateSlotSwap, u43[i], u253[(v256 + i - 1) % #u253 + 1]);
                local _ = i;
            end;
        end;
    end);
end;

local function ConnectClick(p257: userdata, u258: function) -- Line: 1531
    if p257:IsA("GuiButton") then
        p257.Activated:Connect(u258);

        return;
    end;

    p257.InputBegan:Connect(function(p259: userdata) -- Line: 1535
        -- upvalues: u258 (copy)
        if p259.UserInputType == Enum.UserInputType.MouseButton1 or p259.UserInputType == Enum.UserInputType.Touch then
            u258();
        end;
    end);
end;

function u1.Start() -- Line: 1544
    -- upvalues: LocalPlayer (copy), SetRunGameplayUIHidden (copy), WaspWaveSurvivalUI (copy), SetWaspSurvivalLoopEnabled (copy), UpdateWaspWaveSurvivalUI (copy), u21 (ref), BeeColonyStateController (copy), PlayerGui (copy), u20 (ref), u22 (ref), u23 (ref), u24 (ref), u25 (ref), u46 (ref), u47 (ref), u48 (ref), u43 (copy), u44 (copy), StartRewardRotator (copy), u45 (ref), RunService (copy), WaveProgress (copy), u26 (ref), TweenService (copy), ConnectClick (copy), u49 (ref), u33 (ref), HasAnyLiveBee (copy), u37 (ref), ConfirmationPromptController (copy), RequestExit (copy), u42 (ref), u40 (ref), u35 (ref), RequestClaim (copy), u5 (ref), u36 (ref), Notification (copy), u74 (ref), SettingsService (copy), u41 (ref), u27 (ref), u28 (ref), u29 (ref), u30 (copy), u31 (ref), u32 (ref), u34 (ref), u39 (ref), BuildRewardPool (copy), PaintSlot (copy), EnsureConclusionQuantityLabel (copy), CommaFormatNumber (copy), ItemInfoHover (copy), AllBeesDead (copy), u50 (ref), Victory (copy), u1 (copy), OnParticipateClicked (copy), CloseParticipation (copy), SetupParticipateHoverGrow (copy), GameConfigController (copy), FormatRemaining (copy), GetState (copy), ApplyRunStateSnapshot (copy), ApplyPortalSnapshot (copy), u60 (ref), UpdateParticipateButton (copy), UpdateStatsDisplay (copy), u73 (ref), SaveSlotController (copy), MarketplaceService (copy), PurchaseID (copy), u66 (ref), u63 (ref), u62 (ref), u65 (ref), SetPortalTimerText (copy), u61 (ref), u7 (ref), StateChanged (copy), u51 (ref), u54 (ref), u55 (ref), u53 (ref), u56 (ref), u57 (ref), PopulateVictoryRewards (copy), CondenseRewards (copy), u64 (ref), FetchEventScheduleFromServer (copy), CreateTagHandler (copy), Trove (copy)
    local v260 = LocalPlayer:GetAttribute("InWaspWaveSurvival") == true;
    LocalPlayer:SetAttribute("NormalMusicSuppressed", v260);
    SetRunGameplayUIHidden(v260);
    WaspWaveSurvivalUI.Enabled = v260;
    SetWaspSurvivalLoopEnabled(v260);
    local u261 = LocalPlayer:GetAttribute("InWaspWaveSurvival") == true;
    LocalPlayer:GetAttributeChangedSignal("InWaspWaveSurvival"):Connect(function() -- Line: 1549
        -- upvalues: LocalPlayer (ref), u261 (ref), SetRunGameplayUIHidden (ref), WaspWaveSurvivalUI (ref), SetWaspSurvivalLoopEnabled (ref), UpdateWaspWaveSurvivalUI (ref), u21 (ref), BeeColonyStateController (ref)
        local v262 = LocalPlayer:GetAttribute("InWaspWaveSurvival") == true;
        local v263 = u261 and not v262;
        u261 = v262;
        local v264 = LocalPlayer:GetAttribute("InWaspWaveSurvival") == true;
        LocalPlayer:SetAttribute("NormalMusicSuppressed", v264);
        SetRunGameplayUIHidden(v264);
        WaspWaveSurvivalUI.Enabled = v264;
        SetWaspSurvivalLoopEnabled(v264);
        UpdateWaspWaveSurvivalUI();

        if v262 then
            if u21 then
                u21.Visible = false;
            end;
        elseif v263 then
            task.wait(0.5);
            BeeColonyStateController:ForceReloadLocalPlayerBeeModels();
        end;
    end);
    local BizzyBeeWaspDungeon_UI = PlayerGui:WaitForChild("BizzyBeeWaspDungeon_UI", 10);

    if not BizzyBeeWaspDungeon_UI then
        warn("BizzyBeeWaspDungeon_UI not found; WaspWaveSurvivalController aborting");

        return;
    end;

    u20 = BizzyBeeWaspDungeon_UI;
    u21 = BizzyBeeWaspDungeon_UI:WaitForChild("Participation");
    local Main = u21:WaitForChild("Main");
    u22 = Main:WaitForChild("Timer");
    u23 = u22:FindFirstChild("TextShadow");
    u24 = u21:WaitForChild("ParticipateButton");
    u25 = u21:WaitForChild("Header"):WaitForChild("Close");
    local EventDetails = Main:FindFirstChild("EventDetails");
    local u265;

    if EventDetails then
        u265 = EventDetails:FindFirstChild("InfoList");
    else
        u265 = EventDetails;
    end;

    if u265 then
        local function pickTitle(p266) -- Line: 1583
            -- upvalues: u265 (copy)
            local v267 = u265:FindFirstChild(p266);

            if v267 then
                v267 = v267:FindFirstChild("Title");
            end;

            if not (v267 and (v267:IsA("TextLabel") and v267)) then
                v267 = nil;
            end;

            return v267;
        end;

        local TimePassed = u265:FindFirstChild("TimePassed");
        local v268 = TimePassed and TimePassed:FindFirstChild("Title");

        if not (v268 and (v268:IsA("TextLabel") and v268)) then
            v268 = nil;
        end;

        u46 = v268;
        local Waves = u265:FindFirstChild("Waves");
        local v269 = Waves and Waves:FindFirstChild("Title");

        if not (v269 and (v269:IsA("TextLabel") and v269)) then
            v269 = nil;
        end;

        u47 = v269;
        local TotalKilled = u265:FindFirstChild("TotalKilled");
        local v270 = TotalKilled and TotalKilled:FindFirstChild("Title");

        if not (v270 and (v270:IsA("TextLabel") and v270)) then
            v270 = nil;
        end;

        u48 = v270;
    end;

    if EventDetails then
        EventDetails = EventDetails:FindFirstChild("Rewards");
    end;

    if EventDetails then
        for i = 1, 3 do
            local v271 = EventDetails:FindFirstChild("RewardTemplate" .. i);
            local v272;

            if v271 then
                v272 = v271:FindFirstChild("Reward");
            else
                v272 = v271;
            end;

            if v272 and v272:IsA("ImageLabel") then
                table.insert(u43, v272);
            end;

            if v271 then
                v271 = v271:FindFirstChild("Details");
            end;

            if v271 then
                v271 = v271:FindFirstChild("Sunrays");
            end;

            local v273;

            if v271 and v271:IsA("ImageLabel") then
                table.insert(u44, v271);
                v273 = i;
            else
                v273 = i;
            end;
        end;

        StartRewardRotator();
    end;

    local v274 = u21:FindFirstChild("Details") and u21.Details:FindFirstChild("Characters");
    local v275;

    if v274 then
        v275 = v274:FindFirstChild("CharacterDetails");
    else
        v275 = v274;
    end;

    if v275 then
        for _, v in { "Sunrays1", "Sunrays2" } do
            local v276 = v275:FindFirstChild(v);

            if v276 and v276:IsA("ImageLabel") then
                table.insert(u44, v276);
            end;
        end;
    end;

    if v274 then
        v274 = v274:FindFirstChild("PrimarySubject");
    end;

    if v274 and v274:IsA("ImageLabel") then
        u45 = v274;
    end;

    if #u44 ~= 0 then
        RunService.RenderStepped:Connect(function(p277) -- Line: 1462
            -- upvalues: u44 (ref)
            local v278 = 30 * p277;

            for _, v in u44 do
                v.Rotation = (v.Rotation + v278) % 360;
            end;
        end);
    end;

    if u45 then
        local u279 = 0;
        RunService.RenderStepped:Connect(function(p280) -- Line: 1475
            -- upvalues: u279 (ref), u45 (ref)
            u279 = u279 + p280;
            local v281 = math.sin(u279 * 2 * 3.141592653589793 / 2) * 0.04000000000000001 + 0.19;
            u45.Position = UDim2.new(0.04, 0, v281, 0);
        end);
    end;

    local function u282() -- Line: 1632
    end;

    local v283 = PlayerGui:FindFirstChild("Top_Notification") or PlayerGui:WaitForChild("Top_Notification", 5);

    if v283 then
        local u284 = v283:FindFirstChild("Frame") or v283:WaitForChild("Frame", 5);

        if u284 and u284:IsA("GuiObject") then
            local Position = u284.Position;
            local UDim2_new_ret = UDim2.new(0.5, 0, 0.25, 0);

            u282 = function() -- Line: 1639
                -- upvalues: WaveProgress (ref), u284 (copy), UDim2_new_ret (copy), Position (copy)
                if WaveProgress.Visible then
                    u284.Position = UDim2_new_ret;

                    return;
                end;

                u284.Position = Position;
            end;
        end;
    end;

    local function disableAutoClaimTimer() -- Line: 1739
        -- upvalues: u42 (ref), u40 (ref)
        if u42 then
            u42:Disconnect();
            u42 = nil;
        end;

        if u40 then
            u40.Visible = false;
        end;
    end;

    local function fireAutoTrigger() -- Line: 1749
        -- upvalues: u49 (ref), u33 (ref), u35 (ref), RequestClaim (ref), u5 (ref), u36 (ref), Notification (ref), u74 (ref), SettingsService (ref), RequestExit (ref)
        if not u49 or u33 == nil then
            return;
        end;

        if not u35 then
            RequestClaim:FireServer();
        end;

        local v285;

        if u33 == "Victory" then
            v285 = u5;
        else
            v285 = u36;
        end;

        if v285 and #v285 > 0 then
            local v286 = {};

            for _, v in ipairs(v285) do
                local v287 = tonumber(v.Quantity) or 1;
                local v288 = tostring(v.Value or (v.Type or "Reward"));

                if v287 > 1 then
                    v288 = `{v287}x {v288}`;
                end;

                table.insert(v286, v288);
            end;

            Notification:CreateNotification((`Auto-claimed: {table.concat(v286, ", ")}`));
        else
            Notification:CreateNotification("Auto-claimed your rewards and left the dungeon!");
        end;

        if u74 ~= nil then
            SettingsService:SetSetting("BeeColonyFollowPlayer", u74);
            u74 = nil;
        end;

        RequestExit:FireServer();
    end;

    local function enableAutoClaimTimer(u289) -- Line: 1777
        -- upvalues: u40 (ref), u42 (ref), u41 (ref), RunService (ref), fireAutoTrigger (copy)
        u40 = u289:FindFirstChild("AutoClaimTimer") or u40;

        if u42 then
            return;
        end;

        u41 = os.clock();
        u42 = RunService.Heartbeat:Connect(function() -- Line: 1782
            -- upvalues: u289 (copy), u42 (ref), u40 (ref), u41 (ref), fireAutoTrigger (ref)
            if not u289.Visible then
                if u42 then
                    u42:Disconnect();
                    u42 = nil;
                end;

                if u40 then
                    u40.Visible = false;
                end;

                return;
            end;

            local v290 = os.clock() - u41;

            if v290 < 30 then
                if u40 then
                    local math_ceil_ret = math.ceil(30 - v290);
                    local math_max_ret = math.max(0, math_ceil_ret);
                    u40.Text = string.format("Auto Claiming & Exiting Dungeon in %d %s", math_max_ret, math_max_ret == 1 and "Second" or "Seconds");
                    u40.Visible = true;
                end;

                return;
            end;

            u41 = os.clock();

            if u40 then
                u40.Visible = false;
            end;

            fireAutoTrigger();
        end);
    end;

    local function BuildConclusionPanel() -- Line: 1813
        -- upvalues: u27 (ref), WaspWaveSurvivalUI (ref), u28 (ref), u29 (ref), u30 (ref), u44 (ref), u31 (ref), u32 (ref), TweenService (ref), ConnectClick (ref), u49 (ref), u33 (ref), u74 (ref), SettingsService (ref), RequestExit (ref), u40 (ref), u42 (ref), u41 (ref), RunService (ref), fireAutoTrigger (copy)
        if u27 then
            return;
        end;

        local WaspWaveConclusionPanel = WaspWaveSurvivalUI:FindFirstChild("WaspWaveConclusionPanel");

        if not (WaspWaveConclusionPanel and WaspWaveConclusionPanel:IsA("Frame")) then
            warn("[WaspWaveSurvivalController] WaspWaveConclusionPanel not found under WaspWaveSurvivalUI; conclusion UI disabled");

            return;
        end;

        WaspWaveConclusionPanel.Visible = false;
        local Header = WaspWaveConclusionPanel:FindFirstChild("Header");

        if Header and Header:IsA("TextLabel") then
            u28 = Header;
            local TextShadow = Header:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                u29 = TextShadow;
            end;
        end;

        local RewardsRow = WaspWaveConclusionPanel:FindFirstChild("RewardsRow");

        if RewardsRow then
            for i = 1, 3 do
                local v291 = RewardsRow:FindFirstChild("RewardBox" .. i);
                local v292;

                if v291 and v291:IsA("Frame") then
                    v291.Size = UDim2.new(0.3333333333333333, -8, 1, 0);
                    local v293 = v291:FindFirstChildOfClass("UIAspectRatioConstraint");

                    if v293 then
                        v293.AspectType = Enum.AspectType.ScaleWithParentSize;
                    end;

                    table.insert(u30, v291);
                    table.insert(u44, v291.Details.Sunrays);
                    v292 = i;
                else
                    v292 = i;
                end;
            end;
        end;

        local ClaimButton = WaspWaveConclusionPanel:FindFirstChild("ClaimButton");

        if ClaimButton then
            u31 = ClaimButton;
            local Title = ClaimButton:FindFirstChild("Title");

            if Title and Title:IsA("TextLabel") then
                u32 = Title;
            end;

            local ClaimHoverScale = ClaimButton:FindFirstChild("ClaimHoverScale");

            if ClaimHoverScale and ClaimHoverScale:IsA("UIScale") then
                local TweenInfo_new_ret = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                ClaimButton.MouseEnter:Connect(function() -- Line: 1867
                    -- upvalues: TweenService (ref), ClaimHoverScale (copy), TweenInfo_new_ret (copy)
                    TweenService:Create(ClaimHoverScale, TweenInfo_new_ret, {
                        Scale = 1.05
                    }):Play();
                end);
                ClaimButton.MouseLeave:Connect(function() -- Line: 1870
                    -- upvalues: TweenService (ref), ClaimHoverScale (copy), TweenInfo_new_ret (copy)
                    TweenService:Create(ClaimHoverScale, TweenInfo_new_ret, {
                        Scale = 1
                    }):Play();
                end);
            end;

            ConnectClick(ClaimButton.SENSOR, function() -- Line: 1875
                -- upvalues: u49 (ref), u33 (ref), u74 (ref), SettingsService (ref), RequestExit (ref)
                if not u49 then
                    return;
                end;

                if u33 == nil then
                    return;
                end;

                if u74 ~= nil then
                    SettingsService:SetSetting("BeeColonyFollowPlayer", u74);
                    u74 = nil;
                end;

                RequestExit:FireServer();
            end);
        end;

        local EntryScale = WaspWaveConclusionPanel:FindFirstChild("EntryScale");
        local AutoClaimTimer = WaspWaveConclusionPanel:FindFirstChild("AutoClaimTimer");

        if not AutoClaimTimer then
            AutoClaimTimer = Instance.new("TextLabel");
            AutoClaimTimer.Name = "AutoClaimTimer";
            AutoClaimTimer.AnchorPoint = Vector2.new(0.5, 0.5);
            AutoClaimTimer.Position = UDim2.new(0.5, 0, 0.7, 0);
            AutoClaimTimer.Size = UDim2.new(0.6, 0, 0.06, 0);
            AutoClaimTimer.BackgroundTransparency = 1;
            AutoClaimTimer.Text = "";
            AutoClaimTimer.TextColor3 = Color3.fromRGB(255, 235, 130);
            AutoClaimTimer.TextScaled = true;
            AutoClaimTimer.Font = Enum.Font.GothamBold;
            AutoClaimTimer.Visible = false;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Thickness = 2;
            UIStroke.Color = Color3.fromRGB(0, 0, 0);
            UIStroke.Parent = AutoClaimTimer;
            AutoClaimTimer.Parent = WaspWaveConclusionPanel;
        end;

        u40 = AutoClaimTimer;

        local function bumpAutoClaim() -- Line: 1912
        end;

        WaspWaveConclusionPanel.MouseEnter:Connect(bumpAutoClaim);
        WaspWaveConclusionPanel.MouseMoved:Connect(bumpAutoClaim);
        WaspWaveConclusionPanel.InputBegan:Connect(bumpAutoClaim);

        if u31 then
            u31.MouseEnter:Connect(bumpAutoClaim);
            u31.MouseMoved:Connect(bumpAutoClaim);
        end;

        if EntryScale and EntryScale:IsA("UIScale") then
            local u294 = nil;
            WaspWaveConclusionPanel:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1929
                -- upvalues: WaspWaveConclusionPanel (copy), EntryScale (copy), u294 (ref), TweenService (ref), u40 (ref), u42 (ref), u41 (ref), RunService (ref), fireAutoTrigger (ref)
                if not WaspWaveConclusionPanel.Visible then
                    if u294 then
                        u294:Cancel();
                    end;

                    EntryScale.Scale = 0.4;

                    if u42 then
                        u42:Disconnect();
                        u42 = nil;
                    end;

                    if u40 then
                        u40.Visible = false;
                    end;

                    return;
                end;

                EntryScale.Scale = 0.4;

                if u294 then
                    u294:Cancel();
                end;

                u294 = TweenService:Create(EntryScale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Scale = 1
                });
                u294:Play();
                local u295 = WaspWaveConclusionPanel;
                u40 = u295:FindFirstChild("AutoClaimTimer") or u40;

                if u42 then
                    return;
                end;

                u41 = os.clock();
                u42 = RunService.Heartbeat:Connect(function() -- Line: 1782
                    -- upvalues: u295 (copy), u42 (ref), u40 (ref), u41 (ref), fireAutoTrigger (ref)
                    if not u295.Visible then
                        if u42 then
                            u42:Disconnect();
                            u42 = nil;
                        end;

                        if u40 then
                            u40.Visible = false;
                        end;

                        return;
                    end;

                    local v296 = os.clock() - u41;

                    if v296 < 30 then
                        if u40 then
                            local math_ceil_ret = math.ceil(30 - v296);
                            local math_max_ret = math.max(0, math_ceil_ret);
                            u40.Text = string.format("Auto Claiming & Exiting Dungeon in %d %s", math_max_ret, math_max_ret == 1 and "Second" or "Seconds");
                            u40.Visible = true;
                        end;

                        return;
                    end;

                    u41 = os.clock();

                    if u40 then
                        u40.Visible = false;
                    end;

                    fireAutoTrigger();
                end);
            end);
        else
            WaspWaveConclusionPanel:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1948
                -- upvalues: WaspWaveConclusionPanel (copy), u40 (ref), u42 (ref), u41 (ref), RunService (ref), fireAutoTrigger (ref)
                if not WaspWaveConclusionPanel.Visible then
                    if u42 then
                        u42:Disconnect();
                        u42 = nil;
                    end;

                    if u40 then
                        u40.Visible = false;
                    end;

                    return;
                end;

                local u297 = WaspWaveConclusionPanel;
                u40 = u297:FindFirstChild("AutoClaimTimer") or u40;

                if u42 then
                    return;
                end;

                u41 = os.clock();
                u42 = RunService.Heartbeat:Connect(function() -- Line: 1782
                    -- upvalues: u297 (copy), u42 (ref), u40 (ref), u41 (ref), fireAutoTrigger (ref)
                    if not u297.Visible then
                        if u42 then
                            u42:Disconnect();
                            u42 = nil;
                        end;

                        if u40 then
                            u40.Visible = false;
                        end;

                        return;
                    end;

                    local v298 = os.clock() - u41;

                    if v298 < 30 then
                        if u40 then
                            local math_ceil_ret = math.ceil(30 - v298);
                            local math_max_ret = math.max(0, math_ceil_ret);
                            u40.Text = string.format("Auto Claiming & Exiting Dungeon in %d %s", math_max_ret, math_max_ret == 1 and "Second" or "Seconds");
                            u40.Visible = true;
                        end;

                        return;
                    end;

                    u41 = os.clock();

                    if u40 then
                        u40.Visible = false;
                    end;

                    fireAutoTrigger();
                end);
            end);
        end;

        u27 = WaspWaveConclusionPanel;
    end;

    local function UpdateConclusionPanel() -- Line: 1956
        -- upvalues: u27 (ref), u28 (ref), u34 (ref), u29 (ref), u36 (ref), u39 (ref), BuildRewardPool (ref), u30 (ref), PaintSlot (ref), EnsureConclusionQuantityLabel (ref), CommaFormatNumber (ref), ItemInfoHover (ref), u32 (ref)
        if not u27 then
            return;
        end;

        if u28 then
            local v299 = `You made it to wave {u34}`;
            u28.Text = v299;
            u28.TextColor3 = Color3.fromRGB(230, 40, 40);

            if u29 then
                u29.Text = v299;
            end;
        end;

        local v300 = u36;
        local v301 = v300 ~= nil;

        if not v300 then
            v300 = u39 or BuildRewardPool();
            u39 = v300;
        end;

        for i, v in ipairs(u30) do
            local u302 = v300[i];
            local Reward = v:FindFirstChild("Reward");

            if Reward and Reward:IsA("ImageLabel") then
                PaintSlot(Reward, u302);
            end;

            v.Visible = u302 ~= nil;
            local v303 = EnsureConclusionQuantityLabel(v);

            if u302 and v301 then
                local v304 = tonumber(u302.Quantity) or 0;
                v303.Text = v304 <= 0 and "" or "x" .. CommaFormatNumber(v304);
                local u305 = "WaspReward_" .. tostring(u302.Type) .. "_" .. tostring(u302.Value);
                v:SetAttribute("UUID", u305);
                local success, result = pcall(function() -- Line: 1989
                    -- upvalues: ItemInfoHover (ref), u305 (copy), u302 (copy)
                    ItemInfoHover:AddItemFromRewardWithQuantity(u305, u302);
                end);

                if not success then
                    warn("[WaspWaveSurvival] Conclusion hover register failed:", result, u302);
                end;
            else
                v303.Text = "";
            end;
        end;

        if u32 then
            u32.Text = "Claim Rewards";
        end;
    end;

    local function SyncExitDungeonUI() -- Line: 2006
        -- upvalues: LocalPlayer (ref), u33 (ref), AllBeesDead (ref), u34 (ref), u50 (ref), u35 (ref), u41 (ref), UpdateWaspWaveSurvivalUI (ref), u36 (ref), u26 (ref), u27 (ref), UpdateConclusionPanel (copy), Victory (ref)
        local v306 = LocalPlayer:GetAttribute("InWaspWaveSurvival") == true;

        if v306 and (u33 == nil and AllBeesDead()) then
            u33 = "Defeated";
            u34 = u50;
            u35 = false;
            u41 = os.clock();
            UpdateWaspWaveSurvivalUI();
        end;

        if not v306 and u33 ~= nil then
            u33 = nil;
            u34 = 0;
            u35 = false;
            u36 = nil;
        end;

        if u26 then
            local v307;

            if v306 then
                v307 = u33 == nil;
            else
                v307 = v306;
            end;

            u26.Visible = v307;
        end;

        if u27 then
            local v308;

            if v306 then
                if u33 == nil then
                    v308 = false;
                else
                    v308 = u33 ~= "Victory";
                end;
            else
                v308 = v306;
            end;

            if v308 then
                UpdateConclusionPanel();
            end;

            u27.Visible = v308;
        end;

        if Victory then
            if v306 then
                v306 = u33 == "Victory";
            end;

            Victory.Visible = v306;
        end;
    end;

    (function() -- Line: 1654, Name: BuildExitDungeonButton
        -- upvalues: u26 (ref), u24 (ref), WaspWaveSurvivalUI (ref), TweenService (ref), ConnectClick (ref), u49 (ref), u33 (ref), HasAnyLiveBee (ref), u37 (ref), ConfirmationPromptController (ref), RequestExit (ref)
        if u26 or not u24 then
            return;
        end;

        local u309 = u24:Clone();
        u309.Name = "ExitDungeonButton";
        u309.AnchorPoint = Vector2.new(0.5, 0.5);
        u309.Position = UDim2.new(0.94, 0, 0.5, 0);
        u309.Size = UDim2.new(0.1, 0, 0.045, 0);
        u309.Rotation = 0;
        u309.Visible = false;
        pcall(function() -- Line: 1664
            -- upvalues: u309 (copy)
            u309.Active = true;
        end);
        pcall(function() -- Line: 1665
            -- upvalues: u309 (copy)
            u309.AutoButtonColor = true;
        end);
        pcall(function() -- Line: 1666
            -- upvalues: u309 (copy)
            u309.BackgroundColor3 = Color3.fromRGB(220, 55, 55);
        end);
        local ColorSequence_new_ret = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 110, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 35, 35)) });

        for _, child in ipairs(u309:GetChildren()) do
            if child:IsA("UIGradient") then
                child.Color = ColorSequence_new_ret;
            elseif child:IsA("UIStroke") then
                child.Color = Color3.fromRGB(110, 20, 20);
            end;
        end;

        local Title = u309:FindFirstChild("Title");

        if Title and Title:IsA("TextLabel") then
            Title.Text = "Exit Dungeon";
            Title.TextColor3 = Color3.fromRGB(255, 255, 255);
            local v310 = Title:FindFirstChildOfClass("UIStroke");

            if v310 then
                v310.Thickness = math.max(v310.Thickness, 3);
                v310.Color = Color3.fromRGB(0, 0, 0);
            end;

            local TextShadow = Title:FindFirstChild("TextShadow");

            if TextShadow and TextShadow:IsA("TextLabel") then
                TextShadow.Text = "Exit Dungeon";
            end;
        end;

        local ParticipateHoverScale = u309:FindFirstChild("ParticipateHoverScale");

        if ParticipateHoverScale then
            ParticipateHoverScale:Destroy();
        end;

        u309.Parent = WaspWaveSurvivalUI;
        u26 = u309;
        local UIScale = Instance.new("UIScale");
        UIScale.Name = "ExitHoverScale";
        UIScale.Scale = 1;
        UIScale.Parent = u309;
        local TweenInfo_new_ret = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        u309.MouseEnter:Connect(function() -- Line: 1706
            -- upvalues: TweenService (ref), UIScale (copy), TweenInfo_new_ret (copy)
            TweenService:Create(UIScale, TweenInfo_new_ret, {
                Scale = 1.1
            }):Play();
        end);
        u309.MouseLeave:Connect(function() -- Line: 1709
            -- upvalues: TweenService (ref), UIScale (copy), TweenInfo_new_ret (copy)
            TweenService:Create(UIScale, TweenInfo_new_ret, {
                Scale = 1
            }):Play();
        end);
        ConnectClick(u309, function() -- Line: 1713
            -- upvalues: u49 (ref), u33 (ref), HasAnyLiveBee (ref), u37 (ref), ConfirmationPromptController (ref), RequestExit (ref)
            if not u49 then
                return;
            end;

            if u33 ~= nil then
                return;
            end;

            if not HasAnyLiveBee() then
                return;
            end;

            if u37 then
                return;
            end;

            u37 = true;
            ConfirmationPromptController:Open({
                Title = "Exit Dungeon",
                Header = "Are you sure you want to leave the dungeon?",
                Middle = "You\'ll forfeit your progress in this run.",
                Footer = ""
            }, {
                ConfirmCallback = function() -- Line: 1727, Name: ConfirmCallback
                    -- upvalues: u37 (ref), RequestExit (ref)
                    u37 = false;
                    RequestExit:FireServer();
                end,

                RejectCallback = function() -- Line: 1731, Name: RejectCallback
                    -- upvalues: u37 (ref)
                    u37 = false;
                end
            });
        end);
    end)();
    BuildConclusionPanel();

    if Victory then
        Victory:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 2053
            -- upvalues: Victory (ref), u40 (ref), u42 (ref), u41 (ref), RunService (ref), fireAutoTrigger (copy)
            if not Victory.Visible then
                if u42 then
                    u42:Disconnect();
                    u42 = nil;
                end;

                if u40 then
                    u40.Visible = false;
                end;

                return;
            end;

            local u311 = Victory;
            u40 = u311:FindFirstChild("AutoClaimTimer") or u40;

            if u42 then
                return;
            end;

            u41 = os.clock();
            u42 = RunService.Heartbeat:Connect(function() -- Line: 1782
                -- upvalues: u311 (copy), u42 (ref), u40 (ref), u41 (ref), fireAutoTrigger (ref)
                if not u311.Visible then
                    if u42 then
                        u42:Disconnect();
                        u42 = nil;
                    end;

                    if u40 then
                        u40.Visible = false;
                    end;

                    return;
                end;

                local v312 = os.clock() - u41;

                if v312 < 30 then
                    if u40 then
                        local math_ceil_ret = math.ceil(30 - v312);
                        local math_max_ret = math.max(0, math_ceil_ret);
                        u40.Text = string.format("Auto Claiming & Exiting Dungeon in %d %s", math_max_ret, math_max_ret == 1 and "Second" or "Seconds");
                        u40.Visible = true;
                    end;

                    return;
                end;

                u41 = os.clock();

                if u40 then
                    u40.Visible = false;
                end;

                fireAutoTrigger();
            end);
        end);
    end;

    WaveProgress:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 2062
        -- upvalues: u282 (ref), SyncExitDungeonUI (copy)
        u282();
        SyncExitDungeonUI();
    end);
    u282();
    SyncExitDungeonUI();
    BeeColonyStateController.OnBeeStateUpdate:Connect(function(p313: string) -- Line: 2071
        -- upvalues: LocalPlayer (ref), SyncExitDungeonUI (copy)
        if p313 == `Player_{LocalPlayer.UserId}` then
            SyncExitDungeonUI();
        end;
    end);
    u1._SyncConclusionUI = SyncExitDungeonUI;
    u21.Visible = false;
    ConnectClick(u24, OnParticipateClicked);
    ConnectClick(u25, CloseParticipation);
    SetupParticipateHoverGrow();
    local Config = GameConfigController:GetConfig("WaspWaveSurvival_EndsAtUnix");
    local v314 = tonumber(Config) or 0;

    if v314 > 0 then
        local _ = v314 <= os.time();
    end;

    task.spawn(function() -- Line: 2094
        -- upvalues: GameConfigController (ref), FormatRemaining (ref), u22 (ref), u23 (ref)
        while true do
            local Config2 = GameConfigController:GetConfig("WaspWaveSurvival_EndsAtUnix");
            local v315 = tonumber(Config2) or 0;
            local v316 = v315 - os.time();
            local v317 = FormatRemaining(v316);

            if u22 then
                u22.Text = v317;
            end;

            if u23 then
                u23.Text = v317;
            end;

            if v315 > 0 then
                local _ = v316 <= 0;
            end;

            task.wait(1);
        end;
    end);
    task.spawn(function() -- Line: 2107
        -- upvalues: GetState (ref), ApplyRunStateSnapshot (ref), ApplyPortalSnapshot (ref), u60 (ref), UpdateParticipateButton (ref), UpdateStatsDisplay (ref)
        local success, result = pcall(function() -- Line: 2108
            -- upvalues: GetState (ref)
            return GetState:InvokeServer();
        end);

        if not (success and result) then
            UpdateStatsDisplay();

            return;
        end;

        ApplyRunStateSnapshot(result);
        ApplyPortalSnapshot(result);
        local v318 = tonumber(result.DefeatLockoutRemaining);

        if v318 then
            u60 = math.max(0, v318);
        end;

        UpdateParticipateButton();
    end);
    u73 = SaveSlotController:GetCurrentSaveSlot();
    SaveSlotController:GetSaveSlotChangeSignal():Connect(function() -- Line: 2127
        -- upvalues: u73 (ref), SaveSlotController (ref)
        u73 = SaveSlotController:GetCurrentSaveSlot();
    end);
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(p319, p320, p321) -- Line: 2132
        -- upvalues: LocalPlayer (ref), PurchaseID (ref), u66 (ref), u63 (ref), u62 (ref), u65 (ref), UpdateParticipateButton (ref), SetPortalTimerText (ref), u61 (ref), u7 (ref), Notification (ref)
        if p319 ~= LocalPlayer.UserId then
            return;
        end;

        if p320 ~= PurchaseID then
            return;
        end;

        if not p321 then
            return;
        end;

        u66 = true;
        u63 = 0;
        u62 = true;
        u65 = false;
        UpdateParticipateButton();
        local v322;

        if u66 then
            v322 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
        else
            v322 = nil;
        end;

        SetPortalTimerText(v322);

        if u7 then
            return;
        end;

        u7 = true;
        Notification:CreateNotification("The portal is ready. You can enter the dungeon now.");
    end);
    StateChanged.OnClientEvent:Connect(function(p323) -- Line: 2146
        -- upvalues: u51 (ref), ApplyRunStateSnapshot (ref), u49 (ref), u54 (ref), u55 (ref), u50 (ref), u53 (ref), u56 (ref), u57 (ref), u41 (ref), u33 (ref), u34 (ref), u35 (ref), u5 (ref), PopulateVictoryRewards (ref), u1 (ref), u36 (ref), CondenseRewards (ref), u74 (ref), SettingsService (ref), u60 (ref), UpdateParticipateButton (ref), UpdateStatsDisplay (ref), UpdateWaspWaveSurvivalUI (ref)
        if typeof(p323) ~= "table" then
            return;
        end;

        if p323.MaxWaves then
            u51 = p323.MaxWaves;
        end;

        if p323.Type == "RunStateUpdate" then
            ApplyRunStateSnapshot(p323);

            return;
        end;

        if p323.Type == "Preparing" then
            u49 = true;
            u54 = "Preparing";
            u55 = p323.StartsAt or workspace:GetServerTimeNow() + (p323.StartDelay or 0);
            u50 = p323.Wave or 0;
            u53 = 0;
            u56 = 0;
            u57 = 0;
        elseif p323.Type == "Started" then
            u49 = true;
            u54 = "Running";
            u55 = 0;
            u53 = p323.StartedAt or workspace:GetServerTimeNow();
            u50 = p323.Wave or u50;
            u56 = p323.ActiveWasps or 0;
            u57 = p323.MaxWasps or 0;
        elseif p323.Type == "WaveStarted" then
            u49 = true;
            u54 = "Running";
            u50 = p323.Wave or u50;
            u55 = 0;
            u56 = p323.ActiveWasps or 0;
            u57 = p323.MaxWasps or u57;
        elseif p323.Type == "WaveCleared" then
            u56 = 0;
            u57 = p323.MaxWasps or u57;
        elseif p323.Type == "RunVictory" then
            u41 = os.clock();

            if u33 == nil then
                u33 = "Victory";
                u34 = p323.WavesCleared or u51;
                u35 = false;
            end;

            u5 = p323.GrantedRewards or {};
            PopulateVictoryRewards(u5);

            if u1._SyncConclusionUI then
                u1._SyncConclusionUI();
            end;
        elseif p323.Type == "Claimed" then
            u35 = true;
            u36 = CondenseRewards(p323.GrantedRewards or {});
            u41 = os.clock();

            if u1._SyncConclusionUI then
                u1._SyncConclusionUI();
            end;
        elseif p323.Type == "Ended" then
            if u74 ~= nil then
                SettingsService:SetSetting("BeeColonyFollowPlayer", u74);
                u74 = nil;
            end;

            u49 = false;
            u54 = nil;
            u55 = 0;
            u56 = 0;
            u57 = 0;
            local v324 = tonumber(p323.DefeatLockoutRemaining);

            if v324 then
                u60 = math.max(0, v324);
                UpdateParticipateButton();
            end;

            if p323.GrantedRewards and #p323.GrantedRewards > 0 then
                u36 = CondenseRewards(p323.GrantedRewards);

                if u1._SyncConclusionUI then
                    u1._SyncConclusionUI();
                end;
            end;
        end;

        UpdateStatsDisplay();
        UpdateWaspWaveSurvivalUI();
    end);
    task.spawn(function() -- Line: 2223
        -- upvalues: UpdateStatsDisplay (ref), UpdateWaspWaveSurvivalUI (ref), u61 (ref), u62 (ref), u63 (ref), u7 (ref), Notification (ref), u64 (ref), SetPortalTimerText (ref), u66 (ref), u65 (ref), u60 (ref), UpdateParticipateButton (ref), FetchEventScheduleFromServer (ref), SyncExitDungeonUI (copy)
        local v325 = 0;

        while true do
            UpdateStatsDisplay();
            UpdateWaspWaveSurvivalUI();
            local v326 = u61 and not u62;
            local v327 = false;

            if u61 and not u62 then
                u63 = math.max(0, u63 - 1);

                if u63 <= 0 then
                    u62 = true;

                    if v326 and not u7 then
                        u7 = true;
                        Notification:CreateNotification("The portal is ready. You can enter the dungeon now.");
                        v327 = v326;
                    else
                        v327 = v326;
                    end;
                end;
            elseif not u61 and u64 > 0 then
                u64 = math.max(0, u64 - 1);
            end;

            local v328;

            if u66 then
                v328 = u62 and "READY" or (u61 and "PORTAL IGNITED" or (u65 and "READY FOR IGNITION" or nil));
            else
                v328 = nil;
            end;

            SetPortalTimerText(v328);

            if u60 > 0 then
                u60 = math.max(0, u60 - 1);
                UpdateParticipateButton();
            end;

            v325 = v325 + 1;

            if v325 >= 8 or v327 then
                task.spawn(function() -- Line: 2257
                    -- upvalues: FetchEventScheduleFromServer (ref), UpdateParticipateButton (ref)
                    FetchEventScheduleFromServer();
                    UpdateParticipateButton();
                end);
                v325 = 0;
            end;

            UpdateParticipateButton();
            SyncExitDungeonUI();
            task.wait(1);
        end;
    end);
    CreateTagHandler({
        Tag = "WaspWaveDebug",

        OnInstanceAdded = function(u329: userdata) -- Line: 2271, Name: OnInstanceAdded
            -- upvalues: Trove (ref), u1 (ref), u21 (ref), ConfirmationPromptController (ref), u20 (ref), UpdateParticipateButton (ref)
            local v330 = Trove.new();
            v330:Add(function() -- Line: 2273
                -- upvalues: u1 (ref), u329 (copy)
                u1.States[u329] = nil;
            end);
            u1.States[u329] = v330;
            local v331 = v330:Add(Instance.new("ProximityPrompt"));
            v331.RequiresLineOfSight = false;
            v331:SetAttribute("Theme", "ShadowedPrompt");
            v331.Style = Enum.ProximityPromptStyle.Custom;
            v331.ActionText = "Enter";
            v331.ObjectText = "Wasp Dungeon";
            v331.Parent = u329;
            local u332 = v330:Add(Instance.new("Sound"));
            u332.SoundId = "rbxassetid://75916878082729";
            u332.Looped = true;
            u332.RollOffMaxDistance = 80;
            u332.RollOffMinDistance = 15;
            u332.RollOffMode = Enum.RollOffMode.InverseTapered;
            u332.Parent = u329;
            v330:Add(u329.AncestryChanged:Connect(function() -- Line: 2297
                -- upvalues: u329 (copy), u332 (copy)
                if u329:IsDescendantOf(workspace) then
                    u332:Play();

                    return;
                end;

                u332:Stop();
            end));
            v331.Triggered:Connect(function() -- Line: 2305
                -- upvalues: u21 (ref), ConfirmationPromptController (ref), u20 (ref), UpdateParticipateButton (ref)
                warn("[WaspWaveSurvival] Prompt triggered -> OpenParticipation");

                if not u21 then
                    warn("[WaspWaveSurvival] OpenParticipation no-op: Participation = nil");

                    return;
                end;

                ConfirmationPromptController:Close();

                if u20 then
                    u20.Enabled = true;
                end;

                u21.Visible = true;
                UpdateParticipateButton();
            end);
        end,

        OnInstanceRemoved = function(p333: userdata) -- Line: 2310, Name: OnInstanceRemoved
            -- upvalues: u1 (ref)
            if u1.States[p333] then
                u1.States[p333]:Clean();
            end;
        end
    });
end;

task.spawn(u1.Start);

return u1;