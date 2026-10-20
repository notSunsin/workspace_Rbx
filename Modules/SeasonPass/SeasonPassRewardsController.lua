-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
game:GetService("RunService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local SeasonPassUtils = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassUtils);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local SkipTierData = require(ReplicatedStorage.Data.SeasonPass.SkipTierData);
local SeasonPassData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassData);
local ImageCycle = require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local SeasonPassButtonEffects = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassButtonEffects);
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local GameEvents = ReplicatedStorage.GameEvents;
local ClaimSeasonPassReward = GameEvents.SeasonPass.ClaimSeasonPassReward;
local ProgressSeasonPassBar = GameEvents.SeasonPass.ProgressSeasonPassBar;
local ClaimSeasonPassInfReward = GameEvents.SeasonPass.ClaimSeasonPassInfReward;
local LocalPlayer = Players.LocalPlayer;
local SeasonPassUI = LocalPlayer.PlayerGui.SeasonPassUI;
local SeasonPassTemplates = SeasonPassUI.SeasonPassTemplates;
local Rewards = SeasonPassUI.SeasonPassFrame.Main.Rewards.ScrollingFrame.Rewards;
local InfReward = Rewards.InfReward;
local BPLevel = SeasonPassUI.SeasonPassFrame.Main.Rewards.BPLevel;
local Fill = BPLevel.Fill;
local TextLabel = BPLevel.LvlDisplay.TextLabel;
local BPLevel2 = SeasonPassUI.SeasonPassFrame.Main.Quests.BPLevel;
local Fill2 = BPLevel2.Fill;
local TextLabel2 = BPLevel2.LvlDisplay.TextLabel;
local FillProg = SeasonPassUI.SeasonPassFrame.Main.Rewards.ScrollingFrame.FillProg;
local Scale = SeasonPassUI.SeasonPassFrame.Main.Rewards.ScrollingFrame.Progress.Size.X.Scale;
local SkipOptions = SeasonPassUI.SeasonPassFrame.Main.Rewards.SkipOptions;
local Notify = LocalPlayer.PlayerGui.Hud_UI.SideBtns.Pass.Notify;
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = 0;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local MAX_LEVEL = SeasonPassStaticData.MAX_LEVEL;
local u9 = {};

local function PulseFrame(u10: userdata) -- Line: 63
    -- upvalues: TweenService (copy), u1 (copy)
    task.spawn(function() -- Line: 64
        -- upvalues: u10 (copy), TweenService (ref), u1 (ref)
        local UIScale = u10:FindFirstChild("UIScale");
        local v11 = TweenService:Create(UIScale, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Scale = 1.25
        });
        local v12 = TweenService:Create(UIScale, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            Scale = 1
        });

        if not u1[u10.Name] then
            u1[u10.Name] = { v11, v12 };

            while u1[u10.Name] do
                v11:Play();
                v11.Completed:Wait();
                v12:Play();
                v12.Completed:Wait();
            end;
        end;
    end);
end;

local function MoveBarTween(p13: userdata, p14: number, p15: number, p16: number) -- Line: 87
    -- upvalues: TweenService (copy)
    local v17 = math.sqrt(p16) * 0.05;

    return TweenService:Create(p13, TweenInfo.new(v17, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Size = UDim2.fromScale(math.clamp(p14, 0, p15), p13.Size.Y.Scale)
    });
end;

