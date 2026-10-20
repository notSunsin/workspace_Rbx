-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "FillHoneyCompressor",

    Display = function(p1, p2, p3) -- Line: 10, Name: Display
        return {
            Description = "Fill up the honey compressor with honey.",
            Title = `Fill the honey compressor {p3} times`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p4, p5) -- Line: 18, Name: Use
        local table_clone_ret = table.clone(p5);
        table_clone_ret.Type = p4.Type;

        return table_clone_ret;
    end
};