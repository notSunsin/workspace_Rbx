-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local BeeEventConfig = require(ReplicatedStorage.Data.BeeEvent.BeeEventConfig);
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
require(ReplicatedStorage.Modules.Utility.ParticleHelper);
local _ = BeeEventConfig.Enemies.AttackRadius;
local AttackCooldownRadius = BeeEventConfig.Enemies.AttackCooldownRadius;
local _ = BeeEventConfig.Swarm.HeightMin;
local _ = BeeEventConfig.Swarm.HeightMax;
local AttackSpinMaxMagnitude = BeeEventConfig.Enemies.AttackSpinMaxMagnitude;
script.Parent.Parent:WaitForChild("VFX");

local function GetWaspWaveSpawnField() -- Line: 18
    local Interaction = workspace:FindFirstChild("Interaction");

    if not Interaction then
        return nil;
    end;

    local WaspWaveArena = Interaction:FindFirstChild("WaspWaveArena");

    if not WaspWaveArena then
        return nil;
    end;

    local SpawnField = WaspWaveArena:FindFirstChild("SpawnField");

    if SpawnField and SpawnField:IsA("BasePart") then
        return SpawnField;
    end;

    return nil;
end;

local function ClampSurvivalWaspToSpawnFieldXZ(p1: string, p2: vector) -- Line: 33
    if p1 ~= "wasp-wave-survival" then
        return p2;
    end;

    local Interaction = workspace:FindFirstChild("Interaction");
    local v3;

    if Interaction then
        local WaspWaveArena = Interaction:FindFirstChild("WaspWaveArena");

        if WaspWaveArena then
            v3 = WaspWaveArena:FindFirstChild("SpawnField");

            if not (v3 and v3:IsA("BasePart")) then
                v3 = nil;
            end;
        else
            v3 = nil;
        end;
    else
        v3 = nil;
    end;

    if not v3 then
        return p2;
    end;

    local v4 = v3.CFrame:PointToObjectSpace(p2);
    local math_max_ret = math.max(0, v3.Size.X * 0.5 - 4);
    local math_max_ret2 = math.max(0, v3.Size.Z * 0.5 - 4);
    local math_clamp_ret = math.clamp(v4.X, -math_max_ret, math_max_ret);
    local Y = v4.Y;
    local math_clamp_ret2 = math.clamp(v4.Z, -math_max_ret2, math_max_ret2);
    local Vector3_new_ret = Vector3.new(math_clamp_ret, Y, math_clamp_ret2);
    local v5 = v3.CFrame:PointToWorldSpace(Vector3_new_ret);

    return Vector3.new(v5.X, p2.Y, v5.Z);
end;

