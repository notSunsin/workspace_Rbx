-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SeedPackRewardTrackUIController = require(ReplicatedStorage.Modules.SeedPackRewardTrackUIController);
require(ReplicatedStorage.Modules.GameConfigController);
local PlantAnimationController = require(ReplicatedStorage.Modules.Events.AngryPlantEvent.PlantAnimationController);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local AnimateAngryPlant = ReplicatedStorage.GameEvents.Events.AngryPlantEvent.AnimateAngryPlant;
local u1 = Trove.new();
local u5 = {
    Start = function(p2) -- Line: 21, Name: Start
        -- upvalues: EventRotationUtils (copy), u1 (copy), AnimateAngryPlant (copy), PlantAnimationController (copy), SeedPackRewardTrackUIController (copy)
        local u3 = EventRotationUtils:GetEventIDModels("AngryPlantEvent")[1]:QueryDescendants(".AngryPlantHeadBase")[1];
        u1:Add(AnimateAngryPlant.OnClientEvent:Connect(function(p4: string) -- Line: 25
            -- upvalues: PlantAnimationController (ref), u3 (copy)
            if p4 == "Spit" then
                PlantAnimationController:PlaySpitAnimation(u3);

                return;
            end;

            if p4 == "Bite" then
                PlantAnimationController:PlayBiteAnimation(u3);
            end;
        end));
        SeedPackRewardTrackUIController:SetUpSeedPackRewardTrack("AngryPlantEvent", "AngryPlantConfig");
    end
};
local u6 = false;
EventRotationController.EventUpdated:Connect(function(p7: string, p8: string) -- Line: 37, Name: OnEventUpdated
    -- upvalues: u1 (copy), u6 (ref), u5 (copy)
    if p8 ~= "AngryPlantEvent" then
        u1:Clean();
        u6 = false;

        return;
    end;

    if u6 then
        return;
    end;

    u6 = true;
    u1:Clean();
    task.spawn(u5.Start, u5);
end);

return u5;