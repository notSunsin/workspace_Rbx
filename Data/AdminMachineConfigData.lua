-- Decompiled with Potassium's decompiler.

local function seconds(p1: number) -- Line: 4
    return p1;
end;

local function minutes(p2: number) -- Line: 8
    return p2 * 60;
end;

local function hours(p3: number) -- Line: 12
    return p3 * 60 * 60;
end;

return {
    GEAR_STOCK_CHANCE_MULTIPLIER = 1,
    EGG_STOCK_CHANCE_MULTIPLIER = 1,
    SEED_STOCK_CHANCE_MULTIPLIER = 1,
    WEATHER_CHANCE_MULTIPLIER = 1,
    ROLL_DURATION_LENGTH = 3,
    COST_RATE_OF_INCREASE = 100,
    BOOST_RATE_OF_INCREASE = 0.1,
    MIN_BOOST_AMOUNT = 1,
    MAX_BOOST_AMOUNT = 2,
    INTERVAL_LENGTH = 3600
};