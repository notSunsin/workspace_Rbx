-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Signal = require(ReplicatedStorage.Modules.Signal);
local CycleForceStarted = ReplicatedStorage.GameEvents.CycleHandler.CycleForceStarted;
local CycleForceEnded = ReplicatedStorage.GameEvents.CycleHandler.CycleForceEnded;
local CycleForceStateCleared = ReplicatedStorage.GameEvents.CycleHandler.CycleForceStateCleared;
local EventTimingStorage = ReplicatedStorage:FindFirstChild("EventTimingStorage");
local u1 = workspace:FindFirstChild("Interaction") or workspace;
local u2 = {};
u2.__index = u2;
local u3 = {};

function u2.getAllHandlers() -- Line: 181
    -- upvalues: u3 (copy)
    return u3;
end;

function u2.new(p4: table) -- Line: 185
    -- upvalues: u3 (copy), Signal (copy), u2 (copy)
    local v5 = p4.TimeOffset or 0;

    if p4.Duration > p4.Interval then
        error((`[CycleHandler] Handler {p4.Name} is misconfigured: Duration is greater than Interval`));
    end;

    if u3[p4.Name] then
        error((`[CycleHandler] Handler with name {p4.Name} already exists`));
    end;

    local v6 = {
        _isRunning = false,
        _isEventActive = false,
        _isForced = false,
        _isForcedStop = false,
        _forcedStartTime = nil,
        _forcedDuration = nil,
        _currentCycle = -1,
        _checkThread = nil,
        _endEventThread = nil,
        _forcedStopEndThread = nil,
        _startTime = 0,
        Name = p4.Name,
        Interval = p4.Interval,
        Duration = p4.Duration,
        TimeOffset = v5,
        EventFolder = p4.EventFolder,
        FolderMoveMode = p4.FolderMoveMode or "ServerOnly",
        PrintDebug = p4.PrintDebug or "None",
        DisableCommandAutocomplete = p4.DisableCommandAutocomplete,
        _effectiveTimeOffset = v5,
        EventStart = Signal.new(),
        EventEnd = Signal.new(),
        IntervalChanged = Signal.new()
    };
    local v7 = setmetatable(v6, u2);
    u3[v7.Name] = v7;

    return v7;
end;

function u2._print(p8: table, p9: string) -- Line: 231
    -- upvalues: RunService (copy)
    if p8.PrintDebug == "None" then
        return;
    end;

    if p8.PrintDebug == "ServerOnly" and RunService:IsServer() then
        print("[CycleHandler] " .. p9);

        return;
    end;

    if p8.PrintDebug == "ClientOnly" and RunService:IsClient() then
        print("[CycleHandler] " .. p9);

        return;
    end;

    if p8.PrintDebug == "ServerClient" then
        print("[CycleHandler] " .. p9);
    end;
end;

function u2.GetCycleAt(p10: table, p11: number) -- Line: 244
    return p10.Interval <= 0 and 0 or math.floor((p11 - p10._startTime) / p10.Interval);
end;

function u2.GetCurrentCycle(p12) -- Line: 253
    return p12:GetCycleAt(workspace:GetServerTimeNow());
end;

function u2.IsCycleActive(p13) -- Line: 258
    return p13._isEventActive;
end;

function u2.IsForced(p14) -- Line: 263
    return p14._isForced or p14._isForcedStop;
end;

function u2.GetRunInfo(p15: table, p16: number) -- Line: 268
    if p15.Interval <= 0 or p16 < 0 then
        return {
            StartTime = 0,
            EndTime = 0,
            IsActive = false,
            TimeUntilStart = nil,
            TimeUntilEnd = nil,
            Progress = nil,
            Cycle = p16
        };
    end;

    local v17 = p15._startTime + p16 * p15.Interval + p15._effectiveTimeOffset;
    local v18 = v17 + p15.Duration;
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v19;

    if v17 <= ServerTimeNow then
        v19 = ServerTimeNow < v18;
    else
        v19 = false;
    end;

    local v20 = nil;
    local v21 = nil;
    local v22 = nil;

    if v19 then
        v21 = v18 - ServerTimeNow;
        v22 = (ServerTimeNow - v17) / p15.Duration;
    elseif ServerTimeNow < v17 then
        v20 = v17 - ServerTimeNow;
    else
        v20 = nil;
    end;

    return {
        Cycle = p16,
        StartTime = v17,
        EndTime = v18,
        IsActive = v19,
        TimeUntilStart = v20,
        TimeUntilEnd = v21,
        Progress = v22
    };
