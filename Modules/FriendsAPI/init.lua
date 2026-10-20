-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.Modules.Signal);
local script_Remote = require(script.Remote);
local u1 = RunService:IsServer();
local u2 = RunService:IsClient();
local u3 = Signal.new();
local u4 = {};
local u5 = {};
local u6 = {};
local u7;

if u2 then
    u7 = Players.LocalPlayer;
else
    u7 = nil;
end;

local v8 = {
    _updateSignal = u3,
    _playerMaps = u5
};

local function getFriendMap(p9: userdata) -- Line: 27
    -- upvalues: u5 (copy)
    local v10 = u5[p9.UserId];

    if not v10 then
        v10 = {};
        u5[p9.UserId] = v10;
    end;

    return v10;
end;

local function getClientFriendMap(p11: userdata) -- Line: 37
    -- upvalues: u6 (copy)
    local v12 = u6[p11.UserId];

    if not v12 then
        v12 = {};
        u6[p11.UserId] = v12;
    end;

    return v12;
end;

local function getRequestMap(p13: userdata) -- Line: 47
    -- upvalues: u4 (copy)
    local v14 = u4[p13];

    if not v14 then
        v14 = {};
        u4[p13] = v14;
    end;

    return v14;
end;

local function fetchIsFriendsWith(p15: userdata, p16: number) -- Line: 57
    -- upvalues: RunService (copy)
    return p15.UserId < 0 and p16 < 0 and true or (RunService:IsStudio() and true or p15:IsFriendsWith(p16));
end;

local function getRawFriendState(p17: userdata, p18: number) -- Line: 69
    -- upvalues: Players (copy), u5 (copy), u6 (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p18);

    if not PlayerByUserId then
        local v19 = u5[p17.UserId];

        if not v19 then
            v19 = {};
            u5[p17.UserId] = v19;
        end;

        return v19[p18] == true;
    end;

    local v20 = u5[PlayerByUserId.UserId];

    if not v20 then
        v20 = {};
        u5[PlayerByUserId.UserId] = v20;
    end;

    if not v20[p17.UserId] then
        local v21 = u5[p17.UserId];

        if not v21 then
            v21 = {};
            u5[p17.UserId] = v21;
        end;

        if not v21[PlayerByUserId.UserId] then
            local v22 = u6[PlayerByUserId.UserId];

            if not v22 then
                v22 = {};
                u6[PlayerByUserId.UserId] = v22;
            end;

            local v23 = false;
            local v24 = u6[p17.UserId];

            if not v24 then
                v24 = {};
                u6[p17.UserId] = v24;
            end;

            if v24[p18] == true then
                if v22 == nil then
                    v23 = false;
                else
                    v23 = v22[p17.UserId] == true;
                end;
            end;

            return v23;
        end;
    end;

    return true;
end;

local function handleFriendState(p25: userdata, p26: number, p27: boolean?) -- Line: 89
    -- upvalues: u5 (copy), getRawFriendState (copy), u3 (copy), u1 (copy), script_Remote (copy), Players (copy)
    if p26 == p25.UserId then
        return;
    end;

    local v28 = u5[p25.UserId];

    if not v28 then
        v28 = {};
        u5[p25.UserId] = v28;
    end;

    if v28[p26] == p27 then
        return;
    end;

    v28[p26] = p27;
    local v29 = getRawFriendState(p25, p26);
    u3:Fire(p25, p26, v29);

    if u1 then
        script_Remote.Update:FireClient(p25, p26, v29);
        local PlayerByUserId = Players:GetPlayerByUserId(p26);

        if PlayerByUserId then
            script_Remote.Update:FireClient(PlayerByUserId, p25.UserId, v29);
        end;
    end;
end;

