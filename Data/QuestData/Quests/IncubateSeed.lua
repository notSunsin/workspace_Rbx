-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "IncubateSeed",

    Display = function(p1, p2, p3) -- Line: 10, Name: Display
        local v4 = {
            Description = "Complete a Honey Incubator cycle to turn seeds into normal seeds."
        };
        local v5;

        if p3 == 1 then
            v5 = `Incubate {p3} seed in the Honey Incubator`;
        else
            v5 = `Incubate {p3} seeds in the Honey Incubator`;
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