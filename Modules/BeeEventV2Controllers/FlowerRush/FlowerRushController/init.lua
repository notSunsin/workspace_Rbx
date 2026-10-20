-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local v1 = {};

if not RunService:IsClient() then
    return v1;
end;

local success, result = pcall(function() -- Line: 29
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.IsInTradeWorld);
end);

if success and result then
    return v1;
end;

local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("FlowerRushConfig");
workspace:GetAttributeChangedSignal("FlowerRushConfig"):Connect(function() -- Line: 37
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("FlowerRushConfig");
end);
local u2 = nil;
pcall(function() -- Line: 42
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    u2 = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
end);
local FlowerRush = workspace:WaitForChild("FlowerRush");
local Folder = Instance.new("Folder");
Folder.Name = "FlowerRushHidden";
local Folder2 = Instance.new("Folder");
Folder2.Name = "FlowerRushFX";
Folder2.Parent = workspace;

local function attr(p3: string, p4: any) -- Line: 59
    -- upvalues: Config (ref)
    local v5 = Config and Config[p3];

    if v5 == nil then
        return p4;
    end;

    return v5;
end;

local function toColor3(p6: any, p7) -- Line: 65
    if typeof(p6) == "table" and p6[1] then
        return Color3.fromRGB(p6[1], p6[2], p6[3]);
    end;

    return p7;
end;

local function inBeeGarden() -- Line: 70
    -- upvalues: u2 (ref)
    if not u2 then
        return false;
    end;

    local success2, result2 = pcall(function() -- Line: 72
        -- upvalues: u2 (ref)
        return u2:GetCurrentSaveSlot();
    end);

    if success2 then
        if typeof(result2) == "table" then
            success2 = result2.IsBeeSlot == true;
        else
            success2 = false;
        end;
    end;

    return success2;
end;

local function playAt(p8: string, p9: vector) -- Line: 81
    -- upvalues: Folder2 (copy), Debris (copy)
    local v10 = script:FindFirstChild(p8);

    if not (v10 and v10:IsA("Sound")) then
        return;
    end;

    local v11 = v10:Clone();
    v11.PlaybackSpeed = v11.PlaybackSpeed * (1 + (math.random() * 2 - 1) * 0.08);
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Position = p9;
    Part.Parent = Folder2;
    v11.Parent = Part;
    v11:Play();
    v11.Ended:Once(function() -- Line: 97
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
    Debris:AddItem(Part, 12);
end;

local function play2D(p12: string) -- Line: 102
    -- upvalues: SoundService (copy), Debris (copy)
    local v13 = script:FindFirstChild(p12);

    if not (v13 and v13:IsA("Sound")) then
        return;
    end;

    local u14 = v13:Clone();
    u14.Parent = SoundService;
    u14:Play();
    u14.Ended:Once(function() -- Line: 108
        -- upvalues: u14 (copy)
        u14:Destroy();
    end);
    Debris:AddItem(u14, 12);
end;

local function emitAll(p15: userdata?) -- Line: 116
    if not p15 then
        return;
    end;

    for _, descendant in p15:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 12);
        end;
    end;
end;

local u16 = {};
local u17 = nil;
local u18 = {};
local u19 = false;

local function getPosition(p20: table) -- Line: 147
    local HitBox = p20.Model:FindFirstChild("HitBox");

    return HitBox and (HitBox:IsA("BasePart") and HitBox.Position) or p20.RestCFrame.Position;
end;

local function settle(p21: table) -- Line: 152
    p21.JiggleStart = nil;

    if p21.Model.Parent then
        p21.Model:PivotTo(p21.RestCFrame);
    end;
end;

local function untrack(p22: userdata) -- Line: 157
    -- upvalues: u16 (copy)
    local v23 = u16[p22];

    if not v23 then
        return;
    end;

    u16[p22] = nil;

    for _, v in v23.Connections do
        v:Disconnect();
    end;
end;

local function placeItem(p24: userdata) -- Line: 168
    -- upvalues: Folder (copy), u19 (ref), FlowerRush (copy)
    if not p24:IsDescendantOf(game) and p24.Parent ~= Folder then
        return;
    end;

    local v25;

    if u19 then
        v25 = FlowerRush;
    else
        v25 = Folder;
    end;

    if p24.Parent ~= v25 then
        p24.Parent = v25;
    end;