local function handleClientState(p30: userdata, p31: number, p32: boolean?) -- Line: 114
    -- upvalues: u6 (copy), Players (copy), handleFriendState (copy)
    if p31 == p30.UserId then
        return;
    end;

    local v33 = u6[p30.UserId];

    if not v33 then
        v33 = {};
        u6[p30.UserId] = v33;
    end;

    if v33[p31] == p32 then
        return;
    end;

    v33[p31] = p32;
    local PlayerByUserId = Players:GetPlayerByUserId(p31);

    if p32 and PlayerByUserId then
        local v34 = u6[PlayerByUserId.UserId];

        if not v34 then
            v34 = {};
            u6[PlayerByUserId.UserId] = v34;
        end;

        if v34[p30.UserId] then
            handleFriendState(p30, p31, true);
        end;
    end;
end;

local function updatePlayer(p35: userdata, u36: number) -- Line: 138
    -- upvalues: u2 (copy), u4 (copy), Players (copy), fetchIsFriendsWith (copy), handleFriendState (copy)
    if u2 then
        return;
    end;

    local u37 = u4[p35];

    if not u37 then
        u37 = {};
        u4[p35] = u37;
    end;

    local v38;

    if u37 then
        v38 = u37[u36];
    else
        v38 = u37;
    end;

    local v39 = os.clock() + 15;
    local v40 = false;

    while u37 and u37[u36] do
        if v39 < os.clock() then
            u37[u36] = nil;
            v40 = true;
            break;
        end;

        task.wait();
    end;

    if v38 and not v40 then
        return;
    end;

    if not p35:IsDescendantOf(Players) then
        return;
    end;

    local u41 = {};
    u37[u36] = u41;

    local function release() -- Line: 177
        -- upvalues: u37 (copy), u36 (copy), u41 (copy)
        if u37[u36] == u41 then
            u37[u36] = nil;
        end;
    end;

    local success, result = pcall(fetchIsFriendsWith, p35, u36);

    if not success then
        warn((`FriendsAPI: Failed to request: {result}`));

        if u37[u36] == u41 then
            u37[u36] = nil;
        end;

        return;
    end;

    local success2 = pcall(handleFriendState, p35, u36, result);

    if u37[u36] == u41 then
        u37[u36] = nil;
    end;

    if not success2 then
        warn((`FriendsAPI: Failed to apply friend state for {p35.UserId} -> {u36}`));
    end;
end;

local function internalIsFriendsWith(p42: userdata, p43: number, p44: boolean?) -- Line: 206
    -- upvalues: u2 (copy), u7 (copy), u5 (copy), Players (copy), updatePlayer (copy), getRawFriendState (copy)
    local v45 = p44 ~= false;

    if u2 and p42 ~= u7 then
        error("FriendsAPI:IsFriendsWithByUserId | this function can only be used with LocalPlayer in the Client");
    end;

    local v46 = u5[p42.UserId];

    if not v46 then
        v46 = {};
        u5[p42.UserId] = v46;
    end;

    if u2 then
        return v46[p43] == true;
    end;

    if Players:GetPlayerByUserId(p43) then
        return getRawFriendState(p42, p43);
    end;

    if v46[p43] == nil then
        if v45 then
            updatePlayer(p42, p43);
        else
            task.spawn(updatePlayer, p42, p43);
        end;
    end;

    return v46[p43] == true;
end;

local function startServer() -- Line: 237
    -- upvalues: Players (copy), updatePlayer (copy), script_Remote (copy), handleClientState (copy)
    local function onPlayerAdded(p47: userdata) -- Line: 239
        -- upvalues: Players (ref), updatePlayer (ref)
        for _, v in Players:GetPlayers() do
            if v ~= p47 then
                updatePlayer(p47, v.UserId);
            end;
        end;
    end;

    Players.PlayerAdded:Connect(onPlayerAdded);

    for _, v in Players:GetPlayers() do
        task.spawn(onPlayerAdded, v);
    end;

    script_Remote.Update.OnServerEvent:Connect(function(p48: userdata, p49: userdata, p50: boolean) -- Line: 254
        -- upvalues: handleClientState (ref)
        if typeof(p49) ~= "Instance" or (not p49:IsA("Player") or p49 == p48) then
            return;
        end;

        if p50 ~= nil and type(p50) ~= "boolean" then
            return;
        end;

        handleClientState(p48, p49.UserId, p50);
    end);
