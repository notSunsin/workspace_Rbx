-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticRotationYUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticRotationYUserInterfaceService);
local CosmeticRotationYService = require(ReplicatedStorage.Modules.CosmeticServices.ModelMovement.CosmeticRotationYService);

return function(u1) -- Line: 6, Name: Loader
    -- upvalues: CosmeticRotationYUserInterfaceService (copy), CosmeticRotationYService (copy)
    return {
        InputBegan = function() -- Line: 8
            -- upvalues: CosmeticRotationYUserInterfaceService (ref), u1 (copy), CosmeticRotationYService (ref)
            CosmeticRotationYUserInterfaceService:Toggle(true);
            u1:Toggle(false);
            CosmeticRotationYService:SetTarget(u1.Target);
        end,

        InputEnded = function() -- Line: 14
            -- upvalues: CosmeticRotationYUserInterfaceService (ref), u1 (copy), CosmeticRotationYService (ref)
            CosmeticRotationYUserInterfaceService:Toggle(false);
            u1:Toggle(true);
            CosmeticRotationYService:SetTarget(nil);
        end
    };
end;