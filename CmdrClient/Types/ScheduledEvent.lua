-- Decompiled with Potassium's decompiler.

game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(ReplicatedStorage.Code.Util);
local EventRotationConfig = require(ReplicatedStorage.Modules.EventRotation.EventRotationConfig);
local u7 = {
    Transform = function(p1) -- Line: 9, Name: Transform
        -- upvalues: EventRotationConfig (copy), Util (copy)
        local v2 = {};

        for _, v in EventRotationConfig do
            table.insert(v2, v.EventID);
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p3) -- Line: 20, Name: Validate
        return #p3 > 0, "No Events could be found.";
    end,

    Autocomplete = function(p4) -- Line: 24, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 28, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 32, Name: Default
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 44
    -- upvalues: u7 (copy)
    p8:RegisterType("scheduledEvent", u7);
end;