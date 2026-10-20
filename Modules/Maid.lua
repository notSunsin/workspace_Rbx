-- Decompiled with Potassium's decompiler.

local u1 = {
    ClassName = "Maid"
};

function u1.new() -- Line: 55
    -- upvalues: u1 (copy)
    return setmetatable({
        _tasks = {}
    }, u1);
end;

function u1.isMaid(p2) -- Line: 76
    local v3;

    if type(p2) == "table" then
        v3 = p2.ClassName == "Maid";
    else
        v3 = false;
    end;

    return v3;
end;

function u1.__index(p4, p5) -- Line: 96
    -- upvalues: u1 (copy)
    if u1[p5] then
        return u1[p5];
    end;

    return p4._tasks[p5];
end;

function u1.__newindex(p6, p7, p8) -- Line: 124
    -- upvalues: u1 (copy)
    if u1[p7] ~= nil then
        error(string.format("Cannot use \'%s\' as a Maid key", (tostring(p7))), 2);
    end;

    local _tasks = p6._tasks;
    local u9 = _tasks[p7];

    if u9 == p8 then
        return;
    end;

    _tasks[p7] = p8;

    if u9 then
        if typeof(u9) == "function" then
            u9();

            return;
        end;

        if typeof(u9) == "table" then
            if type(u9.Destroy) == "function" then
                u9:Destroy();
            end;
        else
            if typeof(u9) == "Instance" then
                u9:Destroy();

                return;
            end;

            if typeof(u9) == "thread" then
                local v10;

                if coroutine.running() == u9 then
                    v10 = nil;
                else
                    v10 = pcall(function() -- Line: 151
                        -- upvalues: u9 (copy)
                        task.cancel(u9);
                    end);
                end;

                if not v10 then
                    task.defer(function() -- Line: 157
                        -- upvalues: u9 (copy)
                        task.cancel(u9);
                    end);
                end;
            elseif typeof(u9) == "RBXScriptConnection" then
                u9:Disconnect();
            end;
        end;
    end;
end;

function u1.Add(p11, p12) -- Line: 174
    if not p12 then
        error("Task cannot be false or nil", 2);
    end;

    p11[#p11._tasks + 1] = p12;

    if type(p12) == "table" and not p12.Destroy then
        warn("[Maid.Add] - Gave table task without .Destroy\n\n" .. debug.traceback());
    end;

    return p12;
end;

function u1.GiveTask(p13, p14) -- Line: 195
    if not p14 then
        error("Task cannot be false or nil", 2);
    end;

    local v15 = #p13._tasks + 1;
    p13[v15] = p14;

    if type(p14) == "table" and not p14.Destroy then
        warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback());
    end;

    return v15;
end;

function u1.GivePromise(u16, p17) -- Line: 217
    if not p17:IsPending() then
        return p17;
    end;

    local v18 = p17.resolved(p17);
    local u19 = u16:GiveTask(v18);
    v18:Finally(function() -- Line: 226
        -- upvalues: u16 (copy), u19 (copy)
        u16[u19] = nil;
    end);

    return v18;
end;

function u1.DoCleaning(p20) -- Line: 251
    local _tasks = p20._tasks;

    for i, v in _tasks do
        if typeof(v) == "RBXScriptConnection" then
            _tasks[i] = nil;
            v:Disconnect();
        end;
    end;

    local v21, u22 = next(_tasks);

    while u22 ~= nil do
        _tasks[v21] = nil;

        if typeof(u22) == "function" then
            u22();
        elseif typeof(u22) == "table" and type(u22.Destroy) == "function" then
            u22:Destroy();
        elseif typeof(u22) == "Instance" then
            u22:Destroy();
        elseif typeof(u22) == "thread" then
            local v23;

            if coroutine.running() == u22 then
                v23 = nil;
            else
                v23 = pcall(function() -- Line: 275
                    -- upvalues: u22 (ref)
                    task.cancel(u22);
                end);
            end;

            if not v23 then
                local u24 = u22;
                task.defer(function() -- Line: 282
                    -- upvalues: u24 (copy)
                    task.cancel(u24);
                end);
            end;
        elseif typeof(u22) == "RBXScriptConnection" then
            u22:Disconnect();
        end;

        v21, u22 = next(_tasks);
    end;
end;

u1.Destroy = u1.DoCleaning;

return u1;