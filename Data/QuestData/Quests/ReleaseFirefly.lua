-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "ReleaseFirefly",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        local v5;

        if p3 > 1 then
            v5 = `Release {p3} Fireflies from their jars`;
        else
            v5 = `Release {p3} Firefly from its jar`;
        end;

        return {
            Description = "Be free, little guy!",
            Title = v5,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p6, p7) -- Line: 25, Name: Use
        local table_clone_ret = table.clone(p7);
        table_clone_ret.Type = p6.Type;

        return table_clone_ret;
    end
};