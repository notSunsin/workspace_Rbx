-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("RunService");
local Util = require(game.ReplicatedStorage.Code.Util);
local FoodRecipeData = require(ReplicatedStorage.Data.FoodRecipeData);
local u7 = {
    Transform = function(p1) -- Line: 9, Name: Transform
        -- upvalues: FoodRecipeData (copy), Util (copy)
        local v2 = {};

        for i in FoodRecipeData.RecipeNames do
            table.insert(v2, i);
        end;

        return Util.MakeFuzzyFinder(v2)(p1);
    end,

    Validate = function(p3) -- Line: 21, Name: Validate
        return #p3 > 0, "No food recipes could be found.";
    end,

    Autocomplete = function(p4) -- Line: 25, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 29, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 33, Name: Default
        return "Soup";
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p8) -- Line: 45
    -- upvalues: u7 (copy)
    p8:RegisterType("foodname", u7);
end;