-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local MarketplaceService = game:GetService("MarketplaceService");
local UserInputService = game:GetService("UserInputService");
local GamepadService = game:GetService("GamepadService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local Icon = require(ReplicatedStorage.Modules.Icon);
local VFXUtils = require(ReplicatedStorage.Code.VFXUtils);
local Backpack = require(ReplicatedStorage.Modules.Backpack);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DataService = require(ReplicatedStorage.Modules.DataService);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
require(ReplicatedStorage.Modules.GiveServiceCommon);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.UpdateService);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local UseDynamicPrices = require(ReplicatedStorage.Modules.UseDynamicPrices);
local CircularTransition = require(ReplicatedStorage.Code.CircularTransition);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local DiggingRewardsUIController = require(ReplicatedStorage.Modules.DiggingMinigame.DiggingRewardsUIController);
local ProximityPromptController = require(ReplicatedStorage.Modules.ProximityPromptController);
local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
local DiggingConfigData = require(ReplicatedStorage.Data.DiggingMinigame.DiggingConfigData);
local DiggingEventConfigData = require(ReplicatedStorage.Data.DiggingMinigame.DiggingEventConfigData);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local DiggingMinigameUtils = require(ReplicatedStorage.Modules.DiggingMinigame.DiggingMinigameUtils);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local RestartDiggingSheckles = ReplicatedStorage.GameEvents.DiggingMiniGame.RestartDiggingSheckles;
local u1 = {
    IsInDigPrompt = false
};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Digging_UI = PlayerGui:WaitForChild("Digging_UI");
local DiggingRewards_UI = PlayerGui:WaitForChild("DiggingRewards_UI");
local Teleport_UI = PlayerGui:WaitForChild("Teleport_UI");
local Hud_UI = PlayerGui:WaitForChild("Hud_UI");
local DiggingEventReward = Digging_UI:WaitForChild("DiggingEventReward");
DiggingEventReward:FindFirstChild("REWARD_TITLE_TEXT", true);
DiggingEventReward:FindFirstChild("REWARD_TITLE_TEXT_SHADOW", true);
local REWARD_TEXT = DiggingEventReward:FindFirstChild("REWARD_TEXT", true);
local REWARD_TEXT_SHADOW = DiggingEventReward:FindFirstChild("REWARD_TEXT_SHADOW", true);
local REWARD_IMAGE = DiggingEventReward:FindFirstChild("REWARD_IMAGE", true);
local DIG_TIME_LEFT = Digging_UI:FindFirstChild("DIG_TIME_LEFT", true);
local DIG_TIME_LEFT_SHADOW = Digging_UI:FindFirstChild("DIG_TIME_LEFT_SHADOW", true);
local TIMER_ICON = Digging_UI:FindFirstChild("TIMER_ICON", true);
local DIGS_REMAINING = Digging_UI:FindFirstChild("DIGS_REMAINING", true);
local DIGS_REMAINING_SHADOW = Digging_UI:FindFirstChild("DIGS_REMAINING_SHADOW", true);
local TREASURES_LEFT = Digging_UI:FindFirstChild("TREASURES_LEFT", true);
local TREASURES_LEFT_SHADOW = Digging_UI:FindFirstChild("TREASURES_LEFT_SHADOW", true);
local EVENT_TIME_LEFT = Digging_UI:FindFirstChild("EVENT_TIME_LEFT", true);
local EVENT_TIME_LEFT_SHADOW = Digging_UI:FindFirstChild("EVENT_TIME_LEFT_SHADOW", true);
local DiggingCompleteFrame = Digging_UI:FindFirstChild("DiggingCompleteFrame", true);
local RESTART_SHECKLES = Digging_UI:FindFirstChild("RESTART_SHECKLES", true);
local RESTART_ROBUX = Digging_UI:FindFirstChild("RESTART_ROBUX", true);
local OddsButton = Digging_UI:FindFirstChild("OddsButton", true);
local u2 = CircularTransition.new(game.Players.LocalPlayer);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local PermanentDigging = SharedCycleHandlerData.PermanentDigging;

