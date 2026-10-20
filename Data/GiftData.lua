-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Item_Module = require(ReplicatedStorage.Item_Module);
local GearShopData = require(ReplicatedStorage.Data.GearShopData);
local PetEggData = require(ReplicatedStorage.Data.PetEggData);
local SummerPackData = require(ReplicatedStorage.Data.Packs.SummerPackData);
local Summer2026PackData = require(ReplicatedStorage.Data.Packs.Summer2026PackData);
local GoldenShovelPackData = require(ReplicatedStorage.Data.Packs.GoldenShovelPackData);
local SproutPackData = require(ReplicatedStorage.Data.Packs.SproutPackData);
local TwilightPackData = require(ReplicatedStorage.Data.Packs.TwilightPackData);
local MoonLimitedSeedData = require(ReplicatedStorage.Data.Packs.MoonLimitedSeedData);
local ScarletAspenLimitedSeedData = require(ReplicatedStorage.Data.Packs.ScarletAspenLimitedSeedData);
local BlacksmithBundleData = require(ReplicatedStorage.Data.Packs.BlacksmithBundleData);
local TradeTokenData = require(ReplicatedStorage.Data.TradeTokenData);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local v1 = {
    ["Open 1 - Exotic Seed Pack"] = {
        GiftId = 3269033223,
        NormalId = 3267528421,
        Display = "1 Exotic Seed Pack"
    },
    ["Open 3 - Exotic Seed Pack"] = {
        GiftId = 3269033336,
        NormalId = 3267548052,
        Display = "3 Exotic Seed Packs"
    },
    ["Open 10 - Exotic Seed Pack"] = {
        GiftId = 3269033529,
        NormalId = 3267548161,
        Display = "10 Exotic Seed Packs"
    },
    ["Open 1 - Bug Egg"] = {
        GiftId = 3277815193,
        NormalId = 3278426597,
        Display = "1 Bug Egg"
    },
    ["Open 3 - Bug Egg"] = {
        GiftId = 3277815350,
        NormalId = 3277814538,
        Display = "3 Bug Eggs"
    },
    ["Open 10 - Bug Egg"] = {
        GiftId = 3277815654,
        NormalId = 3277814625,
        Display = "10 Bug Eggs"
    },
    ["10 Premium Seed Sacks"] = {
        GiftId = 3273679009,
        NormalId = 3273679012,
        Display = "10 Premium Seed Sacks"
    },
    ["10 Premium Night Seeds"] = {
        GiftId = 3282733014,
        NormalId = 3282157462,
        Display = "10 Premium Night Seeds"
    },
    ["10 Premium Night Eggs"] = {
        GiftId = 3282661439,
        NormalId = 3282157312,
        Display = "10 Premium Night Eggs"
    },
    ["+1 Exclusive Cosmetic Crate"] = {
        GiftId = 3290672926,
        NormalId = 3290672626,
        Display = "1 Exclusive Cosmetic Crate"
    },
    ["+3 Exclusive Cosmetic Crates"] = {
        GiftId = 3290673007,
        NormalId = 3290672712,
        Display = "3 Exclusive Cosmetic Crates"
    },
    ["+10 Exclusive Cosmetic Crates"] = {
        GiftId = 3290673073,
        NormalId = 3290672848,
        Display = "10 Exclusive Cosmetic Crates"
    },
    ["+1 Exotic Flower Seed Pack"] = {
        GiftId = 3295548788,
        NormalId = 3295548770,
        Display = "1 Exotic Flower Seed Pack"
    },
    ["+3 Exotic Flower Seed Pack"] = {
        GiftId = 3295548780,
        NormalId = 3295548782,
        Display = "3 Exotic Flower Seed Packs"
    },
    ["+10 Exotic Flower Seed Pack"] = {
        GiftId = 3295548784,
        NormalId = 3295548781,
        Display = "10 Exotic Flower Seed Packs"
    },
    ["+1 Exotic Crafters Seed Pack"] = {
        GiftId = 3306352285,
        NormalId = 3306352279,
        Display = "1 Exotic Crafters Seed Pack"
    },
    ["+3 Exotic Crafters Seed Pack"] = {
        GiftId = 3306352286,
        NormalId = 3306352283,
        Display = "3 Exotic Crafters Seed Packs"
    },
    ["+10 Exotic Crafters Seed Pack"] = {
        GiftId = 3306352287,
        NormalId = 3306352284,
        Display = "10 Exotic Crafters Seed Packs"
    },
    ["+1 Exotic Summer Seed Pack"] = {
        GiftId = 3311388950,
        NormalId = 3311388942,
        Display = "1 Exotic Summer Seed Pack"
    },
    ["+3 Exotic Summer Seed Pack"] = {
        GiftId = 3311388953,
        NormalId = 3311388951,
        Display = "3 Exotic Summer Seed Packs"
    },
    ["+10 Exotic Summer Seed Pack"] = {
        GiftId = 3311388949,
        NormalId = 3311388948,
        Display = "10 Exotic Summer Seed Packs"
    },
    ["+1 Exotic Ancient Seed Pack"] = {
        GiftId = 3323657555,
        NormalId = 3323657553,
        Display = "1 Exotic Ancient Seed Pack"
    },
    ["+3 Exotic Ancient Seed Pack"] = {
        GiftId = 3323657556,
        NormalId = 3323657547,
        Display = "3 Exotic Ancient Seed Packs"
    },
    ["+10 Exotic Ancient Seed Pack"] = {
        GiftId = 3323657554,
        NormalId = 3323657552,
        Display = "10 Exotic Ancient Seed Packs"
    },
    ["+1 Exotic Zen Seed Pack"] = {
        GiftId = 3338826788,
        NormalId = 3338826792,
        Display = "1 Exotic Zen Seed Pack"
    },
    ["+3 Exotic Zen Seed Pack"] = {
        GiftId = 3338826794,
        NormalId = 3338826791,
        Display = "3 Exotic Zen Seed Packs"
    },
    ["+10 Exotic Zen Seed Pack"] = {
        GiftId = 3338826793,
        NormalId = 3338826790,
        Display = "10 Exotic Zen Seed Packs"
    },
    ["+1 Exotic Gourmet Seed Pack"] = {
        GiftId = 3354839820,
        NormalId = 3354839803,
        Display = "1 Exotic Gourmet Seed Pack"
    },
    ["+3 Exotic Gourmet Seed Packs"] = {
        GiftId = 3354839819,
        NormalId = 3354839826,
        Display = "3 Exotic Gourmet Seed Packs"
    },
    ["+10 Exotic Gourmet Seed Packs"] = {
        GiftId = 3354839818,
        NormalId = 3354839817,
        Display = "10 Exotic Gourmet Seed Packs"
    },
    ["+1 Exotic Sprout Seed Pack"] = {
        GiftId = 3371226361,
        NormalId = 3371226353,
        Display = "1 Exotic Sprout Seed Pack"
    },
    ["+3 Exotic Sprout Seed Packs"] = {
        GiftId = 3371226362,
        NormalId = 3371226360,
        Display = "3 Exotic Sprout Seed Packs"
    },
    ["+10 Exotic Sprout Seed Packs"] = {
        GiftId = 3371226364,
        NormalId = 3371226363,
        Display = "10 Exotic Sprout Seed Packs"
    },
    ["+1 Exotic Enchanted Seed Pack"] = {
        GiftId = 3387753639,
        NormalId = 3387753641,
        Display = "1 Exotic Enchanted Seed Pack"
    },
    ["+3 Exotic Enchanted Seed Packs"] = {
        GiftId = 3387753637,
        NormalId = 3387753634,
        Display = "3 Exotic Enchanted Seed Packs"
    },
    ["+10 Exotic Enchanted Seed Packs"] = {
        GiftId = 3387753640,
        NormalId = 3387753638,
        Display = "10 Exotic Enchanted Seed Packs"
    },
    ["+1 Exotic Fall Seed Pack"] = {
        GiftId = 3407391673,
        NormalId = 3407391662,
        Display = "1 Exotic Fall Seed Pack"
    },
    ["+3 Exotic Fall Seed Packs"] = {
        GiftId = 3407391664,
        NormalId = 3407391663,
        Display = "3 Exotic Fall Seed Packs"
    },
    ["+10 Exotic Fall Seed Packs"] = {
        GiftId = 3407391665,
        NormalId = 3407391666,
        Display = "10 Exotic Fall Seed Packs"
    },
    ["+1 Exotic Safari Seed Pack"] = {
        GiftId = 3449810468,
        NormalId = 3449810469,
        Display = "1 Exotic Safari Seed Pack"
    },
    ["+3 Exotic Safari Seed Packs"] = {
        GiftId = 3449810470,
        NormalId = 3449810472,
        Display = "3 Exotic Safari Seed Packs"
    },
    ["+10 Exotic Safari Seed Packs"] = {
        GiftId = 3449810473,
        NormalId = 3449810471,
        Display = "10 Exotic Safari Seed Packs"
    },
    ["+1 Exotic Culinarian Chests"] = {
        GiftId = 3362680913,
        NormalId = 3362680911,
        Display = "1 Exotic Culinarian Chests"
    },
    ["+3 Exotic Culinarian Chests"] = {
        GiftId = 3362680919,
        NormalId = 3362680917,
        Display = "3 Exotic Culinarian Chests"
    },
    ["+10 Exotic Culinarian Chests"] = {
        GiftId = 3362680914,
        NormalId = 3362680916,
        Display = "10 Exotic Culinarian Chests"
    },
    ["+1 Exotic Kitsune Chest"] = {
        GiftId = 3345819471,
        NormalId = 3345819463,
        Display = "1 Exotic Kitsune Chest"
    },
    ["+3 Exotic Kitsune Chests"] = {
        GiftId = 3345819477,
        NormalId = 3345819470,
        Display = "3 Exotic Kitsune Chests"
    },
    ["+10 Exotic Kitsune Chests"] = {
        GiftId = 3345819473,
        NormalId = 3345819472,
        Display = "10 Exotic Kitsune Chests"
    },
    ["+1 Exotic Skyroot Chest"] = {
        GiftId = 3379038160,
        NormalId = 3379038157,
        Display = "1 Exotic Skyroot Chest"
    },
    ["+3 Exotic Skyroot Chests"] = {
        GiftId = 3379038158,
        NormalId = 3379038152,
        Display = "3 Exotic Skyroot Chests"
    },
    ["+10 Exotic Skyroot Chests"] = {
        GiftId = 3379038166,
        NormalId = 3379038159,
        Display = "10 Exotic Skyroot Chests"
    },
    ["+1 Exotic Enchanted Chest"] = {
        GiftId = 3394224240,
        NormalId = 3394224231,
        Display = "1 Exotic Enchanted Chest"
    },
    ["+3 Exotic Enchanted Chests"] = {
        GiftId = 3394224238,
        NormalId = 3394224239,
        Display = "3 Exotic Enchanted Chests"
    },
    ["+10 Exotic Enchanted Chests"] = {
        GiftId = 3394224256,
        NormalId = 3394224237,
        Display = "10 Exotic Enchanted Chests"
    },
    ["+1 Exotic Nutty Chest"] = {
        GiftId = 3420021048,
        NormalId = 3420021045,
        Display = "1 Exotic Nutty Chest"
    },
    ["+3 Exotic Nutty Chests"] = {
        GiftId = 3420021049,
        NormalId = 3420021043,
        Display = "3 Exotic Nutty Chests"
    },
    ["+10 Exotic Nutty Chests"] = {
        GiftId = 3420021050,
        NormalId = 3420021044,
        Display = "10 Exotic Nutty Chests"
    },
    ["+1 Exotic Spooky Chest"] = {
        GiftId = 3438653515,
        NormalId = 3438653519,
        Display = "1 Exotic Spooky Chest"
    },
    ["+3 Exotic Spooky Chests"] = {
        GiftId = 3438653520,
        NormalId = 3438653518,
        Display = "3 Exotic Spooky Chests"
    },
    ["+10 Exotic Spooky Chests"] = {
        GiftId = 3438653521,
        NormalId = 3438653517,
        Display = "10 Exotic Spooky Chests"
    },
    ["+1 Exotic Gem Chest"] = {
        GiftId = 3460600738,
        NormalId = 3460600740,
        Display = "1 Exotic Gem Chest"
    },
    ["+3 Exotic Gem Chests"] = {
        GiftId = 3460600739,
        NormalId = 3460600737,
        Display = "3 Exotic Gem Chests"
    },
    ["+10 Exotic Gem Chests"] = {
        GiftId = 3460600741,
        NormalId = 3460600736,
        Display = "10 Exotic Gem Chests"
    },
    ["+1 Exotic Buttercup Chest"] = {
        GiftId = 3520430333,
        NormalId = 3520430329,
        Display = "1 Exotic Buttercup Chest"
    },
    ["+3 Exotic Buttercup Chests"] = {
        GiftId = 3520430330,
        NormalId = 3520430327,
        Display = "3 Exotic Buttercup Chests"
    },
    ["+10 Exotic Buttercup Chests"] = {
        GiftId = 3520430332,
        NormalId = 3520430328,
        Display = "10 Exotic Buttercup Chests"
    },
    ["+50 Exotic Buttercup Chests"] = {
        GiftId = 3520430334,
        NormalId = 3520430331,
        Display = "50 Exotic Buttercup Chests"
    },
    ["+1 Iconic Gonme Crate"] = {
        GiftId = 3300962951,
        NormalId = 3300962946,
        Display = "1 Iconic Gonme Crate"
    },
    ["+3 Iconic Gonme Crate"] = {
        GiftId = 3300962954,
        NormalId = 3300962950,
        Display = "3 Iconic Gonme Crate"
    },
    ["+10 Iconic Gonme Crate"] = {
        GiftId = 3300962960,
        NormalId = 3300962952,
        Display = "10 Iconic Gonme Crate"
    },
    ["+1 Premium Anti Bee Egg"] = {
        GiftId = 3301567956,
        NormalId = 3301567958,
        Display = "1 Premium Anti Bee Egg"
    },
    ["+3 Premium Anti Bee Egg"] = {
        GiftId = 3301567959,
        NormalId = 3301567955,
        Display = "3 Premium Anti Bee Egg"
    },
    ["+10 Premium Anti Bee Egg"] = {
        GiftId = 3301567957,
        NormalId = 3301567960,
        Display = "10 Premium Anti Bee Egg"
    },
    ["+1 Premium Oasis Egg"] = {
        GiftId = 3317459189,
        NormalId = 3317459182,
        Display = "1 Premium Oasis Egg"
    },
    ["+3 Premium Oasis Egg"] = {
        GiftId = 3317459185,
        NormalId = 3317459186,
        Display = "3 Premium Oasis Egg"
    },
    ["+10 Premium Oasis Egg"] = {
        GiftId = 3317459187,
        NormalId = 3317459188,
        Display = "10 Premium Oasis Egg"
    },
    ["+1 Premium Primal Egg"] = {
        GiftId = 3330286152,
        NormalId = 3330286154,
        Display = "1 Premium Primal Egg"
    },
    ["+3 Premium Primal Egg"] = {
        GiftId = 3330286153,
        NormalId = 3330286155,
        Display = "3 Premium Primal Egg"
    },
    ["+10 Premium Primal Egg"] = {
        GiftId = 3330286160,
        NormalId = 3330286148,
        Display = "10 Premium Primal Egg"
    },
    ["+1 Premium Fall Egg"] = {
        GiftId = 3401426986,
        NormalId = 3401426983,
        Display = "1 Premium Fall Egg"
    },
    ["+3 Premium Fall Eggs"] = {
        GiftId = 3401426987,
        NormalId = 3401426985,
        Display = "3 Premium Fall Eggs"
    },
    ["+10 Premium Fall Eggs"] = {
        GiftId = 3401426988,
        NormalId = 3401426984,
        Display = "10 Premium Fall Eggs"
    },
    ["+1 Premium Spooky Egg"] = {
        GiftId = 3427163851,
        NormalId = 3427163857,
        Display = "1 Premium Spooky Egg"
    },
    ["+3 Premium Spooky Eggs"] = {
        GiftId = 3427163855,
        NormalId = 3427163854,
        Display = "3 Premium Spooky Eggs"
    },
    ["+10 Premium Spooky Eggs"] = {
        GiftId = 3427163856,
        NormalId = 3427163853,
        Display = "10 Premium Spooky Eggs"
    },
    ["+1 Premium Safari Egg"] = {
        GiftId = 3444449490,
        NormalId = 3444449487,
        Display = "1 Premium Safari Egg"
    },
    ["+3 Premium Safari Eggs"] = {
        GiftId = 3444449488,
        NormalId = 3444449485,
        Display = "3 Premium Safari Eggs"
    },
    ["+10 Premium Safari Eggs"] = {
        GiftId = 3444449489,
        NormalId = 3444449486,
        Display = "10 Premium Safari Eggs"
    },
    ["+1 Premium Christmas Egg"] = {
        GiftId = 3477922694,
        NormalId = 3477922698,
        Display = "1 Premium Christmas Egg"
    },
    ["+3 Premium Christmas Eggs"] = {
        GiftId = 3477922696,
        NormalId = 3477922697,
        Display = "3 Premium Christmas Eggs"
    },
    ["+10 Premium Christmas Eggs"] = {
        GiftId = 3477922699,
        NormalId = 3477922700,
        Display = "10 Premium Christmas Eggs"
    },
    ["+50 Premium Christmas Eggs"] = {
        GiftId = 3478044311,
        NormalId = 3478043835,
        Display = "50 Premium Christmas Eggs"
    },
    ["+1 Premium Winter Egg"] = {
        GiftId = 3483801742,
        NormalId = 3483801741,
        Display = "1 Premium Winter Egg"
    },
    ["+3 Premium Winter Eggs"] = {
        GiftId = 3483801746,
        NormalId = 3483801745,
        Display = "3 Premium Winter Eggs"
    },
    ["+10 Premium Winter Eggs"] = {
        GiftId = 3483801749,
        NormalId = 3483801744,
        Display = "10 Premium Winter Eggs"
    },
    ["+50 Premium Winter Eggs"] = {
        GiftId = 3483801747,
        NormalId = 3483801743,
        Display = "50 Premium Winter Eggs"
    },
    ["+1 Premium New Year\'s Egg"] = {
        GiftId = 3489363340,
        NormalId = 3489363343,
        Display = "1 Premium New Year\'s Egg"
    },
    ["+3 Premium New Year\'s Eggs"] = {
        GiftId = 3489363337,
        NormalId = 3489363338,
        Display = "3 Premium New Year\'s Eggs"
    },
    ["+10 Premium New Year\'s Eggs"] = {
        GiftId = 3489363341,
        NormalId = 3489363342,
        Display = "10 Premium New Year\'s Eggs"
    },
    ["+50 Premium New Year\'s Eggs"] = {
        GiftId = 3489363345,
        NormalId = 3489363344,
        Display = "50 Premium New Year\'s Eggs"
    },
    ["+1 Premium Carnival Egg"] = {
        GiftId = 3497475841,
        NormalId = 3497475839,
        Display = "1 Premium Carnival Egg"
    },
    ["+3 Premium Carnival Eggs"] = {
        GiftId = 3497475845,
        NormalId = 3497475846,
        Display = "3 Premium Carnival Eggs"
    },
    ["+10 Premium Carnival Eggs"] = {
        GiftId = 3497475840,
        NormalId = 3497475844,
        Display = "10 Premium Carnival Eggs"
    },
    ["+50 Premium Carnival Eggs"] = {
        GiftId = 3497475842,
        NormalId = 3497475843,
        Display = "50 Premium Carnival Eggs"
    },
    ["+1 Premium Bird Egg"] = {
        GiftId = 3512151974,
        NormalId = 3512151971,
        Display = "1 Premium Bird Egg"
    },
    ["+3 Premium Bird Eggs"] = {
        GiftId = 3512151972,
        NormalId = 3512151973,
        Display = "3 Premium Bird Eggs"
    },
    ["+10 Premium Bird Eggs"] = {
        GiftId = 3512151975,
        NormalId = 3512151976,
        Display = "10 Premium Bird Eggs"
    },
    ["+50 Premium Birdl Eggs"] = {
        GiftId = 3512151981,
        NormalId = 3512151977,
        Display = "50 Premium Bird Eggs"
    },
    ["+1 Premium Golden Egg"] = {
        GiftId = 3568827750,
        NormalId = 3568827015,
        Display = "1 Premium Golden Egg"
    },
    ["+3 Premium Golden Eggs"] = {
        GiftId = 3568828285,
        NormalId = 3568827227,
        Display = "3 Premium Golden Eggs"
    },
    ["+10 Premium Golden Eggs"] = {
        GiftId = 3568828441,
        NormalId = 3568827595,
        Display = "10 Premium Golden Eggs"
    },
    ["+50 Premium Golden Eggs"] = {
        GiftId = 3570157336,
        NormalId = 3570157250,
        Display = "50 Premium Golden Eggs"
    },
    ["+1 Premium Springtide Egg"] = {
        GiftId = 3576525092,
        NormalId = 3576524674,
        Display = "1 Premium Springtide Egg"
    },
    ["+3 Premium Springtide Egg"] = {
        GiftId = 3576525196,
        NormalId = 3576524780,
        Display = "3 Premium Springtide Egg"
    },
    ["+10 Premium Springtide Egg"] = {
        GiftId = 3576525248,
        NormalId = 3576524860,
        Display = "10 Premium Springtide Egg"
    },
    ["+50 Premium Springtide Egg"] = {
        GiftId = 3576525311,
        NormalId = 3576525035,
        Display = "50 Premium Springtide Egg"
    },
    ["+1 Premium Hive Egg"] = {
        GiftId = 3584036934,
        NormalId = 3584036637,
        Display = "1 Premium Hive Egg"
    },
    ["+3 Premium Hive Egg"] = {
        GiftId = 3584037008,
        NormalId = 3584036735,
        Display = "3 Premium Hive Egg"
    },
    ["+10 Premium Hive Egg"] = {
        GiftId = 3584037083,
        NormalId = 3584036839,
        Display = "10 Premium Hive Egg"
    },
    ["+50 Premium Hive Egg"] = {
        GiftId = 3587190724,
        NormalId = 3587190661,
        Display = "50 Premium Hive Egg"
    },
    ["+1 Exotic Hive Seed Pack"] = {
        GiftId = 3588293395,
        NormalId = 3588292639,
        Display = "1 Exotic Hive Seed Pack"
    },
    ["+3 Exotic Hive Seed Pack"] = {
        GiftId = 3588293465,
        NormalId = 3588293165,
        Display = "3 Exotic Hive Seed Packs"
    },
    ["+10 Exotic Hive Seed Pack"] = {
        GiftId = 3588293540,
        NormalId = 3588293244,
        Display = "10 Exotic Hive Seed Packs"
    },
    ["+50 Exotic Hive Seed Pack"] = {
        GiftId = 3588293629,
        NormalId = 3588293328,
        Display = "50 Exotic Hive Seed Packs"
    },
    ["+1 Premium Campfire Egg"] = {
        GiftId = 3602506154,
        NormalId = 3602505965,
        Display = "+1 Premium Campfire Egg"
    },
    ["+3 Premium Campfire Egg"] = {
        GiftId = 3602506203,
        NormalId = 3602506028,
        Display = "+3 Premium Campfire Eggs"
    },
    ["+10 Premium Campfire Egg"] = {
        GiftId = 3602506392,
        NormalId = 3602506064,
        Display = "+10 Premium Campfire Eggs"
    },
    ["+50 Premium Campfire Egg"] = {
        GiftId = 3602506446,
        NormalId = 3602506115,
        Display = "+50 Premium Campfire Eggs"
    },
    ["+1 Exotic Campfire Seed Pack"] = {
        GiftId = 3603830106,
        NormalId = 3603829987,
        Display = "1 Exotic Campfire Seed Pack"
    },
    ["+3 Exotic Campfire Seed Pack"] = {
        GiftId = 3603830134,
        NormalId = 3603830024,
        Display = "3 Exotic Campfire Seed Pack"
    },
    ["+10 Exotic Campfire Seed Pack"] = {
        GiftId = 3603830161,
        NormalId = 3603830055,
        Display = "10 Exotic Campfire Seed Pack"
    },
    ["+50 Exotic Campfire Seed Pack"] = {
        GiftId = 3603830195,
        NormalId = 3603830077,
        Display = "50 Exotic Campfire Seed Pack"
    },
    ["+1 Premium Coastal Egg"] = {
        GiftId = 3607717806,
        NormalId = 3607717721,
        Display = "+1 Premium Coastal Egg"
    },
    ["+3 Premium Coastal Egg"] = {
        GiftId = 3607717835,
        NormalId = 3607717736,
        Display = "+3 Premium Coastal Eggs"
    },
    ["+10 Premium Coastal Egg"] = {
        GiftId = 3607717860,
        NormalId = 3607717758,
        Display = "+10 Premium Coastal Eggs"
    },
    ["+50 Premium Coastal Egg"] = {
        GiftId = 3607717887,
        NormalId = 3607717778,
        Display = "+50 Premium Coastal Eggs"
    },
    ["+1 Exotic Coastal Seed Pack"] = {
        GiftId = 3608858929,
        NormalId = 3608858826,
        Display = "+1 Exotic Coastal Seed Pack"
    },
    ["+3 Exotic Coastal Seed Pack"] = {
        GiftId = 3608858947,
        NormalId = 3608858860,
        Display = "+3 Exotic Coastal Seed Packs"
    },
    ["+10 Exotic Coastal Seed Pack"] = {
        GiftId = 3608858978,
        NormalId = 3608858882,
        Display = "+10 Exotic Coastal Seed Packs"
    },
    ["+50 Exotic Coastal Seed Pack"] = {
        GiftId = 3608859002,
        NormalId = 3608858906,
        Display = "+50 Exotic Coastal Seed Packs"
    },
    ["+1 Coastal Container"] = {
        GiftId = 3611262650,
        NormalId = 3611262564,
        Display = "+1 Coastal Container"
    },
    ["+3 Coastal Container"] = {
        GiftId = 3611262667,
        NormalId = 3611262600,
        Display = "+3 Coastal Containers"
    },
    ["+10 Coastal Container"] = {
        GiftId = 3611262688,
        NormalId = 3611262627,
        Display = "+10 Coastal Containers"
    },
    ["+1 Premium Moon Egg"] = {
        GiftId = 3612305899,
        NormalId = 3612305749,
        Display = "+1 Premium Moon Egg"
    },
    ["+3 Premium Moon Eggs"] = {
        GiftId = 3612305932,
        NormalId = 3612305786,
        Display = "+3 Premium Moon Eggs"
    },
    ["+10 Premium Moon Eggs"] = {
        GiftId = 3612305959,
        NormalId = 3612305812,
        Display = "+10 Premium Moon Eggs"
    },
    ["+50 Premium Moon Eggs"] = {
        GiftId = 3612305981,
        NormalId = 3612305842,
        Display = "+50 Premium Moon Eggs"
    },
    ["+1 Exotic Moon Chest"] = {
        GiftId = 3625643815,
        NormalId = 3625639161,
        Display = "+1 Exotic Moon Chest"
    },
    ["+3 Exotic Moon Chests"] = {
        GiftId = 3625646165,
        NormalId = 3625640337,
        Display = "+3 Exotic Moon Chests"
    },
    ["+10 Exotic Moon Chests"] = {
        GiftId = 3625647334,
        NormalId = 3625641435,
        Display = "+10 Exotic Moon Chests"
    },
    ["+50 Exotic Moon Chests"] = {
        GiftId = 3625650074,
        NormalId = 3625642643,
        Display = "+50 Exotic Moon Chests"
    },
    ["+1 Premium Beanpod Egg"] = {
        GiftId = 3709891434,
        NormalId = 3709891366,
        Display = "+1 Premium Beanpod Egg"
    },
    ["+3 Premium Beanpod Eggs"] = {
        GiftId = 3709891454,
        NormalId = 3709891385,
        Display = "+3 Premium Beanpod Eggs"
    },
    ["+10 Premium Beanpod Eggs"] = {
        GiftId = 3709891474,
        NormalId = 3709891407,
        Display = "+10 Premium Beanpod Eggs"
    },
    ["+50 Premium Beanpod Eggs"] = {
        GiftId = 3709891499,
        NormalId = 3709891420,
        Display = "+50 Premium Beanpod Eggs"
    },
    ["+1 Exotic Beanpod Chest"] = {
        GiftId = 3711038487,
        NormalId = 3711038375,
        Display = "+1 Exotic Beanpod Chest"
    },
    ["+3 Exotic Beanpod Chests"] = {
        GiftId = 3711038498,
        NormalId = 3711038401,
        Display = "+3 Exotic Beanpod Chests"
    },
    ["+10 Exotic Beanpod Chests"] = {
        GiftId = 3711038514,
        NormalId = 3711038424,
        Display = "+10 Exotic Beanpod Chests"
    },
    ["+50 Exotic Beanpod Chests"] = {
        GiftId = 3711038536,
        NormalId = 3711038455,
        Display = "+50 Exotic Beanpod Chests"
    },
    ["+1 Exotic Autumn Seed Pack"] = {
        GiftId = 3713317780,
        NormalId = 3713317675,
        Display = "+1 Exotic Autumn Seed Pack"
    },
    ["+3 Exotic Autumn Seed Pack"] = {
        GiftId = 3713317802,
        NormalId = 3713317715,
        Display = "+3 Exotic Autumn Seed Packs"
    },
    ["+10 Exotic Autumn Seed Pack"] = {
        GiftId = 3713317825,
        NormalId = 3713317737,
        Display = "+10 Exotic Autumn Seed Packs"
    },
    ["+50 Exotic Autumn Seed Pack"] = {
        GiftId = 3713317849,
        NormalId = 3713317757,
        Display = "+50 Exotic Autumn Seed Packs"
    },
    ["+1 Premium Autumn Egg"] = {
        GiftId = 3714396065,
        NormalId = 3714395739,
        Display = "+1 Premium Autumn Egg"
    },
    ["+3 Premium Autumn Egg"] = {
        GiftId = 3714396129,
        NormalId = 3714395815,
        Display = "+3 Premium Autumn Eggs"
    },
    ["+10 Premium Autumn Egg"] = {
        GiftId = 3714396230,
        NormalId = 3714395899,
        Display = "+10 Premium Autumn Eggs"
    },
    ["+50 Premium Autumn Egg"] = {
        GiftId = 3714396299,
        NormalId = 3714396001,
        Display = "+50 Premium Autumn Eggs"
    },
    ["+1 Exotic Fairy Chest"] = {
        GiftId = 3717205296,
        NormalId = 3717205221,
        Display = "+1 Exotic Fairy Chest"
    },
    ["+3 Exotic Fairy Chests"] = {
        GiftId = 3717205313,
        NormalId = 3717205245,
        Display = "+3 Exotic Fairy Chests"
    },
    ["+10 Exotic Fairy Chests"] = {
        GiftId = 3717205336,
        NormalId = 3717205265,
        Display = "+10 Exotic Fairy Chests"
    },
    ["+50 Exotic Fairy Chests"] = {
        GiftId = 3717205363,
        NormalId = 3717205274,
        Display = "+50 Exotic Fairy Chests"
    },
    ["+1 Premium Haunted Egg"] = {
        GiftId = 3718827497,
        NormalId = 3718827230,
        Display = "+1 Premium Haunted Egg"
    },
    ["+3 Premium Haunted Eggs"] = {
        GiftId = 3718827540,
        NormalId = 3718827272,
        Display = "+3 Premium Haunted Eggs"
    },
    ["+10 Premium Haunted Eggs"] = {
        GiftId = 3718827727,
        NormalId = 3718827355,
        Display = "+10 Premium Haunted Eggs"
    },
    ["+50 Premium Haunted Eggs"] = {
        GiftId = 3718827768,
        NormalId = 3718827410,
        Display = "+50 Premium Haunted Eggs"
    },
    ["+10 Exotic Haunted Seed Pack"] = {
        GiftId = 3718826877,
        NormalId = 3718826777,
        Display = "+10 Exotic Haunted Seed Packs"
    },
    ["+50 Exotic Haunted Seed Pack"] = {
        GiftId = 3718826916,
        NormalId = 3718826801,
        Display = "+50 Exotic Haunted Seed Packs"
    },
    ["Trade Token 50"] = {
        GiftId = 3425758808,
        NormalId = 3460376533,
        Display = "Trade Token 50",
        ForcedRobuxPurchase = true
    },
    ["Trade Token 250"] = {
        GiftId = 3425758810,
        NormalId = 3460378135,
        Display = "Trade Token 250",
        ForcedRobuxPurchase = true
    },
    ["Trade Token 1000"] = {
        GiftId = 3425758809,
        NormalId = 3460378800,
        Display = "Trade Token 1000",
        ForcedRobuxPurchase = true
    },
    ["Trade Token 5000"] = {
        GiftId = 3425758811,
        NormalId = 3460379424,
        Display = "Trade Token 5000",
        ForcedRobuxPurchase = true
    },
    ["Trade Token 25000"] = {
        GiftId = 3425758812,
        NormalId = 3460379831,
        Display = "Trade Token 25000",
        ForcedRobuxPurchase = true
    },
    ["Sheckles 1"] = {
        GiftId = 3269363716,
        NormalId = 3250137172,
        Display = "100¢"
    },
    ["Sheckles 2"] = {
        GiftId = 3269364749,
        NormalId = 3250137261,
        Display = "250¢"
    },
    ["Sheckles 3"] = {
        GiftId = 3269364968,
        NormalId = 3250137355,
        Display = "1,000¢"
    },
    ["Sheckles 4"] = {
        GiftId = 3269365441,
        NormalId = 3250139018,
        Display = "5,000¢"
    },
    ["Summer Pack"] = {
        Display = "Summer Pack",
        GiftId = SummerPackData.GiftId,
        NormalId = SummerPackData.ProductId
    },
    ["Sprout Pack"] = {
        Display = "Sprout Pack",
        GiftId = SproutPackData.GiftId,
        NormalId = SproutPackData.ProductId
    },
    ["Blacksmith Bundle"] = {
        Display = "Blacksmith Bundle",
        GiftId = BlacksmithBundleData.GiftId,
        NormalId = BlacksmithBundleData.ProductId
    },
    ["Twilight Pack"] = {
        Display = "Twilight Pack",
        GiftId = TwilightPackData.GiftId,
        NormalId = TwilightPackData.ProductId
    },
    ["Beach Bundle"] = {
        Display = "Beach Bundle",
        GiftId = Summer2026PackData.GiftId,
        NormalId = Summer2026PackData.ProductId
    },
    ["Golden Shovel Pack"] = {
        Display = "Golden Shovel Pack",
        GiftId = GoldenShovelPackData.GiftId,
        NormalId = GoldenShovelPackData.ProductId
    },
    ["Season Pass"] = {
        Display = "Premium Pass",
        GiftId = DevProductIds.GiftSeasonPass.PurchaseID,
        NormalId = DevProductIds.BuySeasonPassPremium.PurchaseID
    },
    ["Artisan Container"] = {
        GiftId = 3467103686,
        NormalId = 3460380041,
        Display = "1 Artisan Container"
    },
    ["3 Artisan Containers"] = {
        GiftId = 3467103689,
        NormalId = 3467103688,
        Display = "3 Artisan Containers"
    },
    ["10 Artisan Containers"] = {
        GiftId = 3467103690,
        NormalId = 3467103687,
        Display = "10 Artisan Containers"
    },
    ["Elemental Container"] = {
        GiftId = 3467110139,
        NormalId = 3460380235,
        Display = "1 Elemental Container"
    },
    ["3 Elemental Containers"] = {
        GiftId = 3467110144,
        NormalId = 3467110142,
        Display = "3 Elemental Containers"
    },
    ["10 Elemental Containers"] = {
        GiftId = 3467110143,
        NormalId = 3467110145,
        Display = "10 Elemental Containers"
    },
    ["Festive Container"] = {
        GiftId = 3478032198,
        NormalId = 3478031738,
        Display = "1 Festive Container"
    },
    ["3 Festive Containers"] = {
        GiftId = 3478032318,
        NormalId = 3478031853,
        Display = "3 Festive Containers"
    },
    ["10 Festive Containers"] = {
        GiftId = 3478032404,
        NormalId = 3478031941,
        Display = "10 Festive Containers"
    },
    ["+1 Exotic Santa\'s Surprise Present"] = {
        GiftId = 3472461581,
        NormalId = 3472461585,
        Display = "1 Exotic Santa\'s Surprise Present"
    },
    ["+3 Exotic Santa\'s Surprise Present"] = {
        GiftId = 3472461582,
        NormalId = 3472461575,
        Display = "3 Exotic Santa\'s Surprise Present"
    },
    ["+10 Exotic Santa\'s Surprise Present"] = {
        GiftId = 3472461580,
        NormalId = 3472461579,
        Display = "10 Exotic Santa\'s Surprise Present"
    },
    ["+50 Exotic Santa\'s Surprise Present"] = {
        GiftId = 3472461583,
        NormalId = 3472461584,
        Display = "50 Exotic Santa\'s Surprise Present"
    },
    ["+1 Super Seed"] = {
        GiftId = 3482199804,
        NormalId = 3482199602,
        Display = "+1 Super Seed"
    },
    ["+3 Super Seed"] = {
        GiftId = 3482200078,
        NormalId = 3482199918,
        Display = "+3 Super Seed"
    },
    ["+10 Super Seed"] = {
        GiftId = 3482200423,
        NormalId = 3482200241,
        Display = "+10 Super Seed"
    },
    ["+9 Super Seed"] = {
        GiftId = 3482222113,
        NormalId = 3249981764,
        Display = "+9 Super Seed"
    },
    ["Rainbow Peppermint Vine Seed"] = {
        GiftId = 3482271756,
        NormalId = 3482271454,
        Display = "Rainbow Peppermint Vine Seed"
    },
    ["Rainbow Moongrain Meadow Seed"] = {
        Display = "Rainbow Moongrain Meadow Seed",
        GiftId = MoonLimitedSeedData.GiftId,
        NormalId = MoonLimitedSeedData.ProductId
    },
    ["Rainbow Scarlet Aspen Seed"] = {
        Display = "Rainbow Scarlet Aspen Seed",
        GiftId = ScarletAspenLimitedSeedData.GiftId,
        NormalId = ScarletAspenLimitedSeedData.ProductId
    },
    ["Firework Fern"] = {
        GiftId = 3490207392,
        NormalId = 3490207231,
        Display = "Firework Fern"
    },
    ["10 Exotic Easter Seed Packs"] = {
        GiftId = 3569021506,
        Display = "10 Exotic Easter Seed Packs",
        NormalId = DevProductIds.EasterPackExoticBuy10.PurchaseID
    },
    ["50 Exotic Easter Seed Packs"] = {
        GiftId = 3570335883,
        Display = "50 Exotic Easter Seed Packs",
        NormalId = DevProductIds.EasterPackExoticBuy50.PurchaseID
    }
};

