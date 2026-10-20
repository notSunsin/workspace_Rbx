-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ParticleHelper = require(ReplicatedStorage.Modules.Utility.ParticleHelper);

return {
    PlayBeeVFX = function(p1: table, p2: userdata) -- Line: 7, Name: PlayBeeVFX
        -- upvalues: ParticleHelper (copy)
        ParticleHelper:EmitParticles(p2);
    end
};