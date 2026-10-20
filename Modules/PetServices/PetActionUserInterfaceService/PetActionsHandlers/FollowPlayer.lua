-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local LocalPlayer = Players.LocalPlayer;

return {
    Verifier = function(p1: userdata) -- Line: 10, Name: Verifier
        -- upvalues: LocalPlayer (copy)
        return p1:GetAttribute("OWNER") == LocalPlayer.Name;
    end,

    Activate = function(p2: userdata) -- Line: 14, Name: Activate
        -- upvalues: ActivePetsService (copy)
        print("Follow Player");
        ActivePetsService:SetPetState(p2:GetAttribute("UUID"), "FollowPlayer");
    end
};