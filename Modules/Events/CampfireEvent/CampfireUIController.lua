-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local PolicyService = game:GetService("PolicyService");
local RunService = game:GetService("RunService");
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local RetryPcall = require(ReplicatedStorage.Modules.RetryPcall);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local Config = GameConfigController:GetConfig("SummerBearConfig");
workspace:GetAttributeChangedSignal("SummerBearConfig"):Connect(function() -- Line: 27
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("SummerBearConfig");
end);
local ExoticPackData = require(ReplicatedStorage.Data.ExoticPackData);
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer not found!");
local PlayerGui = LocalPlayer.PlayerGui;
local CampfireReward_UI = PlayerGui:WaitForChild("CampfireReward_UI");
local Frame = CampfireReward_UI.Frame;
local Btns = Frame.Btns;
local EXOTIC_CAMPFIRE_SEED_PACK = ExoticPackData.EXOTIC_CAMPFIRE_SEED_PACK;
assert(EXOTIC_CAMPFIRE_SEED_PACK, "Missing ExoticPackData.EXOTIC_CAMPFIRE_SEED_PACK");
local u2 = false;
local u3 = {};

function u3.DisplayExoticSackUI(p4) -- Line: 51
    -- upvalues: u2 (ref), u3 (copy), GuiController (copy), CampfireReward_UI (copy), Frame (copy)
    if not u2 then
        u3:DisplayBasicSackUI();

        return;
    end;

    u3:UpdateProgression();
    GuiController:Open(CampfireReward_UI);
    Frame.BasicVer.Visible = false;
    Frame.ExoticVer.Visible = true;
end;

function u3.DisplayBasicSackUI(p5) -- Line: 65
    -- upvalues: u3 (copy), GuiController (copy), CampfireReward_UI (copy), Frame (copy)
    u3:UpdateProgression();
    GuiController:Open(CampfireReward_UI);
    Frame.BasicVer.Visible = true;
    Frame.ExoticVer.Visible = false;
end;

function u3.UpdateProgression(p6) -- Line: 76
    -- upvalues: DataService (copy), LocalPlayer (copy), Config (ref), Frame (copy)
    local Data = DataService:GetData();

    if not Data then
        warn((`No player data for {LocalPlayer}!`));

        return;
    end;

    local SummerFireEventData = Data.SummerFireEventData;

    if not SummerFireEventData then
        warn((`No SummerFireEventData for {LocalPlayer}!`));

        return;
    end;

    local v7 = #Config.REWARDS;
    local math_clamp_ret = math.clamp(SummerFireEventData.CurrentLevel or 0, 0, v7);
    local Prog = Frame.BasicVer.Prog;
    Prog.Fill.Size = UDim2.new(v7 <= 0 and 0 or math_clamp_ret / v7, 0, 1, 0);
    Prog.Progress.Text = `{math_clamp_ret}/{v7}`;
    Frame.BasicVer.ClaimButton.Visible = false;
    local math_clamp_ret2 = math.clamp(SummerFireEventData.InfernoShardProgress or 0, 0, 25);
    Frame.BasicVer.ImageFrame.ShardProgress.Text = `{25 - math_clamp_ret2} Plants Remaining`;
end;