local function UpdateInfReward(p18: number) -- Line: 96
    -- upvalues: SeasonPassUtils (copy), SkipOptions (copy), Fill (copy), Fill2 (copy), BPLevel (copy), BPLevel2 (copy), InfReward (copy), DataService (copy), SeasonPassData (copy), MAX_LEVEL (copy), SeasonPassStaticData (copy), NumberUtil (copy), TweenService (copy), u1 (copy), u4 (ref), Notify (copy)
    SeasonPassUtils.ToggleButton(SkipOptions.All, false);
    Fill.Size = UDim2.fromScale(1, Fill.Size.Y.Scale);
    Fill2.Size = UDim2.fromScale(Fill.Size.X.Scale, Fill2.Size.Y.Scale);
    BPLevel.Exp.Text = "COMPLETED";
    BPLevel2.Exp.Text = BPLevel.Exp.Text;
    InfReward.Image.Locked.Visible = false;
    local Data = DataService:GetData();

    if not Data then
        warn("No player data");

        return;
    end;

    local v19 = SeasonPassData.CurrentSeason and Data.SeasonPass[SeasonPassData.CurrentSeason];

    if not v19 then
        return;
    end;

    local v20 = p18 - SeasonPassUtils.CalculateXPForLevel(MAX_LEVEL);
    local InfRewardsClaimed = v19.InfRewardsClaimed;
    local v21 = SeasonPassUtils.CalculateInfClaimCount(p18, InfRewardsClaimed);
    local INF_REWARD_XP = SeasonPassStaticData.INF_REWARD_XP;
    local v22 = NumberUtil.RoundToDP(math.clamp(v20 - InfRewardsClaimed * INF_REWARD_XP, 0, INF_REWARD_XP), 2);
    InfReward.Image.Progress.Text = `{v22}/{INF_REWARD_XP}XP`;
    local ClaimInfReward = InfReward.Image.ClaimInfReward;
    local ClaimCountNotif = ClaimInfReward.ClaimCountNotif;
    local Count = ClaimCountNotif.Count;
    ClaimCountNotif.Visible = v21 >= 1;
    Count.Text = `{v21}`;
    task.spawn(function() -- Line: 64
        -- upvalues: ClaimCountNotif (copy), TweenService (ref), u1 (ref)
        local UIScale = ClaimCountNotif:FindFirstChild("UIScale");
        local v23 = TweenService:Create(UIScale, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Scale = 1.25
        });
        local v24 = TweenService:Create(UIScale, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
            Scale = 1
        });

        if not u1[ClaimCountNotif.Name] then
            u1[ClaimCountNotif.Name] = { v23, v24 };

            while u1[ClaimCountNotif.Name] do
                v23:Play();
                v23.Completed:Wait();
                v24:Play();
                v24.Completed:Wait();
            end;
        end;
    end);
    SeasonPassUtils.ToggleButton(ClaimInfReward, v21 >= 1);
    local v25;

    if v21 >= 1 then
        v25 = u4 + 1;
    else
        v25 = u4;
    end;

    u4 = v25;
    Notify.Visible = v21 >= 1;
end;

local function ActivateTierReward(p26: any, p27: number) -- Line: 140
    -- upvalues: SeasonPassData (copy), DataService (copy), TweenService (copy), BPLevel (copy), TextLabel (copy), MAX_LEVEL (copy), TextLabel2 (copy), SeasonPassUtils (copy), u4 (ref), Notify (copy)
    if not SeasonPassData.CurrentSeason then
        warn("SeasonPassRewardsController | Season Pass not found!");

        return;
    end;

    local Data = DataService:GetData();

    if not Data then
        warn("SeasonPassUIController | No player data");

        return;
    end;

    local v28 = TweenService:Create(BPLevel.LvlDisplay.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Scale = 1.15
    });
    v28:Play();
    v28.Completed:Wait();
    TextLabel.Text = `{math.min(p27 + 1, MAX_LEVEL)}`;
    TextLabel2.Text = TextLabel.Text;
    TweenService:Create(BPLevel.LvlDisplay.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Scale = 1
    }):Play();
    local v29 = p26:FindFirstChild((`Premium{p27}`));
    local v30 = p26:FindFirstChild((`Free{p27}`));

    if not (v29 and v30) then
        warn((`Missing RewardFrames for Premium and/or Free Tier {p27}`));
    end;

    local Claim = v29.Claim;
    local Claim2 = v30.Claim;

    if not Data.SeasonPass[SeasonPassData.CurrentSeason] then
        return;
    end;

    local table_find_ret = table.find(Data.SeasonPass[SeasonPassData.CurrentSeason].ClaimedLevelPremiumRewards, p27);

    if not table.find(Data.SeasonPass[SeasonPassData.CurrentSeason].ClaimedLevelFreeRewards, p27) then
        v30.Locked.Visible = false;
        v30.Checkmark.Visible = false;
        SeasonPassUtils.ToggleButton(Claim2, true);
        u4 = u4 + 1;
        Notify.Visible = true;
    end;

    if not table_find_ret and Data.SeasonPass[SeasonPassData.CurrentSeason].IsPremium then
        v29.Locked.Visible = false;
        v29.Checkmark.Visible = false;
        SeasonPassUtils.ToggleButton(Claim, Data.SeasonPass[SeasonPassData.CurrentSeason].IsPremium);
        u4 = u4 + 1;
        Notify.Visible = true;
    end;

    local v31 = p26:FindFirstChild((`Tier{p27}`));
    v31.Image = "rbxassetid://89980127975261";
    v31.Visible = true;
end;

