-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.UpdateService);
local CameraShaker = require(ReplicatedStorage.Code.CameraShaker);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local u2 = false;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = {};

local function ToggleShrineTransparency(p7: userdata, p8: number) -- Line: 23
    -- upvalues: CollectionService (copy)
    for _, descendant in p7:GetDescendants() do
        if descendant:IsA("BasePart") and not CollectionService:HasTag(descendant, "KeepTransparency") then
            descendant.Transparency = p8;
            descendant.CanCollide = true;
        end;
    end;
end;

local function ToggleGroundBreakEmitter(p9: boolean) -- Line: 32
    -- upvalues: u5 (ref)
    for _, child in u5:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child.Enabled = p9;
        end;
    end;
end;

local function MoveShrine(p10: userdata, p11, p12) -- Line: 39
    -- upvalues: ToggleShrineTransparency (copy), ToggleGroundBreakEmitter (copy), u4 (ref), CameraShaker (copy), u5 (ref), RunService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    ToggleShrineTransparency(p10, 0);
    ToggleGroundBreakEmitter(true);
    local v13 = u4:ShakeSustain(CameraShaker.Presets.Vibration);
    local v14 = 0;

    while v14 < 4 do
        v13:SetScaleMagnitude(1 - math.clamp((workspace_CurrentCamera.CFrame.Position - u5.Position).Magnitude, 0, 75) / 75);
        v14 = v14 + RunService.Heartbeat:Wait();
        p10:PivotTo(p11:Lerp(p12, v14 / 4) * CFrame.new(Random.new():NextUnitVector() * 0.1));
    end;

    u4:StopSustained(1);
    p10:PivotTo(p12);
    ToggleGroundBreakEmitter(false);
end;

local function MoveUp(p15: userdata, p16, p17) -- Line: 65
    -- upvalues: u2 (ref), MoveShrine (copy)
    if u2 then
        return;
    end;

    u2 = true;
    MoveShrine(p15, p16, p17);
end;

local function MoveDown(p18: userdata, p19, p20) -- Line: 71
    -- upvalues: u2 (ref), MoveShrine (copy)
    if not u2 then
        return;
    end;

    u2 = false;
    MoveShrine(p18, p20, p19);
end;

local function InitShrine(u21: userdata, u22: string) -- Line: 77
    -- upvalues: ToggleShrineTransparency (copy), u1 (copy), u2 (ref), MoveShrine (copy)
    local Pivot = u21:GetPivot();
    local u23 = u21:GetPivot() * CFrame.new(0, -15, 0);
    u21:PivotTo(u23);
    ToggleShrineTransparency(u21, 1);
    u1:Add(workspace:GetAttributeChangedSignal(u22):Connect(function() -- Line: 84
        -- upvalues: u22 (copy), u21 (copy), u23 (copy), Pivot (copy), u2 (ref), MoveShrine (ref)
        if workspace:GetAttribute(u22) then
            if u2 then
                return;
            end;

            u2 = true;
            MoveShrine(u21, u23, Pivot);

            return;
        end;

        if not u2 then
            return;
        end;

        u2 = false;
        MoveShrine(u21, Pivot, u23);
    end));

    if workspace:GetAttribute(u22) then
        if u2 then
            return;
        end;

        u2 = true;
        MoveShrine(u21, u23, Pivot);
    end;
end;

function u6.Start(p24) -- Line: 97
    -- upvalues: EventRotationUtils (copy), u5 (ref), u3 (ref), u4 (ref), CameraShaker (copy), InitShrine (copy)
    local v25 = EventRotationUtils:GetEventIDModelsWait("LunarGlowEvent")[1];
    local NightEventShrine = v25:FindFirstChild("NightEventShrine");
    local BloodMoonShrine = v25:FindFirstChild("BloodMoonShrine");
    u5 = v25:FindFirstChild("GroundBreak");
    u3 = workspace.CurrentCamera;
    u4 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p26) -- Line: 104
        -- upvalues: u3 (ref)
        u3.CFrame = u3.CFrame * p26;
    end);
    u4:Start();
    InitShrine(NightEventShrine, "NightEvent");
    InitShrine(BloodMoonShrine, "BloodMoonEvent");
end;

local u27 = false;
EventRotationController.EventUpdated:Connect(function(p28: string, p29: string) -- Line: 114, Name: OnEventUpdated
    -- upvalues: u1 (copy), u27 (ref), u6 (copy)
    if p29 ~= "LunarGlowEvent" then
        u1:Clean();
        u27 = false;

        return;
    end;

    if u27 then
        return;
    end;

    u27 = true;
    u1:Clean();
    task.spawn(u6.Start, u6);
end);

return u6;