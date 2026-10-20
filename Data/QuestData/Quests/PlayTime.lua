-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);

return {
    Type = "PlayTime",

    Display = function(p1, p2, p3) -- Line: 11, Name: Display
        -- upvalues: TimeHelper (copy)
        local v4 = TimeHelper:GenerateColonFormatFromTime(p3);

        return {
            Description = "Why touch grass when you could Grow a Garden!",
            Title = `Play for {v4}`,
            Bar = `{TimeHelper:GenerateColonFormatFromTime(p2)}/{v4}`
        };
    end,

    Use = function(p5, p6) -- Line: 21, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};