end;

local function refreshVisibility() -- Line: 178
    -- upvalues: u2 (ref), u19 (ref), u18 (copy), Folder (copy), FlowerRush (copy), u16 (copy)
    local v26;

    if u2 then
        local v27;
        v26, v27 = pcall(function() -- Line: 72
            -- upvalues: u2 (ref)
            return u2:GetCurrentSaveSlot();
        end);

        if v26 then
            if typeof(v27) == "table" then
                v26 = v27.IsBeeSlot == true;
            else
                v26 = false;
            end;
        end;
    else
        v26 = false;
    end;

    if v26 == u19 then
        return;
    end;

    u19 = v26;

    for i in u18 do
        if i:IsDescendantOf(game) or i.Parent == Folder then
            local v28;

            if u19 then
                v28 = FlowerRush;
            else
                v28 = Folder;
            end;

            if i.Parent ~= v28 then
                i.Parent = v28;
            end;
        end;
    end;

    if not u19 then
        for _, v in u16 do
            v.JiggleStart = nil;

            if v.Model.Parent then
                v.Model:PivotTo(v.RestCFrame);
            end;
        end;
    end;
end;

local function startJiggle(p29: table) -- Line: 193
    local v30 = math.random() * 3.141592653589793 * 2;
    local math_cos_ret = math.cos(v30);
    local math_sin_ret = math.sin(v30);
    p29.JiggleAxis = Vector3.new(math_cos_ret, 0, math_sin_ret);
    p29.JiggleStart = os.clock();
end;

RunService.RenderStepped:Connect(function() -- Line: 199
    -- upvalues: u16 (copy), FlowerRush (copy), Config (ref)
    for _, v in u16 do
        if v.JiggleStart and v.Model.Parent == FlowerRush then
            local v31 = os.clock() - v.JiggleStart;
            local v32 = Config and Config.JIGGLE_DURATION;

            if (v32 == nil and 0.6 or v32) <= v31 then
                v.JiggleStart = nil;

                if v.Model.Parent then
                    v.Model:PivotTo(v.RestCFrame);
                end;
            else
                local v33 = Config and Config.JIGGLE_DECAY;
                local math_exp_ret = math.exp(-v31 * (v33 == nil and 7 or v33));
                local v34 = Config and Config.JIGGLE_FREQUENCY;
                local math_sin_ret = math.sin(v31 * (v34 == nil and 14 or v34));
                local v35 = Config and Config.JIGGLE_TILT_DEG;
                local v36 = math.rad(v35 == nil and 7 or v35) * math_sin_ret * math_exp_ret;
                local v37 = Config and Config.JIGGLE_POP;
                local v38 = (v37 == nil and 0.35 or v37) * math.abs(math_sin_ret) * math_exp_ret;
                local BasePoint = v.BasePoint;
                v.Model:PivotTo(CFrame.new(BasePoint + Vector3.new(0, v38, 0)) * CFrame.fromAxisAngle(v.JiggleAxis, v36) * CFrame.new(-BasePoint) * v.RestCFrame);
            end;
        end;
    end;
end);

local function onProgressChanged(p39: table) -- Line: 228
    -- upvalues: u19 (ref), playAt (copy), Config (ref), emitAll (copy)
    local Attribute = p39.Model:GetAttribute("Progress");

    if typeof(Attribute) ~= "number" then
        return;
    end;

    local v40 = p39.LastProgress < Attribute;
    local v41 = math.floor(Attribute) > math.floor(p39.LastProgress);
    p39.LastProgress = Attribute;

    if not (v40 and (u19 and p39.Model:GetAttribute("State") == "Active")) then
        return;
    end;

    if v41 then
        local HitBox = p39.Model:FindFirstChild("HitBox");
        playAt("Pollinated", HitBox and (HitBox:IsA("BasePart") and HitBox.Position) or p39.RestCFrame.Position);
    end;

    local v42 = math.random() * 3.141592653589793 * 2;
    local math_cos_ret = math.cos(v42);
    local math_sin_ret = math.sin(v42);
    p39.JiggleAxis = Vector3.new(math_cos_ret, 0, math_sin_ret);
    p39.JiggleStart = os.clock();
    local os_clock_ret = os.clock();
    local v43 = Config and Config.HIT_VFX_INTERVAL;

    if (v43 == nil and 0.35 or v43) <= os_clock_ret - p39.LastHitVfx then
        p39.LastHitVfx = os_clock_ret;
        emitAll(p39.Model:FindFirstChild("Hit"));
    end;
