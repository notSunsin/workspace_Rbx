-- Decompiled with Potassium's decompiler.

local u1 = {
    EGAResourceFlowType = require(script.GAResourceFlowType),
    EGAProgressionStatus = require(script.GAProgressionStatus),
    EGAErrorSeverity = require(script.GAErrorSeverity)
};
local script_Logger = require(script.Logger);
local script_Threading = require(script.Threading);
local script_State = require(script.State);
local script_Validation = require(script.Validation);
local script_Store = require(script.Store);
local script_Events = require(script.Events);
local script_Utilities = require(script.Utilities);
local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("LocalizationService");
local ScriptContext = game:GetService("ScriptContext");
local script_Postie = require(script.Postie);
local u2 = nil;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};

local function addToInitializationQueue(p9, ...) -- Line: 36
    -- upvalues: u7 (ref), script_Logger (copy)
    if u7 == nil then
        script_Logger:w("Initialization queue already cleared.");

        return;
    end;

    table.insert(u7, {
        Func = p9,
        Args = { ... }
    });
    script_Logger:i("Added event to initialization queue");
end;

local function addToInitializationQueueByUserId(p10, p11, ...) -- Line: 50
    -- upvalues: u1 (copy), u8 (copy), script_Logger (copy)
    if u1:isPlayerReady(p10) then
        script_Logger:w("Player initialization queue already cleared.");

        return;
    end;

    if u8[p10] == nil then
        u8[p10] = {};
    end;

    table.insert(u8[p10], {
        Func = p11,
        Args = { ... }
    });
    script_Logger:i("Added event to player initialization queue");
end;

local function isSdkReady(p12) -- Line: 70
    -- upvalues: script_State (copy), script_Logger (copy)
    local v13 = p12.playerId or nil;
    local v14 = p12.needsInitialized or true;
    local v15 = p12.shouldWarn or false;
    local v16 = p12.message or "";

    if v14 and not script_State.Initialized then
        if v15 then
            script_Logger:w(v16 .. " SDK is not initialized");
        end;

        return false;
    end;

    if v14 and (v13 and not script_State:isEnabled(v13)) then
        if v15 then
            script_Logger:w(v16 .. " SDK is disabled");
        end;

        return false;
    end;

    if not (v14 and (v13 and not script_State:sessionIsStarted(v13))) then
        return true;
    end;

    if v15 then
        script_Logger:w(v16 .. " Session has not started yet");
    end;

    return false;
end;

function u1.configureAvailableCustomDimensions01(p17, p18) -- Line: 106
    -- upvalues: isSdkReady (copy), script_Logger (copy), script_State (copy)
    if isSdkReady({
        needsInitialized = true,
        shouldWarn = false
    }) then
        script_Logger:w("Available custom dimensions must be set before SDK is initialized");

        return;
    end;

    script_State:setAvailableCustomDimensions01(p18);
end;

function u1.configureAvailableCustomDimensions02(p19, p20) -- Line: 115
    -- upvalues: isSdkReady (copy), script_Logger (copy), script_State (copy)
    if isSdkReady({
        needsInitialized = true,
        shouldWarn = false
    }) then
        script_Logger:w("Available custom dimensions must be set before SDK is initialized");

        return;
    end;

    script_State:setAvailableCustomDimensions02(p20);
end;

function u1.configureAvailableCustomDimensions03(p21, p22) -- Line: 124
    -- upvalues: isSdkReady (copy), script_Logger (copy), script_State (copy)
    if isSdkReady({
        needsInitialized = true,
        shouldWarn = false
    }) then
        script_Logger:w("Available custom dimensions must be set before SDK is initialized");

        return;
    end;

    script_State:setAvailableCustomDimensions03(p22);
end;

function u1.configureAvailableResourceCurrencies(p23, p24) -- Line: 133
    -- upvalues: isSdkReady (copy), script_Logger (copy), script_Events (copy)
    if isSdkReady({
        needsInitialized = true,
        shouldWarn = false
    }) then
        script_Logger:w("Available resource currencies must be set before SDK is initialized");

        return;
    end;

    script_Events:setAvailableResourceCurrencies(p24);
end;

