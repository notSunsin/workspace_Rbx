-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContextActionService = game:GetService("ContextActionService");
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local DataService = require(ReplicatedStorage.Modules.DataService);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local Color3_fromRGB_ret = Color3.fromRGB(0, 255, 21);
local Color3_fromRGB_ret2 = Color3.fromRGB(191, 107, 70);
local u2 = {
    Crate = true,
    Egg = true,
    ["Seed Pack"] = true
};
local RestartMoney = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("HarvestMoonQuests"):WaitForChild("RestartMoney");
local HarvestMoonQuests_UI = PlayerGui:WaitForChild("HarvestMoonQuests_UI");
local RewardsWithQuests = HarvestMoonQuests_UI:WaitForChild("RewardsWithQuests");
local Main = RewardsWithQuests:WaitForChild("Main");
local TierRewards = Main:WaitForChild("TierRewards");
local Progress = Main:WaitForChild("Progress");
local ProgressBar = Progress:WaitForChild("ProgressBar");
local ProgressionContainer = Progress:WaitForChild("ProgressionContainer");
local Quests = RewardsWithQuests:WaitForChild("Quests");
local Slots = Quests:WaitForChild("Main"):WaitForChild("Slots");
local QuestTemplateNew = Slots:WaitForChild("UIListLayout"):FindFirstChild("QuestTemplateNew");
local RestartFrame = RewardsWithQuests:WaitForChild("RestartFrame");
local u3 = {
    Basic = TierRewards:WaitForChild("UIListLayout"):FindFirstChild("BasicTemplate"),
    Mid = TierRewards:WaitForChild("UIListLayout"):FindFirstChild("MidTemplate"),
    Best = TierRewards:WaitForChild("UIListLayout"):FindFirstChild("BestTemplate")
};
local u4 = {};
local u5 = {
    Visible = false,
    ScrollOffset = 0,
    Started = false,
    TierFrames = {},
    RenderedQuests = {}
};

local function getConfig() -- Line: 88
    -- upvalues: GameConfigController (copy)
    return GameConfigController:GetConfig("HarvestMoonQuestsConfig");
end;

local function getQuestData() -- Line: 92
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonQuestData;
    end;

    return Data;
end;

local function getSortedTierKeys(u6) -- Line: 98
    local v7 = {};

    for i in u6.PersonalRewards do
        table.insert(v7, i);
    end;

    table.sort(v7, function(p8, p9) -- Line: 103
        -- upvalues: u6 (copy)
        return u6.PersonalRewards[p8].RequiredPoints < u6.PersonalRewards[p9].RequiredPoints;
    end);

    return v7;
end;

local function isTrackComplete(p10, p11) -- Line: 109
    if not (p11 and p11.ClaimedTiers) then
        return false;
    end;

    for i in p10.PersonalRewards do
        if not p11.ClaimedTiers[i] then
            return false;
        end;
    end;

    return true;
end;

local function getSecondsUntilRefresh(p12) -- Line: 117
    local REFRESH_INTERVAL = p12.REFRESH_INTERVAL;
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v13 = (math.floor(ServerTimeNow / REFRESH_INTERVAL) + 1) * REFRESH_INTERVAL - ServerTimeNow;

    return math.max(v13, 0);
end;

local function ensureTierFrame(p14: number, p15: string?) -- Line: 127
    -- upvalues: u5 (copy), u3 (copy), TierRewards (copy)
    local v16 = p15 or "Basic";
    local v17 = u5.TierFrames[p14];

    if v17 and v17:GetAttribute("TemplateType") == v16 then
        return v17;
    end;

    if v17 then
        v17:Destroy();
    end;

    local v18 = (u3[v16] or u3.Basic):Clone();
    v18:SetAttribute("TemplateType", v16);
    v18.LayoutOrder = p14;
    v18.Visible = true;
    v18.Parent = TierRewards;
    u5.TierFrames[p14] = v18;

    return v18;
end;

local function setCardClaimed(p19: any, p20: boolean) -- Line: 144
    local CompletedFrame = p19:FindFirstChild("CompletedFrame");

    if CompletedFrame then
        CompletedFrame.Visible = p20;
    end;
end;

