-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ABTests = require(ReplicatedStorage.UserGenerated.ABTests);
local DropTable = require(ReplicatedStorage.UserGenerated.Collections.DropTable);
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags);
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts);
local ISAAC = require(ReplicatedStorage.UserGenerated.Randoms.ISAAC);
require(script.InfinitePackTypes);
local script_InfinitePackProductIds = require(script.InfinitePackProductIds);
local u1 = {
    {
        Name = "250,000¢",
        RewardName = "Sheckles",
        Type = "Currency",
        Amount = 250000,
        Chance = 80
    },
    {
        Name = "Watering Can x30",
        RewardName = "Watering Can",
        Type = "Gear",
        Amount = 30,
        Chance = 80
    },
    {
        Name = "Silver Fertilizer",
        RewardName = "Silver Fertilizer",
        Type = "Gear",
        Amount = 1,
        Chance = 80
    },
    {
        Name = "Medium Toy",
        RewardName = "Medium Toy",
        Type = "Gear",
        Amount = 1,
        Chance = 30
    },
    {
        Name = "Medium Treat",
        RewardName = "Medium Treat",
        Type = "Gear",
        Amount = 1,
        Chance = 30
    },
    {
        Name = "Magnifying Glass",
        RewardName = "Magnifying Glass",
        Type = "Gear",
        Amount = 1,
        Chance = 30
    },
    {
        Name = "Friendship Pot",
        RewardName = "Friendship Pot",
        Type = "Gear",
        Amount = 1,
        Chance = 30
    },
    {
        Name = "Tropical Mist Sprinkler",
        RewardName = "Tropical Mist Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Sweet Soaker Sprinkler",
        RewardName = "Sweet Soaker Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Stalk Sprout Sprinkler",
        RewardName = "Stalk Sprout Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Spice Spritzer Sprinkler",
        RewardName = "Spice Spritzer Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Master Sprinkler",
        RewardName = "Master Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 5
    },
    {
        Name = "Statue Crate",
        RewardName = "Statue Crate",
        Type = "Crate",
        Amount = 1,
        Chance = 5
    },
    {
        Name = "Fun Crate",
        RewardName = "Fun Crate",
        Type = "Crate",
        Amount = 1,
        Chance = 5
    },
    {
        Name = "Outdoors Crate",
        RewardName = "Outdoors Crate",
        Type = "Crate",
        Amount = 1,
        Chance = 5
    },
    {
        Name = "Classic Gnome Crate",
        RewardName = "Classic Gnome Crate",
        Type = "Crate",
        Amount = 1,
        Chance = 5
    }
};
local v2 = {
    Free = {},
    Paid = {}
};
local u3 = {
    {
        Name = "1,000,000¢",
        RewardName = "Sheckles",
        Type = "Currency",
        Amount = 1000000,
        Chance = 25
    },
    {
        Name = "Super Watering Can",
        RewardName = "Super Watering Can",
        Type = "Gear",
        Amount = 1,
        Chance = 25
    },
    {
        Name = "Large Toy",
        RewardName = "Large Toy",
        Type = "Gear",
        Amount = 1,
        Chance = 25
    },
    {
        Name = "Energy Chew",
        RewardName = "Energy Chew",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Rainbow Fertilizer",
        RewardName = "Rainbow Fertilizer",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Level-Up Lollipop",
        RewardName = "Levelup Lollipop",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Silver Lollipop",
        RewardName = "Silver Lollipop",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Rainbow Lollipop",
        RewardName = "Rainbow Lollipop",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Grandmaster Sprinkler",
        RewardName = "Grandmaster Sprinkler",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Grow All",
        RewardName = "Grow All",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Artisan Container",
        RewardName = "Artisan Container",
        Type = "Seed Pack",
        Amount = 1,
        Chance = 5
    },
    {
        Name = "Elemental Container",
        RewardName = "Elemental Container",
        Type = "Seed Pack",
        Amount = 1,
        Chance = 5
    },
    {
        Name = "Gem Chest",
        RewardName = "Gem Chest",
        Type = "Seed Pack",
        Amount = 1,
        Chance = 5
    },
    {
        Name = "Zen Crate",
        RewardName = "Zen Crate",
        Type = "Crate",
        Amount = 1,
        Chance = 5
    },
    {
        Name = "Bug Egg",
        RewardName = "Bug Egg",
        Type = "Egg",
        Amount = 1,
        Chance = 3
    },
    {
        Name = "Gem Egg",
        RewardName = "Gem Egg",
        Type = "Egg",
        Amount = 1,
        Chance = 3
    }
};
local u4 = {
    {
        Name = "10,000,000¢",
        RewardName = "Sheckles",
        Type = "Currency",
        Amount = 10000000,
        Chance = 10
    },
    {
        Name = "Pet Mutation Shard (Gold)",
        RewardName = "Pet Shard Golden",
        Type = "Gear",
        Amount = 1,
        Chance = 10
    },
    {
        Name = "Pet Mutation Shard (Jumbo)",
        RewardName = "Pet Shard JUMBO",
        Type = "Gear",
        Amount = 1,
        Chance = 7
    },
    {
        Name = "Zen Egg",
        RewardName = "Zen Egg",
        Type = "Egg",
        Amount = 1,
        Chance = 0.1
    },
    {
        Name = "Crimson Thorn Seed",
        RewardName = "Crimson Thorn",
        Type = "Seed",
        Amount = 1,
        Chance = 3
    },
    {
        Name = "Zebrazinkle Seed",
        RewardName = "Zebrazinkle",
        Type = "Seed",
        Amount = 1,
        Chance = 3
    },
    {
        Name = "Octobloom Seed",
        RewardName = "Octobloom",
        Type = "Seed",
        Amount = 1,
        Chance = 3
    },
    {
        Name = "Paradise Egg",
        RewardName = "Paradise Egg",
        Type = "Egg",
        Amount = 1,
        Chance = 1
    },
    {
        Name = "Mega Lollipop",
        RewardName = "Mega Lollipop",
        Type = "Gear",
        Amount = 1,
        MaxAmount = 1,
        Chance = 1
    },
    {
        Name = "Pet Mutation Shard (Rainbow)",
        RewardName = "Pet Shard Rainbow",
        Type = "Gear",
        Amount = 1,
        Chance = 0.5
    },
    {
        Name = "Night Egg",
        RewardName = "Night Egg",
        Type = "Egg",
        Amount = 1,
        MaxAmount = 1,
        Chance = 0.1
    }
};

