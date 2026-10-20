-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
pcall(function() -- Line: 12
    -- upvalues: ReplicatedStorage (copy), u1 (ref)
    local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
    u1 = GameConfigController:GetConfig("FlowerRushConfig");
    workspace:GetAttributeChangedSignal("FlowerRushConfig"):Connect(function() -- Line: 15
        -- upvalues: u1 (ref), GameConfigController (copy)
        u1 = GameConfigController:GetConfig("FlowerRushConfig");
    end);
end);

local function cfg(p2: string, p3: number) -- Line: 20
    -- upvalues: u1 (ref)
    local v4 = u1 and u1[p2];

    if typeof(v4) == "number" then
        return v4;
    end;

    return p3;
end;

local u5 = {};

local function GetFlowerHitBox() -- Line: 34
    local FlowerRush = workspace:FindFirstChild("FlowerRush");

    if not FlowerRush then
        return nil;
    end;

    for _, child in FlowerRush:GetChildren() do
        if child:IsA("Model") and (child:GetAttribute("FlowerRushId") and child:GetAttribute("State") == "Active") then
            local HitBox = child:FindFirstChild("HitBox");

            if HitBox and HitBox:IsA("BasePart") then
                return HitBox;
            end;
        end;
    end;

    return nil;
end;

local function CreatePollinateVFX(p6: userdata, p7: userdata?) -- Line: 48
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p6;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 230, 80), Color3.fromRGB(255, 180, 0));
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1.2);
    ParticleEmitter.Rate = 30;
    ParticleEmitter.Speed = NumberRange.new(1, 3);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Parent = Attachment;

    if not p7 then
        return Attachment, nil;
    end;

    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = p7;
    local Beam = Instance.new("Beam");
    Beam.Attachment0 = Attachment;
    Beam.Attachment1 = Attachment2;
    Beam.Color = ColorSequence.new(Color3.fromRGB(255, 220, 60), Color3.fromRGB(180, 255, 80));
    Beam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(0.5, 0.6), NumberSequenceKeypoint.new(1, 0.3) });
    Beam.LightEmission = 0.8;
    Beam.Width0 = 0.4;
    Beam.Width1 = 0.2;
    Beam.TextureLength = 1;
    Beam.TextureSpeed = 1;
    Beam.CurveSize0 = 2;
    Beam.CurveSize1 = -2;
    Beam.FaceCamera = true;
    Beam.Parent = Attachment;

    return Attachment, Attachment2;
end;

local function CleanupVFX(p8: any, p9: string) -- Line: 87
    local v10 = p8[p9];

    if not v10 then
        return;
    end;

    v10.BeeAttachment:Destroy();

    if v10.PlantAttachment then
        v10.PlantAttachment:Destroy();
    end;

    p8[p9] = nil;
end;

Players.PlayerRemoving:Connect(function(p11) -- Line: 95
    -- upvalues: u5 (copy)
    local v12 = u5[p11];

    if not v12 then
        return;
    end;

    for i in v12 do
        local v13 = v12[i];

        if v13 then
            v13.BeeAttachment:Destroy();

            if v13.PlantAttachment then
                v13.PlantAttachment:Destroy();
            end;

            v12[i] = nil;
        end;
    end;

    u5[p11] = nil;
end);

local function GetCurrentCFrame(p14) -- Line: 104
    local v15 = p14.Client.PredictedCFrame or (p14.Client.SmoothedCFrame or p14.Server.CFrame);

    if v15 and v15.Position.Magnitude >= 0.01 then
        return v15;
    end;

    return p14.Server.CFrame;
end;

local function MoveEntryTowardCFrame(p16: any, p17, p18: number) -- Line: 116
    local v19 = p16.Client.PredictedCFrame or (p16.Client.SmoothedCFrame or p16.Server.CFrame);

    if not v19 or v19.Position.Magnitude < 0.01 then
        v19 = p16.Server.CFrame;
    end;

    if not v19 or v19.Position.Magnitude < 0.01 then
        p16.Client.PredictedCFrame = p17;

        return;
    end;

    local Magnitude = (p17.Position - v19.Position).Magnitude;
    local v20 = (p16.Server.Speed or 16) * p18;

    if Magnitude <= v20 or Magnitude < 0.01 then
        p16.Client.PredictedCFrame = p17;

        return;
    end;

    local v21 = v19.Position + (p17.Position - v19.Position).Unit * v20;
    local Position = p17.Position;

    if (Position - v21).Magnitude < 0.01 then
        Position = v21 + p17.LookVector;
    end;

    p16.Client.PredictedCFrame = CFrame.new(v21, Position);
end;

