-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local _ = Players.LocalPlayer;
local BeeEventConfig = require(ReplicatedStorage.Data.BeeEvent.BeeEventConfig);
local _ = BeeEventConfig.Enemies.GuardRadius;
local BobAmplitude = BeeEventConfig.Swarm.BobAmplitude;
local BobFrequency = BeeEventConfig.Swarm.BobFrequency;
local _ = BeeEventConfig.Enemies.AlertRadius;

return function(p1) -- Line: 13
    -- upvalues: BobFrequency (copy), BobAmplitude (copy)
    return function(p2: string, p3: number, p4: table) -- Line: 14
        -- upvalues: BobFrequency (ref), BobAmplitude (ref)
        for _, v in p4 do
            if v.Server.GuardObject and v.Server.GuardObject:IsA("PVInstance") then
                local ServerTimeNow = workspace:GetServerTimeNow();
                local v5 = math.sin(ServerTimeNow * BobFrequency + v.Server.Identifier * 2.39996 % 6.283185307179586) * BobAmplitude;
                v.Client.RenderOffset = CFrame.new(0, v5, 0);
                v.Client.LockFacing = false;
                v.Client.TargetFacingDirection = nil;
                v.Client.PredictedCFrame = nil;
            else
                warn("\"Guarding\" state must have a PVInstance set in the Custom field");
            end;
        end;
    end;
end;