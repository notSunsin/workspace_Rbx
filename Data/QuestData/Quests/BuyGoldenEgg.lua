-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "BuyGoldenEgg",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        assert(p4, "Quest BuyGoldenEgg doesn\'t have an argument.");

        return {
            Description = "Go for gold!",
            Title = `Buy {p3}x golden eggs!`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 21, Name: Use
        assert(p6.Arguments, "BuyGoldenEgg quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};