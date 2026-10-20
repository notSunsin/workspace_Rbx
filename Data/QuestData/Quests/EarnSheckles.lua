-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Comma_Module = require(ReplicatedStorage.Comma_Module);

return {
    Type = "EarnSheckles",

    Display = function(p1, p2, p3) -- Line: 11, Name: Display
        -- upvalues: Comma_Module (copy)
        local v4 = Comma_Module.Comma(p3);

        return {
            Description = "Sell your crops to make that moolah!",
            Title = `Earn {v4}¢`,
            Bar = `{Comma_Module.Comma((math.min(p2, p3)))}/{v4}`
        };
    end,

    Use = function(p5, p6) -- Line: 20, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};