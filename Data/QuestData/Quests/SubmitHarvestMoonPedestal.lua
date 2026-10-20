-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "SubmitHarvestMoonPedestal",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        return {
            Description = "Place plants on the Harvest Moon Pedestal.",
            Title = `Submit {p3} Plant{p3 == 1 and "" or "s"} to the Harvest Moon Pedestal`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 18, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};