-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local BeanstalkPermissionModule = require(ReplicatedStorage.Modules.Events.BeanstalkEvent.BeanstalkPermissionModule);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local RE_BeanstalkTeleportRequest = ReplicatedStorage.GameEvents.Events.BeanstalkEvent.RE_BeanstalkTeleportRequest;
local LocalPlayer = Players.LocalPlayer;
local u6 = {
    Start = function(p2) -- Line: 31, Name: Start
        -- upvalues: CollectionService (copy), BeanstalkPermissionModule (copy), LocalPlayer (copy), u1 (copy), RE_BeanstalkTeleportRequest (copy), Notification (copy), DataService (copy)
        local Tagged = CollectionService:GetTagged("BeanstalkPortalModel");

        local function ActivateAllPortals() -- Line: 36
            -- upvalues: Tagged (copy), BeanstalkPermissionModule (ref), LocalPlayer (ref)
            for _, v in Tagged do
                v:FindFirstChild("PortalPrompt"):FindFirstChild("ProximityPrompt").Enabled = true;

                if BeanstalkPermissionModule:GetPlayerContributions(LocalPlayer) >= BeanstalkPermissionModule.REQUIRED_CONTRIBUTIONS then
                    for _, descendant in v:FindFirstChild("PortalFX"):GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = true;
                        end;
                    end;
                end;
            end;
        end;

        local function DeactivateAllPortals() -- Line: 58
            -- upvalues: Tagged (copy)
            for _, v in Tagged do
                v:FindFirstChild("PortalPrompt"):FindFirstChild("ProximityPrompt");

                for _, descendant in v:FindFirstChild("PortalFX"):GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end;

        (function() -- Line: 73, Name: SetUpProxPrompts
            -- upvalues: Tagged (copy), u1 (ref), BeanstalkPermissionModule (ref), RE_BeanstalkTeleportRequest (ref), Notification (ref)
            for _, v in Tagged do
                u1:Add(v:FindFirstChild("PortalPrompt"):FindFirstChild("ProximityPrompt").Triggered:Connect(function(p3: userdata) -- Line: 79
                    -- upvalues: BeanstalkPermissionModule (ref), RE_BeanstalkTeleportRequest (ref), v (copy), Notification (ref)
                    if BeanstalkPermissionModule:CanUseBeanstalkPortal(p3) then
                        RE_BeanstalkTeleportRequest:FireServer(v);

                        return;
                    end;

                    local PlayerContributions = BeanstalkPermissionModule:GetPlayerContributions(p3);

                    if PlayerContributions >= BeanstalkPermissionModule.REQUIRED_CONTRIBUTIONS then
                        Notification:CreateNotification("Portal cannot be used right now.");

                        return;
                    end;

                    local v4 = BeanstalkPermissionModule.REQUIRED_CONTRIBUTIONS - PlayerContributions;
                    Notification:CreateNotification((`Portal unlocks after you contribute {v4} more {v4 == 1 and "growth" or "growths"}!`));
                end));
            end;
        end)();

        if BeanstalkPermissionModule:CanSeeBeanstalkPortal(LocalPlayer) then
            ActivateAllPortals();
        else
            DeactivateAllPortals();
        end;

        u1:Add(workspace.AttributeChanged:Connect(function(p5: string) -- Line: 111
            -- upvalues: BeanstalkPermissionModule (ref), LocalPlayer (ref), ActivateAllPortals (copy), DeactivateAllPortals (copy)
            if p5 ~= "ActivateBeanstalk" then
                return;
            end;

            if BeanstalkPermissionModule:CanSeeBeanstalkPortal(LocalPlayer) then
                ActivateAllPortals();

                return;
            end;

            DeactivateAllPortals();
        end));
        u1:Add(DataService:GetPathSignal("BeanstalkEvent/EventsContributed"):Connect(function() -- Line: 120
            -- upvalues: BeanstalkPermissionModule (ref), LocalPlayer (ref), ActivateAllPortals (copy), DeactivateAllPortals (copy)
            if not BeanstalkPermissionModule:CanSeeBeanstalkPortal(LocalPlayer) then
                return;
            end;

            if BeanstalkPermissionModule:GetPlayerContributions(LocalPlayer) >= BeanstalkPermissionModule.REQUIRED_CONTRIBUTIONS then
                ActivateAllPortals();

                return;
            end;

            DeactivateAllPortals();
        end));
    end
};
local u7 = false;
EventRotationController.EventUpdated:Connect(function(p8: string, p9: string) -- Line: 133, Name: OnEventUpdated
    -- upvalues: u1 (copy), u7 (ref), u6 (copy)
    if p9 ~= "BeanstalkEvent" then
        u1:Clean();
        u7 = false;

        return;
    end;

    if u7 then
        return;
    end;

    u7 = true;
    u1:Clean();
    task.spawn(u6.Start, u6);
end);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent and LoadedEvent.EventSet == "BeanstalkEvent" then
    local _ = LoadedEvent.EventID;

    if LoadedEvent.EventSet == "BeanstalkEvent" then
        if not u7 then
            u7 = true;
            u1:Clean();
            task.spawn(u6.Start, u6);
        end;
    else
        u1:Clean();
        u7 = false;
    end;
end;

return u6;