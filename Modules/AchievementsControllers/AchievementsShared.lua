-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local AchievementsData = require(ReplicatedStorage.Data.AchievementsData);
require(ReplicatedStorage.Data.DefaultData);
local u1;

if RunService:IsServer() then
    u1 = require(game:GetService("ServerScriptService").Modules.DataService);
else
    u1 = require(ReplicatedStorage.Modules.DataService);
end;

local LocalPlayer = Players.LocalPlayer;
local u2 = RunService:IsServer();
local u3 = RunService:IsStudio();
local u4 = {};

local function getPlayerData(p5: userdata) -- Line: 18
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy)
    if u2 then
        return u1:GetPlayerData(p5);
    end;

    if p5 == LocalPlayer then
        return u1:GetData();
    end;

    return nil;
end;

local function listenToPathSignal(p6: userdata, p7: any, p8: any) -- Line: 30
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy)
    if u2 then
        local PathSignal = u1:GetPathSignal(p6, p7);

        if PathSignal then
            return PathSignal:Connect(p8);
        end;

        return;
    end;

    if p6 ~= LocalPlayer then
        return nil;
    end;

    local PathSignal = u1:GetPathSignal(p7);

    if PathSignal then
        return PathSignal:Connect(p8);
    end;
end;

function u4.GetSeasonData(p9: table, p10: userdata, p11: number) -- Line: 52
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy), u3 (copy)
    local v12;

    if u2 then
        v12 = u1:GetPlayerData(p10);
    elseif p10 == LocalPlayer then
        v12 = u1:GetData();
    else
        v12 = nil;
    end;

    if v12 then
        return v12.Achievements.Seasons[`Season_{p11}`];
    end;

    if u3 then
        warn("AchievementsShared:GetSeasonData: player data not found");
    end;

    return nil;
end;

function u4.ValidateParameters(p13: table, p14: userdata, p15: string, p16: table) -- Line: 65
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy), u3 (copy), AchievementsData (copy), u4 (copy)
    local v17;

    if u2 then
        v17 = u1:GetPlayerData(p14);
    elseif p14 == LocalPlayer then
        v17 = u1:GetData();
    else
        v17 = nil;
    end;

    if not v17 then
        if u3 then
            warn("AchievementsShared:ValidateParameters: player data not found");
        end;

        return false;
    end;

    if type(p16) ~= "table" then
        if u3 then
            warn("AchievementsShared:ValidateParameters: arguments is not a table");
        end;

        return false;
    end;

    if p15 == "Season" then
        if #p16 ~= 1 then
            if u3 then
                warn((`AchievementsShared:ValidateParameters: arguments got unexpected length for {p15}, expected 1, got {#p16}`));
            end;

            return false;
        end;

        local v18 = tonumber(p16[1]);

        if v18 == nil then
            if u3 then
                warn("AchievementsShared:ValidateParameters: failed to parse first arguments as a number");
            end;

            return false;
        end;

        if AchievementsData.Seasons[v18] ~= nil then
            return true;
        end;

        if u3 then
            warn("AchievementsShared:ValidateParameters: failed to find season");
        end;

        return false;
    end;

    if p15 == "Set" then
        if #p16 ~= 2 then
            if u3 then
                warn((`AchievementsShared:ValidateParameters: arguments got unexpected length for {p15}, expected 2, got {#p16}`));
            end;

            return false;
        end;

        local v19 = p16[1];

        if not u4:ValidateParameters(p14, "Season", { v19 }) then
            return false;
        end;

        local v20 = p16[2];

        if type(v20) ~= "string" then
            if u3 then
                warn((`AchievementsShared:ValidateParameters: arguments got unexpected length for {p15}, expected 2, got {#p16}`));
            end;

            return false;
        end;

        local v21 = tonumber(v19);

        if AchievementsData.Seasons[v21].Sets[v20] then
            return true;
        end;

        if u3 then
            warn((`AchievementsShared:ValidateParameters: set {v20} doesn't exist for season {v19}`));
        end;

        return false;
    end;

    if p15 ~= "Quest" then
        return false;
    end;

    if #p16 ~= 3 then
        if u3 then
            warn((`AchievementsShared:ValidateParameters: arguments got unexpected length for {p15}, expected 3, got {#p16}`));
        end;

        return false;
    end;

    local v22 = p16[1];
    local v23 = p16[2];

    if not u4:ValidateParameters(p14, "Set", { v22, v23 }) then
        return false;
    end;

    local v24 = tonumber(v22);
    local Quests = AchievementsData.Seasons[v24].Sets[v23].Quests;
    local v25 = p16[3];

    if type(v25) == "string" then
        for _, v in Quests do
            if v.Id == v25 then
                return true;
            end;
        end;
    elseif type(v25) == "number" and Quests[v25] ~= nil then
        return true;
    end;

    return false;
