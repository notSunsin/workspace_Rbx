-- Decompiled with Potassium's decompiler.

return {
    MUTATION_COUNT_CAP = 5,
    MIN_XP_REWARD = 1,
    HarvestXPReduction = 0.15,
    HarvestResetTime = 43200,
    INCLUDE_MUTATIONS = true,
    XP_CONSTANT = 600,
    MAX_LEVEL = 50,
    INF_REWARD_XP = 10000,
    DAILY_QUEST_XP = 400,
    PST_TIME = 18,
    PST_OFFSET = 0,
    SHIFT = 21600,
    NUM_OF_DAYS = 35,
    NextPass = 3024000,
    Rarity = {
        Common = 1,
        Uncommon = 1,
        Rare = 2,
        Legendary = 3,
        Mythical = 5,
        Divine = 8,
        Prismatic = 13,
        Transcendent = 21
    },
    MutationCount = { 5, 15, 35, 75, 155 },
    HarvestThresholdByRarity = {
        Common = 400,
        Uncommon = 350,
        Rare = 300,
        Legendary = 250,
        Mythical = 200,
        Divine = 150,
        Prismatic = 100,
        Transcendent = 75
    },
    ButtonColors = {
        Green = {
            Background = Color3.fromRGB(0, 170, 0),
            ButtonStroke = Color3.fromRGB(6, 70, 0),
            ButtonStrokeAlt = Color3.fromRGB(132, 255, 132),
            TextStroke = Color3.fromRGB(14, 99, 0),
            Text = Color3.fromRGB(255, 255, 255),
            Gradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 245, 55)), ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 229, 17)) })
        },
        Yellow = {
            Background = Color3.fromRGB(255, 252, 38),
            ButtonStroke = Color3.fromRGB(70, 70, 0),
            TextStroke = Color3.fromRGB(255, 255, 255),
            Text = Color3.fromRGB(255, 255, 255)
        },
        Gold = {
            Background = Color3.fromRGB(255, 204, 0),
            ButtonStroke = Color3.fromRGB(141, 86, 0),
            TextStroke = Color3.fromRGB(134, 77, 0),
            Text = Color3.fromRGB(255, 227, 126)
        },
        Gray = {
            Background = Color3.fromRGB(95, 95, 95),
            ButtonStroke = Color3.fromRGB(64, 64, 64),
            TextStroke = Color3.fromRGB(52, 52, 52),
            Text = Color3.fromRGB(255, 255, 255)
        },
        White = {
            Background = Color3.fromRGB(255, 255, 255),
            ButtonStroke = Color3.fromRGB(255, 255, 255),
            TextStroke = Color3.fromRGB(255, 255, 255),
            Text = Color3.fromRGB(255, 255, 255)
        },
        Blue = {
            Background = Color3.fromRGB(0, 192, 255),
            ButtonStroke = Color3.fromRGB(0, 99, 132),
            TextStroke = Color3.fromRGB(0, 70, 103),
            Text = Color3.fromRGB(255, 255, 255)
        },
        Red = {
            Background = Color3.fromRGB(255, 255, 255),
            ButtonStroke = Color3.fromRGB(235, 41, 41),
            ButtonStrokeAlt = Color3.fromRGB(235, 41, 41),
            TextStroke = Color3.fromRGB(58, 0, 0),
            Text = Color3.fromRGB(255, 255, 255),
            Gradient = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(221, 10, 10)), ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 3, 3)) })
        },
        Brown = {
            Background = Color3.fromRGB(133, 82, 51),
            ButtonStroke = Color3.fromRGB(103, 63, 38),
            TextStroke = Color3.fromRGB(61, 41, 0),
            Text = Color3.fromRGB(255, 255, 255)
        }
    },
    START_TIME = os.time({
        year = 2025,
        month = 12,
        day = 27,
        hour = 18,
        min = 0,
        sec = 0
    })
};