-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
require(ReplicatedStorage.Modules.CycleHandler);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = Trove.new();
local u2 = Trove.new();
local JackOLantern = SharedCycleHandlerData.JackOLantern;
local HalloweenMarket = SharedCycleHandlerData.HalloweenMarket;
local Gravedigger = SharedCycleHandlerData.Gravedigger;
local DeadTree = SharedCycleHandlerData.DeadTree;
local WitchesBrew = SharedCycleHandlerData.WitchesBrew;
local HarvestReaper = SharedCycleHandlerData.HarvestReaper;
local WitchesBrewAndDeadTree = SharedCycleHandlerData.WitchesBrewAndDeadTree;
local u3 = {};

local function RunTimerLoop(u4: any, u5: userdata, u6: userdata) -- Line: 30
    -- upvalues: u1 (copy), RunService (copy), TimeHelper (copy), SharedCycleHandlerData (copy), DeadTree (copy), WitchesBrewAndDeadTree (copy), WitchesBrew (copy), JackOLantern (copy), Gravedigger (copy), HarvestReaper (copy)
    u1:Add(RunService.Heartbeat:Connect(function() -- Line: 31
        -- upvalues: u4 (copy), u6 (copy), u5 (copy), TimeHelper (ref), SharedCycleHandlerData (ref), DeadTree (ref), WitchesBrewAndDeadTree (ref), WitchesBrew (ref), JackOLantern (ref), Gravedigger (ref), HarvestReaper (ref)
        if u4:IsCycleActive() then
            u6.Text = `The {u4.Name} leaves in:`;
            u5.Text = TimeHelper:GenerateTextFromTime(u4:GetTimeRemaining() or 0);
        else
            local v7 = u4:GetTimeUntilNext() or (1 / 0);
            u6.Text = `The {u4.Name} appears in:`;
            u5.Text = TimeHelper:GenerateTextFromTime(v7);
        end;

        local v8 = u6:FindFirstAncestorOfClass("BillboardGui");

        if u4 == SharedCycleHandlerData.WitchesBrew then
            v8.Enabled = not DeadTree:IsCycleActive();

            if WitchesBrewAndDeadTree:IsRunning() then
                v8.Enabled = false;
            end;
        elseif u4 == SharedCycleHandlerData.DeadTree then
            v8.Enabled = not WitchesBrew:IsCycleActive();

            if WitchesBrewAndDeadTree:IsRunning() then
                v8.Enabled = false;
            end;
        else
            if u4 == SharedCycleHandlerData.Gravedigger then
                v8.Enabled = not JackOLantern:IsCycleActive();

                return;
            end;

            if u4 == SharedCycleHandlerData.JackOLantern then
                v8.Enabled = not Gravedigger:IsCycleActive();

                return;
            end;

            if u4 == SharedCycleHandlerData.WitchesBrewAndDeadTree then
                v8.Enabled = not HarvestReaper:IsCycleActive();

                return;
            end;

            if u4 == SharedCycleHandlerData.HarvestReaper then
                v8.Enabled = not WitchesBrewAndDeadTree:IsCycleActive();
            end;
        end;
    end));
end;

