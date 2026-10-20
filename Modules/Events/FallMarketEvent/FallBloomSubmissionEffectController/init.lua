-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
ReplicatedStorage:WaitForChild("GameEvents").Events.FallMarketEvent.FallBloomProgressed.OnClientEvent:Connect(function() -- Line: 9, Name: OnFallBloomProgressed
    task.spawn(function() -- Line: 10
        local v1 = script.Bloom:Clone();
        v1.Parent = workspace;
        v1.ParticleEmitter:Emit(70);
        game:GetService("Debris"):AddItem(v1, 7);
    end);
end);

return {};