local function renderTiers(p21, p22) -- Line: 151
    -- upvalues: getSortedTierKeys (copy), u5 (copy), ensureTierFrame (copy), ItemImageFinder (copy), u2 (copy), GameConfigController (copy), CosmeticCrateOddsController (copy), HarvestMoonQuests_UI (copy), PetEggOddsController (copy), SeedPackOddsController (copy), ProgressionContainer (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), ProgressBar (copy)
    local v23 = p22 and (p22.Points or 0) or 0;
    local v24 = p22 and p22.ClaimedTiers or {};
    local v25 = getSortedTierKeys(p21);

    for i = 1, 6 do
        local v26 = i + u5.ScrollOffset;
        local v27 = v25[v26];
        local v28;

        if v27 then
            v28 = p21.PersonalRewards[v27];
        else
            v28 = v27;
        end;

        local u29 = ensureTierFrame(i, v28 and (v28.Template or "Basic") or "Basic");
        u29.Visible = v28 ~= nil;
        local v30;

        if v28 then
            local Inner = u29:WaitForChild("Inner");
            local v31 = v28.RequiredPoints or 0;
            Inner:WaitForChild("PointAmountText").Text = tostring(v31);
            v30 = i;
            local v32 = "";

            for _, v in v28.Rewards do
                local v33;

                if v.Variant then
                    v33 = `{v.Variant} {v.Value}`;
                else
                    v33 = v.Value;
                end;

                v32 = v32 .. `x{v.Quantity or 1} {v33 == "MoonCoins" and "Moon Coins" or v33}, `;
            end;

            if #v32 >= 2 then
                v32 = ` {v32:sub(1, #v32 - 2)} `;
            end;

            Inner:WaitForChild("RewardNameText").Text = v32;
            local Vector = Inner:FindFirstChild("Vector");
            local v34 = v28.Rewards[1];

            if Vector and v34 then
                Vector.Image = v34.CustomImage or ItemImageFinder(v34.Value, v34.Type);
            end;

            local v35 = v24[v27] == true;
            local v36 = v31 <= v23;
            local CompletedFrame = u29:FindFirstChild("CompletedFrame");

            if CompletedFrame then
                CompletedFrame.Visible = v35;
            end;

            u29.Inner.BackgroundTransparency = 0;
            u29:SetAttribute("TierKey", v27);
            local OddsButton = Inner:FindFirstChild("OddsButton");

            if OddsButton and OddsButton:IsA("GuiButton") then
                local v37;

                if v34 == nil then
                    v37 = false;
                else
                    v37 = u2[v34.Type] == true;
                end;

                OddsButton.Visible = v37;

                if not OddsButton:GetAttribute("Wired") then
                    OddsButton:SetAttribute("Wired", true);
                    OddsButton.Activated:Connect(function() -- Line: 208
                        -- upvalues: GameConfigController (ref), u29 (copy), CosmeticCrateOddsController (ref), HarvestMoonQuests_UI (ref), PetEggOddsController (ref), SeedPackOddsController (ref)
                        local Config = GameConfigController:GetConfig("HarvestMoonQuestsConfig");
                        local Attribute = u29:GetAttribute("TierKey");

                        if Attribute then
                            if Config then
                                Config = Config.PersonalRewards[Attribute];
                            end;
                        else
                            Config = Attribute;
                        end;

                        local v38 = Config and Config.Rewards and Config.Rewards[1];

                        if not v38 then
                            return;
                        end;

                        if v38.Type == "Crate" then
                            CosmeticCrateOddsController:Open(v38.Value, HarvestMoonQuests_UI);

                            return;
                        end;

                        if v38.Type == "Egg" then
                            PetEggOddsController:Open(v38.Value, HarvestMoonQuests_UI);

                            return;
                        end;

                        if v38.Type == "Seed Pack" then
                            SeedPackOddsController:Open(v38.Value, HarvestMoonQuests_UI);
                        end;
                    end);
                end;
            end;

            local v39 = ProgressionContainer:FindFirstChild((tostring(v30)));

            if v39 then
                local v40 = v39:FindFirstChild("Dot") and v39.Dot:FindFirstChild("Container");

                if v40 then
                    local v41;

                    if v36 then
                        v41 = Color3_fromRGB_ret;
                    else
                        v41 = Color3_fromRGB_ret2;
                    end;

                    v40.BackgroundColor3 = v41;
                end;

                local v42 = v39:FindFirstChildWhichIsA("TextLabel", true) or v39:FindFirstChildWhichIsA("TextButton", true);

                if v42 then
                    v42.Text = `{v26}.`;
                end;
            end;
        else
            v30 = i;
        end;
    end;

    local ScrollOffset = u5.ScrollOffset;
    local v43 = 0;

    for i = 1, 6 do
        local v44 = v25[i + ScrollOffset];

        if v44 then
            v44 = p21.PersonalRewards[v44];
        end;

        local v45;

        if v44 and (v44.RequiredPoints or 0) <= v23 then
            v43 = i;
            v45 = v43;
            local v46 = v43;
            v43 = v45;
            v46 = v45;
        else
            v45 = i;
        end;
    end;

    ProgressBar.Size = UDim2.fromScale(math.clamp(v43 / 6, 0, 1), 1);

    return #v25;
