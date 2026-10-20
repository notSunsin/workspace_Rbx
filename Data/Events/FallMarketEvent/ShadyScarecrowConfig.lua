-- Decompiled with Potassium's decompiler.

return {
    ENABLED = true,
    COOLDOWN = 600,
    DEV_COOLDOWN = 30,
    MAX_SUBMIT_DISTANCE = 30,
    MAX_SCORE = 10,
    RARITY_SCORE = {
        Common = 1,
        Uncommon = 2,
        Rare = 3,
        Legendary = 4,
        Mythical = 5,
        Divine = 6,
        Prismatic = 7,
        Transcendent = 8
    },
    VARIANT_BONUS = {
        Normal = 0,
        Silver = 0.5,
        Gold = 1,
        Jelly = 1,
        Rainbow = 2,
        Diamond = 2,
        Ember = 2
    },
    SCORE_GROWTH = 0.25,
    SCORE_BOOST_POWER = 4,
    EXCLUDED_SEEDS = { "Super" },
    EXCLUDED_VARIANTS = {},
    REWARDS = { {
            Value = "Maple Melt",
            Display = "Maple Melt Seed",
            Quantity = 1,
            Type = "Seed",
            Weight = 0.1,
            RainbowInterface = true
        }, {
            Value = "Scarecrow",
            Display = "Scarecrow",
            Quantity = 1,
            Type = "Pet",
            Weight = 0.3,
            RainbowInterface = true
        }, {
            Value = "Autumn Egg",
            Display = "Autumn Egg",
            Quantity = 4,
            Type = "Egg",
            Weight = 1.6,
            BlueInterface = true
        }, {
            Value = "Autumn Seed Pack",
            Display = "Autumn Seed Pack",
            Quantity = 3,
            Type = "Seed Pack",
            Weight = 4,
            BlueInterface = true
        }, {
            Value = "Carved Swingseat",
            Display = "Carved Swingseat",
            Quantity = 1,
            Type = "Cosmetic",
            Weight = 9
        }, {
            Value = "Autumn Seed Pack",
            Display = "Autumn Seed Pack",
            Quantity = 1,
            Type = "Seed Pack",
            Weight = 20
        }, {
            Value = "Autumn Egg",
            Display = "Autumn Egg",
            Quantity = 1,
            Type = "Egg",
            Weight = 29.5
        }, {
            Value = "Rosy Root",
            Display = "Rosy Root Seed",
            Quantity = 1,
            Type = "Seed",
            Weight = 35.5
        } },
    PLANT_TO_CROW_DELAY = 5,
    SEED_IN_HAND_TIME = 0.35,
    SEED_TO_PATCH_TIME = 0.55,
    SEED_TOSS_ARC = 2,
    CROW_ARRIVE_TIME = 1.6,
    PECK_TIME = 4,
    GRAB_TIME = 0.6,
    FLY_AWAY_TIME = 2.2,
    REWARD_DELAY = 0.4,
    REWARD_LINE_LEAD = 1.5,
    NPC_ANIM_FADE = 0.2,
    NPC_PLANT_ANIM_SPEED = 1.5,
    NPC_HAND_PART = "RightStraw1",
    CROW_COUNT = 3,
    CROW_RING_RADIUS = 2.6,
    CROW_SPAWN_HEIGHT = 30,
    CROW_SPAWN_SPREAD = 25,
    CROW_FLY_DISTANCE = 70,
    CROW_SCALE = 1,
    CROW_ANIMATION_FOLDER = "Cardinal",
    CROW_PECK_ANIMATION_ID = "rbxassetid://122251156947305",
    PECK_INTERVAL = 0.35,
    PECK_ANGLE = 35,
    SEED_BURY_DEPTH = 1.2,
    SEED_JIGGLE_DEG = 12,
    SEED_VISUAL_SCALE = 1.4,
    SFX_FALLBACK_IDS = {
        Plant = "rbxassetid://115974139108386",
        CrowCaw = "rbxassetid://98519985813095",
        CrowLand = "rbxassetid://95783055449423",
        CrowTakeoff = "rbxassetid://132476910449834",
        ["Flying Loop"] = "rbxassetid://120628386657802"
    },
    SFX_FALLBACK_VOLUME = 0.5,
    SFX_FALLBACK_VOLUMES = {
        ["Flying Loop"] = 0.3,
        Laugh1 = 1.4,
        Laugh2 = 1.4,
        Laugh3 = 1.4,
        Laugh4 = 1.4
    },
    LAUGH_SOUNDS = { "Laugh1", "Laugh2", "Laugh3", "Laugh4" },
    LAUGH_VOLUME_SCALE = 1,
    LAUGH_PITCH_VARIATION = 0.08,
    LAUGH_BASE_PITCH = 0.85,
    NPC_LINE_HOLD = 3,
    SEED_DROP_TIME = 0.5,
    MODEL_TAG = "ShadyScarecrowModel",
    PLAYER_READY_ATTRIBUTE = "ShadyScarecrowReadyAt",
    TITLE_READY = "Shady Scarecrow",
    TIMER_READY = "Ready!",
    TITLE_COOLDOWN = "Come Back In:",
    REWARDS_UI_TITLE = "Shady Scarecrow Rewards",
    REWARDS_UI_INFO = "Rarer seeds and better variants boost your odds for better rewards!",
    NOTIFICATION_COLOR = { 255, 255, 255 },
    MSG_NOT_HOLDING_SEED = "Hold the seed you want to give first!",
    MSG_EXCLUDED_SEED = "The Shady Scarecrow won\'t take that seed.",
    MSG_FAVORITED = "You can\'t give away a favorited seed!",
    MSG_ON_COOLDOWN = "The Shady Scarecrow isn\'t ready yet. Come back in {TIME}.",
    MSG_TOO_FAR = "Get closer to the Shady Scarecrow!",
    MSG_DISABLED = "The Shady Scarecrow isn\'t accepting seeds right now.",
    MSG_BUSY = "Hold on, the crows are still busy!",
    MSG_SEED_CHANGED = "Keep holding the seed you chose!",
    MSG_RECOVERED_REWARD = "The Shady Scarecrow saved your reward while you were away: {REWARD}",
    CONFIRM_TITLE = "Shady Scarecrow",
    CONFIRM_HEADER = "{SEED}",
    CONFIRM_MIDDLE = "Give 1x {SEED} ({RARITY}) to the Shady Scarecrow?",
    CONFIRM_FOOTER = "The crows will take it. This can\'t be undone!",
    CONFIRM_BUTTON = "Give",
    CANCEL_BUTTON = "Cancel",
    CONFIRM_TIMEOUT = 60,
    DIALOGUE = {
        ExitLine = "The crows are always watching...",
        LineDuration = 3,
        CancelLine = "Changed your mind? Heh... the crows can wait.",
        RewardLine = "The crows are pleased... here\'s your cut!",
        IntroLines = { "Psst... over here. Got a seed for an old scarecrow?" },
        Options = { {
                Prompt = "Who are you?",
                Lines = { "Me? Just a humble scarecrow. Nothing shady here... heh.", "Hand me a seed and I\'ll plant it in my patch. My crows take care of the rest.", "Rarer seeds and fancier variants fetch a much better reward!" }
            }, {
                Prompt = "Give Seed",
                Action = "GiveSeed",
                Lines = {}
            }, {
                Prompt = "View rewards",
                Action = "OpenRewards",
                Lines = {}
            }, {
                Prompt = "Nevermind",
                Lines = {}
            } },
        SubmitLines = { "Ooh, a fine seed. Let\'s plant it... heh heh." }
    }
};