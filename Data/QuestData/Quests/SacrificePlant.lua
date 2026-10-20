-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "SacrificePlant",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        assert(p4, "Quest SacrificePlant doesn\'t have an argument.");

        return {
            Description = "Sometimes, you must give to get",
            Title = `Sacrifice {p3}x plants to the evil bunny!`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 21, Name: Use
        assert(p6.Arguments, "SacrificePlant quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};