-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Trove = require(ReplicatedStorage.Modules.Trove);
local DataService = require(ReplicatedStorage.Modules.DataService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
require(ReplicatedStorage.Modules.PetEggOddsController);
require(ReplicatedStorage.Modules.SeedPackOddsController);
local ChipmunkEventCommon = require(ReplicatedStorage.Modules.Events.ChubbyChipmunkEvent.ChipmunkEventCommon);
require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.GiveServiceCommon.Types);
local ChipmunkEventRewardData = require(ReplicatedStorage.Data.Events.ChubbyChipmunkEvent.ChipmunkEventRewardData);
local UITabHelperModule = require(ReplicatedStorage.Modules.UITabHelperModule);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local u1 = Trove.new();
local GameEvents = ReplicatedStorage.GameEvents;
local ClaimChipmunkRewards = GameEvents.Events.ChubbyChipmunkEvent.ClaimChipmunkRewards;
local RestartChipmunkTrack = GameEvents.Events.ChubbyChipmunkEvent.RestartChipmunkTrack;
local LocalPlayer = Players.LocalPlayer;
local ChipmunkRewards_UI = LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("ChubbyChipmunkEvent"):WaitForChild("ChipmunkRewards_UI");
local Holder = ChipmunkRewards_UI.Frame.Main.Holder;
local WeightTitle = Holder.ChipmunkWeightSection:FindFirstChild("WeightTitle");
local RewardsFrame = Holder.ScalesHolder.RewardScrollingFrame.CanvasGroup.RewardsFrame;
local RewardScrollingFrame = Holder.ScalesHolder.RewardScrollingFrame;
local REWARDTRACK_TEMPLATE = RewardsFrame.UIListLayout.REWARDTRACK_TEMPLATE;
local CLAIM_BUTTON = Holder.CLAIM_BUTTON;
local RestartFrame = Holder.RestartFrame;
local RESTART_BUTTON = RestartFrame.ButtonBox.RESTART_BUTTON;
local RESTART_BUTTON_ROBUX = RestartFrame.ButtonBox.RESTART_BUTTON_ROBUX;
local CLAIM_BUTTON_DISABLED = Holder.CLAIM_BUTTON_DISABLED;
local u2 = Trove.new();
local u3 = Trove.new();
local AllRewardsHolder = ChipmunkRewards_UI.Frame.Main.AllRewardsHolder;
local Holder2 = ChipmunkRewards_UI.Frame.Main.Holder;
local u4 = 0;
local u5 = {};
local u6 = {};
local u7 = {};

local function WeightToChildX(p8: number) -- Line: 67
    -- upvalues: u5 (copy), u6 (copy)
    local v9 = #u5;

    if v9 == 0 then
        return 0;
    end;

    local v10 = u6[1] - 0.25;

    if p8 <= 0 then
        return v10;
    end;

    local v11 = {};
    table.insert(v11, {
        weightStart = 0,
        weightEnd = u5[1],
        xStart = v10,
        xEnd = u6[1]
    });

    for i = 1, v9 - 1 do
        table.insert(v11, {
            weightStart = u5[i],
            weightEnd = u5[i + 1],
            xStart = u6[i],
            xEnd = u6[i + 1]
        });
        local _ = i;
    end;

    for _, v in v11 do
        if v.weightStart <= p8 and p8 <= v.weightEnd then
            local v12 = v.weightEnd - v.weightStart;

            if v12 > 0 then
                return v.xStart + (p8 - v.weightStart) / v12 * (v.xEnd - v.xStart);
            end;

            return v.xStart;
        end;
    end;

    if u5[v9] <= p8 then
        return u6[v9];
    end;

    return v10;
end;

local function FormatReward(p13) -- Line: 117
    local v14 = p13.Quantity or 1;
    local Value = p13.Value;

    if p13.Type == "XP" then
        Value = p13.Type;
        v14 = p13.Value;
    end;

    if v14 <= 1 then
        return `{Value}`;
    end;

    return `{Value} x{v14}`;
end;

