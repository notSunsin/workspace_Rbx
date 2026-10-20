-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "SummerHarvestSpecific",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        local v5 = p4 and p4[1] or "plants";

        return {
            Title = `Harvest {p3} {v5}`,
            Bar = `{p2}/{p3}`,
            Description = `Harvest {v5} from your garden.`
        };
    end,

    Use = function(p6, p7) -- Line: 19, Name: Use
        assert(p7.Arguments, "SummerHarvestSpecific quests need arguments.");
        local table_clone_ret = table.clone(p7);
        table_clone_ret.Type = p6.Type;

        return table_clone_ret;
    end
};