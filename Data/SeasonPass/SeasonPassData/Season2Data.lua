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
                DisplayName = "Friendship Pot",
                Type = "Gear",
                Value = "Friendship Pot",
                Quantity = 1
            }, {
                DisplayName = "Event Lantern",
                Type = "Gear",
                Value = "Event Lantern",
                Quantity = 1
            } },
        { {
                DisplayName = "Armadillo",
                Type = "Pet",
                Value = "Armadillo",
                Quantity = 1
            } },
        { {
                DisplayName = "Horned Redrose Seed",
                Type = "Seed",
                Value = "Horned Redrose",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Zenith Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Basketball Hoop",
                Type = "Cosmetic",
                Value = "Basketball Hoop",
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
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Banana Orchid Seed",
                Type = "Seed",
                Value = "Banana Orchid",
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
                Quantity = 150
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
                Quantity = 100
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
                DisplayName = "Viburnum Berry Seed",
                Type = "Seed",
                Value = "Viburnum Berry",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 75
            }, {
                DisplayName = "Legendary Egg",
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Zenith Seed Pack",
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
                DisplayName = "Garden Arbor",
                Type = "Cosmetic",
                Value = "Garden Arbor",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 175
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
            }, {
                DisplayName = "Rafflesia Seed",
                Type = "Seed",
                Value = "Rafflesia",
                Quantity = 1
            } },
        { {
                DisplayName = "Lightning Rod",
                Type = "Gear",
                Value = "Lightning Rod",
                Quantity = 1
            } },
        { {
                DisplayName = "Buddhas Hand Seed",
                Type = "Seed",
                Value = "Buddhas Hand",
                Quantity = 1
            } },
        { {
                DisplayName = "Stag Beetle",
                Type = "Pet",
                Value = "Stag Beetle",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
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
                DisplayName = "Favorite Tool",
                Type = "Gear",
                Value = "Favorite Tool",
                Quantity = 1
            }, {
                DisplayName = "Pet Lead",
                Type = "Gear",
                Value = "Pet Lead",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Zenith Seed Pack",
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
                DisplayName = "Bonfire",
                Type = "Cosmetic",
                Value = "Bonfire",
                Quantity = 2
            } },
        { {
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
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
            } },
        { {
                DisplayName = "Mantis Shrimp",
                Type = "Pet",
                Value = "Mantis Shrimp",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Zenith Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            }, {
                DisplayName = "Mandrake Seed",
                Type = "Seed",
                Value = "Mandrake",
                Quantity = 3
            } },
        { {
                DisplayName = "Levelup Lollipop",
                Type = "Gear",
                Value = "Levelup Lollipop",
                Quantity = 5
            } },
        { {
                DisplayName = "Ghost Pepper Seed",
                Type = "Seed",
                Value = "Ghost Pepper",
                Quantity = 1
            } },
        { {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            }, {
                DisplayName = "Super Watering Can",
                Type = "Gear",
                Value = "Super Watering Can",
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
                DisplayName = "Hydra",
                Type = "Pet",
                Value = "Hydra",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Zenith Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
            }, {
                DisplayName = "Sugar Apple Seed",
                Type = "Seed",
                Value = "Sugar Apple",
                Quantity = 1
            } },
        { {
                DisplayName = "Thornspire Seed",
                Type = "Seed",
                Value = "Thornspire",
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
                DisplayName = "Pet Lead",
                Type = "Gear",
                Value = "Pet Lead",
                Quantity = 1
            }, {
                DisplayName = "Super Leaf Blower",
                Type = "Gear",
                Value = "Super Leaf Blower",
                Quantity = 1
            } },
        { {
                DisplayName = "Giant Armadillo",
                Type = "Pet",
                Value = "GIANT Armadillo",
                Quantity = 1
            } },
        { {
                DisplayName = "Horned Redrose Seed",
                Type = "Seed",
                Value = "Horned Redrose",
                Quantity = 3
            } },
        { {
                DisplayName = "Exotic Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Zenith Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Sun Dial",
                Type = "Cosmetic",
                Value = "Sun Dial",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 100
            }, {
                DisplayName = "Uncommon Egg",
                Type = "Egg",
                Value = "Uncommon Egg",
                Quantity = 1
            }, {
                DisplayName = "Rare Egg",
                Type = "Egg",
                Value = "Rare Egg",
                Quantity = 2
            } },
        { {
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Banana Orchid Seed",
                Type = "Seed",
                Value = "Banana Orchid",
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
                Quantity = 200
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
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
                DisplayName = "Viburnum Berry",
                Type = "Seed",
                Value = "Viburnum Berry",
                Quantity = 1,
                Variant = "Silver"
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
                DisplayName = "Exotic Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Zenith Seed Pack",
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
                DisplayName = "Garden Workbench",
                Type = "Cosmetic",
                Value = "Garden Workbench",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
                Quantity = 2
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 250
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
            }, {
                DisplayName = "Rafflesia Seed",
                Type = "Seed",
                Value = "Rafflesia",
                Quantity = 1
            } },
        { {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
            } },
        { {
                DisplayName = "Buddhas Hand Seed",
                Type = "Seed",
                Value = "Buddhas Hand",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Rainbow Stag Beetle",
                Type = "Pet",
                Value = "Rainbow Stag Beetle",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
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
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
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
                DisplayName = "Exotic Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Zenith Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 200
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 150
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
                DisplayName = "Gazebo",
                Type = "Cosmetic",
                Value = "Gazebo",
                Quantity = 1
            } },
        { {
                DisplayName = "Zenith Crate",
                Type = "Crate",
                Value = "Zenith Crate",
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
                DisplayName = "Giant Mantis Shrimp",
                Type = "Pet",
                Value = "GIANT Mantis Shrimp",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Zenith Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 200
            }, {
                DisplayName = "Mandrake Seed",
                Type = "Seed",
                Value = "Mandrake",
                Quantity = 3
            } },
        { {
                DisplayName = "Grandmaster Sprinkler",
                Type = "Gear",
                Value = "Grandmaster Sprinkler",
                Quantity = 5
            } },
        { {
                DisplayName = "Ghost Pepper Seed",
                Type = "Seed",
                Value = "Ghost Pepper",
                Quantity = 1,
                Variant = "Gold"
            } },
        { {
                DisplayName = "Grow All",
                Type = "Gear",
                Value = "Grow All",
                Quantity = 1
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
                DisplayName = "Rainbow Hydra",
                Type = "Pet",
                Value = "Rainbow Hydra",
                Quantity = 1
            } },
        { {
                DisplayName = "Exotic Zenith Seed Pack",
                Type = "Seed Pack",
                Value = "Exotic Zenith Seed Pack",
                Quantity = 1
            } },
        { {
                DisplayName = "Pass Points",
                Type = "Currency",
                Value = "PassPoints",
                Quantity = 800
            }, {
                DisplayName = "Sugar Apple Seed",
                Type = "Seed",
                Value = "Sugar Apple",
                Quantity = 1,
                Variant = "Silver"
            } },
        { {
                DisplayName = "Thornspire Seed",
                Type = "Seed",
                Value = "Thornspire",
                Quantity = 1,
                Variant = "Gold"
            } }
    },
    IncludesItems = { "Rainbow Hydra", "Gold Thornspire", "Gold Ghost Pepper", "Giant Mantis Shrimp", "Gazebo" },
    ShopItems = {
        ["Zenith Crate"] = {
            DisplayName = "Zenith Crate",
            Rarity = "Common",
            Type = "Crate",
            StockChance = 1,
            Price = 100,
            PurchaseID = 3445146070,
            GiftPurchaseID = 3445159608,
            LayoutOrder = 1,
            FallbackPrice = 179,
            ImageId = require(ReplicatedStorage.Data.CosmeticCrateRegistry.CosmeticCrates)["Zenith Crate"].Icon,
            StockAmount = { 1, 2 }
        },
        ["Mossy Rock"] = {
            DisplayName = "Mossy Rock",
            Type = "Cosmetic",
            StockChance = 5,
            Price = 600,
            PurchaseID = 3445146549,
            GiftPurchaseID = 3445160676,
            LayoutOrder = 2,
            FallbackPrice = 239,
            Rarity = CosmeticList["Mossy Rock"].Rarity,
            ImageId = CosmeticList["Mossy Rock"].Icon,
            StockAmount = { 1, 1 }
        },
        ["Silver Fertilizer"] = {
            DisplayName = "Silver Fertilizer",
            Type = "Gear",
            Stack = 1,
            StockChance = 50,
            Price = 300,
            PurchaseID = 3369805300,
            GiftPurchaseID = 3415155618,
            LayoutOrder = 3,
            FallbackPrice = 129,
            Rarity = GearData["Silver Fertilizer"].GearRarity,
            ImageId = GearData["Silver Fertilizer"].Asset,
            Desc = GearData["Silver Fertilizer"].GearDescription,
            StockAmount = { 1, 1 }
        },
        ["Zenith Seed Pack"] = {
            DisplayName = "Zenith Seed Pack",
            Rarity = "Divine",
            Type = "Seed Pack",
            StockChance = 5,
            Price = 150,
            PurchaseID = 3445151790,
            GiftPurchaseID = 3445162746,
            LayoutOrder = 4,
            FallbackPrice = 199,
            ImageId = SeedPackData.Packs["Zenith Seed Pack"].Icon,
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
        Wyrmvine = {
            DisplayName = "Wyrmvine",
            Type = "Seed",
            StockChance = 300,
            Price = 3000,
            PurchaseID = 3445154232,
            GiftPurchaseID = 3445163056,
            LayoutOrder = 7,
            FallbackPrice = 779,
            Rarity = SeedData.Wyrmvine.SeedRarity,
            ImageId = SeedData.Wyrmvine.Asset,
            StockAmount = { 1, 1 }
        }
    }
};