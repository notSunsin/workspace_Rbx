-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.PetServices.PetsService);
local LocalPlayer = Players.LocalPlayer;
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local PetBoostService = ReplicatedStorage.GameEvents.PetBoostService;

return {
    Verifier = function(p1: userdata) -- Line: 15, Name: Verifier
        -- upvalues: LocalPlayer (copy)
        return p1:GetAttribute("OWNER") == LocalPlayer.Name;
    end,

    Activate = function(p2: userdata) -- Line: 20, Name: Activate
        -- upvalues: LocalPlayer (copy), PetBoostService (copy), Notification (copy), ActivePetsService (copy)
        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        local v3 = Character:FindFirstChildWhichIsA("Tool");

        if v3 and v3:HasTag("PetBoost") then
            PetBoostService:FireServer("ApplyBoost", p2:GetAttribute("UUID"));

            return;
        end;

        if not v3 then
            return Notification:CreateNotification("You are not holding a fruit!");
        end;

        if not v3:HasTag("FruitTool") then
            return Notification:CreateNotification("You are not holding a fruit!");
        end;

        ActivePetsService:Feed(p2:GetAttribute("UUID"));
    end
};