-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(ReplicatedStorage.Code.Util);
local u1 = {};

for i, _ in require(ReplicatedStorage.Data.ConfigRegistry) do
    table.insert(u1, i);
end;

local u7 = {
    Transform = function(p2) -- Line: 12, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 17, Name: Validate
        return #p3 > 0, "no power by that name could be found.";
    end,

    Autocomplete = function(p4) -- Line: 21, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 25, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 29, Name: Default
        return p6;
    end,

    ArgumentOperatorAliases = {
        All = "*",
        random = "?"
    }
};

return function(p8) -- Line: 39
    -- upvalues: u7 (copy), Util (copy)
    p8:RegisterType(script.Name, u7);
    p8:RegisterType(script.Name .. "s", Util.MakeListableType(u7));
end;