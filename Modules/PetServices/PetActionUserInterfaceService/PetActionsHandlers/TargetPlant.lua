-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local GeneralTargettingService = require(ReplicatedStorage.Modules.GeneralTargettingService);

return {
    Activate = function(u1: userdata) -- Line: 7, Name: Activate
        -- upvalues: GeneralTargettingService (copy), ActivePetsService (copy)
        GeneralTargettingService:CreateTargetingHandler({
            TargetType = "Plant",

            OnConfirm = function(p2) -- Line: 9, Name: OnConfirm
                -- upvalues: ActivePetsService (ref), u1 (copy)
                print("Confirmed", p2);
                ActivePetsService:SetPetState(u1:GetAttribute("UUID"), "TargetPlant", {
                    TargetedPlant = p2
                });
            end,

            OnCancelled = function(...) -- Line: 16, Name: OnCancelled
                print("Cancelled");
            end,

            Targeter = u1
        });
    end
};