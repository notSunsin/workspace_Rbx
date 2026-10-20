-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);
local u7 = {
    Transform = function(p1) -- Line: 7, Name: Transform
        -- upvalues: BeeEnchantmentRegistry (copy), Util (copy)
        local v2 = {};

        for i in BeeEnchantmentRegistry.Entries do
            table.insert(v2, i);
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p3) -- Line: 19, Name: Validate
        return #p3 > 0, "No bee enchantments could be found.";
    end,

    Autocomplete = function(p4) -- Line: 23, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 27, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 31, Name: Default
        return "Sword";
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
    p8:RegisterType("beeenchantment", u7);
end;