local function CreateStaticRewardFrame(p15: any, p16: number, p17: any, p18: any, p19: userdata?) -- Line: 132
    -- upvalues: REWARDTRACK_TEMPLATE (copy), GiveServiceCommon (copy), ColorHelper (copy), ItemImageFinder (copy), ItemOddsController (copy), ChipmunkRewards_UI (copy)
    local v20 = p18:Clone(p19 or REWARDTRACK_TEMPLATE);
    v20.Name = "STATIC_REWARD_" .. p16;
    v20.LayoutOrder = p16;
    v20.Parent = p17;
    local RarityColor = GiveServiceCommon:GetRarityColor(p15);
    v20.Frame.RewardName.TextColor3 = Color3.new(1, 1, 1);
    local UIStroke = v20.Frame.RewardName.UIStroke;

    if UIStroke then
        UIStroke.Color = ColorHelper:Darken(RarityColor, 3);
    end;

    local RewardName = v20.Frame.RewardName;
    local v21 = p15.Quantity or 1;
    local Value = p15.Value;

    if p15.Type == "XP" then
        Value = p15.Type;
        v21 = p15.Value;
    end;

    local v22;

    if v21 <= 1 then
        v22 = `{Value}`;
    else
        v22 = `{Value} x{v21}`;
    end;

    RewardName.Text = v22;
    local v23 = ItemImageFinder(p15.Value, p15.Type);
    v20.Frame.ITEM_IMAGE.Image = v23 or "rbxassetid://6937742258";
    local v24 = ColorHelper:Darken(RarityColor, 1.3);
    v20.Frame.BackgroundColor3 = v24:Lerp(v20.Frame.BackgroundColor3, 0.5);
    ItemOddsController:ConnectOddsButton(p15, v20.Frame.OddsButton, ChipmunkRewards_UI);

    return v20;
end;

local function UpdateWeightText() -- Line: 165
    -- upvalues: ChipmunkEventCommon (copy), LocalPlayer (copy), u4 (ref), WeightTitle (copy)
    if ChipmunkEventCommon:GetChipmunkData(LocalPlayer) then
        WeightTitle.Text = `Your Chipmunk Weighs: {string.format("%.2f", u4)}kg`;

        return;
    end;

    WeightTitle.Text = "Claim your Chipmunk to get started!";
end;

local function UpdateFrameScales() -- Line: 176
    -- upvalues: RewardScrollingFrame (copy), ChipmunkEventRewardData (copy), RewardsFrame (copy)
    local v25 = RewardScrollingFrame.AbsolutePosition.X + RewardScrollingFrame.AbsoluteSize.X / 2;
    local X = RewardScrollingFrame.AbsoluteSize.X;

    for i, _ in ChipmunkEventRewardData.RewardBrackets do
        local v26 = RewardsFrame:FindFirstChild("STATIC_REWARD_" .. i);

        if v26 then
            local math_abs_ret = math.abs(v26.AbsolutePosition.X + v26.AbsoluteSize.X / 2 - v25);
            local v27 = (1 - math.min(math_abs_ret / (X * 0.5), 1)) * 0.15000000000000002 + 0.65;
            v26.Size = UDim2.new(v27, 0, v27, 0);
            local v28 = (1 - math.min(math_abs_ret / (X * 0.8), 1)) * -0.6 + 0.6;
            v26.Frame.BackgroundTransparency = v28;
            v26.Frame.ITEM_IMAGE.ImageTransparency = v28;
            v26.Frame.RewardName.TextTransparency = v28;
            v26.WeightTarget.TextTransparency = v28;
        end;
    end;
end;

local function UpdateClaimButton() -- Line: 211
    -- upvalues: ChipmunkEventCommon (copy), LocalPlayer (copy), PetUtilities (copy), ChipmunkEventRewardData (copy), CLAIM_BUTTON (copy), CLAIM_BUTTON_DISABLED (copy), RestartFrame (copy)
    local ChipmunkData = ChipmunkEventCommon:GetChipmunkData(LocalPlayer);
    local v29 = ChipmunkData and (ChipmunkData.PetData and PetUtilities:CalculateWeight(ChipmunkData.PetData.BaseWeight or 1, ChipmunkData.PetData.Level, ChipmunkData.PetType) >= ChipmunkEventRewardData.MaxWeight) and true or false;
    local v30 = ChipmunkEventCommon:CountUnclaimedRewards(LocalPlayer);
    CLAIM_BUTTON.Visible = v30 > 0;
    CLAIM_BUTTON:FindFirstChild("CLAIM").Text = `Claim (x{v30})`;
    CLAIM_BUTTON:FindFirstChild("CLAIM_BUTTON").Text = `Claim (x{v30})`;
    local v31;

    if v30 <= 0 then
        v31 = not v29;
    else
        v31 = false;
    end;

    CLAIM_BUTTON_DISABLED.Visible = v31;

    if v29 then
        v29 = v30 <= 0;
    end;

    RestartFrame.Visible = v29;
