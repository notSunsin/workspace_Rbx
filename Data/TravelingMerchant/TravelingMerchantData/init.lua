-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");

return {
    ["Sky Traveling Merchant"] = {
        Title = "Sky",
        AppearanceChance = 4,
        Duration = 1800,
        ShopData = require(script.SkyMerchantShopData)
    },
    ["Gnome Traveling Merchant"] = {
        Title = "Gnome",
        AppearanceChance = 3,
        Duration = 1800,
        ShopData = require(script.GnomeMerchantShopData)
    },
    ["Honey Traveling Merchant"] = {
        Title = "Honey",
        AppearanceChance = -1,
        Duration = 1800,
        ShopData = require(script.HoneyMerchantShopData)
    },
    ["Summer Traveling Merchant"] = {
        Title = "Summer",
        AppearanceChance = -1,
        Duration = 1800,
        ShopData = require(script.SummerMerchantShopData)
    },
    ["Rare Cosmetic Traveling Merchant"] = {
        Title = "Rare Cosmetic",
        AppearanceChance = 2,
        Duration = 1800,
        ShopData = require(script.RareCosmeticMerchantShopData)
    },
    ["Spray Traveling Merchant"] = {
        Title = "Spray",
        AppearanceChance = -1,
        Duration = 1800,
        ShopData = require(script.SprayMerchantShopData)
    },
    ["Sprinkling Traveling Merchant"] = {
        Title = "Sprinkler",
        AppearanceChance = 4,
        Duration = 1800,
        ShopData = require(script.SprinklerMerchantShopData)
    },
    ["Fall Traveling Merchant"] = {
        Title = "Fall",
        AppearanceChance = 4,
        Duration = 1800,
        ShopData = require(script.FallMerchantShopData)
    },
    ["Safari Traveling Merchant"] = {
        Title = "Safari",
        AppearanceChance = 4,
        Duration = 1800,
        ShopData = require(script.SafariMerchantShopData)
    },
    ["Harvest Moon Traveling Merchant"] = {
        Title = "Harvest Moon",
        AppearanceChance = 4,
        Duration = 1800,
        ShopData = require(script.HarvestMoonMerchantShopData)
    },
    ["Halloween Traveling Merchant"] = {
        Title = "Halloween",
        AppearanceChance = -1,
        Duration = 86400,
        ShopData = require(script.HalloweenMerchantShopData)
    },
    ["American Traveling Merchant"] = {
        Title = "4th July",
        AppearanceChance = -1,
        Duration = 122400,
        ShopData = require(script.AmericanMerchantShopData)
    },
    ["American Traveling Merchant 2026"] = {
        Title = "4th July",
        AppearanceChance = -1,
        Duration = 172800,
        ShopData = require(script.AmericanMerchant2026ShopData)
    }
};