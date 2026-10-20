-- Decompiled with Potassium's decompiler.

return {
    MINIMUM_GOAL = 30,
    MAXIMUM_GOAL = 75,
    COOLDOWN = 180,
    SUBMIT_DEBOUNCE = 0.25,
    REQUIRED_VARIANT = "Gold",
    VARIANT_COLOR = "FFC93C",
    MODEL_TAG = "GoldCauldronModel",
    SUBMIT_REMOTE = "GoldCauldronSubmit",
    SUBMIT_ALL_REMOTE = "GoldCauldronSubmitAll",
    PREVIEW_REMOTE = "GoldCauldronPreview",
    SKIP_PRODUCT = "SkipGoldCauldron",
    REWARD = {
        SEED_PACK = "Beanpod Chest",
        QUANTITY = 1
    },
    VISUALS = {
        IDLE_STIR_SPEED = 40,
        COOK_STIR_SPEED = 220,
        IDLE_STEAM_RATE = 2.5,
        COOK_STEAM_RATE = 16,
        IDLE_SWIRL_RATE = 12,
        COOK_SWIRL_RATE = 45,
        IDLE_LIGHT_BRIGHTNESS = 1,
        COOK_LIGHT_BRIGHTNESS = 4,
        FLAME_RATE = 26,
        COOK_WATER_COLOR = "FFC93C",
        BOIL_HEIGHT = 0.09,
        BOIL_SPEED = 7,
        LIQUID_MIN_HEIGHT = 0.15,
        LIQUID_LERP = 4,
        PLAYER_SPIN_SPEED = 90,
        UPDATE_RATE = 0.05,
        ACTIVE_DISTANCE = 250,
        BAR_DAMPING = 0.75,
        BAR_FREQUENCY = 3.5,
        BAR_UPDATE_RATE = 0.1
    },
    SOUNDS = {
        SUBMIT = "AddItem",
        REWARD = "CookingDone",
        COOKING_LOOP = "SkipCooking"
    },
    MESSAGES = {
        NO_PLANT = "You aren\'t holding a plant!",
        WRONG_VARIANT = "The cauldron only takes [VARIANT] plants!",
        TOO_QUICK = "You\'re submitting too quickly!",
        TRADING = "Finish trading first!",
        ON_COOLDOWN = "The cauldron needs to cool down first!",
        SUBMITTED = "+[KG]kg into the cauldron!",
        SKIPPED = "Cooldown skipped!",
        NOTHING_TO_SKIP = "The cauldron was already cool!",
        REWARDED = "+[COUNT] <font color=\"rgb(255,201,60)\">[REWARD]</font>!"
    },
    DISPLAY = {
        TITLE = "Cauldron Progress",
        REMAINING = "[KG]kg Left",
        COOKING = "Cooking: [TIME]",
        COOK_SECONDS = "[S]s",
        COOK_CLOCK = "[M]:[SS]"
    },
    NPC = {
        INTRO = "Oh! A climber. Careful, it\'s a long way down.",
        EXIT = "Mind the clouds on your way back!",
        NO_MATCH = "You don\'t have any [VARIANT] plants for me!",
        OPTIONS = {
            WHO = "Who are you?",
            SUBMIT = "Submit Plant",
            SUBMIT_ALL = "Submit All",
            SKIP = "Skip Cooking",
            NEVERMIND = "Nevermind"
        },
        WHO_LINES = { "I\'m Jill. Jack climbs, I cook.", "Feed my cauldron [VARIANT] plants until it\'s full.", "Fill it and it\'ll brew you a Beanpod Chest." },
        CONFIRM_ALL = {
            TITLE = "Gold Cauldron",
            HEADER = "Tip all your [VARIANT] plants in?",
            MIDDLE = "[COUNT] x [VARIANT] Plants",
            FOOTER = "Only enough to fill the cauldron will be taken.",
            CONFIRM = "Submit All",
            CANCEL = "Cancel"
        }
    }
};