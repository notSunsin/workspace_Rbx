-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local Item_Module = require(ReplicatedStorage.Item_Module);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SafariEventConfigData = require(ReplicatedStorage.Data.Events.SafariEvent.SafariEventConfigData);
local EventShopData = require(ReplicatedStorage.Data.EventShopData);
local SafariEventRewardData = require(ReplicatedStorage.Data.Events.SafariEvent.SafariEventRewardData);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local u1 = Trove.new();
local u2 = Trove.new();
local u3 = Trove.new();
local u4 = Trove.new();
local SafariIndividualRewards_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("SafariEvent"):WaitForChild("SafariIndividualRewards_UI");
local Individual = SafariIndividualRewards_UI.Frame.Individual;
local Shared = SafariIndividualRewards_UI.Frame.Shared;
local Holder = Individual.Holder;
local Holder2 = Shared.Holder;
local CommunityMilestonesButton = Individual.Holder.Footer.CommunityMilestonesButton;
local IndividualRewardsButton = Shared.Holder.Footer.IndividualRewardsButton;
Item_Module.Return_All_Seed_Rarities();
local SafariEventCounter = ReplicatedStorage.Data.ReplicatedGlobalStock.SafariEventCounter;
local Rewards = SafariEventRewardData.SafariIndividualRewardData.Rewards;
local u5 = Chalk.color(Color3.fromRGB(226, 0, 0))("YOU");
local u6 = {
    SafariRain = "rbxassetid://116830092067355",
    SafariDrought = "rbxassetid://110370631383095",
    SafariOasis = "rbxassetid://119563396372269",
    SafariNight = "rbxassetid://94088546523000",
    SafariStampede = "rbxassetid://109242734417069",
    SafariTyphoon = "rbxassetid://125782260914996",
    SafariDusk = "rbxassetid://125782260914996",
    SafariStorm = "rbxassetid://125782260914996",
    SafariHunt = "rbxassetid://125782260914996",
    SafariTour = "rbxassetid://125782260914996"
};
local u7 = {};

