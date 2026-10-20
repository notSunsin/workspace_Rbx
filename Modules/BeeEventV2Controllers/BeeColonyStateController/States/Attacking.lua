-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local _ = Players.LocalPlayer;
local BeeEventConfig = require(ReplicatedStorage.Data.BeeEvent.BeeEventConfig);
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
script.Parent.Parent:WaitForChild("Sounds");
local AttackRadius = BeeEventConfig.Enemies.AttackRadius;
local _ = BeeEventConfig.Enemies.AttackCooldownRadius;
local _ = BeeEventConfig.Swarm.HeightMin;
local _ = BeeEventConfig.Swarm.HeightMax;
local AttackSpinMaxMagnitude = BeeEventConfig.Enemies.AttackSpinMaxMagnitude;

local function IsPlayerKeyOnServer(p1: string) -- Line: 16
    -- upvalues: Players (copy)
    local v2 = string.split(p1, "_")[2];
    local v3 = tonumber(v2);

    return (not v3 or Players:GetPlayerByUserId(v3)) and true or false;
end;

local function GetWaspWaveSpawnField() -- Line: 29
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

local function ClampSurvivalWaspToSpawnFieldXZ(p4: string, p5: vector) -- Line: 44
    if p4 ~= "wasp-wave-survival" then
        return p5;
    end;

    local Interaction = workspace:FindFirstChild("Interaction");
    local v6;

    if Interaction then
        local WaspWaveArena = Interaction:FindFirstChild("WaspWaveArena");

        if WaspWaveArena then
            v6 = WaspWaveArena:FindFirstChild("SpawnField");

            if not (v6 and v6:IsA("BasePart")) then
                v6 = nil;
            end;
        else
            v6 = nil;
        end;
    else
        v6 = nil;
    end;

    if not v6 then
        return p5;
    end;

    local v7 = v6.CFrame:PointToObjectSpace(p5);
    local math_max_ret = math.max(0, v6.Size.X * 0.5 - 4);
    local math_max_ret2 = math.max(0, v6.Size.Z * 0.5 - 4);
    local math_clamp_ret = math.clamp(v7.X, -math_max_ret, math_max_ret);
    local Y = v7.Y;
    local math_clamp_ret2 = math.clamp(v7.Z, -math_max_ret2, math_max_ret2);
    local Vector3_new_ret = Vector3.new(math_clamp_ret, Y, math_clamp_ret2);
    local v8 = v6.CFrame:PointToWorldSpace(Vector3_new_ret);

    return Vector3.new(v8.X, p5.Y, v8.Z);
end;

return function(u9) -- Line: 71
    -- upvalues: Players (copy), BeeRegistry (copy), AttackRadius (copy), AttackSpinMaxMagnitude (copy), ClampSurvivalWaspToSpawnFieldXZ (copy)
    return function(p10: string, p11: number, p12: table) -- Line: 72
        -- upvalues: Players (ref), u9 (copy), BeeRegistry (ref), AttackRadius (ref), AttackSpinMaxMagnitude (ref), ClampSurvivalWaspToSpawnFieldXZ (ref)
        local v13 = {};

        for _, v in p12 do
            if v.Server.TargetPlayer and v.Server.TargetBee then
                local v14 = string.split(v.Server.TargetPlayer, "_")[2];
                local v15 = tonumber(v14);

                if (not v15 or Players:GetPlayerByUserId(v15)) and true or false then
                    local Entry = u9:GetEntry(v.Server.TargetPlayer, v.Server.TargetBee);

                    if Entry and Entry.Server.Health > 0 then
                        if not v13[Entry] then
                            v13[Entry] = {};
                        end;

                        table.insert(v13[Entry], v);
                    end;
                end;
            end;
        end;

        workspace:GetServerTimeNow();

        for i, v in v13 do
            local v16 = i.Client.PredictedCFrame or (i.Client.SmoothedCFrame or i.Server.CFrame);

            for _, v2 in v do
                local v17 = v2.Client.PredictedCFrame or (v2.Client.SmoothedCFrame or v2.Server.CFrame);
                local Position = v16.Position;
                local v18 = (v17.Position - Position) * Vector3.new(1, 0, 1);
                local v19 = v18.Magnitude < 0.01 and Vector3.new(1, 0, 0) or v18;
                local v20 = BeeRegistry[v2.Server.BeeName];

                if v20 then
                    v20 = v20.Stats;
                end;

                local v21;

                if v20 and v20.Ranged then
                    v21 = v20.Range or 30;
                else
                    v21 = AttackRadius;
                end;

                local v22 = v19.Unit * v21;
                math.randomseed(v2.Server.Identifier);
                local v23 = Position + v22;
                local Vector3_new_ret = Vector3.new(v23.X, Position.Y, v23.Z);
                local v24 = v19:Cross(Vector3.new(0, 1, 0));

                if v24.Magnitude > 0.01 then
                    Vector3_new_ret = Vector3_new_ret + v24.Unit * math.random() * AttackSpinMaxMagnitude;
                end;

                local v25 = ClampSurvivalWaspToSpawnFieldXZ(p10, Vector3_new_ret);
                local Vector3_new_ret2 = Vector3.new(Position.X, v25.Y, Position.Z);

                if (Vector3_new_ret2 - v25).Magnitude > 0.01 then
                    CFrame.lookAt(v25, Vector3_new_ret2);
                else
                    CFrame.new(v25);
                end;

                local Position2 = v17.Position;
                local Magnitude = (v25 - Position2).Magnitude;
                local v26 = v2.Server.Speed * p11 * 2;

                if Magnitude > v26 then
                    v25 = Position2:Lerp(v25, v26 / Magnitude);
                end;

                local Vector3_new_ret3 = Vector3.new(Position.X, v25.Y, Position.Z);

                if (Vector3_new_ret3 - v25).Magnitude > 0.01 then
                    v2.Client.PredictedCFrame = CFrame.lookAt(v25, Vector3_new_ret3);
                else
                    v2.Client.PredictedCFrame = CFrame.new(v25);
                end;
            end;
        end;

        for _, v in p12 do
            if v.Client.PredictedCFrame then
                v.Client.PredictedCFrame = v.Client.PredictedCFrame:Lerp(v.Server.CFrame, p11);
            end;

            v.Client.TargetFacingDirection = nil;
            v.Client.LockFacing = false;

            if v.Server.TargetBee and v.Server.TargetPlayer then
                local v27 = string.split(v.Server.TargetPlayer, "_")[2];
                local v28 = tonumber(v27);

                if (not v28 or Players:GetPlayerByUserId(v28)) and true or false then
                    local Entry = u9:GetEntry(v.Server.TargetPlayer, v.Server.TargetBee);

                    if Entry and Entry.Server.Health > 0 then
                        local v29 = ((Entry.Client.PredictedCFrame or (Entry.Client.SmoothedCFrame or Entry.Server.CFrame)).Position - (v.Client.PredictedCFrame or (v.Client.SmoothedCFrame or v.Server.CFrame)).Position) * Vector3.new(1, 0, 1);

                        if v29.Magnitude > 0.01 then
                            v.Client.TargetFacingDirection = v29;
                            v.Client.LockFacing = true;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;