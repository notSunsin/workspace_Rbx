-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local SoundService = game:GetService("SoundService");
local UserInputService = game:GetService("UserInputService");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local GlobalUpdateTime = ReplicatedFirst:WaitForChild("GlobalUpdateTime");
local u2 = {};
local success, result = pcall(function() -- Line: 35
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.IsInTradeWorld);
end);

if success and result then
    return u2;
end;

local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("AcornChaosConfig");
workspace:GetAttributeChangedSignal("AcornChaosConfig"):Connect(function() -- Line: 43
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("AcornChaosConfig");
end);
local LocalPlayer = Players.LocalPlayer;
local u3 = nil;
pcall(function() -- Line: 50
    -- upvalues: u3 (ref), ReplicatedStorage (copy)
    u3 = require(ReplicatedStorage.Modules.Notification);
end);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local AcornChaos = GameEvents:WaitForChild("AcornChaos");
local Start = AcornChaos:WaitForChild("Start");
local Crack = AcornChaos:WaitForChild("Crack");
local Reward = AcornChaos:WaitForChild("Reward");
local FireDropBindable = GameEvents:FindFirstChild("FireDropBindable");
local Acorns = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Acorns");
local Folder = Instance.new("Folder");
Folder.Name = "AcornChaosLocal";
Folder.Parent = workspace;
local u4 = {};
local u5 = {};
local u6 = false;

local function attr(p7, p8) -- Line: 79
    -- upvalues: Config (ref)
    if Config then
        p8 = Config[p7] or p8;
    end;

    return p8;
end;

local function getStartGate() -- Line: 84
    -- upvalues: Config (ref), GlobalUpdateTime (copy)
    local v9 = Config and Config.START_EPOCH or 0;

    return v9 == -1 and (tonumber(GlobalUpdateTime.Value) or 0) or v9;
end;

local function formatClock(p10: number) -- Line: 91
    local math_floor_ret = math.floor(p10);
    local math_max_ret = math.max(math_floor_ret, 0);
    local v11 = math_max_ret // 3600;
    local v12 = math_max_ret % 3600 // 60;
    local v13 = math_max_ret % 60;

    if v11 > 0 then
        return string.format("%d:%02d:%02d", v11, v12, v13);
    end;

    return string.format("%02d:%02d", v12, v13);
end;

local function toColor3(p14) -- Line: 102
    if typeof(p14) == "table" and p14[1] then
        return Color3.fromRGB(p14[1], p14[2], p14[3]);
    end;

    return Color3.fromRGB(214, 158, 74);
end;

local function getTypeDef(p15) -- Line: 107
    -- upvalues: Config (ref)
    for _, v in Config.ACORN_TYPES or {} do
        if v.Name == p15 then
            return v;
        end;
    end;

    return nil;
end;

local u16 = 0;
local u17 = 0;
local u18 = false;

