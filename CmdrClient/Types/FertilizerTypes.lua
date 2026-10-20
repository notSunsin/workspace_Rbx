-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local _ = ReplicatedStorage.Assets.Models.Fertilizers;
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = { "Variant" };
local u7 = {
    Transform = function(p2) -- Line: 13, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 19, Name: Validate
        return #p3 > 0, "No fertilizer could be found.";
    end,

    Autocomplete = function(p4) -- Line: 21, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 23, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 25, Name: Default
        return "Variant";
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 35
    -- upvalues: u7 (copy)
    p8:RegisterType("fertilizertype", u7);
end;