-- Decompiled with Potassium's decompiler.

local u1 = {
    ProcessEventsInterval = 8,
    GameKey = "",
    SecretKey = "",
    Build = "",
    _availableResourceCurrencies = {},
    _availableResourceItemTypes = {}
};
local Store = require(script.Parent.Store);
local Logger = require(script.Parent.Logger);
local Version = require(script.Parent.Version);
local Validation = require(script.Parent.Validation);
local Threading = require(script.Parent.Threading);
local HttpApi = require(script.Parent.HttpApi);
local Utilities = require(script.Parent.Utilities);
local GAResourceFlowType = require(script.Parent.GAResourceFlowType);
local GAProgressionStatus = require(script.Parent.GAProgressionStatus);
local GAErrorSeverity = require(script.Parent.GAErrorSeverity);
local HttpService = game:GetService("HttpService");

local function addDimensionsToEvent(p2, p3) -- Line: 33
    -- upvalues: Store (copy)
    if not (p3 and p2) then
        return;
    end;

    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p2);

    if PlayerDataFromCache and (PlayerDataFromCache.CurrentCustomDimension01 and #PlayerDataFromCache.CurrentCustomDimension01 > 0) then
        p3.custom_01 = PlayerDataFromCache.CurrentCustomDimension01;
    end;

    if PlayerDataFromCache and (PlayerDataFromCache.CurrentCustomDimension02 and #PlayerDataFromCache.CurrentCustomDimension02 > 0) then
        p3.custom_02 = PlayerDataFromCache.CurrentCustomDimension02;
    end;

    if PlayerDataFromCache and (PlayerDataFromCache.CurrentCustomDimension03 and #PlayerDataFromCache.CurrentCustomDimension03 > 0) then
        p3.custom_03 = PlayerDataFromCache.CurrentCustomDimension03;
    end;
end;

local function getClientTsAdjusted(p4) -- Line: 54
    -- upvalues: Store (copy), Validation (copy)
    if not p4 then
        return os.time();
    end;

    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p4);
    local os_time_ret = os.time();
    local v5 = os_time_ret + PlayerDataFromCache.ClientServerTimeOffset;

    if Validation:validateClientTs(v5) then
        return v5;
    end;

    return os_time_ret;
end;

local u6 = HttpService:GenerateGUID(false):lower();

local function Length(p7) -- Line: 71
    local v8 = 0;

    for _, _ in pairs(p7) do
        v8 = v8 + 1;
    end;

    return v8;
end;

local function getEventAnnotations(p9) -- Line: 79
    -- upvalues: Store (copy), u6 (copy), Validation (copy), Version (copy), Utilities (copy), u1 (copy)
    local v10, v11;

    if p9 then
        v10 = Store:GetPlayerDataFromCache(p9);
        v11 = p9;
    else
        v10 = {
            OS = "uwp_desktop 0.0.0",
            Platform = "uwp_desktop",
            Sessions = 1,
            CustomUserId = "Server",
            SessionID = u6
        };
        v11 = "DummyId";
    end;

    local v12 = {
        v = 2,
        user_id = tostring(v11) .. v10.CustomUserId
    };
    local v13;

    if p9 then
        local PlayerDataFromCache = Store:GetPlayerDataFromCache(p9);
        v13 = os.time();
        local v14 = v13 + PlayerDataFromCache.ClientServerTimeOffset;

        if Validation:validateClientTs(v14) then
            v13 = v14;
        end;
    else
        v13 = os.time();
    end;

    v12.client_ts = v13;
    v12.sdk_version = "roblox " .. Version.SdkVersion;
    v12.os_version = v10.OS;
    v12.manufacturer = "unknown";
    v12.device = "unknown";
    v12.platform = v10.Platform;
    v12.session_id = v10.SessionID;
    v12.session_num = v10.Sessions;

    if Utilities:isStringNullOrEmpty(v10.CountryCode) then
        v12.country_code = "unknown";
    else
        v12.country_code = v10.CountryCode;
    end;

    if Validation:validateBuild(u1.Build) then
        v12.build = u1.Build;
    end;

    if v10.Configurations then
        local v15 = 0;

        for _, _ in pairs(v10.Configurations) do
            v15 = v15 + 1;
        end;

        if v15 > 0 then
            v12.configurations = v10.Configurations;
        end;
    end;

    if not Utilities:isStringNullOrEmpty(v10.AbId) then
        v12.ab_id = v10.AbId;
    end;

    if not Utilities:isStringNullOrEmpty(v10.AbVariantId) then
        v12.ab_variant_id = v10.AbVariantId;
    end;

    return v12;
end;

local function addEventToStore(p16, p17) -- Line: 146
    -- upvalues: getEventAnnotations (copy), HttpService (copy), Logger (copy), Store (copy)
    local v18 = getEventAnnotations(p16);

    for i in pairs(p17) do
        v18[i] = p17[i];
    end;

    Logger:ii("Event added to queue: " .. HttpService:JSONEncode(v18));
    Store.EventsQueue[#Store.EventsQueue + 1] = v18;
end;

local function dequeueMaxEvents() -- Line: 165
    -- upvalues: Store (copy), Logger (copy)
    if #Store.EventsQueue <= 500 then
        local EventsQueue = Store.EventsQueue;
        Store.EventsQueue = {};

        return EventsQueue;
    end;

    Logger:w(("More than %d events queued! Sending %d."):format(500, 500));

    if #Store.EventsQueue > 2000 then
        Logger:w(("DROPPING EVENTS: More than %d events queued!"):format(2000));
    end;

    local table_create_ret = table.create(500);

    for i = 1, 500 do
        table_create_ret[i] = Store.EventsQueue[i];
        local _ = i;
    end;

    local v19 = #Store.EventsQueue;

    for i = 1, math.min(2000, v19) do
        Store.EventsQueue[i] = Store.EventsQueue[i + 500];
        local _ = i;
    end;

    for i = 2001, v19 do
        Store.EventsQueue[i] = nil;
        local _ = i;
    end;

    return table_create_ret;
end;

local function processEvents() -- Line: 198
    -- upvalues: dequeueMaxEvents (copy), Logger (copy), HttpApi (copy), u1 (copy), Store (copy)
    local v20 = dequeueMaxEvents();

    if #v20 == 0 then
        Logger:i("Event queue: No events to send");

        return;
    end;

    Logger:i("Event queue: Sending " .. tostring(#v20) .. " events.");
    local v21 = HttpApi:sendEventsInArray(u1.GameKey, u1.SecretKey, v20);
    local statusCode = v21.statusCode;
    local body = v21.body;

    if statusCode == HttpApi.EGAHTTPApiResponse.Ok and body then
        Logger:i("Event queue: " .. tostring(#v20) .. " events sent.");

        return;
    end;

    if statusCode == HttpApi.EGAHTTPApiResponse.NoResponse then
        Logger:w("Event queue: Failed to send events to collector - Retrying next time");

        for _, v in pairs(v20) do
            if #Store.EventsQueue >= 2000 then
                return;
            end;

            Store.EventsQueue[#Store.EventsQueue + 1] = v;
        end;

        return;
    end;

    if statusCode == HttpApi.EGAHTTPApiResponse.BadRequest and body then
        Logger:w("Event queue: " .. tostring(#v20) .. " events sent. " .. tostring(#body) .. " events failed GA server validation.");

        return;
    end;

    Logger:w("Event queue: Failed to send events.");
end;

function u1.processEventQueue(p22) -- Line: 235
    -- upvalues: processEvents (copy), Threading (copy), u1 (copy)
    processEvents();
    Threading:scheduleTimer(u1.ProcessEventsInterval, function() -- Line: 237
        -- upvalues: u1 (ref)
        u1:processEventQueue();
    end);
end;

function u1.setBuild(p23, p24) -- Line: 242
    -- upvalues: Validation (copy), Logger (copy)
    if not Validation:validateBuild(p24) then
        Logger:w("Validation fail - configure build: Cannot be null, empty or above 32 length. String: " .. p24);

        return;
    end;

    p23.Build = p24;
    Logger:i("Set build version: " .. p24);
end;

function u1.setAvailableResourceCurrencies(p25, p26) -- Line: 252
    -- upvalues: Validation (copy), Logger (copy)
    if not Validation:validateResourceCurrencies(p26) then
        return;
    end;

    p25._availableResourceCurrencies = p26;
    Logger:i("Set available resource currencies: (" .. table.concat(p26, ", ") .. ")");
end;

function u1.setAvailableResourceItemTypes(p27, p28) -- Line: 261
    -- upvalues: Validation (copy), Logger (copy)
    if not Validation:validateResourceCurrencies(p28) then
        return;
    end;

    p27._availableResourceItemTypes = p28;
    Logger:i("Set available resource item types: (" .. table.concat(p28, ", ") .. ")");
end;

function u1.addSessionStartEvent(p29, p30, p31) -- Line: 270
    -- upvalues: Store (copy), addDimensionsToEvent (copy), addEventToStore (copy), Logger (copy), processEvents (copy)
    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p30);

    if p31 then
        PlayerDataFromCache.Sessions = p31.Sessions;

        return;
    end;

    local v32 = {
        category = "user"
    };
    PlayerDataFromCache.Sessions = PlayerDataFromCache.Sessions + 1;
    addDimensionsToEvent(p30, v32);
    addEventToStore(p30, v32);
    Logger:i("Add SESSION START event");
    processEvents();
end;

function u1.addSessionEndEvent(p33, p34) -- Line: 296
    -- upvalues: Store (copy), Validation (copy), Logger (copy), addDimensionsToEvent (copy), addEventToStore (copy), processEvents (copy)
    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p34);
    local SessionStart = PlayerDataFromCache.SessionStart;
    local v35;

    if p34 then
        local PlayerDataFromCache2 = Store:GetPlayerDataFromCache(p34);
        v35 = os.time();
        local v36 = v35 + PlayerDataFromCache2.ClientServerTimeOffset;

        if Validation:validateClientTs(v36) then
            v35 = v36;
        end;
    else
        v35 = os.time();
    end;

    local v37 = (v35 == nil or SessionStart == nil) and 0 or v35 - SessionStart;

    if v37 < 0 then
        Logger:w("Session length was calculated to be less then 0. Should not be possible. Resetting to 0.");
        v37 = 0;
    end;

    local v38 = {
        category = "session_end",
        length = v37
    };
    addDimensionsToEvent(p34, v38);
    addEventToStore(p34, v38);
    PlayerDataFromCache.SessionStart = 0;
    Logger:i("Add SESSION END event.");
    processEvents();
end;

function u1.addBusinessEvent(p39, p40, p41, p42, p43, p44, p45) -- Line: 330
    -- upvalues: Validation (copy), Store (copy), Utilities (copy), addDimensionsToEvent (copy), Logger (copy), addEventToStore (copy)
    if not Validation:validateBusinessEvent(p41, p42, p45, p43, p44) then
        return;
    end;

    local v46 = {};
    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p40);
    PlayerDataFromCache.Transactions = PlayerDataFromCache.Transactions + 1;
    v46.event_id = p43 .. ":" .. p44;
    v46.category = "business";
    v46.currency = p41;
    v46.amount = p42;
    v46.transaction_num = PlayerDataFromCache.Transactions;

    if not Utilities:isStringNullOrEmpty(p45) then
        v46.cart_type = p45;
    end;

    addDimensionsToEvent(p40, v46);
    Logger:i("Add BUSINESS event: {currency:" .. p41 .. ", amount:" .. tostring(p42) .. ", itemType:" .. p43 .. ", itemId:" .. p44 .. ", cartType:" .. p45 .. "}");
    addEventToStore(p40, v46);
end;

function u1.addResourceEvent(p47, p48, p49, p50, p51, p52, p53) -- Line: 365
    -- upvalues: Validation (copy), GAResourceFlowType (copy), addDimensionsToEvent (copy), Logger (copy), addEventToStore (copy)
    if not Validation:validateResourceEvent(GAResourceFlowType, p49, p50, p51, p52, p53, p47._availableResourceCurrencies, p47._availableResourceItemTypes) then
        return;
    end;

    if p49 == GAResourceFlowType.Sink then
        p51 = -1 * p51;
    end;

    local v54 = {
        event_id = GAResourceFlowType[p49] .. ":" .. p50 .. ":" .. p52 .. ":" .. p53,
        category = "resource",
        amount = p51
    };
    addDimensionsToEvent(p48, v54);
    Logger:i("Add RESOURCE event: {currency:" .. p50 .. ", amount:" .. tostring(p51) .. ", itemType:" .. p52 .. ", itemId:" .. p53 .. "}");
    addEventToStore(p48, v54);
end;

function u1.addProgressionEvent(p55, p56, p57, p58, p59, p60, p61) -- Line: 395
    -- upvalues: Validation (copy), GAProgressionStatus (copy), Utilities (copy), Store (copy), addDimensionsToEvent (copy), Logger (copy), addEventToStore (copy)
    if not Validation:validateProgressionEvent(GAProgressionStatus, p57, p58, p59, p60) then
        return;
    end;

    local v62 = {};
    local v63;

    if Utilities:isStringNullOrEmpty(p59) then
        v63 = p58;
    elseif Utilities:isStringNullOrEmpty(p60) then
        v63 = p58 .. ":" .. p59;
    else
        v63 = p58 .. ":" .. p59 .. ":" .. p60;
    end;

    local v64 = GAProgressionStatus[p57];
    v62.category = "progression";
    v62.event_id = v64 .. ":" .. v63;
    local v65 = 0;

    if p61 ~= nil and p57 ~= GAProgressionStatus.Start then
        v62.score = p61;
    end;

    local PlayerDataFromCache = Store:GetPlayerDataFromCache(p56);

    if p57 == GAProgressionStatus.Fail then
        PlayerDataFromCache.ProgressionTries[v63] = (PlayerDataFromCache.ProgressionTries[v63] or 0) + 1;
    end;

    if p57 == GAProgressionStatus.Complete then
        PlayerDataFromCache.ProgressionTries[v63] = (PlayerDataFromCache.ProgressionTries[v63] or 0) + 1;
        v65 = PlayerDataFromCache.ProgressionTries[v63];
        v62.attempt_num = v65;
        PlayerDataFromCache.ProgressionTries[v63] = 0;
    end;

    addDimensionsToEvent(p56, v62);
    Logger:i("Add PROGRESSION event: {status:" .. v64 .. ", progression01:" .. p58 .. ", progression02:" .. (Utilities:isStringNullOrEmpty(p59) and "" or p59) .. ", progression03:" .. (Utilities:isStringNullOrEmpty(p60) and "" or p60) .. ", score:" .. tostring(p61) .. ", attempt:" .. tostring(v65) .. "}");
    addEventToStore(p56, v62);
end;

function u1.addDesignEvent(p66, p67, p68, p69) -- Line: 471
    -- upvalues: Validation (copy), addDimensionsToEvent (copy), Logger (copy), addEventToStore (copy)
    if not Validation:validateDesignEvent(p68) then
        return;
    end;

    local v70 = {
        category = "design",
        event_id = p68
    };

    if p69 ~= nil then
        v70.value = p69;
    end;

    addDimensionsToEvent(p67, v70);
    Logger:i("Add DESIGN event: {eventId:" .. p68 .. ", value:" .. tostring(p69) .. "}");
    addEventToStore(p67, v70);
end;

function u1.addErrorEvent(p71, p72, p73, p74) -- Line: 498
    -- upvalues: Validation (copy), GAErrorSeverity (copy), addDimensionsToEvent (copy), Utilities (copy), Logger (copy), addEventToStore (copy)
    if not Validation:validateErrorEvent(GAErrorSeverity, p73, p74) then
        return;
    end;

    local v75 = {};
    local v76 = GAErrorSeverity[p73];
    v75.category = "error";
    v75.severity = v76;
    v75.message = p74;
    addDimensionsToEvent(p72, v75);
    Logger:i("Add ERROR event: {severity:" .. v76 .. ", message:" .. (Utilities:isStringNullOrEmpty(p74) and "" or p74) .. "}");
    addEventToStore(p72, v75);
end;

function u1.addSdkErrorEvent(p77, p78, p79, p80, p81, p82, p83) -- Line: 528
    -- upvalues: Utilities (copy), Logger (copy), addEventToStore (copy)
    local v84 = {
        category = "sdk_error",
        error_category = p79,
        error_area = p80,
        error_action = p81
    };

    if not Utilities:isStringNullOrEmpty(p82) then
        v84.error_parameter = p82;
    end;

    if not Utilities:isStringNullOrEmpty(p83) then
        v84.reason = p83;
    end;

    Logger:i("Add SDK ERROR event: {error_category:" .. p79 .. ", error_area:" .. p80 .. ", error_action:" .. p81 .. "}");
    addEventToStore(p78, v84);
end;

return u1;