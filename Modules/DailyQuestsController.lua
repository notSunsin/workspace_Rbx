-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Trove);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.GuiController);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
local ImageCycle = require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Modules.GiveServiceCommon);
local GGButtonEffects = require(ReplicatedStorage.Modules.GardenGuideModules.GGButtonEffects);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local RandomSeedRewardUIController = require(ReplicatedStorage.Modules.RandomSeedRewardUIController);
local LocalPlayer = Players.LocalPlayer;
local GardenGuide = LocalPlayer.PlayerGui:WaitForChild("GardenGuide");
local DailyQuestView = GardenGuide.MainMenu.MainMenuFrame.DailyQuestView;
local Main = DailyQuestView.Main;
local Main2 = Main.Quests.Main;
local Progress = Main.Progress;
local TopBar = GardenGuide.MainMenu.TopBar;
require(ReplicatedStorage.Modules.IsDev);
local SkipQuests = TopBar.SkipQuests;
local DailyQuestTemplates = ReplicatedStorage.Modules.GardenGuideModules.Templates.DailyQuestTemplates;
local RewardFrame = DailyQuestTemplates.RewardFrame;
local Line = DailyQuestTemplates.Line;
local DailyQuestTemplate = DailyQuestTemplates.DailyQuestTemplate;
local OddsButton = DailyQuestTemplates.OddsButton;
local InfoButton = DailyQuestTemplates.InfoButton;
local u1 = {};
local v2 = {};

local function getCurrentDay(p3: number) -- Line: 58
    return (p3 + 14400) // 86400;
end;

