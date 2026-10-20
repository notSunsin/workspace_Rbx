-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {
    Wasp = 1,
    ["Razorsting Wasp"] = 2,
    ["Acidwing Wasp"] = 3,
    ["Dreadhorn Wasp"] = 4,
    ["Wasp King"] = 6
};
local u3 = {
    {
        tier = 0,
        weight = 145,
        min = 15,
        max = 45,
        reward = {
            Type = "Currency",
            Value = "HoneyCoins"
        }
    },
    {
        tier = 1,
        weight = 28,
        min = 3,
        max = 8,
        reward = {
            Type = "Currency",
            Value = "RoyalJelly"
        }
    },
    {
        tier = 1,
        weight = 28,
        min = 1,
        max = 2,
        reward = {
            Type = "Seed",
            Value = "Stinger Reed"
        }
    },
    {
        tier = 2,
        weight = 12,
        min = 1,
        max = 1,
        reward = {
            Type = "Gear",
            Value = "Common Bee Egg"
        }
    },
    {
        tier = 2,
        weight = 10,
        min = 1,
        max = 1,
        reward = {
            Type = "Seed Pack",
            Value = "Honey Hive Seed Pack"
        }
    },
    {
        tier = 2,
        weight = 7,
        min = 1,
        max = 1,
        reward = {
            Type = "Seed",
            Value = "Spiketail"
        }
    },
    {
        tier = 3,
        weight = 3,
        min = 1,
        max = 1,
        minPower = 2,
        reward = {
            Type = "Gear",
            Value = "Rare Bee Egg"
        }
    },
    {
        tier = 4,
        weight = 1,
        min = 1,
        max = 1,
        minPower = 3,
        reward = {
            Type = "Gear",
            Value = "Mythical Bee Egg"
        }
    },
    {
        tier = 5,
        weight = 0.35,
        min = 1,
        max = 1,
        minPower = 4,
        reward = {
            Type = "Gear",
            Value = "Transcendent Bee Egg"
        }
    },
    {
        tier = 5,
        weight = 0.25,
        min = 1,
        max = 1,
        minPower = 5,
        reward = {
            Type = "Seed",
            Value = "Royal Rose"
        }
    },
    {
        tier = 5,
        weight = 0.08,
        min = 1,
        max = 1,
        minPower = 5,
        reward = {
            Type = "Pet",
            Value = "Prince Wasp"
        }
    }
};

function u1.GetPower(p4: string) -- Line: 43
    -- upvalues: u2 (copy)
    return u2[p4] or 1;
end;

function u1.GetBonusRollCount(p5: string) -- Line: 47
    -- upvalues: u1 (copy)
    local v6 = u1.GetPower(p5) / 2;

    return math.floor(v6) + 1;
end;

function u1.GetGuaranteedCoins(p7: string) -- Line: 52
    -- upvalues: u1 (copy)
    local v8 = 35 * u1.GetPower(p7);

    return math.round(v8);
end;

function u1.GetQuantityScale(p9: string) -- Line: 57
    -- upvalues: u1 (copy)
    return 1 + 0.25 * (u1.GetPower(p9) - 1);
end;

function u1.GetLuck(p10: string, p11: number?) -- Line: 62
    -- upvalues: u1 (copy)
    return 1 + 0.2 * (u1.GetPower(p10) - 1) + (p11 or 0);
end;

function u1.GetWeightedEntries(p12: string, p13: number?) -- Line: 67
    -- upvalues: u1 (copy), u3 (copy)
    local Power = u1.GetPower(p12);
    local Luck = u1.GetLuck(p12, p13);
    local v14 = 0;
    local v15 = {};

    for _, v in u3 do
        if not v.minPower or Power >= v.minPower then
            local v16 = v.weight * (1 + (Luck - 1) * v.tier);

            if v16 > 0 then
                v14 = v14 + v16;
                table.insert(v15, {
                    Entry = v,
                    Weight = v16
                });
            end;
        end;
    end;

    return v15, v14;
end;

function u1.GetOdds(p17: string, p18: number?) -- Line: 93
    -- upvalues: u1 (copy)
    local WeightedEntries, v19 = u1.GetWeightedEntries(p17, p18);
    local BonusRollCount = u1.GetBonusRollCount(p17);
    local v20 = {};

    if v19 <= 0 then
        return v20;
    end;

    for _, v in WeightedEntries do
        local Entry = v.Entry;
        local v21 = v.Weight / v19;
        table.insert(v20, {
            Type = Entry.reward.Type,
            Value = Entry.reward.Value,
            Tier = Entry.tier,
            Min = Entry.min,
            Max = Entry.max,
            PerRollChance = v21,
            PerCrateChance = 1 - (1 - v21) ^ BonusRollCount,
            EffectiveWeight = v.Weight
        });
    end;

    table.sort(v20, function(p22, p23) -- Line: 120
        if p22.Tier == p23.Tier then
            return p22.PerCrateChance > p23.PerCrateChance;
        end;

        return p22.Tier < p23.Tier;
    end);

    return v20;
end;

local u24 = {
    [0] = 1,
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 4,
    [5] = 4
};

function u1.GetRewardTier(p25: string, p26: string) -- Line: 134
    -- upvalues: u3 (copy)
    for _, v in u3 do
        if v.reward.Type == p25 and v.reward.Value == p26 then
            return v.tier;
        end;
    end;

    return 0;
end;

function u1.GetChestTier(p27: table) -- Line: 143
    -- upvalues: u1 (copy), u24 (copy)
    local v28 = 0;

    for _, v in p27 do
        local RewardTier = u1.GetRewardTier(v.Type, v.Value);

        if v28 < RewardTier then
            v28 = RewardTier;
        end;
    end;

    return u24[v28] or 1;
end;

function u1.GetRewardsTable() -- Line: 154
    -- upvalues: u3 (copy)
    local v29 = {};

    for _, v in u3 do
        table.insert(v29, v.reward);
    end;

    return v29;
end;

return u1;