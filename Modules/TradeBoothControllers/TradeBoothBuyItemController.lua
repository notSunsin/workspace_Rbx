-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Data.EnumRegistry.ReversedItemTypeEnums);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
require(ReplicatedStorage.Modules.ReplicationReciever);
require(ReplicatedStorage.Data.TradeBoothsData);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.Observers);
require(ReplicatedStorage.Data.TradeData);
require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.TradeControllers.TradingUserInterfaceController.TradeUIStaticData);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local TradeBoothBuyItem = Players.LocalPlayer.PlayerGui:WaitForChild("TradeBoothBuyItem");
local TradeEvents = ReplicatedStorage.GameEvents.TradeEvents;
local u1 = nil;
local u2 = nil;
local v14 = {
    PromptBuyListing = function(p3: table, p4: any, p5: userdata?) -- Line: 37, Name: PromptBuyListing
        -- upvalues: TradeWorldController (copy), u1 (ref), u2 (ref), TradeBoothBuyItem (copy), ItemImageFinder (copy), ItemNameFinder (copy), ItemRarityFinder (copy), GGStaticData (copy), NumberUtil (copy), GuiController (copy)
        if not TradeWorldController:IsInWorld() then
            return false;
        end;

        if u1 then
            return false;
        end;

        local table_clone_ret = table.clone(p4);
        u1 = table_clone_ret;
        u2 = p5;
        local v6 = p4.data.Name or (p4.data.ItemName or p4.data.PetType or (p4.data.SkinID or "Unknown"));
        local Item = TradeBoothBuyItem.Frame.Item;
        local ITEM_IMAGE = Item.ITEM_IMAGE;
        local ITEM_NAME = Item.ITEM_NAME;
        local Description = TradeBoothBuyItem.Frame.Description;
        ITEM_IMAGE.Image = ItemImageFinder(v6, p4.type);
        ITEM_NAME.Text = ItemNameFinder(v6, p4.type);
        Description.Text = `Are you sure you want to buy this item from @{table_clone_ret.listingOwner and table_clone_ret.listingOwner.Name or "???"}?`;
        local v7 = ItemRarityFinder(v6, p4.type);
        local v8 = GGStaticData.RarityColorMap[v7];

        if v8 then
            local v9 = GGStaticData.AnimatedColors[v7];

            if v9 then
                v9(Item);
            else
                Item.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(v8, 0.75);
            end;
        else
            Item.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
        end;

        ITEM_IMAGE:SetAttribute("UUID", p4.id);
        ITEM_IMAGE:AddTag("TradingUserInterfaceTargetable");
        local Amount = TradeBoothBuyItem.Frame.Price.Amount;

        if p4.listingPrice then
            Amount.Text = NumberUtil.Comma(p4.listingPrice);
        else
            Amount.Text = "???";
        end;

        GuiController:Open(TradeBoothBuyItem);

        return true;
    end,

    Start = function(p10) -- Line: 97, Name: Start
        -- upvalues: TradeWorldController (copy), GuiController (copy), TradeBoothBuyItem (copy), u1 (ref), u2 (ref), TradeEvents (copy)
        if not TradeWorldController:IsInWorld() then
            return;
        end;

        GuiController:UsePopupAnims(TradeBoothBuyItem);
        GuiController:GetStateForGui(TradeBoothBuyItem).Visible:Listen(function(p11: boolean) -- Line: 104
            -- upvalues: u1 (ref)
            if p11 then
                return;
            end;

            if u1 then
                u1 = nil;
            end;
        end);
        TradeBoothBuyItem.Frame.Options.Yes.Activated:Connect(function() -- Line: 114
            -- upvalues: u2 (ref), u1 (ref), GuiController (ref), TradeBoothBuyItem (ref), TradeEvents (ref)
            if u2 then
                u2 = nil;
            end;

            if not u1 then
                GuiController:Close(TradeBoothBuyItem);

                return;
            end;

            local listingOwner = u1.listingOwner;
            local listingUUID = u1.listingUUID;
            GuiController:Close(TradeBoothBuyItem);
            local v12, v13 = TradeEvents.Booths.BuyListing:InvokeServer(listingOwner, listingUUID);

            if not v12 then
                warn(v12, v13);
            end;
        end);
        TradeBoothBuyItem.Frame.Close.Activated:Connect(function() -- Line: 135
            -- upvalues: GuiController (ref), TradeBoothBuyItem (ref), u1 (ref), u2 (ref)
            GuiController:Close(TradeBoothBuyItem);
            u1 = nil;

            if u2 then
                GuiController:Open(u2);
                u2 = nil;
            end;
        end);
        TradeBoothBuyItem.Frame.Options.No.Activated:Connect(function() -- Line: 145
            -- upvalues: GuiController (ref), TradeBoothBuyItem (ref), u1 (ref), u2 (ref)
            GuiController:Close(TradeBoothBuyItem);
            u1 = nil;

            if u2 then
                GuiController:Open(u2);
                u2 = nil;
            end;
        end);
    end
};
task.spawn(v14.Start, v14);

return v14;