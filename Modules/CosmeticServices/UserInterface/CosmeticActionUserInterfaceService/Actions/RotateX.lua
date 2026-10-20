-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticRotationXUserInterfaceService = require(ReplicatedStorage.Modules.CosmeticServices.UserInterface.CosmeticRotationXUserInterfaceService);
local CosmeticRotationXService = require(ReplicatedStorage.Modules.CosmeticServices.ModelMovement.CosmeticRotationXService);

return function(u1) -- Line: 6, Name: Loader
    -- upvalues: CosmeticRotationXUserInterfaceService (copy), CosmeticRotationXService (copy)
    return {
        InputBegan = function() -- Line: 8
            -- upvalues: CosmeticRotationXUserInterfaceService (ref), u1 (copy), CosmeticRotationXService (ref)
            CosmeticRotationXUserInterfaceService:Toggle(true);
            u1:Toggle(false);
            CosmeticRotationXService:SetTarget(u1.Target);
        end,

        InputEnded = function() -- Line: 14
            -- upvalues: CosmeticRotationXUserInterfaceService (ref), u1 (copy), CosmeticRotationXService (ref)
            CosmeticRotationXUserInterfaceService:Toggle(false);
            u1:Toggle(true);
            CosmeticRotationXService:SetTarget(nil);
        end
    };
end;