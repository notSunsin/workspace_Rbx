-- Decompiled with Potassium's decompiler.

return {
    ENABLED = true,
    START_EPOCH = -1,
    INTERVAL = 1800,
    DURATION = 300,
    DEV_INTERVAL = 600,
    DEV_DURATION = 45,
    ACORN_COUNT = 5,
    DROP_DELAY = 2.5,
    BASEPLATE_NAME = "TopBaseplate",
    FALL_HEIGHT = 100,
    FALL_TIME = 3.5,
    SPAWN_MARGIN = 45,
    SPAWN_MIN_FARM_DISTANCE = 60,
    FARM_CENTER_NAME = "Center_Point",
    TILT_MAX_DEG = 12,
    DAMAGE_PER_HIT = 1,
    HIT_RANGE = 15,
    HIT_DEBOUNCE = 0.7,
    MIN_CRACK_TIME_FACTOR = 0.8,
    HIT_PITCH_VARIATION = 0.1,
    HIT_HIGHLIGHT_COLOR = { 255, 45, 45 },
    HIT_HIGHLIGHT_FILL = 0.35,
    HIT_HIGHLIGHT_TIME = 0.18,
    REVEAL_HIGHLIGHT_COLOR = { 255, 230, 120 },
    REVEAL_HIGHLIGHT_FILL = 0.6,
    REVEAL_HIGHLIGHT_TIME = 10,
    JIGGLE_IMPULSE = 14,
    JIGGLE_BOUNCE = 14,
    JIGGLE_STIFFNESS = 180,
    JIGGLE_DAMPING = 9,
    JIGGLE_MAX_OFFSET = 2,
    SHAKE_MAGNITUDE = 1.3,
    SHAKE_DURATION = 0.35,
    FINAL_HIT_TIME = 1,
    METEOR_SITE_LIFETIME = 3,
    WORKSPACE_ENDS_AT = "AcornChaosEndsAt",
    WORKSPACE_ACTIVE = "AcornChaosActive",
    MODEL_TAG = "AcornChaosModel",
    NPC_NAME = "Squirrel",
    TITLE_ACTIVE = "Acorn Chaos Ends In:",
    TITLE_IDLE = "Acorn Chaos Starts In:",
    MSG_STARTED = "Acorn Chaos has begun! Whack the falling acorns with your shovel!",
    MSG_STARTED_ALL = "Acorns have begun dropping!",
    MSG_ENDED = "The acorns have vanished...",
    PROGRESS_TEXT = "CURRENT / MAX",
    PROGRESS_BAR_COLOR = { 88, 200, 96 },
    NOTIFICATION_COLOR = { 214, 158, 74 },
    DIALOGUE = {
        ExitLine = "Stay nutty!",
        LineDuration = 3,
        IntroLines = { "Well hello there! Nutty weather we\'re having, huh?" },
        Options = { {
                Prompt = "Who are you?",
                Lines = { "Name\'s Chester! Chester the Squirrel.", "I\'m on the hunt for my acorns! I\'ve lost a whole stash of \'em!" }
            }, {
                Prompt = "What is this?",
                Lines = { "Every so often, giant acorns come raining down from the sky across the map!", "Find where they land and whack them with your shovel to crack them open.", "Tougher acorns take more hits. The bar above shows how close one is to cracking.", "Crack one and you\'ll get a random reward! Golden acorns hold the best loot!" }
            }, {
                Prompt = "What are the rewards?",
                Action = "OpenRewards",
                Lines = {}
            }, {
                Prompt = "Nevermind",
                Lines = {}
            } }
    },
    ACORN_TYPES = {
        {
            Name = "Regular",
            Model = "Acorn1",
            Weight = 49.5,
            HP = 12,
            Icon = "rbxassetid://104338091980206",
            Rewards = { {
                    Value = "Orchid Harvest Box",
                    Display = "Orchid Harvest Box",
                    Quantity = 1,
                    Type = "Cosmetic"
                }, {
                    Value = "Maple Sprinkler",
                    Display = "Maple Sprinkler",
                    Quantity = 1,
                    Type = "Gear"
                }, {
                    Value = "Autumn Crate",
                    Display = "Autumn Crate",
                    Quantity = 1,
                    Type = "Crate"
                }, {
                    Value = "Autumn Seed Pack",
                    Display = "Autumn Seed Pack",
                    Quantity = 1,
                    Type = "Seed Pack"
                }, {
                    Value = "Autumn Egg",
                    Display = "Autumn Egg",
                    Quantity = 1,
                    Type = "Egg"
                } }
        },
        {
            Name = "Mossy",
            Model = "Acorn2",
            Weight = 7.5,
            HP = 20,
            Icon = "rbxassetid://122457487128619",
            Rewards = { {
                    Value = "Amber Hammock",
                    Display = "Amber Hammock",
                    Quantity = 1,
                    Type = "Cosmetic"
                }, {
                    Value = "Maple Sprinkler",
                    Display = "Maple Sprinkler",
                    Quantity = 2,
                    Type = "Gear"
                }, {
                    Value = "Autumn Seed Pack",
                    Display = "Autumn Seed Pack",
                    Quantity = 1,
                    Type = "Seed Pack"
                }, {
                    Value = "Autumn Egg",
                    Display = "Autumn Egg",
                    Quantity = 1,
                    Type = "Egg"
                } }
        },
        {
            Name = "Silver",
            Model = "Acorn3",
            Weight = 2.5,
            HP = 30,
            Icon = "rbxassetid://103748283726732",
            Rewards = { {
                    Value = "Harvesting Workbench",
                    Display = "Harvesting Workbench",
                    Quantity = 1,
                    Type = "Cosmetic"
                }, {
                    Value = "Acorn Lollipop",
                    Display = "Acorn Lollipop",
                    Quantity = 1,
                    Type = "Gear",
                    RainbowInterface = true
                }, {
                    Value = "Autumn Seed Pack",
                    Display = "Autumn Seed Pack",
                    Quantity = 2,
                    Type = "Seed Pack"
                }, {
                    Value = "Autumn Egg",
                    Display = "Autumn Egg",
                    Quantity = 2,
                    Type = "Egg"
                } }
        },
        {
            Name = "Gold",
            Model = "Acorn4",
            Weight = 0.5,
            HP = 50,
            Icon = "rbxassetid://135370348800289",
            Rewards = { {
                    Value = "Fall Pineapple",
                    Display = "Fall Pineapple Seed",
                    Quantity = 1,
                    Type = "Seed",
                    RainbowInterface = true
                }, {
                    Value = "Golden Acorn",
                    Display = "Golden Acorn",
                    Quantity = 1,
                    Type = "Gear",
                    RainbowInterface = true
                }, {
                    Value = "Autumn Seed Pack",
                    Display = "Autumn Seed Pack",
                    Quantity = 5,
                    Type = "Seed Pack"
                }, {
                    Value = "Autumn Egg",
                    Display = "Autumn Egg",
                    Quantity = 5,
                    Type = "Egg"
                } }
        }
    }
};