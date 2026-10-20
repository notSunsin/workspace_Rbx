-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Modules.CountDictionary);
require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.Events.SafariEvent.SafariEventConfigData);
require(ReplicatedStorage.Data.Events.SafariEvent.SafariEventRewardData);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local SafariEventCounter = ReplicatedStorage.Data.ReplicatedGlobalStock.SafariEventCounter;
local script_Containers = script.Containers;
local script_Fruit = script.Fruit;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local Sine = Enum.EasingStyle.Sine;
local InOut = Enum.EasingDirection.InOut;
local u8 = 0;
local u9 = -1;
local u10 = {};
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = {};
local u16 = {};
local u17 = {};

local function LoadInstances() -- Line: 66
    -- upvalues: CollectionService (copy), u2 (ref), u4 (ref), u5 (ref), u6 (ref), u3 (ref), u7 (ref), u8 (ref)
    local function waitForCollection(p18: string) -- Line: 67
        -- upvalues: CollectionService (ref)
        local v19 = CollectionService:GetTagged(p18)[1];

        if v19 then
            return v19;
        end;

        local v20 = 0;

        while not v19 do
            v19 = CollectionService:GetTagged(p18)[1];
            v20 = v20 + task.wait();

            if v20 >= 60 then
                break;
            end;
        end;

        if not v19 then
            warn((`No Instance found tagged (60s elapsed): {p18}`));
        end;

        return v19;
    end;

    u2 = waitForCollection("SafariEventPlatform");
    u4 = waitForCollection("SafariFruitInContainer");
    u5 = waitForCollection("PrePlacedContainerModels");
    u6 = waitForCollection("SafariContainerDetailing");
    u3 = waitForCollection("SafariContainerStack");
    u7 = u3:FindFirstChild("ContainerPivot");
    u8 = #u5:GetChildren();
end;

local function SetupFruitModels() -- Line: 96
    -- upvalues: u4 (ref), script_Fruit (copy), u15 (copy)
    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("Model") then
            local BoundingBox, v21 = descendant:GetBoundingBox();
            local v22 = BoundingBox.Position.Y - v21.Y / 2;
            descendant.Parent = script_Fruit;
            table.insert(u15, {
                Model = descendant,
                Height = v22
            });
        end;
    end;

    table.sort(u15, function(p23: table, p24: table) -- Line: 111
        return p23.Height < p24.Height;
    end);
end;

local function SetupContainerModels() -- Line: 116
    -- upvalues: u5 (ref), u10 (copy), script_Containers (copy), u16 (copy), u6 (ref)
    for _, child in u5:GetChildren() do
        if child:IsA("Model") then
            table.insert(u10, child);
            local BoundingBox, v25 = child:GetBoundingBox();
            local v26 = BoundingBox.Position.Y - v25.Y / 2;
            child.Parent = script_Containers;
            table.insert(u16, {
                Model = child,
                Height = v26
            });
        end;
    end;

    table.sort(u16, function(p27: table, p28: table) -- Line: 133
        return p27.Height < p28.Height;
    end);
    u6.Parent = script;
end;

local function PlayVFX(p29: userdata) -- Line: 141
    -- upvalues: Debris (copy)
    local v30 = game.Workspace:FindFirstChild("Terrain"):FindFirstChild("BigPopEffect"):Clone();
    v30.Parent = workspace.Terrain;
    v30.CFrame = CFrame.new(p29:GetPivot().Position);

    for _, child in v30:GetChildren() do
        child:Emit(1);
    end;

    Debris:AddItem(v30, 2);
end;

