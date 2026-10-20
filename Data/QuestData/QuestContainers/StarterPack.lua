-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
require(ReplicatedStorage.Data.QuestData.QuestRewards);

return {
    Type = "StarterPack",

    Display = function(p1) -- Line: 13, Name: Display
        return "Stater Pack Plant Logic";
    end,

    Generate = function(p2) -- Line: 17, Name: Generate
        -- upvalues: Quests (copy)
        return {
            Quests = { Quests.Plant:Use({
                    Target = 2,
                    Arguments = { "Tomato" }
                }) },
            Rewards = {}
        };
    end
};