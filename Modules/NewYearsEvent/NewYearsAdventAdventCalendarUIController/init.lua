-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.ItemImageFinder);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.Signal);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local EventService = require(ReplicatedStorage.Modules.EventService);
require(ReplicatedStorage.Modules.QuestsController);
require(ReplicatedStorage.Modules.MarketController);
local script_RewardFrame = require(script.RewardFrame);
require(ReplicatedStorage.Modules.UIComponents.QuestView);
local AdventCalendarConfigData = require(ReplicatedStorage.Data.NewYearsEvent.AdventCalendarConfigData);
local AdventCalendarRewardsData = require(ReplicatedStorage.Data.NewYearsEvent.AdventCalendarRewardsData);
local NewYearsAdventCalendar = require(ReplicatedStorage.Data.SharedCycleHandlerData).NewYearsAdventCalendar;
require(ReplicatedStorage.Data.DevProductIds);
local NewYears2025_StreakPetsReward_UI = Players.LocalPlayer.PlayerGui:WaitForChild("NewYears2025_StreakPetsReward_UI");
local Timer = NewYears2025_StreakPetsReward_UI.Frame.Main.Header.Resets.Timer;
local FINALREWARD_FRAME = NewYears2025_StreakPetsReward_UI.Frame.Main.Content.FINALREWARD_FRAME;
local _ = ReplicatedStorage.GameEvents.NewYearsEvent.ClaimAdventCalendarDay;
local ClaimAdventCalendarFinalReward = ReplicatedStorage.GameEvents.NewYearsEvent.ClaimAdventCalendarFinalReward;
local u1 = nil;
local u2 = {};
local u3 = nil;

local function isTodayFinished() -- Line: 49
    -- upvalues: NewYearsAdventCalendar (copy), DataService (copy)
    local CurrentCycle = NewYearsAdventCalendar:GetCurrentCycle();
    local Data = DataService:GetData();
    local v4 = 0;

    while not Data.NewYearsEvent.Advent.Days[CurrentCycle] and v4 < 10 do
        task.wait(1);
        v4 = v4 + 1;
    end;

    if Data.NewYearsEvent.Advent.Days[CurrentCycle] then
        return Data.NewYearsEvent.Advent.Days[CurrentCycle].State == "Complete" or (Data.NewYearsEvent.Advent.Days[CurrentCycle].State == "Expired" or Data.NewYearsEvent.Advent.Days[CurrentCycle].State == "Claimed");
    end;

    return false;
end;

local NewYearsAdventAdventCalendarUIController = EventService.new("NewYearsAdventAdventCalendarUIController", "New Years Advent Calendar");

local function InitializeRewardsUI() -- Line: 76
    -- upvalues: AdventCalendarConfigData (copy), AdventCalendarRewardsData (copy), script_RewardFrame (copy), u2 (copy), NewYears2025_StreakPetsReward_UI (copy), FINALREWARD_FRAME (copy), u3 (ref), ClaimAdventCalendarFinalReward (copy), NewYearsAdventAdventCalendarUIController (copy)
    local v5 = 0;

    for i = 1, AdventCalendarConfigData.DAY_COUNT do
        local v6;

        if AdventCalendarRewardsData.Rewards[i] then
            local v7 = script_RewardFrame.new(i, AdventCalendarRewardsData.Rewards[i]);
            u2[i] = v7;
            local Frame = v7:GetFrame();
            Frame.Parent = NewYears2025_StreakPetsReward_UI.Frame.Main.Content.SmallRewards;
            Frame.LayoutOrder = v5;
            v5 = v5 + 100;
            v6 = i;
        else
            v6 = i;
        end;
    end;

    FINALREWARD_FRAME.RewardName.Text = AdventCalendarRewardsData.FinalReward.ItemName;
    FINALREWARD_FRAME.ITEM_IMAGE.Image = AdventCalendarRewardsData.FinalReward.ImageId;
    u3 = FINALREWARD_FRAME.ClaimButton.Activated:Connect(function() -- Line: 97
        -- upvalues: ClaimAdventCalendarFinalReward (ref)
        ClaimAdventCalendarFinalReward:FireServer();
    end);
    NewYearsAdventAdventCalendarUIController.UpdateAllRewardStates();
    UpdateCurrentDayHighlight();
end;

function NewYearsAdventAdventCalendarUIController.UpdateClaimCount(p8) -- Line: 107
    -- upvalues: DataService (copy), FINALREWARD_FRAME (copy), AdventCalendarConfigData (copy)
    local v9 = 0;

    for _, v in DataService:GetData().NewYearsEvent.Advent.Days do
        if v.State == "Complete" or v.State == "Claimed" then
            v9 = v9 + 1;
        end;
    end;

    FINALREWARD_FRAME.Requirement.Counter.Text = `Login {v9}/{AdventCalendarConfigData.DAY_COUNT} Days`;
end;