function u1.configureAvailableResourceItemTypes(p25, p26) -- Line: 142
    -- upvalues: isSdkReady (copy), script_Logger (copy), script_Events (copy)
    if isSdkReady({
        needsInitialized = true,
        shouldWarn = false
    }) then
        script_Logger:w("Available resource item types must be set before SDK is initialized");

        return;
    end;

    script_Events:setAvailableResourceItemTypes(p26);
end;

function u1.configureBuild(p27, p28) -- Line: 151
    -- upvalues: isSdkReady (copy), script_Logger (copy), script_Events (copy)
    if isSdkReady({
        needsInitialized = true,
        shouldWarn = false
    }) then
        script_Logger:w("Build version must be set before SDK is initialized.");

        return;
    end;

    script_Events:setBuild(p28);
end;

function u1.configureAvailableGamepasses(p29, p30) -- Line: 160
    -- upvalues: isSdkReady (copy), script_Logger (copy), script_State (copy)
    if isSdkReady({
        needsInitialized = true,
        shouldWarn = false
    }) then
        script_Logger:w("Available gamepasses must be set before SDK is initialized.");

        return;
    end;

    script_State:setAvailableGamepasses(p30);
end;

function u1.startNewSession(p31, u32, u33) -- Line: 169
    -- upvalues: script_Threading (copy), script_State (copy), script_Logger (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 170
        -- upvalues: script_State (ref), script_Logger (ref), u32 (copy), u33 (copy)
        if not script_State:isEventSubmissionEnabled() then
            return;
        end;

        if script_State.Initialized then
            script_State:startNewSession(u32, u33);

            return;
        end;

        script_Logger:w("Cannot start new session. SDK is not initialized yet.");
    end);
end;

function u1.endSession(p34, u35) -- Line: 184
    -- upvalues: script_Threading (copy), script_State (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 185
        -- upvalues: script_State (ref), u35 (copy)
        if not script_State:isEventSubmissionEnabled() then
            return;
        end;

        script_State:endSession(u35);
    end);
end;

function u1.filterForBusinessEvent(p36, p37) -- Line: 193
    return string.gsub(p37, "[^A-Za-z0-9%s%-_%.%(%)!%?]", "");
end;

function u1.addBusinessEvent(p38, u39, u40) -- Line: 197
    -- upvalues: script_Threading (copy), script_State (copy), isSdkReady (copy), addToInitializationQueueByUserId (copy), u1 (copy), addToInitializationQueue (copy), script_Events (copy), Players (copy), script_Store (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 198
        -- upvalues: script_State (ref), isSdkReady (ref), u39 (copy), addToInitializationQueueByUserId (ref), u1 (ref), u40 (copy), addToInitializationQueue (ref), script_Events (ref), Players (ref), script_Store (ref)
        if not script_State:isEventSubmissionEnabled() then
            return;
        end;

        if not isSdkReady({
            needsInitialized = true,
            shouldWarn = false,
            message = "Could not add business event",
            playerId = u39
        }) then
            if u39 then
                addToInitializationQueueByUserId(u39, u1.addBusinessEvent, u1, u39, u40);

                return;
            end;

            addToInitializationQueue(u1.addBusinessEvent, u1, u39, u40);

            return;
        end;

        local v41 = u40.itemType or "";
        local v42 = u40.itemId or "";
        local v43 = u40.cartType or "";
        local math_floor_ret = math.floor((u40.amount or 0) * 0.7 * 0.35);
        local v44 = u40.gamepassId or nil;
        script_Events:addBusinessEvent(u39, "USD", math_floor_ret, v41, v42, v43);

        if v41 == "Gamepass" and v43 ~= "Website" then
            local PlayerByUserId = Players:GetPlayerByUserId(u39);
            local PlayerDataFromCache = script_Store:GetPlayerDataFromCache(u39);

            if not PlayerDataFromCache.OwnedGamepasses then
                PlayerDataFromCache.OwnedGamepasses = {};
            end;

            table.insert(PlayerDataFromCache.OwnedGamepasses, v44);
            script_Store.PlayerCache[u39] = PlayerDataFromCache;
            script_Store:SavePlayerData(PlayerByUserId);
        end;
    end);
end;