return function(u6) -- Line: 60
    -- upvalues: BeeRegistry (copy), AttackCooldownRadius (copy), AttackSpinMaxMagnitude (copy), ClampSurvivalWaspToSpawnFieldXZ (copy)
    local function playAttackSoundEffect(p7) -- Line: 61
        local Client = p7.Client;
        local Server = p7.Server;

        if not Server.AttackSound then
            return;
        end;

        Instance.new("Sound");
        local Hitbox = Client.Hitbox;

        if not Hitbox then
            return;
        end;

        if not Client.AttacKSound then
            return;
        end;

        local Sound = Instance.new("Sound");
        local v8;

        if typeof(Server.AttackSound) == "string" then
            v8 = Server.AttackSound;
        else
            v8 = Server.AttackSound[math.random(1, #Server.AttackSound)];
        end;

        Sound.SoundId = v8;
        Sound.Looped = false;
        Sound.Volume = 0.1;
        Sound.RollOffMaxDistance = 20;
        Sound.Parent = Hitbox;
        Sound:Play();
        Sound.Ended:Once(function() -- Line: 85
            -- upvalues: Sound (copy)
            Sound:Destroy();
        end);
        task.delay(2, function() -- Line: 89
            -- upvalues: Sound (copy)
            if Sound.Parent then
                Sound:Destroy();
            end;
        end);
    end;

    return function(p9: string, p10: number, p11: table) -- Line: 96
        -- upvalues: u6 (copy), BeeRegistry (ref), AttackCooldownRadius (ref), AttackSpinMaxMagnitude (ref), ClampSurvivalWaspToSpawnFieldXZ (ref)
        local v12 = {};

        for _, v in p11 do
            if v.Server.TargetPlayer and v.Server.TargetBee then
                local Entry = u6:GetEntry(v.Server.TargetPlayer, v.Server.TargetBee);

                if Entry and Entry.Server.Health > 0 then
                    if not v12[Entry] then
                        v12[Entry] = {};
                    end;

                    table.insert(v12[Entry], v);
                end;
            end;
        end;

        for i, v in v12 do
            local v13 = i.Client.PredictedCFrame or (i.Client.SmoothedCFrame or i.Server.CFrame);

            for _, v2 in v do
                local v14 = v2.Client.PredictedCFrame or (v2.Client.SmoothedCFrame or v2.Server.CFrame);
                local Position = v13.Position;
                local v15 = (v14.Position - Position) * Vector3.new(1, 0, 1);
                local v16 = v15.Magnitude < 0.01 and Vector3.new(1, 0, 0) or v15;
                local v17 = BeeRegistry[v2.Server.BeeName];

                if v17 then
                    v17 = v17.Stats;
                end;

                local v18;

                if v17 and v17.Ranged then
                    v18 = v17.Range or 30;
                else
                    v18 = AttackCooldownRadius;
                end;

                local v19 = v16.Unit * v18;
                math.randomseed(v2.Server.Identifier);
                local v20 = Position + v19;
                local Vector3_new_ret = Vector3.new(v20.X, Position.Y, v20.Z);
                local v21 = v16:Cross(Vector3.new(0, 1, 0));

                if v21.Magnitude > 0.01 then
                    Vector3_new_ret = Vector3_new_ret + v21.Unit * math.random() * AttackSpinMaxMagnitude;
                end;

                local v22 = ClampSurvivalWaspToSpawnFieldXZ(p9, Vector3_new_ret);
                local Vector3_new_ret2 = Vector3.new(Position.X, v22.Y, Position.Z);

                if (Vector3_new_ret2 - v22).Magnitude > 0.01 then
                    CFrame.lookAt(v22, Vector3_new_ret2);
                else
                    CFrame.new(v22);
                end;

                local Position2 = v14.Position;
                local Magnitude = (v22 - Position2).Magnitude;
                local v23 = v2.Server.Speed * p10;

                if Magnitude > v23 then
                    v22 = Position2:Lerp(v22, v23 / Magnitude);
                end;

                local Vector3_new_ret3 = Vector3.new(Position.X, v22.Y, Position.Z);

                if (Vector3_new_ret3 - v22).Magnitude > 0.01 then
                    v2.Client.PredictedCFrame = CFrame.lookAt(v22, Vector3_new_ret3);
                else
                    v2.Client.PredictedCFrame = CFrame.new(v22);
                end;
            end;
        end;

        for _, v in p11 do
            if v.Client.PredictedCFrame then
                v.Client.PredictedCFrame = v.Client.PredictedCFrame:Lerp(v.Server.CFrame, p10);
            end;

            v.Client.TargetFacingDirection = nil;
            v.Client.LockFacing = false;

            if v.Server.TargetPlayer and v.Server.TargetBee then
                local Entry = u6:GetEntry(v.Server.TargetPlayer, v.Server.TargetBee);

                if Entry and Entry.Server.Health > 0 then
                    local v24 = ((Entry.Client.PredictedCFrame or (Entry.Client.SmoothedCFrame or Entry.Server.CFrame)).Position - (v.Client.PredictedCFrame or (v.Client.SmoothedCFrame or v.Server.CFrame)).Position) * Vector3.new(1, 0, 1);

                    if v24.Magnitude > 0.01 then
                        v.Client.TargetFacingDirection = v24;
                        v.Client.LockFacing = true;
                    end;
                end;
            end;
        end;
    end;
end;