end;

function u4.IsCompleted(p26: table, p27: userdata, p28: string, p29: table) -- Line: 185
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy), u3 (copy), u4 (copy), AchievementsData (copy)
    local v30;

    if u2 then
        v30 = u1:GetPlayerData(p27);
    elseif p27 == LocalPlayer then
        v30 = u1:GetData();
    else
        v30 = nil;
    end;

    if not v30 then
        if u3 then
            warn("AchievementsShared:IsCompleted: player data not found");
        end;

        return false;
    end;

    if type(p29) ~= "table" then
        if u3 then
            warn("AchievementsShared:IsCompleted: arguments is not a table");
        end;

        return false;
    end;

    if not u4:ValidateParameters(p27, p28, p29) then
        return false;
    end;

    local v31 = AchievementsData.Seasons[tonumber(p29[1])];
    local v32 = v30.Achievements.Seasons[`Season_{p29[1]}`];

    if v31 == nil or v32 == nil then
        if u3 then
            warn((`AchievementsShared:IsCompleted: Season doesn't exist for {p29[1]}`));
        end;

        return false;
    end;

    local v33;

    if p29[2] then
        v33 = v31.Sets[p29[2]];
    else
        v33 = nil;
    end;

    local v34;

    if p29[2] then
        v34 = v32.Sets[p29[2]];
    else
        v34 = nil;
    end;

    if p29[2] and (v33 == nil or v34 == nil) then
        if u3 then
            warn((`AchievementsShared:IsCompleted: Season set doesn't exist for season {p29[1]}, set {p29[2]}`));
        end;

        return false;
    end;

    if p28 == "Season" then
        for i in v31.Sets do
            if not u4:IsCompleted(p27, "Set", { p29[1], i }) then
                return false;
            end;
        end;

        return true;
    end;

    if p28 == "Set" then
        for _, v in v33.Quests do
            if not u4:IsCompleted(p27, "Quest", { p29[1], p29[2], v.Id }) then
                return false;
            end;
        end;

        return true;
    end;

    if p28 ~= "Quest" then
        return false;
    end;

    tonumber(p29[1]);
    local v35 = p29[3];

    if type(v35) == "string" then
        local v36 = v34.Quests[v35];

        if v36 == nil then
            return false;
        end;

        for _, v in v33.Quests do
            if v.Id == v35 and v36.Progress >= v.Target then
                return true;
            end;
        end;

        return false;
    end;

    if type(v35) ~= "number" then
        return false;
    end;

    local v37 = v33.Quests[v35];
    local v38;

    if v37 then
        v38 = v34.Quests[v37.Id];
    else
        v38 = nil;
    end;

    if v38 ~= nil then
        return v38.Progress >= v37.Target;
    end;

    if u3 then
        warn((`AchievementsShared:IsCompleted: Quest data doesn't exist for {p29[1]}, {p29[2]}, {p29[3]}`));
    end;

    return false;
end;

function u4.IsClaimed(p39: table, p40: userdata, p41: string, p42: table) -- Line: 287
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy), u3 (copy), AchievementsData (copy)
    local v43;

    if u2 then
        v43 = u1:GetPlayerData(p40);
    elseif p40 == LocalPlayer then
        v43 = u1:GetData();
    else
        v43 = nil;
    end;

    if not v43 then
        if u3 then
            warn("AchievementsShared:IsClaimed: player data not found");
        end;

        return false;
    end;

    if type(p42) ~= "table" then
        if u3 then
            warn("AchievementsShared:IsClaimed: arguments is not a table");
        end;

        return false;
    end;

    local v44 = AchievementsData.Seasons[tonumber(p42[1])];
    local v45 = v43.Achievements.Seasons[`Season_{p42[1]}`];

    if v44 == nil or v45 == nil then
        if u3 then
            warn((`AchievementsShared:IsClaimed: Season doesn't exist for {p42[1]}`));
        end;

        return false;
    end;

    local v46;

    if p42[2] then
        v46 = v44.Sets[p42[2]];
    else
        v46 = nil;
    end;

    local v47;

    if p42[2] then
        v47 = v45.Sets[p42[2]];
    else
        v47 = nil;
    end;

    if p42[2] and (v46 == nil or v47 == nil) then
        if u3 then
            warn((`AchievementsShared:IsClaimed: Season set doesn't exist for season {p42[1]}, set {p42[2]}`));
        end;

        return false;
    end;

    if p41 == "Season" then
        if v45.Claimed then
            return true;
        end;
    elseif p41 == "Set" then
        if v47.Claimed then
            return true;
        end;
    elseif p41 == "Quest" then
        local v48 = p42[3];

        if type(v48) == "string" then
            local v49 = v47.Quests[v48];

            if v49 and v49.Claimed then
                return true;
            end;
        elseif type(v48) == "number" then
            local v50 = v46.Quests[v48];
            local v51;

            if v50 then
                v51 = v47.Quests[v50.Id];
            else
                v51 = nil;
            end;

            if v51 and v51.Claimed then
                return true;
            end;
        end;
    end;

    return false;
