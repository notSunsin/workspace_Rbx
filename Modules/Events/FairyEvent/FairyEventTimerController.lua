-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observers = require(ReplicatedStorage.Modules.Observers);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local LocalPlayer = Players.LocalPlayer;
local u1 = Trove.new();
local u2 = {};

local function GetTimerText() -- Line: 16
    -- upvalues: LocalPlayer (copy), TimeHelper (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local Attribute = LocalPlayer:GetAttribute("FairyWaveEnd");
    local Attribute2 = LocalPlayer:GetAttribute("FairyNextWaveStart");

    if Attribute and ServerTimeNow < Attribute then
        local v3 = Attribute - ServerTimeNow;

        return v3 < 1 and "Fairies are leaving now!" or `Fairies leave in {TimeHelper:GenerateTextFromTime(v3)}`;
    end;

    if not Attribute2 then
        return "";
    end;

    local math_max_ret = math.max(Attribute2 - ServerTimeNow, 0);

    return math_max_ret < 1 and "Fairies are arriving now!" or `Fairies arrive in {TimeHelper:GenerateTextFromTime(math_max_ret)}`;
end;

function u2.Start(p4) -- Line: 39
    -- upvalues: u1 (copy), Observers (copy), GetTimerText (copy)
    u1:Add((Observers.observeTag("FairyEventTimerLabel", function(u5: userdata) -- Line: 40
        -- upvalues: GetTimerText (ref)
        local u6 = true;
        task.spawn(function() -- Line: 42
            -- upvalues: u6 (ref), u5 (copy), GetTimerText (ref)
            while u6 do
                u5.Text = GetTimerText();
                task.wait(0.25);
            end;
        end);

        return function() -- Line: 48
            -- upvalues: u6 (ref)
            u6 = false;
        end;
    end, { workspace })));
end;

EventRotationClientBinder:Bind({
    EventSet = "FairyEvent",
    Script = script,

    OnStart = function() -- Line: 57, Name: OnStart
        -- upvalues: u2 (copy)
        task.spawn(u2.Start, u2);
    end,

    OnStop = function() -- Line: 58, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u2;