return function(u22) -- Line: 140
    -- upvalues: Players (copy), LocalPlayer (copy), GetFlowerHitBox (copy), u5 (copy), u1 (ref), CreatePollinateVFX (copy), MoveEntryTowardCFrame (copy)
    return function(p23: string, p24: number, p25: table) -- Line: 141
        -- upvalues: Players (ref), LocalPlayer (ref), GetFlowerHitBox (ref), u5 (ref), u22 (copy), u1 (ref), CreatePollinateVFX (ref), MoveEntryTowardCFrame (ref)
        local string_split_ret = string.split(p23, "_");

        if string_split_ret[1] ~= "Player" or not string_split_ret[2] then
            return;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId((tonumber(string_split_ret[2])));

        if not PlayerByUserId then
            return;
        end;

        local v26 = PlayerByUserId == LocalPlayer;
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v27 = GetFlowerHitBox();
        local v28 = u5[PlayerByUserId];

        if not v28 then
            v28 = {};
            u5[PlayerByUserId] = v28;
        end;

        local v29 = {};

        for i, v in p25 do
            v.Client.LockFacing = false;
            v.Client.FacingDirection = nil;
            v.Client.TargetFacingDirection = nil;

            if typeof(v.Server.FlowerRushTarget) == "Vector3" then
                table.insert(v29, {
                    UUID = i,
                    Entry = v
                });
            else
                v.Client.PredictedCFrame = nil;
                u22:SetPollinateSoundEnabled(v, false);
                local v30 = v28[i];

                if v30 then
                    v30.BeeAttachment:Destroy();

                    if v30.PlantAttachment then
                        v30.PlantAttachment:Destroy();
                    end;

                    v28[i] = nil;
                end;
            end;
        end;

        table.sort(v29, function(p31, p32) -- Line: 177
            return (p31.Entry.Server.Identifier or 0) < (p32.Entry.Server.Identifier or 0);
        end);
        local v33 = #v29;
        local v34 = u1 and u1.BEE_ORBIT_RADIUS;
        local v35 = typeof(v34) ~= "number" and 5 or v34;
        local v36 = u1 and u1.BEE_ORBIT_PER_BEE;
        local v37 = v35 + v33 * (typeof(v36) ~= "number" and 0.4 or v36);
        local v38 = u1 and u1.BEE_ORBIT_HEIGHT;
        local v39 = typeof(v38) ~= "number" and 5 or v38;
        local v40 = u1 and u1.BEE_ORBIT_SPEED;
        local v41 = typeof(v40) ~= "number" and 1.5 or v40;
        local v42 = u1 and u1.BEE_ARRIVE_DISTANCE;
        local v43 = typeof(v42) ~= "number" and 4 or v42;

        for i, v in v29 do
            local UUID = v.UUID;
            local Entry = v.Entry;
            local FlowerRushTarget = Entry.Server.FlowerRushTarget;
            local v44 = (i - 1) / v33 * 3.141592653589793 * 2;
            local v45 = v44 + ServerTimeNow * v41;
            local v46 = math.sin(ServerTimeNow * 4 + v44) * 0.3;
            Entry.Client.RenderOffset = CFrame.new(0, v46, 0);
            local v47 = math.cos(v45) * v37;
            local v48 = math.sin(v45) * v37;
            local v49 = FlowerRushTarget + Vector3.new(v47, v39, v48);
            local CFrame_new_ret = CFrame.new(v49, (Vector3.new(FlowerRushTarget.X, v49.Y, FlowerRushTarget.Z)));
            local v50 = Entry.Client.PredictedCFrame or (Entry.Client.SmoothedCFrame or Entry.Server.CFrame);

            if not v50 or v50.Position.Magnitude < 0.01 then
                v50 = Entry.Server.CFrame;
            end;

            local v51 = v50.Position - FlowerRushTarget;
            local v52 = math.sqrt(v51.X * v51.X + v51.Z * v51.Z) <= v37 + v43;
            u22:SetPollinateSoundEnabled(Entry, v52);

            if v52 then
                local v53 = v28[UUID];

                if v53 and (v27 and (not v53.PlantAttachment or v53.PlantAttachment.Parent ~= v27)) then
                    local v54 = v28[UUID];

                    if v54 then
                        v54.BeeAttachment:Destroy();

                        if v54.PlantAttachment then
                            v54.PlantAttachment:Destroy();
                        end;

                        v28[UUID] = nil;
                        v53 = nil;
                    else
                        v53 = nil;
                    end;
                end;

                if Entry.Client.Hitbox and not v53 then
                    local v55, v56 = CreatePollinateVFX(Entry.Client.Hitbox, v27);
                    v28[UUID] = {
                        BeeAttachment = v55,
                        PlantAttachment = v56
                    };
                end;
            else
                local v57 = v28[UUID];

                if v57 then
                    v57.BeeAttachment:Destroy();

                    if v57.PlantAttachment then
                        v57.PlantAttachment:Destroy();
                    end;

                    v28[UUID] = nil;
                end;
            end;

            if v26 then
                MoveEntryTowardCFrame(Entry, CFrame_new_ret, p24);
            else
                Entry.Client.PredictedCFrame = nil;
            end;
        end;

        for i in v28 do
            if not p25[i] then
                local v58 = v28[i];

                if v58 then
                    v58.BeeAttachment:Destroy();

                    if v58.PlantAttachment then
                        v58.PlantAttachment:Destroy();
                    end;

                    v28[i] = nil;
                end;
            end;
        end;
    end;
end;