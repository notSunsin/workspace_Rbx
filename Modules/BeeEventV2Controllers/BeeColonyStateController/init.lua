-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
local BeeEventConfig = require(ReplicatedStorage.Data.BeeEvent.BeeEventConfig);
local UnpackCFrames = require(script.Util.UnpackCFrames);
local BeeModelLoader = require(script.Util.BeeModelLoader);
local BeeItemLoader = require(script.Util.BeeItemLoader);
local script_BeeColonyAbilityEffectsController = require(script.BeeColonyAbilityEffectsController);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Notification = require(ReplicatedStorage.Modules.Notification);
local ParticleHelper = require(ReplicatedStorage.Modules.Utility.ParticleHelper);
require(ReplicatedStorage.Modules.LerpColor);
local DamageIndicator = require(ReplicatedStorage.Modules.BeeEventV2Controllers.DamageIndicator);
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);
local LocalPlayer = Players.LocalPlayer;
local _ = BeeEventConfig.Simulation.SimulationHertz;
local UnreliableHertz = BeeEventConfig.Simulation.UnreliableHertz;
local BeeColonyStateService = ReplicatedStorage.GameEvents.BeeColonyStateService;
local Reliable = BeeColonyStateService.Reliable;
local Unreliable = BeeColonyStateService.Unreliable;
local VFX = script:WaitForChild("VFX");
local Sounds = script:WaitForChild("Sounds");
local RoyalJelly = script.VFX.RoyalJelly;
local HoneyCoin = script.VFX.HoneyCoin;
local u1 = {};
local u2 = {
    State = {
        BeeStates = {},
        IdentifierMap = {},
        BulkMoveTo = {
            Parts = {},
            CFrames = {}
        },
        SpatialGrid = {}
    },
    OnBeeCreated = Signal.new(),
    OnBeeDestroyed = Signal.new(),
    OnBeeStateUpdate = Signal.new()
};
local State = u2.State;
local IdentifierMap = State.IdentifierMap;
local u3 = false;
local BulkMoveTo = State.BulkMoveTo;
local Parts = BulkMoveTo.Parts;
local CFrames = BulkMoveTo.CFrames;
local u4 = nil;
local u5 = {};
local Near = BeeEventConfig.LOD.Near;
local Mid = BeeEventConfig.LOD.Mid;
local Far = BeeEventConfig.LOD.Far;
local u6 = 0;

local function snapToGrid(p7: vector, p8: number) -- Line: 157
    local v9 = math.floor(p7.X / p8) * p8;
    local v10 = math.floor(p7.Y / p8) * p8;
    local v11 = math.floor(p7.Z / p8) * p8;

    return Vector3.new(v9, v10, v11);
end;

local function SpringEase(p12: number) -- Line: 165
    return (p12 - 1) ^ 3 * 2.70158 + 1 + (p12 - 1) ^ 2 * 1.70158;
end;

local function StopLoopedSound(p13: userdata?) -- Line: 171
    if p13 then
        p13:Stop();
        p13:Destroy();
    end;

    return nil;
end;

local function StartLoopedSound(p14: userdata, p15: userdata?, p16: string) -- Line: 180
    -- upvalues: Sounds (copy)
    if p15 and p15.Parent then
        if not p15.IsPlaying then
            p15:Play();
        end;

        return p15;
    end;

    local v17 = Sounds:FindFirstChild(p16);

    if not (v17 and v17:IsA("Sound")) then
        return nil;
    end;

    local v18 = v17:Clone();
    v18.Name = `{p16}Sound`;
    v18.Looped = true;
    v18.Parent = p14;
    v18:Play();

    return v18;
end;

local function UpdateSoundAllowances() -- Line: 203
    -- upvalues: State (copy), BeeRegistry (copy)
    local v19 = {};

    for _, v in State.BeeStates do
        for _, v2 in v do
            v2.Client.AllowFollowPlayerSound = false;
            v2.Client.AllowPollinateSound = false;
            local State2 = v2.Server.State;

            if State2 == "Pollinate" or (State2 == "FlowerRush" or (State2 == "FollowPlayer" or State2 == "Guarding")) then
                table.insert(v19, v2);
            end;
        end;
    end;

    table.sort(v19, function(p20, p21) -- Line: 218
        local v22 = (p20.Server.State == "Pollinate" or p20.Server.State == "FlowerRush") and 1 or 2;
        local v23 = (p21.Server.State == "Pollinate" or p21.Server.State == "FlowerRush") and 1 or 2;

        if v22 == v23 then
            return p20.Server.Identifier < p21.Server.Identifier;
        end;

        return v22 < v23;
    end);
    local v24 = 0;
    local v25 = 0;
    local v26 = 0;

    for _, v in v19 do
        local State2 = v.Server.State;

        if v24 < 1 then
            v.Client.AllowFollowPlayerSound = true;
            v24 = v24 + 1;
        end;

        local IsWasp = BeeRegistry[v.Server.BeeName].IsWasp;

        if IsWasp and v25 < 0 then
            if not v.Client.IdleSound.IsPlaying then
                v.Client.IdleSound:Play();
            end;

            v25 = v25 + 1;
        elseif IsWasp then
            v.Client.IdleSound:Stop();
        end;

        if (State2 == "Pollinate" or State2 == "FlowerRush") and v26 < 5 then
            v.Client.AllowPollinateSound = true;
            v26 = v26 + 1;
        end;
    end;
end;

local function SetFollowPlayerSoundEnabled(p27: table, p28: boolean) -- Line: 260
    -- upvalues: StartLoopedSound (copy)
    local Client = p27.Client;

    if p28 and not Client.AllowFollowPlayerSound then
        p28 = false;
    end;

    if p28 then
        local Hitbox = Client.Hitbox;

        if not Hitbox then
            return;
        end;

        Client.FollowPlayerSound = StartLoopedSound(Hitbox, Client.FollowPlayerSound, "FollowPlayer");

        return;
    end;

    local FollowPlayerSound = Client.FollowPlayerSound;

    if FollowPlayerSound then
        FollowPlayerSound:Stop();
        FollowPlayerSound:Destroy();
    end;

    Client.FollowPlayerSound = nil;
end;

function u2.SetPollinateSoundEnabled(p29: table, p30: table, p31: boolean) -- Line: 278
    -- upvalues: StartLoopedSound (copy)
    local Client = p30.Client;

    if p31 and not Client.AllowPollinateSound then
        p31 = false;
    end;

    if p31 then
        local Hitbox = Client.Hitbox;

        if not Hitbox then
            return;
        end;

        Client.PollinateSound = StartLoopedSound(Hitbox, Client.PollinateSound, "Pollinate");

        return;
    end;

    local PollinateSound = Client.PollinateSound;

    if PollinateSound then
        PollinateSound:Stop();
        PollinateSound:Destroy();
    end;

    Client.PollinateSound = nil;
end;

local function StopAllBeeSounds(p32: table) -- Line: 296
    local FollowPlayerSound = p32.FollowPlayerSound;

    if FollowPlayerSound then
        FollowPlayerSound:Stop();
        FollowPlayerSound:Destroy();
    end;

    p32.FollowPlayerSound = nil;
    local PollinateSound = p32.PollinateSound;

    if PollinateSound then
        PollinateSound:Stop();
        PollinateSound:Destroy();
    end;

    p32.PollinateSound = nil;
    local IdleSound = p32.IdleSound;

    if IdleSound then
        IdleSound:Stop();
        IdleSound:Destroy();
    end;

    p32.IdleSound = nil;
    local BossSound = p32.BossSound;

    if BossSound then
        BossSound:Stop();
        BossSound:Destroy();
    end;

    p32.BossSound = nil;
end;

local function IsLocalPlayerKey(p33: string) -- Line: 303
    -- upvalues: LocalPlayer (copy)
    return p33 == `Player_{LocalPlayer.UserId}`;
end;

local function IsPlayerBeeColony(p34: string) -- Line: 307
    return string.sub(p34, 1, 7) == "Player_";
end;

local function ShouldShowEntry(p35: string, p36: table) -- Line: 311
    -- upvalues: LocalPlayer (copy), SettingsService (copy)
    if p36.Server.BeeName == "Wasp" then
        return true;
    end;

    if string.sub(p35, 1, 7) ~= "Player_" then
        return true;
    end;

    if p35 == `Player_{LocalPlayer.UserId}` then
        return true;
    end;

    local Attribute = LocalPlayer:GetAttribute("OtherPlayerBeeColonyVisibility");

    if Attribute == nil then
        Attribute = SettingsService:GetSetting("OtherPlayerBeeColonyVisibility");
    end;

    return Attribute ~= false;
