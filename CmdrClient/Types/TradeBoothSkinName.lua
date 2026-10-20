-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("RunService");
local Util = require(game.ReplicatedStorage.Code.Util);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local u7 = {
    Transform = function(p1) -- Line: 10, Name: Transform
        -- upvalues: TradeBoothSkinRegistry (copy), Util (copy)
        local v2 = {};

        for i in TradeBoothSkinRegistry do
            table.insert(v2, i);
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p3) -- Line: 22, Name: Validate
        return #p3 > 0, "No seeds could be found.";
    end,

    Autocomplete = function(p4) -- Line: 26, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 30, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 34, Name: Default
        -- upvalues: TradeBoothSkinRegistry (copy)
        return next(TradeBoothSkinRegistry);
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 46
    -- upvalues: u7 (copy), Util (copy)
    p8:RegisterType("tradeboothskinname", u7);
    p8:RegisterType("stricttradeboothskinname", Util.MakeListableType(u7, {
        Prefixes = "% fencename"
    }));
end;