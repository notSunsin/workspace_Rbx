-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for _, v in require(ReplicatedStorage.Data.AchievementsData).Seasons do
    for _, v2 in v.Sets do
        for _, v3 in v2.Quests do
            table.insert(u1, v3.Id);
        end;
    end;
end;

local u7 = {
    Transform = function(p2) -- Line: 16, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 22, Name: Validate
        return #p3 > 0, "No quests could be found.";
    end,

    Autocomplete = function(p4) -- Line: 26, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 30, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 34, Name: Default
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 46
    -- upvalues: u7 (copy)
    p8:RegisterType("achievementquest", u7);
end;