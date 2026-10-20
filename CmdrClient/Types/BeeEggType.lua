-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for i in require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry).Entries do
    table.insert(u1, i);
end;

local u6 = {
    Transform = function(p2) -- Line: 11, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 15, Name: Validate
        return #p3 > 0, "No Bee Egg type could be found";
    end,

    Autocomplete = function(p4) -- Line: 18, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 21, Name: Parse
        return p5[1];
    end,

    Default = function() -- Line: 24, Name: Default
        -- upvalues: u1 (copy)
        return u1[1];
    end
};

return function(p7) -- Line: 29
    -- upvalues: u6 (copy)
    p7:RegisterType("beeeggtype", u6);
end;