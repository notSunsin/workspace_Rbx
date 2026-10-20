-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("SummerRitualConfig");
workspace:GetAttributeChangedSignal("SummerRitualConfig"):Connect(function() -- Line: 39
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("SummerRitualConfig");
end);
local DataService = require(ReplicatedStorage.Modules.DataService);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.Notification);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local u2 = require(ReplicatedStorage.Modules.Trove).new();

function u1.Start(p3) -- Line: 64
    -- upvalues: Players (copy), CollectionService (copy), Config (ref), ReplicatedStorage (copy), DataService (copy), u1 (copy), RunService (copy), PetMutationRegistry (copy), SelectiveAssetReplication (copy), PetRegistry (copy), TweenService (copy), u2 (copy), MarketController (copy), ConfirmationPromptController (copy), InventoryServiceEnums (copy), ItemImageFinder (copy)
    local LocalPlayer = Players.LocalPlayer;
    local u4 = CollectionService:GetTagged(Config.RITUAL_MODEL_TAG)[1];
    local u5;

    if u4 then
        u5 = u4:WaitForChild("ProximityPrompts");
    else
        u5 = u4;
    end;

    local PetPositon = u4:WaitForChild("PetPositon");
    local PetVisual = u4:WaitForChild("PetVisual");
    local Submit = u4:WaitForChild("Sound"):WaitForChild("Submit");
    local SummerRitual = ReplicatedStorage.GameEvents.SummerRitual;
    local u6 = {
        Status = "Idle",
        FilledSlots = 0,
        PetType = nil,
        PetRarity = nil,
        StartTime = nil,
        Duration = nil,
        Progress = nil,
        LastTick = nil,
        Remaining = nil,
        SlotStates = { false, false, false, false }
    };
    local u7 = nil;
    local u8 = nil;
    local u9 = {
        SlotFilled = Color3.fromRGB(255, 138, 61),
        SlotEmpty = Color3.fromRGB(80, 80, 80),
        FillSlot = Color3.fromRGB(200, 100, 30),
        CenterPet = Color3.fromRGB(200, 100, 30),
        CenterActive = Color3.fromRGB(255, 60, 60),
        CenterClaim = Color3.fromRGB(255, 220, 80),
        FillCenterClaim = Color3.fromRGB(255, 200, 50)
    };
    local TweenInfo_new_ret = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    local function EnsureRitualFields(p10) -- Line: 122
        if not p10 then
            return;
        end;

        if not p10.ShardSlots then
            p10.ShardSlots = { false, false, false, false };
        end;

        if p10.ShardSlots[1] == nil then
            p10.ShardSlots[1] = false;
        end;

        if p10.ShardSlots[2] == nil then
            p10.ShardSlots[2] = false;
        end;

        if p10.ShardSlots[3] == nil then
            p10.ShardSlots[3] = false;
        end;

        if p10.ShardSlots[4] == nil then
            p10.ShardSlots[4] = false;
        end;
    end;

    function u1.GetDevProduct(p11: userdata) -- Line: 132
        -- upvalues: DataService (ref), Config (ref), EnsureRitualFields (copy)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        if Data then
            Data = Data[Config.DATA_KEY];
        end;

        if not Data then
            return;
        end;

        EnsureRitualFields(Data);

        if Data.RitualPetRarity ~= nil then
            return Config.SKIP_PRODUCTS[Data.RitualPetRarity];
        end;
    end;

    local function CalcDuration(p12: string) -- Line: 152
        -- upvalues: Config (ref)
        local math_floor_ret = math.floor(Config.RITUAL_DURATION_BY_RARITY[p12] or Config.RITUAL_DURATION_BY_RARITY.FallBack);

        return math.max(math_floor_ret, 10);
    end;

    local function SetVFX(p13: string, p14: boolean) -- Line: 157
        -- upvalues: u4 (copy)
        if not u4 then
            return;
        end;

        local v15 = u4:FindFirstChild(p13);

        if not v15 then
            return;
        end;

        for _, descendant in v15:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = p14;
            elseif descendant:IsA("Sound") then
                descendant.Playing = p14;
            end;
        end;
    end;

    local function EmitVFX(p16: string, p17: number?) -- Line: 170
        -- upvalues: u4 (copy)
        if not u4 then
            return;
        end;

        local v18 = u4:FindFirstChild(p16);

        if not v18 then
            return;
        end;

        for _, descendant in v18:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(p17 or (descendant:GetAttribute("EmitCount") or 10));
            elseif descendant:IsA("Sound") then
                descendant:Play();
            end;
        end;
    end;

    local u19 = false;
    local u20 = 0;

    local function CollectShardBits() -- Line: 198
        -- upvalues: u4 (copy)
        local v21 = {};
        local v22 = u4 and u4:FindFirstChild("ProximityPrompts");

        if not v22 then
            return v21;
        end;

        for i = 1, 4 do
            local v23 = v22:FindFirstChild("Shard" .. i);

            if v23 then
                v23 = v23:FindFirstChild("Visuals");
            end;

            local v24;

            if v23 then
                v24 = i;

                for _, descendant in v23:GetDescendants() do
                    if descendant:IsA("BasePart") and not descendant:FindFirstChildWhichIsA("Attachment") then
                        table.insert(v21, descendant);
                    end;
                end;
            else
                v24 = i;
            end;
        end;

        return v21;
    end;

    local function Bezier(p25: number, p26: vector, p27: vector, p28: vector, p29: vector) -- Line: 216
        local v30 = 1 - p25;

        return v30 * v30 * v30 * p26 + v30 * 3 * v30 * p25 * p27 + v30 * 3 * p25 * p25 * p28 + p25 * p25 * p25 * p29;
    end;

    local function FlyBitToPet(p31: userdata, u32: vector) -- Line: 224
        -- upvalues: RunService (ref)
        local u33 = p31:Clone();

        for _, child in u33:GetChildren() do
            if child:IsA("Attachment") or (child:IsA("JointInstance") or child:IsA("WeldConstraint")) then
                child:Destroy();
            end;
        end;

        u33.Anchored = true;
        u33.CanCollide = false;
        u33.CanQuery = false;
        u33.CanTouch = false;
        u33.Parent = workspace.CurrentCamera;
        local Position = p31.Position;
        local v34 = u32 - Position;
        local Magnitude = v34.Magnitude;
        local u35 = Position + (Magnitude > 0.01 and -v34.Unit or Vector3.new(0, 0, 1)) * 2 + Vector3.new(0, 1, 0);
        local v36 = Position:Lerp(u32, 0.65);
        local math_clamp_ret = math.clamp(Magnitude * 0.4, 4, 12);
        local u37 = v36 + Vector3.new(0, math_clamp_ret, 0);
        local Transparency = u33.Transparency;
        local math_random_ret = math.random();
        local math_random_ret2 = math.random();
        local Vector3_new_ret = Vector3.new(math_random_ret, math_random_ret2, math.random());
        local u38 = Vector3_new_ret.Magnitude > 0 and Vector3_new_ret.Unit or Vector3.new(0, 1, 0);
        local u39 = 0;
        local u40 = nil;
        u40 = RunService.Heartbeat:Connect(function(p41) -- Line: 253
            -- upvalues: u39 (ref), Position (copy), u35 (copy), u37 (copy), u32 (copy), u33 (copy), u38 (ref), Transparency (copy), u40 (ref)
            u39 = u39 + p41;
            local math_clamp_ret2 = math.clamp(u39 / 1.5, 0, 1);
            local v42 = math_clamp_ret2 * math_clamp_ret2;
            local v43 = 1 - v42;
            u33.CFrame = CFrame.new(v43 * v43 * v43 * Position + v43 * 3 * v43 * v42 * u35 + v43 * 3 * v42 * v42 * u37 + v42 * v42 * v42 * u32) * CFrame.fromAxisAngle(u38, u39 * 8);

            if math_clamp_ret2 > 0.66 then
                u33.Transparency = Transparency + (1 - Transparency) * ((math_clamp_ret2 - 0.66) / 0.34);
            end;

            if math_clamp_ret2 >= 1 then
                u40:Disconnect();
                u33:Destroy();
            end;
        end);
    end;

    local function SetShardFlow(p44: boolean) -- Line: 269
        -- upvalues: u19 (ref), u20 (ref), PetPositon (copy), CollectShardBits (copy), FlyBitToPet (copy)
        if p44 == u19 then
            return;
        end;

        u19 = p44;
        u20 = u20 + 1;

        if not p44 then
            return;
        end;

        local u45 = u20;
        task.spawn(function() -- Line: 276
            -- upvalues: u45 (copy), u20 (ref), PetPositon (ref), CollectShardBits (ref), FlyBitToPet (ref)
            while u45 == u20 do
                local v46 = PetPositon and PetPositon.Position;

                if v46 then
                    local v47 = CollectShardBits();

                    if #v47 > 0 then
                        FlyBitToPet(v47[math.random(1, #v47)], v46);
                    end;
                end;

                task.wait(0.1);
            end;
        end);
    end;

    local function ApplyVFX(p48: string, p49: string?) -- Line: 291
        -- upvalues: SetVFX (copy), u19 (ref), u20 (ref), PetPositon (copy), CollectShardBits (copy), FlyBitToPet (copy), EmitVFX (copy)
        SetVFX("VFX_Idle", p48 == "Idle" and true or p48 == "Ready");
        SetVFX("VFX_Active", p48 == "Active");
        local v50 = p48 == "Active";

        if v50 ~= u19 then
            u19 = v50;
            u20 = u20 + 1;

            if v50 then
                local u51 = u20;
                task.spawn(function() -- Line: 276
                    -- upvalues: u51 (copy), u20 (ref), PetPositon (ref), CollectShardBits (ref), FlyBitToPet (ref)
                    while u51 == u20 do
                        local v52 = PetPositon and PetPositon.Position;

                        if v52 then
                            local v53 = CollectShardBits();

                            if #v53 > 0 then
                                FlyBitToPet(v53[math.random(1, #v53)], v52);
                            end;
                        end;

                        task.wait(0.1);
                    end;
                end);
            end;
        end;

        if p49 == p48 then
            return;
        end;

        if p48 == "Active" then
            EmitVFX("VFX_Start", 1);

            return;
        end;

        if p48 == "Complete" then
            EmitVFX("VFX_End", 1);

            return;
        end;

        if p48 == "Idle" and p49 == "Complete" then
            EmitVFX("VFX_Claim", 1);
        end;
    end;

    local u54 = nil;
    local u55 = nil;
    local u56 = 0;

    local function BlendColor(p57, p58, p59: number) -- Line: 317
        return p57:Lerp(p58, p59);
    end;

    local Color3_fromRGB_ret = Color3.fromRGB(90, 0, 0);
    local Color3_fromRGB_ret2 = Color3.fromRGB(101, 255, 91);

    local function ApplyInfernoFX(p60: userdata) -- Line: 328
        -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
        local Inferno = script:FindFirstChild("Inferno");
        local v61 = Inferno and Inferno:GetChildren() or {};
        local PrimaryPart = p60.PrimaryPart;

        if PrimaryPart then
            for _, v in v61 do
                local v62 = v:Clone();
                v62.Parent = PrimaryPart;

                if v62:IsA("ParticleEmitter") or v62:IsA("Trail") then
                    v62.Enabled = true;
                end;
            end;
        end;

        local v63 = {};
        local v64 = (1 / 0);
        local v65 = (-1 / 0);

        for _, descendant in p60:GetDescendants() do
            if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or (string.find(descendant.Name, "Eye") or (descendant.Name == "RootPart" or (descendant.Name == "RootParts" or (descendant.Name == "FruitHold" or (descendant.Name == "Seat" or descendant.Name == "HumanoidRootPart")))))) then
                table.insert(v63, descendant);
                v64 = math.min(v64, descendant.Position.Y - descendant.Size.Y / 2);
                v65 = math.max(v65, descendant.Position.Y + descendant.Size.Y / 2);
            end;
        end;

        local math_max_ret = math.max(v65 - v64, 0.001);
        local Random_new_ret = Random.new();

        for i, v in v63 do
            if v:IsA("UnionOperation") then
                v.UsePartColor = true;
            end;

            v.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, (math.clamp((v.Position.Y - v64) / math_max_ret, 0, 1)));
            v.Material = Enum.Material.Neon;

            if i % 10 == 0 then
                local Attachment = Instance.new("Attachment");
                Attachment.Position = Vector3.new(0, 0.15, 0);
                Attachment.Parent = v;
                local Attachment2 = Instance.new("Attachment");
                Attachment2.Position = Vector3.new(0, -0.15, 0);
                Attachment2.Parent = v;
                local Trail = Instance.new("Trail");
                Trail.Color = ColorSequence.new(Color3_fromRGB_ret2);
                Trail.LightInfluence = 0;
                Trail.Brightness = 3;
                Trail.Attachment0 = Attachment;
                Trail.Attachment1 = Attachment2;
                Trail.Lifetime = 0.3;
                Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
                Trail.WidthScale = NumberSequence.new(2);
                Trail.Parent = v;
            end;

            if v ~= PrimaryPart and (#v61 > 0 and Random_new_ret:NextNumber() <= 0.1) then
                local v66 = v;

                for i2 = 1, Random_new_ret:NextInteger(1, (math.min(2, #v61))) do
                    local v67 = v61[Random_new_ret:NextInteger(1, #v61)]:Clone();
                    v67.Parent = v66;
                    local v68;

                    if v67:IsA("ParticleEmitter") or v67:IsA("Trail") then
                        v67.Enabled = true;
                        v68 = i2;
                    else
                        v68 = i2;
                    end;
                end;
            end;
        end;
    end;

    local function ApplyMutationVisuals(p69: userdata, p70: string) -- Line: 397
        -- upvalues: Config (ref), ApplyInfernoFX (copy), PetMutationRegistry (ref)
        if p70 == Config.INFERNO_MUTATION_NAME then
            ApplyInfernoFX(p69);

            return;
        end;

        local v71 = PetMutationRegistry.PetMutationRegistry[p70];

        if not v71 then
            return;
        end;

        local Color = v71.Color;

        if not Color then
            return;
        end;

        for _, descendant in p69:GetDescendants() do
            if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                if descendant:IsA("UnionOperation") then
                    descendant.UsePartColor = true;
                end;

                descendant.Color = descendant.Color:Lerp(Color, 0.75);
            end;
        end;
    end;

    local function RenderPet(p72: string, p73: number, p74: string?, p75, p76: userdata?) -- Line: 421
        -- upvalues: SelectiveAssetReplication (ref), PetRegistry (ref), ApplyMutationVisuals (copy), Config (ref)
        local AssetAsync = SelectiveAssetReplication:GetAssetAsync("PetAssets", p72, 10);

        if not AssetAsync then
            warn((`SummerRitualController | No pet asset found for "{p72}"`));

            return nil;
        end;

        local v77 = PetRegistry.PetList[p72];

        if AssetAsync.PrimaryPart then
            local v78 = AssetAsync:Clone();

            for _, descendant in v78:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.CanCollide = false;
                    descendant.CanQuery = false;
                    descendant.CanTouch = false;
                    descendant.Anchored = false;
                end;
            end;

            v78.PrimaryPart.Anchored = true;

            if p73 and p73 ~= 1 then
                v78:ScaleTo(p73);
            end;

            if p74 then
                ApplyMutationVisuals(v78, p74);
            end;

            v78:PivotTo(p75 * (v77 and v77.WeldOffset or CFrame.new()) + Vector3.new(0, Config.Y_RISE_PET_VISUAL, 0));
            local AnimationController = v78:FindFirstChild("AnimationController");

            if AnimationController then
                AnimationController = AnimationController:FindFirstChild("Animator");
            end;

            v78.Parent = p76 or workspace.CurrentCamera;

            if AnimationController and (v77 and (v77.Animations and v77.Animations.Idle)) then
                local v79 = AnimationController:LoadAnimation(v77.Animations.Idle);
                v79.Looped = true;
                v79:Play();
            end;

            return v78;
        end;
    end;

    local function ClearPetVisual() -- Line: 477
        -- upvalues: u56 (ref), u55 (ref), u54 (ref)
        u56 = u56 + 1;
        u55 = nil;

        if u54 then
            u54:Destroy();
            u54 = nil;
        end;
    end;

    local function UpdatePetVisual(p80) -- Line: 488
        -- upvalues: PetPositon (copy), PetVisual (copy), u56 (ref), u55 (ref), u54 (ref), Config (ref), RenderPet (copy), Submit (copy)
        if not (PetPositon and PetVisual) then
            return;
        end;

        local PetType = p80.PetType;

        if not PetType then
            u56 = u56 + 1;
            u55 = nil;

            if u54 then
                u54:Destroy();
                u54 = nil;
            end;

            return;
        end;

        local PetSnapshot = p80.PetSnapshot;
        local u81 = PetSnapshot and (PetSnapshot.PetSize or 1) or 1;
        local u82;

        if p80.Status == "Complete" then
            u82 = Config.INFERNO_MUTATION_NAME;
        else
            u82 = PetSnapshot and PetSnapshot.Mutation or nil;
        end;

        local v83 = `{PetType}|{tostring(u82)}|{p80.Status}|{u81}`;

        if v83 == u55 and u54 then
            return;
        end;

        u56 = u56 + 1;
        u55 = nil;

        if u54 then
            u54:Destroy();
            u54 = nil;
        end;

        u55 = v83;
        local u84 = u56;
        task.spawn(function() -- Line: 519
            -- upvalues: RenderPet (ref), PetType (copy), u81 (copy), u82 (ref), PetPositon (ref), PetVisual (ref), u84 (copy), u56 (ref), u54 (ref)
            local v85 = RenderPet(PetType, u81, u82, PetPositon.CFrame, PetVisual);

            if u84 == u56 then
                u54 = v85;

                return;
            end;

            if v85 then
                v85:Destroy();
            end;
        end);
        Submit:Play();
    end;

    local u86;

    if u4 then
        u86 = u4:FindFirstChild("Gunpowder");
    else
        u86 = u4;
    end;

    local u87 = {};
    local u88 = nil;
    local u89 = 0;
    local Color3_fromRGB_ret3 = Color3.fromRGB(255, 120, 25);

    local function EnsureGunpowderParts() -- Line: 550
        -- upvalues: u87 (copy), u86 (copy)
        if #u87 > 0 or not u86 then
            return;
        end;

        for _, child in u86:GetChildren() do
            if child:IsA("BasePart") and tonumber(child.Name) then
                table.insert(u87, child);

                if child:GetAttribute("OGColor") == nil then
                    child:SetAttribute("OGColor", child.Color);
                    child:SetAttribute("OGMaterial", child.Material.Name);
                end;
            end;
        end;

        table.sort(u87, function(p90, p91) -- Line: 561
            return (tonumber(p90.Name) or 0) < (tonumber(p91.Name) or 0);
        end);
    end;

    local function SetGunpowderPart(p92: userdata, p93: boolean) -- Line: 567
        -- upvalues: Color3_fromRGB_ret3 (copy)
        if p93 then
            p92.Color = Color3_fromRGB_ret3;
            p92.Material = Enum.Material.Neon;
        else
            local Attribute = p92:GetAttribute("OGColor");
            local Attribute2 = p92:GetAttribute("OGMaterial");

            if typeof(Attribute) == "Color3" then
                p92.Color = Attribute;
            end;

            if Attribute2 then
                p92.Material = Enum.Material[Attribute2];
            end;
        end;

        for _, descendant in p92:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                if descendant.Name == "EMIT" then
                    if p93 then
                        descendant:Emit(1);
                    end;
                else
                    descendant.Enabled = p93;
                end;
            end;
        end;
    end;

    local function PulseGunpowder(u94: boolean, p95: boolean?) -- Line: 592
        -- upvalues: EnsureGunpowderParts (copy), u87 (copy), u89 (ref), SetGunpowderPart (copy)
        EnsureGunpowderParts();

        if #u87 == 0 then
            return;
        end;

        u89 = u89 + 1;
        local u96 = u89;

        if p95 then
            for _, v in u87 do
                SetGunpowderPart(v, u94);
            end;

            return;
        end;

        task.spawn(function() -- Line: 606
            -- upvalues: u87 (ref), u96 (copy), u89 (ref), SetGunpowderPart (ref), u94 (copy)
            for _, v in u87 do
                if u96 ~= u89 then
                    return;
                end;

                SetGunpowderPart(v, u94);
                task.wait(0.08);
            end;
        end);
    end;

    local function UpdateGunpowder(p97: number) -- Line: 617
        -- upvalues: Config (ref), u88 (ref), PulseGunpowder (copy)
        local v98 = Config.MIN_CAMPFIRE_TIER <= p97;

        if v98 == u88 then
            return;
        end;

        local v99 = u88 == nil;
        u88 = v98;
        PulseGunpowder(v98, v99);
    end;

    local u100 = {};
    local u101 = {};
    local u102 = nil;

    local function MakeHighlight(p103: userdata) -- Line: 634
        -- upvalues: u9 (copy)
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillTransparency = 0.85;
        Highlight.OutlineTransparency = 0;
        Highlight.OutlineColor = u9.SlotEmpty;
        Highlight.FillColor = Color3.fromRGB(30, 30, 30);
        Highlight.Adornee = p103;
        Highlight.Parent = p103;

        return Highlight;
    end;

    local function TweenHL(p104: userdata, p105: table) -- Line: 646
        -- upvalues: TweenService (ref), TweenInfo_new_ret (copy)
        TweenService:Create(p104, TweenInfo_new_ret, p105):Play();
    end;

    local function GetSlotPart(p106: userdata) -- Line: 650
        if p106:IsA("BasePart") then
            return p106;
        end;

        return p106:FindFirstChildWhichIsA("BasePart");
    end;

    local function TweenModel(u107: userdata, p108: userdata, p109) -- Line: 655
        -- upvalues: TweenService (ref)
        local CFrameValue = Instance.new("CFrameValue");
        CFrameValue.Value = u107.PrimaryPart.CFrame;
        CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 659
            -- upvalues: u107 (copy), CFrameValue (copy)
            u107:PivotTo(CFrameValue.Value);
        end);
        TweenService:Create(CFrameValue, p108, {
            Value = p109
        }):Play();
    end;

    local function UpdateSlotHighlights(p110: table) -- Line: 669
        -- upvalues: u5 (copy), u101 (copy), Config (ref), TweenModel (copy), u100 (copy), u9 (copy), TweenService (ref), TweenInfo_new_ret (copy)
        for i = 1, 4 do
            local v111 = p110[i];
            local v112 = u5:WaitForChild("Shard" .. i);
            local v113;

            if v112 then
                local v114 = false;
                local v115 = u101[i] == true;
                local Visuals = v112:FindFirstChild("Visuals");

                if Visuals then
                    if not u101[i] then
                        u101[i] = true;

                        if Config.Y_RISE_VISUAL ~= 0 then
                            TweenModel(Visuals, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, -1, true), Visuals.PrimaryPart.CFrame + Vector3.new(0, Config.Y_RISE_VISUAL, 0));
                        end;
                    end;

                    v113 = i;

                    for _, descendant in Visuals:GetDescendants() do
                        if descendant:IsA("BasePart") or (descendant:IsA("MeshPart") or descendant:IsA("Decal")) then
                            local Attribute = descendant:GetAttribute("OGTrans");

                            if not Attribute then
                                Attribute = descendant.Transparency;
                                descendant:SetAttribute("OGTrans", descendant.Transparency);
                            end;

                            if v111 then
                                v114 = v114 or descendant.Transparency ~= Attribute;
                                descendant.Transparency = Attribute;
                            else
                                v114 = v114 or descendant.Transparency ~= 0.95;
                                descendant.Transparency = 0.95;
                            end;
                        elseif descendant:IsA("ParticleEmitter") then
                            if v111 then
                                descendant.Enabled = true;
                            else
                                descendant.Enabled = false;
                            end;
                        end;
                    end;
                else
                    v113 = i;
                end;

                local VisualStill = v112:FindFirstChild("VisualStill");

                if VisualStill then
                    for _, descendant in VisualStill:GetDescendants() do
                        if descendant:IsA("BasePart") or (descendant:IsA("MeshPart") or descendant:IsA("Decal")) then
                            local Attribute = descendant:GetAttribute("OGTrans");

                            if not Attribute then
                                Attribute = descendant.Transparency;
                                descendant:SetAttribute("OGTrans", descendant.Transparency);
                            end;

                            if v111 then
                                descendant.Transparency = Attribute;
                            else
                                descendant.Transparency = 0.95;
                            end;
                        elseif descendant:IsA("ParticleEmitter") then
                            if v111 then
                                descendant.Enabled = true;
                            else
                                descendant.Enabled = false;
                            end;
                        end;
                    end;
                end;

                if v115 and (v111 and v114) then
                    local Submit2 = v112:FindFirstChild("Submit");

                    if Submit2 then
                        Submit2:Play();
                    end;
                end;
            else
                v113 = i;
            end;

            local v116 = u100[v113];

            if v116 then
                if v111 then
                    TweenService:Create(v116, TweenInfo_new_ret, {
                        FillTransparency = 0.6,
                        OutlineColor = u9.SlotFilled,
                        FillColor = u9.FillSlot
                    }):Play();
                else
                    TweenService:Create(v116, TweenInfo_new_ret, {
                        FillTransparency = 0.85,
                        OutlineColor = u9.SlotEmpty,
                        FillColor = Color3.fromRGB(30, 30, 30)
                    }):Play();
                end;
            end;
        end;
    end;

    local function UpdateCenterHighlight(p117) -- Line: 762
        -- upvalues: u102 (ref), u9 (copy), TweenService (ref), TweenInfo_new_ret (copy)
        if not u102 then
            return;
        end;

        local Status = p117.Status;

        if Status == "Complete" then
            TweenService:Create(u102, TweenInfo_new_ret, {
                FillTransparency = 0.4,
                OutlineColor = u9.CenterClaim,
                FillColor = u9.FillCenterClaim
            }):Play();

            return;
        end;

        if Status == "Active" then
            TweenService:Create(u102, TweenInfo_new_ret, {
                FillTransparency = 0.65,
                OutlineColor = u9.CenterActive
            }):Play();

            return;
        end;

        if p117.PetType then
            TweenService:Create(u102, TweenInfo_new_ret, {
                FillTransparency = 0.75,
                OutlineColor = u9.CenterPet
            }):Play();

            return;
        end;

        TweenService:Create(u102, TweenInfo_new_ret, {
            FillTransparency = 0.9,
            OutlineColor = u9.SlotEmpty
        }):Play();
    end;

    local function RefreshPrompts(p118) -- Line: 780
        -- upvalues: u5 (copy)
        if not u5 then
            return;
        end;

        local Status = p118.Status;
        local ProximityPrompt = u5:WaitForChild("Start"):WaitForChild("ProximityPrompt");
        ProximityPrompt.Enabled = Status == "Ready";
        ProximityPrompt.ActionText = "Begin Ritual";
        local ProximityPrompt2 = u5:WaitForChild("PetRemove"):WaitForChild("ProximityPrompt");
        local ProximityPrompt3 = u5:WaitForChild("Pet"):WaitForChild("ProximityPrompt");

        if Status == "Complete" then
            ProximityPrompt3.ActionText = "Claim Pet";
            ProximityPrompt3.Enabled = true;
            ProximityPrompt2.Enabled = false;
        elseif Status == "Active" then
            ProximityPrompt3.ActionText = "Skip Ritual";
            ProximityPrompt3.Enabled = true;
            ProximityPrompt2.Enabled = false;
        elseif p118.PetType then
            ProximityPrompt2.Enabled = true;
            ProximityPrompt3.Enabled = false;
            ProximityPrompt3.ActionText = "Remove Pet";
        else
            ProximityPrompt3.ActionText = "Place Pet";
            ProximityPrompt3.Enabled = true;
            ProximityPrompt2.Enabled = false;
        end;

        for i = 1, 4 do
            local ProximityPrompt4 = u5:WaitForChild("Shard" .. i):WaitForChild("ProximityPrompt");
            local v119;

            if Status == "Active" or (Status == "Complete" or p118.SlotStates[i]) then
                ProximityPrompt4.Enabled = false;
                v119 = i;
            else
                ProximityPrompt4.Enabled = true;
                ProximityPrompt4.ActionText = p118.SlotStates[i] and "Shard Placed" or "Place Shard";
                v119 = i;
            end;
        end;
    end;

    local u120 = nil;
    local u121 = nil;
    local u122 = nil;
    local u123 = nil;
    local u124 = nil;
    local u125 = nil;
    local u126 = nil;
    local u127 = nil;

    local function FormatTime(p128: number) -- Line: 839
        local math_ceil_ret = math.ceil(p128);
        local math_max_ret = math.max(math_ceil_ret, 0);
        local math_floor_ret = math.floor(math_max_ret / 3600);
        local math_floor_ret2 = math.floor(math_max_ret % 3600 / 60);
        local v129 = math_max_ret % 60;

        if math_floor_ret <= 0 then
            if math_floor_ret2 > 0 then
                return v129 > 0 and `{math_floor_ret2}m {v129}s` or `{math_floor_ret2}m`;
            end;

            return `{v129}s`;
        end;

        if math_floor_ret2 > 0 and v129 > 0 then
            return `{math_floor_ret}h {math_floor_ret2}m {v129}s`;
        end;

        if math_floor_ret2 > 0 then
            return `{math_floor_ret}h {math_floor_ret2}m`;
        end;

        if v129 > 0 then
            return `{math_floor_ret}h {v129}s`;
        end;

        return `{math_floor_ret}h`;
    end;

    local function StopTick() -- Line: 865
        -- upvalues: u127 (ref)
        if u127 then
            u127:Disconnect();
            u127 = nil;
        end;
    end;

    function u1.GetTierTimeMultiplier(p130: number) -- Line: 870
        -- upvalues: Config (ref)
        local v131 = (-1 / 0);
        local v132 = 1;

        for i, v in Config.TIER_TIME_MULTIPLIER do
            local v133 = tonumber(i);

            if v133 <= p130 and v131 < v133 then
                v132 = tonumber(v);
                v131 = v133;
            end;
        end;

        return v132;
    end;

    local function ClientTimeMultiplier() -- Line: 882
        -- upvalues: Config (ref), u1 (ref)
        local v134 = workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0;

        return u1.GetTierTimeMultiplier(v134);
    end;

    local function ComputeRemaining(p135: number, p136: number?, p137: number?) -- Line: 890
        -- upvalues: Config (ref), u1 (ref)
        local v138 = p136 or 0;

        if p137 then
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v139 = math.floor(ServerTimeNow) - p137;
            local math_max_ret = math.max(v139, 0);
            local v140 = workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0;
            v138 = v138 + math_max_ret * u1.GetTierTimeMultiplier(v140);
        end;

        return math.max(p135 - v138, 0);
    end;

    local function StartTick(u141) -- Line: 899
        -- upvalues: u127 (ref), RunService (ref), Config (ref), u1 (ref), u121 (ref), u122 (ref), FormatTime (copy), u6 (ref), u8 (ref)
        if u127 then
            u127:Disconnect();
            u127 = nil;
        end;

        if u141.Status ~= "Active" then
            return;
        end;

        local Duration = u141.Duration;

        if not Duration or Duration <= 0 then
            return;
        end;

        u127 = RunService.Heartbeat:Connect(function() -- Line: 905
            -- upvalues: Duration (copy), u141 (copy), Config (ref), u1 (ref), u121 (ref), u122 (ref), FormatTime (ref), u127 (ref), u6 (ref), u8 (ref)
            local LastTick = u141.LastTick;
            local v142 = u141.Progress or 0;

            if LastTick then
                local ServerTimeNow = workspace:GetServerTimeNow();
                local v143 = math.floor(ServerTimeNow) - LastTick;
                local math_max_ret = math.max(v143, 0);
                local v144 = workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0;
                v142 = v142 + math_max_ret * u1.GetTierTimeMultiplier(v144);
            end;

            local math_max_ret = math.max(Duration - v142, 0);
            local math_clamp_ret = math.clamp((Duration - math_max_ret) / Duration, 0, 1);

            if u121 then
                u121.Size = UDim2.fromScale(math_clamp_ret, 1);
            end;

            local TierTimeMultiplier = u1.GetTierTimeMultiplier(workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0);

            if TierTimeMultiplier > 1 then
                u122.Text = "<font color=\"#FFFFFF\">" .. FormatTime(math_max_ret) .. "</font> " .. "<font color=\"#FF0000\">(x" .. tostring(TierTimeMultiplier) .. ")</font>";
            else
                u122.Text = "<font color=\"#FFFFFF\">" .. FormatTime(math_max_ret) .. "</font>";
            end;

            if math_max_ret <= 0 then
                if u127 then
                    u127:Disconnect();
                    u127 = nil;
                end;

                if u6 and u6.Status == "Active" then
                    local table_clone_ret = table.clone(u6);
                    table_clone_ret.Status = "Complete";
                    u8(table_clone_ret);
                end;
            end;
        end);
    end;

    local function UpdateBillboard(u145) -- Line: 931
        -- upvalues: u120 (ref), Config (ref), u88 (ref), PulseGunpowder (copy), u123 (ref), u125 (ref), u1 (ref), u124 (ref), u127 (ref), u121 (ref), u122 (ref), u126 (ref), RunService (ref), FormatTime (copy), u6 (ref), u8 (ref)
        if not u120 then
            return;
        end;

        local Status = u145.Status;
        local v146 = (workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0) >= Config.MIN_CAMPFIRE_TIER;

        if v146 ~= u88 then
            local v147 = u88 == nil;
            u88 = v146;
            PulseGunpowder(v146, v147);
        end;

        local v148 = workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0;

        if u123 then
            if Status == "Idle" then
                if u145.FilledSlots < Config.REQUIRED_SHARDS then
                    u123.Text = "Place shards to begin...";
                    u123.Visible = false;
                elseif u145.PetRarity then
                    u123.Visible = false;
                else
                    u123.Text = "Place pet to begin...";
                    u123.Visible = false;
                end;
            elseif Status == "Ready" then
                u123.Text = "Ready! Begin the ritual.";
                u123.Visible = Config.MIN_CAMPFIRE_TIER <= v148;
            elseif Status == "Active" then
                u123.Text = "Ritual burning...";
                u123.Visible = false;
            elseif Status == "Complete" then
                u123.Text = "Complete! Claim your pet!";
                u123.Visible = true;
            end;
        end;

        if Status == "Active" or Status == "Complete" then
            u125.Visible = false;
        elseif Config.MIN_CAMPFIRE_TIER <= v148 then
            local TierTimeMultiplier = u1.GetTierTimeMultiplier(v148);
            u125.Text = Config.MESSAGES.CAMPFIRE_BOOST:gsub("MULT", string.format("%g", TierTimeMultiplier));
            u125.Visible = false;
        else
            u125.Text = Config.MESSAGES.CAMPFIRE_NEEDED:gsub("MIN_TIER", (tostring(Config.MIN_CAMPFIRE_TIER)));
            u125.Visible = true;
        end;

        if Status == "Idle" then
            u124.Text = `Shards: {u145.FilledSlots}/{Config.REQUIRED_SHARDS}`;
            u124.Visible = u145.FilledSlots < Config.REQUIRED_SHARDS;
        else
            u124.Visible = false;
        end;

        if Status ~= "Idle" and Status ~= "Ready" then
            if Status ~= "Active" then
                if Status == "Complete" then
                    if u127 then
                        u127:Disconnect();
                        u127 = nil;
                    end;

                    if u121 then
                        u121.Size = UDim2.fromScale(1, 1);
                    end;

                    if u122 then
                        u122.Text = Config.MESSAGES.COMPLETED_TIMER;
                    end;

                    u122.Visible = false;
                    u126.Enabled = false;
                end;

                return;
            end;

            if u127 then
                u127:Disconnect();
                u127 = nil;
            end;

            if u145.Status == "Active" then
                local Duration = u145.Duration;

                if Duration and Duration > 0 then
                    u127 = RunService.Heartbeat:Connect(function() -- Line: 905
                        -- upvalues: Duration (copy), u145 (copy), Config (ref), u1 (ref), u121 (ref), u122 (ref), FormatTime (ref), u127 (ref), u6 (ref), u8 (ref)
                        local LastTick = u145.LastTick;
                        local v149 = u145.Progress or 0;

                        if LastTick then
                            local ServerTimeNow = workspace:GetServerTimeNow();
                            local v150 = math.floor(ServerTimeNow) - LastTick;
                            local math_max_ret = math.max(v150, 0);
                            local v151 = workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0;
                            v149 = v149 + math_max_ret * u1.GetTierTimeMultiplier(v151);
                        end;

                        local math_max_ret = math.max(Duration - v149, 0);
                        local math_clamp_ret = math.clamp((Duration - math_max_ret) / Duration, 0, 1);

                        if u121 then
                            u121.Size = UDim2.fromScale(math_clamp_ret, 1);
                        end;

                        local TierTimeMultiplier = u1.GetTierTimeMultiplier(workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0);

                        if TierTimeMultiplier > 1 then
                            u122.Text = "<font color=\"#FFFFFF\">" .. FormatTime(math_max_ret) .. "</font> " .. "<font color=\"#FF0000\">(x" .. tostring(TierTimeMultiplier) .. ")</font>";
                        else
                            u122.Text = "<font color=\"#FFFFFF\">" .. FormatTime(math_max_ret) .. "</font>";
                        end;

                        if math_max_ret <= 0 then
                            if u127 then
                                u127:Disconnect();
                                u127 = nil;
                            end;

                            if u6 and u6.Status == "Active" then
                                local table_clone_ret = table.clone(u6);
                                table_clone_ret.Status = "Complete";
                                u8(table_clone_ret);
                            end;
                        end;
                    end);
                end;
            end;

            u122.Visible = true;
            u126.Enabled = false;

            return;
        end;

        if u127 then
            u127:Disconnect();
            u127 = nil;
        end;

        if u121 then
            u121.Size = UDim2.fromScale(0, 1);
        end;

        if not u145.PetRarity then
            u122.Visible = false;
            u122.Text = Config.MESSAGES.NO_TIME;
            u126.Enabled = true;

            return;
        end;

        local math_floor_ret = math.floor(Config.RITUAL_DURATION_BY_RARITY[u145.PetRarity] or Config.RITUAL_DURATION_BY_RARITY.FallBack);
        math.max(math_floor_ret, 10);
        u122.Visible = false;
        u126.Enabled = false;
    end;

    u8 = function(p152) -- Line: 1017, Name: ApplySnapshot
        -- upvalues: u7 (ref), u6 (ref), ApplyVFX (copy), UpdateSlotHighlights (copy), UpdateCenterHighlight (copy), RefreshPrompts (copy), UpdateBillboard (copy), UpdatePetVisual (copy)
        if not p152 then
            return;
        end;

        local v153 = u7;
        local Status = p152.Status;
        u7 = Status;
        u6 = p152;
        ApplyVFX(Status, v153);
        UpdateSlotHighlights(p152.SlotStates);
        UpdateCenterHighlight(p152);
        RefreshPrompts(p152);
        UpdateBillboard(p152);
        UpdatePetVisual(p152);
    end;

    local Data = DataService:GetData();

    if not u4 then
        warn("SummerRitualController | No model tagged SummerRitualModel");

        return;
    end;

    if not u5 then
        warn("SummerRitualController | RitualModel missing ProximityPrompts folder");

        return;
    end;

    for i = 1, 4 do
        local v154 = u5:WaitForChild("Shard" .. i);
        local v155;

        if v154 then
            if not v154:IsA("BasePart") then
                v154 = v154:FindFirstChildWhichIsA("BasePart");
            end;

            if v154 then
                local Highlight = Instance.new("Highlight");
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillTransparency = 0.85;
                Highlight.OutlineTransparency = 0;
                Highlight.OutlineColor = u9.SlotEmpty;
                Highlight.FillColor = Color3.fromRGB(30, 30, 30);
                Highlight.Adornee = v154;
                Highlight.Parent = v154;
                u100[i] = Highlight;
                v155 = i;
            else
                v155 = i;
            end;
        else
            v155 = i;
        end;
    end;

    local Pet = u5:FindFirstChild("Pet");

    if Pet then
        if not Pet:IsA("BasePart") then
            Pet = Pet:FindFirstChildWhichIsA("BasePart");
        end;

        if Pet then
            local Highlight = Instance.new("Highlight");
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillTransparency = 0.85;
            Highlight.OutlineTransparency = 0;
            Highlight.OutlineColor = u9.SlotEmpty;
            Highlight.FillColor = Color3.fromRGB(30, 30, 30);
            Highlight.Adornee = Pet;
            Highlight.Parent = Pet;
            u102 = Highlight;
        end;
    end;

    u120 = u4:WaitForChild("UI"):WaitForChild("BillboardGui");
    local Container = u120:WaitForChild("Container");
    u121 = Container:WaitForChild("BarBG"):WaitForChild("Fill");
    u122 = Container:WaitForChild("Timer");
    u123 = Container:WaitForChild("Status");
    u124 = Container:WaitForChild("ShardCount");
    Container:WaitForChild("PetName");
    u125 = Container:WaitForChild("CampfireBoost");
    u126 = u4:WaitForChild("PlacePet"):WaitForChild("BillboardGui");
    local ImageLabel = u126:WaitForChild("ImageLabel");

    local function RebuildFromData() -- Line: 1079
        -- upvalues: Data (copy), Config (ref), u1 (ref), u8 (ref)
        local v156 = Data and Data[Config.DATA_KEY];

        if not v156 then
            return;
        end;

        local v157 = v156.ShardSlots or { false, false, false, false };
        local v158 = 0;

        for _, v in v157 do
            if v then
                v158 = v158 + 1;
            end;
        end;

        local v159 = v156.RitualStatus or "Idle";
        local v160;

        if v156.RitualTime and v156.RitualDuration then
            local RitualDuration = v156.RitualDuration;
            local RitualLastTick = v156.RitualLastTick;
            local v161 = v156.RitualProgress or 0;

            if RitualLastTick then
                local ServerTimeNow = workspace:GetServerTimeNow();
                local v162 = math.floor(ServerTimeNow) - RitualLastTick;
                local math_max_ret = math.max(v162, 0);
                local v163 = workspace:GetAttribute(Config.CAMPFIRE_TIER_ATTRIBUTE) or 0;
                v161 = v161 + math_max_ret * u1.GetTierTimeMultiplier(v163);
            end;

            v160 = math.max(RitualDuration - v161, 0);
        else
            v160 = nil;
        end;

        u8({
            Status = v159 == "Active" and (v160 ~= nil and v160 <= 0) and "Complete" or v159,
            FilledSlots = v158,
            SlotStates = {
                v157[1],
                v157[2],
                v157[3],
                v157[4]
            },
            PetType = v156.RitualPetType,
            PetRarity = v156.RitualPetRarity,
            PetSnapshot = v156.RitualPetSnapshot,
            StartTime = v156.RitualTime,
            Duration = v156.RitualDuration,
            Progress = v156.RitualProgress,
            LastTick = v156.RitualLastTick,
            Remaining = v160
        });
    end;

    for _, v in { "SummerFireEventData/RitualStatus", "SummerFireEventData/RitualPet", "SummerFireEventData/RitualTime", "SummerFireEventData/RitualLastTick", "SummerFireEventData/ShardSlots", "SummerFireEventData/RitualPetType", "SummerFireEventData/RitualPetSnapshot" } do
        u2:Add(DataService:GetPathSignal(v):Connect(RebuildFromData));
    end;

    RebuildFromData();
    u2:Add(workspace:GetAttributeChangedSignal(Config.CAMPFIRE_TIER_ATTRIBUTE):Connect(RebuildFromData));
    u2:Add(task.spawn(function() -- Line: 1139
        -- upvalues: u4 (copy)
        local v164 = nil;

        while true do
            task.wait(5);
            local v165;

            if u4 and u4.Parent then
                v165 = not u4.Parent:IsA("Folder");

                if v165 == v164 then
                    v165 = v164;
                else
                    for _, descendant in u4:GetDescendants() do
                        if descendant:IsA("Sound") then
                            if descendant:GetAttribute("OGVolume") == nil then
                                descendant:SetAttribute("OGVolume", descendant.Volume);
                            end;

                            descendant.Volume = v165 and 0 or (descendant:GetAttribute("OGVolume") or descendant.Volume);
                        end;
                    end;
                end;
            else
                v165 = v164;
            end;

            v164 = v165;
        end;
    end));
    u2:Add((u5:WaitForChild("PetRemove"):WaitForChild("ProximityPrompt").Triggered:Connect(function() -- Line: 1161
        -- upvalues: SummerRitual (copy)
        SummerRitual.Submit:FireServer();
    end)));
    u2:Add((u5:WaitForChild("Pet"):WaitForChild("ProximityPrompt").Triggered:Connect(function() -- Line: 1167
        -- upvalues: u6 (ref), u1 (ref), LocalPlayer (copy), MarketController (ref), SummerRitual (copy)
        if u6.Status == "Active" then
            pcall(function() -- Line: 1170
                -- upvalues: u1 (ref), LocalPlayer (ref), MarketController (ref)
                local DevProduct = u1.GetDevProduct(LocalPlayer);

                if DevProduct then
                    MarketController:PromptPurchase(DevProduct, Enum.InfoType.Product);
                end;
            end);

            return;
        end;

        SummerRitual.Submit:FireServer();
    end)));
    u2:Add((u5:WaitForChild("Start"):WaitForChild("ProximityPrompt").Triggered:Connect(function() -- Line: 1183
        -- upvalues: SummerRitual (copy), ConfirmationPromptController (ref)
        local function confirm(p166) -- Line: 1185
            -- upvalues: SummerRitual (ref)
            SummerRitual.Start:FireServer();
        end;

        ConfirmationPromptController:Open({
            Title = "Earn the Inferno Mutation...",
            Header = "Start Ritual?",
            Middle = "Pet AGE and MUTATION will be reset!"
        }, {
            ConfirmCallback = function() -- Line: 1196, Name: ConfirmCallback
                -- upvalues: SummerRitual (ref)
                SummerRitual.Start:FireServer();
            end
        });
    end)));

    local function HeldPetTool() -- Line: 1205
        -- upvalues: LocalPlayer (copy)
        local Character = LocalPlayer.Character;

        if not Character then
            return nil;
        end;

        for _, child in Character:GetChildren() do
            if child:IsA("Tool") and child:GetAttribute("PET_UUID") then
                return child;
            end;
        end;

        return nil;
    end;

    local function UpdatePlacePetIcon() -- Line: 1216
        -- upvalues: ImageLabel (copy), HeldPetTool (copy), InventoryServiceEnums (ref), ItemImageFinder (ref)
        if not ImageLabel then
            return;
        end;

        local v167 = HeldPetTool();

        if v167 then
            v167 = v167:GetAttribute(InventoryServiceEnums.ItemName);
        end;

        if v167 then
            ImageLabel.Image = ItemImageFinder(v167, "Pet");
            ImageLabel.ImageTransparency = 0;

            return;
        end;

        ImageLabel.Image = "";
        ImageLabel.ImageTransparency = 1;
    end;

    local u168 = nil;
    local u169 = nil;

    local function WatchCharacterTools(p170: userdata) -- Line: 1231
        -- upvalues: u168 (ref), u169 (ref), ImageLabel (copy), HeldPetTool (copy), InventoryServiceEnums (ref), ItemImageFinder (ref)
        if u168 then
            u168:Disconnect();
        end;

        if u169 then
            u169:Disconnect();
        end;

        if ImageLabel then
            local v171 = HeldPetTool();

            if v171 then
                v171 = v171:GetAttribute(InventoryServiceEnums.ItemName);
            end;

            if v171 then
                ImageLabel.Image = ItemImageFinder(v171, "Pet");
                ImageLabel.ImageTransparency = 0;
            else
                ImageLabel.Image = "";
                ImageLabel.ImageTransparency = 1;
            end;
        end;

        u168 = p170.ChildAdded:Connect(function(p172) -- Line: 1236
            -- upvalues: ImageLabel (ref), HeldPetTool (ref), InventoryServiceEnums (ref), ItemImageFinder (ref)
            if p172:IsA("Tool") then
                if not ImageLabel then
                    return;
                end;

                local v173 = HeldPetTool();

                if v173 then
                    v173 = v173:GetAttribute(InventoryServiceEnums.ItemName);
                end;

                if v173 then
                    ImageLabel.Image = ItemImageFinder(v173, "Pet");
                    ImageLabel.ImageTransparency = 0;

                    return;
                end;

                ImageLabel.Image = "";
                ImageLabel.ImageTransparency = 1;
            end;
        end);
        u169 = p170.ChildRemoved:Connect(function(p174) -- Line: 1240
            -- upvalues: ImageLabel (ref), HeldPetTool (ref), InventoryServiceEnums (ref), ItemImageFinder (ref)
            if p174:IsA("Tool") then
                if not ImageLabel then
                    return;
                end;

                local v175 = HeldPetTool();

                if v175 then
                    v175 = v175:GetAttribute(InventoryServiceEnums.ItemName);
                end;

                if v175 then
                    ImageLabel.Image = ItemImageFinder(v175, "Pet");
                    ImageLabel.ImageTransparency = 0;

                    return;
                end;

                ImageLabel.Image = "";
                ImageLabel.ImageTransparency = 1;
            end;
        end);
    end;

    u2:Add((LocalPlayer.CharacterAdded:Connect(WatchCharacterTools)));

    if LocalPlayer.Character then
        WatchCharacterTools(LocalPlayer.Character);
    end;

    if ImageLabel then
        local v176 = HeldPetTool();

        if v176 then
            v176 = v176:GetAttribute(InventoryServiceEnums.ItemName);
        end;

        if v176 then
            ImageLabel.Image = ItemImageFinder(v176, "Pet");
            ImageLabel.ImageTransparency = 0;
        else
            ImageLabel.Image = "";
            ImageLabel.ImageTransparency = 1;
        end;
    end;
end;

local u177 = false;
EventRotationController.EventUpdated:Connect(function(p178: string, p179: string) -- Line: 1254, Name: OnEventUpdated
    -- upvalues: u2 (copy), u177 (ref), EventRotationUtils (copy), u1 (copy)
    if p179 ~= "CampfireEvent" then
        u2:Clean();
        u177 = false;

        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p178, p179);

    if not EventInSetIndex then
        return;
    end;

    if EventInSetIndex < 3 then
        return;
    end;

    if u177 then
        return;
    end;

    u177 = true;
    u2:Clean();
    task.spawn(u1.Start, u1);
end);

return u1;