end;

local function removeQuest(p47) -- Line: 255
    -- upvalues: u5 (copy)
    local v48 = u5.RenderedQuests[p47];

    if v48 then
        v48:Destroy();
        u5.RenderedQuests[p47] = nil;
    end;
end;

local function renderQuests(p49) -- Line: 263
    -- upvalues: QuestsController (copy), u5 (copy), QuestTemplateNew (copy), Slots (copy)
    if p49 then
        p49 = p49.ContainerId;
    end;

    if p49 then
        if p49 == "" then
            p49 = false;
        else
            p49 = QuestsController:GetContainerFromId(p49);
        end;
    end;

    if not (p49 and p49.Quests) then
        for i in u5.RenderedQuests do
            local v50 = u5.RenderedQuests[i];

            if v50 then
                v50:Destroy();
                u5.RenderedQuests[i] = nil;
            end;
        end;

        return;
    end;

    for i, v in p49.Quests do
        local Quest = QuestsController:GetQuest(v.Type);

        if Quest then
            local v51 = u5.RenderedQuests[v.Id];

            if not v51 then
                v51 = QuestTemplateNew:Clone();
                v51.Visible = true;
                v51.LayoutOrder = i;
                v51.Parent = Slots;
                u5.RenderedQuests[v.Id] = v51;
            end;

            local v52 = Quest:Display(v.Progress, v.Target, v.Arguments);
            v51.Title.Text = v52.Title;
            v51.Bar.Loader.Size = UDim2.fromScale(math.clamp(v.Progress / v.Target, 0, 1), 1);
            v51.Bar.Progress.Text = v.Completed and "Completed!" or v52.Bar;
        end;
    end;

    for i in u5.RenderedQuests do
        local v53 = i;
        local v54 = false;

        for _, v in p49.Quests do
            if v.Id == v53 then
                v54 = true;
                break;
            end;
        end;

        if not v54 then
            local v55 = u5.RenderedQuests[v53];

            if v55 then
                v55:Destroy();
                u5.RenderedQuests[v53] = nil;
            end;
        end;
    end;
end;

local function renderRestart(p56, p57) -- Line: 303
    -- upvalues: RestartFrame (copy), Quests (copy)
    local v58;

    if p57 and p57.ClaimedTiers then
        v58 = true;

        for i in p56.PersonalRewards do
            if not p57.ClaimedTiers[i] then
                v58 = false;
                break;
            end;
        end;
    else
        v58 = false;
    end;

    RestartFrame.Visible = v58;
    local Skip = Quests.Buttons:FindFirstChild("Skip");

    if Skip then
        Skip.Visible = not v58;
    end;
end;

local function renderCountdown(p59) -- Line: 317
    -- upvalues: Quests (copy), NumberUtil (copy)
    local ResetsIn = Quests.Buttons:FindFirstChild("ResetsIn");

    if ResetsIn then
        ResetsIn = ResetsIn:FindFirstChild("Label");
    end;

    if ResetsIn then
        local REFRESH_INTERVAL = p59.REFRESH_INTERVAL;
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v60 = (math.floor(ServerTimeNow / REFRESH_INTERVAL) + 1) * REFRESH_INTERVAL - ServerTimeNow;
        local math_max_ret = math.max(v60, 0);
        ResetsIn.Text = `Refreshes in <font color="rgb(255, 78, 78)">{NumberUtil.compactFormat(math_max_ret)}</font>`;
    end;
end;

local function renderPoints(p61) -- Line: 327
    -- upvalues: Quests (copy)
    local v62 = p61 and p61.Points or 0;
    local Points = Quests.Header:FindFirstChild("Points");

    if Points then
        Points.Text = `Total: {v62}`;
    end;
end;

