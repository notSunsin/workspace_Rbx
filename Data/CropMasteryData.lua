-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Data = ReplicatedStorage:WaitForChild("Data");
require(Data:WaitForChild("DefaultData"));
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local u3 = {
    MaxMasteryLevel = 5,
    InitialData = {
        Default = {
            HarvestWeight = 2,
            PlantWeight = 4,
            SaleWeight = 1,
            ProgressRequired = 12000,
            Levels = {
                [0] = {
                    WeightMultiplier = 1,
                    GrowSpeedMultiplier = 1
                },
                [1] = {
                    WeightMultiplier = 1.02,
                    GrowSpeedMultiplier = 1.02
                },
                [2] = {
                    WeightMultiplier = 1.03,
                    GrowSpeedMultiplier = 1.03
                },
                [3] = {
                    WeightMultiplier = 1.04,
                    GrowSpeedMultiplier = 1.04
                },
                [4] = {
                    WeightMultiplier = 1.06,
                    GrowSpeedMultiplier = 1.06
                },
                [5] = {
                    WeightMultiplier = 1.15,
                    GrowSpeedMultiplier = 1.15
                }
            }
        }
    },
    ResolvedCrops = {},

    GetCropConfig = function(p1: table, p2: string) -- Line: 49, Name: GetCropConfig
        return p1.ResolvedCrops[p2] or p1.ResolvedCrops.Default;
    end
};

local function MasteryCurve(p4: number, p5: number, p6: number) -- Line: 55
    -- upvalues: TweenService (copy)
    return TweenService:GetValue(math.clamp(p4 / p5, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out) * p6;
end;

function u3.GetMasteryProgress(p7: table, p8: any, p9: string) -- Line: 63
    -- upvalues: UpdateService (copy), u3 (copy), TweenService (copy)
    if UpdateService:IsHiddenFromUpdate("Crop Mastery") then
        return 0;
    end;

    if not p8.CropMastery then
        return 0;
    end;

    local PlantData = p8.CropMastery.PlantData;

    if not PlantData then
        return 0;
    end;

    local v10 = PlantData[p9];

    if not v10 then
        return 0;
    end;

    local CropConfig = u3:GetCropConfig(p9);
    local MaxMasteryLevel = p7.MaxMasteryLevel;
    local v11 = TweenService:GetValue(math.clamp(((v10.PlantedCount or 0) * CropConfig.PlantWeight + (v10.HarvestCount or 0) * CropConfig.HarvestWeight + (v10.SoldCount or 0) * CropConfig.SaleWeight) / CropConfig.ProgressRequired, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.Out) * MaxMasteryLevel;

    return math.min(v11, p7.MaxMasteryLevel);
end;

function u3.GetMasteryLevel(p12: table, p13: any, p14: string) -- Line: 93
    -- upvalues: UpdateService (copy)
    if UpdateService:IsHiddenFromUpdate("Crop Mastery") then
        return 0;
    end;

    local MasteryProgress = p12:GetMasteryProgress(p13, p14);

    return math.floor(MasteryProgress);
end;

function u3.GetMultipliers(p15: table, p16: string, p17: number) -- Line: 101
    -- upvalues: UpdateService (copy), u3 (copy)
    if UpdateService:IsHiddenFromUpdate("Crop Mastery") then
        return {
            WeightMultiplier = 1,
            GrowSpeedMultiplier = 1
        };
    end;

    local CropConfig = u3:GetCropConfig(p16);
    local v18 = CropConfig.Levels[p17] or CropConfig.Levels[1];

    return {
        WeightMultiplier = v18.WeightMultiplier or 1,
        GrowSpeedMultiplier = v18.GrowSpeedMultiplier or 1
    };
end;

local function DeepMerge(p19, p20) -- Line: 121
    -- upvalues: DeepMerge (copy)
    local v21 = {};

    for i, v in pairs(p19) do
        if type(v) == "table" then
            v21[i] = DeepMerge(v, {});
        else
            v21[i] = v;
        end;
    end;

    for i, v in pairs(p20) do
        if type(v) == "table" and type(v21[i]) == "table" then
            v21[i] = DeepMerge(v21[i], v);
        else
            v21[i] = v;
        end;
    end;

    return v21;
end;

local Default = u3.InitialData.Default;

for i, v in pairs(u3.InitialData) do
    if i == "Default" then
        u3.ResolvedCrops[i] = DeepMerge(Default, {});
    else
        u3.ResolvedCrops[i] = DeepMerge(Default, v);
    end;
end;

return u3;