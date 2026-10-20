-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "PlaceObject",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        assert(p4, "Quest PlaceObject doesn\'t have an argument.");

        return {
            Description = "Place those items!",
            Title = `Place {p3}x {p4[1]}{p3 > 1 and "s" or ""}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 20, Name: Use
        assert(p6.Arguments, "PlaceObject quests needs arguments.");
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};