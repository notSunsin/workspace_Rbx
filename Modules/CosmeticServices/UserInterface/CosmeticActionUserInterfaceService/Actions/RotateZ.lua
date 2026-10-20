-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticRotationZUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticRotationZUserInterfaceService);
local CosmeticRotationZService = require(ReplicatedStorage.Modules.CosmeticServices.ModelMovement.CosmeticRotationZService);

return function(u1) -- Line: 6, Name: Loader
    -- upvalues: CosmeticRotationZUserInterfaceService (copy), CosmeticRotationZService (copy)
    return {
        InputBegan = function() -- Line: 8
            -- upvalues: CosmeticRotationZUserInterfaceService (ref), u1 (copy), CosmeticRotationZService (ref)
            CosmeticRotationZUserInterfaceService:Toggle(true);
            u1:Toggle(false);
            CosmeticRotationZService:SetTarget(u1.Target);
        end,

        InputEnded = function() -- Line: 14
            -- upvalues: CosmeticRotationZUserInterfaceService (ref), u1 (copy), CosmeticRotationZService (ref)
            CosmeticRotationZUserInterfaceService:Toggle(false);
            u1:Toggle(true);
            CosmeticRotationZService:SetTarget(nil);
        end
    };
end;