function u4.Render(p63) -- Line: 338
    -- upvalues: GameConfigController (copy), DataService (copy), renderTiers (copy), renderQuests (copy), RestartFrame (copy), Quests (copy), NumberUtil (copy)
    local Config = GameConfigController:GetConfig("HarvestMoonQuestsConfig");

    if not Config then
        return;
    end;

    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonQuestData;
    end;

    renderTiers(Config, Data);
    renderQuests(Data);
    local v64;

    if Data and Data.ClaimedTiers then
        v64 = true;

        for i in Config.PersonalRewards do
            if not Data.ClaimedTiers[i] then
                v64 = false;
                break;
            end;
        end;
    else
        v64 = false;
    end;

    RestartFrame.Visible = v64;
    local Skip = Quests.Buttons:FindFirstChild("Skip");

    if Skip then
        Skip.Visible = not v64;
    end;

    local ResetsIn = Quests.Buttons:FindFirstChild("ResetsIn");

    if ResetsIn then
        ResetsIn = ResetsIn:FindFirstChild("Label");
    end;

    if ResetsIn then
        local REFRESH_INTERVAL = Config.REFRESH_INTERVAL;
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v65 = (math.floor(ServerTimeNow / REFRESH_INTERVAL) + 1) * REFRESH_INTERVAL - ServerTimeNow;
        local math_max_ret = math.max(v65, 0);
        ResetsIn.Text = `Refreshes in <font color="rgb(255, 78, 78)">{NumberUtil.compactFormat(math_max_ret)}</font>`;
    end;

    local v66 = Data and Data.Points or 0;
    local Points = Quests.Header:FindFirstChild("Points");

    if Points then
        Points.Text = `Total: {v66}`;
    end;
end;

function u4.ScrollTo(p67: table, p68: number) -- Line: 350
    -- upvalues: GameConfigController (copy), getSortedTierKeys (copy), u5 (copy), u4 (copy)
    local Config = GameConfigController:GetConfig("HarvestMoonQuestsConfig");

    if not Config then
        return;
    end;

    local v69 = #getSortedTierKeys(Config) - 6;
    local math_max_ret = math.max(0, v69);
    u5.ScrollOffset = math.clamp(p68, 0, math_max_ret);
    u4:Render();
end;

function u4.Toggle(p70: table, p71: boolean?) -- Line: 361
    -- upvalues: u5 (copy), RewardsWithQuests (copy), u4 (copy), GuiController (copy), HarvestMoonQuests_UI (copy), ContextActionService (copy)
    if p71 == nil then
        p71 = not u5.Visible;
    end;

    u5.Visible = p71;
    RewardsWithQuests.Visible = p71;

    if not p71 then
        GuiController:Close(HarvestMoonQuests_UI);
        ContextActionService:UnbindAction("HarvestMoonQuests_SinkScroll");

        return;
    end;

    u4:Render();
    GuiController:Open(HarvestMoonQuests_UI);
    ContextActionService:BindActionAtPriority("HarvestMoonQuests_SinkScroll", function() -- Line: 372
        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.UserInputType.MouseWheel);
end;

