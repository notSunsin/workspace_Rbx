-- Decompiled with Potassium's decompiler.

local v1 = require(game:GetService("ReplicatedStorage").Modules.IsDev)();

local function seconds(p2: number) -- Line: 13
    return p2;
end;

local function minutes(p3: number) -- Line: 17
    return p3 * 60;
end;

local function hours(p4: number) -- Line: 21
    return p4 * 60 * 60;
end;

return {
    REQUIRED_SHARDS = 4,
    SHARD_ITEM_NAME = "Inferno Shard",
    SHARD_TOOL_TAG = "InfernoShard",
    RITUAL_MODEL_TAG = "SummerRitualModel",
    CAMPFIRE_TIER_ATTRIBUTE = "SummerFireTier",
    RITUAL_DURATION_BY_RARITY = {
        FallBack = v1 and 60 or 900,
        Common = v1 and 120 or 900,
        Uncommon = v1 and 180 or 1800,
        Rare = v1 and 240 or 3600,
        Legendary = v1 and 240 or 10800,
        Mythical = v1 and 360 or 21600,
        Divine = v1 and 420 or 43200,
        Prismatic = v1 and 480 or 64800
    },
    MIN_CAMPFIRE_TIER = 1,
    OFFLINE_TIME_MULTIPLIER = 1,
    TIER_TIME_MULTIPLIER = {
        [2] = 2,
        [3] = 3,
        [4] = 4,
        [5] = 5
    },
    Y_RISE_VISUAL = 1.25,
    Y_RISE_PET_VISUAL = 0.5,
    SKIP_PRODUCTS = {
        FallBack = 3604894503,
        Common = 3604894503,
        Uncommon = 3604894503,
        Rare = 3604894553,
        Legendary = 3604894553,
        Mythical = 3604894553,
        Divine = 3604894610,
        Prismatic = 3604894610
    },
    MESSAGES = {
        SHARD_PLACED = "🔥 Inferno Shard placed! (PLACED/REQUIRED)",
        SHARD_ALREADY_THERE = "🔥 Inferno Shard already in place!",
        SHARD_REMOVED = "🔥 Inferno Shard removed.",
        SLOT_OCCUPIED = "You already have a shard in that slot!",
        NO_SHARD_HELD = "You need an Inferno Shard in your hand or backpack!",
        NO_PET_HELD = "You need to hold a pet to place it on the podium!",
        PET_PLACED = "🔥 PET_TYPE placed! (RARITY — DURATION)",
        PET_REMOVED = "🔥 Pet removed from the podium.",
        RITUAL_STARTED = "🔥 Your Campfire Ritual has begun!",
        RITUAL_COMPLETE = "🔥 Your ritual is complete! Return to claim your Inferno pet!",
        RITUAL_ALREADY_ACTIVE = "Your ritual is already underway!",
        RITUAL_NOT_READY = "Place all 4 Inferno Shards and a pet before starting.",
        CAMPFIRE_TOO_LOW = "The campfire must be at least Tier MIN_TIER to begin the ritual!",
        CLAIMED = "🔥 Your pet has been Inferno-mutated!",
        TOO_QUICK = "Slow down!",
        ALREADY_PET = "Pet already in the ritual!",
        NO_TIME = "",
        COMPLETED_TIMER = "",
        SKIPPED = "Skipped ritual timer!",
        CAMPFIRE_BOOST = "MULTx Ritual Speed (online)",
        CAMPFIRE_NEEDED = "Reach Tier MIN_TIER Campfire to begin the ritual!",
        ALREADY_HAS_MUTATION = "This pet already has the PET_MUTATION mutation!",
        SWITCHED_CONFIRM = "You switched pets!",
        FAVORITED = "This pet is Favorited!"
    },
    MESSAGE_QUESTION = { { 3, "I\'m the Campfire Keeper, here to give your pets a new mutation!" }, { 2.5, "Every 25 Bearnaby quests earn 1 Inferno Shard." }, { 2.5, "Place 4 Inferno Shards and a Pet of your choice" }, { 3, "Activate the ritual by reaching Tier 1 in the campfire and starting it!" }, { 2.5, "The higher the campfire tier, the faster the ritual goes!" }, { 3, "After the ritual is done, your pet will gain the Inferno Mutation!" } },
    GOODBYE = "Goodbye",
    EXIT_LINE = "Goodbye",
    INTRO = "Hey there!",
    NOTIFICATION_COLOR = { 255, 255, 255 },
    NOTIFICATION_COLOR_SPECIAL = { 255, 255, 255 },
    INFERNO_MUTATION_NAME = "Inferno",
    DATA_KEY = "SummerFireEventData"
};