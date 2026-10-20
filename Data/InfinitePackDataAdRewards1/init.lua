-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ConfigService = game:GetService("ConfigService");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests);
local DropTable = require(ReplicatedStorage.UserGenerated.Collections.DropTable);
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags);
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts);
local ISAAC = require(ReplicatedStorage.UserGenerated.Randoms.ISAAC);
require(script.InfinitePackTypes);
local script_InfinitePackProductIds = require(script.InfinitePackProductIds);
local u1 = { {
        Name = "Magnifying Glass",
        RewardName = "Magnifying Glass",
        Type = "Gear",
        Amount = 1,
        Chance = 30
    } };
local u2 = { {
        Name = "Spice Spritzer Sprinkler",
        RewardName = "Spice Spritzer Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    } };
local u3 = { {
        Name = "Rainbow Fertilizer",
        RewardName = "Rainbow Fertilizer",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    } };
local u4 = 90;
local u5 = 9;
local u6 = 1;

local function applyConfigTable(p7) -- Line: 47
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    if type(p7) ~= "table" then
        return;
    end;

    if type(p7.lowValueItems) == "table" then
        u1 = p7.lowValueItems;
    end;

    if type(p7.mediumValueItems) == "table" then
        u2 = p7.mediumValueItems;
    end;

    if type(p7.highValueItems) == "table" then
        u3 = p7.highValueItems;
    end;

    if type(p7.WeightLow) == "number" then
        u4 = p7.WeightLow;
    end;

    if type(p7.WeightMedium) == "number" then
        u5 = p7.WeightMedium;
    end;

    if type(p7.WeightHigh) == "number" then
        u6 = p7.WeightHigh;
    end;
end;

local function buildConfigTableFromCreatorHub() -- Line: 73
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), ConfigService (copy)
    local v8 = {
        lowValueItems = u1,
        mediumValueItems = u2,
        highValueItems = u3,
        WeightLow = u4,
        WeightMedium = u5,
        WeightHigh = u6
    };
    local UseCreatorHubConfig = script:FindFirstChild("UseCreatorHubConfig");
    local success, result = pcall(function() -- Line: 86
        -- upvalues: ConfigService (ref)
        return ConfigService:GetConfigAsync();
    end);

    if success and (result and (UseCreatorHubConfig and UseCreatorHubConfig.Value == true)) then
        local success2, result2 = pcall(function() -- Line: 91
            -- upvalues: result (copy)
            return result:GetValue("DailyDeals_Rewards");
        end);

        if not success2 or type(result2) ~= "table" then
            print("(Daily Deals) Using default rewards (config missing/invalid)");

            return v8;
        end;

        if type(result2.lowValueItems) == "table" then
            v8.lowValueItems = result2.lowValueItems;
        end;

        if type(result2.mediumValueItems) == "table" then
            v8.mediumValueItems = result2.mediumValueItems;
        end;

        if type(result2.highValueItems) == "table" then
            v8.highValueItems = result2.highValueItems;
        end;

        if type(result2.WeightLow) == "number" then
            v8.WeightLow = result2.WeightLow;
        end;

        if type(result2.WeightMedium) == "number" then
            v8.WeightMedium = result2.WeightMedium;
        end;

        if type(result2.WeightHigh) == "number" then
            v8.WeightHigh = result2.WeightHigh;

            return v8;
        end;
    end;

    return v8;
end;

if RunService:IsServer() then
    local v9 = buildConfigTableFromCreatorHub();
    applyConfigTable(v9);
    local DailyDealsConfigJson = script:FindFirstChild("DailyDealsConfigJson");

    if not DailyDealsConfigJson then
        DailyDealsConfigJson = Instance.new("StringValue");
        DailyDealsConfigJson.Name = "DailyDealsConfigJson";
        DailyDealsConfigJson.Parent = script;
    end;

    DailyDealsConfigJson.Value = HttpService:JSONEncode(v9);
else
    local DailyDealsConfigJson = script:WaitForChild("DailyDealsConfigJson");
    local success, result = pcall(function() -- Line: 149
        -- upvalues: HttpService (copy), DailyDealsConfigJson (copy)
        return HttpService:JSONDecode(DailyDealsConfigJson.Value);
    end);

    if success and type(result) == "table" then
        applyConfigTable(result);
    end;
end;

local v10 = {
    Free = {},
    Paid = {}
};

for _, v in ipairs(u1) do
    table.insert(v10.Paid, v);
end;

for _, v in ipairs(u2) do
    table.insert(v10.Paid, v);
end;

for _, v in ipairs(u3) do
    table.insert(v10.Paid, v);
end;

local u11 = FastFlags.Replicated("ForeverPackAdRewards.BaseAmount", Asserts.FiniteNonNegative, 1);
local u12 = FastFlags.Replicated("ForeverPackAdRewards.BaseLuck", Asserts.FiniteNonNegative, 1);
local u13 = FastFlags.Replicated("ForeverPackAdRewards.LuckPerPremiumTier", Asserts.FiniteNonNegative, 1);
local u14 = FastFlags.Replicated("ForeverPackAdRewards.InitialFreeSlotsRange", Asserts.Table({ Asserts.IntegerNonNegative, Asserts.IntegerNonNegative }), { 1, 1 });
local u15 = FastFlags.Replicated("ForeverPackAdRewards.PremiumFreeSlotsRange", Asserts.Table({ Asserts.IntegerNonNegative, Asserts.IntegerNonNegative }), { 2, 4 });
local u16 = FastFlags.Replicated("ForeverPackAdRewards.ItemsRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 1, 2 });
local u17 = FastFlags.Replicated("ForeverPackAdRewards.PremiumItemsRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 2, 3 });
local u18 = FastFlags.Replicated("ForeverPackAdRewards.PremiumReset", Asserts.Boolean, true);
local u19 = FastFlags.Replicated("ForeverPackAdRewards.PremiumAmountMultRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 3, 6 });
local u20 = FastFlags.Replicated("ForeverPackAdRewards.PremiumLuckMult", Asserts.FiniteNonNegative, 3);
local u21 = FastFlags.Replicated("ForeverPackAdRewards.Enabled", Asserts.Boolean, true);
local u22 = FastFlags.Replicated("ForeverPackAdRewards.DropsWeightLow", Asserts.FiniteNonNegative, u4);
local u23 = FastFlags.Replicated("ForeverPackAdRewards.DropsWeightMedium", Asserts.FiniteNonNegative, u5);
local u24 = FastFlags.Replicated("ForeverPackAdRewards.DropsWeightHigh", Asserts.FiniteNonNegative, u6);

local function PickItem(p25: any, p26: any, p27: number, p28: number) -- Line: 268
    local v29 = p25:Pick(1 - (1 - p26:NextDouble()) ^ (1 / p27));
    local table_clone_ret = table.clone(v29);
    local Amount = table_clone_ret.Amount;
    local math_floor_ret = math.floor(Amount);

    if Amount - math_floor_ret > p26:NextDouble() then
        math_floor_ret = math_floor_ret + 1;
    end;

    math.clamp(math_floor_ret, 1, table_clone_ret.MaxAmount or (1 / 0));
    table_clone_ret.Amount = Amount;

    return table_clone_ret;
end;

return {
    Rewards = v10,

    GetRewardsAsync = function(p30: userdata, p31: number, p32: number) -- Line: 292, Name: GetRewardsAsync
        -- upvalues: FastFlags (copy), ABTests (copy), u21 (copy), u14 (copy), u15 (copy), u16 (copy), u17 (copy), u18 (copy), u19 (copy), u20 (copy), u11 (copy), u12 (copy), u13 (copy), u22 (copy), u23 (copy), u24 (copy), ISAAC (copy), u1 (ref), u2 (ref), u3 (ref), DropTable (copy), script_InfinitePackProductIds (copy), PickItem (copy)
        if not FastFlags.IsLoaded() then
            FastFlags.Loaded:Wait();
        end;

        if not ABTests.IsLoaded() then
            ABTests.Loaded:Wait();
        end;

        if not u21:Get() then
            return {};
        end;

        local u33 = {
            InitialFreeSlotsRange = ABTests.GetAttribute(p30, "ForeverPackAdRewards.InitialFreeSlotsRange", u14:Get()),
            PremiumFreeSlotsRange = ABTests.GetAttribute(p30, "ForeverPackAdRewards.PremiumFreeSlotsRange", u15:Get()),
            ItemsRange = ABTests.GetAttribute(p30, "ForeverPackAdRewards.ItemsRange", u16:Get()),
            PremiumItemsRange = ABTests.GetAttribute(p30, "ForeverPackAdRewards.PremiumItemsRange", u17:Get()),
            PremiumReset = ABTests.GetAttribute(p30, "ForeverPackAdRewards.PremiumReset", u18:Get()),
            PremiumAmountMultRange = ABTests.GetAttribute(p30, "ForeverPackAdRewards.PremiumAmountMultRange", u19:Get()),
            PremiumLuckMult = ABTests.GetAttribute(p30, "ForeverPackAdRewards.PremiumLuckMult", u20:Get()),
            BaseAmount = ABTests.GetAttribute(p30, "ForeverPackAdRewards.BaseAmount", u11:Get()),
            BaseLuck = ABTests.GetAttribute(p30, "ForeverPackAdRewards.BaseLuck", u12:Get()),
            LuckPerPremiumTier = ABTests.GetAttribute(p30, "ForeverPackAdRewards.LuckPerPremiumTier", u13:Get()),
            DropsWeightLow = ABTests.GetAttribute(p30, "ForeverPackAdRewards.DropsWeightLow", u22:Get()),
            DropsWeightMedium = ABTests.GetAttribute(p30, "ForeverPackAdRewards.DropsWeightMedium", u23:Get()),
            DropsWeightHigh = ABTests.GetAttribute(p30, "ForeverPackAdRewards.DropsWeightHigh", u24:Get())
        };
        local u34 = ISAAC.new({ p30.UserId, p31 });
        local u35 = {};

        local function addDrops(p36: table, p37: number) -- Line: 331
            -- upvalues: u35 (copy)
            local v38 = 0;

            for _, v in ipairs(p36) do
                v38 = v38 + v.Chance;
            end;

            if v38 == 0 then
                return;
            end;

            for _, v in ipairs(p36) do
                table.insert(u35, {
                    Weight = v.Chance * p37 / v38,
                    Value = v
                });
            end;
        end;

        addDrops(u1, u33.DropsWeightLow);
        addDrops(u2, u33.DropsWeightMedium);
        addDrops(u3, u33.DropsWeightHigh);
        local v39 = DropTable.new(u35);

        local function initialFreeSlots() -- Line: 355
            -- upvalues: u33 (copy), u34 (copy)
            local InitialFreeSlotsRange = u33.InitialFreeSlotsRange;

            return u34:NextInteger(InitialFreeSlotsRange[1], InitialFreeSlotsRange[2]);
        end;

        local InitialFreeSlotsRange = u33.InitialFreeSlotsRange;
        local v40 = u34:NextInteger(InitialFreeSlotsRange[1], InitialFreeSlotsRange[2]);
        local v41 = 0;
        local v42 = 0;
        local v43 = {};

        for i = 1, p32 do
            local v44 = nil;

            if v40 <= v41 then
                if v42 < #script_InfinitePackProductIds or u33.PremiumReset then
                    v42 = v42 + 1;
                end;

                v41 = 0;

                if v42 <= #script_InfinitePackProductIds then
                    v44 = script_InfinitePackProductIds[v42][1];
                    local PremiumFreeSlotsRange = u33.PremiumFreeSlotsRange;
                    v40 = u34:NextInteger(PremiumFreeSlotsRange[1], PremiumFreeSlotsRange[2]);
                else
                    local InitialFreeSlotsRange2 = u33.InitialFreeSlotsRange;
                    v40 = u34:NextInteger(InitialFreeSlotsRange2[1], InitialFreeSlotsRange2[2]);
                    v42 = 0;
                end;
            end;

            if not v44 then
                v41 = v41 + 1;
            end;

            local ItemsRange = u33.ItemsRange;
            local BaseAmount = u33.BaseAmount;
            local v45 = u33.BaseLuck + v42 * u33.LuckPerPremiumTier;

            if v44 then
                ItemsRange = u33.PremiumItemsRange;
                local PremiumAmountMultRange = u33.PremiumAmountMultRange;
                BaseAmount = BaseAmount * u34:NextInteger(PremiumAmountMultRange[1], PremiumAmountMultRange[2]);
                v45 = v45 * u33.PremiumLuckMult;
            end;

            u34:NextInteger(ItemsRange[1], ItemsRange[2]);
            local v46 = {};

            for i2 = 1, 1 do
                local v47 = PickItem(v39, u34, v45, BaseAmount);
                table.insert(v46, v47);
                local _ = i2;
            end;

            v43[i] = {
                Rewards = v46,
                ProductId = v44
            };
        end;

        return v43;
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