function NewYearsAdventAdventCalendarUIController.UpdateAllRewardStates() -- Line: 121
    -- upvalues: u2 (copy), DataService (copy), FINALREWARD_FRAME (copy), AdventCalendarConfigData (copy), NewYearsAdventAdventCalendarUIController (copy)
    for _, v in u2 do
        v:UpdateState();
    end;

    local Data = DataService:GetData();
    local v10 = 0;

    if Data.NewYearsEvent.Advent.FinalRewardClaimed then
        FINALREWARD_FRAME.ClaimedDisplay.Visible = true;
        FINALREWARD_FRAME.ClaimButton.Visible = false;
        FINALREWARD_FRAME.Requirement.Visible = false;
    else
        FINALREWARD_FRAME.ClaimedDisplay.Visible = false;

        for _, v in Data.NewYearsEvent.Advent.Days do
            if v.State == "Complete" or v.State == "Claimed" then
                v10 = v10 + 1;
            end;
        end;

        if AdventCalendarConfigData.DAY_COUNT <= v10 then
            if Data.NewYearsEvent.Advent.FinalRewardClaimed then
                FINALREWARD_FRAME.ClaimButton.Visible = false;
                FINALREWARD_FRAME.Requirement.Visible = false;
            else
                FINALREWARD_FRAME.ClaimButton.Visible = true;
                FINALREWARD_FRAME.Requirement.Visible = false;
            end;
        else
            FINALREWARD_FRAME.ClaimButton.Visible = false;
            FINALREWARD_FRAME.Requirement.Visible = true;
        end;
    end;

    NewYearsAdventAdventCalendarUIController:UpdateClaimCount();
end;

function UpdateCurrentDayHighlight()
    -- upvalues: NewYearsAdventCalendar (copy), u2 (copy)
    local CurrentCycle = NewYearsAdventCalendar:GetCurrentCycle();

    for i, v in u2 do
        v:SetCurrentDay(i == CurrentCycle);
    end;
end;

local function GetExpiredDaysCount() -- Line: 168
    -- upvalues: DataService (copy)
    local v11 = 0;

    for _, v in DataService:GetData().NewYearsEvent.Advent.Days do
        if v.State == "Expired" then
            v11 = v11 + 1;
        end;
    end;

    return v11;
end;

function NewYearsAdventAdventCalendarUIController.OnStarted(p12) -- Line: 179
    -- upvalues: NewYearsAdventCalendar (copy), AdventCalendarConfigData (copy), NewYearsAdventAdventCalendarUIController (copy), InitializeRewardsUI (copy), DataService (copy), FINALREWARD_FRAME (copy), Timer (copy), NumberUtil (copy)
    if not NewYearsAdventCalendar:IsRunning() then
        NewYearsAdventCalendar:Start(AdventCalendarConfigData.START_TIMESTAMP);
    end;

    p12:Bind(NewYearsAdventCalendar.IntervalChanged:Connect(function(p13: number, p14: number) -- Line: 194
        -- upvalues: NewYearsAdventAdventCalendarUIController (ref), NewYearsAdventCalendar (ref), AdventCalendarConfigData (ref)
        UpdateCurrentDayHighlight();
        NewYearsAdventAdventCalendarUIController.UpdateAllRewardStates();
        local _ = NewYearsAdventCalendar:GetCurrentCycle() >= AdventCalendarConfigData.DAY_COUNT;
    end));
    InitializeRewardsUI();
    p12:Bind(DataService:GetPathSignal("NewYearsEvent/Advent/Days/@"):Connect(function() -- Line: 207
        -- upvalues: NewYearsAdventAdventCalendarUIController (ref)
        NewYearsAdventAdventCalendarUIController.UpdateAllRewardStates();
    end));
    p12:Bind(DataService:GetPathSignal("NewYearsEvent/Advent/FinalRewardClaimed"):Connect(function() -- Line: 217
        -- upvalues: FINALREWARD_FRAME (ref)
        FINALREWARD_FRAME.ClaimButton.Visible = false;
        FINALREWARD_FRAME.ClaimedDisplay.Visible = true;
    end));
    NewYearsAdventAdventCalendarUIController.UpdateAllRewardStates();
    print(DataService:GetData().NewYearsEvent);
    task.spawn(function() -- Line: 227
        -- upvalues: NewYearsAdventCalendar (ref), AdventCalendarConfigData (ref), Timer (ref), NumberUtil (ref)
        while task.wait(1) do
            local CurrentCycle = NewYearsAdventCalendar:GetCurrentCycle();

            if CurrentCycle == AdventCalendarConfigData.DAY_COUNT then
                Timer.Text = "Happy new years!";
            else
                if AdventCalendarConfigData.DAY_COUNT < CurrentCycle then
                    Timer.Visible = false;

                    return;
                end;

                local TimeUntilNext = NewYearsAdventCalendar:GetTimeUntilNext();
                Timer.Text = `New Day in {NumberUtil.toHMS(TimeUntilNext or 0)}`;
            end;
        end;
    end);
end;

function NewYearsAdventAdventCalendarUIController.OnEnded(p15) -- Line: 245
    -- upvalues: u1 (ref)
    u1 = nil;
end;

function NewYearsAdventAdventCalendarUIController.Open(p16) -- Line: 249
    -- upvalues: GuiController (copy), NewYears2025_StreakPetsReward_UI (copy)
    GuiController:Open(NewYears2025_StreakPetsReward_UI);
end;

function NewYearsAdventAdventCalendarUIController.Close(p17) -- Line: 254
    -- upvalues: GuiController (copy), NewYears2025_StreakPetsReward_UI (copy)
    GuiController:Close(NewYears2025_StreakPetsReward_UI);
end;

GuiController:UsePopupAnims(NewYears2025_StreakPetsReward_UI);

return NewYearsAdventAdventCalendarUIController;