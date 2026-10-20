-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
require(ReplicatedStorage.Modules.MutationHandler);
local u1 = { "Normal" };

for i in require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry).PetMutationRegistry do
    table.insert(u1, i);
end;

local u7 = {
    Transform = function(p2) -- Line: 19, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 25, Name: Validate
        return #p3 > 0, "No seeds could be found.";
    end,

    Autocomplete = function(p4) -- Line: 29, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 33, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 37, Name: Default
        return "Shocked";
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 49
    -- upvalues: u7 (copy)
    p8:RegisterType("petmutation", u7);
end;