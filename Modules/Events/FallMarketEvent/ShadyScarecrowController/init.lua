-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local SoundService = game:GetService("SoundService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local u2 = {};
local success, result = pcall(function() -- Line: 58
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.IsInTradeWorld);
end);

if success and result then
    return u2;
end;

local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("ShadyScarecrowConfig");
workspace:GetAttributeChangedSignal("ShadyScarecrowConfig"):Connect(function() -- Line: 66
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("ShadyScarecrowConfig");
end);
local LocalPlayer = Players.LocalPlayer;
local u3 = nil;
pcall(function() -- Line: 72
    -- upvalues: u3 (ref), ReplicatedStorage (copy)
    u3 = require(ReplicatedStorage.Modules.Notification);
end);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local Submit = GameEvents:WaitForChild("ShadyScarecrow"):WaitForChild("Submit");
local FireDropBindable = GameEvents:FindFirstChild("FireDropBindable");
local Crow = script:WaitForChild("Crow");
local Folder = Instance.new("Folder");
Folder.Name = "ShadyScarecrowLocal";
Folder.Parent = workspace;
local u4 = false;

local function attr(p5, p6) -- Line: 94
    -- upvalues: Config (ref)
    local v7 = Config and Config[p5];

    if v7 == nil then
        return p6;
    end;

    return v7;
end;

local function formatClock(p8: number) -- Line: 100
    local math_ceil_ret = math.ceil(p8);
    local math_max_ret = math.max(math_ceil_ret, 0);
    local v9 = math_max_ret // 3600;
    local v10 = math_max_ret % 3600 // 60;
    local v11 = math_max_ret % 60;

    if v9 > 0 then
        return string.format("%d:%02d:%02d", v9, v10, v11);
    end;

    return string.format("%02d:%02d", v10, v11);
end;

local function fireDropCategory(p12: string) -- Line: 112
    return p12 == "Currency" and "Coins" or (p12 == "Seed" and "Seeds" or (p12 == "Seed Pack" and "SeedPack" or "Items"));
end;

local function getModel() -- Line: 122
    -- upvalues: CollectionService (copy), Config (ref)
    local v13 = Config and Config.MODEL_TAG;

    return CollectionService:GetTagged(v13 == nil and "ShadyScarecrowModel" or v13)[1];
end;

local function getImportant() -- Line: 126
    -- upvalues: CollectionService (copy), Config (ref)
    local v14 = Config and Config.MODEL_TAG;
    local v15 = CollectionService:GetTagged(v14 == nil and "ShadyScarecrowModel" or v14)[1];

    if v15 then
        v15 = v15:FindFirstChild("Important");
    end;

    return v15;
end;

local function getPart(p16: string) -- Line: 131
    -- upvalues: CollectionService (copy), Config (ref)
    local v17 = Config and Config.MODEL_TAG;
    local v18 = CollectionService:GetTagged(v17 == nil and "ShadyScarecrowModel" or v17)[1];

    if v18 then
        v18 = v18:FindFirstChild("Important");
    end;

    if v18 then
        v18 = v18:FindFirstChild(p16);
    end;

    if v18 and v18:IsA("BasePart") then
        return v18;
    end;

    if v18 and v18:IsA("Model") then
        return v18.PrimaryPart or v18:FindFirstChildWhichIsA("BasePart");
    end;

    return nil;
end;

local function getNpcOriginPart() -- Line: 142
    -- upvalues: CollectionService (copy), Config (ref), getPart (copy)
    local v19 = Config and Config.MODEL_TAG;
    local v20 = CollectionService:GetTagged(v19 == nil and "ShadyScarecrowModel" or v19)[1];

    if v20 then
        v20 = v20:FindFirstChild("NPC");
    end;

    if not (v20 and v20:IsA("Model")) then
        if v20 and v20:IsA("BasePart") then
            return v20;
        end;

        return getPart("NPC");
    end;

    local Head = v20:FindFirstChild("Head");

    if Head and Head:IsA("BasePart") then
        return Head;
    end;

    local RootPart = v20:FindFirstChild("RootPart");

    if RootPart and RootPart:IsA("BasePart") then
        return RootPart;
    end;

    return v20.PrimaryPart or v20:FindFirstChildWhichIsA("BasePart");
end;

local u21 = {};
local u22 = nil;

local function getNpcModel() -- Line: 165
    -- upvalues: CollectionService (copy), Config (ref)
    local v23 = Config and Config.MODEL_TAG;
    local v24 = CollectionService:GetTagged(v23 == nil and "ShadyScarecrowModel" or v23)[1];

    if v24 then
        v24 = v24:FindFirstChild("NPC");
    end;

    if v24 and v24:IsA("Model") then
        return v24;
    end;

    return nil;
end;

local function getNpcTrack(p25: string) -- Line: 172
    -- upvalues: CollectionService (copy), Config (ref), u22 (ref), u21 (copy)
    local v26 = Config and Config.MODEL_TAG;
    local v27 = CollectionService:GetTagged(v26 == nil and "ShadyScarecrowModel" or v26)[1];

    if v27 then
        v27 = v27:FindFirstChild("NPC");
    end;

    if not (v27 and v27:IsA("Model")) then
        v27 = nil;
    end;

    if not v27 then
        return nil;
    end;

    local v28 = v27:FindFirstChildWhichIsA("AnimationController") or v27:FindFirstChildWhichIsA("Humanoid");

    if not v28 then
        return nil;
    end;

    local u29 = v28:FindFirstChildWhichIsA("Animator");

    if not u29 then
        return nil;
    end;

    if u22 ~= u29 then
        for _, v in u21 do
            pcall(function() -- Line: 182
                -- upvalues: v (copy)
                v:Stop(0);
                v:Destroy();
            end);
        end;

        table.clear(u21);
        u22 = u29;
    end;

    local v30 = u21[p25];

    if v30 then
        return v30;
    end;

    local u31 = v27:FindFirstChild(p25);

    if not (u31 and u31:IsA("Animation")) then
        return nil;
    end;

    local success2, result2 = pcall(function() -- Line: 191
        -- upvalues: u29 (copy), u31 (copy)
        return u29:LoadAnimation(u31);
    end);

    if not (success2 and result2) then
        return nil;
    end;

    if p25 == "Idle" then
        result2.Priority = Enum.AnimationPriority.Idle;
        result2.Looped = true;
    else
        result2.Priority = Enum.AnimationPriority.Action;
        result2.Looped = false;
    end;

    u21[p25] = result2;

    return result2;
end;

local function playNpcIdle() -- Line: 204
    -- upvalues: getNpcTrack (copy), Config (ref)
    local v32 = getNpcTrack("Idle");

    if v32 and not v32.IsPlaying then
        local v33 = Config and Config.NPC_ANIM_FADE;
        v32:Play(v33 == nil and 0.2 or v33);
    end;
end;

local function playNpcAction(p34: string, p35: number?) -- Line: 210
    -- upvalues: getNpcTrack (copy), Config (ref), u21 (copy)
    local v36 = getNpcTrack("Idle");

    if v36 and not v36.IsPlaying then
        local v37 = Config and Config.NPC_ANIM_FADE;
        v36:Play(v37 == nil and 0.2 or v37);
    end;

    for i, v in u21 do
        if i ~= p34 and (i ~= "Idle" and v.IsPlaying) then
            local v38 = Config and Config.NPC_ANIM_FADE;
            v:Stop(v38 == nil and 0.2 or v38);
        end;
    end;

    local v39 = getNpcTrack(p34);

    if v39 then
        local v40 = Config and Config.NPC_ANIM_FADE;
        v39:Play(v40 == nil and 0.2 or v40, 1, p35 or 1);
    end;
end;

local function stopNpcAction(p41: string) -- Line: 221
    -- upvalues: u21 (copy), Config (ref)
    local v42 = u21[p41];

    if v42 and v42.IsPlaying then
        local v43 = Config and Config.NPC_ANIM_FADE;
        v42:Stop(v43 == nil and 0.2 or v43);
    end;
end;

local function preloadNpcTracks() -- Line: 227
    -- upvalues: getNpcTrack (copy)
    for _, v in { "Idle", "Plant", "Success" } do
        getNpcTrack(v);
    end;
end;