local function ensureShakeBound() -- Line: 120
    -- upvalues: u18 (ref), RunService (copy), u16 (ref), Config (ref), u17 (ref)
    if u18 then
        return;
    end;

    u18 = true;
    RunService:BindToRenderStep("AcornChaosShake", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 123
        -- upvalues: u16 (ref), Config (ref), u17 (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera then
            return;
        end;

        local os_clock_ret = os.clock();

        if u16 <= os_clock_ret then
            return;
        end;

        local v19 = Config and Config.SHAKE_DURATION or 0.35;
        local v20 = u17 * (v19 > 0 and (u16 - os_clock_ret) / v19 or 0);
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new((math.random() * 2 - 1) * v20 * 0.15, (math.random() * 2 - 1) * v20 * 0.15, 0) * CFrame.Angles((math.random() * 2 - 1) * math.rad(v20), (math.random() * 2 - 1) * math.rad(v20), (math.random() * 2 - 1) * math.rad(v20 * 0.5));
    end);
end;

local function doScreenShake() -- Line: 143
    -- upvalues: u18 (ref), RunService (copy), u16 (ref), Config (ref), u17 (ref)
    if not workspace.CurrentCamera then
        return;
    end;

    if not u18 then
        u18 = true;
        RunService:BindToRenderStep("AcornChaosShake", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 123
            -- upvalues: u16 (ref), Config (ref), u17 (ref)
            local workspace_CurrentCamera = workspace.CurrentCamera;

            if not workspace_CurrentCamera then
                return;
            end;

            local os_clock_ret = os.clock();

            if u16 <= os_clock_ret then
                return;
            end;

            local v21 = Config and Config.SHAKE_DURATION or 0.35;
            local v22 = u17 * (v21 > 0 and (u16 - os_clock_ret) / v21 or 0);
            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new((math.random() * 2 - 1) * v22 * 0.15, (math.random() * 2 - 1) * v22 * 0.15, 0) * CFrame.Angles((math.random() * 2 - 1) * math.rad(v22), (math.random() * 2 - 1) * math.rad(v22), (math.random() * 2 - 1) * math.rad(v22 * 0.5));
        end);
    end;

    u17 = Config and Config.SHAKE_MAGNITUDE or 1.3;
    u16 = os.clock() + (Config and Config.SHAKE_DURATION or 0.35);
end;

local u23 = false;

local function ensureJiggleBound() -- Line: 157
    -- upvalues: u23 (ref), RunService (copy), Config (ref), u4 (copy)
    if u23 then
        return;
    end;

    u23 = true;
    RunService.RenderStepped:Connect(function(p24) -- Line: 160
        -- upvalues: Config (ref), u4 (ref)
        local math_min_ret = math.min(p24, 0.03333333333333333);
        local v25 = Config and Config.JIGGLE_STIFFNESS or 180;
        local v26 = Config and Config.JIGGLE_DAMPING or 9;
        local v27 = Config and Config.JIGGLE_MAX_OFFSET or 2;

        for _, v in u4 do
            if v.jActive and v.restCFrame then
                local model = v.model;

                if model and model.Parent then
                    v.jVel = v.jVel + (v.jOffset * -v25 - v.jVel * v26) * math_min_ret;
                    v.jOffset = v.jOffset + v.jVel * math_min_ret;

                    if v27 < v.jOffset.Magnitude then
                        v.jOffset = v.jOffset.Unit * v27;
                    end;

                    if v.jOffset.Y < 0 then
                        v.jOffset = Vector3.new(v.jOffset.X, 0, v.jOffset.Z);

                        if v.jVel.Y < 0 then
                            v.jVel = Vector3.new(v.jVel.X, 0, v.jVel.Z);
                        end;
                    end;

                    if v.jOffset.Magnitude < 0.02 and v.jVel.Magnitude < 0.05 then
                        v.jOffset = Vector3.new(0, 0, 0);
                        v.jVel = Vector3.new(0, 0, 0);
                        v.jActive = false;
                        model:PivotTo(v.restCFrame);
                    else
                        model:PivotTo(CFrame.new(v.jOffset) * v.restCFrame);
                    end;
                else
                    v.jActive = false;
                end;
            end;
        end;
    end);
end;

local function cloneChildSound(p28: string) -- Line: 206
    local v29 = script:FindFirstChild(p28);

    if v29 and v29:IsA("Sound") then
        return v29:Clone();
    end;

    return nil;
end;

local function play2D(p30: string) -- Line: 215
    -- upvalues: SoundService (copy), Debris (copy)
    local v31 = script:FindFirstChild(p30);
    local u32;

    if v31 and v31:IsA("Sound") then
        u32 = v31:Clone();
    else
        u32 = nil;
    end;

    if not u32 then
        return nil;
    end;

    u32.Parent = SoundService;
    u32:Play();
    u32.Ended:Once(function() -- Line: 220
        -- upvalues: u32 (copy)
        u32:Destroy();
    end);
    Debris:AddItem(u32, 12);

    return u32;
end;

local function playTracked2D(p33: string) -- Line: 227
    -- upvalues: SoundService (copy), Debris (copy)
    local v34 = script:FindFirstChild(p33);
    local v35;

    if v34 and v34:IsA("Sound") then
        v35 = v34:Clone();
    else
        v35 = nil;
    end;

    if not v35 then
        return nil;
    end;

    v35.Parent = SoundService;
    v35:Play();
    Debris:AddItem(v35, 15);

    return v35;
end;

local function stopSound(u36: userdata?) -- Line: 237
    if u36 then
        pcall(function() -- Line: 239
            -- upvalues: u36 (copy)
            u36:Stop();
            u36:Destroy();
        end);
    end;
end;

local function playAt(p37: string, p38: vector, p39: number?) -- Line: 247
    -- upvalues: Folder (copy), Debris (copy)
    local v40 = script:FindFirstChild(p37);
    local v41;

    if v40 and v40:IsA("Sound") then
        v41 = v40:Clone();
    else
        v41 = nil;
    end;

    if not v41 then
        return;
    end;

    if p39 then
        v41.PlaybackSpeed = p39;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Position = p38;
    Part.Parent = Folder;
    v41.Parent = Part;
    v41:Play();
    v41.Ended:Once(function() -- Line: 261
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
    Debris:AddItem(Part, 12);
end;

local function fireDropCategory(p42: string) -- Line: 266
    return p42 == "Currency" and "Coins" or (p42 == "Seed" and "Seeds" or (p42 == "Seed Pack" and "SeedPack" or "Items"));
end;

local function emitAll(p43: userdata?) -- Line: 277
    if not p43 then
        return;
    end;

    for _, descendant in p43:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 12);
        end;
    end;
end;

local function hideAcornVisuals(p44: userdata) -- Line: 287
    for _, descendant in p44:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            descendant.Transparency = 1;
        elseif descendant:IsA("BillboardGui") then
            descendant.Enabled = false;
        end;
    end;
end;

local function spawnMeteorSite(p45: vector) -- Line: 301
    -- upvalues: Folder (copy), Config (ref), TweenService (copy), Debris (copy)
    local MeteorSite = script:FindFirstChild("MeteorSite");

    if not (MeteorSite and MeteorSite:IsA("BasePart")) then
        return;
    end;

    local v46 = MeteorSite:Clone();
    v46.CFrame = CFrame.new(p45);
    v46.Parent = Folder;

    for _, descendant in v46:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 10);
        end;
    end;

    local v47 = Config and Config.METEOR_SITE_LIFETIME or 3;
    local v48 = v46:FindFirstChildWhichIsA("SurfaceGui", true);

    if v48 then
        v48 = v48:FindFirstChildWhichIsA("ImageLabel");
    end;

    if v48 then
        TweenService:Create(v48, TweenInfo.new(v47), {
            ImageTransparency = 1
        }):Play();
    end;

    Debris:AddItem(v46, v47 + 0.5);
end;

