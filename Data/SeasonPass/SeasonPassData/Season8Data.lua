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
                DisplayName = "Dormouse",
                Type = "Pet",
                Value = "Dormouse",
                Quantity = 1
            } },
        { {
                DisplayName = "Drowse Daisy Seed",
                Type = "Seed",
                Value = "Drowse Daisy",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 8 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Dream Orb",
                Type = "Cosmetic",
                Value = "Dream Orb",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
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
                DisplayName = "Lullaberry Seed",
                Type = "Seed",
                Value = "Lullaberry",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 8 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Master Sprinkler",
                Type = "Gear",
                Value = "Master Sprinkler",
                Quantity = 5
            } },
        { {
                DisplayName = "Nightmare Candle",
                Type = "Cosmetic",
                Value = "Nightmare Candle",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
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
                DisplayName = "Beach Fern Seed",
                Type = "Seed",
                Value = "Beach Fern",
                Quantity = 1
            } },
        { {
                DisplayName = "Binturong",
                Type = "Pet",
                Value = "Binturong",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
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
                DisplayName = "Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 8 Seed Pack",
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
                DisplayName = "Dream Nightstand",
                Type = "Cosmetic",
                Value = "Dream Nightstand",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
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
                DisplayName = "Koala",
                Type = "Pet",
                Value = "Koala",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 8 Seed Pack",
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
                DisplayName = "Fernberry Seed",
                Type = "Seed",
                Value = "Fernberry",
                Quantity = 1
            } },
        { {
                DisplayName = "Giant Pinecone Seed",
                Type = "Seed",
                Value = "Giant Pinecone",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            } },
        { {
                DisplayName = "Baku",
                Type = "Pet",
                Value = "Baku",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 8 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Cosmic Dew Seed",
                Type = "Seed",
                Value = "Cosmic Dew",
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
                DisplayName = "Giant Dormouse",
                Type = "Pet",
                Value = "GIANT Dormouse",
                Quantity = 1
            } },
        { {
                DisplayName = "Drowse Daisy Seed",
                Type = "Seed",
                Value = "Drowse Daisy",
                Quantity = 3
            } },
        { {
                DisplayName = "Exotic Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 8 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Nightmare Key",
                Type = "Cosmetic",
                Value = "Nightmare Key",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
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
                DisplayName = "Lullaberry Seed",
                Type = "Seed",
                Value = "Lullaberry",
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
                DisplayName = "Exotic Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 8 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Super Watering Can",
                Type = "Gear",
                Value = "Super Watering Can",
                Quantity = 1
            } },
        { {
                DisplayName = "Nightmare Chest",
                Type = "Cosmetic",
                Value = "Nightmare Chest",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
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
                DisplayName = "Beach Fern Seed",
                Type = "Seed",
                Value = "Beach Fern",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Giant Binturong",
                Type = "Pet",
                Value = "GIANT Binturong",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 4
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Exotic Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 8 Seed Pack",
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
                DisplayName = "Cloud Steps",
                Type = "Cosmetic",
                Value = "Cloud Steps",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 8 Crate",
                Type = "Crate",
                Value = "Season 8 Crate",
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
                DisplayName = "Rainbow Koala",
                Type = "Pet",
                Value = "Rainbow Koala",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 8 Seed Pack",
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
                DisplayName = "Fernberry Seed",
                Type = "Seed",
                Value = "Fernberry",
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
                DisplayName = "Rainbow Baku",
                Type = "Pet",
                Value = "Rainbow Baku",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Season 8 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 8 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 800
            } },
        { {
                DisplayName = "Cosmic Dew Seed",
                Type = "Seed",
                Value = "Cosmic Dew",
                Quantity = 1,
                Variant = "Gold"
            } }
    },
    IncludesItems = { "Rainbow Baku!", "Gold Cosmic Dew!", "Gold Fernberry", "Giant Binturong", "Cloud Steps" },
    ShopItems = {
        ["Season 8 Crate"] = {
            DisplayName = "Season 8 Crate",
            Rarity = "Common",
            Type = "Crate",
            StockChance = 1,
            Price = 100,
            PurchaseID = 3714383089,
            GiftPurchaseID = 0,
            LayoutOrder = 1,
            FallbackPrice = 179,
            ImageId = CosmeticCrates["Season 8 Crate"].Icon,
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
        ["Nightmare Crystal"] = {
            DisplayName = "Nightmare Crystal",
            Type = "Cosmetic",
            StockChance = 5,
            Price = 600,
            PurchaseID = 3714382992,
            GiftPurchaseID = 0,
            LayoutOrder = 3,
            FallbackPrice = 119,
            Rarity = CosmeticList["Nightmare Crystal"].Rarity,
            ImageId = CosmeticList["Nightmare Crystal"].Icon,
            StockAmount = { 1, 1 }
        },
        ["Season 8 Seed Pack"] = {
            DisplayName = "Season 8 Seed Pack",
            Rarity = "Divine",
            Type = "Seed Pack",
            StockChance = 5,
            Price = 150,
            PurchaseID = 3714383044,
            GiftPurchaseID = 0,
            LayoutOrder = 4,
            FallbackPrice = 199,
            ImageId = SeedPackData.Packs["Season 8 Seed Pack"].Icon,
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
        Astralcap = {
            DisplayName = "Astralcap",
            Type = "Seed",
            StockChance = 300,
            Price = 3000,
            PurchaseID = 3714383170,
            GiftPurchaseID = 0,
            LayoutOrder = 7,
            FallbackPrice = 819,
            Rarity = SeedData.Astralcap.SeedRarity,
            ImageId = SeedData.Astralcap.Asset,
            StockAmount = { 1, 1 }
        }
    }
};