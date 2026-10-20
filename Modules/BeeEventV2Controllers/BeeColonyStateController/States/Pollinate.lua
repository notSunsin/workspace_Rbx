-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};

local function CreatePollinateVFX(p2: userdata, p3: userdata) -- Line: 14
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p2;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = p3;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 230, 80), Color3.fromRGB(255, 180, 0));
    ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1.2);
    ParticleEmitter.Rate = 30;
    ParticleEmitter.Speed = NumberRange.new(1, 3);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.LightEmission = 1;
    ParticleEmitter.Parent = Attachment;
    local ParticleEmitter2 = Instance.new("ParticleEmitter");
    ParticleEmitter2.Color = ColorSequence.new(Color3.fromRGB(180, 255, 100), Color3.fromRGB(255, 230, 50));
    ParticleEmitter2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(1, 0) });
    ParticleEmitter2.Lifetime = NumberRange.new(0.5, 1);
    ParticleEmitter2.Rate = 15;
    ParticleEmitter2.Speed = NumberRange.new(0.5, 2);
    ParticleEmitter2.SpreadAngle = Vector2.new(120, 120);
    ParticleEmitter2.LightEmission = 1;
    ParticleEmitter2.Parent = Attachment2;
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

local function CleanupVFX(p4: userdata, p5: string) -- Line: 59
    -- upvalues: u1 (copy)
    local v6 = u1[p4];

    if not v6 then
        return;
    end;

    local v7 = v6[p5];

    if not v7 then
        return;
    end;

    v7.BeeAttachment:Destroy();
    v7.PlantAttachment:Destroy();
    v6[p5] = nil;
end;

local function GetCurrentCFrame(p8) -- Line: 70
    local v9 = p8.Client.PredictedCFrame or (p8.Client.SmoothedCFrame or p8.Server.CFrame);

    if v9 and v9.Position.Magnitude >= 0.01 then
        return v9;
    end;

    return p8.Server.CFrame;
end;

local function MoveEntryTowardCFrame(p10: any, p11, p12: number) -- Line: 82
    local v13 = p10.Client.PredictedCFrame or (p10.Client.SmoothedCFrame or p10.Server.CFrame);

    if not v13 or v13.Position.Magnitude < 0.01 then
        v13 = p10.Server.CFrame;
    end;

    if not v13 or v13.Position.Magnitude < 0.01 then
        p10.Client.PredictedCFrame = p11;

        return;
    end;

    local Magnitude = (p11.Position - v13.Position).Magnitude;

    if Magnitude < 0.01 then
        p10.Client.PredictedCFrame = p11;

        return;
    end;

    local v14 = p10.Server.Speed * p12;

    if Magnitude <= v14 then
        p10.Client.PredictedCFrame = p11;

        return;
    end;

    local v15 = v13.Position + (p11.Position - v13.Position).Unit * v14;
    local Position = p11.Position;

    if (Position - v15).Magnitude < 0.01 then
        Position = v15 + p11.LookVector;
    end;

    p10.Client.PredictedCFrame = CFrame.new(v15, Position);
end;

return function(u16) -- Line: 113
    -- upvalues: Players (copy), LocalPlayer (copy), u1 (copy), CreatePollinateVFX (copy), MoveEntryTowardCFrame (copy)
    return function(p17: string, p18: number, p19: table) -- Line: 114
        -- upvalues: Players (ref), LocalPlayer (ref), u1 (ref), u16 (copy), CreatePollinateVFX (ref), MoveEntryTowardCFrame (ref)
        local string_split_ret = string.split(p17, "_");

        if string_split_ret[1] ~= "Player" or not string_split_ret[2] then
            return;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId((tonumber(string_split_ret[2])));

        if not PlayerByUserId then
            return;
        end;

        local ServerTimeNow = workspace:GetServerTimeNow();
        local v20 = PlayerByUserId == LocalPlayer;
        local v21 = u1[PlayerByUserId];

        if not v21 then
            v21 = {};
            u1[PlayerByUserId] = v21;
        end;

        local v22 = {};

        for i, v in p19 do
            v.Client.LockFacing = false;
            v.Client.FacingDirection = nil;
            v.Client.TargetFacingDirection = nil;
            local PollinatingPlant = v.Server.PollinatingPlant;

            if PollinatingPlant and (PollinatingPlant.Parent and PollinatingPlant.PrimaryPart) then
                if not v22[PollinatingPlant] then
                    v22[PollinatingPlant] = {};
                end;

                table.insert(v22[PollinatingPlant], {
                    UUID = i,
                    Entry = v
                });
            else
                v.Client.PredictedCFrame = nil;
                u16:SetPollinateSoundEnabled(v, false);
                local v23 = u1[PlayerByUserId];

                if v23 then
                    local v24 = v23[i];

                    if v24 then
                        v24.BeeAttachment:Destroy();
                        v24.PlantAttachment:Destroy();
                        v23[i] = nil;
                    end;
                end;
            end;
        end;

        for i, v in v22 do
            local Position = i.PrimaryPart.Position;
            local v25 = #v;
            local v26 = v25 * 0.5 + 2;
            local v27 = i;

            for i2, v2 in v do
                local UUID = v2.UUID;
                local Entry = v2.Entry;
                local v28 = (i2 - 1) / v25 * 3.141592653589793 * 2;
                local v29 = v28 + ServerTimeNow * 1.5;
                local v30 = math.sin(ServerTimeNow * 4 + v28) * 0.3;
                Entry.Client.RenderOffset = CFrame.new(0, v30, 0);
                local v31 = math.cos(v29) * v26;
                local v32 = math.sin(v29) * v26;
                local v33 = Position + Vector3.new(v31, 3, v32);
                local Vector3_new_ret = Vector3.new(Position.X, v33.Y, Position.Z);
                local CFrame_new_ret = CFrame.new(v33, Vector3_new_ret);
                local v34 = Entry.Client.PredictedCFrame or (Entry.Client.SmoothedCFrame or Entry.Server.CFrame);

                if not v34 or v34.Position.Magnitude < 0.01 then
                    v34 = Entry.Server.CFrame;
                end;

                local v35 = (v34.Position - Position).Magnitude <= v26 + 3;
                u16:SetPollinateSoundEnabled(Entry, v35);

                if v35 then
                    if Entry.Client.Hitbox and not v21[UUID] then
                        local v36, v37 = CreatePollinateVFX(Entry.Client.Hitbox, v27.PrimaryPart);
                        v21[UUID] = {
                            BeeAttachment = v36,
                            PlantAttachment = v37
                        };
                    end;
                else
                    local v38 = u1[PlayerByUserId];
                    local v39 = v38 and v38[UUID];

                    if v39 then
                        v39.BeeAttachment:Destroy();
                        v39.PlantAttachment:Destroy();
                        v38[UUID] = nil;
                    end;
                end;

                if v20 then
                    MoveEntryTowardCFrame(Entry, CFrame_new_ret, p18);
                else
                    Entry.Client.PredictedCFrame = nil;
                end;
            end;
        end;

        for i in v21 do
            if not p19[i] then
                local v40 = u1[PlayerByUserId];

                if v40 then
                    local v41 = v40[i];

                    if v41 then
                        v41.BeeAttachment:Destroy();
                        v41.PlantAttachment:Destroy();
                        v40[i] = nil;
                    end;
                end;
            end;
        end;
    end;
end;