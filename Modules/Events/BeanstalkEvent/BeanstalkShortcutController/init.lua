-- Decompiled with Potassium's decompiler.

game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local _ = ReplicatedStorage.GameEvents.Events.BeanstalkEvent.RE_ActivateShortcut;
local u2 = 0;
local u3 = {};
local u4 = {};

local function EnableShortcut() -- Line: 27
    -- upvalues: u2 (ref), RunService (copy), u3 (copy)
    while u2 < 1 do
        u2 = u2 + RunService.Heartbeat:Wait() / 2;

        for _, v in u3 do
            v:ScaleTo(u2);
        end;
    end;
end;

local function DisableShortcut() -- Line: 37
    -- upvalues: u2 (ref), RunService (copy), u3 (copy)
    while u2 > 0 do
        u2 = u2 - RunService.Heartbeat:Wait() / 2;

        for _, v in u3 do
            v:ScaleTo(u2);
        end;
    end;
end;

function u4.Start(p5) -- Line: 46
    -- upvalues: CollectionService (copy), u3 (copy), DisableShortcut (copy), u1 (copy)
    local v6 = CollectionService:GetTagged("BeanstalkEventModel")[1];

    if not v6 then
        local v7 = 0;

        while not v6 and v7 <= 5 do
            v6 = CollectionService:GetTagged("BeanstalkEventModel")[1];
            v7 = v7 + task.wait(0.5);

            if v7 > 5 then
                warn("BeanstalkShortcutController | No BeanstalkEventModel");
                break;
            end;
        end;

        if not v6 then
            warn("BeanstalkShortcutController | No BeanstalkEventModel found after 5s, aborting Start()");

            return;
        end;
    end;

    for _, descendant in v6:FindFirstChild("ShortCuts"):FindFirstChild("Shortcut1"):GetDescendants() do
        if descendant:HasTag("Shortcut") then
            if descendant:IsA("Model") then
                descendant:ScaleTo(0.01);
            end;

            table.insert(u3, descendant);
        end;
    end;

    DisableShortcut();
    u1:Add(workspace:GetAttributeChangedSignal("ActivateBeanstalk"):Connect(function() -- Line: 73
        -- upvalues: DisableShortcut (ref)
        if workspace:GetAttribute("ActivateBeanstalk") then
            DisableShortcut();
        end;
    end));
end;

local u8 = false;
EventRotationController.EventUpdated:Connect(function(p9: string, p10: string) -- Line: 83, Name: OnEventUpdated
    -- upvalues: u1 (copy), u8 (ref), u4 (copy)
    if p10 ~= "BeanstalkEvent" then
        u1:Clean();
        u8 = false;

        return;
    end;

    if u8 then
        return;
    end;

    u8 = true;
    u1:Clean();
    task.spawn(u4.Start, u4);
end);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent and LoadedEvent.EventSet == "BeanstalkEvent" then
    local _ = LoadedEvent.EventID;

    if LoadedEvent.EventSet == "BeanstalkEvent" then
        if not u8 then
            u8 = true;
            u1:Clean();
            task.spawn(u4.Start, u4);
        end;
    else
        u1:Clean();
        u8 = false;
    end;
end;

return u4;