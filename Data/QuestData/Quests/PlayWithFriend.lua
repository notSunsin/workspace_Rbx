-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Data.SeedData);

return {
    Type = "PlayWithFriend",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        assert(p4, "Quest PlayWithFriend doesn\'t have an argument.");

        return {
            Title = "Play with a friend",
            Description = "Play on the same server as a connection!",
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 22, Name: Use
        assert(p6.Arguments, "PlayWithFriend quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};