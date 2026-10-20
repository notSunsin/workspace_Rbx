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
                DisplayName = "Leaf Insect",
                Type = "Pet",
                Value = "Leaf Insect",
                Quantity = 1
            } },
        { {
                DisplayName = "Starbloom Daisy Seed",
                Type = "Seed",
                Value = "Starbloom Daisy",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 5 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Red Mailbox",
                Type = "Cosmetic",
                Value = "Red Mailbox",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Cocoa Pod Seed",
                Type = "Seed",
                Value = "Cocoa Pod",
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
                DisplayName = "Astrobush Seed",
                Type = "Seed",
                Value = "Astrobush",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            } },
        { {
                DisplayName = "Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 5 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Master Sprinkler",
                Type = "Gear",
                Value = "Master Sprinkler",
                Quantity = 5
            } },
        { {
                DisplayName = "Storage Unit",
                Type = "Cosmetic",
                Value = "Storage Unit",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
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
                DisplayName = "Lumi Shroom Seed",
                Type = "Seed",
                Value = "Lumi Shroom",
                Quantity = 1
            } },
        { {
                DisplayName = "Quetzal",
                Type = "Pet",
                Value = "Quetzal",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
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
                DisplayName = "Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 5 Seed Pack",
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
                DisplayName = "Garden Bin",
                Type = "Cosmetic",
                Value = "Garden Bin",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
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
                DisplayName = "Monitor Lizard",
                Type = "Pet",
                Value = "Monitor Lizard",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 5 Seed Pack",
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
                DisplayName = "Sweetheart Flower Seed",
                Type = "Seed",
                Value = "Sweetheart Flower",
                Quantity = 1
            } },
        { {
                DisplayName = "Burning Bud Seed",
                Type = "Seed",
                Value = "Burning Bud",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            } },
        { {
                DisplayName = "Moss Wyvern",
                Type = "Pet",
                Value = "Moss Wyvern",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Season 5 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Bendbark Seed",
                Type = "Seed",
                Value = "Bendbark",
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
                DisplayName = "Giant Leaf Insect",
                Type = "Pet",
                Value = "GIANT Leaf Insect",
                Quantity = 1
            } },
        { {
                DisplayName = "Starbloom Daisy Seed",
                Type = "Seed",
                Value = "Starbloom Daisy",
                Quantity = 3
            } },
        { {
                DisplayName = "Exotic Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 5 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Stepping Stones",
                Type = "Cosmetic",
                Value = "Stepping Stones",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Cocoa Pod Seed",
                Type = "Seed",
                Value = "Cocoa Pod",
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
                DisplayName = "Astrobush",
                Type = "Seed",
                Value = "Astrobush",
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
                DisplayName = "Exotic Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 5 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Super Watering Can",
                Type = "Gear",
                Value = "Super Watering Can",
                Quantity = 1
            } },
        { {
                DisplayName = "Empty Cart",
                Type = "Cosmetic",
                Value = "Empty Cart",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
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
                DisplayName = "Lumi Shroom Seed",
                Type = "Seed",
                Value = "Lumi Shroom",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Giant Quetzal",
                Type = "Pet",
                Value = "GIANT Quetzal",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 4
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Exotic Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 5 Seed Pack",
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
                DisplayName = "Garden Chest",
                Type = "Cosmetic",
                Value = "Garden Chest",
                Quantity = 1
            } },
        { {
                DisplayName = "Season 5 Crate",
                Type = "Crate",
                Value = "Season 5 Crate",
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
                DisplayName = "Rainbow Monitor Lizard",
                Type = "Pet",
                Value = "Rainbow Monitor Lizard",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 5 Seed Pack",
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
                DisplayName = "Sweetheart Flower Seed",
                Type = "Seed",
                Value = "Sweetheart Flower",
                Quantity = 1,
                Variant = "Gold"
            } },
        { {
                DisplayName = "Burning Bud Seed",
                Type = "Seed",
                Value = "Burning Bud",
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
                DisplayName = "Rainbow Moss Wyvern",
                Type = "Pet",
                Value = "Rainbow Moss Wyvern",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Season 5 Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Season 5 Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 800
            } },
        { {
                DisplayName = "Bendbark Seed",
                Type = "Seed",
                Value = "Bendbark",
                Quantity = 1,
                Variant = "Gold"
            } }
    },
    IncludesItems = { "Rainbow Moss Wyvern!", "Gold Bendbark!", "Gold Sweetheart Flower", "Giant Quetzal", "Garden Chest" },
    ShopItems = {
        ["Season 5 Crate"] = {
            DisplayName = "Season 5 Crate",
            Rarity = "Common",
            Type = "Crate",
            StockChance = 1,
            Price = 100,
            PurchaseID = 3596484464,
            GiftPurchaseID = 0,
            LayoutOrder = 1,
            FallbackPrice = 179,
            ImageId = CosmeticCrates["Season 5 Crate"].Icon,
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
        ["Garden Lantern"] = {
            DisplayName = "Garden Lantern",
            Type = "Cosmetic",
            StockChance = 5,
            Price = 600,
            PurchaseID = 3596484927,
            GiftPurchaseID = 0,
            LayoutOrder = 3,
            FallbackPrice = 119,
            Rarity = CosmeticList["Garden Lantern"].Rarity,
            ImageId = CosmeticList["Garden Lantern"].Icon,
            StockAmount = { 1, 1 }
        },
        ["Season 5 Seed Pack"] = {
            DisplayName = "Season 5 Seed Pack",
            Rarity = "Divine",
            Type = "Seed Pack",
            StockChance = 5,
            Price = 150,
            PurchaseID = 3596484651,
            GiftPurchaseID = 0,
            LayoutOrder = 4,
            FallbackPrice = 199,
            ImageId = SeedPackData.Packs["Season 5 Seed Pack"].Icon,
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
        ["Pinkfruit Palm"] = {
            DisplayName = "Pinkfruit Palm",
            Type = "Seed",
            StockChance = 300,
            Price = 3000,
            PurchaseID = 3596485110,
            GiftPurchaseID = 0,
            LayoutOrder = 7,
            FallbackPrice = 819,
            Rarity = SeedData["Pinkfruit Palm"].SeedRarity,
            ImageId = SeedData["Pinkfruit Palm"].Asset,
            StockAmount = { 1, 1 }
        }
    }
};