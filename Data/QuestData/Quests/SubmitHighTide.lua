-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "SubmitHighTide",

    Display = function(p1, p2, p3) -- Line: 12, Name: Display
        local v4 = {
            Description = "Hand plants in at the High Tide Harvest."
        };
        local v5;

        if p3 == 1 then
            v5 = `Submit {p3} plant to the High Tide Harvest`;
        else
            v5 = `Submit {p3} plants to the High Tide Harvest`;
        end;

        v4.Title = v5;
        v4.Bar = `{p2}/{p3}`;

        return v4;
    end,

    Use = function(p6, p7) -- Line: 20, Name: Use
        local table_clone_ret = table.clone(p7);
        table_clone_ret.Type = p6.Type;

        return table_clone_ret;
    end
};