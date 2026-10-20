-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);

return {
    IsEasterSeed = function(p1: string?) -- Line: 11, Name: IsEasterSeed
        -- upvalues: PlantTraitsData (copy)
        local v2;

        if p1 == nil or p1 == "" then
            v2 = false;
        else
            v2 = PlantTraitsData.HasTrait(p1, "EasterSlot");
        end;

        return v2;
    end
};