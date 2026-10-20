-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.GuiController);
local Trove = require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.DataService);
local EventService = require(ReplicatedStorage.Modules.EventService);
require(ReplicatedStorage.Modules.QuestsController);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local Spr = require(ReplicatedStorage.Code.Spr);
require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.UIComponents.QuestView);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local _ = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local StealAPetController = EventService.new("StealAPetController", "Steal A Pet Event");
local StealAPetEvent = SharedCycleHandlerData.StealAPetEvent;
local u1 = Trove.new();
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = {};
local u6 = false;
local u7 = { "Texture", "Decal" };

local function StartShakeLoop(u8: userdata) -- Line: 57
    -- upvalues: u1 (copy), u2 (ref), StealAPetEvent (copy)
    if not u8.PrimaryPart then
        return;
    end;

    local u9 = {
        RotationX = 10,
        RotationZ = 12.5,
        Height = 0.25,
        RootCFrame = u8.PrimaryPart.CFrame,
        RNG = Random.new(),
        Offset = Instance.new("CFrameValue"),
        Offset2 = Instance.new("CFrameValue"),
        Offset3 = Instance.new("NumberValue")
    };
    u1:Add(u9.Offset);
    u1:Add(u9.Offset2);
    u1:Add(u9.Offset3);
    u1:Add(task.spawn(function() -- Line: 79
        -- upvalues: u2 (ref), u8 (copy), StealAPetEvent (ref), u9 (copy)
        while u2 == u8 and u8.Parent do
            local v10 = StealAPetEvent:GetTimeUntilNext() or 30;
            u9.RotationX = math.clamp((600 - v10) * 2, 10, 50);
            u9.RotationZ = math.clamp((600 - v10) * 2, 10, 50);
            Shake(u8.PrimaryPart, u9);
            task.wait(5);
        end;
    end));
end;

function Shake(u11: userdata, u12: table?, p13: boolean?)
    -- upvalues: workspace_CurrentCamera (copy), u1 (copy), RunService (copy), Spr (copy)
    if not u11 then
        return;
    end;

    local _, u14 = u11.Parent:GetBoundingBox();
    u11.PivotOffset = CFrame.new(0, -u14.Y / 2, 0);
    u1:Add(RunService.Heartbeat:Connect(function() -- Line: 109, Name: Update
        -- upvalues: u11 (copy), workspace_CurrentCamera (ref), u12 (copy), u14 (copy)
        if (u11.Position - workspace_CurrentCamera.CFrame.Position).Magnitude > 200 then
            return;
        end;

        u11.Parent:PivotTo(u12.RootCFrame * CFrame.new(0, -u14.Y / 2 + u12.Offset3.Value, 0) * u12.Offset.Value * u12.Offset2.Value);
    end));
    u1:Add(task.spawn(function() -- Line: 123
        -- upvalues: Spr (ref), u12 (copy), u1 (ref), u14 (copy)
        Spr.stop(u12.Offset);
        Spr.stop(u12.Offset2);
        task.delay(0.1, function() -- Line: 129
            task.wait(0.075);
            task.wait(0.075);
            task.wait(0.075);
        end);
        Spr.target(u12.Offset, 0.3, 15, {
            Value = CFrame.new(0, u12.Height, 0) * CFrame.Angles(0, 0, u12.RNG:NextInteger(0, 1) == 1 and -math.rad(u12.RotationZ) or math.rad(u12.RotationZ))
        });
        Spr.target(u12.Offset2, 0.3, 15, {
            Value = CFrame.new(0, u12.Height, 0) * CFrame.Angles(math.rad(u12.RotationX), 0, 0)
        });
        task.wait(0.075);
        u1:Add(task.spawn(function() -- Line: 156
            -- upvalues: Spr (ref), u12 (ref), u14 (ref)
            Spr.target(u12.Offset3, 0.5, 8, {
                Value = u14.Y * 0.2
            });
            task.wait(0.2);
            Spr.target(u12.Offset3, 0.5, 8, {
                Value = 0
            });
        end));
        Spr.target(u12.Offset, 0.25, 2, {
            Value = CFrame.new(0, 0, 0)
        });
        Spr.target(u12.Offset2, 0.15, 2.5, {
            Value = CFrame.new(0, 0, 0)
        });
    end));
end;

