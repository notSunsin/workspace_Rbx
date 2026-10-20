-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local BeeColonyAbilityEffectsService = ReplicatedStorage.GameEvents.BizzyBeeEvent.BeeColonyAbilityEffectsService;
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local u1 = {};
local u2 = {};
local u3 = {};
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function CreateBeam(p4: userdata, p5: userdata, p6) -- Line: 15
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p4;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = p5;
    local Beam = Instance.new("Beam");
    Beam.Attachment0 = Attachment;
    Beam.Attachment1 = Attachment2;
    local v7 = p6 or Color3.fromRGB(255, 230, 80);
    Beam.Color = ColorSequence.new(v7, v7:Lerp(Color3.new(1, 1, 1), 0.35));
    Beam.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(0.5, 0.35), NumberSequenceKeypoint.new(1, 0.15) });
    Beam.LightEmission = 1;
    Beam.Width0 = 0.35;
    Beam.Width1 = 0.2;
    Beam.TextureLength = 1;
    Beam.TextureSpeed = 2;
    Beam.CurveSize0 = 1.5;
    Beam.CurveSize1 = -1.5;
    Beam.FaceCamera = true;
    Beam.Parent = Attachment;

    return {
        CasterAttachment = Attachment,
        TargetAttachment = Attachment2,
        Beam = Beam
    };
end;

local function CleanupEffect(p8) -- Line: 49
    -- upvalues: u1 (copy)
    if p8.Cleaned then
        return;
    end;

    p8.Cleaned = true;

    if p8.CasterDestroyConn then
        p8.CasterDestroyConn:Disconnect();
        p8.CasterDestroyConn = nil;
    end;

    if p8.TargetDestroyConn then
        p8.TargetDestroyConn:Disconnect();
        p8.TargetDestroyConn = nil;
    end;

    if p8.CasterAttachment then
        p8.CasterAttachment:Destroy();
    end;

    if p8.TargetAttachment then
        p8.TargetAttachment:Destroy();
    end;

    u1[p8] = nil;
end;

local function ApplyTemporaryTargetStats(u9: userdata, p10: any, p11: number) -- Line: 74
    if not p10 then
        return;
    end;

    local Attribute = u9:GetAttribute("Speed");
    local Attribute2 = u9:GetAttribute("PollinationQuality");
    local Attribute3 = u9:GetAttribute("PollinationRate");
    local v12;

    if p10.Speed then
        v12 = (Attribute or 0) + p10.Speed;
    else
        v12 = Attribute;
    end;

    if p10.SpeedMultiplier then
        v12 = (v12 or 0) * p10.SpeedMultiplier;
    end;

    local v13;

    if p10.PollinationQuality then
        v13 = (Attribute2 or 0) + p10.PollinationQuality;
    else
        v13 = Attribute2;
    end;

    if p10.PollinationQualityMultiplier then
        v13 = (v13 or 0) * p10.PollinationQualityMultiplier;
    end;

    local v14;

    if p10.PollinationRate then
        v14 = (Attribute3 or 0) + p10.PollinationRate;
    else
        v14 = Attribute3;
    end;

    if p10.PollinationRateMultiplier then
        v14 = (v14 or 0) * p10.PollinationRateMultiplier;
    end;

    if v12 ~= Attribute then
        u9:SetAttribute("Speed", v12);
    end;

    if v13 ~= Attribute2 then
        u9:SetAttribute("PollinationQuality", v13);
    end;

    if v14 ~= Attribute3 then
        u9:SetAttribute("PollinationRate", v14);
    end;

    task.delay(p11, function() -- Line: 121
        -- upvalues: u9 (copy), Attribute (copy), Attribute2 (copy), Attribute3 (copy)
        if not (u9 and u9.Parent) then
            return;
        end;

        if Attribute then
            u9:SetAttribute("Speed", Attribute);
        end;

        if Attribute2 then
            u9:SetAttribute("PollinationQuality", Attribute2);
        end;

        if Attribute3 then
            u9:SetAttribute("PollinationRate", Attribute3);
        end;
    end);
