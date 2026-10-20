-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);

return {
    RewardSets = {
        Default = {
            {
                Value = "Fall Seed Pack",
                Type = "Seed Pack",
                Quantity = 1,
                Chance = 50
            },
            {
                Value = "Fall Egg",
                Type = "Egg",
                Quantity = 1,
                Chance = 50
            },
            {
                Value = "Fall Crate",
                Type = "Crate",
                Quantity = 1,
                Chance = 30
            },
            {
                Value = "Maple Crate",
                Type = "Crate",
                Quantity = 1,
                Chance = 10
            },
            {
                Value = "Maple Sprinkler",
                Type = "Gear",
                Quantity = 1,
                Chance = 10
            },
            {
                Value = "Rake",
                Type = "Gear",
                Quantity = 10,
                Chance = 10
            },
            {
                Value = "Pet Lead",
                Type = "Gear",
                Quantity = 5,
                Chance = 10
            },
            {
                Value = "Pet Name Reroller",
                Type = "Gear",
                Quantity = 5,
                Chance = 10
            },
            {
                Value = "Reclaimer",
                Type = "Gear",
                Quantity = 10,
                Chance = 5
            },
            {
                Value = "Sheckles",
                Type = "Currency",
                Quantity = 100000,
                Chance = 5
            },
            {
                Value = "Super Leaf Blower",
                Type = "Gear",
                ItemAmount = 1,
                Chance = 3
            },
            {
                Value = "Super Watering Can",
                Type = "Gear",
                ItemAmount = 1,
                Chance = 1
            },
            {
                Value = "Pet Shard Silver",
                Type = "Gear",
                ItemAmount = 1,
                Chance = 1
            },
            {
                Value = "Silver Fertilizer",
                Type = "Gear",
                ItemAmount = 1,
                Chance = 1
            }
        },
        Set2 = { {
                Value = "Bone Blossom",
                Type = "Seed",
                ItemAmount = 1000,
                Chance = 10
            } }
    },

    PickRandom = function(p1) -- Line: 106, Name: PickRandom
        local v2 = 0;

        for _, v in p1 do
            v2 = v2 + (v.Chance or 1);
        end;

        local v3 = Random.new():NextNumber() * v2;
        local v4 = 0;

        for _, v in p1 do
            v4 = v4 + (v.Chance or 1);

            if v3 <= v4 then
                return v;
            end;
        end;
    end
};