for _, v in Item_Module.Return_All_Seeds() do
    if v[8] and v[5] then
        v1[`Seed-{v[1]}`] = {
            GiftId = v[8],
            NormalId = v[5],
            Display = v[1]
        };
    end;
end;

for i, v in GearShopData.Gear do
    if v.GiftPurchaseID and v.PurchaseID then
        v1[`Gear-{i}`] = {
            GiftId = v.GiftPurchaseID,
            NormalId = v.PurchaseID,
            Display = v.Gear.GearName
        };
    end;
end;

for i, v in PetEggData do
    if v.GiftPurchaseID and v.PurchaseID then
        v1[`PetEggData-{i}`] = {
            GiftId = v.GiftPurchaseID,
            NormalId = v.PurchaseID,
            Display = v.EggName
        };
    end;
end;

for i, v in TradeTokenData.Shop.Tokens.Products do
    if v.GiftId ~= 0 then
        v1[`TradeToken-Products-{i}`] = {
            GiftId = v.GiftId,
            NormalId = v.ProductId,
            Display = `{v.FallbackPrice or `Tier {i}`} Trade Tokens`
        };
    end;
end;

for i, v in TradeTokenData.Shop.Tokens.Bundles do
    if v.GiftId ~= 0 then
        v1[`TradeToken-Bundles-{i}`] = {
            GiftId = v.GiftId,
            NormalId = v.ProductId,
            Display = `{v.FallbackPrice or `Tier {i}`} Trade Tokens`
        };
    end;
end;

return v1;