local function PlayHatchAnimation(p15: userdata) -- Line: 189
    -- upvalues: Spr (copy), u4 (ref), u7 (copy)
    if not (p15 and p15.PrimaryPart) then
        return;
    end;

    p15.Parent = workspace;
    local Scale = p15:GetScale();

    for i = 1, 6 do
        Spr.target(p15, 0.5, 20, {
            Pivot = u4 * CFrame.Angles(0, 0, (math.rad(i * 3 * (i % 2 == 0 and 1 or -1))))
        });
        task.wait(0.05);
        local _ = i;
    end;

    Spr.target(p15, 0.5, 20, {
        Pivot = u4
    });
    task.wait(0.1);
    Spr.target(p15, 0.6, 2, {
        Pivot = u4 + Vector3.new(0, 10, 0)
    });
    Spr.target(p15, 0.6, 2, {
        Scale = Scale * 2
    });

    for _, descendant in p15:GetDescendants() do
        if descendant:IsA("BasePart") then
            Spr.target(descendant, 0.7, 1, {
                Transparency = 1
            });
        elseif table.find(u7, descendant.ClassName) then
            Spr.target(descendant, 0.7, 1, {
                Transparency = 1
            });
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.wait(2);
    Spr.stop(p15);
    p15:Destroy();
end;

local function PlayEntranceAnimation(p16: userdata) -- Line: 258
    -- upvalues: Spr (copy)
    if not (p16 and p16.PrimaryPart) then
        return;
    end;

    local CFrame2 = p16.PrimaryPart.CFrame;
    local Scale = p16:GetScale();

    for _, descendant in p16:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    p16:ScaleTo(0.1);
    p16:PivotTo(CFrame2 + Vector3.new(0, -2, 0));

    for _, descendant in p16:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Name ~= "HitBox" then
            Spr.target(descendant, 0.6, 5, {
                Transparency = 0
            });
        end;
    end;

    Spr.target(p16, 0.5, 4, {
        Scale = Scale,
        Pivot = CFrame2
    });
    task.wait(0.5);
    Spr.stop(p16);
    p16:ScaleTo(Scale);
    p16:PivotTo(CFrame2);
end;

local function PrepareHatchClone(p17: userdata) -- Line: 306
    -- upvalues: u3 (ref), u4 (ref)
    if u3 then
        u3:Destroy();
        u3 = nil;
        u4 = nil;
    end;

    u3 = p17:Clone();
    u4 = p17:GetPivot();
    u3.Name = "HatchClone";
    u3:RemoveTag("StealEggSpawner");

    if u3.PrimaryPart then
        u3.PrimaryPart.PivotOffset = CFrame.new();
    end;
end;

local function NewEggSpawned(p18: userdata) -- Line: 336
    -- upvalues: StealAPetController (copy), u5 (copy), u6 (ref), u1 (copy), u3 (ref), PlayHatchAnimation (copy), u4 (ref), u2 (ref), PlayEntranceAnimation (copy), PrepareHatchClone (copy), StartShakeLoop (copy)
    if not StealAPetController.IsRunning then
        table.insert(u5, p18);

        return;
    end;

    if u6 then
        return;
    end;

    u6 = true;
    u1:Clean();

    for _, descendant in p18:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    if u3 and u3.PrimaryPart then
        PlayHatchAnimation(u3);
        u3 = nil;
        u4 = nil;
    end;

    u2 = p18;
    PlayEntranceAnimation(p18);
    PrepareHatchClone(p18);
    StartShakeLoop(p18);
    u6 = false;
end;

local function OnEggTagAdded(p19: userdata) -- Line: 382
    -- upvalues: StealAPetController (copy), u5 (copy), u2 (ref), NewEggSpawned (copy)
    if StealAPetController.IsRunning then
        if p19 ~= u2 then
            NewEggSpawned(p19);
        end;

        return;
    end;

    table.insert(u5, p19);
end;

function StealAPetController.OnStarted(p20) -- Line: 399
    -- upvalues: StealAPetEvent (copy), u5 (copy), StealAPetController (copy), u2 (ref), NewEggSpawned (copy)
    if not StealAPetEvent:IsRunning() then
        StealAPetEvent:Start(game.ReplicatedFirst.GlobalUpdateTime.Value);
    end;

    for _, v in u5 do
        if StealAPetController.IsRunning then
            if v ~= u2 then
                NewEggSpawned(v);
            end;
        else
            table.insert(u5, v);
        end;
    end;

    table.clear(u5);
end;

function StealAPetController.OnEnded(p21) -- Line: 417
    -- upvalues: u1 (copy), u2 (ref), u3 (ref), u4 (ref)
    u1:Clean();
    u2 = nil;

    if u3 then
        u3:Destroy();
        u3 = nil;
        u4 = nil;
    end;
end;

CreateTagHandler({
    Tag = "StealEggSpawner",
    OnInstanceAdded = OnEggTagAdded
});

return StealAPetController;