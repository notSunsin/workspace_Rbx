-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Data.SeedData);

return {
    Type = "SubmitFairyFountainFruit",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        assert(p4, "Quest Submit Fairy Fountain Fruit doesn\'t have an argument.");
        local v5 = p4[1];
        local v6 = p4[2];

        return v6 and {
            Title = `Offer {p3}x {v6} {v5}`,
            Bar = `{p2}/{p3}`
        } or {
            Title = `Offer {p3}x {v5}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p7, p8) -- Line: 32, Name: Use
        assert(p8.Arguments, "Submit Fairy Fountain Fruit quests needs arguments.");
        local table_clone_ret = table.clone(p8);
        table_clone_ret.Type = p7.Type;

        return table_clone_ret;
    end
};