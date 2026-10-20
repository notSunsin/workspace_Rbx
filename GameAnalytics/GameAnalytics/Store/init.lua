-- Decompiled with Potassium's decompiler.

local DataStoreService = game:GetService("DataStoreService");
local RunService = game:GetService("RunService");
local script_DataStoreQueue = require(script.DataStoreQueue);
local u1 = {
    AutoSaveData = 180,
    PlayerDS = RunService:IsStudio() and {} or DataStoreService:GetDataStore("GA_PlayerDS_1.0.0"),
    BasePlayerData = {
        Sessions = 0,
        Transactions = 0,
        CurrentCustomDimension01 = "",
        CurrentCustomDimension02 = "",
        CurrentCustomDimension03 = "",
        ConfigsHash = "",
        AbId = "",
        AbVariantId = "",
        InitAuthorized = false,
        ClientServerTimeOffset = 0,
        RemoteConfigsIsReady = false,
        PlayerTeleporting = false,
        OwnedGamepasses = nil,
        CountryCode = "",
        CustomUserId = "",
        ProgressionTries = {},
        SdkConfig = {},
        Configurations = {}
    },
    DataToSave = { "Sessions", "Transactions", "ProgressionTries", "CurrentCustomDimension01", "CurrentCustomDimension02", "CurrentCustomDimension03", "OwnedGamepasses" },
    PlayerCache = {},
    EventsQueue = {},
    DataStoreQueue = script_DataStoreQueue
};

function u1.GetPlayerData(p2, p3) -- Line: 45
    -- upvalues: script_DataStoreQueue (copy), RunService (copy), u1 (copy)
    local UserId = p3.UserId;
    local v4, v5 = script_DataStoreQueue.AddRequest(UserId, function() -- Line: 47
        -- upvalues: RunService (ref), u1 (ref), UserId (copy)
        return RunService:IsStudio() and {} or (u1.PlayerDS:GetAsync(UserId) or {});
    end, 7);

    return not v4 and {} or v5;
end;

function u1.GetPlayerDataFromCache(p6, p7) -- Line: 57
    -- upvalues: u1 (copy)
    return u1.PlayerCache[tonumber(p7)] or u1.PlayerCache[tostring(p7)];
end;

function u1.GetErrorDataStore(p8, u9) -- Line: 66
    -- upvalues: RunService (copy), DataStoreService (copy)
    local u10 = nil;

    return not pcall(function() -- Line: 68
        -- upvalues: u10 (ref), RunService (ref), DataStoreService (ref), u9 (copy)
        u10 = RunService:IsStudio() and {} or DataStoreService:GetDataStore("GA_ErrorDS_1.0.0", u9);
    end) and {} or u10;
end;

function u1.SavePlayerData(p11, p12) -- Line: 79
    -- upvalues: u1 (copy), RunService (copy), script_DataStoreQueue (copy)
    local PlayerDataFromCache = u1:GetPlayerDataFromCache(p12.UserId);
    local u13 = {};

    if not PlayerDataFromCache then
        return;
    end;

    for _, v in pairs(u1.DataToSave) do
        u13[v] = PlayerDataFromCache[v];
    end;

    local UserId = p12.UserId;

    if not RunService:IsStudio() then
        script_DataStoreQueue.AddRequest(UserId, function() -- Line: 96
            -- upvalues: u1 (ref), UserId (copy), u13 (copy)
            return u1.PlayerDS:SetAsync(UserId, u13);
        end, 7);
    end;
end;

function u1.IncrementErrorCount(p14, u15, u16, u17) -- Line: 102
    -- upvalues: RunService (copy), script_DataStoreQueue (copy)
    if not (u16 and (type(u17) == "number" and u17 > 0)) then
        return nil;
    end;

    if RunService:IsStudio() then
        return nil;
    end;

    local v18, v19 = script_DataStoreQueue.AddRequest(u16, function() -- Line: 112
        -- upvalues: u15 (copy), u16 (copy), u17 (copy)
        return u15:IncrementAsync(u16, u17);
    end, 7);

    if v18 then
        return v19;
    end;

    return nil;
end;

return u1;