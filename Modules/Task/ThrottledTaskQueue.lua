-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Task = require(ReplicatedStorage.Modules.Task);
local u1 = {};
u1.__index = u1;

function u1.new(p2: number, p3: number, p4: number?) -- Line: 28
    -- upvalues: u1 (copy)
    assert(p2 > 0, "MaxInvocations must be greater than 0");
    assert(p3 > 0, "TimeWindow must be greater than 0");
    local v5 = setmetatable({}, u1);
    v5._maxInvocations = p2;
    v5._timeWindow = p3;
    v5._concurrentLimit = p4 or p2;
    v5._queue = {};
    v5._runningTasks = {};
    v5._invocationTimestamps = {};
    v5._isRunning = true;
    v5._processingThread = nil;
    v5:_startProcessing();

    return v5;
end;

function u1.Enqueue(p6, p7) -- Line: 54
    if p6._isRunning then
        table.insert(p6._queue, p7);

        return;
    end;

    warn("ThrottledTaskQueue: Cannot enqueue task - queue is stopped");
end;

function u1.EnqueueNew(p8: table, p9: function, ...) -- Line: 63
    -- upvalues: Task (copy)
    local v10 = Task.new(p9, ...);
    p8:Enqueue(v10);

    return v10;
end;

function u1.Clear(p11) -- Line: 69
    table.clear(p11._queue);
end;

function u1.GetQueueSize(p12) -- Line: 73
    return #p12._queue;
end;

function u1.GetPendingCount(p13) -- Line: 77
    local v14 = 0;

    for _, v in ipairs(p13._queue) do
        if v:GetStatus() == "Pending" then
            v14 = v14 + 1;
        end;
    end;

    return v14;
end;

function u1.GetRunningCount(p15) -- Line: 87
    return #p15._runningTasks;
end;

function u1.IsRunning(p16) -- Line: 91
    return p16._isRunning;
end;

function u1.Stop(p17) -- Line: 95
    p17._isRunning = false;
end;

function u1.Resume(p18) -- Line: 99
    if p18._isRunning then
        return;
    end;

    p18._isRunning = true;

    if not p18._processingThread then
        p18:_startProcessing();
    end;
end;

function u1.Destroy(p19) -- Line: 110
    p19._isRunning = false;

    if p19._processingThread then
        task.cancel(p19._processingThread);
        p19._processingThread = nil;
    end;

    for _, v in ipairs(p19._queue) do
        v:Cancel();
    end;

    for _, v in ipairs(p19._runningTasks) do
        v:Cancel();
    end;

    table.clear(p19._queue);
    table.clear(p19._runningTasks);
    table.clear(p19._invocationTimestamps);
end;

function u1._canStartTask(p20) -- Line: 133
    if #p20._runningTasks >= p20._concurrentLimit then
        return false;
    end;

    local v21 = os.clock() - p20._timeWindow;
    local v22 = 1;

    while v22 <= #p20._invocationTimestamps do
        if p20._invocationTimestamps[v22] < v21 then
            table.remove(p20._invocationTimestamps, v22);
        else
            v22 = v22 + 1;
        end;
    end;

    return #p20._invocationTimestamps < p20._maxInvocations;
end;

function u1._recordInvocation(p23) -- Line: 158
    table.insert(p23._invocationTimestamps, os.clock());
end;

function u1._removeRunningTask(p24, p25) -- Line: 162
    for i, v in ipairs(p24._runningTasks) do
        if v == p25 then
            table.remove(p24._runningTasks, i);

            return;
        end;
    end;
end;

function u1._startProcessing(u26) -- Line: 171
    u26._processingThread = task.spawn(function() -- Line: 172
        -- upvalues: u26 (copy)
        while u26._isRunning do
            while u26._isRunning and (#u26._queue > 0 and u26:_canStartTask()) do
                local table_remove_ret = table.remove(u26._queue, 1);

                if table_remove_ret then
                    table.insert(u26._runningTasks, table_remove_ret);
                    u26:_recordInvocation();
                    table_remove_ret:Start();
                    task.spawn(function() -- Line: 184
                        -- upvalues: table_remove_ret (copy), u26 (ref)
                        table_remove_ret:Await();
                        u26:_removeRunningTask(table_remove_ret);
                    end);
                end;
            end;

            task.wait(0.05);
        end;

        u26._processingThread = nil;
    end);
end;

return u1;