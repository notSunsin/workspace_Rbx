-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local MarketplaceService = game:GetService("MarketplaceService");
local PolicyService = game:GetService("PolicyService");
local RunService = game:GetService("RunService");
local SeedPackGiverEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("SeedPackGiverEvent");
local EASTER_SeedGiverQuestProgression = require(ReplicatedStorage.Data.EASTER_SeedGiverQuestProgression);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GiftController = require(ReplicatedStorage.Modules.GiftController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local RetryPcall = require(ReplicatedStorage.Modules.RetryPcall);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer not found!");
local EasterReward_UI = LocalPlayer.PlayerGui:WaitForChild("EasterReward_UI");
local Frame = EasterReward_UI.Frame;
local Btns = Frame.Btns;
local u1 = false;
local u2 = {};

function u2.DisplayExoticSackUI(p3) -- Line: 39
    -- upvalues: u1 (ref), u2 (copy), GuiController (copy), EasterReward_UI (copy), Frame (copy)
    if not u1 then
        u2:DisplayBasicSackUI();

        return;
    end;

    u2:UpdateProgression();
    GuiController:Open(EasterReward_UI);
    Frame.BasicVer.Visible = false;
    Frame.ExoticVer.Visible = true;
end;

function u2.DisplayBasicSackUI(p4) -- Line: 52
    -- upvalues: u2 (copy), GuiController (copy), EasterReward_UI (copy), Frame (copy)
    u2:UpdateProgression();
    GuiController:Open(EasterReward_UI);
    Frame.BasicVer.Visible = true;
    Frame.ExoticVer.Visible = false;
end;

function u2.UpdateProgression(p5) -- Line: 59
    -- upvalues: DataService (copy), LocalPlayer (copy), Frame (copy), EASTER_SeedGiverQuestProgression (copy)
    local Data = DataService:GetData();

    if not Data then
        warn((`No player data for {LocalPlayer}!`));

        return;
    end;

    local EasterEventData = Data.EasterEventData;
    local Prog = Frame.BasicVer.Prog;
    Frame.BasicVer.Prog.Fill.Size = UDim2.new((Data.EasterEventData.Progression - 1) / #EASTER_SeedGiverQuestProgression, 0, 1, 0);

    if Data.EasterEventData.Progression > #EASTER_SeedGiverQuestProgression then
        Prog.Progress.Text = "Plant is fully fed! Claim your Exotic Seed Pack!";
        Frame.BasicVer.ClaimButton.Visible = true;
    else
        Prog.Progress.Text = `{EasterEventData.Progression - 1}/{#EASTER_SeedGiverQuestProgression}`;
        Frame.BasicVer.ClaimButton.Visible = false;
    end;

    Frame.BasicVer.ImageFrame.ShardProgress.Text = `{25 - (EasterEventData.CandyBlossomShardProgress or 0)} Plants Remaining`;
end;

function u2.Start(p6) -- Line: 87
    -- upvalues: GuiController (copy), EasterReward_UI (copy), Btns (copy), u2 (copy), Frame (copy), RunService (copy), UpdateService (copy), SeedPackGiverEvent (copy), SeedPackData (copy), SeedData (copy), SeedPackOddsController (copy), DataService (copy), DevProductIds (copy), MarketController (copy), RetryPcall (copy), MarketplaceService (copy), Comma_Module (copy), GiftController (copy), PolicyService (copy), LocalPlayer (copy), u1 (ref)
    local StateForGui = GuiController:GetStateForGui(EasterReward_UI);
    GuiController:UsePopupAnims(EasterReward_UI);
    Btns.Basic.Activated:Connect(function() -- Line: 91
        -- upvalues: u2 (ref)
        u2:DisplayBasicSackUI();
    end);
    Btns.Exotic.Activated:Connect(function() -- Line: 95
        -- upvalues: u2 (ref)
        u2:DisplayExoticSackUI();
    end);
    Frame.ExitButton.Activated:Connect(function() -- Line: 99
        -- upvalues: GuiController (ref), EasterReward_UI (ref)
        GuiController:Close(EasterReward_UI);
    end);

    local function InitPart2Interface() -- Line: 103
        -- upvalues: RunService (ref), Frame (ref)
        RunService.Heartbeat:Connect(function(p7: number) -- Line: 104
            -- upvalues: Frame (ref)
            Frame.BasicVer.ImageFrame.RainbowUIGradient.Rotation = (Frame.BasicVer.ImageFrame.RainbowUIGradient.Rotation + p7 * 30) % 360;
        end);
        Frame.BasicVer.ImageFrame.Visible = true;
    end;

    if UpdateService:IsHiddenFromUpdate("Candy Blossom Shard") then
        Frame.BasicVer.ImageFrame.Visible = false;
        UpdateService.OnUpdated:Once(InitPart2Interface);
    else
        RunService.Heartbeat:Connect(function(p8: number) -- Line: 104
            -- upvalues: Frame (ref)
            Frame.BasicVer.ImageFrame.RainbowUIGradient.Rotation = (Frame.BasicVer.ImageFrame.RainbowUIGradient.Rotation + p8 * 30) % 360;
        end);
        Frame.BasicVer.ImageFrame.Visible = true;
    end;

    Frame.BasicVer.ClaimButton.Claim.Activated:Connect(function() -- Line: 117
        -- upvalues: SeedPackGiverEvent (ref), Frame (ref)
        SeedPackGiverEvent:FireServer("ClaimPremiumPack");
        Frame.BasicVer.Prog.Progress.Text = "Well done! Exotic Seed Pack Claimed!";
        Frame.BasicVer.ClaimButton.Visible = false;
    end);

    local function renderRewards(u9, p10) -- Line: 126
        -- upvalues: SeedPackData (ref), SeedData (ref), SeedPackOddsController (ref), EasterReward_UI (ref), StateForGui (copy), RunService (ref)
        local table_clone_ret = table.clone(p10.Items);
        table.sort(table_clone_ret, function(p11, p12) -- Line: 131
            return (p11.Chance or (1 / 0)) < (p12.Chance or (1 / 0));
        end);
        local v13 = {};
        local v14 = {};

        for i, v in table_clone_ret do
            if i <= 2 then
                v13[v] = true;
            elseif i <= 4 then
                v14[v] = true;
            end;
        end;

        for i, v in p10.Items do
            local v15 = v13[v] == true;
            local v16 = not v15 and v14[v] == true;
            local v17;

            if v15 then
                v17 = u9.UIListLayout.TemplateRainbow;
            elseif v16 then
                v17 = u9.UIListLayout.TemplateBigger;
            else
                v17 = u9.UIListLayout.TemplateSmaller;
            end;

            local u18 = v17:Clone();
            u18.LayoutOrder = i;
            u18.Odds.Text = v.RemoveChance and "" or (v.HideChance and "???" or `{math.floor(v.Chance * 100) / 100}%`);
            u18.Title.Text = SeedPackData:GetTextDisplayForItem(v);

            if v.Icon then
                u18.Vector.Image = v.Icon;
            else
                local v19 = SeedData[v.RewardId];

                if v19 and v19.Asset then
                    u18.Vector.Image = v19.Asset;
                end;
            end;

            if u18:FindFirstChild("OddsButton") then
                if v.Type == "Pack" then
                    u18.OddsButton.Visible = true;
                    u18.OddsButton.Activated:Connect(function() -- Line: 174
                        -- upvalues: SeedPackOddsController (ref), v (copy), EasterReward_UI (ref)
                        SeedPackOddsController:Open(v.RewardId, EasterReward_UI);
                    end);
                else
                    u18.OddsButton.Visible = false;
                end;
            end;

            if v15 then
                local u20 = nil;
                StateForGui.Visible:Listen(function(p21: boolean) -- Line: 184
                    -- upvalues: u20 (ref), RunService (ref), u18 (copy)
                    if p21 then
                        if not u20 then
                            u20 = RunService.PostSimulation:Connect(function() -- Line: 188
                                -- upvalues: u18 (ref)
                                local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                                u18.Odds.TextColor3 = Color3_fromHSV_ret;
                                u18.Title.TextColor3 = Color3_fromHSV_ret;
                            end);
                        end;
                    elseif u20 then
                        u20:Disconnect();
                        u20 = nil;
                    end;
                end);
            elseif v16 then
                local Color3_fromRGB_ret = Color3.fromRGB(85, 170, 255);
                u18.Odds.TextColor3 = Color3_fromRGB_ret;
                u18.Title.TextColor3 = Color3_fromRGB_ret;
            end;

            u18.Parent = u9;
            task.delay(0.01, function() -- Line: 209
                -- upvalues: u9 (copy)
                if u9.AbsoluteCanvasSize.X > u9.AbsoluteWindowSize.X then
                    u9.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;

                    return;
                end;

                u9.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
            end);
        end;
    end;

    renderRewards(Frame.BasicVer.Items.ScrollingFrame, SeedPackData.Packs["Easter Seed Pack"]);
    renderRewards(Frame.ExoticVer.Items.ScrollingFrame, SeedPackData.Packs["Exotic Easter Seed Pack"]);

    local function Update50State() -- Line: 222
        -- upvalues: DataService (ref), DevProductIds (ref), Frame (ref)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        local v22 = false;

        for _, v in Data.Transactions do
            if v.ProductId == DevProductIds.EasterPackExoticBuy10.PurchaseID then
                v22 = true;
                break;
            end;
        end;

        Frame.ExoticVer.Frame.Gift50.Visible = v22;
        Frame.ExoticVer.Frame.Buy50.Visible = v22;
    end;

    DataService:GetPathSignal("TotalRobuxSpent"):Connect(Update50State);
    DataService:GetPathSignal("Transactions/@"):Connect(Update50State);
    Update50State();
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy1.Cost, DevProductIds.EasterPackExoticBuy1.PurchaseID);
    Frame.ExoticVer.Frame.Buy1.Activated:Connect(function() -- Line: 244
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.EasterPackExoticBuy1.PurchaseID, Enum.InfoType.Product);
    end);
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy3.Cost, DevProductIds.EasterPackExoticBuy3.PurchaseID);
    Frame.ExoticVer.Frame.Buy3.Activated:Connect(function() -- Line: 249
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.EasterPackExoticBuy3.PurchaseID, Enum.InfoType.Product);
    end);
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy10.Cost, DevProductIds.EasterPackExoticBuy10.PurchaseID);
    Frame.ExoticVer.Frame.Buy10.Activated:Connect(function() -- Line: 254
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.EasterPackExoticBuy10.PurchaseID, Enum.InfoType.Product);
    end);
    MarketController:SetPriceLabel(Frame.ExoticVer.Frame.Buy50.Cost, DevProductIds.EasterPackExoticBuy50.PurchaseID);
    Frame.ExoticVer.Frame.Buy50.Activated:Connect(function() -- Line: 259
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.EasterPackExoticBuy50.PurchaseID, Enum.InfoType.Product);
    end);
    task.spawn(function() -- Line: 263
        -- upvalues: Frame (ref), RetryPcall (ref), MarketplaceService (ref), DevProductIds (ref), Comma_Module (ref)
        Frame.ExoticVer.Frame.Buy10.Tag.Visible = false;
        local v23, v24 = RetryPcall(30, 6, function() -- Line: 266
            -- upvalues: MarketplaceService (ref), DevProductIds (ref)
            return MarketplaceService:GetProductInfo(DevProductIds.EasterPackExoticBuy1.PurchaseID, Enum.InfoType.Product);
        end);

        if not v23 then
            return;
        end;

        Frame.ExoticVer.Frame.Buy10.Tag.Text = Comma_Module.Comma(v24.PriceInRobux * 10);
        Frame.ExoticVer.Frame.Buy10.Tag.Visible = true;
    end);
    task.spawn(function() -- Line: 275
        -- upvalues: Frame (ref), RetryPcall (ref), MarketplaceService (ref), DevProductIds (ref), Comma_Module (ref)
        Frame.ExoticVer.Frame.Buy50.Tag.Visible = false;
        local v25, v26 = RetryPcall(30, 6, function() -- Line: 278
            -- upvalues: MarketplaceService (ref), DevProductIds (ref)
            return MarketplaceService:GetProductInfo(DevProductIds.EasterPackExoticBuy1.PurchaseID, Enum.InfoType.Product);
        end);

        if not v25 then
            return;
        end;

        Frame.ExoticVer.Frame.Buy50.Tag.Text = Comma_Module.Comma(v26.PriceInRobux * 50);
        Frame.ExoticVer.Frame.Buy50.Tag.Visible = true;
    end);
    Frame.ExoticVer.Frame.Gift.Activated:Connect(function() -- Line: 287
        -- upvalues: GiftController (ref)
        GiftController:PromptGift("10 Exotic Easter Seed Packs");
    end);
    Frame.ExoticVer.Frame.Gift50.Activated:Connect(function() -- Line: 291
        -- upvalues: GiftController (ref)
        GiftController:PromptGift("50 Exotic Easter Seed Packs");
    end);
    u2:UpdateProgression();
    task.spawn(function() -- Line: 297
        -- upvalues: Btns (ref), Frame (ref), RetryPcall (ref), PolicyService (ref), LocalPlayer (ref), u1 (ref)
        Btns.Exotic.Visible = false;
        local v27 = Frame.ExoticVer:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 300
            -- upvalues: Frame (ref)
            if not Frame.ExoticVer.Visible then
                return;
            end;

            Frame.ExoticVer.Visible = false;
            Frame.BasicVer.Visible = true;
        end);
        local v28, v29 = RetryPcall(10, 5, function() -- Line: 309
            -- upvalues: PolicyService (ref), LocalPlayer (ref)
            return PolicyService:GetPolicyInfoForPlayerAsync(LocalPlayer);
        end);

        if not v28 then
            return;
        end;

        if v29.ArePaidRandomItemsRestricted then
            return;
        end;

        u1 = true;
        Btns.Exotic.Visible = true;
        v27:Disconnect();
    end);
end;

task.spawn(u2.Start, u2);

return u2;