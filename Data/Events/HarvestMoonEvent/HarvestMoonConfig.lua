-- Decompiled with Potassium's decompiler.

return {
    WEATHER_DURATION = 600,
    COOLDOWN = 600,
    SERVER_START_DELAY = 600,
    SUBMIT_DEBOUNCE = 0.25,
    EffectDuration = 5,
    WEATHER_NAME = "HarvestMoon",
    PLANT_COUNT = 10,
    MUTATION_CHANCE = 0.5,
    MODEL_TAG = "HarvestMoonModel",
    SUBMIT_REMOTE = "SubmitHarvestMoon",
    SKIP_TARGET_REMOTE = "HarvestMoonSkipTarget",
    SKIP_PRODUCT = "SkipHarvestMoon",
    CONFIRM_REMOTE = "HarvestMoonConfirmGive",
    PLANT_OPTIONS = { "Strawberry", "Blueberry", "Tomato", "Corn", "Watermelon", "Apple", "Pumpkin", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango" },
    MUTATION_OPTIONS = { "Wet", "Chilled", "Frozen", "Shocked" },
    MUTATION_ODDS = {
        Wet = 1,
        Chilled = 1,
        Frozen = 1,
        Shocked = 1
    },
    BLOCKED_MUTATIONS = {
        ["Dragon Fruit"] = { "Chilled" }
    },
    FRUIT_DISPLAY = {
        Pumpkin = {
            Flip = true,
            Scale = 1
        },
        Watermelon = {
            Flip = true,
            Scale = 1
        },
        Apple = {
            Flip = true,
            Scale = 1
        },
        Tomato = {
            Flip = true,
            Scale = 1
        },
        Blueberry = {
            Flip = false,
            Scale = 1
        },
        ["Dragon Fruit"] = {
            Height = 3
        },
        Mango = {
            Height = 2
        }
    },
    ATTR = {
        Phase = "HarvestMoon_Phase",
        PhaseEndsAt = "HarvestMoon_PhaseEndsAt",
        Submissions = "HarvestMoon_Submissions"
    },
    PART_ATTR = {
        Fruit = "HM_Fruit",
        Mutation = "HM_Mutation",
        Done = "HM_Done"
    },
    PHASE = {
        Startup = "Startup",
        Collecting = "Collecting",
        Active = "Active",
        Cooldown = "Cooldown"
    },
    MESSAGES = {
        NO_PLANT = "You aren\'t holding a plant!",
        PLANT_FAV = "Can\'t offer Favorited plants!",
        TOO_QUICK = "You\'re offering too quickly!",
        NOT_READY = "The Harvest Moon isn\'t taking offerings right now!",
        WRONG_PLANT = "I need a [PLANT]!",
        WRONG_PLANT_MUT = "I need a [MUTATION] [PLANT]!",
        NOT_FOUND = "No [MUTATION][PLANT] found!",
        SUBMITTED = "Offering accepted!",
        TRADING = "Finish trading first!",
        TRIGGERED = "The Harvest Moon rises!"
    },
    NPC = {
        INTRO = "Hey!",
        GOODBYE = "Goodbye!",
        WHO = { "I\'m Harvest Heath!", "My mission is to summon the Harvest Moon!", "Bring fruits to my pedestals to start!" },
        WHAT = { "I\'m trying to summon the Harvest Moon!", "The Harvest Moon will bring Moonbeam plants!" }
    },
    DISPLAY = {
        STARTUP_TITLE = "Harvest Moon can be summoned in:",
        COLLECTING_TITLE = "Bring offerings to raise the moon!",
        ACTIVE_TITLE = "Harvest Moon ends in:",
        COOLDOWN_TITLE = "Harvest Moon can be summoned again in:",
        NO_MUTATION = "",
        PROGRESS = "[N] / [MAX] offered",
        TURNIN_ACTION = "Submit",
        TURNIN_DIALOGUE = "Submit",
        SKIP_DIALOGUE = "Skip",
        CONFIRM = {
            TITLE = "Harvest Moon",
            HEADER = "Offer this from your inventory?",
            MIDDLE = "[PLANT]",
            FOOTER = "It\'ll be given to the Harvest Moon.",
            CONFIRM_TEXT = "Give",
            REJECT_TEXT = "Cancel"
        }
    },
    MOONCOIN = {
        ACCEPTED_MUTATION = "Moonbeam",
        CURRENCY = "MoonCoins",
        SELL_REMOTE = "HarvestMoonSell",
        COINS_PER_VALUE = 1,
        MESSAGES = {
            NO_PLANT = "You aren\'t holding a plant!",
            NOT_MOONBEAM = "Only Moonbeam plants can be turned in for Moon Coins!",
            PLANT_FAV = "Can\'t turn in Favorited plants!",
            TOO_QUICK = "You\'re turning in too quickly!",
            TRADING = "Finish trading first!",
            NONE_ALL = "No Moonbeam plants in your inventory!",
            REWARD = "+[AMOUNT] Moon Coins!"
        }
    },
    SELL_NPC = {
        INTRO = "Hello",
        EXIT = "May the moonlight guide you.",
        OPTIONS = {
            WHAT = "Who are you?",
            GIVE = "Give Plant",
            GIVE_ALL = "Give All Plants",
            NEVERMIND = "Nevermind"
        },
        WHAT_LINES = { "I\'m Harvest Harriet!", "You can turn in plants with the Moonbeam mutation here.", "Each one rewards you with Moon Coins!", "The more valuable the plant, the more you earn." }
    }
};