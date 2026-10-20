-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Trove);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.GuiController);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Modules.GiveServiceCommon);
local GGButtonEffects = require(ReplicatedStorage.Modules.GardenGuideModules.GGButtonEffects);
local SeasonPassButtonEffects = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassButtonEffects);
local SeasonPassData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassData);
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
require(ReplicatedStorage.Modules.IsDev);
local SPQuestsRewardOddsController = require(ReplicatedStorage.Modules.SeasonPass.SPQuestsRewardOddsController);
local GameEvents = ReplicatedStorage.GameEvents;
local Open = GameEvents.SeedPack.Open;
local ClaimSeasonPassQuest = GameEvents.SeasonPass.ClaimSeasonPassQuest;
local SeasonPassUI = Players.LocalPlayer.PlayerGui:WaitForChild("SeasonPassUI");
local Quests = SeasonPassUI.SeasonPassFrame.Main.Quests;
local List = Quests.List;
local SkipQuests = Quests.SkipQuests;
local RollRewardsButton = Quests.RollRewardsButton;
local InfoButton = Quests.InfoButton;
local InfoFrame = Quests.InfoFrame;
local OddsButton = Quests.OddsButton;
local SeasonPassQuestTemplate = SeasonPassUI.SeasonPassTemplates.SeasonPassQuestTemplate;
local v1 = {};

local function getCurrentDay(p2: number) -- Line: 63
    return (p2 + 14400) // 86400;
end;