function u1.addResourceEvent(p45, u46, u47) -- Line: 234
    -- upvalues: script_Threading (copy), script_State (copy), isSdkReady (copy), addToInitializationQueueByUserId (copy), u1 (copy), addToInitializationQueue (copy), script_Events (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 235
        -- upvalues: script_State (ref), isSdkReady (ref), u46 (copy), addToInitializationQueueByUserId (ref), u1 (ref), u47 (copy), addToInitializationQueue (ref), script_Events (ref)
        if not script_State:isEventSubmissionEnabled() then
            return;
        end;

        if isSdkReady({
            needsInitialized = true,
            shouldWarn = false,
            message = "Could not add resource event",
            playerId = u46
        }) then
            script_Events:addResourceEvent(u46, u47.flowType or 0, u47.currency or "", u47.amount or 0, u47.itemType or "", u47.itemId or "");

            return;
        end;

        if u46 then
            addToInitializationQueueByUserId(u46, u1.addResourceEvent, u1, u46, u47);

            return;
        end;

        addToInitializationQueue(u1.addResourceEvent, u1, u46, u47);
    end);
end;

function u1.addProgressionEvent(p48, u49, u50) -- Line: 259
    -- upvalues: script_Threading (copy), script_State (copy), isSdkReady (copy), addToInitializationQueueByUserId (copy), u1 (copy), addToInitializationQueue (copy), script_Events (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 260
        -- upvalues: script_State (ref), isSdkReady (ref), u49 (copy), addToInitializationQueueByUserId (ref), u1 (ref), u50 (copy), addToInitializationQueue (ref), script_Events (ref)
        if not script_State:isEventSubmissionEnabled() then
            return;
        end;

        if isSdkReady({
            needsInitialized = true,
            shouldWarn = false,
            message = "Could not add progression event",
            playerId = u49
        }) then
            script_Events:addProgressionEvent(u49, u50.progressionStatus or 0, u50.progression01 or "", u50.progression02 or nil, u50.progression03 or nil, u50.score or nil);

            return;
        end;

        if u49 then
            addToInitializationQueueByUserId(u49, u1.addProgressionEvent, u1, u49, u50);

            return;
        end;

        addToInitializationQueue(u1.addProgressionEvent, u1, u49, u50);
    end);
end;

function u1.addDesignEvent(p51, u52, u53) -- Line: 284
    -- upvalues: script_Threading (copy), script_State (copy), isSdkReady (copy), addToInitializationQueueByUserId (copy), u1 (copy), addToInitializationQueue (copy), script_Events (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 285
        -- upvalues: script_State (ref), isSdkReady (ref), u52 (copy), addToInitializationQueueByUserId (ref), u1 (ref), u53 (copy), addToInitializationQueue (ref), script_Events (ref)
        if not script_State:isEventSubmissionEnabled() then
            return;
        end;

        if isSdkReady({
            needsInitialized = true,
            shouldWarn = false,
            message = "Could not add design event",
            playerId = u52
        }) then
            script_Events:addDesignEvent(u52, u53.eventId or "", u53.value or nil);

            return;
        end;

        if u52 then
            addToInitializationQueueByUserId(u52, u1.addDesignEvent, u1, u52, u53);

            return;
        end;

        addToInitializationQueue(u1.addDesignEvent, u1, u52, u53);
    end);
end;

function u1.addErrorEvent(p54, u55, u56) -- Line: 306
    -- upvalues: script_Threading (copy), script_State (copy), isSdkReady (copy), addToInitializationQueueByUserId (copy), u1 (copy), addToInitializationQueue (copy), script_Events (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 307
        -- upvalues: script_State (ref), isSdkReady (ref), u55 (copy), addToInitializationQueueByUserId (ref), u1 (ref), u56 (copy), addToInitializationQueue (ref), script_Events (ref)
        if not script_State:isEventSubmissionEnabled() then
            return;
        end;

        if isSdkReady({
            needsInitialized = true,
            shouldWarn = false,
            message = "Could not add error event",
            playerId = u55
        }) then
            script_Events:addErrorEvent(u55, u56.severity or 0, u56.message or "");

            return;
        end;

        if u55 then
            addToInitializationQueueByUserId(u55, u1.addErrorEvent, u1, u55, u56);

            return;
        end;

        addToInitializationQueue(u1.addErrorEvent, u1, u55, u56);
    end);
end;

