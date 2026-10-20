-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local v1 = newproxy();
local table_freeze_ret = table.freeze({
    ["Exotic Culinarian Chest"] = {
        Display = "Chest",
        DisplayPlural = "Chests",
        Items = {
            {
                Type = "Seed",
                RewardId = "Rhubarb",
                Icon = "rbxassetid://106871330378373",
                Pity = 4
            },
            {
                Type = "Pet",
                RewardId = "Bacon Pig",
                Icon = "rbxassetid://123575630335943",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Badlands Pepper",
                Icon = "rbxassetid://80652364697403",
                Pity = 17
            },
            {
                Type = "Pet",
                RewardId = "Hotdog Daschund",
                Icon = "rbxassetid://95882797225742",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "King Cabbage",
                Icon = "rbxassetid://91601239615737",
                Pity = 75
            },
            {
                Type = "Pet",
                RewardId = "Lobster Thermidor",
                Icon = "rbxassetid://123517269814780",
                Pity = 100
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Culinarian Chest",
                Icon = "rbxassetid://139267369304594",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Rhubarb",
                Icon = "rbxassetid://106871330378373",
                Pity = 175
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Bacon Pig",
                Icon = "rbxassetid://123575630335943",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Badlands Pepper",
                Icon = "rbxassetid://80652364697403",
                Pity = 375
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Hotdog Daschund",
                Icon = "rbxassetid://95882797225742",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "King Cabbage",
                Icon = "rbxassetid://91601239615737",
                Pity = 625
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Lobster Thermidor",
                Icon = "rbxassetid://123517269814780",
                Pity = 750
            }
        }
    },
    ["Exotic Sprout Seed Pack"] = {
        Display = "Pack",
        DisplayPlural = "Packs",
        Items = {
            {
                Type = "Seed",
                RewardId = "Flare Daisy",
                Icon = "rbxassetid://105316835053253",
                Pity = 4
            },
            {
                Type = "Seed",
                RewardId = "Duskpuff",
                Icon = "rbxassetid://91872032827721",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Mangosteen",
                Icon = "rbxassetid://134506599201430",
                Pity = 17
            },
            {
                Type = "Seed",
                RewardId = "Poseidon Plant",
                Icon = "rbxassetid://97650420696362",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Gleamroot",
                Icon = "rbxassetid://131568273345403",
                Pity = 75
            },
            {
                Type = "Seed",
                RewardId = "Princess Thorn",
                Icon = "rbxassetid://116245630615057",
                Pity = 100
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Sprout Seed Pack",
                Icon = "rbxassetid://79790068231864",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Flare Daisy",
                Icon = "rbxassetid://105316835053253",
                Pity = 175
            },
            {
                Type = "RainbowSeed",
                RewardId = "Duskpuff",
                Icon = "rbxassetid://91872032827721",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Mangosteen",
                Icon = "rbxassetid://134506599201430",
                Pity = 375
            },
            {
                Type = "RainbowSeed",
                RewardId = "Poseidon Plant",
                Icon = "rbxassetid://97650420696362",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Gleamroot",
                Icon = "rbxassetid://131568273345403",
                Pity = 625
            },
            {
                Type = "RainbowSeed",
                RewardId = "Princess Thorn",
                Icon = "rbxassetid://116245630615057",
                Pity = 750
            }
        }
    },
    ["Exotic Skyroot Chest"] = {
        Display = "Chest",
        DisplayPlural = "Chests",
        Items = {
            {
                Type = "Seed",
                RewardId = "Crown of Thorns",
                Icon = "rbxassetid://71247058412364",
                Pity = 4
            },
            {
                Type = "Pet",
                RewardId = "Elk",
                Icon = "rbxassetid://127104293000030",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Calla Lily",
                Icon = "rbxassetid://79097917957337",
                Pity = 17
            },
            {
                Type = "Pet",
                RewardId = "Mandrake",
                Icon = "rbxassetid://110030055256222",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Cyclamen",
                Icon = "rbxassetid://87977286245584",
                Pity = 75
            },
            {
                Type = "Pet",
                RewardId = "Griffin",
                Icon = "rbxassetid://89180236366919",
                Pity = 100
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Skyroot Chest",
                Icon = "rbxassetid://123959241611335",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Crown of Thorns",
                Icon = "rbxassetid://71247058412364",
                Pity = 175
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Elk",
                Icon = "rbxassetid://127104293000030",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Calla Lily",
                Icon = "rbxassetid://79097917957337",
                Pity = 375
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Mandrake",
                Icon = "rbxassetid://110030055256222",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Cyclamen",
                Icon = "rbxassetid://87977286245584",
                Pity = 625
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Griffin",
                Icon = "rbxassetid://89180236366919",
                Pity = 750
            }
        }
    },
    ["Exotic Enchanted Seed Pack"] = {
        Display = "Pack",
        DisplayPlural = "Packs",
        Items = {
            {
                Type = "Seed",
                RewardId = "Sunbulb",
                Icon = "rbxassetid://120700463623509",
                Pity = 4
            },
            {
                Type = "Seed",
                RewardId = "Glowthorn",
                Icon = "rbxassetid://91714836806838",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Lightshoot",
                Icon = "rbxassetid://111505838463119",
                Pity = 17
            },
            {
                Type = "Seed",
                RewardId = "Briar Rose",
                Icon = "rbxassetid://76419523252769",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Spirit Flower",
                Icon = "rbxassetid://119395365157545",
                Pity = 75
            },
            {
                Type = "Seed",
                RewardId = "Wispwing",
                Icon = "rbxassetid://94302407520780",
                Pity = 100
            },
            {
                Type = "Pack",
                RewardId = "Rainbow Exotic Enchanted Seed Pack",
                Icon = "rbxassetid://103106788031205",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Sunbulb",
                Icon = "rbxassetid://120700463623509",
                Pity = 175
            },
            {
                Type = "RainbowSeed",
                RewardId = "Glowthorn",
                Icon = "rbxassetid://91714836806838",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Lightshoot",
                Icon = "rbxassetid://111505838463119",
                Pity = 375
            },
            {
                Type = "RainbowSeed",
                RewardId = "Briar Rose",
                Icon = "rbxassetid://76419523252769",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Spirit Flower",
                Icon = "rbxassetid://119395365157545",
                Pity = 625
            },
            {
                Type = "RainbowSeed",
                RewardId = "Wispwing",
                Icon = "rbxassetid://94302407520780",
                Pity = 750
            }
        }
    },
    ["Exotic Enchanted Chest"] = {
        Display = "Chest",
        DisplayPlural = "Chests",
        Items = {
            {
                Type = "Seed",
                RewardId = "Emerald Bud",
                Icon = "rbxassetid://126003306982516",
                Pity = 4
            },
            {
                Type = "Pet",
                RewardId = "Cardinal",
                Icon = "rbxassetid://137030064718487",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Pyracantha",
                Icon = "rbxassetid://97004839731597",
                Pity = 17
            },
            {
                Type = "Pet",
                RewardId = "Shroomie",
                Icon = "rbxassetid://118861411002665",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Aetherfruit",
                Icon = "rbxassetid://90507124224051",
                Pity = 75
            },
            {
                Type = "Pet",
                RewardId = "Phoenix",
                Icon = "rbxassetid://117645843394939",
                Pity = 100
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Enchanted Chest",
                Icon = "rbxassetid://74555275163145",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Emerald Bud",
                Icon = "rbxassetid://126003306982516",
                Pity = 175
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Cardinal",
                Icon = "rbxassetid://137030064718487",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Pyracantha",
                Icon = "rbxassetid://97004839731597",
                Pity = 375
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Shroomie",
                Icon = "rbxassetid://118861411002665",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Aetherfruit",
                Icon = "rbxassetid://90507124224051",
                Pity = 625
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Phoenix",
                Icon = "rbxassetid://117645843394939",
                Pity = 750
            }
        }
    },
    ["Premium Fall Egg"] = {
        Display = "Egg",
        DisplayPlural = "Eggs",
        Items = {
            {
                Type = "Pet",
                RewardId = "Robin",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Badger",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Grizzly Bear",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Barn Owl",
                Pity = 80,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Swan",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Egg",
                DisplayName = "GIANT Premium Fall Egg",
                RewardId = "GIANT Premium Fall Egg",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "GIANT Robin",
                Pity = 175,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "GIANT Badger",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "GIANT Grizzly Bear",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "GIANT Barn Owl",
                Pity = 500,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "GIANT Swan",
                Pity = 650,
                Icon = v1
            }
        }
    },
    ["Exotic Fall Seed Pack"] = {
        Display = "Pack",
        DisplayPlural = "Packs",
        Items = {
            {
                Type = "Seed",
                RewardId = "Autumn Shroom",
                Icon = "rbxassetid://75191261635804",
                Pity = 4
            },
            {
                Type = "Seed",
                RewardId = "Fall Berry",
                Icon = "rbxassetid://73166761479846",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Speargrass",
                Icon = "rbxassetid://116332608985559",
                Pity = 17
            },
            {
                Type = "Seed",
                RewardId = "Torchflare",
                Icon = "rbxassetid://105688382453107",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Auburn Pine",
                Icon = "rbxassetid://70592093864676",
                Pity = 75
            },
            {
                Type = "Seed",
                RewardId = "Firewell",
                Icon = "rbxassetid://82408767722747",
                Pity = 100
            },
            {
                Type = "Pack",
                RewardId = "Rainbow Exotic Fall Seed Pack",
                Icon = "rbxassetid://130784540117024",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Autumn Shroom",
                Icon = "rbxassetid://75191261635804",
                Pity = 175
            },
            {
                Type = "RainbowSeed",
                RewardId = "Fall Berry",
                Icon = "rbxassetid://73166761479846",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Speargrass",
                Icon = "rbxassetid://116332608985559",
                Pity = 375
            },
            {
                Type = "RainbowSeed",
                RewardId = "Torchflare",
                Icon = "rbxassetid://105688382453107",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Auburn Pine",
                Icon = "rbxassetid://70592093864676",
                Pity = 625
            },
            {
                Type = "RainbowSeed",
                RewardId = "Firewell",
                Icon = "rbxassetid://82408767722747",
                Pity = 750
            }
        }
    },
    ["Exotic Nutty Chest"] = {
        Display = "Chest",
        DisplayPlural = "Chests",
        Items = {
            {
                Type = "Seed",
                RewardId = "Hazelnut",
                Icon = "rbxassetid://109787439424464",
                Pity = 4
            },
            {
                Type = "Pet",
                RewardId = "Farmer Chipmunk",
                Icon = "rbxassetid://75410382754350",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Persimmon",
                Icon = "rbxassetid://70665514066275",
                Pity = 17
            },
            {
                Type = "Pet",
                RewardId = "Idol Chipmunk",
                Icon = "rbxassetid://107956964205378",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Acorn",
                Icon = "rbxassetid://115598356098825",
                Pity = 75
            },
            {
                Type = "Pet",
                RewardId = "Chinchilla",
                Icon = "rbxassetid://111612178675697",
                Pity = 100
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Nutty Chest",
                Icon = "rbxassetid://86723107125634",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Hazelnut",
                Icon = "rbxassetid://109787439424464",
                Pity = 175
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Farmer Chipmunk",
                Icon = "rbxassetid://75410382754350",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Persimmon",
                Icon = "rbxassetid://70665514066275",
                Pity = 375
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Idol Chipmunk",
                Icon = "rbxassetid://107956964205378",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Acorn",
                Icon = "rbxassetid://115598356098825",
                Pity = 625
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Chinchilla",
                Icon = "rbxassetid://111612178675697",
                Pity = 750
            }
        }
    },
    ["Premium Spooky Egg"] = {
        Display = "Egg",
        DisplayPlural = "Eggs",
        Items = {
            {
                Type = "Pet",
                RewardId = "Bat",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Bone Dog",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Spider",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Black Cat",
                Pity = 80,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Headless Horseman",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Egg",
                DisplayName = "Ghostly Premium Spooky Egg",
                RewardId = "Ghostly Premium Spooky Egg",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Ghostly Bat",
                Pity = 175,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Ghostly Bone Dog",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Ghostly Spider",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Ghostly Black Cat",
                Pity = 500,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Ghostly Headless Horseman",
                Pity = 650,
                Icon = v1
            }
        }
    },
    ["Exotic Spooky Chest"] = {
        Display = "Chest",
        DisplayPlural = "Chests",
        Items = {
            {
                Type = "Seed",
                RewardId = "Ghost Bush",
                Icon = "rbxassetid://89461296862154",
                Pity = 4
            },
            {
                Type = "Pet",
                RewardId = "Scarab",
                Icon = "rbxassetid://130923289845949",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Devilroot",
                Icon = "rbxassetid://115428593786887",
                Pity = 17
            },
            {
                Type = "Pet",
                RewardId = "Tomb Marmot",
                Icon = "rbxassetid://129811000175004",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Wereplant",
                Icon = "rbxassetid://110458015208721",
                Pity = 75
            },
            {
                Type = "Pet",
                RewardId = "Mummy",
                Icon = "rbxassetid://109984183023587",
                Pity = 100
            },
            {
                Type = "Pack",
                DisplayName = "Special Pack",
                RewardId = "Special Exotic Spooky Chest",
                Icon = "rbxassetid://110835717235166",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Ghost Bush",
                Icon = "rbxassetid://89461296862154",
                Pity = 175
            },
            {
                Type = "Pet",
                RewardId = "Ghostly Scarab",
                Icon = "rbxassetid://112844006603733",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Devilroot",
                Icon = "rbxassetid://115428593786887",
                Pity = 375
            },
            {
                Type = "Pet",
                RewardId = "Ghostly Tomb Marmot",
                Icon = "rbxassetid://108400222651524",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Wereplant",
                Icon = "rbxassetid://110458015208721",
                Pity = 625
            },
            {
                Type = "Pet",
                RewardId = "Ghostly Mummy",
                Icon = "rbxassetid://128554214079406",
                Pity = 750
            }
        }
    },
    ["Premium Safari Egg"] = {
        Display = "Egg",
        DisplayPlural = "Eggs",
        Items = {
            {
                Type = "Pet",
                RewardId = "Oxpecker",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Zebra",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Giraffe",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rhino",
                Pity = 80,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Elephant",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Egg",
                DisplayName = "Rainbow Premium Safari Egg",
                RewardId = "Rainbow Premium Safari Egg",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Oxpecker",
                Pity = 175,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Zebra",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Giraffe",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Rhino",
                Pity = 500,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Elephant",
                Pity = 650,
                Icon = v1
            }
        }
    },
    ["Exotic Safari Seed Pack"] = {
        Display = "Pack",
        DisplayPlural = "Packs",
        Items = {
            {
                Type = "Seed",
                RewardId = "Daisy",
                Icon = "rbxassetid://138804049517799",
                Pity = 4
            },
            {
                Type = "Seed",
                RewardId = "Bamboo Tree",
                Icon = "rbxassetid://134939186622894",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Amberfruit Shrub",
                Icon = "rbxassetid://92319597519259",
                Pity = 17
            },
            {
                Type = "Seed",
                RewardId = "Castor Bean",
                Icon = "rbxassetid://91154044889049",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Java Banana",
                Icon = "rbxassetid://74353075923360",
                Pity = 75
            },
            {
                Type = "Seed",
                RewardId = "Peacock Tail",
                Icon = "rbxassetid://92582344140177",
                Pity = 100
            },
            {
                Type = "Pack",
                RewardId = "Rainbow Exotic Safari Seed Pack",
                Icon = "rbxassetid://94884022497372",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Daisy",
                Icon = "rbxassetid://138804049517799",
                Pity = 175
            },
            {
                Type = "RainbowSeed",
                RewardId = "Bamboo Tree",
                Icon = "rbxassetid://134939186622894",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Amberfruit Shrub",
                Icon = "rbxassetid://92319597519259",
                Pity = 375
            },
            {
                Type = "RainbowSeed",
                RewardId = "Castor Bean",
                Icon = "rbxassetid://91154044889049",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Java Banana",
                Icon = "rbxassetid://74353075923360",
                Pity = 625
            },
            {
                Type = "RainbowSeed",
                RewardId = "Peacock Tail",
                Icon = "rbxassetid://92582344140177",
                Pity = 750
            }
        }
    },
    ["Exotic Gem Chest"] = {
        Display = "Chest",
        DisplayPlural = "Chests",
        Items = {
            {
                Type = "Seed",
                RewardId = "Gem Fruit",
                Icon = "rbxassetid://121801427908658",
                Pity = 4
            },
            {
                Type = "Pet",
                RewardId = "Clam",
                Icon = "rbxassetid://115999998856683",
                Pity = 6
            },
            {
                Type = "Seed",
                RewardId = "Coilvine",
                Icon = "rbxassetid://105351951641002",
                Pity = 17
            },
            {
                Type = "Pet",
                RewardId = "Magpie",
                Icon = "rbxassetid://139376566129954",
                Pity = 23
            },
            {
                Type = "Seed",
                RewardId = "Asteris",
                Icon = "rbxassetid://134130292574701",
                Pity = 75
            },
            {
                Type = "Pet",
                RewardId = "Bearded Dragon",
                Icon = "rbxassetid://130976380531698",
                Pity = 100
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Gem Chest",
                Icon = "rbxassetid://115309330511483",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Gem Fruit",
                Icon = "rbxassetid://121801427908658",
                Pity = 175
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Clam",
                Icon = "rbxassetid://115999998856683",
                Pity = 250
            },
            {
                Type = "RainbowSeed",
                RewardId = "Coilvine",
                Icon = "rbxassetid://105351951641002",
                Pity = 375
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Magpie",
                Icon = "rbxassetid://139376566129954",
                Pity = 500
            },
            {
                Type = "RainbowSeed",
                RewardId = "Asteris",
                Icon = "rbxassetid://134130292574701",
                Pity = 625
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Bearded Dragon",
                Icon = "rbxassetid://130976380531698",
                Pity = 750
            }
        }
    },
    ["Artisan Container"] = {
        Display = "Container",
        DisplayPlural = "Containers",
        Items = { {
                Type = "TradeBoothSkin",
                RewardId = "Green",
                Icon = "rbxassetid://91086294684465",
                Pity = 5
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Purple",
                Icon = "rbxassetid://81730682212397",
                Pity = 15
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Toriigate",
                Icon = "rbxassetid://107168764835511",
                Pity = 35
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Fairy",
                Icon = "rbxassetid://117155720434253",
                Pity = 80
            }, {
                Type = "TradeBoothSkin",
                RewardId = "DJ",
                Icon = "rbxassetid://101237248829994",
                Pity = 100
            } }
    },
    ["Elemental Container"] = {
        Display = "Container",
        DisplayPlural = "Containers",
        Items = { {
                Type = "TradeBoothSkin",
                RewardId = "Blue",
                Icon = "rbxassetid://98175417203754",
                Pity = 5
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Yellow",
                Icon = "rbxassetid://106026174719144",
                Pity = 15
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Beach",
                Icon = "rbxassetid://138905092934000",
                Pity = 35
            }, {
                Type = "TradeBoothSkin",
                RewardId = "CherryBlossom",
                Icon = "rbxassetid://100583352441498",
                Pity = 80
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Waterfall",
                Icon = "rbxassetid://87879730769730",
                Pity = 100
            } }
    },
    ["Festive Container"] = {
        Display = "Container",
        DisplayPlural = "Containers",
        Items = { {
                Type = "TradeBoothSkin",
                RewardId = "Sleigh",
                Icon = "rbxassetid://85059208973593",
                Pity = 5
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Candy Cane",
                Icon = "rbxassetid://130737222569939",
                Pity = 15
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Festive",
                Icon = "rbxassetid://118036207499114",
                Pity = 35
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Snowy",
                Icon = "rbxassetid://105773049174678",
                Pity = 80
            }, {
                Type = "TradeBoothSkin",
                RewardId = "Present",
                Icon = "rbxassetid://103157401366735",
                Pity = 100
            } }
    },
    ["Exotic Santa\'s Surprise Present"] = {
        Display = "Present",
        DisplayPlural = "Presents",
        Items = {
            {
                Type = "Seed",
                RewardId = "Cookie Stack",
                Icon = "rbxassetid://95614998789534",
                Pity = 4
            },
            {
                Type = "Pet",
                RewardId = "Snow Bunny",
                Pity = 8,
                Icon = "rbxassetid://87880212796520"
            },
            {
                Type = "Seed",
                RewardId = "Poinsettia",
                Icon = "rbxassetid://74064121845349",
                Pity = 14
            },
            {
                Type = "Pet",
                RewardId = "French Hen",
                Pity = 20,
                Icon = "rbxassetid://99623793770709"
            },
            {
                Type = "Seed",
                RewardId = "Antlerbloom",
                Icon = "rbxassetid://117900418806654",
                Pity = 30
            },
            {
                Type = "Pet",
                RewardId = "Christmas Gorilla",
                Pity = 40,
                Icon = "rbxassetid://117550228795797"
            },
            {
                Type = "Seed",
                RewardId = "Holly Berry",
                Icon = "rbxassetid://132582203488703",
                Pity = 50
            },
            {
                Type = "Pet",
                RewardId = "Mistletoad",
                Pity = 60,
                Icon = "rbxassetid://85173745103378"
            },
            {
                Type = "Seed",
                RewardId = "Gift Berry",
                Icon = "rbxassetid://115656624815881",
                Pity = 75
            },
            {
                Type = "Pet",
                RewardId = "Krampus",
                Pity = 100,
                Icon = "rbxassetid://140396704438382"
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Pack",
                RewardId = "Rainbow Exotic Santa\'s Surprise Present",
                Icon = "rbxassetid://130913316923791",
                Pity = 125
            },
            {
                Type = "RainbowSeed",
                RewardId = "Cookie Stack",
                Icon = "rbxassetid://95614998789534",
                Pity = 175
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Snow Bunny",
                Pity = 240,
                Icon = "rbxassetid://87880212796520"
            },
            {
                Type = "RainbowSeed",
                RewardId = "Poinsettia",
                Icon = "rbxassetid://74064121845349",
                Pity = 305
            },
            {
                Type = "Pet",
                RewardId = "Rainbow French Hen",
                Pity = 370,
                Icon = "rbxassetid://99623793770709"
            },
            {
                Type = "RainbowSeed",
                RewardId = "Antlerbloom",
                Icon = "rbxassetid://117900418806654",
                Pity = 435
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Christmas Gorilla",
                Pity = 500,
                Icon = "rbxassetid://117550228795797"
            },
            {
                Type = "RainbowSeed",
                RewardId = "Holly Berry",
                Icon = "rbxassetid://132582203488703",
                Pity = 565
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Mistletoad",
                Pity = 630,
                Icon = "rbxassetid://85173745103378"
            },
            {
                Type = "RainbowSeed",
                RewardId = "Gift Berry",
                Icon = "rbxassetid://115656624815881",
                Pity = 695
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Krampus",
                Pity = 750,
                Icon = "rbxassetid://140396704438382"
            }
        }
    },
    ["Premium Christmas Egg"] = {
        Display = "Egg",
        DisplayPlural = "Eggs",
        Items = {
            {
                Type = "Pet",
                RewardId = "Turtle Dove",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Reindeer",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Nutcracker",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Yeti",
                Pity = 80,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Ice Golem",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Egg",
                DisplayName = "Festive Premium Christmas Egg",
                RewardId = "Festive Premium Christmas Egg",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Turtle Dove",
                Pity = 175,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Reindeer",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Nutcracker",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Yeti",
                Pity = 500,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Ice Golem",
                Pity = 650,
                Icon = v1
            }
        }
    },
    ["Premium Winter Egg"] = {
        Display = "Egg",
        DisplayPlural = "Eggs",
        Items = {
            {
                Type = "Pet",
                RewardId = "Partridge",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Santa Bear",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Moose",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Frost Squirrel",
                Pity = 65,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Wendigo",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Egg",
                DisplayName = "Festive Premium Winter Egg",
                RewardId = "Festive Premium Winter Egg",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Partridge",
                Pity = 175,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Santa Bear",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Moose",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Frost Squirrel",
                Pity = 475,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Festive Wendigo",
                Pity = 650,
                Icon = v1
            }
        }
    },
    ["Premium New Year\'s Egg"] = {
        Display = "Egg",
        DisplayPlural = "Eggs",
        Items = {
            {
                Type = "Pet",
                RewardId = "New Year\'s Bird",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Firework Sprite",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Celebration Puppy",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "New Year\'s Chimp",
                Pity = 65,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Star Wolf",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Egg",
                DisplayName = "Rainbow Premium New Year\'s Egg",
                RewardId = "Rainbow Premium New Year\'s Egg",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "New Year\'s Dragon",
                Pity = 200,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow New Year\'s Bird",
                Pity = 215,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Firework Sprite",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Celebration Puppy",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow New Year\'s Chimp",
                Pity = 475,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Star Wolf",
                Pity = 650,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow New Year\'s Dragon",
                Pity = 1000,
                Icon = v1
            }
        }
    },
    ["Premium Carnival Egg"] = {
        Display = "Egg",
        DisplayPlural = "Eggs",
        Items = {
            {
                Type = "Pet",
                RewardId = "Unicycle Monkey",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Performer Seal",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Bear on Bike",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Show Pony",
                Pity = 65,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Carnival Elephant",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Egg",
                DisplayName = "Rainbow Premium Carnival Egg",
                RewardId = "Rainbow Premium Carnival Egg",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Unicycle Monkey",
                Pity = 175,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Performer Seal",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Bear on Bike",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Show Pony",
                Pity = 475,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Carnival Elephant",
                Pity = 650,
                Icon = v1
            }
        }
    },
    ["Premium Bird Egg"] = {
        Display = "Egg",
        DisplayPlural = "Eggs",
        Items = {
            {
                Type = "Pet",
                RewardId = "Black Bird",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Cuckoo",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Brown Owl",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Gold Finch",
                Pity = 65,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Birb",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Egg",
                DisplayName = "Rainbow Premium Bird Egg",
                RewardId = "Rainbow Premium Bird Egg",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Black Bird",
                Pity = 175,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Cuckoo",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Brown Owl",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Gold Finch",
                Pity = 475,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Birb",
                Pity = 650,
                Icon = v1
            }
        }
    },
    ["Exotic Buttercup Chest"] = {
        Display = "Chest",
        DisplayPlural = "Chests",
        Items = {
            {
                Type = "Seed",
                RewardId = "Big Buttercup",
                Pity = 5,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Pink Bunny",
                Pity = 15,
                Icon = v1
            },
            {
                Type = "Seed",
                RewardId = "Bigger Buttercup",
                Pity = 35,
                Icon = v1
            },
            {
                Type = "Seed",
                RewardId = "Biggest Buttercup",
                Pity = 65,
                Icon = v1
            },
            {
                Type = "Seed",
                RewardId = "Beast Buttercup",
                Pity = 100,
                Icon = v1
            },
            {
                Type = "Pack",
                DisplayName = "Rainbow Exotic Buttercup Chest",
                RewardId = "Rainbow Exotic Buttercup Chest",
                Pity = 125,
                Icon = v1
            },
            {
                Type = "RainbowSeed",
                RewardId = "Big Buttercup",
                Pity = 175,
                Icon = v1
            },
            {
                Type = "Pet",
                RewardId = "Rainbow Pink Bunny",
                Pity = 250,
                Icon = v1
            },
            {
                Type = "RainbowSeed",
                RewardId = "Bigger Buttercup",
                Pity = 375,
                Icon = v1
            },
            {
                Type = "RainbowSeed",
                RewardId = "Biggest Buttercup",
                Pity = 475,
                Icon = v1
            },
            {
                Type = "RainbowSeed",
                RewardId = "Beast Buttercup",
                Pity = 650,
                Icon = v1
            }
        }
    }
});

for _, v in table_freeze_ret do
    for _, v2 in v.Items do
        if v2.Icon == v1 then
            v2.Icon = ItemImageFinder(v2.RewardId, v2.Type);
        end;
    end;
end;

return table_freeze_ret;