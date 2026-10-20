-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Trove = require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.ConfirmationPromptController);
require(ReplicatedStorage.Data.NewYearsEvent.AdventCalendarConfigData);
require(ReplicatedStorage.Data.NewYearsEvent.AdventCalendarRewardsData);
local NewYearsAdventCalendar = require(ReplicatedStorage.Data.SharedCycleHandlerData).NewYearsAdventCalendar;
local NewYears2025_StreakPetsReward_UI = Players.LocalPlayer.PlayerGui:WaitForChild("NewYears2025_StreakPetsReward_UI");
local ClaimAdventCalendarDay = ReplicatedStorage.GameEvents.NewYearsEvent.ClaimAdventCalendarDay;
local RobuxClaimAdventCalendarDay = ReplicatedStorage.GameEvents.NewYearsEvent.RobuxClaimAdventCalendarDay;
local TweenInfo_new_ret = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

local function Brighten(p1) -- Line: 47
    local v2, v3, v4 = p1:ToHSV();

    return Color3.fromHSV(v2, math.min(v3 * 0.8, 1), (math.min(v4 * 1.5, 1)));
end;

local u5 = {};
u5.__index = u5;

function u5.new(u6: number, p7: table?) -- Line: 56
    -- upvalues: u5 (copy), Trove (copy), NewYears2025_StreakPetsReward_UI (copy), ClaimAdventCalendarDay (copy), DataService (copy), RobuxClaimAdventCalendarDay (copy)
    local v8 = setmetatable({}, u5);
    v8._trove = Trove.new();
    v8._index = u6;
    v8._frame = v8._trove:Clone(NewYears2025_StreakPetsReward_UI.Frame.Main.Content.SmallRewards.UIGridLayout.Template);
    v8._frame.Name = `RewardFrame_{u6}`;
    local _ = (u6 - 1) % 6 + 1;
    v8._state = "Incomplete";
    v8._rewardDetails = v8._frame.Container.Content;
    v8._rewardNameFrame = v8._frame.Container.Content.RewardName;
    v8._rewardNameLabel = v8._frame.Container.Content.RewardName.RewardName;
    v8._itemImageLabel = v8._frame.Container.Content.ITEM_IMAGE;
    v8._claimButton = v8._frame.Container.Content.ClaimButton;
    v8._overlay = v8._frame.Container.ExpiredOverlay;
    v8._claimedOverlay = v8._frame.Container.Content.ClaimedDisplay;
    v8._robuxClaimButton = v8._overlay.RecoverButton;
    v8._backgroundFrame = v8._frame.Container;
    v8._indexLabel = v8._frame.Container.Content.DayCounter.Counter;
    v8._originalSize = v8._frame.Container.Content.Size;
    v8._originalBackgroundColor = v8._backgroundFrame.BackgroundColor3;
    v8._isCurrentDay = false;
    v8._trove:Add(v8._claimButton.Activated:Connect(function(p9: userdata, p10: number) -- Line: 86
        -- upvalues: ClaimAdventCalendarDay (ref), u6 (copy)
        require(script.Parent).UpdateAllRewardStates();
        ClaimAdventCalendarDay:FireServer(u6);
    end));
    v8._trove:Add(v8._robuxClaimButton.Activated:Connect(function(p11: userdata, p12: number) -- Line: 94
        -- upvalues: DataService (ref), RobuxClaimAdventCalendarDay (ref), u6 (copy)
        require(script.Parent).UpdateAllRewardStates();

        if not DataService:GetData() then
            return;
        end;

        RobuxClaimAdventCalendarDay:FireServer(u6);
    end));

    if p7 then
        v8._itemImageLabel.Image = p7.ImageId;
        v8._rewardNameLabel.Text = p7.ItemName;
    else
        v8._rewardNameLabel.Text = "NO REWARD";
    end;

    v8._indexLabel.Text = `{v8._index}`;
    v8:UpdateState();
    v8:_applyState();

    return v8;
end;

function u5.UpdateState(p13) -- Line: 128
    -- upvalues: DataService (copy), NewYearsAdventCalendar (copy)
    local v14 = DataService:GetData().NewYearsEvent.Advent.Days[p13._index];
    p13._state = p13._index < NewYearsAdventCalendar:GetCurrentCycle() and (v14 and v14.State == "Incomplete") and "Expired" or (not v14 and "Incomplete" or v14.State);
    p13:_applyState();
end;

function u5._applyState(p15) -- Line: 150
    -- upvalues: NewYearsAdventCalendar (copy), DataService (copy)
    local v16 = p15._index == NewYearsAdventCalendar:GetCurrentCycle();
    DataService:GetData();

    if p15._state == "Incomplete" then
        p15._claimButton.Visible = false;
        p15._robuxClaimButton.Visible = false;
        p15._claimedOverlay.Visible = false;
        p15._overlay.Visible = false;
        p15._claimedOverlay.Visible = false;

        if v16 then
            return;
        end;

        p15._rewardNameFrame.Visible = true;

        return;
    end;

    if p15._state == "Complete" then
        p15._claimButton.Visible = true;
        p15._robuxClaimButton.Visible = false;
        p15._claimedOverlay.Visible = false;
        p15._overlay.Visible = false;
        p15._claimedOverlay.Visible = false;
        p15._rewardDetails.Visible = true;
        p15._rewardNameFrame.Visible = false;

        return;
    end;

    if p15._state ~= "Claimed" then
        if p15._state == "Expired" then
            p15._claimButton.Visible = false;
            p15._robuxClaimButton.Visible = true;
            p15._overlay.Visible = true;
            p15._claimedOverlay.Visible = true;
            p15._rewardDetails.Visible = true;
            p15._rewardNameFrame.Visible = true;
        end;

        return;
    end;

    p15._claimButton.Visible = false;
    p15._robuxClaimButton.Visible = false;
    p15._overlay.Visible = false;
    p15._rewardNameFrame.Visible = false;
    p15._claimedOverlay.Visible = true;
    p15._rewardDetails.Visible = true;
end;

function u5.SetCurrentDay(p17: table, p18: boolean) -- Line: 213
    -- upvalues: TweenService (copy), TweenInfo_new_ret (copy)
    if p17._isCurrentDay == p18 then
        return;
    end;

    p17._isCurrentDay = p18;
    local v19;

    if p18 and p17._state ~= "Claimed" then
        local v20, v21, v22 = p17._originalBackgroundColor:ToHSV();
        v19 = Color3.fromHSV(v20, math.min(v21 * 0.8, 1), (math.min(v22 * 1.5, 1))) or p17._originalBackgroundColor;
    else
        v19 = p17._originalBackgroundColor;
    end;

    local v23 = TweenService:Create(p17._backgroundFrame, TweenInfo_new_ret, {
        BackgroundColor3 = v19
    });
    TweenService:Create(p17._frame.Container, TweenInfo_new_ret, {
        Size = p18 and p17._state ~= "Claimed" and UDim2.new(0.98, 0, 0.98, 0) or p17._originalSize
    }):Play();
    v23:Play();
end;

function u5.GetIndex(p24) -- Line: 239
    return p24._index;
end;

function u5.GetFrame(p25) -- Line: 243
    return p25._frame;
end;

function u5.Destroy(p26) -- Line: 247
    p26._trove:Destroy();
end;

return u5;