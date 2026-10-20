-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);
local CalculatePetValue = require(ReplicatedStorage.Modules.CalculatePetValue);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);

return {
    Pet = function(p1) -- Line: 10
        -- upvalues: CalculatePetValue (copy)
        return CalculatePetValue(p1.data);
    end,

    Holdable = function(p2) -- Line: 14
        -- upvalues: Calculate_Weight (copy), CalculatePlantValue (copy), MutationHandler (copy)
        local v3 = Calculate_Weight.Calculate_Weight(p2.data.Seed, p2.data.ItemName) * (p2.data.WeightMultiplier or 1);

        return CalculatePlantValue({
            name = p2.data.ItemName,
            variant = p2.data.Variant,
            weight = v3,
            mutationMultiplier = MutationHandler:CalcValueMultiFromMuts(MutationHandler:ExtractMutationsFromString(p2.data.MutationString)),
            fruitVersion = p2.data.FruitVersion
        });
    end,

    ["Packaged Seed"] = function(p4) -- Line: 26
        return 0;
    end
};