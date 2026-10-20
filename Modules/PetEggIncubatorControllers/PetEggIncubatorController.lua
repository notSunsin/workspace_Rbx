-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PetEggIncubatorService = ReplicatedStorage.GameEvents:WaitForChild("PetEggIncubatorService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local GetPlayerFromFarm = require(ReplicatedStorage.Modules.GetPlayerFromFarm);

return {
    GetMachineData = function(p1: table, p2: userdata) -- Line: 12, Name: GetMachineData
        -- upvalues: DataService (copy)
        if not (p2 and p2.Parent) then
            return;
        end;

        local Attribute = p2.Parent:GetAttribute("CosmeticUUID");

        if not Attribute then
            return;
        end;

        local Data = DataService:GetData();

        if Data then
            return Data.PetsData.PetEggIncubatorData.IncubatorData[Attribute];
        end;
    end,

    SubmitItem = function(p3: table, p4: string) -- Line: 23, Name: SubmitItem
        -- upvalues: PetEggIncubatorService (copy)
        PetEggIncubatorService.SubmitItem:FireServer(p4);
    end,

    InputEgg = function(p5: table, p6: string) -- Line: 27, Name: InputEgg
        -- upvalues: PetEggIncubatorService (copy)
        PetEggIncubatorService.InputEgg:FireServer(p6);
    end,

    RemoveEgg = function(p7: table, p8: string) -- Line: 31, Name: RemoveEgg
        -- upvalues: PetEggIncubatorService (copy)
        PetEggIncubatorService.RemoveEgg:FireServer(p8);
    end,

    Boost = function(p9: table, p10: userdata) -- Line: 35, Name: Boost
        -- upvalues: GetPlayerFromFarm (copy), PetEggIncubatorService (copy)
        if not p10.Parent then
            return;
        end;

        local Attribute = p10.Parent:GetAttribute("CosmeticUUID");

        if not Attribute then
            return;
        end;

        local v11 = p10:FindFirstAncestorOfClass("Model");

        if not v11 then
            return;
        end;

        local v12 = GetPlayerFromFarm(v11);

        if not v12 then
            return;
        end;

        PetEggIncubatorService.Boost:FireServer(v12, Attribute);
    end
};