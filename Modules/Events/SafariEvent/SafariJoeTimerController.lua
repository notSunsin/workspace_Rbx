-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = Trove.new();
local SafariJoe = SharedCycleHandlerData.SafariJoe;
local u5 = {
    Start = function(p2) -- Line: 18, Name: Start
        -- upvalues: EventRotationController (copy), SafariJoe (copy), CollectionService (copy), u1 (copy), RunService (copy), TimeHelper (copy)
        if not EventRotationController:GetLoadedEvent() then
            return;
        end;

        if not SafariJoe:IsRunning() then
            SafariJoe:Start();
        end;

        local v3 = CollectionService:GetTagged("SafariJoeTimerPart")[1];
        local Timer = v3:FindFirstChild("Timer", true);
        local Title = v3:FindFirstChild("Title", true);
        u1:Add(RunService.Heartbeat:Connect(function() -- Line: 28
            -- upvalues: SafariJoe (ref), Title (copy), Timer (copy), TimeHelper (ref)
            if SafariJoe:IsCycleActive() then
                Title.Text = "Safari Joe leaves in:";
                Timer.Text = TimeHelper:GenerateTextFromTime(SafariJoe:GetTimeRemaining() or 0);

                return;
            end;

            local v4 = SafariJoe:GetTimeUntilNext() or (1 / 0);
            Title.Text = "Safari Joe arrives in:";
            Timer.Text = TimeHelper:GenerateTextFromTime(v4);
        end));
    end
};
EventRotationClientBinder:Bind({
    EventSet = "SafariEvent",
    MinPartIndex = 2,
    Script = script,

    OnStart = function() -- Line: 44, Name: OnStart
        -- upvalues: u5 (copy)
        task.spawn(u5.Start, u5);
    end,

    OnStop = function() -- Line: 45, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u5;