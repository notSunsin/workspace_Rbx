-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GearData = require(ReplicatedStorage.Data.GearData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Data.PetRegistry.PetList);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticList);
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry.CosmeticCrates);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    InfRewards = { {
            DisplayName = "Pass Points",
            Type = "Currency",
            Value = "PassPoints",
            Quantity = 200
        } },
    FreeRewards = {
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Cactus Mouse",
                Type = "Pet",
                Value = "Cactus Mouse",
                Quantity = 1
            } },
        { {
                DisplayName = "Twineberry Seed",
                Type = "Seed",
                Value = "Twineberry",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Bucket Stand",
                Type = "Cosmetic",
                Value = "Bucket Stand",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Godly Sprinkler",
                Type = "Gear",
                Value = "Godly Sprinkler",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Levelup Lollipop",
                Type = "Gear",
                Value = "Levelup Lollipop",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            } },
        { {
                DisplayName = "Watering Can",
                Type = "Gear",
                Value = "Watering Can",
                Quantity = 10
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 125
            } },
        { {
                DisplayName = "Sun Melon Seed",
                Type = "Seed",
                Value = "Sun Melon",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Master Sprinkler",
                Type = "Gear",
                Value = "Master Sprinkler",
                Quantity = 5
            } },
        { {
                DisplayName = "Lumber Rack",
                Type = "Cosmetic",
                Value = "Lumber Rack",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Medium Treat",
                Type = "Gear",
                Value = "Medium Treat",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Lightning Rod",
                Type = "Gear",
                Value = "Lightning Rod",
                Quantity = 1
            } },
        { {
                DisplayName = "Clove Seed",
                Type = "Seed",
                Value = "Clove",
                Quantity = 1
            } },
        { {
                DisplayName = "Desert Tortoise",
                Type = "Pet",
                Value = "Desert Tortoise",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Super Watering Can",
                Type = "Gear",
                Value = "Super Watering Can",
                Quantity = 1
            } },
        { {
                DisplayName = "Levelup Lollipop",
                Type = "Gear",
                Value = "Levelup Lollipop",
                Quantity = 3
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            } },
        { {
                DisplayName = "Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 175
            } },
        { {
                DisplayName = "Rare Egg",
                Type = "Egg",
                Value = "Rare Egg",
                Quantity = 4
            } },
        { {
                DisplayName = "Master Sprinkler",
                Type = "Gear",
                Value = "Master Sprinkler",
                Quantity = 5
            } },
        { {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            } },
        { {
                DisplayName = "Terracotta Jar",
                Type = "Cosmetic",
                Value = "Terracotta Jar",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Harvest Tool",
                Type = "Gear",
                Value = "Harvest Tool",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Anubis",
                Type = "Pet",
                Value = "Anubis",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            } },
        { {
                DisplayName = "Maple Petal Seed",
                Type = "Seed",
                Value = "Maple Petal",
                Quantity = 1
            } },
        { {
                DisplayName = "Ember Lily Seed",
                Type = "Seed",
                Value = "Ember Lily",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            } },
        { {
                DisplayName = "Sand Wyrm",
                Type = "Pet",
                Value = "Sand Wyrm",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Emberpear Seed",
                Type = "Seed",
                Value = "Emberpear",
                Quantity = 1
            } }
    },
    PremiumRewards = {
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            } },
        { {
                DisplayName = "Giant Cactus Mouse",
                Type = "Pet",
                Value = "GIANT Cactus Mouse",
                Quantity = 1
            } },
        { {
                DisplayName = "Twineberry Seed",
                Type = "Seed",
                Value = "Twineberry",
                Quantity = 3
            } },
        { {
                DisplayName = "Exotic Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Wooden Farm Cart",
                Type = "Cosmetic",
                Value = "Wooden Farm Cart",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Grape Seed",
                Type = "Seed",
                Value = "Grape",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            } },
        { {
                DisplayName = "Levelup Lollipop",
                Type = "Gear",
                Value = "Levelup Lollipop",
                Quantity = 5
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 125
            } },
        { {
                DisplayName = "Watering Can",
                Type = "Gear",
                Value = "Watering Can",
                Quantity = 20
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 200
            } },
        { {
                DisplayName = "Sun Melon Seed",
                Type = "Seed",
                Value = "Sun Melon",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 125
            } },
        { {
                DisplayName = "Exotic Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Super Watering Can",
                Type = "Gear",
                Value = "Super Watering Can",
                Quantity = 1
            } },
        { {
                DisplayName = "Garden Trough",
                Type = "Cosmetic",
                Value = "Garden Trough",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 200
            } },
        { {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 3
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 125
            } },
        { {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            } },
        { {
                DisplayName = "Clove Seed",
                Type = "Seed",
                Value = "Clove",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Giant Desert Tortoise",
                Type = "Pet",
                Value = "GIANT Desert Tortoise",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 4
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Exotic Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 300
            } },
        { {
                DisplayName = "Legendary Egg",
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 2
            } },
        { {
                DisplayName = "Godly Sprinkler",
                Type = "Gear",
                Value = "Godly Sprinkler",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Water Pump",
                Type = "Cosmetic",
                Value = "Water Pump",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 7 Crate",
                Type = "Crate",
                Value = "Season 7 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Legendary Egg",
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 200
            } },
        { {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 2
            } },
        { {
                DisplayName = "Rainbow Anubis",
                Type = "Pet",
                Value = "Rainbow Anubis",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 200
            } },
        { {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            } },
        { {
                DisplayName = "Maple Petal Seed",
                Type = "Seed",
                Value = "Maple Petal",
                Quantity = 1,
                Variant = "Gold"
            } },
        { {
                DisplayName = "Ember Lily Seed",
                Type = "Seed",
                Value = "Ember Lily",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 300
            } },
        { {
                DisplayName = "Rainbow Sand Wyrm",
                Type = "Pet",
                Value = "Rainbow Sand Wyrm",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Season 7 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 7 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 800
            } },
        { {
                DisplayName = "Emberpear Seed",
                Type = "Seed",
                Value = "Emberpear",
                Quantity = 1,
                Variant = "Gold"
            } }
    },
    IncludesItems = { "Rainbow Sand Wyrm!", "Gold Emberpear!", "Gold Maple Petal", "Giant Desert Tortoise", "Water Pump" },
    ShopItems = {
        ["Season 7 Crate"] = {
            DisplayName = "Season 7 Crate",
            Rarity = "Common",
            Type = "Crate",
            StockChance = 1,
            Price = 100,
            PurchaseID = 3627198462,
            GiftPurchaseID = 0,
            LayoutOrder = 1,
            FallbackPrice = 179,
            ImageId = CosmeticCrates["Season 7 Crate"].Icon,
            StockAmount = { 1, 2 }
        },
        ["Smith Hammer of Harvest"] = {
            DisplayName = "Hammer of Harvest",
            Type = "Gear",
            Stack = 1,
            StockChance = 50,
            Price = 275,
            PurchaseID = 3455273154,
            GiftPurchaseID = 0,
            LayoutOrder = 2,
            FallbackPrice = 179,
            Rarity = GearData["Smith Hammer of Harvest"].GearRarity,
            ImageId = GearData["Smith Hammer of Harvest"].Asset,
            Desc = GearData["Smith Hammer of Harvest"].GearDescription,
            StockAmount = { 1, 1 }
        },
        Anchor = {
            DisplayName = "Anchor",
            Type = "Cosmetic",
            StockChance = 5,
            Price = 600,
            PurchaseID = 3627205912,
            GiftPurchaseID = 0,
            LayoutOrder = 3,
            FallbackPrice = 119,
            Rarity = CosmeticList.Anchor.Rarity,
            ImageId = CosmeticList.Anchor.Icon,
            StockAmount = { 1, 1 }
        },
        ["Season 7 Seed Pack"] = {
            DisplayName = "Season 7 Seed Pack",
            Rarity = "Divine",
            Type = "Seed Pack",
            StockChance = 5,
            Price = 150,
            PurchaseID = 3627197051,
            GiftPurchaseID = 0,
            LayoutOrder = 4,
            FallbackPrice = 199,
            ImageId = SeedPackData.Packs["Season 7 Seed Pack"].Icon,
            StockAmount = { 1, 2 }
        },
        ["Levelup Lollipop"] = {
            DisplayName = "Levelup Lollipop",
            Type = "Gear",
            Stack = 1,
            StockChance = 150,
            Price = 500,
            PurchaseID = 3329528135,
            GiftPurchaseID = 0,
            LayoutOrder = 5,
            FallbackPrice = 79,
            Rarity = GearData["Levelup Lollipop"].GearRarity,
            ImageId = GearData["Levelup Lollipop"].Asset,
            Desc = GearData["Levelup Lollipop"].GearDescription,
            StockAmount = { 1, 1 }
        },
        ["Grow All"] = {
            DisplayName = "Grow All",
            Type = "Gear",
            Stack = 1,
            StockChance = 250,
            Price = 1000,
            PurchaseID = 3415151239,
            GiftPurchaseID = 0,
            LayoutOrder = 6,
            FallbackPrice = 375,
            Rarity = GearData["Grow All"].GearRarity,
            ImageId = GearData["Grow All"].Asset,
            Desc = GearData["Grow All"].GearDescription,
            StockAmount = { 1, 1 }
        },
        Spirecrest = {
            DisplayName = "Spirecrest",
            Type = "Seed",
            StockChance = 300,
            Price = 3000,
            PurchaseID = 3627199928,
            GiftPurchaseID = 0,
            LayoutOrder = 7,
            FallbackPrice = 819,
            Rarity = SeedData.Spirecrest.SeedRarity,
            ImageId = SeedData.Spirecrest.Asset,
            StockAmount = { 1, 1 }
        }
    }
};