function u4.Start(p72) -- Line: 386
    -- upvalues: u5 (copy), GuiController (copy), HarvestMoonQuests_UI (copy), RewardsWithQuests (copy), SetupButton (copy), u4 (copy), Quests (copy), GameConfigController (copy), MarketController (copy), RestartFrame (copy), RestartMoney (copy), Comma_Module (copy), Main (copy), u1 (copy), DataService (copy), NumberUtil (copy)
    if u5.Started then
        return;
    end;

    u5.Started = true;
    GuiController:GetStateForGui(HarvestMoonQuests_UI).ChangeEnabled:Set(true);
    local Rewards = HarvestMoonQuests_UI:FindFirstChild("Rewards");

    if Rewards then
        Rewards.Visible = false;
    end;

    local TeamRewards = RewardsWithQuests.Header:FindFirstChild("TeamRewards");

    if TeamRewards then
        TeamRewards.Visible = false;
    end;

    local ResetTrack = RewardsWithQuests.Header:FindFirstChild("ResetTrack");

    if ResetTrack then
        ResetTrack.Visible = false;
    end;

    local Close = RewardsWithQuests.Header:FindFirstChild("Close");

    if Close then
        SetupButton({
            legacy = true,
            instance = Close,

            onclick = function() -- Line: 405, Name: onclick
                -- upvalues: u4 (ref)
                u4:Toggle(false);
            end
        });
    end;

    local Skip = Quests.Buttons:FindFirstChild("Skip");

    if Skip then
        SetupButton({
            legacy = true,
            instance = Skip,

            onclick = function() -- Line: 414, Name: onclick
                -- upvalues: GameConfigController (ref), MarketController (ref)
                local Config = GameConfigController:GetConfig("HarvestMoonQuestsConfig");

                if Config and (Config.SKIP_QUESTS_PRODUCT_ID and Config.SKIP_QUESTS_PRODUCT_ID > 0) then
                    MarketController:PromptPurchase(Config.SKIP_QUESTS_PRODUCT_ID, Enum.InfoType.Product);
                end;
            end
        });
    end;

    local v73 = RestartFrame:FindFirstChild("Widget") and RestartFrame.Widget:FindFirstChild("RestartButtons");

    if v73 then
        local RestartRobux = v73:FindFirstChild("RestartRobux");

        if RestartRobux then
            SetupButton({
                legacy = true,
                instance = RestartRobux,

                onclick = function() -- Line: 431, Name: onclick
                    -- upvalues: GameConfigController (ref), MarketController (ref)
                    local Config = GameConfigController:GetConfig("HarvestMoonQuestsConfig");

                    if Config and (Config.RESTART_TRACK_PRODUCT_ID and Config.RESTART_TRACK_PRODUCT_ID > 0) then
                        MarketController:PromptPurchase(Config.RESTART_TRACK_PRODUCT_ID, Enum.InfoType.Product);
                    end;
                end
            });
        end;

        local RestartScheckles = v73:FindFirstChild("RestartScheckles");

        if RestartScheckles then
            SetupButton({
                legacy = true,
                instance = RestartScheckles,

                onclick = function() -- Line: 444, Name: onclick
                    -- upvalues: RestartMoney (ref)
                    RestartMoney:FireServer();
                end
            });
        end;

        local function costLabel(p74) -- Line: 451
            if p74 then
                p74 = p74:FindFirstChild("TextLabel");
            end;

            return p74;
        end;

        local Config = GameConfigController:GetConfig("HarvestMoonQuestsConfig");

        if Config then
            if RestartScheckles then
                RestartScheckles = RestartScheckles:FindFirstChild("TextLabel");
            end;

            if RestartScheckles and Config.RESTART_MONEY_COST then
                RestartScheckles.Text = Comma_Module.Comma(Config.RESTART_MONEY_COST) .. "¢";
            end;

            if RestartRobux then
                RestartRobux = RestartRobux:FindFirstChild("TextLabel");
            end;

            if RestartRobux and (Config.RESTART_TRACK_PRODUCT_ID and Config.RESTART_TRACK_PRODUCT_ID > 0) then
                MarketController:SetPriceLabel(RestartRobux, Config.RESTART_TRACK_PRODUCT_ID);
            end;
        end;
    end;

    local MoveLeft = Main:FindFirstChild("MoveLeft");

    if MoveLeft then
        SetupButton({
            legacy = true,
            instance = MoveLeft,

            onclick = function() -- Line: 474, Name: onclick
                -- upvalues: u4 (ref), u5 (ref)
                u4:ScrollTo(u5.ScrollOffset - 1);
            end
        });
    end;

    local MoveRight = Main:FindFirstChild("MoveRight");

    if MoveRight then
        SetupButton({
            legacy = true,
            instance = MoveRight,

            onclick = function() -- Line: 478, Name: onclick
                -- upvalues: u4 (ref), u5 (ref)
                u4:ScrollTo(u5.ScrollOffset + 1);
            end
        });
    end;

    u1:Add(DataService:GetPathSignal("HarvestMoonQuestData/@"):Connect(function() -- Line: 482
        -- upvalues: u5 (ref), u4 (ref)
        if u5.Visible then
            u4:Render();
        end;
    end));
    u1:Add(DataService:GetPathSignal("QuestContainers/@"):Connect(function() -- Line: 485
        -- upvalues: u5 (ref), u4 (ref)
        if u5.Visible then
            u4:Render();
        end;
    end));
    u1:Add(task.spawn(function() -- Line: 490
        -- upvalues: u5 (ref), GameConfigController (ref), Quests (ref), NumberUtil (ref)
        task.wait(math.random() * 0.9);

        while true do
            if u5.Visible then
                local Config = GameConfigController:GetConfig("HarvestMoonQuestsConfig");
                local ResetsIn = Quests.Buttons:FindFirstChild("ResetsIn");

                if ResetsIn then
                    ResetsIn = ResetsIn:FindFirstChild("Label");
                end;

                if ResetsIn then
                    local REFRESH_INTERVAL = Config.REFRESH_INTERVAL;
                    local ServerTimeNow = workspace:GetServerTimeNow();
                    local v75 = (math.floor(ServerTimeNow / REFRESH_INTERVAL) + 1) * REFRESH_INTERVAL - ServerTimeNow;
                    local math_max_ret = math.max(v75, 0);
                    ResetsIn.Text = `Refreshes in <font color="rgb(255, 78, 78)">{NumberUtil.compactFormat(math_max_ret)}</font>`;
                end;
            end;

            task.wait(1);
        end;
    end));
    RewardsWithQuests.Visible = false;
end;

EventRotationClientBinder:Bind({
    EventSet = "HarvestMoonEvent",
    Script = script,

    OnStart = function() -- Line: 505, Name: OnStart
        -- upvalues: u4 (copy)
        task.spawn(u4.Start, u4);
    end,

    OnStop = function() -- Line: 506, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u4;