local function UpdateTierLevelBar(u32: number, u33: number) -- Line: 209
    -- upvalues: DataService (copy), SeasonPassUtils (copy), MAX_LEVEL (copy), BPLevel (copy), BPLevel2 (copy), UpdateInfReward (copy), MoveBarTween (copy), Fill (copy), Fill2 (copy), FillProg (copy), Scale (copy), NumberUtil (copy), Rewards (copy), ActivateTierReward (copy)
    task.spawn(function() -- Line: 210
        -- upvalues: DataService (ref), SeasonPassUtils (ref), u33 (copy), u32 (copy), MAX_LEVEL (ref), BPLevel (ref), BPLevel2 (ref), UpdateInfReward (ref), MoveBarTween (ref), Fill (ref), Fill2 (ref), FillProg (ref), Scale (ref), NumberUtil (ref), Rewards (ref), ActivateTierReward (ref)
        if not DataService:GetData() then
            warn("SeasonPassUIController | No player data");

            return;
        end;

        local v34 = SeasonPassUtils.CalculateLevel(u33);
        local v35 = SeasonPassUtils.CalculateLevel(u32);
        local v36 = u33 - u32;
        local v37 = u32;

        local function stopUpdatingText(p38: number) -- Line: 224
            -- upvalues: SeasonPassUtils (ref), MAX_LEVEL (ref), BPLevel (ref), BPLevel2 (ref)
            local v39 = SeasonPassUtils.CalculateXPForLevel(p38);
            local v40 = SeasonPassUtils.CalculateXPForLevel(p38 + 1) - v39;

            if MAX_LEVEL <= p38 then
                BPLevel.Exp.Text = "COMPLETED";
                BPLevel2.Exp.Text = BPLevel.Exp.Text;

                return;
            end;

            BPLevel.Exp.Text = `0/{v40}`;
            BPLevel2.Exp.Text = BPLevel.Exp.Text;
        end;

        local v41 = v35;

        while true do
            local XPEarnedCurrentLevel = SeasonPassUtils.GetXPEarnedCurrentLevel(v37);
            local TotalXPForNextLevel = SeasonPassUtils.GetTotalXPForNextLevel(v37);
            local v42 = TotalXPForNextLevel - XPEarnedCurrentLevel;

            if v36 - v42 <= 0 then
                v42 = v36;
            end;

            v37 = v37 + v42;
            v36 = v36 - v42;
            stopUpdatingText(v35);
            local v43 = SeasonPassUtils.CalculateLevel(v37);
            local v44 = v37 - SeasonPassUtils.CalculateXPForLevel(MAX_LEVEL);

            if v44 >= 1 then
                UpdateInfReward(u33);

                return;
            end;

            if v44 == 0 then
                UpdateInfReward(u33);
            end;

            local math_clamp_ret = math.clamp((XPEarnedCurrentLevel + v42) / TotalXPForNextLevel, 0, 1);
            local v45 = MoveBarTween(Fill, math_clamp_ret, 1, v34);
            local v46 = MoveBarTween(Fill2, math_clamp_ret, 1, v43);
            local v47 = MoveBarTween(FillProg, (v43 + SeasonPassUtils.GetXPFractionOfCurrentLevel(v37)) / MAX_LEVEL * Scale, Scale, v34);
            v46:Play();
            v45:Play();
            local v48 = SeasonPassUtils.CalculateXPForLevel(v43);
            local v49 = SeasonPassUtils.CalculateXPForLevel(v43 + 1) - v48;
            BPLevel.Exp.Text = `{NumberUtil.RoundToDP(XPEarnedCurrentLevel + v42, 2)}/{v49}`;
            BPLevel2.Exp.Text = BPLevel.Exp.Text;
            v47:Play();
            v47.Completed:Wait();

            if v41 < v43 then
                stopUpdatingText(v43);
                ActivateTierReward(Rewards:FindFirstChild((`Tier{v43}RewardFrame`)), v43);
                v41 = v43;
            end;

            local v50 = math.sqrt(v34) * 0.01;
            task.wait(v50 * 0.5);

            if Fill.Size.X.Scale == 1 and v43 < 50 then
                Fill.Size = UDim2.fromScale(0, Fill.Size.Y.Scale);
                Fill2.Size = UDim2.fromScale(Fill.Size.X.Scale, Fill2.Size.Y.Scale);
            end;

            if v36 <= 0 then
                return;
            end;
        end;
    end);
end;

