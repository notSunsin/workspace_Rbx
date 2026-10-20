-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Utils = require(script.Parent.Internal.Utils);
local Signal = require(script.Parent.Parent.Signal);
local Network = require(script.Parent.Internal.Network);
local script_ClientReplion = require(script.ClientReplion);
require(script.Parent.Internal.Types);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = Signal.new();
local u5 = Signal.new();

local function getWaitList(p6: string) -- Line: 48
    -- upvalues: u2 (copy)
    local v7 = u2[p6];

    if not v7 then
        v7 = {};
        u2[p6] = v7;
    end;

    return assert(v7, "Invalid wait list");
end;

local function cancelWait(p8: table, p9: thread) -- Line: 58
    -- upvalues: Utils (copy), u3 (copy)
    for i, v in p8 do
        if v.thread == p9 then
            table.remove(p8, i);

            if v.async then
                Utils.safeCancelThread(p9);
            else
                pcall(task.spawn, p9);
            end;

            u3[p9] = nil;

            return;
        end;
    end;
end;

local function createTimeout(p10: table, p11: number, p12: thread) -- Line: 79
    -- upvalues: cancelWait (copy)
    return task.delay(p11, cancelWait, p10, p12);
end;

local function createReplion(p13) -- Line: 83
    -- upvalues: u1 (copy), script_ClientReplion (copy), u4 (copy), u2 (copy)
    local v14 = p13[2];

    if u1[v14] then
        return;
    end;

    local v15 = script_ClientReplion.new(p13);
    u1[v14] = v15;
    u1[p13[1]] = v15;
    u4:Fire(v15);
    local v16 = u2[v14];

    if v16 then
        for _, v in v16 do
            pcall(task.spawn, v.thread, v15);
        end;

        u2[v14] = nil;
    end;
end;

local v44 = {
    OnReplionAdded = function(p17, p18) -- Line: 120, Name: OnReplionAdded
        -- upvalues: u4 (copy)
        return u4:Connect(p18);
    end,

    OnReplionRemoved = function(p19, p20) -- Line: 131, Name: OnReplionRemoved
        -- upvalues: u5 (copy)
        return u5:Connect(p20);
    end,

    OnReplionAddedWithTag = function(p21, u22, u23) -- Line: 143, Name: OnReplionAddedWithTag
        return p21:OnReplionAdded(function(p24) -- Line: 144
            -- upvalues: u22 (copy), u23 (copy)
            local Tags = p24.Tags;

            if Tags and table.find(Tags, u22) ~= nil then
                u23(p24);
            end;
        end);
    end,

    OnReplionRemovedWithTag = function(p25, u26, u27) -- Line: 161, Name: OnReplionRemovedWithTag
        return p25:OnReplionRemoved(function(p28) -- Line: 162
            -- upvalues: u26 (copy), u27 (copy)
            local Tags = p28.Tags;

            if Tags and table.find(Tags, u26) ~= nil then
                u27(p28);
            end;
        end);
    end,

    GetReplion = function(p29, p30) -- Line: 176, Name: GetReplion
        -- upvalues: u1 (copy)
        return u1[p30];
    end,

    WaitReplion = function(p31, p32, p33) -- Line: 188, Name: WaitReplion
        -- upvalues: u1 (copy), u2 (copy), u3 (copy), cancelWait (copy)
        local v34 = u1[p32];

        if v34 then
            return v34;
        end;

        local coroutine_running_ret = coroutine.running();
        local v35 = u2[p32];

        if not v35 then
            v35 = {};
            u2[p32] = v35;
        end;

        local v36 = assert(v35, "Invalid wait list");

        if p33 then
            u3[coroutine_running_ret] = task.delay(p33, cancelWait, v36, coroutine_running_ret);
        end;

        table.insert(v36, {
            thread = coroutine_running_ret
        });

        return coroutine.yield();
    end,

    AwaitReplion = function(p37, p38, p39, p40) -- Line: 216, Name: AwaitReplion
        -- upvalues: u1 (copy), u2 (copy), u3 (copy), cancelWait (copy)
        local v41 = u1[p38];

        if v41 then
            return p39(v41);
        end;

        local v42 = u2[p38];

        if not v42 then
            v42 = {};
            u2[p38] = v42;
        end;

        local u43 = assert(v42, "Invalid wait list");
        local coroutine_create_ret = coroutine.create(p39);

        if p40 then
            u3[coroutine_create_ret] = task.delay(p40, cancelWait, u43, coroutine_create_ret);
        end;

        table.insert(u43, {
            async = true,
            thread = coroutine_create_ret
        });

        return function() -- Line: 231
            -- upvalues: cancelWait (ref), u43 (copy), coroutine_create_ret (copy)
            cancelWait(u43, coroutine_create_ret);
        end;
    end
};

if not Utils.ShouldMock and RunService:IsClient() then
    local v45 = Network.get("Added");
    local v46 = Network.get("Removed");
    local v47 = Network.get("Update");
    local v48 = Network.get("Set");
    local v49 = Network.get("UpdateReplicateTo");
    local v50 = Network.get("ArrayUpdate");
    v45.OnClientEvent:Connect(function(p51) -- Line: 244
        -- upvalues: createReplion (copy)
        if type(p51[1]) == "table" then
            for _, v in p51 do
                createReplion(v);
            end;

            return;
        end;

        createReplion(p51);
    end);
    v46.OnClientEvent:Connect(function(p52: string) -- Line: 254
        -- upvalues: u1 (copy), u5 (copy)
        local v53 = u1[p52];

        if v53 then
            u1[p52] = nil;
            u1[v53._channel] = nil;
            u5:Fire(v53);
            v53:Destroy();
        end;
    end);
    v47.OnClientEvent:Connect(function(p54: string, p55: any, p56: any, p57: boolean?) -- Line: 267
        -- upvalues: u1 (copy)
        local v58 = u1[p54];

        if v58 then
            v58:_update(p55, p56, p57);
        end;
    end);
    v49.OnClientEvent:Connect(function(p59: string, p60: any) -- Line: 276
        -- upvalues: u1 (copy)
        local v61 = u1[p59];

        if v61 then
            v61.ReplicateTo = p60;
        end;
    end);
    v48.OnClientEvent:Connect(function(p62: string, p63: any, p64: any) -- Line: 284
        -- upvalues: u1 (copy)
        local v65 = u1[p62];

        if v65 then
            v65:_set(p63, p64);
        end;
    end);
    v50.OnClientEvent:Connect(function(p66: string, p67: string, ...) -- Line: 292
        -- upvalues: u1 (copy)
        local v68 = u1[p66];

        if v68 then
            if p67 == "i" then
                v68:_insert(...);

                return;
            end;

            if p67 == "r" then
                v68:_remove(...);

                return;
            end;

            if p67 == "c" then
                v68:_clear(...);
            end;
        end;
    end);
end;

return table.freeze(v44);