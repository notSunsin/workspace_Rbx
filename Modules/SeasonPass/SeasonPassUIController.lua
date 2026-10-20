-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
game:GetService("RunService");
local SeasonPassRewardsController = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassRewardsController);
local SeasonPassQuestsController = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassQuestsController);
local SeasonPassShopController = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassShopController);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local SeasonPassToggler = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassToggler);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SeasonPassButtonEffects = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassButtonEffects);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local SeasonPassData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassData);
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local SeasonPassUtils = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassUtils);
local Notification = require(ReplicatedStorage.Modules.Notification);
local UpdateSeasonPass = ReplicatedStorage.GameEvents.SeasonPass.UpdateSeasonPass;
local v1 = {};
local SeasonPassUI = Players.LocalPlayer.PlayerGui.SeasonPassUI;
local Main = SeasonPassUI.SeasonPassFrame.Main;
local TopBtns = SeasonPassUI.SeasonPassFrame.TopBtns;
local Close = SeasonPassUI.SeasonPassFrame.Close;
local PremiumSection = SeasonPassUI.SeasonPassFrame.PremiumSection;
local SeasonPassTemplates = SeasonPassUI.SeasonPassTemplates;
local IncludesTextTemplate = SeasonPassTemplates.IncludesTextTemplate;
local CurrentSeason = SeasonPassData.CurrentSeason;
local u2 = nil;
local Pass = Players.LocalPlayer.PlayerGui.Hud_UI.SideBtns.Pass;

local function PremiumSignalFunc() -- Line: 44
    -- upvalues: DataService (copy), Players (copy), SeasonPassData (copy), SeasonPassStaticData (copy), PremiumSection (copy)
    local Data = DataService:GetData();

    if not Data then
        warn((`No player data {Players.LocalPlayer}`));

        return;
    end;

    if not SeasonPassData.CurrentSeason then
        return;
    end;

    local v3 = Data.SeasonPass[SeasonPassData.CurrentSeason];

    if not v3 then
        return;
    end;

    local IsPremium = v3.IsPremium;
    local Background = SeasonPassStaticData.ButtonColors.Gray.Background;
    local Background2 = SeasonPassStaticData.ButtonColors.White.Background;
    local Buy = PremiumSection.Buy;
    local v4;

    if IsPremium then
        v4 = Background;
    else
        v4 = Background2;
    end;

    PremiumSection.Buy.TextLabel.TextColor3 = v4;

    if IsPremium then
        Background2 = Background;
    end;

    Buy.ImageColor3 = Background2;
    Buy.Interactable = not IsPremium;
end;

local function WaitForSeasonData() -- Line: 78
    -- upvalues: SeasonPassData (copy), DataService (copy)
    local CurrentSeason2 = SeasonPassData.CurrentSeason;

    while CurrentSeason2 and CurrentSeason2 == SeasonPassData.CurrentSeason do
        local Data = DataService:GetData();
        local v5 = Data and Data.SeasonPass and Data.SeasonPass[CurrentSeason2];

        if v5 then
            return v5;
        end;

        task.wait(0.5);
    end;

    return nil;
end;

