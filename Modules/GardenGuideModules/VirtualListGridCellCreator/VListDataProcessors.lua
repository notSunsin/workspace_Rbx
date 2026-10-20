-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
require(ReplicatedStorage.Data.TradeData);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
require(script.Parent.VListTypes);

return {
    GardenGuide = function(p1: table) -- Line: 12
        return {
            DisplayName = p1.DisplayName or p1.Name,
            Rarity = p1.Rarity,
            ImageId = p1.ImageId,
            New = p1.New,
            Seen = p1.Seen,
            Source = p1.Source,
            Mastered = p1.Mastered,
            Traits = p1.Traits,
            Color = p1.Color
        };
    end,

    TradePlazaIndex = function(p2) -- Line: 27
        -- upvalues: TokenRAPController (copy)
        return {
            DisplayName = p2.data.ItemName or "Unknown",
            Rarity = p2.data.Rarity,
            ImageId = p2.data.ImageId or "rbxassetid://6937742258",
            Item = p2,
            RAPValue = TokenRAPController:GetRAPById(p2.type, p2.id) or 0
        };
    end,

    TradeBoothInventory = function(p3) -- Line: 37
        -- upvalues: ItemImageFinder (copy), ItemNameFinder (copy), ItemRarityFinder (copy), TokenRAPController (copy)
        local v4 = p3.data.Name or (p3.data.ItemName or p3.data.PetType or (p3.data.SkinID or "Unknown"));
        local v5 = ItemImageFinder(v4, p3.type);

        return {
            DisplayName = ItemNameFinder(v4, p3.type) or "Unknown",
            Rarity = ItemRarityFinder(v4, p3.type),
            ImageId = v5 or "rbxassetid://6937742258",
            Item = p3,
            RAPValue = TokenRAPController:GetRAPById(p3.type, p3.id) or 0
        };
    end
};