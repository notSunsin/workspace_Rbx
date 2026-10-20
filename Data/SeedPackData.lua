-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
RunService:IsStudio();
local SeedData = require(ReplicatedStorage.Data.SeedData);
local table_freeze_ret = table.freeze({
    Normal = {
        DisplayName = "Normal Seed Pack",
        Icon = "rbxassetid://101410959894969",
        Items = { {
                Type = "Seed",
                RewardId = "Pumpkin",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Watermelon",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Peach",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Raspberry",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Dragon Fruit",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Cactus",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Mango",
                Chance = 5
            } }
    },
    Exotic = {
        DisplayName = "Exotic Seed Pack",
        Icon = "rbxassetid://110709773038246",
        Items = { {
                Type = "Seed",
                RewardId = "Papaya",
                Icon = "rbxassetid://137358951402692",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Banana",
                Icon = "rbxassetid://118516260773130",
                Chance = 38
            }, {
                Type = "Seed",
                RewardId = "Passionfruit",
                Icon = "rbxassetid://139621938553116",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Soul Fruit",
                Icon = "rbxassetid://111245465505679",
                Chance = 1.5
            }, {
                Type = "Seed",
                RewardId = "Cursed Fruit",
                Icon = "rbxassetid://89675695188581",
                Chance = 0.5
            } }
    },
    SeedSackBasic = {
        DisplayName = "Basic Seed Sack",
        Icon = "rbxassetid://106607488980528",
        Items = { {
                Type = "Seed",
                RewardId = "Raspberry",
                Icon = "rbxassetid://86654246455569",
                Chance = 40,
                RemoveChance = true
            }, {
                Type = "Seed",
                RewardId = "Cranberry",
                Icon = "rbxassetid://84025739268823",
                Chance = 30,
                RemoveChance = true
            }, {
                Type = "Seed",
                RewardId = "Durian",
                Icon = "rbxassetid://80039191190165",
                Chance = 21,
                RemoveChance = true
            }, {
                Type = "Seed",
                RewardId = "Eggplant",
                Icon = "rbxassetid://99580594965602",
                Chance = 8.735,
                RemoveChance = true
            }, {
                Type = "Seed",
                RewardId = "Lotus",
                Icon = "rbxassetid://104511535272743",
                Chance = 0.25,
                RemoveChance = true
            }, {
                Type = "Seed",
                RewardId = "Venus Fly Trap",
                Icon = "rbxassetid://139210236985330",
                Chance = 0.01,
                RemoveChance = true
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Sack",
                RewardId = "RainbowSeedSackBasic",
                Icon = "rbxassetid://102551065819622",
                Chance = 0.005,
                RemoveChance = true
            } }
    },
    SeedSackPremium = {
        DisplayName = "Premium Seed Sack",
        Icon = "rbxassetid://86897424486908",
        Items = { {
                Type = "Seed",
                RewardId = "Cranberry",
                Icon = "rbxassetid://84025739268823",
                Chance = 45
            }, {
                Type = "Seed",
                RewardId = "Durian",
                Icon = "rbxassetid://80039191190165",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Eggplant",
                Icon = "rbxassetid://99580594965602",
                Chance = 16
            }, {
                Type = "Seed",
                RewardId = "Lotus",
                Icon = "rbxassetid://104511535272743",
                Chance = 2.5
            }, {
                Type = "Seed",
                RewardId = "Venus Fly Trap",
                Icon = "rbxassetid://139210236985330",
                Chance = 1
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Sack",
                RewardId = "RainbowSeedSackPremium",
                Icon = "rbxassetid://102551065819622",
                Chance = 0.5
            } }
    },
    RainbowSeedSackBasic = {
        DisplayName = "Rainbow Basic Seed Sack",
        Icon = "rbxassetid://106607488980528",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Cranberry",
                Icon = "rbxassetid://84025739268823",
                Chance = 55,
                RemoveChance = true
            }, {
                Type = "RainbowSeed",
                RewardId = "Durian",
                Icon = "rbxassetid://80039191190165",
                Chance = 36,
                RemoveChance = true
            }, {
                Type = "RainbowSeed",
                RewardId = "Eggplant",
                Icon = "rbxassetid://99580594965602",
                Chance = 8.735,
                RemoveChance = true
            }, {
                Type = "RainbowSeed",
                RewardId = "Lotus",
                Icon = "rbxassetid://104511535272743",
                Chance = 0.25,
                RemoveChance = true
            }, {
                Type = "RainbowSeed",
                RewardId = "Venus Fly Trap",
                Icon = "rbxassetid://139210236985330",
                Chance = 0.01,
                RemoveChance = true
            } }
    },
    RainbowSeedSackPremium = {
        DisplayName = "Rainbow Premium Seed Sack",
        Icon = "rbxassetid://86897424486908",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Cranberry",
                Icon = "rbxassetid://84025739268823",
                Chance = 45
            }, {
                Type = "RainbowSeed",
                RewardId = "Durian",
                Icon = "rbxassetid://80039191190165",
                Chance = 35
            }, {
                Type = "RainbowSeed",
                RewardId = "Eggplant",
                Icon = "rbxassetid://99580594965602",
                Chance = 16
            }, {
                Type = "RainbowSeed",
                RewardId = "Lotus",
                Icon = "rbxassetid://104511535272743",
                Chance = 2.5
            }, {
                Type = "RainbowSeed",
                RewardId = "Venus Fly Trap",
                Icon = "rbxassetid://139210236985330",
                Chance = 1
            } }
    },
    Night = {
        DisplayName = "Night Seed Pack",
        Icon = "rbxassetid://88891383950011",
        Items = { {
                Type = "Seed",
                RewardId = "Nightshade",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Glowshroom",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Mint",
                Chance = 15
            }, {
                Type = "Seed",
                RewardId = "Moonflower",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Starfruit",
                Chance = 9.5
            }, {
                Type = "Seed",
                RewardId = "Moonglow",
                Chance = 5
            }, {
                Type = "Seed",
                RewardId = "Moon Blossom",
                Chance = 0.5
            } }
    },
    ["Flower Seed Pack"] = {
        DisplayName = "Flower Seed Pack",
        Icon = "rbxassetid://89208043739859",
        Items = { {
                Type = "Seed",
                RewardId = "Rose",
                Icon = "rbxassetid://72881701628573",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Foxglove",
                Icon = "rbxassetid://122695141895194",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Lilac",
                Icon = "rbxassetid://87876725757563",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Pink Lily",
                Icon = "rbxassetid://96953921719864",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Purple Dahlia",
                Icon = "rbxassetid://76967631138624",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Legacy Sunflower",
                Icon = "rbxassetid://73557086822633",
                Chance = 0.5
            } }
    },
    ["Exotic Flower Seed Pack"] = {
        DisplayName = "Exotic Flower Seed Pack",
        Icon = "rbxassetid://89208043739859",
        Items = { {
                Type = "Seed",
                RewardId = "Rose",
                Icon = "rbxassetid://72881701628573",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Foxglove",
                Icon = "rbxassetid://122695141895194",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Lilac",
                Icon = "rbxassetid://87876725757563",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Pink Lily",
                Icon = "rbxassetid://96953921719864",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Purple Dahlia",
                Icon = "rbxassetid://76967631138624",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Legacy Sunflower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Flower Seed Pack",
                Icon = "rbxassetid://100169804106156",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Flower Seed Pack"] = {
        DisplayName = "Rainbow Exotic Flower Seed Pack",
        Icon = "rbxassetid://89208043739859",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Rose",
                Icon = "rbxassetid://72881701628573",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Foxglove",
                Icon = "rbxassetid://122695141895194",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Lilac",
                Icon = "rbxassetid://87876725757563",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Pink Lily",
                Icon = "rbxassetid://96953921719864",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Purple Dahlia",
                Icon = "rbxassetid://76967631138624",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Legacy Sunflower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            } }
    },
    ["Crafters Seed Pack"] = {
        DisplayName = "Crafters Seed Pack",
        Icon = "rbxassetid://87806233108357",
        Items = { {
                Type = "Seed",
                RewardId = "Crocus",
                Icon = "rbxassetid://121292386968832",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Succulent",
                Icon = "rbxassetid://92324210469117",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Violet Corn",
                Icon = "rbxassetid://96798056059927",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Bendboo",
                Icon = "rbxassetid://127696002130952",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Cocovine",
                Icon = "rbxassetid://103933603917731",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Dragon Pepper",
                Icon = "rbxassetid://78076429931317",
                Chance = 0.5
            } }
    },
    ["Exotic Crafters Seed Pack"] = {
        DisplayName = "Exotic Crafters Seed Pack",
        Icon = "rbxassetid://87806233108357",
        Items = { {
                Type = "Seed",
                RewardId = "Crocus",
                Icon = "rbxassetid://121292386968832",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Succulent",
                Icon = "rbxassetid://92324210469117",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Violet Corn",
                Icon = "rbxassetid://96798056059927",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Bendboo",
                Icon = "rbxassetid://127696002130952",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Cocovine",
                Icon = "rbxassetid://103933603917731",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Dragon Pepper",
                Icon = "rbxassetid://78076429931317",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Crafters Seed Pack",
                Icon = "rbxassetid://109579584893006",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Crafters Seed Pack"] = {
        DisplayName = "Rainbow Exotic Crafters Seed Pack",
        Icon = "rbxassetid://87806233108357",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Crocus",
                Icon = "rbxassetid://121292386968832",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Succulent",
                Icon = "rbxassetid://92324210469117",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Violet Corn",
                Icon = "rbxassetid://96798056059927",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Bendboo",
                Icon = "rbxassetid://127696002130952",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Cocovine",
                Icon = "rbxassetid://103933603917731",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Dragon Pepper",
                Icon = "rbxassetid://78076429931317",
                Chance = 7
            } }
    },
    ["Summer Seed Pack"] = {
        DisplayName = "Summer Seed Pack",
        Icon = "rbxassetid://87843809427532",
        Items = { {
                Type = "Seed",
                RewardId = "Wild Carrot",
                Icon = "rbxassetid://72854521502613",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Pear",
                Icon = "rbxassetid://91934825764433",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Cantaloupe",
                Icon = "rbxassetid://95818249215044",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Parasol Flower",
                Icon = "rbxassetid://119758485597210",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Rosy Delight",
                Icon = "rbxassetid://92579553790588",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Elephant Ears",
                Icon = "rbxassetid://119701335732381",
                Chance = 0.5
            } }
    },
    ["Exotic Summer Seed Pack"] = {
        DisplayName = "Exotic Summer Seed Pack",
        Icon = "rbxassetid://87843809427532",
        Items = { {
                Type = "Seed",
                RewardId = "Wild Carrot",
                Icon = "rbxassetid://72854521502613",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Pear",
                Icon = "rbxassetid://91934825764433",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Cantaloupe",
                Icon = "rbxassetid://95818249215044",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Parasol Flower",
                Icon = "rbxassetid://119758485597210",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Rosy Delight",
                Icon = "rbxassetid://92579553790588",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Elephant Ears",
                Icon = "rbxassetid://119701335732381",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Summer Seed Pack",
                Icon = "rbxassetid://120279580075160",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Summer Seed Pack"] = {
        DisplayName = "Rainbow Exotic Summer Seed Pack",
        Icon = "rbxassetid://87843809427532",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Wild Carrot",
                Icon = "rbxassetid://72854521502613",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Pear",
                Icon = "rbxassetid://91934825764433",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Cantaloupe",
                Icon = "rbxassetid://95818249215044",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Parasol Flower",
                Icon = "rbxassetid://119758485597210",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Rosy Delight",
                Icon = "rbxassetid://92579553790588",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Elephant Ears",
                Icon = "rbxassetid://119701335732381",
                Chance = 7
            } }
    },
    ["Ancient Seed Pack"] = {
        DisplayName = "Ancient Seed Pack",
        Icon = "rbxassetid://129787954191127",
        Items = { {
                Type = "Seed",
                RewardId = "Stonebite",
                Icon = "rbxassetid://110227673162287",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Paradise Petal",
                Icon = "rbxassetid://73887260192647",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Horned Dinoshroom",
                Icon = "rbxassetid://113476956759836",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Boneboo",
                Icon = "rbxassetid://88824192085169",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Firefly Fern",
                Icon = "rbxassetid://95168789830686",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Fossilight",
                Icon = "rbxassetid://112026504427742",
                Chance = 0.5
            } }
    },
    ["Exotic Ancient Seed Pack"] = {
        DisplayName = "Exotic Ancient Seed Pack",
        Icon = "rbxassetid://125063622378760",
        Items = { {
                Type = "Seed",
                RewardId = "Stonebite",
                Icon = "rbxassetid://110227673162287",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Paradise Petal",
                Icon = "rbxassetid://73887260192647",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Horned Dinoshroom",
                Icon = "rbxassetid://113476956759836",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Boneboo",
                Icon = "rbxassetid://88824192085169",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Firefly Fern",
                Icon = "rbxassetid://95168789830686",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Fossilight",
                Icon = "rbxassetid://112026504427742",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Ancient Seed Pack",
                Icon = "rbxassetid://90010389653960",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Ancient Seed Pack"] = {
        DisplayName = "Rainbow Exotic Ancient Seed Pack",
        Icon = "rbxassetid://125063622378760",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Stonebite",
                Icon = "rbxassetid://110227673162287",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Paradise Petal",
                Icon = "rbxassetid://73887260192647",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Horned Dinoshroom",
                Icon = "rbxassetid://113476956759836",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Boneboo",
                Icon = "rbxassetid://88824192085169",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Firefly Fern",
                Icon = "rbxassetid://95168789830686",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Fossilight",
                Icon = "rbxassetid://112026504427742",
                Chance = 7
            } }
    },
    NightPremium = {
        DisplayName = "Premium Night Seed Pack",
        Icon = "rbxassetid://88891383950011",
        Items = { {
                Type = "Seed",
                RewardId = "Glowshroom",
                Chance = 30
            }, {
                Type = "Seed",
                RewardId = "Mint",
                Chance = 22
            }, {
                Type = "Seed",
                RewardId = "Moonflower",
                Chance = 18
            }, {
                Type = "Seed",
                RewardId = "Starfruit",
                Chance = 15.5
            }, {
                Type = "Seed",
                RewardId = "Moonglow",
                Chance = 12
            }, {
                Type = "Seed",
                RewardId = "Moon Blossom",
                Chance = 2.5
            } }
    },
    ["Zen Seed Pack"] = {
        DisplayName = "Zen Seed Pack",
        Icon = "rbxassetid://86615661639589",
        Items = { {
                Type = "Seed",
                RewardId = "Monoblooma",
                Icon = "rbxassetid://107989871465566",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Serenity",
                Icon = "rbxassetid://137574233665259",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Taro Flower",
                Icon = "rbxassetid://76385999229710",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Zen Rocks",
                Icon = "rbxassetid://130822723633121",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Hinomai",
                Icon = "rbxassetid://92612486902506",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Maple Apple",
                Icon = "rbxassetid://131021954395430",
                Chance = 0.5
            } }
    },
    ["Exotic Zen Seed Pack"] = {
        DisplayName = "Exotic Zen Seed Pack",
        Icon = "rbxassetid://79063061377528",
        Items = { {
                Type = "Seed",
                RewardId = "Monoblooma",
                Icon = "rbxassetid://107989871465566",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Serenity",
                Icon = "rbxassetid://137574233665259",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Taro Flower",
                Icon = "rbxassetid://76385999229710",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Zen Rocks",
                Icon = "rbxassetid://130822723633121",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Hinomai",
                Icon = "rbxassetid://92612486902506",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Maple Apple",
                Icon = "rbxassetid://131021954395430",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Zen Seed Pack",
                Icon = "rbxassetid://72241872838922",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Zen Seed Pack"] = {
        DisplayName = "Rainbow Exotic Zen Seed Pack",
        Icon = "rbxassetid://72241872838922",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Monoblooma",
                Icon = "rbxassetid://107989871465566",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Serenity",
                Icon = "rbxassetid://137574233665259",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Taro Flower",
                Icon = "rbxassetid://76385999229710",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Zen Rocks",
                Icon = "rbxassetid://130822723633121",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Hinomai",
                Icon = "rbxassetid://92612486902506",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Maple Apple",
                Icon = "rbxassetid://131021954395430",
                Chance = 7
            } }
    },
    ["Kitsune Chest"] = {
        DisplayName = "Kitsune Chest",
        Icon = "rbxassetid://Kitsune Chest",
        Items = { {
                Type = "Seed",
                RewardId = "Dezen",
                Icon = "rbxassetid://97620536348206",
                Chance = 34.5
            }, {
                Type = "Pet",
                RewardId = "Maneki-neko",
                Icon = "rbxassetid://120413969413267",
                Chance = 34.5
            }, {
                Type = "Seed",
                RewardId = "Lucky Bamboo",
                Icon = "rbxassetid://86151055265677",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Kodama",
                Icon = "rbxassetid://72999154026196",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Tranquil Bloom",
                Icon = "rbxassetid://94891262768717",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Corrupted Kitsune",
                Icon = "rbxassetid://99270972010214",
                Chance = 1
            } }
    },
    ["Exotic Kitsune Chest"] = {
        DisplayName = "Exotic Kitsune Chest",
        Icon = "rbxassetid://127840719045383",
        Items = { {
                Type = "Seed",
                RewardId = "Dezen",
                Icon = "rbxassetid://97620536348206",
                Chance = 34
            }, {
                Type = "Pet",
                RewardId = "Maneki-neko",
                Icon = "rbxassetid://120413969413267",
                Chance = 34
            }, {
                Type = "Seed",
                RewardId = "Lucky Bamboo",
                Icon = "rbxassetid://86151055265677",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Kodama",
                Icon = "rbxassetid://72999154026196",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Tranquil Bloom",
                Icon = "rbxassetid://94891262768717",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Corrupted Kitsune",
                Icon = "rbxassetid://99270972010214",
                Chance = 1
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Kitsune Chest",
                Icon = "rbxassetid://89553564116412",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Kitsune Chest"] = {
        DisplayName = "Rainbow Exotic Kitsune Chest",
        Icon = "rbxassetid://89553564116412",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Dezen",
                Icon = "rbxassetid://97620536348206",
                Chance = 28
            }, {
                Type = "Pet",
                RewardId = "Rainbow Maneki-neko",
                Icon = "rbxassetid://120413969413267",
                Chance = 28
            }, {
                Type = "RainbowSeed",
                RewardId = "Lucky Bamboo",
                Icon = "rbxassetid://86151055265677",
                Chance = 15
            }, {
                Type = "Pet",
                RewardId = "Rainbow Kodama",
                Icon = "rbxassetid://72999154026196",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "Tranquil Bloom",
                Icon = "rbxassetid://94891262768717",
                Chance = 7
            }, {
                Type = "Pet",
                RewardId = "Rainbow Corrupted Kitsune",
                Icon = "rbxassetid://99270972010214",
                Chance = 7
            } }
    },
    ["Gourmet Seed Pack"] = {
        DisplayName = "Gourmet Seed Pack",
        Icon = "rbxassetid://137105474602826",
        Items = { {
                Type = "Seed",
                RewardId = "Onion",
                Icon = "rbxassetid://109219993957918",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Jalapeno",
                Icon = "rbxassetid://119990140492671",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Crown Melon",
                Icon = "rbxassetid://118977437627962",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Sugarglaze",
                Icon = "rbxassetid://131197396101173",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Tall Asparagus",
                Icon = "rbxassetid://84387436030021",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Grand Tomato",
                Icon = "rbxassetid://87572832539866",
                Chance = 0.5
            } }
    },
    ["Exotic Gourmet Seed Pack"] = {
        DisplayName = "Exotic Gourmet Seed Pack",
        Icon = "rbxassetid://106906415803012",
        Items = { {
                Type = "Seed",
                RewardId = "Onion",
                Icon = "rbxassetid://109219993957918",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Jalapeno",
                Icon = "rbxassetid://119990140492671",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Crown Melon",
                Icon = "rbxassetid://118977437627962",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Sugarglaze",
                Icon = "rbxassetid://131197396101173",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Tall Asparagus",
                Icon = "rbxassetid://84387436030021",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Grand Tomato",
                Icon = "rbxassetid://87572832539866",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Gourmet Seed Pack",
                Icon = "rbxassetid://81256065650103",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Gourmet Seed Pack"] = {
        DisplayName = "Rainbow Exotic Gourmet Seed Pack",
        Icon = "rbxassetid://81256065650103",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Onion",
                Icon = "rbxassetid://109219993957918",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Jalapeno",
                Icon = "rbxassetid://119990140492671",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Crown Melon",
                Icon = "rbxassetid://118977437627962",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Sugarglaze",
                Icon = "rbxassetid://131197396101173",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Tall Asparagus",
                Icon = "rbxassetid://84387436030021",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Grand Tomato",
                Icon = "rbxassetid://87572832539866",
                Chance = 7
            } }
    },
    ["Culinarian Chest"] = {
        DisplayName = "Culinarian Chest",
        Icon = "rbxassetid://140469503778160",
        Items = { {
                Type = "Seed",
                RewardId = "Rhubarb",
                Icon = "rbxassetid://106871330378373",
                Chance = 34.5
            }, {
                Type = "Pet",
                RewardId = "Bacon Pig",
                Icon = "rbxassetid://123575630335943",
                Chance = 34.5
            }, {
                Type = "Seed",
                RewardId = "Badlands Pepper",
                Icon = "rbxassetid://80652364697403",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Hotdog Daschund",
                Icon = "rbxassetid://95882797225742",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "King Cabbage",
                Icon = "rbxassetid://91601239615737",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Lobster Thermidor",
                Icon = "rbxassetid://123517269814780",
                Chance = 1
            } }
    },
    ["Exotic Culinarian Chest"] = {
        DisplayName = "Exotic Culinarian Chest",
        Icon = "rbxassetid://138297937015548",
        Items = { {
                Type = "Seed",
                RewardId = "Rhubarb",
                Icon = "rbxassetid://106871330378373",
                Chance = 34
            }, {
                Type = "Pet",
                RewardId = "Bacon Pig",
                Icon = "rbxassetid://123575630335943",
                Chance = 34
            }, {
                Type = "Seed",
                RewardId = "Badlands Pepper",
                Icon = "rbxassetid://80652364697403",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Hotdog Daschund",
                Icon = "rbxassetid://95882797225742",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "King Cabbage",
                Icon = "rbxassetid://91601239615737",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Lobster Thermidor",
                Icon = "rbxassetid://123517269814780",
                Chance = 1
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Culinarian Chest",
                Icon = "rbxassetid://139267369304594",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Culinarian Chest"] = {
        DisplayName = "Rainbow Exotic Culinarian Chest",
        Icon = "rbxassetid://139267369304594",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Rhubarb",
                Icon = "rbxassetid://106871330378373",
                Chance = 28
            }, {
                Type = "Pet",
                RewardId = "Rainbow Bacon Pig",
                Icon = "rbxassetid://123575630335943",
                Chance = 28
            }, {
                Type = "RainbowSeed",
                RewardId = "Badlands Pepper",
                Icon = "rbxassetid://80652364697403",
                Chance = 15
            }, {
                Type = "Pet",
                RewardId = "Rainbow Hotdog Daschund",
                Icon = "rbxassetid://95882797225742",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "King Cabbage",
                Icon = "rbxassetid://91601239615737",
                Chance = 7
            }, {
                Type = "Pet",
                RewardId = "Rainbow Lobster Thermidor",
                Icon = "rbxassetid://123517269814780",
                Chance = 7
            } }
    },
    ["Sprout Seed Pack"] = {
        DisplayName = "Sprout Seed Pack",
        Icon = "rbxassetid://77523115166507",
        Items = { {
                Type = "Seed",
                RewardId = "Flare Daisy",
                Icon = "rbxassetid://105316835053253",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Duskpuff",
                Icon = "rbxassetid://91872032827721",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Mangosteen",
                Icon = "rbxassetid://134506599201430",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Poseidon Plant",
                Icon = "rbxassetid://97650420696362",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Gleamroot",
                Icon = "rbxassetid://131568273345403",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Princess Thorn",
                Icon = "rbxassetid://116245630615057",
                Chance = 0.5
            } }
    },
    ["Exotic Sprout Seed Pack"] = {
        DisplayName = "Exotic Sprout Seed Pack",
        Icon = "rbxassetid://122594776082214",
        Items = { {
                Type = "Seed",
                RewardId = "Flare Daisy",
                Icon = "rbxassetid://105316835053253",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Duskpuff",
                Icon = "rbxassetid://91872032827721",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Mangosteen",
                Icon = "rbxassetid://134506599201430",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Poseidon Plant",
                Icon = "rbxassetid://97650420696362",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Gleamroot",
                Icon = "rbxassetid://131568273345403",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Princess Thorn",
                Icon = "rbxassetid://116245630615057",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Sprout Seed Pack",
                Icon = "rbxassetid://79790068231864",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Sprout Seed Pack"] = {
        DisplayName = "Rainbow Exotic Sprout Seed Pack",
        Icon = "rbxassetid://79790068231864",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Flare Daisy",
                Icon = "rbxassetid://105316835053253",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Duskpuff",
                Icon = "rbxassetid://91872032827721",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Mangosteen",
                Icon = "rbxassetid://134506599201430",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Poseidon Plant",
                Icon = "rbxassetid://97650420696362",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Gleamroot",
                Icon = "rbxassetid://131568273345403",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Princess Thorn",
                Icon = "rbxassetid://116245630615057",
                Chance = 7
            } }
    },
    ["Silver Common Seed Pack"] = {
        DisplayName = "Silver Common Seed Pack",
        Icon = "rbxassetid://114090638736711",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Carrot",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 62
            }, {
                Type = "SilverSeed",
                RewardId = "Strawberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 38
            } }
    },
    ["Silver Uncommon Seed Pack"] = {
        DisplayName = "Silver Uncommon Seed Pack",
        Icon = "rbxassetid://91021731740542",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Orange Tulip",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 64
            }, {
                Type = "SilverSeed",
                RewardId = "Blueberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 36
            } }
    },
    ["Silver Rare Seed Pack"] = {
        DisplayName = "Silver Rare Seed Pack",
        Icon = "rbxassetid://91143448683946",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Daffodil",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 50
            }, {
                Type = "SilverSeed",
                RewardId = "Tomato",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "SilverSeed",
                RewardId = "Corn",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            } }
    },
    ["Silver Legendary Seed Pack"] = {
        DisplayName = "Silver Legendary Seed Pack",
        Icon = "rbxassetid://133478031325847",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Watermelon",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "SilverSeed",
                RewardId = "Pumpkin",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "SilverSeed",
                RewardId = "Bamboo",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "SilverSeed",
                RewardId = "Apple",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            } }
    },
    ["Silver Mythical Seed Pack"] = {
        DisplayName = "Silver Mythical Seed Pack",
        Icon = "rbxassetid://132700190915323",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Coconut",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 38
            }, {
                Type = "SilverSeed",
                RewardId = "Cactus",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 24
            }, {
                Type = "SilverSeed",
                RewardId = "Dragon Fruit",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "SilverSeed",
                RewardId = "Mango",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 18
            } }
    },
    ["Silver Divine Seed Pack"] = {
        DisplayName = "Silver Divine Seed Pack",
        Icon = "rbxassetid://132632155283313",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Mushroom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 36
            }, {
                Type = "SilverSeed",
                RewardId = "Grape",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 26
            }, {
                Type = "SilverSeed",
                RewardId = "Pepper",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 22
            }, {
                Type = "SilverSeed",
                RewardId = "Cacao",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 16
            } }
    },
    ["Silver Prismatic Seed Pack"] = {
        DisplayName = "Silver Prismatic Seed Pack",
        Icon = "rbxassetid://122495324042615",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Beanstalk",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 27
            }, {
                Type = "SilverSeed",
                RewardId = "Ember Lily",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 19
            }, {
                Type = "SilverSeed",
                RewardId = "Sugar Apple",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 17
            }, {
                Type = "SilverSeed",
                RewardId = "Burning Bud",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 13
            }, {
                Type = "SilverSeed",
                RewardId = "Giant Pinecone",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 9
            }, {
                Type = "SilverSeed",
                RewardId = "Elder Strawberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "SilverSeed",
                RewardId = "Romanesco",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            } }
    },
    ["Silver Transcendent Seed Pack"] = {
        DisplayName = "Silver Transcendent Seed Pack",
        Icon = "rbxassetid://131815761394219",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Crimson Thorn",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "SilverSeed",
                RewardId = "Zebrazinkle",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "SilverSeed",
                RewardId = "Octobloom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "SilverSeed",
                RewardId = "Alien Apple",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            } }
    },
    ["Skyroot Chest"] = {
        DisplayName = "Skyroot Chest",
        Icon = "rbxassetid://123990840770513",
        Items = { {
                Type = "Seed",
                RewardId = "Crown of Thorns",
                Icon = "rbxassetid://71247058412364",
                Chance = 34.5
            }, {
                Type = "Pet",
                RewardId = "Elk",
                Icon = "rbxassetid://127104293000030",
                Chance = 34.5
            }, {
                Type = "Seed",
                RewardId = "Calla Lily",
                Icon = "rbxassetid://79097917957337",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Mandrake",
                Icon = "rbxassetid://110030055256222",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Cyclamen",
                Icon = "rbxassetid://87977286245584",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Griffin",
                Icon = "rbxassetid://89180236366919",
                Chance = 1
            } }
    },
    ["Exotic Skyroot Chest"] = {
        DisplayName = "Exotic Skyroot Chest",
        Icon = "rbxassetid://117305397932726",
        Items = { {
                Type = "Seed",
                RewardId = "Crown of Thorns",
                Icon = "rbxassetid://71247058412364",
                Chance = 34
            }, {
                Type = "Pet",
                RewardId = "Elk",
                Icon = "rbxassetid://127104293000030",
                Chance = 34
            }, {
                Type = "Seed",
                RewardId = "Calla Lily",
                Icon = "rbxassetid://79097917957337",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Mandrake",
                Icon = "rbxassetid://110030055256222",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Cyclamen",
                Icon = "rbxassetid://87977286245584",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Griffin",
                Icon = "rbxassetid://89180236366919",
                Chance = 1
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Skyroot Chest",
                Icon = "rbxassetid://123959241611335",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Skyroot Chest"] = {
        DisplayName = "Rainbow Exotic Skyroot Chest",
        Icon = "rbxassetid://123959241611335",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Crown of Thorns",
                Icon = "rbxassetid://71247058412364",
                Chance = 28
            }, {
                Type = "Pet",
                RewardId = "Rainbow Elk",
                Icon = "rbxassetid://127104293000030",
                Chance = 28
            }, {
                Type = "RainbowSeed",
                RewardId = "Calla Lily",
                Icon = "rbxassetid://79097917957337",
                Chance = 15
            }, {
                Type = "Pet",
                RewardId = "Rainbow Mandrake",
                Icon = "rbxassetid://110030055256222",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "Cyclamen",
                Icon = "rbxassetid://87977286245584",
                Chance = 7
            }, {
                Type = "Pet",
                RewardId = "Rainbow Griffin",
                Icon = "rbxassetid://89180236366919",
                Chance = 7
            } }
    },
    ["Enchanted Seed Pack"] = {
        DisplayName = "Enchanted Seed Pack",
        Icon = "rbxassetid://92703472766569",
        Items = { {
                Type = "Seed",
                RewardId = "Sunbulb",
                Icon = "rbxassetid://72568405170137",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Glowthorn",
                Icon = "rbxassetid://135267704167019",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Lightshoot",
                Icon = "rbxassetid://140324487957539",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Briar Rose",
                Icon = "rbxassetid://102132060641560",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Spirit Flower",
                Icon = "rbxassetid://124894895580710",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Wispwing",
                Icon = "rbxassetid://76721797363104",
                Chance = 0.5
            } }
    },
    ["Exotic Enchanted Seed Pack"] = {
        DisplayName = "Exotic Enchanted Seed Pack",
        Icon = "rbxassetid://89368466054112",
        Items = { {
                Type = "Seed",
                RewardId = "Sunbulb",
                Icon = "rbxassetid://120700463623509",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Glowthorn",
                Icon = "rbxassetid://91714836806838",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Lightshoot",
                Icon = "rbxassetid://111505838463119",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Briar Rose",
                Icon = "rbxassetid://76419523252769",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Spirit Flower",
                Icon = "rbxassetid://119395365157545",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Wispwing",
                Icon = "rbxassetid://94302407520780",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Enchanted Seed Pack",
                Icon = "rbxassetid://103106788031205",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Enchanted Seed Pack"] = {
        DisplayName = "Rainbow Exotic Enchanted Seed Pack",
        Icon = "rbxassetid://103106788031205",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Sunbulb",
                Icon = "rbxassetid://120700463623509",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Glowthorn",
                Icon = "rbxassetid://91714836806838",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Lightshoot",
                Icon = "rbxassetid://111505838463119",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Briar Rose",
                Icon = "rbxassetid://76419523252769",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Spirit Flower",
                Icon = "rbxassetid://119395365157545",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Wispwing",
                Icon = "rbxassetid://94302407520780",
                Chance = 7
            } }
    },
    ["Gardener Seed Pack"] = {
        DisplayName = "Gardener Seed Pack",
        Icon = "rbxassetid://128775555936613",
        Items = { {
                Type = "Seed",
                RewardId = "Radish",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 50
            }, {
                Type = "Seed",
                RewardId = "Blue Raspberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "Seed",
                RewardId = "Horned Melon",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Ackee",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Urchin Plant",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 5
            } }
    },
    ["Exotic Gardener Seed Pack"] = {
        DisplayName = "Exotic Gardener Seed Pack",
        Icon = "rbxassetid://102166075040023",
        Items = { {
                Type = "Seed",
                RewardId = "Radish",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Blue Raspberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Horned Melon",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Ackee",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "Seed",
                RewardId = "Urchin Plant",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Pack",
                RewardId = "Rainbow Gardener Seed Pack",
                Icon = "rbxassetid://130784540117024",
                Chance = 0.5
            } }
    },
    ["Rainbow Gardener Seed Pack"] = {
        DisplayName = "Rainbow Gardener Seed Pack",
        Icon = "rbxassetid://6937742258",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Radish",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "RainbowSeed",
                RewardId = "Blue Raspberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Horned Melon",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Ackee",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "Urchin Plant",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            } }
    },
    ["Enchanted Chest"] = {
        DisplayName = "Enchanted Chest",
        Icon = "rbxassetid://75439896754251",
        Items = { {
                Type = "Seed",
                RewardId = "Emerald Bud",
                Icon = "rbxassetid://126003306982516",
                Chance = 34.5
            }, {
                Type = "Pet",
                RewardId = "Cardinal",
                Icon = "rbxassetid://137030064718487",
                Chance = 34.5
            }, {
                Type = "Seed",
                RewardId = "Pyracantha",
                Icon = "rbxassetid://97004839731597",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Shroomie",
                Icon = "rbxassetid://118861411002665",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Aetherfruit",
                Icon = "rbxassetid://90507124224051",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Phoenix",
                Icon = "rbxassetid://117645843394939",
                Chance = 1
            } }
    },
    ["Exotic Enchanted Chest"] = {
        DisplayName = "Exotic Enchanted Chest",
        Icon = "rbxassetid://131250610548299",
        Items = { {
                Type = "Seed",
                RewardId = "Emerald Bud",
                Icon = "rbxassetid://126003306982516",
                Chance = 34
            }, {
                Type = "Pet",
                RewardId = "Cardinal",
                Icon = "rbxassetid://137030064718487",
                Chance = 34
            }, {
                Type = "Seed",
                RewardId = "Pyracantha",
                Icon = "rbxassetid://97004839731597",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Shroomie",
                Icon = "rbxassetid://118861411002665",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Aetherfruit",
                Icon = "rbxassetid://90507124224051",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Phoenix",
                Icon = "rbxassetid://117645843394939",
                Chance = 1
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Enchanted Chest",
                Icon = "rbxassetid://74555275163145",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Enchanted Chest"] = {
        DisplayName = "Rainbow Exotic Enchanted Chest",
        Icon = "rbxassetid://74555275163145",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Emerald Bud",
                Icon = "rbxassetid://126003306982516",
                Chance = 28
            }, {
                Type = "Pet",
                RewardId = "Rainbow Cardinal",
                Icon = "rbxassetid://137030064718487",
                Chance = 28
            }, {
                Type = "RainbowSeed",
                RewardId = "Pyracantha",
                Icon = "rbxassetid://97004839731597",
                Chance = 15
            }, {
                Type = "Pet",
                RewardId = "Rainbow Shroomie",
                Icon = "rbxassetid://118861411002665",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "Aetherfruit",
                Icon = "rbxassetid://90507124224051",
                Chance = 7
            }, {
                Type = "Pet",
                RewardId = "Rainbow Phoenix",
                Icon = "rbxassetid://117645843394939",
                Chance = 7
            } }
    },
    ["Fall Seed Pack"] = {
        DisplayName = "Fall Seed Pack",
        Icon = "rbxassetid://125206405927735",
        Items = { {
                Type = "Seed",
                RewardId = "Autumn Shroom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Fall Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Speargrass",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Torchflare",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Auburn Pine",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Firewell",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Silver Fall Seed Pack"] = {
        DisplayName = "Silver Fall Seed Pack",
        Icon = "rbxassetid://87371948352938",
        Items = { {
                Type = "SilverSeed",
                RewardId = "Autumn Shroom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "SilverSeed",
                RewardId = "Fall Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "SilverSeed",
                RewardId = "Speargrass",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "SilverSeed",
                RewardId = "Torchflare",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "SilverSeed",
                RewardId = "Auburn Pine",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "SilverSeed",
                RewardId = "Firewell",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Fall Seed Pack"] = {
        DisplayName = "Exotic Fall Seed Pack",
        Icon = "rbxassetid://71053374665565",
        Items = { {
                Type = "Seed",
                RewardId = "Autumn Shroom",
                Icon = "rbxassetid://75191261635804",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Fall Berry",
                Icon = "rbxassetid://73166761479846",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Speargrass",
                Icon = "rbxassetid://116332608985559",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Torchflare",
                Icon = "rbxassetid://105688382453107",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Auburn Pine",
                Icon = "rbxassetid://70592093864676",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Firewell",
                Icon = "rbxassetid://82408767722747",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Fall Seed Pack",
                Icon = "rbxassetid://130784540117024",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Fall Seed Pack"] = {
        DisplayName = "Rainbow Exotic Fall Seed Pack",
        Icon = "rbxassetid://130784540117024",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Autumn Shroom",
                Icon = "rbxassetid://75191261635804",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Fall Berry",
                Icon = "rbxassetid://73166761479846",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Speargrass",
                Icon = "rbxassetid://116332608985559",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Torchflare",
                Icon = "rbxassetid://105688382453107",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Auburn Pine",
                Icon = "rbxassetid://70592093864676",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Firewell",
                Icon = "rbxassetid://82408767722747",
                Chance = 7
            } }
    },
    ["Prime Seed Pack"] = {
        DisplayName = "Prime Seed Pack",
        Icon = "rbxassetid://96057622882386",
        Items = { {
                Type = "Seed",
                RewardId = "Sundew",
                Icon = "rbxassetid://122098869816722",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Black Bat Flower",
                Icon = "rbxassetid://126435095234995",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Mandrone Berry",
                Icon = "rbxassetid://108342490954630",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Corpse Flower",
                Icon = "rbxassetid://137827290854718",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Inferno Quince",
                Icon = "rbxassetid://125974810320036",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Multitrap",
                Icon = "rbxassetid://82806390893398",
                Chance = 0.5
            } }
    },
    ["Exotic Prime Seed Pack"] = {
        DisplayName = "Exotic Prime Seed Pack",
        Icon = "rbxassetid://85642665778586",
        Items = { {
                Type = "Seed",
                RewardId = "Sundew",
                Icon = "rbxassetid://122098869816722",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Black Bat Flower",
                Icon = "rbxassetid://126435095234995",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Mandrone Berry",
                Icon = "rbxassetid://108342490954630",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Corpse Flower",
                Icon = "rbxassetid://137827290854718",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Inferno Quince",
                Icon = "rbxassetid://125974810320036",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Multitrap",
                Icon = "rbxassetid://82806390893398",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Prime Seed Pack",
                Icon = "rbxassetid://90419259772348",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Prime Seed Pack"] = {
        DisplayName = "Rainbow Exotic Prime Seed Pack",
        Icon = "rbxassetid://90419259772348",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Sundew",
                Icon = "rbxassetid://122098869816722",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Black Bat Flower",
                Icon = "rbxassetid://126435095234995",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Mandrone Berry",
                Icon = "rbxassetid://108342490954630",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Corpse Flower",
                Icon = "rbxassetid://137827290854718",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Inferno Quince",
                Icon = "rbxassetid://125974810320036",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Multitrap",
                Icon = "rbxassetid://82806390893398",
                Chance = 7
            } }
    },
    ["Zenith Seed Pack"] = {
        DisplayName = "Zenith Seed Pack",
        Icon = "rbxassetid://135914215015356",
        Items = { {
                Type = "Seed",
                RewardId = "Horned Redrose",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Banana Orchid",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Viburnum Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Buddhas Hand",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Ghost Pepper",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Thornspire",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Zenith Seed Pack"] = {
        DisplayName = "Exotic Zenith Seed Pack",
        Icon = "rbxassetid://120072325886583",
        Items = { {
                Type = "Seed",
                RewardId = "Horned Redrose",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Banana Orchid",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Viburnum Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Buddhas Hand",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Ghost Pepper",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Thornspire",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Zenith Seed Pack",
                Icon = "rbxassetid://90419259772348",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Zenith Seed Pack"] = {
        DisplayName = "Rainbow Exotic Zenith Seed Pack",
        Icon = "rbxassetid://90419259772348",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Horned Redrose",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Banana Orchid",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Viburnum Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Buddhas Hand",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Ghost Pepper",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Thornspire",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            } }
    },
    ["Season 4 Seed Pack"] = {
        DisplayName = "Season 4 Seed Pack",
        Icon = "rbxassetid://86848065126412",
        Items = { {
                Type = "Seed",
                RewardId = "Drowned Flower",
                Icon = "rbxassetid://139458729221824",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Saskia",
                Icon = "rbxassetid://129768676686477",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Mini Pumpkin",
                Icon = "rbxassetid://77089311487267",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Jungle Cherry",
                Icon = "rbxassetid://117045891284570",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Amazon Feather Fern",
                Icon = "rbxassetid://74446239808073",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Boreal Orange",
                Icon = "rbxassetid://93303765808655",
                Chance = 0.5
            } }
    },
    ["Exotic Season 4 Seed Pack"] = {
        DisplayName = "Exotic Season 4 Seed Pack",
        Icon = "rbxassetid://111507069439237",
        Items = { {
                Type = "Seed",
                RewardId = "Drowned Flower",
                Icon = "rbxassetid://139458729221824",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Saskia",
                Icon = "rbxassetid://129768676686477",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Mini Pumpkin",
                Icon = "rbxassetid://77089311487267",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Jungle Cherry",
                Icon = "rbxassetid://117045891284570",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Amazon Feather Fern",
                Icon = "rbxassetid://74446239808073",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Boreal Orange",
                Icon = "rbxassetid://93303765808655",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Season 4 Seed Pack",
                Icon = "rbxassetid://90419259772348",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Season 4 Seed Pack"] = {
        DisplayName = "Rainbow Exotic Season 4 Seed Pack",
        Icon = "rbxassetid://90419259772348",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Drowned Flower",
                Icon = "rbxassetid://139458729221824",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Saskia",
                Icon = "rbxassetid://129768676686477",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Mini Pumpkin",
                Icon = "rbxassetid://77089311487267",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Jungle Cherry",
                Icon = "rbxassetid://117045891284570",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Amazon Feather Fern",
                Icon = "rbxassetid://74446239808073",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Boreal Orange",
                Icon = "rbxassetid://93303765808655",
                Chance = 7
            } }
    },
    ["Season 5 Seed Pack"] = {
        DisplayName = "Season 5 Seed Pack",
        Icon = "rbxassetid://92593109615248",
        Items = { {
                Type = "Seed",
                RewardId = "Starbloom Daisy",
                Icon = "rbxassetid://119321602987254",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Cocoa Pod",
                Icon = "rbxassetid://99576213755680",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Astrobush",
                Icon = "rbxassetid://102470738848486",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Lumi Shroom",
                Icon = "rbxassetid://129236398990859",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Sweetheart Flower",
                Icon = "rbxassetid://102913122483408",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Bendbark",
                Icon = "rbxassetid://124772594989131",
                Chance = 0.5
            } }
    },
    ["Exotic Season 5 Seed Pack"] = {
        DisplayName = "Exotic Season 5 Seed Pack",
        Icon = "rbxassetid://92593109615248",
        Items = { {
                Type = "Seed",
                RewardId = "Starbloom Daisy",
                Icon = "rbxassetid://119321602987254",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Cocoa Pod",
                Icon = "rbxassetid://99576213755680",
                Chance = 29
            }, {
                Type = "Seed",
                RewardId = "Astrobush",
                Icon = "rbxassetid://102470738848486",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Lumi Shroom",
                Icon = "rbxassetid://129236398990859",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Sweetheart Flower",
                Icon = "rbxassetid://102913122483408",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Bendbark",
                Icon = "rbxassetid://124772594989131",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Season 5 Seed Pack",
                Icon = "rbxassetid://90419259772348",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Season 5 Seed Pack"] = {
        DisplayName = "Rainbow Exotic Season 5 Seed Pack",
        Icon = "rbxassetid://92593109615248",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Starbloom Daisy",
                Icon = "rbxassetid://119321602987254",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Cocoa Pod",
                Icon = "rbxassetid://99576213755680",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Astrobush",
                Icon = "rbxassetid://102470738848486",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Lumi Shroom",
                Icon = "rbxassetid://129236398990859",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Sweetheart Flower",
                Icon = "rbxassetid://102913122483408",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Bendbark",
                Icon = "rbxassetid://124772594989131",
                Chance = 7
            } }
    },
    ["Season 6 Seed Pack"] = {
        DisplayName = "Season 6 Seed Pack",
        Icon = "rbxassetid://101748988804829",
        Items = { {
                Type = "Seed",
                RewardId = "Vio Puff",
                Icon = "rbxassetid://124510721353457",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Storm Bulb",
                Icon = "rbxassetid://99500389374423",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Geode Root",
                Icon = "rbxassetid://81350229427183",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Chroma Orb",
                Icon = "rbxassetid://125136735747348",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Polypea Sprout",
                Icon = "rbxassetid://133434061057772",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Volt Lily",
                Icon = "rbxassetid://98784455581752",
                Chance = 0.5
            } }
    },
    ["Exotic Season 6 Seed Pack"] = {
        DisplayName = "Exotic Season 6 Seed Pack",
        Icon = "rbxassetid://101748988804829",
        Items = { {
                Type = "Seed",
                RewardId = "Vio Puff",
                Icon = "rbxassetid://124510721353457",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Storm Bulb",
                Icon = "rbxassetid://99500389374423",
                Chance = 29
            }, {
                Type = "Seed",
                RewardId = "Geode Root",
                Icon = "rbxassetid://81350229427183",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Chroma Orb",
                Icon = "rbxassetid://125136735747348",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Polypea Sprout",
                Icon = "rbxassetid://133434061057772",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Volt Lily",
                Icon = "rbxassetid://98784455581752",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Season 6 Seed Pack",
                Icon = "rbxassetid://90419259772348",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Season 6 Seed Pack"] = {
        DisplayName = "Rainbow Exotic Season 6 Seed Pack",
        Icon = "rbxassetid://101748988804829",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Vio Puff",
                Icon = "rbxassetid://124510721353457",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Storm Bulb",
                Icon = "rbxassetid://99500389374423",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Geode Root",
                Icon = "rbxassetid://81350229427183",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Chroma Orb",
                Icon = "rbxassetid://125136735747348",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Polypea Sprout",
                Icon = "rbxassetid://133434061057772",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Volt Lily",
                Icon = "rbxassetid://98784455581752",
                Chance = 7
            } }
    },
    ["Season 7 Seed Pack"] = {
        DisplayName = "Season 7 Seed Pack",
        Icon = "rbxassetid://85337504547922",
        Items = { {
                Type = "Seed",
                RewardId = "Twineberry",
                Icon = "rbxassetid://90625434883271",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Sun Melon",
                Icon = "rbxassetid://98187887015021",
                Chance = 37.5
            }, {
                Type = "Seed",
                RewardId = "Clove",
                Icon = "rbxassetid://86047698303793",
                Chance = 17.5
            }, {
                Type = "Seed",
                RewardId = "Maple Petal",
                Icon = "rbxassetid://107445838588343",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Emberpear",
                Icon = "rbxassetid://84370176355240",
                Chance = 0.5
            } }
    },
    ["Exotic Season 7 Seed Pack"] = {
        DisplayName = "Exotic Season 7 Seed Pack",
        Icon = "rbxassetid://115116729786452",
        Items = { {
                Type = "Seed",
                RewardId = "Twineberry",
                Icon = "rbxassetid://90625434883271",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Sun Melon",
                Icon = "rbxassetid://98187887015021",
                Chance = 36.5
            }, {
                Type = "Seed",
                RewardId = "Clove",
                Icon = "rbxassetid://86047698303793",
                Chance = 17.5
            }, {
                Type = "Seed",
                RewardId = "Maple Petal",
                Icon = "rbxassetid://107445838588343",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Emberpear",
                Icon = "rbxassetid://84370176355240",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Season 7 Seed Pack",
                Icon = "rbxassetid://90419259772348",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Season 7 Seed Pack"] = {
        DisplayName = "Rainbow Exotic Season 7 Seed Pack",
        Icon = "rbxassetid://115116729786452",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Twineberry",
                Icon = "rbxassetid://90625434883271",
                Chance = 35
            }, {
                Type = "RainbowSeed",
                RewardId = "Sun Melon",
                Icon = "rbxassetid://98187887015021",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Clove",
                Icon = "rbxassetid://86047698303793",
                Chance = 19
            }, {
                Type = "RainbowSeed",
                RewardId = "Maple Petal",
                Icon = "rbxassetid://107445838588343",
                Chance = 13
            }, {
                Type = "RainbowSeed",
                RewardId = "Emberpear",
                Icon = "rbxassetid://84370176355240",
                Chance = 8
            } }
    },
    ["Season 8 Seed Pack"] = {
        DisplayName = "Season 8 Seed Pack",
        Icon = "rbxassetid://98082278013963",
        Items = { {
                Type = "Seed",
                RewardId = "Drowse Daisy",
                Icon = "rbxassetid://118715077608227",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Lullaberry",
                Icon = "rbxassetid://113574739737628",
                Chance = 37.5
            }, {
                Type = "Seed",
                RewardId = "Beach Fern",
                Icon = "rbxassetid://108099159174467",
                Chance = 17.5
            }, {
                Type = "Seed",
                RewardId = "Fernberry",
                Icon = "rbxassetid://95824241696833",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Cosmic Dew",
                Icon = "rbxassetid://113230659727200",
                Chance = 0.5
            } }
    },
    ["Exotic Season 8 Seed Pack"] = {
        DisplayName = "Exotic Season 8 Seed Pack",
        Icon = "rbxassetid://137019675967404",
        Items = { {
                Type = "Seed",
                RewardId = "Drowse Daisy",
                Icon = "rbxassetid://118715077608227",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Lullaberry",
                Icon = "rbxassetid://113574739737628",
                Chance = 36.5
            }, {
                Type = "Seed",
                RewardId = "Beach Fern",
                Icon = "rbxassetid://108099159174467",
                Chance = 17.5
            }, {
                Type = "Seed",
                RewardId = "Fernberry",
                Icon = "rbxassetid://95824241696833",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Cosmic Dew",
                Icon = "rbxassetid://113230659727200",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Season 8 Seed Pack",
                Icon = "rbxassetid://90419259772348",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Season 8 Seed Pack"] = {
        DisplayName = "Rainbow Exotic Season 8 Seed Pack",
        Icon = "rbxassetid://115116729786452",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Drowse Daisy",
                Icon = "rbxassetid://118715077608227",
                Chance = 35
            }, {
                Type = "RainbowSeed",
                RewardId = "Lullaberry",
                Icon = "rbxassetid://113574739737628",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Beach Fern",
                Icon = "rbxassetid://108099159174467",
                Chance = 19
            }, {
                Type = "RainbowSeed",
                RewardId = "Fernberry",
                Icon = "rbxassetid://95824241696833",
                Chance = 13
            }, {
                Type = "RainbowSeed",
                RewardId = "Cosmic Dew",
                Icon = "rbxassetid://113230659727200",
                Chance = 8
            } }
    },
    ["Nutty Chest"] = {
        DisplayName = "Nutty Chest",
        Icon = "rbxassetid://107461364188242",
        Items = { {
                Type = "Seed",
                RewardId = "Hazelnut",
                Icon = "rbxassetid://109787439424464",
                Chance = 34.5
            }, {
                Type = "Pet",
                RewardId = "Farmer Chipmunk",
                Icon = "rbxassetid://75410382754350",
                Chance = 34.5
            }, {
                Type = "Seed",
                RewardId = "Persimmon",
                Icon = "rbxassetid://70665514066275",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Idol Chipmunk",
                Icon = "rbxassetid://107956964205378",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Acorn",
                Icon = "rbxassetid://115598356098825",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Chinchilla",
                Icon = "rbxassetid://111612178675697",
                Chance = 1
            } }
    },
    ["Exotic Nutty Chest"] = {
        DisplayName = "Exotic Nutty Chest",
        Icon = "rbxassetid://137941883600072",
        Items = { {
                Type = "Seed",
                RewardId = "Hazelnut",
                Icon = "rbxassetid://109787439424464",
                Chance = 34
            }, {
                Type = "Pet",
                RewardId = "Farmer Chipmunk",
                Icon = "rbxassetid://75410382754350",
                Chance = 34
            }, {
                Type = "Seed",
                RewardId = "Persimmon",
                Icon = "rbxassetid://70665514066275",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Idol Chipmunk",
                Icon = "rbxassetid://107956964205378",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Acorn",
                Icon = "rbxassetid://115598356098825",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Chinchilla",
                Icon = "rbxassetid://111612178675697",
                Chance = 1
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Nutty Chest",
                Icon = "rbxassetid://86723107125634",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Nutty Chest"] = {
        DisplayName = "Rainbow Exotic Nutty Chest",
        Icon = "rbxassetid://86723107125634",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Hazelnut",
                Icon = "rbxassetid://109787439424464",
                Chance = 28
            }, {
                Type = "Pet",
                RewardId = "Rainbow Farmer Chipmunk",
                Icon = "rbxassetid://75410382754350",
                Chance = 28
            }, {
                Type = "RainbowSeed",
                RewardId = "Persimmon",
                Icon = "rbxassetid://70665514066275",
                Chance = 15
            }, {
                Type = "Pet",
                RewardId = "Rainbow Idol Chipmunk",
                Icon = "rbxassetid://107956964205378",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "Acorn",
                Icon = "rbxassetid://115598356098825",
                Chance = 7
            }, {
                Type = "Pet",
                RewardId = "Rainbow Chinchilla",
                Icon = "rbxassetid://111612178675697",
                Chance = 7
            } }
    },
    ["Halloween Gear Box"] = {
        DisplayName = "Halloween Gear Box",
        Icon = "rbxassetid://119699861742142",
        Items = { {
                Type = "Gear",
                RewardId = "Bland Jelly",
                Icon = "rbxassetid://123485266166758",
                Chance = 40
            }, {
                Type = "Gear",
                RewardId = "Dig Trinket",
                Icon = "rbxassetid://94981549567471",
                Chance = 25
            }, {
                Type = "Gear",
                RewardId = "Jack-O-Jelly",
                Icon = "rbxassetid://75168995000522",
                Chance = 25
            }, {
                Type = "Gear",
                RewardId = "Sugar Watering Can",
                Icon = "rbxassetid://112086217100715",
                Chance = 10
            }, {
                Type = "Gear",
                RewardId = "Pumpkin Lollipop",
                Icon = "rbxassetid://121711144046909",
                Chance = 4
            }, {
                Type = "Gear",
                RewardId = "Toffee Tether",
                Icon = "rbxassetid://89308998158046",
                Chance = 1
            } }
    },
    ["Spooky Chest"] = {
        DisplayName = "Spooky Chest",
        Icon = "rbxassetid://130969229332463",
        Items = { {
                Type = "Seed",
                RewardId = "Ghost Bush",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 34.5
            }, {
                Type = "Pet",
                RewardId = "Scarab",
                Chance = 34.5,
                Icon = "rbxassetid://136076341712984"
            }, {
                Type = "Seed",
                RewardId = "Devilroot",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Tomb Marmot",
                Icon = "rbxassetid://99976660992669",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Wereplant",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Mummy",
                Icon = "rbxassetid://106414262511327",
                Chance = 1
            } }
    },
    ["Exotic Spooky Chest"] = {
        DisplayName = "Exotic Spooky Chest",
        Icon = "rbxassetid://128341455133254",
        Items = { {
                Type = "Seed",
                RewardId = "Ghost Bush",
                Icon = "rbxassetid://89461296862154",
                Chance = 34
            }, {
                Type = "Pet",
                RewardId = "Scarab",
                Icon = "rbxassetid://129811000175004",
                Chance = 34
            }, {
                Type = "Seed",
                RewardId = "Devilroot",
                Icon = "rbxassetid://115428593786887",
                Chance = 25
            }, {
                Type = "Pet",
                RewardId = "Tomb Marmot",
                Icon = "rbxassetid://130923289845949",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Wereplant",
                Icon = "rbxassetid://110458015208721",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Mummy",
                Icon = "rbxassetid://109984183023587",
                Chance = 1
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Special Exotic Spooky Chest",
                Icon = "rbxassetid://110835717235166",
                Chance = 1
            } }
    },
    ["Special Exotic Spooky Chest"] = {
        DisplayName = "Special Exotic Spooky Chest",
        Icon = "rbxassetid://110835717235166",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Ghost Bush",
                Icon = "rbxassetid://89461296862154",
                Chance = 28
            }, {
                Type = "Pet",
                RewardId = "Ghostly Scarab",
                Icon = "rbxassetid://112844006603733",
                Chance = 28
            }, {
                Type = "RainbowSeed",
                RewardId = "Devilroot",
                Icon = "rbxassetid://115428593786887",
                Chance = 15
            }, {
                Type = "Pet",
                RewardId = "Ghostly Tomb Marmot",
                Icon = "rbxassetid://108400222651524",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "Wereplant",
                Icon = "rbxassetid://110458015208721",
                Chance = 7
            }, {
                Type = "Pet",
                RewardId = "Ghostly Mummy",
                Icon = "rbxassetid://128554214079406",
                Chance = 7
            } }
    },
    ["Safari Seed Pack"] = {
        DisplayName = "Safari Seed Pack",
        Icon = "rbxassetid://87182398365926",
        Items = { {
                Type = "Seed",
                RewardId = "Daisy",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Bamboo Tree",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Amberfruit Shrub",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Castor Bean",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Java Banana",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Peacock Tail",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Safari Seed Pack"] = {
        DisplayName = "Exotic Safari Seed Pack",
        Icon = "rbxassetid://100966597218737",
        Items = { {
                Type = "Seed",
                RewardId = "Daisy",
                Icon = "rbxassetid://138804049517799",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Bamboo Tree",
                Icon = "rbxassetid://134939186622894",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Amberfruit Shrub",
                Icon = "rbxassetid://92319597519259",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Castor Bean",
                Icon = "rbxassetid://91154044889049",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Java Banana",
                Icon = "rbxassetid://74353075923360",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Peacock Tail",
                Icon = "rbxassetid://92582344140177",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Safari Seed Pack",
                Icon = "rbxassetid://94884022497372",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Safari Seed Pack"] = {
        DisplayName = "Rainbow Exotic Safari Seed Pack",
        Icon = "rbxassetid://94884022497372",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Daisy",
                Icon = "rbxassetid://138804049517799",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Bamboo Tree",
                Icon = "rbxassetid://134939186622894",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Amberfruit Shrub",
                Icon = "rbxassetid://92319597519259",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Castor Bean",
                Icon = "rbxassetid://91154044889049",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Java Banana",
                Icon = "rbxassetid://74353075923360",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Peacock Tail",
                Icon = "rbxassetid://92582344140177",
                Chance = 7
            } }
    },
    ["Gem Chest"] = {
        DisplayName = "Gem Chest",
        Icon = "rbxassetid://91695379919305",
        Items = { {
                Type = "Seed",
                RewardId = "Gem Fruit",
                Icon = "rbxassetid://114595746887236",
                Chance = 34.5
            }, {
                Type = "Pet",
                RewardId = "Clam",
                Chance = 34.5,
                Icon = "rbxassetid://126158801771825"
            }, {
                Type = "Seed",
                RewardId = "Coilvine",
                Icon = "rbxassetid://88542963046850",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Magpie",
                Icon = "rbxassetid://110248321156657",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Asteris",
                Icon = "rbxassetid://113885582006266",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Bearded Dragon",
                Icon = "rbxassetid://138269797006704",
                Chance = 1
            } }
    },
    ["Exotic Gem Chest"] = {
        DisplayName = "Exotic Gem Chest",
        Icon = "rbxassetid://95537920162350",
        Items = { {
                Type = "Seed",
                RewardId = "Gem Fruit",
                Icon = "rbxassetid://121801427908658",
                Chance = 34
            }, {
                Type = "Pet",
                RewardId = "Clam",
                Chance = 34,
                Icon = "rbxassetid://115999998856683"
            }, {
                Type = "Seed",
                RewardId = "Coilvine",
                Icon = "rbxassetid://105351951641002",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Magpie",
                Icon = "rbxassetid://139376566129954",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Asteris",
                Icon = "rbxassetid://134130292574701",
                Chance = 1
            }, {
                Type = "Pet",
                RewardId = "Bearded Dragon",
                Icon = "rbxassetid://130976380531698",
                Chance = 1
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Gem Chest",
                Icon = "rbxassetid://115309330511483",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Gem Chest"] = {
        DisplayName = "Rainbow Exotic Gem Chest",
        Icon = "rbxassetid://115309330511483",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Gem Fruit",
                Icon = "rbxassetid://121801427908658",
                Chance = 28
            }, {
                Type = "Pet",
                RewardId = "Rainbow Clam",
                Chance = 28,
                Icon = "rbxassetid://115999998856683"
            }, {
                Type = "RainbowSeed",
                RewardId = "Coilvine",
                Icon = "rbxassetid://105351951641002",
                Chance = 15
            }, {
                Type = "Pet",
                RewardId = "Rainbow Magpie",
                Icon = "rbxassetid://139376566129954",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "Asteris",
                Icon = "rbxassetid://134130292574701",
                Chance = 7
            }, {
                Type = "Pet",
                RewardId = "Rainbow Bearded Dragon",
                Icon = "rbxassetid://130976380531698",
                Chance = 7
            } }
    },
    ["Artisan Container"] = {
        DisplayName = "Artisan Container",
        Icon = "rbxassetid://70943785703691",
        Rarity = "Divine",
        Items = { {
                Type = "TradeBoothSkin",
                RewardId = "Green",
                Icon = "rbxassetid://91086294684465",
                Chance = 33
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Purple",
                Icon = "rbxassetid://81730682212397",
                Chance = 33
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Toriigate",
                Icon = "rbxassetid://107168764835511",
                Chance = 20.5
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Fairy",
                Icon = "rbxassetid://117155720434253",
                Chance = 12
            }, {
                Type = "TradeBoothSkin",
                RewardId = "DJ",
                Icon = "rbxassetid://101237248829994",
                Chance = 1.5
            } }
    },
    ["Elemental Container"] = {
        DisplayName = "Elemental Container",
        Icon = "rbxassetid://121756457627450",
        Rarity = "Divine",
        Items = { {
                Type = "TradeBoothSkin",
                RewardId = "Blue",
                Icon = "rbxassetid://98175417203754",
                Chance = 33
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Yellow",
                Icon = "rbxassetid://106026174719144",
                Chance = 33
            }, {
                Type = "TradeBoothSkin",
                RewardId = "CherryBlossom",
                Icon = "rbxassetid://100583352441498",
                Chance = 20.5
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Beach",
                Icon = "rbxassetid://138905092934000",
                Chance = 12
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Waterfall",
                Icon = "rbxassetid://87879730769730",
                Chance = 1.5
            } }
    },
    ["Coastal Container"] = {
        DisplayName = "Coastal Container",
        Icon = "rbxassetid://80424099605376",
        Rarity = "Divine",
        Items = { {
                Type = "TradeBoothSkin",
                RewardId = "Umbrella",
                Icon = "rbxassetid://79820267941584",
                Chance = 38
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Coastline",
                Icon = "rbxassetid://105448341915305",
                Chance = 28
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Sandcastle",
                Icon = "rbxassetid://119747804057361",
                Chance = 20.5
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Pirate Cove",
                Icon = "rbxassetid://73803172083777",
                Chance = 12
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Flamingo Floats",
                Icon = "rbxassetid://79834501636649",
                Chance = 1.5
            } }
    },
    ["Buttercup Chest"] = {
        DisplayName = "Buttercup Chest",
        Icon = "rbxassetid://122073426066738",
        Items = { {
                Type = "Seed",
                RewardId = "Big Buttercup",
                Chance = 43.900000000000006,
                Icon = "AUTOMATIC_SEED_ICON"
            }, {
                Type = "Seed",
                RewardId = "Bigger Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Pink Bunny",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "Seed",
                RewardId = "Biggest Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1
            }, {
                Type = "Seed",
                RewardId = "Beast Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.05
            }, {
                Type = "Pack",
                RewardId = "Rainbow Buttercup Chest",
                Icon = "rbxassetid://88222532186302",
                Chance = 0.01
            } }
    },
    ["Rainbow Buttercup Chest"] = {
        DisplayName = "Rainbow Buttercup Chest",
        Icon = "rbxassetid://88222532186302",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Big Buttercup",
                Chance = 43.9,
                Icon = "AUTOMATIC_SEED_ICON"
            }, {
                Type = "RainbowSeed",
                RewardId = "Bigger Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Rainbow Pink Bunny",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "RainbowSeed",
                RewardId = "Biggest Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1
            }, {
                Type = "RainbowSeed",
                RewardId = "Beast Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.05
            } }
    },
    ["Exotic Buttercup Chest"] = {
        DisplayName = "Exotic Buttercup Chest",
        Icon = "rbxassetid://122073426066738",
        Items = { {
                Type = "Seed",
                RewardId = "Big Buttercup",
                Chance = 42.5,
                Icon = "AUTOMATIC_SEED_ICON"
            }, {
                Type = "Seed",
                RewardId = "Bigger Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 26
            }, {
                Type = "Pet",
                RewardId = "Pink Bunny",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Biggest Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 5
            }, {
                Type = "Seed",
                RewardId = "Beast Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Buttercup Chest",
                Icon = "rbxassetid://88222532186302",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Buttercup Chest"] = {
        DisplayName = "Rainbow Exotic Buttercup Chest",
        Icon = "rbxassetid://88222532186302",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Big Buttercup",
                Chance = 43.5,
                Icon = "AUTOMATIC_SEED_ICON"
            }, {
                Type = "RainbowSeed",
                RewardId = "Bigger Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 26
            }, {
                Type = "Pet",
                RewardId = "Rainbow Pink Bunny",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Biggest Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 5
            }, {
                Type = "RainbowSeed",
                RewardId = "Beast Buttercup",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Season Pass Quests"] = {
        Items = { {
                Type = "Currency",
                RewardId = "PassPoints",
                Chance = 40,
                Quantity = 10
            }, {
                Type = "Currency",
                RewardId = "PassPoints",
                Chance = 30,
                Quantity = 20
            }, {
                Type = "Currency",
                RewardId = "PassPoints",
                Chance = 20,
                Quantity = 50
            }, {
                Type = "Gear",
                RewardId = "Silver Lollipop",
                Chance = 5
            }, {
                Type = "Gear",
                RewardId = "Super Watering Can",
                Chance = 5
            }, {
                Type = "Gear",
                RewardId = "Smith Hammer of Harvest",
                Chance = 3
            }, {
                Type = "Gear",
                RewardId = "Grow All",
                Chance = 1
            }, {
                Type = "Gear",
                RewardId = "Energy Chew",
                Chance = 1
            } }
    },
    ["Bad Present"] = {
        DisplayName = "Bad Present",
        Icon = "rbxassetid://108177615581359",
        Items = { {
                Type = "Gear",
                RewardId = "Common Coal",
                Chance = 40.8
            }, {
                Type = "Currency",
                RewardId = "Sheckles",
                Chance = 22.5,
                Quantity = 10000
            }, {
                Type = "Seed",
                RewardId = "Blueberry",
                Chance = 22.5
            }, {
                Type = "Gear",
                RewardId = "Watering Can",
                Chance = 10,
                Quantity = 10
            }, {
                Type = "Gear",
                RewardId = "Divine Coal",
                Chance = 4
            }, {
                Type = "Gear",
                RewardId = "Mega Lollipop",
                Chance = 0.2
            } }
    },
    ["Normal Present"] = {
        DisplayName = "Normal Present",
        Icon = "rbxassetid://117719176415690",
        Items = { {
                Type = "Gear",
                RewardId = "Harvest Tool",
                Chance = 25,
                Quantity = 15
            }, {
                Type = "Gear",
                RewardId = "Event Lantern",
                Chance = 25,
                Quantity = 15
            }, {
                Type = "Gear",
                RewardId = "Reclaimer",
                Chance = 18,
                Quantity = 5
            }, {
                Type = "Gear",
                RewardId = "Small Toy",
                Chance = 15,
                Quantity = 3
            }, {
                Type = "Gear",
                RewardId = "Small Treat",
                Chance = 15,
                Quantity = 3
            }, {
                Type = "Gear",
                RewardId = "Grandmaster Sprinkler",
                Chance = 1
            }, {
                Type = "Gear",
                RewardId = "Levelup Lollipop",
                Chance = 1
            } }
    },
    ["Rare Present"] = {
        DisplayName = "Rare Present",
        Icon = "rbxassetid://122797436062035",
        Items = { {
                Type = "Gear",
                RewardId = "Medium Toy",
                Chance = 39
            }, {
                Type = "Gear",
                RewardId = "Medium Treat",
                Chance = 30
            }, {
                Type = "Gear",
                RewardId = "Large Toy",
                Chance = 12.5
            }, {
                Type = "Gear",
                RewardId = "Super Watering Can",
                Chance = 12.5
            }, {
                Type = "Gear",
                RewardId = "Energy Chew",
                Chance = 4.5
            }, {
                Type = "Gear",
                RewardId = "Gold Lollipop",
                Chance = 0.5
            } }
    },
    ["Christmas Present"] = {
        DisplayName = "Christmas Present",
        Icon = "rbxassetid://140421144773849",
        Items = { {
                Type = "Gear",
                RewardId = "Christmas Sprinkler",
                Chance = 39.5
            }, {
                Type = "Cosmetic",
                RewardId = "Christmas Tree Painting",
                Chance = 30
            }, {
                Type = "Gear",
                RewardId = "Areaclaimer",
                Chance = 20
            }, {
                Type = "Cosmetic",
                RewardId = "Candycane Fence",
                Chance = 5
            }, {
                Type = "Cosmetic",
                RewardId = "Elf Chair",
                Chance = 5
            }, {
                Type = "Gear",
                RewardId = "Pet Shard Nocturnal",
                Chance = 0.5
            } }
    },
    ["Santa\'s Surprise Present"] = {
        DisplayName = "Santa\'s Surprise Present",
        Icon = "rbxassetid://124932982630950",
        Items = { {
                Type = "Seed",
                RewardId = "Cookie Stack",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 24.225
            }, {
                Type = "Seed",
                RewardId = "Poinsettia",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "Seed",
                RewardId = "Antlerbloom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "Seed",
                RewardId = "Holly Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 2.5
            }, {
                Type = "Seed",
                RewardId = "Gift Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Snow Bunny",
                Chance = 24.225,
                Icon = "rbxassetid://112502221623955"
            }, {
                Type = "Pet",
                RewardId = "French Hen",
                Chance = 15,
                Icon = "rbxassetid://75216061202060"
            }, {
                Type = "Pet",
                RewardId = "Christmas Gorilla",
                Chance = 8,
                Icon = "rbxassetid://110392142867903"
            }, {
                Type = "Pet",
                RewardId = "Mistletoad",
                Chance = 2.5,
                Icon = "rbxassetid://77684525109548"
            }, {
                Type = "Pet",
                RewardId = "Krampus",
                Chance = 0.05,
                Icon = "rbxassetid://85324315800558"
            } }
    },
    ["Exotic Santa\'s Surprise Present"] = {
        DisplayName = "Exotic Santa\'s Surprise Present",
        Icon = "rbxassetid://86431264893709",
        Items = {
            {
                Type = "Seed",
                RewardId = "Cookie Stack",
                Icon = "rbxassetid://95614998789534",
                Chance = 23.5
            },
            {
                Type = "Pet",
                RewardId = "Snow Bunny",
                Chance = 23.5,
                Icon = "rbxassetid://87880212796520"
            },
            {
                Type = "Seed",
                RewardId = "Poinsettia",
                Icon = "rbxassetid://74064121845349",
                Chance = 15
            },
            {
                Type = "Pet",
                RewardId = "French Hen",
                Chance = 15,
                Icon = "rbxassetid://99623793770709"
            },
            {
                Type = "Seed",
                RewardId = "Antlerbloom",
                Icon = "rbxassetid://117900418806654",
                Chance = 8
            },
            {
                Type = "Pet",
                RewardId = "Christmas Gorilla",
                Chance = 8,
                Icon = "rbxassetid://117550228795797"
            },
            {
                Type = "Seed",
                RewardId = "Holly Berry",
                Icon = "rbxassetid://132582203488703",
                Chance = 2.5
            },
            {
                Type = "Pet",
                RewardId = "Mistletoad",
                Chance = 2.5,
                Icon = "rbxassetid://85173745103378"
            },
            {
                Type = "Seed",
                RewardId = "Gift Berry",
                Icon = "rbxassetid://115656624815881",
                Chance = 0.5
            },
            {
                Type = "Pet",
                RewardId = "Krampus",
                Chance = 0.5,
                Icon = "rbxassetid://140396704438382"
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Santa\'s Surprise Present",
                Icon = "rbxassetid://130913316923791",
                Chance = 1
            }
        }
    },
    ["Rainbow Exotic Santa\'s Surprise Present"] = {
        DisplayName = "Rainbow Exotic Santa\'s Surprise Present",
        Icon = "rbxassetid://130913316923791",
        Items = {
            {
                Type = "RainbowSeed",
                RewardId = "Cookie Stack",
                Icon = "rbxassetid://95614998789534",
                Chance = 14
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Snow Bunny",
                Chance = 14,
                Icon = "rbxassetid://87880212796520"
            },
            {
                Type = "RainbowSeed",
                RewardId = "Poinsettia",
                Icon = "rbxassetid://74064121845349",
                Chance = 14
            },
            {
                Type = "Pet",
                RewardId = "Rainbow French Hen",
                Chance = 14,
                Icon = "rbxassetid://99623793770709"
            },
            {
                Type = "RainbowSeed",
                RewardId = "Antlerbloom",
                Icon = "rbxassetid://117900418806654",
                Chance = 10
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Christmas Gorilla",
                Chance = 10,
                Icon = "rbxassetid://117550228795797"
            },
            {
                Type = "RainbowSeed",
                RewardId = "Holly Berry",
                Icon = "rbxassetid://132582203488703",
                Chance = 7
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Mistletoad",
                Chance = 7,
                Icon = "rbxassetid://85173745103378"
            },
            {
                Type = "RainbowSeed",
                RewardId = "Gift Berry",
                Icon = "rbxassetid://115656624815881",
                Chance = 3
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Krampus",
                Chance = 3,
                Icon = "rbxassetid://140396704438382"
            }
        }
    },
    ["Holiday Seed Pack"] = {
        DisplayName = "Holiday Seed Pack",
        Icon = "rbxassetid://81386900626608",
        Items = { {
                Type = "Seed",
                RewardId = "Frosty Bite",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Cryo Rose",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Bush Flake",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Rosemary",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Cryoshard",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Frostwing",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Holiday Seed Pack"] = {
        DisplayName = "Exotic Holiday Seed Pack",
        Icon = "rbxassetid://140584271040170",
        Items = { {
                Type = "Seed",
                RewardId = "Frosty Bite",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Cryo Rose",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Bush Flake",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Rosemary",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Cryoshard",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Frostwing",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Holiday Seed Pack",
                Icon = "rbxassetid://6937742258",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Holiday Seed Pack"] = {
        DisplayName = "Rainbow Exotic Holiday Seed Pack",
        Icon = "rbxassetid://90419259772348",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Frosty Bite",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Cryo Rose",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Bush Flake",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Rosemary",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Cryoshard",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Frostwing",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            } }
    },
    ["Common Gift"] = {
        DisplayName = "Common Gift",
        Icon = "rbxassetid://73779491860540",
        Items = { {
                Type = "Gear",
                RewardId = "Common Coal",
                Chance = 15,
                Quantity = 3
            }, {
                Type = "Gear",
                RewardId = "Event Lantern",
                Chance = 15,
                Quantity = 10
            }, {
                Type = "Gear",
                RewardId = "Watering Can",
                Chance = 15,
                Quantity = 10
            }, {
                Type = "Gear",
                RewardId = "Snow Shovel",
                Chance = 15,
                Quantity = 2
            }, {
                Type = "Seed",
                RewardId = "Peppermint Pop",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "Egg",
                RewardId = "Christmas Egg",
                Chance = 10,
                Icon = "rbxassetid://115418732043570"
            } }
    },
    ["Rare Gift"] = {
        DisplayName = "Rare Gift",
        Icon = "rbxassetid://126058719875973",
        Items = { {
                Type = "Seed",
                RewardId = "Peppermint Pop",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "Gear",
                RewardId = "Small Toy",
                Chance = 15,
                Quantity = 3
            }, {
                Type = "Gear",
                RewardId = "Harvest Tool",
                Chance = 15,
                Quantity = 3
            }, {
                Type = "Gear",
                RewardId = "Event Lantern",
                Chance = 15,
                Quantity = 10
            }, {
                Type = "Egg",
                RewardId = "Christmas Egg",
                Chance = 15,
                Icon = "rbxassetid://115418732043570"
            }, {
                Type = "Gear",
                RewardId = "Areaclaimer",
                Chance = 10
            }, {
                Type = "Pet",
                RewardId = "Pine Beetle",
                Chance = 5,
                Icon = "rbxassetid://75825040212585"
            }, {
                Type = "Gear",
                RewardId = "Levelup Lollipop",
                Chance = 5
            } }
    },
    ["Mythical Gift"] = {
        DisplayName = "Mythical Gift",
        Icon = "rbxassetid://131003341827982",
        Items = { {
                Type = "Egg",
                RewardId = "Christmas Egg",
                Chance = 20,
                Icon = "rbxassetid://115418732043570"
            }, {
                Type = "Gear",
                RewardId = "Medium Treat",
                Chance = 15,
                Quantity = 2
            }, {
                Type = "Gear",
                RewardId = "Medium Toy",
                Chance = 15,
                Quantity = 2
            }, {
                Type = "Seed",
                RewardId = "Gumdrop",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "Pet",
                RewardId = "Pine Beetle",
                Chance = 15,
                Icon = "rbxassetid://75825040212585"
            }, {
                Type = "Gear",
                RewardId = "Areaclaimer",
                Chance = 10
            }, {
                Type = "Gear",
                RewardId = "Christmas Sprinkler",
                Chance = 10
            }, {
                Type = "Pet",
                RewardId = "Eggnog Chick",
                Chance = 2.5,
                Icon = "rbxassetid://126741514840786"
            } }
    },
    ["Gold Gift"] = {
        DisplayName = "Gold Gift",
        Icon = "rbxassetid://106997108428712",
        Items = { {
                Type = "Seed",
                RewardId = "Gumdrop",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "Egg",
                RewardId = "Christmas Egg",
                Chance = 25,
                Icon = "rbxassetid://115418732043570"
            }, {
                Type = "Gear",
                RewardId = "Areaclaimer",
                Chance = 10
            }, {
                Type = "Gear",
                RewardId = "Christmas Sprinkler",
                Chance = 10
            }, {
                Type = "Gear",
                RewardId = "Large Toy",
                Chance = 10
            }, {
                Type = "Gear",
                RewardId = "Christmas Treat",
                Chance = 10
            }, {
                Type = "Gear",
                RewardId = "Mystical Snow Globe",
                Chance = 10
            }, {
                Type = "Pet",
                RewardId = "Eggnog Chick",
                Chance = 10,
                Icon = "rbxassetid://126741514840786"
            }, {
                Type = "Seed",
                RewardId = "Christmas Cracker",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 2.5
            }, {
                Type = "Pet",
                RewardId = "Cocoa Cat",
                Chance = 2.5,
                Icon = "rbxassetid://122859185994067"
            } }
    },
    ["Rainbow Gift"] = {
        DisplayName = "Rainbow Gift",
        Icon = "rbxassetid://87807905601089",
        Items = { {
                Type = "Egg",
                RewardId = "Christmas Egg",
                Chance = 50,
                Icon = "rbxassetid://115418732043570"
            }, {
                Type = "Gear",
                RewardId = "Christmas Treat",
                Chance = 15
            }, {
                Type = "Gear",
                RewardId = "Large Toy",
                Chance = 15
            }, {
                Type = "Gear",
                RewardId = "Mystical Snow Globe",
                Chance = 15
            }, {
                Type = "Gear",
                RewardId = "Levelup Lollipop",
                Chance = 15
            }, {
                Type = "Gear",
                RewardId = "Grandmaster Sprinkler",
                Chance = 15
            }, {
                Type = "Seed",
                RewardId = "Christmas Cracker",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Pet",
                RewardId = "Cocoa Cat",
                Chance = 10,
                Icon = "rbxassetid://122859185994067"
            } }
    },
    ["Festive Container"] = {
        DisplayName = "Festive Container",
        Icon = "rbxassetid://132762949419959",
        Items = { {
                Type = "TradeBoothSkin",
                RewardId = "Sleigh",
                Icon = "rbxassetid://85059208973593",
                Chance = 33
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Candy Cane",
                Icon = "rbxassetid://130737222569939",
                Chance = 33
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Festive",
                Icon = "rbxassetid://118036207499114",
                Chance = 20.5
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Snowy",
                Icon = "rbxassetid://105773049174678",
                Chance = 12
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Present",
                Icon = "rbxassetid://103157401366735",
                Chance = 1.5
            } }
    },
    ["Admin Pack"] = {
        DisplayName = "Admin Pack",
        Icon = "rbxassetid://117137411879749",
        Items = {
            {
                Type = "Egg",
                RewardId = "Common Egg",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10.09
            },
            {
                Type = "Egg",
                RewardId = "Uncommon Egg",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            },
            {
                Type = "Seed",
                RewardId = "Grape",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            },
            {
                Type = "Gear",
                RewardId = "Advanced Sprinkler",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            },
            {
                Type = "Egg",
                RewardId = "Rare Egg",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            },
            {
                Type = "Seed",
                RewardId = "Beanstalk",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 6
            },
            {
                Type = "Gear",
                RewardId = "Levelup Lollipop",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 6
            },
            {
                Type = "Seed",
                RewardId = "Sugar Apple",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 5
            },
            {
                Type = "Gear",
                RewardId = "Godly Sprinkler",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 5
            },
            {
                Type = "Seed",
                RewardId = "Ember Lily",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            },
            {
                Type = "Seed",
                RewardId = "Burning Bud",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            },
            {
                Type = "Egg",
                RewardId = "Legendary Egg",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4
            },
            {
                Type = "Gear",
                RewardId = "Master Sprinkler",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 2.5
            },
            {
                Type = "Egg",
                RewardId = "Mythical Egg",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 2
            },
            {
                Type = "Egg",
                RewardId = "Bug Egg",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 2
            },
            {
                Type = "Seed",
                RewardId = "Giant Pinecone",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1.6
            },
            {
                Type = "Seed",
                RewardId = "Elder Strawberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1.6
            },
            {
                Type = "Egg",
                RewardId = "Jungle Egg",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1.4
            },
            {
                Type = "Seed",
                RewardId = "Romanesco",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1.2
            },
            {
                Type = "Gear",
                RewardId = "Grandmaster Sprinkler",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1
            },
            {
                Type = "Seed",
                RewardId = "Crimson Thorn",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.2
            },
            {
                Type = "Seed",
                RewardId = "Zebrazinkle",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.05
            },
            {
                Type = "Seed",
                RewardId = "Octobloom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.01
            }
        }
    },
    ["Easter Seed Pack"] = {
        DisplayName = "Easter Seed Pack",
        Icon = "rbxassetid://71178703811950",
        Items = { {
                Type = "Seed",
                RewardId = "Candy Carrot",
                Icon = "rbxassetid://103789872431604",
                Chance = 31
            }, {
                Type = "Seed",
                RewardId = "Chocolate Berry",
                Icon = "rbxassetid://102387828269945",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Gumball",
                Icon = "rbxassetid://105517298469321",
                Chance = 15
            }, {
                Type = "Seed",
                RewardId = "Sugar Melon",
                Icon = "rbxassetid://108731244332988",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Liquorice",
                Icon = "rbxassetid://87512076978193",
                Chance = 8
            }, {
                Type = "Seed",
                RewardId = "Chocolate Coconut",
                Icon = "rbxassetid://101588775475466",
                Chance = 7
            }, {
                Type = "Seed",
                RewardId = "Gummy Cactus",
                Icon = "rbxassetid://129716679636430",
                Chance = 5
            }, {
                Type = "Seed",
                RewardId = "Sour Lemon",
                Icon = "rbxassetid://112345513860988",
                Chance = 3.5
            }, {
                Type = "Seed",
                RewardId = "Eggfruit",
                Icon = "rbxassetid://102516543124826",
                Chance = 0.5
            } }
    },
    ["Exotic Easter Seed Pack"] = {
        DisplayName = "Exotic Easter Seed Pack",
        Icon = "rbxassetid://106253859430622",
        Items = {
            {
                Type = "Seed",
                RewardId = "Candy Carrot",
                Icon = "rbxassetid://103789872431604",
                Chance = 30
            },
            {
                Type = "Seed",
                RewardId = "Chocolate Berry",
                Icon = "rbxassetid://102387828269945",
                Chance = 20
            },
            {
                Type = "Seed",
                RewardId = "Gumball",
                Icon = "rbxassetid://105517298469321",
                Chance = 15
            },
            {
                Type = "Seed",
                RewardId = "Sugar Melon",
                Icon = "rbxassetid://108731244332988",
                Chance = 10
            },
            {
                Type = "Seed",
                RewardId = "Liquorice",
                Icon = "rbxassetid://87512076978193",
                Chance = 8
            },
            {
                Type = "Seed",
                RewardId = "Chocolate Coconut",
                Icon = "rbxassetid://101588775475466",
                Chance = 7
            },
            {
                Type = "Seed",
                RewardId = "Gummy Cactus",
                Icon = "rbxassetid://129716679636430",
                Chance = 5
            },
            {
                Type = "Seed",
                RewardId = "Sour Lemon",
                Icon = "rbxassetid://112345513860988",
                Chance = 3.5
            },
            {
                Type = "Seed",
                RewardId = "Eggfruit",
                Icon = "rbxassetid://102516543124826",
                Chance = 0.5
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Easter Seed Pack",
                Icon = "rbxassetid://92542235146045",
                Chance = 1
            }
        }
    },
    ["Rainbow Exotic Easter Seed Pack"] = {
        DisplayName = "Rainbow Exotic Easter Seed Pack",
        Icon = "rbxassetid://92542235146045",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Candy Carrot",
                Icon = "rbxassetid://103789872431604",
                Chance = 21
            }, {
                Type = "RainbowSeed",
                RewardId = "Chocolate Berry",
                Icon = "rbxassetid://102387828269945",
                Chance = 16
            }, {
                Type = "RainbowSeed",
                RewardId = "Gumball",
                Icon = "rbxassetid://105517298469321",
                Chance = 13
            }, {
                Type = "RainbowSeed",
                RewardId = "Sugar Melon",
                Icon = "rbxassetid://108731244332988",
                Chance = 11
            }, {
                Type = "RainbowSeed",
                RewardId = "Liquorice",
                Icon = "rbxassetid://87512076978193",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Chocolate Coconut",
                Icon = "rbxassetid://101588775475466",
                Chance = 9
            }, {
                Type = "RainbowSeed",
                RewardId = "Gummy Cactus",
                Icon = "rbxassetid://129716679636430",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Sour Lemon",
                Icon = "rbxassetid://112345513860988",
                Chance = 7
            }, {
                Type = "RainbowSeed",
                RewardId = "Eggfruit",
                Icon = "rbxassetid://102516543124826",
                Chance = 5
            } }
    },
    ["Honey Hive Seed Pack"] = {
        DisplayName = "Honey Hive Seed Pack",
        Icon = "rbxassetid://124639853459024",
        Rarity = "Rare",
        Description = "A pack of hive-grown seeds from the Bizzy Bee event. Open it for a chance at Honey Stingpetal, Honey Woodbine and other bee-themed plants.",
        Items = { {
                Type = "Seed",
                RewardId = "Honey Stingpetal",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Honey Woodbine",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Honey Honey Dipper",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Honey Bee Bell",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Honey Hive Petal",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Honey Bumble Bulb",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Hive Seed Pack"] = {
        DisplayName = "Hive Seed Pack",
        Icon = "rbxassetid://124639853459024",
        Items = { {
                Type = "Seed",
                RewardId = "Stingpetal",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Woodbine",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Honey Dipper",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Bee Bell",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Hive Petal",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Bumble Bulb",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Hive Seed Pack"] = {
        DisplayName = "Exotic Hive Seed Pack",
        Icon = "rbxassetid://105049574187239",
        Items = { {
                Type = "Seed",
                RewardId = "Stingpetal",
                Icon = "rbxassetid://133812979736761",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Woodbine",
                Icon = "rbxassetid://117227500599419",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Honey Dipper",
                Icon = "rbxassetid://117340176720813",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Bee Bell",
                Icon = "rbxassetid://77203071972876",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Hive Petal",
                Icon = "rbxassetid://75516542074057",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Bumble Bulb",
                Icon = "rbxassetid://97036710414425",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Hive Seed Pack",
                Icon = "rbxassetid://80361028114189",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Hive Seed Pack"] = {
        DisplayName = "Rainbow Exotic Hive Seed Pack",
        Icon = "rbxassetid://105049574187239",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Stingpetal",
                Icon = "rbxassetid://133812979736761",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Woodbine",
                Icon = "rbxassetid://117227500599419",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Honey Dipper",
                Icon = "rbxassetid://117340176720813",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Bee Bell",
                Icon = "rbxassetid://77203071972876",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Hive Petal",
                Icon = "rbxassetid://75516542074057",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Bumble Bulb",
                Icon = "rbxassetid://97036710414425",
                Chance = 7
            } }
    },
    ["Campfire Seed Pack"] = {
        DisplayName = "Campfire Seed Pack",
        Icon = "rbxassetid://115959550266845",
        Items = { {
                Type = "Seed",
                RewardId = "Bear Claw Flower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Venus Beartrap",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Flame Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Smore Suckle",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Campfire Clover",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Mallow Melt",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Campfire Seed Pack"] = {
        DisplayName = "Exotic Campfire Seed Pack",
        Icon = "rbxassetid://79020900401643",
        Items = { {
                Type = "Seed",
                RewardId = "Bear Claw Flower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Venus Beartrap",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Flame Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Smore Suckle",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Campfire Clover",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Mallow Melt",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Campfire Seed Pack",
                Icon = "rbxassetid://118460622911586",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Campfire Seed Pack"] = {
        DisplayName = "Rainbow Exotic Campfire Seed Pack",
        Icon = "rbxassetid://115959550266845",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Bear Claw Flower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Venus Beartrap",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Flame Berry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Smore Suckle",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Campfire Clover",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Mallow Melt",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            } }
    },
    ["Coastal Seed Pack"] = {
        DisplayName = "Coastal Seed Pack",
        Icon = "rbxassetid://115116102426315",
        Items = { {
                Type = "Seed",
                RewardId = "Sunshade Flower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Beach Ball Cactus",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Sand Pail Shrub",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Pool Noodle",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Sun Fruit",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Shark Splash",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Coastal Seed Pack"] = {
        DisplayName = "Exotic Coastal Seed Pack",
        Icon = "rbxassetid://84893373539727",
        Items = { {
                Type = "Seed",
                RewardId = "Sunshade Flower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Beach Ball Cactus",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Sand Pail Shrub",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Pool Noodle",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Sun Fruit",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Shark Splash",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Coastal Seed Pack",
                Icon = "rbxassetid://109949804848416",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Coastal Seed Pack"] = {
        DisplayName = "Rainbow Exotic Coastal Seed Pack",
        Icon = "rbxassetid://109949804848416",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Sunshade Flower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Beach Ball Cactus",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Sand Pail Shrub",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Pool Noodle",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Sun Fruit",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Shark Splash",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            } }
    },
    ["Moon Chest"] = {
        DisplayName = "Moon Chest",
        Icon = "rbxassetid://95049054664561",
        Items = { {
                Type = "Seed",
                RewardId = "Crescent Petal",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Moon Snail",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Strange Man\'s Wheat",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Anglerfish",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Luna Bloom",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Wise Owl",
                Chance = 0.5
            } }
    },
    ["Exotic Moon Chest"] = {
        DisplayName = "Exotic Moon Chest",
        Icon = "rbxassetid://77848669662230",
        Items = { {
                Type = "Seed",
                RewardId = "Crescent Petal",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Moon Snail",
                Icon = "rbxassetid://98417972285882",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Strange Man\'s Wheat",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Anglerfish",
                Icon = "rbxassetid://108579879296863",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Luna Bloom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Wise Owl",
                Icon = "rbxassetid://100843545783263",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Moon Chest",
                Icon = "rbxassetid://104509354199420",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Moon Chest"] = {
        DisplayName = "Rainbow Exotic Moon Chest",
        Icon = "rbxassetid://104509354199420",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Crescent Petal",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Rainbow Moon Snail",
                Chance = 35
            }, {
                Type = "RainbowSeed",
                RewardId = "Strange Man\'s Wheat",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Rainbow Anglerfish",
                Chance = 14.5
            }, {
                Type = "RainbowSeed",
                RewardId = "Luna Bloom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Rainbow Wise Owl",
                Chance = 0.5
            } }
    },
    ["Beanpod Chest"] = {
        DisplayName = "Beanpod Chest",
        Icon = "rbxassetid://105180597867762",
        Items = { {
                Type = "Seed",
                RewardId = "Fableflower",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Sheep",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Harpvine",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Cloud Hound",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Elder Beanstalk",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Chest Mimic",
                Chance = 0.5
            } }
    },
    ["Exotic Beanpod Chest"] = {
        DisplayName = "Exotic Beanpod Chest",
        Icon = "rbxassetid://105180597867762",
        Items = { {
                Type = "Seed",
                RewardId = "Fableflower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Sheep",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Harpvine",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Cloud Hound",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Elder Beanstalk",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Chest Mimic",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Beanpod Chest",
                Icon = "rbxassetid://70649692401667",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Beanpod Chest"] = {
        DisplayName = "Rainbow Exotic Beanpod Chest",
        Icon = "rbxassetid://70649692401667",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Fableflower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Rainbow Sheep",
                Chance = 35
            }, {
                Type = "RainbowSeed",
                RewardId = "Harpvine",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Rainbow Cloud Hound",
                Chance = 14.5
            }, {
                Type = "RainbowSeed",
                RewardId = "Elder Beanstalk",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Rainbow Chest Mimic",
                Chance = 0.5
            } }
    },
    ["Autumn Seed Pack"] = {
        DisplayName = "Autumn Seed Pack",
        Icon = "rbxassetid://72474210523135",
        Items = { {
                Type = "Seed",
                RewardId = "Chestnut",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 40
            }, {
                Type = "Seed",
                RewardId = "Emberbloom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Russet Root",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Fall Cauliflower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Grain Lily",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Autumn Apple",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Autumn Seed Pack"] = {
        DisplayName = "Exotic Autumn Seed Pack",
        Icon = "rbxassetid://138017570890610",
        Items = { {
                Type = "Seed",
                RewardId = "Chestnut",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 39
            }, {
                Type = "Seed",
                RewardId = "Emberbloom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "Seed",
                RewardId = "Russet Root",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "Seed",
                RewardId = "Fall Cauliflower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Grain Lily",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 4.5
            }, {
                Type = "Seed",
                RewardId = "Autumn Apple",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Autumn Seed Pack",
                Icon = "rbxassetid://109949804848416",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Autumn Seed Pack"] = {
        DisplayName = "Rainbow Exotic Autumn Seed Pack",
        Icon = "rbxassetid://126070645230356",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Chestnut",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "RainbowSeed",
                RewardId = "Emberbloom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 25
            }, {
                Type = "RainbowSeed",
                RewardId = "Russet Root",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 20
            }, {
                Type = "RainbowSeed",
                RewardId = "Fall Cauliflower",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Grain Lily",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Autumn Apple",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            } }
    },
    ["Fairy Chest"] = {
        DisplayName = "Fairy Chest",
        Icon = "rbxassetid://109666713657573",
        Items = { {
                Type = "Seed",
                RewardId = "Jellycap",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Wolpertinger",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Glimmervine",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Redcap",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Prism Plume",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Manticore",
                Chance = 0.5
            } }
    },
    ["Exotic Fairy Chest"] = {
        DisplayName = "Exotic Fairy Chest",
        Icon = "rbxassetid://109666713657573",
        Items = { {
                Type = "Seed",
                RewardId = "Jellycap",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Wolpertinger",
                Chance = 35
            }, {
                Type = "Seed",
                RewardId = "Glimmervine",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Redcap",
                Chance = 14.5
            }, {
                Type = "Seed",
                RewardId = "Prism Plume",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Manticore",
                Chance = 0.5
            }, {
                Type = "Pack",
                RewardId = "Rainbow Exotic Fairy Chest",
                Icon = "rbxassetid://132599221802713",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Fairy Chest"] = {
        DisplayName = "Rainbow Exotic Fairy Chest",
        Icon = "rbxassetid://132599221802713",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Jellycap",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 35
            }, {
                Type = "Pet",
                RewardId = "Rainbow Wolpertinger",
                Chance = 35
            }, {
                Type = "RainbowSeed",
                RewardId = "Glimmervine",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 14.5
            }, {
                Type = "Pet",
                RewardId = "Rainbow Redcap",
                Chance = 14.5
            }, {
                Type = "RainbowSeed",
                RewardId = "Prism Plume",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pet",
                RewardId = "Rainbow Manticore",
                Chance = 0.5
            } }
    },
    ["Fairy Gear Box"] = {
        DisplayName = "Fairy Gear Box",
        Icon = "rbxassetid://108180173373173",
        Items = { {
                Type = "Gear",
                RewardId = "Fairy Caller",
                Icon = "rbxassetid://91757592448950",
                Chance = 21.5
            }, {
                Type = "Gear",
                RewardId = "Fairy Targeter",
                Icon = "rbxassetid://120586018702719",
                Chance = 17
            }, {
                Type = "Gear",
                RewardId = "Fairy Power Extender",
                Icon = "rbxassetid://124645530618939",
                Chance = 15
            }, {
                Type = "Gear",
                RewardId = "Glimmering Radar",
                Icon = "rbxassetid://102770681711135",
                Chance = 12
            }, {
                Type = "Gear",
                RewardId = "Fairy Jar",
                Icon = "rbxassetid://96168603825271",
                Chance = 12
            }, {
                Type = "Gear",
                RewardId = "Fairy Summoner",
                Icon = "rbxassetid://70923644117541",
                Chance = 9
            }, {
                Type = "Gear",
                RewardId = "Fairy Bell",
                Icon = "rbxassetid://123186545717412",
                Chance = 8
            }, {
                Type = "Gear",
                RewardId = "Luminous Wand",
                Icon = "rbxassetid://77498741936491",
                Chance = 5
            }, {
                Type = "Gear",
                RewardId = "Pet Shard Glimmering",
                Icon = "rbxassetid://125506626001248",
                Chance = 0.5
            } }
    },
    ["Haunted Seed Pack"] = {
        DisplayName = "Haunted Seed Pack",
        Icon = "rbxassetid://94186259568748",
        Items = { {
                Type = "Seed",
                RewardId = "Candy Corn Carrot",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 31
            }, {
                Type = "Seed",
                RewardId = "Spider Shrub",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 22
            }, {
                Type = "Seed",
                RewardId = "Pumpkin Lantern",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "Seed",
                RewardId = "Candy Cluster",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Witch\'s Broom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "Seed",
                RewardId = "Webberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            }, {
                Type = "Seed",
                RewardId = "Blood Kiwi",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 5
            }, {
                Type = "Seed",
                RewardId = "Fang Root",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1.5
            }, {
                Type = "Seed",
                RewardId = "Haunted Hallow",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            } }
    },
    ["Exotic Haunted Seed Pack"] = {
        DisplayName = "Exotic Haunted Seed Pack",
        Icon = "rbxassetid://113291665467789",
        Items = { {
                Type = "Seed",
                RewardId = "Candy Corn Carrot",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 30
            }, {
                Type = "Seed",
                RewardId = "Spider Shrub",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 22
            }, {
                Type = "Seed",
                RewardId = "Pumpkin Lantern",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 15
            }, {
                Type = "Seed",
                RewardId = "Candy Cluster",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "Seed",
                RewardId = "Witch\'s Broom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "Seed",
                RewardId = "Webberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            }, {
                Type = "Seed",
                RewardId = "Blood Kiwi",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 5
            }, {
                Type = "Seed",
                RewardId = "Fang Root",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 1.5
            }, {
                Type = "Seed",
                RewardId = "Haunted Hallow",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 0.5
            }, {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Haunted Seed Pack",
                Icon = "rbxassetid://119712680131728",
                Chance = 1
            } }
    },
    ["Rainbow Exotic Haunted Seed Pack"] = {
        DisplayName = "Rainbow Exotic Haunted Seed Pack",
        Icon = "rbxassetid://119712680131728",
        Items = { {
                Type = "RainbowSeed",
                RewardId = "Candy Corn Carrot",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 21
            }, {
                Type = "RainbowSeed",
                RewardId = "Spider Shrub",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 16
            }, {
                Type = "RainbowSeed",
                RewardId = "Pumpkin Lantern",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 13
            }, {
                Type = "RainbowSeed",
                RewardId = "Candy Cluster",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 11
            }, {
                Type = "RainbowSeed",
                RewardId = "Witch\'s Broom",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 10
            }, {
                Type = "RainbowSeed",
                RewardId = "Webberry",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 9
            }, {
                Type = "RainbowSeed",
                RewardId = "Blood Kiwi",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 8
            }, {
                Type = "RainbowSeed",
                RewardId = "Fang Root",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 7
            }, {
                Type = "RainbowSeed",
                RewardId = "Haunted Hallow",
                Icon = "AUTOMATIC_SEED_ICON",
                Chance = 5
            } }
    },
    ["Halloween Gear Box 2026"] = {
        DisplayName = "Halloween Gear Box 2026",
        Icon = "rbxassetid://119699861742142",
        Items = { {
                Type = "Gear",
                RewardId = "Bland Jelly",
                Icon = "rbxassetid://123485266166758",
                Chance = 45
            }, {
                Type = "Gear",
                RewardId = "Jack-O-Jelly",
                Icon = "rbxassetid://75168995000522",
                Chance = 35
            }, {
                Type = "Gear",
                RewardId = "Sugar Watering Can",
                Icon = "rbxassetid://112086217100715",
                Chance = 14
            }, {
                Type = "Gear",
                RewardId = "Pumpkin Lollipop",
                Icon = "rbxassetid://121711144046909",
                Chance = 5
            }, {
                Type = "Gear",
                RewardId = "Toffee Tether",
                Icon = "rbxassetid://89308998158046",
                Chance = 1
            } }
    }
});
local v5 = {
    Packs = table_freeze_ret,

    GetTextDisplayForItem = function(p1: table, p2: table) -- Line: 6869, Name: GetTextDisplayForItem
        -- upvalues: ReplicatedStorage (copy)
        local v3 = p2.Type == "TradeBoothSkin" and require(ReplicatedStorage.Data.TradeBoothSkinRegistry)[p2.RewardId];

        if v3 then
            return v3.DisplayName;
        end;

        local v4 = not p2.Quantity and "" or ` x{p2.Quantity}`;

        if p2.DisplayName then
            return `{p2.DisplayName}{v4}`;
        end;

        return `{p2.RewardId}{v4}`;
    end
};

if RunService:IsStudio() and RunService:IsServer() then
    for i, v in table_freeze_ret do
        if string.find(i, "Rainbow") then
            for _, v2 in v.Items do
                local _ = v2.Type == "Seed";
            end;
        end;
    end;
end;

local PetList = require(ReplicatedStorage.Data.PetRegistry.PetList);

for _, v in table_freeze_ret do
    for _, v2 in v.Items do
        if (v2.Type == "Seed" or (v2.Type == "RainbowSeed" or v2.Type == "SilverSeed")) and v2.Icon == "AUTOMATIC_SEED_ICON" then
            local v6 = SeedData[v2.RewardId];
            v2.Icon = not v6 and "rbxassetid://6937742258" or v6.Asset;
        elseif v2.Type == "Pet" and v2.Icon == "AUTOMATIC_SEED_ICON" then
            local v7 = PetList[v2.RewardId];

            if v7 then
                v2.Icon = v7.Icon;
            end;
        end;
    end;
end;

return v5;