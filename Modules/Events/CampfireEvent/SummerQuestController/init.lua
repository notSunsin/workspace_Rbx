-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedFirst = game:GetService("ReplicatedFirst");

local function isExpired() -- Line: 22
    -- upvalues: ReplicatedFirst (copy)
    return workspace:GetServerTimeNow() >= ReplicatedFirst.GlobalUpdateTime.Value;
end;

local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("SummerQuestConfig");
workspace:GetAttributeChangedSignal("SummerQuestConfig"):Connect(function() -- Line: 29
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("SummerQuestConfig");
end);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
require(ReplicatedStorage.Modules.Notification);
local NPCDialogueController = require(ReplicatedStorage.Modules.NPCDialogueController);
local Top_Text = require(ReplicatedStorage.Top_Text);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local SummerQuest = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("SummerQuest");
local ClaimReward = SummerQuest:WaitForChild("ClaimReward");
local SFX = SummerQuest:WaitForChild("SFX");
local RewardsReady = SummerQuest:WaitForChild("RewardsReady");
local u2 = {};
local SummerQuest_UI = Players.LocalPlayer.PlayerGui.SummerQuest_UI;
GuiController:GetStateForGui(SummerQuest_UI).ChangeEnabled:Set(true);
local Quests2 = SummerQuest_UI.Quests;
local Rewards = SummerQuest_UI.Rewards;
local Slots = Quests2.Main.Main.Slots;
local Title = Quests2.Main.Main.Timer.Fill.Title;
local skipQuestsButton = Quests2.Main.Main.skipQuestsButton;
local Title2 = skipQuestsButton.Title;
local Close = Quests2.Main.Header.Close;
local OddsButton = Quests2.Main.Header.OddsButton;
local RewardFrame = Quests2.RewardFrame;
local ITEM_IMAGE = RewardFrame.ITEM_IMAGE;
local Title3 = RewardFrame.Title;
local Progress = RewardFrame.Progress;
local ClaimFrame = Quests2.ClaimFrame;
local MakeAWish = ClaimFrame.Widget.RestartButtons.MakeAWish;
local Items = Rewards.Main.Items;
local Template = Items.UIListLayout.Template;
local ExitButton = Rewards.ExitButton;
local RerollButton = Rewards.RerollButton;
local OddsButton2 = Rewards.OddsButton;
local Odds = SummerQuest_UI.Odds;
local Items2 = Odds.Main.Items;
local REWARDTRACK_TEMPLATE = Items2.UIListLayout.REWARDTRACK_TEMPLATE;
local REWARDTRACK_TEMPLATE2 = Items2.UIListLayout.REWARDTRACK_TEMPLATE;
local ExitButton2 = Odds.ExitButton;
local script_QuestTemplate = script.QuestTemplate;

