-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
require(ReplicatedStorage.Modules.UpdateService);
local v1 = {
    Common = { 100, 50, 25 },
    Uncommon = { 50, 25, 10 },
    Rare = { 25, 10, 5 },
    Legendary = { 10, 5, 3 },
    Mythical = { 1 }
};
local u2 = {
    Quests.PlayTime:Use({
        Target = 600
    }),
    Quests.PlayTime:Use({
        Target = 900
    }),
    Quests.PlayTime:Use({
        Target = 1800
    }),
    Quests.EarnSheckles:Use({
        Target = 15000
    }),
    Quests.EarnSheckles:Use({
        Target = 25000
    }),
    Quests.EarnSheckles:Use({
        Target = 50000
    }),
    Quests.EarnSheckles:Use({
        Target = 100000
    }),
    Quests.HarvestMutation:Use({
        Target = 1,
        Arguments = { "Wet" }
    }),
    Quests.HarvestMutation:Use({
        Target = 2,
        Arguments = { "Wet" }
    }),
    Quests.HarvestMutation:Use({
        Target = 3,
        Arguments = { "Wet" }
    }),
    Quests.Craft:Use({
        Target = 1,
        Arguments = { "Gear", "Lightning Rod" }
    }),
    Quests.Plant:Use({
        Target = v1.Common[1],
        Arguments = { "Carrot" }
    }),
    Quests.Plant:Use({
        Target = v1.Common[2],
        Arguments = { "Carrot" }
    }),
    Quests.Plant:Use({
        Target = v1.Common[1],
        Arguments = { "Strawberry" }
    }),
    Quests.Plant:Use({
        Target = v1.Common[2],
        Arguments = { "Strawberry" }
    }),
    Quests.Plant:Use({
        Target = v1.Uncommon[1],
        Arguments = { "Blueberry" }
    }),
    Quests.Plant:Use({
        Target = v1.Uncommon[2],
        Arguments = { "Blueberry" }
    }),
    Quests.Plant:Use({
        Target = 12,
        Arguments = { "Tomato" }
    }),
    Quests.Plant:Use({
        Target = 12,
        Arguments = { "Corn" }
    }),
    Quests.Plant:Use({
        Target = 14,
        Arguments = { "Daffodil" }
    }),
    Quests.Plant:Use({
        Target = 5,
        Arguments = { "Watermelon" }
    }),
    Quests.Plant:Use({
        Target = 5,
        Arguments = { "Pumpkin" }
    }),
    Quests.Plant:Use({
        Target = 5,
        Arguments = { "Apple" }
    }),
    Quests.Plant:Use({
        Target = 25,
        Arguments = { "Bamboo" }
    }),
    Quests.Plant:Use({
        Target = 1,
        Arguments = { "Coconut" }
    }),
    Quests.Plant:Use({
        Target = 2,
        Arguments = { "Cactus" }
    }),
    Quests.Plant:Use({
        Target = 2,
        Arguments = { "Dragon Fruit" }
    }),
    Quests.Plant:Use({
        Target = 2,
        Arguments = { "Mango" }
    }),
    Quests.Harvest:Use({
        Target = v1.Common[1],
        Arguments = { "Carrot" }
    }),
    Quests.Harvest:Use({
        Target = v1.Common[2],
        Arguments = { "Carrot" }
    }),
    Quests.Harvest:Use({
        Target = v1.Common[1],
        Arguments = { "Strawberry" }
    }),
    Quests.Harvest:Use({
        Target = v1.Common[2],
        Arguments = { "Strawberry" }
    }),
    Quests.Harvest:Use({
        Target = v1.Uncommon[1],
        Arguments = { "Blueberry" }
    }),
    Quests.Harvest:Use({
        Target = v1.Uncommon[2],
        Arguments = { "Blueberry" }
    }),
    Quests.Harvest:Use({
        Target = 30,
        Arguments = { "Tomato" }
    }),
    Quests.Harvest:Use({
        Target = 20,
        Arguments = { "Corn" }
    }),
    Quests.Harvest:Use({
        Target = 14,
        Arguments = { "Daffodil" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Watermelon" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Pumpkin" }
    }),
    Quests.Harvest:Use({
        Target = 25,
        Arguments = { "Apple" }
    }),
    Quests.Harvest:Use({
        Target = 30,
        Arguments = { "Bamboo" }
    }),
    Quests.Harvest:Use({
        Target = 50,
        Arguments = { "Coconut" }
    }),
    Quests.Harvest:Use({
        Target = 10,
        Arguments = { "Cactus" }
    }),
    Quests.Harvest:Use({
        Target = 25,
        Arguments = { "Dragon Fruit" }
    }),
    Quests.Harvest:Use({
        Target = 25,
        Arguments = { "Mango" }
    })
};
local u3 = {
    { QuestRewards["Seed Pack"]:Use({
            Amount = 1,
            Type = "Normal"
        }) },
    {
        QuestRewards.Gear:Use({
            Type = "Watering Can",
            Amount = 10
        }),
        QuestRewards.Gear:Use({
            Type = "Advanced Sprinkler",
            Amount = 3
        }),
        QuestRewards.Gear:Use({
            Type = "Reclaimer",
            Amount = 5
        }),
        QuestRewards.Gear:Use({
            Type = "Recall Wrench",
            Amount = 5
        })
    },
    { QuestRewards["Seed Pack"]:Use({
            Amount = 2,
            Type = "Normal"
        }) },
    { QuestRewards.RandomSeed:Use({
            Amount = 1,
            Type = "Random Seed"
        }) },
    { QuestRewards["Seed Pack"]:Use({
            Amount = 2,
            Type = "Normal"
        }) },
    {
        QuestRewards.Gear:Use({
            Type = "Watering Can",
            Amount = 20
        }),
        QuestRewards.Gear:Use({
            Type = "Master Sprinkler",
            Amount = 1
        }),
        QuestRewards.Gear:Use({
            Type = "Tanning Mirror",
            Amount = 1
        }),
        QuestRewards.Gear:Use({
            Type = "Lightning Rod",
            Amount = 1
        }),
        QuestRewards.Gear:Use({
            Type = "Harvest Tool",
            Amount = 5
        })
    },
    { QuestRewards["Seed Pack"]:Use({
            Type = "Gardener Seed Pack",
            Amount = 1
        }) }
};

