-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Data.SeedData);

return {
    Type = "SubmitFairyFountainMutation",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        assert(p4, "Quest Submit Fairy Fountain Mutation doesn\'t have an argument.");

        return {
            Title = `Offer {p3}x {p4[1]} fruit`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 24, Name: Use
        assert(p6.Arguments, "Submit Fairy Fountain Mutation quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};