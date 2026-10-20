-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);

return {
    FallBloomDuration = 300,
    MarketRefreshInterval = 300,
    RANDOM_SEED_VALUE = 8113,
    CravingRefresh = 1800,
    BaseRerollCost = 50000,
    FallActivityPeriod = 43200,
    Traits = { "Berry", "Fruit", "Flower", "Vegetable", "Tropical", "Prickly", "Woody" }
};