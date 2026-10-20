-- Decompiled with Potassium's decompiler.

local v1 = {
    MaxWeight = 0,
    ValidPetTypes = {
        ["Chubby Chipmunk"] = true
    },
    RewardBrackets = {
        {
            Weight = 1.25,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 1
            }
        },
        {
            Weight = 1.5,
            Reward = {
                Type = "Crate",
                Value = "Nutty Crate",
                Quantity = 1
            }
        },
        {
            Weight = 1.75,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 1
            }
        },
        {
            Weight = 2,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 1
            }
        },
        {
            Weight = 2.15,
            Reward = {
                Type = "Gear",
                Value = "Energy Chew",
                Quantity = 1
            }
        },
        {
            Weight = 2.53,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 1
            }
        },
        {
            Weight = 3.1,
            Reward = {
                Type = "Crate",
                Value = "Nutty Crate",
                Quantity = 1
            }
        },
        {
            Weight = 3.86,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 1
            }
        },
        {
            Weight = 4.78,
            Reward = {
                Type = "Crate",
                Value = "Nutty Crate",
                Quantity = 1
            }
        },
        {
            Weight = 5.88,
            Reward = {
                Type = "Seed",
                Value = "Acorn Squash",
                Quantity = 1
            }
        },
        {
            Weight = 7.13,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 1
            }
        },
        {
            Weight = 8.53,
            Reward = {
                Type = "Cosmetic",
                Value = "Acorn Mirror",
                Quantity = 1
            }
        },
        {
            Weight = 10.09,
            Reward = {
                Type = "Crate",
                Value = "Nutty Crate",
                Quantity = 1
            }
        },
        {
            Weight = 11.8,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 2
            }
        },
        {
            Weight = 13.65,
            Reward = {
                Type = "Gear",
                Value = "Energy Chew",
                Quantity = 1
            }
        },
        {
            Weight = 15.64,
            Reward = {
                Type = "Crate",
                Value = "Nutty Crate",
                Quantity = 2
            }
        },
        {
            Weight = 17.77,
            Reward = {
                Type = "Cosmetic",
                Value = "Acorn Rug",
                Quantity = 1
            }
        },
        {
            Weight = 20.05,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 2
            }
        },
        {
            Weight = 22.45,
            Reward = {
                Type = "Crate",
                Value = "Nutty Crate",
                Quantity = 2
            }
        },
        {
            Weight = 24.99,
            Reward = {
                Type = "Seed",
                Value = "Ferntail",
                Quantity = 1
            }
        },
        {
            Weight = 27.67,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 2
            }
        },
        {
            Weight = 30.48,
            Reward = {
                Type = "Pet",
                Value = "Hyrax",
                Quantity = 1
            }
        },
        {
            Weight = 33.41,
            Reward = {
                Type = "Cosmetic",
                Value = "Acorn Table",
                Quantity = 1
            }
        },
        {
            Weight = 36.48,
            Reward = {
                Type = "Gear",
                Value = "Energy Chew",
                Quantity = 1
            }
        },
        {
            Weight = 39.67,
            Reward = {
                Type = "Seed Pack",
                Value = "Nutty Chest",
                Quantity = 4
            }
        },
        {
            Weight = 42.99,
            Reward = {
                Type = "Crate",
                Value = "Nutty Crate",
                Quantity = 4
            }
        },
        {
            Weight = 46.43,
            Reward = {
                Type = "Pet",
                Value = "Fortune Squirrel",
                Quantity = 1
            }
        },
        {
            Weight = 50,
            Reward = {
                Type = "Seed",
                Value = "Pecan",
                Quantity = 1
            }
        }
    }
};

for _, v in v1.RewardBrackets do
    if v.Weight > v1.MaxWeight then
        v1.MaxWeight = v.Weight;
    end;
end;

return v1;