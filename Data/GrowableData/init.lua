-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local v1 = {};
local u2 = {
    ChocolateRain = {
        GrowRateMulti = 1.5
    },
    DJJhai = {
        GrowRateMulti = 1.5
    },
    Disco = {
        GrowRateMulti = 1.5
    },
    Frost = {
        GrowRateMulti = 1.5
    },
    JandelLazer = {
        GrowRateMulti = 1.5
    },
    JandelMagician = {
        GrowRateMulti = 1.5
    },
    JandelZeus = {
        GrowRateMulti = 1.5
    },
    JandelStorm = {
        GrowRateMulti = 1.5
    },
    MeteorShower = {
        GrowRateMulti = 1.5
    },
    Rain = {
        GrowRateMulti = 1.5
    },
    SheckleRain = {
        GrowRateMulti = 1.5
    },
    Thunderstorm = {
        GrowRateMulti = 1.5
    },
    Tornado = {
        GrowRateMulti = 1.5
    },
    Blackhole = {
        GrowRateMulti = 1.5
    },
    BeeNado = {
        GrowRateMulti = 1.5
    },
    BeeStorm = {
        GrowRateMulti = 1.5
    },
    SpaceTravel = {
        GrowRateMulti = 1.75
    },
    TropicalRain = {
        GrowRateMulti = 1.5
    },
    AuroraBorealis = {
        GrowRateMulti = 1.5
    },
    RadioactiveCarrot = {
        GrowRateMulti = 1.5
    },
    JandelZombie = {
        GrowRateMulti = 1.5
    },
    FullMoon = {
        GrowRateMulti = 2
    },
    SafariStorm = {
        GrowRateMulti = 5
    },
    Cyclone = {
        GrowRateMulti = 1.5
    },
    YetiNight = {
        GrowRateMulti = 3
    },
    Default = {
        GrowRateMulti = 1
    }
};

if RunService:IsServer() then
    for _, child in game.ServerScriptService.WeatherService.weatherManager.Events:GetChildren() do
        if not u2[child.Name] then
            u2[child.Name] = u2.Default;
        end;
    end;
end;