return {
    Type = "Daily",
    CustomData = {
        GenerateRewardsForDay = function(p4: number, p5: number, p6: boolean) -- Line: 412, Name: GenerateRewardsForDay
            -- upvalues: u3 (copy)
            local Random_new_ret = Random.new();
            local table_clone_ret = table.clone(u3[p4]);
            local v7 = {};

            if not table_clone_ret then
                error("DAILY QUEST CONTAINER | GenerateRewardsForDay: No rewards set up for day " .. p4);

                return {};
            end;

            local v8 = p5 == -1 and #table_clone_ret or p5;

            if #table_clone_ret < v8 and p6 then
                error("DAILY QUEST CONTAINER | GenerateRewardsForDay: Not enough rewards to avoid duplicates for daily quests day " .. p4);

                return {};
            end;

            for i = 1, v8 do
                local v9 = Random_new_ret:NextInteger(1, #table_clone_ret);
                table.insert(v7, table_clone_ret[v9]);
                local v10;

                if p6 then
                    table.remove(table_clone_ret, v9);
                    v10 = i;
                else
                    v10 = i;
                end;
            end;

            return v7;
        end
    },

    Display = function(p11) -- Line: 453, Name: Display
        return "Daily Quests";
    end,

    Generate = function(p12, p13) -- Line: 457, Name: Generate
        -- upvalues: u2 (copy)
        local Random_new_ret = Random.new();
        local table_create_ret = table.create(6);
        local table_clone_ret = table.clone(u2);
        Random_new_ret:Shuffle(table_clone_ret);

        for i = 1, 6 do
            table_create_ret[i] = table.remove(table_clone_ret, 1) or u2[Random_new_ret:NextInteger(1, #u2)];
            local _ = i;
        end;

        return {
            Quests = table_create_ret,
            Rewards = type(p13) ~= "function" and {} or p13()
        };
    end
};