end;

local function startClient() -- Line: 268
    -- upvalues: script_Remote (copy), handleFriendState (copy), u7 (copy)
    script_Remote.Update.OnClientEvent:Connect(function(p51: any, p52: boolean?) -- Line: 270
        -- upvalues: handleFriendState (ref), u7 (ref)
        handleFriendState(u7, p51, p52);
    end);
    local StarterGui = game:GetService("StarterGui");

    for i = 1, 5 do
        if pcall(function() -- Line: 279
            -- upvalues: StarterGui (copy), script_Remote (ref)
            StarterGui:GetCore("PlayerFriendedEvent").Event:Connect(function(p53: userdata) -- Line: 283
                -- upvalues: script_Remote (ref)
                script_Remote.Update:FireServer(p53, true);
            end);
        end) then
            break;
        end;

        task.wait(5);
        local _ = i;
    end;
end;

local function startShared() -- Line: 302
    -- upvalues: Players (copy), u4 (copy), u5 (copy), u6 (copy)
    Players.PlayerRemoving:Connect(function(p54: userdata) -- Line: 303
        -- upvalues: u4 (ref), u5 (ref), u6 (ref)
        u4[p54] = nil;
        u5[p54.UserId] = nil;
        u6[p54.UserId] = nil;
    end);
end;

function v8.OnFriendshipUpdate(p55: table, u56: userdata, u57: function) -- Line: 312
    -- upvalues: u3 (copy)
    return u3:Connect(function(p58: userdata, p59: number, p60: boolean?) -- Line: 313
        -- upvalues: u56 (copy), u57 (copy)
        if p58 ~= u56 and p59 ~= u56.UserId then
            return;
        end;

        if u56.UserId == p59 then
            u57(u56.UserId, p60);

            return;
        end;

        u57(p59, p60);
    end);
end;

function v8.IsFriendsWithImmediate(p61: table, p62: userdata, p63: any) -- Line: 326
    -- upvalues: internalIsFriendsWith (copy)
    if typeof(p63) == "Instance" then
        p63 = p63.UserId;
    end;

    return internalIsFriendsWith(p62, p63, false);
end;

function v8.IsFriendsWith(p64: table, p65: userdata, p66: any) -- Line: 330
    -- upvalues: internalIsFriendsWith (copy)
    if typeof(p66) == "Instance" then
        p66 = p66.UserId;
    end;

    return internalIsFriendsWith(p65, p66, true);
end;

function v8.IsFriendsWithAwait(p67: table, p68: userdata, p69: any) -- Line: 348
    -- upvalues: Players (copy), u1 (copy), u5 (copy), updatePlayer (copy), internalIsFriendsWith (copy)
    if typeof(p69) == "Instance" then
        p69 = p69.UserId;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p69);

    if u1 and PlayerByUserId then
        local v70 = u5[p68.UserId];

        if not v70 then
            v70 = {};
            u5[p68.UserId] = v70;
        end;

        if v70[p69] == nil then
            local v71 = u5[PlayerByUserId.UserId];

            if not v71 then
                v71 = {};
                u5[PlayerByUserId.UserId] = v71;
            end;

            if v71[p68.UserId] == nil then
                updatePlayer(p68, p69);
            end;
        end;
    end;

    local v72 = internalIsFriendsWith(p68, p69, true);
    local v73 = not u1;

    if not v73 then
        v73 = true;
        local v74 = u5[p68.UserId];

        if not v74 then
            v74 = {};
            u5[p68.UserId] = v74;
        end;

        if v74[p69] == nil then
            if PlayerByUserId == nil then
                v73 = false;
            else
                local v75 = u5[PlayerByUserId.UserId];

                if not v75 then
                    v75 = {};
                    u5[PlayerByUserId.UserId] = v75;
                end;

                v73 = v75[p68.UserId] ~= nil;
            end;
        end;
    end;

    return v72, v73;
end;

if u1 then
    task.spawn(startServer);
else
    task.spawn(startClient);
end;

task.spawn(startShared);

return v8;