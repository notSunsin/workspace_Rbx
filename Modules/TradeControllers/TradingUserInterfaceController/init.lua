-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
require(script.TradeUIItemValueCalculators);
local script_TradeUIStaticData = require(script.TradeUIStaticData);
local script_TradeUIItemRenderers = require(script.TradeUIItemRenderers);
local TradingController = require(ReplicatedStorage.Modules.TradeControllers.TradingController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local TradeData = require(ReplicatedStorage.Data.TradeData);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Trove = require(ReplicatedStorage.Modules.Trove);
local NotifisController = require(ReplicatedStorage.Modules.NotifisController);
require(ReplicatedStorage.Modules.TradeMenu.TradeMenuTypes);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
local TradeItemHoverController = require(ReplicatedStorage.Modules.TradeControllers.TradeItemHoverController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local TradingUI = PlayerGui:WaitForChild("TradingUI");
local LiveTrade = TradingUI.LiveTrade;
local TradeItemHover = PlayerGui.TradeItemHover.TradeItemHover;
local Accept = LiveTrade.Options.Accept;
local Label = Accept.Label;
local Decline = LiveTrade.Options.Decline;
local MyPlr = LiveTrade.MyPlr;
local OtherPlr = LiveTrade.OtherPlr;
local Btn = MyPlr.ScrollingFrame.AddItemButtom.Btn;
local ItemTemplate = MyPlr.ScrollingFrame.ItemTemplate;
local Price = OtherPlr.Price;
local Price2 = MyPlr.Price;
local Status = LiveTrade.Status;
local TokenCounter = LiveTrade.TokenCounter;
local TokensInfo = PlayerGui.TokensInfo;
local BuyTokens = PlayerGui.BuyTokens;
local TradeNotifs = PlayerGui.TradeNotifs;
local UnfairTrade = PlayerGui.UnfairTrade;
local Templates = ReplicatedStorage.Modules.TradeTokens.Templates;
local ItemTemplate2 = Templates.ItemTemplate;
local PastTradeTemplate = Templates.PastTradeTemplate;
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size420x420 = Enum.ThumbnailSize.Size420x420;
local u1 = false;
ItemTemplate.Visible = false;
local u2 = {};
local u3 = Trove.new();
local u4 = {};
local u5 = nil;
local u6 = nil;
local Color = Accept.Label.UIStroke.Color;
local Color2 = Accept.UIStroke.Color;
local BackgroundColor3 = Accept.BackgroundColor3;

local function GetUIState(p7) -- Line: 98
    -- upvalues: u4 (ref)
    local v8 = u4[p7];

    if not v8 then
        v8 = {
            OfferUIObjects = {}
        };
        u4[p7] = v8;
    end;

    return v8;
end;

local function SetupButton(u9: table) -- Line: 109
    -- upvalues: Spring (copy)
    if not u9 then
        return nil;
    end;

    local instance = u9.instance;

    if not instance:IsA("GuiButton") then
        return nil;
    end;

    local u10 = instance:FindFirstChildOfClass("UIScale");

    if not u10 then
        return nil;
    end;

    local u11 = u9.speed or 10;
    local u12 = u9.damping or 1;
    local u13 = u9.offset or 0.065;
    instance.MouseEnter:Connect(function() -- Line: 120
        -- upvalues: instance (copy), Spring (ref), u10 (copy), u12 (copy), u11 (copy), u13 (copy)
        if instance:HasTag("TradeItemUI") and instance:FindFirstAncestor("MyPlr") then
            instance:FindFirstChild("TrashImg").Visible = true;
        end;

        Spring.target(u10, u12, u11, {
            Scale = 1 + (instance.Active and u13 or 0)
        });
    end);
    instance.MouseLeave:Connect(function() -- Line: 131
        -- upvalues: instance (copy), Spring (ref), u10 (copy), u12 (copy), u11 (copy)
        if instance:HasTag("TradeItemUI") and instance:FindFirstAncestor("MyPlr") then
            instance:FindFirstChild("TrashImg").Visible = false;
        end;

        Spring.target(u10, u12, u11, {
            Scale = 1
        });
    end);
    instance.MouseButton1Down:Connect(function() -- Line: 142
        -- upvalues: Spring (ref), u10 (copy), u12 (copy), u11 (copy), instance (copy), u13 (copy)
        Spring.target(u10, u12, u11, {
            Scale = 1 - (instance.Active and u13 or 0)
        });
    end);
    instance.MouseButton1Up:Connect(function() -- Line: 146
        -- upvalues: Spring (ref), u10 (copy), u12 (copy), u11 (copy), instance (copy), u13 (copy)
        Spring.target(u10, u12, u11, {
            Scale = 1 + (instance.Active and u13 or 0)
        });
    end);
    instance.Activated:Connect(function() -- Line: 150
        -- upvalues: u9 (copy), instance (copy)
        if u9.onclick then
            u9.onclick(instance);
        end;
    end);

    return instance;
end;

local function TweenAcceptButton(p14) -- Line: 158
    -- upvalues: u6 (ref), Accept (copy), Spring (copy), Color (ref), BackgroundColor3 (ref), Color2 (ref)
    if u6 == p14 then
        return;
    end;

    u6 = p14;
    Accept.Active = p14;
    Accept.AutoButtonColor = p14;
    local v15 = Accept;
    Spring.target(v15.Label.UIStroke, 1, 2.5, {
        Color = p14 and Color or Color3.fromRGB(75, 75, 75)
    });
    Spring.target(v15, 1, 2.5, {
        BackgroundColor3 = p14 and BackgroundColor3 or Color3.fromRGB(125, 125, 125)
    });
    Spring.target(v15.UIStroke, 1, 2.5, {
        Color = p14 and Color2 or Color3.fromRGB(50, 50, 50)
    });
    Spring.target(v15.UIScale, 1, 5, {
        Scale = 1
    });
end;

local function TweenDeclineButton(p16) -- Line: 182
    -- upvalues: u5 (ref), Decline (copy), FastTween (copy)
    if u5 == p16 then
        return;
    end;

    u5 = p16;
    Decline.Active = p16;
    Decline.AutoButtonColor = p16;
    local TweenInfo_new_ret = TweenInfo.new(0.15);
    local UIStroke = Decline.Label.UIStroke;
    local v17 = {};
    local v18;

    if p16 then
        v18 = Color3.fromRGB(118, 4, 7);
    else
        v18 = Color3.fromRGB(120, 120, 120);
    end;

    v17.Color = v18;
    FastTween(UIStroke, TweenInfo_new_ret, v17);
    local v19 = {};
    local v20;

    if p16 then
        v20 = Color3.fromRGB(220, 29, 26);
    else
        v20 = Color3.fromRGB(125, 125, 125);
    end;

    v19.BackgroundColor3 = v20;
    FastTween(Decline, TweenInfo_new_ret, v19);
    local UIStroke2 = Decline.UIStroke;
    local v21 = {};
    local v22;

    if p16 then
        v22 = Color3.fromRGB(245, 29, 29);
    else
        v22 = Color3.fromRGB(120, 120, 120);
    end;

    v21.Color = v22;
    FastTween(UIStroke2, TweenInfo_new_ret, v21);
end;

local function CalculateOfferTotalValue(p23: table, p24: number, p25: number) -- Line: 213
    -- upvalues: TokenRAPController (copy)
    local v26 = 0;

    for _, v in p23 do
        v26 = v26 + (TokenRAPController:GetRAP(v.type, v.data) or 0);
    end;

    return v26 + (p24 or 0);
end;

local function CalculateOfferDifference(p27) -- Line: 236
    -- upvalues: CalculateOfferTotalValue (copy)
    local v28 = p27.offers[1];
    local v29 = p27.offers[2];
    local v30 = CalculateOfferTotalValue(v28.items, v28.tokens, v28.sheckles);
    local v31 = CalculateOfferTotalValue(v29.items, v29.tokens, v29.sheckles);
    local math_abs_ret = math.abs(v30 - v31);

    if v31 < v30 then
        return p27.players[1], math_abs_ret;
    end;

    if v30 < v31 then
        return p27.players[2], math_abs_ret;
    end;

    return nil, math_abs_ret;
end;

function u2.CreatePastTrade(p32: any, u33: userdata) -- Line: 255
    -- upvalues: ItemTemplate2 (copy), script_TradeUIItemRenderers (copy), TradeItemHoverController (copy), CalculateOfferTotalValue (copy), NumberUtil (copy), Players (copy), HeadShot (copy), Size420x420 (copy), LocalPlayer (copy), PastTradeTemplate (copy), TradingUI (copy), LiveTrade (copy), GuiController (copy)
    local function populateOffer(p34: any, p35: userdata, p36: number) -- Line: 256
        -- upvalues: ItemTemplate2 (ref), script_TradeUIItemRenderers (ref), TradeItemHoverController (ref), CalculateOfferTotalValue (ref), NumberUtil (ref), Players (ref), HeadShot (ref), Size420x420 (ref)
        local items = p34.items;
        local v37 = p34.sheckles or 0;
        local v38 = p34.tokens or 0;
        local ScrollingFrame = p35:FindFirstChild("ScrollingFrame");

        for _, v in items do
            local type = v.type;
            local v39 = ItemTemplate2:Clone();
            local v40 = script_TradeUIItemRenderers.ItemRenderTypes[type];

            if not v40 then
                warn("TradeMenuHistory | No item renderer");

                return;
            end;

            v39.AutoButtonColor = false;
            v39.Interactable = false;
            v39:SetAttribute("UUID", v.id);
            v39:AddTag("TradingUserInterfaceTargetable");
            TradeItemHoverController:AddItemToData(v.id, v);
            v40(v39, v);
            v39.Parent = ScrollingFrame;
            v39.Visible = true;
        end;

        local v41 = CalculateOfferTotalValue(items, v38, v37);
        p35:FindFirstChild("Price"):FindFirstChild("Amount").Text = `{v41}`;
        p35:FindFirstChild("Sheckles"):FindFirstChild("Amount").Text = `{NumberUtil.FormatCompactPrice(v37)}`;
        p35:FindFirstChild("Tokens"):FindFirstChild("Amount").Text = `{v38}`;
        p35:FindFirstChild("Headshot").Image = Players:GetUserThumbnailAsync(p36, HeadShot, Size420x420);
    end;

    local users = p32.users;
    local v42 = users[1].userId == LocalPlayer.UserId and 1 or 2;
    local v43 = v42 == 1 and 2 or 1;
    local u44 = PastTradeTemplate:Clone();
    local UserFrame = u44.UserFrame;
    UserFrame.Headshot.Image = Players:GetUserThumbnailAsync(users[v43].userId, HeadShot, Size420x420);
    UserFrame.Username.Text = `@{users[v43].username}`;
    u44.OtherPlr.Price.Label.Text = `@{users[v43].username}'s Value:`;
    populateOffer(p32.offers[v42], u44.MyPlr, users[v42].userId);
    populateOffer(p32.offers[v43], u44.OtherPlr, users[v43].userId);
    u44.Parent = TradingUI;
    u44.Visible = true;
    LiveTrade.Visible = false;
    local u45 = u44.Close.Activated:Once(function() -- Line: 324
        -- upvalues: GuiController (ref), u33 (copy), TradingUI (ref), u44 (copy)
        GuiController:Open(u33);
        GuiController:Close(TradingUI);
        game.Debris:AddItem(u44, 0.5);
    end);
    TradingUI:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 333
        -- upvalues: TradingUI (ref), u44 (copy)
        if not TradingUI.Enabled then
            game.Debris:AddItem(u44, 0.5);
        end;
    end);
    u44.Destroying:Once(function() -- Line: 340
        -- upvalues: u45 (ref)
        if u45 then
            u45:Disconnect();
            u45 = nil;
        end;
    end);
    GuiController:Open(TradingUI);
    GuiController:Close(u33);
end;

function u2.RenderValues(p46) -- Line: 353
    -- upvalues: TradingController (copy), CalculateOfferTotalValue (copy), LocalPlayer (copy), Price2 (copy), Price (copy), TweenService (copy), Debris (copy)
    local CurrentTradeReplicator = TradingController.CurrentTradeReplicator;

    if not CurrentTradeReplicator then
        return;
    end;

    local Data = CurrentTradeReplicator:GetData();

    if not Data then
        return;
    end;

    for i, v in Data.players do
        local v47 = Data.offers[i];
        local _ = v47.items;
        local v48 = CalculateOfferTotalValue(v47.items, v47.tokens, v47.sheckles);
        local v49 = v == LocalPlayer and Price2 or Price;

        if v49.Amount.Text ~= v48 then
            v49.Amount.Text = v48;
            local v50 = v49.Amount:Clone();
            local UIScale = Instance.new("UIScale");
            UIScale.Parent = v50;
            TweenService:Create(v50, TweenInfo.new(0.5), {
                TextTransparency = 1,
                Position = UDim2.fromScale(0.5, 0.5)
            }):Play();
            TweenService:Create(UIScale, TweenInfo.new(0.5), {
                Scale = 1.5
            }):Play();
            TweenService:Create(v50.UIStroke, TweenInfo.new(0.5), {
                Transparency = 1
            }):Play();
            v50.Parent = v49;
            Debris:AddItem(v50, 0.5);
        end;
    end;
end;

local u51 = {};

function u2.Render(p52) -- Line: 387
    -- upvalues: TradingController (copy), LocalPlayer (copy), TradeData (copy), Accept (copy), Label (copy), Status (copy), TweenAcceptButton (copy), TweenDeclineButton (copy), MyPlr (copy), OtherPlr (copy), u4 (ref), u51 (copy), Spring (copy), Price (copy), Btn (copy), NumberUtil (copy), TradeItemHoverController (copy), script_TradeUIItemRenderers (copy), u3 (copy), ItemTemplate (copy), SetupButton (copy)
    local CurrentTradeReplicator = TradingController.CurrentTradeReplicator;

    if not CurrentTradeReplicator then
        return;
    end;

    local Data = CurrentTradeReplicator:GetData();

    if not Data then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v53;

    if Data.players[1] == LocalPlayer then
        v53 = Data.players[2];
    else
        v53 = Data.players[1];
    end;

    local v54 = Data.states[table.find(Data.players, LocalPlayer)];
    local v55 = Data.states[table.find(Data.players, v53)];
    local v56 = ServerTimeNow - Data.lastChange;

    if v56 < TradeData.ButtonCooldown then
        Accept.Counter.Size = UDim2.fromScale((TradeData.ButtonCooldown - v56) / TradeData.ButtonCooldown, 1);
        Accept.Label.Text = `{string.format("%0.1f", TradeData.ButtonCooldown - v56)}s`;
    elseif v54 == "None" then
        Label.Text = "Accept";
    elseif v54 == "Processing" then
        Label.Text = "Processing...";
    elseif v54 == "Confirmed" then
        Label.Text = "Confirmed";
    elseif v54 == "Accepted" and v55 ~= "None" then
        Label.Text = "Confirm";
    elseif v54 == "Accepted" then
        Label.Text = "Accepted";
    end;

    if TradeData.ButtonCooldown <= v56 and Accept.Counter.Size ~= UDim2.fromScale(0, 1) then
        Accept.Counter.Size = UDim2.fromScale(0, 1);
    end;

    if v54 == "Confirmed" and v55 ~= "Confirmed" then
        Status.Text = `Waiting for @{v53.Name}`;
    elseif v54 == "Confirmed" or v55 ~= "Confirmed" then
        if v54 == "Accepted" and v55 ~= "Accepted" then
            Status.Text = `Waiting for @{v53.Name}`;
        elseif v54 == "Accepted" or v55 ~= "Accepted" then
            if v54 == "Processing" or v55 == "Processing" then
                Status.Text = "";
            elseif v54 == "None" or v55 == "None" then
                Status.Text = "Waiting for both players to accept";
            elseif v54 == "Accepted" or v55 == "Accepted" then
                Status.Text = "Waiting for both players to confirm";
            end;
        else
            Status.Text = `@{v53.Name} has accepted`;
        end;
    else
        Status.Text = `@{v53.Name} has confirmed`;
    end;

    local v57;

    if v56 >= 5 or v54 == "Accepted" and v55 ~= "Accepted" then
        v57 = v54 ~= "Processing";
    else
        v57 = false;
    end;

    TweenAcceptButton(v57);
    TweenDeclineButton(v54 ~= "Processing");
    local v58;

    if TradeData.Fee == 0 then
        v58 = MyPlr.Sheckles;
    else
        v58 = MyPlr.ShecklesFee;
    end;

    v58.TextBox.Active = v54 == "None" and true or v55 == "None";
    local Tokens = MyPlr.Tokens;

    for i, v in Data.players do
        local v59;

        if v == LocalPlayer then
            v59 = MyPlr;
        else
            v59 = OtherPlr;
        end;

        local v60 = u4[v];

        if not v60 then
            v60 = {
                OfferUIObjects = {}
            };
            u4[v] = v60;
        end;

        local v61 = Data.states[i];
        v59.Ready.Visible = true;
        local v62;

        if v61 == "Accepted" and (v54 == "None" or v55 == "None") then
            v62 = true;
        elseif v61 == "Confirmed" then
            v62 = v54 == "Accepted" and true or v55 == "Accepted";
        else
            v62 = false;
        end;

        if u51[i] ~= v62 then
            u51[i] = v62;
            Spring.target(v59.Ready, 1, 5, {
                BackgroundTransparency = v62 and 0.75 or 1
            });
            Spring.target(v59.Ready.Label, 1, 5, {
                TextTransparency = v62 and 0 or 1
            });
            Spring.target(v59.Ready.Label.UIStroke, 1, 5, {
                Transparency = v62 and 0 or 1
            });
            Spring.target(v59.Ready.Vector, 1, 5, {
                ImageTransparency = v62 and 0 or 1
            });
        end;

        v59.Ready.Label.Text = v61;

        if v ~= LocalPlayer then
            local v63 = `@{v.Name}'s Offer`;
            v59.Price.Label.Text = v63;
            local v64 = `@{v.Name}'s Value`;
            Price.Label.Text = v64;
        end;

        local ScrollingFrame = v59.ScrollingFrame;
        local v65 = Data.offers[i];
        local sheckles = v65.sheckles;
        local items = v65.items;
        local tokens = v65.tokens;

        if v == LocalPlayer then
            Btn.Visible = #items < TradeData.ItemLimit;
        end;

        local v66 = TradeData.ApplyFee(sheckles);

        if v == LocalPlayer then
            v58.TextBox.PlaceholderText = sheckles <= 0 and "Add Sheckles" or NumberUtil.DisplaySheckles(sheckles);

            if TradeData.Fee ~= 0 then
                v58.TextLabel.Text = `<stroke color="rgb(21, 131, 34)"><font color="rgb(41, 255, 66)">{NumberUtil.DisplaySheckles(v66)}</font></stroke> <font rgb="rgb(255, 52, 52)">WITH FEE</font>`;
            end;
        else
            OtherPlr.ShecklesOffer.Amount.Text = NumberUtil.DisplaySheckles(v66);
        end;

        v58.Visible = TradeData.SheckleTradingEnabled;

        if v == LocalPlayer then
            Tokens.TextBox.PlaceholderText = tokens <= 0 and "Add Tokens" or tokens;
        else
            OtherPlr.TokensOffer.Amount.Text = tokens;
        end;

        local OfferUIObjects = v60.OfferUIObjects;
        local v67 = v;
        local v68 = {};

        for _, v2 in items do
            TradeItemHoverController:AddItemToData(v2.id, v2);
            v68[v2.id] = v2;
        end;

        for i2, v2 in OfferUIObjects do
            if not v68[i2] then
                OfferUIObjects[i2] = nil;
                v2:Destroy();

                if v67 == LocalPlayer then
                    Spring.stop(Btn.UIScale, "Scale");
                    Btn.UIScale.Scale = 0.5;
                    Spring.target(Btn.UIScale, 0.5, 5, {
                        Scale = 1
                    });
                end;
            end;
        end;

        for i2, v2 in v68 do
            if not OfferUIObjects[i2] then
                local v69 = script_TradeUIItemRenderers.ItemRenderTypes[v2.type];

                if v69 then
                    local v70 = u3:Add(ItemTemplate:Clone());
                    v69(v70, v2);
                    v70.UIScale.Scale = 0.5;
                    Spring.target(v70.UIScale, 0.5, 5, {
                        Scale = 1
                    });
                    v70.Visible = true;
                    v70:SetAttribute("UUID", i2);
                    v70:AddTag("TradingUserInterfaceTargetable");

                    if v70.GuiState ~= Enum.GuiState.Hover then
                        Spring.target(v70.UIScale, 1, 5, {
                            Scale = 1
                        });
                    end;

                    SetupButton({
                        instance = v70,

                        onclick = function() -- Line: 546, Name: onclick
                            -- upvalues: TradingController (ref), v2 (copy)
                            TradingController:RemoveItem(v2.type, v2.id);
                        end
                    });
                    v70.Parent = ScrollingFrame;
                    OfferUIObjects[i2] = v70;
                else
                    warn(v2.type, "does not have associated item renderer!");
                end;
            end;
        end;
    end;
end;

function u2.Initialize(p71) -- Line: 558
    -- upvalues: DataService (copy), TradingController (copy), u4 (ref), TradeItemHoverController (copy), LocalPlayer (copy), Players (copy), MyPlr (copy), OtherPlr (copy), TokenCounter (copy), u3 (copy), u2 (copy), TradingUI (copy), LiveTrade (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("TradingUserInterfaceController | No player data");

        return;
    end;

    local CurrentTradeReplicator = TradingController.CurrentTradeReplicator;

    if not CurrentTradeReplicator then
        return;
    end;

    local DataAsync = CurrentTradeReplicator:GetDataAsync();

    if not DataAsync or TradingController.CurrentTradeReplicator ~= CurrentTradeReplicator then
        return;
    end;

    table.clear(u4);
    u4 = {};
    TradeItemHoverController:ClearItemsData();
    local v72;

    if DataAsync.players[1] == LocalPlayer then
        v72 = DataAsync.players[2];
    else
        v72 = DataAsync.players[1];
    end;

    local HeadShot2 = Enum.ThumbnailType.HeadShot;
    local Size420x4202 = Enum.ThumbnailSize.Size420x420;
    local UserThumbnailAsync, _ = Players:GetUserThumbnailAsync(LocalPlayer.UserId, HeadShot2, Size420x4202);
    MyPlr.Headshot.Image = UserThumbnailAsync;
    local UserThumbnailAsync2, _ = Players:GetUserThumbnailAsync(v72.UserId, HeadShot2, Size420x4202);
    OtherPlr.Headshot.Image = UserThumbnailAsync2;
    TokenCounter.TokenCount.Text = `Tokens: {Data.TradeData.Tokens}`;
    u3:Add(assert(CurrentTradeReplicator:GetPathSignal("lastChange")):Connect(function() -- Line: 591
        -- upvalues: u2 (ref)
        u2:Render();
    end));
    u3:Add(assert(CurrentTradeReplicator:GetPathSignal("states/@")):Connect(function() -- Line: 595
        -- upvalues: u2 (ref)
        u2:Render();
        u2:RenderValues();
    end));
    u3:Add(assert(CurrentTradeReplicator:GetPathSignal("offers/@")):Connect(function() -- Line: 600
        -- upvalues: u2 (ref)
        u2:Render();
        u2:RenderValues();
    end));
    u2:Render();
    u2:RenderValues();
    u3:Add(task.spawn(function() -- Line: 615
        -- upvalues: u2 (ref)
        while true do
            task.wait(0.1);
            u2:Render();
        end;
    end));
    TradingUI.Enabled = true;
    LiveTrade.Visible = true;
end;

function u2.Cleanup(p73) -- Line: 626
    -- upvalues: u3 (copy), u51 (copy), u4 (ref)
    u3:Clean();
    table.clear(u51);
    table.clear(u4);
    u4 = {};
end;

function u2.Start(p74) -- Line: 640
    -- upvalues: GuiController (copy), TradingUI (copy), TradingController (copy), u2 (copy), TradeNotifs (copy), UnfairTrade (copy), TokensInfo (copy), BuyTokens (copy), SetupButton (copy), Accept (copy), Decline (copy), Btn (copy), u1 (ref), DataService (copy), LocalPlayer (copy), CalculateOfferDifference (copy), NotifisController (copy), Comma_Module (copy), TokenCounter (copy), MyPlr (copy), OtherPlr (copy), UpdateService (copy), script_TradeUIStaticData (copy), TradeData (copy), RunService (copy), GuiService (copy), UserInputService (copy), PlayerGui (copy), TradeItemHover (copy)
    local StateForGui = GuiController:GetStateForGui(TradingUI);
    GuiController:UsePopupAnims(TradingUI);
    TradingController.OnTradeCreated:Connect(function(p75: string, p76: any) -- Line: 644
        -- upvalues: GuiController (ref), TradingUI (ref), u2 (ref)
        GuiController:Open(TradingUI);
        u2:Initialize();
    end);
    TradingController.OnTradeDestroyed:Connect(function(p77: string) -- Line: 654
        -- upvalues: StateForGui (copy), GuiController (ref), TradingUI (ref), TradeNotifs (ref), UnfairTrade (ref), TokensInfo (ref), BuyTokens (ref), u2 (ref)
        if StateForGui.Visible:Get() then
            GuiController:Close(TradingUI);
        end;

        GuiController:Close(TradeNotifs);
        GuiController:Close(UnfairTrade);
        GuiController:Close(TokensInfo);
        GuiController:Close(BuyTokens);
        u2:Cleanup();
    end);
    local v78 = SetupButton({
        instance = Accept
    });
    local v79 = SetupButton({
        instance = Decline
    });
    local v80 = SetupButton({
        instance = Btn
    });

    if not (v78 and (v79 and v80)) then
        warn("Missing button", v78, v79, v80);

        return;
    end;

    local function tradeUINavigationControl(u81: userdata, p82: userdata) -- Line: 675
        -- upvalues: u1 (ref), GuiController (ref), TradingUI (ref), TradingController (ref)
        local u83 = p82.Activated:Once(function() -- Line: 677
            -- upvalues: u1 (ref), GuiController (ref), u81 (copy), TradingUI (ref)
            u1 = false;
            GuiController:Close(u81);
            GuiController:Open(TradingUI);
        end);
        local u84 = nil;
        u84 = u81:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 685
            -- upvalues: u81 (copy), u83 (ref), u84 (ref), u1 (ref), TradingController (ref)
            if u81.Enabled == false then
                if u83 then
                    u83:Disconnect();
                    u83 = nil;
                end;

                if u84 then
                    u84:Disconnect();
                    u84 = nil;
                end;

                if u1 then
                    task.defer(TradingController.Decline, TradingController);
                end;
            end;
        end);
        u1 = true;
        GuiController:Open(u81);
    end;

    v78.Activated:Connect(function() -- Line: 707
        -- upvalues: TradingController (ref), DataService (ref), LocalPlayer (ref), CalculateOfferDifference (ref), NotifisController (ref), UnfairTrade (ref), Comma_Module (ref), tradeUINavigationControl (copy)
        local CurrentTradeReplicator = TradingController.CurrentTradeReplicator;

        if not CurrentTradeReplicator then
            return;
        end;

        local Data = CurrentTradeReplicator:GetData();

        if not Data or TradingController.CurrentTradeReplicator ~= CurrentTradeReplicator then
            return;
        end;

        local Data2 = DataService:GetData();

        if not Data2 then
            warn("TradingUserInterfaceController | No player data");

            return;
        end;

        if Data and Data.states[table.find(Data.players, LocalPlayer)] == "Accepted" then
            TradingController:Confirm();

            return;
        end;

        if Data then
            local v85, v86 = CalculateOfferDifference(Data);

            if v85 ~= LocalPlayer or not Data2.TradeData.UnfairTradeWarning then
                TradingController:Accept();

                return;
            end;

            NotifisController:HideAllUI();
            local UnfairTrade2 = UnfairTrade.UnfairTrade;
            local Value = UnfairTrade2.Difference.Value;

            if v86 <= 1000000000000 then
                v86 = Comma_Module.Comma(v86);
            end;

            Value.Text = `{v86}`;
            UnfairTrade2.Visible = true;
            tradeUINavigationControl(UnfairTrade, UnfairTrade.UnfairTrade.Options.No);
            tradeUINavigationControl(UnfairTrade, UnfairTrade.UnfairTrade.Options.Yes);
        end;
    end);
    v79.Activated:Connect(function() -- Line: 742
        -- upvalues: TradingController (ref)
        TradingController:Decline();
    end);
    TradingUI:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 747
        -- upvalues: TradingUI (ref), u1 (ref), TradingController (ref)
        if TradingUI.Enabled == false and not u1 then
            TradingController:Decline();
        end;
    end);
    v80.Activated:Connect(function() -- Line: 755
        -- upvalues: TradingController (ref)
        TradingController:RequestAddItem();
    end);
    TradingUI.LiveTrade.Close.Activated:Connect(function() -- Line: 761
        -- upvalues: TradingController (ref)
        TradingController:Decline();
    end);
    task.spawn(function() -- Line: 766
        -- upvalues: TokenCounter (ref), MyPlr (ref), OtherPlr (ref), UpdateService (ref), tradeUINavigationControl (copy), BuyTokens (ref), TokensInfo (ref), TradingController (ref), DataService (ref), LocalPlayer (ref), script_TradeUIStaticData (ref)
        TokenCounter.Visible = false;
        MyPlr.Tokens.Visible = false;
        OtherPlr.TokensOffer.Visible = false;

        while UpdateService:IsHiddenFromUpdate("Trade Tokens") do
            task.wait(1);
        end;

        TokenCounter.Visible = true;
        MyPlr.Tokens.Visible = true;
        OtherPlr.TokensOffer.Visible = true;
        TokenCounter.Buy.Activated:Connect(function() -- Line: 781
            -- upvalues: tradeUINavigationControl (ref), BuyTokens (ref)
            tradeUINavigationControl(BuyTokens, BuyTokens.Frame.Close);
        end);
        TokenCounter.Info.Activated:Connect(function() -- Line: 787
            -- upvalues: tradeUINavigationControl (ref), TokensInfo (ref)
            tradeUINavigationControl(TokensInfo, TokensInfo.Frame.Close);
        end);
        local Tokens = MyPlr.Tokens;
        Tokens.TextBox.FocusLost:Connect(function() -- Line: 793
            -- upvalues: TradingController (ref), DataService (ref), LocalPlayer (ref), script_TradeUIStaticData (ref), Tokens (copy)
            local CurrentTradeReplicator = TradingController.CurrentTradeReplicator;

            if not CurrentTradeReplicator then
                return;
            end;

            local Data = CurrentTradeReplicator:GetData();

            if not Data or TradingController.CurrentTradeReplicator ~= CurrentTradeReplicator then
                return;
            end;

            local Data2 = DataService:GetData();

            if not Data2 then
                return;
            end;

            local _ = Data.offers[table.find(Data.players, LocalPlayer)];
            local Suffixes = script_TradeUIStaticData.Suffixes;
            local string_upper_ret = string.upper(Tokens.TextBox.Text);

            for i = #Suffixes, 1, -1 do
                local v87 = string.match(string_upper_ret, (`^([%d%.,]*)[{Suffixes[i]}]$`)) or "";
                local v88 = tonumber(v87);

                if v88 then
                    string_upper_ret = tostring(v88 * 1000 ^ (#Suffixes - i + 1));
                    break;
                end;

                local _ = i;
            end;

            local string_gsub_ret = string.gsub(string_upper_ret, "%D+", "");
            local v89 = tonumber(string_gsub_ret) or 0;
            TradingController:SetTokens(math.clamp(v89, 0, Data2.TradeData.Tokens) or 0);
            Tokens.TextBox.Text = "";
        end);
    end);
    local u90;

    if TradeData.Fee == 0 then
        u90 = MyPlr.Sheckles;
    else
        u90 = MyPlr.ShecklesFee;
    end;

    MyPlr.ShecklesFee.Visible = u90 == MyPlr.ShecklesFee;
    MyPlr.Sheckles.Visible = u90 == MyPlr.Sheckles;
    u90.TextBox.FocusLost:Connect(function() -- Line: 826
        -- upvalues: TradingController (ref), DataService (ref), LocalPlayer (ref), script_TradeUIStaticData (ref), u90 (copy)
        local CurrentTradeReplicator = TradingController.CurrentTradeReplicator;

        if not CurrentTradeReplicator then
            return;
        end;

        local Data = CurrentTradeReplicator:GetData();

        if not Data or TradingController.CurrentTradeReplicator ~= CurrentTradeReplicator then
            return;
        end;

        local Data2 = DataService:GetData();

        if not Data2 then
            return;
        end;

        local _ = Data.offers[table.find(Data.players, LocalPlayer)];
        local Suffixes = script_TradeUIStaticData.Suffixes;
        local string_upper_ret = string.upper(u90.TextBox.Text);

        for i = #Suffixes, 1, -1 do
            local v91 = string.match(string_upper_ret, (`^([%d%.,]*)[{Suffixes[i]}]$`)) or "";
            local v92 = tonumber(v91);

            if v92 then
                string_upper_ret = tostring(v92 * 1000 ^ (#Suffixes - i + 1));
                break;
            end;

            local _ = i;
        end;

        local string_gsub_ret = string.gsub(string_upper_ret, "%D+", "");
        local v93 = tonumber(string_gsub_ret) or 0;
        TradingController:SetSheckles(math.clamp(v93, 0, Data2.Sheckles) or 0);
        u90.TextBox.Text = "";
    end);
    local ShecklesHoverInfo = TradingUI.LiveTrade.ShecklesHoverInfo;
    ShecklesHoverInfo.Visible = false;

    if u90 == MyPlr.ShecklesFee then
        local ExclamationMark = MyPlr.ShecklesFee.ExclamationMark;
        RunService.PreRender:Connect(function(p94: number) -- Line: 858
            -- upvalues: TradingUI (ref), GuiService (ref), UserInputService (ref), ShecklesHoverInfo (copy), PlayerGui (ref), ExclamationMark (copy)
            if not TradingUI.Enabled then
                return;
            end;

            local GuiInset = GuiService:GetGuiInset();
            local v95 = UserInputService:GetMouseLocation() - GuiInset;
            ShecklesHoverInfo.Position = UDim2.fromOffset(v95.X + 16, v95.Y + GuiInset.Y);
            local GuiObjectsAtPosition = PlayerGui:GetGuiObjectsAtPosition(v95.X, v95.Y);
            ShecklesHoverInfo.Visible = table.find(GuiObjectsAtPosition, ExclamationMark) ~= nil;
        end);
    end;

    TradeItemHover.CanvasGroup.GroupTransparency = 1;
end;

task.spawn(u2.Start, u2);

return u2;