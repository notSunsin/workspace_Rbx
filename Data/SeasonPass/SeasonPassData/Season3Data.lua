-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GearData = require(ReplicatedStorage.Data.GearData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Data.PetRegistry.PetList);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticList);

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
            }, {
                DisplayName = "Firework",
                Type = "Gear",
                Value = "Firework",
                Quantity = 5
            }, {
                DisplayName = "Magnifying Glass",
                Type = "Gear",
                Value = "Magnifying Glass",
                Quantity = 1
            }, {
                DisplayName = "Trading Ticket",
                Type = "Gear",
                Value = "Trading Ticket",
                Quantity = 5
            }, {
                DisplayName = "Event Lantern",
                Type = "Gear",
                Value = "Event Lantern",
                Quantity = 1
            } },
        { {
                DisplayName = "Snowman Soldier",
                Type = "Pet",
                Value = "Snowman Soldier",
                Quantity = 1
            } },
        { {
                DisplayName = "Frosty Bite Seed",
                Type = "Seed",
                Value = "Frosty Bite",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Ice Table",
                Type = "Cosmetic",
                Value = "Ice Table",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            }, {
                DisplayName = "Rare Egg",
                Type = "Egg",
                Value = "Rare Egg",
                Quantity = 2
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Cryo Rose Seed",
                Type = "Seed",
                Value = "Cryo Rose",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            }, {
                DisplayName = "Harvest Tool",
                Type = "Gear",
                Value = "Harvest Tool",
                Quantity = 2
            } },
        { {
                DisplayName = "Grandmaster Sprinkler",
                Type = "Gear",
                Value = "Grandmaster Sprinkler",
                Quantity = 1
            }, {
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
            }, {
                DisplayName = "Lightning Rod",
                Type = "Gear",
                Value = "Lightning Rod",
                Quantity = 1
            }, {
                DisplayName = "Trading Ticket",
                Type = "Gear",
                Value = "Trading Ticket",
                Quantity = 3
            } },
        { {
                DisplayName = "Watering Can",
                Type = "Gear",
                Value = "Watering Can",
                Quantity = 10
            }, {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            }, {
                DisplayName = "Advanced Sprinkler",
                Type = "Gear",
                Value = "Advanced Sprinkler",
                Quantity = 1
            }, {
                DisplayName = "Super Leaf Blower",
                Type = "Gear",
                Value = "Super Leaf Blower",
                Quantity = 1
            } },
        { {
                DisplayName = "Bush Flake Seed",
                Type = "Seed",
                Value = "Bush Flake",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            }, {
                DisplayName = "Legendary Egg",
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Master Sprinkler",
                Type = "Gear",
                Value = "Master Sprinkler",
                Quantity = 5
            }, {
                DisplayName = "Watering Can",
                Type = "Gear",
                Value = "Watering Can",
                Quantity = 20
            } },
        { {
                DisplayName = "Toy Horse",
                Type = "Cosmetic",
                Value = "Toy Horse",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Small Treat",
                Type = "Gear",
                Value = "Small Treat",
                Quantity = 2
            }, {
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
            }, {
                DisplayName = "Small Toy",
                Type = "Gear",
                Value = "Small Toy",
                Quantity = 2
            } },
        { {
                DisplayName = "Lightning Rod",
                Type = "Gear",
                Value = "Lightning Rod",
                Quantity = 1
            }, {
                DisplayName = "Tanning Mirror",
                Type = "Gear",
                Value = "Tanning Mirror",
                Quantity = 1
            } },
        { {
                DisplayName = "Rosemary Seed",
                Type = "Seed",
                Value = "Rosemary",
                Quantity = 1
            } },
        { {
                DisplayName = "Snowman Builder",
                Type = "Pet",
                Value = "Snowman Builder",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Watering Can",
                Type = "Gear",
                Value = "Watering Can",
                Quantity = 10
            }, {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 2
            }, {
                DisplayName = "Harvest Tool",
                Type = "Gear",
                Value = "Harvest Tool",
                Quantity = 2
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
            }, {
                DisplayName = "Recall Wrench",
                Type = "Gear",
                Value = "Recall Wrench",
                Quantity = 10
            }, {
                DisplayName = "Pet Name Reroller",
                Type = "Gear",
                Value = "Pet Name Reroller",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            }, {
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
                DisplayName = "Winter Wheelbarrow",
                Type = "Cosmetic",
                Value = "Winter Wheelbarrow",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            }, {
                DisplayName = "Legendary Egg",
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 50
            }, {
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
            }, {
                DisplayName = "Super Watering Can",
                Type = "Gear",
                Value = "Super Watering Can",
                Quantity = 1
            } },
        { {
                DisplayName = "Arctic Fox",
                Type = "Pet",
                Value = "Arctic Fox",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            }, {
                DisplayName = "Evo Apple I Seed",
                Type = "Seed",
                Value = "Evo Apple I",
                Quantity = 1
            } },
        { {
                DisplayName = "Levelup Lollipop",
                Type = "Gear",
                Value = "Levelup Lollipop",
                Quantity = 5
            }, {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            } },
        { {
                DisplayName = "Cryoshard Seed",
                Type = "Seed",
                Value = "Cryoshard",
                Quantity = 1
            } },
        { {
                DisplayName = "Elder Strawberry Seed",
                Type = "Seed",
                Value = "Elder Strawberry",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            }, {
                DisplayName = "Jungle Egg",
                Type = "Egg",
                Value = "Jungle Egg",
                Quantity = 1
            } },
        { {
                DisplayName = "Frost Dragon",
                Type = "Pet",
                Value = "Frost Dragon",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Frostwing Seed",
                Type = "Seed",
                Value = "Frostwing",
                Quantity = 1
            } }
    },
    PremiumRewards = {
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            }, {
                DisplayName = "Firework",
                Type = "Gear",
                Value = "Firework",
                Quantity = 5
            }, {
                DisplayName = "Levelup Lollipop",
                Type = "Gear",
                Value = "Levelup Lollipop",
                Quantity = 1
            }, {
                DisplayName = "Pet Name Reroller",
                Type = "Gear",
                Value = "Pet Name Reroller",
                Quantity = 1
            }, {
                DisplayName = "Super Leaf Blower",
                Type = "Gear",
                Value = "Super Leaf Blower",
                Quantity = 1
            } },
        { {
                DisplayName = "Giant Snowman Soldier",
                Type = "Pet",
                Value = "GIANT Snowman Soldier",
                Quantity = 1
            } },
        { {
                DisplayName = "Frosty Bite Seed",
                Type = "Seed",
                Value = "Frosty Bite",
                Quantity = 3
            } },
        { {
                DisplayName = "Exotic Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Christmas Lamp",
                Type = "Cosmetic",
                Value = "Christmas Lamp",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            }, {
                DisplayName = "Rare Egg",
                Type = "Egg",
                Value = "Rare Egg",
                Quantity = 1
            }, {
                DisplayName = "Legendary Egg",
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Cryo Rose Seed",
                Type = "Seed",
                Value = "Cryo Rose",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            }, {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 1
            }, {
                DisplayName = "Harvest Tool",
                Type = "Gear",
                Value = "Harvest Tool",
                Quantity = 2
            } },
        { {
                DisplayName = "Grandmaster Sprinkler",
                Type = "Gear",
                Value = "Grandmaster Sprinkler",
                Quantity = 1
            }, {
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
            }, {
                DisplayName = "Tanning Mirror",
                Type = "Gear",
                Value = "Tanning Mirror",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            }, {
                DisplayName = "Watering Can",
                Type = "Gear",
                Value = "Watering Can",
                Quantity = 20
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            }, {
                DisplayName = "Advanced Sprinkler",
                Type = "Gear",
                Value = "Advanced Sprinkler",
                Quantity = 2
            } },
        { {
                DisplayName = "Bush Flake",
                Type = "Seed",
                Value = "Bush Flake",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 125
            }, {
                DisplayName = "Legendary Egg",
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 2
            } },
        { {
                DisplayName = "Exotic Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Grandmaster Sprinkler",
                Type = "Gear",
                Value = "Grandmaster Sprinkler",
                Quantity = 2
            }, {
                DisplayName = "Super Watering Can",
                Type = "Gear",
                Value = "Super Watering Can",
                Quantity = 1
            } },
        { {
                DisplayName = "Nutcracker",
                Type = "Cosmetic",
                Value = "Nutcracker",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
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
            }, {
                DisplayName = "Medium Toy",
                Type = "Gear",
                Value = "Medium Toy",
                Quantity = 2
            } },
        { {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            } },
        { {
                DisplayName = "Rosemary Seed",
                Type = "Seed",
                Value = "Rosemary",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Giant Snowman Builder",
                Type = "Pet",
                Value = "GIANT Snowman Builder",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Watering Can",
                Type = "Gear",
                Value = "Watering Can",
                Quantity = 20
            }, {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 4
            }, {
                DisplayName = "Harvest Tool",
                Type = "Gear",
                Value = "Harvest Tool",
                Quantity = 4
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            }, {
                DisplayName = "Pet Lead",
                Type = "Gear",
                Value = "Pet Lead",
                Quantity = 2
            } },
        { {
                DisplayName = "Exotic Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            }, {
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
            }, {
                DisplayName = "Trading Ticket",
                Type = "Gear",
                Value = "Trading Ticket",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            } },
        { {
                DisplayName = "Christmas Bench",
                Type = "Cosmetic",
                Value = "Christmas Bench",
                Quantity = 1
            } },
        { {
                DisplayName = "Holiday Crate",
                Type = "Crate",
                Value = "Holiday Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 125
            }, {
                DisplayName = "Legendary Egg",
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            }, {
                DisplayName = "Reclaimer",
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 200
            } },
        { {
                DisplayName = "Rainbow Arctic Fox",
                Type = "Pet",
                Value = "Rainbow Arctic Fox",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 200
            }, {
                DisplayName = "Evo Apple I Seed",
                Type = "Seed",
                Value = "Evo Apple I",
                Quantity = 1,
                Variant = "Gold"
            } },
        { {
                DisplayName = "Grandmaster Sprinkler",
                Type = "Gear",
                Value = "Grandmaster Sprinkler",
                Quantity = 5
            }, {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            } },
        { {
                DisplayName = "Cryoshard Seed",
                Type = "Seed",
                Value = "Cryoshard",
                Quantity = 1,
                Variant = "Gold"
            } },
        { {
                DisplayName = "Elder Strawberry Seed",
                Type = "Seed",
                Value = "Elder Strawberry",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 300
            }, {
                DisplayName = "Bug Egg",
                Type = "Egg",
                Value = "Bug Egg",
                Quantity = 2
            } },
        { {
                DisplayName = "Rainbow Frost Dragon",
                Type = "Pet",
                Value = "Rainbow Frost Dragon",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Holiday Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Holiday Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 800
            } },
        { {
                DisplayName = "Frostwing Seed",
                Type = "Seed",
                Value = "Frostwing",
                Quantity = 1,
                Variant = "Gold"
            } }
    },
    IncludesItems = { "Rainbow Frost Dragon!", "Gold Frostwing!", "Gold Cyroshard", "Giant Snowman Soldier", "Nutcracker" },
    ShopItems = {
        ["Holiday Crate"] = {
            DisplayName = "Holiday Crate",
            Rarity = "Common",
            Type = "Crate",
            StockChance = 1,
            Price = 100,
            PurchaseID = 3471915270,
            GiftPurchaseID = 0,
            LayoutOrder = 1,
            FallbackPrice = 179,
            ImageId = require(ReplicatedStorage.Data.CosmeticCrateRegistry.CosmeticCrates)["Holiday Crate"].Icon,
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
        ["Penguin Statue"] = {
            DisplayName = "Penguin Statue",
            Type = "Cosmetic",
            StockChance = 5,
            Price = 600,
            PurchaseID = 3471928442,
            GiftPurchaseID = 0,
            LayoutOrder = 3,
            FallbackPrice = 239,
            Rarity = CosmeticList["Penguin Statue"].Rarity,
            ImageId = CosmeticList["Penguin Statue"].Icon,
            StockAmount = { 1, 1 }
        },
        ["Holiday Seed Pack"] = {
            DisplayName = "Holiday Seed Pack",
            Rarity = "Divine",
            Type = "Seed Pack",
            StockChance = 5,
            Price = 150,
            PurchaseID = 3471915500,
            GiftPurchaseID = 0,
            LayoutOrder = 4,
            FallbackPrice = 199,
            ImageId = SeedPackData.Packs["Holiday Seed Pack"].Icon,
            StockAmount = { 1, 2 }
        },
        ["Levelup Lollipop"] = {
            DisplayName = "Levelup Lollipop",
            Type = "Gear",
            Stack = 1,
            StockChance = 150,
            Price = 500,
            PurchaseID = 3329528135,
            GiftPurchaseID = 3329530334,
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
            GiftPurchaseID = 3415151549,
            LayoutOrder = 6,
            FallbackPrice = 375,
            Rarity = GearData["Grow All"].GearRarity,
            ImageId = GearData["Grow All"].Asset,
            Desc = GearData["Grow All"].GearDescription,
            StockAmount = { 1, 1 }
        },
        ["Pollen Cone"] = {
            DisplayName = "Pollen Cone",
            Type = "Seed",
            StockChance = 300,
            Price = 3000,
            PurchaseID = 3471921586,
            GiftPurchaseID = 0,
            LayoutOrder = 7,
            FallbackPrice = 779,
            Rarity = SeedData["Pollen Cone"].SeedRarity,
            ImageId = SeedData["Pollen Cone"].Asset,
            StockAmount = { 1, 1 }
        }
    }
};