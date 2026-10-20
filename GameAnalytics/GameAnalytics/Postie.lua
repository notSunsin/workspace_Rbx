-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

if not ReplicatedStorage:FindFirstChild("PostieSent") then
    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = "PostieSent";
    RemoteEvent.Parent = ReplicatedStorage;
end;

if not ReplicatedStorage:FindFirstChild("PostieReceived") then
    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = "PostieReceived";
    RemoteEvent.Parent = ReplicatedStorage;
end;

local PostieSent = ReplicatedStorage.PostieSent;
local PostieReceived = ReplicatedStorage.PostieReceived;
local u1 = RunService:IsServer();
local u2 = {};
local u3 = {};
local v19 = {
    invokeClient = function(p4: string, u5: userdata, p6: number, ...) -- Line: 81, Name: invokeClient
        -- upvalues: u1 (copy), HttpService (copy), u3 (copy), PostieSent (copy)
        assert(u1, "Postie.invokeClient can only be called from the server");
        local coroutine_running_ret = coroutine.running();
        local u7 = false;
        local u8 = HttpService:GenerateGUID(false);

        u3[u8] = function(p9, p10, ...) -- Line: 89
            -- upvalues: u5 (copy), u7 (ref), u3 (ref), u8 (copy), coroutine_running_ret (copy)
            if p9 ~= u5 then
                return;
            end;

            u7 = true;
            u3[u8] = nil;

            if p10 then
                task.spawn(coroutine_running_ret, true, ...);

                return;
            end;

            task.spawn(coroutine_running_ret, false);
        end;

        task.delay(p6, function() -- Line: 104
            -- upvalues: u7 (ref), u3 (ref), u8 (copy), coroutine_running_ret (copy)
            if u7 then
                return;
            end;

            u3[u8] = nil;
            task.spawn(coroutine_running_ret, false);
        end);
        PostieSent:FireClient(u5, p4, u8, ...);

        return coroutine.yield();
    end,

    invokeServer = function(p11: string, p12: number, ...) -- Line: 118, Name: invokeServer
        -- upvalues: u1 (copy), HttpService (copy), u3 (copy), PostieSent (copy)
        assert(not u1, "Postie.invokeServer can only be called from the client");
        local coroutine_running_ret = coroutine.running();
        local u13 = false;
        local u14 = HttpService:GenerateGUID(false);

        u3[u14] = function(p15, ...) -- Line: 126
            -- upvalues: u13 (ref), u3 (ref), u14 (copy), coroutine_running_ret (copy)
            u13 = true;
            u3[u14] = nil;

            if p15 then
                task.spawn(coroutine_running_ret, true, ...);

                return;
            end;

            task.spawn(coroutine_running_ret, false);
        end;

        task.delay(p12, function() -- Line: 137
            -- upvalues: u13 (ref), u3 (ref), u14 (copy), coroutine_running_ret (copy)
            if u13 then
                return;
            end;

            u3[u14] = nil;
            task.spawn(coroutine_running_ret, false);
        end);
        PostieSent:FireServer(p11, u14, ...);

        return coroutine.yield();
    end,

    setCallback = function(p16: string, p17: function?) -- Line: 151, Name: setCallback
        -- upvalues: u2 (copy)
        u2[p16] = p17;
    end,

    getCallback = function(p18: string) -- Line: 155, Name: getCallback
        -- upvalues: u2 (copy)
        return u2[p18];
    end
};

if u1 then
    PostieReceived.OnServerEvent:Connect(function(p20, p21, p22, ...) -- Line: 161
        -- upvalues: u3 (copy)
        local v23 = u3[p21];

        if not v23 then
            return;
        end;

        v23(p20, p22, ...);
    end);
    PostieSent.OnServerEvent:Connect(function(p24, p25, p26, ...) -- Line: 170
        -- upvalues: u2 (copy), PostieReceived (copy)
        local v27 = u2[p25];

        if v27 then
            PostieReceived:FireClient(p24, p26, true, v27(p24, ...));

            return;
        end;

        PostieReceived:FireClient(p24, p26, false);
    end);

    return v19;
end;

PostieReceived.OnClientEvent:Connect(function(p28, p29, ...) -- Line: 180
    -- upvalues: u3 (copy)
    local v30 = u3[p28];

    if not v30 then
        return;
    end;

    v30(p29, ...);
end);
PostieSent.OnClientEvent:Connect(function(p31, p32, ...) -- Line: 189
    -- upvalues: u2 (copy), PostieReceived (copy)
    local v33 = u2[p31];

    if v33 then
        PostieReceived:FireServer(p32, true, v33(...));

        return;
    end;

    PostieReceived:FireServer(p32, false);
end);

return v19;