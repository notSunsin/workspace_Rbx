-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u6 = {
    Transform = function(p1) -- Line: 7, Name: Transform
        -- upvalues: Util (copy)
        return Util.MakeFuzzyFinder({ "Pumpkin", "Nil" })(p1);
    end,

    Validate = function(p2) -- Line: 13, Name: Validate
        return #p2 > 0, "No action could be found.";
    end,

    Autocomplete = function(p3) -- Line: 17, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p3);
    end,

    Parse = function(p4) -- Line: 21, Name: Parse
        return p4[1];
    end,

    Default = function(p5) -- Line: 25, Name: Default
        return "Pumpkin";
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p7) -- Line: 37
    -- upvalues: u6 (copy)
    p7:RegisterType("jumpscaretype", u6);
end;