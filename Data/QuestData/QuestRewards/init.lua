-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local v1 = {
    Sheckles = require(script.Sheckles),
    Seed = require(script.Seed),
    Egg = require(script.Egg),
    ["Cosmetic Crate"] = require(script["Cosmetic Crate"]),
    Cosmetic = require(script.Cosmetic),
    Gear = require(script.Gear),
    ["Seed Pack"] = require(script["Seed Pack"]),
    Currency = require(script.Currency),
    RandomSeed = require(script.RandomSeed),
    CompositeAll = require(script.CompositeAll),
    TeamEventPoints = require(script.TeamEventPoints),
    ["Fall Energy"] = require(script["Fall Energy"])
};

return table.freeze(v1);