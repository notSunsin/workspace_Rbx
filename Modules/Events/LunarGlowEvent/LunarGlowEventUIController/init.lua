-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Comma_Module);
local LunarGlowUtils = require(ReplicatedStorage.Modules.Events.LunarGlowEvent.LunarGlowUtils);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.UpdateService);
local Blur_Module = require(ReplicatedStorage.Blur_Module);
local Particle2D = require(ReplicatedStorage.Code.Particle2D);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local Trove = require(ReplicatedStorage.Modules.Trove);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local script_ItemRewarder = require(script.ItemRewarder);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local Config = GameConfigController:GetConfig("LunarGlowConfig");
workspace:GetAttributeChangedSignal("LunarGlowConfig"):Connect(function() -- Line: 28
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("LunarGlowConfig");
end);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local _ = GameEvents.Events.LunarGlowEvent.LunarGlowSubmitHeld;
local _ = GameEvents.Events.LunarGlowEvent.LunarGlowSubmitAll;
local LunarGlowClaimQuestReward = GameEvents.Events.LunarGlowEvent.LunarGlowClaimQuestReward;
local LunarGlowResetQuestData = GameEvents.Events.LunarGlowEvent.LunarGlowResetQuestData;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local LunarGlowQuestRewards = PlayerGui:WaitForChild("LunarGlowQuestRewards");
local Frame = LunarGlowQuestRewards.Frame;
local Main = Frame.Main;
local Holder = Main.Holder;
local MainProgress = Holder.MainProgress;
local ResetProgressionFrame = MainProgress.ResetProgressionFrame;
local Progress = Holder.Progress;
local CURRENT_REWARD = Progress.CurrentReward.CURRENT_REWARD;
local PROGRESSION_AMOUNT = Progress.Bar.PROGRESSION_AMOUNT;
local PROGRESS_FILL = Progress.Bar.PROGRESS_FILL;
local RewardTrack = Frame.RewardTrack;
local LunarGlowQuestProgress = PlayerGui:WaitForChild("LunarGlowQuestProgress");
local PROGRESS_FILL2 = LunarGlowQuestProgress.Progress.Bar.PROGRESS_FILL;
local PremiumCurrency = LunarGlowQuestProgress.Progress.PremiumCurrency;
local CURRENT_REWARD2 = LunarGlowQuestProgress.Progress.CurrentReward.CURRENT_REWARD;
local PROGRESSION_AMOUNT2 = LunarGlowQuestProgress.Progress.Bar.PROGRESSION_AMOUNT;
local u1 = Trove.new();
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local u10 = 0;
local u11 = nil;
local u12 = {};
local u13 = {};

local function PopulateRewardTrack() -- Line: 81
    -- upvalues: RewardTrack (copy), Config (ref), ItemImageFinder (copy), ItemInfoHover (copy)
    local RewardScrollingFrame = RewardTrack.Holder.RewardScrollingFrame;
    local REWARDTRACK_TEMPLATE = RewardScrollingFrame.UIGridLayout.REWARDTRACK_TEMPLATE;
    local v14 = {};

    for _, v in Config.REWARDS do
        local v15 = REWARDTRACK_TEMPLATE:Clone();
        v15.ITEM_IMAGE.Image = ItemImageFinder(v.Value, v.Type);
        v15.PointAmount.Text = v.RequiredExperience;

        if v.Quantity > 1 then
            v15.Count.Text = "+" .. v.Quantity;
        else
            v15.Count.Text = "";
        end;

        v15:SetAttribute("UUID", (`LunarGlowRewards_{v.Type}_{v.Value}`));
        v15:AddTag("ItemInfoHoverTag");
        table.insert(v14, {
            Type = v.Type,
            Value = v.Value,
            Quantity = v.Quantity
        });
        v15.Parent = RewardScrollingFrame;
    end;

    ItemInfoHover:AddRewardTable("LunarGlowRewards", v14);
end;