local function UpdateDiggingUI() -- Line: 94
    -- upvalues: DataService (copy), DIGS_REMAINING (copy), DiggingConfigData (copy), DIGS_REMAINING_SHADOW (copy), TREASURES_LEFT (copy), TREASURES_LEFT_SHADOW (copy), DiggingEventConfigData (copy), DiggingCompleteFrame (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local DiggingData = Data.DiggingData;
    DIGS_REMAINING.Text = `{DiggingData.RemainingDigs}/{DiggingConfigData.MAX_DIGS_AVALIABLE}`;
    DIGS_REMAINING_SHADOW.Text = DIGS_REMAINING.Text;
    local v3 = #DiggingData.TreasureData;
    local v4 = 0;

    for _, v in DiggingData.TreasureData do
        if v.TreasureClaimed then
            v4 = v4 + 1;
        end;
    end;

    if v4 < v3 then
        TREASURES_LEFT.Text = `{v4}/{v3}`;
    else
        TREASURES_LEFT.Text = "All treasures found!";
    end;

    TREASURES_LEFT_SHADOW.Text = TREASURES_LEFT.Text;

    if Data.DiggingData.DigComplete then
        task.spawn(function() -- Line: 125
            -- upvalues: DiggingEventConfigData (ref), DiggingCompleteFrame (ref), Data (copy)
            task.wait(4);

            if DiggingEventConfigData.IsPermanentEvent() then
                DiggingCompleteFrame.Visible = Data.DiggingData.DigComplete;

                return;
            end;

            DiggingCompleteFrame.Visible = true;
        end);

        return;
    end;

    DiggingCompleteFrame.Visible = false;
end;

local function SwitchToDiggingZone() -- Line: 140
    -- upvalues: CollectionService (copy), u2 (copy), workspace_CurrentCamera (copy)
    local Tagged = CollectionService:GetTagged("DiggingCameraPart");
    local v5 = Tagged[1];

    for _, v in Tagged do
        if v:IsDescendantOf(workspace) then
            v5 = v;
            break;
        end;
    end;

    u2:Close();
    task.wait(0.5);

    if workspace_CurrentCamera then
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        workspace_CurrentCamera.CFrame = v5.CFrame;
        task.wait(0.5);
        u2:Open();
    end;
end;

local function ResetToPlayer() -- Line: 160
    -- upvalues: LocalPlayer (copy), u2 (copy), workspace_CurrentCamera (copy)
    if LocalPlayer:GetAttribute("PlayerDigging") ~= nil then
        u2:Close();
    end;

    task.wait(0.5);

    if workspace_CurrentCamera then
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CameraSubject = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid");
    end;

    task.wait(0.5);

    if LocalPlayer:GetAttribute("PlayerDigging") ~= nil then
        u2:Open();
    end;
end;

local function StartDigStockTimer() -- Line: 179
    -- upvalues: DataService (copy), ClientABTests (copy), LocalPlayer (copy), DIG_TIME_LEFT (copy), TIMER_ICON (copy), DIG_TIME_LEFT_SHADOW (copy), DiggingConfigData (copy), NumberUtil (copy)
    while true do
        while true do
            task.wait(1);
            local Data = DataService:GetData();

            if ClientABTests.GetAttributeAsync(LocalPlayer, "AB_DiggingTypes", "Default") == "No_Free" then
                break;
            end;

            TIMER_ICON.Visible = true;

            if Data then
                if Data.DiggingData.RemainingDigs >= DiggingConfigData.MAX_DIGS_AVALIABLE or Data.DiggingData.NextDiggingGainTime < 0 then
                    DIG_TIME_LEFT.Text = "MAX";
                    DIG_TIME_LEFT_SHADOW.Text = DIG_TIME_LEFT.Text;
                else
                    local ServerTimeNow = workspace:GetServerTimeNow();
                    local math_max_ret = math.max(Data.DiggingData.NextDiggingGainTime - ServerTimeNow, 0);
                    DIG_TIME_LEFT.Text = NumberUtil.compactFormat(math_max_ret);
                    DIG_TIME_LEFT_SHADOW.Text = DIG_TIME_LEFT.Text;
                end;
            end;
        end;

        DIG_TIME_LEFT.Visible = false;
        TIMER_ICON.Visible = false;
        DIG_TIME_LEFT_SHADOW.Visible = false;
    end;
end;

local function StartDigEventTimer() -- Line: 229
    -- upvalues: PermanentDigging (ref), EVENT_TIME_LEFT (copy), NumberUtil (copy), EVENT_TIME_LEFT_SHADOW (copy)
    while true do
        workspace:GetServerTimeNow();

        if PermanentDigging:IsRunning() and PermanentDigging:IsCycleActive() then
            EVENT_TIME_LEFT.Text = NumberUtil.compactFormat(PermanentDigging:GetTimeRemaining() or 0);
            EVENT_TIME_LEFT_SHADOW.Text = EVENT_TIME_LEFT.Text;
        end;

        task.wait(1);
    end;
end;

function u1.PromptDigProductPurchase(p6) -- Line: 242
    -- upvalues: u1 (copy), MarketplaceService (copy), LocalPlayer (copy), MarketController (copy), DevProductIds (copy)
    if u1.IsInDigPrompt then
        return nil;
    end;

    u1.IsInDigPrompt = true;
    local u7 = nil;
    u7 = MarketplaceService.PromptProductPurchaseFinished:Connect(function() -- Line: 250, Name: resetInDeveloperProductState
        -- upvalues: u7 (ref), u1 (ref)
        if u7 then
            u7:Disconnect();
            u7 = nil;
        end;

        task.wait(1);
        u1.IsInDigPrompt = false;

        return nil;
    end);
    local u8 = nil;
    u8 = LocalPlayer.PlayerGui.TradeNotifs:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 264
        -- upvalues: LocalPlayer (ref), u8 (ref), u1 (ref)
        if not LocalPlayer.PlayerGui.TradeNotifs.Enabled then
            if u8 then
                u8:Disconnect();
                u8 = nil;
            end;

            task.wait(1);
            u1.IsInDigPrompt = false;
        end;
    end);
    MarketController:PromptPurchase(DevProductIds.DiggingBuyDigs.PurchaseID, Enum.InfoType.Product);

    return nil;
