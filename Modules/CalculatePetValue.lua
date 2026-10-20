-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Item_Module);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local u1 = RunService:IsServer() and require(ServerScriptService.Modules.PetsServices.PetsService);
local u2 = RunService:IsClient() and require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);

local function CalculatePetValueFromValues(p3: table) -- Line: 16
    -- upvalues: PetRegistry (copy), NumberUtil (copy), PetUtilities (copy)
    local v4 = 1;
    local HatchedFrom = p3.HatchedFrom;

    if HatchedFrom and HatchedFrom ~= "" then
        local v5 = PetRegistry.PetEggs[HatchedFrom];
        local v6 = v5 and v5.RarityData and v5.RarityData.Items[p3.PetType];
        local v7 = v6 and v6.GeneratedPetData and v6.GeneratedPetData.WeightRange;

        if v7 then
            local v8 = NumberUtil.ReverseLerp(v7[1], v7[2], p3.BaseWeight);
            v4 = math.lerp(0.8, 1.2, v8);
        end;
    end;

    local LevelProgress = PetUtilities:GetLevelProgress(p3.Level);
    local math_lerp_ret = math.lerp(0.15, 6, LevelProgress);
    local v9 = PetRegistry.PetList[p3.PetType];

    if v9 then
        local v10 = (tonumber(v9.SellPrice) or 0) * v4 * math_lerp_ret;

        return math.floor(v10);
    end;

    warn((`CalculatePetValue | PetType {p3.PetType} missing from PetList!`));

    return 0;
end;

return function(p11) -- Line: 52, Name: CalculatePetValue
    -- upvalues: Players (copy), RunService (copy), u1 (copy), u2 (copy), CalculatePetValueFromValues (copy)
    if not p11 then
        warn("CalculatePetValue | No Pet Tool given!");

        return 0;
    end;

    local v12;

    if type(p11) == "table" then
        v12 = p11;
    else
        v12 = nil;
    end;

    if typeof(p11) == "Instance" then
        local v13 = Players:GetPlayerFromCharacter((p11:FindFirstAncestorWhichIsA("Model"))) or p11:FindFirstAncestorWhichIsA("Player");

        if not v13 then
            warn("CalculatePetValue | No Player Ancestor found!");

            return 0;
        end;

        local Attribute = p11:GetAttribute("PET_UUID");

        if not Attribute then
            warn("CalculatePetValue | No UUID!");

            return 0;
        end;

        if RunService:IsServer() then
            v12 = u1:GetPlayerPetData(v13, Attribute);
        else
            v12 = u2:GetData().PetsData.PetInventory.Data[Attribute];
        end;

        if not v12 then
            warn("CalculatePetValue | No pet data found!");

            return 0;
        end;
    end;

    return CalculatePetValueFromValues({
        PetType = v12.PetType,
        HatchedFrom = v12.PetData.HatchedFrom,
        BaseWeight = v12.PetData.BaseWeight,
        Level = v12.PetData.Level
    });
end;