local function getNpcHand() -- Line: 234
    -- upvalues: CollectionService (copy), Config (ref)
    local v44 = Config and Config.MODEL_TAG;
    local v45 = CollectionService:GetTagged(v44 == nil and "ShadyScarecrowModel" or v44)[1];

    if v45 then
        v45 = v45:FindFirstChild("NPC");
    end;

    if not (v45 and v45:IsA("Model")) then
        v45 = nil;
    end;

    if v45 then
        local v46 = Config and Config.NPC_HAND_PART;
        v45 = v45:FindFirstChild(v46 == nil and "RightStraw1" or v46, true);
    end;

    if v45 and v45:IsA("BasePart") then
        return v45;
    end;

    return nil;
end;

local function stopNpcAnims() -- Line: 241
    -- upvalues: u21 (copy)
    for _, v in u21 do
        pcall(function() -- Line: 242
            -- upvalues: v (copy)
            v:Stop(0);
        end);
    end;
end;

local u47 = {};

local function findSound(p48: string) -- Line: 252
    -- upvalues: Config (ref), u47 (copy)
    local v49 = script:FindFirstChild(p48);

    if v49 and v49:IsA("Sound") then
        return v49;
    end;

    local v50 = p48:gsub("%s", ""):lower();

    for _, child in script:GetChildren() do
        if child:IsA("Sound") and child.Name:gsub("%s", ""):lower() == v50 then
            return child;
        end;
    end;

    local v51 = {};
    local v52 = Config and Config.SFX_FALLBACK_IDS;

    if v52 == nil then
        v52 = v51;
    end;

    local v53 = v52[p48];

    if typeof(v53) ~= "string" or v53 == "" then
        return nil;
    end;

    local v54 = u47[p48];

    if v54 and v54.SoundId == v53 then
        return v54;
    end;

    local Sound = Instance.new("Sound");
    Sound.Name = p48;
    Sound.SoundId = v53;
    local v55 = {};
    local v56 = Config and Config.SFX_FALLBACK_VOLUMES;

    if v56 == nil then
        v56 = v55;
    end;

    local v57 = v56[p48];

    if not v57 then
        local v58 = Config and Config.SFX_FALLBACK_VOLUME;
        v57 = v58 == nil and 0.5 or v58;
    end;

    Sound.Volume = v57;
    Sound.RollOffMaxDistance = 80;
    u47[p48] = Sound;

    return Sound;
end;

