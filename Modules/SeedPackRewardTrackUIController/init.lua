-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local PolicyService = game:GetService("PolicyService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
require(ReplicatedStorage.Modules.UpdateService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local ExoticPackData = require(ReplicatedStorage.Data.ExoticPackData);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local RetryPcall = require(ReplicatedStorage.Modules.RetryPcall);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local StringUtils = require(ReplicatedStorage.Modules.StringUtils);
local Trove = require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local SeedPackRewardTrack_UI = PlayerGui:WaitForChild("SeedPackRewardTrack_UI");
local Frame = SeedPackRewardTrack_UI.Frame;
local BasicVer = Frame.BasicVer;
local ExoticVer = Frame.ExoticVer;
local Btns = Frame.Btns;
local u1 = nil;
local u2 = false;
local u3 = {};
local u4 = Trove.new();
local u5 = nil;
local u6 = {};

local function InitRainbowGradient() -- Line: 55
    -- upvalues: Frame (copy), PlayerGui (copy), RunService (copy)
    task.spawn(function() -- Line: 56
        -- upvalues: Frame (ref), PlayerGui (ref), RunService (ref)
        while Frame:IsDescendantOf(PlayerGui) do
            local v7 = RunService.Heartbeat:Wait();
            local CheckpointRewardFrame = Frame.BasicVer.CheckpointRewardFrame;
            local RainbowUIGradient = CheckpointRewardFrame.RainbowUIGradient;

            if not (CheckpointRewardFrame and RainbowUIGradient) then
                return;
            end;

            if not RainbowUIGradient:IsA("UIGradient") then
                return;
            end;

            RainbowUIGradient.Rotation = (RainbowUIGradient.Rotation + 30 * v7) % 360;
            CheckpointRewardFrame.Visible = true;
        end;
    end);
end;

local function ClearRenderedRewards(p8: userdata) -- Line: 72
    for _, child in p8:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;
end;

local u9 = {};

local function rewardTypeFor(p10) -- Line: 85
    return p10.Type == "RainbowSeed" and "Seed" or p10.Type;
end;

local function RegisterHover(p11: userdata, p12: any) -- Line: 89
    -- upvalues: u9 (copy), ItemInfoHover (copy)
    local u13 = u9[p11];

    if u13 then
        pcall(function() -- Line: 92
            -- upvalues: ItemInfoHover (ref), u13 (copy)
            ItemInfoHover:RemoveRewardTable(u13.id, u13.rewards);
        end);
    end;

    local u14 = `SeedPackRewardTrack_{p11:GetFullName()}`;
    local u15 = {};

    for _, v in p12.Items do
        table.insert(u15, {
            Type = v.Type == "RainbowSeed" and "Seed" or v.Type,
            Value = v.RewardId
        });
    end;

    pcall(function() -- Line: 99
        -- upvalues: ItemInfoHover (ref), u14 (copy), u15 (copy)
        ItemInfoHover:AddRewardTable(u14, u15);
    end);
    u9[p11] = {
        id = u14,
        rewards = u15
    };

    return u14;
end;

local function RenderRewards(u16: userdata, p17: any) -- Line: 104
    -- upvalues: ClearRenderedRewards (copy), RegisterHover (copy), SeedPackData (copy), SeedData (copy), SeedPackOddsController (copy), SeedPackRewardTrack_UI (copy), u1 (ref), RunService (copy), PlayerGui (copy)
    ClearRenderedRewards(u16);
    local v18 = RegisterHover(u16, p17);
    local v19 = {};

    for _, v in p17.Items do
        if v.Type == "Seed" then
            table.insert(v19, v);
        end;
    end;

    table.sort(v19, function(p20, p21) -- Line: 116
        return (p20.Chance or (1 / 0)) < (p21.Chance or (1 / 0));
    end);
    local v22 = {};
    local v23 = {};

    for i, v in v19 do
        if i <= 1 then
            v22[v] = true;
        elseif i <= 3 then
            v23[v] = true;
        end;
    end;

    for i, v in p17.Items do
        local v24 = v.Type == "Pack" or v22[v] == true;
        local v25 = not v24 and v23[v] == true;
        local v26;

        if v24 then
            v26 = script.TemplateRainbow;
        elseif v25 then
            v26 = script.TemplateBigger;
        else
            v26 = script.TemplateSmaller;
        end;

        local u27 = v26:Clone();
        u27.LayoutOrder = i;
        u27:SetAttribute("UUID", (`{v18}_{v.Type == "RainbowSeed" and "Seed" or v.Type}_{v.RewardId}`));
        u27:AddTag("ItemInfoHoverTag");
        u27.Odds.Text = v.RemoveChance and "" or (v.HideChance and "???" or `{math.floor(v.Chance * 100) / 100}%`);
        u27.Title.Text = SeedPackData:GetTextDisplayForItem(v);

        if v.Icon then
            u27.Vector.Image = v.Icon;
        else
            local v28 = SeedData[v.RewardId];

            if v28 and v28.Asset then
                u27.Vector.Image = v28.Asset;
            end;
        end;

        if u27:FindFirstChild("OddsButton") then
            if v.Type == "Pack" then
                u27.OddsButton.Visible = true;
                u27.OddsButton.Activated:Connect(function() -- Line: 170
                    -- upvalues: SeedPackOddsController (ref), v (copy), SeedPackRewardTrack_UI (ref)
                    SeedPackOddsController:Open(v.RewardId, SeedPackRewardTrack_UI);
                end);
            else
                u27.OddsButton.Visible = false;
            end;
        end;

        if not v24 then
            if v25 then
                local Color3_fromRGB_ret = Color3.fromRGB(85, 170, 255);
                u27.Odds.TextColor3 = Color3_fromRGB_ret;
                u27.Title.TextColor3 = Color3_fromRGB_ret;
            end;

            u27.Parent = u16;
            task.delay(0.01, function() -- Line: 209
                -- upvalues: u16 (copy), PlayerGui (ref)
                if not u16:IsDescendantOf(PlayerGui) then
                    return;
                end;

                local UIListLayout = u16:FindFirstChild("UIListLayout");

                if u16.AbsoluteCanvasSize.X > u16.AbsoluteWindowSize.X then
                    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;

                    return;
                end;

                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
            end);
        end;

        local u29 = nil;

        if u1 then
            u1.Visible:Listen(function(p30: boolean) -- Line: 181
                -- upvalues: u29 (ref), RunService (ref), u27 (copy)
                if p30 then
                    if not u29 then
                        u29 = RunService.PostSimulation:Connect(function() -- Line: 186
                            -- upvalues: u27 (ref)
                            local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                            u27.Odds.TextColor3 = Color3_fromHSV_ret;
                            u27.Title.TextColor3 = Color3_fromHSV_ret;
                        end);
                    end;
                elseif u29 then
                    u29:Disconnect();
                    u29 = nil;
                end;
            end);
            u27.Parent = u16;
            task.delay(0.01, function() -- Line: 209
                -- upvalues: u16 (copy), PlayerGui (ref)
                if not u16:IsDescendantOf(PlayerGui) then
                    return;
                end;

                local UIListLayout = u16:FindFirstChild("UIListLayout");

                if u16.AbsoluteCanvasSize.X > u16.AbsoluteWindowSize.X then
                    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;

                    return;
                end;

                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
            end);
        else
            warn("Missing GuiState?");
        end;
    end;
end;

local function UpdateProgression(p31: string) -- Line: 222
    -- upvalues: DataService (copy), LocalPlayer (copy), u3 (copy), Frame (copy)
    local Data = DataService:GetData();

    if not Data then
        warn((`No player data for {LocalPlayer}!`));

        return;
    end;

    local v32 = Data[`{p31}Data`];

    if not v32 then
        warn((`No {p31}Data for {LocalPlayer}!`));

        return;
    end;

    local v33 = u3[p31];
    local v34 = v33 and v33.REWARDS and #v33.REWARDS or 50;
    local v35 = math.clamp(v32.CurrentLevel or 0, 0, v34) - 1;
    local Prog = Frame.BasicVer.Prog;
    Prog.Fill.Size = UDim2.new(v34 <= 0 and 0 or v35 / v34, 0, 1, 0);
    Prog.Progress.Text = `{v35}/{v34}`;
    Frame.BasicVer.ClaimButton.Visible = false;
    local math_clamp_ret = math.clamp(v32.CheckpointProgress or 0, 0, 25);
    Frame.BasicVer.CheckpointRewardFrame.Progress.Text = `{25 - math_clamp_ret} Plants Remaining`;
end;

local function RenderRewardTrackUI(p36: string, p37: string, p38: string?) -- Line: 256
    -- upvalues: ItemImageFinder (copy), ItemNameFinder (copy), BasicVer (copy), StringUtils (copy), Frame (copy), PlayerGui (copy), RunService (copy)
    local v39 = ItemImageFinder(p36, "Seed Pack");
    local v40 = ItemNameFinder(p36, "Seed Pack");
    BasicVer.Prog.FinalRewardImage.Image = v39;
    local v41;

    if string.find(string.lower(v40), "seed pack$") then
        v41 = v40;
    else
        v41 = `{v40} Seed Pack`;
    end;

    BasicVer.Prog.Label.Text = `<font color="rgb(0,255,70)">Feed the {p37}</font> to get {StringUtils:IsAn(v40)} <font color="rgb(255,204,1)">{string.upper(v41)}</font>`;

    if not p38 then
        BasicVer.CheckpointRewardFrame.Visible = false;

        return;
    end;

    local v42 = ItemImageFinder(p38, "Seed Pack");
    BasicVer.CheckpointRewardFrame.Visible = true;
    BasicVer.CheckpointRewardFrame.ImageLabel.Image = v42;
    BasicVer.CheckpointRewardFrame.RewardName.Text = p38;
    task.spawn(function() -- Line: 56
        -- upvalues: Frame (ref), PlayerGui (ref), RunService (ref)
        while Frame:IsDescendantOf(PlayerGui) do
            local v43 = RunService.Heartbeat:Wait();
            local CheckpointRewardFrame = Frame.BasicVer.CheckpointRewardFrame;
            local RainbowUIGradient = CheckpointRewardFrame.RainbowUIGradient;

            if not (CheckpointRewardFrame and RainbowUIGradient) then
                return;
            end;

            if not RainbowUIGradient:IsA("UIGradient") then
                return;
            end;

            RainbowUIGradient.Rotation = (RainbowUIGradient.Rotation + 30 * v43) % 360;
            CheckpointRewardFrame.Visible = true;
        end;
    end);
end;

local function RefitStrip(u44: userdata) -- Line: 281
    u44.AutomaticCanvasSize = Enum.AutomaticSize.None;
    task.defer(function() -- Line: 283
        -- upvalues: u44 (copy)
        u44.AutomaticCanvasSize = Enum.AutomaticSize.X;
        task.wait();
        local v45 = u44:FindFirstChildOfClass("UIListLayout");

        if v45 then
            local v46;

            if u44.AbsoluteCanvasSize.X > u44.AbsoluteWindowSize.X then
                v46 = Enum.HorizontalAlignment.Left;
            else
                v46 = Enum.HorizontalAlignment.Center;
            end;

            v45.HorizontalAlignment = v46;
        end;
    end);
end;

function u6.OpenExoticPackUI(p47: table, p48: string) -- Line: 295
    -- upvalues: u2 (ref), u6 (copy), UpdateProgression (copy), GuiController (copy), SeedPackRewardTrack_UI (copy), BasicVer (copy), ExoticVer (copy)
    if not u2 then
        u6:OpenBasicPackUI(p48);

        return;
    end;

    UpdateProgression(p48);
    GuiController:Open(SeedPackRewardTrack_UI);
    BasicVer.Visible = false;
    ExoticVer.Visible = true;
    local ScrollingFrame = ExoticVer.Items.ScrollingFrame;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None;
    task.defer(function() -- Line: 283
        -- upvalues: ScrollingFrame (copy)
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X;
        task.wait();
        local v49 = ScrollingFrame:FindFirstChildOfClass("UIListLayout");

        if v49 then
            local v50;

            if ScrollingFrame.AbsoluteCanvasSize.X > ScrollingFrame.AbsoluteWindowSize.X then
                v50 = Enum.HorizontalAlignment.Left;
            else
                v50 = Enum.HorizontalAlignment.Center;
            end;

            v49.HorizontalAlignment = v50;
        end;
    end);
end;

function u6.OpenBasicPackUI(p51: table, p52: string) -- Line: 310
    -- upvalues: UpdateProgression (copy), GuiController (copy), SeedPackRewardTrack_UI (copy), BasicVer (copy), ExoticVer (copy)
    UpdateProgression(p52);
    GuiController:Open(SeedPackRewardTrack_UI);
    BasicVer.Visible = true;
    ExoticVer.Visible = false;
    local ScrollingFrame = BasicVer.Items.ScrollingFrame;
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None;
    task.defer(function() -- Line: 283
        -- upvalues: ScrollingFrame (copy)
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X;
        task.wait();
        local v53 = ScrollingFrame:FindFirstChildOfClass("UIListLayout");

        if v53 then
            local v54;

            if ScrollingFrame.AbsoluteCanvasSize.X > ScrollingFrame.AbsoluteWindowSize.X then
                v54 = Enum.HorizontalAlignment.Left;
            else
                v54 = Enum.HorizontalAlignment.Center;
            end;

            v53.HorizontalAlignment = v54;
        end;
    end);
end;

function u6.CleanUp(p55: table, p56: string?) -- Line: 323
    -- upvalues: u5 (ref), u4 (copy)
    if p56 and u5 ~= p56 then
        return false;
    end;

    u4:Clean();
    u5 = nil;

    return true;
end;

local function GetWarningFrame() -- Line: 336
    -- upvalues: Frame (copy), PlayerGui (copy)
    local Warning = Frame:FindFirstChild("Warning");

    if Warning and Warning:IsA("GuiObject") then
        return Warning;
    end;

    local EasterReward_UI = PlayerGui:FindFirstChild("EasterReward_UI");
    local v57 = EasterReward_UI and EasterReward_UI:FindFirstChild("Frame") and EasterReward_UI.Frame:FindFirstChild("Warning");

    if not (v57 and v57:IsA("GuiObject")) then
        return nil;
    end;

    local v58 = v57:Clone();
    v58.Visible = false;
    v58.Parent = Frame;

    return v58;
end;

local function ApplyDisclaimer(p59) -- Line: 348
    -- upvalues: GetWarningFrame (copy), Frame (copy)
    if p59 then
        p59 = p59.DISCLAIMER;
    end;

    local v60;

    if typeof(p59) == "string" and p59 ~= "" then
        v60 = GetWarningFrame();
    else
        v60 = Frame:FindFirstChild("Warning");
    end;

    if not (v60 and v60:IsA("GuiObject")) then
        return;
    end;

    if typeof(p59) ~= "string" or p59 == "" then
        v60.Visible = false;

        return;
    end;

    local Text = v60:FindFirstChild("Text");

    if Text and Text:IsA("TextLabel") then
        Text.RichText = true;
        Text.Text = p59;
    end;

    v60.Visible = true;
end;

function u6.SetUpSeedPackRewardTrack(p61: table, u62: string, u63: string) -- Line: 366
    -- upvalues: u4 (copy), u5 (ref), GameConfigController (copy), u3 (copy), ApplyDisclaimer (copy), SeedPackData (copy), RenderRewardTrackUI (copy), RenderRewards (copy), Frame (copy), UpdateProgression (copy), u1 (ref), GuiController (copy), SeedPackRewardTrack_UI (copy), Btns (copy), u6 (copy), ExoticPackData (copy), DataService (copy), RetryPcall (copy), PolicyService (copy), LocalPlayer (copy), u2 (ref), MarketController (copy), MarketplaceService (copy), Comma_Module (copy), GiftController (copy)
    u4:Clean();
    u5 = u62;
    local Config = GameConfigController:GetConfig(u63);
    u3[u62] = Config;
    pcall(ApplyDisclaimer, Config);
    u4:Add(workspace:GetAttributeChangedSignal(u63):Connect(function() -- Line: 374
        -- upvalues: Config (ref), GameConfigController (ref), u63 (copy), u3 (ref), u62 (copy), ApplyDisclaimer (ref), SeedPackData (ref), RenderRewardTrackUI (ref), RenderRewards (ref), Frame (ref), UpdateProgression (ref)
        Config = GameConfigController:GetConfig(u63);
        u3[u62] = Config;
        pcall(ApplyDisclaimer, Config);
        local Value = Config.REWARDS[#Config.REWARDS].Value;
        local v64 = SeedPackData.Packs[Config.REWARDS[1].Value];
        local v65 = SeedPackData.Packs[Value];
        RenderRewardTrackUI(Value, Config.NPC_NAME, Config.ProgressReward);
        RenderRewards(Frame.BasicVer.Items.ScrollingFrame, v64);
        RenderRewards(Frame.ExoticVer.Items.ScrollingFrame, v65);
        UpdateProgression(u62);
    end));
    u1 = GuiController:GetStateForGui(SeedPackRewardTrack_UI);
    GuiController:UsePopupAnims(SeedPackRewardTrack_UI);
    u4:Add(Btns.Basic.Activated:Connect(function() -- Line: 395
        -- upvalues: u6 (ref), u62 (copy)
        u6:OpenBasicPackUI(u62);
    end));
    u4:Add(Btns.Exotic.Activated:Connect(function() -- Line: 399
        -- upvalues: u6 (ref), u62 (copy)
        u6:OpenExoticPackUI(u62);
    end));
    u4:Add(Frame.ExitButton.Activated:Connect(function() -- Line: 403
        -- upvalues: GuiController (ref), SeedPackRewardTrack_UI (ref)
        GuiController:Close(SeedPackRewardTrack_UI);
    end));
    local u66 = ExoticPackData[Config.PACK_DATA_ID];
    local Value = Config.REWARDS[#Config.REWARDS].Value;
    local v67 = SeedPackData.Packs[Config.REWARDS[1].Value];
    local v68 = SeedPackData.Packs[Value];
    Frame.BasicVer.TextLabel.Text = `Earn {v67.DisplayName}s!`;
    Frame.ExoticVer.TextLabel.Text = `{string.upper(v68.DisplayName)}!`;
    RenderRewardTrackUI(Value, Config.NPC_NAME, Config.ProgressReward);
    RenderRewards(Frame.BasicVer.Items.ScrollingFrame, v67);
    RenderRewards(Frame.ExoticVer.Items.ScrollingFrame, v68);
    UpdateProgression(u62);
    u4:Add(DataService:GetPathSignal((`{u62}Data/CurrentLevel`)):Connect(function() -- Line: 424
        -- upvalues: UpdateProgression (ref), u62 (copy)
        UpdateProgression(u62);
    end));
    u4:Add(DataService:GetPathSignal((`{u62}Data/CheckpointProgress`)):Connect(function() -- Line: 428
        -- upvalues: UpdateProgression (ref), u62 (copy)
        UpdateProgression(u62);
    end));
    u4:Add(task.spawn(function() -- Line: 433
        -- upvalues: Btns (ref), Frame (ref), u4 (ref), RetryPcall (ref), PolicyService (ref), LocalPlayer (ref), u2 (ref)
        Btns.Exotic.Visible = false;
        local v69 = Frame.ExoticVer:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 436
            -- upvalues: Frame (ref)
            if not Frame.ExoticVer.Visible then
                return;
            end;

            Frame.ExoticVer.Visible = false;
            Frame.BasicVer.Visible = true;
        end);
        u4:Add(v69);
        local v70, v71 = RetryPcall(10, 5, function() -- Line: 446
            -- upvalues: PolicyService (ref), LocalPlayer (ref)
            return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);
        end);

        if not v70 then
            return;
        end;

        if v71.ArePaidRandomItemsRestricted then
            return;
        end;

        u2 = true;
        Btns.Exotic.Visible = true;
        v69:Disconnect();
    end));
    Frame.ExoticVer.Frame.Visible = u66 ~= nil;

    if not u66 then
        local PACK_DATA_ID = Config.PACK_DATA_ID;

        if typeof(PACK_DATA_ID) == "string" and PACK_DATA_ID ~= "" then
            warn((`SeedPackRewardTrackUIController | No ExoticPackData for '{PACK_DATA_ID}' ({u62}); purchase buttons hidden.`));
        end;

        return;
    end;

    local function update50State() -- Line: 477
        -- upvalues: DataService (ref), u66 (copy), Frame (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local v72 = false;

        for _, v in Data.Transactions do
            if not u66.Products[10] then
                break;
            end;

            if v.ProductId == u66.Products[10] then
                v72 = true;
                break;
            end;
        end;

        Frame.ExoticVer.Frame.Gift50.Visible = v72;
        Frame.ExoticVer.Frame.Buy50.Visible = v72;
    end;

    u4:Add(DataService:GetPathSignal("TotalRobuxSpent"):Connect(update50State));
    u4:Add(DataService:GetPathSignal("Transactions/@"):Connect(update50State));
    update50State();
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy1.Cost, u66.Products[1]);
    u4:Add(Frame.ExoticVer.Frame.Buy1.Activated:Connect(function() -- Line: 511
        -- upvalues: MarketController (ref), u66 (copy)
        MarketController:PromptPurchase(u66.Products[1], Enum.InfoType.Product);
    end));
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy3.Cost, u66.Products[3]);
    u4:Add(Frame.ExoticVer.Frame.Buy3.Activated:Connect(function() -- Line: 520
        -- upvalues: MarketController (ref), u66 (copy)
        MarketController:PromptPurchase(u66.Products[3], Enum.InfoType.Product);
    end));
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy10.Cost, u66.Products[10]);
    u4:Add(Frame.ExoticVer.Frame.Buy10.Activated:Connect(function() -- Line: 529
        -- upvalues: MarketController (ref), u66 (copy)
        MarketController:PromptPurchase(u66.Products[10], Enum.InfoType.Product);
    end));

    if u66.Products[50] then
        MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy50.Cost, u66.Products[50]);
    end;

    u4:Add(Frame.ExoticVer.Frame.Buy50.Activated:Connect(function() -- Line: 541
        -- upvalues: MarketController (ref), u66 (copy)
        MarketController:PromptPurchase(u66.Products[50], Enum.InfoType.Product);
    end));
    task.spawn(function() -- Line: 545
        -- upvalues: Frame (ref), RetryPcall (ref), MarketplaceService (ref), u66 (copy), Comma_Module (ref)
        Frame.ExoticVer.Frame.Buy10.Tag.Visible = false;
        local v73, v74 = RetryPcall(30, 6, function() -- Line: 548
            -- upvalues: MarketplaceService (ref), u66 (ref)
            return MarketplaceService:GetProductInfoAsync(u66.Products[1], Enum.InfoType.Product);
        end);

        if v73 then
            Frame.ExoticVer.Frame.Buy10.Tag.Text = Comma_Module.Comma(v74.PriceInRobux * 10);
            Frame.ExoticVer.Frame.Buy10.Tag.Visible = true;

            return;
        end;

        local v75 = u66.FallbackPrices and u66.FallbackPrices[1];

        if v75 then
            Frame.ExoticVer.Frame.Buy10.Tag.Text = Comma_Module.Comma((`{v75 * 10}`));
            Frame.ExoticVer.Frame.Buy10.Tag.Visible = true;
        end;
    end);
    task.spawn(function() -- Line: 566
        -- upvalues: Frame (ref), RetryPcall (ref), MarketplaceService (ref), u66 (copy), Comma_Module (ref)
        Frame.ExoticVer.Frame.Buy50.Tag.Visible = false;
        local v76, v77 = RetryPcall(30, 6, function() -- Line: 569
            -- upvalues: MarketplaceService (ref), u66 (ref)
            return MarketplaceService:GetProductInfoAsync(u66.Products[1], Enum.InfoType.Product);
        end);

        if v76 then
            Frame.ExoticVer.Frame.Buy50.Tag.Text = Comma_Module.Comma(v77.PriceInRobux * 50);
            Frame.ExoticVer.Frame.Buy50.Tag.Visible = true;

            return;
        end;

        local v78 = u66.FallbackPrices and u66.FallbackPrices[1];

        if v78 then
            Frame.ExoticVer.Frame.Buy50.Tag.Text = Comma_Module.Comma((`{v78 * 50}`));
            Frame.ExoticVer.Frame.Buy50.Tag.Visible = true;
        end;
    end);
    u4:Add(Frame.ExoticVer.Frame.Gift.Activated:Connect(function() -- Line: 587
        -- upvalues: GiftController (ref), u66 (copy)
        GiftController:PromptGiftFromGiftId(u66.GiftProducts[10]);
    end));
    u4:Add(Frame.ExoticVer.Frame.Gift50.Activated:Connect(function() -- Line: 591
        -- upvalues: GiftController (ref), u66 (copy)
        GiftController:PromptGiftFromGiftId(u66.GiftProducts[50]);
    end));
end;

return u6;