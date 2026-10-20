-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.CosmeticServices.CosmeticService);
local PlaySound = require(ReplicatedStorage.Modules.PlaySound);
local CosmeticRotationLockUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticRotationLockUserInterfaceService);
local CosmeticMovementService = require(ReplicatedStorage.Modules.CosmeticServices.ModelMovement.CosmeticMovementService);

return function(p1) -- Line: 10, Name: Loader
    -- upvalues: CosmeticRotationLockUserInterfaceService (copy), PlaySound (copy), CosmeticMovementService (copy)
    return {
        InputBegan = function() -- Line: 12
        end,

        InputEnded = function() -- Line: 14
            -- upvalues: CosmeticRotationLockUserInterfaceService (ref), PlaySound (ref), CosmeticMovementService (ref)
            local v2 = CosmeticRotationLockUserInterfaceService:Toggle();
            PlaySound("rbxassetid://103926661258479", v2 and Random.new():NextNumber(1, 1.1) or Random.new():NextNumber(0.8, 0.9)).Volume = 0.25;
            CosmeticMovementService:ToggleRotationLock(v2);
        end,

        InstantAction = true
    };
end;