local function BuildIndividualRewardsPage() -- Line: 65
    -- upvalues: GuiController (copy), SafariIndividualRewards_UI (copy), u2 (copy), Holder (copy), SafariEventConfigData (copy), u5 (copy), Rewards (copy), ItemOddsController (copy), ItemImageFinder (copy), ColorHelper (copy)
    GuiController:GetStateForGui(SafariIndividualRewards_UI);
    u2:Clean();
    Holder.Header.Title.Text = `Gain a random reward for every {SafariEventConfigData.INDIVIDUAL_REWARD_THRESHOLD} points {u5} contribute.`;

    for _, child in Holder.RewardScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
            child:Destroy();
        end;
    end;

    local v8 = Rewards;
    table.sort(v8, function(p9, p10) -- Line: 84
        return p9.Chance > p10.Chance;
    end);
    local v11 = 0;

    for _, v in v8 do
        v11 = v11 + (v.Chance or 0);
    end;

    local v12 = 0;

    for _, v in Rewards do
        v12 = v12 + 1;
        local v13 = u2:Clone(Holder.RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
        local RewardName = v13.Frame.RewardName;
        local Odds = v13.Frame.Odds;
        local ITEM_IMAGE = v13.Frame.ITEM_IMAGE;
        ItemOddsController:ConnectOddsButton(v, v13.Frame.OddsButton, SafariIndividualRewards_UI);
        local v14 = tostring(v.Value);
        local v15 = v.Quantity or 1;

        if v15 > 1 then
            v14 = "x" .. v15 .. " " .. v.Value;
        end;

        RewardName.Text = v14;
        Odds.Text = string.format("%.2f", v.Chance / v11 * 100) .. "%";
        Odds.Visible = true;
        ITEM_IMAGE.Image = ItemImageFinder(tostring(v.Value), v.Type);
        RewardName.TextColor3 = Color3.fromRGB(255, 255, 255);
        local UIStroke = v13.Frame.RewardName.UIStroke;

        if UIStroke then
            UIStroke.Color = ColorHelper:Darken(RewardName.TextColor3);
        end;

        v13:AddTag("ItemInfoHoverTag");
        v13:SetAttribute("UUID", (`SafariHarvestRewards_{v.Type}_{v.Value}`));
        v13.LayoutOrder = v12 + 1000 + 1;
        v13.Parent = Holder.RewardScrollingFrame;
    end;
end;

local function BuildCommunityRewardsPage() -- Line: 141
    -- upvalues: GuiController (copy), SafariIndividualRewards_UI (copy), u3 (copy), Holder2 (copy), Chalk (copy), SafariEventRewardData (copy), SafariEventCounter (copy), CommaFormatNumber (copy), UpdateService (copy), NumberUtil (copy), EventShopData (copy), ItemImageFinder (copy), u6 (copy), GiveServiceCommon (copy)
    GuiController:GetStateForGui(SafariIndividualRewards_UI);
    u3:Clean();
    Holder2.Header.Title.Text = `Gain community rewards for each {Chalk.color(Color3.fromRGB(255, 0, 0))("milestone")} reached.`;
    local AllMilestonesData = SafariEventRewardData.AllMilestonesData;
    local RewardScrollingFrame = Holder2.RewardScrollingFrame;

    for _, child in RewardScrollingFrame:GetChildren() do
        if not child:IsA("UIListLayout") then
            child:Destroy();
        end;
    end;

    local function UpdateCompletedMilestones() -- Line: 160
        -- upvalues: RewardScrollingFrame (copy), SafariEventCounter (ref)
        local v16 = false;

        for _, child in RewardScrollingFrame:GetChildren() do
            local Attribute = child:GetAttribute("Milestone");

            if Attribute then
                local v17 = Attribute < SafariEventCounter.Value;

                if v16 then
                    v16 = not v17;
                end;

                child:FindFirstChild("Frame").Left.CompletedOverlay.Visible = v17;
                local DarkenFrame = child:FindFirstChild("DarkenFrame");
                DarkenFrame.Visible = not v16 and not v17;
                child:FindFirstChild("Frame").UIGradient.Enabled = v16;
                v16 = v17;
            end;
        end;
    end;

    local UIListLayout = RewardScrollingFrame.UIListLayout;

    local function UpdateProgressBar() -- Line: 180
        -- upvalues: SafariEventCounter (ref), AllMilestonesData (copy), Holder2 (ref), CommaFormatNumber (ref)
        local Value = SafariEventCounter.Value;
        local v18 = nil;

        for _, v in AllMilestonesData do
            if Value < v.MilestoneValue then
                v18 = v.MilestoneValue;
                break;
            end;

            local _ = v.MilestoneValue;
        end;

        local ProgressFG = Holder2.CommunityPointsFrame.ProgressBG.ProgressFG;

        if not v18 then
            ProgressFG.Size = UDim2.new(1, 0, ProgressFG.Size.Y.Scale, 0);
            Holder2.CommunityPointsFrame.ProgressBG.TextLabel.Text = "All Milestones Completed!";

            return;
        end;

        local math_clamp_ret = math.clamp(Value / v18, 0, 1);
        ProgressFG.Size = UDim2.new(math_clamp_ret, 0, ProgressFG.Size.Y.Scale, 0);
        Holder2.CommunityPointsFrame.ProgressBG.TextLabel.Text = `Next Milestone\n{CommaFormatNumber(Value)} / {CommaFormatNumber(v18)}`;
    end;

    u3:Add(SafariEventCounter.Changed:Connect(function(p19: number) -- Line: 211
        -- upvalues: UpdateCompletedMilestones (copy), UpdateProgressBar (copy)
        UpdateCompletedMilestones();
        UpdateProgressBar();
    end));

    local function PascalCaseToSpaces(p20) -- Line: 216
        return p20:gsub("(%l)(%u)", "%1 %2");
    end;

    local v21 = 100;

    for _, v in AllMilestonesData do
        if not (v.Key and UpdateService:IsHiddenFromUpdate((`SafariRewards/{v.Key}`))) then
            local v22 = u3:Clone(RewardScrollingFrame.UIListLayout.REWARDTRACK_TEMPLATE);
            v22:SetAttribute("Milestone", v.MilestoneValue);
            v22.Frame.Left.PointsMilestone.Text = NumberUtil.FormatCompactPrice(v.MilestoneValue, "4");
            local RewardName = v22.Frame.Right.RewardName;
            local RewardType = v22.Frame.Right.RewardType;
            local ITEM_IMAGE = v22.Frame.Righter.ITEM_IMAGE;

            if v.Type == "EventShopCooldown" then
                RewardType.Text = "Event Shop Cooldown";
                RewardName.Text = NumberUtil.toMS(v.Value);
                ITEM_IMAGE.Image = "rbxassetid://95647738620303";
            elseif v.Type == "EventShopUnlock" then
                RewardType.Text = "Event Shop Item";
                RewardName.Text = `{v.Value}`;

                local function FindEventShopType(p23: string) -- Line: 245
                    -- upvalues: EventShopData (ref)
                    for _, v2 in EventShopData do
                        local v24 = v2[p23];

                        if v24 then
                            return v24.ItemType;
                        end;
                    end;

                    warn((`Could not find item type for {p23}`));

                    return nil;
                end;

                local function FindImage(p25: string) -- Line: 257
                    -- upvalues: EventShopData (ref), ItemImageFinder (ref)
                    local v26;

                    for _, v2 in EventShopData do
                        local v27 = v2[p25];

                        if v27 then
                            v26 = v27.ItemType;
                            break;
                        end;
                    end;

                    warn((`Could not find item type for {p25}`));
                    v26 = nil;

                    return not v26 and "rbxassetid://6937742258" or ItemImageFinder(p25, v26);
                end;

                local Value = v.Value;
                local v28;

                for _, v2 in EventShopData do
                    local v29 = v2[Value];

                    if v29 then
                        v28 = v29.ItemType;
                        break;
                    end;
                end;

                warn((`Could not find item type for {Value}`));
                v28 = nil;
                ITEM_IMAGE.Image = not v28 and "rbxassetid://6937742258" or ItemImageFinder(Value, v28);
            elseif v.Type == "WeatherUnlock" then
                RewardType.Text = "New Weather Event";
                RewardName.Text = v.Value:gsub("(%l)(%u)", "%1 %2");
                ITEM_IMAGE.Image = u6[v.Value] or "rbxassetid://6937742258";
            elseif v.Type == "ItemReward" then
                RewardType.Text = "Item Reward";
                RewardName.Text = GiveServiceCommon:Format(v.Value);
                ITEM_IMAGE.Image = GiveServiceCommon:GetImage(v.Value) or "rbxassetid://6937742258";
            elseif v.Type == "EventShopChance" then
                RewardType.Text = "Event Shop Luck";
                RewardName.Text = `{v.Value} increase to Safari Shop Stock Chance`;
                ITEM_IMAGE.Image = "rbxassetid://113974930273964";
            elseif v.Type == "SeedShopUnlock" then
                RewardType.Text = "Seed Shop Unlock";
                RewardName.Text = v.Value;
                ITEM_IMAGE.Image = ItemImageFinder(v.Value, "Seed");
            elseif v.Type == "DummyReward" then
                RewardType.Text = v.HeaderText;
                RewardName.Text = v.RewardText;
                ITEM_IMAGE.Image = v.Image or "rbxassetid://6937742258";
            end;

            v22.LayoutOrder = v21;
            v22.Parent = RewardScrollingFrame;
            v21 = v21 + 10;
        end;
    end;

    RewardScrollingFrame.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X, 0, UIListLayout.AbsoluteContentSize.Y);
    UpdateCompletedMilestones();
    UpdateProgressBar();
