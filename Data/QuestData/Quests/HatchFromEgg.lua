-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "HatchFromEgg",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        assert(p4, "Quest HatchFromEgg doesn\'t have an argument.");
        assert(#p4 ~= 1, "Quest HatchFromEgg needs an argument.");

        return {
            Description = "Get hatching!",
            Title = `Obtain a {p4[1]} from an egg`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 21, Name: Use
        assert(p6.Arguments, "HatchFromEgg quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};