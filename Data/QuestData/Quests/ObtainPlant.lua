-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Pluralize = require(ReplicatedStorage.Modules.Pluralize);

return {
    Type = "ObtainPlant",

    Display = function(p1, p2, p3, p4) -- Line: 13, Name: Display
        -- upvalues: Pluralize (copy)
        assert(p4, "Quest ObtainPlant doesn\'t have an argument.");
        local v5 = {
            Description = "Get your hands on this plant!"
        };
        local v6;

        if p3 > 1 then
            v6 = Pluralize(p4[1]);
        else
            v6 = p4[1];
        end;

        v5.Title = `Obtain {p3}x {v6}`;
        v5.Bar = `{p2}/{p3}`;

        return v5;
    end,

    Use = function(p7, p8) -- Line: 23, Name: Use
        assert(p8.Arguments, "ObtainPlant quests needs arguments.");
        local table_clone_ret = table.clone(p8);
        table_clone_ret.Type = p7.Type;

        return table_clone_ret;
    end
};