end;

function u2.GetCurrentRunInfo(p23) -- Line: 316
    local RunInfo = p23:GetRunInfo(p23:GetCurrentCycle());

    if p23._isForcedStop then
        return {
            IsActive = false,
            TimeUntilStart = nil,
            TimeUntilEnd = nil,
            Progress = nil,
            Cycle = RunInfo.Cycle,
            StartTime = RunInfo.StartTime,
            EndTime = RunInfo.EndTime
        };
    end;

    if not p23._isForced then
        return RunInfo;
    end;

    if not (p23._isEventActive and (p23._forcedStartTime and p23._forcedDuration)) then
        return p23._isEventActive and {
            IsActive = true,
            TimeUntilStart = nil,
            TimeUntilEnd = nil,
            Progress = nil,
            Cycle = RunInfo.Cycle,
            StartTime = RunInfo.StartTime,
            EndTime = RunInfo.EndTime
        } or RunInfo;
    end;

    local v24 = workspace:GetServerTimeNow() - p23._forcedStartTime;
    local math_max_ret = math.max(0, p23._forcedDuration - v24);
    local math_clamp_ret = math.clamp(v24 / p23._forcedDuration, 0, 1);

    return {
        IsActive = true,
        TimeUntilStart = nil,
        Cycle = RunInfo.Cycle,
        StartTime = p23._forcedStartTime,
        EndTime = p23._forcedStartTime + p23._forcedDuration,
        TimeUntilEnd = math_max_ret,
        Progress = math_clamp_ret
    };
end;

function u2.GetRunInfoAt(p25: table, p26: number) -- Line: 371
    return p25:GetRunInfo((p25:GetCycleAt(p26)));
end;

function u2._moveFolderToWorkspace(p27) -- Line: 377
    -- upvalues: RunService (copy), u1 (copy)
    if not p27.EventFolder then
        return;
    end;

    if ((p27.FolderMoveMode == "ServerOnly" and RunService:IsServer() or p27.FolderMoveMode == "ClientOnly" and RunService:IsClient()) and true or (p27.FolderMoveMode == "ServerClient" and true or false)) and p27.EventFolder.Parent ~= u1 then
        p27:_print((`[{p27.Name}] Moving folder to workspace`));
        p27.EventFolder.Parent = u1;
    end;
end;

function u2._moveFolderToStorage(p28) -- Line: 399
    -- upvalues: EventTimingStorage (copy), RunService (copy)
    if not (p28.EventFolder and EventTimingStorage) then
        return;
    end;

    if ((p28.FolderMoveMode == "ServerOnly" and RunService:IsServer() or p28.FolderMoveMode == "ClientOnly" and RunService:IsClient()) and true or (p28.FolderMoveMode == "ServerClient" and true or false)) and p28.EventFolder.Parent ~= EventTimingStorage then
        p28:_print((`[{p28.Name}] Moving folder to storage`));
        p28.EventFolder.Parent = EventTimingStorage;
    end;
end;

function u2._startEvent(p29: table, p30: boolean?) -- Line: 421
    if p29._isEventActive then
        p29:_print((`[{p29.Name}] Event already active`));

        return;
    end;

    p29._isEventActive = true;

    if p30 then
        p29._isForced = true;
    end;

    p29:_print((`[{p29.Name}] Event starting{p30 and " (FORCED)" or ""}`));
    p29:_moveFolderToWorkspace();
    p29.EventStart:Fire();
end;

function u2._endEvent(p31: table, p32: boolean?) -- Line: 443
    if not p31._isEventActive then
        p31:_print((`[{p31.Name}] Event not active, cannot end`));

        return;
    end;

    p31._isEventActive = false;

    if p32 then
        if p31._isForced then
            p31._isForced = false;
            p31._forcedStartTime = nil;
            p31._forcedDuration = nil;
        end;
    elseif p31._isForced then
        p31._isForced = false;
        p31._forcedStartTime = nil;
        p31._forcedDuration = nil;
    end;

    p31:_print((`[{p31.Name}] Event ending{p32 and " (FORCED)" or ""}`));
    p31:_moveFolderToStorage();

    if p31._endEventThread then
        pcall(task.cancel, p31._endEventThread);
        p31._endEventThread = nil;
    end;

    p31.EventEnd:Fire();
