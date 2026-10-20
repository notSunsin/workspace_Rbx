-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "HarvestMoonbeamPlant",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        return {
            Description = "Harvest Moonbeam plants from your garden.",
            Title = `Harvest {p3} Moonbeam Plant{p3 == 1 and "" or "s"}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 18, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};