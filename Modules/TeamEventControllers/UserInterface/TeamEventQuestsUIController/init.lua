-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventController);
require(ReplicatedStorage.Modules.TeamEventHelper);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local TeamEventQuestsController = require(ReplicatedStorage.Modules.TeamEventControllers.TeamEventQuestsController);
local TeamEventRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("TeamEventRewards_UI");
local Quests = TeamEventRewards_UI:WaitForChild("Quests");
local Slots = Quests.Main.Main.Slots;
local Title = Quests.Main.Main.Timer.Fill.Title;
GuiController:GetStateForGui(TeamEventRewards_UI).ChangeEnabled:Set(true);
local script_QuestTemplateNew = script.QuestTemplateNew;
local u1 = {};
local u2 = {};

local function GetCurrentPeriod(p3: number) -- Line: 42
    return p3 // 3600;
end;

local function GetResetTime(p4: number) -- Line: 46
    return (p4 // 3600 + 1) * 3600;
end;

local function RemoveQuestFromRender(p5) -- Line: 50
    -- upvalues: u2 (copy)
    local v6 = u2[p5];

    if v6 then
        v6:Destroy();
        u2[p5] = nil;
    end;
end;

local function UpdateQuests() -- Line: 58
    -- upvalues: DataService (copy), u2 (copy), QuestsController (copy), script_QuestTemplateNew (copy), Slots (copy), TeamEventQuestsController (copy), Quests (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    if not Data.TeamEventData then
        for i in u2 do
            local v7 = u2[i];

            if v7 then
                v7:Destroy();
                u2[i] = nil;
            end;
        end;

        table.clear(u2);

        return;
    end;

    local BeeEvent = Data.TeamEventData.BeeEvent;

    if not BeeEvent then
        warn("No player event data found: BeeEvent");

        return;
    end;

    local QuestContainerId = BeeEvent.QuestContainerId;

    if not QuestContainerId then
        return;
    end;

    local ContainerFromId = QuestsController:GetContainerFromId(QuestContainerId);

    if not ContainerFromId then
        return;
    end;

    for i, v in ContainerFromId.Quests do
        local _ = v.Completed;
        local Quest = QuestsController:GetQuest(v.Type);

        if Quest then
            local v8 = u2[v.Id];

            if not v8 then
                v8 = script_QuestTemplateNew:Clone();
                v8.Visible = true;
                v8.LayoutOrder = i + 1;
                v8.Parent = Slots;
                u2[v.Id] = v8;
            end;

            local v9;

            if v.Rewards then
                v9 = v;

                for _, v2 in v.Rewards do
                    local v10 = v2.Data and v2.Data.Amount;

                    if not v10 then
                        local RewardInfo = QuestsController:GetRewardInfo(v2.Type);

                        if RewardInfo then
                            v10 = RewardInfo:Display(v2):match("%d+");
                        end;
                    end;

                    if v10 then
                        v8.Reward.TextLabel.Text = `x{v10}`;
                    end;
                end;
            else
                v9 = v;
            end;

            local v11 = Quest:Display(v9.Progress, v9.Target, v9.Arguments);
            v8.Title.Text = v11.Title;
            v8.Bar.Loader.Size = UDim2.fromScale(math.clamp(v9.Progress / v9.Target, 0, 1), 1);
            v8.Bar.Progress.Text = v9.Progress >= v9.Target and "Completed!" or v11.Bar;
        end;
    end;

    for i in u2 do
        local v12 = i;
        local v13 = false;

        for _, v in ContainerFromId.Quests do
            if v.Id == v12 then
                v13 = true;
                break;
            end;
        end;

        if not v13 then
            local v14 = u2[v12];

            if v14 then
                v14:Destroy();
                u2[v12] = nil;
            end;
        end;
    end;

    local QuestsCompletedCount, v15 = TeamEventQuestsController:GetQuestsCompletedCount("BeeEvent");
    Quests.Main.Main.skipQuestsButton.Visible = QuestsCompletedCount < v15;
end;

function u1.Toggle(p16: table, p17: boolean?) -- Line: 155
    -- upvalues: Quests (copy), TeamEventRewards_UI (copy), GuiController (copy)
    if p17 == nil then
        p17 = not Quests.Visible;
    end;

    if p17 then
        for _, v in { "RewardsWithQuests", "Rewards", "Rewards_HarvestMoon", "Rewards_HarvestMoon_OLD" } do
            local v18 = TeamEventRewards_UI:FindFirstChild(v);

            if v18 then
                v18.Visible = false;
            end;
        end;
    end;

    Quests.Visible = p17;

    if p17 then
        GuiController:Open(TeamEventRewards_UI);

        return;
    end;

    GuiController:Close(TeamEventRewards_UI);
end;

function u1.Start(p19) -- Line: 178
    -- upvalues: Quests (copy), SetupButton (copy), MarketController (copy), DevProductIds (copy), DataService (copy), NumberUtil (copy), Title (copy), UpdateQuests (copy), UpdateService (copy), u1 (copy), TeamEventRewards_UI (copy)
    SetupButton({
        legacy = true,
        instance = Quests.Main.Main.skipQuestsButton,

        onclick = function() -- Line: 186, Name: onclick
            -- upvalues: MarketController (ref), DevProductIds (ref)
            MarketController:PromptPurchase(DevProductIds.SkipBeeEventQuests.PurchaseID, Enum.InfoType.Product);
        end
    });
    local u20 = nil;

    local function UpdateTimerLabel() -- Line: 195
        -- upvalues: DataService (ref), NumberUtil (ref), u20 (ref), Title (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v21 = (ServerTimeNow // 3600 + 1) * 3600;
        local Data = DataService:GetData();
        local v22 = Data and Data.TeamEventData and Data.TeamEventData.BeeEvent;

        if v22 and v22.QuestExpiresAt then
            v21 = v22.QuestExpiresAt;
        end;

        local math_max_ret = math.max(0, v21 - ServerTimeNow);
        local v23 = `Refreshes in <font color="rgb(255, 78, 78)">{NumberUtil.compactFormat(math_max_ret)}</font>`;

        if v23 ~= u20 then
            u20 = v23;
            Title.Text = v23;
        end;
    end;

    UpdateQuests();
    DataService:GetPathSignal("TeamEventData/@"):Connect(UpdateQuests);
    DataService:GetPathSignal("QuestContainers/@"):Connect(UpdateQuests);
    UpdateService.OnUpdated:Connect(UpdateQuests);
    Quests:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 219
        -- upvalues: Quests (ref), UpdateQuests (ref), UpdateTimerLabel (copy)
        if Quests.Visible then
            UpdateQuests();
            UpdateTimerLabel();
        end;
    end);
    SetupButton({
        legacy = true,
        instance = Quests.Main.Header.Close,

        onclick = function() -- Line: 229, Name: onclick
            -- upvalues: u1 (ref)
            u1:Toggle(false);
        end
    });
    task.spawn(function() -- Line: 233
        -- upvalues: TeamEventRewards_UI (ref), Quests (ref), UpdateTimerLabel (copy)
        task.wait(math.random() * 0.9);

        while true do
            if TeamEventRewards_UI.Enabled and Quests.Visible then
                UpdateTimerLabel();
            end;

            task.wait(1);
        end;
    end);
end;

task.spawn(u1.Start, u1);

return u1;