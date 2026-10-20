-- Decompiled with Potassium's decompiler.

local Validation = require(script.Parent.Validation);
local Logger = require(script.Parent.Logger);
local HttpApi = require(script.Parent.HttpApi);
local Store = require(script.Parent.Store);
local Events = require(script.Parent.Events);
local HttpService = game:GetService("HttpService");
local u1 = {
    _enableEventSubmission = false,
    Initialized = false,
    ReportErrors = false,
    UseCustomUserId = false,
    AutomaticSendBusinessEvents = true,
    ConfigsHash = "",
    _availableCustomDimensions01 = {},
    _availableCustomDimensions02 = {},
    _availableCustomDimensions03 = {},
    _availableGamepasses = {}
};
local u2 = nil;

local function getClientTsAdjusted(p3) -- Line: 23
    -- upvalues: Store (copy), Validation (copy)
    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p3);

    if not PlayerDataFromCache then
        return os.time();
    end;

    local os_time_ret = os.time();
    local v4 = os_time_ret + PlayerDataFromCache.ClientServerTimeOffset;

    if Validation:validateClientTs(v4) then
        return v4;
    end;

    return os_time_ret;
end;

local function populateConfigurations(p5) -- Line: 38
    -- upvalues: Store (copy), Validation (copy), Logger (copy), u2 (ref)
    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p5.UserId);
    local SdkConfig = PlayerDataFromCache.SdkConfig;

    if SdkConfig.configs then
        for _, v in pairs(SdkConfig.configs) do
            if v then
                local v6 = v.key or "";
                local v7 = v.start_ts or 0;
                local v8 = v.end_ts or (1 / 0);
                local PlayerDataFromCache2 = Store:GetPlayerDataFromCache(p5.UserId);
                local v9;

                if PlayerDataFromCache2 then
                    v9 = os.time();
                    local v10 = v9 + PlayerDataFromCache2.ClientServerTimeOffset;

                    if Validation:validateClientTs(v10) then
                        v9 = v10;
                    end;
                else
                    v9 = os.time();
                end;

                if #v6 > 0 and (v.value and (v7 < v9 and v9 < v8)) then
                    PlayerDataFromCache.Configurations[v6] = v.value;
                    Logger:d("configuration added: key=" .. v.key .. ", value=" .. v.value);
                end;
            end;
        end;
    end;

    Logger:i("Remote configs populated");
    PlayerDataFromCache.RemoteConfigsIsReady = true;
    u2 = u2 or game:GetService("ReplicatedStorage"):WaitForChild("GameAnalyticsRemoteConfigs");
    u2:FireClient(p5, PlayerDataFromCache.Configurations);
end;

function u1.sessionIsStarted(p11, p12) -- Line: 67
    -- upvalues: Store (copy)
    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p12);

    if PlayerDataFromCache then
        return PlayerDataFromCache.SessionStart ~= 0;
    end;

    return false;
end;

function u1.isEnabled(p13, p14) -- Line: 76
    -- upvalues: Store (copy)
    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p14);

    if PlayerDataFromCache then
        return PlayerDataFromCache.InitAuthorized and true or false;
    end;

    return false;
end;

function u1.validateAndFixCurrentDimensions(p15, p16) -- Line: 87
    -- upvalues: Store (copy), Validation (copy), Logger (copy)
    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p16);

    if not Validation:validateDimension(p15._availableCustomDimensions01, PlayerDataFromCache.CurrentCustomDimension01) then
        Logger:d("Invalid dimension01 found in variable. Setting to nil. Invalid dimension: " .. PlayerDataFromCache.CurrentCustomDimension01);
    end;

    if not Validation:validateDimension(p15._availableCustomDimensions02, PlayerDataFromCache.CurrentCustomDimension02) then
        Logger:d("Invalid dimension02 found in variable. Setting to nil. Invalid dimension: " .. PlayerDataFromCache.CurrentCustomDimension02);
    end;

    if not Validation:validateDimension(p15._availableCustomDimensions03, PlayerDataFromCache.CurrentCustomDimension03) then
        Logger:d("Invalid dimension03 found in variable. Setting to nil. Invalid dimension: " .. PlayerDataFromCache.CurrentCustomDimension03);
    end;
