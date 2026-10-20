-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Task = require(ReplicatedStorage.Modules.Task);
local u1 = {};
u1.__index = u1;

function u1.new(p2: number, p3: number?) -- Line: 28
    -- upvalues: u1 (copy)
    assert(p2 > 0, "TimeBudget must be greater than 0");
    local v4 = setmetatable({}, u1);
    v4._timeBudget = p2;
    v4._concurrentLimit = p3 or (1 / 0);
    v4._queue = {};
    v4._runningTasks = {};
    v4._isRunning = true;
    v4._processingThread = nil;
    v4:_startProcessing();

    return v4;
end;

function u1.Enqueue(p5, p6) -- Line: 50
    if p5._isRunning then
        table.insert(p5._queue, p6);

        return;
    end;

    warn("TimeBudgetTaskQueue: Cannot enqueue task - queue is stopped");
end;

function u1.EnqueueNew(p7: table, p8: function, ...) -- Line: 59
    -- upvalues: Task (copy)
    local v9 = Task.new(p8, ...);
    p7:Enqueue(v9);

    return v9;
end;

function u1.Clear(p10) -- Line: 65
    table.clear(p10._queue);
end;

function u1.GetQueueSize(p11) -- Line: 69
    return #p11._queue;
end;

function u1.GetPendingCount(p12) -- Line: 73
    local v13 = 0;

    for _, v in ipairs(p12._queue) do
        if v:GetStatus() == "Pending" then
            v13 = v13 + 1;
        end;
    end;

    return v13;
end;

function u1.GetRunningCount(p14) -- Line: 83
    return #p14._runningTasks;
end;

function u1.IsRunning(p15) -- Line: 87
    return p15._isRunning;
end;

function u1.Stop(p16) -- Line: 91
    p16._isRunning = false;
end;

function u1.Resume(p17) -- Line: 95
    if p17._isRunning then
        return;
    end;

    p17._isRunning = true;

    if not p17._processingThread then
        p17:_startProcessing();
    end;
end;

function u1.SetTimeBudget(p18: table, p19: number) -- Line: 106
    assert(p19 > 0, "TimeBudget must be greater than 0");
    p18._timeBudget = p19;
end;

function u1.GetTimeBudget(p20) -- Line: 111
    return p20._timeBudget;
end;

function u1.Destroy(p21) -- Line: 115
    p21._isRunning = false;

    if p21._processingThread then
        task.cancel(p21._processingThread);
        p21._processingThread = nil;
    end;

    for _, v in p21._queue do
        v:Cancel();
    end;

    for _, v in p21._runningTasks do
        v:Cancel();
    end;

    table.clear(p21._queue);
    table.clear(p21._runningTasks);
end;

function u1._canStartTask(p22) -- Line: 137
    return #p22._runningTasks < p22._concurrentLimit;
end;

function u1._removeRunningTask(p23, p24) -- Line: 141
    for i, v in ipairs(p23._runningTasks) do
        if v == p24 then
            table.remove(p23._runningTasks, i);

            return;
        end;
    end;
end;

function u1._startProcessing(u25) -- Line: 150
    u25._processingThread = task.spawn(function() -- Line: 151
        -- upvalues: u25 (copy)
        while u25._isRunning do
            local os_clock_ret = os.clock();
            local v26 = 0;

            while u25._isRunning and (#u25._queue > 0 and (v26 < u25._timeBudget and u25:_canStartTask())) do
                local table_remove_ret = table.remove(u25._queue, 1);

                if table_remove_ret then
                    table.insert(u25._runningTasks, table_remove_ret);
                    os.clock();
                    table_remove_ret:Start();
                    v26 = os.clock() - os_clock_ret;
                    task.spawn(function() -- Line: 174
                        -- upvalues: table_remove_ret (copy), u25 (ref)
                        table_remove_ret:Await();
                        u25:_removeRunningTask(table_remove_ret);
                    end);
                end;
            end;

            task.wait();
        end;

        u25._processingThread = nil;
    end);
end;

return u1;