end;

local function ShowDefeatedNotification(p37: string, p38: string, p39: table) -- Line: 333
    -- upvalues: Players (copy), u5 (copy), Notification (copy)
    if p37 ~= `Player_{Players.LocalPlayer.UserId}` then
        return;
    end;

    if p39.Server.BeeName == "Skeleton Bee" then
        return;
    end;

    if u5[p38] then
        return;
    end;

    u5[p38] = true;
    Notification:CreateNotification((`Your {p39.Server.BeeName} was defeated in combat!`));
end;

local u40 = setmetatable({}, {
    __mode = "k"
});
local u41 = setmetatable({}, {
    __mode = "k"
});

local function SetVFXLocalVisibility(p42: userdata?, p43: boolean) -- Line: 345
    -- upvalues: u40 (copy), u41 (copy)
    if not p42 then
        return;
    end;

    for _, descendant in p42:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            if p43 then
                local v44 = u40[descendant];

                if v44 ~= nil then
                    descendant.Enabled = v44;
                    u40[descendant] = nil;
                end;
            else
                if u40[descendant] == nil then
                    u40[descendant] = descendant.Enabled;
                end;

                descendant.Enabled = false;
            end;
        elseif descendant:IsA("Decal") then
            if p43 then
                local v45 = u41[descendant];

                if v45 ~= nil then
                    descendant.Transparency = v45;
                    u41[descendant] = nil;
                end;
            else
                if u41[descendant] == nil then
                    u41[descendant] = descendant.Transparency;
                end;

                descendant.Transparency = 1;
            end;
        end;
    end;
end;

local function SetModelLocalVisibility(p46: userdata?, p47: boolean) -- Line: 383
    -- upvalues: SetVFXLocalVisibility (copy)
    if not p46 then
        return;
    end;

    for _, descendant in p46:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = p47 and 0 or 1;
        end;
    end;

    SetVFXLocalVisibility(p46, p47);
end;

local function ClearHiddenBeeVFX(p48: table) -- Line: 395
    -- upvalues: SetVFXLocalVisibility (copy)
    if p48.HealthBar then
        p48.HealthBar.Enabled = false;
    end;

    SetVFXLocalVisibility(p48.Hitbox, false);
end;

local function ApplyBeeVisualScale(p49) -- Line: 404
    local Model = p49.Client.Model;

    if not Model then
        return;
    end;

    local v50 = p49.Server.ScaleMultiplier or 1;

    if Model:GetAttribute("BeeBaseVisualScale") == nil then
        Model:SetAttribute("BeeBaseVisualScale", Model:GetScale());
    end;

    local Attribute = Model:GetAttribute("BeeBaseVisualScale");

    if typeof(Attribute) == "number" then
        Model:ScaleTo(Attribute * v50);
    end;
end;

local function LoadEntryModel(p51: table, p52: string) -- Line: 421
    -- upvalues: BeeModelLoader (copy), BeeItemLoader (copy), ApplyBeeVisualScale (copy), SetModelLocalVisibility (copy), BeeRegistry (copy)
    BeeModelLoader(p51, p52);
    BeeItemLoader(p51);
    ApplyBeeVisualScale(p51);
    SetModelLocalVisibility(p51.Client.Model, p51.Client.IsVisible ~= false);

    if BeeRegistry[p51.Server.BeeName].IdleSound then
        local Sound = Instance.new("Sound");
        Sound.SoundId = BeeRegistry[p51.Server.BeeName].IdleSound;
        Sound.Looped = true;
        Sound.Volume = 0.18;
        Sound.Parent = p51.Client.Hitbox;
        p51.Client.IdleSound = Sound;
    end;
end;

local function SetEntryVisible(p53: string, p54: string, p55: table, p56: boolean) -- Line: 439
    -- upvalues: LoadEntryModel (copy), SetModelLocalVisibility (copy), SetVFXLocalVisibility (copy), CollectionService (copy)
    local Client = p55.Client;
    local Hitbox = Client.Hitbox;
    Client.IsVisible = p56;

    if not Hitbox then
        return;
    end;

    Hitbox.CanQuery = p56;
    Hitbox.LocalTransparencyModifier = p56 and 0 or 1;

    if Client.Model then
        SetModelLocalVisibility(Client.Model, p56);
    else
        task.spawn(LoadEntryModel, p55, p54);
    end;

    SetVFXLocalVisibility(Hitbox, p56);

    if p56 then
        if not CollectionService:HasTag(Hitbox, "BeeHover") then
            CollectionService:AddTag(Hitbox, "BeeHover");
        end;
    else
        local FollowPlayerSound = Client.FollowPlayerSound;

        if FollowPlayerSound then
            FollowPlayerSound:Stop();
            FollowPlayerSound:Destroy();
        end;

        Client.FollowPlayerSound = nil;
        local PollinateSound = Client.PollinateSound;

        if PollinateSound then
            PollinateSound:Stop();
            PollinateSound:Destroy();
        end;

        Client.PollinateSound = nil;
        local IdleSound = Client.IdleSound;

        if IdleSound then
            IdleSound:Stop();
            IdleSound:Destroy();
        end;

        Client.IdleSound = nil;
        local BossSound = Client.BossSound;

        if BossSound then
            BossSound:Stop();
            BossSound:Destroy();
        end;

        Client.BossSound = nil;

        if Client.HealthBar then
            Client.HealthBar.Enabled = false;
        end;

        SetVFXLocalVisibility(Client.Hitbox, false);

        if CollectionService:HasTag(Hitbox, "BeeHover") then
            CollectionService:RemoveTag(Hitbox, "BeeHover");
        end;
    end;
end;

local function RefreshBeeVisibility() -- Line: 472
    -- upvalues: State (copy), SetEntryVisible (copy), ShouldShowEntry (copy)
    for i, v in State.BeeStates do
        local v57 = i;

        for i2, v2 in v do
            SetEntryVisible(v57, i2, v2, (ShouldShowEntry(v57, v2)));
        end;
    end;
end;

local function ApplyBeeAttributes(p58: table) -- Line: 480
    -- upvalues: BeeRegistry (copy)
    local Hitbox = p58.Client.Hitbox;

    if not Hitbox then
        return;
    end;

    local BeeName = p58.Server.BeeName;
    local v59;

    if BeeName then
        v59 = BeeRegistry[BeeName];
    else
        v59 = BeeName;
    end;

    if v59 then
        v59 = v59.Stats;
    end;

    Hitbox:SetAttribute("BeeName", BeeName);
    Hitbox:SetAttribute("BeeIdentifier", p58.Server.Identifier);
    Hitbox:SetAttribute("Speed", p58.Server.Speed);
    Hitbox:SetAttribute("IsIllusion", p58.Server.IsIllusion == true);
    Hitbox:SetAttribute("IllusionCopiedUUID", p58.Server.IllusionCopiedUUID);
    Hitbox:SetAttribute("Health", p58.Server.Health);
    Hitbox:SetAttribute("State", p58.Server.State);
    Hitbox:SetAttribute("BeeState", p58.Server.State);
    Hitbox:SetAttribute("Slot", p58.Server.Slot);
    Hitbox:SetAttribute("BeeSlot", p58.Server.Slot);
    Hitbox:SetAttribute("Enchantment", p58.Server.Enchantment);
    Hitbox:SetAttribute("IsNesting", p58.Server.State == "Nesting");

    if v59 then
        Hitbox:SetAttribute("PollinationQuality", p58.Server.PollinationQuality or v59.PollinationQuality);
        Hitbox:SetAttribute("PollinationRate", p58.Server.PollinationRate or v59.PollinationRate);
    end;
end;

local u60 = {};

