-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.Events.HalloweenEvent.WitchesBrewTypes);

return {
    Rewards = { {
            DisplayName = "Spooky Egg",
            Type = "Egg",
            Value = "Spooky Egg",
            Quantity = 1,
            Chance = 10
        }, {
            DisplayName = "Pumpkin Crate",
            Type = "Crate",
            Value = "Pumpkin Crate",
            Quantity = 1,
            Chance = 10
        } },
    Part2Rewards = { {
            DisplayName = "Spooky Egg",
            Type = "Egg",
            Value = "Spooky Egg",
            Quantity = 1,
            Chance = 10
        }, {
            DisplayName = "Pumpkin Crate",
            Type = "Crate",
            Value = "Pumpkin Crate",
            Quantity = 1,
            Chance = 10
        }, {
            DisplayName = "Halloween Gear Box",
            Type = "Seed Pack",
            Value = "Halloween Gear Box",
            Quantity = 1,
            Chance = 10
        } },
    TopContributorRewards = { {
            DisplayName = "Spooky Egg",
            Type = "Egg",
            Value = "Spooky Egg",
            Quantity = 2,
            Chance = 5
        }, {
            DisplayName = "Pumpkin Crate",
            Type = "Crate",
            Value = "Pumpkin Crate",
            Quantity = 2,
            Chance = 5
        } },

    PickRandom = function(p1) -- Line: 71, Name: PickRandom
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

        return nil;
    end,

    RandomCurrency = function(p5: number) -- Line: 89, Name: RandomCurrency
        return {
            DisplayName = "Candy Corn",
            Type = "Currency",
            Value = "CandyCorn",
            Quantity = math.random(10 * (p5 or 1), 20 * (p5 or 1))
        };
    end
};