-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PetIncubatorService = ReplicatedStorage.GameEvents:WaitForChild("PetIncubatorService");
local DataService = require(ReplicatedStorage.Modules.DataService);

return {
    GetMachineData = function(p1: table, p2: userdata) -- Line: 10, Name: GetMachineData
        -- upvalues: DataService (copy)
        if not p2 then
            return;
        end;

        local Attribute = p2.Parent:GetAttribute("CosmeticUUID");

        if not Attribute then
            return;
        end;

        local Data = DataService:GetData();

        if Data then
            return Data.PetsData.PetIncubatorData.IncubatorData[Attribute];
        end;
    end,

    InputPet = function(p3: table, p4: userdata) -- Line: 22, Name: InputPet
        -- upvalues: PetIncubatorService (copy)
        PetIncubatorService.InputPet:FireServer(p4);
    end,

    SubmitItem = function(p5: table, p6: userdata) -- Line: 26, Name: SubmitItem
        -- upvalues: PetIncubatorService (copy)
        PetIncubatorService.SubmitItem:FireServer(p6);
    end,

    RemovePet = function(p7: table, p8: userdata) -- Line: 30, Name: RemovePet
        -- upvalues: PetIncubatorService (copy)
        PetIncubatorService.RemovePet:FireServer(p8);
    end,

    Boost = function(p9: table, p10: userdata) -- Line: 34, Name: Boost
        -- upvalues: PetIncubatorService (copy)
        PetIncubatorService.Boost:FireServer(p10);
    end
};