-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local ShovelSkinRegistry = require(ReplicatedStorage.Data.ShovelSkinRegistry);
local u7 = {
    Transform = function(p1) -- Line: 7, Name: Transform
        -- upvalues: ShovelSkinRegistry (copy), Util (copy)
        local v2 = {};

        for i in ShovelSkinRegistry do
            table.insert(v2, i);
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p3) -- Line: 17, Name: Validate
        return #p3 > 0, "No shovel skins could be found.";
    end,

    Autocomplete = function(p4) -- Line: 21, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 25, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 29, Name: Default
        -- upvalues: ShovelSkinRegistry (copy)
        return next(ShovelSkinRegistry);
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 41
    -- upvalues: u7 (copy), Util (copy)
    p8:RegisterType("shovelskinname", u7);
    p8:RegisterType("strictshovelskinname", Util.MakeListableType(u7, {
        Prefixes = "% shovelskinname"
    }));
end;