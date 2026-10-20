-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticMovementService = require(ReplicatedStorage.Modules.CosmeticServices.ModelMovement.CosmeticMovementService);
local PlaySound = require(ReplicatedStorage.Modules.PlaySound);

return function(u1) -- Line: 6, Name: Loader
    -- upvalues: CosmeticMovementService (copy), PlaySound (copy)
    return {
        InputBegan = function() -- Line: 8
            -- upvalues: CosmeticMovementService (ref), u1 (copy), PlaySound (ref)
            CosmeticMovementService:SetTarget(u1.Target);
            CosmeticMovementService:Nudge(Vector3.new(0, 0, -1));
            CosmeticMovementService:SetTarget(nil);
            PlaySound("rbxassetid://99990810464653").Volume = 0.5;
        end,

        InputEnded = function() -- Line: 15
        end
    };
end;