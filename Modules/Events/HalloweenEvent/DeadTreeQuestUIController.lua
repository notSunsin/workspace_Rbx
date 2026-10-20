-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
require(ReplicatedStorage.Data.QuestData.Types);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local ImageCycle = require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local DeepClone = require(ReplicatedStorage.Modules.ReplicationClass.DeepClone);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local Trove = require(ReplicatedStorage.Modules.Trove);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local DeadTreeRewardData = require(ReplicatedStorage.Data.Events.HalloweenEvent.DeadTreeRewardData);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
local u1 = Trove.new();
local _ = ReplicatedStorage:WaitForChild("GameEvents").GetDeadTreeGlobalStock;
local DeadTreeQuests_UI = Players.LocalPlayer.PlayerGui.Events.HalloweenEvent:WaitForChild("DeadTreeQuests_UI");
local Main = DeadTreeQuests_UI.Frame.Main;
local Header = Main.Holder.Header;
local List = Main.Holder.Content.Tasks.List;
local RewardSection = Main.Holder.Content.RewardSection;
local CanvasGroup = RewardSection.CanvasGroup;
local MainReward = RewardSection.CanvasGroup.RewardsList.MainReward;
local u2 = {
    ItemFrame = MainReward.Layout.Left.ItemFrame,
    ItemIcon = MainReward.Layout.Left.ItemFrame.ITEM_IMAGE,
    ItemName = MainReward.ItemName,
    StockLabel = MainReward.Layout.Left.ItemFrame.Stocks.StockLabel,
    PurchaseFrame = MainReward.Layout.Right.PurchaseButton,
    BonusChanceTextLabel = MainReward.Layout.Left.ItemFrame.BonusChance
};
local SecondaryReward = RewardSection.CanvasGroup.RewardsList.SecondaryReward;
local u3 = {
    ItemFrame = SecondaryReward.Layout.ItemFrame,
    ItemIcon = SecondaryReward.Layout.ItemFrame.ITEM_IMAGE,
    ItemName = SecondaryReward.ItemName,
    PurchaseFrame = SecondaryReward.Layout.PurchaseButton,
    OddsButton = SecondaryReward.Layout.ItemFrame.OddsButton
};
local SkipQuestsButton = Header.SkipQuestsButton;
local SENSOR = Header.Exit.SENSOR;
local Resets = Header.Resets;
local Segment = List.UIListLayout.Segment;
local u4 = {};
local DeadTree = SharedCycleHandlerData.DeadTree;
local u5 = {};

local function GetRerollCost(p6: number) -- Line: 73
    return math.max(50000, 2 ^ p6 * 50000);
end;

local function ConfigureQuestCell(p7: string, p8: any) -- Line: 77
    -- upvalues: QuestsController (copy)
    local ContainerFromId = QuestsController:GetContainerFromId(p7);

    if not ContainerFromId then
        return;
    end;

    local v9 = ContainerFromId.Quests[1];
    local v10 = QuestsController:GetQuest(v9.Type):Display(v9.Progress, v9.Target, v9.Arguments);
    local v11 = v9.Progress >= v9.Target and "Completed!" or v10.Bar;
    p8.TASK_NAME.Text = v10.Title;
    p8.Progress.ProgressBar.PROGRESS.Text = v11;
    p8.Progress.ProgressBar.PROGRESS_SHADOW.Text = v11;
    local math_clamp_ret = math.clamp(v9.Progress / v9.Target, 0, 1);
    p8.Progress.ProgressBar.Bar_Actual.Size = UDim2.new(math_clamp_ret, 0, 1, 0);
    p8.Progress.Details.Underglow.Size = UDim2.new(math_clamp_ret * 1.296, 0, math_clamp_ret * 6.504, 0);
    p8.Visible = true;
end;

local function GetCellForQuest(p12: string) -- Line: 103
    -- upvalues: u4 (copy), Segment (copy)
    if u4[p12] then
        return u4[p12];
    end;

    local v13 = Segment:Clone();
    u4[p12] = v13;

    return v13;
end;

local function AreQuestsCompleted() -- Line: 114
    -- upvalues: DataService (copy), QuestsController (copy)
    local Data = DataService:GetData();

    if not Data then
        return false;
    end;

    if #Data.HalloweenEventData.DeadTree.QuestContainers <= 0 then
        return false;
    end;

    for _, v in Data.HalloweenEventData.DeadTree.QuestContainers do
        local ContainerFromId = QuestsController:GetContainerFromId(v);

        if not ContainerFromId then
            return false;
        end;

        for _, v2 in ContainerFromId.Quests do
            if not v2.Completed then
                return false;
            end;
        end;
    end;

    return true;
end;

