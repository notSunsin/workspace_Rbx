-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
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
    SpendCurrency = {
        Quests.SpendCurrency:Use({
            Target = 100000,
            Arguments = { "Sheckles" }
        }),
        Quests.SpendCurrency:Use({
            Target = 500000,
            Arguments = { "Sheckles" }
        }),
        Quests.SpendCurrency:Use({
            Target = 1000000,
            Arguments = { "Sheckles" }
        }),
        Quests.SpendCurrency:Use({
            Target = 2000000,
            Arguments = { "Sheckles" }
        }),
        Quests.SpendCurrency:Use({
            Target = 10000000,
            Arguments = { "Sheckles" }
        })
    },
    SellAnyPlant = {
        Quests.SellAnyPlant:Use({
            Target = 500,
            Arguments = {}
        }),
        Quests.SellAnyPlant:Use({
            Target = 1000,
            Arguments = {}
        }),
        Quests.SellAnyPlant:Use({
            Target = 1500,
            Arguments = {}
        }),
        Quests.SellAnyPlant:Use({
            Target = 2000,
            Arguments = {}
        })
    },
    WaterPlants = {
        Quests.WaterPlants:Use({
            Target = 20,
            Arguments = {}
        }),
        Quests.WaterPlants:Use({
            Target = 35,
            Arguments = {}
        }),
        Quests.WaterPlants:Use({
            Target = 50,
            Arguments = {}
        }),
        Quests.WaterPlants:Use({
            Target = 100,
            Arguments = {}
        })
    },
    AgeAnyPet = {
        Quests.AgeAnyPet:Use({
            Target = 5,
            Arguments = {}
        }),
        Quests.AgeAnyPet:Use({
            Target = 10,
            Arguments = {}
        }),
        Quests.AgeAnyPet:Use({
            Target = 20,
            Arguments = {}
        }),
        Quests.AgeAnyPet:Use({
            Target = 30,
            Arguments = {}
        }),
        Quests.AgeAnyPet:Use({
            Target = 50,
            Arguments = {}
        })
    },
    HarvestAnyMutation = { Quests.HarvestMutation:Use({
            Target = 100,
            Arguments = {}
        }), Quests.HarvestMutation:Use({
            Target = 200,
            Arguments = {}
        }), Quests.HarvestMutation:Use({
            Target = 300,
            Arguments = {}
        }) }
};
local u2 = {
    Quests.FeedAnyPetFood:Use({
        Target = 5,
        Arguments = { "Soup" }
    }),
    Quests.FeedAnyPet:Use({
        Target = 15,
        Arguments = { "Coconut" }
    }),
    Quests.FeedAnyPet:Use({
        Target = 40,
        Arguments = { "Carrot" }
    }),
    Quests.FeedAnyPet:Use({
        Target = 20,
        Arguments = { "Apple" }
    }),
    Quests.FeedAnyPet:Use({
        Target = 5,
        Arguments = { "Pepper" }
    }),
    Quests.FeedAnyPet:Use({
        Target = 10,
        Arguments = { "Mango" }
    }),
    Quests.HarvestMutation:Use({
        Target = 20,
        Arguments = { "Wet" }
    }),
    Quests.HarvestMutation:Use({
        Target = 10,
        Arguments = { "Windstruck" }
    }),
    Quests.HarvestMutation:Use({
        Target = 5,
        Arguments = { "Shocked" }
    }),
    Quests.HarvestMutation:Use({
        Target = 5,
        Arguments = { "Disco" }
    }),
    Quests.HarvestMutation:Use({
        Target = 5,
        Arguments = { "Lightcycle" }
    }),
    Quests.HarvestMutation:Use({
        Target = 5,
        Arguments = { "Voidtouched" }
    }),
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
    }),
    Quests.ObtainPlant:Use({
        Target = 30,
        Arguments = { "Mango" }
    }),
    Quests.ObtainPlant:Use({
        Target = 30,
        Arguments = { "Pepper" }
    }),
    Quests.ObtainPlant:Use({
        Target = 30,
        Arguments = { "Dragon Fruit" }
    }),
    Quests.ObtainPlant:Use({
        Target = 30,
        Arguments = { "Grape" }
    }),
    Quests.ObtainPlant:Use({
        Target = 15,
        Arguments = { "Giant Pinecone" }
    }),
    Quests.ObtainPlant:Use({
        Target = 15,
        Arguments = { "Ember Lily" }
    }),
    Quests.ObtainPlant:Use({
        Target = 3,
        Arguments = { "Romanesco" }
    }),
    Quests.ObtainPlant:Use({
        Target = 1,
        Arguments = { "Crimson Thorn" }
    }),
    Quests.ObtainPlant:Use({
        Target = 25,
        Arguments = { "Beanstalk" }
    }),
    Quests.UseInCooking:Use({
        Target = 10,
        Arguments = { "Corn" }
    }),
    Quests.UseInCooking:Use({
        Target = 10,
        Arguments = { "Strawberry" }
    }),
    Quests.UseInCooking:Use({
        Target = 10,
        Arguments = { "Apple" }
    }),
    Quests.UseInCooking:Use({
        Target = 10,
        Arguments = { "Tomato" }
    }),
    Quests.UseInCooking:Use({
        Target = 3,
        Arguments = { "Elder Strawberry" }
    }),
    Quests.SellPlant:Use({
        Target = 25,
        Arguments = { "Pepper" }
    }),
    Quests.SellPlant:Use({
        Target = 25,
        Arguments = { "Cacao" }
    }),
    Quests.SellPlant:Use({
        Target = 25,
        Arguments = { "Grape" }
    }),
    Quests.SellPlant:Use({
        Target = 40,
        Arguments = { "Bamboo" }
    }),
    Quests.SellPlant:Use({
        Target = 20,
        Arguments = { "Sugar Apple" }
    }),
    Quests.SellPlant:Use({
        Target = 30,
        Arguments = { "Mango" }
    }),
    Quests.SellPlant:Use({
        Target = 30,
        Arguments = { "Mushroom" }
    }),
    Quests.SellPlant:Use({
        Target = 5,
        Arguments = { "Burning Bud" }
    }),
    Quests.SellPlant:Use({
        Target = 5,
        Arguments = { "Elder Strawberry" }
    }),
    Quests.SellPlant:Use({
        Target = 100,
        Arguments = { "Tomato" }
    }),
    Quests.SellPlant:Use({
        Target = 80,
        Arguments = { "Daffodil" }
    }),
    Quests.SellPlant:Use({
        Target = 200,
        Arguments = { "Carrot" }
    }),
    Quests.SellPlant:Use({
        Target = 200,
        Arguments = { "Blueberry" }
    }),
    Quests.PlaceObject:Use({
        Target = 15,
        Arguments = { "Basic Sprinkler" }
    }),
    Quests.PlaceObject:Use({
        Target = 8,
        Arguments = { "Advanced Sprinkler" }
    }),
    Quests.PlaceObject:Use({
        Target = 3,
        Arguments = { "Godly Sprinkler" }
    })
};
local u3 = {
    QuestRewards.Seed:Use({
        Type = "Crimson Thorn",
        Amount = 1
    }),
    QuestRewards.Gear:Use({
        Type = "Rainbow Lollipop",
        Amount = 1
    }),
    QuestRewards.Seed:Use({
        Type = "Burning Bud",
        Amount = 1
    }),
    QuestRewards.Seed:Use({
        Type = "Beanstalk",
        Amount = 1
    }),
    QuestRewards.Seed:Use({
        Type = "Ember Lily",
        Amount = 1
    }),
    QuestRewards.Seed:Use({
        Type = "Sugar Apple",
        Amount = 1
    }),
    QuestRewards.Seed:Use({
        Type = "Giant Pinecone",
        Amount = 1
    }),
    QuestRewards.Seed:Use({
        Type = "Elder Strawberry",
        Amount = 1
    }),
    QuestRewards.Seed:Use({
        Type = "Romanesco",
        Amount = 1
    })
};
local v13 = {
    DisplayName = "Admin Quest",
    Type = "AdminQuest01",
    CustomData = {
        PossibleRewards = u3
    },

    Display = function(p4) -- Line: 567, Name: Display
        return "Admin Quest";
    end,

    Generate = function(p5, p6) -- Line: 571, Name: Generate
        -- upvalues: u2 (copy), u1 (copy), u3 (copy)
        local Random_new_ret = Random.new();
        local v7 = {};
        local v8 = {};

        for _, v in u2 do
            table.insert(v7, v);
        end;

        for _, v in u1 do
            local v9 = v[Random_new_ret:NextNumber(1, #v)];
            table.insert(v7, v9);
        end;

        for i = 1, math.min(30, #v7) do
            local v10 = Random_new_ret:NextInteger(1, #v7);
            table.insert(v8, v7[v10]);
            table.remove(v7, v10);
            local _ = i;
        end;

        local v11 = {
            Quests = v8
        };
        local v12;

        if type(p6) == "function" then
            v12 = p6({
                type = "rewards"
            });
        else
            v12 = { u3[Random_new_ret:NextInteger(1, #u3)] };
        end;

        v11.Rewards = v12;

        return v11;
    end
};

if game:GetService("RunService"):IsClient() and (game:GetService("RunService"):IsStudio() and game:GetService("Players").LocalPlayer.UserId == 9099919347) then
    local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
    print("AdminQuest01 Count: " .. #u2 + CountDictionary(u1));
end;

return v13;