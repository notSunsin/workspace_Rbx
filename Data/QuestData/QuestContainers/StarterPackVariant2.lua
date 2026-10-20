-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Quests = require(ReplicatedStorage.Data.QuestData.Quests);
require(ReplicatedStorage.Data.QuestData.QuestRewards);

return {
    Type = "StarterPackVariant2",

    Display = function(p1) -- Line: 13, Name: Display
        return "Stater Pack Play Time Logic";
    end,

    Generate = function(p2) -- Line: 17, Name: Generate
        -- upvalues: Quests (copy)
        return {
            Quests = { Quests.PlayTime:Use({
                    Target = 600
                }) },
            Rewards = {}
        };
    end
};