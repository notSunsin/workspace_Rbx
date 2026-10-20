-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for i in require(ReplicatedStorage.Data.BeeEvent.BeeRegistry) do
    if string.find(i, "Wasp") then
        table.insert(u1, i);
    end;
end;

local u7 = {
    Transform = function(p2) -- Line: 17, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 22, Name: Validate
        return #p3 > 0, "No wasp could be found";
    end,

    Autocomplete = function(p4) -- Line: 26, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 30, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 34, Name: Default
        -- upvalues: u1 (copy)
        return u1[1];
    end
};

return function(p8) -- Line: 39
    -- upvalues: u7 (copy)
    p8:RegisterType("waspname", u7);
end;