end;

function u1.setAvailableCustomDimensions01(p17, p18) -- Line: 106
    -- upvalues: Validation (copy), Logger (copy)
    if not Validation:validateCustomDimensions(p18) then
        return;
    end;

    p17._availableCustomDimensions01 = p18;
    Logger:i("Set available custom01 dimension values: (" .. table.concat(p18, ", ") .. ")");
end;

function u1.setAvailableCustomDimensions02(p19, p20) -- Line: 115
    -- upvalues: Validation (copy), Logger (copy)
    if not Validation:validateCustomDimensions(p20) then
        return;
    end;

    p19._availableCustomDimensions02 = p20;
    Logger:i("Set available custom02 dimension values: (" .. table.concat(p20, ", ") .. ")");
end;

function u1.setAvailableCustomDimensions03(p21, p22) -- Line: 124
    -- upvalues: Validation (copy), Logger (copy)
    if not Validation:validateCustomDimensions(p22) then
        return;
    end;

    p21._availableCustomDimensions03 = p22;
    Logger:i("Set available custom03 dimension values: (" .. table.concat(p22, ", ") .. ")");
end;

function u1.setAvailableGamepasses(p23, p24) -- Line: 133
    -- upvalues: Logger (copy)
    p23._availableGamepasses = p24;
    Logger:i("Set available game passes: (" .. table.concat(p24, ", ") .. ")");
end;

function u1.setEventSubmission(p25, p26) -- Line: 138
    p25._enableEventSubmission = p26;
end;

function u1.isEventSubmissionEnabled(p27) -- Line: 142
    return p27._enableEventSubmission;
end;

function u1.setCustomDimension01(p28, p29, p30) -- Line: 146
    -- upvalues: Store (copy)
    Store:GetPlayerDataFromCache(p29).CurrentCustomDimension01 = p30;
end;

function u1.setCustomDimension02(p31, p32, p33) -- Line: 151
    -- upvalues: Store (copy)
    Store:GetPlayerDataFromCache(p32).CurrentCustomDimension02 = p33;
end;

function u1.setCustomDimension03(p34, p35, p36) -- Line: 156
    -- upvalues: Store (copy)
    Store:GetPlayerDataFromCache(p35).CurrentCustomDimension03 = p36;
end;