end;

local function GetCooldownKey(p15: string, p16: string, p17: string) -- Line: 138
    return `{p15}_{p16}_{p17}`;
end;

local function CleanupCooldown(p18: string) -- Line: 142
    -- upvalues: u2 (copy)
    local v19 = u2[p18];

    if not v19 then
        return;
    end;

    if v19.Gui then
        v19.Gui:Destroy();
    end;

    u2[p18] = nil;
end;

local function CreateCooldownGui(p20: userdata, p21) -- Line: 153
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "BeeAbilityCooldown";
    BillboardGui.Size = UDim2.fromOffset(90, 28);
    BillboardGui.StudsOffset = Vector3.new(0, 2.2, 0);
    BillboardGui.MaxDistance = 250;
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.Adornee = p20;
    BillboardGui.Parent = p20;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "CooldownText";
    TextLabel.Size = UDim2.fromScale(0.8, 0.8);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextColor3 = p21 or Color3.fromRGB(255, 255, 255);
    TextLabel.TextStrokeTransparency = 0;
    TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
    TextLabel.TextScaled = true;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold);
    TextLabel.Parent = BillboardGui;

    return BillboardGui, TextLabel;
end;

local function StartCooldown(p22: string, p23: string, p24: string, p25: userdata, p26: number, p27) -- Line: 177
    -- upvalues: LocalPlayer (copy), u2 (copy), CreateCooldownGui (copy)
    if not p26 or p26 <= 0 then
        return;
    end;

    local v28 = `{p22}_{p23}_{p24}`;
    local v29 = `{`Player_{LocalPlayer.UserId}`}_{p23}_{p24}`;
    local v30 = u2[v28];

    if v30 then
        if v30.Gui then
            v30.Gui:Destroy();
        end;

        u2[v28] = nil;
    end;

    local v31, v32 = CreateCooldownGui(p25, p27);
    v31.Enabled = v29 == v28;
    u2[v28] = {
        Gui = v31,
        Label = v32,
        EndsAt = p26
    };
end;

local function TryStartCooldown(p33, p34) -- Line: 194
    -- upvalues: StartCooldown (copy)
    local Hitbox = p33:GetHitbox(p34.PlayerKey, p34.CasterUUID);
    local Entry = p33:GetEntry(p34.PlayerKey, p34.CasterUUID);

    if not Entry or Entry.Client.IsVisible ~= false then
        if not Hitbox then
            return false;
        end;

        StartCooldown(p34.PlayerKey, p34.CasterUUID, p34.AbilityName, Hitbox, p34.CooldownEndsAt, p34.EffectColor);
        local Entry2 = p33:GetEntry(p34.PlayerKey, p34.CasterUUID);

        return Entry2 and Entry2.Client.IsVisible == false and true or true;
    end;
end;

local function IsInvalidProjectileTarget(p35) -- Line: 215
    return not p35 and true or (not (p35.Client.Hitbox and p35.Client.Hitbox.Parent) and true or (p35.Server.Health <= 0 and true or (p35.Server.State == "Nesting" and true or (p35.Server.DidDie and true or false))));
end;

