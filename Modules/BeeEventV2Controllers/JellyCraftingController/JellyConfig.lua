-- Decompiled with Potassium's decompiler.

local function minutes(p1) -- Line: 1
    return p1 * 60;
end;

local function hours(p2) -- Line: 5
    return p2 * 60 * 60;
end;

return {
    PRICE_FALLBACK = 150,
    CRAFT_TIMES = {
        Common = 300,
        Uncommon = 1200,
        Rare = 60 * 60,
        Legendary = 180 * 60,
        Mythical = 360 * 60,
        Divine = 720 * 60,
        Prismatic = 1080 * 60,
        Transcendent = 1440 * 60
    },
    PRICES = {
        Common = 25,
        Uncommon = 60,
        Rare = 150,
        Legendary = 300,
        Mythical = 600,
        Divine = 1200,
        Prismatic = 1800,
        Transcendent = 2500
    },
    NOTIFICATION_COLOR = Color3.fromRGB(177, 88, 255),
    NOTIFICATION_ENUMS = {
        WRONG_ITEM_TYPE = "Hold out a Seed to start crafting!",
        NOT_ENOUGH_CURRENCY = "Not enough Royal Jelly!",
        INVALID_VARIANT = "This seed is already Jelly!",
        NO_SUPERSEEDS = "You can\'t submit Super Seeds!",
        NO_HONEY_SEEDS = "You can\'t submit Honey Seeds!",
        CRAFT_STARTED = "Started Jelly Incubator!",
        PREMATURE_CLAIM_ATTEMPT = "This Seed is not ready yet!",
        CRAFT_SKIPPED = "Skipped Jelly Incubator!",
        CRAFT_CLAIMED = "+AMOUNT Jelly SEEDNAME Seed",
        ALREADY_CRAFTING = "You are already crafting.",
        SEED_INSERTED = "Inserted SEEDNAME Seed.",
        SEED_REMOVED = "Removed SEEDNAME Seed.",
        NO_STORED_SEED = "No Seed is inserted."
    },
    SOUND_ENUMS = {
        Submit = "rbxassetid://91696051071797",
        Start = "rbxassetid://135422257454796",
        Loop = "rbxassetid://114282526567949",
        Spin = "rbxassetid://90428246409622",
        Retrieve = "rbxassetid://132086173426930",
        Done = "rbxassetid://70476124357162"
    },
    RARITY_ENUMS = {
        Common = 1,
        Uncommon = 2,
        Rare = 3,
        Legendary = 4,
        Mythical = 5,
        Divine = 6,
        Prismatic = 7,
        Transcendent = 8
    }
};