local function playAt(p59: string, p60: vector, p61: number?, p62: number?, p63: number?) -- Line: 276
    -- upvalues: findSound (copy), Folder (copy), Debris (copy)
    local v64 = findSound(p59);

    if not v64 then
        return;
    end;

    local v65 = v64:Clone();

    if p63 then
        v65.PlaybackSpeed = v65.PlaybackSpeed * p63;
    end;

    if p61 then
        v65.PlaybackSpeed = v65.PlaybackSpeed * (1 + (math.random() * 2 - 1) * p61);
    end;

    if p62 then
        v65.Volume = v65.Volume * p62;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Position = p60;
    Part.Parent = Folder;
    v65.Parent = Part;
    v65:Play();
    v65.Ended:Once(function() -- Line: 300
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
    Debris:AddItem(Part, 12);
end;

local function play2D(p66: string) -- Line: 304
    -- upvalues: findSound (copy), SoundService (copy), Debris (copy)
    local v67 = findSound(p66);

    if not v67 then
        return;
    end;

    local u68 = v67:Clone();
    u68.Parent = SoundService;
    u68:Play();
    u68.Ended:Once(function() -- Line: 310
        -- upvalues: u68 (copy)
        u68:Destroy();
    end);
    Debris:AddItem(u68, 12);
end;

local u69 = nil;

local function playLaugh(p70: vector?) -- Line: 318
    -- upvalues: Config (ref), findSound (copy), u69 (ref), playAt (copy), SoundService (copy), Debris (copy)
    local v71 = {};
    local v72 = { "Laugh1", "Laugh2", "Laugh3", "Laugh4" };
    local v73 = Config and Config.LAUGH_SOUNDS;
    local v74, v75;

    if v73 == nil then
        v73 = v72;
        v74 = nil;
        v75 = nil;
    else
        v74 = nil;
        v75 = nil;
    end;

    for _, v in v73, v74, v75 do
        if findSound(v) then
            table.insert(v71, v);
        end;
    end;

    if #v71 == 0 then
        return;
    end;

    local v76 = #v71 > 1 and u69 and table.find(v71, u69);

    if v76 then
        table.remove(v71, v76);
    end;

    local v77 = v71[math.random(#v71)];
    u69 = v77;
    local v78 = Config and Config.LAUGH_VOLUME_SCALE;
    local v79 = v78 == nil and 1 or v78;
    local v80 = Config and Config.LAUGH_PITCH_VARIATION;
    local v81 = v80 == nil and 0.08 or v80;
    local v82 = Config and Config.LAUGH_BASE_PITCH;
    local v83 = v82 == nil and 0.85 or v82;

    if p70 then
        playAt(v77, p70, v81, v79, v83);

        return;
    end;

    local v84 = findSound(v77);

    if not v84 then
        return;
    end;

    local u85 = v84:Clone();
    u85.Volume = u85.Volume * v79;
    u85.PlaybackSpeed = u85.PlaybackSpeed * v83 * (1 + (math.random() * 2 - 1) * v81);
    u85.Parent = SoundService;
    u85:Play();
    u85.Ended:Once(function() -- Line: 345
        -- upvalues: u85 (copy)
        u85:Destroy();
    end);
    Debris:AddItem(u85, 15);
end;

local function startLoop(p86: string, p87: userdata?) -- Line: 351
    -- upvalues: findSound (copy)
    if not p87 then
        return nil;
    end;

    local v88 = findSound(p86);

    if not v88 then
        return nil;
    end;

    local v89 = v88:Clone();
    v89.Looped = true;
    v89.PlaybackSpeed = v89.PlaybackSpeed * (1 + (math.random() * 2 - 1) * 0.08);
    v89.Parent = p87;
    v89:Play();

    return v89;
end;

local function stopLoop(u90: userdata?) -- Line: 363
    if u90 then
        pcall(function() -- Line: 364
            -- upvalues: u90 (copy)
            u90:Stop();
            u90:Destroy();
        end);
    end;
end;

local function animate(p91: number, p92: any, p93: any, p94: function) -- Line: 371
    -- upvalues: TweenService (copy), RunService (copy)
    local math_max_ret = math.max(p91, 0.01);
    local os_clock_ret = os.clock();

    while true do
        local v95 = (os.clock() - os_clock_ret) / math_max_ret;
        local math_clamp_ret = math.clamp(v95, 0, 1);
        p94(TweenService:GetValue(math_clamp_ret, p92 or Enum.EasingStyle.Quad, p93 or Enum.EasingDirection.Out));

        if math_clamp_ret >= 1 then
            break;
        end;

        RunService.RenderStepped:Wait();
    end;
end;

local function setModelTransparency(p96: userdata, p97: table, p98: number) -- Line: 382
    for i, v in p97 do
        if i.Parent then
            i.Transparency = v + (1 - v) * p98;
        end;
    end;
end;

local function cacheTransparency(p99: userdata) -- Line: 390
    local v100 = {};

    for _, descendant in p99:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            v100[descendant] = descendant.Transparency;
        end;
    end;

    return v100;
end;

local function makeFallbackSeed() -- Line: 403
    local Model = Instance.new("Model");
    Model.Name = "ShadyScarecrowSeed";
    local Part = Instance.new("Part");
    Part.Name = "Handle";
    Part.Shape = Enum.PartType.Ball;
    Part.Size = Vector3.new(0.8, 0.8, 0.8);
    Part.Color = Color3.fromRGB(124, 86, 52);
    Part.Material = Enum.Material.SmoothPlastic;
    Part.Parent = Model;
    Model.PrimaryPart = Part;

    return Model;
end;

local function snapshotHeldSeed(u101: userdata?) -- Line: 417
    -- upvalues: makeFallbackSeed (copy)
    if not u101 then
        return makeFallbackSeed();
    end;

    local success2, result2 = pcall(function() -- Line: 419
        -- upvalues: u101 (copy)
        local Archivable = u101.Archivable;
        u101.Archivable = true;
        local v102 = u101:Clone();
        u101.Archivable = Archivable;

        if not v102 then
            return nil;
        end;

        local Model = Instance.new("Model");
        Model.Name = "ShadyScarecrowSeed";

        for _, child in v102:GetChildren() do
            child.Parent = Model;
        end;

        v102:Destroy();

        for _, descendant in Model:GetDescendants() do
            if descendant:IsA("LuaSourceContainer") or (descendant:IsA("ProximityPrompt") or (descendant:IsA("BillboardGui") or descendant:IsA("Sound"))) then
                descendant:Destroy();
            elseif descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.Massless = true;
            end;
        end;

        local Handle = Model:FindFirstChild("Handle");

        if not (Handle and Handle:IsA("BasePart")) then
            Handle = Model:FindFirstChildWhichIsA("BasePart", true);
        end;

        if Handle then
            Model.PrimaryPart = Handle;

            return Model;
        end;

        Model:Destroy();

        return nil;
    end);

    return success2 and result2 and result2 or makeFallbackSeed();
end;

local function getHeldSeedTool() -- Line: 458
    -- upvalues: LocalPlayer (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    for _, child in Character:GetChildren() do
        if child:IsA("Tool") and (child:GetAttribute(InventoryServiceEnums.ITEM_TYPE) == ItemTypeEnums.Seed or typeof(child:GetAttribute("Seed")) == "string" and child:GetAttribute("Quantity") ~= nil) then
            return child;
        end;
    end;

    return nil;
end;

local u103 = nil;

local function npcSay(u104: userdata?, u105: string?) -- Line: 477
    -- upvalues: u103 (ref), ReplicatedStorage (copy), Config (ref), TweenService (copy), Debris (copy)
    if not (u104 and (u105 and u105 ~= "")) then
        return;
    end;

    if not u104:FindFirstChild("Head") then
        return;
    end;

    if not u103 then
        local success2, result2 = pcall(function() -- Line: 481
            -- upvalues: ReplicatedStorage (ref)
            return require(ReplicatedStorage.Top_Text);
        end);

        if not success2 then
            return;
        end;

        u103 = result2;
    end;

    local success2, result2 = pcall(u103.NpcText, u104, u105, true);

    if not success2 or typeof(result2) ~= "Instance" then
        return;
    end;

    local v106 = Config and Config.NPC_LINE_HOLD;
    task.delay(v106 == nil and 3 or v106, function() -- Line: 489
        -- upvalues: result2 (copy), u104 (copy), u105 (copy), TweenService (ref), Debris (ref)
        if not result2.Parent then
            return;
        end;

        if u104:GetAttribute("ConversationStarted") == true then
            return;
        end;

        local TextLabel = result2:FindFirstChild("TextLabel");

        if TextLabel and (TextLabel:IsA("TextLabel") and TextLabel.Text ~= u105) then
            return;
        end;

        for _, child in result2:GetChildren() do
            if child:IsA("TextLabel") then
                TweenService:Create(child, TweenInfo.new(0.25), {
                    TextTransparency = 1
                }):Play();
            elseif child:IsA("ImageLabel") then
                TweenService:Create(child, TweenInfo.new(0.25), {
                    ImageTransparency = 1
                }):Play();
            end;
        end;

        Debris:AddItem(result2, 0.25);
    end);
end;

local u107 = nil;
pcall(function() -- Line: 511
    -- upvalues: u107 (ref), ReplicatedStorage (copy)
    u107 = require(ReplicatedStorage.Code.Bezier);
end);

local function flySeedToNpc(u108: string?) -- Line: 512
    -- upvalues: LocalPlayer (copy), getNpcOriginPart (copy), ReplicatedStorage (copy), u107 (ref), SeedData (copy), Folder (copy), Config (ref), animate (copy), Debris (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character.PrimaryPart or Character:FindFirstChild("HumanoidRootPart");
    end;

    local u109 = getNpcOriginPart();
    local RewardDropVisual = ReplicatedStorage:FindFirstChild("RewardDropVisual");

    if not (Character and (u109 and (RewardDropVisual and u107))) then
        return;
    end;

    local u110 = RewardDropVisual:Clone();
    local v111 = u110:FindFirstChildWhichIsA("BillboardGui");

    if v111 then
        for _, child in v111:GetChildren() do
            if child:IsA("GuiObject") then
                child.Visible = false;
            end;
        end;

        local Gear = v111:FindFirstChild("Gear");
        local u112;

        if u108 then
            u112 = SeedData[u108];
        else
            u112 = u108;
        end;

        if u112 then
            u112 = u112.Asset;
        end;

        if not u112 and u108 then
            pcall(function() -- Line: 529
                -- upvalues: u112 (ref), ReplicatedStorage (ref), u108 (copy)
                u112 = require(ReplicatedStorage.Modules.ItemImageFinder)(u108, "Seed");
            end);
        end;

        if Gear and (Gear:IsA("ImageLabel") and u112) then
            Gear.Image = u112;
            Gear.Visible = true;
        end;

        v111.Enabled = true;
    end;

    local Value = u110:FindFirstChild("Value");

    if Value then
        Value:Destroy();
    end;

    local Position = Character.Position;
    u110.Anchored = true;
    u110.CanCollide = false;
    u110.CanQuery = false;
    u110.CanTouch = false;
    u110.CFrame = CFrame.new(Position);
    u110.Parent = Folder;
    local v113 = Config and Config.SEED_DROP_TIME;
    animate(v113 == nil and 0.5 or v113, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function(p114) -- Line: 548
        -- upvalues: u109 (copy), Position (copy), u110 (copy), u107 (ref)
        local Position2 = u109.Position;
        u110.CFrame = CFrame.new(u107.new(Position, (Position + Position2) / 2 + Vector3.new(0, 7, 0), Position2):Get(p114));
    end);
    u110:Destroy();
    local PopEffect = workspace.Terrain:FindFirstChild("PopEffect");

    if PopEffect then
        local v115 = PopEffect:Clone();
        v115.Parent = workspace.Terrain;
        v115.CFrame = CFrame.new(u109.Position);

        for _, child in v115:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child:Emit(1);
            end;
        end;

        Debris:AddItem(v115, 2);
    end;
end;

local u116 = nil;
local u117 = nil;

local function getCrowAnim(p118: string) -- Line: 572
    -- upvalues: Config (ref), u117 (ref), u116 (ref), ReplicatedStorage (copy)
    if p118 ~= "Peck" then
        if not u116 then
            local success2, result2 = pcall(function() -- Line: 586
                -- upvalues: ReplicatedStorage (ref), Config (ref)
                local v119 = Config and Config.CROW_ANIMATION_FOLDER;

                return ReplicatedStorage.Assets.Animations.PetAnimations:FindFirstChild(v119 == nil and "Cardinal" or v119);
            end);
            u116 = success2 and result2 and result2 or nil;
        end;

        local v120 = u116 and u116:FindFirstChild(p118);

        if v120 and v120:IsA("Animation") then
            return v120;
        end;

        return nil;
    end;

    local v121 = Config and Config.CROW_PECK_ANIMATION_ID;
    local v122 = v121 == nil and "rbxassetid://122251156947305" or v121;

    if not v122 or v122 == "" then
        return nil;
    end;

    if not u117 or u117.AnimationId ~= v122 then
        local Animation = Instance.new("Animation");
        Animation.Name = "Peck";
        Animation.AnimationId = v122;
        u117 = Animation;
    end;

    return u117;
end;

local function spawnCrow() -- Line: 597
    -- upvalues: Crow (copy), Config (ref), getCrowAnim (copy), Folder (copy)
    local u123 = Crow:Clone();
    local v124 = Config and Config.CROW_SCALE;
    local u125 = v124 == nil and 1 or v124;

    if u125 ~= 1 then
        pcall(function() -- Line: 600
            -- upvalues: u123 (copy), u125 (copy)
            u123:ScaleTo(u125);
        end);
    end;

    local Pivot = u123:GetPivot();
    local BoundingBox, v126 = u123:GetBoundingBox();
    local v127 = Pivot.Y - (BoundingBox.Y - v126.Y / 2);

    for _, descendant in u123:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Anchored = descendant == u123.PrimaryPart;
        end;
    end;

    if u123.PrimaryPart then
        u123.PrimaryPart.Anchored = true;
    end;

    local v128 = u123:FindFirstChildWhichIsA("AnimationController");
    local u129;

    if v128 then
        u129 = v128:FindFirstChildWhichIsA("Animator");

        if not u129 then
            u129 = Instance.new("Animator");
            u129.Parent = v128;
        end;
    else
        u129 = nil;
    end;

    local u130 = {};
    local u131 = nil;
    local v137 = {
        model = u123,
        heightOffset = v127,

        play = function(p132: string) -- Line: 634, Name: play
            -- upvalues: u129 (ref), u130 (copy), getCrowAnim (ref), u131 (ref)
            if not u129 then
                return;
            end;

            local v133 = u130[p132];

            if not v133 then
                local u134 = getCrowAnim(p132);

                if not u134 then
                    return;
                end;

                local v135;
                v135, v133 = pcall(function() -- Line: 640
                    -- upvalues: u129 (ref), u134 (copy)
                    return u129:LoadAnimation(u134);
                end);

                if not (v135 and v133) then
                    return;
                end;

                u130[p132] = v133;
            end;

            if u131 == v133 and v133.IsPlaying then
                return;
            end;

            if u131 then
                u131:Stop(0.15);
            end;

            local v136;

            if p132 == "FlyUp" then
                v136 = false;
            else
                v136 = p132 ~= "FlyDown";
            end;

            v133.Looped = v136;
            v133:Play(0.15);
            u131 = v133;
        end
    };
    u123.Parent = Folder;

    return v137;
end;

local function playSequence(u138: userdata, p139: any, p140: userdata?, p141: number?) -- Line: 659
    -- upvalues: getPart (copy), getNpcOriginPart (copy), Config (ref), playNpcAction (copy), CollectionService (copy), cacheTransparency (copy), Folder (copy), animate (copy), playAt (copy), spawnCrow (copy), startLoop (copy), TweenService (copy), npcSay (copy), FireDropBindable (copy), LocalPlayer (copy), play2D (copy), playLaugh (copy)
    local v142 = getPart("SeedPosition");
    local v143 = getNpcOriginPart();

    if not v142 then
        u138:Destroy();

        return;
    end;

    local v144 = v142.Position.Y + v142.Size.Y / 2;
    local Vector3_new_ret = Vector3.new(v142.Position.X, v144, v142.Position.Z);
    pcall(function() -- Line: 671
        -- upvalues: u138 (copy), Config (ref)
        local v145 = Config and Config.SEED_VISUAL_SCALE;
        u138:ScaleTo(v145 == nil and 1.4 or v145);
    end);
    local _, v146 = u138:GetBoundingBox();
    local v147 = v144 + v146.Y / 2;
    local v148 = Config and Config.SEED_BURY_DEPTH;
    local CFrame_new_ret = CFrame.new(Vector3_new_ret.X, v147, Vector3_new_ret.Z);
    local CFrame_new_ret2 = CFrame.new(Vector3_new_ret.X, v147 - (v148 == nil and 1.2 or v148), Vector3_new_ret.Z);
    local v149 = p141 or os.clock();

    if not p141 then
        local v150 = Config and Config.NPC_PLANT_ANIM_SPEED;
        playNpcAction("Plant", v150 == nil and 1.5 or v150);
    end;

    local v151 = Config and Config.MODEL_TAG;
    local u152 = CollectionService:GetTagged(v151 == nil and "ShadyScarecrowModel" or v151)[1];

    if u152 then
        u152 = u152:FindFirstChild("NPC");
    end;

    if not (u152 and u152:IsA("Model")) then
        u152 = nil;
    end;

    if u152 then
        local v153 = Config and Config.NPC_HAND_PART;
        u152 = u152:FindFirstChild(v153 == nil and "RightStraw1" or v153, true);
    end;

    if not (u152 and u152:IsA("BasePart")) then
        u152 = nil;
    end;

    local u154 = v143 and v143.Position or Vector3_new_ret + Vector3.new(0, 6, 0);

    local function handPos() -- Line: 686
        -- upvalues: u152 (copy), u154 (copy)
        if u152 and u152.Parent then
            return u152.Position;
        end;

        return u154;
    end;

    local u155 = cacheTransparency(u138);

    for i, v in u155 do
        if i.Parent then
            i.Transparency = v + (1 - v) * 1;
        end;
    end;

    local v156;

    if u152 and u152.Parent then
        v156 = u152.Position;
    else
        v156 = u154;
    end;

    u138:PivotTo(CFrame.new(v156));
    u138.Parent = Folder;
    local v157 = Config and Config.SEED_IN_HAND_TIME;
    animate(v157 == nil and 0.35 or v157, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function(p158) -- Line: 697
        -- upvalues: u138 (copy), u155 (copy), u152 (copy), u154 (copy)
        local v159 = 1 - p158;

        for i, v in u155 do
            if i.Parent then
                i.Transparency = v + (1 - v) * v159;
            end;
        end;

        local v160;

        if u152 and u152.Parent then
            v160 = u152.Position;
        else
            v160 = u154;
        end;

        u138:PivotTo(CFrame.new(v160));
    end);

    for i, v in u155 do
        if i.Parent then
            i.Transparency = v + (1 - v) * 0;
        end;
    end;

    local u161 = CFrame_new_ret:Lerp(CFrame_new_ret2, 0.5);

    if u152 and u152.Parent then
        u154 = u152.Position;
    end;

    local v162 = Config and Config.SEED_TOSS_ARC;
    local u163 = v162 == nil and 2 or v162;
    local v164 = Config and Config.SEED_TO_PATCH_TIME;
    animate(v164 == nil and 0.55 or v164, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, function(p165) -- Line: 707
        -- upvalues: u154 (copy), u161 (copy), u163 (copy), u138 (copy)
        local v166 = u154:Lerp(u161.Position, p165);
        local v167 = math.sin(p165 * 3.141592653589793) * u163;
        local v168 = v166 + Vector3.new(0, v167, 0);
        u138:PivotTo(CFrame.new(v168) * CFrame.Angles(0, p165 * 3.141592653589793 * 2, 0));
    end);
    playAt("Plant", u161.Position, 0.08);
    animate(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In, function(p169) -- Line: 712
        -- upvalues: u138 (copy), u161 (copy), CFrame_new_ret2 (copy)
        u138:PivotTo(u161:Lerp(CFrame_new_ret2, p169));
    end);
    local v170 = Config and Config.PLANT_TO_CROW_DELAY;
    local v171 = (v170 == nil and 5 or v170) - (os.clock() - v149);

    if v171 > 0 then
        task.wait(v171);
    end;

    local v172 = Config and Config.CROW_COUNT;
    local math_max_ret = math.max(v172 == nil and 3 or v172, 1);
    local v173 = Config and Config.CROW_RING_RADIUS;
    local v174 = v173 == nil and 2.6 or v173;
    local v175 = Config and Config.CROW_SPAWN_HEIGHT;
    local v176 = v175 == nil and 30 or v175;
    local v177 = Config and Config.CROW_SPAWN_SPREAD;
    local v178 = v177 == nil and 25 or v177;
    local v179 = Config and Config.CROW_ARRIVE_TIME;
    local u180 = v179 == nil and 1.6 or v179;
    local v181 = math.random() * 3.141592653589793 * 2;
    local u182 = {};

    for i = 1, math_max_ret do
        local v183 = spawnCrow();
        local v184 = v181 + (i - 1) * (6.283185307179586 / math_max_ret);
        local math_cos_ret = math.cos(v184);
        local math_sin_ret = math.sin(v184);
        local Vector3_new_ret2 = Vector3.new(math_cos_ret, 0, math_sin_ret);
        local v185 = Vector3_new_ret + Vector3_new_ret2 * v174 + Vector3.new(0, v183.heightOffset, 0);
        local v186 = v176 + math.random() * 6;
        local v187 = Vector3_new_ret + Vector3_new_ret2 * v178 + Vector3.new(0, v186, 0);
        v183.landCF = CFrame.lookAt(v185, (Vector3.new(Vector3_new_ret.X, v185.Y, Vector3_new_ret.Z)));
        v183.fromPos = v187;
        v183.dir = Vector3_new_ret2;
        v183.model:PivotTo(CFrame.lookAt(v187, v185));
        table.insert(u182, v183);
        local _ = i;
    end;

    if u182[1] then
        playAt("CrowCaw", u182[1].fromPos, 0.1);
    end;

    local u188 = 0;

    for i, v in u182 do
        task.spawn(function() -- Line: 745
            -- upvalues: i (copy), v (copy), startLoop (ref), animate (ref), u180 (copy), playAt (ref), u188 (ref)
            task.wait((i - 1) * 0.15);
            v.play("Fly");
            local u189 = startLoop("Flying Loop", v.model.PrimaryPart);
            local Pivot = v.model:GetPivot();
            local u190 = false;
            animate(u180, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, function(p191) -- Line: 751
                -- upvalues: v (ref), Pivot (copy), u190 (ref), playAt (ref)
                if not v.model.Parent then
                    return;
                end;

                local v192 = Pivot.Position:Lerp(v.landCF.Position, p191);
                local v193 = Pivot.Rotation:Lerp(v.landCF.Rotation, (math.clamp(p191 * 1.5, 0, 1)));
                v.model:PivotTo(CFrame.new(v192) * v193);

                if p191 > 0.7 then
                    v.play("FlyDown");

                    if not u190 then
                        u190 = true;
                        playAt("CrowLand", v.landCF.Position, 0.1);
                    end;
                end;
            end);

            if u189 then
                pcall(function() -- Line: 364
                    -- upvalues: u189 (copy)
                    u189:Stop();
                    u189:Destroy();
                end);
            end;

            v.play("Idle");
            u188 = u188 + 1;
        end);
    end;

    local os_clock_ret = os.clock();

    repeat
        task.wait();
    until #u182 <= u188 or os.clock() - os_clock_ret > u180 + 2;

    local v194 = Config and Config.PECK_TIME;
    local v195 = Config and Config.PECK_INTERVAL;
    local math_max_ret2 = math.max(v195 == nil and 0.35 or v195, 0.1);
    local v196 = Config and Config.PECK_ANGLE;
    local math_rad_ret = math.rad(v196 == nil and 35 or v196);
    local v197 = Config and Config.SEED_JIGGLE_DEG;
    local math_rad_ret2 = math.rad(v197 == nil and 12 or v197);
    local os_clock_ret2 = os.clock();
    local u198 = {};
    local u199 = {};

    for i, v in u182 do
        u198[i] = math.random() * math_max_ret2;
        u199[i] = 1;
        v.play("Peck");
    end;

    animate(v194 == nil and 4 or v194, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, function(p200) -- Line: 787
        -- upvalues: os_clock_ret2 (copy), TweenService (ref), math_rad_ret2 (copy), CFrame_new_ret2 (copy), CFrame_new_ret (copy), u138 (copy), u182 (copy), u198 (copy), math_max_ret2 (copy), math_rad_ret (copy), u199 (copy), playAt (ref)
        local v201 = os.clock() - os_clock_ret2;
        local Value = TweenService:GetValue(p200, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local v202 = math_rad_ret2 * (0.4 + 0.6 * p200);
        u138:PivotTo(CFrame_new_ret2:Lerp(CFrame_new_ret, Value) * CFrame.Angles(math.sin(v201 * 22) * v202, 0, math.cos(v201 * 17) * v202));

        for i, v in u182 do
            if v.model.Parent then
                local v203 = (v201 + u198[i]) % math_max_ret2 / math_max_ret2;
                local v204 = math.clamp(v203 * 2, 0, 1) * 3.141592653589793;
                local math_sin_ret = math.sin(v204);
                v.model:PivotTo(v.landCF * CFrame.Angles(-math_rad_ret * math_sin_ret, 0, 0));

                if u199[i] < 0.25 and v203 >= 0.25 then
                    playAt("Peck", v.model:GetPivot().Position, 0.15);
                end;

                u199[i] = v203;
            end;
        end;
    end);

    for _, v in u182 do
        v.play("Idle");

        if v.model.Parent then
            v.model:PivotTo(v.landCF);
        end;
    end;

    u138:PivotTo(CFrame_new_ret);
    local u205 = u182[1];
    local v206 = Config and Config.CROW_SCALE;
    local v207 = Config and Config.CROW_SCALE;
    local CFrame_new_ret3 = CFrame.new(0, 0.35 * (v206 == nil and 1 or v206), -1.35 * (v207 == nil and 1 or v207));
    local v208 = Config and Config.GRAB_TIME;
    local v209 = v208 == nil and 0.6 or v208;

    if u205 and u205.model.Parent then
        local Pivot = u205.model:GetPivot();
        local Position = (Pivot.Rotation * CFrame_new_ret3).Position;
        local CFrame_new_ret4 = CFrame.new(CFrame_new_ret.X - Position.X, Pivot.Y, CFrame_new_ret.Z - Position.Z);
        animate(v209, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, function(p210) -- Line: 824
            -- upvalues: Pivot (copy), CFrame_new_ret4 (copy), u205 (copy), u138 (copy), CFrame_new_ret3 (copy)
            local v211 = Pivot.Position:Lerp(CFrame_new_ret4.Position, p210);
            local v212 = math.sin(p210 * 3.141592653589793) * 1;
            local v213 = v211 + Vector3.new(0, v212, 0);
            u205.model:PivotTo(CFrame.new(v213) * Pivot.Rotation);

            if p210 > 0.6 and u138.Parent then
                u138:PivotTo(u205.model:GetPivot() * CFrame_new_ret3);
            end;
        end);
        playAt("CrowCaw", CFrame_new_ret.Position, 0.1);
    end;

    local v214 = Config and Config.FLY_AWAY_TIME;
    local u215 = v214 == nil and 2.2 or v214;
    local v216 = Config and Config.CROW_FLY_DISTANCE;
    local u217 = v216 == nil and 70 or v216;
    local u218 = 0;

    for _, v in u182 do
        task.spawn(function() -- Line: 840
            -- upvalues: v (copy), u218 (ref), u205 (copy), u217 (copy), cacheTransparency (ref), playAt (ref), startLoop (ref), animate (ref), u215 (copy), u138 (copy), CFrame_new_ret3 (copy)
            if not v.model.Parent then
                u218 = u218 + 1;

                return;
            end;

            local Pivot = v.model:GetPivot();
            local dir = v.dir;

            if v == u205 then
                local v219 = math.random() * 3.141592653589793 * 2;
                local math_cos_ret = math.cos(v219);
                local math_sin_ret = math.sin(v219);
                dir = Vector3.new(math_cos_ret, 0, math_sin_ret);
            end;

            local u220 = Pivot.Position + dir * u217 + Vector3.new(0, u217 * 0.6, 0);
            local Rotation = CFrame.lookAt(Pivot.Position, u220).Rotation;
            local u221 = cacheTransparency(v.model);
            v.play("FlyUp");
            playAt("CrowTakeoff", Pivot.Position, 0.1);
            startLoop("Flying Loop", v.model.PrimaryPart);
            task.delay(0.35, function() -- Line: 854
                -- upvalues: v (ref)
                v.play("Fly");
            end);
            animate(u215, Enum.EasingStyle.Quad, Enum.EasingDirection.In, function(p222) -- Line: 855
                -- upvalues: v (ref), Pivot (copy), u220 (copy), Rotation (copy), u205 (ref), u138 (ref), CFrame_new_ret3 (ref), u221 (copy)
                if not v.model.Parent then
                    return;
                end;

                local v223 = Pivot.Position:Lerp(u220, p222);
                local v224 = Pivot.Rotation:Lerp(Rotation, (math.clamp(p222 * 3, 0, 1)));
                local v225 = CFrame.new(v223) * v224;
                v.model:PivotTo(v225);

                if v == u205 and u138.Parent then
                    u138:PivotTo(v225 * CFrame_new_ret3);
                end;

                if p222 > 0.65 then
                    local v226 = (p222 - 0.65) / 0.35;
                    local _ = v.model;

                    for i, v2 in u221 do
                        if i.Parent then
                            i.Transparency = v2 + (1 - v2) * v226;
                        end;
                    end;
                end;
            end);
            v.model:Destroy();
            u218 = u218 + 1;
        end);
    end;

    task.spawn(function() -- Line: 874
        -- upvalues: cacheTransparency (ref), u138 (copy), u215 (copy), animate (ref)
        local u227 = cacheTransparency(u138);
        task.wait(u215 * 0.65);
        animate(u215 * 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, function(p228) -- Line: 877
            -- upvalues: u138 (ref), u227 (copy)
            for i, v in u227 do
                if i.Parent then
                    i.Transparency = v + (1 - v) * p228;
                end;
            end;
        end);
    end);
    local os_clock_ret3 = os.clock();

    repeat
        task.wait();
    until #u182 <= u218 or os.clock() - os_clock_ret3 > u215 + 2;

    if u138.Parent then
        u138:Destroy();
    end;

    local v229 = Config and Config.REWARD_DELAY;
    task.wait(v229 == nil and 0.4 or v229);
    local v230 = {};
    local v231 = Config and Config.DIALOGUE;

    if v231 == nil then
        v231 = v230;
    end;

    if v231.RewardLine and v231.RewardLine ~= "" then
        task.spawn(npcSay, p140, v231.RewardLine);
        local v232 = Config and Config.REWARD_LINE_LEAD;
        task.wait(v232 == nil and 1.5 or v232);
    end;

    playNpcAction("Success");
    local Reward = p139.Reward;

    if FireDropBindable and Reward then
        local u233 = v143 and v143.CFrame or LocalPlayer.Character and LocalPlayer.Character:GetPivot();

        if u233 then
            pcall(function() -- Line: 897
                -- upvalues: FireDropBindable (ref), LocalPlayer (ref), Reward (copy), u233 (copy)
                local v234 = {
                    Owner = LocalPlayer.Name
                };
                local Type = Reward.Type;
                v234.RewardType = Type == "Currency" and "Coins" or (Type == "Seed" and "Seeds" or (Type == "Seed Pack" and "SeedPack" or "Items"));
                v234.GearName = Reward.Value;
                v234.KeySeed = Reward.Value;
                FireDropBindable:Fire(v234, u233);
            end);
        end;
    end;

    if v143 then
        playAt("Reward", v143.Position);
    else
        play2D("Reward");
    end;

    playLaugh(v143 and v143.Position or nil);
end;

local u235 = nil;

local function confirmGiveSeed(p236: userdata) -- Line: 922
    -- upvalues: u235 (ref), ReplicatedStorage (copy), InventoryServiceEnums (copy), SeedData (copy), Config (ref)
    if not u235 then
        local success2, result2 = pcall(function() -- Line: 924
            -- upvalues: ReplicatedStorage (ref)
            return require(ReplicatedStorage.Modules.ConfirmationPromptController);
        end);

        if not success2 then
            warn("ShadyScarecrowController: ConfirmationPromptController unavailable -- skipping confirmation");

            return true;
        end;

        u235 = result2;
    end;

    local v237 = p236:GetAttribute("Seed") or (p236:GetAttribute(InventoryServiceEnums.ItemName) or p236.Name);
    local Attribute = p236:GetAttribute("Variant");
    local u238 = (Attribute == nil or Attribute == "") and "Normal" or Attribute;
    local v239 = SeedData[v237];
    local u240 = v239 and v239.SeedRarity or "Unknown";
    local u241 = (u238 == "Normal" and "" or (`{u238} ` or "")) .. `{v237} Seed`;

    local function fill(p242: string) -- Line: 939
        -- upvalues: u241 (copy), u240 (copy), u238 (ref)
        return p242:gsub("{SEED}", u241):gsub("{RARITY}", u240):gsub("{VARIANT}", u238);
    end;

    local u243 = nil;
    local v244 = {};
    local v245 = Config and Config.CONFIRM_TITLE;
    v244.Title = (v245 == nil and "Shady Scarecrow" or v245):gsub("{SEED}", u241):gsub("{RARITY}", u240):gsub("{VARIANT}", u238);
    local v246 = Config and Config.CONFIRM_HEADER;
    v244.Header = (v246 == nil and "{SEED}" or v246):gsub("{SEED}", u241):gsub("{RARITY}", u240):gsub("{VARIANT}", u238);
    local v247 = Config and Config.CONFIRM_MIDDLE;
    v244.Middle = (v247 == nil and "Give 1x {SEED} ({RARITY}) to the Shady Scarecrow?" or v247):gsub("{SEED}", u241):gsub("{RARITY}", u240):gsub("{VARIANT}", u238);
    local v248 = Config and Config.CONFIRM_FOOTER;
    v244.Footer = (v248 == nil and "The crows will take it. This can\'t be undone!" or v248):gsub("{SEED}", u241):gsub("{RARITY}", u240):gsub("{VARIANT}", u238);
    local v249 = Config and Config.CONFIRM_BUTTON;
    v244.ConfirmText = v249 == nil and "Give" or v249;
    local v250 = Config and Config.CANCEL_BUTTON;
    v244.RejectText = v250 == nil and "Cancel" or v250;
    v244.AnimatedWords = {
        [u240] = u240
    };
    u235:Open(v244, {
        ConfirmCallback = function() -- Line: 953, Name: ConfirmCallback
            -- upvalues: u243 (ref)
            u243 = true;
        end,

        RejectCallback = function() -- Line: 954, Name: RejectCallback
            -- upvalues: u243 (ref)
            u243 = false;
        end
    });
    local os_clock_ret = os.clock();
    task.wait();

    while u243 == nil and u235:IsThisOpen() do
        local v251 = os.clock() - os_clock_ret;
        local v252 = Config and Config.CONFIRM_TIMEOUT;

        if (v252 == nil and 60 or v252) < v251 then
            pcall(function() -- Line: 963
                -- upvalues: u235 (ref)
                u235:Close();
            end);
            break;
        end;

        task.wait();
    end;

    return u243 == true;
end;

function u2.PlayGreetingLaugh(p253) -- Line: 973
    -- upvalues: getNpcOriginPart (copy), playLaugh (copy)
    local v254 = getNpcOriginPart();
    playLaugh(v254 and v254.Position or nil);
end;

function u2.SubmitHeldSeed(p255: table, u256: userdata?) -- Line: 978
    -- upvalues: u4 (ref), Config (ref), getHeldSeedTool (copy), u3 (ref), confirmGiveSeed (copy), InventoryServiceEnums (copy), makeFallbackSeed (copy), playNpcAction (copy), Submit (copy), u21 (copy), play2D (copy), getNpcOriginPart (copy), playLaugh (copy), flySeedToNpc (copy), playSequence (copy)
    if u4 then
        local v257 = {
            Ok = false
        };
        local v258 = Config and Config.MSG_BUSY;
        v257.Message = v258 == nil and "Hold on, the crows are still busy!" or v258;

        return false, v257;
    end;

    local u259 = getHeldSeedTool();

    if not u259 then
        local v260 = Config and Config.MSG_NOT_HOLDING_SEED;
        local u261 = v260 == nil and "Hold the seed you want to give first!" or v260;

        if u3 then
            pcall(function() -- Line: 985
                -- upvalues: u3 (ref), u261 (copy)
                u3:CreateNotification(u261);
            end);
        end;

        return false, {
            Ok = false,
            Message = u261
        };
    end;

    if not confirmGiveSeed(u259) then
        local v262 = {
            Ok = false,
            Cancelled = true
        };
        local v263 = {};
        local v264 = Config and Config.DIALOGUE;

        if v264 == nil then
            v264 = v263;
        end;

        v262.Message = v264.CancelLine;

        return false, v262;
    end;

    if u4 then
        local v265 = {
            Ok = false
        };
        local v266 = Config and Config.MSG_BUSY;
        v265.Message = v266 == nil and "Hold on, the crows are still busy!" or v266;

        return false, v265;
    end;

    local Attribute = u259:GetAttribute(InventoryServiceEnums.ITEM_UUID);

    if getHeldSeedTool() ~= u259 or not Attribute then
        local v267 = Config and Config.MSG_SEED_CHANGED;
        local u268 = v267 == nil and "Keep holding the seed you chose!" or v267;

        if u3 then
            pcall(function() -- Line: 1000
                -- upvalues: u3 (ref), u268 (copy)
                u3:CreateNotification(u268);
            end);
        end;

        return false, {
            Ok = false,
            Message = u268
        };
    end;

    local u269;

    if u259 then
        local success2, result2 = pcall(function() -- Line: 419
            -- upvalues: u259 (copy)
            local Archivable = u259.Archivable;
            u259.Archivable = true;
            local v270 = u259:Clone();
            u259.Archivable = Archivable;

            if not v270 then
                return nil;
            end;

            local Model = Instance.new("Model");
            Model.Name = "ShadyScarecrowSeed";

            for _, child in v270:GetChildren() do
                child.Parent = Model;
            end;

            v270:Destroy();

            for _, descendant in Model:GetDescendants() do
                if descendant:IsA("LuaSourceContainer") or (descendant:IsA("ProximityPrompt") or (descendant:IsA("BillboardGui") or descendant:IsA("Sound"))) then
                    descendant:Destroy();
                elseif descendant:IsA("BasePart") then
                    descendant.Anchored = true;
                    descendant.CanCollide = false;
                    descendant.CanQuery = false;
                    descendant.CanTouch = false;
                    descendant.Massless = true;
                end;
            end;

            local Handle = Model:FindFirstChild("Handle");

            if not (Handle and Handle:IsA("BasePart")) then
                Handle = Model:FindFirstChildWhichIsA("BasePart", true);
            end;

            if Handle then
                Model.PrimaryPart = Handle;

                return Model;
            end;

            Model:Destroy();

            return nil;
        end);
        u269 = success2 and result2 and result2 or makeFallbackSeed();
    else
        u269 = makeFallbackSeed();
    end;

    u4 = true;
    local os_clock_ret = os.clock();
    local v271 = Config and Config.NPC_PLANT_ANIM_SPEED;
    playNpcAction("Plant", v271 == nil and 1.5 or v271);
    local u272 = nil;
    task.spawn(function() -- Line: 1015
        -- upvalues: Submit (ref), Attribute (copy), u21 (ref), Config (ref), u4 (ref), u269 (copy), u272 (ref), play2D (ref), getNpcOriginPart (ref), playLaugh (ref), flySeedToNpc (ref), playSequence (ref), u256 (copy), os_clock_ret (copy)
        local success2, result2 = pcall(function() -- Line: 1016
            -- upvalues: Submit (ref), Attribute (ref)
            return Submit:InvokeServer(Attribute);
        end);

        if not (success2 and (typeof(result2) == "table" and result2.Ok)) then
            local Plant = u21.Plant;

            if Plant and Plant.IsPlaying then
                local v273 = Config and Config.NPC_ANIM_FADE;
                Plant:Stop(v273 == nil and 0.2 or v273);
            end;

            u4 = false;
            u269:Destroy();
            u272 = typeof(result2) == "table" and result2 and result2 or {
                Ok = false
            };

            return;
        end;

        u272 = result2;
        play2D("Submit");
        local v274 = getNpcOriginPart();
        playLaugh(v274 and v274.Position or nil);
        task.spawn(flySeedToNpc, result2.Seed);
        local success3, result3 = pcall(playSequence, u269, result2, u256, os_clock_ret);

        if not success3 then
            warn("ShadyScarecrowController sequence error:", result3);
        end;

        if u269.Parent then
            u269:Destroy();
        end;

        u4 = false;
    end);

    while u272 == nil do
        task.wait();
    end;

    return u272.Ok == true, u272;
end;

local u275 = nil;

local function getUIModules() -- Line: 1043
    -- upvalues: u275 (ref), ReplicatedStorage (copy)
    if u275 then
        return u275;
    end;

    local success2, result2 = pcall(function() -- Line: 1045
        -- upvalues: ReplicatedStorage (ref)
        return {
            Gui = require(ReplicatedStorage.Modules.GuiController),
            ImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder),
            InfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover),
            FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated),
            ItemOdds = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController)
        };
    end);

    if success2 then
        u275 = result2;
    end;

    return u275;
end;

local u276 = nil;
local u277 = false;
local u278 = {};

local function addButtonSFX(p279: userdata) -- Line: 1062
    -- upvalues: SoundService (copy), UserInputService (copy)
    local Hover = SoundService:FindFirstChild("Hover");
    local Click = SoundService:FindFirstChild("Click");

    if Hover and not UserInputService.TouchEnabled then
        p279.MouseEnter:Connect(function() -- Line: 1066
            -- upvalues: Hover (copy)
            Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Hover.TimePosition = 0;
            Hover.Playing = true;
        end);
    end;

    if Click then
        p279.Activated:Connect(function() -- Line: 1073
            -- upvalues: Click (copy)
            Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Click.TimePosition = 0;
            Click.Playing = true;
        end);
    end;
end;

local function getRewardsGui() -- Line: 1081
    -- upvalues: LocalPlayer (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

    return PlayerGui.Events.FallMarketEvent:FindFirstChild("ShadyScarecrow_UI") or PlayerGui:WaitForChild("ShadyScarecrow_UI", 10);
end;

local function buildRewardsUI() -- Line: 1086
    -- upvalues: u275 (ref), ReplicatedStorage (copy), LocalPlayer (copy), u276 (ref), u278 (copy), Config (ref), addButtonSFX (copy), u277 (ref), RunService (copy)
    local u280;

    if u275 then
        u280 = u275;
    else
        local success2, result2 = pcall(function() -- Line: 1045
            -- upvalues: ReplicatedStorage (ref)
            return {
                Gui = require(ReplicatedStorage.Modules.GuiController),
                ImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder),
                InfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover),
                FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated),
                ItemOdds = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController)
            };
        end);

        if success2 then
            u275 = result2;
        end;

        u280 = u275;
    end;

    if not u280 then
        return;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local u281 = PlayerGui.Events.FallMarketEvent:FindFirstChild("ShadyScarecrow_UI") or PlayerGui:WaitForChild("ShadyScarecrow_UI", 10);

    if not u281 then
        return;
    end;

    local Frame = u281.Frame;
    local PageTemplate = Frame.Main:FindFirstChild("PageTemplate");
    local v282;

    if PageTemplate then
        v282 = PageTemplate:FindFirstChild("ScrollingFrame");
    else
        v282 = PageTemplate;
    end;

    if not v282 then
        warn("ShadyScarecrowController: ShadyScarecrow_UI Frame.Main.PageTemplate.ScrollingFrame not found");

        return;
    end;

    if not u276 then
        local ItemTemplate = v282:FindFirstChild("ItemTemplate");

        if not (ItemTemplate and ItemTemplate:IsA("GuiObject")) then
            warn("ShadyScarecrowController: ShadyScarecrow_UI ItemTemplate not found");

            return;
        end;

        ItemTemplate.Parent = nil;
        u276 = ItemTemplate;
    end;

    for _, child in v282:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    table.clear(u278);
    PageTemplate.Visible = true;
    local Header = Frame:FindFirstChild("Header");

    if Header and Header:FindFirstChild("Title") then
        local v283 = Config and Config.REWARDS_UI_TITLE;
        Header.Title.Text = v283 == nil and "Shady Scarecrow Rewards" or v283;
    end;

    local Information = Frame:FindFirstChild("Information");

    if Information and Information:FindFirstChild("Text") then
        local v284 = Config and Config.REWARDS_UI_INFO;
        Information.Text.Text = v284 == nil and "" or v284;
    end;

    local v285 = {};
    local v286 = Config and Config.REWARDS;
    local v287, v288;

    if v286 == nil then
        v286 = v285;
        v287 = nil;
        v288 = nil;
    else
        v287 = nil;
        v288 = nil;
    end;

    for i, v in v286, v287, v288 do
        local v289 = u276:Clone();
        v289.Name = string.format("Reward_%03d", i);
        v289.LayoutOrder = i;
        local u290 = v.Quantity or 1;
        local EntryName = v289:FindFirstChild("EntryName");

        if EntryName and EntryName:IsA("TextLabel") then
            EntryName.Text = v.Display or v.Value;
        end;

        local Quantity = v289:FindFirstChild("Quantity");

        if Quantity and Quantity:IsA("TextLabel") then
            Quantity.Text = u290 > 1 and (`x{u280.FormatAbbreviated(u290)}` or "") or "";
        end;

        local Icon = v289:FindFirstChild("Icon");

        if Icon and Icon:IsA("ImageLabel") then
            local success2, result2 = pcall(u280.ImageFinder, v.Value, v.Type);

            if success2 and result2 then
                Icon.Image = result2;
            end;
        end;

        if v.RainbowInterface then
            local UIStroke = v289:FindFirstChild("UIStroke");
            local v291;

            if UIStroke then
                v291 = UIStroke:FindFirstChildWhichIsA("UIGradient");
            else
                v291 = UIStroke;
            end;

            if v291 then
                v291.Enabled = true;
                UIStroke.Color = Color3.fromRGB(255, 255, 255);
                u278[v291] = true;
            end;

            local v292 = v289:FindFirstChildWhichIsA("UIGradient");

            if v292 then
                v292.Enabled = true;
                v289.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            end;

            local Details = v289:FindFirstChild("Details");

            if Details then
                Details = Details:FindFirstChild("InnerGlow");
            end;

            if Details and Details:IsA("GuiObject") then
                Details.Visible = false;
            end;
        elseif v.BlueInterface then
            local BlueFrame = v289:FindFirstChild("BlueFrame");

            if BlueFrame and BlueFrame:IsA("GuiObject") then
                BlueFrame.Visible = true;
                v289.BackgroundTransparency = 1;
                local UIStroke = v289:FindFirstChild("UIStroke");

                if UIStroke and UIStroke:IsA("UIStroke") then
                    UIStroke.Enabled = false;
                end;
            end;
        end;

        local OddsButton = v289:FindFirstChild("OddsButton");

        if OddsButton and OddsButton:IsA("GuiButton") then
            u280.ItemOdds:ConnectOddsButton({
                Type = v.Type,
                Value = v.Value,
                Quantity = u290
            }, OddsButton, u281);

            if OddsButton.Visible then
                addButtonSFX(OddsButton);
            end;
        end;

        local u293 = `ShadyScarecrowReward_{i}_{v.Type}_{v.Value}`;
        pcall(function() -- Line: 1186
            -- upvalues: u280 (copy), u293 (copy), v (copy), u290 (copy)
            u280.InfoHover:AddItemFromRewardWithQuantity(u293, {
                Value = v.Value,
                Type = v.Type,
                Quantity = u290
            });
        end);
        v289:SetAttribute("UUID", u293);
        v289:AddTag("ItemInfoHoverTag");
        v289.Parent = v282;
    end;

    if not u277 then
        u277 = true;

        if Header then
            Header = Header:FindFirstChild("Close");
        end;

        if Header and Header:IsA("GuiButton") then
            Header.Activated:Connect(function() -- Line: 1204
                -- upvalues: u280 (copy), u281 (copy)
                u280.Gui:Close(u281);
            end);
        end;

        RunService.Heartbeat:Connect(function(p294: number) -- Line: 1206
            -- upvalues: u281 (copy), u278 (ref)
            if not u281.Enabled then
                return;
            end;

            for i in u278 do
                i.Rotation = (i.Rotation + p294 * 30) % 360;
            end;
        end);
    end;
