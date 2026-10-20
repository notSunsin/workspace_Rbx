-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "HarvestMutation",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        assert(p4, "Quest HarvestMutation doesn\'t have an argument.");

        return p4[1] and {
            Title = `Harvest {p3}x {p4[1]} Mutated Plants`,
            Bar = `{p2}/{p3}`,
            Description = `Any plant will do, as long as it has the {p4[1]} mutation!`
        } or {
            Description = "Any plant will do, as long as it has a mutation!",
            Title = `Harvest {p3}x Mutated Plants`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 30, Name: Use
        assert(p6.Arguments, "Plant quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};