function u2.Start(p3) -- Line: 101
    -- upvalues: CollectionService (copy), Config (ref), u2 (copy), Quests (copy), ClaimReward (copy), MarketController (copy), Items (copy), ItemInfoHover (copy), Items2 (copy), RerollButton (copy), Template (copy), ItemImageFinder (copy), Rewards (copy), Quests2 (copy), Odds (copy), REWARDTRACK_TEMPLATE2 (copy), REWARDTRACK_TEMPLATE (copy), ItemNameFinder (copy), skipQuestsButton (copy), Title2 (copy), ClaimFrame (copy), script_QuestTemplate (copy), Slots (copy), Title (copy), ITEM_IMAGE (copy), RewardFrame (copy), Title3 (copy), Progress (copy), GuiController (copy), SummerQuest_UI (copy), DataService (copy), SetupButton (copy), Close (copy), MakeAWish (copy), ExitButton (copy), u1 (copy), OddsButton2 (copy), ExitButton2 (copy), OddsButton (copy), Top_Text (copy), NPCDialogueController (copy), SFX (copy), RewardsReady (copy)
    local v4 = CollectionService:GetTagged(Config.MODEL_TAG)[1];

    if not v4 then
        warn((`Missing Model: {Config.MODEL_TAG}`));

        return;
    end;

    local NPC = v4:WaitForChild("NPC");
    local ProximityPrompts = v4:WaitForChild("ProximityPrompts");
    local ProximityPrompt = ProximityPrompts:WaitForChild("Open"):WaitForChild("ProximityPrompt");
    local ProximityPrompt2 = ProximityPrompts:WaitForChild("OpenQuests"):WaitForChild("ProximityPrompt");
    local ProximityPrompts2 = v4:WaitForChild("ProximityPrompts");
    local Timer = ProximityPrompts2:WaitForChild("Timer"):WaitForChild("Attachment"):WaitForChild("BillboardGui"):WaitForChild("Timer");
    local RewardFrame2 = ProximityPrompts2:WaitForChild("RewardCycle"):WaitForChild("Attachment"):WaitForChild("BillboardGui"):WaitForChild("RewardFrame");
    local ITEM_IMAGE2 = RewardFrame2:WaitForChild("ITEM_IMAGE");
    local Title4 = RewardFrame2:WaitForChild("Title");
    u2.State = nil;
    u2.PendingRewards = {};
    local u5 = nil;
    local u6 = {};

    local function getSecondsUntilRefresh() -- Line: 129
        -- upvalues: Config (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v7 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;

        return math.max(v7, 0);
    end;

    local function formatTime(p8: number) -- Line: 135
        local math_floor_ret = math.floor(p8 + 0.5);
        local math_max_ret = math.max(math_floor_ret, 0);
        local math_floor_ret2 = math.floor(math_max_ret / 3600);
        local math_floor_ret3 = math.floor(math_max_ret % 3600 / 60);
        local v9 = math_max_ret % 60;

        if math_floor_ret2 > 0 then
            return string.format("%d:%02d:%02d", math_floor_ret2, math_floor_ret3, v9);
        end;

        return string.format("%d:%02d", math_floor_ret3, v9);
    end;

    local function ensureSeedSuffix(p10: string) -- Line: 146
        local v11 = p10:match("^%s*(.-)%s*$");

        if v11:lower():match("%sseed$") then
            return v11;
        end;

        return `{v11} Seed`;
    end;

    local function getQuestData() -- Line: 155
        -- upvalues: u5 (ref)
        return u5 and u5.SummerQuestData or nil;
    end;

    local function getContainer() -- Line: 159
        -- upvalues: u5 (ref)
        local v12 = u5 and u5.SummerQuestData or nil;

        if not (v12 and (v12.ContainerId and v12.ContainerId ~= "")) then
            return nil;
        end;

        if u5.QuestContainers then
            return u5.QuestContainers[v12.ContainerId];
        end;

        return nil;
    end;

    function u2.GetQuestDisplay(p13, p14) -- Line: 168
        -- upvalues: Quests (ref)
        local v15 = Quests[p14.Type];

        return not (v15 and v15.Display) and {
            Description = "",
            Title = p14.Type,
            Bar = `{p14.Progress}/{p14.Target}`
        } or v15:Display(p14.Progress, p14.Target, p14.Arguments);
    end;

    function u2.GetState(p16) -- Line: 181
        -- upvalues: u5 (ref), u2 (ref), Config (ref)
        local v17 = u5 and u5.SummerQuestData or nil;

        if not v17 then
            return nil;
        end;

        local v18 = u5 and u5.SummerQuestData or nil;
        local v19;

        if v18 and (v18.ContainerId and v18.ContainerId ~= "") and u5.QuestContainers then
            v19 = u5.QuestContainers[v18.ContainerId];
        else
            v19 = nil;
        end;

        local v20 = {};

        if v19 and v19.Quests then
            for _, v in v19.Quests do
                local v21 = {
                    Type = v.Type,
                    Progress = v.Progress,
                    Target = v.Target,
                    Completed = v.Completed,
                    Arguments = v.Arguments,
                    Display = u2:GetQuestDisplay(v)
                };
                table.insert(v20, v21);
            end;
        end;

        local v22 = {
            Period = v17.Period
        };
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v23 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;
        v22.SecondsLeft = math.max(v23, 0);
        v22.Quests = v20;
        v22.RewardsReady = v17.RewardsReady;
        v22.RewardClaimed = v17.RewardClaimed;
        v22.RerollCount = v17.RerollCount;
        v22.PendingRewards = v17.PendingRewards or {};
        u2.State = v22;
        u2.PendingRewards = u2.State.PendingRewards;

        return u2.State;
    end;

    function u2.ClaimReward(p24: table, p25: string) -- Line: 213
        -- upvalues: ClaimReward (ref)
        ClaimReward:FireServer(p25);
    end;

    function u2.PromptReroll(p26) -- Line: 219
        -- upvalues: Config (ref), MarketController (ref)
        local REROLL_PRODUCT_ID = Config.REROLL_PRODUCT_ID;

        if REROLL_PRODUCT_ID and REROLL_PRODUCT_ID > 0 then
            MarketController:PromptPurchase(REROLL_PRODUCT_ID, Enum.InfoType.Product);

            return;
        end;

        warn("SummerQuestController | REROLL_PRODUCT_ID not configured");
    end;

    local function allComplete() -- Line: 228
        -- upvalues: u5 (ref)
        local v27 = u5 and u5.SummerQuestData or nil;
        local v28;

        if v27 and (v27.ContainerId and v27.ContainerId ~= "") and u5.QuestContainers then
            v28 = u5.QuestContainers[v27.ContainerId];
        else
            v28 = nil;
        end;

        if not (v28 and (v28.Quests and #v28.Quests ~= 0)) then
            return false;
        end;

        for _, v in v28.Quests do
            if not v.Completed then
                return false;
            end;
        end;

        return true;
    end;

    function u2.PromptSkip(p29) -- Line: 241
        -- upvalues: Config (ref), MarketController (ref)
        local SKIP_QUESTS_PRODUCT_ID = Config.SKIP_QUESTS_PRODUCT_ID;

        if SKIP_QUESTS_PRODUCT_ID and SKIP_QUESTS_PRODUCT_ID > 0 then
            MarketController:PromptPurchase(SKIP_QUESTS_PRODUCT_ID, Enum.InfoType.Product);

            return;
        end;

        warn("SummerQuestController | SKIP_QUESTS_PRODUCT_ID not configured");
    end;

    local function clearRewardClones() -- Line: 253
        -- upvalues: Items (ref), ItemInfoHover (ref)
        for _, child in Items:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                local Attribute = child:GetAttribute("UUID");

                if Attribute then
                    ItemInfoHover:RemoveItemFromData(Attribute);
                end;

                child:Destroy();
            end;
        end;
    end;

    local function clearOddsClones() -- Line: 265
        -- upvalues: Items2 (ref), ItemInfoHover (ref)
        for _, child in Items2:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
                local Attribute = child:GetAttribute("UUID");

                if Attribute then
                    ItemInfoHover:RemoveItemFromData(Attribute);
                end;

                child:Destroy();
            end;
        end;
    end;

    local function updateRerollUI() -- Line: 279
        -- upvalues: u5 (ref), Config (ref), RerollButton (ref)
        local v30 = u5 and u5.SummerQuestData or nil;
        local math_max_ret = math.max((Config.MAX_FREE_REROLLS or 0) - (v30 and v30.RerollCount or 0), 0);
        RerollButton.Visible = true;

        if math_max_ret <= 0 then
            if RerollButton:FindFirstChild("RobuxPrice") then
                RerollButton.RobuxPrice.Visible = true;
            end;

            if RerollButton:FindFirstChild("Price") then
                RerollButton.Price.Visible = false;
            end;

            RerollButton.Price.Text = "Reroll";

            return;
        end;

        if RerollButton:FindFirstChild("RobuxPrice") then
            RerollButton.RobuxPrice.Visible = false;
        end;

        if RerollButton:FindFirstChild("Price") then
            RerollButton.Price.Visible = true;
        end;

        RerollButton.Price.Text = `Reroll: {math_max_ret}`;
    end;

    local function renderRewards(p31) -- Line: 300
        -- upvalues: u5 (ref), clearRewardClones (copy), Template (ref), ItemImageFinder (ref), u2 (ref), Items (ref)
        local v32 = u5 and u5.SummerQuestData or nil;
        local v33 = p31 or v32 and v32.PendingRewards or {};
        clearRewardClones();
        local v34 = 0;

        for _, v in v33 do
            v34 = v34 + 1;
            local u35 = Template:Clone();
            u35.Visible = true;
            local Title5 = u35:FindFirstChild("Title");

            if Title5 then
                Title5.Text = tostring(v.Value);
            end;

            local Vector = u35:FindFirstChild("Vector");

            if Vector then
                local v36 = tostring(v.Value);
                local success, result = pcall(ItemImageFinder, v36, v.Type);

                if success and result then
                    Vector.Image = result;
                end;
            end;

            local UUID = v.UUID;
            local u37 = u35.MouseButton1Down:Connect(function() -- Line: 323
                -- upvalues: u35 (copy), u2 (ref), UUID (copy)
                u35.UIScale.Scale = 1;
                u2:ClaimReward(UUID);
            end);
            local u38 = u35.MouseEnter:Connect(function() -- Line: 329
                -- upvalues: u35 (copy)
                u35.UIScale.Scale = 1;
                game:GetService("TweenService"):Create(u35.UIScale, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
                    Scale = 1.05
                }):Play();
            end);
            local u39 = u35.MouseLeave:Connect(function() -- Line: 335
                -- upvalues: u35 (copy)
                u35.UIScale.Scale = 1.05;
                game:GetService("TweenService"):Create(u35.UIScale, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
                    Scale = 1
                }):Play();
            end);
            u35.Destroying:Once(function() -- Line: 340
                -- upvalues: u37 (ref), u38 (ref), u39 (ref)
                u37:Disconnect();
                u38:Disconnect();
                u39:Disconnect();
            end);
            u35.LayoutOrder = v34;
            u35.Parent = Items;
        end;
    end;

    local function openRewards() -- Line: 351
        -- upvalues: renderRewards (copy), updateRerollUI (copy), Rewards (ref), Quests2 (ref)
        renderRewards();
        updateRerollUI();
        Rewards.Visible = true;
        Quests2.Visible = false;
    end;

    local function closeRewards() -- Line: 358
        -- upvalues: clearRewardClones (copy), clearOddsClones (copy), Rewards (ref), Odds (ref), Quests2 (ref)
        clearRewardClones();
        clearOddsClones();
        Rewards.Visible = false;
        Odds.Visible = false;
        Quests2.Visible = true;
    end;

    local function renderOdds() -- Line: 367
        -- upvalues: clearOddsClones (copy), Config (ref), u5 (ref), REWARDTRACK_TEMPLATE2 (ref), REWARDTRACK_TEMPLATE (ref), ItemNameFinder (ref), ItemImageFinder (ref), ItemInfoHover (ref), Items2 (ref)
        clearOddsClones();
        local v40 = Config.RewardPool or {};
        local v41 = u5 and u5.SummerQuestData or nil;
        local v42 = v41 and v41.ClaimedOnceRewards or {};
        local v43 = 0;

        for _, v in v40 do
            if v.Reward then
                local v44 = v.OnlyOnce and v42[`{v.Reward.Type}|{v.Reward.Value}`];

                if not v44 then
                    v43 = v43 + (v.Chance or 0);
                end;
            end;
        end;

        if v43 <= 0 then
            return;
        end;

        for _, v in v40 do
            local Reward = v.Reward;

            if Reward then
                local v45 = -v.Chance;
                local v46;

                if v.Chance <= 15 then
                    v46 = REWARDTRACK_TEMPLATE2:Clone();
                else
                    v46 = REWARDTRACK_TEMPLATE:Clone();
                end;

                v46.Visible = true;
                local Title5 = v46.Frame:FindFirstChild("Title");

                if Title5 then
                    local v47 = ItemNameFinder(tostring(Reward.Value), Reward.Type);

                    if Reward.Type == "Seed" then
                        v47 = v47:match("^%s*(.-)%s*$");

                        if not v47:lower():match("%sseed$") then
                            v47 = `{v47} Seed`;
                        end;
                    end;

                    Title5.Text = v47;
                end;

                local v48 = v.OnlyOnce and v42[`{Reward.Type}|{Reward.Value}`];
                local Rarity = v46.Frame:FindFirstChild("Rarity");

                if Rarity then
                    if v48 then
                        Rarity.Text = "0%";
                    else
                        Rarity.Text = string.format("%d%%", (math.floor(v.Chance / v43 * 100 + 0.5)));
                    end;
                end;

                local Claimed = v46.Frame:FindFirstChild("Claimed");

                if Claimed then
                    Claimed.Visible = v48 == true;
                end;

                local Vector = v46.Frame:FindFirstChild("Vector");

                if Vector then
                    local v49 = tostring(Reward.Value);
                    local success, result = pcall(ItemImageFinder, v49, Reward.Type);

                    if success and result then
                        Vector.Image = result;
                    end;
                end;

                local u50 = `SummerQuestOdds_{v45}_{Reward.Type}_{Reward.Value}`;
                pcall(function() -- Line: 438
                    -- upvalues: ItemInfoHover (ref), u50 (copy), Reward (copy)
                    ItemInfoHover:AddItemFromRewardWithQuantity(u50, Reward);
                end);
                v46:SetAttribute("UUID", u50);
                v46:SetAttribute("NoScale", true);
                v46:AddTag("ItemInfoHoverTag");
                v46.LayoutOrder = v45;
                v46.Parent = Items2;
            end;
        end;
    end;

    local u51 = false;

    local function openOdds() -- Line: 454
        -- upvalues: u51 (ref), Rewards (ref), renderOdds (copy), Odds (ref), Quests2 (ref)
        u51 = Rewards.Visible;
        renderOdds();
        Odds.Visible = true;
        Rewards.Visible = false;
        Quests2.Visible = false;
    end;

    local function closeOdds() -- Line: 462
        -- upvalues: clearOddsClones (copy), Odds (ref), u51 (ref), openRewards (ref), Rewards (ref), Quests2 (ref)
        clearOddsClones();
        Odds.Visible = false;

        if u51 then
            openRewards();

            return;
        end;

        Rewards.Visible = false;
        Quests2.Visible = true;
    end;

    local u52 = nil;

    local function removeQuest(p53) -- Line: 481
        -- upvalues: u6 (copy)
        local v54 = u6[p53];

        if v54 then
            v54:Destroy();
            u6[p53] = nil;
        end;
    end;

    local function updateButton() -- Line: 491
        -- upvalues: u5 (ref), skipQuestsButton (ref), Title2 (ref), ClaimFrame (ref)
        local v55 = u5 and u5.SummerQuestData or nil;
        local v56 = u5 and u5.SummerQuestData or nil;
        local v57;

        if v56 and (v56.ContainerId and v56.ContainerId ~= "") and u5.QuestContainers then
            v57 = u5.QuestContainers[v56.ContainerId];
        else
            v57 = nil;
        end;

        local v58;

        if v57 == nil or v57.Quests == nil then
            v58 = false;
        else
            v58 = #v57.Quests > 0;
        end;

        local v59 = u5 and u5.SummerQuestData or nil;
        local v60;

        if v59 and (v59.ContainerId and v59.ContainerId ~= "") and u5.QuestContainers then
            v60 = u5.QuestContainers[v59.ContainerId];
        else
            v60 = nil;
        end;

        local v61;

        if v60 and (v60.Quests and #v60.Quests ~= 0) then
            v61 = true;

            for _, v in v60.Quests do
                if not v.Completed then
                    v61 = false;
                    break;
                end;
            end;
        else
            v61 = false;
        end;

        local v62 = (v55 and v55.RewardsReady and not v55.RewardClaimed) == true;

        if v58 then
            v58 = not v61;
        end;

        skipQuestsButton.Visible = v58;

        if skipQuestsButton.Visible then
            Title2.Text = "SKIP QUESTS";
        end;

        ClaimFrame.Visible = v62;
    end;

    local function updateQuests() -- Line: 506
        -- upvalues: u5 (ref), u6 (copy), updateButton (copy), Quests (ref), script_QuestTemplate (ref), Slots (ref), u52 (ref)
        local v63 = u5 and u5.SummerQuestData or nil;
        local v64;

        if v63 and (v63.ContainerId and v63.ContainerId ~= "") and u5.QuestContainers then
            v64 = u5.QuestContainers[v63.ContainerId];
        else
            v64 = nil;
        end;

        if not (v64 and v64.Quests) then
            for i in u6 do
                local v65 = u6[i];

                if v65 then
                    v65:Destroy();
                    u6[i] = nil;
                end;
            end;

            updateButton();

            return;
        end;

        for i, v in v64.Quests do
            local v66 = Quests[v.Type];

            if v66 then
                local v67 = u6[v.Id];

                if not v67 then
                    v67 = script_QuestTemplate:Clone();
                    v67.Visible = true;
                    v67.Parent = Slots;
                    u6[v.Id] = v67;
                end;

                v67.LayoutOrder = i;
                local v68 = v66:Display(v.Progress, v.Target, v.Arguments);
                v67.Title.Text = v68.Title;
                v67.Bar.Loader.Size = UDim2.fromScale(math.clamp(v.Progress / v.Target, 0, 1), 1);
                v67.Bar.Progress.Text = v.Completed and "Completed!" or v68.Bar;
            end;
        end;

        for i in u6 do
            local v69 = i;
            local v70 = false;

            for _, v in v64.Quests do
                if v.Id == v69 then
                    v70 = true;
                    break;
                end;
            end;

            if not v70 then
                local v71 = u6[v69];

                if v71 then
                    v71:Destroy();
                    u6[v69] = nil;
                end;
            end;
        end;

        updateButton();
        u52();
    end;

    local function updateTimerLabel() -- Line: 547
        -- upvalues: Title (ref), formatTime (copy), Config (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v72 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;
        Title.Text = `Refreshes in {formatTime((math.max(v72, 0)))}`;
    end;

    local function updateModelBillboard() -- Line: 551
        -- upvalues: Timer (copy), formatTime (copy), Config (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v73 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;
        Timer.Text = "Refreshes in " .. formatTime((math.max(v73, 0)));
    end;

    local ContentProvider = game:GetService("ContentProvider");
    local u74 = {};
    local u75 = {};
    local u76 = 0;

    local function buildRewardPreviewIcons() -- Line: 567
        -- upvalues: u74 (copy), u75 (copy), u76 (ref), ITEM_IMAGE (ref), ITEM_IMAGE2 (copy), Config (ref), ItemNameFinder (ref), ItemImageFinder (ref), RewardFrame (ref), RewardFrame2 (copy), ContentProvider (copy)
        for _, v in u74 do
            v:Destroy();
        end;

        for _, v in u75 do
            v:Destroy();
        end;

        table.clear(u74);
        table.clear(u75);
        u76 = 0;
        ITEM_IMAGE.Visible = false;
        ITEM_IMAGE2.Visible = false;
        local v77 = Config.RewardPool or {};

        for _, v in v77 do
            local Reward = v.Reward;

            if Reward then
                local v78 = ITEM_IMAGE:Clone();
                v78.Name = "RewardPreviewIcon";
                v78.Visible = false;
                v78:SetAttribute("DisplayName", (ItemNameFinder(tostring(Reward.Value), Reward.Type)));
                v78:SetAttribute("RewardValue", Reward.Value);
                local v79 = tostring(Reward.Value);
                local success, result = pcall(ItemImageFinder, v79, Reward.Type);

                if success and result then
                    v78.Image = result;
                end;

                v78.Parent = RewardFrame;
                table.insert(u74, v78);
            end;
        end;

        for _, v in v77 do
            local Reward = v.Reward;

            if Reward then
                local v80 = ITEM_IMAGE2:Clone();
                v80.Name = "RewardPreviewIcon";
                v80.Visible = false;
                v80:SetAttribute("DisplayName", (ItemNameFinder(tostring(Reward.Value), Reward.Type)));
                v80:SetAttribute("RewardValue", Reward.Value);
                local v81 = tostring(Reward.Value);
                local success, result = pcall(ItemImageFinder, v81, Reward.Type);

                if success and result then
                    v80.Image = result;
                end;

                v80.Parent = RewardFrame2;
                table.insert(u75, v80);
            end;
        end;

        if #u74 > 0 then
            task.spawn(function() -- Line: 616
                -- upvalues: ContentProvider (ref), u74 (ref)
                pcall(function() -- Line: 617
                    -- upvalues: ContentProvider (ref), u74 (ref)
                    ContentProvider:PreloadAsync(u74);
                end);
            end);
        end;
    end;

    local function advanceRewardPreview() -- Line: 623
        -- upvalues: u74 (copy), u76 (ref), u75 (copy), Title3 (ref), Title4 (copy)
        if #u74 == 0 then
            return;
        end;

        if u74[u76] then
            u74[u76].Visible = false;
            u75[u76].Visible = false;
        end;

        u76 = u76 + 1;

        if u76 > #u74 then
            u76 = 1;
        end;

        local v82 = u74[u76];
        v82.Visible = true;
        Title3.Text = `[{v82:GetAttribute("DisplayName")}]`;
        local v83 = u75[u76];
        v83.Visible = true;
        Title4.Text = `{v83:GetAttribute("DisplayName")}`;
    end;

    u52 = function() -- Line: 645, Name: updateRewardPreviewProgress
        -- upvalues: u5 (ref), Progress (ref)
        local v84 = u5 and u5.SummerQuestData or nil;
        local v85;

        if v84 and (v84.ContainerId and v84.ContainerId ~= "") and u5.QuestContainers then
            v85 = u5.QuestContainers[v84.ContainerId];
        else
            v85 = nil;
        end;

        if not (v85 and v85.Quests) then
            return;
        end;

        local v86 = 0;

        for _, v in v85.Quests do
            if not v.Completed then
                v86 = v86 + 1;
            end;
        end;

        if v86 <= 0 then
            Progress.Text = "Quests Completed";

            return;
        end;

        if v86 == 1 then
            Progress.Text = "1 Quest Remaining";

            return;
        end;

        Progress.Text = `{v86} Quests Remaining`;
    end;

    function u2.OpenUI(p87) -- Line: 663
        -- upvalues: u2 (ref), closeRewards (ref), updateQuests (copy), Title (ref), formatTime (copy), Config (ref), GuiController (ref), SummerQuest_UI (ref)
        u2:GetState();
        closeRewards();
        updateQuests();
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v88 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;
        Title.Text = `Refreshes in {formatTime((math.max(v88, 0)))}`;
        GuiController:Open(SummerQuest_UI);
    end;

    function u2.CloseUI(p89) -- Line: 673
        -- upvalues: GuiController (ref), SummerQuest_UI (ref)
        GuiController:Close(SummerQuest_UI);
    end;

    u5 = DataService:GetData();
    SummerQuest_UI.Enabled = false;
    Quests2.Visible = true;
    Rewards.Visible = false;
    Odds.Visible = false;
    SetupButton({
        legacy = true,
        instance = skipQuestsButton,

        onclick = function() -- Line: 690, Name: onclick
            -- upvalues: u2 (ref)
            u2:PromptSkip();
        end
    });
    SetupButton({
        legacy = true,
        instance = Close,

        onclick = function() -- Line: 694, Name: onclick
            -- upvalues: u2 (ref)
            u2:CloseUI();
        end
    });
    SetupButton({
        legacy = true,
        instance = MakeAWish,

        onclick = function() -- Line: 699, Name: onclick
            -- upvalues: openRewards (ref)
            openRewards();
        end
    });

    if ExitButton then
        ExitButton.Visible = true;
        u1:Add(ExitButton.Activated:Connect(function() -- Line: 708
            -- upvalues: closeRewards (ref)
            closeRewards();
        end));
    end;

    u1:Add(RerollButton.Activated:Connect(function() -- Line: 710
        -- upvalues: u2 (ref)
        u2:PromptReroll();
    end));
    u1:Add(OddsButton2.Activated:Connect(openOdds));
    u1:Add(ExitButton2.Activated:Connect(closeOdds));
    u1:Add(OddsButton.Activated:Connect(openOdds));

    local function onDataChanged() -- Line: 716
        -- upvalues: u2 (ref), updateQuests (copy), SummerQuest_UI (ref), Title (ref), formatTime (copy), Config (ref), u5 (ref), Rewards (ref), Odds (ref), closeRewards (ref), renderRewards (copy), updateRerollUI (copy)
        local v90 = u2.State and u2.State.RewardClaimed;
        u2:GetState();
        updateQuests();

        if SummerQuest_UI.Enabled then
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v91 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;
            Title.Text = `Refreshes in {formatTime((math.max(v91, 0)))}`;
        end;

        local v92 = u5 and u5.SummerQuestData or nil;
        local v93 = v92 and v92.RewardsReady and not v92.RewardClaimed;

        if v92 and (v92.RewardClaimed and not v90) then
            if Rewards.Visible or Odds.Visible then
                closeRewards();
            end;

            return;
        end;

        if v93 then
            if SummerQuest_UI.Enabled and Rewards.Visible then
                renderRewards();
                updateRerollUI();
            end;

            return;
        end;

        if Rewards.Visible then
            closeRewards();
        end;
    end;

    u1:Add(DataService:GetPathSignal("SummerQuestData/@"):Connect(onDataChanged));
    u1:Add(DataService:GetPathSignal("QuestContainers/@"):Connect(onDataChanged));
    u2:GetState();
    updateQuests();
    u1:Add((task.spawn(function() -- Line: 759
        -- upvalues: Timer (copy), formatTime (copy), Config (ref), SummerQuest_UI (ref), Title (ref)
        while true do
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v94 = (math.floor(ServerTimeNow / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow;
            Timer.Text = "Refreshes in " .. formatTime((math.max(v94, 0)));

            if SummerQuest_UI.Enabled then
                local ServerTimeNow2 = workspace:GetServerTimeNow();
                local v95 = (math.floor(ServerTimeNow2 / Config.REFRESH_INTERVAL) + 1) * Config.REFRESH_INTERVAL - ServerTimeNow2;
                Title.Text = `Refreshes in {formatTime((math.max(v95, 0)))}`;
            end;

            task.wait(0.5);
        end;
    end)));
    buildRewardPreviewIcons();
    advanceRewardPreview();
    u1:Add((task.spawn(function() -- Line: 772
        -- upvalues: Config (ref), advanceRewardPreview (copy)
        while true do
            task.wait((math.max(Config.REWARD_CYCLE_INTERVAL or 5, 0.1)));
            advanceRewardPreview();
        end;
    end)));
    local v96 = { "What\'s going on?", "View Quests!", "Goodbye" };
    NPCDialogueController:Start({
        ExitLine = "Good luck!",
        DeactivationDistance = 20,
        ProximityPrompt = ProximityPrompt,
        SpeakingNPC = NPC,
        PromptList = v96,
        OperationMap = {
            [v96[1]] = function() -- Line: 789
                -- upvalues: Config (ref), Top_Text (ref), NPC (copy)
                for i = 1, #Config.MESSAGE_QUESTION do
                    local v97 = Config.MESSAGE_QUESTION[i];
                    Top_Text.NpcText(NPC, v97[2], true);
                    task.wait(v97[1]);
                    local _ = i;
                end;
            end,

            [v96[2]] = function() -- Line: 797
                -- upvalues: u2 (ref)
                u2:OpenUI();
            end,

            [v96[3]] = function() -- Line: 801
                -- upvalues: Top_Text (ref), NPC (copy)
                Top_Text.NpcText(NPC, "Goodbye!", true);
                task.wait(2);
            end
        },
        IntroLines = { "Howdy Camper!" },
        RootPart = NPC.PrimaryPart,

        OnDialogueStarted = function() -- Line: 818, Name: OnDialogueStarted
            return nil;
        end,

        OnDialogueEnded = function() -- Line: 819, Name: OnDialogueEnded
            return nil;
        end
    });
    u1:Add(ProximityPrompt2.Triggered:Connect(function() -- Line: 822
        -- upvalues: u2 (ref)
        u2:OpenUI();
    end));
    u1:Add(SFX.OnClientEvent:Connect(function(p98) -- Line: 826
        if not p98 then
            return;
        end;

        local v99 = script:FindFirstChild(p98);

        if v99 then
            v99:Play();
        end;
    end));
    u1:Add(RewardsReady.OnClientEvent:Connect(function(p100) -- Line: 834
        -- upvalues: Rewards (ref), renderRewards (copy), updateRerollUI (copy)
        if Rewards.Visible then
            renderRewards(p100);
            updateRerollUI();
        end;
    end));
end;

local u101 = false;
EventRotationController.EventUpdated:Connect(function(p102: string, p103: string) -- Line: 848, Name: OnEventUpdated
    -- upvalues: u1 (copy), u101 (ref), u2 (copy)
    if p103 ~= "CampfireEvent" then
        u1:Clean();
        u101 = false;

        return;
    end;

    if p102 ~= "CampfireEventPart4" then
        return;
    end;

    if u101 then
        return;
    end;

    u101 = true;
    u1:Clean();
    task.spawn(u2.Start, u2);
end);

return u2;