-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for i in require(ReplicatedStorage.Data.BeeEvent.BeeRegistry) do
    table.insert(u1, i);
end;

local u7 = {
    Transform = function(p2) -- Line: 17, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 23, Name: Validate
        return #p3 > 0, "No Pet could be found";
    end,

    Autocomplete = function(p4) -- Line: 27, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 31, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 35, Name: Default
        -- upvalues: u1 (copy)
        return u1[1];
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 47
    -- upvalues: u7 (copy)
    p8:RegisterType("beetype", u7);
end;