function u3.Start(p8) -- Line: 108
    -- upvalues: GuiController (copy), CampfireReward_UI (copy), Btns (copy), u3 (copy), Frame (copy), PlayerGui (copy), RunService (copy), UpdateService (copy), SeedPackData (copy), SeedData (copy), SeedPackOddsController (copy), DataService (copy), EXOTIC_CAMPFIRE_SEED_PACK (copy), MarketController (copy), RetryPcall (copy), MarketplaceService (copy), Comma_Module (copy), GiftController (copy), PolicyService (copy), LocalPlayer (copy), u2 (ref)
    local StateForGui = GuiController:GetStateForGui(CampfireReward_UI);
    GuiController:UsePopupAnims(CampfireReward_UI);
    Btns.Basic.Activated:Connect(function() -- Line: 112
        -- upvalues: u3 (ref)
        u3:DisplayBasicSackUI();
    end);
    Btns.Exotic.Activated:Connect(function() -- Line: 116
        -- upvalues: u3 (ref)
        u3:DisplayExoticSackUI();
    end);
    Frame.ExitButton.Activated:Connect(function() -- Line: 120
        -- upvalues: GuiController (ref), CampfireReward_UI (ref)
        GuiController:Close(CampfireReward_UI);
    end);

    local function InitRainbowGradient() -- Line: 124
        -- upvalues: Frame (ref), PlayerGui (ref), RunService (ref)
        task.spawn(function() -- Line: 125
            -- upvalues: Frame (ref), PlayerGui (ref), RunService (ref)
            while Frame:IsDescendantOf(PlayerGui) do
                local v9 = RunService.Heartbeat:Wait();
                local ImageFrame = Frame.BasicVer:FindFirstChild("ImageFrame");

                if ImageFrame then
                    local RainbowUIGradient = ImageFrame:FindFirstChild("RainbowUIGradient");

                    if RainbowUIGradient and RainbowUIGradient:IsA("UIGradient") then
                        RainbowUIGradient.Rotation = (RainbowUIGradient.Rotation + 30 * v9) % 360;
                    end;

                    ImageFrame.Visible = true;
                end;
            end;
        end);
    end;

    if UpdateService:IsHiddenFromUpdate("Inferno Shard") then
        Frame.BasicVer.ImageFrame.Visible = false;
        UpdateService.OnUpdated:Once(InitRainbowGradient);
    else
        task.spawn(function() -- Line: 125
            -- upvalues: Frame (ref), PlayerGui (ref), RunService (ref)
            while Frame:IsDescendantOf(PlayerGui) do
                local v10 = RunService.Heartbeat:Wait();
                local ImageFrame = Frame.BasicVer:FindFirstChild("ImageFrame");

                if ImageFrame then
                    local RainbowUIGradient = ImageFrame:FindFirstChild("RainbowUIGradient");

                    if RainbowUIGradient and RainbowUIGradient:IsA("UIGradient") then
                        RainbowUIGradient.Rotation = (RainbowUIGradient.Rotation + 30 * v10) % 360;
                    end;

                    ImageFrame.Visible = true;
                end;
            end;
        end);
    end;

    local function clearRenderedRewards(p11) -- Line: 150
        for _, child in p11:GetChildren() do
            if child:IsA("GuiObject") then
                child:Destroy();
            end;
        end;
    end;

    local function renderRewards(u12: userdata, p13: any) -- Line: 158
        -- upvalues: clearRenderedRewards (copy), SeedPackData (ref), SeedData (ref), SeedPackOddsController (ref), CampfireReward_UI (ref), StateForGui (copy), RunService (ref), PlayerGui (ref)
        clearRenderedRewards(u12);
        local v14 = {};

        for _, v in p13.Items do
            if v.Type == "Seed" then
                table.insert(v14, v);
            end;
        end;

        table.sort(v14, function(p15, p16) -- Line: 169
            return (p15.Chance or (1 / 0)) < (p16.Chance or (1 / 0));
        end);
        local v17 = {};
        local v18 = {};

        for i, v in v14 do
            if i <= 1 then
                v17[v] = true;
            elseif i <= 3 then
                v18[v] = true;
            end;
        end;

        for i, v in p13.Items do
            local v19 = v.Type == "Pack" or v17[v] == true;
            local v20 = not v19 and v18[v] == true;
            local v21;

            if v19 then
                v21 = u12.UIListLayout.TemplateRainbow;
            elseif v20 then
                v21 = u12.UIListLayout.TemplateBigger;
            else
                v21 = u12.UIListLayout.TemplateSmaller;
            end;

            local u22 = v21:Clone();
            u22.LayoutOrder = i;
            u22.Odds.Text = v.RemoveChance and "" or (v.HideChance and "???" or `{math.floor(v.Chance * 100) / 100}%`);
            u22.Title.Text = SeedPackData:GetTextDisplayForItem(v);

            if v.Icon then
                u22.Vector.Image = v.Icon;
            else
                local v23 = SeedData[v.RewardId];

                if v23 and v23.Asset then
                    u22.Vector.Image = v23.Asset;
                end;
            end;

            if u22:FindFirstChild("OddsButton") then
                if v.Type == "Pack" then
                    u22.OddsButton.Visible = true;
                    u22.OddsButton.Activated:Connect(function() -- Line: 220
                        -- upvalues: SeedPackOddsController (ref), v (copy), CampfireReward_UI (ref)
                        SeedPackOddsController:Open(v.RewardId, CampfireReward_UI);
                    end);
                else
                    u22.OddsButton.Visible = false;
                end;
            end;

            if v19 then
                local u24 = nil;
                StateForGui.Visible:Listen(function(p25: boolean) -- Line: 231
                    -- upvalues: u24 (ref), RunService (ref), u22 (copy)
                    if p25 then
                        if not u24 then
                            u24 = RunService.PostSimulation:Connect(function() -- Line: 236
                                -- upvalues: u22 (ref)
                                local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                                u22.Odds.TextColor3 = Color3_fromHSV_ret;
                                u22.Title.TextColor3 = Color3_fromHSV_ret;
                            end);
                        end;
                    elseif u24 then
                        u24:Disconnect();
                        u24 = nil;
                    end;
                end);
            elseif v20 then
                local Color3_fromRGB_ret = Color3.fromRGB(85, 170, 255);
                u22.Odds.TextColor3 = Color3_fromRGB_ret;
                u22.Title.TextColor3 = Color3_fromRGB_ret;
            end;

            u22.Parent = u12;
            task.delay(0.01, function() -- Line: 259
                -- upvalues: u12 (copy), PlayerGui (ref)
                if not u12:IsDescendantOf(PlayerGui) then
                    return;
                end;

                if u12.AbsoluteCanvasSize.X > u12.AbsoluteWindowSize.X then
                    u12.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;

                    return;
                end;

                u12.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
            end);
        end;
    end;

    local v26 = SeedPackData.Packs["Campfire Seed Pack"];
    local v27 = SeedPackData.Packs["Exotic Campfire Seed Pack"];
    assert(v26, "Missing SeedPackData.Packs[\"Campfire Seed Pack\"]");
    assert(v27, "Missing SeedPackData.Packs[\"Exotic Campfire Seed Pack\"]");
    renderRewards(Frame.BasicVer.Items.ScrollingFrame, v26);
    renderRewards(Frame.ExoticVer.Items.ScrollingFrame, v27);

    local function update50State() -- Line: 282
        -- upvalues: DataService (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref), Frame (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local v28 = false;

        for _, v in Data.Transactions do
            if v.ProductId == EXOTIC_CAMPFIRE_SEED_PACK.Products[10] then
                v28 = true;
                break;
            end;
        end;

        Frame.ExoticVer.Frame.Gift50.Visible = v28;
        Frame.ExoticVer.Frame.Buy50.Visible = v28;
    end;

    DataService:GetPathSignal("TotalRobuxSpent"):Connect(update50State);
    DataService:GetPathSignal("Transactions/@"):Connect(update50State);
    update50State();
    DataService:GetPathSignal("SummerFireEventData/CurrentLevel"):Connect(function() -- Line: 308
        -- upvalues: u3 (ref)
        u3:UpdateProgression();
    end);
    DataService:GetPathSignal("SummerFireEventData/InfernoShardProgress"):Connect(function() -- Line: 312
        -- upvalues: u3 (ref)
        u3:UpdateProgression();
    end);
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy1.Cost, EXOTIC_CAMPFIRE_SEED_PACK.Products[1]);
    Frame.ExoticVer.Frame.Buy1.Activated:Connect(function() -- Line: 322
        -- upvalues: MarketController (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref)
        MarketController:PromptPurchase(EXOTIC_CAMPFIRE_SEED_PACK.Products[1], Enum.InfoType.Product);
    end);
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy3.Cost, EXOTIC_CAMPFIRE_SEED_PACK.Products[3]);
    Frame.ExoticVer.Frame.Buy3.Activated:Connect(function() -- Line: 331
        -- upvalues: MarketController (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref)
        MarketController:PromptPurchase(EXOTIC_CAMPFIRE_SEED_PACK.Products[3], Enum.InfoType.Product);
    end);
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy10.Cost, EXOTIC_CAMPFIRE_SEED_PACK.Products[10]);
    Frame.ExoticVer.Frame.Buy10.Activated:Connect(function() -- Line: 340
        -- upvalues: MarketController (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref)
        MarketController:PromptPurchase(EXOTIC_CAMPFIRE_SEED_PACK.Products[10], Enum.InfoType.Product);
    end);
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy50.Cost, EXOTIC_CAMPFIRE_SEED_PACK.Products[50]);
    Frame.ExoticVer.Frame.Buy50.Activated:Connect(function() -- Line: 349
        -- upvalues: MarketController (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref)
        MarketController:PromptPurchase(EXOTIC_CAMPFIRE_SEED_PACK.Products[50], Enum.InfoType.Product);
    end);
    task.spawn(function() -- Line: 353
        -- upvalues: Frame (ref), RetryPcall (ref), MarketplaceService (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref), Comma_Module (ref)
        Frame.ExoticVer.Frame.Buy10.Tag.Visible = false;
        local v29, v30 = RetryPcall(30, 6, function() -- Line: 356
            -- upvalues: MarketplaceService (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref)
            return MarketplaceService:GetProductInfo(EXOTIC_CAMPFIRE_SEED_PACK.Products[1], Enum.InfoType.Product);
        end);

        if v29 then
            Frame.ExoticVer.Frame.Buy10.Tag.Text = Comma_Module.Comma(v30.PriceInRobux * 10);
            Frame.ExoticVer.Frame.Buy10.Tag.Visible = true;

            return;
        end;

        local v31 = EXOTIC_CAMPFIRE_SEED_PACK.FallbackPrices and EXOTIC_CAMPFIRE_SEED_PACK.FallbackPrices[1];

        if v31 then
            Frame.ExoticVer.Frame.Buy10.Tag.Text = Comma_Module.Comma(v31 * 10);
            Frame.ExoticVer.Frame.Buy10.Tag.Visible = true;
        end;
    end);
    task.spawn(function() -- Line: 374
        -- upvalues: Frame (ref), RetryPcall (ref), MarketplaceService (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref), Comma_Module (ref)
        Frame.ExoticVer.Frame.Buy50.Tag.Visible = false;
        local v32, v33 = RetryPcall(30, 6, function() -- Line: 377
            -- upvalues: MarketplaceService (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref)
            return MarketplaceService:GetProductInfo(EXOTIC_CAMPFIRE_SEED_PACK.Products[1], Enum.InfoType.Product);
        end);

        if v32 then
            Frame.ExoticVer.Frame.Buy50.Tag.Text = Comma_Module.Comma(v33.PriceInRobux * 50);
            Frame.ExoticVer.Frame.Buy50.Tag.Visible = true;

            return;
        end;

        local v34 = EXOTIC_CAMPFIRE_SEED_PACK.FallbackPrices and EXOTIC_CAMPFIRE_SEED_PACK.FallbackPrices[1];

        if v34 then
            Frame.ExoticVer.Frame.Buy50.Tag.Text = Comma_Module.Comma(v34 * 50);
            Frame.ExoticVer.Frame.Buy50.Tag.Visible = true;
        end;
    end);
    Frame.ExoticVer.Frame.Gift.Activated:Connect(function() -- Line: 395
        -- upvalues: GiftController (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref)
        GiftController:PromptGiftFromGiftId(EXOTIC_CAMPFIRE_SEED_PACK.GiftProducts[10]);
    end);
    Frame.ExoticVer.Frame.Gift50.Activated:Connect(function() -- Line: 399
        -- upvalues: GiftController (ref), EXOTIC_CAMPFIRE_SEED_PACK (ref)
        GiftController:PromptGiftFromGiftId(EXOTIC_CAMPFIRE_SEED_PACK.GiftProducts[50]);
    end);
    u3:UpdateProgression();
    task.spawn(function() -- Line: 405
        -- upvalues: Btns (ref), Frame (ref), RetryPcall (ref), PolicyService (ref), LocalPlayer (ref), u2 (ref)
        Btns.Exotic.Visible = false;
        local v35 = Frame.ExoticVer:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 408
            -- upvalues: Frame (ref)
            if not Frame.ExoticVer.Visible then
                return;
            end;

            Frame.ExoticVer.Visible = false;
            Frame.BasicVer.Visible = true;
        end);
        local v36, v37 = RetryPcall(10, 5, function() -- Line: 417
            -- upvalues: PolicyService (ref), LocalPlayer (ref)
            return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);
        end);

        if not v36 then
            return;
        end;

        if v37.ArePaidRandomItemsRestricted then
            return;
        end;

        u2 = true;
        Btns.Exotic.Visible = true;
        v35:Disconnect();
    end);
end;

local u38 = false;
EventRotationController.EventUpdated:Connect(function(p39: string, p40: string) -- Line: 437, Name: OnEventUpdated
    -- upvalues: u1 (copy), u38 (ref), EventRotationUtils (copy), u3 (copy)
    if p40 ~= "CampfireEvent" then
        u1:Clean();
        u38 = false;

        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p39, p40);

    if not EventInSetIndex then
        return;
    end;

    if EventInSetIndex < 2 then
        return;
    end;

    if u38 then
        return;
    end;

    u38 = true;
    u1:Clean();
    task.spawn(u3.Start, u3);
end);

return u3;