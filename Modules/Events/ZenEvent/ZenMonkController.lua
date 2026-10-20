-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
local Players = game:GetService("Players");
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
require(ReplicatedStorage.Modules.UpdateService);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Modules.Observers);
require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Code.Spr);
require(ReplicatedStorage.Code.Bezier_2);
require(ReplicatedStorage.Data.DefaultData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local ZenEventTreeController = require(ReplicatedStorage.Modules.Events.ZenEvent.ZenEventTreeController);
local u1 = Trove.new();
local Config = GameConfigController:GetConfig("ZenEventConfig");
local ZenProgressData = Config.ZenProgressData;
local ZenTreeData = Config.ZenTreeData;
workspace:GetAttributeChangedSignal("ZenEventConfig"):Connect(function() -- Line: 29
    -- upvalues: Config (ref), GameConfigController (copy), ZenProgressData (ref), ZenTreeData (ref)
    Config = GameConfigController:GetConfig("ZenEventConfig");
    ZenProgressData = Config.ZenProgressData;
    ZenTreeData = Config.ZenTreeData;
end);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local _ = GameEvents.Events.ZenEvent.ClaimZenReward;
local _ = GameEvents.Events.ZenEvent.FoxRewardEffect;
local LocalPlayer = Players.LocalPlayer;
local u2 = {};

local function GetZenTreeData() -- Line: 45
    -- upvalues: LocalPlayer (copy), DataService (copy)
    if not LocalPlayer then
        warn("No LocalPlayer!");

        return nil;
    end;

    local Data = DataService:GetData();

    if not Data then
        warn((`No PlayerData for {LocalPlayer}!`));

        return nil;
    end;

    local ZenEventData = Data.ZenEventData;

    if not ZenEventData then
        warn((`No ZenEventData for {LocalPlayer.Name}!`));

        return nil;
    end;

    local ZenTree = ZenEventData.ZenTree;

    if ZenTree then
        return ZenTree;
    end;

    warn((`No ZenTree for {LocalPlayer.Name}!`));

    return nil;
end;

local function UpdateUI() -- Line: 60
    -- upvalues: GetZenTreeData (copy), CollectionService (copy), Config (ref), CountDictionary (copy), FastTween (copy)
    local v3 = GetZenTreeData();

    if not v3 then
        return;
    end;

    local v4 = CollectionService:GetTagged("ZenPlatform")[1];
    local UpgradeBar = v4:FindFirstChild("UpgradeBar", true);
    local UpgradeLabel = v4:FindFirstChild("UpgradeLabel", true);
    local ProgressionLabel = UpgradeBar:FindFirstChild("ProgressionLabel", true);
    local LEVEL_PLANT_VALUE_REQUIREMENTS = Config.ZenTreeData.LEVEL_PLANT_VALUE_REQUIREMENTS;

    if v3.CurrentTreeLevel >= CountDictionary(LEVEL_PLANT_VALUE_REQUIREMENTS) and UpgradeLabel then
        UpgradeLabel.Text = "Max Level";
    end;

    local SubmittedPlantsValue = v3.SubmittedPlantsValue;
    local v5 = LEVEL_PLANT_VALUE_REQUIREMENTS[v3.CurrentTreeLevel + 1] or LEVEL_PLANT_VALUE_REQUIREMENTS[v3.CurrentTreeLevel];
    ProgressionLabel.Text = `{math.floor(SubmittedPlantsValue)}/{v5} Zen`;
    local v6 = math.floor(SubmittedPlantsValue) / v5;
    local math_clamp_ret = math.clamp(v6, 0, 1);
    FastTween(UpgradeBar:FindFirstChild("Fill"), TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(math_clamp_ret, 1)
    });
    CollectionService:GetTagged("StageSignText")[1].Text = `Stage {v3.CurrentTreeLevel}`;
end;

