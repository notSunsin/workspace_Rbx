-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local HttpService = game:GetService("HttpService");
local u1 = HttpService:JSONDecode(workspace:GetAttribute("AllEvents") or "[]");
workspace:GetAttributeChangedSignal("AllEvents"):Connect(function() -- Line: 8
    -- upvalues: u1 (ref), HttpService (copy)
    u1 = HttpService:JSONDecode(workspace:GetAttribute("AllEvents"));
end);
local u7 = {
    Transform = function(p2) -- Line: 13, Name: Transform
        -- upvalues: Util (copy), u1 (ref)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 19, Name: Validate
        return #p3 > 0, "No events could be found.";
    end,

    Autocomplete = function(p4) -- Line: 23, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 27, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 31, Name: Default
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
    p8:RegisterType("event", u7);
end;