for _, v in ipairs(u1) do
    table.insert(v2.Paid, v);
end;

for _, v in ipairs(u3) do
    table.insert(v2.Paid, v);
end;

for _, v in ipairs(u4) do
    table.insert(v2.Paid, v);
end;

local u5 = FastFlags.Replicated("ForeverPack.BaseAmount", Asserts.FiniteNonNegative, 1);
local u6 = FastFlags.Replicated("ForeverPack.BaseLuck", Asserts.FiniteNonNegative, 1);
local u7 = FastFlags.Replicated("ForeverPack.LuckPerPremiumTier", Asserts.FiniteNonNegative, 1);
local u8 = FastFlags.Replicated("ForeverPack.InitialFreeSlotsRange", Asserts.Table({ Asserts.IntegerNonNegative, Asserts.IntegerNonNegative }), { 1, 1 });
local u9 = FastFlags.Replicated("ForeverPack.PremiumFreeSlotsRange", Asserts.Table({ Asserts.IntegerNonNegative, Asserts.IntegerNonNegative }), { 2, 4 });
local u10 = FastFlags.Replicated("ForeverPack.ItemsRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 1, 2 });
local u11 = FastFlags.Replicated("ForeverPack.PremiumItemsRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 2, 3 });
local u12 = FastFlags.Replicated("ForeverPack.PremiumReset", Asserts.Boolean, true);
local u13 = FastFlags.Replicated("ForeverPack.PremiumAmountMultRange", Asserts.Table({ Asserts.FiniteNonNegative, Asserts.FiniteNonNegative }), { 3, 6 });
local u14 = FastFlags.Replicated("ForeverPack.PremiumLuckMult", Asserts.FiniteNonNegative, 3);
local u15 = FastFlags.Replicated("ForeverPack.Enabled", Asserts.Boolean, true);
local u16 = FastFlags.Replicated("ForeverPack.DropsWeightLow", Asserts.FiniteNonNegative, 95);
local u17 = FastFlags.Replicated("ForeverPack.DropsWeightMedium", Asserts.FiniteNonNegative, 4.99);
local u18 = FastFlags.Replicated("ForeverPack.DropsWeightHigh", Asserts.FiniteNonNegative, 0.01);

local function PickItem(p19: any, p20: any, p21: number, p22: number) -- Line: 185
    local v23 = p19:Pick(1 - (1 - p20:NextDouble()) ^ (1 / p21));
    local table_clone_ret = table.clone(v23);
    local v24 = table_clone_ret.Amount * p22;
    local math_floor_ret = math.floor(v24);

    if v24 - math_floor_ret > p20:NextDouble() then
        math_floor_ret = math_floor_ret + 1;
    end;

    table_clone_ret.Amount = math.clamp(math_floor_ret, 1, table_clone_ret.MaxAmount or (1 / 0));

    return table_clone_ret;
end;

local function GetRewardsAsync(p25: userdata, p26: number, p27: number) -- Line: 217
    -- upvalues: FastFlags (copy), ABTests (copy), u15 (copy), u8 (copy), u9 (copy), u10 (copy), u11 (copy), u12 (copy), u13 (copy), u14 (copy), u5 (copy), u6 (copy), u7 (copy), u16 (copy), u17 (copy), u18 (copy), ISAAC (copy), u1 (copy), u3 (copy), u4 (copy), DropTable (copy), script_InfinitePackProductIds (copy), PickItem (copy)
    if not FastFlags.IsLoaded() then
        FastFlags.Loaded:Wait();
    end;

    if not ABTests.IsLoaded() then
        ABTests.Loaded:Wait();
    end;

    if not u15:Get() then
        return {};
    end;

    local u28 = {
        InitialFreeSlotsRange = ABTests.GetAttribute(p25, "ForeverPack.InitialFreeSlotsRange", u8:Get()),
        PremiumFreeSlotsRange = ABTests.GetAttribute(p25, "ForeverPack.PremiumFreeSlotsRange", u9:Get()),
        ItemsRange = ABTests.GetAttribute(p25, "ForeverPack.ItemsRange", u10:Get()),
        PremiumItemsRange = ABTests.GetAttribute(p25, "ForeverPack.PremiumItemsRange", u11:Get()),
        PremiumReset = ABTests.GetAttribute(p25, "ForeverPack.PremiumReset", u12:Get()),
        PremiumAmountMultRange = ABTests.GetAttribute(p25, "ForeverPack.PremiumAmountMultRange", u13:Get()),
        PremiumLuckMult = ABTests.GetAttribute(p25, "ForeverPack.PremiumLuckMult", u14:Get()),
        BaseAmount = ABTests.GetAttribute(p25, "ForeverPack.BaseAmount", u5:Get()),
        BaseLuck = ABTests.GetAttribute(p25, "ForeverPack.BaseLuck", u6:Get()),
        LuckPerPremiumTier = ABTests.GetAttribute(p25, "ForeverPack.LuckPerPremiumTier", u7:Get()),
        DropsWeightLow = ABTests.GetAttribute(p25, "ForeverPack.DropsWeightLow", u16:Get()),
        DropsWeightMedium = ABTests.GetAttribute(p25, "ForeverPack.DropsWeightMedium", u17:Get()),
        DropsWeightHigh = ABTests.GetAttribute(p25, "ForeverPack.DropsWeightHigh", u18:Get())
    };
    local u29 = ISAAC.new({ p25.UserId, p26 });
    local u30 = {};

    local function addDrops(p31: table, p32: number) -- Line: 258
        -- upvalues: u30 (copy)
        local v33 = 0;

        for _, v in ipairs(p31) do
            v33 = v33 + v.Chance;
        end;

        if v33 == 0 then
            return;
        end;

        for _, v in ipairs(p31) do
            table.insert(u30, {
                Weight = v.Chance * p32 / v33,
                Value = v
            });
        end;
    end;

    addDrops(u1, u28.DropsWeightLow);
    addDrops(u3, u28.DropsWeightMedium);
    addDrops(u4, u28.DropsWeightHigh);
    local v34 = DropTable.new(u30);

    local function initialFreeSlots() -- Line: 283
        -- upvalues: u28 (copy), u29 (copy)
        local InitialFreeSlotsRange = u28.InitialFreeSlotsRange;

        return u29:NextInteger(InitialFreeSlotsRange[1], InitialFreeSlotsRange[2]);
    end;

    local InitialFreeSlotsRange = u28.InitialFreeSlotsRange;
    local v35 = u29:NextInteger(InitialFreeSlotsRange[1], InitialFreeSlotsRange[2]);
    local v36 = 0;
    local v37 = 0;
    local v38 = {};

    for i = 1, p27 do
        local v39 = nil;

        if v35 <= v36 then
            if v37 < #script_InfinitePackProductIds or u28.PremiumReset then
                v37 = v37 + 1;
            end;

            v36 = 0;

            if v37 <= #script_InfinitePackProductIds then
                v39 = script_InfinitePackProductIds[v37][1];
                local PremiumFreeSlotsRange = u28.PremiumFreeSlotsRange;
                v35 = u29:NextInteger(PremiumFreeSlotsRange[1], PremiumFreeSlotsRange[2]);
            else
                local InitialFreeSlotsRange2 = u28.InitialFreeSlotsRange;
                v35 = u29:NextInteger(InitialFreeSlotsRange2[1], InitialFreeSlotsRange2[2]);
                v37 = 0;
            end;
        end;

        if not v39 then
            v36 = v36 + 1;
        end;

        local ItemsRange = u28.ItemsRange;
        local BaseAmount = u28.BaseAmount;
        local v40 = u28.BaseLuck + v37 * u28.LuckPerPremiumTier;

        if v39 then
            ItemsRange = u28.PremiumItemsRange;
            local PremiumAmountMultRange = u28.PremiumAmountMultRange;
            BaseAmount = BaseAmount * u29:NextInteger(PremiumAmountMultRange[1], PremiumAmountMultRange[2]);
            v40 = v40 * u28.PremiumLuckMult;
        end;

        u29:NextInteger(ItemsRange[1], ItemsRange[2]);
        local v41 = {};

        for i2 = 1, 1 do
            local v42 = PickItem(v34, u29, v40, BaseAmount);
            table.insert(v41, v42);
            local _ = i2;
        end;

        v38[i] = {
            Rewards = v41,
            ProductId = v39
        };
    end;

    return v38;
end;

return {};