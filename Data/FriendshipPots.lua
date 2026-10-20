-- Decompiled with Potassium's decompiler.

return {
    ["Friendship Pot"] = {
        PotType = "Friendship Pot",
        Rewards = {
            Basic = {
                DisplayName = "Basic Reward",
                Description = "Some basic items",
                Chance = 100,
                MinDays = 0,
                MaxDays = (1 / 0),
                ItemCount = NumberRange.new(1, 2),
                Items = {
                    ["Carrot Seeds"] = {
                        ItemName = "Carrot",
                        ItemType = "seed",
                        ItemAmount = NumberRange.new(5, 10)
                    },
                    ["Tomato Seeds"] = {
                        ItemName = "Tomato",
                        ItemType = "seed",
                        ItemAmount = NumberRange.new(2, 3)
                    }
                }
            }
        }
    }
};