local function GetRandomContainer() -- Line: 157
    -- upvalues: script_Containers (copy)
    local Children = script_Containers:GetChildren();

    if #Children ~= 0 then
        return Children[math.random(1, #Children)];
    end;

    warn("No container templates found!");

    return nil;
end;

local function SpawnContainer() -- Line: 167
    -- upvalues: script_Containers (copy), Debris (copy), u7 (ref), u10 (copy), PlayVFX (copy)
    local Children = script_Containers:GetChildren();
    local v31;

    if #Children == 0 then
        warn("No container templates found!");
        v31 = nil;
    else
        v31 = Children[math.random(1, #Children)];
    end;

    if not v31 then
        return;
    end;

    local v32 = v31:Clone();
    local ContainerSlamSound = v32:FindFirstChild("ContainerSlamSound", true);

    if ContainerSlamSound then
        ContainerSlamSound:Play();
        Debris:AddItem(ContainerSlamSound, 2);
    end;

    v32.Parent = u7;
    local math_random_ret = math.random(-20, 20);
    local math_rad_ret = math.rad(math_random_ret);
    local math_random_ret2 = math.random(-2, 2);
    local math_random_ret3 = math.random(-2, 2);
    local CFrame_Angles_ret = CFrame.Angles(0, 0, -1.5707963267948966);
    v32:PivotTo(u7:GetPivot() * CFrame.new(math_random_ret2, #u10 * 9 - 4.5, math_random_ret3) * CFrame.Angles(0, math_rad_ret, 0) * CFrame_Angles_ret);
    PlayVFX(v32);
    table.insert(u10, v32);
end;

local function TweenPivotUp(p33: number) -- Line: 204
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u7 (ref), RunService (copy), Sine (copy), InOut (copy), TweenService (copy)
    if u11 then
        u11:Cancel();
        u11 = nil;
    end;

    if u12 then
        u12:Destroy();
        u12 = nil;
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    local Pivot = u7:GetPivot();
    local u34 = Pivot * CFrame.new(0, p33, 0);
    local v35 = math.abs(p33) / 100 * 1;
    local CFrameValue = Instance.new("CFrameValue");
    CFrameValue.Value = Pivot;
    u12 = CFrameValue;
    u13 = RunService.Heartbeat:Connect(function() -- Line: 228
        -- upvalues: u7 (ref), CFrameValue (copy)
        u7:PivotTo(CFrameValue.Value);
    end);
    local v36 = TweenService:Create(CFrameValue, TweenInfo.new(v35, Sine, InOut), {
        Value = u34
    });
    u11 = v36;
    v36.Completed:Connect(function(p37) -- Line: 236
        -- upvalues: u13 (ref), u11 (ref), CFrameValue (copy), u12 (ref), u7 (ref), u34 (copy)
        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        u11 = nil;
        CFrameValue:Destroy();
        u12 = nil;

        if p37 == Enum.PlaybackState.Completed then
            u7:PivotTo(u34);
        end;
    end);
    v36:Play();
end;

local function RenderContainers(p38: number) -- Line: 253
    -- upvalues: u16 (copy), u3 (ref), Debris (copy), PlayVFX (copy), u6 (ref), u2 (ref), u8 (ref), u10 (copy), SpawnContainer (copy), u14 (ref)
    local v39 = math.clamp((p38 - 3000) / 9000, 0, 1) * #u16;
    local math_round_ret = math.round(v39);

    for i, v in u16 do
        if v.Model.Parent ~= u3 and math_round_ret > i then
            v.Model.Parent = u3;
            local ContainerSlamSound = v.Model:FindFirstChild("ContainerSlamSound", true);

            if ContainerSlamSound then
                ContainerSlamSound:Play();
                Debris:AddItem(ContainerSlamSound, 2);
            end;

            PlayVFX(v.Model);
            task.wait(0.2);
        end;
    end;

    if p38 < 12000 then
        return;
    end;

    u6.Parent = u2;
    local v40 = (p38 - 12000) / 10000;
    local math_floor_ret = math.floor(v40);
    local _ = v40 - math_floor_ret;

    while #u10 < u8 + math_floor_ret + 1 and #u10 < 30 do
        SpawnContainer();
        task.wait(0.2);
    end;

    u14 = nil;
end;

local function RenderFruits(p41: number) -- Line: 307
    -- upvalues: u15 (copy), u4 (ref)
    local v42 = math.clamp(p41 / 3000, 0, 1) * #u15;
    local math_round_ret = math.round(v42);

    for i, v in u15 do
        if v.Model.Parent ~= u4 and math_round_ret > i then
            v.Model.Parent = u4;
        end;
    end;
end;

local function CounterChanged() -- Line: 322
    -- upvalues: SafariEventCounter (copy), RenderFruits (copy), u14 (ref), RenderContainers (copy), u9 (ref)
    local math_min_ret = math.min(SafariEventCounter.Value, 1000000);
    task.spawn(RenderFruits, math_min_ret);

    if math_min_ret >= 3000 then
        u14 = task.spawn(RenderContainers, math_min_ret);
    end;

    u9 = math_min_ret;
end;

local function EventCleanup() -- Line: 335
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u14 (ref)
    if u11 then
        u11:Cancel();
        u11 = nil;
    end;

    if u12 then
        u12:Destroy();
        u12 = nil;
    end;

    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;

    if u14 then
        task.cancel(u14);
        u14 = nil;
    end;
end;

function u17.Start(p43) -- Line: 374
    -- upvalues: LoadInstances (copy), u9 (ref), SafariEventCounter (copy), RenderFruits (copy), u14 (ref), RenderContainers (copy), CounterChanged (copy), u1 (copy), u7 (ref), u3 (ref), SetupFruitModels (copy), SetupContainerModels (copy)
    LoadInstances();
    u9 = SafariEventCounter.Value;
    local math_min_ret = math.min(SafariEventCounter.Value, 1000000);
    task.spawn(RenderFruits, math_min_ret);

    if math_min_ret >= 3000 then
        u14 = task.spawn(RenderContainers, math_min_ret);
    end;

    u9 = math_min_ret;
    task.delay(4, CounterChanged);
    u1:Add(SafariEventCounter.Changed:Connect(CounterChanged));
    u7:PivotTo(u3:GetPivot());

    for _, child in u7:GetChildren() do
        if u7.PrimaryPart ~= child then
            child:Destroy();
        end;
    end;

    SetupFruitModels();
    SetupContainerModels();
end;

EventRotationClientBinder:Bind({
    EventSet = "SafariEvent",
    Script = script,

    OnStart = function() -- Line: 401, Name: OnStart
        -- upvalues: u17 (copy)
        task.spawn(u17.Start, u17);
    end,

    OnStop = function() -- Line: 402, Name: OnStop
        -- upvalues: u11 (ref), u12 (ref), u13 (ref), u14 (ref), u1 (copy)
        if u11 then
            u11:Cancel();
            u11 = nil;
        end;

        if u12 then
            u12:Destroy();
            u12 = nil;
        end;

        if u13 then
            u13:Disconnect();
            u13 = nil;
        end;

        if u14 then
            task.cancel(u14);
            u14 = nil;
        end;

        u1:Clean();
    end
});

return u17;