local function UpdateStockText() -- Line: 131
    -- upvalues: DataService (copy), DeadTreeRewardData (copy), AreQuestsCompleted (copy), DeadTree (ref), SkipQuestsButton (copy), CanvasGroup (copy), ItemImageFinder (copy), u2 (copy), u3 (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local StockItem = DeadTreeRewardData.StockItem;
    local v14 = AreQuestsCompleted();
    local v15 = Data.HalloweenEventData.DeadTree.LastClaimCycle == DeadTree:GetCurrentCycle();
    SkipQuestsButton.Visible = not v14;
    CanvasGroup.GroupTransparency = 0;
    local v16 = ItemImageFinder(StockItem, "Seed");
    u2.ItemIcon.Image = v16;
    u2.ItemName.Text = StockItem;
    u2.PurchaseFrame.Main.Price.Text = "CLAIM";
    u2.StockLabel.TextColor3 = Color3.new(0, 1, 0);
    u2.PurchaseFrame.Main.Visible = true;
    u2.PurchaseFrame.OutOfStock.Visible = false;

    if v14 then
        u3.PurchaseFrame.Main.Visible = true;
        u3.PurchaseFrame.OutOfStock.Visible = false;
    else
        u2.PurchaseFrame.Main.Visible = false;
        u2.PurchaseFrame.OutOfStock.Visible = true;
        u2.PurchaseFrame.OutOfStock.Price.Text = "LOCKED";
        u3.PurchaseFrame.Main.Visible = false;
        u3.PurchaseFrame.OutOfStock.Visible = true;
        u3.PurchaseFrame.OutOfStock.Price.Text = "LOCKED";
    end;

    if v15 then
        u2.PurchaseFrame.Main.Visible = false;
        u2.PurchaseFrame.OutOfStock.Visible = true;
        u2.PurchaseFrame.OutOfStock.Price.Text = "CLAIMED";
        u3.PurchaseFrame.Main.Visible = false;
        u3.PurchaseFrame.OutOfStock.Visible = true;
        u3.PurchaseFrame.OutOfStock.Price.Text = "CLAIMED";
    end;
end;

local function BuildUI() -- Line: 180
    -- upvalues: DataService (copy), QuestsController (copy), u4 (copy), Segment (copy), ConfigureQuestCell (copy), List (copy), UpdateStockText (copy), MainReward (copy), SeedData (copy), DeepClone (copy), DeadTreeRewardData (copy), u2 (copy)
    local Data = DataService:GetData();

    for _, v in Data.HalloweenEventData.DeadTree.QuestContainers do
        local v17 = tostring(v);

        if QuestsController:GetContainerFromId(v17) == nil then
            warn("Invalid Quest ID in Dead Tree Quest List. Skipping.");
        else
            local v18;

            if u4[v17] then
                v18 = u4[v17];
            else
                v18 = Segment:Clone();
                u4[v17] = v18;
            end;

            ConfigureQuestCell(v17, v18);
            v18.Parent = List;
        end;
    end;

    UpdateStockText();
    MainReward.Layout.Right.Description.Text = `{SeedData["Weeping Branch"].AbilityDescription}`;
    local v19 = DeepClone(DeadTreeRewardData.Rewards);
    local v20 = 1;
    local Data2 = DataService:GetData();

    if Data2 then
        for _, v in v19 do
            if v.Value == "Weeping Branch" then
                v.Chance = v.Chance + Data2.HalloweenEventData.DeadTree.WeepingSeedBonusChance;
                v20 = v.Chance;
                break;
            end;
        end;
    end;

    local v21 = 0;

    for _, v in v19 do
        v21 = v21 + (v.Chance or 0);
    end;

    u2.BonusChanceTextLabel.Text = `Bonus +{string.format("%.2f", v20 / v21 * 100)}%`;

    for i, _ in u4 do
        if table.find(Data.HalloweenEventData.DeadTree.QuestContainers, i) == nil then
            u4[i]:Destroy();
            u4[i] = nil;
        end;
    end;
end;

function u5.Start(p22) -- Line: 234
    -- upvalues: GuiController (copy), DeadTreeQuests_UI (copy), u1 (copy), SENSOR (copy), SkipQuestsButton (copy), DeadTree (ref), Notification (copy), AreQuestsCompleted (copy), MarketController (copy), DevProductIds (copy), DataService (copy), BuildUI (copy), RunService (copy), Resets (copy), NumberUtil (copy), ReplicatedStorage (copy), u3 (copy), UpdateStockText (copy), DeadTreeRewardData (copy), GenericRewardsUIController (copy), ImageCycle (copy), SecondaryReward (copy)
    GuiController:GetStateForGui(DeadTreeQuests_UI);
    u1:Add(SENSOR.Activated:Connect(function() -- Line: 238
        -- upvalues: GuiController (ref), DeadTreeQuests_UI (ref)
        GuiController:Close(DeadTreeQuests_UI);
    end));
    u1:Add(SkipQuestsButton.Activated:Connect(function() -- Line: 242
        -- upvalues: DeadTree (ref), Notification (ref), AreQuestsCompleted (ref), MarketController (ref), DevProductIds (ref)
        if not DeadTree:IsCycleActive() then
            Notification:CreateNotification("Dead Tree is not active!");

            return;
        end;

        if AreQuestsCompleted() then
            Notification:CreateNotification("You\'ve already completed the quests!");

            return;
        end;

        MarketController:PromptPurchase(DevProductIds.DeadTreeSkipQuests.PurchaseID, Enum.InfoType.Product);
    end));
    local PathSignal = DataService:GetPathSignal("HalloweenEventData/DeadTree/@");
    u1:Add(assert(PathSignal, "Failed to listen for Dead Tree Quests"):Connect(BuildUI));
    local PathSignal2 = DataService:GetPathSignal("QuestContainers/@");
    u1:Add(assert(PathSignal2, "Failed to listen for Dead Tree Containers"):Connect(BuildUI));
    u1:Add(RunService.Heartbeat:Connect(function() -- Line: 261
        -- upvalues: DeadTree (ref), Resets (ref), NumberUtil (ref)
        local TimeRemaining = DeadTree:GetTimeRemaining();
        Resets.Text = "Leaves in " .. NumberUtil.toHMS(TimeRemaining or 0);
        task.wait(1);
    end));
    u1:Add(ReplicatedStorage.GameEvents.DeadTreeStockUpdated.OnClientEvent:Connect(function(p23) -- Line: 267
        -- upvalues: BuildUI (ref)
        BuildUI();
    end));
    u1:Add(u3.PurchaseFrame.Main.SENSOR.Activated:Connect(function(p24: userdata, p25: number) -- Line: 271
        -- upvalues: ReplicatedStorage (ref), UpdateStockText (ref)
        ReplicatedStorage.GameEvents.ClaimDeadTree:FireServer();
        UpdateStockText();
    end));
    local u26 = {};

    for _, v in DeadTreeRewardData.Rewards do
        table.insert(u26, {
            Reward = v,
            Weight = v.Chance
        });
    end;

    u1:Add(u3.OddsButton.Activated:Connect(function(p27: userdata, p28: number) -- Line: 284
        -- upvalues: GenericRewardsUIController (ref), u26 (copy), DeadTreeQuests_UI (ref)
        GenericRewardsUIController:Open({
            Title = "Dead Tree Rewards",
            DisplayOdds = true,
            RewardData = u26,
            HeaderColor = Color3.new(0.0235294, 0.0117647, 0.392157),
            Breadcrumb = DeadTreeQuests_UI
        });
    end));
    UpdateStockText();
    ImageCycle.CycleRewardImages(u3.ItemIcon, nil, nil, SecondaryReward, DeadTreeRewardData.Rewards);
    task.spawn(BuildUI);
end;

EventRotationClientBinder:Bind({
    EventSet = "HalloweenEvent",
    MinPartIndex = 2,
    Script = script,

    OnStart = function() -- Line: 306, Name: OnStart
        -- upvalues: u5 (copy), u1 (copy), DeadTree (ref), GuiController (copy), DeadTreeQuests_UI (copy), EventRotationController (copy), SharedCycleHandlerData (copy)
        task.spawn(u5.Start, u5);
        local u29 = u1:Add(DeadTree.EventEnd:Connect(function() -- Line: 310
            -- upvalues: GuiController (ref), DeadTreeQuests_UI (ref)
            GuiController:Close(DeadTreeQuests_UI);
        end));

        local function CheckCombinedSwitch() -- Line: 314
            -- upvalues: EventRotationController (ref), DeadTree (ref), SharedCycleHandlerData (ref), u29 (ref), u1 (ref), GuiController (ref), DeadTreeQuests_UI (ref)
            if EventRotationController:IsPastEventIDIndex(3) and DeadTree ~= SharedCycleHandlerData.WitchesBrewAndDeadTree then
                DeadTree:Stop();
                DeadTree = SharedCycleHandlerData.WitchesBrewAndDeadTree;

                if not DeadTree:IsRunning() then
                    DeadTree:Start();
                end;

                if u29 then
                    u1:Remove(u29);
                end;

                u29 = u1:Add(DeadTree.EventEnd:Connect(function() -- Line: 326
                    -- upvalues: GuiController (ref), DeadTreeQuests_UI (ref)
                    GuiController:Close(DeadTreeQuests_UI);
                end));
            end;
        end;

        u1:Add(EventRotationController.EventUpdated:Connect(function(p30, p31) -- Line: 332
            -- upvalues: CheckCombinedSwitch (copy)
            if p31 ~= "HalloweenEvent" then
                return;
            end;

            CheckCombinedSwitch(p30, p31);
        end));
        local LoadedEvent = EventRotationController:GetLoadedEvent();

        if LoadedEvent then
            CheckCombinedSwitch(LoadedEvent.EventID, LoadedEvent.EventSet);
        end;
    end,

    OnStop = function() -- Line: 342, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u5;