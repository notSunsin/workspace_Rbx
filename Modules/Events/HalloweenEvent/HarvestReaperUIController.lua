-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local HarvestReaperRewardData = require(ReplicatedStorage.Data.Events.HalloweenEvent.HarvestReaperRewardData);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local HarvestReaperConfigData = require(ReplicatedStorage.Data.Events.HalloweenEvent.HarvestReaperConfigData);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local u1 = Trove.new();
local HarvestReaper_UI = Players.LocalPlayer.PlayerGui.Events.HalloweenEvent.HarvestReaper_UI;
local ExitButton = HarvestReaper_UI.Frame.ExitButton;
local Holder = HarvestReaper_UI.Frame.Main.Holder;
local RewardScrollingFrame = Holder.RewardScrollingFrame;
local SkipRobux = Holder.Header.SkipRobux;
local ClaimedOverlay = Holder.RewardScrollingFrame.RewardSection.ClaimedOverlay;
local Timer = ClaimedOverlay.Timer;
local HarvestReaper = SharedCycleHandlerData.HarvestReaper;
local StockLabel = RewardScrollingFrame.RewardSection.RewardsList.MainReward.Layout.Left.ItemFrame.Stocks.StockLabel;
local MainReward = RewardScrollingFrame.RewardSection.RewardsList.MainReward;
local Description = MainReward.Layout.Right.Description;
local u2 = {
    [0] = DevProductIds.HarvestReaperSkipRitual1.PurchaseID,
    [0.2] = DevProductIds.HarvestReaperSkipRitual2.PurchaseID,
    [0.4] = DevProductIds.HarvestReaperSkipRitual3.PurchaseID,
    [0.6] = DevProductIds.HarvestReaperSkipRitual4.PurchaseID,
    [0.8] = DevProductIds.HarvestReaperSkipRitual5.PurchaseID
};
local HarvestReaperSeed = ReplicatedStorage.Data.ReplicatedGlobalStock.HarvestReaperSeed;
local u3 = {};
local u4 = {};

local function GetDevProductBracket() -- Line: 59
    -- upvalues: CollectionService (copy), u2 (copy)
    local v5 = 0;
    local v6 = 0;

    for _, child in CollectionService:GetTagged("HarvestReaperRitualPointsFolder")[1]:GetChildren() do
        v5 = v5 + 1;

        if child:GetAttribute("RitualPoint_Completed") then
            v6 = v6 + 1;
        end;
    end;

    if v5 == 0 then
        return 0;
    end;

    local v7 = v6 / v5;
    local v8 = 0;

    for i, _ in pairs(u2) do
        if i <= v7 and v8 < i then
            v8 = i;
        end;
    end;

    return u2[v8];
end;

function u4.Open(p9) -- Line: 87
    -- upvalues: GuiController (copy), HarvestReaper_UI (copy)
    GuiController:Open(HarvestReaper_UI);
end;

function u4.Close(p10) -- Line: 91
    -- upvalues: GuiController (copy), HarvestReaper_UI (copy)
    GuiController:Close(HarvestReaper_UI);
end;

