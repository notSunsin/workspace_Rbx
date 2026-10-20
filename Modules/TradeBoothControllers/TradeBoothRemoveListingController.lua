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
require(ReplicatedStorage.Modules.NumberUtil);
local TradeBoothRemoveListing = Players.LocalPlayer.PlayerGui:WaitForChild("TradeBoothRemoveListing");
local TradeEvents = ReplicatedStorage.GameEvents.TradeEvents;
local u1 = nil;
local u2 = nil;
local v13 = {
    PromptRemoveListing = function(p3: table, p4: any, p5: userdata?) -- Line: 37, Name: PromptRemoveListing
        -- upvalues: TradeWorldController (copy), u1 (ref), u2 (ref), TradeBoothRemoveListing (copy), ItemNameFinder (copy), ItemImageFinder (copy), ItemRarityFinder (copy), GGStaticData (copy), GuiController (copy)
        if not TradeWorldController:IsInWorld() then
            return false;
        end;

        if u1 then
            return false;
        end;

        u1 = table.clone(p4);
        u2 = p5;
        local v6 = p4.data.Name or (p4.data.ItemName or p4.data.PetType or (p4.data.SkinID or "Unknown"));
        local HoverableItem = TradeBoothRemoveListing.Frame.HoverableItem;
        local ITEM_IMAGE = HoverableItem.ITEM_IMAGE;
        local v7 = ItemNameFinder(v6, p4.type);
        TradeBoothRemoveListing.Frame.ItemName.Text = v7;
        ITEM_IMAGE.Image = ItemImageFinder(v6, p4.type);
        local v8 = ItemRarityFinder(v6, p4.type);
        HoverableItem:SetAttribute("Rarity", v8);
        local v9 = GGStaticData.RarityColorMap[v8];

        if v9 then
            local v10 = GGStaticData.AnimatedColors[v8];

            if v10 then
                v10(HoverableItem);
            else
                HoverableItem.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(v9, 0.75);
            end;
        else
            HoverableItem.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
        end;

        ITEM_IMAGE:SetAttribute("UUID", p4.id);
        ITEM_IMAGE:AddTag("TradingUserInterfaceTargetable");
        GuiController:Open(TradeBoothRemoveListing);

        return true;
    end,

    Start = function(p11) -- Line: 91, Name: Start
        -- upvalues: TradeWorldController (copy), GuiController (copy), TradeBoothRemoveListing (copy), u1 (ref), u2 (ref), TradeEvents (copy)
        if not TradeWorldController:IsInWorld() then
            return;
        end;

        GuiController:UsePopupAnims(TradeBoothRemoveListing);
        GuiController:GetStateForGui(TradeBoothRemoveListing).Visible:Listen(function(p12: boolean) -- Line: 98
            -- upvalues: u1 (ref)
            if p12 then
                return;
            end;

            if u1 then
                u1 = nil;
            end;
        end);
        TradeBoothRemoveListing.Frame.Confirm.Activated:Connect(function() -- Line: 108
            -- upvalues: u2 (ref), u1 (ref), GuiController (ref), TradeBoothRemoveListing (ref), TradeEvents (ref)
            if u2 then
                u2 = nil;
            end;

            if u1 then
                if TradeEvents.Booths.RemoveListing:InvokeServer(u1.listingUUID) then
                    GuiController:Close(TradeBoothRemoveListing);
                end;

                return;
            end;

            GuiController:Close(TradeBoothRemoveListing);
        end);
        TradeBoothRemoveListing.Frame.ExitButton.Activated:Connect(function() -- Line: 124
            -- upvalues: GuiController (ref), TradeBoothRemoveListing (ref), u1 (ref), u2 (ref)
            GuiController:Close(TradeBoothRemoveListing);
            u1 = nil;

            if u2 then
                GuiController:Open(u2);
                u2 = nil;
            end;
        end);
        TradeBoothRemoveListing.Frame.Cancel.Activated:Connect(function() -- Line: 134
            -- upvalues: GuiController (ref), TradeBoothRemoveListing (ref), u1 (ref), u2 (ref)
            GuiController:Close(TradeBoothRemoveListing);
            u1 = nil;

            if u2 then
                GuiController:Open(u2);
                u2 = nil;
            end;
        end);
    end
};
task.spawn(v13.Start, v13);

return v13;