function u2.Start(p7) -- Line: 88
    -- upvalues: CollectionService (copy), EventRotationController (copy), EventRotationUtils (copy), u1 (copy), DataService (copy), GetZenTreeData (copy), Notification (copy), ZenEventTreeController (copy), UpdateUI (copy)
    local ZenTree = CollectionService:GetTagged("ZenEventModel")[1]:FindFirstChild("ZenTree");
    ZenTree:FindFirstChild("GrowEffects");
    local LoadedEvent = EventRotationController:GetLoadedEvent();

    if not LoadedEvent then
        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(LoadedEvent.EventID, LoadedEvent.EventSet);

    if EventInSetIndex and EventInSetIndex >= 2 then
        EventRotationUtils:GetEventIDModels("ZenEventPart2")[1]:FindFirstChild("CorruptZenTree");
    end;

    local v8 = CollectionService:GetTagged("ZenChanneller")[1];
    v8:FindFirstChild("ZenQuestProximityPrompt", true);
    v8:GetPivot();
    local PathSignal = DataService:GetPathSignal("ZenEventData/ZenTree/CurrentTreeLevel");
    u1:Add(assert(PathSignal, "Failed to listen for Quest Containers"):Connect(function(...) -- Line: 110
        -- upvalues: GetZenTreeData (ref), ZenTree (copy), Notification (ref), ZenEventTreeController (ref), UpdateUI (ref)
        local v9 = GetZenTreeData();

        if not v9 then
            return;
        end;

        if v9.CurrentTreeLevel <= 0 then
            ZenTree.Parent = script;

            return;
        end;

        task.delay(1.5, function() -- Line: 118
            -- upvalues: Notification (ref)
            Notification:CreateNotification("The Zen Tree is growing");
        end);
        ZenEventTreeController:Run(false);
        UpdateUI();
    end));
    local PathSignal2 = DataService:GetPathSignal("ZenEventData/ZenTree/SubmittedPlantsValue");
    u1:Add(assert(PathSignal2, "Failed to listen for Quest Containers"):Connect(function() -- Line: 126
        -- upvalues: GetZenTreeData (ref), UpdateUI (ref)
        if not GetZenTreeData() then
            return;
        end;

        UpdateUI();
    end));
    local PathSignal3 = DataService:GetPathSignal("ZenEventData/ZenTree/SubmittedPlantsValue");
    u1:Add(assert(PathSignal3, "Failed to listen for Quest Containers"):Connect(function() -- Line: 132
        -- upvalues: GetZenTreeData (ref), UpdateUI (ref)
        if not GetZenTreeData() then
            return;
        end;

        UpdateUI();
    end));
    u1:Add(ZenTree.AncestryChanged:Connect(function() -- Line: 137
        -- upvalues: ZenEventTreeController (ref)
        ZenEventTreeController:Run(false);
    end));
    task.wait(1);
    task.spawn(function() -- Line: 145
        -- upvalues: ZenEventTreeController (ref)
        ZenEventTreeController:SetupZenTree();
        ZenEventTreeController:Run(false);
    end);
    task.spawn(UpdateUI);
end;

local u10 = false;
EventRotationController.EventUpdated:Connect(function(p11: string, p12: string) -- Line: 155, Name: OnEventUpdated
    -- upvalues: u1 (copy), u10 (ref), u2 (copy)
    if p12 ~= "ZenEvent" then
        u1:Clean();
        u10 = false;

        return;
    end;

    if u10 then
        return;
    end;

    u10 = true;
    u1:Clean();
    task.spawn(u2.Start, u2);
end);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent and LoadedEvent.EventSet == "ZenEvent" then
    local _ = LoadedEvent.EventID;

    if LoadedEvent.EventSet == "ZenEvent" then
        if not u10 then
            u10 = true;
            u1:Clean();
            task.spawn(u2.Start, u2);
        end;
    else
        u1:Clean();
        u10 = false;
    end;
end;

return u2;