local u3 = {
    ["Everafter Glowstalk"] = {
        PlantName = "Everafter Glowstalk",
        PlantData = {
            GrowRate = 0.00536,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(400, 400)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    Carrot = {
        PlantName = "Carrot",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Tomato = {
        PlantName = "Tomato",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Apple = {
        PlantName = "Apple",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Blue Lollipop"] = {
        PlantName = "Blue Lollipop",
        PlantData = {
            GrowRate = 0.6,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1.2, 1.4)
        }
    },
    ["Cherry Blossom"] = {
        PlantName = "Cherry Blossom",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(80, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Pumpkin = {
        PlantName = "Pumpkin",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(1.6, 2.4)
        }
    },
    Watermelon = {
        PlantName = "Watermelon",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(1.6, 2.4)
        }
    },
    Coconut = {
        PlantName = "Coconut",
        PlantData = {
            GrowRate = 0.001,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Candy Blossom"] = {
        PlantName = "Candy Blossom",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 5)
        }
    },
    ["Candy Blossom 2026"] = {
        PlantName = "Candy Blossom 2026",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 5)
        }
    },
    Cacao = {
        PlantName = "Cacao",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(80, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Sunflower = {
        PlantName = "Sunflower",
        PlantData = {
            GrowRate = 0.07,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(28, 32),
            GrowFruitTime = NumberRange.new(200, 340)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    Beanstalk = {
        PlantName = "Beanstalk",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 1,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Coolcool Beanbeanstalk"] = {
        PlantName = "Coolcool Beanbeanstalk",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 1,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Ember Lily"] = {
        PlantName = "Ember Lily",
        PlantData = {
            GrowRate = 0.0285,
            PlantDown = -1.15,
            GrowTickTime = NumberRange.new(15, 18),
            GrowFruitTime = NumberRange.new(110, 160)
        },
        FruitData = {
            GrowRate = 0.035,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Sugar Apple"] = {
        PlantName = "Sugar Apple",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(9, 11),
            GrowFruitTime = NumberRange.new(40, 80)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(5.5, 7)
        }
    },
    ["Burning Bud"] = {
        PlantName = "Burning Bud",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 4,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(250, 300)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Zebrazinkle = {
        PlantName = "Zebrazinkle",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 4,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(250, 300)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(5, 6)
        }
    },
    ["Giant Pinecone"] = {
        PlantName = "Giant Pinecone",
        PlantData = {
            GrowRate = 0.011,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 21),
            GrowFruitTime = NumberRange.new(180, 200)
        },
        FruitData = {
            GrowRate = 0.075,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10.35, 11)
        }
    },
    ["Elder Strawberry"] = {
        PlantName = "Elder Strawberry",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20.4, 20.65),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.0125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6)
        }
    },
    Romanesco = {
        PlantName = "Romanesco",
        PlantData = {
            GrowRate = 0.001,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(333, 366)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Crimson Thorn"] = {
        PlantName = "Crimson Thorn",
        PlantData = {
            GrowRate = 0.001,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.7, 2.1),
            GrowFruitTime = NumberRange.new(400, 500)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.7, 1.1)
        }
    },
    ["Great Pumpkin"] = {
        PlantName = "Great Pumpkin",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Octobloom = {
        PlantName = "Octobloom",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(88, 88),
            GrowFruitTime = NumberRange.new(333, 333)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8)
        }
    },
    ["Trinity Fruit"] = {
        PlantName = "Trinity Fruit",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14),
            GrowFruitTime = NumberRange.new(480, 480)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    ["Four Leaf Clover"] = {
        PlantName = "Four Leaf Clover",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14),
            GrowFruitTime = NumberRange.new(480, 480)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    ["Peppermint Vine"] = {
        PlantName = "Peppermint Vine",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(300, 400)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 10)
        }
    },
    ["Reindeer Root"] = {
        PlantName = "Reindeer Root",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 40),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 14)
        }
    },
    ["Spirit Sparkle"] = {
        PlantName = "Spirit Sparkle",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 40),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 14)
        }
    },
    ["Candy Sunflower"] = {
        PlantName = "Candy Sunflower",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(3, 4)
        }
    },
    Grape = {
        PlantName = "Grape",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 1,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Venus Fly Trap"] = {
        PlantName = "Venus Fly Trap",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    Raspberry = {
        PlantName = "Raspberry",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Peach = {
        PlantName = "Peach",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Passionfruit = {
        PlantName = "Passionfruit",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(3, 5),
            GrowFruitTime = NumberRange.new(2, 4)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Blueberry = {
        PlantName = "Blueberry",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Celestiberry = {
        PlantName = "Celestiberry",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(0.6, 0.85),
            GrowFruitTime = NumberRange.new(170, 190)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(3, 4)
        }
    },
    Eggplant = {
        PlantName = "Eggplant",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 7),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Easter Egg"] = {
        PlantName = "Easter Egg",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(2, 3),
            GrowFruitTime = NumberRange.new(120, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1.5, 2)
        }
    },
    ["Purple Cabbage"] = {
        PlantName = "Purple Cabbage",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 7),
            GrowFruitTime = NumberRange.new(10, 20)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Lemon = {
        PlantName = "Lemon",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Chocolate Carrot"] = {
        PlantName = "Chocolate Carrot",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1.5, 2.3)
        }
    },
    ["Soul Fruit"] = {
        PlantName = "Soul Fruit",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(1.5, 2),
            GrowFruitTime = NumberRange.new(200, 260)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.3)
        }
    },
    ["Pink Tulip"] = {
        PlantName = "Pink Tulip",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Orange Tulip"] = {
        PlantName = "Orange Tulip",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Buttercup = {
        PlantName = "Buttercup",
        PlantData = {
            GrowRate = 0.2,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Big Buttercup"] = {
        PlantName = "Big Buttercup",
        PlantData = {
            GrowRate = 0.2,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Bigger Buttercup"] = {
        PlantName = "Bigger Buttercup",
        PlantData = {
            GrowRate = 0.2,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Biggest Buttercup"] = {
        PlantName = "Biggest Buttercup",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Beast Buttercup"] = {
        PlantName = "Beast Buttercup",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Shadow Buttercup"] = {
        PlantName = "Shadow Buttercup",
        PlantData = {
            GrowRate = 0.2,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Big Shadow Buttercup"] = {
        PlantName = "Big Shadow Buttercup",
        PlantData = {
            GrowRate = 0.2,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Bigger Shadow Buttercup"] = {
        PlantName = "Bigger Shadow Buttercup",
        PlantData = {
            GrowRate = 0.2,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Biggest Shadow Buttercup"] = {
        PlantName = "Biggest Shadow Buttercup",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Beast Shadow Buttercup"] = {
        PlantName = "Beast Shadow Buttercup",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Daffodil = {
        PlantName = "Daffodil",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Cherry OLD"] = {
        PlantName = "Cherry OLD",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Banana = {
        PlantName = "Banana",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6, 9),
            GrowFruitTime = NumberRange.new(80, 140)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Red Lollipop"] = {
        PlantName = "Red Lollipop",
        PlantData = {
            GrowRate = 0.6,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1.2, 1.4)
        }
    },
    Bamboo = {
        PlantName = "Bamboo",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(1.5, 3)
        }
    },
    Mushroom = {
        PlantName = "Mushroom",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    ["Mega Mushroom"] = {
        PlantName = "Mega Mushroom",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    Corn = {
        PlantName = "Corn",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(70, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Cactus = {
        PlantName = "Cactus",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Mango = {
        PlantName = "Mango",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Moon Mango"] = {
        PlantName = "Moon Mango",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(5, 6.5),
            GrowFruitTime = NumberRange.new(1150, 1250)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Dragon Fruit"] = {
        PlantName = "Dragon Fruit",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.25,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Pineapple = {
        PlantName = "Pineapple",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0.5,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(70, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Strawberry = {
        PlantName = "Strawberry",
        PlantData = {
            GrowRate = 0.25,
            PlantDown = 0.1,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(13, 18)
        },
        FruitData = {
            GrowRate = 0.25,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Cranberry = {
        PlantName = "Cranberry",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 7),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Pepper = {
        PlantName = "Pepper",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(3, 4.5),
            GrowFruitTime = NumberRange.new(80, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Papaya = {
        PlantName = "Papaya",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(200, 260)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Lotus = {
        PlantName = "Lotus",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(2, 3.5),
            GrowFruitTime = NumberRange.new(200, 230)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    Avocado = {
        PlantName = "Avocado",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(5, 6),
            GrowFruitTime = NumberRange.new(80, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    Starfruit = {
        PlantName = "Starfruit",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(80, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Mint = {
        PlantName = "Mint",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(2, 4),
            GrowFruitTime = NumberRange.new(90, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2, 4)
        }
    },
    ["Moon Blossom"] = {
        PlantName = "Moon Blossom",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Nightshade = {
        PlantName = "Nightshade",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(1.5, 3)
        }
    },
    Durian = {
        PlantName = "Durian",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(5, 7.5),
            GrowFruitTime = NumberRange.new(200, 230)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    Moonflower = {
        PlantName = "Moonflower",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(2, 4),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Moonglow = {
        PlantName = "Moonglow",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(3, 4.5),
            GrowFruitTime = NumberRange.new(80, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Glowshroom = {
        PlantName = "Glowshroom",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(2, 4),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Cursed Fruit"] = {
        PlantName = "Cursed Fruit",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Crimson Vine"] = {
        PlantName = "Crimson Vine",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Moon Melon"] = {
        PlantName = "Moon Melon",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(140, 200)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    ["Blood Banana"] = {
        PlantName = "Blood Banana",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6, 9),
            GrowFruitTime = NumberRange.new(80, 140)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Broccoli = {
        PlantName = "Broccoli",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 24),
            GrowFruitTime = NumberRange.new(50, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Potato = {
        PlantName = "Potato",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 10),
            GrowFruitTime = NumberRange.new(10, 20)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Brussels Sprout"] = {
        PlantName = "Brussels Sprout",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = -0.1,
            GrowTickTime = NumberRange.new(5, 6),
            GrowFruitTime = NumberRange.new(90, 110)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Cocomango = {
        PlantName = "Cocomango",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(20, 40)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(10, 20)
        }
    },
    Rose = {
        PlantName = "Rose",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = -1.15,
            GrowTickTime = NumberRange.new(7, 9),
            GrowFruitTime = NumberRange.new(220, 300)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    Foxglove = {
        PlantName = "Foxglove",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(33, 44)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.5, 5)
        }
    },
    Lilac = {
        PlantName = "Lilac",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(2, 4),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Pink Lily"] = {
        PlantName = "Pink Lily",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -1,
            GrowTickTime = NumberRange.new(3, 5),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    ["Purple Dahlia"] = {
        PlantName = "Purple Dahlia",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(3, 5),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    ["Legacy Sunflower"] = {
        PlantName = "Legacy Sunflower",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = -1.15,
            GrowTickTime = NumberRange.new(7, 10),
            GrowFruitTime = NumberRange.new(220, 300)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    Lavender = {
        PlantName = "Lavender",
        PlantData = {
            GrowRate = 0.07,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    Nectarshade = {
        PlantName = "Nectarshade",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    Nectarine = {
        PlantName = "Nectarine",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(12, 18),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(14, 21)
        }
    },
    ["Hive Fruit"] = {
        PlantName = "Hive Fruit",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -1.15,
            GrowTickTime = NumberRange.new(7.5, 10),
            GrowFruitTime = NumberRange.new(80, 160)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Manuka Flower"] = {
        PlantName = "Manuka Flower",
        PlantData = {
            GrowRate = 0.06,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    Dandelion = {
        PlantName = "Dandelion",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2.5, 4)
        }
    },
    Lumira = {
        PlantName = "Lumira",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(3.5, 4.5),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    Honeysuckle = {
        PlantName = "Honeysuckle",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = -1.15,
            GrowTickTime = NumberRange.new(12, 14),
            GrowFruitTime = NumberRange.new(110, 160)
        },
        FruitData = {
            GrowRate = 0.035,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(7, 9)
        }
    },
    Crocus = {
        PlantName = "Crocus",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2.75, 3.75)
        }
    },
    Succulent = {
        PlantName = "Succulent",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6.75, 8.25),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(7, 9)
        }
    },
    ["Violet Corn"] = {
        PlantName = "Violet Corn",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Bendboo = {
        PlantName = "Bendboo",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.5, 4.5)
        }
    },
    Cocovine = {
        PlantName = "Cocovine",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(3.8, 4.25),
            GrowFruitTime = NumberRange.new(900, 1000)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Dragon Pepper"] = {
        PlantName = "Dragon Pepper",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 5)
        }
    },
    ["Bee Balm"] = {
        PlantName = "Bee Balm",
        PlantData = {
            GrowRate = 0.03,
            PlantDown = 0.1,
            GrowTickTime = NumberRange.new(24, 27),
            GrowFruitTime = NumberRange.new(18, 22)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2, 3.5)
        }
    },
    ["Nectar Thorn"] = {
        PlantName = "Nectarine",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(18, 22),
            GrowFruitTime = NumberRange.new(70, 100)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    Suncoil = {
        PlantName = "Suncoil",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6.5, 8.5),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(5, 8)
        }
    },
    ["Noble Flower"] = {
        PlantName = "Noble Flower",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(33, 44)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.5, 5)
        }
    },
    ["Ice Cream Bean"] = {
        PlantName = "Ice Cream Bean",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14),
            GrowFruitTime = NumberRange.new(60, 120)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    Lime = {
        PlantName = "Lime",
        PlantData = {
            GrowRate = 0.075,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(5, 6.5),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    Cauliflower = {
        PlantName = "Cauliflower",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 13)
        }
    },
    ["Green Apple"] = {
        PlantName = "Green Apple",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 12),
            GrowFruitTime = NumberRange.new(140, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Kiwi = {
        PlantName = "Kiwi",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 10),
            GrowFruitTime = NumberRange.new(200, 220)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Bell Pepper"] = {
        PlantName = "Bell Pepper",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(9, 13),
            GrowFruitTime = NumberRange.new(90, 170)
        },
        FruitData = {
            GrowRate = 0.06,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 8)
        }
    },
    ["Prickly Pear"] = {
        PlantName = "Prickly Pear",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(19, 25),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.25,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(10, 16)
        }
    },
    Feijoa = {
        PlantName = "Feijoa",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(260, 290)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(1.5, 2)
        }
    },
    Loquat = {
        PlantName = "Loquat",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 15),
            GrowFruitTime = NumberRange.new(120, 140)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 10)
        }
    },
    Delphinium = {
        PlantName = "Delphinium",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(8.25, 9)
        }
    },
    ["Lily of the Valley"] = {
        PlantName = "Lily of the Valley",
        PlantData = {
            GrowRate = 0.0175,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.0125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18)
        }
    },
    ["Traveler\'s Fruit"] = {
        PlantName = "Traveler\'s Fruit",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 30),
            GrowFruitTime = NumberRange.new(300, 320)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Peace Lily"] = {
        PlantName = "Peace Lily",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(3, 4)
        }
    },
    ["Aloe Vera"] = {
        PlantName = "Aloe Vera",
        PlantData = {
            GrowRate = 0.016,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(12, 16)
        }
    },
    Rafflesia = {
        PlantName = "Rafflesia",
        PlantData = {
            GrowRate = 0.01225,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 13.5)
        }
    },
    Guanabana = {
        PlantName = "Guanabana",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(40, 45),
            GrowFruitTime = NumberRange.new(90, 150)
        },
        FruitData = {
            GrowRate = 0.0125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8)
        }
    },
    ["Wild Carrot"] = {
        PlantName = "Wild Carrot",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.6, 0.75)
        }
    },
    Pear = {
        PlantName = "Pear",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(3, 3.5),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1.25, 2)
        }
    },
    Cantaloupe = {
        PlantName = "Cantaloupe",
        PlantData = {
            GrowRate = 0.0325,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(9.5, 10.25),
            GrowFruitTime = NumberRange.new(70, 90)
        },
        FruitData = {
            GrowRate = 0.0285,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(9, 11)
        }
    },
    ["Parasol Flower"] = {
        PlantName = "Parasol Flower",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0.5,
            GrowTickTime = NumberRange.new(20, 25)
        }
    },
    ["Rosy Delight"] = {
        PlantName = "Rosy Delight",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.0125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18)
        }
    },
    ["Elephant Ears"] = {
        PlantName = "Elephant Ears",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 35),
            GrowFruitTime = NumberRange.new(150, 180)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    ["Liberty Lily"] = {
        PlantName = "Liberty Lily",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(11.2, 11.4),
            GrowFruitTime = NumberRange.new(120, 150)
        },
        FruitData = {
            GrowRate = 0.0145,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7.4)
        }
    },
    ["Firework Flower"] = {
        PlantName = "Firework Flower",
        PlantData = {
            GrowRate = 0.07,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(10, 15)
        }
    },
    ["White Mulberry"] = {
        PlantName = "White Mulberry",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(150, 180)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 9)
        }
    },
    ["Merica Mushroom"] = {
        PlantName = "Merica Mushroom",
        PlantData = {
            GrowRate = 0.07,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    ["Pitcher Plant"] = {
        PlantName = "Pitcher Plant",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(22, 24),
            GrowFruitTime = NumberRange.new(900, 1000)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5)
        }
    },
    ["Bone Blossom"] = {
        PlantName = "Bone Blossom",
        PlantData = {
            GrowRate = 0.009,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(100, 140)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4.8, 6)
        }
    },
    Stonebite = {
        PlantName = "Stonebite",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Paradise Petal"] = {
        PlantName = "Paradise Petal",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 9),
            GrowFruitTime = NumberRange.new(120, 150)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4.8, 6)
        }
    },
    ["Horned Dinoshroom"] = {
        PlantName = "Horned Dinoshroom",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Boneboo = {
        PlantName = "Boneboo",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = 0.5,
            GrowTickTime = NumberRange.new(16, 20)
        }
    },
    ["Firefly Fern"] = {
        PlantName = "Firefly Fern",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(220, 240)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 12)
        }
    },
    Fossilight = {
        PlantName = "Fossilight",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7.2, 9.6)
        }
    },
    Horsetail = {
        PlantName = "Horsetail",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(8, 9)
        }
    },
    Lingonberry = {
        PlantName = "Lingonberry",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5.5, 5.8),
            GrowFruitTime = NumberRange.new(100, 140)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5)
        }
    },
    ["Amber Spine"] = {
        PlantName = "Amber Spine",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(120, 150)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 8)
        }
    },
    ["Grand Volcania"] = {
        PlantName = "Grand Volcania",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18.25, 18.75),
            GrowFruitTime = NumberRange.new(80, 120)
        },
        FruitData = {
            GrowRate = 0.0185,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7.25)
        }
    },
    Monoblooma = {
        PlantName = "Monoblooma",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.3)
        }
    },
    Serenity = {
        PlantName = "Serenity",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0.1,
            GrowTickTime = NumberRange.new(15, 16),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Taro Flower"] = {
        PlantName = "Taro Flower",
        PlantData = {
            GrowRate = 0.022,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(8.25, 9)
        }
    },
    ["Zen Rocks"] = {
        PlantName = "Zen Rocks",
        PlantData = {
            GrowRate = 0.027,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6)
        }
    },
    Hinomai = {
        PlantName = "Hinomai",
        PlantData = {
            GrowRate = 0.00875,
            PlantDown = 1.25,
            GrowTickTime = NumberRange.new(11.3, 12),
            GrowFruitTime = NumberRange.new(90, 120)
        },
        FruitData = {
            GrowRate = 0.009,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7.2, 7.5)
        }
    },
    ["Maple Apple"] = {
        PlantName = "Maple Apple",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(8, 9),
            GrowFruitTime = NumberRange.new(200, 260)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6)
        }
    },
    Zenflare = {
        PlantName = "Zenflare",
        PlantData = {
            GrowRate = 0.0185,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(5, 6),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.075,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5)
        }
    },
    ["Sakura Bush"] = {
        PlantName = "Sakura Bush",
        PlantData = {
            GrowRate = 0.075,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.0175,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Soft Sunshine"] = {
        PlantName = "Soft Sunshine",
        PlantData = {
            GrowRate = 0.0035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4.75, 4.76),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.0125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4.8, 5)
        }
    },
    ["Spiked Mango"] = {
        PlantName = "Spiked Mango",
        PlantData = {
            GrowRate = 0.0015,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(5, 6.5),
            GrowFruitTime = NumberRange.new(1150, 1250)
        },
        FruitData = {
            GrowRate = 0.0215,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Enkaku = {
        PlantName = "Enkaku",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10.7, 11.1),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    Dezen = {
        PlantName = "Dezen",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Lucky Bamboo"] = {
        PlantName = "Lucky Bamboo",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(40, 50),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.0135,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Tranquil Bloom"] = {
        PlantName = "Tranquil Bloom",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20.4, 20.6),
            GrowFruitTime = NumberRange.new(240, 300)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 15)
        }
    },
    Fruitball = {
        PlantName = "Fruitball",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7.6, 8),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.0225,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7.35)
        }
    },
    Onion = {
        PlantName = "Onion",
        PlantData = {
            GrowRate = 0.5,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(3, 4)
        }
    },
    Jalapeno = {
        PlantName = "Jalapeno",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7.6, 8),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7.35)
        }
    },
    ["Crown Melon"] = {
        PlantName = "Crown Melon",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7.5, 8),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7.25)
        }
    },
    Sugarglaze = {
        PlantName = "Sugarglaze",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 1.5,
            GrowTickTime = NumberRange.new(30, 50),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.0135,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Tall Asparagus"] = {
        PlantName = "Tall Asparagus",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(60, 75),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.0135,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Grand Tomato"] = {
        PlantName = "Grand Tomato",
        PlantData = {
            GrowRate = 0.001,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 4),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7.35)
        }
    },
    Artichoke = {
        PlantName = "Artichoke",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Taco Fern"] = {
        PlantName = "Taco Fern",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6)
        }
    },
    ["Twisted Tangle"] = {
        PlantName = "Twisted Tangle",
        PlantData = {
            GrowRate = 0.3,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7.3, 8),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6)
        }
    },
    Veinpetal = {
        PlantName = "Veinpetal",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6)
        }
    },
    Rhubarb = {
        PlantName = "Rhubarb",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Badlands Pepper"] = {
        PlantName = "Badlands Pepper",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["King Cabbage"] = {
        PlantName = "King Cabbage",
        PlantData = {
            GrowRate = 0.00215,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.2, 10),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Spring Onion"] = {
        PlantName = "Spring Onion",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Butternut Squash"] = {
        PlantName = "Butternut Squash",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Pricklefruit = {
        PlantName = "Pricklefruit",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 24),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Bitter Melon"] = {
        PlantName = "Bitter Melon",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 35),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Golden Egg"] = {
        PlantName = "Golden Egg",
        PlantData = {
            GrowRate = 1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 1)
        }
    },
    ["Flare Daisy"] = {
        PlantName = "Flare Daisy",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Duskpuff = {
        PlantName = "Duskpuff",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    Mangosteen = {
        PlantName = "Mangosteen",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Poseidon Plant"] = {
        PlantName = "Poseidon Plant",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Gleamroot = {
        PlantName = "Gleamroot",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(120, 140)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Princess Thorn"] = {
        PlantName = "Princess Thorn",
        PlantData = {
            GrowRate = 0.001,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6),
            GrowFruitTime = NumberRange.new(400, 500)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Mandrake = {
        PlantName = "Mandrake",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Canary Melon"] = {
        PlantName = "Canary Melon",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(120, 140)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Amberheart = {
        PlantName = "Amberheart",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Crown of Thorns"] = {
        PlantName = "Crown of Thorns",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 5),
            GrowFruitTime = NumberRange.new(20, 40)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Calla Lily"] = {
        PlantName = "Calla Lily",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 32),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    Cyclamen = {
        PlantName = "Cyclamen",
        PlantData = {
            GrowRate = 0.0015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(280, 300)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Glowpod = {
        PlantName = "Glowpod",
        PlantData = {
            GrowRate = 0.5,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 30),
            GrowFruitTime = NumberRange.new(30, 40)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Flare Melon"] = {
        PlantName = "Flare Melon",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    Willowberry = {
        PlantName = "Willowberry",
        PlantData = {
            GrowRate = 0.0025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 5),
            GrowFruitTime = NumberRange.new(700, 780)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    Sunbulb = {
        PlantName = "Sunbulb",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(30, 40)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Glowthorn = {
        PlantName = "Glowthorn",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(24, 36),
            GrowFruitTime = NumberRange.new(90, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Lightshoot = {
        PlantName = "Lightshoot",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Briar Rose"] = {
        PlantName = "Briar Rose",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8)
        }
    },
    ["Pink Rose"] = {
        PlantName = "Pink Rose",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8)
        }
    },
    ["Spirit Flower"] = {
        PlantName = "Spirit Flower",
        PlantData = {
            GrowRate = 0.018,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(24, 36),
            GrowFruitTime = NumberRange.new(120, 140)
        },
        FruitData = {
            GrowRate = 0.5,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Wispwing = {
        PlantName = "Wispwing",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(60, 80),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18)
        }
    },
    ["Emerald Bud"] = {
        PlantName = "Emerald Bud",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.15,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Pyracantha = {
        PlantName = "Pyracantha",
        PlantData = {
            GrowRate = 0.075,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(90, 110)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5)
        }
    },
    Aetherfruit = {
        PlantName = "Aetherfruit",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(15, 15),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(4, 5)
        }
    },
    Radish = {
        PlantName = "Radish",
        PlantData = {
            GrowRate = 0.55,
            PlantDown = 0.65,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Blue Raspberry"] = {
        PlantName = "Blue Raspberry",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 1.5)
        }
    },
    ["Horned Melon"] = {
        PlantName = "Horned Melon",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    Ackee = {
        PlantName = "Ackee",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Urchin Plant"] = {
        PlantName = "Urchin Plant",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 15),
            GrowFruitTime = NumberRange.new(90, 110)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Pixie Faern"] = {
        PlantName = "Pixie Faern",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Untold Bell"] = {
        PlantName = "Untold Bell",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(20, 25),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(3, 4)
        }
    },
    Turnip = {
        PlantName = "Turnip",
        PlantData = {
            GrowRate = 0.036,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Parsley = {
        PlantName = "Parsley",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2),
            GrowFruitTime = NumberRange.new(1, 2)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Meyer Lemon"] = {
        PlantName = "Meyer Lemon",
        PlantData = {
            GrowRate = 0.0167,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Carnival Pumpkin"] = {
        PlantName = "Carnival Pumpkin",
        PlantData = {
            GrowRate = 0.0067,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(150, 180)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Kniphofia = {
        PlantName = "Kniphofia",
        PlantData = {
            GrowRate = 0.0014,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Golden Peach"] = {
        PlantName = "Golden Peach",
        PlantData = {
            GrowRate = 0.0025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(90, 180)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Maple Resin"] = {
        PlantName = "Maple Resin",
        PlantData = {
            GrowRate = 0.0017,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(300, 380)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Mangrove = {
        PlantName = "Mangrove",
        PlantData = {
            GrowRate = 0.0017,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(300, 380)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Sundew = {
        PlantName = "Sundew",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Black Bat Flower"] = {
        PlantName = "Black Bat Flower",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Mandrone Berry"] = {
        PlantName = "Mandrone Berry",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Corpse Flower"] = {
        PlantName = "Corpse Flower",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 32),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Inferno Quince"] = {
        PlantName = "Inferno Quince",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    Multitrap = {
        PlantName = "Multitrap",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    ["Naval Wort"] = {
        PlantName = "Naval Wort",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 35),
            GrowFruitTime = NumberRange.new(150, 180)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    ["Evo Beetroot I"] = {
        PlantName = "Evo Beetroot I",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Beetroot II"] = {
        PlantName = "Evo Beetroot II",
        PlantData = {
            GrowRate = 0.009,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Beetroot III"] = {
        PlantName = "Evo Beetroot III",
        PlantData = {
            GrowRate = 0.0045,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Beetroot IV"] = {
        PlantName = "Evo Beetroot IV",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(400, 480)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.5, 3)
        }
    },
    ["Evo Blueberry I"] = {
        PlantName = "Evo Blueberry I",
        PlantData = {
            GrowRate = 0.032,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Blueberry II"] = {
        PlantName = "Evo Blueberry II",
        PlantData = {
            GrowRate = 0.0096,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Blueberry III"] = {
        PlantName = "Evo Blueberry III",
        PlantData = {
            GrowRate = 0.0032,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Blueberry IV"] = {
        PlantName = "Evo Blueberry IV",
        PlantData = {
            GrowRate = 0.0032,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(400, 480)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.5, 3)
        }
    },
    ["Evo Pumpkin I"] = {
        PlantName = "Evo Pumpkin I",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Pumpkin II"] = {
        PlantName = "Evo Pumpkin II",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Pumpkin III"] = {
        PlantName = "Evo Pumpkin III",
        PlantData = {
            GrowRate = 0.0015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Pumpkin IV"] = {
        PlantName = "Evo Pumpkin IV",
        PlantData = {
            GrowRate = 0.001,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(400, 480)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.5, 3)
        }
    },
    ["Evo Mushroom I"] = {
        PlantName = "Evo Mushroom I",
        PlantData = {
            GrowRate = 0.009,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Mushroom II"] = {
        PlantName = "Evo Mushroom II",
        PlantData = {
            GrowRate = 0.0035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Mushroom III"] = {
        PlantName = "Evo Mushroom III",
        PlantData = {
            GrowRate = 0.0017,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Evo Mushroom IV"] = {
        PlantName = "Evo Mushroom IV",
        PlantData = {
            GrowRate = 0.003,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(400, 480)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.5, 3)
        }
    },
    ["Evo Apple I"] = {
        PlantName = "Evo Apple I",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.5, 3)
        }
    },
    ["Evo Apple II"] = {
        PlantName = "Evo Apple II",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Evo Apple III"] = {
        PlantName = "Evo Apple III",
        PlantData = {
            GrowRate = 0.007,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 11)
        }
    },
    ["Evo Apple IV"] = {
        PlantName = "Evo Apple IV",
        PlantData = {
            GrowRate = 0.006,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 30),
            GrowFruitTime = NumberRange.new(400, 440)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 17)
        }
    },
    Hazelnut = {
        PlantName = "Hazelnut",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(90, 110)
        },
        FruitData = {
            GrowRate = 0.09,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    Persimmon = {
        PlantName = "Persimmon",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 36),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Acorn = {
        PlantName = "Acorn",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    ["Acorn Squash"] = {
        PlantName = "Acorn Squash",
        PlantData = {
            GrowRate = 0.2,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.03, 0.05)
        }
    },
    Ferntail = {
        PlantName = "Ferntail",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 16),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    Pecan = {
        PlantName = "Pecan",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 25),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 25)
        }
    },
    ["Fissure Berry"] = {
        PlantName = "Fissure Berry",
        PlantData = {
            GrowRate = 0.5,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18)
        }
    },
    ["Bloodred Mushroom"] = {
        PlantName = "Bloodred Mushroom",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.5, 9.85),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 4)
        }
    },
    ["Jack O Lantern"] = {
        PlantName = "Jack O Lantern",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 8),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.5, 3)
        }
    },
    ["Ghoul Root"] = {
        PlantName = "Ghoul Root",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 40),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Chicken Feed"] = {
        PlantName = "Chicken Feed",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 24),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Seer Vine"] = {
        PlantName = "Seer Vine",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14),
            GrowFruitTime = NumberRange.new(200, 220)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.5, 3)
        }
    },
    ["Poison Apple"] = {
        PlantName = "Poison Apple",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17, 18),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Alien Apple"] = {
        PlantName = "Alien Apple",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17, 18),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    Banesberry = {
        PlantName = "Banesberry",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(90, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 4)
        }
    },
    ["Candy Cornflower"] = {
        PlantName = "Candy Cornflower",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(90, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 4)
        }
    },
    ["Blood Orange"] = {
        PlantName = "Blood Orange",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 28),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Zombie Fruit"] = {
        PlantName = "Zombie Fruit",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 20),
            GrowFruitTime = NumberRange.new(5, 15)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 4)
        }
    },
    ["Wisp Flower"] = {
        PlantName = "Wisp Flower",
        PlantData = {
            GrowRate = 0.08,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 18),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Mummy\'s Hand"] = {
        PlantName = "Mummy\'s Hand",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17, 17),
            GrowFruitTime = NumberRange.new(200, 220)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 8)
        }
    },
    ["Weeping Branch"] = {
        PlantName = "Weeping Branch",
        PlantData = {
            GrowRate = 0.009,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 28),
            GrowFruitTime = NumberRange.new(140, 170)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    ["Ghost Bush"] = {
        PlantName = "Ghost Bush",
        PlantData = {
            GrowRate = 0.25,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 12),
            GrowFruitTime = NumberRange.new(150, 200)
        },
        FruitData = {
            GrowRate = 0.35,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    Devilroot = {
        PlantName = "Devilroot",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 18),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    Wereplant = {
        PlantName = "Wereplant",
        PlantData = {
            GrowRate = 0.011,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 28),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Severed Spine"] = {
        PlantName = "Severed Spine",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(140, 170)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    ["Glass Kiwi"] = {
        PlantName = "Glass Kiwi",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 10),
            GrowFruitTime = NumberRange.new(200, 220)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Spider Vine"] = {
        PlantName = "Spider Vine",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14),
            GrowFruitTime = NumberRange.new(200, 220)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 9)
        }
    },
    ["Monster Flower"] = {
        PlantName = "Monster Flower",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17, 21),
            GrowFruitTime = NumberRange.new(300, 350)
        },
        FruitData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(11, 13)
        }
    },
    ["Horned Redrose"] = {
        PlantName = "Horned Redrose",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Banana Orchid"] = {
        PlantName = "Banana Orchid",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(90, 110)
        },
        FruitData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Viburnum Berry"] = {
        PlantName = "Viburnum Berry",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 9),
            GrowFruitTime = NumberRange.new(120, 140)
        },
        FruitData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7)
        }
    },
    ["Buddhas Hand"] = {
        PlantName = "Buddhas Hand",
        PlantData = {
            GrowRate = 0.021,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 14),
            GrowFruitTime = NumberRange.new(160, 180)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Ghost Pepper"] = {
        PlantName = "Ghost Pepper",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 18),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 12)
        }
    },
    Mahogany = {
        PlantName = "Mahogany",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 18),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 12)
        }
    },
    Thornspire = {
        PlantName = "Thornspire",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(26, 28),
            GrowFruitTime = NumberRange.new(300, 300)
        },
        FruitData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 15)
        }
    },
    Wyrmvine = {
        PlantName = "Wyrmvine",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(400, 460)
        },
        FruitData = {
            GrowRate = 0.001,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7.85, 8.5)
        }
    },
    ["Orange Delight"] = {
        PlantName = "Orange Delight",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 5),
            GrowFruitTime = NumberRange.new(80, 100)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 4)
        }
    },
    Protea = {
        PlantName = "Protea",
        PlantData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 18),
            GrowFruitTime = NumberRange.new(140, 160)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 10)
        }
    },
    Baobab = {
        PlantName = "Baobab",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 32),
            GrowFruitTime = NumberRange.new(400, 420)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20)
        }
    },
    Daisy = {
        PlantName = "Daisy",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    ["Bamboo Tree"] = {
        PlantName = "Bamboo Tree",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 5),
            GrowFruitTime = NumberRange.new(90, 110)
        },
        FruitData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Amberfruit Shrub"] = {
        PlantName = "Amberfruit Shrub",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 9),
            GrowFruitTime = NumberRange.new(120, 140)
        },
        FruitData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7)
        }
    },
    ["Castor Bean"] = {
        PlantName = "Castor Bean",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 14),
            GrowFruitTime = NumberRange.new(160, 180)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Java Banana"] = {
        PlantName = "Java Banana",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 18),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 12)
        }
    },
    ["Peacock Tail"] = {
        PlantName = "Peacock Tail",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 35),
            GrowFruitTime = NumberRange.new(400, 500)
        },
        FruitData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 15)
        }
    },
    ["Gem Fruit"] = {
        PlantName = "Gem Fruit",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(90, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Coilvine = {
        PlantName = "Coilvine",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(250, 250)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    Asteris = {
        PlantName = "Asteris",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(40, 40),
            GrowFruitTime = NumberRange.new(400, 400)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 14)
        }
    },
    ["Lumin Bloom"] = {
        PlantName = "Lumin Bloom",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(120, 120)
        },
        FruitData = {
            GrowRate = 0.08,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Luna Stem"] = {
        PlantName = "Luna Stem",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8)
        }
    },
    Zucchini = {
        PlantName = "Zucchini",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 16),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 26)
        }
    },
    Olive = {
        PlantName = "Olive",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    ["Hollow Bamboo"] = {
        PlantName = "Hollow Bamboo",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 22),
            GrowFruitTime = NumberRange.new(100, 140)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 9)
        }
    },
    Yarrow = {
        PlantName = "Yarrow",
        PlantData = {
            GrowRate = 0.007,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(26, 28),
            GrowFruitTime = NumberRange.new(400, 460)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 4)
        }
    },
    Pomegranate = {
        PlantName = "Pomegranate",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12),
            GrowFruitTime = NumberRange.new(90, 110)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Wild Pineapple"] = {
        PlantName = "Wild Pineapple",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 24),
            GrowFruitTime = NumberRange.new(300, 300)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 8)
        }
    },
    Coinfruit = {
        PlantName = "Coinfruit",
        PlantData = {
            GrowRate = 0.15,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 8),
            GrowFruitTime = NumberRange.new(100, 100)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 8)
        }
    },
    Sherrybloom = {
        PlantName = "Sherrybloom",
        PlantData = {
            GrowRate = 0.045,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 16),
            GrowFruitTime = NumberRange.new(200, 200)
        },
        FruitData = {
            GrowRate = 0.067,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7)
        }
    },
    ["Pinkside Dandelion"] = {
        PlantName = "Pinkside Dandelion",
        PlantData = {
            GrowRate = 0.011,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(36, 40),
            GrowFruitTime = NumberRange.new(400, 400)
        },
        FruitData = {
            GrowRate = 0.08,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 12)
        }
    },
    ["Gingerbread Blossom"] = {
        PlantName = "Gingerbread Blossom",
        PlantData = {
            GrowRate = 0.023,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(48, 48),
            GrowFruitTime = NumberRange.new(500, 500)
        },
        FruitData = {
            GrowRate = 0.045,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12)
        }
    },
    ["Heart Blossom"] = {
        PlantName = "Heart Blossom",
        PlantData = {
            GrowRate = 0.023,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(48, 48),
            GrowFruitTime = NumberRange.new(500, 500)
        },
        FruitData = {
            GrowRate = 0.045,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12)
        }
    },
    ["Cookie Stack"] = {
        PlantName = "Cookie Stack",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12),
            GrowFruitTime = NumberRange.new(80, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    Poinsettia = {
        PlantName = "Poinsettia",
        PlantData = {
            GrowRate = 0.08,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(120, 140)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 8)
        }
    },
    Antlerbloom = {
        PlantName = "Antlerbloom",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 30),
            GrowFruitTime = NumberRange.new(200, 300)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    ["Holly Berry"] = {
        PlantName = "Holly Berry",
        PlantData = {
            GrowRate = 0.075,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 18),
            GrowFruitTime = NumberRange.new(250, 350)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 9)
        }
    },
    ["Gift Berry"] = {
        PlantName = "Gift Berry",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 30),
            GrowFruitTime = NumberRange.new(400, 500)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    ["Frosty Bite"] = {
        PlantName = "Frosty Bite",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Cryo Rose"] = {
        PlantName = "Cryo Rose",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(60, 100)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Bush Flake"] = {
        PlantName = "Bush Flake",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 20),
            GrowFruitTime = NumberRange.new(100, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14)
        }
    },
    Rosemary = {
        PlantName = "Rosemary",
        PlantData = {
            GrowRate = 0.018,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 34),
            GrowFruitTime = NumberRange.new(160, 200)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 18)
        }
    },
    Cryoshard = {
        PlantName = "Cryoshard",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(28, 32),
            GrowFruitTime = NumberRange.new(300, 350)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 22)
        }
    },
    Frostwing = {
        PlantName = "Frostwing",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0.333,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(400, 440)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(40, 44)
        }
    },
    ["Pollen Cone"] = {
        PlantName = "Pollen Cone",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(30, 44),
            GrowFruitTime = NumberRange.new(333, 350)
        },
        FruitData = {
            GrowRate = 0.015,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(17, 23)
        }
    },
    ["Peppermint Pop"] = {
        PlantName = "Peppermint Pop",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 1)
        }
    },
    Gumdrop = {
        PlantName = "Gumdrop",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(80, 100)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7)
        }
    },
    ["Christmas Cracker"] = {
        PlantName = "Christmas Cracker",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(100, 140)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8)
        }
    },
    ["Candy Cane"] = {
        PlantName = "Candy Cane",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Snowman Sprout"] = {
        PlantName = "Snowman Sprout",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0.333,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(300, 400)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Christmas Tree"] = {
        PlantName = "Christmas Tree",
        PlantData = {
            GrowRate = 1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 5)
        }
    },
    ["Sparkle Slice"] = {
        PlantName = "Sparkle Slice",
        PlantData = {
            GrowRate = 0.02026,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 26),
            GrowFruitTime = NumberRange.new(222, 222)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 4)
        }
    },
    ["Colorpop Crop"] = {
        PlantName = "Colorpop Crop",
        PlantData = {
            GrowRate = 0.02026,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(40, 45),
            GrowFruitTime = NumberRange.new(333, 333)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Firework Fern"] = {
        PlantName = "Firework Fern",
        PlantData = {
            GrowRate = 0.02026,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(60, 60),
            GrowFruitTime = NumberRange.new(444, 444)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Kernel Curl"] = {
        PlantName = "Kernel Curl",
        PlantData = {
            GrowRate = 0.007,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(129, 160)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Bonanza Bloom"] = {
        PlantName = "Bonanza Bloom",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(28, 32),
            GrowFruitTime = NumberRange.new(280, 320)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    Shimmersprout = {
        PlantName = "Shimmersprout",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = -0.5,
            GrowTickTime = NumberRange.new(3, 4),
            GrowFruitTime = NumberRange.new(80, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Crimson Cranberry"] = {
        PlantName = "Crimson Cranberry",
        PlantData = {
            GrowRate = 0.095,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 4)
        }
    },
    ["Confetti Tula"] = {
        PlantName = "Confetti Tula",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 14),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 3)
        }
    },
    Hexberry = {
        PlantName = "Hexberry",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.11,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 4)
        }
    },
    Peanut = {
        PlantName = "Peanut",
        PlantData = {
            GrowRate = 0.0085,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 11),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.09,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 5)
        }
    },
    ["Yellow Core"] = {
        PlantName = "Yellow Core",
        PlantData = {
            GrowRate = 0.0066,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(160, 180)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    Crunchnut = {
        PlantName = "Crunchnut",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 22),
            GrowFruitTime = NumberRange.new(220, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7)
        }
    },
    Candlite = {
        PlantName = "Candlite",
        PlantData = {
            GrowRate = 0.0099,
            PlantDown = 0.333,
            GrowTickTime = NumberRange.new(18, 19),
            GrowFruitTime = NumberRange.new(220, 220)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 9)
        }
    },
    ["Frost Pepper"] = {
        PlantName = "Frost Pepper",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(300, 300)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13)
        }
    },
    Plumwillow = {
        PlantName = "Plumwillow",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 15),
            GrowFruitTime = NumberRange.new(300, 300)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 15)
        }
    },
    ["Blooming Cactus"] = {
        PlantName = "Blooming Cactus",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 34),
            GrowFruitTime = NumberRange.new(350, 350)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 18)
        }
    },
    ["Madcrown Vine"] = {
        PlantName = "Madcrown Vine",
        PlantData = {
            GrowRate = 0.0067,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(42, 44),
            GrowFruitTime = NumberRange.new(400, 400)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24)
        }
    },
    ["Magma Pepper"] = {
        PlantName = "Magma Pepper",
        PlantData = {
            GrowRate = 0.0035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 32),
            GrowFruitTime = NumberRange.new(666, 666)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(33, 33)
        }
    },
    ["Frost Fern"] = {
        PlantName = "Frost Fern",
        PlantData = {
            GrowRate = 0.0072,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20),
            GrowFruitTime = NumberRange.new(200, 200)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 10)
        }
    },
    ["Dragon Sapling"] = {
        PlantName = "Dragon Sapling",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Sinisterdrip = {
        PlantName = "Sinisterdrip",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Log Pumpkin"] = {
        PlantName = "Log Pumpkin",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Aura Flora"] = {
        PlantName = "Aura Flora",
        PlantData = {
            GrowRate = 0.21,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 13.24),
            GrowFruitTime = NumberRange.new(72, 85)
        },
        FruitData = {
            GrowRate = 0.12,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 7.35)
        }
    },
    ["Mutant Carrot"] = {
        PlantName = "Mutant Carrot",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    Spectralis = {
        PlantName = "Spectralis",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Spirit Lantern"] = {
        PlantName = "Spirit Lantern",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Aurora Vine"] = {
        PlantName = "Aurora Vine",
        PlantData = {
            GrowRate = 0.0085,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(20, 40)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 1)
        }
    },
    ["Snaparino Beanarini"] = {
        PlantName = "Snaparino Beanarini",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(90, 120)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    ["Melon Flower"] = {
        PlantName = "Melon Flower",
        PlantData = {
            GrowRate = 0.52,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.785,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Frostspike = {
        PlantName = "Frostspike",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2, 3)
        }
    },
    Torchflare = {
        PlantName = "Torchflare",
        PlantData = {
            GrowRate = 0.01225,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 4.35),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.0175,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.9, 4.15)
        }
    },
    Gooseberry = {
        PlantName = "Gooseberry",
        PlantData = {
            GrowRate = 0.61,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.1, 0.2),
            GrowFruitTime = NumberRange.new(0.1, 0.2)
        },
        FruitData = {
            GrowRate = 0.525,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.2, 0.3)
        }
    },
    Speargrass = {
        PlantName = "Speargrass",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17.8, 18.25),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.0285,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.3, 3.5)
        }
    },
    ["Fall Berry"] = {
        PlantName = "Fall Berry",
        PlantData = {
            GrowRate = 0.085,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7.35, 7.75),
            GrowFruitTime = NumberRange.new(45, 75)
        },
        FruitData = {
            GrowRate = 0.075,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.5, 4)
        }
    },
    Firewell = {
        PlantName = "Firewell",
        PlantData = {
            GrowRate = 0.0015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7.4),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.0085,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.4)
        }
    },
    ["Auburn Pine"] = {
        PlantName = "Auburn Pine",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8.65, 9),
            GrowFruitTime = NumberRange.new(60, 90)
        },
        FruitData = {
            GrowRate = 0.00485,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.35, 3.75)
        }
    },
    ["Autumn Shroom"] = {
        PlantName = "Autumn Shroom",
        PlantData = {
            GrowRate = 0.0585,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.5, 9.85),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.065,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.75, 2)
        }
    },
    ["Black Magic Ears"] = {
        PlantName = "Black Magic Ears",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 35),
            GrowFruitTime = NumberRange.new(150, 180)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    Helenium = {
        PlantName = "Helenium",
        PlantData = {
            GrowRate = 0.41,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.2, 0.35),
            GrowFruitTime = NumberRange.new(0.15, 0.18)
        },
        FruitData = {
            GrowRate = 0.11,
            PlantDown = 0.5,
            GrowTickTime = NumberRange.new(0.125, 0.13)
        }
    },
    Jelpod = {
        PlantName = "Jelpod",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.06, 0.12),
            GrowFruitTime = NumberRange.new(0.082, 0.106)
        },
        FruitData = {
            GrowRate = 0.09,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.03, 0.05)
        }
    },
    ["Filbert Nut"] = {
        PlantName = "Filbert Nut",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.06, 0.12),
            GrowFruitTime = NumberRange.new(0.082, 0.106)
        },
        FruitData = {
            GrowRate = 0.29,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.01, 0.02)
        }
    },
    ["Wild Berry"] = {
        PlantName = "Wild Berry",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = -1.75,
            GrowTickTime = NumberRange.new(7, 8),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.5, 3)
        }
    },
    ["Turkish Hazel"] = {
        PlantName = "Turkish Hazel",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.07, 0.08),
            GrowFruitTime = NumberRange.new(0.012, 0.016)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.025, 0.03)
        }
    },
    Cherry = {
        PlantName = "Cherry",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9.65, 10),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8.35)
        }
    },
    ["Witch Cap"] = {
        PlantName = "Witch Cap",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 24),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Skull Flower"] = {
        PlantName = "Skull Flower",
        PlantData = {
            GrowRate = 0.41,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.07, 0.08),
            GrowFruitTime = NumberRange.new(0.012, 0.016)
        },
        FruitData = {
            GrowRate = 0.41,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.025, 0.03)
        }
    },
    ["Mind Root"] = {
        PlantName = "Mind Root",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.07, 0.08),
            GrowFruitTime = NumberRange.new(0.012, 0.016)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.025, 0.03)
        }
    },
    Vampbloom = {
        PlantName = "Vampbloom",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7)
        }
    },
    Sugarcane = {
        PlantName = "Sugarcane",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7)
        }
    },
    ["Crassula Umbrella"] = {
        PlantName = "Crassula Umbrella",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7),
            GrowFruitTime = NumberRange.new(120, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7)
        }
    },
    Faestar = {
        PlantName = "Faestar",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Madras Thorn"] = {
        PlantName = "Madras Thorn",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Aqua Lily"] = {
        PlantName = "Aqua Lily",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Akebi = {
        PlantName = "Akebi",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Observee = {
        PlantName = "Observee",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Crown Pumpkin"] = {
        PlantName = "Crown Pumpkin",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Cyberflare = {
        PlantName = "Cyberflare",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Rambutan = {
        PlantName = "Rambutan",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Walnut = {
        PlantName = "Walnut",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Leifo Fruit"] = {
        PlantName = "Leifo Fruit",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Festive Bamboo"] = {
        PlantName = "Festive Bamboo",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Iciclesco = {
        PlantName = "Iciclesco",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Icestalite = {
        PlantName = "Icestalite",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Frost Bush"] = {
        PlantName = "Frost Bush",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Grand Cucumber"] = {
        PlantName = "Grand Cucumber",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0.333,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Mauve Fruit"] = {
        PlantName = "Mauve Fruit",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0.333,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    Archling = {
        PlantName = "Archling",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Cold Snap Suckle"] = {
        PlantName = "Cold Snap Suckle",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Monster Plum"] = {
        PlantName = "Monster Plum",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Gift Root"] = {
        PlantName = "Gift Root",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Mammoth Mistletoe"] = {
        PlantName = "Mammoth Mistletoe",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Frostline Flake"] = {
        PlantName = "Frostline Flake",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Wild Frond"] = {
        PlantName = "Wild Frond",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0.333,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 6)
        }
    },
    ["Peach Sun"] = {
        PlantName = "Peach Sun",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 2,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Wintercreep = {
        PlantName = "Wintercreep",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Milk Table"] = {
        PlantName = "Milk Table",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Ornament Vine"] = {
        PlantName = "Ornament Vine",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Tinsel = {
        PlantName = "Tinsel",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Wreath Span"] = {
        PlantName = "Wreath Span",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["New Years Tinsel"] = {
        PlantName = "New Years Tinsel",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Taffy Tree"] = {
        PlantName = "Taffy Tree",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Star Palm"] = {
        PlantName = "Star Palm",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Heart Gem"] = {
        PlantName = "Heart Gem",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Witches Hair"] = {
        PlantName = "Witches Hair",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Luminova = {
        PlantName = "Luminova",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Birds Nest"] = {
        PlantName = "Birds Nest",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(110, 130)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Candy Carrot"] = {
        PlantName = "Candy Carrot",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Chocolate Berry"] = {
        PlantName = "Chocolate Berry",
        PlantData = {
            GrowRate = 0.028,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Gumball = {
        PlantName = "Gumball",
        PlantData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Liquorice = {
        PlantName = "Liquorice",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.5, 3)
        }
    },
    ["Sugar Melon"] = {
        PlantName = "Sugar Melon",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Chocolate Coconut"] = {
        PlantName = "Chocolate Coconut",
        PlantData = {
            GrowRate = 0.15,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(70, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Gummy Cactus"] = {
        PlantName = "Gummy Cactus",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(80, 100)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Egg Melon"] = {
        PlantName = "Egg Melon",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(90, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 6)
        }
    },
    ["Sour Lemon"] = {
        PlantName = "Sour Lemon",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 20),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Eggfruit = {
        PlantName = "Eggfruit",
        PlantData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 28),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Easter Sprout"] = {
        PlantName = "Easter Sprout",
        PlantData = {
            GrowRate = 0.0167,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(167, 167)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 17)
        }
    },
    ["Easter Candy Carrot"] = {
        PlantName = "Easter Candy Carrot",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Easter Chocolate Berry"] = {
        PlantName = "Easter Chocolate Berry",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(20, 30)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Easter Gumball"] = {
        PlantName = "Easter Gumball",
        PlantData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Easter Liquorice"] = {
        PlantName = "Easter Liquorice",
        PlantData = {
            GrowRate = 0.1875,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.5, 3)
        }
    },
    ["Easter Sugar Melon"] = {
        PlantName = "Easter Sugar Melon",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Easter Chocolate Coconut"] = {
        PlantName = "Chocolate Coconut",
        PlantData = {
            GrowRate = 0.15,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(70, 90)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Easter Gummy Cactus"] = {
        PlantName = "Easter Gummy Cactus",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(80, 100)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Easter Egg Melon"] = {
        PlantName = "Easter Egg Melon",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(90, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 6)
        }
    },
    ["Easter Sour Lemon"] = {
        PlantName = "Easter Sour Lemon",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 20),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Easter Eggfruit"] = {
        PlantName = "Easter Eggfruit",
        PlantData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 28),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    ["Easter Easter Sprout"] = {
        PlantName = "Easter Easter Sprout",
        PlantData = {
            GrowRate = 0.0167,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(167, 167)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 17)
        }
    },
    Eggsnapper = {
        PlantName = "Eggsnapper",
        PlantData = {
            GrowRate = 0.007,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(33, 33),
            GrowFruitTime = NumberRange.new(333, 333)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13)
        }
    },
    ["Drowned Flower"] = {
        PlantName = "Drowned Flower",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8)
        }
    },
    Saskia = {
        PlantName = "Saskia",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(60, 100)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Mini Pumpkin"] = {
        PlantName = "Mini Pumpkin",
        PlantData = {
            GrowRate = 0.25,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 20),
            GrowFruitTime = NumberRange.new(100, 160)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14)
        }
    },
    ["Jungle Cherry"] = {
        PlantName = "Jungle Cherry",
        PlantData = {
            GrowRate = 0.009,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 34),
            GrowFruitTime = NumberRange.new(160, 200)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 18)
        }
    },
    ["Amazon Feather Fern"] = {
        PlantName = "Amazon Feather Fern",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(28, 32),
            GrowFruitTime = NumberRange.new(300, 350)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 22)
        }
    },
    ["Boreal Orange"] = {
        PlantName = "Boreal Orange",
        PlantData = {
            GrowRate = 0.0025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 22),
            GrowFruitTime = NumberRange.new(400, 440)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(40, 44)
        }
    },
    ["Purple Treeshroom"] = {
        PlantName = "Purple Treeshroom",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 44),
            GrowFruitTime = NumberRange.new(333, 350)
        },
        FruitData = {
            GrowRate = 0.015,
            PlantDown = -0,
            GrowTickTime = NumberRange.new(17, 23)
        }
    },
    ["DJ Delight"] = {
        PlantName = "DJ Delight",
        PlantData = {
            GrowRate = 0.0267,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7),
            GrowFruitTime = NumberRange.new(167, 167)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 17)
        }
    },
    ["Blue Candypop"] = {
        PlantName = "Blue Candypop",
        PlantData = {
            GrowRate = 0.028,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(40, 60)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Elder Candy Blossom"] = {
        PlantName = "Elder Candy Blossom",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Bunny Berry"] = {
        PlantName = "Bunny Berry",
        PlantData = {
            GrowRate = 0.3,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20),
            GrowFruitTime = NumberRange.new(100, 150)
        },
        FruitData = {
            GrowRate = 0.5,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Bonnet Bloom"] = {
        PlantName = "Bonnet Bloom",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7),
            GrowFruitTime = NumberRange.new(160, 160)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 16)
        }
    },
    ["Egg Shroom"] = {
        PlantName = "Egg Shroom",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 22),
            GrowFruitTime = NumberRange.new(300, 300)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 16)
        }
    },
    ["Waddling Willow"] = {
        PlantName = "Waddling Willow",
        PlantData = {
            GrowRate = 0.009,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18),
            GrowFruitTime = NumberRange.new(300, 350)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    ["Marshmallow Root"] = {
        PlantName = "Marshmallow Root",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 10),
            GrowFruitTime = NumberRange.new(300, 350)
        },
        FruitData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14)
        }
    },
    ["Basket Bouquet"] = {
        PlantName = "Basket Bouquet",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(100, 140)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 10)
        }
    },
    ["Jelly Bean Sprout"] = {
        PlantName = "Jelly Bean Sprout",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 20)
        }
    },
    ["Sugar Snapdragon"] = {
        PlantName = "Sugar Snapdragon",
        PlantData = {
            GrowRate = 0.002,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(33, 33),
            GrowFruitTime = NumberRange.new(333, 333)
        },
        FruitData = {
            GrowRate = 0.033,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    ["Honey Daisy"] = {
        PlantName = "Honey Daisy",
        PlantData = {
            GrowRate = 0.5,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 10)
        }
    },
    ["Honey Dew"] = {
        PlantName = "Honey Dew",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12),
            GrowFruitTime = NumberRange.new(100, 140)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Ambercomb = {
        PlantName = "Ambercomb",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(160, 200)
        },
        FruitData = {
            GrowRate = 0.08,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    Coneflower = {
        PlantName = "Coneflower",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(26, 28),
            GrowFruitTime = NumberRange.new(220, 240)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Birds of Paradise"] = {
        PlantName = "Birds of Paradise",
        PlantData = {
            GrowRate = 0.006,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    ["Honey Honey Daisy"] = {
        PlantName = "Honey Honey Daisy",
        PlantData = {
            GrowRate = 0.5,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 10)
        }
    },
    ["Honey Honey Dew"] = {
        PlantName = "Honey Honey Dew",
        PlantData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12),
            GrowFruitTime = NumberRange.new(100, 140)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Honey Ambercomb"] = {
        PlantName = "Honey Ambercomb",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(160, 200)
        },
        FruitData = {
            GrowRate = 0.08,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    ["Honey Coneflower"] = {
        PlantName = "Honey Coneflower",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(26, 28),
            GrowFruitTime = NumberRange.new(220, 240)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Honey Birds of Paradise"] = {
        PlantName = "Honey Birds of Paradise",
        PlantData = {
            GrowRate = 0.006,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    Stingpetal = {
        PlantName = "Stingpetal",
        PlantData = {
            GrowRate = 0.5,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Woodbine = {
        PlantName = "Woodbine",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 12)
        }
    },
    ["Honey Dipper"] = {
        PlantName = "Honey Dipper",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(150, 180)
        },
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.01,
            GrowTickTime = NumberRange.new(12, 15)
        }
    },
    ["Bee Bell"] = {
        PlantName = "Bee Bell",
        PlantData = {
            GrowRate = 0.023,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 25),
            GrowFruitTime = NumberRange.new(190, 240)
        },
        FruitData = {
            GrowRate = 0.038,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18)
        }
    },
    ["Hive Petal"] = {
        PlantName = "Hive Petal",
        PlantData = {
            GrowRate = 0.017,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 28),
            GrowFruitTime = NumberRange.new(250, 280)
        },
        FruitData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 21)
        }
    },
    ["Bumble Bulb"] = {
        PlantName = "Bumble Bulb",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 30),
            GrowFruitTime = NumberRange.new(290, 320)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(21, 24)
        }
    },
    ["Honey Carrot"] = {
        PlantName = "Honey Carrot",
        PlantData = {
            PlantDown = 0.25,
            GrowRate = 0.4,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Honey Strawberry"] = {
        PlantName = "Honey Strawberry",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = 0.1,
            GrowRate = 0.25,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(13, 18)
        }
    },
    ["Honey Blueberry"] = {
        PlantName = "Honey Blueberry",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.02,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        }
    },
    ["Honey Buttercup"] = {
        PlantName = "Honey Buttercup",
        PlantData = {
            PlantDown = 0.25,
            GrowRate = 0.2,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Honey Tomato"] = {
        PlantName = "Honey Tomato",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = 0.25,
            GrowRate = 0.02,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        }
    },
    ["Honey Corn"] = {
        PlantName = "Honey Corn",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = 0.25,
            GrowRate = 0.005,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(70, 90)
        }
    },
    ["Honey Daffodil"] = {
        PlantName = "Honey Daffodil",
        PlantData = {
            PlantDown = 0.25,
            GrowRate = 0.4,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Honey Watermelon"] = {
        PlantName = "Honey Watermelon",
        PlantData = {
            PlantDown = -0.25,
            GrowRate = 0.01,
            GrowTickTime = NumberRange.new(1.6, 2.4)
        }
    },
    ["Honey Pumpkin"] = {
        PlantName = "Honey Pumpkin",
        PlantData = {
            PlantDown = -0.25,
            GrowRate = 0.005,
            GrowTickTime = NumberRange.new(1.6, 2.4)
        }
    },
    ["Honey Apple"] = {
        PlantName = "Honey Apple",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.02,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        }
    },
    ["Honey Bamboo"] = {
        PlantName = "Honey Bamboo",
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.1875,
            GrowTickTime = NumberRange.new(1.5, 3)
        }
    },
    ["Honey Coconut"] = {
        PlantName = "Honey Coconut",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.001,
            GrowTickTime = NumberRange.new(1.6, 2.4),
            GrowFruitTime = NumberRange.new(40, 60)
        }
    },
    ["Honey Cactus"] = {
        PlantName = "Honey Cactus",
        FruitData = {
            PlantDown = -0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = 2,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        }
    },
    ["Honey Dragon Fruit"] = {
        PlantName = "Honey Dragon Fruit",
        FruitData = {
            PlantDown = -0.25,
            GrowRate = 0.25,
            GrowTickTime = NumberRange.new(1, 2)
        },
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        }
    },
    ["Honey Mango"] = {
        PlantName = "Honey Mango",
        FruitData = {
            PlantDown = -0.25,
            GrowRate = 0.025,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = 2,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(290, 310)
        }
    },
    ["Honey Grape"] = {
        PlantName = "Honey Grape",
        FruitData = {
            PlantDown = -0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = 1,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        }
    },
    ["Honey Mushroom"] = {
        PlantName = "Honey Mushroom",
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    ["Honey Pepper"] = {
        PlantName = "Honey Pepper",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(3, 4.5),
            GrowFruitTime = NumberRange.new(80, 160)
        }
    },
    ["Honey Cacao"] = {
        PlantName = "Honey Cacao",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(1, 2)
        },
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(80, 160)
        }
    },
    ["Honey Sunflower"] = {
        PlantName = "Honey Sunflower",
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(6, 8)
        },
        PlantData = {
            PlantDown = 0,
            GrowRate = 0.07,
            GrowTickTime = NumberRange.new(28, 32),
            GrowFruitTime = NumberRange.new(200, 340)
        }
    },
    ["Honey Beanstalk"] = {
        PlantName = "Honey Beanstalk",
        FruitData = {
            PlantDown = -0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        },
        PlantData = {
            PlantDown = 1,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        }
    },
    ["Honey Ember Lily"] = {
        PlantName = "Honey Ember Lily",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.035,
            GrowTickTime = NumberRange.new(6, 8)
        },
        PlantData = {
            PlantDown = -1.15,
            GrowRate = 0.0285,
            GrowTickTime = NumberRange.new(15, 18),
            GrowFruitTime = NumberRange.new(110, 160)
        }
    },
    ["Honey Sugar Apple"] = {
        PlantName = "Honey Sugar Apple",
        FruitData = {
            PlantDown = 0.25,
            GrowRate = 0.025,
            GrowTickTime = NumberRange.new(5.5, 7)
        },
        PlantData = {
            PlantDown = -0.5,
            GrowRate = 0.025,
            GrowTickTime = NumberRange.new(9, 11),
            GrowFruitTime = NumberRange.new(40, 80)
        }
    },
    ["Honey Burning Bud"] = {
        PlantName = "Honey Burning Bud",
        FruitData = {
            PlantDown = -0.25,
            GrowRate = 0.05,
            GrowTickTime = NumberRange.new(1, 2)
        },
        PlantData = {
            PlantDown = 4,
            GrowRate = 0.005,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(250, 300)
        }
    },
    ["Honey Giant Pinecone"] = {
        PlantName = "Honey Giant Pinecone",
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.075,
            GrowTickTime = NumberRange.new(10.35, 11)
        },
        PlantData = {
            PlantDown = 0,
            GrowRate = 0.011,
            GrowTickTime = NumberRange.new(20, 21),
            GrowFruitTime = NumberRange.new(180, 200)
        }
    },
    ["Honey Elder Strawberry"] = {
        PlantName = "Honey Elder Strawberry",
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.0125,
            GrowTickTime = NumberRange.new(5, 6)
        },
        PlantData = {
            PlantDown = 0,
            GrowRate = 0.005,
            GrowTickTime = NumberRange.new(20.4, 20.65),
            GrowFruitTime = NumberRange.new(200, 240)
        }
    },
    ["Honey Romanesco"] = {
        PlantName = "Honey Romanesco",
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.02,
            GrowTickTime = NumberRange.new(3.6, 4)
        },
        PlantData = {
            PlantDown = 0,
            GrowRate = 0.001,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(333, 366)
        }
    },
    ["Honey Crimson Thorn"] = {
        PlantName = "Honey Crimson Thorn",
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.01,
            GrowTickTime = NumberRange.new(0.7, 1.1)
        },
        PlantData = {
            PlantDown = 0,
            GrowRate = 0.001,
            GrowTickTime = NumberRange.new(1.7, 2.1),
            GrowFruitTime = NumberRange.new(400, 500)
        }
    },
    ["Honey Zebrazinkle"] = {
        PlantName = "Honey Zebrazinkle",
        FruitData = {
            PlantDown = -0.25,
            GrowRate = 0.02,
            GrowTickTime = NumberRange.new(5, 6)
        },
        PlantData = {
            PlantDown = 4,
            GrowRate = 0.005,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(250, 300)
        }
    },
    ["Honey Octobloom"] = {
        PlantName = "Honey Octobloom",
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.04,
            GrowTickTime = NumberRange.new(8, 8)
        },
        PlantData = {
            PlantDown = 0,
            GrowRate = 0.04,
            GrowTickTime = NumberRange.new(88, 88),
            GrowFruitTime = NumberRange.new(333, 333)
        }
    },
    ["Honey Alien Apple"] = {
        PlantName = "Honey Alien Apple",
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.01,
            GrowTickTime = NumberRange.new(4, 6)
        },
        PlantData = {
            PlantDown = 0,
            GrowRate = 0.015,
            GrowTickTime = NumberRange.new(17, 18),
            GrowFruitTime = NumberRange.new(300, 360)
        }
    },
    ["Honey Pollenvine"] = {
        PlantName = "Honey Pollenvine",
        PlantData = {
            GrowRate = 0.009,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(400, 420)
        },
        FruitData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    ["Honey Stingpetal"] = {
        PlantName = "Honey Stingpetal",
        PlantData = {
            GrowRate = 0.5,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(80, 90)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 6)
        }
    },
    ["Honey Woodbine"] = {
        PlantName = "Honey Woodbine",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 12)
        }
    },
    ["Honey Honey Dipper"] = {
        PlantName = "Honey Honey Dipper",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(150, 180)
        },
        FruitData = {
            PlantDown = 0,
            GrowRate = 0.01,
            GrowTickTime = NumberRange.new(12, 15)
        }
    },
    ["Honey Bee Bell"] = {
        PlantName = "Honey Bee Bell",
        PlantData = {
            GrowRate = 0.023,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 25),
            GrowFruitTime = NumberRange.new(190, 240)
        },
        FruitData = {
            GrowRate = 0.038,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18)
        }
    },
    ["Honey Hive Petal"] = {
        PlantName = "Honey Hive Petal",
        PlantData = {
            GrowRate = 0.017,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 28),
            GrowFruitTime = NumberRange.new(250, 280)
        },
        FruitData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 21)
        }
    },
    ["Honey Bumble Bulb"] = {
        PlantName = "Honey Bumble Bulb",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 30),
            GrowFruitTime = NumberRange.new(290, 320)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(21, 24)
        }
    },
    Pollenvine = {
        PlantName = "Pollenvine",
        PlantData = {
            GrowRate = 0.009,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(400, 420)
        },
        FruitData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    ["Obby Oddvine"] = {
        PlantName = "Obby Oddvine",
        PlantData = {
            GrowRate = 0.045,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17, 18),
            GrowFruitTime = NumberRange.new(200, 260)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14)
        }
    },
    ["Pollen Puffball"] = {
        PlantName = "Pollen Puffball",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 12)
        }
    },
    ["Grape Droplet"] = {
        PlantName = "Grape Droplet",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(290, 310)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    Pohutukawa = {
        PlantName = "Pohutukawa",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(28, 28),
            GrowFruitTime = NumberRange.new(400, 420)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24)
        }
    },
    ["Honey Hollow"] = {
        PlantName = "Honey Hollow",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 18),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 14)
        }
    },
    ["Honey Honey Hollow"] = {
        PlantName = "Honey Honey Hollow",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 18),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 14)
        }
    },
    ["Starbloom Daisy"] = {
        PlantName = "Starbloom Daisy",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6),
            GrowFruitTime = NumberRange.new(60, 70)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Cocoa Pod"] = {
        PlantName = "Cocoa Pod",
        PlantData = {
            GrowRate = 0.028,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7),
            GrowFruitTime = NumberRange.new(100, 100)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    Astrobush = {
        PlantName = "Astrobush",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 14),
            GrowFruitTime = NumberRange.new(200, 200)
        },
        FruitData = {
            GrowRate = 0.08,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 4)
        }
    },
    ["Lumi Shroom"] = {
        PlantName = "Lumi Shroom",
        PlantData = {
            GrowRate = 0.0035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(250, 250)
        },
        FruitData = {
            GrowRate = 0.06,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Sweetheart Flower"] = {
        PlantName = "Sweetheart Flower",
        PlantData = {
            GrowRate = 0.019,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 18),
            GrowFruitTime = NumberRange.new(200, 222)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8)
        }
    },
    Bendbark = {
        PlantName = "Bendbark",
        PlantData = {
            GrowRate = 0.0075,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(22, 22),
            GrowFruitTime = NumberRange.new(300, 333)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 10)
        }
    },
    ["Pinkfruit Palm"] = {
        PlantName = "Pinkfruit Palm",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 16),
            GrowFruitTime = NumberRange.new(400, 444)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12)
        }
    },
    ["Stinger Reed"] = {
        PlantName = "Stinger Reed",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 9),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 3)
        }
    },
    Spiketail = {
        PlantName = "Spiketail",
        PlantData = {
            GrowRate = 0.0087,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Royal Rose"] = {
        PlantName = "Royal Rose",
        PlantData = {
            GrowRate = 0.0067,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(36, 36),
            GrowFruitTime = NumberRange.new(400, 440)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 9)
        }
    },
    Hexpetal = {
        PlantName = "Hexpetal",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(90, 90)
        },
        FruitData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 3)
        }
    },
    ["Suncrest Orchid"] = {
        PlantName = "Suncrest Orchid",
        PlantData = {
            GrowRate = 0.007,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25),
            GrowFruitTime = NumberRange.new(300, 300)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 9)
        }
    },
    ["Swivel Stinger"] = {
        PlantName = "Swivel Stinger",
        PlantData = {
            GrowRate = 0.0025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(35, 35),
            GrowFruitTime = NumberRange.new(300, 340)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12)
        }
    },
    ["Haskap Berry"] = {
        PlantName = "Haskap Berry",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Bee Lantern"] = {
        PlantName = "Bee Lantern",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(200, 240)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Honey Orange Tulip"] = {
        PlantName = "Honey Orange Tulip",
        PlantData = {
            GrowRate = 0.4,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Amber Flower"] = {
        PlantName = "Amber Flower",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17, 18),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    Hollyhock = {
        PlantName = "Hollyhock",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17, 18),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Glacial Petal"] = {
        PlantName = "Glacial Petal",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(17, 18),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Snakeskin Tulip"] = {
        PlantName = "Snakeskin Tulip",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(250, 250)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Royal Jelly Cup"] = {
        PlantName = "Royal Jelly Cup",
        PlantData = {
            GrowRate = 0.00939,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(36, 40),
            GrowFruitTime = NumberRange.new(340, 380)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 14)
        }
    },
    ["Monarch Jellpod"] = {
        PlantName = "Monarch Jellpod",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(250, 250)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Firepit Flower"] = {
        PlantName = "Firepit Flower",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(100, 100)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7)
        }
    },
    ["Hearth Reed"] = {
        PlantName = "Hearth Reed",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 22),
            GrowFruitTime = NumberRange.new(200, 260)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Firefly Spiral"] = {
        PlantName = "Firefly Spiral",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(300, 350)
        },
        FruitData = {
            GrowRate = 0.006,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Drizzle Cane"] = {
        PlantName = "Drizzle Cane",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(250, 250)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Red Hornet"] = {
        PlantName = "Red Hornet",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(250, 250)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Bear Claw Flower"] = {
        PlantName = "Bear Claw Flower",
        PlantData = {
            GrowRate = 0.045,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(100, 100)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 3)
        }
    },
    ["Venus Beartrap"] = {
        PlantName = "Venus Beartrap",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 16),
            GrowFruitTime = NumberRange.new(200, 200)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 5)
        }
    },
    ["Flame Berry"] = {
        PlantName = "Flame Berry",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(250, 250)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(7, 7)
        }
    },
    ["Smore Suckle"] = {
        PlantName = "Smore Suckle",
        PlantData = {
            GrowRate = 0.007,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(300, 300)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(9, 9)
        }
    },
    ["Campfire Clover"] = {
        PlantName = "Campfire Clover",
        PlantData = {
            GrowRate = 0.0062,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(400, 400)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(11, 11)
        }
    },
    ["Mallow Melt"] = {
        PlantName = "Mallow Melt",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(500, 550)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13)
        }
    },
    ["Smoke Stalk"] = {
        PlantName = "Smoke Stalk",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(160, 180)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    ["Shadow Spine"] = {
        PlantName = "Shadow Spine",
        PlantData = {
            GrowRate = 0.0075,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(300, 320)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13)
        }
    },
    ["Jungle Kiwano"] = {
        PlantName = "Jungle Kiwano",
        PlantData = {
            GrowRate = 0.0045,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(420, 420)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 9)
        }
    },
    Flamebud = {
        PlantName = "Flamebud",
        PlantData = {
            GrowRate = 0.00427,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(300, 320)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13)
        }
    },
    ["Vio Puff"] = {
        PlantName = "Vio Puff",
        PlantData = {
            GrowRate = 0.10681,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(13, 13),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 6)
        }
    },
    ["Storm Bulb"] = {
        PlantName = "Storm Bulb",
        PlantData = {
            GrowRate = 0.04787,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(180, 200)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 8)
        }
    },
    ["Geode Root"] = {
        PlantName = "Geode Root",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(250, 280)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 10)
        }
    },
    ["Chroma Orb"] = {
        PlantName = "Chroma Orb",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(320, 340)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 12)
        }
    },
    ["Polypea Sprout"] = {
        PlantName = "Polypea Sprout",
        PlantData = {
            GrowRate = 0.01486,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(400, 420)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 14)
        }
    },
    ["Volt Lily"] = {
        PlantName = "Volt Lily",
        PlantData = {
            GrowRate = 0.00467,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(500, 550)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 16)
        }
    },
    ["Queen Fruit"] = {
        PlantName = "Queen Fruit",
        PlantData = {
            GrowRate = 0.00375,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 7),
            GrowFruitTime = NumberRange.new(450, 470)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 15)
        }
    },
    ["Freedom Flare"] = {
        PlantName = "Freedom Flare",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(18, 18),
            GrowFruitTime = NumberRange.new(514, 517)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 17)
        }
    },
    ["Tiki Totem"] = {
        PlantName = "Tiki Totem",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25),
            GrowFruitTime = NumberRange.new(555, 555)
        },
        FruitData = {
            GrowRate = 0.04,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    ["Castle Crocus"] = {
        PlantName = "Castle Crocus",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8)
        }
    },
    ["Sun Bloom"] = {
        PlantName = "Sun Bloom",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 15),
            GrowFruitTime = NumberRange.new(150, 180)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 10)
        }
    },
    ["Popsicle Melt"] = {
        PlantName = "Popsicle Melt",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 16)
        }
    },
    ["Beach Ball Palm"] = {
        PlantName = "Beach Ball Palm",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(500, 500)
        },
        FruitData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20)
        }
    },
    ["Lagoon Lily"] = {
        PlantName = "Lagoon Lily",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(35, 40),
            GrowFruitTime = NumberRange.new(600, 600)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Sunshade Flower"] = {
        PlantName = "Sunshade Flower",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18),
            GrowFruitTime = NumberRange.new(100, 100)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Beach Ball Cactus"] = {
        PlantName = "Beach Ball Cactus",
        PlantData = {
            GrowRate = 0.011,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(200, 200)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Sand Pail Shrub"] = {
        PlantName = "Sand Pail Shrub",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(300, 300)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Pool Noodle"] = {
        PlantName = "Pool Noodle",
        PlantData = {
            GrowRate = 0.00277,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(400, 400)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Sun Fruit"] = {
        PlantName = "Sun Fruit",
        PlantData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(500, 500)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Shark Splash"] = {
        PlantName = "Shark Splash",
        PlantData = {
            GrowRate = 0.00222,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 30),
            GrowFruitTime = NumberRange.new(660, 660)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Drippy Delight"] = {
        PlantName = "Drippy Delight",
        PlantData = {
            GrowRate = 0.0166,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 20)
        }
    },
    Okra = {
        PlantName = "Okra",
        PlantData = {
            GrowRate = 0.011,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(34, 36),
            GrowFruitTime = NumberRange.new(420, 450)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Seaspray Grass"] = {
        PlantName = "Seaspray Grass",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 30),
            GrowFruitTime = NumberRange.new(300, 350)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Gilded Grove"] = {
        PlantName = "Gilded Grove",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(40, 42),
            GrowFruitTime = NumberRange.new(500, 520)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Glimmer Fern"] = {
        PlantName = "Glimmer Fern",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(40, 42),
            GrowFruitTime = NumberRange.new(500, 520)
        },
        FruitData = {
            GrowRate = 0.025,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(25, 25)
        }
    },
    ["Beach Brella"] = {
        PlantName = "Beach Brella",
        PlantData = {
            GrowRate = 0.35,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Tidal Orchid"] = {
        PlantName = "Tidal Orchid",
        PlantData = {
            GrowRate = 0.016,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(300, 400)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    ["Lunar Lily"] = {
        PlantName = "Lunar Lily",
        PlantData = {
            GrowRate = 0.25,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Crescent Reed"] = {
        PlantName = "Crescent Reed",
        PlantData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(200, 200)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(2, 2)
        }
    },
    Fennel = {
        PlantName = "Fennel",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3, 6)
        }
    },
    ["Astral Grape"] = {
        PlantName = "Astral Grape",
        PlantData = {
            GrowRate = 0.03889,
            PlantDown = 1,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(300, 350)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(3, 5)
        }
    },
    ["Lunar Lantern"] = {
        PlantName = "Lunar Lantern",
        PlantData = {
            GrowRate = 0.00536,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(400, 400)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Moongrain Meadow"] = {
        PlantName = "Moongrain Meadow",
        PlantData = {
            GrowRate = 0.00694,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(500, 600)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Crescent Petal"] = {
        PlantName = "Crescent Petal",
        PlantData = {
            GrowRate = 0.14171,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8)
        }
    },
    ["Strange Man\'s Wheat"] = {
        PlantName = "Strange Man\'s Wheat",
        PlantData = {
            GrowRate = 0.01252,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(200, 220)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Luna Bloom"] = {
        PlantName = "Luna Bloom",
        PlantData = {
            GrowRate = 0.016,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(500, 520)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 14)
        }
    },
    Twineberry = {
        PlantName = "Twineberry",
        PlantData = {
            GrowRate = 0.14095,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 8)
        }
    },
    ["Sun Melon"] = {
        PlantName = "Sun Melon",
        PlantData = {
            GrowRate = 0.016,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(200, 220)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 10)
        }
    },
    Clove = {
        PlantName = "Clove",
        PlantData = {
            GrowRate = 0.016,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(300, 330)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Maple Petal"] = {
        PlantName = "Maple Petal",
        PlantData = {
            GrowRate = 0.016,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(400, 440)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 14)
        }
    },
    Emberpear = {
        PlantName = "Emberpear",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(500, 550)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16)
        }
    },
    Spirecrest = {
        PlantName = "Spirecrest",
        PlantData = {
            GrowRate = 0.0136,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(600, 620)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 18)
        }
    },
    ["Starry Strawberry"] = {
        PlantName = "Starry Strawberry",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.5,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 2)
        }
    },
    Wheatcap = {
        PlantName = "Wheatcap",
        PlantData = {
            GrowRate = 0.045,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 32)
        }
    },
    ["Harvest Melon"] = {
        PlantName = "Harvest Melon",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0.1,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(400, 500)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 6)
        }
    },
    ["Maize Stalk"] = {
        PlantName = "Maize Stalk",
        PlantData = {
            GrowRate = 0.01,
            PlantDown = 0.1,
            GrowTickTime = NumberRange.new(30, 34),
            GrowFruitTime = NumberRange.new(300, 330)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Eclipse Berry"] = {
        PlantName = "Eclipse Berry",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["King Palm"] = {
        PlantName = "King Palm",
        PlantData = {
            GrowRate = 0.018,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(45, 50),
            GrowFruitTime = NumberRange.new(400, 450)
        },
        FruitData = {
            GrowRate = 0.005,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 10)
        }
    },
    ["Jungle Lily"] = {
        PlantName = "Jungle Lily",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(50, 60),
            GrowFruitTime = NumberRange.new(500, 550)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 15)
        }
    },
    ["Twist Berry"] = {
        PlantName = "Twist Berry",
        PlantData = {
            GrowRate = 0.085,
            PlantDown = 0.15,
            GrowTickTime = NumberRange.new(12, 14),
            GrowFruitTime = NumberRange.new(100, 124)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    Nimbush = {
        PlantName = "Nimbush",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(22, 26),
            GrowFruitTime = NumberRange.new(20, 22)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Aurum Spire"] = {
        PlantName = "Aurum Spire",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(50, 55),
            GrowFruitTime = NumberRange.new(540, 580)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 32)
        }
    },
    Wool = {
        PlantName = "Wool",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1, 1)
        }
    },
    ["Lilypad Cluster"] = {
        PlantName = "Lilypad Cluster",
        PlantData = {
            GrowRate = 0.0048,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(20, 24),
            GrowFruitTime = NumberRange.new(700, 780)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Fableflower = {
        PlantName = "Fableflower",
        PlantData = {
            GrowRate = 0.1,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 8),
            GrowFruitTime = NumberRange.new(90, 110)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8)
        }
    },
    Harpvine = {
        PlantName = "Harpvine",
        PlantData = {
            GrowRate = 0.049,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 32),
            GrowFruitTime = NumberRange.new(200, 220)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Elder Beanstalk"] = {
        PlantName = "Elder Beanstalk",
        PlantData = {
            GrowRate = 0.049,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(540, 560)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Brambleberry = {
        PlantName = "Brambleberry",
        PlantData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 7),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(5, 8)
        }
    },
    ["Nebula Barb"] = {
        PlantName = "Nebula Barb",
        PlantData = {
            GrowRate = 0.035,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16),
            GrowFruitTime = NumberRange.new(240, 245)
        },
        FruitData = {
            GrowRate = 0.08,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    ["Everglow Helix"] = {
        PlantName = "Everglow Helix",
        PlantData = {
            GrowRate = 0.00536,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12),
            GrowFruitTime = NumberRange.new(400, 400)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = -0.25,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Chilli Mango"] = {
        PlantName = "Chilli Mango",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(20, 20),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.03,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 20)
        }
    },
    Chestnut = {
        PlantName = "Chestnut",
        PlantData = {
            GrowRate = 0.32,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(9.5, 9.85),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.065,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(1.75, 2)
        }
    },
    Emberbloom = {
        PlantName = "Emberbloom",
        PlantData = {
            GrowRate = 0.0253,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(15, 18),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Russet Root"] = {
        PlantName = "Russet Root",
        PlantData = {
            GrowRate = 0.004,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(24, 24),
            GrowFruitTime = NumberRange.new(250, 280)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 10)
        }
    },
    ["Fall Cauliflower"] = {
        PlantName = "Fall Cauliflower",
        PlantData = {
            GrowRate = 0.0282,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(24, 32),
            GrowFruitTime = NumberRange.new(60, 80)
        },
        FruitData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(3.6, 4)
        }
    },
    ["Grain Lily"] = {
        PlantName = "Grain Lily",
        PlantData = {
            GrowRate = 0.00357,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(4, 6),
            GrowFruitTime = NumberRange.new(90, 180)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(2.2, 2.8)
        }
    },
    ["Autumn Apple"] = {
        PlantName = "Autumn Apple",
        PlantData = {
            GrowRate = 0.00745,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(17, 18),
            GrowFruitTime = NumberRange.new(300, 360)
        },
        FruitData = {
            GrowRate = 0.01,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Fall Pineapple"] = {
        PlantName = "Fall Pineapple",
        PlantData = {
            GrowRate = 0.0155,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(32, 36),
            GrowFruitTime = NumberRange.new(340, 380)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 14)
        }
    },
    ["Scarlet Aspen"] = {
        PlantName = "Scarlet Aspen",
        PlantData = {
            GrowRate = 0.011,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(35, 38),
            GrowFruitTime = NumberRange.new(600, 600)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 20)
        }
    },
    ["Drowse Daisy"] = {
        PlantName = "Drowse Daisy",
        PlantData = {
            GrowRate = 0.3,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 8)
        }
    },
    Lullaberry = {
        PlantName = "Lullaberry",
        PlantData = {
            GrowRate = 0.025,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(15, 18),
            GrowFruitTime = NumberRange.new(230, 260)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(6, 10)
        }
    },
    ["Beach Fern"] = {
        PlantName = "Beach Fern",
        PlantData = {
            GrowRate = 0.008,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 34),
            GrowFruitTime = NumberRange.new(300, 330)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    Fernberry = {
        PlantName = "Fernberry",
        PlantData = {
            GrowRate = 0.015,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(20, 22),
            GrowFruitTime = NumberRange.new(380, 420)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 14)
        }
    },
    ["Cosmic Dew"] = {
        PlantName = "Cosmic Dew",
        PlantData = {
            GrowRate = 0.012,
            PlantDown = 0.25,
            GrowTickTime = NumberRange.new(24, 27),
            GrowFruitTime = NumberRange.new(520, 570)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16)
        }
    },
    Astralcap = {
        PlantName = "Astralcap",
        PlantData = {
            GrowRate = 0.0115,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(36, 38),
            GrowFruitTime = NumberRange.new(640, 680)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 18)
        }
    },
    ["Rosy Root"] = {
        PlantName = "Rosy Root",
        PlantData = {
            GrowRate = 0.055,
            PlantDown = 0.1,
            GrowTickTime = NumberRange.new(10, 12)
        }
    },
    Sapberry = {
        PlantName = "Sapberry",
        PlantData = {
            GrowRate = 0.02905,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(38, 42),
            GrowFruitTime = NumberRange.new(660, 700)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 18)
        }
    },
    ["Maple Melt"] = {
        PlantName = "Maple Melt",
        PlantData = {
            GrowRate = 0.00734,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(38, 42),
            GrowFruitTime = NumberRange.new(480, 520)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(16, 20)
        }
    },
    Jellycap = {
        PlantName = "Jellycap",
        PlantData = {
            GrowRate = 0.008334,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(14, 16),
            GrowFruitTime = NumberRange.new(100, 120)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(4, 8)
        }
    },
    Glimmervine = {
        PlantName = "Glimmervine",
        PlantData = {
            GrowRate = 0.023,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(30, 34),
            GrowFruitTime = NumberRange.new(310, 340)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Prism Plume"] = {
        PlantName = "Prism Plume",
        PlantData = {
            GrowRate = 0.01266,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(38, 42),
            GrowFruitTime = NumberRange.new(440, 480)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(12, 16)
        }
    },
    ["Flutter Freesia"] = {
        PlantName = "Flutter Freesia",
        PlantData = {
            GrowRate = 0.0132,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(36, 40),
            GrowFruitTime = NumberRange.new(380, 420)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 14)
        }
    },
    ["Twilight Bud"] = {
        PlantName = "Twilight Bud",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Glimmerpine = {
        PlantName = "Glimmerpine",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Sleep Blossom"] = {
        PlantName = "Sleep Blossom",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Elder Thistle"] = {
        PlantName = "Elder Thistle",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Glowing Acorn"] = {
        PlantName = "Glowing Acorn",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.05,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Fairytale Turnip"] = {
        PlantName = "Fairytale Turnip",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Dracuvine = {
        PlantName = "Dracuvine",
        PlantData = {
            GrowRate = 0.01273,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(38, 42),
            GrowFruitTime = NumberRange.new(600, 640)
        },
        FruitData = {
            GrowRate = 0.02778,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Pharaoh\'s Eye"] = {
        PlantName = "Pharaoh\'s Eye",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Wisppear = {
        PlantName = "Wisppear",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Gaze Berry"] = {
        PlantName = "Gaze Berry",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Witch\'s Cap"] = {
        PlantName = "Witch\'s Cap",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44)
        }
    },
    ["Brew Blossom"] = {
        PlantName = "Brew Blossom",
        PlantData = {
            GrowRate = 0.0165,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(40, 44),
            GrowFruitTime = NumberRange.new(600, 630)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Candy Corn Carrot"] = {
        PlantName = "Candy Corn Carrot",
        PlantData = {
            GrowRate = 0.08333,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(4, 6)
        }
    },
    ["Pumpkin Lantern"] = {
        PlantName = "Pumpkin Lantern",
        PlantData = {
            GrowRate = 0.03674,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 16),
            GrowFruitTime = NumberRange.new(90, 100)
        },
        FruitData = {
            GrowRate = 0.07143,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Witch\'s Broom"] = {
        PlantName = "Witch\'s Broom",
        PlantData = {
            GrowRate = 0.135,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    Webberry = {
        PlantName = "Webberry",
        PlantData = {
            GrowRate = 0.16284,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 26),
            GrowFruitTime = NumberRange.new(150, 165)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Spider Shrub"] = {
        PlantName = "Spider Shrub",
        PlantData = {
            GrowRate = 0.02,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(44, 66)
        },
        FruitData = {
            GrowRate = 0.04545,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Blood Kiwi"] = {
        PlantName = "Blood Kiwi",
        PlantData = {
            GrowRate = 0.07385,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 34),
            GrowFruitTime = NumberRange.new(190, 210)
        },
        FruitData = {
            GrowRate = 0.04167,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Fang Root"] = {
        PlantName = "Fang Root",
        PlantData = {
            GrowRate = 0.12375,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(34, 38),
            GrowFruitTime = NumberRange.new(260, 280)
        },
        FruitData = {
            GrowRate = 0.03571,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Candy Cluster"] = {
        PlantName = "Candy Cluster",
        PlantData = {
            GrowRate = 0.09,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 16),
            GrowFruitTime = NumberRange.new(100, 110)
        },
        FruitData = {
            GrowRate = 0.06667,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Haunted Hallow"] = {
        PlantName = "Haunted Hallow",
        PlantData = {
            GrowRate = 0.05333,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(38, 42),
            GrowFruitTime = NumberRange.new(300, 320)
        },
        FruitData = {
            GrowRate = 0.03125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Halloween Candy Corn Carrot"] = {
        PlantName = "Halloween Candy Corn Carrot",
        PlantData = {
            GrowRate = 0.3,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Halloween Spider Shrub"] = {
        PlantName = "Halloween Spider Shrub",
        PlantData = {
            GrowRate = 0.0375,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 10),
            GrowFruitTime = NumberRange.new(44, 66)
        },
        FruitData = {
            GrowRate = 0.04545,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(0.8, 1.2)
        }
    },
    ["Halloween Pumpkin Lantern"] = {
        PlantName = "Halloween Pumpkin Lantern",
        PlantData = {
            GrowRate = 0.03674,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 16),
            GrowFruitTime = NumberRange.new(90, 100)
        },
        FruitData = {
            GrowRate = 0.07143,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Halloween Candy Cluster"] = {
        PlantName = "Halloween Candy Cluster",
        PlantData = {
            GrowRate = 0.09,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(14, 16),
            GrowFruitTime = NumberRange.new(100, 110)
        },
        FruitData = {
            GrowRate = 0.06667,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Halloween Witch\'s Broom"] = {
        PlantName = "Halloween Witch\'s Broom",
        PlantData = {
            GrowRate = 0.135,
            PlantDown = 0.35,
            GrowTickTime = NumberRange.new(8, 10)
        }
    },
    ["Halloween Webberry"] = {
        PlantName = "Halloween Webberry",
        PlantData = {
            GrowRate = 0.16284,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(24, 26),
            GrowFruitTime = NumberRange.new(150, 165)
        },
        FruitData = {
            GrowRate = 0.05,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Halloween Blood Kiwi"] = {
        PlantName = "Halloween Blood Kiwi",
        PlantData = {
            GrowRate = 0.07385,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(30, 34),
            GrowFruitTime = NumberRange.new(190, 210)
        },
        FruitData = {
            GrowRate = 0.04167,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Halloween Fang Root"] = {
        PlantName = "Halloween Fang Root",
        PlantData = {
            GrowRate = 0.12375,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(34, 38),
            GrowFruitTime = NumberRange.new(260, 280)
        },
        FruitData = {
            GrowRate = 0.03571,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Halloween Haunted Hallow"] = {
        PlantName = "Halloween Haunted Hallow",
        PlantData = {
            GrowRate = 0.05333,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(38, 42),
            GrowFruitTime = NumberRange.new(300, 320)
        },
        FruitData = {
            GrowRate = 0.03125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Rotten Apple"] = {
        PlantName = "Rotten Apple",
        PlantData = {
            GrowRate = 0.01111,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(38, 42),
            GrowFruitTime = NumberRange.new(600, 640)
        },
        FruitData = {
            GrowRate = 0.03125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Rib Rose"] = {
        PlantName = "Rib Rose",
        PlantData = {
            GrowRate = 0.01111,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(38, 42),
            GrowFruitTime = NumberRange.new(600, 640)
        },
        FruitData = {
            GrowRate = 0.03125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(8, 12)
        }
    },
    ["Ghoul of the Valley"] = {
        PlantName = "Ghoul of the Valley",
        PlantData = {
            GrowRate = 0.0175,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(10, 12),
            GrowFruitTime = NumberRange.new(120, 160)
        },
        FruitData = {
            GrowRate = 0.0125,
            PlantDown = 0,
            GrowTickTime = NumberRange.new(15, 18)
        }
    }
};

function v1.GetDataForWeather(p4: table, p5: string) -- Line: 9422
    -- upvalues: u2 (copy), RunService (copy)
    if not p5 or type(p5) ~= "string" then
        warn("GrowableData:GetDataForWeather | weatherName is not applicable!");

        return u2.Default;
    end;

    local v6 = u2[p5];

    if v6 then
        return v6;
    end;

    if RunService:IsStudio() then
        warn("GrowableData:GetDataForWeather | weatherData is nil! Using Default", p5);
    end;

    return u2.Default;
end;

function v1.GetDataForPlant(p7: table, p8: userdata) -- Line: 9441
    -- upvalues: u3 (copy)
    if not p8 then
        warn((`GrowableData:GetDataForPlan | {not p8 and "nil" or p8.Name} is not a valid plant!`));

        return nil;
    end;

    local v9 = p8.Parent and (p8.Parent.Name == "Fruits" or p8.Parent.Name == "Fruit_Spawn") and true or false;
    local v10 = p8:FindFirstChild("Fruit_Spawn") and true or false;
    local v11 = u3[p8.Name];

    if not v11 then
        warn((`GrowableData:GetDataForPlan | No GrowData for {p8.Name}!`));

        return nil;
    end;

    local v12 = nil;

    if v9 and v11.FruitData then
        v12 = v11.FruitData;
    elseif v11.PlantData then
        v12 = v11.PlantData;
    end;

    if not v12 then
        warn((`GrowableData:GetDataForPlan | {p8.Name} has no PlantData or FruitData!`));

        return nil;
    end;

    if not v12.GrowTickTime then
        warn((`GrowableData:GetDataForPlan | {p8.Name} has no GrowTickTime!`));

        return nil;
    end;

    if not v12.GrowRate then
        warn((`GrowableData:GetDataForPlan | {p8.Name} has no GrowRate!`));

        return nil;
    end;

    if v12.PlantDown == nil then
        warn((`GrowableData:GetDataForPlant | {p8.Name} has no PlantDown!`));

        return nil;
    end;

    if not v10 or v12.GrowFruitTime then
        return v12;
    end;

    print(v12);
    warn((`GrowableData:GetDataForPlan | {p8.Name} has no GrowFruitTime!`));

    return nil;
end;

function v1.GetAllPlantData(p13) -- Line: 9493
    -- upvalues: u3 (copy)
    return u3;
end;

local function GenerateGrowDataText() -- Line: 9498
    -- upvalues: u3 (copy)
    local ServerStorage = game:GetService("ServerStorage");
    local Collectables = ServerStorage:WaitForChild("Collectables");
    local Fruit_Spawn = ServerStorage:WaitForChild("Fruit_Spawn");
    local v14 = "";

    local function formatNumber(p15) -- Line: 9506
        return string.format("%.4g", p15);
    end;

    for _, child in pairs(Collectables:GetChildren()) do
        local Name = child.Name;
        local v16 = u3[Name];
        local v17 = 1;
        local Grow_Rate = child:FindFirstChild("Grow_Rate", true);

        if Grow_Rate and Grow_Rate:IsA("NumberValue") then
            v17 = Grow_Rate.Value;
        elseif v16 and (v16.PlantData and v16.PlantData.GrowRate) then
            v17 = v16.PlantData.GrowRate;
        end;

        local v18 = v16 and v16.PlantData and v16.PlantData.GrowTickTime or NumberRange.new(1, 2);
        local v19 = v16 and v16.PlantData and v16.PlantData.GrowFruitTime;
        local v20 = v16 and v16.FruitData and v16.FruitData.GrowTickTime;
        local v21 = math.floor(v18.Min * 10 + 0.5) / 10;
        local v22 = math.floor(v18.Max * 10 + 0.5) / 10;
        local string_format_ret = string.format("\n\t\t\tGrowRate = %s;", formatNumber(v17));
        local v23;

        if v19 then
            local v24 = math.floor(v19.Min * 10 + 0.5) / 10;
            local v25 = math.floor(v19.Max * 10 + 0.5) / 10;
            v23 = string.format("\n\t\t\tGrowFruitTime = NumberRange.new(%s, %s);", string.format("%.4g", v24), formatNumber(v25));
        else
            v23 = "";
        end;

        local v26;

        if Fruit_Spawn:FindFirstChild(Name) then
            local v27 = Fruit_Spawn[Name];
            local v28 = 1;
            local Grow_Rate2 = v27:FindFirstChild("Grow_Rate", true);

            if Grow_Rate2 and Grow_Rate2:IsA("NumberValue") then
                v28 = Grow_Rate2.Value;
            elseif v16 and (v16.FruitData and v16.FruitData.GrowRate) then
                v28 = v16.FruitData.GrowRate;
            end;

            local v29 = ";\n\t\tFruitData = { -- Fruit_Spawn[\"" .. Name .. "\"]";
            local v30;

            if v20 then
                local v31 = math.floor(v20.Min * 10 + 0.5) / 10;
                local v32 = math.floor(v20.Max * 10 + 0.5) / 10;
                v30 = v29 .. string.format("\n\t\t\tGrowTickTime = NumberRange.new(%s, %s);", string.format("%.4g", v31), formatNumber(v32));
            else
                v30 = v29 .. "\n\t\t\tGrowTickTime = NumberRange.new(1, 2);";
            end;

            local v33 = v30 .. string.format("\n\t\t\tGrowRate = %s;", formatNumber(v28));
            local v34 = 0;
            local Plant_Down = v27:FindFirstChild("Plant_Down", true);

            if Plant_Down and Plant_Down:IsA("NumberValue") then
                v34 = Plant_Down.Value;
            elseif v16 and (v16.FruitData and v16.FruitData.PlantDown) then
                v34 = v16.FruitData.PlantDown;
            end;

            v26 = (v33 .. string.format("\n\t\t\tPlantDown = %s;", formatNumber(v34))) .. "\n\t\t}";
        else
            v26 = "";
        end;

        local v35 = 0;
        local Plant_Down = child:FindFirstChild("Plant_Down", true);

        if Plant_Down and Plant_Down:IsA("NumberValue") then
            v35 = Plant_Down.Value;
        elseif v16 and (v16.PlantData and v16.PlantData.PlantDown) then
            v35 = v16.PlantData.PlantDown;
        end;

        local string_format_ret2 = string.format("\n\t\t\tPlantDown = %s;", formatNumber(v35));
        v14 = v14 .. string.format("\t[\"%s\"] = {\n\t\tPlantName = \"%s\";\n\t\tPlantData = { -- Collectables[\"%s\"]\n\t\t\tGrowTickTime = NumberRange.new(%s, %s);%s%s%s\n\t\t}%s\n\t};\n\n", Name, Name, Name, string.format("%.4g", v21), string.format("%.4g", v22), v23, string_format_ret, string_format_ret2, v26);
    end;

    return v14;
end;

local function ValidateGrowData() -- Line: 9614
    -- upvalues: u3 (copy)
    local ServerStorage = game:GetService("ServerStorage");
    local Collectables = ServerStorage:WaitForChild("Collectables");
    local Fruit_Spawn = ServerStorage:WaitForChild("Fruit_Spawn");
    local v36 = 0;

    for _, child in pairs(Collectables:GetChildren()) do
        local Name = child.Name;

        if u3[Name] then
            if not (u3[Name].PlantData and u3[Name].PlantData.GrowTickTime) then
                warn("Missing GrowTickTime for plant: ", child);
                v36 = v36 + 1;
            end;

            if not (u3[Name].PlantData and u3[Name].PlantData.GrowRate) then
                warn("Missing required GrowRate for plant: ", child);
                v36 = v36 + 1;
            end;

            if not u3[Name].PlantData.PlantDown then
                warn("Missing required PlantDown for plant: ", child);
                v36 = v36 + 1;
            end;

            if Fruit_Spawn:FindFirstChild(Name) then
                if not u3[Name].PlantData.GrowFruitTime then
                    warn("Missing GrowFruitTime for plant with fruit: ", child);
                    v36 = v36 + 1;
                end;

                if not (u3[Name].FruitData and u3[Name].FruitData.GrowTickTime) then
                    warn("Missing FruitData.GrowTickTime for fruit: ", child);
                    v36 = v36 + 1;
                end;

                if not (u3[Name].FruitData and u3[Name].FruitData.GrowRate) then
                    warn("Missing required FruitData.GrowRate for fruit: ", child);
                    v36 = v36 + 1;
                end;
            end;
        else
            warn("Missing plant entry: ", child);
            v36 = v36 + 1;
        end;
    end;

    for _, child in pairs(Fruit_Spawn:GetChildren()) do
        local Name = child.Name;

        if u3[Name] then
            if u3[Name].FruitData then
                if u3[Name].FruitData and not u3[Name].FruitData.PlantDown then
                    warn("Missing required PlantDown for fruit: ", child);
                    v36 = v36 + 1;
                end;
            else
                warn("Missing FruitData for fruit: ", child);
                v36 = v36 + 1;
            end;
        else
            warn("Missing plant entry for fruit: ", child);
            v36 = v36 + 1;
        end;
    end;

    local _ = 0 < v36;

    return v36 == 0;
end;

if RunService:IsStudio() and RunService:IsServer() then
    ValidateGrowData();
end;

return v1;