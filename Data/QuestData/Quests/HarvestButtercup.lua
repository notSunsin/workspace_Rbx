-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Modules.Pluralize);

return {
    Type = "HarvestButtercup",

    Display = function(p1, p2, p3, p4) -- Line: 13, Name: Display
        assert(p4, "Quest Harvest doesn\'t have an argument.");

        return {
            Description = "Mutations and variants not required.",
            Title = `Harvest {p3} {p4[1]} {p3 > 1 and "Buttercups" or "Buttercup"}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 23, Name: Use
        assert(p6.Arguments, "Plant quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};