function u3.Start(p9) -- Line: 70
    -- upvalues: EventRotationController (copy), EventRotationUtils (copy), CollectionService (copy), JackOLantern (copy), RunTimerLoop (copy), HalloweenMarket (copy), Gravedigger (copy), DeadTree (copy), WitchesBrew (copy), HarvestReaper (copy), WitchesBrewAndDeadTree (copy)
    local LoadedEvent = EventRotationController:GetLoadedEvent();

    if not LoadedEvent then
        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(LoadedEvent.EventID, LoadedEvent.EventSet);

    if not EventInSetIndex then
        return;
    end;

    local v10 = CollectionService:GetTagged("JackOLanternTimerPart")[1];
    local v11 = CollectionService:GetTagged("HalloweenMarketTimerPart")[1];
    local v12 = CollectionService:GetTagged("GraveDiggerTimerPart")[1];
    local v13 = CollectionService:GetTagged("DeadTreeTimerPart")[1];
    local v14 = CollectionService:GetTagged("WitchesBrewTimerPart")[1];
    local v15 = CollectionService:GetTagged("HarvestReaperTimerPart")[1];
    local v16 = CollectionService:GetTagged("WitchAndTreeTimerPart")[1];
    v14:FindFirstChildOfClass("BillboardGui").Enabled = EventInSetIndex == 2;

    if EventInSetIndex >= 1 then
        if not JackOLantern:IsRunning() then
            JackOLantern:Start();
        end;

        local Timer = v10:FindFirstChild("Timer", true);
        local Title = v10:FindFirstChild("Title", true);
        task.spawn(RunTimerLoop, JackOLantern, Timer, Title);

        if not HalloweenMarket:IsRunning() then
            HalloweenMarket:Start();
        end;

        local Timer2 = v11:FindFirstChild("Timer", true);
        local Title2 = v11:FindFirstChild("Title", true);
        task.spawn(RunTimerLoop, HalloweenMarket, Timer2, Title2);
    end;

    if EventInSetIndex >= 2 then
        if not Gravedigger:IsRunning() then
            Gravedigger:Start();
        end;

        local Timer = v12:FindFirstChild("Timer", true);
        local Title = v12:FindFirstChild("Title", true);
        task.spawn(RunTimerLoop, Gravedigger, Timer, Title);

        if not DeadTree:IsRunning() then
            DeadTree:Start();
        end;

        local Timer2 = v13:FindFirstChild("Timer", true);
        local Title2 = v13:FindFirstChild("Title", true);
        task.spawn(RunTimerLoop, DeadTree, Timer2, Title2);

        if not WitchesBrew:IsRunning() then
            WitchesBrew:Start();
        end;

        local Timer3 = v14:FindFirstChild("Timer", true);
        local Title3 = v14:FindFirstChild("Title", true);
        task.spawn(RunTimerLoop, WitchesBrew, Timer3, Title3);
    end;

    if EventInSetIndex >= 3 then
        if not HarvestReaper:IsRunning() then
            HarvestReaper:Start();
        end;

        local Timer = v15:FindFirstChild("Timer", true);
        local Title = v15:FindFirstChild("Title", true);
        task.spawn(RunTimerLoop, HarvestReaper, Timer, Title);

        if not WitchesBrewAndDeadTree:IsRunning() then
            WitchesBrewAndDeadTree:Start();
        end;

        local Timer2 = v16:FindFirstChild("Timer", true);
        local Title2 = v16:FindFirstChild("Title", true);
        task.spawn(RunTimerLoop, WitchesBrewAndDeadTree, Timer2, Title2);
    end;
end;

EventRotationClientBinder:Bind({
    EventSet = "HalloweenEvent",
    Script = script,

    OnStart = function() -- Line: 133, Name: OnStart
        -- upvalues: u1 (copy), u3 (copy), u2 (copy), EventRotationController (copy)
        local u17 = nil;

        local function RestartOnNewPart(p18: string) -- Line: 136
            -- upvalues: u17 (ref), u1 (ref), u3 (ref)
            if u17 == p18 then
                return;
            end;

            u17 = p18;
            u1:Clean();
            task.spawn(u3.Start, u3);
        end;

        u2:Add(EventRotationController.EventUpdated:Connect(function(p19, p20) -- Line: 144
            -- upvalues: u17 (ref), u1 (ref), u3 (ref)
            if p20 ~= "HalloweenEvent" then
                return;
            end;

            if u17 == p19 then
                return;
            end;

            u17 = p19;
            u1:Clean();
            task.spawn(u3.Start, u3);
        end));
        local LoadedEvent = EventRotationController:GetLoadedEvent();

        if LoadedEvent then
            local EventID = LoadedEvent.EventID;

            if u17 ~= EventID then
                u17 = EventID;
                u1:Clean();
                task.spawn(u3.Start, u3);
            end;
        end;
    end,

    OnStop = function() -- Line: 154, Name: OnStop
        -- upvalues: u2 (copy), u1 (copy)
        u2:Clean();
        u1:Clean();
    end
});

return u3;