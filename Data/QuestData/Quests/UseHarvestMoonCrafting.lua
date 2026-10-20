-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "UseHarvestMoonCrafting",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        return {
            Description = "Craft anything at the Harvest Moon Crafting station.",
            Title = `Use Harvest Moon Crafting {p3} {p3 == 1 and "time" or "times"}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 19, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};