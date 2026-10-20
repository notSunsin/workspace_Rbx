-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.Modules.PetServices.PetsService);
require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local Notification = require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Types.PetTypes);
local PetBoostService = ReplicatedStorage.GameEvents.PetBoostService;

return {
    Verifier = function(p1: userdata) -- Line: 14, Name: Verifier
        -- upvalues: LocalPlayer (copy)
        local Character = LocalPlayer.Character;

        if not Character then
            warn("No Character? how?");

            return;
        end;

        local v2 = Character:FindFirstChildWhichIsA("Tool");

        if v2 then
            local v3;

            if p1:GetAttribute("OWNER") == LocalPlayer.Name then
                v3 = v2:HasTag("PetBoost");
            else
                v3 = false;
            end;

            return v3;
        end;
    end,

    Activate = function(p4: userdata) -- Line: 29, Name: Activate
        -- upvalues: LocalPlayer (copy), Notification (copy), PetBoostService (copy)
        local Character = LocalPlayer.Character;

        if not Character then
            warn("No Character? how?");

            return;
        end;

        local v5 = Character:FindFirstChildWhichIsA("Tool");

        if not v5 then
            return Notification:CreateNotification("You are not holding a pet boost!");
        end;

        if not v5:HasTag("PetBoost") then
            return Notification:CreateNotification("You are not holding a pet boost!");
        end;

        PetBoostService:FireServer("ApplyBoost", p4:GetAttribute("UUID"));
    end
};