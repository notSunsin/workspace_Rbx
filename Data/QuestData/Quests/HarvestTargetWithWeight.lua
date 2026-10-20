-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Pluralize = require(ReplicatedStorage.Modules.Pluralize);

return {
    Type = "HarvestTargetWithWeight",

    DynamicFunction = function(p1: table, p2: table) -- Line: 11, Name: DynamicFunction
        local v3 = tonumber(p1[1]);
        local v4 = p1[2];
        local v5;

        if p2 then
            v5 = tonumber(p2.Weight);
        else
            v5 = p2;
        end;

        if p2 then
            p2 = p2.CropName;
        end;

        if not (v5 and v3) then
            return false;
        end;

        if v4 and p2 ~= v4 then
            return false;
        end;

        return v3 <= v5;
    end,

    Display = function(p6, p7, p8, p9) -- Line: 26, Name: Display
        -- upvalues: Pluralize (copy)
        assert(p9, "Quest Harvest doesn\'t have an argument.");
        local v10 = {
            Description = "Mutations and variants not required."
        };
        local v11;

        if p8 > 1 then
            v11 = Pluralize(p9[2]);
        else
            v11 = p9[2];
        end;

        v10.Title = `Harvest {p8} {v11} of weight greater than {p9[1]} kg`;
        v10.Bar = `{p7}/{p8}`;

        return v10;
    end,

    Use = function(p12, p13) -- Line: 35, Name: Use
        assert(p13.Arguments, "Plant quests needs arguments.");
        local table_clone_ret = table.clone(p13);
        table_clone_ret.Type = p12.Type;
        table_clone_ret.DynamicFunction = p12.DynamicFunction;

        return table_clone_ret;
    end
};