-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Modules.TimeHelper);

return {
    Type = "OpenSeedPack",
    AnyArguments = true,

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        assert(p4);

        return {
            Description = "Good luck!",
            Title = `Open {p3} {p4[1]}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 22, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};