function u1.startNewSession(p37, p38, p39) -- Line: 161
    -- upvalues: u1 (copy), Logger (copy), Store (copy), HttpApi (copy), Events (copy), populateConfigurations (copy), HttpService (copy), Validation (copy)
    if u1:isEventSubmissionEnabled() and p39 == nil then
        Logger:i("Starting a new session.");
    end;

    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p38.UserId);
    u1:validateAndFixCurrentDimensions(p38.UserId);
    local v40 = HttpApi:initRequest(Events.GameKey, Events.SecretKey, Events.Build, PlayerDataFromCache, p38.UserId);
    local statusCode = v40.statusCode;
    local body = v40.body;

    if (statusCode == HttpApi.EGAHTTPApiResponse.Ok or statusCode == HttpApi.EGAHTTPApiResponse.Created) and body then
        local v41 = body.server_ts or -1;
        body.time_offset = v41 <= 0 and 0 or v41 - os.time();

        if statusCode ~= HttpApi.EGAHTTPApiResponse.Created then
            local SdkConfig = PlayerDataFromCache.SdkConfig;

            if SdkConfig.configs then
                body.configs = SdkConfig.configs;
            end;

            if SdkConfig.ab_id then
                body.ab_id = SdkConfig.ab_id;
            end;

            if SdkConfig.ab_variant_id then
                body.ab_variant_id = SdkConfig.ab_variant_id;
            end;
        end;

        PlayerDataFromCache.SdkConfig = body;
        PlayerDataFromCache.InitAuthorized = true;
    elseif statusCode == HttpApi.EGAHTTPApiResponse.Unauthorized then
        Logger:w("Initialize SDK failed - Unauthorized");
        PlayerDataFromCache.InitAuthorized = false;
    else
        if statusCode == HttpApi.EGAHTTPApiResponse.NoResponse or statusCode == HttpApi.EGAHTTPApiResponse.RequestTimeout then
            Logger:i("Init call (session start) failed - no response. Could be offline or timeout.");
        elseif statusCode == HttpApi.EGAHTTPApiResponse.BadResponse or (statusCode == HttpApi.EGAHTTPApiResponse.JsonEncodeFailed or statusCode == HttpApi.EGAHTTPApiResponse.JsonDecodeFailed) then
            Logger:i("Init call (session start) failed - bad response. Could be bad response from proxy or GA servers.");
        elseif statusCode == HttpApi.EGAHTTPApiResponse.BadRequest or statusCode == HttpApi.EGAHTTPApiResponse.UnknownResponseCode then
            Logger:i("Init call (session start) failed - bad request or unknown response.");
        end;

        PlayerDataFromCache.InitAuthorized = true;
    end;

    PlayerDataFromCache.ClientServerTimeOffset = PlayerDataFromCache.SdkConfig.time_offset or 0;
    PlayerDataFromCache.ConfigsHash = PlayerDataFromCache.SdkConfig.configs_hash or "";
    PlayerDataFromCache.AbId = PlayerDataFromCache.SdkConfig.ab_id or "";
    PlayerDataFromCache.AbVariantId = PlayerDataFromCache.SdkConfig.ab_variant_id or "";
    populateConfigurations(p38);

    if not u1:isEnabled(p38.UserId) then
        Logger:w("Could not start session: SDK is disabled.");

        return;
    end;

    if p39 then
        PlayerDataFromCache.SessionID = p39.SessionID;
        PlayerDataFromCache.SessionStart = p39.SessionStart;
    else
        PlayerDataFromCache.SessionID = string.lower(HttpService:GenerateGUID(false));
        local PlayerDataFromCache2 = Store:GetPlayerDataFromCache(p38.UserId);
        local v42;

        if PlayerDataFromCache2 then
            v42 = os.time();
            local v43 = v42 + PlayerDataFromCache2.ClientServerTimeOffset;

            if Validation:validateClientTs(v43) then
                v42 = v43;
            end;
        else
            v42 = os.time();
        end;

        PlayerDataFromCache.SessionStart = v42;
    end;

    if u1:isEventSubmissionEnabled() then
        Events:addSessionStartEvent(p38.UserId, p39);
    end;
end;

function u1.endSession(p44, p45) -- Line: 247
    -- upvalues: u1 (copy), Logger (copy), Events (copy), Store (copy)
    if u1.Initialized and u1:isEventSubmissionEnabled() then
        Logger:i("Ending session.");

        if u1:isEnabled(p45) and u1:sessionIsStarted(p45) then
            Events:addSessionEndEvent(p45);
            Store.PlayerCache[p45] = nil;
        end;
    end;
end;

function u1.getRemoteConfigsStringValue(p46, p47, p48, p49) -- Line: 257
    -- upvalues: Store (copy)
    return Store:GetPlayerDataFromCache(p47).Configurations[p48] or p49;
end;

function u1.isRemoteConfigsReady(p50, p51) -- Line: 262
    -- upvalues: Store (copy)
    return Store:GetPlayerDataFromCache(p51).RemoteConfigsIsReady;
end;

function u1.getRemoteConfigsContentAsString(p52, p53) -- Line: 267
    -- upvalues: Store (copy), HttpService (copy)
    return HttpService:JSONEncode(Store:GetPlayerDataFromCache(p53).Configurations);
end;

return u1;