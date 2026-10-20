-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TradeItemHoverController = require(ReplicatedStorage.Modules.TradeControllers.TradeItemHoverController);
local TradeBoothBuyItemController = require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothBuyItemController);
require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local ReplicationReciever = require(ReplicatedStorage.Modules.ReplicationReciever);
require(ReplicatedStorage.UserGenerated.Collections.DeepCopy);
require(ReplicatedStorage.Modules.ItemRarityFinder);
require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local TradeBoothsData = require(ReplicatedStorage.Data.TradeBoothsData);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Notification);
local DataService = require(ReplicatedStorage.Modules.DataService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local TradeUIUtils = require(ReplicatedStorage.Modules.TradeControllers.TradeUIUtils);
local RemoveBooth = ReplicatedStorage.GameEvents.TradeEvents.Booths.RemoveBooth;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local TradeBoothSkinSelector = PlayerGui.TradeBoothSkinSelector;
local TradeBoothHistory = PlayerGui.TradeBoothHistory;
local TradeBooth = PlayerGui.TradeBooth;
local ScrollingFrame = TradeBooth.Frame.ItemsList.ScrollingFrame;
local SearchBox = TradeBooth.Frame.SearchFrame.SearchBox;
local Close = TradeBooth.Frame.Close;
local Sort = TradeBooth.Frame.Sort;
local Vector = Sort.Vector;
local Label = Sort.Label;
local Unclaim = TradeBooth.Frame.Frame.Unclaim;
local History = TradeBooth.Frame.Frame.History;
local Edit = TradeBooth.Frame.Frame.Edit;
local HoverableItemTemplate = ReplicatedStorage.Modules.TradeTokens.Templates.HoverableItemTemplate;
local Booths = ReplicationReciever.new("Booths");
local u1 = { "Name", "Rarity", "Price" };
local v47 = {
    OnUpdated = Signal.new(),
    Query = "",
    SortType = "Rarity",
    SortAscending = true,

    Start = function(u2: table) -- Line: 112, Name: Start
        -- upvalues: Booths (copy), GuiController (copy), TradeBooth (copy), ScrollingFrame (copy), PlayClickSound (copy), PlayerGui (copy), Close (copy), SearchBox (copy), Sort (copy), History (copy), TradeBoothHistory (copy), Edit (copy), TradeBoothSkinSelector (copy), Unclaim (copy), RemoveBooth (copy), DataService (copy), NumberUtil (copy)
        Booths:GetDataAsync();
        GuiController:UsePopupAnims(TradeBooth);
        ScrollingFrame.Add.SENSOR.Activated:Connect(function() -- Line: 117
            -- upvalues: PlayClickSound (ref), GuiController (ref), PlayerGui (ref)
            PlayClickSound();
            GuiController:Open(PlayerGui.TradeBoothInventory);
        end);
        Close.Activated:Connect(function() -- Line: 123
            -- upvalues: GuiController (ref), TradeBooth (ref), u2 (copy)
            GuiController:Close(TradeBooth);

            if u2.Redirect then
                GuiController:Open(u2.Redirect);
                u2.Redirect = nil;
            end;

            u2:ClearInventory();
        end);
        SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 133
            -- upvalues: u2 (copy), SearchBox (ref)
            u2.Query = SearchBox.Text:lower();
            u2:RefreshDisplay();
        end);
        Sort.Activated:Connect(function() -- Line: 139
            -- upvalues: PlayClickSound (ref), u2 (copy)
            PlayClickSound();
            u2:ToggleSortType();
        end);
        History.Activated:Connect(function() -- Line: 145
            -- upvalues: GuiController (ref), TradeBooth (ref), TradeBoothHistory (ref)
            GuiController:Close(TradeBooth);
            GuiController:Open(TradeBoothHistory);
        end);
        Edit.Activated:Connect(function() -- Line: 151
            -- upvalues: GuiController (ref), TradeBooth (ref), TradeBoothSkinSelector (ref)
            GuiController:Close(TradeBooth);
            GuiController:Open(TradeBoothSkinSelector);
        end);
        Unclaim.Activated:Connect(function() -- Line: 157
            -- upvalues: RemoveBooth (ref)
            RemoveBooth:FireServer();
        end);
        GuiController:GetStateForGui(TradeBooth).Visible:Observe(function(p3: boolean) -- Line: 165
            -- upvalues: u2 (copy), SearchBox (ref)
            if p3 then
                u2:UpdateInventory();

                return;
            end;

            u2.Query = "";
            SearchBox.Text = "";
        end);

        local function setupInterfaceToggle(p4, u5, u6) -- Line: 176
            -- upvalues: GuiController (ref)
            p4.Activated:Connect(function() -- Line: 177
                -- upvalues: u5 (copy), GuiController (ref), u6 (copy)
                local Close2 = u5:FindFirstChild("Close", true);

                if Close2 then
                    Close2.Activated:Once(function() -- Line: 180
                        -- upvalues: GuiController (ref), u5 (ref), u6 (ref)
                        GuiController:Close(u5);
                        GuiController:Open(u6);
                    end);
                end;

                GuiController:Open(u5);
            end);
        end;

        local Data = DataService:GetData();
        local TokenCounter = TradeBooth.Frame.TokenCounter;
        TokenCounter.Label.Text = `Tokens: {NumberUtil.Comma(Data.TradeData.Tokens)}`;
        DataService:GetPathSignal("TradeData/Tokens"):Connect(function() -- Line: 195
            -- upvalues: TokenCounter (copy), NumberUtil (ref), Data (copy)
            TokenCounter.Label.Text = `Tokens: {NumberUtil.Comma(Data.TradeData.Tokens)}`;
        end);
        local Buy = TokenCounter.Buy;
        local BuyTokens = PlayerGui:WaitForChild("BuyTokens");
        local u7 = TradeBooth;
        Buy.Activated:Connect(function() -- Line: 177
            -- upvalues: BuyTokens (copy), GuiController (ref), u7 (copy)
            local Close2 = BuyTokens:FindFirstChild("Close", true);

            if Close2 then
                Close2.Activated:Once(function() -- Line: 180
                    -- upvalues: GuiController (ref), BuyTokens (ref), u7 (ref)
                    GuiController:Close(BuyTokens);
                    GuiController:Open(u7);
                end);
            end;

            GuiController:Open(BuyTokens);
        end);
        local Info = TokenCounter.Info;
        local TokensInfo = PlayerGui:WaitForChild("TokensInfo");
        local u8 = TradeBooth;
        Info.Activated:Connect(function() -- Line: 177
            -- upvalues: TokensInfo (copy), GuiController (ref), u8 (copy)
            local Close2 = TokensInfo:FindFirstChild("Close", true);

            if Close2 then
                Close2.Activated:Once(function() -- Line: 180
                    -- upvalues: GuiController (ref), TokensInfo (ref), u8 (ref)
                    GuiController:Close(TokensInfo);
                    GuiController:Open(u8);
                end);
            end;

            GuiController:Open(TokensInfo);
        end);
    end,

    SetBooth = function(u9: table, u10: string) -- Line: 204, Name: SetBooth
        -- upvalues: Booths (copy)
        if u9._playerBoothConn then
            u9._playerBoothConn:Disconnect();
            u9._playerBoothConn = nil;
        end;

        if u9._boothConn then
            u9._boothConn:Disconnect();
            u9._boothConn = nil;
        end;

        u9.BoothUUID = u10;
        u9:RefreshDisplay();
        local DataAsync = Booths:GetDataAsync();
        local PathSignal = Booths:GetPathSignal((`Booths/{u10}/Owner`));

        if PathSignal then
            u9._boothConn = PathSignal:Connect(function() -- Line: 222
                -- upvalues: u9 (copy), DataAsync (copy), u10 (copy), Booths (ref)
                if u9._playerBoothConn then
                    u9._playerBoothConn:Disconnect();
                    u9._playerBoothConn = nil;
                end;

                local v11 = DataAsync and (u10 and DataAsync.Booths[u10]) and DataAsync.Booths[u10].Owner;
                local v12 = v11 and Booths:GetPathSignal((`Players/{v11}/@`));

                if v12 then
                    u9._playerBoothConn = v12:Connect(function() -- Line: 232
                        -- upvalues: u9 (ref)
                        u9:RefreshDisplay();
                    end);
                end;

                u9:RefreshDisplay();
            end);
        end;

        local v13 = DataAsync and (u10 and DataAsync.Booths[u10]) and DataAsync.Booths[u10].Owner;
        local v14 = v13 and Booths:GetPathSignal((`Players/{v13}/@`));

        if v14 then
            u9._playerBoothConn = v14:Connect(function() -- Line: 246
                -- upvalues: u9 (copy)
                u9:RefreshDisplay();
            end);
        end;
    end,

    SetRedirect = function(p15: table, p16: userdata?) -- Line: 253, Name: SetRedirect
        p15.Redirect = p16;
    end,

    CreateItemCard = function(u17: table, u18: any) -- Line: 257, Name: CreateItemCard
        -- upvalues: HoverableItemTemplate (copy), Booths (copy), TradeBoothsData (copy), LocalPlayer (copy), TradeItemHoverController (copy), ReplicatedStorage (copy), TradeBooth (copy), TradeBoothBuyItemController (copy), ScrollingFrame (copy)
        local u19 = HoverableItemTemplate:Clone();
        u17:UpdateItemCard(u19, u18);
        local u20 = u19.SENSOR.MouseEnter:Connect(function() -- Line: 261
            -- upvalues: Booths (ref), u17 (copy), TradeBoothsData (ref), LocalPlayer (ref), u19 (copy)
            local Data = Booths:GetData();

            if (Data and (u17.BoothUUID and Data.Booths[u17.BoothUUID]) and Data.Booths[u17.BoothUUID].Owner) == TradeBoothsData.getPlayerId(LocalPlayer) then
                u19.TrashImg.Visible = true;
            end;
        end);
        local u21 = u19.SENSOR.MouseLeave:Connect(function() -- Line: 270
            -- upvalues: u19 (copy)
            u19.TrashImg.Visible = false;
        end);
        u19:SetAttribute("UUID", u18.id);
        u19:AddTag("TradingUserInterfaceTargetable");
        TradeItemHoverController:AddItemToData(u18.id, u18);
        local u22 = u19.SENSOR.Activated:Connect(function() -- Line: 278
            -- upvalues: Booths (ref), u17 (copy), TradeBoothsData (ref), LocalPlayer (ref), ReplicatedStorage (ref), u18 (copy), TradeBooth (ref), TradeBoothBuyItemController (ref)
            local DataAsync = Booths:GetDataAsync();

            if (DataAsync and (u17.BoothUUID and DataAsync.Booths[u17.BoothUUID]) and DataAsync.Booths[u17.BoothUUID].Owner) == TradeBoothsData.getPlayerId(LocalPlayer) then
                require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothRemoveListingController):PromptRemoveListing(u18, TradeBooth);

                return;
            end;

            TradeBoothBuyItemController:PromptBuyListing(u18, TradeBooth);
        end);
        u19.Destroying:Once(function() -- Line: 291
            -- upvalues: u20 (copy), u21 (copy), u22 (copy)
            u20:Disconnect();
            u21:Disconnect();
            u22:Disconnect();
        end);
        u19.Visible = true;
        u19.Parent = ScrollingFrame;

        return u19;
    end,

    UpdateItemCard = function(p23: table, p24: any, p25: any) -- Line: 302, Name: UpdateItemCard
        -- upvalues: TradeUIUtils (copy)
        TradeUIUtils.PopulateItemFrame(p24, p25);
    end,

    FilterItems = function(p26: table, p27: table) -- Line: 306, Name: FilterItems
        -- upvalues: ItemNameFinder (copy)
        if p26.Query == "" then
            return p27;
        end;

        local v28 = {};

        for _, v in p27 do
            if ItemNameFinder(v.data.Name or v.data.ItemName or (v.data.PetType or ""), v.type):lower():find(p26.Query, 1, true) then
                table.insert(v28, v);
            end;
        end;

        return v28;
    end,

    GetInventory = function(p29: table) -- Line: 324, Name: GetInventory
        -- upvalues: Booths (copy), TradeBoothsData (copy)
        if not p29.BoothUUID then
            return {};
        end;

        local DataAsync = Booths:GetDataAsync();
        local v30 = DataAsync.Booths[p29.BoothUUID];

        if not v30 then
            return {};
        end;

        local Owner = v30.Owner;

        if not Owner then
            return {};
        end;

        local v31 = DataAsync.Players[Owner];

        if not v31 then
            return {};
        end;

        local PlayerById = TradeBoothsData.getPlayerById(Owner);
        local v32 = {};

        for i, v in v31.Listings do
            local v33 = v31.Items[v.ItemId];

            if v33 then
                table.insert(v32, {
                    id = v.ItemId,
                    type = v.ItemType,
                    data = v33,
                    listingOwner = PlayerById,
                    listingUUID = i,
                    listingPrice = v.Price
                });
            end;
        end;

        return v32;
    end,

    UpdateInventory = function(p34: table) -- Line: 367, Name: UpdateInventory
        p34:RefreshDisplay();
        p34.OnUpdated:Fire();
    end,

    RefreshDisplay = function(p35: table) -- Line: 372, Name: RefreshDisplay
        -- upvalues: Booths (copy), TradeBoothsData (copy), LocalPlayer (copy), GuiController (copy), TradeBooth (copy), ScrollingFrame (copy), Unclaim (copy), History (copy), TradeUIUtils (copy)
        local DataAsync = Booths:GetDataAsync();
        local v36 = DataAsync and (p35.BoothUUID and DataAsync.Booths[p35.BoothUUID]) and DataAsync.Booths[p35.BoothUUID].Owner;
        local v37 = v36 == TradeBoothsData.getPlayerId(LocalPlayer);

        if not v36 then
            GuiController:Close(TradeBooth);

            return;
        end;

        local PlayerById = TradeBoothsData.getPlayerById(v36);
        ScrollingFrame.Add.Visible = v37;
        local Title = TradeBooth.Frame.Title;
        local v38;

        if v37 then
            v38 = "My Booth";
        elseif PlayerById then
            v38 = `@{PlayerById.Name}'s' Booth`;
        else
            v38 = `{v36} Booth`;
        end;

        Title.Text = v38;
        Unclaim.Visible = v37;
        History.Visible = v37;
        local v39 = p35:FilterItems((p35:GetInventory()));
        local v40 = TradeUIUtils.SortTradeItems(p35.SortType, p35.SortAscending, v39);
        p35:ClearInventory();

        for _, v in v40 do
            p35:CreateItemCard(v);
        end;
    end,

    ClearInventory = function(p41: table) -- Line: 400, Name: ClearInventory
        -- upvalues: ScrollingFrame (copy), HoverableItemTemplate (copy)
        for _, child in ScrollingFrame:GetChildren() do
            if not (child:IsA("UIComponent") or (child == HoverableItemTemplate or child.Name == "Add")) then
                child:Destroy();
            end;
        end;
    end,

    ToggleSortOrder = function(p42: table, p43: any) -- Line: 410, Name: ToggleSortOrder
        -- upvalues: Vector (copy)
        p42.SortAscending = not p42.SortAscending;
        Vector.Rotation = p42.SortAscending and 180 or 0;

        if p43 == nil or p43 == true then
            p42:RefreshDisplay();
        end;
    end,

    ToggleSortType = function(p44: table) -- Line: 418, Name: ToggleSortType
        -- upvalues: u1 (copy)
        if p44.SortAscending then
            p44:ToggleSortOrder();

            return;
        end;

        p44:ToggleSortOrder(false);
        p44:SetSortType(u1[table.find(u1, p44.SortType) % #u1 + 1]);
    end,

    SetSortType = function(p45: table, p46: userdata) -- Line: 428, Name: SetSortType
        -- upvalues: Label (copy)
        p45.SortType = p46;
        Label.Text = p46;
        p45:RefreshDisplay();
    end
};
task.spawn(v47.Start, v47);

return v47;