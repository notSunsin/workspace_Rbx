-- Decompiled with Potassium's decompiler.

return {
    ZenProgressData = {
        ZenRequirement = 3,
        MAX_QUEST_COMPLETION = 7,
        CORRUPT_MONK_RESET_TIME = 300,
        MAX_CORRUPTION_LEVEL = 5,
        MAX_TRANQUIL_LEVEL = 5,
        MAX_CORRUPTION_SPAWN = 10
    },
    ZenTreeData = {
        LEVEL_PLANT_VALUE_REQUIREMENTS = { 40, 60, 90, 130, 180, 245, 325 }
    },
    ZenQuestsRewardData = { {
            ItemName = "Chi",
            ItemType = "Currency",
            ItemAmount = 20
        } },
    CorruptZenQuestData = {
        Easy = { {
                Type = "Sheckles",
                Method = "Percent",
                Value = 5,
                Chance = 20,
                Minimum = 10000
            }, {
                Type = "Fruit",
                Value = "Tomato",
                Weight = 0.5,
                Chance = 11.42
            }, {
                Type = "Fruit",
                Value = "Strawberry",
                Weight = 0.3,
                Chance = 11.42
            }, {
                Type = "Fruit",
                Value = "Blueberry",
                Weight = 0.2,
                Chance = 11.42
            }, {
                Type = "Fruit",
                Value = "Orange Tulip",
                Weight = 0.05,
                Chance = 11.42
            }, {
                Type = "Fruit",
                Value = "Corn",
                Weight = 2,
                Chance = 11.42
            }, {
                Type = "Fruit",
                Value = "Daffodil",
                Weight = 0.2,
                Chance = 11.42
            }, {
                Type = "Fruit",
                Value = "Bamboo",
                Weight = 4,
                Chance = 11.42
            } },
        Medium = { {
                Type = "Sheckles",
                Method = "Percent",
                Value = 10,
                Chance = 20,
                Minimum = 500000
            }, {
                Type = "Fruit",
                Value = "Apple",
                Weight = 3,
                Chance = 26.66
            }, {
                Type = "Fruit",
                Value = "Coconut",
                Weight = 14,
                Chance = 13.33
            }, {
                Type = "Fruit",
                Value = "Pumpkin",
                Weight = 15,
                Chance = 13.33
            }, {
                Type = "Fruit",
                Value = "Watermelon",
                Weight = 10,
                Chance = 13.33
            }, {
                Type = "Fruit",
                Value = "Cactus",
                Weight = 10,
                Chance = 6.66
            }, {
                Type = "Fruit",
                Value = "Dragon Fruit",
                Weight = 20,
                Chance = 6.66
            } },
        Hard = { {
                Type = "Sheckles",
                Method = "Percent",
                Value = 15,
                Chance = 20,
                Minimum = 10000000
            }, {
                Type = "Fruit",
                Value = "Mango",
                Weight = 16,
                Chance = 16
            }, {
                Type = "Fruit",
                Value = "Grape",
                Weight = 3,
                Chance = 16
            }, {
                Type = "Fruit",
                Value = "Mushroom",
                Weight = 25,
                Chance = 16
            }, {
                Type = "Fruit",
                Value = "Pepper",
                Weight = 7,
                Chance = 16
            }, {
                Type = "Fruit",
                Value = "Cacao",
                Weight = 15,
                Chance = 16
            } }
    },
    CorruptZenQuestRewardData = { {
            ItemName = "Chi",
            ItemType = "Currency",
            ItemAmount = 10,
            Chance = 4
        } }
};