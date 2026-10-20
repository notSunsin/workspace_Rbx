-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.EventRotation.EventRotationConfig);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local Signal = require(ReplicatedStorage.Modules.Signal);
local LocalPlayer = Players.LocalPlayer;
local RotateNewEvent = ReplicatedStorage.GameEvents.EventRotation.RotateNewEvent;
local u1 = nil;
local u2 = {};
local u3 = Signal.new();
u2.EventUpdated = u3;

local function UpdateEvent(p4) -- Line: 26
    -- upvalues: EventRotationUtils (copy), u1 (ref), u3 (copy), ReplicatedStorage (copy)
    local EventConfig = EventRotationUtils:GetEventConfig(p4);

    if not EventConfig then
        return;
    end;

    u1 = EventConfig;
    u3:Fire(p4, EventConfig.EventSet);
    require(ReplicatedStorage.Modules.Notification):CreateNotification((`NEW EVENT! <font color="#ffdd00">{EventConfig.EventDisplayName}</font>`));
end;

local function WaitForFTUEClear() -- Line: 41
    -- upvalues: LocalPlayer (copy)
    while LocalPlayer:GetAttribute("FirstTimePlayer") do
        LocalPlayer:GetAttributeChangedSignal("FirstTimePlayer"):Wait();
    end;

    task.wait();
end;

function u2.GetLoadedEvent(p5) -- Line: 48
    -- upvalues: u1 (ref)
    return u1;
end;

function u2.IsPastEventIDIndex(p6: table, p7: number) -- Line: 57
    -- upvalues: u2 (copy), EventRotationUtils (copy)
    local LoadedEvent = u2:GetLoadedEvent();

    if not LoadedEvent then
        return false;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(LoadedEvent.EventID, LoadedEvent.EventSet);

    return EventInSetIndex and p7 <= EventInSetIndex and true or false;
end;

function u2.IsInEvent(p8: table, p9: string, p10: string?) -- Line: 72
    -- upvalues: u2 (copy)
    local LoadedEvent = u2:GetLoadedEvent();

    if not LoadedEvent then
        return false;
    end;

    if LoadedEvent.EventSet == p9 then
        return p10 == nil and true or LoadedEvent.EventID == p10;
    end;

    return false;
end;

RotateNewEvent.OnClientEvent:Connect(function(p11: string) -- Line: 80
    -- upvalues: WaitForFTUEClear (copy), UpdateEvent (copy)
    WaitForFTUEClear();
    UpdateEvent(p11);
end);

return u2;