local function UpdateSeasonPassUI() -- Line: 92
    -- upvalues: SeasonPassData (copy), PremiumSection (copy), SeasonPassTemplates (copy), SeasonPassStaticData (copy), IncludesTextTemplate (copy), SeasonPassUI (copy), WaitForSeasonData (copy)
    if not SeasonPassData.CurrentSeason then
        return;
    end;

    local v6 = SeasonPassData.PreviousSeason and PremiumSection:FindFirstChild((`{SeasonPassData.PreviousSeason:gsub(" ", "")}ImageBackground`));

    if v6 then
        v6.Visible = false;
        v6.Parent = SeasonPassTemplates.ImageBackgrounds;
    end;

    local v7 = SeasonPassData.CurrentSeason:gsub(" ", "");
    local v8 = SeasonPassTemplates.ImageBackgrounds:FindFirstChild((`{v7}ImageBackground`));

    if v8 then
        v8.Parent = PremiumSection;
        v8.Visible = true;
    elseif not PremiumSection:FindFirstChild((`{v7}ImageBackground`)) then
        warn((`No image background found for {v7}: {v8}`));
    end;

    local Includes = PremiumSection.Includes;

    for _, child in Includes:GetChildren() do
        if child:IsA("TextLabel") and child.Name ~= "Top" then
            child:Destroy();
        end;
    end;

    local Text = SeasonPassStaticData.ButtonColors.Gold.Text;
    local Text2 = SeasonPassStaticData.ButtonColors.White.Text;
    local IncludesItems = SeasonPassData.IncludesItems;

    for i, v in IncludesItems do
        local v9 = IncludesTextTemplate:Clone();
        v9.Text = v;
        v9.LayoutOrder = i;
        local v10;

        if i <= 2 then
            v10 = Text;
        else
            v10 = Text2;
        end;

        v9.TextColor3 = v10;
        v9.TextTransparency = i <= 2 and 0 or math.abs(0 - i / #IncludesItems) - 0.5;
        v9.UIStroke.Transparency = v9.TextTransparency;
        v9.Visible = true;
        v9.Parent = Includes;
    end;

    SeasonPassUI.SeasonPassFrame.Title.Text = SeasonPassData.CurrentSeason;
    local TextLabel = PremiumSection.Buy.TextLabel;
    local Buy = PremiumSection.Buy;
    local Background = SeasonPassStaticData.ButtonColors.Gray.Background;
    local Background2 = SeasonPassStaticData.ButtonColors.White.Background;
    Buy.Interactable = false;
    local v11 = WaitForSeasonData();

    if not v11 then
        return;
    end;

    local IsPremium = v11.IsPremium;
    local v12;

    if IsPremium then
        v12 = Background;
    else
        v12 = Background2;
    end;

    TextLabel.TextColor3 = v12;

    if IsPremium then
        Background2 = Background;
    end;

    Buy.ImageColor3 = Background2;
    Buy.Interactable = not IsPremium;
end;

local function SetUpTopButtons() -- Line: 166
    -- upvalues: Main (copy), TopBtns (copy), SeasonPassButtonEffects (copy), SeasonPassStaticData (copy), Close (copy), SeasonPassToggler (copy)
    local u13 = {
        Rewards = Main.Rewards,
        Quests = Main.Quests,
        Store = Main.Store
    };

    for _, child in TopBtns:GetChildren() do
        if child:IsA("ImageButton") then
            local Name = child.Name;
            u13[Name].Visible = false;
            child.Activated:Connect(function() -- Line: 176
                -- upvalues: SeasonPassButtonEffects (ref), u13 (copy), Name (copy), SeasonPassStaticData (ref), TopBtns (ref)
                SeasonPassButtonEffects.Click();

                for i, v in u13 do
                    v.Visible = i == Name;
                    local Background = SeasonPassStaticData.ButtonColors.Yellow.Background;
                    local ButtonStroke = SeasonPassStaticData.ButtonColors.Yellow.ButtonStroke;
                    local TextStroke = SeasonPassStaticData.ButtonColors.Green.TextStroke;
                    local ButtonStroke2 = SeasonPassStaticData.ButtonColors.Green.ButtonStroke;
                    local v14 = TopBtns:FindFirstChild(i);

                    if not v.Visible then
                        Background = TextStroke;
                    end;

                    v14.BackgroundColor3 = Background;

                    if v.Visible then
                        ButtonStroke2 = ButtonStroke;
                    end;

                    v14.UIStroke.Color = ButtonStroke2;
                end;
            end);
            child.MouseEnter:Connect(function() -- Line: 190
                -- upvalues: SeasonPassButtonEffects (ref)
                SeasonPassButtonEffects.Hover();
            end);
        end;
    end;

    u13.Rewards.Visible = true;
    Close.Activated:Connect(function() -- Line: 196
        -- upvalues: SeasonPassButtonEffects (ref), SeasonPassToggler (ref)
        SeasonPassButtonEffects.Click();
        SeasonPassToggler:Toggle();
    end);
end;

local function SetUpPremiumFrame() -- Line: 203
    -- upvalues: DataService (copy), Players (copy), SeasonPassData (copy), PremiumSection (copy), SeasonPassStaticData (copy), MarketController (copy), DevProductIds (copy), SeasonPassButtonEffects (copy), GiftController (copy), UpdateSeasonPassUI (copy)
    local Data = DataService:GetData();

    if not Data then
        warn((`No player data {Players.LocalPlayer}`));

        return;
    end;

    local v15 = SeasonPassData.CurrentSeason and Data.SeasonPass[SeasonPassData.CurrentSeason];
    local v16;

    if v15 == nil then
        v16 = false;
    else
        v16 = v15.IsPremium == true;
    end;

    local TextLabel = PremiumSection.Buy.TextLabel;
    local Buy = PremiumSection.Buy;
    local Background = SeasonPassStaticData.ButtonColors.Gray.Background;
    local Background2 = SeasonPassStaticData.ButtonColors.White.Background;
    MarketController:SetPriceLabel(TextLabel, DevProductIds.BuySeasonPassPremium.PurchaseID, ":robux::value:");
    Buy.Activated:Connect(function() -- Line: 219
        -- upvalues: SeasonPassButtonEffects (ref), DataService (ref), SeasonPassData (ref), DevProductIds (ref), MarketController (ref)
        SeasonPassButtonEffects.Click();
        local Data2 = DataService:GetData();
        local v17 = SeasonPassData.CurrentSeason and (Data2 and Data2.SeasonPass) and Data2.SeasonPass[SeasonPassData.CurrentSeason];

        if not v17 or v17.IsPremium then
            return;
        end;

        MarketController:PromptPurchase(DevProductIds.BuySeasonPassPremium.PurchaseID, Enum.InfoType.Product);
    end);
    Buy.MouseEnter:Connect(function() -- Line: 232
        -- upvalues: SeasonPassButtonEffects (ref)
        SeasonPassButtonEffects.Hover();
    end);
    local v18;

    if v16 then
        v18 = Background;
    else
        v18 = Background2;
    end;

    TextLabel.TextColor3 = v18;

    if v16 then
        Background2 = Background;
    end;

    Buy.ImageColor3 = Background2;
    Buy.Interactable = not v16;
    local Gift = PremiumSection.Gift;
    Gift.Activated:Connect(function() -- Line: 241
        -- upvalues: SeasonPassButtonEffects (ref), DevProductIds (ref), GiftController (ref)
        SeasonPassButtonEffects.Click();
        GiftController:PromptGiftFromGiftId(DevProductIds.GiftSeasonPass.PurchaseID);
    end);
    Gift.MouseEnter:Connect(function() -- Line: 246
        -- upvalues: SeasonPassButtonEffects (ref)
        SeasonPassButtonEffects.Hover();
    end);
    UpdateSeasonPassUI();
end;

local function SetUpSeasonPassTimer() -- Line: 254
    -- upvalues: SeasonPassUI (copy), SeasonPassUtils (copy), SeasonPassData (copy), Pass (copy), GuiController (copy), NumberUtil (copy)
    local Timer = SeasonPassUI.SeasonPassFrame.Timer;
    task.spawn(function() -- Line: 257
        -- upvalues: SeasonPassUtils (ref), SeasonPassData (ref), Pass (ref), GuiController (ref), SeasonPassUI (ref), Timer (copy), NumberUtil (ref)
        while true do
            local v19, v20;

            while true do
                v19 = workspace:GetServerTimeNow();
                v20 = SeasonPassUtils.GetResetTime();

                if v20 ~= 0 and SeasonPassData.CurrentSeason then
                    break;
                end;

                Pass.Visible = false;
                GuiController:Close(SeasonPassUI);
                Timer.Text = "<font color=\"rgb(255, 78, 78)\">NO SEASON :)</font>";
                task.wait(1);
            end;

            Pass.Visible = true;
            Timer.Text = `(Season ends in <font color="rgb(255, 78, 78)">{NumberUtil.compactFormat(v20 - v19)}</font>)`;
            task.wait(1);
        end;
    end);
end;

local function Start() -- Line: 278
    -- upvalues: DataService (copy), SeasonPassData (copy), CurrentSeason (ref), SeasonPassRewardsController (copy), SeasonPassShopController (copy), u2 (ref), PremiumSignalFunc (copy), Pass (copy), GuiController (copy), SeasonPassUI (copy), SetUpTopButtons (copy), SetUpPremiumFrame (copy), SetUpSeasonPassTimer (copy), SeasonPassQuestsController (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("SeasonPassUIController | No player data");

        return;
    end;

    if SeasonPassData.CurrentSeason and Data.SeasonPass[SeasonPassData.CurrentSeason] then
        SeasonPassData.SwitchToNewSeason();
        CurrentSeason = SeasonPassData.CurrentSeason;
        SeasonPassRewardsController.UpdateRewardsTrack();
        SeasonPassShopController.UpdateShopFrames();

        if u2 then
            u2:Disconnect();
            local PathSignal = DataService:GetPathSignal((`SeasonPass/{SeasonPassData.CurrentSeason}/IsPremium/@`));

            if PathSignal then
                u2 = PathSignal:Connect(PremiumSignalFunc);
            end;
        end;
    end;

    local v21 = os.clock() + 30;

    while SeasonPassData.CurrentSeason and os.clock() < v21 do
        local Data2 = DataService:GetData();

        if Data2 and Data2.SeasonPass[SeasonPassData.CurrentSeason] then
            break;
        end;

        task.wait(0.5);
    end;

    if not SeasonPassData.CurrentSeason then
        warn("SeasonPassUIController | No Current Season found");
        Pass.Visible = false;
        GuiController:Close(SeasonPassUI);

        return;
    end;

    task.spawn(SetUpTopButtons);
    task.spawn(SetUpPremiumFrame);
    task.spawn(SetUpSeasonPassTimer);
    task.spawn(SeasonPassRewardsController.Start);
    task.spawn(SeasonPassQuestsController.Start, SeasonPassQuestsController);
    task.spawn(SeasonPassShopController.Start, SeasonPassShopController);
end;

task.spawn(function() -- Line: 333
    -- upvalues: Start (copy)
    Start();
end);

if SeasonPassData.CurrentSeason then
    local PathSignal = DataService:GetPathSignal((`SeasonPass/{SeasonPassData.CurrentSeason}/IsPremium/@`));

    if PathSignal then
        u2 = PathSignal:Connect(PremiumSignalFunc);
    end;
end;

local u22 = false;

local function UpdateSeasonPassVisibility() -- Line: 354
    -- upvalues: UpdateService (copy), SeasonPassData (copy), Pass (copy)
    local v23 = UpdateService:IsHiddenFromUpdate("SeasonPassButton");

    if SeasonPassData.CurrentSeason then
        Pass.Visible = not v23;

        return;
    end;

    Pass.Visible = false;
end;

local function ShowSeasonPassNotification() -- Line: 365
    -- upvalues: u22 (ref), Notification (copy), Pass (copy)
    if u22 then
        return;
    end;

    u22 = true;
    Notification:CreateNotification("<font color=\"rgb(245, 185, 32)\">New Season Pass Available❗</font>");
    Pass.Notify.Visible = true;
end;

UpdateSeasonPass.OnClientEvent:Connect(function(p24: string) -- Line: 376
    -- upvalues: DataService (copy), SeasonPassData (copy), GuiController (copy), SeasonPassUI (copy), CurrentSeason (ref), Pass (copy), UpdateSeasonPassUI (copy), SeasonPassRewardsController (copy), SeasonPassShopController (copy), u2 (ref), PremiumSignalFunc (copy), UpdateService (copy), u22 (ref), Notification (copy)
    if not DataService:GetData() then
        warn("SeasonPassUIController | No player data");

        return;
    end;

    if typeof(p24) ~= "string" then
        warn((`newSeason is not a string: {p24}`));

        return;
    end;

    if SeasonPassData.CurrentSeason == p24 then
        return;
    end;

    GuiController:Close(SeasonPassUI);
    SeasonPassData.SwitchToNewSeason();
    CurrentSeason = SeasonPassData.CurrentSeason;

    if not CurrentSeason then
        warn("SeasonPassUIController | No Current Season found");
        Pass.Visible = false;
        GuiController:Close(SeasonPassUI);

        return;
    end;

    task.spawn(UpdateSeasonPassUI);
    task.spawn(SeasonPassRewardsController.UpdateRewardsTrack);
    SeasonPassShopController.UpdateShopFrames();

    if u2 then
        u2:Disconnect();
        local PathSignal = DataService:GetPathSignal((`SeasonPass/{SeasonPassData.CurrentSeason}/IsPremium/@`));

        if PathSignal then
            u2 = PathSignal:Connect(PremiumSignalFunc);
        end;
    end;

    local v25 = UpdateService:IsHiddenFromUpdate("SeasonPassButton");

    if SeasonPassData.CurrentSeason then
        Pass.Visible = not v25;
    else
        Pass.Visible = false;
    end;

    if Pass.Visible then
        if u22 then
            return;
        end;

        u22 = true;
        Notification:CreateNotification("<font color=\"rgb(245, 185, 32)\">New Season Pass Available❗</font>");
        Pass.Notify.Visible = true;
    end;
end);
local v26 = UpdateService:IsHiddenFromUpdate("SeasonPassButton");

if SeasonPassData.CurrentSeason then
    Pass.Visible = not v26;
else
    Pass.Visible = false;
end;

UpdateService.OnUpdated:Connect(function() -- Line: 429
    -- upvalues: UpdateService (copy), SeasonPassData (copy), Pass (copy)
    local v27 = UpdateService:IsHiddenFromUpdate("SeasonPassButton");

    if SeasonPassData.CurrentSeason then
        Pass.Visible = not v27;

        return;
    end;

    Pass.Visible = false;
end);

return v1;