end;

function u4.Observe(p52: table, p53: userdata, p54: string, u55: table, u56: function) -- Line: 359
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy), u3 (copy), u4 (copy), listenToPathSignal (copy), AchievementsData (copy)
    local u57;

    if u2 then
        u57 = u1:GetPlayerData(p53);
    elseif p53 == LocalPlayer then
        u57 = u1:GetData();
    else
        u57 = nil;
    end;

    if not u57 then
        if u3 then
            warn("AchievementsShared:Observe: player data not found");
        end;

        return nil;
    end;

    if not u4:ValidateParameters(p53, p54, u55) then
        return nil;
    end;

    local u58 = `Season_{u55[1]}`;
    local v59 = `Achievements/Seasons/{u58}`;
    local v60;

    if u55[2] then
        v60 = `{v59}/Sets/{tostring(u55[2])}`;
    else
        v60 = nil;
    end;

    if p54 == "Season" then
        local function runUpdate() -- Line: 378
            -- upvalues: u57 (copy), u58 (copy), u56 (copy)
            local v61 = u57.Achievements.Seasons[u58];

            if not v61 then
                return;
            end;

            u56(v61);
        end;

        local u62 = listenToPathSignal(p53, v59, runUpdate);
        local u63 = listenToPathSignal(p53, `{v59}/@`, runUpdate);
        task.spawn(runUpdate);

        return function() -- Line: 392
            -- upvalues: u62 (copy), u63 (copy)
            if u62 then
                u62:Disconnect();
            end;

            if u63 then
                u63:Disconnect();
            end;
        end;
    end;

    if p54 == "Set" then
        local function v65() -- Line: 401
            -- upvalues: u57 (copy), u58 (copy), u56 (copy), u55 (copy)
            local v64 = u57.Achievements.Seasons[u58];

            if not v64 then
                return;
            end;

            u56(v64.Sets[u55[2]]);
        end;

        local u66 = listenToPathSignal(p53, v60, v65);
        local u67 = listenToPathSignal(p53, `{v60}/@`, v65);
        task.spawn(v65);

        return function() -- Line: 415
            -- upvalues: u66 (copy), u67 (copy)
            if u66 then
                u66:Disconnect();
            end;

            if u67 then
                u67:Disconnect();
            end;
        end;
    end;

    if p54 ~= "Quest" then
        return nil;
    end;

    local u68 = u55[3];

    if type(u68) == "number" then
        local v69 = AchievementsData.Seasons[tonumber(u55[1])].Sets[u55[2]].Quests[u68];

        if not v69 then
            return nil;
        end;

        u68 = v69.Id;
    end;

    local v70 = type(u68) == "string";
    assert(v70);

    local function v73() -- Line: 439
        -- upvalues: u57 (copy), u58 (copy), u55 (copy), u56 (copy), u68 (ref)
        local v71 = u57.Achievements.Seasons[u58];

        if not v71 then
            return;
        end;

        local v72 = v71.Sets[u55[2]];

        if v72 then
            u56(v72.Quests[u68]);

            return;
        end;

        u56(nil);
    end;

    local u74 = listenToPathSignal(p53, `{v60}/Quests/{u68}`, v73);
    local u75 = listenToPathSignal(p53, `{v60}/Quests/{u68}/@`, v73);
    task.spawn(v73);

    return function() -- Line: 460
        -- upvalues: u74 (copy), u75 (copy)
        if u74 then
            u74:Disconnect();
        end;

        if u75 then
            u75:Disconnect();
        end;
    end;
end;

return u4;