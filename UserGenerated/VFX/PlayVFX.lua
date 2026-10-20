-- Decompiled with Potassium's decompiler.

local Debris = game:GetService("Debris");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emit = require(ReplicatedStorage.UserGenerated.VFX.Emit);

return function(p1: userdata, p2, p3: userdata) -- Line: 25, Name: PlayVFX
    -- upvalues: Debris (copy), Emit (copy)
    local Attachment = Instance.new("Attachment");
    Attachment.CFrame = p1.CFrame:ToObjectSpace(p2);

    for _, descendant in ipairs(p3:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Parent = Attachment;
        end;
    end;

    if p3:IsA("ParticleEmitter") then
        p3.Parent = Attachment;
    else
        p3:Destroy();
    end;

    Attachment.Parent = p1;
    Debris:AddItem(Attachment, Emit(Attachment));
end;