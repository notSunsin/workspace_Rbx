-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "TravelLeafBlower",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        return {
            Description = "Be free, little guy!",
            Title = `Travel {p3} studs with a Leafblower`,
            Bar = `{math.floor(p2)}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 18, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};