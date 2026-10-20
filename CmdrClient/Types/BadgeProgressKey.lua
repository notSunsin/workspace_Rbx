-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local v1 = {
    require(ReplicatedStorage.Data.Events.Halloween2026Event.SweetFortuneQuestData).ProgressKey,
    "SeedpackConnoisseur",
    "WhatCameFirst",
    "PetMaster",
    "Caretaker",
    "MelonMadness",
    "CarrotConnoisseur"
};
local u2 = Util.MakeFuzzyFinder(v1);
local u7 = {
    Transform = function(p3) -- Line: 20, Name: Transform
        -- upvalues: u2 (copy)
        return u2(p3);
    end,

    Validate = function(p4) -- Line: 24, Name: Validate
        return #p4 > 0, "No badge progress key could be found.";
    end,

    Autocomplete = function(p5) -- Line: 28, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p5);
    end,

    Parse = function(p6) -- Line: 32, Name: Parse
        return p6[1];
    end
};

return function(p8) -- Line: 37
    -- upvalues: u7 (copy)
    p8:RegisterType("badgeprogresskey", u7);
end;