end;

local function onStateChanged(p44: table) -- Line: 251
    -- upvalues: u19 (ref), emitAll (copy), playAt (copy), u17 (ref)
    local Attribute = p44.Model:GetAttribute("State");

    if Attribute == "Active" then
        return;
    end;

    p44.JiggleStart = nil;

    if p44.Model.Parent then
        p44.Model:PivotTo(p44.RestCFrame);
    end;

    if not u19 then
        return;
    end;

    if Attribute ~= "Pollinated" then
        if Attribute == "Wilted" then
            local HitBox = p44.Model:FindFirstChild("HitBox");
            playAt("FlowerWilted", HitBox and (HitBox:IsA("BasePart") and HitBox.Position) or p44.RestCFrame.Position);
        end;

        return;
    end;

    emitAll(p44.Model:FindFirstChild("FinalHit"));
    local HitBox = p44.Model:FindFirstChild("HitBox");
    playAt("Finished", HitBox and (HitBox:IsA("BasePart") and HitBox.Position) or p44.RestCFrame.Position);
    local v45 = {};
    local HitBox2 = p44.Model:FindFirstChild("HitBox");
    v45.Position = HitBox2 and (HitBox2:IsA("BasePart") and HitBox2.Position) or p44.RestCFrame.Position;
    v45.At = os.clock();
    u17 = v45;
end;

local function playSpawnEffects(p46: table) -- Line: 269
    -- upvalues: emitAll (copy), playAt (copy), Config (ref), TweenService (copy), Debris (copy)
    local Model = p46.Model;
    emitAll(Model:FindFirstChild("Spawned"));
    local HitBox = p46.Model:FindFirstChild("HitBox");
    playAt("FlowerSpawned", HitBox and (HitBox:IsA("BasePart") and HitBox.Position) or p46.RestCFrame.Position);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    local v47 = Config and Config.REVEAL_HIGHLIGHT_COLOR;

    if v47 == nil then
        v47 = nil;
    end;

    local Color3_fromRGB_ret = Color3.fromRGB(255, 230, 120);

    if typeof(v47) == "table" and v47[1] then
        Color3_fromRGB_ret = Color3.fromRGB(v47[1], v47[2], v47[3]);
    end;

    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.OutlineColor = Color3_fromRGB_ret;
    local v48 = Config and Config.REVEAL_HIGHLIGHT_FILL;
    Highlight.FillTransparency = v48 == nil and 0.6 or v48;
    Highlight.OutlineTransparency = 0;
    Highlight.Adornee = Model;
    Highlight.Parent = Model;
    local v49 = Config and Config.REVEAL_HIGHLIGHT_TIME;
    task.delay(v49 == nil and 8 or v49, function() -- Line: 286
        -- upvalues: Highlight (copy), TweenService (ref), Debris (ref)
        if not Highlight.Parent then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.5), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
        Debris:AddItem(Highlight, 0.6);
    end);
end;

