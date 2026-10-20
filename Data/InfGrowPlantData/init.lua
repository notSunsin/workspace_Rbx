-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.UpdateService);

return {
    InfGrowPlants = {
        ["Christmas Tree"] = {
            DisplayName = "Christmas Tree",
            BaseWeightIncrease = 0.1,
            CanBeMutated = false,
            MaxScale = 20,
            CollideThresh = 10,
            OfflineIncrease = 0.1,
            CollectionDate = 1766858400,
            ValidSubmissions = {
                ["Wonder Water"] = true
            }
        }
    },
    AllValidSubmissions = {
        ["Wonder Water"] = true
    }
};