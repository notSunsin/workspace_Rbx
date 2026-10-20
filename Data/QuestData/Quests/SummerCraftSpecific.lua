-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "SummerCraftSpecific",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        local v5 = p4 and p4[1] or "items";
        local v6 = {};
        local v7;

        if p3 == 1 then
            v7 = `Craft {p3} {v5}`;
        else
            v7 = `Craft {p3} {v5}s`;
        end;

        v6.Title = v7;
        v6.Bar = `{p2}/{p3}`;
        v6.Description = `Craft {v5} at a crafting station.`;

        return v6;
    end,

    Use = function(p8, p9) -- Line: 20, Name: Use
        assert(p9.Arguments, "SummerCraftSpecific quests need arguments.");
        local table_clone_ret = table.clone(p9);
        table_clone_ret.Type = p8.Type;

        return table_clone_ret;
    end
};