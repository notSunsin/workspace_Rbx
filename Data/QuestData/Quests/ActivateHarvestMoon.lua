-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "ActivateHarvestMoon",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        return {
            Description = "Trigger the Harvest Moon event.",
            Title = `Activate {p3 == 1 and "the Harvest Moon" or `the Harvest Moon {p3} times`}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 19, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};