local function SetUpTrackRewards() -- Line: 326
    -- upvalues: DataService (copy), SeasonPassData (copy), SeasonPassUtils (copy), SeasonPassTemplates (copy), ImageCycle (copy), u3 (copy), SeasonPassButtonEffects (copy), ClaimSeasonPassReward (copy), u4 (ref), Notify (copy), InfReward (copy), MAX_LEVEL (copy), u2 (copy), Rewards (copy), ActivateTierReward (copy), TextLabel (copy), TextLabel2 (copy), MoveBarTween (copy), FillProg (copy), Scale (copy), Fill (copy), Fill2 (copy), BPLevel (copy), NumberUtil (copy), BPLevel2 (copy), SeasonPassStaticData (copy), u5 (ref), UpdateInfReward (copy), u8 (ref), u7 (ref), ClaimSeasonPassInfReward (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("No player data");

        return;
    end;

    if not SeasonPassData.CurrentSeason then
        return;
    end;

    if not Data.SeasonPass[SeasonPassData.CurrentSeason] then
        return;
    end;

    local TotalExperience = Data.SeasonPass[SeasonPassData.CurrentSeason].TotalExperience;
    local u51 = SeasonPassUtils.CalculateLevel(TotalExperience);
    local RewardFrameTemplate = SeasonPassTemplates.RewardFrameTemplate;
    local FinalRewardFrameTemplate = SeasonPassTemplates.FinalRewardFrameTemplate;

    local function rewardFrameSetup(u52: any, p53: number, u54: number, u55: string) -- Line: 349
        -- upvalues: SeasonPassData (ref), ImageCycle (ref), Data (copy), SeasonPassUtils (ref), u3 (ref), SeasonPassButtonEffects (ref), ClaimSeasonPassReward (ref), u4 (ref), Notify (ref)
        local v56 = SeasonPassData[`{u55}Rewards`][u54];

        if not v56 then
            warn((`No rewards for {u55} {u54}`));

            return;
        end;

        u52.Name = `{u55}{u54}`;
        u52.Visible = false;
        ImageCycle.CycleRewardImages(u52.Vector, u52.TextLabel, nil, u52, v56, true);
        u52.Visible = true;
        local v57 = table.find(Data.SeasonPass[SeasonPassData.CurrentSeason][`ClaimedLevel{u55}Rewards`], u54) and true or false;
        u52.Checkmark.Visible = v57;

        if u55 == "Premium" then
            u52.Locked.Visible = p53 < u54 and true or not Data.SeasonPass[SeasonPassData.CurrentSeason].IsPremium;
        else
            u52.Locked.Visible = p53 < u54;
        end;

        SeasonPassUtils.ToggleButton(u52.Claim, false);

        if u3[`{u55}{u54}`] then
            u3[`{u55}{u54}`][1]:Disconnect();
            u3[`{u55}{u54}`][2]:Disconnect();
            u3[`{u55}{u54}`] = nil;
        end;

        local u58 = nil;
        local u59 = u52.Claim.Activated:Once(function() -- Line: 380
            -- upvalues: SeasonPassButtonEffects (ref), ClaimSeasonPassReward (ref), u54 (copy), u55 (copy), u52 (copy), SeasonPassUtils (ref), u58 (ref), u4 (ref), Notify (ref)
            SeasonPassButtonEffects.Click();
            ClaimSeasonPassReward:FireServer(u54, u55 == "Premium");
            u52.Checkmark.Visible = true;
            SeasonPassUtils.ToggleButton(u52.Claim, false);
            u58:Disconnect();
            u4 = u4 - 1;
            Notify.Visible = u4 > 0;
        end);
        u58 = u52.Claim.MouseEnter:Connect(function() -- Line: 390
            -- upvalues: SeasonPassButtonEffects (ref)
            SeasonPassButtonEffects.Hover();
        end);
        u52.Claim.Destroying:Once(function() -- Line: 393
            -- upvalues: u59 (ref), u58 (ref)
            u59:Disconnect();
            u58:Disconnect();
        end);
        local v60 = { u59, u58 };
        u3[`{u55}{u54}`] = v60;
    end;

    InfReward.Image.ClaimInfReward.ClaimCountNotif.Visible = false;

    for i = 1, MAX_LEVEL do
        task.spawn(function() -- Line: 408
            -- upvalues: i (copy), MAX_LEVEL (ref), FinalRewardFrameTemplate (copy), RewardFrameTemplate (copy), u2 (ref), Rewards (ref), rewardFrameSetup (copy), u51 (copy), ActivateTierReward (ref)
            local v61;

            if i == MAX_LEVEL then
                v61 = FinalRewardFrameTemplate;
            else
                v61 = RewardFrameTemplate;
            end;

            local v62 = u2[i];

            if not v62 then
                v62 = v61:Clone();
                v62.Name = `Tier{i}RewardFrame`;
                v62.LayoutOrder = i;
                v62.Parent = Rewards;
                u2[i] = v62;
            end;

            local v63 = v62:FindFirstChild("Free") or v62:FindFirstChild((`Free{i}`));
            local v64 = v62:FindFirstChild("Premium") or v62:FindFirstChild((`Premium{i}`));
            rewardFrameSetup(v63, u51, i, "Free");
            rewardFrameSetup(v64, u51, i, "Premium");
            v62.Visible = true;
            local v65 = v62:FindFirstChild("Number") or v62:FindFirstChild((`Tier{i}`));
            v65.Name = `Tier{i}`;
            v65.Image = u51 < i and "rbxassetid://94566582297171" or "rbxassetid://89980127975261";
            v65:FindFirstChild("TextLabel").Text = `{i}`;
            v65.Visible = true;

            if i <= u51 then
                ActivateTierReward(v62, i);
            end;
        end);
        local _ = i;
    end;

    TextLabel.Text = `{math.min(u51 + 1, MAX_LEVEL)}`;
    TextLabel2.Text = TextLabel.Text;
    MoveBarTween(FillProg, (u51 + SeasonPassUtils.GetXPFractionOfCurrentLevel(TotalExperience)) / MAX_LEVEL * Scale, Scale, u51):Play();
    local TotalXPForNextLevel = SeasonPassUtils.GetTotalXPForNextLevel(TotalExperience);
    local XPEarnedCurrentLevel = SeasonPassUtils.GetXPEarnedCurrentLevel(TotalExperience);
    local math_clamp_ret = math.clamp(XPEarnedCurrentLevel / TotalXPForNextLevel, 0, 1);
    Fill.Size = UDim2.fromScale(math_clamp_ret, Fill.Size.Y.Scale);
    Fill2.Size = UDim2.fromScale(Fill.Size.X.Scale, Fill2.Size.Y.Scale);
    BPLevel.Exp.Text = `{NumberUtil.RoundToDP(XPEarnedCurrentLevel, 2)}/{TotalXPForNextLevel}`;
    BPLevel2.Exp.Text = BPLevel.Exp.Text;
    local u66 = MAX_LEVEL + 1;
    local Vector = InfReward.Image.Vector;
    local TextLabel3 = InfReward.Image.TextLabel;
    local InfRewards = SeasonPassData.InfRewards;
    InfReward.Visible = false;
    ImageCycle.CycleRewardImages(Vector, TextLabel3, nil, InfReward, InfRewards, true);
    InfReward.Visible = true;
    InfReward.Image.Locked.Visible = u51 < u66;
    InfReward.LayoutOrder = u66;
    local v67 = TotalExperience - SeasonPassUtils.CalculateXPForLevel(MAX_LEVEL);
    local INF_REWARD_XP = SeasonPassStaticData.INF_REWARD_XP;
    local v68 = NumberUtil.RoundToDP(math.clamp(v67 - Data.SeasonPass[SeasonPassData.CurrentSeason].InfRewardsClaimed * INF_REWARD_XP, 0, INF_REWARD_XP), 2);
    InfReward.Image.Progress.Text = `{v68}/{INF_REWARD_XP}XP`;
    SeasonPassUtils.ToggleButton(InfReward.Image.ClaimInfReward, false);

    if u5 then
        u5:Disconnect();
        local PathSignal = DataService:GetPathSignal((`SeasonPass/{SeasonPassData.CurrentSeason}/InfRewardsClaimed/@`));

        if PathSignal then
            u5 = PathSignal:Connect(function(p69: string, p70: any, p71: string) -- Line: 486
                -- upvalues: DataService (ref), SeasonPassData (ref), UpdateInfReward (ref)
                local Data2 = DataService:GetData();

                if not Data2 then
                    warn("No player data");

                    return;
                end;

                local v72 = SeasonPassData.CurrentSeason and Data2.SeasonPass[SeasonPassData.CurrentSeason];

                if not v72 then
                    return;
                end;

                UpdateInfReward(v72.TotalExperience);
            end);
        end;
    end;

    if u8 then
        u8:Disconnect();
    end;

    if u7 then
        u7:Disconnect();
    end;

    u8 = InfReward.Image.ClaimInfReward.Activated:Connect(function() -- Line: 507
        -- upvalues: SeasonPassButtonEffects (ref), ClaimSeasonPassInfReward (ref), u66 (copy), InfReward (ref), SeasonPassStaticData (ref), SeasonPassUtils (ref), u7 (ref)
        SeasonPassButtonEffects.Click();
        ClaimSeasonPassInfReward:FireServer(u66, false);
        InfReward.Image.Progress.Text = `0/{SeasonPassStaticData.INF_REWARD_XP}XP`;
        SeasonPassUtils.ToggleButton(InfReward.Image.ClaimInfReward, false);
        u7:Disconnect();
    end);
    u7 = InfReward.Image.ClaimInfReward.MouseEnter:Connect(function() -- Line: 514
        -- upvalues: SeasonPassButtonEffects (ref)
        SeasonPassButtonEffects.Hover();
    end);

    if MAX_LEVEL <= u51 then
        UpdateInfReward(TotalExperience);
    end;
end;

local u73 = {};
local u74 = {};

local function SetUpRobuxButtons() -- Line: 527
    -- upvalues: DataService (copy), SeasonPassData (copy), SeasonPassUtils (copy), SkipOptions (copy), u73 (copy), SeasonPassButtonEffects (copy), DevProductIds (copy), MarketController (copy), MAX_LEVEL (copy), u74 (ref), SkipTierData (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    if not SeasonPassData.CurrentSeason then
        return;
    end;

    if not Data.SeasonPass[SeasonPassData.CurrentSeason] then
        return;
    end;

    local v75 = SeasonPassUtils.CalculateLevel(Data.SeasonPass[SeasonPassData.CurrentSeason].TotalExperience);
    local Tier = SkipOptions.Tier;

    if #u73 == 0 then
        local v76 = Tier.Activated:Connect(function() -- Line: 546
            -- upvalues: SeasonPassButtonEffects (ref), DevProductIds (ref), MarketController (ref)
            SeasonPassButtonEffects.Click();
            local PurchaseID = DevProductIds.SkipSeasonPassTier.PurchaseID;

            if PurchaseID == 0 or not PurchaseID then
                warn("Warning: DevProdID is 0");

                return;
            end;

            MarketController:PromptPurchase(PurchaseID, Enum.InfoType.Product);
        end);
        local v77 = Tier.MouseEnter:Connect(function() -- Line: 556
            -- upvalues: SeasonPassButtonEffects (ref)
            SeasonPassButtonEffects.Hover();
        end);
        table.insert(u73, v76);
        table.insert(u73, v77);
    end;

    local All = SkipOptions.All;

    if MAX_LEVEL <= v75 then
        SeasonPassUtils.ToggleButton(All, false);

        if u74[1] then
            u74[1]:Disconnect();
            u74[2]:Disconnect();
            u74 = {};
        end;
    else
        SeasonPassUtils.ToggleButton(All, true, "Gold");
    end;

    if #u74 == 0 then
        local v80 = All.Activated:Connect(function() -- Line: 578
            -- upvalues: SeasonPassButtonEffects (ref), DataService (ref), SeasonPassData (ref), SeasonPassUtils (ref), SkipTierData (ref), MarketController (ref)
            SeasonPassButtonEffects.Click();
            local Data2 = DataService:GetData();

            if not Data2 then
                warn("No player data");

                return;
            end;

            local v78 = SeasonPassData.CurrentSeason and Data2.SeasonPass[SeasonPassData.CurrentSeason];

            if not v78 then
                warn("No season pass data");

                return;
            end;

            local v79 = SeasonPassUtils.CalculateLevel(v78.TotalExperience);
            local SkipAllId = SkipTierData.GetSkipAllId(v79);

            if not SkipAllId or SkipAllId == 0 then
                return;
            end;

            MarketController:PromptPurchase(SkipAllId, Enum.InfoType.Product);
        end);
        local v81 = All.MouseEnter:Connect(function() -- Line: 595
            -- upvalues: SeasonPassButtonEffects (ref)
            SeasonPassButtonEffects.Hover();
        end);
        table.insert(u74, v80);
        table.insert(u74, v81);
    end;
end;

local function SetUpNerfsButton() -- Line: 604
    -- upvalues: SeasonPassUI (copy), DataService (copy), SeasonPassUtils (copy), CountDictionary (copy), LocalPlayer (copy), Players (copy), SeasonPassStaticData (copy), NumberUtil (copy)
    local NerfsButton = SeasonPassUI.SeasonPassFrame.Main.Rewards.NerfsButton;

    local function hasXPReductions() -- Line: 608
        -- upvalues: NerfsButton (copy), DataService (ref), SeasonPassUtils (ref), CountDictionary (ref)
        NerfsButton.Visible = false;
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        if CountDictionary((SeasonPassUtils.GetXPReductions(Data.SeasonPassHarvestCounter))) > 0 then
            NerfsButton.Visible = true;
        end;
    end;

    DataService:GetPathSignal("SeasonPassHarvestCounter/@"):Connect(function() -- Line: 620
        -- upvalues: NerfsButton (copy), DataService (ref), SeasonPassUtils (ref), CountDictionary (ref)
        NerfsButton.Visible = false;
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        if CountDictionary((SeasonPassUtils.GetXPReductions(Data.SeasonPassHarvestCounter))) > 0 then
            NerfsButton.Visible = true;
        end;
    end);
    NerfsButton.Visible = false;
    local Data = DataService:GetData();

    if Data and CountDictionary((SeasonPassUtils.GetXPReductions(Data.SeasonPassHarvestCounter))) > 0 then
        NerfsButton.Visible = true;
    end;

    task.spawn(function() -- Line: 626
        -- upvalues: NerfsButton (copy), LocalPlayer (ref), Players (ref), DataService (ref), SeasonPassStaticData (ref), NumberUtil (ref)
        local Label = NerfsButton.Label;

        while LocalPlayer:IsDescendantOf(Players) do
            task.wait(1);
            local Data2 = DataService:GetData();

            if Data2 then
                local ServerTimeNow = workspace:GetServerTimeNow();
                local math_floor_ret = math.floor(ServerTimeNow);
                Label.Text = `<font color="rgb(255, 78, 78)">XP Reduced - {NumberUtil.toHMS(SeasonPassStaticData.HarvestResetTime - (math_floor_ret - Data2.SeasonPassLastHarvestReset))}</font>`;
            end;
        end;
    end);
end;

function u9.Start() -- Line: 644
    -- upvalues: DataService (copy), SetUpTrackRewards (copy), SetUpRobuxButtons (copy), SetUpNerfsButton (copy)
    if not DataService:GetData() then
        warn("No player data");

        return;
    end;

    SetUpTrackRewards();
    SetUpRobuxButtons();
    SetUpNerfsButton();
end;

function u9.UpdateRewardsTrack() -- Line: 654
    -- upvalues: SeasonPassData (copy), Rewards (copy), u2 (copy), Notify (copy), u6 (ref), DataService (copy), u9 (copy), LocalPlayer (copy), u4 (ref), SetUpTrackRewards (copy), SeasonPassUtils (copy), MAX_LEVEL (copy), SkipOptions (copy)
    if not SeasonPassData.CurrentSeason then
        return;
    end;

    for _, child in Rewards:GetChildren() do
        if child:IsA("Frame") and child.Name ~= "InfReward" then
            child:Destroy();
        end;
    end;

    table.clear(u2);
    Notify.Visible = false;

    if u6 then
        u6:Disconnect();
        local PathSignal = DataService:GetPathSignal((`SeasonPass/{SeasonPassData.CurrentSeason}/IsPremium/@`));

        if PathSignal then
            u6 = PathSignal:Connect(u9.Start);
        end;
    end;

    task.wait(1);
    local CurrentSeason = SeasonPassData.CurrentSeason;

    if not CurrentSeason then
        return;
    end;

    local Data = DataService:GetData();

    while not (Data and (Data.SeasonPass and Data.SeasonPass[CurrentSeason])) do
        task.wait(0.5);

        if SeasonPassData.CurrentSeason ~= CurrentSeason then
            return;
        end;

        Data = DataService:GetData();
    end;

    LocalPlayer.PlayerGui.Hud_UI.SideBtns.Pass.Activated:Once(function() -- Line: 697
        -- upvalues: Notify (ref)
        Notify.Visible = false;
    end);
    u4 = 0;
    SetUpTrackRewards();
    local Data2 = DataService:GetData();

    if not Data2 then
        return;
    end;

    local v82 = SeasonPassData.CurrentSeason and Data2.SeasonPass[SeasonPassData.CurrentSeason];

    if not v82 then
        return;
    end;

    if SeasonPassUtils.CalculateLevel(v82.TotalExperience) < MAX_LEVEL then
        SeasonPassUtils.ToggleButton(SkipOptions.All, true, "Gold");

        return;
    end;

    SeasonPassUtils.ToggleButton(SkipOptions.All, false);
end;

ProgressSeasonPassBar.OnClientEvent:Connect(function(u83: number, u84: number) -- Line: 721
    -- upvalues: DataService (copy), SeasonPassUtils (copy), MAX_LEVEL (copy), BPLevel (copy), BPLevel2 (copy), UpdateInfReward (copy), MoveBarTween (copy), Fill (copy), Fill2 (copy), FillProg (copy), Scale (copy), NumberUtil (copy), Rewards (copy), ActivateTierReward (copy)
    task.spawn(function() -- Line: 210
        -- upvalues: DataService (ref), SeasonPassUtils (ref), u84 (copy), u83 (copy), MAX_LEVEL (ref), BPLevel (ref), BPLevel2 (ref), UpdateInfReward (ref), MoveBarTween (ref), Fill (ref), Fill2 (ref), FillProg (ref), Scale (ref), NumberUtil (ref), Rewards (ref), ActivateTierReward (ref)
        if not DataService:GetData() then
            warn("SeasonPassUIController | No player data");

            return;
        end;

        local v85 = SeasonPassUtils.CalculateLevel(u84);
        local v86 = SeasonPassUtils.CalculateLevel(u83);
        local v87 = u84 - u83;
        local v88 = u83;

        local function v92(p89: number) -- Line: 224
            -- upvalues: SeasonPassUtils (ref), MAX_LEVEL (ref), BPLevel (ref), BPLevel2 (ref)
            local v90 = SeasonPassUtils.CalculateXPForLevel(p89);
            local v91 = SeasonPassUtils.CalculateXPForLevel(p89 + 1) - v90;

            if MAX_LEVEL <= p89 then
                BPLevel.Exp.Text = "COMPLETED";
                BPLevel2.Exp.Text = BPLevel.Exp.Text;

                return;
            end;

            BPLevel.Exp.Text = `0/{v91}`;
            BPLevel2.Exp.Text = BPLevel.Exp.Text;
        end;

        local v93 = v86;

        while true do
            local XPEarnedCurrentLevel = SeasonPassUtils.GetXPEarnedCurrentLevel(v88);
            local TotalXPForNextLevel = SeasonPassUtils.GetTotalXPForNextLevel(v88);
            local v94 = TotalXPForNextLevel - XPEarnedCurrentLevel;

            if v87 - v94 <= 0 then
                v94 = v87;
            end;

            v88 = v88 + v94;
            v87 = v87 - v94;
            v92(v86);
            local v95 = SeasonPassUtils.CalculateLevel(v88);
            local v96 = v88 - SeasonPassUtils.CalculateXPForLevel(MAX_LEVEL);

            if v96 >= 1 then
                UpdateInfReward(u84);

                return;
            end;

            if v96 == 0 then
                UpdateInfReward(u84);
            end;

            local math_clamp_ret = math.clamp((XPEarnedCurrentLevel + v94) / TotalXPForNextLevel, 0, 1);
            local v97 = MoveBarTween(Fill, math_clamp_ret, 1, v85);
            local v98 = MoveBarTween(Fill2, math_clamp_ret, 1, v95);
            local v99 = MoveBarTween(FillProg, (v95 + SeasonPassUtils.GetXPFractionOfCurrentLevel(v88)) / MAX_LEVEL * Scale, Scale, v85);
            v98:Play();
            v97:Play();
            local v100 = SeasonPassUtils.CalculateXPForLevel(v95);
            local v101 = SeasonPassUtils.CalculateXPForLevel(v95 + 1) - v100;
            BPLevel.Exp.Text = `{NumberUtil.RoundToDP(XPEarnedCurrentLevel + v94, 2)}/{v101}`;
            BPLevel2.Exp.Text = BPLevel.Exp.Text;
            v99:Play();
            v99.Completed:Wait();

            if v93 < v95 then
                v92(v95);
                ActivateTierReward(Rewards:FindFirstChild((`Tier{v95}RewardFrame`)), v95);
                v93 = v95;
            end;

            local v102 = math.sqrt(v85) * 0.01;
            task.wait(v102 * 0.5);

            if Fill.Size.X.Scale == 1 and v95 < 50 then
                Fill.Size = UDim2.fromScale(0, Fill.Size.Y.Scale);
                Fill2.Size = UDim2.fromScale(Fill.Size.X.Scale, Fill2.Size.Y.Scale);
            end;

            if v87 <= 0 then
                return;
            end;
        end;
    end);
end);

if SeasonPassData.CurrentSeason then
    local PathSignal = DataService:GetPathSignal((`SeasonPass/{SeasonPassData.CurrentSeason}/IsPremium/@`));

    if PathSignal then
        u6 = PathSignal:Connect(function(p103: string, p104: any, p105: string) -- Line: 728
            -- upvalues: u9 (copy)
            u9.UpdateRewardsTrack();
            u9.Start();
        end);
    end;

    local PathSignal2 = DataService:GetPathSignal((`SeasonPass/{SeasonPassData.CurrentSeason}/InfRewardsClaimed/@`));

    if PathSignal2 then
        u5 = PathSignal2:Connect(function(p106: string, p107: any, p108: string) -- Line: 736
            -- upvalues: DataService (copy), SeasonPassData (copy), UpdateInfReward (copy)
            local Data = DataService:GetData();

            if not Data then
                warn("No player data");

                return;
            end;

            local v109 = SeasonPassData.CurrentSeason and Data.SeasonPass[SeasonPassData.CurrentSeason];

            if not v109 then
                return;
            end;

            UpdateInfReward(v109.TotalExperience);
        end);
    end;
end;

return u9;