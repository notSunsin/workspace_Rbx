-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService);
local LocalPlayer = Players.LocalPlayer;

return {
    Verifier = function(p1: userdata) -- Line: 9, Name: Verifier
        -- upvalues: LocalPlayer (copy)
        return p1:GetAttribute("OWNER") == LocalPlayer.Name;
    end,

    Activate = function(p2: userdata) -- Line: 14, Name: Activate
        -- upvalues: PetsService (copy)
        PetsService:UnequipPet(p2:GetAttribute("UUID"));
    end
};