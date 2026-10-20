-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for i, v in require(ReplicatedStorage.Data.PetEggData) do
    if v.StockChance ~= 0 then
        table.insert(u1, i);
    end;
end;

local u7 = {
    Transform = function(p2) -- Line: 15, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 19, Name: Validate
        return #p3 > 0, "No Eggs could be found.";
    end,

    Autocomplete = function(p4) -- Line: 23, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 27, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 31, Name: Default
        return "Carrot";
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 43
    -- upvalues: u7 (copy)
    p8:RegisterType("peteggshopname", u7);
end;