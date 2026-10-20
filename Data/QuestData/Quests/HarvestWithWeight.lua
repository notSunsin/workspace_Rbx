-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Modules.Pluralize);

return {
    Type = "HarvestWithWeight",

    DynamicFunction = function(p1: table, p2: table) -- Line: 11, Name: DynamicFunction
        local v3 = tonumber(p1[1]);

        if p2 then
            p2 = tonumber(p2.Weight);
        end;

        if p2 and v3 then
            return v3 <= p2;
        end;

        return false;
    end,

    Display = function(p4, p5, p6, p7) -- Line: 20, Name: Display
        assert(p7, "Quest Harvest doesn\'t have an argument.");

        return {
            Description = "Mutations and variants not required.",
            Title = `Harvest {p6} Plant{p6 > 1 and "s" or ""} of weight greater than {p7[1]} kg`,
            Bar = `{p5}/{p6}`
        };
    end,

    Use = function(p8, p9) -- Line: 29, Name: Use
        assert(p9.Arguments, "Plant quests needs arguments.");
        local table_clone_ret = table.clone(p9);
        table_clone_ret.Type = p8.Type;
        table_clone_ret.DynamicFunction = p8.DynamicFunction;

        return table_clone_ret;
    end
};