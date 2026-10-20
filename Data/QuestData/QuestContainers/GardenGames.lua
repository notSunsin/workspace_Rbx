-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local u1 = {
    EasyQuests = NumberRange.new(1),
    MediumQuests = NumberRange.new(2, 3),
    HardQuests = NumberRange.new(3, 4)
};
local u2 = {
    PlayTime = {
        Quests.PlayTime:Use({
            Target = 300
        }),
        Quests.PlayTime:Use({
            Target = 600
        }),
        Quests.PlayTime:Use({
            Target = 900
        }),
        Quests.PlayTime:Use({
            Target = 1800
        })
    },
    EarnSheckles = {
        Quests.EarnSheckles:Use({
            Target = 100000
        }),
        Quests.EarnSheckles:Use({
            Target = 500000
        }),
        Quests.EarnSheckles:Use({
            Target = 1000000
        }),
        Quests.EarnSheckles:Use({
            Target = 2000000
        }),
        Quests.EarnSheckles:Use({
            Target = 10000000
        })
    },
    PlayWithFriend = { Quests.PlayWithFriend:Use({
            Target = 1,
            Arguments = {}
        }) },
    GiftFruitToFriend = { Quests.GiftFruitToFriend:Use({
            Target = 25,
            Arguments = {}
        }) },
    LikeGardens = { Quests.LikeGardens:Use({
            Target = 3,
            Arguments = {}
        }) }
};
local u3 = {
    Quests.Plant:Use({
        Target = 200,
        Arguments = { "Carrot" }
    }),
    Quests.Plant:Use({
        Target = 50,
        Arguments = { "Blueberry" }
    }),
    Quests.Plant:Use({
        Target = 40,
        Arguments = { "Bamboo" }
    }),
    Quests.Plant:Use({
        Target = 30,
        Arguments = { "Daffodil" }
    }),
    Quests.Plant:Use({
        Target = 30,
        Arguments = { "Buttercup" }
    }),
    Quests.Plant:Use({
        Target = 10,
        Arguments = { "Mushroom" }
    }),
    Quests.Plant:Use({
        Target = 5,
        Arguments = { "Pumpkin" }
    }),
    Quests.Plant:Use({
        Target = 5,
        Arguments = { "Watermelon" }
    }),
    Quests.Plant:Use({
        Target = 4,
        Arguments = { "Mango" }
    }),
    Quests.Plant:Use({
        Target = 4,
        Arguments = { "Dragon Fruit" }
    }),
    Quests.Harvest:Use({
        Target = 100,
        Arguments = { "Carrot" }
    }),
    Quests.Harvest:Use({
        Target = 300,
        Arguments = { "Blueberry" }
    }),
    Quests.Harvest:Use({
        Target = 100,
        Arguments = { "Corn" }
    }),
    Quests.Harvest:Use({
        Target = 100,
        Arguments = { "Bamboo" }
    }),
    Quests.Harvest:Use({
        Target = 150,
        Arguments = { "Tomato" }
    }),
    Quests.Harvest:Use({
        Target = 75,
        Arguments = { "Apple" }
    }),
    Quests.Harvest:Use({
        Target = 40,
        Arguments = { "Cactus" }
    }),
    Quests.Harvest:Use({
        Target = 30,
        Arguments = { "Buttercup" }
    }),
    Quests.Harvest:Use({
        Target = 50,
        Arguments = { "Mango" }
    }),
    Quests.Harvest:Use({
        Target = 30,
        Arguments = { "Daffodil" }
    })
};
local u4 = {
    Quests.Plant:Use({
        Target = 10,
        Arguments = { "Carrot" }
    }),
    Quests.Plant:Use({
        Target = 2,
        Arguments = { "Blueberry" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Strawberry" }
    }),
    Quests.Harvest:Use({
        Target = 20,
        Arguments = { "Blueberry" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Carrot" }
    })
};

return {
    Type = "GardenGames",
    IsIndividual = true,
    CustomData = {},

    Display = function(p5) -- Line: 272, Name: Display
        return "Garden Games Quest";
    end,

    Generate = function(p6, p7) -- Line: 276, Name: Generate
        -- upvalues: u2 (copy), QuestRewards (copy), u1 (copy), u4 (copy), u3 (copy)
        local Random_new_ret = Random.new();
        local v8 = {};
        local v9 = {};

        for _, v in u2 do
            local v10 = v[Random_new_ret:NextInteger(1, #v)];
            table.insert(v8, v10);
        end;

        local table_clone_ret = table.clone(v8);
        local v11 = table_clone_ret[Random_new_ret:NextInteger(1, #table_clone_ret)];
        v11.Rewards = { QuestRewards.Currency:Use({
                Type = "CarrotCoins",
                Amount = Random_new_ret:NextInteger(u1.HardQuests.Min, u1.HardQuests.Max)
            }) };
        table.insert(v9, v11);
        local table_clone_ret2 = table.clone(u4);
        local v12 = table_clone_ret2[Random_new_ret:NextInteger(1, #table_clone_ret2)];
        v12.Rewards = { QuestRewards.Currency:Use({
                Type = "CarrotCoins",
                Amount = Random_new_ret:NextInteger(u1.EasyQuests.Min, u1.EasyQuests.Max)
            }) };
        table.insert(v9, v12);
        local table_clone_ret3 = table.clone(u3);

        for i = 1, 3 do
            local v13 = Random_new_ret:NextInteger(1, #table_clone_ret3);
            local v14 = table_clone_ret3[v13];
            v14.Rewards = { QuestRewards.Currency:Use({
                    Type = "CarrotCoins",
                    Amount = Random_new_ret:NextInteger(u1.MediumQuests.Min, u1.MediumQuests.Max)
                }) };
            table.remove(table_clone_ret3, v13);
            table.insert(v9, v14);
            local _ = i;
        end;

        return {
            Quests = v9,
            Rewards = type(p7) ~= "function" and {} or p7({
                type = "rewards"
            })
        };
    end
};