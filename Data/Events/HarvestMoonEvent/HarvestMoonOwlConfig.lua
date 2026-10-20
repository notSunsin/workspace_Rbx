-- Decompiled with Potassium's decompiler.

return {
    POINTS_REQUIRED = 500,
    COOLDOWN = 300,
    SUBMIT_DEBOUNCE = 0.25,
    TRAIT_INTERVAL = 3600,
    TRAIT_HASH_NUM = 2654435,
    WORKSPACE_TRAIT_ATTR = "HarvestMoonOwl_Trait",
    WORKSPACE_MUTATION_ATTR = "HarvestMoonOwl_Mutation",
    MODEL_TAG = "HarvestMoonOwlModel",
    SUBMIT_REMOTE = "SubmitHarvestMoonOwl",
    SUBMIT_ALL_REMOTE = "SubmitAllHarvestMoonOwl",
    PREVIEW_REMOTE = "PreviewHarvestMoonOwl",
    SKIP_PRODUCT = "SkipHarvestMoonOwl",
    MUTATION_CHANCE = 0,
    TRAIT_OPTIONS = { "Berry", "Fruit", "Flower", "Vegetable", "Sweet", "Tropical", "Prickly", "Woody", "Leafy", "Stalky" },
    MUTATION_ODDS = {
        Wet = 1,
        Chilled = 1,
        Frozen = 1,
        Shocked = 1
    },
    REWARD = {
        SEED_PACK = "Moon Chest",
        QUANTITY = 1
    },
    MOONBEAM = {
        MUTATION = "Moonbeam",
        CHANCE = 0.5
    },
    MESSAGES = {
        NO_PLANT = "You aren\'t holding a plant!",
        TOO_QUICK = "You\'re submitting too quickly!",
        TRADING = "Finish trading first!",
        ON_COOLDOWN = "The owl is full -- come back soon!",
        SUBMITTED = "+[POINTS] points!",
        FILLED = "The owl is satisfied! Here is your <font color=\"rgb(154, 83, 31)\">Moon Chest</font>!",
        MOONBEAM = "A fruit in your garden was blessed with a <font color=\"rgb(110, 0, 255)\">Moonbeam</font>!",
        SKIPPED = "Cooldown skipped!",
        COOLDOWN_COMPLETE = "Wise Owl cooldown completed!"
    },
    DISPLAY = {
        CRAVING_TITLE = "The Owl craves:",
        TRAIT_TEXT = "Looking for <font color=\"rgb(228, 214, 97)\">[TRAIT]</font> Plants!",
        MUTATION_TEXT = "[MUTATION]",
        NO_MUTATION = "",
        PROGRESS = "[N] / [MAX]",
        TRAIT_TIMER_TITLE = "New craving in:",
        COOLDOWN_TITLE = "Resets in:",
        SUBMIT_ACTION = "Feed",
        SKIP_ACTION = "Skip Wait",
        IN_COOLDOWN = "Moon Chest Progress",
        READY = "Moon Chest Progress"
    },
    NPC = {
        INTRO = "Hello, child of the moon.",
        EXIT = "May the moon and Heartseed guide you!",
        NO_MATCH = "You don\'t have any [TRAIT] plants for me!",
        OPTIONS = {
            SUBMIT = "Submit Held Plant",
            SUBMIT_ALL = "Submit All Plants",
            WHO = "Who are you?",
            NEVERMIND = "Nevermind"
        },
        WHO_LINES = { "I\'m known as the Wise Owl.", "Hand me plants to offer to the harvest moon to fill the bar!", "Fill it up and I\'ll reward you with a Moon Chest!" },
        CONFIRM_ALL = {
            TITLE = "Wise Owl",
            HEADER = "Feed all your matching plants?",
            MIDDLE = "[COUNT] x [TRAIT]",
            FOOTER = "They\'ll be fed to the owl for points.",
            CONFIRM = "Submit All",
            CANCEL = "Cancel"
        }
    }
};