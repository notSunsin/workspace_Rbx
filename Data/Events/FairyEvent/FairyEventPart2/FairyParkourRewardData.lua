-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);

return {
    RewardSets = { {
            Rewards = { {
                    Value = "FairyPoints",
                    Type = "Currency",
                    Quantity = 500,
                    Chance = 13
                }, {
                    Value = "Event Lantern",
                    Type = "Gear",
                    Quantity = 5,
                    Chance = 12
                }, {
                    Value = "Fairy Net",
                    Type = "Gear",
                    Quantity = 3,
                    Chance = 11
                }, {
                    Value = "Reclaimer",
                    Type = "Gear",
                    Quantity = 3,
                    Chance = 10
                }, {
                    Value = "Enchanted Seed Pack",
                    Type = "Seed Pack",
                    Quantity = 1,
                    Chance = 9
                }, {
                    Value = "Mutation Spray Glimmering",
                    Type = "Gear",
                    Quantity = 3,
                    Chance = 8
                }, {
                    Value = "Enchanted Crate",
                    Type = "Crate",
                    Quantity = 1,
                    Chance = 6
                }, {
                    Value = "Glimmering Crate",
                    Type = "Crate",
                    Quantity = 1,
                    Chance = 4
                }, {
                    Value = "Enchanted Egg",
                    Type = "Egg",
                    Quantity = 1,
                    Chance = 2
                }, {
                    Value = "Enchanted Chest",
                    Type = "Seed Pack",
                    Quantity = 1,
                    Chance = 1
                } }
        } },

    PickRandom = function(p1) -- Line: 74, Name: PickRandom
        local v2 = 0;

        for _, v in p1 do
            v2 = v2 + (v.Chance or 1);
        end;

        local v3 = math.random() * v2;
        local v4 = 0;

        for _, v in p1 do
            v4 = v4 + (v.Chance or 1);

            if v3 <= v4 then
                return v;
            end;
        end;
    end
};