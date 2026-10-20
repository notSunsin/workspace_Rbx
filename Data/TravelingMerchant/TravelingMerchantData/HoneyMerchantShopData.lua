-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Chalk);

return {
    ["Flower Seed Pack"] = {
        SeedName = "Flower Seed Pack",
        SeedRarity = "Rare",
        StockChance = 1,
        Price = 10,
        PurchaseID = 3295395160,
        SpecialCurrencyType = "Honey",
        DisplayInShop = true,
        ShowOdds = true,
        LayoutOrder = 1,
        ItemType = "Seed Pack",
        Stack = 1,
        Description = "",
        FallbackPrice = 199,
        StockAmount = { 1, 2 }
    },
    ["Honey Sprinkler"] = {
        SeedName = "Honey Sprinkler",
        SeedRarity = "Divine",
        StockChance = 6,
        Price = 30,
        PurchaseID = 3295397583,
        SpecialCurrencyType = "Honey",
        DisplayInShop = true,
        LayoutOrder = 25,
        ItemType = "Gear",
        Stack = 1,
        Description = "Covers nearby plants in honey! Lasts 1 minute",
        FallbackPrice = 199,
        StockAmount = { 1, 1 }
    },
    ["Bee Egg"] = {
        SeedName = "Bee Egg",
        SeedRarity = "Mythical",
        StockChance = 1,
        Price = 18,
        PurchaseID = 3295398638,
        SpecialCurrencyType = "Honey",
        DisplayInShop = true,
        ShowOdds = true,
        LayoutOrder = 30,
        ItemType = "Egg",
        Stack = 1,
        Description = "",
        FallbackPrice = 129,
        StockAmount = { 1, 1 }
    },
    ["Bee Crate"] = {
        SeedName = "Bee Crate",
        SeedRarity = "Legendary",
        StockChance = 4,
        Price = 12,
        PurchaseID = 3295396781,
        SpecialCurrencyType = "Honey",
        DisplayInShop = true,
        ShowOdds = true,
        LayoutOrder = 40,
        ItemType = "Crate",
        Stack = 1,
        Description = "",
        FallbackPrice = 179,
        StockAmount = { 1, 1 }
    },
    ["Honey Crafters Crate"] = {
        SeedName = "Honey Crafters Crate",
        SeedRarity = "Legendary",
        StockChance = 4,
        Price = 15,
        PurchaseID = 3306484248,
        SpecialCurrencyType = "Honey",
        DisplayInShop = true,
        ShowOdds = true,
        LayoutOrder = 50,
        ItemType = "Crate",
        Stack = 1,
        Description = "",
        FallbackPrice = 179,
        StockAmount = { 1, 1 }
    }
};