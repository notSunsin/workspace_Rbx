-- Decompiled with Potassium's decompiler.

local Util = require(game.ReplicatedStorage.Code.Util);
local HttpService = game:GetService("HttpService");
local u1 = HttpService:JSONDecode(workspace:GetAttribute("AllLiveEvents") or "[]");
workspace:GetAttributeChangedSignal("AllLiveEvents"):Connect(function() -- Line: 7
    -- upvalues: u1 (ref), HttpService (copy)
    u1 = HttpService:JSONDecode(workspace:GetAttribute("AllLiveEvents"));
end);
local u7 = {
    Transform = function(p2) -- Line: 12, Name: Transform
        -- upvalues: Util (copy), u1 (ref)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 18, Name: Validate
        return #p3 > 0, "No live events could be found.";
    end,

    Autocomplete = function(p4) -- Line: 22, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 26, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 30, Name: Default
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 42
    -- upvalues: u7 (copy)
    p8:RegisterType("liveevent", u7);
end;