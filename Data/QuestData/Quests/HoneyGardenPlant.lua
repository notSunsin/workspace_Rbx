-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "HoneyGardenPlant",

    Display = function(p1, p2, p3) -- Line: 10, Name: Display
        return {
            Description = "Plant any seed while in your honey garden slot.",
            Title = `Plant {p3} seeds in your honey garden`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p4, p5) -- Line: 18, Name: Use
        local table_clone_ret = table.clone(p5);
        table_clone_ret.Type = p4.Type;

        return table_clone_ret;
    end
};