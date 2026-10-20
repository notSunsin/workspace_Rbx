-- Decompiled with Potassium's decompiler.

local u1 = {
    QR = true,
    Aborted = false,
    Queue = {},
    Process = 0
};
local u2 = {};
task.spawn(function() -- Line: 9
    -- upvalues: u1 (copy), u2 (copy)
    while u1.QR do
        task.wait();

        if #u1.Queue > 0 then
            local u3 = u1.Queue[1];
            table.remove(u1.Queue, 1);

            if not u2[u3.Key] then
                u2[u3.Key] = 0;
            end;

            local v4 = u1;
            v4.Process = v4.Process + 1;
            local v5 = u3.Delay + u2[u3.Key] - DateTime.now().UnixTimestamp;
            task.delay(v5 <= 0 and 0 or v5, function() -- Line: 24
                -- upvalues: u1 (ref), u2 (ref), u3 (copy)
                local v6 = nil;
                local v7 = nil;
                local v8 = nil;

                for i = 1, 3 do
                    if u1.Aborted then
                        break;
                    end;

                    u2[u3.Key] = DateTime.now().UnixTimestamp;
                    v6, v7, v8 = pcall(u3.Func);

                    if v6 then
                        break;
                    end;

                    warn(v7);
                    local v9;

                    if i < 3 then
                        task.wait((u3.Delay or 7) * 2 ^ (i - 1) * (1 + 0.15 * math.random()));
                        v9 = i;
                    else
                        v9 = i;
                    end;
                end;

                u3.Event:Fire(v6, v7, v8);
                local v10 = u1;
                v10.Process = v10.Process - 1;
                u2[u3.Key] = DateTime.now().UnixTimestamp;
            end);
        end;
    end;
end);

function u1.AddRequest(p11, p12, p13) -- Line: 46
    -- upvalues: u1 (copy)
    local BindableEvent = Instance.new("BindableEvent");
    table.insert(u1.Queue, {
        Key = p11,
        Delay = p13,
        Func = p12,
        Event = BindableEvent
    });
    local v14, v15, v16 = BindableEvent.Event:Wait();

    return v14, v15, v16;
end;

function u1.RemoveKey(p17) -- Line: 60
    -- upvalues: u2 (copy)
    u2[p17] = nil;
end;

return u1;