end;

local function UpdateFramesClaimStates() -- Line: 232
    -- upvalues: DataService (copy), ChipmunkEventRewardData (copy), RewardsFrame (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    for i, v in ChipmunkEventRewardData.RewardBrackets do
        local v32 = RewardsFrame:FindFirstChild("STATIC_REWARD_" .. i);

        if v32 then
            local ClaimedText = v32.ClaimedText;

            if Data.ChipmunkEvent.WeightTiersClaimed[`{v.Weight}`] then
                ClaimedText.Visible = true;
                v32.Frame.RewardName.TextTransparency = 0.5;
                v32.Frame.RewardName.UIStroke.Transparency = 0.5;
                v32.Frame.ITEM_IMAGE.ImageTransparency = 0.5;
                v32.Frame.ClaimedOverlay.BackgroundTransparency = 0.5;
            else
                ClaimedText.Visible = false;
                v32.Frame.RewardName.TextTransparency = 0;
                v32.Frame.RewardName.UIStroke.Transparency = 0;
                v32.Frame.ITEM_IMAGE.ImageTransparency = 0;
                v32.Frame.ClaimedOverlay.BackgroundTransparency = 1;
            end;
        end;
    end;
end;

local function UpdateScroll() -- Line: 258
    -- upvalues: WeightToChildX (copy), u4 (ref), u6 (copy), RewardsFrame (copy), UpdateFrameScales (copy)
    local v33 = 0.5 - WeightToChildX(u4);
    local math_clamp_ret = math.clamp(v33, 0.5 - u6[#u6], 0.5 - (u6[1] - 0.25));
    RewardsFrame.Position = UDim2.new(math_clamp_ret, 0, 0, 0);
    UpdateFrameScales();
end;

local function TweenWeight(p34: number, p35: number, p36: number?) -- Line: 274
    -- upvalues: u4 (ref), TweenService (copy), ChipmunkEventCommon (copy), LocalPlayer (copy), WeightTitle (copy), WeightToChildX (copy), u6 (copy), RewardsFrame (copy), UpdateFrameScales (copy), GuiController (copy), ChipmunkRewards_UI (copy), Holder2 (copy), u5 (copy), SoundService (copy), u2 (copy)
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = p36 or 0;
    u4 = p36 or 0;
    local v37 = TweenService:Create(NumberValue, TweenInfo.new(p35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0), {
        Value = p34
    });
    local u38 = 1;
    u2:Add((NumberValue.Changed:Connect(function(p39) -- Line: 293
        -- upvalues: u4 (ref), ChipmunkEventCommon (ref), LocalPlayer (ref), WeightTitle (ref), WeightToChildX (ref), u6 (ref), RewardsFrame (ref), UpdateFrameScales (ref), GuiController (ref), ChipmunkRewards_UI (ref), Holder2 (ref), u38 (ref), u5 (ref), SoundService (ref)
        u4 = p39;

        if ChipmunkEventCommon:GetChipmunkData(LocalPlayer) then
            WeightTitle.Text = `Your Chipmunk Weighs: {string.format("%.2f", u4)}kg`;
        else
            WeightTitle.Text = "Claim your Chipmunk to get started!";
        end;

        local v40 = 0.5 - WeightToChildX(u4);
        local math_clamp_ret = math.clamp(v40, 0.5 - u6[#u6], 0.5 - (u6[1] - 0.25));
        RewardsFrame.Position = UDim2.new(math_clamp_ret, 0, 0, 0);
        UpdateFrameScales();

        if GuiController:GetStateForGui(ChipmunkRewards_UI).Visible:Get() and (Holder2.Visible and (u38 <= #u5 and u5[u38] <= p39)) then
            SoundService:PlayLocalSound(SoundService.Click);
            u38 = u38 + 1;
        end;
    end)));
    u2:Add(NumberValue);
    u2:Add(v37);
    v37:Play();
end;

local function UpdateRestartButtonPrices() -- Line: 316
    -- upvalues: NumberUtil (copy), ChipmunkEventCommon (copy), RESTART_BUTTON (copy), RESTART_BUTTON_ROBUX (copy)
    local v41 = NumberUtil.FormatCompactPrice(ChipmunkEventCommon.TRACK_RESTART_COST, "5");
    RESTART_BUTTON.CLAIM.Text = `{v41}¢`;
    RESTART_BUTTON.CLAIM_BUTTON.Text = RESTART_BUTTON.CLAIM.Text;
    RESTART_BUTTON_ROBUX.CLAIM.Text = `{ChipmunkEventCommon.TRACK_RESTART_COST_ROBUX}`;
    RESTART_BUTTON_ROBUX.CLAIM_BUTTON.Text = RESTART_BUTTON_ROBUX.CLAIM.Text;
end;

function u7.Open(p42) -- Line: 325
    -- upvalues: GuiController (copy), ChipmunkRewards_UI (copy), u2 (copy), RewardsFrame (copy), ChipmunkEventRewardData (copy), CreateStaticRewardFrame (copy), u5 (copy), u6 (copy), u4 (ref), ChipmunkEventCommon (copy), LocalPlayer (copy), WeightTitle (copy), WeightToChildX (copy), UpdateFrameScales (copy), UpdateFramesClaimStates (copy), UpdateClaimButton (copy), NumberUtil (copy), RESTART_BUTTON (copy), RESTART_BUTTON_ROBUX (copy), PetUtilities (copy), TweenWeight (copy), RewardScrollingFrame (copy)
    GuiController:GetStateForGui(ChipmunkRewards_UI);
    u2:Destroy();

    for _, child in RewardsFrame:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    local v43 = 100;

    for i, v in ChipmunkEventRewardData.RewardBrackets do
        local v44 = CreateStaticRewardFrame(v.Reward, v43, RewardsFrame, u2);
        v44.WeightTarget.Text = `{v.Weight}kg`;
        v44.Name = "STATIC_REWARD_" .. i;
        v44.Position = UDim2.new((i - 1) * 0.25, 0, 0.5, 0);
        u5[i] = v.Weight;
        u6[i] = v44.Position.X.Scale;
        v43 = v43 + 100;
    end;

    u4 = 0;

    if ChipmunkEventCommon:GetChipmunkData(LocalPlayer) then
        WeightTitle.Text = `Your Chipmunk Weighs: {string.format("%.2f", u4)}kg`;
    else
        WeightTitle.Text = "Claim your Chipmunk to get started!";
    end;

    local v45 = 0.5 - WeightToChildX(u4);
    local math_clamp_ret = math.clamp(v45, 0.5 - u6[#u6], 0.5 - (u6[1] - 0.25));
    RewardsFrame.Position = UDim2.new(math_clamp_ret, 0, 0, 0);
    UpdateFrameScales();
    UpdateFramesClaimStates();
    UpdateClaimButton();
    local v46 = NumberUtil.FormatCompactPrice(ChipmunkEventCommon.TRACK_RESTART_COST, "5");
    RESTART_BUTTON.CLAIM.Text = `{v46}¢`;
    RESTART_BUTTON.CLAIM_BUTTON.Text = RESTART_BUTTON.CLAIM.Text;
    RESTART_BUTTON_ROBUX.CLAIM.Text = `{ChipmunkEventCommon.TRACK_RESTART_COST_ROBUX}`;
    RESTART_BUTTON_ROBUX.CLAIM_BUTTON.Text = RESTART_BUTTON_ROBUX.CLAIM.Text;
    local ChipmunkData = ChipmunkEventCommon:GetChipmunkData(LocalPlayer);

    if ChipmunkData and ChipmunkData.PetData then
        TweenWeight(PetUtilities:CalculateWeight(ChipmunkData.PetData.BaseWeight or 1, ChipmunkData.PetData.Level, ChipmunkData.PetType), 2);
    end;

    u2:Add(RewardScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 368
        -- upvalues: WeightToChildX (ref), u4 (ref), u6 (ref), RewardsFrame (ref), UpdateFrameScales (ref)
        local v47 = 0.5 - WeightToChildX(u4);
        local math_clamp_ret2 = math.clamp(v47, 0.5 - u6[#u6], 0.5 - (u6[1] - 0.25));
        RewardsFrame.Position = UDim2.new(math_clamp_ret2, 0, 0, 0);
        UpdateFrameScales();
    end));
end;

local function PopulateAllRewardsList() -- Line: 373
    -- upvalues: u3 (ref), Trove (copy), ChipmunkEventRewardData (copy), CreateStaticRewardFrame (copy), RewardsFrame (copy), AllRewardsHolder (copy)
    if u3 then
        u3:Destroy();
    end;

    u3 = Trove.new();

    for i, v in ChipmunkEventRewardData.RewardBrackets do
        local v48 = CreateStaticRewardFrame(v.Reward, 100, RewardsFrame, u3, AllRewardsHolder.ScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
        v48.WeightTarget.Text = `{v.Weight}kg`;
        v48.Name = "STATIC_REWARD_" .. i;
        v48.Parent = AllRewardsHolder.ScrollingFrame;
        v48.ClaimedText.Visible = false;
    end;
end;

function u7.OnStopped(p49) -- Line: 387
    -- upvalues: GuiController (copy), ChipmunkRewards_UI (copy), u2 (copy), u3 (ref)
    GuiController:Close(ChipmunkRewards_UI);
    u2:Destroy();
    u3:Destroy();
end;

function u7.Start(u50) -- Line: 393
    -- upvalues: ChipmunkRewards_UI (copy), ReplicatedStorage (copy), UITabHelperModule (copy), Holder2 (copy), AllRewardsHolder (copy), GuiController (copy), u7 (copy), u1 (copy), CLAIM_BUTTON (copy), ClaimChipmunkRewards (copy), RESTART_BUTTON (copy), RestartChipmunkTrack (copy), RESTART_BUTTON_ROBUX (copy), MarketController (copy), DataService (copy), PopulateAllRewardsList (copy)
    local TabFrame = ChipmunkRewards_UI:WaitForChild("TabAnchor"):WaitForChild("TabFrame");
    local TabButtonTemplate = ReplicatedStorage.UITemplates:WaitForChild("TabButtonTemplate");
    local u51 = UITabHelperModule.CreateOrGetTabHandler("ChipmunkRewards", TabFrame, TabButtonTemplate);
    u51.OnCategoryChanged:Connect(function(p52: string) -- Line: 404, Name: OnTabSelected
        -- upvalues: u51 (copy), Holder2 (ref), AllRewardsHolder (ref)
        if u51.CurrentCategory ~= "Reward Track" then
            if u51.CurrentCategory == "All Rewards" then
                Holder2.Visible = false;
                AllRewardsHolder.Visible = true;
            end;

            return;
        end;

        Holder2.Visible = true;
        AllRewardsHolder.Visible = false;
    end);
    u51.DefaultCategory = "Reward Track";
    u51.SetCategories({ {
            Name = "Reward Track",
            IsLocked = false
        }, {
            Name = "All Rewards",
            IsLocked = false
        } });
    u51.CurrentCategory = "Reward Track";
    GuiController:UsePopupAnims(ChipmunkRewards_UI);
    u7:Open();
    u1:Add(ChipmunkRewards_UI.Frame.ExitButton.Activated:Connect(function() -- Line: 424
        -- upvalues: GuiController (ref), ChipmunkRewards_UI (ref)
        GuiController:Close(ChipmunkRewards_UI);
    end));
    u1:Add(CLAIM_BUTTON.SENSOR.Activated:Connect(function() -- Line: 428
        -- upvalues: ClaimChipmunkRewards (ref), GuiController (ref), ChipmunkRewards_UI (ref)
        ClaimChipmunkRewards:FireServer();
        GuiController:Close(ChipmunkRewards_UI);
    end));
    u1:Add(RESTART_BUTTON.SENSOR.Activated:Connect(function() -- Line: 433
        -- upvalues: RestartChipmunkTrack (ref)
        RestartChipmunkTrack:FireServer();
    end));
    u1:Add(RESTART_BUTTON_ROBUX.SENSOR.Activated:Connect(function() -- Line: 437
        -- upvalues: MarketController (ref)
        MarketController:PromptPurchase(3420314011, Enum.InfoType.Product);
    end));
    u1:Add(DataService:GetPathSignal("ChipmunkEvent/WeightTiersClaimed"):Connect(function() -- Line: 441
        -- upvalues: GuiController (ref), ChipmunkRewards_UI (ref), u50 (copy)
        if GuiController:GetStateForGui(ChipmunkRewards_UI).Visible:Get() then
            u50:Open();
        end;
    end));
    PopulateAllRewardsList();
end;

EventRotationClientBinder:Bind({
    EventSet = "ChubbyChipmunkEvent",
    Script = script,

    OnStart = function() -- Line: 454, Name: OnStart
        -- upvalues: u7 (copy)
        task.spawn(u7.Start, u7);
    end,

    OnStop = function() -- Line: 455, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u7;