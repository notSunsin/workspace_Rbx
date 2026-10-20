-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticService = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticService);
local PlaySound = require(ReplicatedStorage.Modules.PlaySound);
local CosmeticPickupEffect = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticPickupEffect);
local Random_new_ret = Random.new();

return function(u1) -- Line: 9, Name: Loader
    -- upvalues: CosmeticPickupEffect (copy), CosmeticService (copy), PlaySound (copy), Random_new_ret (copy)
    return {
        InputBegan = function() -- Line: 11
        end,

        InputEnded = function() -- Line: 14
            -- upvalues: u1 (copy), CosmeticPickupEffect (ref), CosmeticService (ref), PlaySound (ref), Random_new_ret (ref)
            local Target = u1.Target;

            if not Target then
                return;
            end;

            local Parent = Target.Parent;

            if not Parent then
                return;
            end;

            local Attribute = Parent:GetAttribute("CosmeticUUID");
            CosmeticPickupEffect:Play(Attribute);
            CosmeticService:Unequip(Attribute);
            u1:Toggle(false);
            PlaySound("rbxassetid://139578759536123", Random_new_ret:NextNumber(0.8, 1.2)).Volume = 0.5;
        end,

        InstantAction = true
    };
end;