end;

function u7.Open(p30: table, u31: userdata?, p32: boolean?) -- Line: 304
    -- upvalues: GuiController (copy), SafariIndividualRewards_UI (copy), u4 (copy)
    GuiController:Open(SafariIndividualRewards_UI);

    if u31 then
        u4:Add(SafariIndividualRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 309
            -- upvalues: GuiController (ref), SafariIndividualRewards_UI (ref), u31 (copy), u4 (ref)
            GuiController:Close(SafariIndividualRewards_UI);
            GuiController:Open(u31);
            u4:Clean();
        end));

        return;
    end;

    u4:Add(SafariIndividualRewards_UI.Frame.ExitButton.Activated:Once(function() -- Line: 315
        -- upvalues: GuiController (ref), SafariIndividualRewards_UI (ref), u4 (ref)
        GuiController:Close(SafariIndividualRewards_UI);
        u4:Clean();
    end));
end;

function u7.Start(p33) -- Line: 322
    -- upvalues: GuiController (copy), SafariIndividualRewards_UI (copy), ItemInfoHover (copy), Rewards (copy), BuildIndividualRewardsPage (copy), BuildCommunityRewardsPage (copy), EventRotationController (copy), SafariEventRewardData (copy), IndividualRewardsButton (copy), Individual (copy), Shared (copy), CommunityMilestonesButton (copy)
    GuiController:UsePopupAnims(SafariIndividualRewards_UI);
    ItemInfoHover:AddRewardTable("SafariHarvestRewards", Rewards);
    BuildIndividualRewardsPage();
    BuildCommunityRewardsPage();
    task.spawn(function() -- Line: 330
        -- upvalues: EventRotationController (ref), BuildCommunityRewardsPage (ref)
        if EventRotationController:IsPastEventIDIndex(2) then
            BuildCommunityRewardsPage();
        end;
    end);
    SafariEventRewardData.IndividualRewardsChanged:Connect(function() -- Line: 336
        -- upvalues: BuildIndividualRewardsPage (ref)
        BuildIndividualRewardsPage();
    end);
    IndividualRewardsButton.Activated:Connect(function() -- Line: 340
        -- upvalues: Individual (ref), Shared (ref)
        Individual.Visible = true;
        Shared.Visible = false;
        game.SoundService.Click:Play();
    end);
    CommunityMilestonesButton.Activated:Connect(function() -- Line: 346
        -- upvalues: Individual (ref), Shared (ref)
        Individual.Visible = false;
        Shared.Visible = true;
        game.SoundService.Click:Play();
    end);
end;

function u7.OverwriteTitle(p34: table, p35: string) -- Line: 353
    -- upvalues: Holder (copy)
    Holder.Header.Title.Text = p35;
end;

EventRotationClientBinder:Bind({
    EventSet = "SafariEvent",
    Script = script,

    OnStart = function() -- Line: 360, Name: OnStart
        -- upvalues: u7 (copy)
        task.spawn(u7.Start, u7);
    end,

    OnStop = function() -- Line: 361, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u7;