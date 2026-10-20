-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for i in require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList do
    table.insert(u1, i);
end;

local u7 = {
    Transform = function(p2) -- Line: 29, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 35, Name: Validate
        return #p3 > 0, "No cosmetic could be found.";
    end,

    Autocomplete = function(p4) -- Line: 39, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 43, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 47, Name: Default
        return "Arch";
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 59
    -- upvalues: u7 (copy)
    p8:RegisterType("cosmeticname", u7);
end;