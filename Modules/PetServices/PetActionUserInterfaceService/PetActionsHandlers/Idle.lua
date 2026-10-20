-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);

return {
    Activate = function(p1: userdata) -- Line: 7, Name: Activate
        -- upvalues: ActivePetsService (copy)
        ActivePetsService:SetPetState(p1:GetAttribute("UUID"), "Idle");
    end
};