local function flashRed(p49) -- Line: 322
    -- upvalues: Config (ref), TweenService (copy)
    local model = p49.model;

    if not (model and model.Parent) then
        return;
    end;

    local highlight = p49.highlight;

    if not (highlight and highlight.Parent) then
        highlight = Instance.new("Highlight");
        highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        highlight.Adornee = model;
        highlight.Parent = model;
        p49.highlight = highlight;
    end;

    local v50 = { 255, 45, 45 };

    if Config then
        v50 = Config.HIT_HIGHLIGHT_COLOR or v50;
    end;

    local v51;

    if typeof(v50) == "table" and v50[1] then
        v51 = Color3.fromRGB(v50[1], v50[2], v50[3]);
    else
        v51 = Color3.fromRGB(214, 158, 74);
    end;

    highlight.FillColor = v51;
    highlight.OutlineColor = v51;
    highlight.FillTransparency = Config and Config.HIT_HIGHLIGHT_FILL or 0.35;
    highlight.OutlineTransparency = 0;
    TweenService:Create(highlight, TweenInfo.new(Config and Config.HIT_HIGHLIGHT_TIME or 0.18), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
end;

local function refreshBar(p52) -- Line: 347
    -- upvalues: Config (ref)
    if not p52.fill then
        return;
    end;

    local v53 = p52.hp / math.max(p52.maxHp, 1);
    local math_clamp_ret = math.clamp(v53, 0, 1);
    p52.fill.Size = UDim2.fromScale(math_clamp_ret, 1);

    if p52.label then
        local label = p52.label;
        local v54 = Config and Config.PROGRESS_TEXT or "CURRENT / MAX";
        local math_ceil_ret = math.ceil(p52.hp);
        label.Text = v54:gsub("CURRENT", (tostring(math_ceil_ret))):gsub("MAX", (tostring(p52.maxHp)));
    end;
end;

local function setupBar(p55, p56) -- Line: 358
    -- upvalues: Config (ref), refreshBar (copy)
    local hitbox = p55.hitbox;

    if hitbox then
        hitbox = hitbox:FindFirstChild("Attachment");
    end;

    if hitbox then
        hitbox = hitbox:FindFirstChild("ProgressBilboard");
    end;

    if not hitbox then
        return;
    end;

    p55.billboard = hitbox;
    hitbox.Enabled = true;
    local UpgradeBar = hitbox:FindFirstChild("UpgradeBar");

    if UpgradeBar then
        p55.fill = UpgradeBar:FindFirstChild("Fill");
        p55.label = UpgradeBar:FindFirstChild("ProgressionLabel");

        if p55.fill then
            local fill = p55.fill;
            local v57 = { 88, 200, 96 };

            if Config then
                v57 = Config.PROGRESS_BAR_COLOR or v57;
            end;

            local v58;

            if typeof(v57) == "table" and v57[1] then
                v58 = Color3.fromRGB(v57[1], v57[2], v57[3]);
            else
                v58 = Color3.fromRGB(214, 158, 74);
            end;

            fill.BackgroundColor3 = v58;
        end;
    end;

    local Title = hitbox:FindFirstChild("Title");

    if Title then
        Title.Text = p55.typeName .. " Acorn";
    end;

    refreshBar(p55);
end;

local function crackAcorn(p59: string, p60: any, p61: boolean) -- Line: 382
    -- upvalues: u4 (copy), u5 (copy), Debris (copy), Config (ref), Crack (copy), play2D (copy), hideAcornVisuals (copy), emitAll (copy)
    if not u4[p59] then
        return;
    end;

    u4[p59] = nil;
    local model = p60.model;

    if model then
        u5[p59] = model:GetPivot().Position;
    end;

    local spawnSound = p60.spawnSound;

    if spawnSound then
        pcall(function() -- Line: 239
            -- upvalues: spawnSound (copy)
            spawnSound:Stop();
            spawnSound:Destroy();
        end);
    end;

    p60.spawnSound = nil;

    if p60.highlight then
        p60.highlight:Destroy();
        p60.highlight = nil;
    end;

    if p60.dirt then
        Debris:AddItem(p60.dirt, Config and Config.FINAL_HIT_TIME or 1);
        p60.dirt = nil;
    end;

    if p61 then
        Crack:FireServer(p59);
    end;

    play2D("AcornDestroyed");

    if model and model.Parent then
        hideAcornVisuals(model);
        emitAll(model:FindFirstChild("FinalHit"));
        Debris:AddItem(model, Config and Config.FINAL_HIT_TIME or 1);
    end;
end;

local function spawnAcorn(u62) -- Line: 415
    -- upvalues: u6 (ref), Config (ref), Acorns (copy), Folder (copy), u4 (copy), setupBar (copy), SoundService (copy), Debris (copy), RunService (copy), play2D (copy), u18 (ref), u16 (ref), u17 (ref), emitAll (copy), spawnMeteorSite (copy), TweenService (copy)
    if not u6 then
        return;
    end;

    local Type = u62.Type;
    local v63 = nil;

    for _, v in Config.ACORN_TYPES or {} do
        if v.Name == Type then
            v63 = v;
            break;
        end;
    end;

    if not v63 then
        return;
    end;

    local v64 = Acorns:FindFirstChild(v63.Model);

    if not v64 then
        warn((`AcornChaosController: missing acorn asset '{tostring(v63.Model)}'`));

        return;
    end;

    local u65 = v64:Clone();
    local v66 = u65:FindFirstChild("HitBox") or (u65.PrimaryPart or u65:FindFirstChildWhichIsA("BasePart"));
    local Y = u65:GetPivot().Position.Y;
    local Rotation = u65:GetPivot().Rotation;
    local u67 = Y + (Config and Config.FALL_HEIGHT or 250);
    local Dirt = u65:FindFirstChild("Dirt");
    local v68 = {};
    local Vector3_new_ret = Vector3.new(u62.X, Y, u62.Z);

    if Dirt then
        local v69 = u65:GetPivot():ToObjectSpace(Dirt:GetPivot());
        local v70 = CFrame.new(u62.X, Y, u62.Z) * Rotation * v69;
        Dirt.Parent = Folder;
        Dirt:PivotTo(v70);
        Vector3_new_ret = v70.Position;

        for _, descendant in Dirt:GetDescendants() do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                v68[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;
    end;

    local function pivotAtY(p71, p72) -- Line: 452
        -- upvalues: u65 (copy), u62 (copy), Rotation (copy)
        u65:PivotTo(CFrame.new(u62.X, p71, u62.Z) * Rotation * (p72 or CFrame.identity));
    end;

    u65:PivotTo(CFrame.new(u62.X, u67, u62.Z) * Rotation * CFrame.identity);
    u65.Parent = Folder;
    local u73 = {
        lastHit = 0,
        landed = false,
        spawnSound = nil,
        highlight = nil,
        restCFrame = nil,
        jOffset = Vector3.new(0, 0, 0),
        jVel = Vector3.new(0, 0, 0),
        jActive = false,
        model = u65,
        hitbox = v66,
        hp = v63.HP or 5,
        maxHp = v63.HP or 5,
        typeName = u62.Type,
        dirt = Dirt,
        dirtCache = v68,
        groundPos = Vector3_new_ret
    };
    u4[u62.Id] = u73;
    setupBar(u73, v63);
    local AcornSpawned = script:FindFirstChild("AcornSpawned");
    local v74;

    if AcornSpawned and AcornSpawned:IsA("Sound") then
        v74 = AcornSpawned:Clone();
    else
        v74 = nil;
    end;

    if v74 then
        v74.Parent = SoundService;
        v74:Play();
        Debris:AddItem(v74, 15);
    else
        v74 = nil;
    end;

    u73.spawnSound = v74;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    local v75 = Config and Config.REVEAL_HIGHLIGHT_COLOR or { 255, 230, 120 };
    local v76;

    if typeof(v75) == "table" and v75[1] then
        v76 = Color3.fromRGB(v75[1], v75[2], v75[3]);
    else
        v76 = Color3.fromRGB(214, 158, 74);
    end;

    Highlight.FillColor = v76;
    Highlight.OutlineColor = v76;
    Highlight.FillTransparency = Config and Config.REVEAL_HIGHLIGHT_FILL or 0.6;
    Highlight.OutlineTransparency = 0;
    Highlight.Adornee = u65;
    Highlight.Parent = u65;
    u73.highlight = Highlight;
    local math_max_ret = math.max(Config and Config.FALL_TIME or 1.4, 0.05);
    local os_clock_ret = os.clock();
    local u77 = nil;
    u77 = RunService.RenderStepped:Connect(function() -- Line: 490
        -- upvalues: u65 (copy), u4 (ref), u62 (copy), u77 (ref), os_clock_ret (copy), math_max_ret (copy), u67 (copy), Y (copy), Rotation (copy), u73 (copy), Config (ref), play2D (ref), u18 (ref), RunService (ref), u16 (ref), u17 (ref), emitAll (ref), spawnMeteorSite (ref), TweenService (ref)
        if not (u65.Parent and u4[u62.Id]) then
            u77:Disconnect();

            return;
        end;

        local v78 = (os.clock() - os_clock_ret) / math_max_ret;
        local math_clamp_ret = math.clamp(v78, 0, 1);
        u65:PivotTo(CFrame.new(u62.X, u67 + (Y - u67) * (math_clamp_ret * math_clamp_ret), u62.Z) * Rotation * CFrame.identity);

        if math_clamp_ret >= 1 then
            u77:Disconnect();

            if not u4[u62.Id] then
                return;
            end;

            u73.landed = true;
            local v79 = math.random() * 2 - 1;
            local math_rad_ret = math.rad(v79 * (Config and Config.TILT_MAX_DEG or 12));
            local v80 = CFrame.new(u62.X, Y, u62.Z) * Rotation * CFrame.Angles(0, 0, math_rad_ret);
            u65:PivotTo(v80);
            u73.restCFrame = v80;
            local spawnSound = u73.spawnSound;

            if spawnSound then
                pcall(function() -- Line: 239
                    -- upvalues: spawnSound (copy)
                    spawnSound:Stop();
                    spawnSound:Destroy();
                end);
            end;

            u73.spawnSound = nil;
            play2D("AcornLanded");

            if workspace.CurrentCamera then
                if not u18 then
                    u18 = true;
                    RunService:BindToRenderStep("AcornChaosShake", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 123
                        -- upvalues: u16 (ref), Config (ref), u17 (ref)
                        local workspace_CurrentCamera = workspace.CurrentCamera;

                        if not workspace_CurrentCamera then
                            return;
                        end;

                        local os_clock_ret2 = os.clock();

                        if u16 <= os_clock_ret2 then
                            return;
                        end;

                        local v81 = Config and Config.SHAKE_DURATION or 0.35;
                        local v82 = u17 * (v81 > 0 and (u16 - os_clock_ret2) / v81 or 0);
                        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.new((math.random() * 2 - 1) * v82 * 0.15, (math.random() * 2 - 1) * v82 * 0.15, 0) * CFrame.Angles((math.random() * 2 - 1) * math.rad(v82), (math.random() * 2 - 1) * math.rad(v82), (math.random() * 2 - 1) * math.rad(v82 * 0.5));
                    end);
                end;

                u17 = Config and Config.SHAKE_MAGNITUDE or 1.3;
                u16 = os.clock() + (Config and Config.SHAKE_DURATION or 0.35);
            end;

            emitAll(u65:FindFirstChild("AcornLand"));

            for i, v in u73.dirtCache do
                i.Transparency = v;
            end;

            spawnMeteorSite(u73.groundPos);
            task.delay(Config and Config.REVEAL_HIGHLIGHT_TIME or 10, function() -- Line: 520
                -- upvalues: u73 (ref), TweenService (ref)
                local highlight = u73.highlight;

                if highlight and highlight.Parent then
                    TweenService:Create(highlight, TweenInfo.new(0.5), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    }):Play();
                    task.delay(0.5, function() -- Line: 524
                        -- upvalues: u73 (ref), highlight (copy)
                        if u73.highlight == highlight then
                            highlight:Destroy();
                            u73.highlight = nil;
                        end;
                    end);
                end;
            end);
        end;
    end);
end;

local function clearAll() -- Line: 539
    -- upvalues: u4 (copy)
    for i, v in u4 do
        u4[i] = nil;
        local spawnSound = v.spawnSound;

        if spawnSound then
            pcall(function() -- Line: 239
                -- upvalues: spawnSound (copy)
                spawnSound:Stop();
                spawnSound:Destroy();
            end);
        end;

        if v.dirt then
            v.dirt:Destroy();
        end;

        if v.model then
            v.model:Destroy();
        end;
    end;

    table.clear(u4);
end;

local function isStormActive() -- Line: 552
    -- upvalues: Config (ref)
    return workspace:GetAttribute(Config and Config.WORKSPACE_ACTIVE or "AcornChaosActive") == true;
end;

local function findNearestAcorn(p83: vector) -- Line: 562
    -- upvalues: Config (ref), u4 (copy)
    local v84 = Config and Config.HIT_RANGE or 16;
    local v85 = (1 / 0);
    local v86 = nil;
    local v87 = nil;

    for i, v in u4 do
        if v.landed and (v.model and v.model.Parent) then
            local Magnitude = (v.model:GetPivot().Position - p83).Magnitude;

            if Magnitude <= v84 and Magnitude < v85 then
                v87 = i;
                v86 = v;
                v85 = Magnitude;
            end;
        end;
    end;

    return v86, v87;
end;

local function onShovelSwing() -- Line: 577
    -- upvalues: Config (ref), LocalPlayer (copy), findNearestAcorn (copy), refreshBar (copy), playAt (copy), flashRed (copy), emitAll (copy), u23 (ref), RunService (copy), u4 (copy), crackAcorn (copy)
    if workspace:GetAttribute(Config and Config.WORKSPACE_ACTIVE or "AcornChaosActive") ~= true then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local v88, v89 = findNearestAcorn(Character.Position);

    if not v88 then
        return;
    end;

    local os_clock_ret = os.clock();

    if os_clock_ret - v88.lastHit < (Config and Config.HIT_DEBOUNCE or 0.15) then
        return;
    end;

    v88.lastHit = os_clock_ret;
    v88.hp = v88.hp - (Config and Config.DAMAGE_PER_HIT or 1);
    refreshBar(v88);
    local v90 = 1 + (math.random() * 2 - 1) * (Config and Config.HIT_PITCH_VARIATION or 0.1);
    playAt("AcornHit", v88.model:GetPivot().Position, v90);
    flashRed(v88);

    if v88.hp > 0 then
        emitAll(v88.model:FindFirstChild("Hit"));
    end;

    if v88.restCFrame then
        local v91 = v88.model:GetPivot().Position - Character.Position;
        local Vector3_new_ret = Vector3.new(v91.X, 0, v91.Z);

        if Vector3_new_ret.Magnitude < 0.05 then
            local LookVector = v88.restCFrame.LookVector;
            Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);
        end;

        v88.jVel = v88.jVel + ((Vector3_new_ret.Magnitude < 0.05 and Vector3.new(0, 0, 1) or Vector3_new_ret).Unit * (Config and Config.JIGGLE_IMPULSE or 14) + Vector3.new(0, Config and Config.JIGGLE_BOUNCE or 14, 0));
        v88.jActive = true;

        if not u23 then
            u23 = true;
            RunService.RenderStepped:Connect(function(p92) -- Line: 160
                -- upvalues: Config (ref), u4 (ref)
                local math_min_ret = math.min(p92, 0.03333333333333333);
                local v93 = Config and Config.JIGGLE_STIFFNESS or 180;
                local v94 = Config and Config.JIGGLE_DAMPING or 9;
                local v95 = Config and Config.JIGGLE_MAX_OFFSET or 2;

                for _, v in u4 do
                    if v.jActive and v.restCFrame then
                        local model = v.model;

                        if model and model.Parent then
                            v.jVel = v.jVel + (v.jOffset * -v93 - v.jVel * v94) * math_min_ret;
                            v.jOffset = v.jOffset + v.jVel * math_min_ret;

                            if v95 < v.jOffset.Magnitude then
                                v.jOffset = v.jOffset.Unit * v95;
                            end;

                            if v.jOffset.Y < 0 then
                                v.jOffset = Vector3.new(v.jOffset.X, 0, v.jOffset.Z);

                                if v.jVel.Y < 0 then
                                    v.jVel = Vector3.new(v.jVel.X, 0, v.jVel.Z);
                                end;
                            end;

                            if v.jOffset.Magnitude < 0.02 and v.jVel.Magnitude < 0.05 then
                                v.jOffset = Vector3.new(0, 0, 0);
                                v.jVel = Vector3.new(0, 0, 0);
                                v.jActive = false;
                                model:PivotTo(v.restCFrame);
                            else
                                model:PivotTo(CFrame.new(v.jOffset) * v.restCFrame);
                            end;
                        else
                            v.jActive = false;
                        end;
                    end;
                end;
            end);
        end;
    end;

    if v88.hp <= 0 then
        crackAcorn(v89, v88, true);
    end;
