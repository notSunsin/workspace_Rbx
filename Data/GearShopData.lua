-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.NPCLevels.NPCLevelData.NPCLevelTypes);
require(ReplicatedStorage.Modules.Chalk);
local GearData = require(script.Parent.GearData);

return {
    RefreshTime = 300,
    Gear = {
        ["Watering Can"] = {
            StockChance = 1,
            Price = 50000,
            PurchaseID = 3260229242,
            GiftPurchaseID = 3269349334,
            LayoutOrder = 1,
            FallbackPrice = 39,
            Gear = GearData["Watering Can"],
            StockAmount = { 1, 3 }
        },
        ["Trading Ticket"] = {
            StockChance = 1,
            Price = 100000,
            PurchaseID = 3352931398,
            GiftPurchaseID = 3352931957,
            DisplayInShop = true,
            FallbackPrice = 19,
            LayoutOrder = 1000,
            RebirthRequirement = 3,
            Gear = GearData["Trading Ticket"],
            StockAmount = { 1, 2 }
        },
        Trowel = {
            StockChance = 1,
            Price = 100000,
            PurchaseID = 3265946561,
            Stack = 5,
            DisplayInShop = true,
            LayoutOrder = 25,
            FallbackPrice = 49,
            Gear = GearData.Trowel,
            StockAmount = { 1, 3 }
        },
        ["Recall Wrench"] = {
            StockChance = 1,
            Price = 150000,
            PurchaseID = 3282918403,
            GiftPurchaseID = 3282918955,
            LayoutOrder = 30,
            GearDescription = "Teleports to Gear Shop. 5 uses",
            FallbackPrice = 59,
            Gear = GearData["Recall Wrench"],
            StockAmount = { 1, 3 }
        },
        ["Basic Sprinkler"] = {
            StockChance = 3,
            Price = 25000,
            PurchaseID = 3265889601,
            GiftPurchaseID = 3269349445,
            LayoutOrder = 2,
            FallbackPrice = 79,
            Gear = GearData["Basic Sprinkler"],
            StockAmount = { 1, 3 }
        },
        ["Advanced Sprinkler"] = {
            StockChance = 7,
            Price = 50000,
            PurchaseID = 3265889751,
            GiftPurchaseID = 3269349768,
            LayoutOrder = 3,
            FallbackPrice = 99,
            Gear = GearData["Advanced Sprinkler"],
            StockAmount = { 1, 2 }
        },
        ["Medium Toy"] = {
            StockChance = 50,
            Price = 4000000,
            PurchaseID = 3329526686,
            GiftPurchaseID = 3329530133,
            LayoutOrder = 52,
            FallbackPrice = 189,
            RebirthRequirement = 3,
            Gear = GearData["Medium Toy"],
            StockAmount = { 1, 2 }
        },
        ["Pet Name Reroller"] = {
            StockChance = 1,
            Price = 10000000,
            PurchaseID = 3394263188,
            LayoutOrder = 54,
            FallbackPrice = 49,
            RebirthRequirement = 3,
            Gear = GearData["Pet Name Reroller"],
            StockAmount = { 1, 10 }
        },
        ["Pet Lead"] = {
            StockChance = 25,
            Price = 20000000,
            PurchaseID = 3394262674,
            LayoutOrder = 56,
            FallbackPrice = 99,
            RebirthRequirement = 3,
            Gear = GearData["Pet Lead"],
            StockAmount = { 1, 2 }
        },
        ["Medium Treat"] = {
            StockChance = 50,
            Price = 4000000,
            PurchaseID = 3329527365,
            GiftPurchaseID = 3329529928,
            LayoutOrder = 58,
            FallbackPrice = 119,
            RebirthRequirement = 3,
            Gear = GearData["Medium Treat"],
            StockAmount = { 1, 2 }
        },
        ["Godly Sprinkler"] = {
            StockChance = 11,
            Price = 120000,
            PurchaseID = 3265889948,
            GiftPurchaseID = 3269349908,
            LayoutOrder = 4,
            FallbackPrice = 149,
            Gear = GearData["Godly Sprinkler"],
            StockAmount = { 1, 1 }
        },
        ["Magnifying Glass"] = {
            StockChance = 3,
            Price = 10000000,
            PurchaseID = 3316261725,
            GiftPurchaseID = 3317955209,
            LayoutOrder = 80,
            FallbackPrice = 99,
            Gear = GearData["Magnifying Glass"],
            StockAmount = { 1, 1 }
        },
        ["Master Sprinkler"] = {
            StockChance = 100,
            Price = 10000000,
            PurchaseID = 3267580365,
            GiftPurchaseID = 3269350167,
            LayoutOrder = 5,
            FallbackPrice = 199,
            RebirthRequirement = 4,
            Gear = GearData["Master Sprinkler"],
            StockAmount = { 1, 1 }
        },
        ["Cleaning Spray"] = {
            StockChance = 3,
            Price = 15000000,
            PurchaseID = 3306767043,
            GiftPurchaseID = 3306767451,
            LayoutOrder = 110,
            FallbackPrice = 139,
            Gear = GearData["Cleaning Spray"],
            StockAmount = { 1, 2 }
        },
        ["Favorite Tool"] = {
            GearRarity = "Divine",
            StockChance = 1,
            Price = 20000000,
            PurchaseID = 3281679093,
            GiftPurchaseID = 3281679185,
            LayoutOrder = 120,
            FallbackPrice = 119,
            Gear = GearData["Favorite Tool"],
            StockAmount = { 1, 3 }
        },
        ["Harvest Tool"] = {
            StockChance = 1,
            Price = 30000000,
            PurchaseID = 3286038236,
            GiftPurchaseID = 3286038078,
            LayoutOrder = 130,
            FallbackPrice = 149,
            Gear = GearData["Harvest Tool"],
            StockAmount = { 1, 3 }
        },
        ["Friendship Pot"] = {
            StockChance = 50,
            Price = 15000000,
            PurchaseID = 3301473650,
            GiftPurchaseID = 3301474767,
            LayoutOrder = 140,
            FallbackPrice = 39,
            Gear = GearData["Friendship Pot"],
            StockAmount = { 1, 1 }
        },
        ["Grandmaster Sprinkler"] = {
            StockChance = 300,
            Price = 1000000000,
            PurchaseID = 3354130076,
            GiftPurchaseID = 3354131020,
            LayoutOrder = 6,
            RebirthRequirement = 5,
            FallbackPrice = 279,
            Gear = GearData["Grandmaster Sprinkler"],
            StockAmount = { 1, 1 }
        },
        ["Levelup Lollipop"] = {
            StockChance = 300,
            Price = 10000000000,
            PurchaseID = 3329528135,
            GiftPurchaseID = 3329530334,
            LayoutOrder = 170,
            RebirthRequirement = 3,
            FallbackPrice = 79,
            Gear = GearData["Levelup Lollipop"],
            StockAmount = { 1, 2 }
        },
        ["Cleansing Pet Shard"] = {
            StockChance = 12,
            Price = 30000000,
            PurchaseID = 3379245220,
            GiftPurchaseID = 3379255032,
            LayoutOrder = 115,
            FallbackPrice = 139,
            RebirthRequirement = 3,
            Gear = GearData["Cleansing Pet Shard"],
            StockAmount = { 1, 1 }
        }
    }
};