local function BuildRewardsUI() -- Line: 95
    -- upvalues: SeedData (copy), Description (copy), MainReward (copy), ItemImageFinder (copy), HarvestReaperRewardData (copy), RewardScrollingFrame (copy), u3 (copy), ItemOddsController (copy), HarvestReaper_UI (copy), ColorHelper (copy)
    local v11 = SeedData["Severed Spine"];

    if v11 then
        Description.Text = v11.AbilityDescription or "NO DESCRIPTION ASSIGNED";
    end;

    MainReward.Layout.Left.ItemFrame.ITEM_IMAGE.Image = ItemImageFinder("Severed Spine", "Seed");
    local SecondaryRewards = HarvestReaperRewardData.SecondaryRewards;
    local _ = #SecondaryRewards;
    local table_clone_ret = table.clone(SecondaryRewards);
    table.sort(table_clone_ret, function(p12, p13) -- Line: 107
        return (p12.Chance or 1) > (p13.Chance or 1);
    end);
    local v14 = 0;

    for _, v in table_clone_ret do
        v14 = v14 + (v.Chance or 0);
    end;

    local v15 = 100;

    for _, v in HarvestReaperRewardData.SecondaryRewards do
        local v16 = RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE:Clone();
        v16.LayoutOrder = v15;
        v16.Parent = RewardScrollingFrame;
        u3[v16] = true;
        local Odds = v16.Frame.Odds;
        ItemOddsController:ConnectOddsButton(v, v16.Frame.OddsButton, HarvestReaper_UI);
        local v17 = tostring(v.Value);
        local v18 = v.Quantity or 1;

        if v18 > 1 then
            v17 = "x" .. v18 .. " " .. v.Value;
        end;

        v16.Frame.RewardName.Text = v17;
        Odds.Text = string.format("%.2f", v.Chance / v14 * 100) .. "%";
        Odds.Visible = true;
        v16.Frame.ITEM_IMAGE.Image = ItemImageFinder(`{v.Value}`, v.Type);
        v16.Frame.RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
        local UIStroke = v16.Frame.RewardName.UIStroke;

        if UIStroke then
            UIStroke.Color = ColorHelper:Darken(v16.Frame.RewardName.TextColor3);
        end;

        v15 = v15 + 1;
    end;

    local SmallRewards = HarvestReaperRewardData.SmallRewards;
    local _ = #SmallRewards;
    local table_clone_ret2 = table.clone(SmallRewards);
    table.sort(table_clone_ret2, function(p19, p20) -- Line: 165
        return (p19.Chance or 1) > (p20.Chance or 1);
    end);
    local v21 = 0;

    for _, v in table_clone_ret2 do
        v21 = v21 + (v.Chance or 0);
    end;

    local v22 = 6000;

    for _, v in HarvestReaperRewardData.SmallRewards do
        local v23 = RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE:Clone();
        v23.LayoutOrder = v22;
        v23.Parent = RewardScrollingFrame;
        u3[v23] = true;
        local Odds = v23.Frame.Odds;
        ItemOddsController:ConnectOddsButton(v, v23.Frame.OddsButton, HarvestReaper_UI);
        local v24 = tostring(v.Value);
        local v25 = v.Quantity or 1;

        if v25 > 1 then
            v24 = "x" .. v25 .. " " .. v.Value;
        end;

        v23.Frame.RewardName.Text = v24;
        Odds.Text = string.format("%.2f", v.Chance / v21 * 100) .. "%";
        Odds.Visible = true;
        v23.Frame.ITEM_IMAGE.Image = ItemImageFinder(`{v.Value}`, v.Type);
        v23.Frame.RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
        local UIStroke = v23.Frame.RewardName.UIStroke;

        if UIStroke then
            UIStroke.Color = ColorHelper:Darken(v23.Frame.RewardName.TextColor3);
        end;

        v22 = v22 + 1;
    end;
end;

local function UpdateStockText() -- Line: 219
    -- upvalues: StockLabel (copy), CommaFormatNumber (copy), HarvestReaperSeed (copy), HarvestReaperConfigData (copy)
    StockLabel.Text = `x{CommaFormatNumber(HarvestReaperSeed.Value)} LEFT`;
    local v26 = HarvestReaperSeed.Value / HarvestReaperConfigData.RESTOCK_AMOUNT;

    if v26 > 0.75 then
        StockLabel.TextColor3 = Color3.fromRGB(11, 255, 19);

        return;
    end;

    if v26 > 0.5 then
        StockLabel.TextColor3 = Color3.fromRGB(255, 255, 0);

        return;
    end;

    if v26 > 0.25 then
        StockLabel.TextColor3 = Color3.fromRGB(255, 85, 0);

        return;
    end;

    StockLabel.TextColor3 = Color3.fromRGB(255, 0, 0);
end;

function u4.Start(p27) -- Line: 235
    -- upvalues: u1 (copy), ExitButton (copy), u4 (copy), SkipRobux (copy), GetDevProductBracket (copy), MarketController (copy), BuildRewardsUI (copy), HarvestReaper (copy), DataService (copy), ClaimedOverlay (copy), TimeHelper (copy), Timer (copy), HarvestReaperSeed (copy), UpdateStockText (copy)
    u1:Add(ExitButton.Activated:Connect(function() -- Line: 236
        -- upvalues: u4 (ref)
        u4:Close();
    end));
    u1:Add(SkipRobux.Activated:Connect(function() -- Line: 240
        -- upvalues: GetDevProductBracket (ref), MarketController (ref)
        local v28 = GetDevProductBracket();

        if v28 ~= 0 then
            MarketController:PromptPurchase(v28, Enum.InfoType.Product);
        end;
    end));
    BuildRewardsUI();

    if not HarvestReaper:IsRunning() then
        HarvestReaper:Start();
    end;

    u1:Add(task.spawn(function() -- Line: 253
        -- upvalues: DataService (ref), HarvestReaper (ref), ClaimedOverlay (ref), TimeHelper (ref), Timer (ref)
        while true do
            local v29;

            if DataService:GetData().HalloweenEventData.HarvestReaper.LastClaimCycle == HarvestReaper:GetCurrentCycle() then
                v29 = true;
            else
                v29 = false;
            end;

            ClaimedOverlay.Visible = v29;

            if v29 then
                Timer.Text = TimeHelper:GenerateTextFromTime(HarvestReaper:GetTimeUntilNext() or 0);
            end;

            task.wait(1);
        end;
    end));
    HarvestReaperSeed.Changed:Connect(UpdateStockText);
    UpdateStockText();
end;

EventRotationClientBinder:Bind({
    EventSet = "HalloweenEvent",
    MinPartIndex = 3,
    Script = script,

    OnStart = function() -- Line: 276, Name: OnStart
        -- upvalues: u4 (copy)
        task.spawn(u4.Start, u4);
    end,

    OnStop = function() -- Line: 277, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u4;