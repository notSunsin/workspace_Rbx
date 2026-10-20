-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CravingUtils = require(ReplicatedStorage.Modules.CravingControllers.CravingUtils);
local ColorHelper = require(ReplicatedStorage.Modules.ColorHelper);
local u3 = {
    GetCravingConfig = function(p1, p2) -- Line: 23, Name: GetCravingConfig
        return {
            Options = p2.Traits,
            Interval = p2.CravingRefresh,
            HashNum = p2.RANDOM_SEED_VALUE or 8143
        };
    end
};

function u3.GetTrait(p4, p5) -- Line: 31
    -- upvalues: CravingUtils (copy), u3 (copy)
    return CravingUtils:GetCurrentCraving(u3:GetCravingConfig(p5));
end;

function u3.GetBubbleDisplayData(p6, p7) -- Line: 36
    -- upvalues: u3 (copy), ColorHelper (copy)
    local Trait = u3:GetTrait(p7);
    local TraitColor, v8 = ColorHelper:GetTraitColor(Trait);

    return TraitColor or "#ffffff", Trait, Color3.fromRGB(v8[1] or 255, v8[2] or 255, v8[3] or 255):Lerp(Color3.fromRGB(255, 255, 255), 0.75);
end;

return u3;