-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "SubmitSummerCampfire",

    Display = function(p1, p2, p3) -- Line: 10, Name: Display
        local v4 = {
            Description = "Burn plants at the Summer campfire."
        };
        local v5;

        if p3 == 1 then
            v5 = `Submit {p3} plant to the Campfire`;
        else
            v5 = `Submit {p3} plants to the Campfire`;
        end;

        v4.Title = v5;
        v4.Bar = `{p2}/{p3}`;

        return v4;
    end,

    Use = function(p6, p7) -- Line: 18, Name: Use
        local table_clone_ret = table.clone(p7);
        table_clone_ret.Type = p6.Type;

        return table_clone_ret;
    end
};