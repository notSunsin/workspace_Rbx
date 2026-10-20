-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.EventShopData.EventShopTypes);

return {
    SeedShopConfig = {
        SHOP_RESET_TIME = 900,
        SHOP_UI_NAME = "FallMarketEventShop_UI",
        EVENT_SET = "FallMarketEvent",
        LINKED_SHOPS = {}
    },
    SeedShop = {
        Turnip = {
            SeedName = "Turnip",
            SeedRarity = "Common",
            StockChance = 1,
            Price = 10000000,
            PurchaseID = 3401533643,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 10,
            ItemType = "Seed",
            Stack = 1,
            ShopIndex = 1,
            Description = "",
            FallbackPrice = 129,
            StockAmount = { 5, 7 },

            CanBuy = function(p1, p2) -- Line: 31, Name: CanBuy
                return true;
            end
        },
        Parsley = {
            SeedName = "Parsley",
            SeedRarity = "Uncommon",
            StockChance = 3,
            Price = 20000000,
            PurchaseID = 3401533790,
            DisplayInShop = true,
            ShowOdds = true,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 2 Times",
            LayoutOrder = 20,
            ItemType = "Seed",
            Stack = 1,
            ShopIndex = 1,
            Description = "",
            FallbackPrice = 169,
            StockAmount = { 3, 5 },

            CanBuy = function(p3, p4) -- Line: 74, Name: CanBuy
                return true;
            end
        },
        ["Autumn Seed Pack"] = {
            SeedName = "Autumn Seed Pack",
            SeedRarity = "Rare",
            StockChance = 1,
            Price = 10000000,
            PurchaseID = 3713349771,
            DisplayInShop = true,
            ShowOdds = true,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 3 Times",
            LayoutOrder = 30,
            ItemType = "Seed Pack",
            Stack = 1,
            ShopIndex = 1,
            Description = "",
            FallbackPrice = 199,
            StockAmount = { 1, 1 },

            CanBuy = function(p5, p6) -- Line: 96, Name: CanBuy
                return true;
            end
        },
        ["Meyer Lemon"] = {
            SeedName = "Meyer Lemon",
            SeedRarity = "Rare",
            StockChance = 4,
            Price = 50000000,
            PurchaseID = 3401533943,
            DisplayInShop = true,
            ShowOdds = true,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 4 Times",
            LayoutOrder = 40,
            ItemType = "Seed",
            Stack = 1,
            ShopIndex = 1,
            Description = "",
            FallbackPrice = 247,
            StockAmount = { 1, 2 },

            CanBuy = function(p7, p8) -- Line: 118, Name: CanBuy
                return true;
            end
        },
        ["Carnival Pumpkin"] = {
            SeedName = "Carnival Pumpkin",
            SeedRarity = "Legendary",
            StockChance = 6,
            Price = 100000000,
            PurchaseID = 3401534101,
            DisplayInShop = true,
            ShowOdds = true,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 5 Times",
            LayoutOrder = 50,
            ItemType = "Seed",
            Stack = 1,
            ShopIndex = 1,
            Description = "",
            FallbackPrice = 479,
            StockAmount = { 1, 1 },

            CanBuy = function(p9, p10) -- Line: 139, Name: CanBuy
                return true;
            end
        },
        Kniphofia = {
            SeedName = "Kniphofia",
            SeedRarity = "Mythical",
            StockChance = 18,
            Price = 450000000,
            PurchaseID = 3401534268,
            DisplayInShop = true,
            ShowOdds = true,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 10 Times",
            LayoutOrder = 60,
            ItemType = "Seed",
            Stack = 1,
            ShopIndex = 1,
            Description = "",
            FallbackPrice = 659,
            StockAmount = { 1, 1 },

            CanBuy = function(p11, p12) -- Line: 160, Name: CanBuy
                return true;
            end
        },
        ["Golden Peach"] = {
            SeedName = "Golden Peach",
            SeedRarity = "Divine",
            StockChance = 30,
            Price = 900000000,
            PurchaseID = 3401534430,
            DisplayInShop = true,
            ShowOdds = true,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 13 Times",
            LayoutOrder = 70,
            ItemType = "Seed",
            Stack = 1,
            ShopIndex = 1,
            Description = "",
            FallbackPrice = 719,
            StockAmount = { 1, 1 },

            CanBuy = function(p13, p14) -- Line: 181, Name: CanBuy
                return true;
            end
        },
        ["Maple Resin"] = {
            SeedName = "Maple Resin",
            SeedRarity = "Transcendent",
            StockChance = 60,
            Price = 1500000000,
            PurchaseID = 3401534643,
            DisplayInShop = true,
            ShowOdds = true,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 17 Times",
            LayoutOrder = 80,
            ItemType = "Seed",
            Stack = 1,
            ShopIndex = 1,
            Description = "",
            FallbackPrice = 999,
            StockAmount = { 1, 1 },

            CanBuy = function(p15, p16) -- Line: 202, Name: CanBuy
                return true;
            end
        }
    },
    PetShopConfig = {
        SHOP_RESET_TIME = 900,
        SHOP_UI_NAME = "FallMarketEventShop_UI",
        EVENT_SET = "FallMarketEvent",
        LINKED_SHOPS = {}
    },
    PetShop = {
        ["Fall Egg"] = {
            SeedName = "Fall Egg",
            SeedRarity = "Mythical",
            StockChance = 1,
            Price = 90000000,
            PurchaseID = 3401534851,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 10,
            ItemType = "Egg",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 149,
            StockAmount = { 1, 1 }
        },
        ["Scarf Crow"] = {
            SeedName = "Scarf Crow",
            SeedRarity = "Common",
            StockChance = 2,
            Price = 100000000,
            PurchaseID = 3716150681,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 15,
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 299,
            StockAmount = { 1, 1 }
        },
        Chipmunk = {
            SeedName = "Chipmunk",
            SeedRarity = "Common",
            StockChance = 3,
            Price = 150000000,
            PurchaseID = 3401548923,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 20,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 4 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 299,
            StockAmount = { 1, 1 }
        },
        ["Red Squirrel"] = {
            SeedName = "Red Squirrel",
            SeedRarity = "Rare",
            StockChance = 6,
            Price = 400000000,
            PurchaseID = 3401549019,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 30,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 7 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 219,
            StockAmount = { 1, 1 }
        },
        Salmon = {
            SeedName = "Salmon",
            SeedRarity = "Uncommon",
            StockChance = 6,
            Price = 50000000,
            PurchaseID = 3408412072,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 40,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 9 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 219,
            StockAmount = { 1, 1 }
        },
        Marmot = {
            SeedName = "Marmot",
            SeedRarity = "Legendary",
            StockChance = 12,
            Price = 700000000,
            PurchaseID = 3401537209,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 50,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 10 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 459,
            StockAmount = { 1, 1 }
        },
        ["Sugar Glider"] = {
            SeedName = "Sugar Glider",
            SeedRarity = "Mythical",
            StockChance = 24,
            Price = 900000000,
            PurchaseID = 3401537342,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 60,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 13 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 568,
            StockAmount = { 1, 1 }
        },
        Woodpecker = {
            SeedName = "Woodpecker",
            SeedRarity = "Rare",
            StockChance = 8,
            Price = 400000000,
            PurchaseID = 3408412411,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 70,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 15 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 309,
            StockAmount = { 1, 1 }
        },
        ["Space Squirrel"] = {
            SeedName = "Space Squirrel",
            SeedRarity = "Divine",
            StockChance = 50,
            Price = 1250000000,
            PurchaseID = 3401549137,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 80,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 17 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 659,
            StockAmount = { 1, 1 }
        },
        Mallard = {
            SeedName = "Mallard",
            SeedRarity = "Legendary",
            StockChance = 14,
            Price = 700000000,
            PurchaseID = 3408413042,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 90,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 40 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 479,
            StockAmount = { 1, 1 }
        },
        ["Red Panda"] = {
            SeedName = "Red Panda",
            SeedRarity = "Divine",
            StockChance = 60,
            Price = 1250000000,
            PurchaseID = 3408413280,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 100,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 50 Times",
            ItemType = "Pet",
            Stack = 1,
            Description = "",
            ShopIndex = 3,
            FallbackPrice = 629,
            StockAmount = { 1, 1 }
        }
    },
    GearShopConfig = {
        SHOP_RESET_TIME = 900,
        SHOP_UI_NAME = "FallMarketEventShop_UI",
        EVENT_SET = "FallMarketEvent",
        LINKED_SHOPS = {}
    },
    GearShop = {
        ["Firefly Jar"] = {
            SeedName = "Firefly Jar",
            SeedRarity = "Common",
            StockChance = 1,
            Price = 500000,
            PurchaseID = 3401535051,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 10,
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 37,
            StockAmount = { 5, 8 },

            CanBuy = function(p17, p18) -- Line: 434, Name: CanBuy
                return true;
            end
        },
        ["Sky Lantern"] = {
            SeedName = "Sky Lantern",
            SeedRarity = "Uncommon",
            StockChance = 1,
            Price = 1000000,
            PurchaseID = 3401535228,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 20,
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 39,
            StockAmount = { 2, 4 },

            CanBuy = function(p19, p20) -- Line: 453, Name: CanBuy
                return true;
            end
        },
        ["Maple Leaf Kite"] = {
            SeedName = "Maple Leaf Kite",
            SeedRarity = "Uncommon",
            StockChance = 2,
            Price = 15000000,
            PurchaseID = 3401535375,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 30,
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 49,
            StockAmount = { 1, 3 },

            CanBuy = function(p21, p22) -- Line: 472, Name: CanBuy
                return true;
            end
        },
        ["Leaf Blower"] = {
            SeedName = "Leaf Blower",
            SeedRarity = "Rare",
            StockChance = 3,
            Price = 35000000,
            PurchaseID = 3401535500,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 40,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 2 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 89,
            StockAmount = { 1, 3 },

            CanBuy = function(p23, p24) -- Line: 493, Name: CanBuy
                return true;
            end
        },
        ["Maple Syrup"] = {
            SeedName = "Maple Syrup",
            SeedRarity = "Rare",
            StockChance = 1,
            Price = 50000000,
            PurchaseID = 3401535642,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 50,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 5 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 39,
            StockAmount = { 2, 4 },

            CanBuy = function(p25, p26) -- Line: 514, Name: CanBuy
                return true;
            end
        },
        ["Maple Sprinkler"] = {
            SeedName = "Maple Sprinkler",
            SeedRarity = "Legendary",
            StockChance = 5,
            Price = 250000000,
            PurchaseID = 3401535950,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 60,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 9 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 189,
            StockAmount = { 1, 1 },

            CanBuy = function(p27, p28) -- Line: 535, Name: CanBuy
                return true;
            end
        },
        Bonfire = {
            SeedName = "Bonfire",
            SeedRarity = "Mythical",
            StockChance = 8,
            Price = 500000000,
            PurchaseID = 3401536118,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 70,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 10 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 259,
            StockAmount = { 1, 1 },

            CanBuy = function(p29, p30) -- Line: 556, Name: CanBuy
                return true;
            end
        },
        ["Harvest Basket"] = {
            SeedName = "Harvest Basket",
            SeedRarity = "Divine",
            StockChance = 15,
            Price = 750000000,
            PurchaseID = 3401536271,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 80,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 12 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 67,
            StockAmount = { 1, 1 },

            CanBuy = function(p31, p32) -- Line: 577, Name: CanBuy
                return true;
            end
        },
        ["Maple Leaf Charm"] = {
            SeedName = "Maple Leaf Charm",
            SeedRarity = "Divine",
            StockChance = 25,
            Price = 100000000,
            PurchaseID = 3401535789,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 90,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 13 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 195,
            StockAmount = { 1, 1 },

            CanBuy = function(p33, p34) -- Line: 598, Name: CanBuy
                return true;
            end
        },
        ["Golden Acorn"] = {
            SeedName = "Golden Acorn",
            SeedRarity = "Prismatic",
            StockChance = 40,
            Price = 10000000000,
            PurchaseID = 3401536371,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 100,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 17 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 239,
            StockAmount = { 1, 1 },

            CanBuy = function(p35, p36) -- Line: 619, Name: CanBuy
                return true;
            end
        },
        Rake = {
            SeedName = "Rake",
            SeedRarity = "Mythical",
            StockChance = 1,
            Price = 10000000,
            PurchaseID = 3408411084,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 110,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 20 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 68,
            StockAmount = { 1, 5 },

            CanBuy = function(p37, p38) -- Line: 640, Name: CanBuy
                return true;
            end
        },
        ["Acorn Bell"] = {
            SeedName = "Acorn Bell",
            SeedRarity = "Legendary",
            StockChance = 5,
            Price = 25000000,
            PurchaseID = 3408411429,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 120,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 23 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 65,
            StockAmount = { 1, 1 },

            CanBuy = function(p39, p40) -- Line: 661, Name: CanBuy
                return true;
            end
        },
        ["Acorn Lollipop"] = {
            SeedName = "Acorn Lollipop",
            SeedRarity = "Prismatic",
            StockChance = 30,
            Price = 100000000,
            PurchaseID = 3408411631,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 130,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 37 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 79,
            StockAmount = { 1, 1 },

            CanBuy = function(p41, p42) -- Line: 682, Name: CanBuy
                return true;
            end
        },
        ["Super Leaf Blower"] = {
            SeedName = "Super Leaf Blower",
            SeedRarity = "Mythical",
            StockChance = 10,
            Price = 50000000,
            PurchaseID = 3408416796,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 140,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 44 Times",
            ItemType = "Gear",
            Description = "",
            ShopIndex = 2,
            Stack = 1,
            FallbackPrice = 129,
            StockAmount = { 1, 2 },

            CanBuy = function(p43, p44) -- Line: 703, Name: CanBuy
                return true;
            end
        }
    },
    CosmeticShopConfig = {
        SHOP_RESET_TIME = 900,
        SHOP_UI_NAME = "FallMarketEventShop_UI",
        EVENT_SET = "FallMarketEvent",
        LINKED_SHOPS = {}
    },
    CosmeticShop = {
        ["Fall Crate"] = {
            SeedName = "Fall Crate",
            SeedRarity = "Legendary",
            StockChance = 1,
            Price = 50000000,
            PurchaseID = 3401536497,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 10,
            ItemType = "Crate",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 179,
            StockAmount = { 1, 1 }
        },
        ["Fall Leaf Chair"] = {
            SeedName = "Fall Leaf Chair",
            SeedRarity = "Common",
            StockChance = 1,
            Price = 10000000,
            PurchaseID = 3401536663,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 30,
            ItemType = "Cosmetic",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 79,
            StockAmount = { 1, 1 }
        },
        ["Maple Flag"] = {
            SeedName = "Maple Flag",
            SeedRarity = "Rare",
            StockChance = 2,
            Price = 15000000,
            PurchaseID = 3401536754,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 40,
            ItemType = "Cosmetic",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 119,
            StockAmount = { 1, 1 }
        },
        ["Fall Wreath"] = {
            SeedName = "Fall Wreath",
            SeedRarity = "Rare",
            StockChance = 4,
            Price = 2000000,
            PurchaseID = 3408414891,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 50,
            ItemType = "Cosmetic",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 105,
            StockAmount = { 1, 1 }
        },
        ["Fall Hay Bale"] = {
            SeedName = "Fall Hay Bale",
            SeedRarity = "Rare",
            StockChance = 4,
            Price = 2000000,
            PurchaseID = 3408414325,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 60,
            ItemType = "Cosmetic",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 119,
            StockAmount = { 1, 1 }
        },
        ["Pile Of Leaves"] = {
            SeedName = "Pile Of Leaves",
            SeedRarity = "Rare",
            StockChance = 4,
            Price = 2000000,
            PurchaseID = 3408415503,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 70,
            ItemType = "Cosmetic",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 89,
            StockAmount = { 1, 1 }
        },
        ["Flying Kite"] = {
            SeedName = "Flying Kite",
            SeedRarity = "Legendary",
            StockChance = 3,
            Price = 25000000,
            PurchaseID = 3401536894,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 80,
            ItemType = "Cosmetic",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 139,
            StockAmount = { 1, 1 }
        },
        ["Autumn Crate"] = {
            SeedName = "Autumn Crate",
            SeedRarity = "Legendary",
            StockChance = 1,
            Price = 10000000,
            PurchaseID = 3713349796,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 90,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 5 Times",
            ItemType = "Crate",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 179,
            StockAmount = { 1, 1 }
        },
        ["Fall Fountain"] = {
            SeedName = "Fall Fountain",
            SeedRarity = "Divine",
            StockChance = 30,
            Price = 1000000000,
            PurchaseID = 3401537019,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 100,
            LockedInShop = true,
            UnlockText = "Contribute to Fall Bloom 10 Times",
            ItemType = "Cosmetic",
            Stack = 1,
            Description = "",
            ShopIndex = 4,
            FallbackPrice = 279,
            StockAmount = { 1, 1 }
        }
    }
};