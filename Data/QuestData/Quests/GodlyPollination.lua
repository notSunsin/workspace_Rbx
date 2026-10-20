-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "GodlyPollination",

    Display = function(p1, p2, p3) -- Line: 10, Name: Display
        return {
            Description = "Trigger a godly pollination on any plant.",
            Title = `Get {p3} godly pollinations`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p4, p5) -- Line: 18, Name: Use
        local table_clone_ret = table.clone(p5);
        table_clone_ret.Type = p4.Type;

        return table_clone_ret;
    end
};