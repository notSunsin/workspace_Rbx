-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
require(ReplicatedStorage.Data.QuestData.Types);

return {
    ProgresPerQuest = 1,
    RestartRobuxPrice = 149,
    RestartRobuxProduct = 3322860121,
    MaxProgress = 21,
    Rewards = {
        [3] = QuestRewards.Cosmetic:Use({
            Amount = 1,
            Type = "Volcano"
        }),
        [6] = QuestRewards["Seed Pack"]:Use({
            Type = "Ancient Seed Pack",
            Amount = 3
        }),
        [9] = QuestRewards.Cosmetic:Use({
            Type = "Long Neck Dino Statue",
            Amount = 1
        }),
        [12] = QuestRewards["Seed Pack"]:Use({
            Type = "Ancient Seed Pack",
            Amount = 6
        }),
        [15] = QuestRewards.Gear:Use({
            Type = "Mutation Spray Amber",
            Amount = 3
        }),
        [18] = QuestRewards["Seed Pack"]:Use({
            Type = "Ancient Seed Pack",
            Amount = 10
        }),
        [21] = QuestRewards.Seed:Use({
            Type = "Bone Blossom",
            Amount = 1
        })
    }
};