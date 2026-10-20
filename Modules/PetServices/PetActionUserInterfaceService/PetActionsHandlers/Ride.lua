-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.Modules.PetServices.PetsService);
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Types.PetTypes);
require(ReplicatedStorage.Modules.Notification);
local _ = ReplicatedStorage.GameEvents.PetBoostService;
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local PetRidingService = require(ReplicatedStorage.Modules.PetServices.PetRidingService);

return {
    Verifier = function(p1: userdata) -- Line: 18, Name: Verifier
        -- upvalues: ActivePetsService (copy), LocalPlayer (copy), PetMutationRegistry (copy)
        local Attribute = p1:GetAttribute("OWNER");
        local PetData = ActivePetsService:GetPetData(LocalPlayer.Name, p1:GetAttribute("UUID"));
        local v2;

        if Attribute == LocalPlayer.Name then
            v2 = PetMutationRegistry.EnumToPetMutation[PetData.MutationType] == "Rideable";
        else
            v2 = false;
        end;

        return v2;
    end,

    Activate = function(p3: userdata) -- Line: 25, Name: Activate
        -- upvalues: PetRidingService (copy)
        PetRidingService:RidePet(p3:GetAttribute("UUID"));
    end
};