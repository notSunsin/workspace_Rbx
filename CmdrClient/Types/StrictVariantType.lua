-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for _, v in require(ReplicatedStorage.Item_Module).VariantNames do
    table.insert(u1, v);
end;

local u7 = {
    Transform = function(p2) -- Line: 12, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 18, Name: Validate
        return #p3 > 0, "No variants could be found.";
    end,

    Autocomplete = function(p4) -- Line: 22, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 26, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 30, Name: Default
        return "Normal";
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 42
    -- upvalues: u7 (copy), Util (copy)
    p8:RegisterType("strictvariant", u7);
    p8:RegisterType("strictvariants", Util.MakeListableType(u7, {
        Prefixes = "% variants"
    }));
end;