local function ProcessSynchronize(p61) -- Line: 510
    -- upvalues: State (copy), IdentifierMap (copy), u60 (copy), u3 (ref), CollectionService (copy), ApplyBeeAttributes (copy), SetEntryVisible (copy), ShouldShowEntry (copy), u2 (copy)
    for _, v in State.BeeStates do
        for _, v2 in v do
            local Client = v2.Client;
            local FollowPlayerSound = Client.FollowPlayerSound;

            if FollowPlayerSound then
                FollowPlayerSound:Stop();
                FollowPlayerSound:Destroy();
            end;

            Client.FollowPlayerSound = nil;
            local PollinateSound = Client.PollinateSound;

            if PollinateSound then
                PollinateSound:Stop();
                PollinateSound:Destroy();
            end;

            Client.PollinateSound = nil;
            local IdleSound = Client.IdleSound;

            if IdleSound then
                IdleSound:Stop();
                IdleSound:Destroy();
            end;

            Client.IdleSound = nil;
            local BossSound = Client.BossSound;

            if BossSound then
                BossSound:Stop();
                BossSound:Destroy();
            end;

            Client.BossSound = nil;

            if v2.Client.DamagedAnimation then
                v2.Client.DamagedAnimation:Stop(0);
            end;

            if v2.Client.AttackAnimation then
                v2.Client.AttackAnimation:Stop(0);
            end;

            if v2.Client.IdleAnimation then
                v2.Client.IdleAnimation:Stop(0);
            end;

            if v2.Client.Hitbox then
                v2.Client.Hitbox:Destroy();
            end;

            if v2.Client.HealthBar then
                v2.Client.HealthBar:Destroy();
            end;
        end;
    end;

    table.clear(State.BeeStates);
    table.clear(IdentifierMap);
    table.clear(u60);
    u3 = true;

    for i, v in p61 do
        local v62 = i;
        local v63 = {};

        for i2, v2 in v.ActiveBees do
            local v64 = {
                CFrame = v2.CFrame or CFrame.identity,
                BeeName = v2.BeeName,
                Speed = v2.Speed,
                PollinationQuality = v2.PollinationQuality,
                PollinationRate = v2.PollinationRate,
                State = v2.State,
                Health = v2.Health,
                LastAttack = v2.LastAttack,
                LastHealTime = v2.LastHealTime,
                TargetPlayer = v2.TargetPlayer,
                TargetBee = v2.TargetBee,
                GuardObject = v2.GuardObject,
                Player = v62,
                Identifier = v2.Identifier,
                PollinatingPlant = v2.PollinatingPlant,
                IsIllusion = v2.IsIllusion,
                IllusionOwnerUUID = v2.IllusionOwnerUUID,
                IllusionCopiedUUID = v2.IllusionCopiedUUID,
                IsSummon = v2.IsSummon,
                SummonOwnerUUID = v2.SummonOwnerUUID,
                Custom = v2.Custom,
                Slot = v2.Slot,
                Enchantment = v2.Enchantment,
                WaspStunExpiresAt = v2.WaspStunExpiresAt,
                WaspPoisonTick = v2.WaspPoisonTick,
                WaspKnockbackCFrame = v2.WaspKnockbackCFrame,
                WaspWarsongBuffed = v2.WaspWarsongBuffed,
                DidDie = v2.DidDie
            };
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1, 1, 1);
            Part.Shape = Enum.PartType.Ball;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = true;
            Part.Color = Color3.fromRGB(255, 200, 0);
            Part.Material = Enum.Material.Neon;
            Part.CFrame = v64.CFrame;
            CollectionService:AddTag(Part, "BeeHover");
            Part.Parent = workspace;
            v63[i2] = {
                Server = v64,
                Client = {
                    LerpAlpha = 1,
                    Hitbox = Part,
                    FromCFrame = v64.CFrame,
                    ToCFrame = v64.CFrame
                }
            };
            ApplyBeeAttributes(v63[i2]);
            local Client = v63[i2].Client;
            IdentifierMap[v64.Identifier] = v64;
            u60[v64.Identifier] = Client;
            SetEntryVisible(v62, i2, v63[i2], (ShouldShowEntry(v62, v63[i2])));
            u2.OnBeeCreated:Fire(i2, v63[i2]);
        end;

        State.BeeStates[v62] = v63;
    end;
end;

local function ProcessCreate(p65) -- Line: 620
    -- upvalues: State (copy), CollectionService (copy), ApplyBeeAttributes (copy), IdentifierMap (copy), u60 (copy), SetEntryVisible (copy), ShouldShowEntry (copy), BeeRegistry (copy), u2 (copy)
    for i, v in p65 do
        if not State.BeeStates[i] then
            State.BeeStates[i] = {};
        end;

        local v66 = State.BeeStates[i];
        local v67 = i;

        for i2, v2 in v do
            local v68 = {
                CFrame = v2.CFrame or CFrame.identity,
                BeeName = v2.BeeName,
                Speed = v2.Speed,
                PollinationQuality = v2.PollinationQuality,
                PollinationRate = v2.PollinationRate,
                State = v2.State,
                Health = v2.Health,
                LastAttack = v2.LastAttack,
                LastHealTime = v2.LastHealTime,
                TargetPlayer = v2.TargetPlayer,
                TargetBee = v2.TargetBee,
                GuardObject = v2.GuardObject,
                Player = v67,
                Identifier = v2.Identifier,
                IsIllusion = v2.IsIllusion,
                IllusionOwnerUUID = v2.IllusionOwnerUUID,
                IllusionCopiedUUID = v2.IllusionCopiedUUID,
                IsSummon = v2.IsSummon,
                SummonOwnerUUID = v2.SummonOwnerUUID,
                Slot = v2.Slot,
                Enchantment = v2.Enchantment,
                WaspStunExpiresAt = v2.WaspStunExpiresAt,
                WaspPoisonTick = v2.WaspPoisonTick,
                WaspKnockbackCFrame = v2.WaspKnockbackCFrame,
                WaspWarsongBuffed = v2.WaspWarsongBuffed,
                DidDie = v2.DidDie
            };
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(1, 1, 1);
            Part.Shape = Enum.PartType.Ball;
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanQuery = false;
            Part.Color = Color3.fromRGB(255, 200, 0);
            Part.Material = Enum.Material.Neon;
            Part.CFrame = v68.CFrame;
            CollectionService:AddTag(Part, "BeeHover");
            Part.Parent = workspace;
            v66[i2] = {
                Server = v68,
                Client = {
                    LerpAlpha = 1,
                    PreviousDistance = 0,
                    UseSpring = false,
                    Hitbox = Part,
                    FromCFrame = v68.CFrame,
                    ToCFrame = v68.CFrame
                }
            };
            ApplyBeeAttributes(v66[i2]);
            local v69 = v66[i2];
            IdentifierMap[v2.Identifier] = v68;
            u60[v2.Identifier] = v69.Client;
            SetEntryVisible(v67, i2, v69, (ShouldShowEntry(v67, v69)));
            local SpawnSound = BeeRegistry[v69.Server.BeeName].SpawnSound;

            if SpawnSound and ShouldShowEntry(v67, v69) then
                local Sound = Instance.new("Sound");
                Sound.SoundId = SpawnSound;
                Sound.Looped = false;
                Sound.Parent = Part;
                Sound:Play();
                Sound.Ended:Once(function() -- Line: 703
                    -- upvalues: Sound (copy)
                    Sound:Destroy();
                end);
            end;

            u2.OnBeeCreated:Fire(i2, v69);
        end;
    end;
end;

