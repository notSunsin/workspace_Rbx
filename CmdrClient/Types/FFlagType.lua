-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for i in require(ReplicatedStorage.Data.FFlagState) do
    table.insert(u1, i);
end;

local u7 = {
    Transform = function(p2) -- Line: 16, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 22, Name: Validate
        return #p3 > 0, "No type could be found.";
    end,

    Autocomplete = function(p4) -- Line: 26, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 30, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 34, Name: Default
        return "Gold";
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
    p8:RegisterType("fflag", u7);
end;