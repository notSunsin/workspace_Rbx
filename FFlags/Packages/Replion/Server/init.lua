-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Freeze = require(script.Parent.Parent.Freeze);
local Utils = require(script.Parent.Internal.Utils);
local Network = require(script.Parent.Internal.Network);
local script_ServerReplion = require(script.ServerReplion);
local Signal = require(script.Parent.Parent.Signal);
require(script.Parent.Internal.Types);
local u1 = Signal.new();
local u2 = Signal.new();
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};

local function getCache(p7, p8) -- Line: 62
    local v9 = p7[p8];

    if not v9 then
        v9 = {};
        p7[p8] = v9;
    end;

    return v9;
end;

local function cancelWait(p10: table, p11: thread) -- Line: 73
    -- upvalues: Utils (copy), u6 (copy)
    for i, v in p10 do
        if v.thread == p11 then
            table.remove(p10, i);

            if v.async then
                Utils.safeCancelThread(p11);
            else
                pcall(task.spawn, p11);
            end;

            u6[p11] = nil;

            return;
        end;
    end;
end;

local function createTimeout(p12: table, p13: number, p14: thread) -- Line: 94
    -- upvalues: cancelWait (copy)
    return task.delay(p13, cancelWait, p12, p14);
end;

local u84 = {
    new = function(p15) -- Line: 112, Name: new
        -- upvalues: u3 (copy), script_ServerReplion (copy), u2 (copy), u5 (copy), u1 (copy), Utils (copy), u4 (copy), u6 (copy)
        local u16 = assert(p15.Channel, "Channel is required!");
        local v17 = u3;
        local u18 = v17[u16];

        if not u18 then
            u18 = {};
            v17[u16] = u18;
        end;

        local ReplicateTo = p15.ReplicateTo;

        for _, v in u18 do
            local ReplicateTo2 = v.ReplicateTo;
            local v19 = ReplicateTo2 == ReplicateTo;

            if not (v19 or (type(ReplicateTo2) ~= "table" or type(ReplicateTo) ~= "table")) then
                for _, v2 in ReplicateTo2 do
                    v19 = table.find(ReplicateTo, v2) ~= nil;

                    if v19 then
                        break;
                    end;
                end;
            end;

            if v19 then
                local v20 = nil;

                if typeof(ReplicateTo2) == "Instance" or typeof(v20) == "userdata" then
                    v20 = tostring(ReplicateTo2);
                elseif type(ReplicateTo2) == "string" then
                    v20 = ReplicateTo2;
                elseif type(ReplicateTo2) == "table" then
                    for _, v2 in ReplicateTo2 do
                        v20 = (not v20 and "" or v20 .. ", ") .. tostring(v2);
                    end;
                end;

                error((`Channel "{u16}" already exists! for "{v20}"`));
            end;
        end;

        local u21 = script_ServerReplion.new(p15);
        u21:BeforeDestroy(function() -- Line: 151
            -- upvalues: u18 (copy), u21 (ref), u3 (ref), u16 (copy), u2 (ref)
            u18[u21._id] = nil;

            if not next(u18) then
                u3[u16] = nil;
            end;

            u2:Fire(u16, u21);
            u21 = nil;
        end);
        u21._replicateToChanged:Connect(function(p22, p23) -- Line: 164
            -- upvalues: u5 (ref), u16 (copy), u21 (ref)
            if typeof(p23) == "Player" then
                local v24 = u5[p23];

                if not v24 then
                    return;
                end;

                v24[u16] = nil;
            elseif typeof(p23) == "table" then
                for _, v in p23 do
                    local v25 = u5[v];

                    if v25 then
                        v25[u16] = nil;
                    end;
                end;
            end;

            if typeof(p22) ~= "Player" then
                if typeof(p22) == "table" then
                    for _, v in p22 do
                        local v26 = u5;
                        local v27 = v26[v];

                        if not v27 then
                            v27 = {};
                            v26[v] = v27;
                        end;

                        v27[u16] = u21._id;
                    end;
                end;

                return;
            end;

            local v28 = u5;
            local v29 = v28[p22];

            if not v29 then
                v29 = {};
                v28[p22] = v29;
            end;

            v29[u16] = u21._id;
        end);
        u18[u21._id] = u21;
        u1:Fire(u16, u21);

        if typeof(ReplicateTo) == "Instance" or Utils.ShouldMock and typeof(ReplicateTo) == "userdata" then
            local v30 = u5;
            local v31 = v30[ReplicateTo];

            if not v31 then
                v31 = {};
                v30[ReplicateTo] = v31;
            end;

            v31[u16] = u21._id;
        elseif type(ReplicateTo) == "table" then
            for _, v in ReplicateTo do
                local v32 = u5;
                local v33 = v32[v];

                if not v33 then
                    v33 = {};
                    v32[v] = v33;
                end;

                v33[u16] = u21._id;
            end;
        end;

        local v34 = u4[u16];

        if not v34 then
            return u21;
        end;

        for i = #v34, 1, -1 do
            local v35 = v34[i];
            local thread = v35.thread;
            local player = v35.player;
            local v36, v37;

            if player then
                local v38 = false;

                if typeof(ReplicateTo) == "Instance" or typeof(ReplicateTo) == "userdata" then
                    v38 = ReplicateTo == player;
                elseif type(ReplicateTo) == "table" then
                    v38 = table.find(ReplicateTo, player) ~= nil;
                end;

                if v38 then
                    v36 = u6[thread];

                    if v36 then
                        Utils.safeCancelThread(v36);
                        u6[thread] = nil;
                    end;

                    if coroutine.status(thread) == "suspended" then
                        task.spawn(thread, u21);
                    end;

                    table.remove(v34, i);
                    v37 = i;
                else
                    v37 = i;
                end;
            else
                v36 = u6[thread];

                if v36 then
                    Utils.safeCancelThread(v36);
                    u6[thread] = nil;
                end;

                if coroutine.status(thread) == "suspended" then
                    task.spawn(thread, u21);
                end;

                table.remove(v34, i);
                v37 = i;
            end;
        end;

        return u21;
    end,

    GetReplion = function(p39: table, p40: string) -- Line: 253, Name: GetReplion
        -- upvalues: u3 (copy), Freeze (copy)
        local v41 = u3[p40];

        if not v41 then
            return nil;
        end;

        local v42 = Freeze.Dictionary.count(v41) == 1;
        local v43 = `There are multiple replions with the channel "{p40}". Did you mean to use GetReplionFor?`;
        assert(v42, v43);
        local _, v44 = next(v41);

        return v44;
    end,

    GetReplionFor = function(p45, p46, p47) -- Line: 274, Name: GetReplionFor
        -- upvalues: u3 (copy), u5 (copy)
        local v48 = u3[p47];

        if not v48 then
            return;
        end;

        local v49 = u5[p46];

        if v49 then
            return v48[v49[p47]];
        end;
    end,

    GetReplionsFor = function(p50, p51) -- Line: 293, Name: GetReplionsFor
        -- upvalues: u3 (copy)
        local v52 = {};

        for _, v in u3 do
            for _, v2 in v do
                local ReplicateTo = v2.ReplicateTo;
                local v53 = ReplicateTo == "All";

                if not v53 then
                    if type(ReplicateTo) == "table" then
                        v53 = table.find(ReplicateTo, p51) ~= nil;
                    else
                        v53 = ReplicateTo == p51 and true or v53;
                    end;
                end;

                if v53 then
                    table.insert(v52, v2);
                end;
            end;
        end;

        return v52;
    end,

    WaitReplion = function(p54, p55, p56) -- Line: 326, Name: WaitReplion
        -- upvalues: u4 (copy), u6 (copy), cancelWait (copy)
        local Replion = p54:GetReplion(p55);

        if Replion then
            return Replion;
        end;

        local coroutine_running_ret = coroutine.running();
        local v57 = u4;
        local v58 = v57[p55];

        if not v58 then
            v58 = {};
            v57[p55] = v58;
        end;

        if p56 then
            u6[coroutine_running_ret] = task.delay(p56, cancelWait, v58, coroutine_running_ret);
        end;

        table.insert(v58, {
            thread = coroutine_running_ret
        });

        return coroutine.yield();
    end,

    WaitReplionFor = function(p59, p60, p61, p62) -- Line: 353, Name: WaitReplionFor
        -- upvalues: Players (copy), u4 (copy), u6 (copy), cancelWait (copy)
        local ReplionFor = p59:GetReplionFor(p60, p61);

        if ReplionFor then
            return ReplionFor;
        end;

        if typeof(p60) == "Instance" and not p60:IsDescendantOf(Players) then
            if _G.__DEV__ then
                local debug_info_ret, v63 = debug.info(2, "sl");
                warn((`Warning: Trying to wait for a player that is not in the game at {debug_info_ret}:{v63}`));
            end;

            return nil;
        end;

        local coroutine_running_ret = coroutine.running();
        local v64 = u4;
        local v65 = v64[p61];

        if not v65 then
            v65 = {};
            v64[p61] = v65;
        end;

        if p62 then
            u6[coroutine_running_ret] = task.delay(p62, cancelWait, v65, coroutine_running_ret);
        end;

        table.insert(v65, {
            thread = coroutine_running_ret,
            player = p60
        });

        return coroutine.yield();
    end,

    AwaitReplion = function(p66, p67, p68, p69) -- Line: 391, Name: AwaitReplion
        -- upvalues: u4 (copy), u6 (copy), cancelWait (copy)
        local Replion = p66:GetReplion(p67);

        if Replion then
            return p68(Replion);
        end;

        local v70 = u4;
        local u71 = v70[p67];

        if not u71 then
            u71 = {};
            v70[p67] = u71;
        end;

        local coroutine_create_ret = coroutine.create(p68);

        if p69 then
            u6[coroutine_create_ret] = task.delay(p69, cancelWait, u71, coroutine_create_ret);
        end;

        table.insert(u71, {
            async = true,
            thread = coroutine_create_ret
        });

        return function() -- Line: 406
            -- upvalues: cancelWait (ref), u71 (copy), coroutine_create_ret (copy)
            cancelWait(u71, coroutine_create_ret);
        end;
    end,

    AwaitReplionFor = function(p72, p73, p74, p75, p76) -- Line: 422, Name: AwaitReplionFor
        -- upvalues: u4 (copy), u6 (copy), cancelWait (copy)
        local ReplionFor = p72:GetReplionFor(p73, p74);

        if ReplionFor then
            return p75(ReplionFor);
        end;

        if typeof(p73) == "Instance" and p73.Parent == nil then
            if _G.__DEV__ then
                local debug_info_ret, v77 = debug.info(2, "sl");
                warn((`Warning: Trying to await for a player that is not in the game at {debug_info_ret}:{v77}`));
            end;

            return nil;
        end;

        local v78 = u4;
        local u79 = v78[p74];

        if not u79 then
            u79 = {};
            v78[p74] = u79;
        end;

        local coroutine_create_ret = coroutine.create(p75);

        if p76 then
            u6[coroutine_create_ret] = task.delay(p76, cancelWait, u79, coroutine_create_ret);
        end;

        table.insert(u79, {
            async = true,
            thread = coroutine_create_ret,
            player = p73
        });

        return function() -- Line: 447
            -- upvalues: cancelWait (ref), u79 (copy), coroutine_create_ret (copy)
            cancelWait(u79, coroutine_create_ret);
        end;
    end,

    OnReplionAdded = function(p80, p81) -- Line: 459, Name: OnReplionAdded
        -- upvalues: u1 (copy)
        return u1:Connect(p81);
    end,

    OnReplionRemoved = function(p82, p83) -- Line: 470, Name: OnReplionRemoved
        -- upvalues: u2 (copy)
        return u2:Connect(p83);
    end
};

