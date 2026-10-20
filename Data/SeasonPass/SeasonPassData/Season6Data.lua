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
                DisplayName = "Canary",
                Type = "Pet",
                Value = "Canary",
                Quantity = 1
            } },
        { {
                DisplayName = "Vio Puff Seed",
                Type = "Seed",
                Value = "Vio Puff",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 6 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Classic Beach Chair",
                Type = "Cosmetic",
                Value = "Classic Beach Chair",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Storm Bulb Seed",
                Type = "Seed",
                Value = "Storm Bulb",
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
                DisplayName = "Geode Root Seed",
                Type = "Seed",
                Value = "Geode Root",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 6 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Master Sprinkler",
                Type = "Gear",
                Value = "Master Sprinkler",
                Quantity = 5
            } },
        { {
                DisplayName = "Garden Bush",
                Type = "Cosmetic",
                Value = "Garden Bush",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
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
                DisplayName = "Chroma Orb Seed",
                Type = "Seed",
                Value = "Chroma Orb",
                Quantity = 1
            } },
        { {
                DisplayName = "Electric Eel",
                Type = "Pet",
                Value = "Electric Eel",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
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
                DisplayName = "Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 6 Seed Pack",
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
                DisplayName = "Cooler",
                Type = "Cosmetic",
                Value = "Cooler",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
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
                DisplayName = "Kirin",
                Type = "Pet",
                Value = "Kirin",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 6 Seed Pack",
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
                DisplayName = "Polypea Sprout Seed",
                Type = "Seed",
                Value = "Polypea Sprout",
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
                DisplayName = "Thunderbird",
                Type = "Pet",
                Value = "Thunderbird",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 6 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Volt Lily Seed",
                Type = "Seed",
                Value = "Volt Lily",
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
                DisplayName = "Giant Canary",
                Type = "Pet",
                Value = "GIANT Canary",
                Quantity = 1
            } },
        { {
                DisplayName = "Vio Puff Seed",
                Type = "Seed",
                Value = "Vio Puff",
                Quantity = 3
            } },
        { {
                DisplayName = "Exotic Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 6 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Large Toolbox",
                Type = "Cosmetic",
                Value = "Large Toolbox",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Storm Bulb Seed",
                Type = "Seed",
                Value = "Storm Bulb",
                Quantity = 2
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
                DisplayName = "Geode Root Seed",
                Type = "Seed",
                Value = "Geode Root",
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
                DisplayName = "Exotic Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 6 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Super Watering Can",
                Type = "Gear",
                Value = "Super Watering Can",
                Quantity = 1
            } },
        { {
                DisplayName = "Gumball Machine",
                Type = "Cosmetic",
                Value = "Gumball Machine",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
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
                DisplayName = "Chroma Orb Seed",
                Type = "Seed",
                Value = "Chroma Orb",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Giant Electric Eel",
                Type = "Pet",
                Value = "GIANT Electric Eel",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 4
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Exotic Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 6 Seed Pack",
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
                DisplayName = "Construction Sign",
                Type = "Cosmetic",
                Value = "Construction Sign",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 6 Crate",
                Type = "Crate",
                Value = "Season 6 Crate",
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
                DisplayName = "Rainbow Kirin",
                Type = "Pet",
                Value = "Rainbow Kirin",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 6 Seed Pack",
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
                DisplayName = "Polypea Sprout Seed",
                Type = "Seed",
                Value = "Polypea Sprout",
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
                DisplayName = "Rainbow Thunderbird",
                Type = "Pet",
                Value = "Rainbow Thunderbird",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Season 6 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 6 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 800
            } },
        { {
                DisplayName = "Volt Lily Seed",
                Type = "Seed",
                Value = "Volt Lily",
                Quantity = 1,
                Variant = "Gold"
            } }
    },
    IncludesItems = { "Rainbow Thunderbird!", "Gold Volt Lily!", "Gold Polypea Sprout", "Giant Electric Eel", "Construction Sign" },
    ShopItems = {
        ["Season 6 Crate"] = {
            DisplayName = "Season 6 Crate",
            Rarity = "Common",
            Type = "Crate",
            StockChance = 1,
            Price = 100,
            PurchaseID = 3606300323,
            GiftPurchaseID = 0,
            LayoutOrder = 1,
            FallbackPrice = 179,
            ImageId = CosmeticCrates["Season 6 Crate"].Icon,
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
        Floodlight = {
            DisplayName = "Floodlight",
            Type = "Cosmetic",
            StockChance = 5,
            Price = 600,
            PurchaseID = 3606300494,
            GiftPurchaseID = 0,
            LayoutOrder = 3,
            FallbackPrice = 119,
            Rarity = CosmeticList.Floodlight.Rarity,
            ImageId = CosmeticList.Floodlight.Icon,
            StockAmount = { 1, 1 }
        },
        ["Season 6 Seed Pack"] = {
            DisplayName = "Season 6 Seed Pack",
            Rarity = "Divine",
            Type = "Seed Pack",
            StockChance = 5,
            Price = 150,
            PurchaseID = 3606300380,
            GiftPurchaseID = 0,
            LayoutOrder = 4,
            FallbackPrice = 199,
            ImageId = SeedPackData.Packs["Season 6 Seed Pack"].Icon,
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
        ["Queen Fruit"] = {
            DisplayName = "Queen Fruit",
            Type = "Seed",
            StockChance = 300,
            Price = 3000,
            PurchaseID = 3606300434,
            GiftPurchaseID = 0,
            LayoutOrder = 7,
            FallbackPrice = 819,
            Rarity = SeedData["Queen Fruit"].SeedRarity,
            ImageId = SeedData["Queen Fruit"].Asset,
            StockAmount = { 1, 1 }
        }
    }
};