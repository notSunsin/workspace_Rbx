-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local GardenLevelData = require(ReplicatedStorage.Data.GardenLevel.GardenLevelData);
local GardenLevelRewardData = require(ReplicatedStorage.Data.GardenLevel.GardenLevelRewardData);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local Data = DataService:GetData();
local PlayerStatsView = Players.LocalPlayer.PlayerGui.GardenGuide.MainMenu.MainMenuFrame.PlayerStatsView;
local PlayerLevelFrame = PlayerStatsView.ScrollingFrame.Main.PlayerLevelFrame;
local RewardsTracker = PlayerStatsView.ScrollingFrame.Main.RewardsTracker;
local RewardTrackItemTemplate = script.Parent.Templates.RewardTrackItemTemplate;
local v1 = {};

local function UpdateRewardsTracker() -- Line: 27
    -- upvalues: Data (copy), Players (copy), GardenLevelData (copy), RewardsTracker (copy), GardenLevelRewardData (copy)
    if not Data then
        warn((`No player data for {Players.LocalPlayer}`));

        return;
    end;

    local v2 = GardenLevelData.CalculateLevel(Data.GardenLevel.TotalExperience or 0);
    local Content = RewardsTracker.Main.ScrollingFrame.Content;

    for i, _ in GardenLevelRewardData do
        if i <= v2 then
            local v3 = Content:FindFirstChild((`{i}`));
            v3.LockedOverlay.Visible = false;
            v3.RewardedOverlay.Visible = true;
        else
            local v4 = Content:FindFirstChild((`{i}`));
            v4.LockedOverlay.Visible = true;
            v4.RewardedOverlay.Visible = false;
        end;
    end;
end;

local function UpdatePlayerXP() -- Line: 49
    -- upvalues: Data (copy), Players (copy), GardenLevelData (copy), PlayerLevelFrame (copy)
    if not Data then
        warn((`No player data for {Players.LocalPlayer}`));

        return;
    end;

    local v5 = Data.GardenLevel.TotalExperience or 0;
    local v6 = GardenLevelData.CalculateLevel(v5);
    local TotalXPForNextLevel = GardenLevelData.GetTotalXPForNextLevel(v5);
    local XPEarnedCurrentLevel = GardenLevelData.GetXPEarnedCurrentLevel(v5);
    local PlayerImage = PlayerLevelFrame.Content.PlayerImage;
    local LEVEL_VALUE_SHADOW = PlayerImage.LEVEL_VALUE_SHADOW;
    PlayerImage.LEVEL_VALUE.Text = v6;
    LEVEL_VALUE_SHADOW.Text = v6;
    local CurrentLevelDisplay = PlayerLevelFrame.Content.CurrentLevelDisplay;
    local PLAYER_LEVEL = CurrentLevelDisplay.PLAYER_LEVEL;
    local PLAYER_LEVEL_SHADOW = CurrentLevelDisplay.PLAYER_LEVEL_SHADOW;
    local v7 = `Level {v6}`;
    PLAYER_LEVEL.Text = v7;
    PLAYER_LEVEL_SHADOW.Text = v7;
    local EXP_REQUIRED = PlayerLevelFrame.Content.EXP_REQUIRED;
    local EXP_REQUIRED_SHADOW = PlayerLevelFrame.Content.EXP_REQUIRED_SHADOW;
    local v8 = `{TotalXPForNextLevel - XPEarnedCurrentLevel} XP <font transparency=".4">to the Next Level</font>`;
    EXP_REQUIRED.Text = v8;
    EXP_REQUIRED_SHADOW.Text = v8;
    local XPBar = PlayerLevelFrame.Content.XPBar;
    local Bar_Actual = XPBar.Bar_Actual;
    local PROGRESS = XPBar.PROGRESS;
    local PROGRESS_SHADOW = XPBar.PROGRESS_SHADOW;
    local v9 = `{XPEarnedCurrentLevel} / {TotalXPForNextLevel}XP`;
    Bar_Actual.Size = UDim2.fromScale(XPEarnedCurrentLevel / TotalXPForNextLevel, 1);
    PROGRESS.Text = v9;
    PROGRESS_SHADOW.Text = v9;
end;

local function CreateRewardTracker() -- Line: 83
    -- upvalues: Data (copy), Players (copy), GardenLevelData (copy), RewardsTracker (copy), GardenLevelRewardData (copy), RewardTrackItemTemplate (copy), ItemImageFinder (copy)
    if not Data then
        warn((`No player data for {Players.LocalPlayer}`));

        return;
    end;

    local v10 = GardenLevelData.CalculateLevel(Data.GardenLevel.TotalExperience or 0);
    local Content = RewardsTracker.Main.ScrollingFrame.Content;
    local v11 = {};

    for i, _ in GardenLevelRewardData do
        table.insert(v11, i);
    end;

    table.sort(v11);

    for _, v in v11 do
        local v12 = GardenLevelRewardData[v];
        local v13 = RewardTrackItemTemplate:Clone();
        v13.Name = `{v}`;
        local ItemPlayerFacingName = v12.ItemPlayerFacingName;
        v13.Main.ITEM_NAME.REWARD_NAME.Text = ItemPlayerFacingName;
        v13.Main.ITEM_NAME.REWARD_NAME_SHADOW.Text = ItemPlayerFacingName;
        v13.Main.REWARD_IMAGE.Image = ItemImageFinder(v12.ItemName, v12.ItemType);
        local LockedOverlay = v13.LockedOverlay;
        LockedOverlay.LEVEL_VALUE.Text = v;
        LockedOverlay.LEVEL_VALUE_SHADOW.Text = v;

        if v <= v10 then
            LockedOverlay.Visible = false;
            v13.RewardedOverlay.Visible = true;
        end;

        v13.Parent = Content;
    end;

    local v14 = RewardTrackItemTemplate:Clone();
    v14.Name = "?";
    v14.Main.ITEM_NAME.REWARD_NAME.Text = v14.Name;
    v14.Main.ITEM_NAME.REWARD_NAME_SHADOW.Text = v14.Name;
    local LockedOverlay = v14.LockedOverlay;
    LockedOverlay.LEVEL_VALUE.Text = v14.Name;
    LockedOverlay.LEVEL_VALUE_SHADOW.Text = v14.Name;
    LockedOverlay.SUB_TEXT.Text = "More coming soon...";
    LockedOverlay.SUB_TEXT_SHADOW.Text = "More coming soon...";
    v14.Parent = Content;
end;

function v1.CreatePlayerStatsPage() -- Line: 144
    -- upvalues: CreateRewardTracker (copy), UpdatePlayerXP (copy)
    CreateRewardTracker();
    UpdatePlayerXP();
end;

v1.CreatePlayerStatsPage();
local PathSignal = DataService:GetPathSignal("GardenLevel/TotalExperience");

if PathSignal then
    PathSignal:Connect(function() -- Line: 154
        -- upvalues: UpdatePlayerXP (copy), UpdateRewardsTracker (copy)
        UpdatePlayerXP();
        UpdateRewardsTracker();
    end);
end;

return v1;