local function playHurtEffects(p70: table) -- Line: 713
    -- upvalues: BeeRegistry (copy)
    local Client = p70.Client;
    local Server = p70.Server;
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(255, 0, 0);
    Highlight.Parent = Client.Model;
    task.delay(0.3, function() -- Line: 723
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);

    if Client.DamagedAnimation then
        Client.DamagedAnimation:Play();
    end;

    local Hitbox = Client.Hitbox;

    if not Hitbox then
        return;
    end;

    local DamagedSound = BeeRegistry[Server.BeeName].DamagedSound;

    if not DamagedSound then
        return;
    end;

    local Sound = Instance.new("Sound");

    if typeof(DamagedSound) ~= "string" then
        DamagedSound = DamagedSound[math.random(1, #DamagedSound)];
    end;

    Sound.SoundId = DamagedSound;
    Sound.Looped = false;
    Sound.Parent = Hitbox;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 746
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
end;

local function EmitAttachment(p71: userdata) -- Line: 751
    for _, descendant in p71:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
        end;
    end;
end;

local function PlayPoisonTickVFX(p72: table) -- Line: 759
    -- upvalues: VFX (copy), EmitAttachment (copy)
    local Hitbox = p72.Client.Hitbox;

    if not Hitbox then
        return;
    end;

    if p72.Client.IsVisible == false then
        return;
    end;

    local Poison = VFX:FindFirstChild("Poison");

    if not Poison then
        return;
    end;

    local Emit = Poison:FindFirstChild("Emit", true);

    if not (Emit and Emit:IsA("Attachment")) then
        return;
    end;

    local u73 = Emit:Clone();
    u73.Parent = Hitbox;
    EmitAttachment(u73);
    task.delay(2, function() -- Line: 775
        -- upvalues: u73 (copy)
        if u73.Parent then
            u73:Destroy();
        end;
    end);
end;

local function SetStunnedVFX(p74: table, p75: boolean) -- Line: 782
    -- upvalues: VFX (copy)
    local Client = p74.Client;
    local Hitbox = Client.Hitbox;

    if not Hitbox then
        return;
    end;

    if not p75 then
        if Client.StunnedVFX then
            Client.StunnedVFX:Destroy();
            Client.StunnedVFX = nil;
        end;

        return;
    end;

    if Client.IsVisible == false then
        return;
    end;

    if Client.StunnedVFX then
        return;
    end;

    local Stunned = VFX:FindFirstChild("Stunned");

    if not Stunned then
        return;
    end;

    local Stunned2 = Stunned:FindFirstChild("Stunned", true);

    if not (Stunned2 and Stunned2:IsA("Attachment")) then
        return;
    end;

    Client.StunnedVFX = Stunned2:Clone();
    Client.StunnedVFX.Parent = Hitbox;
end;

local function SetWarsongBuffVFX(p76: table, p77: boolean) -- Line: 808
    -- upvalues: VFX (copy)
    local Client = p76.Client;
    local Hitbox = Client.Hitbox;

    if not Hitbox then
        return;
    end;

    if not p77 then
        if Client.WarsongBuffVFX then
            Client.WarsongBuffVFX:Destroy();
            Client.WarsongBuffVFX = nil;
        end;

        return;
    end;

    if Client.IsVisible == false then
        return;
    end;

    if Client.WarsongBuffVFX then
        return;
    end;

    local WarsongBuffVFX = VFX:FindFirstChild("WarsongBuffVFX", true);

    if not (WarsongBuffVFX and WarsongBuffVFX:IsA("Attachment")) then
        return;
    end;

    Client.WarsongBuffVFX = WarsongBuffVFX:Clone();
    Client.WarsongBuffVFX.Parent = Hitbox;

    for _, descendant in Client.WarsongBuffVFX:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;
end;

local function playFullHealEffect(p78: table) -- Line: 837
    -- upvalues: VFX (copy), ParticleHelper (copy)
    local Client = p78.Client;
    local _ = p78.Server;
    local u79 = VFX:FindFirstChild("Live"):Clone();
    u79.Position = Client.Hitbox.Position;
    u79.Parent = Client.Hitbox;
    ParticleHelper:EmitParticles(u79);
    task.delay(1, function() -- Line: 847
        -- upvalues: u79 (copy)
        u79:Destroy();
    end);
end;

local function playHealEffect(p80: table) -- Line: 852
    local Client = p80.Client;
    local _ = p80.Server;
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 0.5;
    Highlight.OutlineTransparency = 1;
    Highlight.FillColor = Color3.fromRGB(0, 255, 0);
    Highlight.Parent = Client.Model;
    task.delay(0.3, function() -- Line: 862
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);

    if Client.DamagedAnimation and Client.DamagedAnimation.IsPlaying then
        Client.DamagedAnimation:Stop(0.15);
    end;
end;

local function playDeathVFX(p81: vector) -- Line: 873
    -- upvalues: VFX (copy), ParticleHelper (copy)
    local u82 = VFX:FindFirstChild("Die"):Clone();
    u82.Position = p81;
    u82.Parent = workspace;
    ParticleHelper:EmitParticles(u82);
    task.delay(1, function() -- Line: 881
        -- upvalues: u82 (copy)
        u82:Destroy();
    end);
end;

local function playDeathSoundEffect(p83) -- Line: 886
    -- upvalues: BeeRegistry (copy)
    local DeathSound = BeeRegistry[p83.Server.BeeName].DeathSound;

    if not DeathSound then
        return;
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = DeathSound;
    Sound.Looped = false;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Position = p83.Client.Hitbox.Position;
    Part.Parent = workspace;
    Sound.Parent = Part;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 910
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local function GetClientMaxHealth(p84: table) -- Line: 920
    -- upvalues: BeeRegistry (copy), BeeEnchantmentRegistry (copy), Players (copy), LocalPlayer (copy)
    local v85 = BeeRegistry[p84.Server.BeeName];

    if not v85 then
        return 1;
    end;

    local MaxHealth = v85.Stats.MaxHealth;
    local Enchantment = p84.Server.Enchantment;

    if Enchantment then
        Enchantment = BeeEnchantmentRegistry.Entries[Enchantment];
    end;

    if Enchantment then
        Enchantment = Enchantment.Modifiers;
    end;

    if Enchantment then
        MaxHealth = MaxHealth * (Enchantment.MaxHealthMult or 1);
    end;

    if p84.Server.Player == `Player_{Players.LocalPlayer.UserId}` then
        return MaxHealth + (LocalPlayer:GetAttribute("BeeHealthBonus") or 0);
    end;

    return MaxHealth;
end;

local Color3_fromRGB_ret = Color3.fromRGB(220, 50, 50);
local Color3_fromRGB_ret2 = Color3.fromRGB(160, 50, 220);

function u2.UpdateHealthBar(p86: table, p87: table, p88: string, p89: number?) -- Line: 951
    -- upvalues: BeeRegistry (copy), GetClientMaxHealth (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), LocalPlayer (copy), Players (copy)
    local HealthBar = p87.Client.HealthBar;

    if not HealthBar then
        return;
    end;

    local Server = p87.Server;
    local v90 = BeeRegistry[Server.BeeName];

    if not v90 then
        return;
    end;

    local v91 = GetClientMaxHealth(p87);
    local v92 = Server.State == "Nesting";
    HealthBar.StudsOffsetWorldSpace = v92 and Vector3.new(0, 0, 0) or Vector3.new(0, -4, 0);
    HealthBar.MaxDistance = v92 and 75 or 50;
    local v93 = p89 or Server.Health;
    local v94 = v91 <= 0 and 0 or v93 / v91;
    local v95;

    if (v90.IsWasp == true or (Server.Player == "wasp-colony" or Server.Player == "wasp-wave-survival")) and true or p88 == "wasp-wave-survival" then
        v95 = Color3_fromRGB_ret2;
    else
        v95 = Color3_fromRGB_ret;
    end;

    local HeartBaseRotations = p87.Client.HeartBaseRotations;

    for i = 1, 4 do
        local v96 = HealthBar:FindFirstChild((tostring(i)));
        local v97;

        if v96 then
            local Heart = v96:FindFirstChild("Heart");

            if Heart then
                local math_clamp_ret = math.clamp((v94 - (i - 1) * 0.25) / 0.25, 0, 1);
                v96.Visible = math_clamp_ret > 0;
                Heart.ImageColor3 = v95;
                local v98 = Heart:FindFirstChildOfClass("UIGradient");

                if v98 and HeartBaseRotations then
                    v98.Rotation = math.clamp(HeartBaseRotations[i] + (1 - math_clamp_ret) * 92, HeartBaseRotations[i], HeartBaseRotations[i] + 92);
                    v97 = i;
                else
                    v97 = i;
                end;
            else
                v97 = i;
            end;
        else
            v97 = i;
        end;
    end;

    local v99 = LocalPlayer:GetAttribute("ShovelOnCooldown") or (LocalPlayer:GetAttribute("InWaspCombat") or false);
    local v100 = v93 < v91;
    local _ = HealthBar.Enabled;

    if p87.Client.IsVisible == false then
        v100 = false;
    elseif v100 then
        v100 = v99 or p88 == `Player_{Players.LocalPlayer.UserId}`;
    end;

    HealthBar.Enabled = v100;
end;

local function ProcessStateUpdate(p101) -- Line: 1010
    -- upvalues: State (copy), Players (copy), u5 (copy), Notification (copy), GetClientMaxHealth (copy), u2 (copy), ShouldShowEntry (copy), playHurtEffects (copy), DamageIndicator (copy), playHealEffect (copy), playFullHealEffect (copy), playDeathVFX (copy), playDeathSoundEffect (copy), PlayPoisonTickVFX (copy), SetStunnedVFX (copy), SetWarsongBuffVFX (copy), LocalPlayer (copy), u4 (ref), ReplicatedStorage (copy), BeeItemLoader (copy), ApplyBeeAttributes (copy)
    for i, v in p101 do
        local v102 = State.BeeStates[i];

        if v102 then
            local v103 = i;

            for i2, v2 in v do
                local u104 = v102[i2];

                if u104 then
                    local v105 = i2;

                    for i3, v3 in v2 do
                        if i3 == "DidDie" and (v3 == true and (v103 == `Player_{Players.LocalPlayer.UserId}` and (u104.Server.BeeName ~= "Skeleton Bee" and not u5[v105]))) then
                            u5[v105] = true;
                            Notification:CreateNotification((`Your {u104.Server.BeeName} was defeated in combat!`));
                        end;

                        if i3 == "Health" then
                            local v106 = GetClientMaxHealth(u104);
                            u2:UpdateHealthBar(u104, v103, v3);

                            if v3 < u104.Server[i3] and ShouldShowEntry(v103, u104) then
                                local v107 = u104.Server[i3] - v3;
                                playHurtEffects(u104);
                                DamageIndicator({
                                    Position = (u104.Client.SmoothedCFrame or (u104.Client.PredictedCFrame or u104.Server.CFrame)).Position,
                                    Text = `{math.floor(v107)}`,
                                    textColor = Color3.fromRGB(255, 80, 80)
                                });
                            end;

                            if u104.Server[i3] < v3 and ShouldShowEntry(v103, u104) then
                                playHealEffect(u104);
                            end;

                            if v106 <= v3 and (v103 == `Player_{Players.LocalPlayer.UserId}` and ShouldShowEntry(v103, u104)) then
                                u5[v105] = nil;
                                playFullHealEffect(u104);

                                if u104.Server.State == "Nesting" then
                                    Notification:CreateNotification((`Your {u104.Server.BeeName} rejoined the battle!`));
                                end;

                                local HealthBar = u104.Client.HealthBar;

                                if HealthBar then
                                    if u104.Client.HealthBarThread then
                                        task.cancel(u104.Client.HealthBarThread);
                                    end;

                                    u104.Client.HealthBarThread = task.delay(2, function() -- Line: 1063
                                        -- upvalues: HealthBar (copy), u104 (copy)
                                        HealthBar.Enabled = false;
                                        u104.Client.HealthBarThread = nil;
                                    end);
                                end;
                            end;

                            if u104.Server.Health > 0 and (v3 <= 0 and ShouldShowEntry(v103, u104)) then
                                playDeathVFX((u104.Client.SmoothedCFrame or (u104.Client.PredictedCFrame or u104.Server.CFrame)).Position);
                                playDeathSoundEffect(u104);
                            end;
                        end;

                        if i3 == "WaspPoisonTick" then
                            PlayPoisonTickVFX(u104);
                        end;

                        if i3 == "WaspStunExpiresAt" then
                            local v108;

                            if v3 then
                                v108 = workspace:GetServerTimeNow() < v3;
                            else
                                v108 = v3;
                            end;

                            SetStunnedVFX(u104, v108);
                        end;

                        if i3 == "WaspWarsongBuffed" then
                            SetWarsongBuffVFX(u104, v3 == true);
                        end;

                        if i3 == "LastAttack" and v103 == `Player_{Players.LocalPlayer.UserId}` then
                            LocalPlayer:SetAttribute("InWaspCombat", true);

                            if u4 then
                                task.cancel(u4);
                            end;

                            u4 = task.delay(10, function() -- Line: 1095
                                -- upvalues: LocalPlayer (ref), u4 (ref)
                                LocalPlayer:SetAttribute("InWaspCombat", false);
                                u4 = nil;
                            end);
                        end;

                        if i3 == "State" and (v3 == "Nesting" and u104.Server.DidDie) then
                            local Slot = u104.Server.Slot;
                            local ResolvedSlot = u104.Client.ResolvedSlot;

                            if not ResolvedSlot and Slot then
                                ResolvedSlot = require(ReplicatedStorage.Modules.GetFarm)(LocalPlayer);

                                if ResolvedSlot then
                                    ResolvedSlot = ResolvedSlot:FindFirstChild("CurrentExpansion");
                                end;

                                if ResolvedSlot then
                                    ResolvedSlot = ResolvedSlot:FindFirstChild("Custom");
                                end;

                                if ResolvedSlot then
                                    ResolvedSlot = ResolvedSlot:FindFirstChild("Hive");
                                end;

                                if ResolvedSlot then
                                    ResolvedSlot = ResolvedSlot:FindFirstChild((tostring(Slot)));
                                end;
                            end;

                            if ResolvedSlot then
                                local v109 = ResolvedSlot.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, -0.5, 0);
                                u104.Client.PredictedCFrame = v109;
                                u104.Client.SmoothedCFrame = v109;
                                u104.Client.LockFacing = true;
                            end;
                        end;

                        if i3 == "WaspKnockbackCFrame" and typeof(v3) == "CFrame" then
                            u104.Client.PredictedCFrame = v3;
                            u104.Client.SmoothedCFrame = v3;
                            u104.Client.FromCFrame = v3;
                            u104.Client.ToCFrame = v3;
                            u104.Client.LerpAlpha = 1;
                        end;

                        u2.OnBeeStateUpdate:Fire(v105, u104, i3, v3);
                        u104.Server[i3] = v3;

                        if i3 == "Enchantment" then
                            BeeItemLoader(u104);
                        end;
                    end;

                    ApplyBeeAttributes(u104);
                end;
            end;
        end;
    end;
end;

local function ProcessDestroy(p110) -- Line: 1144
    -- upvalues: State (copy), playDeathVFX (copy), u2 (copy), IdentifierMap (copy), u60 (copy), u5 (copy)
    for i, v in p110 do
        local v111 = State.BeeStates[i];

        if v111 then
            for i2 in v do
                local v112 = v111[i2];

                if v112 then
                    playDeathVFX((v112.Client.SmoothedCFrame or (v112.Client.PredictedCFrame or v112.Server.CFrame)).Position);
                    u2.OnBeeDestroyed:Fire(i2, v112);
                    local Identifier = v112.Server.Identifier;
                    IdentifierMap[Identifier] = nil;
                    u60[Identifier] = nil;
                    local Client = v112.Client;
                    local FollowPlayerSound = Client.FollowPlayerSound;

                    if FollowPlayerSound then
                        FollowPlayerSound:Stop();
                        FollowPlayerSound:Destroy();
                    end;

                    Client.FollowPlayerSound = nil;
                    local PollinateSound = Client.PollinateSound;

                    if PollinateSound then
                        PollinateSound:Stop();
                        PollinateSound:Destroy();
                    end;

                    Client.PollinateSound = nil;
                    local IdleSound = Client.IdleSound;

                    if IdleSound then
                        IdleSound:Stop();
                        IdleSound:Destroy();
                    end;

                    Client.IdleSound = nil;
                    local BossSound = Client.BossSound;

                    if BossSound then
                        BossSound:Stop();
                        BossSound:Destroy();
                    end;

                    Client.BossSound = nil;

                    if v112.Client.Hitbox then
                        v112.Client.Hitbox:Destroy();
                    end;

                    if v112.Client.HealthBar then
                        v112.Client.HealthBar:Destroy();
                    end;

                    u5[i2] = nil;
                    v111[i2] = nil;
                end;
            end;
        end;
    end;
end;

local function OnReliable(p113) -- Line: 1179
    -- upvalues: ProcessSynchronize (copy), ProcessCreate (copy), ProcessStateUpdate (copy), ProcessDestroy (copy)
    if p113.Synchronize then
        ProcessSynchronize(p113.Synchronize);

        return;
    end;

    if p113.Create then
        ProcessCreate(p113.Create);
    end;

    if p113.StateUpdate then
        ProcessStateUpdate(p113.StateUpdate);
    end;

    if p113.Destroy then
        ProcessDestroy(p113.Destroy);
    end;
end;

local function SnapClientToCFrame(p114: table, p115) -- Line: 1198
    p114.PredictedCFrame = nil;
    p114.SmoothedCFrame = p115;
    p114.FromCFrame = p115;
    p114.ToCFrame = p115;
    p114.LerpAlpha = 1;
    p114.PreviousDistance = 0;
    p114.UseSpring = false;

    if p114.Hitbox then
        p114.Hitbox.CFrame = p115;
    end;
end;

local function OnUnreliable(p116: buffer) -- Line: 1212
    -- upvalues: u3 (ref), UnpackCFrames (copy), IdentifierMap (copy), u60 (copy)
    if not u3 then
        return;
    end;

    for i, v in UnpackCFrames(p116) do
        local v117 = IdentifierMap[i];

        if v117 then
            v117.CFrame = CFrame.new(v);
        end;

        local v118 = u60[i];

        if v118 then
            local CFrame_new_ret = CFrame.new(v);

            if (v - (v118.SmoothedCFrame or v118.ToCFrame or (v118.FromCFrame or CFrame_new_ret)).Position).Magnitude >= 1000 then
                v118.PredictedCFrame = nil;
                v118.SmoothedCFrame = CFrame_new_ret;
                v118.FromCFrame = CFrame_new_ret;
                v118.ToCFrame = CFrame_new_ret;
                v118.LerpAlpha = 1;
                v118.PreviousDistance = 0;
                v118.UseSpring = false;

                if v118.Hitbox then
                    v118.Hitbox.CFrame = CFrame_new_ret;
                end;
            else
                local Magnitude = (v - v118.ToCFrame.Position).Magnitude;
                local v119;

                if (v118.PreviousDistance or 0) > 1 then
                    v119 = Magnitude < 0.5;
                else
                    v119 = false;
                end;

                v118.UseSpring = v119;
                v118.PreviousDistance = Magnitude;
                v118.FromCFrame = v118.ToCFrame;
                v118.ToCFrame = CFrame_new_ret;
                v118.LerpAlpha = 0;
            end;
        end;
    end;
end;

function u2.GetBeesInRadius(p120: table, p121: vector, p122: number, p123: function) -- Line: 1246
    -- upvalues: u2 (copy)
    local v124 = {};

    for i = math.floor((p121.X - p122) / 4), math.floor((p121.X + p122) / 4) do
        local v125 = i;

        for i2 = math.floor((p121.Y - p122) / 4), math.floor((p121.Y + p122) / 4) do
            local v126 = i2;

            for i3 = math.floor((p121.Z - p122) / 4), math.floor((p121.Z + p122) / 4) do
                local Vector3_new_ret = Vector3.new(v125 * 4, v126 * 4, i3 * 4);
                local v127;

                if u2.State.SpatialGrid[Vector3_new_ret] then
                    v127 = i3;

                    for i4, v in u2.State.SpatialGrid[Vector3_new_ret] do
                        if ((v.Client.PredictedCFrame or (v.Client.SmoothedCFrame or v.Server.CFrame)).Position - p121).Magnitude <= p122 and (not p123 or p123(i4, v)) then
                            v124[i4] = v;
                        end;
                    end;
                else
                    v127 = i3;
                end;
            end;
        end;
    end;

    return v124;
end;

function u2.GetEntry(p128: table, p129: any, p130: string) -- Line: 1271
    -- upvalues: State (copy)
    local v131;

    if typeof(p129) == "string" then
        v131 = State.BeeStates[p129];
    else
        v131 = State.BeeStates[`Player_{p129.UserId}`];
    end;

    if v131 then
        return v131[p130];
    end;

    warn("[BeeColonyStateController] Player not found: ", p129);

    return nil;
end;

function u2.GetHitbox(p132: table, p133: string, p134: string) -- Line: 1281
    -- upvalues: u2 (copy)
    local Entry = u2:GetEntry(p133, p134);

    if Entry then
        return Entry.Client.Hitbox;
    end;

    return nil;
end;

local function playAttackVFX(p135, p136) -- Line: 1288
    -- upvalues: VFX (copy), ParticleHelper (copy)
    local v137 = p136.Client.PredictedCFrame or (p136.Client.SmoothedCFrame or p136.Server.CFrame);
    local v138 = p135.Client.PredictedCFrame or (p135.Client.SmoothedCFrame or p136.Server.CFrame);

    if p135.Client.RenderOffset then
        v138 = v138 * p135.Client.RenderOffset;
    end;

    if p136.Client.RenderOffset then
        v137 = v137 * p136.Client.RenderOffset;
    end;

    local u139 = VFX.Attack:Clone();
    u139.CFrame = CFrame.lookAt(v138.Position, v137.Position);
    u139.Parent = workspace;
    ParticleHelper:EmitParticles(u139);
    task.delay(1, function() -- Line: 1307
        -- upvalues: u139 (copy)
        u139:Destroy();
    end);
end;

function u2.Routine(p140: table, p141: number) -- Line: 1312
    -- upvalues: UpdateSoundAllowances (copy), State (copy), Players (copy), u1 (copy), BeeRegistry (copy), u2 (copy), playAttackVFX (copy), StartLoopedSound (copy)
    UpdateSoundAllowances();

    for i, v in State.BeeStates do
        local v142 = string.split(i, "_")[2];
        local v143 = tonumber(v142);

        if not v143 or Players:GetPlayerByUserId(v143) then
            local v144 = i;
            local v145 = {};

            for i2 in u1 do
                v145[i2] = {};
            end;

            for i2, v2 in v do
                if v2.Client.IsVisible ~= false then
                    local v146, v147, v148, v149, v150, v151;

                    if workspace:GetServerTimeNow() - v2.Server.LastAttack >= BeeRegistry[v2.Server.BeeName].Stats.AttackCooldown then
                        v2.Client.AttackAnimationPlayed = false;
                        v146 = v2.Client.PredictedState or v2.Server.State;
                        v147 = (v146 == "FollowPlayer" or v146 == "Pollinate") and true or v146 == "FlowerRush";
                        v148 = v2.Client;

                        if v147 and not v148.AllowFollowPlayerSound then
                            v147 = false;
                        end;

                        if v147 then
                            v149 = v148.Hitbox;

                            if v149 then
                                v148.FollowPlayerSound = StartLoopedSound(v149, v148.FollowPlayerSound, "FollowPlayer");
                            end;
                        else
                            v150 = v148.FollowPlayerSound;

                            if v150 then
                                v150:Stop();
                                v150:Destroy();
                            end;

                            v148.FollowPlayerSound = nil;
                        end;

                        if v146 ~= "Pollinate" and v146 ~= "FlowerRush" then
                            u2:SetPollinateSoundEnabled(v2, false);
                        end;

                        v151 = v145[v2.Client.IsSpawning and "Spawning" or v146];

                        if v151 then
                            v151[i2] = v2;
                        end;
                    end;

                    if v2.Server.TargetPlayer and v2.Server.TargetBee then
                        local Entry = u2:GetEntry(v2.Server.TargetPlayer, v2.Server.TargetBee);

                        if Entry and not v2.Client.AttackAnimationPlayed then
                            playAttackVFX(v2, Entry);
                        end;

                        if not v2.Client.AttackAnimationPlayed then
                            v2.Client.AttackAnimation:Play();
                            v2.Client.AttackAnimation:AdjustSpeed(3);
                            v2.Client.AttackAnimationPlayed = true;
                        end;

                        v146 = v2.Client.PredictedState or v2.Server.State;
                        v147 = (v146 == "FollowPlayer" or v146 == "Pollinate") and true or v146 == "FlowerRush";
                        v148 = v2.Client;

                        if v147 and not v148.AllowFollowPlayerSound then
                            v147 = false;
                        end;

                        if v147 then
                            v149 = v148.Hitbox;

                            if v149 then
                                v148.FollowPlayerSound = StartLoopedSound(v149, v148.FollowPlayerSound, "FollowPlayer");
                            end;
                        else
                            v150 = v148.FollowPlayerSound;

                            if v150 then
                                v150:Stop();
                                v150:Destroy();
                            end;

                            v148.FollowPlayerSound = nil;
                        end;

                        if v146 ~= "Pollinate" and v146 ~= "FlowerRush" then
                            u2:SetPollinateSoundEnabled(v2, false);
                        end;

                        v151 = v145[v2.Client.IsSpawning and "Spawning" or v146];

                        if v151 then
                            v151[i2] = v2;
                        end;
                    end;
                end;
            end;

            for i2, v2 in v145 do
                local v152 = u1[i2];

                if v152 then
                    local success, result = pcall(v152, v144, p141, v2);

                    if not success then
                        warn((`[BeeColony] {i2} handler error: {result}`));
                    end;
                end;
            end;
        end;
    end;
end;

local u153 = 0;
local u154 = 0;

local function PlayRewardPopSound(p155: vector) -- Line: 1394
    -- upvalues: u154 (ref), u153 (ref)
    local os_clock_ret = os.clock();

    if os_clock_ret - u154 > 0.35 then
        u153 = 0;
    end;

    u153 = u153 + 1;
    u154 = os_clock_ret;
    local Part = Instance.new("Part");
    Part.Name = "RewardPopSound";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Position = p155;
    Part.Parent = workspace;
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://6586979979";
    Sound.Volume = 0.45;
    Sound.PlaybackSpeed = math.clamp((u153 - 1) * 0.08 + 1, 1, 1.75);
    Sound.Parent = Part;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 1426
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
    task.delay(2, function() -- Line: 1430
        -- upvalues: Part (copy)
        if Part.Parent then
            Part:Destroy();
        end;
    end);
end;

local function GetRewardPickupFolder() -- Line: 1437
    local BeeRewardPickups = workspace:FindFirstChild("BeeRewardPickups");

    if not BeeRewardPickups then
        BeeRewardPickups = Instance.new("Folder");
        BeeRewardPickups.Name = "BeeRewardPickups";
        BeeRewardPickups.Parent = workspace;
    end;

    return BeeRewardPickups;
end;

local function PreparePickupModel(p156: userdata) -- Line: 1449
    local v157 = nil;

    if not p156:IsA("BasePart") then
        if p156:IsA("Model") then
            v157 = p156.PrimaryPart or p156:FindFirstChildWhichIsA("BasePart", true);

            if v157 then
                p156.PrimaryPart = v157;
            end;

            for _, descendant in p156:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = true;
                    descendant.CanCollide = false;
                    descendant.CanQuery = false;
                    descendant.CanTouch = false;
                end;
            end;
        end;

        return v157;
    end;

    p156.Anchored = true;
    p156.CanCollide = false;
    p156.CanQuery = false;
    p156.CanTouch = false;

    return p156;
end;

local function PivotPickup(p158: userdata, p159) -- Line: 1478
    if p158:IsA("Model") then
        p158:PivotTo(p159);

        return;
    end;

    if p158:IsA("BasePart") then
        p158.CFrame = p159;
    end;
end;

local function GetCurrencyModel(p160: string) -- Line: 1486
    -- upvalues: RoyalJelly (copy), HoneyCoin (copy)
    if p160 == "RoyalJelly" then
        return RoyalJelly;
    end;

    if p160 == "HoneyCoins" then
        return HoneyCoin;
    end;

    return nil;
end;

local function QuadBezier(p161: vector, p162: vector, p163: vector, p164: number) -- Line: 1496
    local v165 = 1 - p164;

    return v165 * v165 * p161 + v165 * 2 * p164 * p162 + p164 * p164 * p163;
end;

local function PlayRewardPickup(p166: string, p167: vector, p168: number, p169: number, u170: function?) -- Line: 1501
    -- upvalues: RoyalJelly (copy), HoneyCoin (copy), LocalPlayer (copy), PreparePickupModel (copy), RunService (copy), PlayRewardPopSound (copy)
    local v171;

    if p166 == "RoyalJelly" then
        v171 = RoyalJelly;
    elseif p166 == "HoneyCoins" then
        v171 = HoneyCoin;
    else
        v171 = nil;
    end;

    if not v171 then
        warn((`Missing pickup model for currency {p166}`));

        if u170 then
            u170();
        end;

        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not (Character and Character:IsA("BasePart")) then
        if u170 then
            u170();
        end;

        return;
    end;

    local u172 = v171:Clone();
    u172.Name = `{p166}Pickup`;
    local BeeRewardPickups = workspace:FindFirstChild("BeeRewardPickups");

    if not BeeRewardPickups then
        BeeRewardPickups = Instance.new("Folder");
        BeeRewardPickups.Name = "BeeRewardPickups";
        BeeRewardPickups.Parent = workspace;
    end;

    u172.Parent = BeeRewardPickups;
    local u173 = PreparePickupModel(u172);

    if not u173 then
        u172:Destroy();

        if u170 then
            u170();
        end;

        return;
    end;

    local v174 = 6.283185307179586 * (p168 / math.max(p169, 1));
    local v175 = math.random(25, 45) / 10;
    local v176 = math.cos(v174) * v175;
    local v177 = math.random(18, 35) / 10;
    local v178 = math.sin(v174) * v175;
    local Vector3_new_ret = Vector3.new(v176, v177, v178);
    local u179 = p167 + Vector3.new(0, 1.25, 0);
    local u180 = u179 + Vector3_new_ret;
    local CFrame_new_ret = CFrame.new(u179);

    if u172:IsA("Model") then
        u172:PivotTo(CFrame_new_ret);
    elseif u172:IsA("BasePart") then
        u172.CFrame = CFrame_new_ret;
    end;

    local u181 = 0.18 + math.random() * 0.06;
    local u182 = 0.45 + math.random() * 0.12;
    task.delay((p168 - 1) * 0.025, function() -- Line: 1552
        -- upvalues: u172 (copy), u181 (copy), u179 (copy), u180 (copy), RunService (ref), LocalPlayer (ref), u182 (copy), u173 (copy), PlayRewardPopSound (ref), u170 (copy)
        if not u172.Parent then
            return;
        end;

        local os_clock_ret = os.clock();

        while u172.Parent do
            local v183 = (os.clock() - os_clock_ret) / u181;
            local math_clamp_ret = math.clamp(v183, 0, 1);
            local v184 = u179:Lerp(u180, 1 - (1 - math_clamp_ret) * (1 - math_clamp_ret));
            local v185 = u172;
            local v186 = CFrame.new(v184) * CFrame.Angles(0, os.clock() * 8, 0);

            if v185:IsA("Model") then
                v185:PivotTo(v186);
            elseif v185:IsA("BasePart") then
                v185.CFrame = v186;
            end;

            if math_clamp_ret >= 1 then
                break;
            end;

            RunService.RenderStepped:Wait();
        end;

        local os_clock_ret2 = os.clock();
        local v187 = u180;

        while u172.Parent do
            local Character2 = LocalPlayer.Character;

            if Character2 then
                Character2 = Character2:FindFirstChild("HumanoidRootPart");
            end;

            if not (Character2 and Character2:IsA("BasePart")) then
                break;
            end;

            local v188 = (os.clock() - os_clock_ret2) / u182;
            local math_clamp_ret = math.clamp(v188, 0, 1);
            local v189 = math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
            local v190 = Character2.Position + Vector3.new(0, 1.5, 0);
            local v191 = v187:Lerp(v190, 0.5) + Vector3.new(0, 4, 0);
            local v192 = 1 - v189;
            local v193 = u172;
            local v194 = CFrame.new(v192 * v192 * v187 + v192 * 2 * v189 * v191 + v189 * v189 * v190) * CFrame.Angles(0, os.clock() * 14, 0);

            if v193:IsA("Model") then
                v193:PivotTo(v194);
            elseif v193:IsA("BasePart") then
                v193.CFrame = v194;
            end;

            if math_clamp_ret >= 1 then
                break;
            end;

            RunService.RenderStepped:Wait();
        end;

        if u172.Parent then
            PlayRewardPopSound(u173.Position);
            u172:Destroy();
        end;

        if u170 then
            u170();
        end;
    end);
end;

local function PlayRewardPickupPacket(p195) -- Line: 1611
    -- upvalues: Notification (copy), PlayRewardPickup (copy)
    if typeof(p195) ~= "table" then
        return;
    end;

    local Origin = p195.Origin;
    local Rewards = p195.Rewards;
    local Notifications = p195.Notifications;

    if typeof(Origin) ~= "Vector3" or typeof(Rewards) ~= "table" then
        return;
    end;

    local u196 = 0;
    local u197 = 0;

    for _, v in Rewards do
        local v198 = v.VisualCount or 1;

        if typeof(v.Currency) == "string" and v198 > 0 then
            u196 = u196 + v198;
        end;
    end;

    local function finishOnePickup() -- Line: 1635
        -- upvalues: u197 (ref), u196 (ref), Notifications (copy), Notification (ref)
        u197 = u197 + 1;

        if u197 < u196 then
            return;
        end;

        if typeof(Notifications) == "table" then
            for _, v in Notifications do
                if typeof(v) == "string" then
                    Notification:CreateNotification(v);
                end;
            end;
        end;
    end;

    if u196 <= 0 then
        if typeof(Notifications) == "table" then
            for _, v in Notifications do
                if typeof(v) == "string" then
                    Notification:CreateNotification(v);
                end;
            end;
        end;

        return;
    end;

    for _, v in Rewards do
        local Currency = v.Currency;
        local v199 = v.VisualCount or 1;

        if typeof(Currency) == "string" then
            for i = 1, v199 do
                PlayRewardPickup(Currency, Origin, i, v199, finishOnePickup);
                local _ = i;
            end;
        end;
    end;
end;

function u2.ForceReloadLocalPlayerBeeModels(p200) -- Line: 1675
    -- upvalues: LocalPlayer (copy), State (copy), SetEntryVisible (copy), ShouldShowEntry (copy)
    local v201 = `Player_{LocalPlayer.UserId}`;
    local v202 = State.BeeStates[v201];

    if not v202 then
        return;
    end;

    for i, v in v202 do
        local Client = v.Client;
        local FollowPlayerSound = Client.FollowPlayerSound;

        if FollowPlayerSound then
            FollowPlayerSound:Stop();
            FollowPlayerSound:Destroy();
        end;

        Client.FollowPlayerSound = nil;
        local PollinateSound = Client.PollinateSound;

        if PollinateSound then
            PollinateSound:Stop();
            PollinateSound:Destroy();
        end;

        Client.PollinateSound = nil;
        local IdleSound = Client.IdleSound;

        if IdleSound then
            IdleSound:Stop();
            IdleSound:Destroy();
        end;

        Client.IdleSound = nil;
        local BossSound = Client.BossSound;

        if BossSound then
            BossSound:Stop();
            BossSound:Destroy();
        end;

        Client.BossSound = nil;

        if Client.Model then
            Client.Model:Destroy();
            Client.Model = nil;
        end;

        Client.RenderOffset = nil;
        Client.IdleAnimation = nil;
        Client.AttackAnimation = nil;
        Client.DamagedAnimation = nil;
        Client.AttackAnimationPlayed = false;
        SetEntryVisible(v201, i, v, (ShouldShowEntry(v201, v)));
    end;
end;

function u2.Start(p203) -- Line: 1703
    -- upvalues: u2 (copy), u1 (copy), script_BeeColonyAbilityEffectsController (copy), LocalPlayer (copy), RefreshBeeVisibility (copy), Reliable (copy), OnReliable (copy), Unreliable (copy), OnUnreliable (copy), ReplicatedStorage (copy), PlayRewardPickupPacket (copy), RunService (copy), u6 (ref), Parts (copy), CFrames (copy), UnreliableHertz (copy), State (copy), Near (copy), Mid (copy), Far (copy), SetStunnedVFX (copy)
    for _, child in script.States:GetChildren() do
        local success, result = pcall(function() -- Line: 1707
            -- upvalues: child (copy), u2 (ref)
            return require(child)(u2);
        end);

        if success then
            u1[child.Name] = result;
        else
            warn((`Failed to load client state {child.Name}: {result}`));
        end;
    end;

    script_BeeColonyAbilityEffectsController(u2);
    LocalPlayer:GetAttributeChangedSignal("OtherPlayerBeeColonyVisibility"):Connect(RefreshBeeVisibility);
    RefreshBeeVisibility();
    Reliable.OnClientEvent:Connect(OnReliable);
    Unreliable.OnClientEvent:Connect(OnUnreliable);
    Reliable:FireServer("RequestSync");
    ReplicatedStorage.GameEvents.BizzyBeeEvent.BeeRewardPickup.OnClientEvent:Connect(PlayRewardPickupPacket);
    task.spawn(function() -- Line: 1731
        -- upvalues: u2 (ref)
        while true do
            u2:Routine((task.wait(0.03333333333333333)));
        end;
    end);
    RunService.RenderStepped:Connect(function(p204) -- Line: 1738
        -- upvalues: u6 (ref), Parts (ref), CFrames (ref), LocalPlayer (ref), UnreliableHertz (ref), State (ref), u2 (ref), Near (ref), Mid (ref), Far (ref), SetStunnedVFX (ref)
        u6 = u6 + 1;
        table.clear(Parts);
        table.clear(CFrames);
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        local Position = Character.Position;
        local v205 = p204 * UnreliableHertz;
        local v206 = 0;

        for _, v in State.BeeStates do
            for i, v2 in v do
                local Client = v2.Client;

                if Client.Hitbox then
                    Client.LerpAlpha = math.min(Client.LerpAlpha + v205, 2);
                    local v207;

                    if Client.PredictedCFrame then
                        v207 = Client.PredictedCFrame;
                    else
                        local LerpAlpha = Client.LerpAlpha;

                        if LerpAlpha <= 1 then
                            v207 = Client.FromCFrame:Lerp(Client.ToCFrame, LerpAlpha);
                        else
                            v207 = Client.ToCFrame + (Client.ToCFrame.Position - Client.FromCFrame.Position) * (LerpAlpha - 1);
                        end;
                    end;

                    if v207 and v207.Position.Magnitude >= 0.01 then
                        local Position2 = (Client.SmoothedCFrame or v207).Position;
                        local v208 = math.floor(Position2.X / 4) * 4;
                        local v209 = math.floor(Position2.Y / 4) * 4;
                        local v210 = math.floor(Position2.Z / 4) * 4;
                        local Vector3_new_ret = Vector3.new(v208, v209, v210);
                        local v211 = Client.SmoothedCFrame and Client.SmoothedCFrame.Position;

                        if not Client.SmoothedCFrame or Client.SmoothedCFrame.Position.Magnitude < 0.01 then
                            Client.SmoothedCFrame = v207;
                        end;

                        Client.SmoothedCFrame = Client.SmoothedCFrame:Lerp(v207, (math.min(p204 * 10, 1)));
                        local SmoothedCFrame = Client.SmoothedCFrame;
                        local Position3 = SmoothedCFrame.Position;
                        local v212 = math.floor(Position3.X / 4) * 4;
                        local v213 = math.floor(Position3.Y / 4) * 4;
                        local v214 = math.floor(Position3.Z / 4) * 4;
                        local Vector3_new_ret2 = Vector3.new(v212, v213, v214);
                        local State2 = u2.State;

                        if Vector3_new_ret2 ~= Vector3_new_ret then
                            if State2.SpatialGrid[Vector3_new_ret] then
                                State2.SpatialGrid[Vector3_new_ret][i] = nil;

                                if not next(State2.SpatialGrid[Vector3_new_ret]) then
                                    State2.SpatialGrid[Vector3_new_ret] = nil;
                                end;
                            end;

                            if not State2.SpatialGrid[Vector3_new_ret2] then
                                State2.SpatialGrid[Vector3_new_ret2] = {};
                            end;

                            State2.SpatialGrid[Vector3_new_ret2][i] = v2;
                        end;

                        if Client.TargetFacingDirection and Client.FacingDirection then
                            Client.FacingDirection = Client.FacingDirection:Lerp(Client.TargetFacingDirection, (math.min(p204, 1)));
                        end;

                        if v211 then
                            local v215 = SmoothedCFrame.Position - v211;
                            local Vector3_new_ret3 = Vector3.new(v215.X, 0, v215.Z);

                            if not Client.LockFacing and Vector3_new_ret3.Magnitude > 0.02 then
                                local Unit = Vector3_new_ret3.Unit;
                                Client.FacingDirection = (Client.FacingDirection or Unit):Lerp(Unit, (math.min(p204 * 8, 1)));
                            end;

                            if Client.FacingDirection then
                                SmoothedCFrame = CFrame.new(SmoothedCFrame.Position, SmoothedCFrame.Position + Client.FacingDirection);
                            end;
                        end;

                        Client.SmoothedCFrame = SmoothedCFrame;

                        if Client.RenderOffset then
                            SmoothedCFrame = SmoothedCFrame * Client.RenderOffset;
                        end;

                        local Magnitude = (SmoothedCFrame.Position - Position).Magnitude;
                        local ServerTimeNow = workspace:GetServerTimeNow();
                        SetStunnedVFX(v2, (v2.Server.WaspStunExpiresAt and ServerTimeNow < v2.Server.WaspStunExpiresAt) == true);

                        if (v2.Server.Identifier + u6) % (Magnitude <= Near and 1 or (Magnitude <= Mid and 2 or (Magnitude <= Far and 4 or 8))) == 0 then
                            v206 = v206 + 1;
                            Parts[v206] = Client.Hitbox;
                            CFrames[v206] = SmoothedCFrame;
                        end;
                    end;
                end;
            end;
        end;

        if v206 > 0 then
            workspace:BulkMoveTo(Parts, CFrames, Enum.BulkMoveMode.FireCFrameChanged);
        end;
    end);
end;

u2:Start();

return u2;