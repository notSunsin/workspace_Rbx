-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests);
local DropTable = require(ReplicatedStorage.UserGenerated.Collections.DropTable);
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags);
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts);
local ISAAC = require(ReplicatedStorage.UserGenerated.Randoms.ISAAC);
require(script.InfinitePackTypes);
local script_InfinitePackProductIds = require(script.InfinitePackProductIds);
local ConfigService = game:GetService("ConfigService");
local u1 = { {
        Name = "Watering Can",
        RewardName = "Watering Can",
        Type = "Gear",
        Amount = 1,
        Chance = 100
    }, {
        Name = "Basic Sprinkler",
        RewardName = "Basic Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 50
    } };
local u2 = { {
        Name = "Super Watering Can",
        RewardName = "Super Watering Can",
        Type = "Gear",
        Amount = 1,
        Chance = 40
    }, {
        Name = "Advanced Sprinkler",
        RewardName = "Advanced Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 60
    } };
local u3 = { {
        Name = "Tropical Mist Sprinkler",
        RewardName = "Tropical Mist Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    }, {
        Name = "Sweet Soaker Sprinkler",
        RewardName = "Sweet Soaker Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    }, {
        Name = "Stalk Sprout Sprinkler",
        RewardName = "Stalk Sprout Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    }, {
        Name = "Spice Spritzer Sprinkler",
        RewardName = "Spice Spritzer Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    } };
local v4 = 90;
local v5 = 9;
local v6 = 1;
local success, result = pcall(function() -- Line: 59
    -- upvalues: ConfigService (copy)
    return ConfigService:GetConfigAsync();
end);
local UseCreatorHubConfig = script:FindFirstChild("UseCreatorHubConfig");

if success and (result and UseCreatorHubConfig) then
    local success2, result2 = pcall(function() -- Line: 66
        -- upvalues: result (copy)
        return result:GetValue("Wateringcan_Rewards");
    end);

    if success2 and (result2 and UseCreatorHubConfig.Value == true) then
        print("(Watering Can) Using configuration rewards");
        u1 = result2.lowValueItems;
        u2 = result2.mediumValueItems;
        u3 = result2.highValueItems;
        v4 = result2.WeightLow;
        v5 = result2.WeightMedium;
        v6 = result2.WeightHigh;
    else
        print("(Watering Can) Using default rewards");
    end;
end;

local v7 = {
    Free = {},
    Paid = {}
};

for _, v in ipairs(u1) do
    table.insert(v7.Paid, v);
end;

for _, v in ipairs(u2) do
    table.insert(v7.Paid, v);
end;

for _, v in ipairs(u3) do
    table.insert(v7.Paid, v);
end;

local u8 = FastFlags.Replicated("WateringCanAdRewards.BaseAmount", Asserts.FiniteNonNegative, 1);
local u9 = FastFlags.Replicated("WateringCanAdRewards.BaseLuck", Asserts.FiniteNonNegative, 1);
local u10 = FastFlags.Replicated("WateringCanAdRewards.LuckPerPremiumTier", Asserts.FiniteNonNegative, 1);
local u11 = FastFlags.Replicated("WateringCanAdRewards.InitialFreeSlotsRange", Asserts.Table({ Asserts.IntegerNonNegative, Asserts.IntegerNonNegative }), { 1, 1 });
local u12 = FastFlags.Replicated("WateringCanAdRewards.PremiumFreeSlotsRange", Asserts.Table({ Asserts.IntegerNonNegative, Asserts.IntegerNonNegative }), { 2, 4 });
local u13 = FastFlags.Replicated("WateringCanAdRewards.ItemsRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 1, 2 });
local u14 = FastFlags.Replicated("WateringCanAdRewards.PremiumItemsRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 2, 3 });
local u15 = FastFlags.Replicated("WateringCanAdRewards.PremiumReset", Asserts.Boolean, true);
local u16 = FastFlags.Replicated("WateringCanAdRewards.PremiumAmountMultRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 3, 6 });
local u17 = FastFlags.Replicated("WateringCanAdRewards.PremiumLuckMult", Asserts.FiniteNonNegative, 3);
local u18 = FastFlags.Replicated("WateringCanAdRewards.Enabled", Asserts.Boolean, true);
local u19 = FastFlags.Replicated("WateringCanAdRewards.DropsWeightLow", Asserts.FiniteNonNegative, v4);
local u20 = FastFlags.Replicated("WateringCanAdRewards.DropsWeightMedium", Asserts.FiniteNonNegative, v5);
local u21 = FastFlags.Replicated("WateringCanAdRewards.DropsWeightHigh", Asserts.FiniteNonNegative, v6);

local function PickItem(p22: any, p23: any, p24: number) -- Line: 194
    local v25 = p22:Pick(1 - (1 - p23:NextDouble()) ^ (1 / p24));

    return table.clone(v25);
end;

local function buildCategoryDrops(p26: table) -- Line: 216
    -- upvalues: DropTable (copy)
    local v27 = 0;
    local v28 = {};

    for _, v in ipairs(p26) do
        v27 = v27 + v.Chance;
    end;

    if v27 == 0 then
        return nil;
    end;

    for _, v in ipairs(p26) do
        table.insert(v28, {
            Weight = v.Chance,
            Value = v
        });
    end;

    return DropTable.new(v28);
end;

local function pickBetweenTwoCategories(p29: any, p30: any, p31: number, p32: any, p33: number) -- Line: 236
    local v34 = 0;

    if p30 and p31 > 0 then
        v34 = v34 + p31;
    end;

    if p32 and p33 > 0 then
        v34 = v34 + p33;
    end;

    if v34 <= 0 then
        return p30 or p32;
    end;

    local v35 = p29:NextDouble() * v34;

    if p30 and (p31 > 0 and v35 < p31) then
        return p30;
    end;

    return p32;
end;

return {
    Rewards = v7,

    GetRewardsAsync = function(p36: userdata, p37: number, p38: number) -- Line: 264, Name: GetRewardsAsync
        -- upvalues: FastFlags (copy), ABTests (copy), u18 (copy), u11 (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy), u17 (copy), u8 (copy), u9 (copy), u10 (copy), u19 (copy), u20 (copy), u21 (copy), ISAAC (copy), buildCategoryDrops (copy), u1 (ref), u2 (ref), u3 (ref), script_InfinitePackProductIds (copy)
        if not FastFlags.IsLoaded() then
            FastFlags.Loaded:Wait();
        end;

        if not ABTests.IsLoaded() then
            ABTests.Loaded:Wait();
        end;

        if not u18:Get() then
            return {};
        end;

        local u39 = {
            InitialFreeSlotsRange = ABTests.GetAttribute(p36, "WateringCanAdRewards.InitialFreeSlotsRange", u11:Get()),
            PremiumFreeSlotsRange = ABTests.GetAttribute(p36, "WateringCanAdRewards.PremiumFreeSlotsRange", u12:Get()),
            ItemsRange = ABTests.GetAttribute(p36, "WateringCanAdRewards.ItemsRange", u13:Get()),
            PremiumItemsRange = ABTests.GetAttribute(p36, "WateringCanAdRewards.PremiumItemsRange", u14:Get()),
            PremiumReset = ABTests.GetAttribute(p36, "WateringCanAdRewards.PremiumReset", u15:Get()),
            PremiumAmountMultRange = ABTests.GetAttribute(p36, "WateringCanAdRewards.PremiumAmountMultRange", u16:Get()),
            PremiumLuckMult = ABTests.GetAttribute(p36, "WateringCanAdRewards.PremiumLuckMult", u17:Get()),
            BaseAmount = ABTests.GetAttribute(p36, "WateringCanAdRewards.BaseAmount", u8:Get()),
            BaseLuck = ABTests.GetAttribute(p36, "WateringCanAdRewards.BaseLuck", u9:Get()),
            LuckPerPremiumTier = ABTests.GetAttribute(p36, "WateringCanAdRewards.LuckPerPremiumTier", u10:Get()),
            DropsWeightLow = ABTests.GetAttribute(p36, "WateringCanAdRewards.DropsWeightLow", u19:Get()),
            DropsWeightMedium = ABTests.GetAttribute(p36, "WateringCanAdRewards.DropsWeightMedium", u20:Get()),
            DropsWeightHigh = ABTests.GetAttribute(p36, "WateringCanAdRewards.DropsWeightHigh", u21:Get())
        };
        local u40 = ISAAC.new({ p36.UserId, p37 });
        local u41 = buildCategoryDrops(u1);
        local u42 = buildCategoryDrops(u2);
        local u43 = buildCategoryDrops(u3);

        local function initialFreeSlots() -- Line: 344
            -- upvalues: u39 (copy), u40 (copy)
            local InitialFreeSlotsRange = u39.InitialFreeSlotsRange;

            return u40:NextInteger(InitialFreeSlotsRange[1], InitialFreeSlotsRange[2]);
        end;

        local InitialFreeSlotsRange = u39.InitialFreeSlotsRange;
        local v44 = u40:NextInteger(InitialFreeSlotsRange[1], InitialFreeSlotsRange[2]);
        local v45 = 0;
        local v46 = 0;

        local function getSlotDrops(p47: number) -- Line: 313
            -- upvalues: u41 (copy), u40 (copy), u39 (copy), u42 (copy), u43 (copy)
            if p47 == 1 then
                return u41;
            end;

            if p47 == 2 then
                local v48 = u41;
                local DropsWeightLow = u39.DropsWeightLow;
                local v49 = u42;
                local DropsWeightMedium = u39.DropsWeightMedium;
                local v50 = 0;

                if v48 and DropsWeightLow > 0 then
                    v50 = v50 + DropsWeightLow;
                end;

                if v49 and DropsWeightMedium > 0 then
                    v50 = v50 + DropsWeightMedium;
                end;

                if v50 <= 0 then
                    return v48 or v49;
                end;

                local v51 = u40:NextDouble() * v50;

                if v48 and (DropsWeightLow > 0 and v51 < DropsWeightLow) then
                    return v48;
                end;

                return v49;
            end;

            if p47 == 3 then
                return u42;
            end;

            if p47 ~= 4 then
                if p47 == 5 then
                    return u41;
                end;

                return u41 or (u42 or u43);
            end;

            local v52 = u42;
            local DropsWeightMedium = u39.DropsWeightMedium;
            local v53 = u43;
            local DropsWeightHigh = u39.DropsWeightHigh;
            local v54 = 0;

            if v52 and DropsWeightMedium > 0 then
                v54 = v54 + DropsWeightMedium;
            end;

            if v53 and DropsWeightHigh > 0 then
                v54 = v54 + DropsWeightHigh;
            end;

            if v54 <= 0 then
                return v52 or v53;
            end;

            local v55 = u40:NextDouble() * v54;

            if v52 and (DropsWeightMedium > 0 and v55 < DropsWeightMedium) then
                return v52;
            end;

            return v53;
        end;

        local v56 = {};

        for i = 1, math.min(p38, 5) do
            local v57 = nil;

            if v44 <= v45 then
                if v46 < #script_InfinitePackProductIds or u39.PremiumReset then
                    v46 = v46 + 1;
                end;

                v45 = 0;

                if v46 <= #script_InfinitePackProductIds then
                    v57 = script_InfinitePackProductIds[v46][1];
                    local PremiumFreeSlotsRange = u39.PremiumFreeSlotsRange;
                    v44 = u40:NextInteger(PremiumFreeSlotsRange[1], PremiumFreeSlotsRange[2]);
                else
                    local InitialFreeSlotsRange2 = u39.InitialFreeSlotsRange;
                    v44 = u40:NextInteger(InitialFreeSlotsRange2[1], InitialFreeSlotsRange2[2]);
                    v46 = 0;
                end;
            end;

            if not v57 then
                v45 = v45 + 1;
            end;

            local ItemsRange = u39.ItemsRange;
            local v58 = u39.BaseLuck + v46 * u39.LuckPerPremiumTier;

            if v57 then
                ItemsRange = u39.PremiumItemsRange;
                v58 = v58 * u39.PremiumLuckMult;
            end;

            u40:NextInteger(ItemsRange[1], ItemsRange[2]);
            local v59 = getSlotDrops(i) or (u41 or (u42 or u43));
            local v60 = {};

            for i2 = 1, 1 do
                local v61 = v59:Pick(1 - (1 - u40:NextDouble()) ^ (1 / v58));
                local table_clone_ret = table.clone(v61);
                table.insert(v60, table_clone_ret);
                local _ = i2;
            end;

            v56[i] = {
                Rewards = v60,
                ProductId = v57
            };
        end;

        return v56;
    end,

    FallbackPrices = {
        [3483219975] = 39,
        [3483220099] = 79,
        [3483220200] = 119,
        [3483220270] = 159,
        [3483220356] = 199,
        [3483220437] = 279,
        [3483221023] = 399,
        [3483221092] = 639,
        [3483221165] = 759,
        [3483221217] = 959,
        [3483221290] = 1199
    }
};