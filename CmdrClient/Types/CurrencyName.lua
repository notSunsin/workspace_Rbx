-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("RunService");
local Util = require(game.ReplicatedStorage.Code.Util);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local u7 = {
    Transform = function(p1) -- Line: 9, Name: Transform
        -- upvalues: CurrencyData (copy), Util (copy)
        local v2 = {};

        for i in CurrencyData do
            if i ~= "Sheckles" then
                table.insert(v2, i);
            end;
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p3) -- Line: 23, Name: Validate
        return #p3 > 0, "No Currency could be found.";
    end,

    Autocomplete = function(p4) -- Line: 27, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 31, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 35, Name: Default
        return "Honey";
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
    p8:RegisterType("currencyname", u7);
end;