end;

function u2._checkCycle(p33) -- Line: 481
    while p33._isRunning do
        local CurrentCycle = p33:GetCurrentCycle();
        local CurrentRunInfo = p33:GetCurrentRunInfo();

        if CurrentCycle ~= p33._currentCycle then
            local _currentCycle = p33._currentCycle;
            p33._currentCycle = CurrentCycle;

            if _currentCycle >= 0 then
                p33:_print((`[{p33.Name}] Cycle changed: {_currentCycle} -> {CurrentCycle}`));
                p33.IntervalChanged:Fire(CurrentCycle, _currentCycle);
            end;
        end;

        if p33._isForced or p33._isForcedStop then
            p33:_print((`[{p33.Name}] In forced mode - ignoring natural cycle (Active: {p33._isEventActive}, ForcedStop: {p33._isForcedStop})`));
        elseif CurrentRunInfo.IsActive and not p33._isEventActive then
            p33:_startEvent(false);
        elseif not CurrentRunInfo.IsActive and p33._isEventActive then
            p33:_endEvent(false);
        end;

        task.wait(1);
    end;
end;

function u2.Start(u34: table, p35: number?) -- Line: 515
    if u34._isRunning then
        warn((`[{u34.Name}] CycleHandler already running`));

        return;
    end;

    if p35 and p35 > 0 then
        u34._startTime = p35 + u34.TimeOffset;
    else
        u34._startTime = u34.TimeOffset;
    end;

    u34._effectiveTimeOffset = 0;
    u34:_print((`[{u34.Name}] CycleHandler starting (Interval: {u34.Interval}s, Duration: {u34.Duration}s, TimeOffset: {u34.TimeOffset}s, StartTime: {u34._startTime})`));
    u34._isRunning = true;
    u34._currentCycle = u34:GetCurrentCycle();

    if u34:GetCurrentRunInfo().IsActive then
        u34:_startEvent(false);
    else
        u34:_moveFolderToStorage();
    end;

    u34._checkThread = task.spawn(function() -- Line: 546
        -- upvalues: u34 (copy)
        u34:_checkCycle();
    end);
end;

function u2.Stop(p36) -- Line: 552
    if not p36._isRunning then
        return;
    end;

    p36:_print((`[{p36.Name}] CycleHandler stopping`));
    p36._isRunning = false;

    if p36._isEventActive then
        p36:_endEvent(true);
    end;

    if p36._checkThread then
        pcall(task.cancel, p36._checkThread);
        p36._checkThread = nil;
    end;

    p36._currentCycle = -1;
    p36._isForced = false;
    p36._isForcedStop = false;
    p36._forcedStartTime = nil;
    p36._forcedDuration = nil;
end;

function u2.ForceStart(u37: table, p38: number?) -- Line: 581
    -- upvalues: RunService (copy), CycleForceStarted (copy)
    if not u37._isRunning then
        return;
    end;

    if u37._isForcedStop then
        u37._isForcedStop = false;

        if u37._forcedStopEndThread then
            pcall(task.cancel, u37._forcedStopEndThread);
            u37._forcedStopEndThread = nil;
        end;
    end;

    local v39 = p38 or u37.Duration;
    u37._forcedStartTime = workspace:GetServerTimeNow();
    u37._forcedDuration = v39;
    u37:_print((`[{u37.Name}] Force starting event for {v39}s`));
    u37:_startEvent(true);

    if RunService:IsServer() then
        CycleForceStarted:FireAllClients(u37.Name, v39);
    end;

    if v39 and v39 > 0 then
        u37._endEventThread = task.delay(v39, function() -- Line: 612
            -- upvalues: u37 (copy)
            u37:_endEvent(true);
            u37._forcedStartTime = nil;
            u37._forcedDuration = nil;
        end);
    end;
end;

