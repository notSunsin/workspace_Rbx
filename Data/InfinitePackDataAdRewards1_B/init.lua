-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ConfigService = game:GetService("ConfigService");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests);
local DropTable = require(ReplicatedStorage.UserGenerated.Collections.DropTable);
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags);
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

local function applyConfigTable(p7) -- Line: 45
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

local function buildConfigTableFromCreatorHub() -- Line: 71
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
    local success, result = pcall(function() -- Line: 83
        -- upvalues: ConfigService (ref)
        return ConfigService:GetConfigAsync();
    end);

    if success and (result and (UseCreatorHubConfig and UseCreatorHubConfig.Value == true)) then
        local success2, result2 = pcall(function() -- Line: 88
            -- upvalues: result (copy)
            return result:GetValue("DailyDeals_Rewards_B");
        end);

        if success2 and type(result2) == "table" then
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
        else
            print("(Daily Deals B) Using default rewards (config missing/invalid)");
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
    local success, result = pcall(function() -- Line: 141
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

local u11 = { 1, 1 };
local u12 = { 2, 4 };
local u13 = { 1, 2 };
local u14 = { 2, 3 };
local u15 = { 3, 6 };

local function PickItem(p16: any, p17: any, p18: number, p19: number) -- Line: 185
    local v20 = p16:Pick(1 - (1 - p17:NextDouble()) ^ (1 / p18));
    local table_clone_ret = table.clone(v20);
    local Amount = table_clone_ret.Amount;
    local math_floor_ret = math.floor(Amount);

    if Amount - math_floor_ret > p17:NextDouble() then
        math_floor_ret = math_floor_ret + 1;
    end;

    math.clamp(math_floor_ret, 1, table_clone_ret.MaxAmount or (1 / 0));
    table_clone_ret.Amount = Amount;

    return table_clone_ret;
end;

return {
    Rewards = v10,

    GetRewardsAsync = function(p21: userdata, p22: number, p23: number) -- Line: 209, Name: GetRewardsAsync
        -- upvalues: FastFlags (copy), ABTests (copy), u11 (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy), u4 (ref), u5 (ref), u6 (ref), ISAAC (copy), u1 (ref), u2 (ref), u3 (ref), DropTable (copy), script_InfinitePackProductIds (copy), PickItem (copy)
        if not FastFlags.IsLoaded() then
            FastFlags.Loaded:Wait();
        end;

        if not ABTests.IsLoaded() then
            ABTests.Loaded:Wait();
        end;

        if not ABTests.GetAttribute(p21, "ForeverPackAdRewards.Enabled", true) then
            return {};
        end;

        local u24 = {
            InitialFreeSlotsRange = ABTests.GetAttribute(p21, "ForeverPackAdRewards.InitialFreeSlotsRange", u11),
            PremiumFreeSlotsRange = ABTests.GetAttribute(p21, "ForeverPackAdRewards.PremiumFreeSlotsRange", u12),
            ItemsRange = ABTests.GetAttribute(p21, "ForeverPackAdRewards.ItemsRange", u13),
            PremiumItemsRange = ABTests.GetAttribute(p21, "ForeverPackAdRewards.PremiumItemsRange", u14),
            PremiumReset = ABTests.GetAttribute(p21, "ForeverPackAdRewards.PremiumReset", true),
            PremiumAmountMultRange = ABTests.GetAttribute(p21, "ForeverPackAdRewards.PremiumAmountMultRange", u15),
            PremiumLuckMult = ABTests.GetAttribute(p21, "ForeverPackAdRewards.PremiumLuckMult", 3),
            BaseAmount = ABTests.GetAttribute(p21, "ForeverPackAdRewards.BaseAmount", 1),
            BaseLuck = ABTests.GetAttribute(p21, "ForeverPackAdRewards.BaseLuck", 1),
            LuckPerPremiumTier = ABTests.GetAttribute(p21, "ForeverPackAdRewards.LuckPerPremiumTier", 1),
            DropsWeightLow = ABTests.GetAttribute(p21, "ForeverPackAdRewards.DropsWeightLow", u4),
            DropsWeightMedium = ABTests.GetAttribute(p21, "ForeverPackAdRewards.DropsWeightMedium", u5),
            DropsWeightHigh = ABTests.GetAttribute(p21, "ForeverPackAdRewards.DropsWeightHigh", u6)
        };
        local u25 = ISAAC.new({ p21.UserId, p22 });
        local u26 = {};

        local function addDrops(p27: table, p28: number) -- Line: 249
            -- upvalues: u26 (copy)
            local v29 = 0;

            for _, v in ipairs(p27) do
                v29 = v29 + v.Chance;
            end;

            if v29 == 0 then
                return;
            end;

            for _, v in ipairs(p27) do
                table.insert(u26, {
                    Weight = v.Chance * p28 / v29,
                    Value = v
                });
            end;
        end;

        addDrops(u1, u24.DropsWeightLow);
        addDrops(u2, u24.DropsWeightMedium);
        addDrops(u3, u24.DropsWeightHigh);
        local v30 = DropTable.new(u26);

        local function initialFreeSlots() -- Line: 275
            -- upvalues: u24 (copy), u25 (copy)
            local InitialFreeSlotsRange = u24.InitialFreeSlotsRange;

            return u25:NextInteger(InitialFreeSlotsRange[1], InitialFreeSlotsRange[2]);
        end;

        local InitialFreeSlotsRange = u24.InitialFreeSlotsRange;
        local v31 = u25:NextInteger(InitialFreeSlotsRange[1], InitialFreeSlotsRange[2]);
        local v32 = 0;
        local v33 = 0;
        local v34 = {};

        for i = 1, p23 do
            local v35 = nil;

            if v31 <= v32 then
                if v33 < #script_InfinitePackProductIds or u24.PremiumReset then
                    v33 = v33 + 1;
                end;

                v32 = 0;

                if v33 <= #script_InfinitePackProductIds then
                    v35 = script_InfinitePackProductIds[v33][1];
                    local PremiumFreeSlotsRange = u24.PremiumFreeSlotsRange;
                    v31 = u25:NextInteger(PremiumFreeSlotsRange[1], PremiumFreeSlotsRange[2]);
                else
                    local InitialFreeSlotsRange2 = u24.InitialFreeSlotsRange;
                    v31 = u25:NextInteger(InitialFreeSlotsRange2[1], InitialFreeSlotsRange2[2]);
                    v33 = 0;
                end;
            end;

            if not v35 then
                v32 = v32 + 1;
            end;

            local ItemsRange = u24.ItemsRange;
            local BaseAmount = u24.BaseAmount;
            local v36 = u24.BaseLuck + v33 * u24.LuckPerPremiumTier;

            if v35 then
                ItemsRange = u24.PremiumItemsRange;
                local PremiumAmountMultRange = u24.PremiumAmountMultRange;
                BaseAmount = BaseAmount * u25:NextInteger(PremiumAmountMultRange[1], PremiumAmountMultRange[2]);
                v36 = v36 * u24.PremiumLuckMult;
            end;

            u25:NextInteger(ItemsRange[1], ItemsRange[2]);
            local v37 = {};

            for i2 = 1, 1 do
                local v38 = PickItem(v30, u25, v36, BaseAmount);
                table.insert(v37, v38);
                local _ = i2;
            end;

            v34[i] = {
                Rewards = v37,
                ProductId = v35
            };
        end;

        return v34;
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