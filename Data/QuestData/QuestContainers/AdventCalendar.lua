-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local AdventCalendarConfigData = require(ReplicatedStorage.Data.ChristmasEvent.AdventCalendarConfigData);
local u1 = {
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
local u2 = {
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

return {
    Type = "AdventCalendar",
    CustomData = {},

    Display = function(p3) -- Line: 230, Name: Display
        return "Advent Calendar";
    end,

    Generate = function(p4, p5) -- Line: 234, Name: Generate
        -- upvalues: AdventCalendarConfigData (copy), u2 (copy), u1 (copy)
        local DAILY_QUEST_COUNT = AdventCalendarConfigData.DAILY_QUEST_COUNT;
        local Random_new_ret = Random.new();
        local v6 = {};
        local v7 = {};

        for _, v in u2 do
            table.insert(v6, v);
        end;

        for _, v in u1 do
            local v8 = v[Random_new_ret:NextNumber(1, #v)];
            table.insert(v6, v8);
        end;

        for i = 1, math.min(DAILY_QUEST_COUNT, #v6) do
            local v9 = Random_new_ret:NextInteger(1, #v6);
            table.insert(v7, v6[v9]);
            table.remove(v6, v9);
            local _ = i;
        end;

        return {
            Quests = v7,
            Rewards = type(p5) ~= "function" and {} or p5({
                type = "rewards"
            })
        };
    end
};