local function getResetTime(p3: number) -- Line: 67
    return ((p3 + 14400) // 86400 + 1) * 86400 - 14400;
end;

local function areDailiesComplete() -- Line: 72
    -- upvalues: DataService (copy), QuestsController (copy)
    local Data = DataService:GetData();

    if Data then
        local ContainerFromId = QuestsController:GetContainerFromId(Data.SeasonPassDailyQuests.ContainerId);

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

local function robuxSkipQuests() -- Line: 92
    -- upvalues: GGButtonEffects (copy), areDailiesComplete (copy), MarketController (copy), DevProductIds (copy)
    GGButtonEffects.Click();

    if areDailiesComplete() then
        warn("Trying to skip dailies when they are already complete. Aborting");

        return;
    end;

    MarketController:PromptPurchase(DevProductIds.SkipSeasonPassQuest.PurchaseID, Enum.InfoType.Product);
end;

function v1.Start(p4) -- Line: 103
    -- upvalues: DataService (copy), SeasonPassData (copy), SkipQuests (copy), areDailiesComplete (copy), Quests (copy), RollRewardsButton (copy), SeasonPassStaticData (copy), robuxSkipQuests (copy), Open (copy), InfoButton (copy), InfoFrame (copy), OddsButton (copy), SPQuestsRewardOddsController (copy), SeasonPassUI (copy), QuestsController (copy), SeasonPassQuestTemplate (copy), List (copy), SeasonPassButtonEffects (copy), ClaimSeasonPassQuest (copy), NumberUtil (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local u5 = {};

    local function updateRobuxSkipQuestsButton() -- Line: 112
        -- upvalues: SeasonPassData (ref), Data (copy), SkipQuests (ref), areDailiesComplete (ref), Quests (ref), RollRewardsButton (ref), SeasonPassStaticData (ref)
        if not SeasonPassData.CurrentSeason then
            return;
        end;

        if not Data.SeasonPass[SeasonPassData.CurrentSeason] then
            return;
        end;

        local v6 = not areDailiesComplete() and Quests.Visible;
        SkipQuests.Visible = v6;
        local QuestRewardClaimed = Data.SeasonPass[SeasonPassData.CurrentSeason].QuestRewardClaimed;
        RollRewardsButton.Visible = areDailiesComplete();

        if QuestRewardClaimed then
            local Gray = SeasonPassStaticData.ButtonColors.Gray;
            RollRewardsButton.BackgroundColor3 = Gray.Background;
            RollRewardsButton.UIStroke.Color = Gray.ButtonStroke;
            RollRewardsButton.TextLabel.UIStroke.Color = Gray.TextStroke;
            RollRewardsButton.Interactable = false;

            return;
        end;

        local Gold = SeasonPassStaticData.ButtonColors.Gold;
        RollRewardsButton.BackgroundColor3 = Gold.Background;
        RollRewardsButton.UIStroke.Color = Gold.ButtonStroke;
        RollRewardsButton.TextLabel.UIStroke.Color = Gold.TextStroke;
        RollRewardsButton.Interactable = true;
    end;

    SkipQuests.Activated:Connect(robuxSkipQuests);
    RollRewardsButton.Activated:Connect(function() -- Line: 147
        -- upvalues: areDailiesComplete (ref), Open (ref), updateRobuxSkipQuestsButton (copy)
        if areDailiesComplete() then
            Open:FireServer("Season Pass Quests");
            task.wait(2);
            updateRobuxSkipQuestsButton();
        end;
    end);
    InfoButton.Activated:Connect(function() -- Line: 155
        -- upvalues: InfoFrame (ref)
        InfoFrame.Visible = not InfoFrame.Visible;
    end);
    OddsButton.Activated:Connect(function() -- Line: 159
        -- upvalues: SPQuestsRewardOddsController (ref), SeasonPassUI (ref)
        SPQuestsRewardOddsController:Open(SeasonPassUI);
    end);

    local function removeQuestFromRender(p7) -- Line: 164
        -- upvalues: u5 (copy)
        local v8 = u5[p7];

        if v8 then
            v8:Destroy();
            u5[p7] = nil;
        end;
    end;

    local function updateQuests() -- Line: 172
        -- upvalues: SeasonPassData (ref), DataService (ref), u5 (copy), QuestsController (ref), SeasonPassQuestTemplate (ref), List (ref), SeasonPassButtonEffects (ref), ClaimSeasonPassQuest (ref), SeasonPassStaticData (ref), updateRobuxSkipQuestsButton (copy)
        if not SeasonPassData.CurrentSeason then
            return;
        end;

        local Data2 = DataService:GetData();

        if not Data2 then
            return;
        end;

        if not (Data2.SeasonPassDailyQuests and (Data2.SeasonPassDailyQuests.ContainerId and Data2.SeasonPassDailyQuests.ContainerId ~= "")) then
            for i in u5 do
                local v9 = u5[i];

                if v9 then
                    v9:Destroy();
                    u5[i] = nil;
                end;
            end;

            table.clear(u5);

            return;
        end;

        local ContainerFromId = QuestsController:GetContainerFromId(Data2.SeasonPassDailyQuests.ContainerId);

        if not ContainerFromId then
            return;
        end;

        for i, v in ContainerFromId.Quests do
            local _ = v.Completed;
            local Quest = QuestsController:GetQuest(v.Type);

            if Quest then
                local u10 = u5[v.Id];

                if not u10 then
                    u10 = SeasonPassQuestTemplate:Clone();
                    u10.Visible = true;
                    u10.LayoutOrder = i + 1;
                    u10.Parent = List;
                    u5[v.Id] = u10;
                    u10.Progress.Claim.Activated:Once(function() -- Line: 215
                        -- upvalues: SeasonPassButtonEffects (ref), ClaimSeasonPassQuest (ref), v (copy), u10 (copy)
                        SeasonPassButtonEffects.Click();
                        ClaimSeasonPassQuest:FireServer(v.Id);
                        u10.Progress.Claim.Visible = false;
                    end);
                    u10.Progress.Claim.MouseEnter:Connect(function() -- Line: 220
                        -- upvalues: SeasonPassButtonEffects (ref)
                        SeasonPassButtonEffects.Hover();
                    end);
                end;

                local v11 = Quest:Display(v.Progress, v.Target, v.Arguments);
                u10.Title.Text = v11.Title;
                u10.Desc.Text = v11.Description;
                u10.Progress.Fill.Size = UDim2.fromScale(math.clamp(v.Progress / v.Target, 0, 1), 1);
                u10.Progress.Amount.Text = v.Progress >= v.Target and "Completed!" or v11.Bar;
                u10.Vector.Image = "rbxassetid://75864975818271";
                u10.Amount.Text = `x{SeasonPassStaticData.DAILY_QUEST_XP}`;
                local Claim = u10.Progress.Claim;

                if v.Progress >= v.Target and SeasonPassData.CurrentSeason then
                    Claim.Visible = table.find(Data2.SeasonPass[SeasonPassData.CurrentSeason].QuestsCompleted, v.Id) and not table.find(Data2.SeasonPass[SeasonPassData.CurrentSeason].QuestsClaimed, v.Id) and true or false;
                end;
            end;
        end;

        for i in u5 do
            local v12 = i;
            local v13 = false;

            for _, v in ContainerFromId.Quests do
                if v.Id == v12 then
                    v13 = true;
                    break;
                end;
            end;

            if not v13 then
                local v14 = u5[v12];

                if v14 then
                    v14:Destroy();
                    u5[v12] = nil;
                end;
            end;
        end;

        updateRobuxSkipQuestsButton();
    end;

    local u15 = nil;

    local function updateTimerLabel() -- Line: 259
        -- upvalues: NumberUtil (ref), u15 (ref), Quests (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v16 = `New quests in:  <font color="rgb(255, 78, 78)">{NumberUtil.compactFormat(((ServerTimeNow + 14400) // 86400 + 1) * 86400 - 14400 - ServerTimeNow)}</font>`;

        if v16 ~= u15 then
            u15 = v16;
            Quests.Timer.Text = v16;
        end;
    end;

    Quests:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 269
        -- upvalues: InfoFrame (ref), updateRobuxSkipQuestsButton (copy), Quests (ref), NumberUtil (ref), u15 (ref)
        InfoFrame.Visible = false;
        updateRobuxSkipQuestsButton();

        if Quests.Visible then
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v17 = `New quests in:  <font color="rgb(255, 78, 78)">{NumberUtil.compactFormat(((ServerTimeNow + 14400) // 86400 + 1) * 86400 - 14400 - ServerTimeNow)}</font>`;

            if v17 ~= u15 then
                u15 = v17;
                Quests.Timer.Text = v17;
            end;
        end;
    end);
    task.spawn(updateQuests);
    local PathSignal = DataService:GetPathSignal("SeasonPassDailyQuests/@");
    assert(PathSignal, "Failed to listen for SP Daily Quests"):Connect(updateQuests);
    local PathSignal2 = DataService:GetPathSignal("QuestContainers/@");
    assert(PathSignal2, "Failed to listen for Quest Containers"):Connect(updateQuests);
    task.spawn(function() -- Line: 281
        -- upvalues: SeasonPassUI (ref), Quests (ref), NumberUtil (ref), u15 (ref)
        task.wait(math.random() * 0.9);

        while true do
            if SeasonPassUI.Enabled and Quests.Visible then
                local ServerTimeNow = workspace:GetServerTimeNow();
                local v18 = `New quests in:  <font color="rgb(255, 78, 78)">{NumberUtil.compactFormat(((ServerTimeNow + 14400) // 86400 + 1) * 86400 - 14400 - ServerTimeNow)}</font>`;

                if v18 ~= u15 then
                    u15 = v18;
                    Quests.Timer.Text = v18;
                end;
            end;

            task.wait(1);
        end;
    end);
end;

return v1;