function u1.setEnabledDebugLog(p57, p58) -- Line: 328
    -- upvalues: RunService (copy), script_Logger (copy)
    if not RunService:IsStudio() then
        script_Logger:i("setEnabledDebugLog can only be used in studio");

        return;
    end;

    if p58 then
        script_Logger:setDebugLog(p58);
        script_Logger:i("Debug logging enabled");

        return;
    end;

    script_Logger:i("Debug logging disabled");
    script_Logger:setDebugLog(p58);
end;

function u1.setEnabledInfoLog(p59, p60) -- Line: 342
    -- upvalues: script_Logger (copy)
    if p60 then
        script_Logger:setInfoLog(p60);
        script_Logger:i("Info logging enabled");

        return;
    end;

    script_Logger:i("Info logging disabled");
    script_Logger:setInfoLog(p60);
end;

function u1.setEnabledVerboseLog(p61, p62) -- Line: 352
    -- upvalues: script_Logger (copy)
    if p62 then
        script_Logger:setVerboseLog(p62);
        script_Logger:ii("Verbose logging enabled");

        return;
    end;

    script_Logger:ii("Verbose logging disabled");
    script_Logger:setVerboseLog(p62);
end;

function u1.setEnabledEventSubmission(p63, u64) -- Line: 363
    -- upvalues: script_Threading (copy), script_State (copy), script_Logger (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 364
        -- upvalues: u64 (copy), script_State (ref), script_Logger (ref)
        if u64 then
            script_State:setEventSubmission(u64);
            script_Logger:i("Event submission enabled");

            return;
        end;

        script_Logger:i("Event submission disabled");
        script_State:setEventSubmission(u64);
    end);
end;

function u1.setCustomDimension01(p65, u66, u67) -- Line: 375
    -- upvalues: script_Threading (copy), script_Validation (copy), script_State (copy), script_Logger (copy), isSdkReady (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 376
        -- upvalues: script_Validation (ref), script_State (ref), u67 (copy), script_Logger (ref), isSdkReady (ref), u66 (copy)
        if not script_Validation:validateDimension(script_State._availableCustomDimensions01, u67) then
            script_Logger:w("Could not set custom01 dimension value to \'" .. u67 .. "\'. Value not found in available custom01 dimension values");

            return;
        end;

        if not isSdkReady({
            needsInitialized = true,
            shouldWarn = true,
            message = "Could not set custom01 dimension",
            playerId = u66
        }) then
            return;
        end;

        script_State:setCustomDimension01(u66, u67);
    end);
end;

function u1.setCustomDimension02(p68, u69, u70) -- Line: 390
    -- upvalues: script_Threading (copy), script_Validation (copy), script_State (copy), script_Logger (copy), isSdkReady (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 391
        -- upvalues: script_Validation (ref), script_State (ref), u70 (copy), script_Logger (ref), isSdkReady (ref), u69 (copy)
        if not script_Validation:validateDimension(script_State._availableCustomDimensions02, u70) then
            script_Logger:w("Could not set custom02 dimension value to \'" .. u70 .. "\'. Value not found in available custom02 dimension values");

            return;
        end;

        if not isSdkReady({
            needsInitialized = true,
            shouldWarn = true,
            message = "Could not set custom02 dimension",
            playerId = u69
        }) then
            return;
        end;

        script_State:setCustomDimension02(u69, u70);
    end);
end;

function u1.setCustomDimension03(p71, u72, u73) -- Line: 405
    -- upvalues: script_Threading (copy), script_Validation (copy), script_State (copy), script_Logger (copy), isSdkReady (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 406
        -- upvalues: script_Validation (ref), script_State (ref), u73 (copy), script_Logger (ref), isSdkReady (ref), u72 (copy)
        if not script_Validation:validateDimension(script_State._availableCustomDimensions03, u73) then
            script_Logger:w("Could not set custom03 dimension value to \'" .. u73 .. "\'. Value not found in available custom03 dimension values");

            return;
        end;

        if not isSdkReady({
            needsInitialized = true,
            shouldWarn = true,
            message = "Could not set custom03 dimension",
            playerId = u72
        }) then
            return;
        end;

        script_State:setCustomDimension03(u72, u73);
    end);
end;

function u1.setEnabledReportErrors(p74, u75) -- Line: 420
    -- upvalues: script_Threading (copy), script_State (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 421
        -- upvalues: script_State (ref), u75 (copy)
        script_State.ReportErrors = u75;
    end);
end;