function u2.ForceEnd(u40: table, p41: number?) -- Line: 623
    -- upvalues: RunService (copy), CycleForceEnded (copy)
    if not u40._isRunning then
        return;
    end;

    u40:_print((`[{u40.Name}] Force ending event{not p41 and " until next cycle" or ` for {p41}s`}`));

    if u40._isForced then
        u40._isForced = false;
        u40._forcedStartTime = nil;
        u40._forcedDuration = nil;

        if u40._endEventThread then
            pcall(task.cancel, u40._endEventThread);
            u40._endEventThread = nil;
        end;
    end;

    if u40._isEventActive then
        u40:_endEvent(true);
    end;

    u40._isForcedStop = true;

    if RunService:IsServer() then
        CycleForceEnded:FireAllClients(u40.Name);
    end;

    if not p41 or p41 <= 0 then
        local ServerTimeNow = workspace:GetServerTimeNow();
        p41 = u40:GetRunInfo(u40:GetCurrentCycle() + 1).StartTime - ServerTimeNow;
    end;

    if p41 > 0 then
        u40._forcedStopEndThread = task.delay(p41, function() -- Line: 669
            -- upvalues: u40 (copy)
            u40:_print((`[{u40.Name}] Exiting forced stop mode`));
            u40._isForcedStop = false;
            u40._forcedStopEndThread = nil;

            if u40:GetCurrentRunInfo().IsActive and not u40._isEventActive then
                u40:_startEvent(false);
            end;
        end);
    end;
end;

function u2.ClearForced(p42) -- Line: 684
    -- upvalues: RunService (copy), CycleForceStateCleared (copy)
    if not (p42._isForced or p42._isForcedStop) then
        return;
    end;

    p42:_print((`[{p42.Name}] Clearing forced mode, returning to natural cycle`));
    p42._isForced = false;
    p42._isForcedStop = false;
    p42._forcedStartTime = nil;
    p42._forcedDuration = nil;

    if p42._endEventThread then
        pcall(task.cancel, p42._endEventThread);
        p42._endEventThread = nil;
    end;

    if p42._forcedStopEndThread then
        pcall(task.cancel, p42._forcedStopEndThread);
        p42._forcedStopEndThread = nil;
    end;

    local RunInfo = p42:GetRunInfo(p42:GetCurrentCycle());

    if RunInfo.IsActive and not p42._isEventActive then
        p42:_startEvent(false);
    elseif not RunInfo.IsActive and p42._isEventActive then
        p42:_endEvent(false);
    end;

    if RunService:IsServer() then
        CycleForceStateCleared:FireAllClients(p42.Name);
    end;
end;

function u2.GetTimeRemaining(p43) -- Line: 719
    if p43._isEventActive then
        return p43:GetCurrentRunInfo().TimeUntilEnd;
    end;

    return nil;
end;

function u2.GetTimeUntilNext(p44) -- Line: 730
    if p44._isForcedStop then
        return nil;
    end;

    if p44._isForced and (p44._isEventActive and not p44._endEventThread) then
        return 999999999;
    end;

    local CurrentRunInfo = p44:GetCurrentRunInfo();

    if CurrentRunInfo.IsActive then
        return p44:GetRunInfo(p44:GetCurrentCycle() + 1).TimeUntilStart;
    end;

    if CurrentRunInfo.TimeUntilStart then
        return CurrentRunInfo.TimeUntilStart;
    end;

    return p44:GetRunInfo(p44:GetCurrentCycle() + 1).TimeUntilStart;
end;

function u2.IsRunning(p45) -- Line: 763
    return p45._isRunning;
end;

function u2.Destroy(p46) -- Line: 769
    -- upvalues: u3 (copy)
    p46:Stop();
    p46.EventStart:Destroy();
    p46.EventEnd:Destroy();
    p46.IntervalChanged:Destroy();
    u3[p46.Name] = nil;
end;

if RunService:IsClient() then
    CycleForceStarted.OnClientEvent:Connect(function(p47: string, p48: number?) -- Line: 782
        -- upvalues: u3 (copy)
        local v49 = u3[p47];

        if v49 then
            v49:ForceStart(p48 or nil);
        end;
    end);
    CycleForceEnded.OnClientEvent:Connect(function(p50: string) -- Line: 789
        -- upvalues: u3 (copy)
        local v51 = u3[p50];

        if v51 then
            v51:ForceEnd();
        end;
    end);
    CycleForceStateCleared.OnClientEvent:Connect(function(p52: string) -- Line: 796
        -- upvalues: u3 (copy)
        local v53 = u3[p52];

        if v53 then
            v53:ClearForced();
        end;
    end);
end;

return u2;