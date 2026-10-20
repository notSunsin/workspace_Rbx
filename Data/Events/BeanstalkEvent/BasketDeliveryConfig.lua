-- Decompiled with Potassium's decompiler.

return {
    MODEL_TAG = "BasketDeliveryModel",
    SUBMIT_REMOTE = "BasketDeliverySubmit",
    CLAIM_REMOTE = "BasketDeliveryClaim",
    TOP_CFRAME_ATTRIBUTE = "BasketTopCFrame",
    REWARD_CHOICES = 3,
    SUBMIT_DEBOUNCE = 0.5,
    REROLL_PRODUCT_ID = 3712173455,
    TRAVEL = {
        RISE = 3.5,
        HOLD = 1.5,
        RETURN = 3
    },
    FRUIT = {
        UPDATE_RATE = 0.05,
        ACTIVE_DISTANCE = 250
    },
    SUBMISSIONS = {
        {
            Plant = "Tomato",
            MinWeight = 0.55
        },
        {
            Plant = "Blueberry",
            MinWeight = 0.22
        },
        {
            Plant = "Strawberry",
            MinWeight = 0.33
        },
        {
            Plant = "Corn",
            MinWeight = 2.2
        },
        {
            Plant = "Mandrake",
            MinWeight = 3.3
        },
        {
            Plant = "Daffodil",
            MinWeight = 0.22
        },
        {
            Plant = "Twist Berry",
            MinWeight = 0.85
        },
        {
            Plant = "Apple",
            MinWeight = 3.3
        },
        {
            Plant = "Fableflower",
            MinWeight = 1.65
        },
        {
            Plant = "Bamboo",
            MinWeight = 4.4
        },
        {
            Plant = "Watermelon",
            MinWeight = 8.4
        },
        {
            Plant = "Flare Daisy",
            MinWeight = 1.8
        },
        {
            Plant = "Pumpkin",
            MinWeight = 9.6
        },
        {
            Plant = "Lilypad Cluster",
            MinWeight = 1.8,
            Mutations = { "Wet" }
        },
        {
            Plant = "Coconut",
            MinWeight = 16.8
        },
        {
            Plant = "Bamboo",
            MinWeight = 4.8,
            Mutations = { "Wet" }
        },
        {
            Plant = "Glowpod",
            MinWeight = 3.6,
            Mutations = { "Chilled" }
        },
        {
            Plant = "Cactus",
            MinWeight = 8.4
        },
        {
            Plant = "Duskpuff",
            MinWeight = 3.6
        },
        {
            Plant = "Dragon Fruit",
            MinWeight = 14.4
        },
        {
            Plant = "Mango",
            MinWeight = 19.5
        },
        {
            Plant = "Canary Melon",
            MinWeight = 10.4
        },
        {
            Plant = "Dragon Fruit",
            MinWeight = 15.6,
            Mutations = { "Chilled" }
        },
        {
            Plant = "Harpvine",
            MinWeight = 6
        },
        {
            Plant = "Grape",
            MinWeight = 3.6
        },
        {
            Plant = "Flare Melon",
            MinWeight = 5.2
        },
        {
            Plant = "Mushroom",
            MinWeight = 32.5
        },
        {
            Plant = "Grape",
            MinWeight = 4.1
        },
        {
            Plant = "Harpvine",
            MinWeight = 6.8,
            Mutations = { "Chilled" }
        },
        {
            Plant = "Pepper",
            MinWeight = 6.5,
            Mutations = { "Frozen" }
        }
    },
    TIERS = {
        {
            Name = "Humble",
            UpTo = 10,
            Pool = { {
                    ItemName = "Cleaning Spray",
                    ItemType = "Gear",
                    ItemAmount = 1,
                    Chance = 16
                }, {
                    ItemName = "Sprout Seed Pack",
                    ItemType = "Seed Pack",
                    ItemAmount = 1,
                    Chance = 10
                }, {
                    ItemName = "Sprout Crate",
                    ItemType = "Crate",
                    ItemAmount = 1,
                    Chance = 10
                }, {
                    ItemName = "Beanpod Crate",
                    ItemType = "Crate",
                    ItemAmount = 1,
                    Chance = 5
                }, {
                    ItemName = "Advanced Sprinkler",
                    ItemType = "Gear",
                    ItemAmount = 1,
                    Chance = 13
                }, {
                    ItemName = "Brambleberry",
                    ItemType = "Seed",
                    ItemAmount = 1,
                    Chance = 7
                } }
        },
        {
            Name = "Hearty",
            UpTo = 20,
            Pool = { {
                    ItemName = "Sprout Seed Pack",
                    ItemType = "Seed Pack",
                    ItemAmount = 1,
                    Chance = 12
                }, {
                    ItemName = "Sprout Egg",
                    ItemType = "Egg",
                    ItemAmount = 1,
                    Chance = 12
                }, {
                    ItemName = "Sprout Crate",
                    ItemType = "Crate",
                    ItemAmount = 1,
                    Chance = 12
                }, {
                    ItemName = "Master Sprinkler",
                    ItemType = "Gear",
                    ItemAmount = 1,
                    Chance = 5
                }, {
                    ItemName = "Beanpod Chest",
                    ItemType = "Seed Pack",
                    ItemAmount = 1,
                    Chance = 5
                }, {
                    ItemName = "Beanpod Egg",
                    ItemType = "Egg",
                    ItemAmount = 1,
                    Chance = 5
                }, {
                    ItemName = "Beanpod Crate",
                    ItemType = "Crate",
                    ItemAmount = 1,
                    Chance = 6
                }, {
                    ItemName = "Nebula Barb",
                    ItemType = "Seed",
                    ItemAmount = 1,
                    Chance = 5
                }, {
                    ItemName = "Silver Fertilizer",
                    ItemType = "Gear",
                    ItemAmount = 1,
                    Chance = 3
                }, {
                    ItemName = "Lightning Rod",
                    ItemType = "Gear",
                    ItemAmount = 1,
                    Chance = 10
                }, {
                    ItemName = "Godly Sprinkler",
                    ItemType = "Gear",
                    ItemAmount = 1,
                    Chance = 10
                } }
        },
        {
            Name = "Giant\'s Favour",
            UpTo = 30,
            Pool = { {
                    ItemName = "Master Sprinkler",
                    ItemType = "Gear",
                    ItemAmount = 1,
                    Chance = 4
                }, {
                    ItemName = "Areaclaimer",
                    ItemType = "Gear",
                    ItemAmount = 1,
                    Chance = 4
                }, {
                    ItemName = "Skyroot Chest",
                    ItemType = "Seed Pack",
                    ItemAmount = 2,
                    Chance = 7
                }, {
                    ItemName = "Beanpod Chest",
                    ItemType = "Seed Pack",
                    ItemAmount = 2,
                    Chance = 7
                }, {
                    ItemName = "Beanpod Egg",
                    ItemType = "Egg",
                    ItemAmount = 2,
                    Chance = 7
                }, {
                    ItemName = "Beanpod Crate",
                    ItemType = "Crate",
                    ItemAmount = 2,
                    Chance = 9
                }, {
                    ItemName = "Beanstalk Bear",
                    ItemType = "Pet",
                    ItemAmount = 1,
                    Chance = 4
                }, {
                    ItemName = "Everglow Helix",
                    ItemType = "Seed",
                    ItemAmount = 1,
                    Chance = 2
                } }
        }
    },
    DISPLAY = {
        TITLE = "Basket Turn-In",
        REQUIREMENT = "[ASK]",
        NAME_LINE = "[PLANT]",
        NAME_LINE_WEIGHT = "[PLANT] ([KG]kg+)",
        MODIFIER_LINE = "[[MODS]]",
        DELIVERING = "Off to the giant...",
        RETURNING = "Basket coming back...",
        CHOOSE = "Pick your reward!",
        ASK_PLAIN = "[PLANT]",
        ASK_WEIGHT = "[PLANT] ([KG]kg+)",
        VARIANT_PREFIX = "[VARIANT] ",
        MUTATION_PREFIX = "[MUTATIONS] ",
        MUTATION_JOIN = ", ",
        REROLL_BUTTON = "Reroll (:robux::value:)"
    },
    MESSAGES = {
        NO_PLANT = "You aren\'t holding a plant!",
        TOO_QUICK = "You\'re submitting too quickly!",
        TRADING = "Finish trading first!",
        BUSY = "The basket is still on its way!",
        WRONG_PLANT = "The giant wants [ASK], not that!",
        CLAIM_FIRST = "Pick your reward first!",
        DELIVERED = "Delivered! The giant hauls the basket up.",
        RUN_COMPLETE = "That was the last basket! The old man will start you over.",
        REWARDED = "x[COUNT] [REWARD] rewarded!"
    },
    NPC = {
        INTRO = "Beans got that boy a giant. Let\'s see what they get you.",
        EXIT = "The basket\'ll be waiting.",
        ASK_LINE = "Bring me [ARTICLE] [ASK].",
        BUSY_LINE = "Patience. The rope only goes one speed.",
        RESTART_LINE = "Thirty baskets. The giant\'s fond of you now -- shall we go again?",
        OPTIONS = {
            WHO = "Who are you?",
            SUBMIT = "Submit Held Fruit",
            CLAIM = "Pick my reward",
            NEVERMIND = "Nevermind"
        },
        WHO_LINES = { "Nobody worth naming. I sold Jack those beans.", "The giant up there trades, if you send the right thing.", "Load the basket, I\'ll pull the rope. You pick the payment." }
    }
};