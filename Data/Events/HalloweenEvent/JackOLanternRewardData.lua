-- Decompiled with Potassium's decompiler.

return {
    RewardSets = { {
            Rewards = { {
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
            Part2Rewards = { {
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
                }, {
                    DisplayName = "Halloween Gear Box",
                    Type = "Seed Pack",
                    Value = "Halloween Gear Box",
                    Quantity = 1,
                    Chance = 5
                } }
        } },

    PickRandom = function(p1) -- Line: 60, Name: PickRandom
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