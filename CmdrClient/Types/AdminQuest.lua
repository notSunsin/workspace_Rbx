-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
game:GetService("HttpService");
local AdminQuestData = require(ReplicatedStorage.Data.AdminQuestData);
local u7 = {
    Transform = function(p1) -- Line: 9, Name: Transform
        -- upvalues: AdminQuestData (copy), Util (copy)
        local v2 = {};

        for i, _ in AdminQuestData.ValidAdminQuests do
            table.insert(v2, i);
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p3) -- Line: 22, Name: Validate
        return #p3 > 0, "No Valid Admin Quests could be found.";
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
    p8:RegisterType("adminquest", u7);
end;