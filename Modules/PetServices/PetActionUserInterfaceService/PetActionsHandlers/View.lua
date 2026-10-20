-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local PetCardUserInterfaceService = require(ReplicatedStorage.Modules.PetServices.PetCardUserInterfaceService);
local ActivePetsUIController = require(ReplicatedStorage.Modules.ActivePetsUIController);

return {
    Activate = function(p1: userdata) -- Line: 8, Name: Activate
        -- upvalues: PetCardUserInterfaceService (copy), ActivePetsUIController (copy)
        PetCardUserInterfaceService:SetTarget(p1);
        PetCardUserInterfaceService:Toggle(true);
        ActivePetsUIController:Close();
    end
};