end;

function u1.Open(p9) -- Line: 280
    -- upvalues: Teleport_UI (copy), Hud_UI (copy), Icon (copy), Backpack (copy), Digging_UI (copy), ProximityPromptController (copy), UpdateDiggingUI (copy), SwitchToDiggingZone (copy), UserInputService (copy), GamepadService (copy), GuiService (copy), LocalPlayer (copy)
    Teleport_UI.Enabled = false;
    Hud_UI.Enabled = false;
    Icon.setTopbarEnabled(false);
    Backpack:SetBackpackEnabled(false);
    Digging_UI.Enabled = true;
    ProximityPromptController:AddDisabler("DiggingMinigame");
    UpdateDiggingUI();
    SwitchToDiggingZone();

    if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        task.delay(0.5, function() -- Line: 297
            -- upvalues: GamepadService (ref), Digging_UI (ref), GuiService (ref)
            GamepadService:EnableGamepadCursor(Digging_UI.VirtualCusor);
            GuiService.SelectedObject = nil;
        end);
    end;

    LocalPlayer:SetAttribute("PlayerDigging", true);
end;

function u1.Close(p10) -- Line: 306
    -- upvalues: Teleport_UI (copy), Hud_UI (copy), Icon (copy), Backpack (copy), UserInputService (copy), GamepadService (copy), Digging_UI (copy), ProximityPromptController (copy), ResetToPlayer (copy), LocalPlayer (copy)
    Teleport_UI.Enabled = true;
    Hud_UI.Enabled = true;
    Icon.setTopbarEnabled(true);
    Backpack:SetBackpackEnabled(true);

    if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        GamepadService:DisableGamepadCursor();
    end;

    Digging_UI.Enabled = false;
    ProximityPromptController:RemoveDisabler("DiggingMinigame");
    ResetToPlayer();
    LocalPlayer:SetAttribute("PlayerDigging", nil);
