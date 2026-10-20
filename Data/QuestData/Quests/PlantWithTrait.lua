-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);

return {
    Type = "PlantWithTrait",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        -- upvalues: PlantTraitsData (copy)
        assert(p4, "Quest Plant doesn\'t have an argument.");
        local v5 = p4[1];
        local v6 = PlantTraitsData.Traits[v5];
        local v7 = `Trait Argument of {v5} is invalid`;
        assert(v6, v7);

        return {
            Description = "Get planting, gardener!",
            Title = `Plant {p3}x {v5} Plants`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p8, p9) -- Line: 25, Name: Use
        assert(p9.Arguments, "Plant quests needs arguments.");
        local table_clone_ret = table.clone(p9);
        table_clone_ret.Type = p8.Type;

        return table_clone_ret;
    end
};