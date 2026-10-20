-- Decompiled with Potassium's decompiler.

return {
    MODEL_TAG = "HarvestMoonPetModel",
    CURRENCY = "MoonCoins",
    PLACE_PET_PART = "PlacePet",
    REQUIRED_PET_LEVEL = 50,
    MUTATION_DISPLAY_SPEED = 3,
    MUTATIONS = { {
            Name = "Bountiful",
            Weight = 47.5
        }, {
            Name = "Threshing",
            Weight = 35
        }, {
            Name = "Lunarbound",
            Weight = 15
        }, {
            Name = "Starry",
            Weight = 2.5
        } },
    COST_BY_RARITY = {
        Common = 50,
        Uncommon = 100,
        Rare = 200,
        Legendary = 400,
        Mythical = 800,
        Divine = 1500,
        Prismatic = 2000,
        Transcendent = 3000,
        FallBack = 1000
    },
    DURATION_BY_RARITY = {
        Common = 900,
        Uncommon = 900,
        Rare = 1800,
        Legendary = 1800,
        Mythical = 2700,
        Divine = 5400,
        Prismatic = 5400,
        Transcendent = 5400,
        FallBack = 3600
    },
    SKIP_PRODUCTS = {
        Common = 3701594914,
        Uncommon = 3701594914,
        Rare = 3704519078,
        Legendary = 3704519078,
        Mythical = 3704519078,
        Divine = 3704520316,
        Prismatic = 3704520316,
        Transcendent = 3704520316,
        FallBack = 3701594914
    },
    NOTIFICATION_COLOR = { 223, 209, 114 },
    NOTIFICATION_COLOR2 = { 10, 255, 10 },
    NOTIFICATION_COLOR3 = { 255, 255, 255 },
    MESSAGES = {
        NO_PET_HELD = "Hold out a Pet to submit it to the Moon Machine!",
        FAVORITED = "You can\'t submit a favorited Pet!",
        LEVEL_TOO_LOW = "Your Pet must be at least Level LEVEL to use the Moon Machine!",
        ALREADY_SUBMITTED = "A Pet is already in the Moon Machine!",
        NO_STORED_PET = "No Pet is in the Moon Machine.",
        ALREADY_RUNNING = "The Moon Machine is already running.",
        NOT_ENOUGH_COINS = "Not enough Moon Coins!",
        INVENTORY_FULL = "Your pet inventory is full! Free up space and try again.",
        SUBMITTED = "Placed PETNAME in the Moon Machine.",
        REMOVED = "Removed PETNAME from the Moon Machine.",
        STARTED = "The Moon Machine is running!",
        SKIPPED = "Skipped the Moon Machine!",
        NOT_READY = "This Pet isn\'t ready yet!",
        READY = "Your Pet is ready to be claimed from the Moon Machine!",
        CLAIMED = "PETNAME emerged with the MUTATION mutation!",
        TRADING = "You can\'t use the Moon Machine while trading!"
    }
};