end;

local DescendantTransparency = VFXUtils:GetDescendantTransparency(DiggingEventReward);
local u11 = false;
local u12 = false;

function u1.Start(u13) -- Line: 333
    -- upvalues: DiggingMinigameUtils (copy), u12 (ref), UpdateDiggingUI (copy), PermanentDigging (ref), u1 (copy), StartDigStockTimer (copy), StartDigEventTimer (copy), Digging_UI (copy), DiggingEventReward (copy), u11 (ref), VFXUtils (copy), RESTART_SHECKLES (copy), RestartDiggingSheckles (copy), RESTART_ROBUX (copy), MarketController (copy), DevProductIds (copy), UseDynamicPrices (copy), NumberUtil (copy), DiggingConfigData (copy), OddsButton (copy), DiggingRewards_UI (copy), GuiController (copy), DiggingRewardsUIController (copy), DiggingCompleteFrame (copy)
    local Theme = DiggingMinigameUtils:GetTheme();

    if not Theme then
        warn("No Theme found");

        return;
    end;

    if Theme == "DISABLED" then
        return;
    end;

    u12 = true;
    UpdateDiggingUI();
    PermanentDigging.EventEnd:Connect(function() -- Line: 343
        -- upvalues: u1 (ref)
        u1:Close();
    end);
    task.spawn(StartDigStockTimer);
    task.spawn(StartDigEventTimer);
    Digging_UI.DiggingEvent.ShovelAmount.Option3.Purchase.Main.SENSOR.Activated:Connect(function() -- Line: 351
        -- upvalues: u13 (copy)
        u13:PromptDigProductPurchase();
    end);
    Digging_UI.DiggingEvent.EventHeaders.Option3.ExitButton.Activated:Connect(function() -- Line: 355
        -- upvalues: u1 (ref)
        u1:Close();
    end);
    DiggingEventReward.Reward.ConfirmReward.Main.SENSOR.Activated:Connect(function() -- Line: 359
        -- upvalues: u11 (ref), VFXUtils (ref), DiggingEventReward (ref)
        if u11 then
            return;
        end;

        u11 = true;
        VFXUtils:SetDescendantTransparency(DiggingEventReward, 1, 0.5, function() -- Line: 363
            -- upvalues: DiggingEventReward (ref), u11 (ref)
            DiggingEventReward.Visible = false;
            u11 = false;

            return nil;
        end);
    end);
    RESTART_SHECKLES.Activated:Connect(function() -- Line: 370
        -- upvalues: RestartDiggingSheckles (ref)
        RestartDiggingSheckles:FireServer();
    end);
    RESTART_ROBUX.Activated:Connect(function() -- Line: 374
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.RestartDigging.PurchaseID, Enum.InfoType.Product);
    end);

    if UseDynamicPrices then
        MarketController:SetPriceLabel(RESTART_ROBUX.Price, DevProductIds.RestartDigging.PurchaseID, ":value:R$");
    else
        RESTART_ROBUX.Price.Text = "99R$";
    end;

    RESTART_SHECKLES.In_Stock.Cost_Text.Text = NumberUtil.FormatCompactPrice(DiggingConfigData.RESTART_SHECKLES_COST) .. "¢";
    OddsButton.Activated:Connect(function() -- Line: 386
        -- upvalues: DiggingRewards_UI (ref), GuiController (ref), DiggingRewardsUIController (ref)
        if DiggingRewards_UI.Enabled then
            GuiController:Close(DiggingRewards_UI);

            return;
        end;

        GuiController:Open(DiggingRewards_UI);
        DiggingRewardsUIController:Open();
    end);
    DiggingEventReward.Visible = false;
    VFXUtils:SetDescendantTransparency(DiggingEventReward, 1);
    DiggingCompleteFrame.Visible = false;

    if not PermanentDigging:IsRunning() then
        PermanentDigging:Start();
    end;
end;