local function UpdateBloodMoon() -- Line: 111
    -- upvalues: u2 (ref), EventRotationUtils (copy), u3 (ref), u4 (ref)
    if not u2 then
        local v16 = EventRotationUtils:GetEventIDModels("LunarGlowEvent")[1];
        u2 = v16:QueryDescendants(".LunarGlowBloodMoonShrine")[1];
        u3 = u2:QueryDescendants(".BloodMoonProxPrompt")[1];
        u4 = v16:QueryDescendants(".BloodMoonArrow")[1];
    end;

    if not (u2 and (u4 and u3)) then
        return;
    end;

    local v17 = workspace:GetAttribute("BloodMoonEvent") == true;

    for _, descendant in u2:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = v17;
        end;
    end;

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = v17 and 0 or 1;
        end;
    end;

    u3.Enabled = v17;
end;

local function BurstParticles1(p18: userdata) -- Line: 139
    -- upvalues: LunarGlowQuestProgress (copy), TweenService (copy), Particle2D (copy)
    local Random_new_ret = Random.new();

    for i = 1, 10 do
        local v19 = Random_new_ret:NextNumber(0, 359);
        local v20 = Random_new_ret:NextInteger(20, 45);
        local u21 = Random_new_ret:NextInteger(1, 0) == 1 and script.Sparkle:Clone() or script.Sparkle2:Clone();
        local v22 = Random_new_ret:NextNumber(-10, 10);
        local math_rad_ret = math.rad(v19);
        local v23 = v22 * math.cos(math_rad_ret);
        local math_rad_ret2 = math.rad(v19);
        local v24 = v22 * math.sin(math_rad_ret2);
        local v25 = p18.AbsolutePosition + p18.AbsoluteSize / 2;
        u21.Position = UDim2.new(0, v25.X, 0, v25.Y) + UDim2.new(0, v23, 0, v24);
        u21.Size = UDim2.new(0, v20, 0, v20);
        u21.Parent = LunarGlowQuestProgress.Frame;
        local u26 = Random_new_ret:NextNumber(0, 0.5);
        task.spawn(function() -- Line: 158
            -- upvalues: TweenService (ref), u21 (copy), u26 (copy)
            TweenService:Create(u21, TweenInfo.new(1), {
                ImageTransparency = u26
            }):Play();
            task.wait(1);
            TweenService:Create(u21, TweenInfo.new(1), {
                ImageTransparency = 1
            }):Play();
        end);
        local UDim2_new = UDim2.new;
        local math_rad_ret3 = math.rad(v19);
        local v27 = math.cos(math_rad_ret3) * 2500;
        local math_rad_ret4 = math.rad(v19);
        local v28 = UDim2_new(0, v27, 0, math.sin(math_rad_ret4) * -1900);
        local UDim2_new_ret = UDim2.new(0, 0, 4, 0);
        Particle2D.createParticle(u21, 3, v28, Random_new_ret:NextInteger(-45, 45), UDim2_new_ret, UDim2.new(0, 5, 0, 5), 0, 0, nil, 0.3);
        local _ = i;
    end;
end;

local function BurstParticles2() -- Line: 170
    -- upvalues: BurstParticles1 (copy), CURRENT_REWARD2 (copy), LunarGlowQuestProgress (copy), TweenService (copy)
    BurstParticles1(CURRENT_REWARD2);
    local v29 = script.Shockwave:Clone();
    local v30 = CURRENT_REWARD2.AbsolutePosition + CURRENT_REWARD2.AbsoluteSize / 2;
    v29.Position = UDim2.new(0, v30.X, 0, v30.Y);
    v29.Parent = LunarGlowQuestProgress.Frame;
    v29.ZIndex = 1;
    TweenService:Create(v29.UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Scale = 7
    }):Play();
    v29.ImageTransparency = 0;
    TweenService:Create(v29, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        ImageTransparency = 1
    }):Play();
    game.Debris:AddItem(v29, 1);
end;

