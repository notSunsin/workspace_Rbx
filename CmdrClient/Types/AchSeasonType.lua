-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for _, child in ReplicatedStorage.Data.AchievementsData.Seasons:GetChildren() do
    table.insert(u1, child.Name);
end;

local u7 = {
    Transform = function(p2) -- Line: 14, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 20, Name: Validate
        return #p3 > 0, "No seasons could be found.";
    end,

    Autocomplete = function(p4) -- Line: 24, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 28, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 32, Name: Default
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 44
    -- upvalues: u7 (copy)
    p8:RegisterType("achievementseason", u7);
end;