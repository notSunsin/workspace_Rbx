-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PlayerTeleportTriggered = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("PlayerTeleportTriggered");

return function(u1: userdata, u2, u3: string) -- Line: 8
    -- upvalues: RunService (copy), PlayerTeleportTriggered (copy)
    local Character = u1.Character;

    if not Character then
        return;
    end;

    local Humanoid = Character:WaitForChild("Humanoid", 1);

    if not Humanoid then
        return;
    end;

    if workspace:GetAttribute("Stoplight") or (Character:GetAttribute("EasterEggHunt_CARRYING") or (Character:GetAttribute("SummerChestHunt_CARRYING") or (Character:GetAttribute("Anniversary20th_CarryCount") or 0) > 0)) then
        return;
    end;

    if Humanoid.Sit then
        Humanoid.Sit = false;
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false);
        task.delay(0.1, function() -- Line: 21
            -- upvalues: Humanoid (copy), Character (copy), u2 (copy), RunService (ref), u1 (copy), u3 (copy), PlayerTeleportTriggered (ref)
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true);
            Character:PivotTo(u2);

            if RunService:IsServer() then
                require(game.ServerScriptService.Modules.PlayerTeleportObserverService):NotifyTeleport(u1, u3);

                return;
            end;

            PlayerTeleportTriggered:FireServer(u3);
        end);

        return;
    end;

    Character:PivotTo(u2);

    if RunService:IsServer() then
        require(game.ServerScriptService.Modules.PlayerTeleportObserverService):NotifyTeleport(u1, u3);

        return;
    end;

    PlayerTeleportTriggered:FireServer(u3);
end;