local function PlayProgressAnimAsync(p31: userdata, p32: number, p33: number, p34: number) -- Line: 185
    -- upvalues: u12 (copy), RunService (copy)
    local v35 = u12[p31];

    if v35 then
        pcall(task.cancel, v35);
    end;

    local coroutine_running_ret = coroutine.running();
    u12[p31] = coroutine_running_ret;
    local v36 = 0;

    while v36 < 1 do
        v36 = v36 + RunService.Heartbeat:Wait();
        local math_lerp_ret = math.lerp(p32, p33, v36 / 1);
        p31.Text = `{math.round(math_lerp_ret)}/{p34}`;
    end;

    p31.Text = `{p33}/{p34}`;

    if u12[p31] == coroutine_running_ret then
        u12[p31] = nil;
    end;
end;

function u13.DisplayUI(p37) -- Line: 212
    -- upvalues: RewardTrack (copy), Main (copy), u13 (copy), GuiController (copy), LunarGlowQuestRewards (copy)
    RewardTrack.Visible = false;
    Main.Visible = true;
    task.spawn(function() -- Line: 215
        -- upvalues: u13 (ref)
        u13:UpdateProgression();
    end);
    GuiController:Open(LunarGlowQuestRewards);
end;

function u13.UpdateProgression(p38) -- Line: 221
    -- upvalues: DataService (copy), LocalPlayer (copy), u10 (ref), u9 (ref), MainProgress (copy), LunarGlowUtils (copy), PROGRESS_FILL (copy), PROGRESSION_AMOUNT (copy), CURRENT_REWARD (copy), ResetProgressionFrame (copy), u6 (ref), Progress (copy), TweenService (copy), u11 (ref), ItemImageFinder (copy), PlayProgressAnimAsync (copy), BurstParticles1 (copy)
    local Data = DataService:GetData();

    if not Data then
        warn((`No player data for {LocalPlayer}!`));

        return;
    end;

    u10 = u10 + 1;
    local v39 = u10;
    u9 = v39;
    local LunarGlowEventData = Data.LunarGlowEventData;
    local QUEST_DETAILS = MainProgress.QUEST_DETAILS;
    local QUEST_DESC_FRAME = MainProgress.QUEST_DESC_FRAME;
    local SmallReward = MainProgress.SmallReward;

    if LunarGlowUtils:IsQuestFinished(LunarGlowEventData) then
        PROGRESS_FILL.Size = UDim2.new(1, 0, 1, 0);
        PROGRESSION_AMOUNT.Text = `{LunarGlowEventData.Experience}/{LunarGlowEventData.Experience}`;
        CURRENT_REWARD.Image = "rbxassetid://0";
        QUEST_DETAILS.Text = "Night Quest is complete - Reset Quest?";
        QUEST_DESC_FRAME.Visible = false;
        ResetProgressionFrame.Visible = true;
        SmallReward.Visible = false;

        return;
    end;

    QUEST_DETAILS.Text = "Free Rewards";
    ResetProgressionFrame.Visible = false;
    QUEST_DESC_FRAME.Visible = true;
    SmallReward.Visible = true;
    local NextQuestReward, v40 = LunarGlowUtils:GetNextQuestReward(LunarGlowEventData);
    local u41 = LunarGlowUtils:ReturnRewardData();

    if not u6 then
        u6 = v40;
    end;

    if u6 ~= v40 then
        for i = u6, v40 - 1 do
            if u9 ~= v39 then
                return;
            end;

            TweenService:Create(Progress.PremiumCurrency.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                Scale = 1.3
            }):Play();
            local u42 = i ~= u6 and 0 or u11;
            PROGRESS_FILL.Size = UDim2.new(0, 0, 1, 0);
            TweenService:Create(PROGRESS_FILL, TweenInfo.new(0.5), {
                Size = UDim2.new(1, 0, 1, 0)
            }):Play();
            CURRENT_REWARD.Image = ItemImageFinder(u41[i].Value, u41[i].Type);
            task.spawn(function() -- Line: 285
                -- upvalues: PlayProgressAnimAsync (ref), PROGRESSION_AMOUNT (ref), u42 (ref), u41 (copy), i (copy)
                PlayProgressAnimAsync(PROGRESSION_AMOUNT, u42, u41[i].RequiredExperience, u41[i].RequiredExperience);
            end);
            task.wait(0.5);
            TweenService:Create(CURRENT_REWARD.Parent.UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                Scale = 1.3
            }):Play();
            BurstParticles1(CURRENT_REWARD);
            task.wait(0.8);
            local _ = i;
        end;

        if u9 ~= v39 then
            return;
        end;

        PROGRESS_FILL.Size = UDim2.new(0, 0, 1, 0);
    end;

    if NextQuestReward then
        local XPForNextReward = LunarGlowUtils:GetXPForNextReward(LunarGlowEventData);
        local math_min_ret = math.min(1, (XPForNextReward - (NextQuestReward.RequiredExperience - LunarGlowEventData.Experience)) / XPForNextReward);
        TweenService:Create(PROGRESS_FILL, TweenInfo.new(0.5), {
            Size = UDim2.new(math_min_ret, 0, 1, 0)
        }):Play();
        local u43 = u6 ~= v40 and 0 or u11;
        CURRENT_REWARD.Image = ItemImageFinder(NextQuestReward.Value, NextQuestReward.Type);
        task.spawn(function() -- Line: 325
            -- upvalues: PlayProgressAnimAsync (ref), PROGRESSION_AMOUNT (ref), u43 (ref), LunarGlowEventData (copy), NextQuestReward (copy)
            PlayProgressAnimAsync(PROGRESSION_AMOUNT, u43, LunarGlowEventData.Experience, NextQuestReward.RequiredExperience);
        end);
        task.delay(0.5, function() -- Line: 329
            -- upvalues: PROGRESSION_AMOUNT (ref), LunarGlowEventData (copy), NextQuestReward (copy)
            PROGRESSION_AMOUNT.Text = `{LunarGlowEventData.Experience}/{NextQuestReward.RequiredExperience}`;
        end);
    else
        TweenService:Create(PROGRESS_FILL, TweenInfo.new(0.5), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play();
        task.delay(0.5, function() -- Line: 305
            -- upvalues: BurstParticles1 (ref), CURRENT_REWARD (ref), PROGRESSION_AMOUNT (ref), LunarGlowEventData (copy)
            BurstParticles1(CURRENT_REWARD);
            PROGRESSION_AMOUNT.Text = `{LunarGlowEventData.Experience}/{LunarGlowEventData.Experience}`;
            CURRENT_REWARD.Image = "rbxassetid://0";
        end);
    end;

    u11 = LunarGlowEventData.Experience;
    u6 = v40;
    local UnclaimedQuestRewards = LunarGlowUtils:GetUnclaimedQuestRewards(LunarGlowEventData);
    local UNCLAIMED_CONTENT = MainProgress.CLAIMREWARD_FRAME.Main.ClaimItems.ScrollingFrame.UNCLAIMED_CONTENT;
    local REWARD_TEMPLATE = UNCLAIMED_CONTENT.UIListLayout.REWARD_TEMPLATE;

    for _, child in UNCLAIMED_CONTENT:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    for _, v in UnclaimedQuestRewards do
        local v44 = REWARD_TEMPLATE:Clone();
        v44.ITEM_IMAGE.Image = ItemImageFinder(v.Value, v.Type);

        if v.Quantity > 1 then
            v44:WaitForChild("Count").Text = "+" .. v.Quantity;
        else
            v44:WaitForChild("Count").Text = "";
        end;

        v44.Parent = UNCLAIMED_CONTENT;
    end;
end;

local function SignalFromServer() -- Line: 364
    -- upvalues: u8 (ref), u7 (ref), LunarGlowQuestProgress (copy), TweenService (copy), DataService (copy), LocalPlayer (copy), LunarGlowUtils (copy), u5 (ref), u11 (ref), PremiumCurrency (copy), PROGRESS_FILL2 (copy), CURRENT_REWARD2 (copy), ItemImageFinder (copy), PlayProgressAnimAsync (copy), PROGRESSION_AMOUNT2 (copy), BurstParticles2 (copy), script_ItemRewarder (copy)
    u8 = u8 + 1;
    local u45 = u8;
    u7 = u45;
    LunarGlowQuestProgress.Enabled = true;
    LunarGlowQuestProgress.Progress.Visible = true;
    TweenService:Create(LunarGlowQuestProgress.Progress, TweenInfo.new(0.4), {
        GroupTransparency = 0
    }):Play();
    local Data = DataService:GetData();

    if not Data then
        warn((`No player data for {LocalPlayer}!`));

        return;
    end;

    local LunarGlowEventData = Data.LunarGlowEventData;
    local NextQuestReward, v46 = LunarGlowUtils:GetNextQuestReward(LunarGlowEventData);
    local u47 = LunarGlowUtils:ReturnRewardData();

    if u5 then
        if u5 == "RESET" then
            u5 = 1;
            u11 = 0;
        end;
    else
        u5 = v46;
    end;

    local v48 = {};

    if u5 ~= v46 then
        local v49 = nil;

        if v46 == nil then
            v46 = u5 + 1;
            v49 = true;
        elseif v46 < u5 then
            u5 = 1;
        end;

        for i = u5, v46 - 1 do
            table.insert(v48, u47[i]);

            if u7 ~= u45 then
                break;
            end;

            TweenService:Create(PremiumCurrency.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                Scale = 1.3
            }):Play();
            local u50 = i ~= u5 and 0 or u11;
            PROGRESS_FILL2.Size = UDim2.new(0, 0, 1, 0);
            TweenService:Create(PROGRESS_FILL2, TweenInfo.new(0.5), {
                Size = UDim2.new(1, 0, 1, 0)
            }):Play();
            CURRENT_REWARD2.Image = ItemImageFinder(u47[i].Value, u47[i].Type);
            task.spawn(function() -- Line: 423
                -- upvalues: PlayProgressAnimAsync (ref), PROGRESSION_AMOUNT2 (ref), u50 (ref), u47 (copy), i (copy)
                PlayProgressAnimAsync(PROGRESSION_AMOUNT2, u50, u47[i].RequiredExperience, u47[i].RequiredExperience);
            end);
            task.wait(0.5);
            TweenService:Create(CURRENT_REWARD2.Parent.UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                Scale = 1.3
            }):Play();
            BurstParticles2();
            task.wait(0.8);
            local _ = i;
        end;

        if u7 ~= u45 then
            return;
        end;

        if v49 then
            v46 = nil;
        end;

        PROGRESS_FILL2.Size = UDim2.new(0, 0, 1, 0);
    end;

    if NextQuestReward then
        local XPForNextReward = LunarGlowUtils:GetXPForNextReward(LunarGlowEventData);
        local math_min_ret = math.min(1, (XPForNextReward - (NextQuestReward.RequiredExperience - LunarGlowEventData.Experience)) / XPForNextReward);
        TweenService:Create(PROGRESS_FILL2, TweenInfo.new(0.5), {
            Size = UDim2.new(math_min_ret, 0, 1, 0)
        }):Play();
        local u51 = u5 ~= v46 and 0 or u11;
        CURRENT_REWARD2.Image = ItemImageFinder(NextQuestReward.Value, NextQuestReward.Type);
        task.spawn(function() -- Line: 468
            -- upvalues: PlayProgressAnimAsync (ref), PROGRESSION_AMOUNT2 (ref), u51 (ref), LunarGlowEventData (copy), NextQuestReward (copy), u11 (ref)
            PlayProgressAnimAsync(PROGRESSION_AMOUNT2, u51, LunarGlowEventData.Experience, NextQuestReward.RequiredExperience);
            u11 = LunarGlowEventData.Experience;
        end);
        task.delay(0.5, function() -- Line: 473
            -- upvalues: PROGRESSION_AMOUNT2 (ref), LunarGlowEventData (copy), NextQuestReward (copy)
            PROGRESSION_AMOUNT2.Text = `{LunarGlowEventData.Experience}/{NextQuestReward.RequiredExperience}`;
        end);
    else
        TweenService:Create(PROGRESS_FILL2, TweenInfo.new(0.5), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play();
        task.delay(0.5, function() -- Line: 447
            -- upvalues: BurstParticles2 (ref), PROGRESSION_AMOUNT2 (ref), LunarGlowEventData (copy), CURRENT_REWARD2 (ref)
            BurstParticles2();
            PROGRESSION_AMOUNT2.Text = `{LunarGlowEventData.Experience}/{LunarGlowEventData.Experience}`;
            CURRENT_REWARD2.Image = "rbxassetid://0";
        end);
    end;

    if v46 == nil then
        u5 = "RESET";
    else
        u5 = v46;
    end;

    task.delay(3, function() -- Line: 484
        -- upvalues: u7 (ref), u45 (copy), TweenService (ref), LunarGlowQuestProgress (ref)
        if u7 == u45 then
            TweenService:Create(LunarGlowQuestProgress.Progress, TweenInfo.new(0.4), {
                GroupTransparency = 1
            }):Play();
            task.delay(0.4, function() -- Line: 488
                -- upvalues: u7 (ref), u45 (ref), LunarGlowQuestProgress (ref)
                if u7 == u45 then
                    LunarGlowQuestProgress.Progress.Visible = false;
                    LunarGlowQuestProgress.Enabled = false;
                end;
            end);
        end;
    end);

    if #v48 > 0 then
        script_ItemRewarder.UnlockItems(v48);
    end;
end;

function u13.Start(p52) -- Line: 502
    -- upvalues: GuiController (copy), LunarGlowQuestRewards (copy), Holder (copy), u1 (copy), RewardTrack (copy), Main (copy), Frame (copy), MainProgress (copy), LunarGlowClaimQuestReward (copy), ResetProgressionFrame (copy), CommaFormatNumber (copy), Config (ref), Blur_Module (copy), LunarGlowResetQuestData (copy), MarketController (copy), EventRotationUtils (copy), u13 (copy), UpdateBloodMoon (copy), NumberUtil (copy), DataService (copy), SignalFromServer (copy), u11 (ref), LunarGlowUtils (copy), u5 (ref), PopulateRewardTrack (copy), RunService (copy)
    GuiController:GetStateForGui(LunarGlowQuestRewards);
    GuiController:UsePopupAnims(LunarGlowQuestRewards);
    u1:Add(Holder.BigReward.TrackButton.TRACK_BUTTON.Activated:Connect(function() -- Line: 507
        -- upvalues: RewardTrack (ref), Main (ref)
        RewardTrack.Visible = true;
        Main.Visible = false;
    end));
    u1:Add(RewardTrack.Holder.Header.ReturnButton.RETURN_BUTTON.Activated:Connect(function() -- Line: 513
        -- upvalues: RewardTrack (ref), Main (ref)
        RewardTrack.Visible = false;
        Main.Visible = true;
    end));
    u1:Add(Frame.Exit.EXIT_BUTTON.Activated:Connect(function() -- Line: 519
        -- upvalues: GuiController (ref), LunarGlowQuestRewards (ref)
        GuiController:Close(LunarGlowQuestRewards);
    end));
    u1:Add(MainProgress.CLAIMREWARD_FRAME.ClaimButton.CONFIRM_BUTTON.Activated:Connect(function() -- Line: 524
        -- upvalues: LunarGlowClaimQuestReward (ref), GuiController (ref), LunarGlowQuestRewards (ref)
        LunarGlowClaimQuestReward:FireServer();
        GuiController:Close(LunarGlowQuestRewards);
    end));
    local ShecklesButton = ResetProgressionFrame.Btns.PurchaseCash.ShecklesButton;
    ShecklesButton.TextLabel.Text = CommaFormatNumber(Config.QUESTS.ShecklesResetCost) .. "¢";
    u1:Add(ShecklesButton.Activated:Connect(function() -- Line: 531
        -- upvalues: Blur_Module (ref), LunarGlowResetQuestData (ref), GuiController (ref), LunarGlowQuestRewards (ref)
        Blur_Module.Blur(0, 0.3);
        LunarGlowResetQuestData:FireServer();
        GuiController:Close(LunarGlowQuestRewards);
    end));
    local RobuxButton = ResetProgressionFrame.Btns.PurchaseRobux.RobuxButton;
    u1:Add(RobuxButton.Activated:Connect(function() -- Line: 538
        -- upvalues: Blur_Module (ref), MarketController (ref), GuiController (ref), LunarGlowQuestRewards (ref)
        Blur_Module.Blur(0, 0.3);
        MarketController:PromptPurchase(3280732293, Enum.InfoType.Product);
        GuiController:Close(LunarGlowQuestRewards);
    end));
    u1:Add(EventRotationUtils:GetEventIDModels("LunarGlowEvent")[1]:QueryDescendants(".LunarGlowSmallOwlPrompt")[1].Triggered:Connect(function() -- Line: 546
        -- upvalues: u13 (ref)
        u13:DisplayUI();
    end));
    u1:Add(workspace:GetAttributeChangedSignal("BloodMoonEvent"):Connect(function() -- Line: 550
        -- upvalues: UpdateBloodMoon (ref)
        UpdateBloodMoon();
    end));
    u1:Add(task.spawn(function() -- Line: 554
        -- upvalues: MarketController (ref), RobuxButton (copy)
        MarketController:SetPriceLabel(RobuxButton.TextLabel, 3280732293, ":robux::value:");
    end));
    u1:Add(task.spawn(function() -- Line: 558
        -- upvalues: Holder (ref), EventRotationUtils (ref), NumberUtil (ref)
        local TIMER_LABEL = Holder.Header.EventTimer.TIMER_LABEL;
        local _, _, v53 = EventRotationUtils:GetCurrentEvent();

        while wait(1) do
            TIMER_LABEL.Text = `Ends in {NumberUtil.compactFormat(v53 - os.time())}`;
        end;

        TIMER_LABEL.Text = "";
    end));
    u1:Add(DataService:GetPathSignal("LunarGlowEventData/Experience"):Connect(function() -- Line: 567
        -- upvalues: SignalFromServer (ref), Main (ref), u13 (ref)
        task.spawn(SignalFromServer);

        if Main.Visible then
            u13:UpdateProgression();
        end;
    end));
    local Data = DataService:GetData();

    if Data then
        local LunarGlowEventData = Data.LunarGlowEventData;
        u11 = LunarGlowEventData.Experience;
        local _, v54 = LunarGlowUtils:GetNextQuestReward(LunarGlowEventData);
        LunarGlowUtils:ReturnRewardData();
        u5 = v54;
    end;

    PopulateRewardTrack();
    UpdateBloodMoon();
    local v55 = MainProgress.SmallReward:QueryDescendants(".SpinUI");
    local v56 = Main.Holder.BigReward:QueryDescendants(".SpinUI");
    local u57 = {};

    for _, v in v55 do
        table.insert(u57, v);
    end;

    for _, v in v56 do
        table.insert(u57, v);
    end;

    RunService.RenderStepped:Connect(function(p58) -- Line: 606
        -- upvalues: u57 (copy)
        if #u57 == 0 then
            return;
        end;

        local v59 = 30 * p58;

        for _, v in u57 do
            v.Rotation = (v.Rotation + v59) % 360;
        end;
    end);
end;

local u60 = false;
EventRotationController.EventUpdated:Connect(function(p61: string, p62: string) -- Line: 616, Name: OnEventUpdated
    -- upvalues: u1 (copy), u60 (ref), u13 (copy)
    if p62 ~= "LunarGlowEvent" then
        u1:Clean();
        u60 = false;

        return;
    end;

    if u60 then
        return;
    end;

    u60 = true;
    u1:Clean();
    task.spawn(u13.Start, u13);
end);

return u13;