function u1.setEnabledCustomUserId(p76, u77) -- Line: 426
    -- upvalues: script_Threading (copy), script_State (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 427
        -- upvalues: script_State (ref), u77 (copy)
        script_State.UseCustomUserId = u77;
    end);
end;

function u1.setEnabledAutomaticSendBusinessEvents(p78, u79) -- Line: 432
    -- upvalues: script_Threading (copy), script_State (copy)
    script_Threading:performTaskOnGAThread(function() -- Line: 433
        -- upvalues: script_State (ref), u79 (copy)
        script_State.AutomaticSendBusinessEvents = u79;
    end);
end;

function u1.addGameAnalyticsTeleportData(p80, p81, p82) -- Line: 438
    -- upvalues: script_Store (copy)
    local v83 = {};

    for _, v in ipairs(p81) do
        local PlayerDataFromCache = script_Store:GetPlayerDataFromCache(v);
        PlayerDataFromCache.PlayerTeleporting = true;
        local v84 = {
            SessionID = PlayerDataFromCache.SessionID,
            Sessions = PlayerDataFromCache.Sessions,
            SessionStart = PlayerDataFromCache.SessionStart
        };
        v83[tostring(v)] = v84;
    end;

    p82.gameanalyticsData = v83;

    return p82;
end;

function u1.getRemoteConfigsValueAsString(p85, p86, p87) -- Line: 457
    -- upvalues: script_State (copy)
    return script_State:getRemoteConfigsStringValue(p86, p87.key or "", p87.defaultValue or nil);
end;

function u1.isRemoteConfigsReady(p88, p89) -- Line: 463
    -- upvalues: script_State (copy)
    return script_State:isRemoteConfigsReady(p89);
end;

function u1.getRemoteConfigsContentAsString(p90, p91) -- Line: 467
    -- upvalues: script_State (copy)
    return script_State:getRemoteConfigsContentAsString(p91);
end;

