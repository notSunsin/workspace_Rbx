-- Decompiled with Potassium's decompiler.

local Util = require(game.ReplicatedStorage.Code.Util);
local EnumItems = Enum.UserInputType:GetEnumItems();

for _, v in pairs(Enum.KeyCode:GetEnumItems()) do
    EnumItems[#EnumItems + 1] = v;
end;

local u5 = {
    Transform = function(p1) -- Line: 10, Name: Transform
        -- upvalues: Util (copy), EnumItems (copy)
        return Util.MakeFuzzyFinder(EnumItems)(p1);
    end,

    Validate = function(p2) -- Line: 16, Name: Validate
        return #p2 > 0;
    end,

    Autocomplete = function(p3) -- Line: 20, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p3);
    end,

    Parse = function(p4) -- Line: 24, Name: Parse
        return p4[1];
    end
};

return function(p6) -- Line: 29
    -- upvalues: u5 (copy), Util (copy)
    p6:RegisterType("userInput", u5);
    p6:RegisterType("userInputs", Util.MakeListableType(u5));
end;