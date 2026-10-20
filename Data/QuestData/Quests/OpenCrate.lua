-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Modules.TimeHelper);

return {
    Type = "OpenCrate",

    Display = function(p1, p2, p3, p4) -- Line: 11, Name: Display
        assert(p4);

        return {
            Description = "Wait for a crate to hatch and open it!",
            Title = `Open {p3} {p4[1]}{p3 == 1 and "" or "s"}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 21, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};