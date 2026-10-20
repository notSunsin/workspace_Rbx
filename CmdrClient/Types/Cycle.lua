-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
game:GetService("HttpService");
local CycleHandler = require(ReplicatedStorage.Modules.CycleHandler);
local u7 = {
    Transform = function(p1) -- Line: 10, Name: Transform
        -- upvalues: CycleHandler (copy), Util (copy)
        local v2 = {};

        for i, v in CycleHandler.getAllHandlers() do
            if not v.DisableCommandAutocomplete then
                table.insert(v2, i);
            end;
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p3) -- Line: 24, Name: Validate
        return #p3 > 0, "No Cycles could be found.";
    end,

    Autocomplete = function(p4) -- Line: 28, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 32, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 36, Name: Default
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 48
    -- upvalues: u7 (copy)
    p8:RegisterType("cycle", u7);
end;