-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local PickRandom = require(ReplicatedStorage.Modules.PickRandom);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local Types = GiveServiceCommon.Types;
local u1 = {
    [5] = {
        Common = 50,
        Uncommon = 30,
        Rare = 20,
        Legendary = 10
    },
    [10] = {
        Common = 30,
        Uncommon = 50,
        Rare = 20,
        Legendary = 10
    },
    [15] = {
        Common = 30,
        Uncommon = 30,
        Rare = 30,
        Legendary = 10
    },
    [20] = {
        Common = 10,
        Uncommon = 30,
        Rare = 30,
        Legendary = 20
    }
};
local u2 = {
    Common = {
        ExtraChance = 0.5,
        AlwaysGiveOne = {
            {
                Type = "GiveItem",
                Chance = 100,
                Reward = Types.Gear:Use("Common Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 30,
                Reward = Types.Gear:Use("Rare Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 10,
                Reward = Types.Gear:Use("Legendary Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 10,
                Reward = Types.Gear:Use("Dig Trinket", 1)
            },
            {
                Type = "GiveItem",
                Chance = 5,
                Reward = Types.Gear:Use("Divine Coal", 1)
            }
        },
        PossibleExtras = {}
    },
    Uncommon = {
        ExtraChance = 0.01,
        AlwaysGiveOne = {
            {
                Type = "GiveItem",
                Chance = 100,
                Reward = Types.Gear:Use("Common Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 30,
                Reward = Types.Gear:Use("Rare Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 10,
                Reward = Types.Gear:Use("Legendary Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 10,
                Reward = Types.Gear:Use("Dig Trinket", 1)
            },
            {
                Type = "GiveItem",
                Chance = 5,
                Reward = Types.Gear:Use("Divine Coal", 1)
            }
        },
        PossibleExtras = { {
                Type = "Weather",
                WeatherName = "Thunderstorm",
                Chance = 1
            }, {
                Type = "Weather",
                WeatherName = "SmithingFever",
                Chance = 7
            }, {
                Type = "Weather",
                WeatherName = "Rain",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Heatwave",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Sandstorm",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Gale",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "SmithingStorm",
                Chance = 10
            } }
    },
    Rare = {
        ExtraChance = 0.05,
        AlwaysGiveOne = {
            {
                Type = "GiveItem",
                Chance = 100,
                Reward = Types.Gear:Use("Common Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 30,
                Reward = Types.Gear:Use("Rare Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 10,
                Reward = Types.Gear:Use("Legendary Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 10,
                Reward = Types.Gear:Use("Dig Trinket", 1)
            },
            {
                Type = "GiveItem",
                Chance = 5,
                Reward = Types.Gear:Use("Divine Coal", 1)
            }
        },
        PossibleExtras = { {
                Type = "Weather",
                WeatherName = "Thunderstorm",
                Chance = 1
            }, {
                Type = "Weather",
                WeatherName = "SmithingFever",
                Chance = 7
            }, {
                Type = "Weather",
                WeatherName = "Rain",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Heatwave",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Sandstorm",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Gale",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "SmithingStorm",
                Chance = 10
            } }
    },
    Legendary = {
        ExtraChance = 0.08,
        AlwaysGiveOne = {
            {
                Type = "GiveItem",
                Chance = 100,
                Reward = Types.Gear:Use("Common Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 30,
                Reward = Types.Gear:Use("Rare Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 10,
                Reward = Types.Gear:Use("Legendary Coal", 1)
            },
            {
                Type = "GiveItem",
                Chance = 10,
                Reward = Types.Gear:Use("Dig Trinket", 1)
            },
            {
                Type = "GiveItem",
                Chance = 5,
                Reward = Types.Gear:Use("Divine Coal", 1)
            }
        },
        PossibleExtras = { {
                Type = "Weather",
                WeatherName = "Thunderstorm",
                Chance = 1
            }, {
                Type = "Weather",
                WeatherName = "SmithingFever",
                Chance = 7
            }, {
                Type = "Weather",
                WeatherName = "Rain",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Heatwave",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Sandstorm",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "Gale",
                Chance = 2
            }, {
                Type = "Weather",
                WeatherName = "SmithingStorm",
                Chance = 10
            } }
    }
};
local u3 = {
    {
        {
            Type = "GiveItem",
            Chance = 100,
            Reward = Types.Egg:Use("Common Egg", 10)
        }
    },
    {
        {
            Type = "GiveItem",
            Chance = 100,
            Reward = Types.Egg:Use("Common Egg", 20)
        }
    },
    {
        {
            Type = "GiveItem",
            Chance = 100,
            Reward = Types.Egg:Use("Common Egg", 30)
        }
    },
    {
        {
            Type = "GiveItem",
            Chance = 100,
            Reward = Types.Egg:Use("Common Egg", 40)
        }
    }
};

local function GetRarityWeights(p4: number) -- Line: 369
    -- upvalues: u1 (copy)
    local v5 = -1;

    for i, v in u1 do
        if v5 < i then
            v5 = i;
        end;

        if p4 <= i then
            return v;
        end;
    end;

    return u1[v5];
end;

local function PickRandomRarity(p6: table) -- Line: 385
    local v7 = 0;

    for _, v in pairs(p6) do
        v7 = v7 + v;
    end;

    local v8 = Random.new():NextNumber(0, v7);
    local v9 = 0;

    for i, v in pairs(p6) do
        v9 = v9 + v;

        if v8 <= v9 then
            return i;
        end;
    end;

    return "Common";
end;

return {
    RewardsData = u2,

    PickReward = function(p10: table, p11: number) -- Line: 412, Name: PickReward
        -- upvalues: u1 (copy), PickRandomRarity (copy), u2 (copy), PickRandom (copy)
        local v12 = -1;
        local v13;

        for i, v in u1 do
            if v12 < i then
                v12 = i;
            end;

            if p11 <= i then
                v13 = v;
                break;
            end;
        end;

        v13 = u1[v12];
        local v14 = u2[PickRandomRarity(v13)];
        local v15 = { PickRandom.One(v14.AlwaysGiveOne) };

        if #v14.PossibleExtras > 0 and Random.new():NextNumber(0, 1) <= v14.ExtraChance then
            local v16 = PickRandom.One(v14.PossibleExtras);
            table.insert(v15, v16);
        end;

        return v15;
    end,

    PickStationReward = function(p17: table, p18: number) -- Line: 436, Name: PickStationReward
        -- upvalues: CountDictionary (copy), u3 (copy), PickRandom (copy)
        if p18 >= 0 and CountDictionary(u3) >= p18 then
            return PickRandom.One(u3[p18]).Reward;
        end;

        warn((`SmithingEventRewardData:PickStationReward | Cannot find Station Index {p18}`));

        return nil;
    end
};