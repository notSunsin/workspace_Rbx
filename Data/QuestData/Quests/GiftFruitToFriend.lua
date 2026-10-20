-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Data.SeedData);

return {
    Type = "GiftFruitToFriend",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        assert(p4, "Quest GiftFruitToFriend doesn\'t have an argument.");
        local v5 = p4[1];

        return v5 and {
            Description = "Sharing is caring!",
            Title = `Gift {p3}x {v5} to friends`,
            Bar = `{p2}/{p3}`
        } or {
            Description = "Sharing is caring!",
            Title = `Gift {p3}x fruits to friends`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p6, p7) -- Line: 33, Name: Use
        assert(p7.Arguments, "GiftFruitToFriend quests needs arguments.");
        local table_clone_ret = table.clone(p7);
        table_clone_ret.Type = p6.Type;

        return table_clone_ret;
    end
};