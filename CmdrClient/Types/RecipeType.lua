-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(ReplicatedStorage.Code.Util);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);

local function BuildAllRecipes() -- Line: 8
    -- upvalues: GameConfigController (copy)
    local v1 = {};

    for _, v in GameConfigController:GetConfig("SummerCraftingConfig").Craftables do
        if type(v) == "table" and (type(v.Result) == "table" and v.Result.Value) then
            local v2 = tostring(v.Result.Value);
            table.insert(v1, v2);
        end;
    end;

    return v1;
end;

local u3 = BuildAllRecipes();
workspace:GetAttributeChangedSignal("SummerCraftingConfig"):Connect(function() -- Line: 22
    -- upvalues: u3 (ref), BuildAllRecipes (copy)
    u3 = BuildAllRecipes();
end);
local u8 = {
    Transform = function(p4) -- Line: 27, Name: Transform
        -- upvalues: Util (copy), u3 (ref)
        return Util.MakeFuzzyFinder(u3)(p4);
    end,

    Validate = function(p5) -- Line: 31, Name: Validate
        return #p5 > 0, "No matching campfire recipe found.";
    end,

    Autocomplete = function(p6) -- Line: 35, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p6);
    end,

    Parse = function(p7) -- Line: 39, Name: Parse
        return p7[1];
    end
};

return function(p9) -- Line: 44
    -- upvalues: u8 (copy), Util (copy)
    p9:RegisterType("recipetype", u8);
    p9:RegisterType("recipes", Util.MakeListableType(u8));
end;