function u1.PlayerJoined(p92, p93) -- Line: 471
    -- upvalues: script_Store (copy), script_Postie (copy), script_Utilities (copy), script_Events (copy), script_State (copy), script_Logger (copy), u1 (copy), u2 (ref), ReplicatedStorage (copy), MarketplaceService (copy), u3 (copy), u8 (copy)
    local TeleportData = p93:GetJoinData().TeleportData;
    local PlayerData = script_Store:GetPlayerData(p93);
    local v94;

    if TeleportData then
        v94 = TeleportData.gameanalyticsData and TeleportData.gameanalyticsData[tostring(p93.UserId)];
    else
        v94 = nil;
    end;

    local PlayerDataFromCache = script_Store:GetPlayerDataFromCache(p93.UserId);

    if PlayerDataFromCache then
        if v94 then
            PlayerDataFromCache.SessionID = v94.SessionID;
            PlayerDataFromCache.SessionStart = v94.SessionStart;
        end;

        PlayerDataFromCache.PlayerTeleporting = false;

        return;
    end;

    local v95, v96 = script_Postie.invokeClient("getPlatform", p93, 5);
    local v97 = not v95 and "unknown" or v96;

    for i, v in pairs(script_Store.BasePlayerData) do
        if not PlayerData[i] then
            if typeof(v) == "table" then
                PlayerData[i] = script_Utilities:copyTable(v);
            else
                PlayerData[i] = v;
            end;
        end;
    end;

    local success, result = pcall(function() -- Line: 512
        return "US";
    end);

    if success then
        PlayerData.CountryCode = result;
    end;

    script_Store.PlayerCache[p93.UserId] = PlayerData;
    local v98;

    if v97 == "Console" then
        v98 = "uwp_console";
    elseif v97 == "Mobile" then
        v98 = "uwp_mobile";
    else
        local _ = v97 == "Desktop";
        v98 = "uwp_desktop";
    end;

    PlayerData.Platform = v98;
    PlayerData.OS = PlayerData.Platform .. " 0.0.0";

    if not success then
        script_Events:addSdkErrorEvent(p93.UserId, "event_validation", "player_joined", "string_empty_or_null", "country_code", "");
    end;

    local v99 = "";
    local v100;

    if script_State.UseCustomUserId then
        local v101;
        v101, v100 = script_Postie.invokeClient("getCustomUserId", p93, 5);

        if not v101 then
            v100 = v99;
        end;
    else
        v100 = v99;
    end;

    if not script_Utilities:isStringNullOrEmpty(v100) then
        script_Logger:i("Using custom id: " .. v100);
        PlayerData.CustomUserId = v100;
    end;

    u1:startNewSession(p93, v94);
    u2 = u2 or ReplicatedStorage:WaitForChild("OnPlayerReadyEvent");
    u2:Fire(p93);

    if script_State.AutomaticSendBusinessEvents then
        if PlayerData.OwnedGamepasses == nil then
            PlayerData.OwnedGamepasses = {};

            for _, v in ipairs(script_State._availableGamepasses) do
                if MarketplaceService:UserOwnsGamePassAsync(p93.UserId, v) then
                    table.insert(PlayerData.OwnedGamepasses, v);
                end;
            end;

            script_Store.PlayerCache[p93.UserId] = PlayerData;
            script_Store:SavePlayerData(p93);
        else
            local v102 = {};

            for _, v in ipairs(script_State._availableGamepasses) do
                if MarketplaceService:UserOwnsGamePassAsync(p93.UserId, v) then
                    table.insert(v102, v);
                end;
            end;

            local v103 = {};

            for _, v in ipairs(PlayerData.OwnedGamepasses) do
                v103[v] = true;
            end;

            for _, v in ipairs(v102) do
                if not v103[v] then
                    table.insert(PlayerData.OwnedGamepasses, v);
                    local v104 = u3[v];

                    if not v104 then
                        v104 = MarketplaceService:GetProductInfo(v, Enum.InfoType.GamePass);
                        u3[v] = v104;
                    end;

                    u1:addBusinessEvent(p93.UserId, {
                        itemType = "Gamepass",
                        cartType = "Website",
                        amount = v104.PriceInRobux,
                        itemId = u1:filterForBusinessEvent(v104.Name)
                    });
                end;
            end;

            script_Store.PlayerCache[p93.UserId] = PlayerData;
            script_Store:SavePlayerData(p93);
        end;
    end;

    local v105 = u8[p93.UserId];

    if v105 then
        u8[p93.UserId] = nil;

        for _, v in ipairs(v105) do
            v.Func(unpack(v.Args));
        end;

        script_Logger:i("Player initialization queue called #" .. #v105 .. " events");
    end;
end;

function u1.PlayerRemoved(p106, p107) -- Line: 615
    -- upvalues: script_Store (copy), u1 (copy)
    script_Store:SavePlayerData(p107);
    local PlayerDataFromCache = script_Store:GetPlayerDataFromCache(p107.UserId);

    if PlayerDataFromCache then
        if not PlayerDataFromCache.PlayerTeleporting then
            u1:endSession(p107.UserId);

            return;
        end;

        script_Store.PlayerCache[p107.UserId] = nil;
        script_Store.DataStoreQueue.RemoveKey(p107.UserId);
    end;
end;

function u1.isPlayerReady(p108, p109) -- Line: 630
    -- upvalues: script_Store (copy)
    return script_Store:GetPlayerDataFromCache(p109) and true or false;
end;

function u1.ProcessReceiptCallback(p110, u111) -- Line: 638
    -- upvalues: u3 (copy), MarketplaceService (copy), u1 (copy)
    local u112 = u3[u111.ProductId];

    if not u112 then
        pcall(function() -- Line: 645
            -- upvalues: u112 (ref), MarketplaceService (ref), u111 (copy), u3 (ref)
            u112 = MarketplaceService:GetProductInfo(u111.ProductId, Enum.InfoType.Product);
            u3[u111.ProductId] = u112;
        end);
    end;

    if u112 then
        u1:addBusinessEvent(u111.PlayerId, {
            itemType = "DeveloperProduct",
            amount = u111.CurrencySpent,
            itemId = u1:filterForBusinessEvent(u112.Name)
        });
    end;
end;

function u1.GamepassPurchased(p113, p114, p115, p116) -- Line: 661
    -- upvalues: u3 (copy), MarketplaceService (copy), u1 (copy)
    local v117 = u3[p115];

    if not v117 then
        v117 = MarketplaceService:GetProductInfo(p115, Enum.InfoType.GamePass);
        u3[p115] = v117;
    end;

    local v118 = 0;
    local v119 = "GamePass";

    if p116 then
        v118 = p116.PriceInRobux;
        v119 = p116.Name;
    elseif v117 then
        v118 = v117.PriceInRobux;
        v119 = v117.Name;
    end;

    u1:addBusinessEvent(p114.UserId, {
        itemType = "Gamepass",
        amount = v118 or 0,
        itemId = u1:filterForBusinessEvent(v119),
        gamepassId = p115
    });
end;

local u120 = { "gameKey", "secretKey" };

function u1.initServer(p121: table, p122: string, p123: string) -- Line: 692
    -- upvalues: u1 (copy)
    u1:initialize({
        gameKey = p122,
        secretKey = p123
    });
end;

function u1.initialize(p124, u125) -- Line: 699
    -- upvalues: script_Threading (copy), u120 (copy), script_Logger (copy), u1 (copy), isSdkReady (copy), script_Validation (copy), script_Events (copy), script_State (copy), Players (copy), u7 (ref)
    script_Threading:performTaskOnGAThread(function() -- Line: 700
        -- upvalues: u120 (ref), u125 (copy), script_Logger (ref), u1 (ref), isSdkReady (ref), script_Validation (ref), script_Events (ref), script_State (ref), Players (ref), u7 (ref)
        for _, v in ipairs(u120) do
            if u125[v] == nil then
                script_Logger:e("Initialize \'" .. v .. "\' option missing");

                return;
            end;
        end;

        if u125.enableInfoLog ~= nil and u125.enableInfoLog then
            u1:setEnabledInfoLog(u125.enableInfoLog);
        end;

        if u125.enableVerboseLog ~= nil and u125.enableVerboseLog then
            u1:setEnabledVerboseLog(u125.enableVerboseLog);
        end;

        if u125.availableCustomDimensions01 ~= nil and #u125.availableCustomDimensions01 > 0 then
            u1:configureAvailableCustomDimensions01(u125.availableCustomDimensions01);
        end;

        if u125.availableCustomDimensions02 ~= nil and #u125.availableCustomDimensions02 > 0 then
            u1:configureAvailableCustomDimensions02(u125.availableCustomDimensions02);
        end;

        if u125.availableCustomDimensions03 ~= nil and #u125.availableCustomDimensions03 > 0 then
            u1:configureAvailableCustomDimensions03(u125.availableCustomDimensions03);
        end;

        if u125.availableResourceCurrencies ~= nil and #u125.availableResourceCurrencies > 0 then
            u1:configureAvailableResourceCurrencies(u125.availableResourceCurrencies);
        end;

        if u125.availableResourceItemTypes ~= nil and #u125.availableResourceItemTypes > 0 then
            u1:configureAvailableResourceItemTypes(u125.availableResourceItemTypes);
        end;

        if u125.build ~= nil and #u125.build > 0 then
            u1:configureBuild(u125.build);
        end;

        if u125.availableGamepasses ~= nil and #u125.availableGamepasses > 0 then
            u1:configureAvailableGamepasses(u125.availableGamepasses);
        end;

        if u125.enableDebugLog ~= nil then
            u1:setEnabledDebugLog(u125.enableDebugLog);
        end;

        if u125.automaticSendBusinessEvents ~= nil then
            u1:setEnabledAutomaticSendBusinessEvents(u125.automaticSendBusinessEvents);
        end;

        if u125.reportErrors ~= nil then
            u1:setEnabledReportErrors(u125.reportErrors);
        end;

        if u125.useCustomUserId ~= nil then
            u1:setEnabledCustomUserId(u125.useCustomUserId);
        end;

        if isSdkReady({
            needsInitialized = true,
            shouldWarn = false
        }) then
            script_Logger:w("SDK already initialized. Can only be called once.");

            return;
        end;

        local gameKey = u125.gameKey;
        local secretKey = u125.secretKey;

        if not script_Validation:validateKeys(gameKey, secretKey) then
            script_Logger:w("SDK failed initialize. Game key or secret key is invalid. Can only contain characters A-z 0-9, gameKey is 32 length, secretKey is 40 length. Failed keys - gameKey: " .. gameKey .. ", secretKey: " .. secretKey);

            return;
        end;

        script_Events.GameKey = gameKey;
        script_Events.SecretKey = secretKey;
        script_State.Initialized = true;
        Players.PlayerAdded:Connect(function(p126) -- Line: 768
            -- upvalues: u1 (ref)
            u1:PlayerJoined(p126);
        end);
        Players.PlayerRemoving:Connect(function(p127) -- Line: 773
            -- upvalues: u1 (ref)
            u1:PlayerRemoved(p127);
        end);

        for _, v in ipairs(Players:GetPlayers()) do
            coroutine.wrap(u1.PlayerJoined)(u1, v);
        end;

        for _, v in ipairs(u7) do
            task.spawn(v.Func, unpack(v.Args));
        end;

        script_Logger:i("Server initialization queue called #" .. #u7 .. " events");
        u7 = nil;
        script_Events:processEventQueue();
    end);
end;

if not ReplicatedStorage:FindFirstChild("GameAnalyticsRemoteConfigs") then
    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = "GameAnalyticsRemoteConfigs";
    RemoteEvent.Parent = ReplicatedStorage;
end;

if not ReplicatedStorage:FindFirstChild("OnPlayerReadyEvent") then
    local BindableEvent = Instance.new("BindableEvent");
    BindableEvent.Name = "OnPlayerReadyEvent";
    BindableEvent.Parent = ReplicatedStorage;
end;

task.spawn(function() -- Line: 808
    -- upvalues: u4 (ref), script_Store (copy), u5 (ref), u6 (ref)
    local v128 = os.time() / 3600;
    u4 = script_Store:GetErrorDataStore((math.floor(v128)));

    while task.wait(3600) do
        local v129 = os.time() / 3600;
        u4 = script_Store:GetErrorDataStore((math.floor(v129)));
        u5 = {};
        u6 = {};
    end;
end);

local function ErrorHandler(p130, p131, p132, p133) -- Line: 848
    -- upvalues: u5 (ref), u6 (ref), u1 (copy)
    local v134 = (p132 == nil and "(null)" or p132) .. ": message=" .. (p130 == nil and "(null)" or p130) .. ", trace=" .. (p131 == nil and "(null)" or p131);

    if #v134 > 8192 then
        v134 = string.sub(v134, 1, 8192);
    end;

    local v135;

    if p133 then
        v135 = p133.UserId;
        v134 = v134:gsub(p133.Name, "[LocalPlayer]");
    else
        v135 = nil;
    end;

    local v136;

    if #v134 > 50 then
        v136 = string.sub(v134, 1, 50);
    else
        v136 = v134;
    end;

    if u5[v136] == nil then
        u6[#u6 + 1] = v136;
        u5[v136] = {};
        u5[v136].countInDS = 0;
        u5[v136].currentCount = 0;
    end;

    if u5[v136].currentCount > 10 then
        return;
    end;

    u1:addErrorEvent(v135, {
        severity = u1.EGAErrorSeverity.error,
        message = v134
    });
    u5[v136].currentCount = u5[v136].currentCount + 1;
end;

local function ErrorHandlerFromClient(p137, p138, p139, p140) -- Line: 920
    -- upvalues: script_State (copy), ErrorHandler (copy)
    if script_State.ReportErrors then
        return ErrorHandler(p137, p138, p139, p140);
    end;
end;

ScriptContext.Error:Connect(function(p141, p142, u143) -- Line: 899, Name: ErrorHandlerFromServer
    -- upvalues: script_State (copy), ErrorHandler (copy)
    if not script_State.ReportErrors then
        return;
    end;

    if not u143 then
        return;
    end;

    local u144 = nil;
    local success, _ = pcall(function() -- Line: 910
        -- upvalues: u144 (ref), u143 (copy)
        u144 = u143:GetFullName();
    end);

    if success then
        return ErrorHandler(p141, p142, u144);
    end;
end);

if not ReplicatedStorage:FindFirstChild("GameAnalyticsError") then
    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = "GameAnalyticsError";
    RemoteEvent.Parent = ReplicatedStorage;
end;

ReplicatedStorage.GameAnalyticsError.OnServerEvent:Connect(function(p145, p146, p147, p148) -- Line: 938
    -- upvalues: script_State (copy), ErrorHandler (copy)
    if not script_State.ReportErrors then
        return;
    end;

    ErrorHandler(p146, p147, p148, p145);
end);
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(p149, p150, p151) -- Line: 944
    -- upvalues: script_State (copy), u1 (copy)
    if not (script_State.AutomaticSendBusinessEvents and p151) then
        return;
    end;

    u1:GamepassPurchased(p149, p150);
end);

return u1;