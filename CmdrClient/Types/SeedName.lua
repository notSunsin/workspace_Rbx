-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("RunService");
local Util = require(game.ReplicatedStorage.Code.Util);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local u9 = {
    Transform = function(p1) -- Line: 9, Name: Transform
        -- upvalues: SeedData (copy), Util (copy)
        local v2 = {};

        for i in SeedData do
            table.insert(v2, i);
        end;

        return Util.MakeFuzzyFinder(v2)((p1:gsub("_", " ")));
    end,

    Validate = function(p3) -- Line: 21, Name: Validate
        return #p3 > 0, "No seeds could be found.";
    end,

    Autocomplete = function(p4) -- Line: 25, Name: Autocomplete
        -- upvalues: Util (copy)
        Util.GetNames(p4);
        local v5 = {};

        for _, v in pairs(p4) do
            local v6 = v:gsub(" ", "_");
            table.insert(v5, v6);
        end;

        return v5;
    end,

    Parse = function(p7) -- Line: 35, Name: Parse
        return p7[1];
    end,

    Default = function(p8) -- Line: 39, Name: Default
        return "Carrot";
    end,

    ArgumentOperatorAliases = {
        me = ".",
        all = "*",
        others = "**",
        random = "?"
    }
};

return function(p10) -- Line: 52
    -- upvalues: u9 (copy), Util (copy)
    p10:RegisterType("seedname", u9);
    p10:RegisterType("seednames", Util.MakeListableType(u9, {
        Prefixes = "% plants"
    }));
end;