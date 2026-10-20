-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.EventShopData.EventShopTypes);

return {
    SeedShopConfig = {
        SHOP_RESET_TIME = 3600,
        SHOP_UI_NAME = "HalloweenEventShop_UI",
        EVENT_SET = "HalloweenEvent",
        RESTOCK_CURRENCY = "Sheckles",
        LINKED_SHOPS = {}
    },
    SeedShop = {
        ["Bloodred Mushroom"] = {
            SeedName = "Bloodred Mushroom",
            SeedRarity = "Uncommon",
            StockChance = 9999,
            Price = 999999999999,
            SpecialCurrencyType = "CandyCorn",
            PurchaseID = 3426534747,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 110,
            LockedInShop = false,
            ItemType = "Seed",
            Stack = 1,
            Description = "",
            FallbackPrice = 129,
            StockAmount = { 0, 0 }
        },
        Pumpkin = {
            SeedName = "Pumpkin",
            SeedRarity = "Legendary",
            StockChance = 9999,
            Price = 999999999999,
            SpecialCurrencyType = "CandyCorn",
            PurchaseID = 3248695199,
            DisplayInShop = true,
            ShowOdds = true,
            LayoutOrder = 125,
            LockedInShop = false,
            ItemType = "Seed",
            Stack = 1,
            Description = "",
            FallbackPrice = 210,
            StockAmount = { 0, 0 }
        }
    },
    PetShopConfig = {
        SHOP_RESET_TIME = 3600,
        SHOP_UI_NAME = "HalloweenEventShop_UI",
        EVENT_SET = "HalloweenEvent",
        RESTOCK_CURRENCY = "Sheckles",
        LINKED_SHOPS = {}
    },
    PetShop = {},
    GearShopConfig = {
        SHOP_RESET_TIME = 3600,
        SHOP_UI_NAME = "HalloweenEventShop_UI",
        EVENT_SET = "HalloweenEvent",
        RESTOCK_CURRENCY = "Sheckles",
        LINKED_SHOPS = {}
    },
    GearShop = {},
    CosmeticShopConfig = {
        SHOP_RESET_TIME = 3600,
        SHOP_UI_NAME = "HalloweenEventShop_UI",
        EVENT_SET = "HalloweenEvent",
        RESTOCK_CURRENCY = "Sheckles",
        LINKED_SHOPS = {}
    },
    CosmeticShop = {}
};