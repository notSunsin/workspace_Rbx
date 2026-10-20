-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Types.PetTypes);
local v1 = {
    Shocked = {
        EnumId = "a",
        AvaliableFromMutationMachine = true,
        Chance = 10,
        ValueMulti = 100,
        Boosts = {},
        Passives = { "Shocked Pet Mutation" },
        Color = Color3.fromRGB(255, 255, 100)
    },
    Golden = {
        EnumId = "b",
        AvaliableFromMutationMachine = true,
        Chance = 20,
        ValueMulti = 100,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.1
            } },
        Passives = { "Golden Pet Mutation" },
        Color = Color3.fromRGB(255, 225, 0)
    },
    Rainbow = {
        EnumId = "c",
        AvaliableFromMutationMachine = true,
        Chance = 10,
        ValueMulti = 100,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.2
            } },
        Passives = { "Rainbow Pet Mutation" },
        Color = Color3.fromRGB(4, 175, 236)
    },
    Shiny = {
        EnumId = "d",
        AvaliableFromMutationMachine = true,
        Chance = 100,
        ValueMulti = 10,
        Boosts = { {
                BoostType = "PET_XP_BOOST",
                BoostAmount = 0.3
            } },
        Passives = { "Shiny Pet Mutation" },
        Color = Color3.fromRGB(145, 207, 221)
    },
    Windy = {
        EnumId = "e",
        AvaliableFromMutationMachine = true,
        Chance = 30,
        ValueMulti = 2,
        Boosts = {},
        Passives = { "Windy Pet Mutation" },
        Color = Color3.fromRGB(162, 185, 209)
    },
    Frozen = {
        EnumId = "f",
        AvaliableFromMutationMachine = true,
        Chance = 30,
        ValueMulti = 10,
        Boosts = { {} },
        Passives = { "Frozen Pet Mutation" },
        Color = Color3.fromRGB(108, 184, 255)
    },
    Inverted = {
        EnumId = "g",
        AvaliableFromMutationMachine = true,
        Chance = 50,
        ValueMulti = 10,
        Boosts = { {
                BoostType = "PET_XP_BOOST",
                BoostAmount = 0.5
            } },
        Passives = { "Inverted Pet Mutation" },
        Color = Color3.fromRGB(128, 128, 128)
    },
    Rideable = {
        EnumId = "h",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = { {} },
        Passives = {},
        Color = Color3.fromRGB(255, 255, 255)
    },
    Mega = {
        EnumId = "i",
        AvaliableFromMutationMachine = true,
        Chance = 20,
        ValueMulti = 1,
        Boosts = { {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 2
            } },
        Passives = { "Mega Pet Mutation", "Mega Pet Mutation Bonus" },
        Color = Color3.fromRGB(255, 90, 90)
    },
    Tiny = {
        EnumId = "j",
        AvaliableFromMutationMachine = true,
        Chance = 20,
        ValueMulti = 1,
        Boosts = { {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = -0.9
            } },
        Passives = { "Tiny Pet Mutation", "Tiny Pet Mutation Bonus" },
        Color = Color3.fromRGB(173, 216, 230)
    },
    IronSkin = {
        EnumId = "k",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = { {} },
        Passives = { "IronSkin Pet Mutation" },
        Color = Color3.fromRGB(206, 206, 206)
    },
    Radiant = {
        EnumId = "l",
        AvaliableFromMutationMachine = true,
        Chance = 10,
        ValueMulti = 100,
        Boosts = { {} },
        Passives = { "Radiant Pet Mutation" },
        Color = Color3.fromRGB(248, 108, 38)
    },
    Normal = {
        EnumId = "m",
        AvaliableFromMutationMachine = false,
        ValueMulti = 1,
        Boosts = {},
        Passives = {},
        Color = Color3.fromRGB(255, 255, 255)
    },
    Ascended = {
        EnumId = "n",
        AvaliableFromMutationMachine = true,
        Chance = 1,
        ValueMulti = 100,
        Boosts = {},
        Passives = { "Ascended Pet Mutation" },
        Color = Color3.fromRGB(247, 245, 184)
    },
    Tranquil = {
        EnumId = "o",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = {},
        Passives = { "Tranquil Pet Mutation" },
        Color = Color3.fromRGB(94, 247, 247)
    },
    Corrupted = {
        EnumId = "p",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = {},
        Passives = { "Corrupted Pet Mutation" },
        Color = Color3.fromRGB(176, 23, 26)
    },
    Fried = {
        EnumId = "q",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 15,
        Boosts = {},
        Passives = { "Fried Pet Mutation" },
        Color = Color3.fromRGB(170, 99, 0)
    },
    Aromatic = {
        EnumId = "r",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = {},
        Passives = { "Aromatic Pet Mutation" },
        Color = Color3.fromRGB(162, 145, 57)
    },
    Silver = {
        EnumId = "s",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 10,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.05
            } },
        Passives = { "Silver Pet Mutation" },
        Color = Color3.fromRGB(222, 222, 222)
    },
    GiantBean = {
        EnumId = "t",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = { {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 1.5
            } },
        Passives = { "GiantBean Pet Mutation", "GiantBean Pet Mutation Bonus" },
        Color = Color3.fromRGB(102, 153, 51)
    },
    Glimmering = {
        EnumId = "u",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = {},
        Passives = { "Glimmering Pet Mutation" },
        Color = Color3.fromRGB(255, 135, 245)
    },
    Luminous = {
        EnumId = "v",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = {},
        Passives = { "Luminous Pet Mutation" },
        Color = Color3.fromRGB(85, 170, 255)
    },
    Nutty = {
        EnumId = "w",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = {},
        Passives = { "Nutty Pet Mutation" },
        Color = Color3.fromRGB(154, 109, 69)
    },
    Dreadbound = {
        EnumId = "x",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = {},
        Passives = { "Dreadbound Pet Mutation" },
        Color = Color3.fromRGB(140, 45, 175)
    },
    Soulflame = {
        EnumId = "y",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = { {
                BoostType = "PET_XP_BOOST",
                BoostAmount = 0.6
            } },
        Passives = { "Soulflame Pet Mutation" },
        Color = Color3.fromRGB(255, 85, 40)
    },
    Spectral = {
        EnumId = "z",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.08
            } },
        Passives = { "Spectral Pet Mutation" },
        Color = Color3.fromRGB(90, 200, 255)
    },
    Nightmare = {
        EnumId = "A",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.22
            }, {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 1.25
            } },
        Passives = { "Nightmare Pet Mutation" },
        Color = Color3.fromRGB(255, 0, 100)
    },
    Tethered = {
        EnumId = "B",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = {},
        Passives = { "Tethered Pet Mutation" },
        Color = Color3.fromRGB(210, 171, 136)
    },
    Aurora = {
        EnumId = "H",
        AvaliableFromMutationMachine = true,
        Chance = 10,
        ValueMulti = 10,
        Boosts = { {} },
        Passives = { "Aurora Pet Mutation" },
        Color = Color3.fromRGB(165, 105, 255)
    },
    JUMBO = {
        EnumId = "I",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 10,
        Boosts = { {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 1.8
            }, {
                BoostType = "PET_XP_BOOST",
                BoostAmount = 0.5
            } },
        Passives = { "JUMBO Pet Mutation", "JUMBO Pet Mutation Bonus" },
        Color = Color3.fromRGB(255, 170, 0)
    },
    Oxpecker = {
        EnumId = "J",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.01
            } },
        Passives = { "Oxpecker Pet Mutation" },
        Color = Color3.fromRGB(170, 0, 0)
    },
    Giraffe = {
        EnumId = "K",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 5,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.03
            } },
        Passives = { "Giraffe Pet Mutation" },
        Color = Color3.fromRGB(255, 215, 0)
    },
    Rhino = {
        EnumId = "L",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 10,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.045
            } },
        Passives = { "Rhino Pet Mutation" },
        Color = Color3.fromRGB(211, 211, 211)
    },
    Crocodile = {
        EnumId = "M",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 15,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.06
            } },
        Passives = { "Crocodile Pet Mutation" },
        Color = Color3.fromRGB(85, 170, 0)
    },
    Lion = {
        EnumId = "N",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 20,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.07
            } },
        Passives = { "Lion Pet Mutation" },
        Color = Color3.fromRGB(255, 255, 102)
    },
    Forger = {
        EnumId = "O",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 10,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.07
            } },
        Passives = { "Forger Pet Mutation" },
        Color = Color3.fromRGB(150, 150, 150)
    },
    HyperHunger = {
        EnumId = "P",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.3
            } },
        Passives = { "HyperHunger Pet Mutation" },
        Color = Color3.fromRGB(255, 255, 0)
    },
    Nocturnal = {
        EnumId = "Q",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 15,
        Boosts = { {} },
        Passives = { "Nocturnal Pet Mutation" },
        Color = Color3.fromRGB(85, 85, 255)
    },
    Peppermint = {
        EnumId = "R",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 25,
        Boosts = { {} },
        Passives = { "Peppermint Pet Mutation" },
        Color = Color3.fromRGB(255, 134, 134)
    },
    SpiritSparkle = {
        EnumId = "SS",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 25,
        Boosts = { {} },
        Passives = { "Spirit Sparkle Pet Mutation" },
        Color = Color3.fromRGB(217, 244, 255)
    },
    ChristmasRally = {
        EnumId = "S",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 10,
        Boosts = { {} },
        Passives = { "Christmas Rally Pet Mutation" },
        Color = Color3.fromRGB(0, 200, 0)
    },
    MerryNursery = {
        EnumId = "T",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 20,
        Boosts = { {} },
        Passives = { "Merry Nursery Pet Mutation" },
        Color = Color3.fromRGB(255, 215, 0)
    },
    JollyDecorator = {
        EnumId = "U",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 50,
        Boosts = { {} },
        Passives = { "Jolly Decorator Pet Mutation" },
        Color = Color3.fromRGB(200, 0, 0)
    },
    GiantGolem = {
        EnumId = "V",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.2
            }, {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 1.5
            } },
        Passives = { "Giant Golem Pet Mutation" },
        Color = Color3.fromRGB(120, 180, 255)
    },
    Fiery = {
        EnumId = "W",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = {},
        Passives = { "Fiery Pet Mutation" },
        Color = Color3.fromRGB(255, 128, 0)
    },
    Venom = {
        EnumId = "X",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.3
            } },
        Passives = { "Venom Pet Mutation" },
        Color = Color3.fromRGB(149, 0, 255)
    },
    UFO = {
        EnumId = "Y",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 100,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.3
            } },
        Passives = { "UFO Pet Mutation" },
        Color = Color3.fromRGB(11, 163, 0)
    },
    Alienated = {
        EnumId = "Z",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 1,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.3
            } },
        Passives = { "Alienated Pet Mutation" },
        Color = Color3.fromRGB(49, 255, 63)
    },
    Blossoming = {
        EnumId = "@",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 50,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.23
            } },
        Passives = { "Blossoming Pet Mutation" },
        Color = Color3.fromRGB(236, 128, 255)
    },
    Everchanted = {
        EnumId = "EV",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 25,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.3
            } },
        Passives = { "Everchanted Pet Mutation", "Everchanted Pet Mutation Bonus" },
        Color = Color3.fromRGB(0, 255, 127)
    },
    RoyalJelly = {
        EnumId = "RJ",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 25,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.25
            } },
        Passives = { "Royal Jelly Pet Mutation" },
        Color = Color3.fromRGB(170, 85, 255)
    },
    Ember = {
        EnumId = "EM",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 88,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.32
            }, {
                BoostType = "PET_XP_BOOST",
                BoostAmount = 0.32
            }, {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 2
            } },
        Passives = { "Ember Pet Mutation" },
        Color = Color3.fromRGB(255, 85, 0)
    },
    Exalted = {
        EnumId = "EX",
        AvaliableFromMutationMachine = false,
        Chance = 50,
        ValueMulti = 100,
        Level500Only = true,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.25
            } },
        Passives = { "Exalted Pet Mutation" },
        Color = Color3.fromRGB(255, 200, 0)
    },
    Iridescent = {
        EnumId = "IR",
        AvaliableFromMutationMachine = false,
        Chance = 35,
        ValueMulti = 125,
        Level500Only = true,
        Boosts = { {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 1.5
            } },
        Passives = { "Iridescent Pet Mutation" },
        Color = Color3.fromRGB(170, 170, 255)
    },
    Gigantic = {
        EnumId = "GG",
        AvaliableFromMutationMachine = false,
        Chance = 12.5,
        ValueMulti = 150,
        Level500Only = true,
        Boosts = { {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 3
            } },
        Passives = { "Gigantic Pet Mutation" },
        Color = Color3.fromRGB(170, 0, 0)
    },
    Transcendent = {
        EnumId = "TS",
        AvaliableFromMutationMachine = false,
        Chance = 2.5,
        ValueMulti = 200,
        Level500Only = true,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.35
            } },
        Passives = { "Transcendent Pet Mutation" },
        Color = Color3.fromRGB(255, 0, 127)
    },
    Inferno = {
        EnumId = "IN",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 50,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.25
            }, {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 1.75
            } },
        Passives = { "Inferno Pet Mutation" },
        Color = Color3.fromRGB(255, 85, 0)
    },
    Bountiful = {
        EnumId = "BO",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 20,
        Boosts = { {
                BoostType = "PET_XP_BOOST",
                BoostAmount = 0.15
            } },
        Passives = { "Bountiful Pet Mutation" },
        Color = Color3.fromRGB(255, 190, 0)
    },
    Threshing = {
        EnumId = "TH",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 30,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.15
            } },
        Passives = { "Threshing Pet Mutation" },
        Color = Color3.fromRGB(235, 225, 120)
    },
    Lunarbound = {
        EnumId = "LB",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 50,
        Boosts = { {
                BoostType = "PET_XP_BOOST",
                BoostAmount = 0.2
            }, {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 1.3
            } },
        Passives = { "Lunarbound Pet Mutation" },
        Color = Color3.fromRGB(190, 235, 255)
    },
    Starry = {
        EnumId = "ST",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 80,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.25
            }, {
                BoostType = "PET_XP_BOOST",
                BoostAmount = 0.25
            } },
        Passives = { "Starry Pet Mutation" },
        Color = Color3.fromRGB(95, 60, 180)
    },
    Everfallen = {
        EnumId = "EF",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 25,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.3
            } },
        Passives = { "Everfallen Pet Mutation", "Everfallen Pet Mutation Bonus" },
        Color = Color3.fromRGB(255, 140, 0)
    },
    Haunted = {
        EnumId = "HA",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 10,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.22
            }, {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 1.25
            } },
        Passives = { "Haunted Pet Mutation", "Haunted Pet Mutation Bonus" },
        Color = Color3.fromRGB(150, 70, 230)
    },
    Everhaunted = {
        EnumId = "EH",
        AvaliableFromMutationMachine = false,
        Chance = 0,
        ValueMulti = 50,
        Boosts = { {
                BoostType = "PASSIVE_BOOST",
                BoostAmount = 0.33
            }, {
                BoostType = "SIZE_MODIFICATION",
                BoostAmount = 2.5
            } },
        Passives = { "Everhaunted Pet Mutation", "Everhaunted Pet Mutation Bonus" },
        Color = Color3.fromRGB(185, 130, 255)
    }
};

function RollRandomMutation(p2)
    local v3 = 0;

    for _, v in p2 do
        local Chance = v.Chance;

        if Chance and Chance > 0 then
            v3 = v3 + Chance;
        end;
    end;

    if v3 <= 0 then
        return nil;
    end;

    local v4 = Random.new():NextNumber() * v3;
    local v5 = 0;

    for i, v in p2 do
        local Chance = v.Chance;

        if Chance and Chance > 0 then
            v5 = v5 + Chance;

            if v5 >= v4 then
                return i;
            end;
        end;
    end;

    return nil;
end;

local v6 = {};
local v7 = {};
local v8 = {};
local v9 = {};

for i, v in v1 do
    v6[v.EnumId] = i;
    v7[i] = v.EnumId;

    if v.Level500Only then
        v8[i] = v;
    elseif v.AvaliableFromMutationMachine then
        v9[i] = v;
    end;
end;

return {
    PetMutationToEnum = v7,
    EnumToPetMutation = v6,
    MachineMutationTypes = v9,
    Level500MutationTypes = v8,
    PetMutationRegistry = v1,
    RollRandomMutation = RollRandomMutation
};