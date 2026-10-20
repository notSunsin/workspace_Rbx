-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Data.SeedData);

return {
    Type = "SubmitHarvestSpiritFruit",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        assert(p4, "Quest Submit Harvest Spirit Fruit doesn\'t have an argument.");

        return {
            Description = "This Harvest Spirit seems eerily familiar...",
            Title = `Offer {p3} plant{p3 > 1 and "s" or ""} to the Harvest Spirit`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 22, Name: Use
        assert(p6.Arguments, "Submit Harvest Spirit Fruit quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};