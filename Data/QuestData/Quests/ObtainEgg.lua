-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "ObtainEgg",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        assert(p4, "Quest ObtainEgg doesn\'t have an argument.");

        return {
            Description = "Better be quick!",
            Title = `Obtain {p3}x eggs during an Egg War`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 21, Name: Use
        assert(p6.Arguments, "ObtainEgg quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};