-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Pluralize = require(ReplicatedStorage.Modules.Pluralize);

return {
    Type = "SubmitHighTideSpecific",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        -- upvalues: Pluralize (copy)
        assert(p4, "Quest SubmitHighTideSpecific doesn\'t have an argument.");
        local v5 = {
            Description = "Hand in this plant at the High Tide Harvest."
        };
        local v6;

        if p3 > 1 then
            v6 = Pluralize(p4[1]);
        else
            v6 = p4[1];
        end;

        v5.Title = `Submit {p3} {v6} to the High Tide Harvest`;
        v5.Bar = `{p2}/{p3}`;

        return v5;
    end,

    Use = function(p7, p8) -- Line: 21, Name: Use
        assert(p8.Arguments, "SubmitHighTideSpecific quests needs arguments.");
        local table_clone_ret = table.clone(p8);
        table_clone_ret.Type = p7.Type;

        return table_clone_ret;
    end
};