-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local SeedData = require(ReplicatedStorage.Data.SeedData);

return {
    Type = "Plant",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        -- upvalues: SeedData (copy)
        assert(p4, "Quest Plant doesn\'t have an argument.");
        local v5 = SeedData[p4[1]];
        local v6 = {
            Description = "Get planting, gardener!"
        };
        local v7;

        if v5 then
            v7 = v5.SeedName;
        else
            v7 = p4[1];
        end;

        v6.Title = `Plant {p3}x {v7}{p3 > 1 and "s" or ""}`;
        v6.Bar = `{p2}/{p3}`;

        return v6;
    end,

    Use = function(p8, p9) -- Line: 24, Name: Use
        assert(p9.Arguments, "Plant quests needs arguments.");
        local table_clone_ret = table.clone(p9);
        table_clone_ret.Type = p8.Type;

        return table_clone_ret;
    end
};