if not Utils.ShouldMock and RunService:IsServer() then
    Network.create({ "Added", "Removed", "Update", "UpdateReplicateTo", "Set", "ArrayUpdate" });

    local function onPlayerAdded(p85) -- Line: 485
        -- upvalues: u84 (copy), Network (copy)
        local v86 = {};

        for _, v in u84:GetReplionsFor(p85) do
            table.insert(v86, v:_serialize());
        end;

        if #v86 > 0 then
            Network.sendTo(p85, "Added", v86);
        end;
    end;

    for _, v in Players:GetPlayers() do
        task.spawn(onPlayerAdded, v);
    end;

    Players.PlayerAdded:Connect(onPlayerAdded);
    Players.PlayerRemoving:Connect(function(u87) -- Line: 504
        -- upvalues: u3 (copy), Freeze (copy), u5 (copy), u4 (copy), Utils (copy), u6 (copy)
        local u88 = {};

        for _, v in u3 do
            for _, v2 in v do
                local ReplicateTo = v2.ReplicateTo;

                if ReplicateTo ~= "All" then
                    if type(ReplicateTo) == "table" then
                        v2:SetReplicateTo(Freeze.List.removeValue(ReplicateTo, u87));
                    elseif ReplicateTo == u87 then
                        if v2.DisableAutoDestroy then
                            v2:BeforeDestroy(function() -- Line: 523
                                -- upvalues: u88 (copy), v2 (copy), u5 (ref), u87 (copy)
                                local table_find_ret = table.find(u88, v2);

                                if not table_find_ret then
                                    return;
                                end;

                                table.remove(u88, table_find_ret);

                                if #u88 == 0 then
                                    u5[u87] = nil;
                                end;
                            end);
                            table.insert(u88, v2);
                        else
                            v2:Destroy();
                        end;
                    end;
                end;
            end;
        end;

        if #u88 == 0 then
            u5[u87] = nil;
        end;

        for i, v in u4 do
            local v89 = i;
            local v90 = v;

            for i2 = #v, 1, -1 do
                local v91 = v90[i2];
                local thread = v91.thread;
                local v92;

                if v91.player == u87 then
                    if v91.async then
                        Utils.safeCancelThread(thread);
                    else
                        pcall(task.spawn, thread);
                    end;

                    u6[thread] = nil;
                    table.remove(v90, i2);
                    v92 = i2;
                else
                    v92 = i2;
                end;
            end;

            if #v90 == 0 then
                u4[v89] = nil;
            end;
        end;
    end);
end;

return u84;