function u1.DisplayReward(p14, u15) -- Line: 403
    -- upvalues: REWARD_TEXT (copy), GiveServiceCommon (copy), REWARD_TEXT_SHADOW (copy), REWARD_IMAGE (copy), ItemImageFinder (copy), DiggingEventReward (copy), VFXUtils (copy), DescendantTransparency (copy), u11 (ref)
    task.spawn(function() -- Line: 404
        -- upvalues: REWARD_TEXT (ref), GiveServiceCommon (ref), u15 (copy), REWARD_TEXT_SHADOW (ref), REWARD_IMAGE (ref), ItemImageFinder (ref), DiggingEventReward (ref), VFXUtils (ref), DescendantTransparency (ref), u11 (ref)
        REWARD_TEXT.Text = GiveServiceCommon:Format(u15);
        REWARD_TEXT_SHADOW.Text = REWARD_TEXT.Text;
        REWARD_IMAGE.Image = ItemImageFinder(u15.Value, u15.Type);
        DiggingEventReward.Visible = true;
        VFXUtils:SetDescendantTransparency(DiggingEventReward, DescendantTransparency, 0.25);
        task.wait(4);
        u11 = true;
        VFXUtils:SetDescendantTransparency(DiggingEventReward, 1, 0.5, function() -- Line: 417
            -- upvalues: DiggingEventReward (ref), u11 (ref)
            DiggingEventReward.Visible = false;
            u11 = false;

            return nil;
        end);
    end);
end;

DataService:GetPathSignal("DiggingData/@"):Connect(function() -- Line: 425
    -- upvalues: UpdateDiggingUI (copy)
    UpdateDiggingUI();
end);

function SwapCycle()
    -- upvalues: DiggingEventConfigData (copy), PermanentDigging (ref), DiggingMinigameUtils (copy), u1 (copy), SharedCycleHandlerData (copy), LocalPlayer (copy), u2 (copy), OddsButton (copy)
    if DiggingEventConfigData.PREVIOUS_THEME == DiggingEventConfigData.NEXT_THEME then
        return;
    end;

    PermanentDigging:Stop();
    PermanentDigging:Destroy();

    if DiggingMinigameUtils:GetTheme() == "DISABLED" then
        u1:Close();

        return;
    end;

    PermanentDigging = SharedCycleHandlerData.PermanentDigging;
    PermanentDigging.EventEnd:Connect(function() -- Line: 441
        -- upvalues: DiggingEventConfigData (ref), LocalPlayer (ref), u2 (ref), u1 (ref)
        if not DiggingEventConfigData.IsPermanentEvent() or LocalPlayer:GetAttribute("PlayerDigging") == nil then
            u1:Close();

            return;
        end;

        u2:Close();
        task.wait(3);
        u2:Open();
    end);
    OddsButton.Visible = true;
    PermanentDigging:Start();
end;

local function OnEventUpdated(u16: string, u17: string) -- Line: 487
    -- upvalues: DiggingEventConfigData (copy), DiggingMinigameUtils (copy), EventRotationUtils (copy), PermanentDigging (ref), SharedCycleHandlerData (copy), u12 (ref), u1 (copy)
    if not DiggingEventConfigData.THEME_DATA[u17] then
        return;
    end;

    local Theme = DiggingMinigameUtils:GetTheme();

    if not Theme then
        warn("No Theme found");

        return;
    end;

    if Theme == "DISABLED" then
        return;
    end;

    task.spawn(function() -- Line: 493
        -- upvalues: u17 (copy), EventRotationUtils (ref), u16 (copy), PermanentDigging (ref), SharedCycleHandlerData (ref), u12 (ref), u1 (ref)
        if u17 == "HalloweenEvent" then
            local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(u16, u17);

            if EventInSetIndex and EventInSetIndex >= 2 then
                PermanentDigging = SharedCycleHandlerData.Gravedigger;
            end;
        else
            PermanentDigging = SharedCycleHandlerData.PermanentDigging;
        end;

        if not u12 then
            u1:Start();
        end;
    end);
end;

EventRotationController.EventUpdated:Connect(OnEventUpdated);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent then
    OnEventUpdated(LoadedEvent.EventID, LoadedEvent.EventSet);
end;

return u1;