end;

local u96 = {};

local function hookTool(u97: userdata) -- Line: 630
    -- upvalues: u96 (copy), onShovelSwing (copy), u1 (copy)
    if not u97:IsA("Tool") then
        return;
    end;

    if u97.Name ~= "Shovel [Destroy Plants]" then
        return;
    end;

    if u96[u97] then
        return;
    end;

    local v98 = u97.Activated:Connect(onShovelSwing);
    u96[u97] = v98;
    u1:Add(v98);
    u1:Add(u97.Destroying:Once(function() -- Line: 637
        -- upvalues: u96 (ref), u97 (copy)
        u96[u97] = nil;
    end));
end;

local function hookCharacter(p99: userdata) -- Line: 640
    -- upvalues: hookTool (copy), u1 (copy)
    for _, child in p99:GetChildren() do
        hookTool(child);
    end;

    u1:Add(p99.ChildAdded:Connect(hookTool));
end;

local u100 = nil;

local function getIndexModules() -- Line: 650
    -- upvalues: u100 (ref), ReplicatedStorage (copy)
    if u100 then
        return u100;
    end;

    local success2, result2 = pcall(function() -- Line: 652
        -- upvalues: ReplicatedStorage (ref)
        return {
            Gui = require(ReplicatedStorage.Modules.GuiController),
            ImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder),
            InfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover),
            FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated),
            EggOdds = require(ReplicatedStorage.Modules.PetEggOddsController),
            SeedPackOdds = require(ReplicatedStorage.Modules.SeedPackOddsController),
            CrateOdds = require(ReplicatedStorage.Modules.CosmeticCrateOddsController)
        };
    end);

    if success2 then
        u100 = result2;
    end;

    return u100;
