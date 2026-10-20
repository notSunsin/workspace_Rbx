-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticMovementUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticMovementUserInterfaceService);
require(ReplicatedStorage.Modules.GetMouseToWorld);
local CosmeticMovementService = require(ReplicatedStorage.Modules.CosmeticServices.ModelMovement.CosmeticMovementService);
local PlaySound = require(ReplicatedStorage.Modules.PlaySound);

return function(u1) -- Line: 9, Name: Loader
    -- upvalues: CosmeticMovementUserInterfaceService (copy), CosmeticMovementService (copy), PlaySound (copy)
    return {
        InputBegan = function() -- Line: 11
            -- upvalues: CosmeticMovementUserInterfaceService (ref), u1 (copy), CosmeticMovementService (ref)
            CosmeticMovementUserInterfaceService:Toggle(true);
            u1:Toggle(false);
            CosmeticMovementService:SetTarget(u1.Target);
        end,

        InputEnded = function() -- Line: 16
            -- upvalues: CosmeticMovementUserInterfaceService (ref), u1 (copy), CosmeticMovementService (ref), PlaySound (ref)
            CosmeticMovementUserInterfaceService:Toggle(false);
            u1:Toggle(true);
            CosmeticMovementService:SetTarget(nil);
            PlaySound("rbxassetid://99990810464653").Volume = 0.5;
        end
    };
end;