end;

function u2.OpenRewards(p295) -- Line: 1215
    -- upvalues: buildRewardsUI (copy), u275 (ref), ReplicatedStorage (copy), LocalPlayer (copy)
    local success2, result2 = pcall(buildRewardsUI);

    if not success2 then
        warn("ShadyScarecrowController rewards UI error:", result2);
    end;

    local v296;

    if u275 then
        v296 = u275;
    else
        local success3, result3 = pcall(function() -- Line: 1045
            -- upvalues: ReplicatedStorage (ref)
            return {
                Gui = require(ReplicatedStorage.Modules.GuiController),
                ImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder),
                InfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover),
                FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated),
                ItemOdds = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController)
            };
        end);

        if success3 then
            u275 = result3;
        end;

        v296 = u275;
    end;

    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    local v297 = PlayerGui.Events.FallMarketEvent:FindFirstChild("ShadyScarecrow_UI") or PlayerGui:WaitForChild("ShadyScarecrow_UI", 10);

    if v296 and v297 then
        v296.Gui:Open(v297);
    end;
end;

function u2.Start(p298) -- Line: 1226
    -- upvalues: u1 (copy), buildRewardsUI (copy), preloadNpcTracks (copy), playNpcIdle (copy), CollectionService (copy), Config (ref), LocalPlayer (copy), u4 (ref)
    u1:Add(task.spawn(function() -- Line: 1228
        -- upvalues: buildRewardsUI (ref)
        pcall(buildRewardsUI);
    end));
    u1:Add(task.spawn(function() -- Line: 1231
        -- upvalues: preloadNpcTracks (ref), playNpcIdle (ref)
        while true do
            pcall(preloadNpcTracks);
            pcall(playNpcIdle);
            task.wait(2);
        end;
    end));
    u1:Add(task.spawn(function() -- Line: 1240
        -- upvalues: CollectionService (ref), Config (ref), LocalPlayer (ref), u4 (ref)
        local v299 = Config and Config.MODEL_TAG;
        local v300 = CollectionService:GetTagged(v299 == nil and "ShadyScarecrowModel" or v299)[1];
        local v301 = 0;

        while not v300 and v301 < 30 do
            task.wait(1);
            v301 = v301 + 1;
            local v302 = Config and Config.MODEL_TAG;
            v300 = CollectionService:GetTagged(v302 == nil and "ShadyScarecrowModel" or v302)[1];
        end;

        if not v300 then
            return;
        end;

        local Important = v300:WaitForChild("Important", 30);

        if Important then
            Important = Important:WaitForChild("Cooldown", 30);
        end;

        if Important then
            Important = Important:WaitForChild("BillboardGui", 30);
        end;

        local v303;

        if Important then
            v303 = Important:WaitForChild("Holder", 30);
        else
            v303 = Important;
        end;

        if not v303 then
            return;
        end;

        local Timer = v303:WaitForChild("Timer", 30);
        local Title = v303:FindFirstChild("Title");

        if not Timer then
            return;
        end;

        while true do
            local v304 = Config and Config.PLAYER_READY_ATTRIBUTE;
            local Attribute = LocalPlayer:GetAttribute(v304 == nil and "ShadyScarecrowReadyAt" or v304);
            local ServerTimeNow = workspace:GetServerTimeNow();
            Important.Enabled = not u4;

            if not u4 then
                if typeof(Attribute) == "number" and ServerTimeNow < Attribute then
                    if Title then
                        local v305 = Config and Config.TITLE_COOLDOWN;
                        Title.Text = v305 == nil and "Come Back In:" or v305;
                    end;

                    local math_ceil_ret = math.ceil(Attribute - ServerTimeNow);
                    local math_max_ret = math.max(math_ceil_ret, 0);
                    local v306 = math_max_ret // 3600;
                    local v307 = math_max_ret % 3600 // 60;
                    local v308 = math_max_ret % 60;
                    local v309;

                    if v306 > 0 then
                        v309 = string.format("%d:%02d:%02d", v306, v307, v308);
                    else
                        v309 = string.format("%02d:%02d", v307, v308);
                    end;

                    Timer.Text = v309;
                else
                    if Title then
                        local v310 = Config and Config.TITLE_READY;
                        Title.Text = v310 == nil and "Shady Scarecrow" or v310;
                    end;

                    local v311 = Config and Config.TIMER_READY;
                    Timer.Text = v311 == nil and "Ready!" or v311;
                end;
            end;

            task.wait(0.5);
        end;
    end));
end;

function u2.Stop(p312) -- Line: 1279
    -- upvalues: u1 (copy), stopNpcAnims (copy), Folder (copy)
    u1:Clean();
    stopNpcAnims();
    Folder:ClearAllChildren();
end;

EventRotationClientBinder:Bind({
    EventSet = "FallMarketEvent",
    MinPartIndex = 3,
    Script = script,

    OnStart = function() -- Line: 1289, Name: OnStart
        -- upvalues: u2 (copy)
        task.spawn(u2.Start, u2);
    end,

    OnStop = function() -- Line: 1290, Name: OnStop
        -- upvalues: u2 (copy)
        u2:Stop();
    end
});

return u2;