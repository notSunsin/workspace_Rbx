-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
require(ReplicatedStorage.Data.TradeData);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
require(ReplicatedStorage.Data.TradeBoothsData);
local _ = ReplicatedStorage.Modules.TradeTokens.Templates.HoverableItemTemplate;

return {
    PopulateItemFrame = function(p1, p2) -- Line: 20, Name: PopulateItemFrame
        -- upvalues: ItemNameFinder (copy), ItemImageFinder (copy), ItemRarityFinder (copy), GGStaticData (copy), NumberUtil (copy)
        local v3 = p2.data.ItemData and p2.data.ItemData.ItemName or (p2.data.ItemName or p2.data.PetType or (p2.data.SkinID or "Unknown"));
        local v4 = ItemNameFinder(v3, p2.type);
        local ITEM_NAME_SHADOW = p1.ITEM_NAME_SHADOW;
        p1.ITEM_NAME.Text = `{v4}`;
        ITEM_NAME_SHADOW.Text = `{v4}`;
        p1.ITEM_IMAGE.Image = ItemImageFinder(v3, p2.type);
        local v5 = ItemRarityFinder(v3, p2.type);
        p1:SetAttribute("Rarity", v5);
        local v6 = GGStaticData.RarityColorMap[v5];

        if v6 then
            local v7 = GGStaticData.AnimatedColors[v5];

            if v7 then
                v7(p1);
            else
                p1.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(v6, 0.75);
            end;
        else
            p1.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3);
        end;

        if not p2.listingPrice then
            p1.Price.Visible = false;

            return;
        end;

        p1.Price.Visible = true;
        p1.Price.Amount.Text = p2.listingPrice and NumberUtil.Comma(p2.listingPrice) or "???";
    end,

    SortTradeItems = function(u8: string, u9: boolean, p10: table) -- Line: 62, Name: SortTradeItems
        -- upvalues: ItemNameFinder (copy), ItemRarityFinder (copy), GGStaticData (copy), TokenRAPController (copy)
        local table_clone_ret = table.clone(p10);
        table.sort(table_clone_ret, function(p11, p12) -- Line: 65
            -- upvalues: ItemNameFinder (ref), u8 (copy), ItemRarityFinder (ref), GGStaticData (ref), TokenRAPController (ref), u9 (copy)
            local v13 = nil;
            local v14 = nil;
            local v15 = ItemNameFinder(p11.data.Name or (p11.data.ItemName or p11.data.PetType or (p11.data.SkinID or "")), p11.type);
            local v16 = ItemNameFinder(p12.data.Name or (p12.data.ItemName or p12.data.PetType or (p12.data.SkinID or "")), p12.type);

            if u8 == "Name" then
                v13 = ItemNameFinder(p11.data.Name or (p11.data.ItemName or p11.data.PetType or (p11.data.SkinID or "")), p11.type);
                v14 = ItemNameFinder(p12.data.Name or (p12.data.ItemName or p12.data.PetType or (p12.data.SkinID or "")), p12.type);
            elseif u8 == "Rarity" then
                local v17 = ItemRarityFinder(p11.data.Name or p11.data.ItemName or (p11.data.PetType or p11.data.SkinID), p11.type);
                local v18 = ItemRarityFinder(p12.data.Name or p12.data.ItemName or (p12.data.PetType or p12.data.SkinID), p12.type);
                v13 = v17 and GGStaticData.RarityLayoutMap[v17] or 0;
                v14 = v18 and GGStaticData.RarityLayoutMap[v18] or 0;
            elseif u8 == "RAP" then
                v13 = TokenRAPController:GetRAP(p11.type, p11.data) or 0;
                v14 = TokenRAPController:GetRAP(p12.type, p12.data) or 0;
            elseif u8 == "Price" then
                v13 = p11.listingPrice or 0;
                v14 = p12.listingPrice or 0;
            end;

            if v13 == v14 then
                return v15 < v16;
            end;

            if u9 then
                return v13 < v14;
            end;

            return v14 < v13;
        end);

        return table_clone_ret;
    end
};