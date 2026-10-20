-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Pluralize = require(ReplicatedStorage.Modules.Pluralize);

return {
    Type = "ObtainSeedPack",

    Display = function(p1, p2, p3, p4) -- Line: 11, Name: Display
        -- upvalues: Pluralize (copy)
        assert(p4, "Quest ObtainSeedPack doesn\'t have an argument.");
        local v5 = p4[1];
        local v6 = {
            Description = "Be packing those seeds!"
        };

        if p3 > 1 then
            v5 = Pluralize(v5);
        end;

        v6.Title = `Obtain {p3} {v5}!`;
        v6.Bar = `{p2}/{p3}`;

        return v6;
    end,

    Use = function(p7, p8) -- Line: 22, Name: Use
        assert(p8.Arguments, "ObtainSeedPack quests needs arguments.");
        local table_clone_ret = table.clone(p8);
        table_clone_ret.Type = p7.Type;

        return table_clone_ret;
    end
};