local function getResetTime(p4: number) -- Line: 62
    return ((p4 + 14400) // 86400 + 1) * 86400 - 14400;
end;

local function areDailiesComplete() -- Line: 67
    -- upvalues: DataService (copy), QuestsController (copy)
    local Data = DataService:GetData();

    if Data then
        local _ = Data.DailyQuests.DaysCompleted;
        local ContainerFromId = QuestsController:GetContainerFromId(Data.DailyQuests.ContainerId);

        if ContainerFromId == nil then
            return true;
        end;

        if #ContainerFromId.Quests <= 0 then
            return true;
        end;

        for _, v in ContainerFromId.Quests do
            if v.Completed == false then
                return false;
            end;
        end;

        return true;
    end;
end;

local function robuxSkipQuests() -- Line: 89
    -- upvalues: GGButtonEffects (copy), areDailiesComplete (copy), MarketController (copy), DevProductIds (copy)
    GGButtonEffects.Click();

    if areDailiesComplete() then
        warn("Trying to skip dailies when they are already complete. Aborting");

        return;
    end;

    MarketController:PromptPurchase(DevProductIds.SkipDailyQuest.PurchaseID, Enum.InfoType.Product);
end;

local u5 = false;

function v2.Start(p6) -- Line: 100
    -- upvalues: SkipQuests (copy), areDailiesComplete (copy), DailyQuestView (copy), robuxSkipQuests (copy), SeedPackOddsController (copy), GardenGuide (copy), RandomSeedRewardUIController (copy), ImageCycle (copy), u1 (copy), ReplicatedStorage (copy), DataService (copy), QuestsController (copy), DailyQuestTemplate (copy), Main2 (copy), LocalPlayer (copy), Progress (copy), Line (copy), RewardFrame (copy), OddsButton (copy), InfoButton (copy), Main (copy), u5 (ref), TopBar (copy), NumberUtil (copy)
    local u7 = {};
    local u8 = {};

    local function updateRobuxSkipQuestsButton() -- Line: 105
        -- upvalues: SkipQuests (ref), areDailiesComplete (ref), DailyQuestView (ref)
        local v9 = not areDailiesComplete() and DailyQuestView.Visible;
        SkipQuests.Visible = v9;
    end;

    SkipQuests.SENSOR.Activated:Connect(robuxSkipQuests);

    local function removeQuestFromRender(p10) -- Line: 111
        -- upvalues: u7 (copy)
        local v11 = u7[p10];

        if v11 then
            v11:Destroy();
            u7[p10] = nil;
        end;
    end;

    local function setupRewardButton(p12, p13, u14) -- Line: 120
        -- upvalues: SeedPackOddsController (ref), GardenGuide (ref), RandomSeedRewardUIController (ref), ImageCycle (ref), u1 (ref), ReplicatedStorage (ref)
        local REWARD_IMAGE = p12.REWARD_IMAGE;
        local REWARD_NAME = p12.ITEM_NAME.REWARD_NAME;
        local REWARD_NAME_SHADOW = p12.ITEM_NAME.REWARD_NAME_SHADOW;
        p12.Visible = false;
        local u15 = {};

        for _, v in p13 do
            if v.Type then
                if REWARD_IMAGE then
                    table.insert(u15, {
                        Quantity = v.Data.Amount or 1,
                        Type = v.Type,
                        Value = v.Data.Type or "Normal"
                    });
                end;
            else
                warn("No reward type");
            end;
        end;

        local OddsButton2 = p12:FindFirstChild("OddsButton");

        if OddsButton2 then
            if u15[1] then
                local u16 = OddsButton2.Activated:Connect(function() -- Line: 144
                    -- upvalues: SeedPackOddsController (ref), u15 (copy), GardenGuide (ref)
                    SeedPackOddsController:Open(u15[1].Value, GardenGuide);
                end);
                OddsButton2.Destroying:Once(function() -- Line: 147
                    -- upvalues: u16 (ref)
                    if not u16 then
                        return;
                    end;

                    u16:Disconnect();
                    u16 = nil;
                end);
            else
                OddsButton2.Visible = false;
            end;
        end;

        local InfoButton2 = p12:FindFirstChild("InfoButton");

        if InfoButton2 then
            local u17 = InfoButton2.Activated:Connect(function() -- Line: 160
                -- upvalues: RandomSeedRewardUIController (ref), GardenGuide (ref)
                RandomSeedRewardUIController:Open(GardenGuide);
            end);
            InfoButton2.Destroying:Once(function() -- Line: 163
                -- upvalues: u17 (ref)
                if not u17 then
                    return;
                end;

                u17:Disconnect();
                u17 = nil;
            end);
        end;

        ImageCycle.CycleRewardImages(REWARD_IMAGE, REWARD_NAME, REWARD_NAME_SHADOW, p12, u15);
        p12.Visible = true;
        p12:FindFirstChild("ClaimedOverlay");
        local SENSOR = p12.SENSOR;

        if not u1[`Day{u14}Reward`] then
            local u18 = SENSOR.Activated:Connect(function() -- Line: 177
                -- upvalues: ReplicatedStorage (ref), u14 (copy)
                ReplicatedStorage.GameEvents.DailyQuests.Claim:FireServer(u14);
            end);
            u1[`Day{u14}Reward`] = u18;
            SENSOR.Destroying:Once(function() -- Line: 181
                -- upvalues: u18 (ref)
                if not u18 then
                    return;
                end;

                u18:Disconnect();
                u18 = nil;
            end);
        end;
    end;

    local function updateQuests() -- Line: 189
        -- upvalues: DataService (ref), u7 (copy), QuestsController (ref), DailyQuestTemplate (ref), Main2 (ref), LocalPlayer (ref), Progress (ref), Line (ref), u8 (copy), RewardFrame (ref), OddsButton (ref), InfoButton (ref), setupRewardButton (copy), Main (ref), SkipQuests (ref), areDailiesComplete (ref), DailyQuestView (ref), u5 (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        if not (Data.DailyQuests and Data.DailyQuests.ContainerId) then
            for i in u7 do
                local v19 = u7[i];

                if v19 then
                    v19:Destroy();
                    u7[i] = nil;
                end;
            end;

            table.clear(u7);

            return;
        end;

        local ContainerFromId = QuestsController:GetContainerFromId(Data.DailyQuests.ContainerId);

        if not ContainerFromId then
            return;
        end;

        local v20 = true;

        for i, v in ContainerFromId.Quests do
            if not v.Completed then
                v20 = false;
            end;

            local Quest = QuestsController:GetQuest(v.Type);

            if Quest then
                local v21 = u7[v.Id];

                if not v21 then
                    v21 = DailyQuestTemplate:Clone();
                    v21.Visible = true;
                    v21.LayoutOrder = i + 1;
                    v21.Parent = Main2;
                    u7[v.Id] = v21;
                end;

                local v22 = Quest:Display(v.Progress, v.Target, v.Arguments);
                v21.Main.QUEST_NAME.Text = v22.Title;
                v21.Main.QUEST_NAME_SHADOW.Text = v22.Title;

                if v22.Description then
                    v21.Main.QUEST_OBJECTIVE.Text = v22.Description;
                    v21.Main.QUEST_OBJECTIVE_SHADOW.Text = v22.Description;
                end;

                v21.Main.Progress.Bar_Actual.Size = UDim2.fromScale(math.clamp(v.Progress / v.Target, 0, 1), 1);
                v21.Main.Progress.VALUE.Text = v.Progress >= v.Target and "Completed!" or v22.Bar;
                v21.Main.Progress.VALUE_SHADOW.Text = v.Progress >= v.Target and "Completed!" or v22.Bar;
            end;
        end;

        for i in u7 do
            local v23 = i;
            local v24 = false;

            for _, v in ContainerFromId.Quests do
                if v.Id == v23 then
                    v24 = true;
                    break;
                end;
            end;

            if not v24 then
                local v25 = u7[v23];

                if v25 then
                    v25:Destroy();
                    u7[v23] = nil;
                end;
            end;
        end;

        if not Data.DailyQuests then
            warn((`No dailyquest data for player {LocalPlayer}`));

            return;
        end;

        local DailyRewards = Data.DailyQuests.DailyRewards;
        local v26 = #DailyRewards - 1;
        local Rewards = Progress.Rewards;
        local IncrementLines = Progress.ProgressBar.IncrementLines;

        if IncrementLines.AbsoluteSize.X == 0 then
            IncrementLines:GetPropertyChangedSignal("AbsoluteSize"):Wait();
        end;

        local X = Line.AbsoluteSize.X;
        local v27 = math.abs(X * v26 - IncrementLines.AbsoluteSize.X * 0.85) / #DailyRewards;

        if #IncrementLines:GetChildren() <= v26 then
            local v28 = 0;

            for i = 1, v26 do
                local v29;

                if u8[`RewardFrameDay{i}`] then
                    v29 = i;
                else
                    local v30 = Line:Clone();
                    v30.Visible = true;
                    v28 = v28 + v27 + X * 0.5;
                    local v31 = v28 / IncrementLines.AbsoluteSize.X;
                    v30.Position = UDim2.fromScale(v31, 0);
                    v30.Parent = IncrementLines;
                    local v32 = RewardFrame:Clone();
                    v32.Visible = true;
                    v32.Position = UDim2.fromScale(v31, v32.Position.Y.Scale);
                    v32.Name = `RewardFrameDay{i}`;
                    v32.Parent = Rewards;
                    u8[v32.Name] = v32;
                    local Rewards2 = DailyRewards[i].Rewards;

                    if Rewards2[1].Type == "Seed Pack" then
                        OddsButton:Clone().Parent = v32;
                    elseif Rewards2[1].Type == "RandomSeed" then
                        InfoButton:Clone().Parent = v32;
                    end;

                    setupRewardButton(v32, Rewards2, i);
                    v29 = i;
                end;
            end;

            if not u8.BigRewardFrame then
                local v33 = v26 + 1;
                local Rewards2 = DailyRewards[v33].Rewards;
                local BigRewardFrame = Rewards:FindFirstChild("BigRewardFrame");
                u8.BigRewardFrame = BigRewardFrame;

                if Rewards2[1].Type == "Seed Pack" then
                    OddsButton:Clone().Parent = BigRewardFrame;
                elseif Rewards2[1].Type == "RandomSeed" then
                    InfoButton:Clone().Parent = BigRewardFrame;
                end;

                setupRewardButton(BigRewardFrame, Rewards2, v33);
            end;
        end;

        local DaysCompleted = Data.DailyQuests.DaysCompleted;
        Main.Progress.ProgressBar.Bar_Actual.Size = UDim2.fromScale(math.clamp(DaysCompleted / #DailyRewards, 0, 1), 1);

        for i = 1, #DailyRewards do
            local v34;

            if i == 7 then
                v34 = Rewards:FindFirstChild("BigRewardFrame");
            else
                v34 = Rewards:FindFirstChild((`RewardFrameDay{i}`));
            end;

            local SENSOR = v34.SENSOR;
            local ClaimedOverlay = v34:FindFirstChild("ClaimedOverlay");
            local HiddenOverlay = v34:FindFirstChild("HiddenOverlay");
            task.spawn(function() -- Line: 347
                -- upvalues: HiddenOverlay (copy), i (copy), DaysCompleted (copy), SENSOR (copy), DailyRewards (copy), ClaimedOverlay (copy)
                task.wait();
                HiddenOverlay.Visible = DaysCompleted < i;
                local v35;

                if i <= DaysCompleted then
                    v35 = not DailyRewards[i].Claimed;
                else
                    v35 = false;
                end;

                SENSOR.Visible = v35;
                local v36;

                if i <= DaysCompleted then
                    v36 = DailyRewards[i].Claimed;
                else
                    v36 = false;
                end;

                ClaimedOverlay.Visible = v36;
            end);
            local _ = i;
        end;

        local v37 = not areDailiesComplete() and DailyQuestView.Visible;
        SkipQuests.Visible = v37;

        if not Data.DailyQuests.DailyRewards[DaysCompleted] then
            return;
        end;

        if not v20 or (Data.DailyQuests.DailyRewards[DaysCompleted].Claimed or (u5 or LocalPlayer:GetAttribute("FirstTimePlayer"))) then
            if not v20 then
                u5 = false;
            end;

            return;
        end;

        u5 = true;
        require(game.ReplicatedStorage.Modules.Notification):CreateNotification("Daily Quests complete! You can now claim your prize!");
    end;

    DailyQuestView:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 367
        -- upvalues: TopBar (ref), DailyQuestView (ref), SkipQuests (ref), areDailiesComplete (ref)
        TopBar.DailyQuestTimer.Visible = DailyQuestView.Visible;
        local v38 = not areDailiesComplete() and DailyQuestView.Visible;
        SkipQuests.Visible = v38;
    end);
    task.spawn(updateQuests);
    local PathSignal = DataService:GetPathSignal("DailyQuests/@");
    assert(PathSignal, "Failed to listen for Daily Quests"):Connect(updateQuests);
    local PathSignal2 = DataService:GetPathSignal("QuestContainers/@");
    assert(PathSignal2, "Failed to listen for Quest Containers"):Connect(updateQuests);
    task.spawn(function() -- Line: 376
        -- upvalues: TopBar (ref), NumberUtil (ref)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v39 = ((ServerTimeNow + 14400) // 86400 + 1) * 86400 - 14400;
            TopBar.DailyQuestTimer.TIME_REMAINING.Text = `Daily quests reset in {NumberUtil.compactFormat(v39 - ServerTimeNow)}`;
            TopBar.DailyQuestTimer.TIME_REMAINING_SHADOW.Text = `Daily quests reset in {NumberUtil.compactFormat(v39 - ServerTimeNow)}`;
            task.wait(1);
        end;
    end);
end;

task.spawn(v2.Start, v2);

return v2;