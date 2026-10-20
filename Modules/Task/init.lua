-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1.new(p2: function, ...) -- Line: 29
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3._func = p2;
    v3._args = { ... };
    v3._status = "Pending";
    v3._thread = nil;
    v3._result = nil;
    v3._error = nil;
    v3.OnCompleted = Signal.new();
    v3.OnFailed = Signal.new();
    v3.OnCancelled = Signal.new();

    return v3;
end;

function u1.run(p4: function, ...) -- Line: 47
    -- upvalues: u1 (copy)
    local v5 = u1.new(p4, ...);
    v5:Start();

    return v5;
end;

function u1.Start(u6) -- Line: 54
    if u6._status ~= "Pending" then
        warn("Task cannot be started - current status:", u6._status);

        return u6;
    end;

    u6._status = "Running";
    u6._thread = task.spawn(function() -- Line: 60
        -- upvalues: u6 (copy)
        if u6._status == "Cancelled" then
            return;
        end;

        local v8, v9 = xpcall(u6._func, function(p7) -- Line: 65, Name: errorHandler
            return debug.traceback(tostring(p7), 2);
        end, table.unpack(u6._args));

        if u6._status == "Cancelled" then
            return;
        end;

        if v8 then
            u6._status = "Completed";
            u6._result = v9;
            u6.OnCompleted:Fire(v9);
        else
            u6._status = "Failed";
            u6._error = v9;
            warn("Task failed with error:\n" .. u6._error);
            u6.OnFailed:Fire(u6._error);
        end;

        task.defer(function() -- Line: 85
            -- upvalues: u6 (ref)
            task.wait(0.1);

            if u6.OnCompleted and u6.OnCompleted.Destroy then
                u6.OnCompleted:Destroy();
            end;

            if u6.OnFailed and u6.OnFailed.Destroy then
                u6.OnFailed:Destroy();
            end;

            if u6.OnCancelled and u6.OnCancelled.Destroy then
                u6.OnCancelled:Destroy();
            end;
        end);
    end);

    return u6;
end;

function u1.Cancel(p10) -- Line: 103
    if p10._status == "Completed" or p10._status == "Failed" then
        return false;
    end;

    if p10._status == "Cancelled" then
        return false;
    end;

    p10._status = "Cancelled";

    if p10._thread then
        task.cancel(p10._thread);
    end;

    p10.OnCancelled:Fire();

    if p10.OnCompleted and p10.OnCompleted.Destroy then
        p10.OnCompleted:Destroy();
    end;

    if p10.OnFailed and p10.OnFailed.Destroy then
        p10.OnFailed:Destroy();
    end;

    if p10.OnCancelled and p10.OnCancelled.Destroy then
        p10.OnCancelled:Destroy();
    end;

    return true;
end;

function u1.IsAlive(p11) -- Line: 135
    return p11._status == "Pending" and true or p11._status == "Running";
end;

function u1.GetStatus(p12) -- Line: 140
    return p12._status;
end;

function u1.Await(p13) -- Line: 145
    if p13._status == "Completed" then
        return p13._result;
    end;

    if p13._status == "Failed" or p13._status == "Cancelled" then
        return nil;
    end;

    local u14 = false;
    local u15 = nil;
    local v17 = p13.OnCompleted:Connect(function(p16) -- Line: 158
        -- upvalues: u15 (ref), u14 (ref)
        u15 = p16;
        u14 = true;
    end);
    local v18 = p13.OnFailed:Connect(function() -- Line: 163
        -- upvalues: u14 (ref)
        u14 = true;
    end);
    local v19 = p13.OnCancelled:Connect(function() -- Line: 167
        -- upvalues: u14 (ref)
        u14 = true;
    end);

    while not u14 do
        task.wait();
    end;

    v17:Disconnect();
    v18:Disconnect();
    v19:Disconnect();

    return u15;
end;

function u1.Then(p20: table, p21: function) -- Line: 183
    p20.OnCompleted:Connect(p21);

    return p20;
end;

function u1.Catch(p22: table, p23: function) -- Line: 189
    p22.OnFailed:Connect(p23);

    return p22;
end;

function u1.Finally(p24: table, p25: function) -- Line: 195
    p24.OnCompleted:Connect(p25);
    p24.OnFailed:Connect(p25);
    p24.OnCancelled:Connect(p25);

    return p24;
end;

function u1.WhenAll(u26: table) -- Line: 203
    -- upvalues: u1 (copy)
    return u1.run(function() -- Line: 204
        -- upvalues: u26 (copy)
        local table_create_ret = table.create(#u26);
        local u27 = 0;
        local v28 = #u26;

        if v28 == 0 then
            return table_create_ret;
        end;

        for i, v in u26 do
            task.spawn(function() -- Line: 214
                -- upvalues: table_create_ret (copy), i (copy), v (copy), u27 (ref)
                table_create_ret[i] = v:Await();
                u27 = u27 + 1;
            end);
        end;

        while u27 < v28 do
            task.wait();
        end;

        return table_create_ret;
    end);
end;

function u1.WhenAny(p29: table) -- Line: 230
    if #p29 == 0 then
        return nil;
    end;

    local u30 = false;
    local u31 = nil;

    for _, v in ipairs(p29) do
        task.spawn(function() -- Line: 239
            -- upvalues: u30 (ref), v (copy), u31 (ref)
            if not u30 then
                local v32 = v:Await();

                if not u30 then
                    u30 = true;
                    u31 = v32;
                end;
            end;
        end);
    end;

    while not u30 do
        task.wait();
    end;

    return u31;
end;

function u1.Delay(u33: number) -- Line: 259
    -- upvalues: u1 (copy)
    return u1.new(function() -- Line: 260
        -- upvalues: u33 (copy)
        task.wait(u33);
    end);
end;

function u1.FromTween(u34: userdata) -- Line: 266
    -- upvalues: u1 (copy)
    local v35 = u1.new(function() -- Line: 267
        -- upvalues: u34 (copy)
        if u34.PlaybackState == Enum.PlaybackState.Completed then
            return;
        end;

        if u34.PlaybackState ~= Enum.PlaybackState.Playing then
            u34:Play();
        end;

        u34.Completed:Wait();
    end);
    v35.OnCancelled:Connect(function() -- Line: 279
        -- upvalues: u34 (copy)
        if u34.PlaybackState == Enum.PlaybackState.Playing then
            u34:Cancel();
        end;
    end);

    if u34.PlaybackState ~= Enum.PlaybackState.Begin then
        v35:Start();
    end;

    return v35;
end;

function u1.FromResult(u36) -- Line: 294
    -- upvalues: u1 (copy)
    local v37 = u1.new(function() -- Line: 295
        -- upvalues: u36 (copy)
        return u36;
    end);
    v37:Start();

    return v37;
end;

function u1.StartAll(p38: table) -- Line: 302
    for _, v in p38 do
        v:Start();
    end;
end;

function u1.RunSequence(p39: table) -- Line: 309
    local v40 = {};

    for i, v in ipairs(p39) do
        v40[i] = v():Await();
    end;

    return v40;
end;

function u1.CancelAll(p41: table) -- Line: 321
    for _, v in ipairs(p41) do
        v:Cancel();
    end;
end;

return u1;