local function onWorldChild(u50: userdata) -- Line: 293
    -- upvalues: u18 (copy), u16 (copy), onProgressChanged (copy), onStateChanged (copy), u19 (ref), playSpawnEffects (copy), Folder (copy), FlowerRush (copy)
    if u18[u50] then
        return;
    end;

    local u51 = u50:IsA("Model") and u50:GetAttribute("FlowerRushId") ~= nil;

    if not u51 and u50:GetAttribute("FlowerRushDirtFor") == nil then
        return;
    end;

    u18[u50] = true;
    u50.Destroying:Once(function() -- Line: 301
        -- upvalues: u18 (ref), u50 (copy), u51 (copy), u16 (ref)
        u18[u50] = nil;

        if u51 then
            local v52 = u50;
            local v53 = u16[v52];

            if not v53 then
                return;
            end;

            u16[v52] = nil;

            for _, v in v53.Connections do
                v:Disconnect();
            end;
        end;
    end);

    if u51 then
        local Pivot = u50:GetPivot();
        local BoundingBox, v54 = u50:GetBoundingBox();
        local u55 = {
            LastHitVfx = 0,
            JiggleStart = nil,
            JiggleAxis = Vector3.new(1, 0, 0),
            Model = u50,
            RestCFrame = Pivot,
            BasePoint = Vector3.new(Pivot.Position.X, BoundingBox.Position.Y - v54.Y / 2, Pivot.Position.Z),
            LastProgress = tonumber(u50:GetAttribute("Progress")) or 0,
            Connections = {}
        };
        u16[u50] = u55;
        local Connections = u55.Connections;
        local AttributeChangedSignal = u50:GetAttributeChangedSignal("Progress");
        table.insert(Connections, AttributeChangedSignal:Connect(function() -- Line: 321
            -- upvalues: onProgressChanged (ref), u55 (copy)
            onProgressChanged(u55);
        end));
        local Connections2 = u55.Connections;
        local AttributeChangedSignal2 = u50:GetAttributeChangedSignal("State");
        table.insert(Connections2, AttributeChangedSignal2:Connect(function() -- Line: 324
            -- upvalues: onStateChanged (ref), u55 (copy)
            onStateChanged(u55);
        end));
        local v56 = tonumber(u50:GetAttribute("SpawnedAt")) or 0;

        if u19 and (u50:GetAttribute("State") == "Active" and workspace:GetServerTimeNow() - v56 < 3) then
            playSpawnEffects(u55);
        end;
    end;

    if not u50:IsDescendantOf(game) and u50.Parent ~= Folder then
        return;
    end;

    local v57;

    if u19 then
        v57 = FlowerRush;
    else
        v57 = Folder;
    end;

    if u50.Parent ~= v57 then
        u50.Parent = v57;
    end;
end;

function v1.Start(p58) -- Line: 342
    -- upvalues: u19 (ref), u2 (ref), ReplicatedStorage (copy), u17 (ref), Config (ref), play2D (copy), FlowerRush (copy), onWorldChild (copy), refreshVisibility (copy)
    local v59;

    if u2 then
        local v60;
        v59, v60 = pcall(function() -- Line: 72
            -- upvalues: u2 (ref)
            return u2:GetCurrentSaveSlot();
        end);

        if v59 then
            if typeof(v60) == "table" then
                v59 = v60.IsBeeSlot == true;
            else
                v59 = false;
            end;
        end;
    else
        v59 = false;
    end;

    u19 = v59;
    local FireDrop = ReplicatedStorage:WaitForChild("GameEvents"):FindFirstChild("FireDrop");

    if FireDrop then
        FireDrop.OnClientEvent:Connect(function(p61, p62) -- Line: 351
            -- upvalues: u17 (ref), Config (ref), play2D (ref)
            local v63 = u17;

            if not v63 or typeof(p62) ~= "CFrame" then
                return;
            end;

            if os.clock() - v63.At > 5 then
                return;
            end;

            local v64 = p62.Position - v63.Position;

            if v64.X * v64.X + v64.Z * v64.Z > 100 then
                return;
            end;

            u17 = nil;
            local v65 = Config and Config.REWARD_DROP_FLIGHT_TIME;
            task.delay(v65 == nil and 0.5 or v65, play2D, "RewardGranted");
        end);
    end;

    FlowerRush.ChildAdded:Connect(onWorldChild);

    for _, child in FlowerRush:GetChildren() do
        onWorldChild(child);
    end;

    if u2 then
        pcall(function() -- Line: 369
            -- upvalues: u2 (ref), refreshVisibility (ref)
            u2:GetSaveSlotChangeSignal():Connect(function() -- Line: 370
                -- upvalues: refreshVisibility (ref)
                task.defer(refreshVisibility);
            end);
        end);
    end;

    task.spawn(function() -- Line: 375
        -- upvalues: refreshVisibility (ref)
        while true do
            task.wait(2);
            refreshVisibility();
        end;
    end);
end;

task.spawn(v1.Start, v1);

return v1;