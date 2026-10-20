-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local SeasonPassData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassData);
local u1 = {};

if SeasonPassData.ShopItems then
    for i, v in SeasonPassData.ShopItems do
        if not v.RobuxOnly and v.StockAmount[2] ~= 0 then
            table.insert(u1, i);
        end;
    end;
end;

local u7 = {
    Transform = function(p2) -- Line: 17, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 21, Name: Validate
        return #p3 > 0, "No items could be found.";
    end,

    Autocomplete = function(p4) -- Line: 25, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 29, Name: Parse
        return p5[1];
    end,

    Default = function(p6) -- Line: 33, Name: Default
        return "";
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
    p8:RegisterType("seasonpassshopitemname", u7);
end;