return function(u36) -- Line: 239
    -- upvalues: BeeColonyAbilityEffectsService (copy), SoundPlayer (copy), RunService (copy), u3 (copy), StartCooldown (copy), CreateBeam (copy), u1 (copy), CleanupEffect (copy), TryStartCooldown (copy), u2 (copy)
    BeeColonyAbilityEffectsService.OnClientEvent:Connect(function(p37) -- Line: 240
        -- upvalues: u36 (copy), SoundPlayer (ref), RunService (ref), u3 (ref), StartCooldown (ref), CreateBeam (ref), u1 (ref), CleanupEffect (ref)
        local v38;

        if p37.CasterUUID then
            v38 = u36:GetHitbox(p37.PlayerKey, p37.CasterUUID);
        else
            v38 = nil;
        end;

        if p37.Type == "BeerserkerInstinct" then
            local Entry = u36:GetEntry(p37.PlayerKey, p37.CasterUUID);

            if not Entry then
                return;
            end;

            local Hitbox = Entry.Client.Hitbox;

            if not Hitbox then
                return;
            end;

            local BeerserkerInstinct = script.Parent.VFX:FindFirstChild("BeerserkerInstinct");

            if not BeerserkerInstinct then
                return;
            end;

            local u39 = BeerserkerInstinct:Clone();
            u39.Parent = Hitbox;

            for _, descendant in u39:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;

            task.delay(p37.Duration, function() -- Line: 272
                -- upvalues: u39 (copy)
                u39:Destroy();
            end);

            return;
        end;

        if p37.Type == "LastStand" then
            local Entry = u36:GetEntry(p37.PlayerKey, p37.CasterUUID);

            if not Entry then
                return;
            end;

            local Hitbox = Entry.Client.Hitbox;

            if not Hitbox then
                return;
            end;

            local LastStand = script.Parent.VFX:FindFirstChild("LastStand");

            if not LastStand then
                return;
            end;

            local u40 = LastStand:Clone();
            u40.Parent = Hitbox;

            for _, descendant in u40:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;

            task.delay(3, function() -- Line: 307
                -- upvalues: u40 (copy)
                u40:Destroy();
            end);

            return;
        end;

        if p37.Type == "WaspKingShockwave" then
            local Entry = u36:GetEntry(p37.PlayerKey, p37.CasterUUID);

            if not Entry then
                return;
            end;

            local Hitbox = Entry.Client.Hitbox;

            if not Hitbox then
                return;
            end;

            local StunShockwaveVFX = script.Parent.VFX:FindFirstChild("StunShockwaveVFX");

            if not StunShockwaveVFX then
                return;
            end;

            local u41 = StunShockwaveVFX:Clone();
            u41.Parent = Hitbox;

            for _, descendant in u41:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;

            SoundPlayer:PlaySound("rbxassetid://115778188450463", {
                Volume = 0.85,
                PlaybackSpeed = Random.new():NextNumber(0.95, 1.05)
            });
            task.delay(5, function() -- Line: 344
                -- upvalues: u41 (copy)
                u41:Destroy();
            end);

            return;
        end;

        if p37.Type == "WaspKingPoisonStrike" then
            local Entry = u36:GetEntry(p37.PlayerKey, p37.CasterUUID);

            if not Entry then
                return;
            end;

            local Entry2 = u36:GetEntry(p37.TargetPlayerKey, p37.TargetUUID);

            if not Entry2 then
                return;
            end;

            local Hitbox = Entry.Client.Hitbox;
            local Hitbox2 = Entry2.Client.Hitbox;

            if not (Hitbox and Hitbox2) then
                return;
            end;

            local PoisonStrikesProjectileVFX = script.Parent.VFX:FindFirstChild("PoisonStrikesProjectileVFX");

            if not PoisonStrikesProjectileVFX then
                return;
            end;

            local u42 = PoisonStrikesProjectileVFX:Clone();
            u42.Anchored = true;
            u42.CanCollide = false;
            u42.CanQuery = false;
            u42.CanTouch = false;
            u42.CFrame = CFrame.new(Hitbox.Position);
            u42.Parent = workspace;
            SoundPlayer:PlaySound("rbxassetid://135896788058098", {
                Volume = 0.65,
                PlaybackSpeed = Random.new():NextNumber(0.95, 1.05)
            });
            local Position = Hitbox.Position;
            local math_random_ret = math.random(-15, 15);
            local math_random_ret2 = math.random(10, 25);
            local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random(-15, 15));
            local math_random_ret3 = math.random(-15, 15);
            local math_random_ret4 = math.random(10, 25);
            local Vector3_new_ret2 = Vector3.new(math_random_ret3, math_random_ret4, math.random(-15, 15));
            local ServerTimeNow = workspace:GetServerTimeNow();
            local u43 = nil;
            u43 = RunService.RenderStepped:Connect(function() -- Line: 405
                -- upvalues: u42 (copy), u43 (ref), Entry2 (copy), ServerTimeNow (copy), Hitbox2 (copy), Position (copy), Vector3_new_ret (copy), Vector3_new_ret2 (copy), SoundPlayer (ref)
                if not u42.Parent then
                    u43:Disconnect();

                    return;
                end;

                local v44 = Entry2;

                if not v44 and true or (not (v44.Client.Hitbox and v44.Client.Hitbox.Parent) and true or (v44.Server.Health <= 0 and true or (v44.Server.State == "Nesting" and true or (v44.Server.DidDie and true or false)))) then
                    u43:Disconnect();
                    u42:Destroy();

                    return;
                end;

                local v45 = (workspace:GetServerTimeNow() - ServerTimeNow) / 3;
                local math_clamp_ret = math.clamp(v45, 0, 1);
                local v46;

                if Hitbox2 and Hitbox2.Parent then
                    v46 = Hitbox2.Position;
                else
                    v46 = u42.Position;
                end;

                local v47 = Position + Vector3_new_ret;
                local v48 = v46 + Vector3_new_ret2;
                local v49 = Position:Lerp(v47, math_clamp_ret);
                local v50 = v47:Lerp(v48, math_clamp_ret);
                local v51 = v48:Lerp(v46, math_clamp_ret);
                local v52 = v49:Lerp(v50, math_clamp_ret):Lerp(v50:Lerp(v51, math_clamp_ret), math_clamp_ret);
                u42.CFrame = CFrame.new(v52);

                if math_clamp_ret >= 1 then
                    u43:Disconnect();
                    local v53;

                    if Hitbox2 and Hitbox2.Parent then
                        v53 = Hitbox2.Position;
                    else
                        v53 = u42.Position;
                    end;

                    SoundPlayer:PlaySound("rbxassetid://78298516531680", {
                        Volume = 0.65,
                        PlaybackSpeed = Random.new():NextNumber(0.95, 1.05)
                    });
                    u42:PivotTo(CFrame.new(v53));
                    u42:Destroy();
                end;
            end);

            return;
        end;

        if p37.Type == "HiveburnBurnTick" then
            local Entry = u36:GetEntry(p37.TargetPlayerKey, p37.TargetUUID);

            if not Entry then
                return;
            end;

            local Hitbox = Entry.Client.Hitbox;

            if not Hitbox then
                return;
            end;

            local HiveburnBurnVFX = script.Parent.VFX:FindFirstChild("HiveburnBurnVFX");

            if not HiveburnBurnVFX then
                return;
            end;

            local u54 = HiveburnBurnVFX:Clone();
            u54.Parent = Hitbox;

            for _, descendant in u54:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                end;
            end;

            task.delay(2, function() -- Line: 478
                -- upvalues: u54 (copy)
                if u54.Parent then
                    u54:Destroy();
                end;
            end);

            return;
        end;

        if p37.Type ~= "HiveburnFireball" then
            if p37.Type == "BloomveinHeal" then
                local Entry = u36:GetEntry(p37.PlayerKey, p37.TargetUUID);

                if not Entry then
                    return;
                end;

                local Hitbox = Entry.Client.Hitbox;

                if not Hitbox then
                    return;
                end;

                local HealVFX = script.Parent.VFX:FindFirstChild("HealVFX");

                if not HealVFX then
                    return;
                end;

                local u55 = HealVFX:Clone();
                u55.Parent = Hitbox;

                for _, descendant in u55:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                    end;
                end;

                task.delay(2, function() -- Line: 575
                    -- upvalues: u55 (copy)
                    if u55.Parent then
                        u55:Destroy();
                    end;
                end);

                return;
            end;

            if p37.Type ~= "ThunderbuzzChainLightning" then
                if p37.Type ~= "RangedBeeProjectile" then
                    if not v38 then
                        if p37.CooldownEndsAt and p37.AbilityName then
                            table.insert(u3, p37);
                        end;

                        return;
                    end;

                    StartCooldown(p37.PlayerKey, p37.CasterUUID, p37.AbilityName, v38, p37.CooldownEndsAt, p37.EffectColor);

                    for _, v in p37.TargetUUIDs do
                        local Hitbox = u36:GetHitbox(p37.PlayerKey, v);

                        if Hitbox then
                            local Entry = u36:GetEntry(p37.PlayerKey, v);

                            if not Entry or Entry.Client.IsVisible ~= false then
                                local u56 = CreateBeam(v38, Hitbox, p37.EffectColor);
                                u1[u56] = true;
                                u56.CasterDestroyConn = v38.Destroying:Connect(function() -- Line: 754
                                    -- upvalues: CleanupEffect (ref), u56 (copy)
                                    CleanupEffect(u56);
                                end);
                                u56.TargetDestroyConn = Hitbox.Destroying:Connect(function() -- Line: 757
                                    -- upvalues: CleanupEffect (ref), u56 (copy)
                                    CleanupEffect(u56);
                                end);
                                task.delay(p37.Duration, function() -- Line: 761
                                    -- upvalues: CleanupEffect (ref), u56 (copy)
                                    CleanupEffect(u56);
                                end);
                            end;
                        end;
                    end;

                    return;
                end;

                local Entry = u36:GetEntry(p37.PlayerKey, p37.CasterUUID);

                if not Entry then
                    return;
                end;

                local Entry2 = u36:GetEntry(p37.TargetPlayerKey, p37.TargetUUID);

                if not Entry2 then
                    return;
                end;

                local Hitbox = Entry.Client.Hitbox;
                local Hitbox2 = Entry2.Client.Hitbox;

                if not (Hitbox and Hitbox2) then
                    return;
                end;

                local v57 = script.Parent.VFX:FindFirstChild(p37.ProjectileName);

                if not v57 then
                    return;
                end;

                local u58 = v57:Clone();

                for _, descendant in u58:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.Anchored = true;
                        descendant.CanCollide = false;
                        descendant.CanQuery = false;
                        descendant.CanTouch = false;
                    end;
                end;

                if u58:IsA("BasePart") then
                    u58.Anchored = true;
                    u58.CanCollide = false;
                    u58.CanQuery = false;
                    u58.CanTouch = false;
                end;

                u58.Parent = workspace;

                local function PivotProjectile(p59) -- Line: 686
                    -- upvalues: u58 (copy)
                    if u58:IsA("Model") then
                        u58:PivotTo(p59);

                        return;
                    end;

                    if u58:IsA("BasePart") then
                        u58.CFrame = p59;
                    end;
                end;

                local u60 = p37.ProjectileSpeed or 35;
                local Position = Hitbox.Position;
                local CFrame_new_ret = CFrame.new(Position);

                if u58:IsA("Model") then
                    u58:PivotTo(CFrame_new_ret);
                elseif u58:IsA("BasePart") then
                    u58.CFrame = CFrame_new_ret;
                end;

                local u61 = nil;
                u61 = RunService.RenderStepped:Connect(function(p62) -- Line: 700
                    -- upvalues: u58 (copy), u61 (ref), Entry2 (copy), Hitbox2 (copy), Position (ref), u60 (copy)
                    if not u58.Parent then
                        u61:Disconnect();

                        return;
                    end;

                    local v63 = Entry2;

                    if not v63 and true or (not (v63.Client.Hitbox and v63.Client.Hitbox.Parent) and true or (v63.Server.Health <= 0 and true or (v63.Server.State == "Nesting" and true or (v63.Server.DidDie and true or false)))) then
                        u61:Disconnect();
                        u58:Destroy();

                        return;
                    end;

                    local Position2 = Hitbox2.Position;
                    local v64 = Position2 - Position;
                    local Magnitude = v64.Magnitude;

                    if Magnitude <= 0.5 then
                        u61:Disconnect();
                        u58:Destroy();

                        return;
                    end;

                    local math_min_ret = math.min(u60 * p62, Magnitude);
                    Position = Position + v64.Unit * math_min_ret;
                    local CFrame_lookAt_ret = CFrame.lookAt(Position, Position2);

                    if u58:IsA("Model") then
                        u58:PivotTo(CFrame_lookAt_ret);

                        return;
                    end;

                    if u58:IsA("BasePart") then
                        u58.CFrame = CFrame_lookAt_ret;
                    end;
                end);

                return;
            end;

            local Entry = u36:GetEntry(p37.PlayerKey, p37.CasterUUID);

            if not Entry then
                return;
            end;

            local Entry2 = u36:GetEntry(p37.TargetPlayerKey, p37.TargetUUID);

            if not Entry2 then
                return;
            end;

            local Hitbox = Entry.Client.Hitbox;
            local Hitbox2 = Entry2.Client.Hitbox;

            if not (Hitbox and Hitbox2) then
                return;
            end;

            local ChainLightningProjectile = script.Parent.VFX:FindFirstChild("ChainLightningProjectile", true);

            if not ChainLightningProjectile then
                return;
            end;

            local u65 = ChainLightningProjectile:Clone();
            u65.Anchored = true;
            u65.CanCollide = false;
            u65.CanQuery = false;
            u65.CanTouch = false;
            u65.CFrame = CFrame.new(Hitbox.Position);
            u65.Parent = workspace;
            local ServerTimeNow = workspace:GetServerTimeNow();
            local u66 = p37.Duration or 1;
            local Position = Hitbox.Position;
            local math_random_ret = math.random(1, 1000000);
            local u67 = nil;
            u67 = RunService.RenderStepped:Connect(function() -- Line: 613
                -- upvalues: u65 (copy), u67 (ref), Entry2 (copy), ServerTimeNow (copy), u66 (copy), Hitbox2 (copy), Position (copy), math_random_ret (copy)
                if not u65.Parent then
                    u67:Disconnect();

                    return;
                end;

                local v68 = Entry2;

                if not v68 and true or (not (v68.Client.Hitbox and v68.Client.Hitbox.Parent) and true or (v68.Server.Health <= 0 and true or (v68.Server.State == "Nesting" and true or (v68.Server.DidDie and true or false)))) then
                    u67:Disconnect();
                    u65:Destroy();

                    return;
                end;

                local v69 = (workspace:GetServerTimeNow() - ServerTimeNow) / u66;
                local math_clamp_ret = math.clamp(v69, 0, 1);
                local v70;

                if Hitbox2 and Hitbox2.Parent then
                    v70 = Hitbox2.Position;
                else
                    v70 = u65.Position;
                end;

                local v71 = Position:Lerp(v70, math_clamp_ret);
                local v72 = v70 - Position;
                local Vector3_new_ret = Vector3.new(v72.X, 0, v72.Z);
                local v73 = Vector3_new_ret.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or Vector3_new_ret.Unit:Cross(Vector3.new(0, 1, 0)).Unit;
                local v74 = math.sin((math_clamp_ret * 10 + math_random_ret) * 3.141592653589793) * 2.5;
                local v75 = math.sin((math_clamp_ret * 24 + math_random_ret) * 3.141592653589793) * 1.25;
                local v76 = math.sin(math_clamp_ret * 3.141592653589793) * 4;
                u65.CFrame = CFrame.lookAt(v71 + v73 * v74 + Vector3.new(0, 1, 0) * (v76 + v75), v70);

                if math_clamp_ret >= 1 then
                    u67:Disconnect();
                    u65:Destroy();
                end;
            end);

            return;
        end;

        local Entry = u36:GetEntry(p37.PlayerKey, p37.CasterUUID);

        if not Entry then
            return;
        end;

        local Entry2 = u36:GetEntry(p37.TargetPlayerKey, p37.TargetUUID);

        if not Entry2 then
            return;
        end;

        local Hitbox = Entry.Client.Hitbox;
        local Hitbox2 = Entry2.Client.Hitbox;

        if not (Hitbox and Hitbox2) then
            return;
        end;

        local HiveburnFireballProjectileVFX = script.Parent.VFX:FindFirstChild("HiveburnFireballProjectileVFX");

        if not HiveburnFireballProjectileVFX then
            return;
        end;

        local u77 = HiveburnFireballProjectileVFX:Clone();
        u77.Anchored = true;
        u77.CanCollide = false;
        u77.CanQuery = false;
        u77.CanTouch = false;
        u77.CFrame = CFrame.new(Hitbox.Position);
        u77.Parent = workspace;
        local Position = Hitbox.Position;
        local u78 = p37.Duration or 2;
        local ServerTimeNow = workspace:GetServerTimeNow();
        local math_random_ret = math.random(-10, 10);
        local math_random_ret2 = math.random(8, 18);
        local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random(-10, 10));
        local math_random_ret3 = math.random(-10, 10);
        local math_random_ret4 = math.random(8, 18);
        local Vector3_new_ret2 = Vector3.new(math_random_ret3, math_random_ret4, math.random(-10, 10));
        local u79 = nil;
        u79 = RunService.RenderStepped:Connect(function() -- Line: 518
            -- upvalues: u77 (copy), u79 (ref), Entry2 (copy), ServerTimeNow (copy), u78 (copy), Hitbox2 (copy), Position (copy), Vector3_new_ret (copy), Vector3_new_ret2 (copy)
            if not u77.Parent then
                u79:Disconnect();

                return;
            end;

            local v80 = Entry2;

            if not v80 and true or (not (v80.Client.Hitbox and v80.Client.Hitbox.Parent) and true or (v80.Server.Health <= 0 and true or (v80.Server.State == "Nesting" and true or (v80.Server.DidDie and true or false)))) then
                u79:Disconnect();
                u77:Destroy();

                return;
            end;

            local v81 = (workspace:GetServerTimeNow() - ServerTimeNow) / u78;
            local math_clamp_ret = math.clamp(v81, 0, 1);
            local v82;

            if Hitbox2 and Hitbox2.Parent then
                v82 = Hitbox2.Position;
            else
                v82 = u77.Position;
            end;

            local v83 = Position + Vector3_new_ret;
            local v84 = v82 + Vector3_new_ret2;
            local v85 = Position:Lerp(v83, math_clamp_ret);
            local v86 = v83:Lerp(v84, math_clamp_ret);
            local v87 = v84:Lerp(v82, math_clamp_ret);
            local v88 = v85:Lerp(v86, math_clamp_ret);
            local v89 = v86:Lerp(v87, math_clamp_ret);
            u77.CFrame = CFrame.new(v88:Lerp(v89, math_clamp_ret));

            if math_clamp_ret >= 1 then
                u79:Disconnect();
                u77:Destroy();
            end;
        end);
    end);
    RunService.RenderStepped:Connect(function() -- Line: 767
        -- upvalues: u3 (ref), TryStartCooldown (ref), u36 (copy), u2 (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();

        for i = #u3, 1, -1 do
            local v90 = u3[i];
            local v91;

            if v90 then
                v91 = v90.CooldownEndsAt;
            else
                v91 = v90;
            end;

            local v92;

            if v90 and v91 then
                if v90.CooldownEndsAt <= ServerTimeNow then
                    table.remove(u3, i);
                    v92 = i;
                elseif TryStartCooldown(u36, v90) then
                    table.remove(u3, i);
                    v92 = i;
                else
                    v92 = i;
                end;
            else
                table.remove(u3, i);
                v92 = i;
            end;
        end;

        for i, v in u2 do
            local math_ceil_ret = math.ceil(v.EndsAt - ServerTimeNow);

            if math_ceil_ret <= 0 then
                local v93 = u2[i];

                if v93 then
                    if v93.Gui then
                        v93.Gui:Destroy();
                    end;

                    u2[i] = nil;
                end;
            else
                v.Label.Text = `⏱️{math_ceil_ret}s`;
            end;
        end;
    end);
end;