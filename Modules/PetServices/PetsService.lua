-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("ReplicatedStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PetsService = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("PetsService");
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Types.PetTypes);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);

function v1.EquipPet(p2: table, p3: string, p4) -- Line: 14
    -- upvalues: PetsService (copy)
    PetsService:FireServer("EquipPet", p3, p4);
end;

function v1.UnequipPet(p5: table, p6: string) -- Line: 18
    -- upvalues: PetsService (copy)
    PetsService:FireServer("UnequipPet", p6);
end;

local function GetPlayerPetData(p7: string) -- Line: 22
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local PetsData = Data.PetsData;

    if not PetsData then
        return;
    end;

    local v8 = PetsData.PetInventory.Data[p7];

    if v8 then
        return v8;
    end;
end;

function v1.GetPlayerPetData(p9: table, p10: string) -- Line: 32
    -- upvalues: GetPlayerPetData (copy)
    return GetPlayerPetData(p10);
end;

function v1.CalculateBoost(p11: table, p12: string, p13: any) -- Line: 36
    -- upvalues: DataService (copy), PetMutationRegistry (copy)
    local Data = DataService:GetData();
    local v14;

    if Data then
        local PetsData = Data.PetsData;

        if PetsData then
            v14 = PetsData.PetInventory.Data[p12] or nil;
        else
            v14 = nil;
        end;
    else
        v14 = nil;
    end;

    if not v14 then
        return 1;
    end;

    local Boosts = v14.PetData.Boosts;

    if not Boosts then
        return 1;
    end;

    local v15 = 1;

    for _, v in Boosts do
        if v.BoostType == p13 then
            v15 = v15 + v.BoostAmount;
        end;
    end;

    local MutationType = v14.PetData.MutationType;

    if MutationType then
        local v16 = PetMutationRegistry.PetMutationRegistry[PetMutationRegistry.EnumToPetMutation[MutationType]];

        for _, v in v16.Boosts do
            if v.BoostType == p13 then
                v15 = v15 + v.BoostAmount;
            end;
        end;

        print(MutationType, v16.Boosts);
    end;

    return v15;
end;

function v1.GetBoostsOfType(p17: table, p18: userdata, p19: string, p20: any) -- Line: 67
    -- upvalues: DataService (copy), PetMutationRegistry (copy)
    local Data = DataService:GetData();
    local v21;

    if Data then
        local PetsData = Data.PetsData;

        if PetsData then
            v21 = PetsData.PetInventory.Data[p19] or nil;
        else
            v21 = nil;
        end;
    else
        v21 = nil;
    end;

    if not v21 then
        return;
    end;

    local Boosts = v21.PetData.Boosts;

    if Boosts then
        local v22 = {};

        for _, v in Boosts do
            if v.BoostType == p20 then
                table.insert(v22, v);
            end;
        end;

        local MutationType = v21.PetData.MutationType;

        if MutationType then
            for _, v in PetMutationRegistry.PetMutationRegistry[PetMutationRegistry.EnumToPetMutation[MutationType]].Boosts do
                if v.BoostType == p20 then
                    table.insert(v22, v);
                end;
            end;
        end;

        return v22;
    end;
end;

return v1;