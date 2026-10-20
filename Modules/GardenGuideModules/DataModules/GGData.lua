-- Decompiled with Potassium's decompiler.

local DataModules = game:GetService("ReplicatedStorage").Modules.GardenGuideModules.DataModules;

return {
    Plant = require(DataModules.PlantData),
    Pet = require(DataModules.PetData),
    Cosmetic = require(DataModules.CosmeticData),
    Food = require(DataModules.FoodData),
    Mutation = require(DataModules.MutationData)
};