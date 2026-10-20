-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
local v1 = {
    EasyQuest = {
        Reward = 10,
        AmountNeeded = 10
    },
    MediumQuest = {
        Reward = 30,
        AmountNeeded = 100
    },
    HardQuest = {
        Reward = 100,
        AmountNeeded = 500
    },
    DifficultQuest = {
        Reward = 200,
        AmountNeeded = 1
    }
};
local u2 = {
    Blue = "rbxassetid://70614580063601",
    Yellow = "rbxassetid://140145827611170",
    Red = "rbxassetid://104646552588332",
    Green = "rbxassetid://72696569776868",
    Purple = "rbxassetid://86645379012923",
    White = "rbxassetid://127731449292254",
    Black = "rbxassetid://115430433208619"
};
local u3 = {
    Quests.HarvestButtercup:Use({
        Target = v1.EasyQuest.AmountNeeded,
        Arguments = { "Blue" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.EasyQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.EasyQuest.AmountNeeded,
        Arguments = { "Red" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.EasyQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.EasyQuest.AmountNeeded,
        Arguments = { "Yellow" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.EasyQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.EasyQuest.AmountNeeded,
        Arguments = { "Purple" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.EasyQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.EasyQuest.AmountNeeded,
        Arguments = { "Green" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.EasyQuest.Reward
            }) }
    })
};
local u4 = {
    Quests.HarvestButtercup:Use({
        Target = v1.MediumQuest.AmountNeeded,
        Arguments = { "Blue" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.MediumQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.MediumQuest.AmountNeeded,
        Arguments = { "Red" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.MediumQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.MediumQuest.AmountNeeded,
        Arguments = { "Yellow" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.MediumQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.MediumQuest.AmountNeeded,
        Arguments = { "Purple" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.MediumQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.MediumQuest.AmountNeeded,
        Arguments = { "Green" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.MediumQuest.Reward
            }) }
    })
};
local u5 = {
    Quests.HarvestButtercup:Use({
        Target = v1.HardQuest.AmountNeeded,
        Arguments = { "Blue" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.HardQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.HardQuest.AmountNeeded,
        Arguments = { "Red" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.HardQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.HardQuest.AmountNeeded,
        Arguments = { "Yellow" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.HardQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.HardQuest.AmountNeeded,
        Arguments = { "Purple" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.HardQuest.Reward
            }) }
    }),
    Quests.HarvestButtercup:Use({
        Target = v1.HardQuest.AmountNeeded,
        Arguments = { "Green" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.HardQuest.Reward
            }) }
    })
};
local u6 = { Quests.HarvestButtercup:Use({
        Target = v1.DifficultQuest.AmountNeeded,
        Arguments = { "Black" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.DifficultQuest.Reward
            }) }
    }), Quests.HarvestButtercup:Use({
        Target = v1.DifficultQuest.AmountNeeded,
        Arguments = { "White" },
        Rewards = { QuestRewards.Currency:Use({
                Type = "ButtercupCoins",
                Amount = v1.DifficultQuest.Reward
            }) }
    }) };

return {
    Type = "ButtercupEvent",
    IsIndividual = true,
    CustomData = {},

    Display = function(p7) -- Line: 265, Name: Display
        return "Buttercup Quest";
    end,

    Generate = function(p8, p9) -- Line: 269, Name: Generate
        -- upvalues: u3 (copy), u4 (copy), u5 (copy), u6 (copy), u2 (copy)
        local u10 = {};
        local Random_new_ret = Random.new();

        local function GetColor(p11) -- Line: 279
            return p11.Arguments and p11.Arguments[1];
        end;

        local v12 = {
            u3,
            u4,
            u5,
            u6
        };

        local function PickFromTier(p13) -- Line: 284
            -- upvalues: u10 (copy), Random_new_ret (copy)
            local v14 = {};

            for _, v in p13 do
                if not u10[v.Arguments and v.Arguments[1]] then
                    table.insert(v14, v);
                end;
            end;

            if #v14 == 0 then
                return nil;
            end;

            local v15 = v14[Random_new_ret:NextInteger(1, #v14)];
            u10[v15.Arguments and v15.Arguments[1]] = true;

            return v15;
        end;

        local v16 = {};

        for _, v in v12 do
            for _, v2 in v do
                local v17 = v2.Arguments and v2.Arguments[1];

                if v17 and u2[v17] then
                    v2.ImageId = u2[v17];
                end;
            end;
        end;

        for _, v in v12 do
            local v18 = PickFromTier(v);

            if v18 then
                table.insert(v16, v18);
            end;
        end;

        return {
            Quests = v16,
            Rewards = type(p9) ~= "function" and {} or p9({
                type = "rewards"
            })
        };
    end
};