end;

local u101 = {};
local u102 = {};
local u103 = nil;
local u104 = false;

local function openIndexPage(p105: string) -- Line: 672
    -- upvalues: u102 (copy)
    for i, v in u102 do
        v.Visible = i == p105;
    end;
end;

local function addButtonSFX(p106: userdata) -- Line: 679
    -- upvalues: SoundService (copy), UserInputService (copy)
    local Hover = SoundService:FindFirstChild("Hover");
    local Click = SoundService:FindFirstChild("Click");

    if Hover and not UserInputService.TouchEnabled then
        p106.MouseEnter:Connect(function() -- Line: 683
            -- upvalues: Hover (copy)
            Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Hover.TimePosition = 0;
            Hover.Playing = true;
        end);
    end;

    if Click then
        p106.Activated:Connect(function() -- Line: 690
            -- upvalues: Click (copy)
            Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Click.TimePosition = 0;
            Click.Playing = true;
        end);
    end;
end;

local function buildRewardIndex() -- Line: 699
    -- upvalues: u100 (ref), ReplicatedStorage (copy), Config (ref), LocalPlayer (copy), u103 (ref), u101 (copy), u102 (copy), addButtonSFX (copy), u104 (ref), RunService (copy)
    local u107;

    if u100 then
        u107 = u100;
    else
        local success2, result2 = pcall(function() -- Line: 652
            -- upvalues: ReplicatedStorage (ref)
            return {
                Gui = require(ReplicatedStorage.Modules.GuiController),
                ImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder),
                InfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover),
                FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated),
                EggOdds = require(ReplicatedStorage.Modules.PetEggOddsController),
                SeedPackOdds = require(ReplicatedStorage.Modules.SeedPackOddsController),
                CrateOdds = require(ReplicatedStorage.Modules.CosmeticCrateOddsController)
            };
        end);

        if success2 then
            u100 = result2;
        end;

        u107 = u100;
    end;

    if not u107 then
        return;
    end;

    local v108 = Config and Config.ACORN_TYPES or {};

    if #v108 == 0 then
        return;
    end;

    local AcornChaosIndex = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("AcornChaosIndex");

    if not AcornChaosIndex then
        return;
    end;

    local EggIndex = AcornChaosIndex:FindFirstChild("EggIndex");

    if not EggIndex then
        return;
    end;

    local Main = EggIndex.Main;

    if not u103 then
        local ItemTemplate = Main.ScrollingFrame:FindFirstChild("ItemTemplate");
        local PageTemplate = Main:FindFirstChild("PageTemplate");
        local v109;

        if PageTemplate then
            v109 = PageTemplate.ScrollingFrame:FindFirstChild("ItemTemplate");
        else
            v109 = PageTemplate;
        end;

        if not (ItemTemplate and (PageTemplate and v109)) then
            return;
        end;

        ItemTemplate.Parent = nil;
        v109.Parent = nil;
        PageTemplate.Parent = nil;
        u103 = {
            Tab = ItemTemplate,
            Reward = v109,
            Page = PageTemplate
        };
    end;

    for _, child in Main.ScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    for _, child in Main:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "ScrollingFrame" then
            child:Destroy();
        end;
    end;

    table.clear(u101);
    table.clear(u102);

    for i, v in v108 do
        local v110 = v.Rewards or {};
        local v111 = u103.Tab:Clone();
        v111.EggName.Text = v.Name .. " Acorn";
        v111.LayoutOrder = #v108 - i;

        if v.Icon and v111:FindFirstChild("Icon") then
            v111.Icon.Image = v.Icon;
        end;

        if v.Name == "Gold" then
            u101[v111.OuterStroke.UIGradient] = true;
            v111.OuterStroke.UIGradient.Enabled = true;
            v111.OuterStroke.Color = Color3.fromRGB(255, 255, 255);

            if v111.Details:FindFirstChild("InnerGlow") then
                v111.Details.InnerGlow.Visible = false;
            end;

            v111.UIGradient.Enabled = true;
            v111.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        end;

        v111.Parent = Main.ScrollingFrame;
        v111.SENSOR.Activated:Connect(function() -- Line: 752
            -- upvalues: v (copy), u102 (ref)
            local Name = v.Name;

            for i2, v2 in u102 do
                v2.Visible = i2 == Name;
            end;
        end);
        addButtonSFX(v111.SENSOR);
        local v112 = u103.Page:Clone();
        v112.Name = v.Name;
        v112.Title.Text = `{v.Name} Acorn Reward{#v110 == 1 and "" or "s"}`;
        local v113 = v;
        local v114 = 0;

        for _, v2 in v110 do
            v114 = v114 + 1;
            local v115 = u103.Reward:Clone();
            v115.EntryName.Text = v2.Display or v2.Value;
            v115.Quantity.Text = (v2.Quantity or 1) > 1 and (`x{u107.FormatAbbreviated(v2.Quantity)}` or "") or "";
            local success2, result2 = pcall(u107.ImageFinder, v2.Value, v2.Type);

            if success2 and result2 then
                v115.Icon.Image = result2;
            end;

            local v116;

            if v2.RainbowInterface then
                v116 = v114 + 999 or v114;
            else
                v116 = v114;
            end;

            v115.LayoutOrder = v116;

            if v2.RainbowInterface then
                u101[v115.UIStroke.UIGradient] = true;
                v115.UIStroke.UIGradient.Enabled = true;
                v115.UIStroke.Color = Color3.fromRGB(255, 255, 255);

                if v115.Details:FindFirstChild("InnerGlow") then
                    v115.Details.InnerGlow.Visible = false;
                end;

                v115.UIGradient.Enabled = true;
                v115.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            end;

            local OddsButton = v115.OddsButton;

            if v2.Type == "Seed Pack" then
                OddsButton.Visible = true;
                OddsButton.Activated:Connect(function() -- Line: 783
                    -- upvalues: u107 (copy), v2 (copy), AcornChaosIndex (copy)
                    u107.SeedPackOdds:Open(v2.Value, AcornChaosIndex);
                end);
            elseif v2.Type == "Egg" then
                OddsButton.Visible = true;
                OddsButton.Activated:Connect(function() -- Line: 786
                    -- upvalues: u107 (copy), v2 (copy), AcornChaosIndex (copy)
                    u107.EggOdds:Open(v2.Value, AcornChaosIndex);
                end);
            elseif v2.Type == "Crate" then
                OddsButton.Visible = true;
                OddsButton.Activated:Connect(function() -- Line: 789
                    -- upvalues: u107 (copy), v2 (copy), AcornChaosIndex (copy)
                    u107.CrateOdds:Open(v2.Value, AcornChaosIndex);
                end);
            else
                OddsButton.Visible = false;
            end;

            if OddsButton.Visible then
                addButtonSFX(OddsButton);
            end;

            local u117 = `AcornChaosReward_{v113.Name}_{v2.Type}_{v2.Value}`;
            pcall(function() -- Line: 797
                -- upvalues: u107 (copy), u117 (copy), v2 (copy)
                u107.InfoHover:AddItemFromRewardWithQuantity(u117, {
                    Value = v2.Value,
                    Type = v2.Type,
                    Quantity = v2.Quantity or 1
                });
            end);
            v115:SetAttribute("UUID", u117);
            v115:AddTag("ItemInfoHoverTag");
            v115.Parent = v112.ScrollingFrame;
        end;

        u102[v113.Name] = v112;
        v112.Parent = Main;
    end;

    if v108[#v108] then
        local Name = v108[#v108].Name;

        for i, v in u102 do
            v.Visible = i == Name;
        end;
    end;

    if not u104 then
        u104 = true;
        EggIndex.Header.Close.Activated:Connect(function() -- Line: 818
            -- upvalues: u107 (copy), AcornChaosIndex (copy)
            u107.Gui:Close(AcornChaosIndex);
        end);
        RunService.Heartbeat:Connect(function(p118: number) -- Line: 821
            -- upvalues: u101 (ref)
            for i in u101 do
                i.Rotation = (i.Rotation + p118 * 30) % 360;
            end;
        end);
    end;
end;

function u2.Start(p119) -- Line: 829
    -- upvalues: u6 (ref), u96 (copy), u1 (copy), Start (copy), play2D (copy), Config (ref), spawnAcorn (copy), Reward (copy), u5 (copy), FireDropBindable (copy), LocalPlayer (copy), clearAll (copy), u3 (ref), hookCharacter (copy), buildRewardIndex (copy), CollectionService (copy), ReplicatedStorage (copy), GlobalUpdateTime (copy)
    u6 = true;
    table.clear(u96);
    u1:Add(Start.OnClientEvent:Connect(function(p120) -- Line: 833
        -- upvalues: play2D (ref), u6 (ref), Config (ref), spawnAcorn (ref)
        if typeof(p120) ~= "table" then
            return;
        end;

        play2D("AcornStartup");
        local v121 = true;

        for _, v in p120 do
            if not u6 or workspace:GetAttribute(Config and Config.WORKSPACE_ACTIVE or "AcornChaosActive") ~= true then
                break;
            end;

            if not v121 then
                task.wait(Config and Config.DROP_DELAY or 2);
            end;

            v121 = false;

            if v and (v.Id and v.Type) then
                spawnAcorn(v);
            end;
        end;
    end));
    u1:Add(Reward.OnClientEvent:Connect(function(p122) -- Line: 850
        -- upvalues: u5 (ref), FireDropBindable (ref), LocalPlayer (ref)
        if typeof(p122) ~= "table" then
            return;
        end;

        local Id = p122.Id;
        local Reward2 = p122.Reward;
        local v123;

        if Id then
            v123 = u5[Id] or nil;
        else
            v123 = nil;
        end;

        if Id then
            u5[Id] = nil;
        end;

        if FireDropBindable and Reward2 then
            local u124 = nil;

            if v123 then
                u124 = CFrame.new(v123);
            elseif LocalPlayer.Character then
                u124 = LocalPlayer.Character:GetPivot();
            end;

            if u124 then
                pcall(function() -- Line: 866
                    -- upvalues: FireDropBindable (ref), LocalPlayer (ref), Reward2 (copy), u124 (ref)
                    local v125 = {
                        Owner = LocalPlayer.Name
                    };
                    local Type = Reward2.Type;
                    v125.RewardType = Type == "Currency" and "Coins" or (Type == "Seed" and "Seeds" or (Type == "Seed Pack" and "SeedPack" or "Items"));
                    v125.GearName = Reward2.Value;
                    v125.KeySeed = Reward2.Value;
                    FireDropBindable:Fire(v125, u124);
                end);
            end;
        end;
    end));
    u1:Add(workspace:GetAttributeChangedSignal(Config and Config.WORKSPACE_ACTIVE or "AcornChaosActive"):Connect(function() -- Line: 878
        -- upvalues: Config (ref), clearAll (ref), u3 (ref)
        if workspace:GetAttribute(Config and Config.WORKSPACE_ACTIVE or "AcornChaosActive") ~= true then
            clearAll();

            if u3 then
                pcall(function() -- Line: 882
                    -- upvalues: u3 (ref), Config (ref)
                    u3:CreateNotification(Config and Config.MSG_ENDED or "The acorns have vanished...");
                end);
            end;
        end;
    end));

    if LocalPlayer.Character then
        hookCharacter(LocalPlayer.Character);
    end;

    u1:Add(LocalPlayer.CharacterAdded:Connect(hookCharacter));
    u1:Add(task.spawn(function() -- Line: 891
        -- upvalues: buildRewardIndex (ref)
        pcall(buildRewardIndex);
    end));
    u1:Add(workspace:GetAttributeChangedSignal("AcornChaosConfig"):Connect(function() -- Line: 892
        -- upvalues: buildRewardIndex (ref)
        task.spawn(function() -- Line: 893
            -- upvalues: buildRewardIndex (ref)
            pcall(buildRewardIndex);
        end);
    end));
    u1:Add(task.spawn(function() -- Line: 899
        -- upvalues: CollectionService (ref), Config (ref), ReplicatedStorage (ref), GlobalUpdateTime (ref)
        local v126 = CollectionService:GetTagged(Config and Config.MODEL_TAG or "AcornChaosModel")[1];
        local v127 = 0;

        while not v126 and v127 < 30 do
            task.wait(1);
            v127 = v127 + 1;
            v126 = CollectionService:GetTagged(Config and Config.MODEL_TAG or "AcornChaosModel")[1];
        end;

        if not v126 then
            return;
        end;

        local TimeLeft = v126:WaitForChild("TimeLeft", 30);

        if TimeLeft then
            TimeLeft = TimeLeft:WaitForChild("BillboardGui", 30);
        end;

        local v128;

        if TimeLeft then
            v128 = TimeLeft:WaitForChild("Holder", 30);
        else
            v128 = TimeLeft;
        end;

        if not v128 then
            return;
        end;

        local Timer = v128:WaitForChild("Timer", 30);
        local Title = v128:FindFirstChild("Title");

        if not Timer then
            return;
        end;

        TimeLeft.Enabled = true;

        while true do
            local Attribute = workspace:GetAttribute(Config and Config.WORKSPACE_ENDS_AT or "AcornChaosEndsAt");
            local ServerTimeNow = workspace:GetServerTimeNow();
            local v129, v130;

            if typeof(Attribute) == "number" and ServerTimeNow < Attribute then
                v129 = Config and Config.TITLE_ACTIVE or "ACORN CHAOS!";
                v130 = Attribute - ServerTimeNow;
            else
                local v131 = Config and Config.INTERVAL or 1800;
                local success2, result2 = pcall(function() -- Line: 926
                    -- upvalues: ReplicatedStorage (ref)
                    return require(ReplicatedStorage.Modules.IsDev)();
                end);
                local v132 = success2 and result2 and (Config and Config.DEV_INTERVAL or 120) or v131;
                local v133 = Config and Config.START_EPOCH or 0;
                local v134 = v133 == -1 and (tonumber(GlobalUpdateTime.Value) or 0) or v133;

                if v134 <= 0 or ServerTimeNow >= v134 then
                    v134 = v134 + (math.floor((ServerTimeNow - v134) / v132) + 1) * v132;
                end;

                v129 = Config and Config.TITLE_IDLE or "Next Acorn Storm";
                v130 = v134 - ServerTimeNow;
            end;

            if Title then
                Title.Text = v129;
            end;

            local math_floor_ret = math.floor(v130);
            local math_max_ret = math.max(math_floor_ret, 0);
            local v135 = math_max_ret // 3600;
            local v136 = math_max_ret % 3600 // 60;
            local v137 = math_max_ret % 60;
            local v138;

            if v135 > 0 then
                v138 = string.format("%d:%02d:%02d", v135, v136, v137);
            else
                v138 = string.format("%02d:%02d", v136, v137);
            end;

            Timer.Text = v138;
            task.wait(1);
        end;
    end));
end;

EventRotationClientBinder:Bind({
    EventSet = "FallMarketEvent",
    MinPartIndex = 2,
    Script = script,

    OnStart = function() -- Line: 953, Name: OnStart
        -- upvalues: u2 (copy)
        task.spawn(u2.Start, u2);
    end,

    OnStop = function() -- Line: 954, Name: OnStop
        -- upvalues: u6 (ref), u1 (copy), clearAll (copy), u5 (copy)
        u6 = false;
        u1:Clean();
        clearAll();
        table.clear(u5);
    end
});

return u2;