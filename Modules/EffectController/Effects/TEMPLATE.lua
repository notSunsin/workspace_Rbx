-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.EffectController.Types);

return {
    PlayTestEffect = function(p1) -- Line: 21, Name: PlayTestEffect
    end,

    Cancel = function(p2) -- Line: 39, Name: Cancel
        p2.Container:Clean();
        p2.Cache = {};
    end
};