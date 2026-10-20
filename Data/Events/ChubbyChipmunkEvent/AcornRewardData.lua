-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);
local Random_new_ret = Random.new();

return {
    RewardSets = {
        {
            Rewards = {
                {
                    Value = "Watering Can",
                    Type = "Gear",
                    Quantity = 15,
                    Chance = 15
                },
                {
                    Value = "Event Lantern",
                    Type = "Gear",
                    Quantity = 20,
                    Chance = 13
                },
                {
                    Value = "Godly Sprinkler",
                    Type = "Gear",
                    Quantity = 2,
                    Chance = 12
                },
                {
                    Value = "Reclaimer",
                    Type = "Gear",
                    Quantity = 3,
                    Chance = 11
                },
                {
                    Value = "Legendary Egg",
                    Type = "Egg",
                    Quantity = 1,
                    Chance = 12
                },
                {
                    Value = "Nutty Crate",
                    Type = "Crate",
                    Quantity = 1,
                    Chance = 9
                },
                {
                    Value = "Silver Fertilizer",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 7
                },
                {
                    Value = "Nutty Chest",
                    Type = "Seed Pack",
                    Quantity = 1,
                    Chance = 6
                },
                {
                    Value = "Master Sprinkler",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 5.5
                },
                {
                    Value = "Medium Treat",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 3.5
                },
                {
                    Value = "Medium Toy",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 3.5
                },
                {
                    Value = "Mythical Egg",
                    Type = "Egg",
                    Quantity = 1,
                    Chance = 3
                },
                {
                    Value = "Nutty Chest",
                    Type = "Seed Pack",
                    Quantity = 2,
                    Chance = 2.5
                },
                {
                    Value = "Grandmaster Sprinkler",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 2.5
                },
                {
                    Value = "Rainbow Fertilizer",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 0.5
                },
                {
                    Value = "Pet Shard Nutty",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 0.25
                }
            }
        },
        {
            Rewards = { {
                    Value = "Watering Can",
                    Type = "Gear",
                    Quantity = 5,
                    Chance = 15
                }, {
                    Value = "Event Lantern",
                    Type = "Gear",
                    Quantity = 3,
                    Chance = 13
                }, {
                    Value = "Harvest Tool",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 11
                }, {
                    Value = "Reclaimer",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 9
                }, {
                    Value = "Godly Sprinkler",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 4
                }, {
                    Value = "Small Treat",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 2
                }, {
                    Value = "Small Toy",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 2
                }, {
                    Value = "Silver Fertilizer",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 1.5
                }, {
                    Value = "Master Sprinkler",
                    Type = "Gear",
                    Quantity = 1,
                    Chance = 1
                } }
        }
    },

    PickRandom = function(p1) -- Line: 173, Name: PickRandom
        -- upvalues: Random_new_ret (copy)
        local v2 = 0;

        for _, v in p1 do
            v2 = v2 + (v.Chance or 1);
        end;

        local v3 = Random_new_ret:NextNumber(0, v2);
        local v4 = 0;

        for _, v in p1 do
            v4 = v4 + (v.Chance or 1);

            if v3 <= v4 then
                return v;
            end;
        end;

        return p1[1];
    end
};