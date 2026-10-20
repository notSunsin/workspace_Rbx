-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Validation = require(script.Parent.Validation);
local Version = require(script.Parent.Version);
local script_HashLib = require(script.HashLib);
local u1 = {
    protocol = "https",
    hostName = "api.gameanalytics.com",
    version = "v2",
    remoteConfigsVersion = "v1",
    initializeUrlPath = "init",
    eventsUrlPath = "events",
    EGAHTTPApiResponse = {
        NoResponse = 0,
        BadResponse = 1,
        RequestTimeout = 2,
        JsonEncodeFailed = 3,
        JsonDecodeFailed = 4,
        InternalServerError = 5,
        BadRequest = 6,
        Unauthorized = 7,
        UnknownResponseCode = 8,
        Ok = 9,
        Created = 10
    }
};
local HttpService = game:GetService("HttpService");
local Logger = require(script.Parent.Logger);
local u2 = (RunService:IsStudio() and "https" or u1.protocol) .. "://" .. (RunService:IsStudio() and "sandbox-" or "") .. u1.hostName .. "/" .. u1.version;
local u3 = (RunService:IsStudio() and "https" or u1.protocol) .. "://" .. (RunService:IsStudio() and "sandbox-" or "") .. u1.hostName .. "/remote_configs/" .. u1.remoteConfigsVersion;

local function getInitAnnotations(p4, p5, p6) -- Line: 34
    -- upvalues: Version (copy)
    return {
        user_id = tostring(p6) .. p5.CustomUserId,
        sdk_version = "roblox " .. Version.SdkVersion,
        os_version = p5.OS,
        platform = p5.Platform,
        build = p4,
        session_num = p5.Sessions,
        random_salt = p5.Sessions
    };
end;

local function encode(p7, p8) -- Line: 48
    -- upvalues: Logger (copy), script_HashLib (copy), RunService (copy)
    if p8 then
        local v9 = script_HashLib.hmac(script_HashLib.sha256, RunService:IsStudio() and "16813a12f718bc5c620f56944e1abc3ea13ccbac" or p8, p7, true);

        return script_HashLib.base64_encode(v9);
    end;

    Logger:w("Error encoding, invalid SecretKey");
end;

local function processRequestResponse(p10, p11) -- Line: 66
    -- upvalues: Logger (copy), u1 (copy)
    local StatusCode = p10.StatusCode;
    local Body = p10.Body;

    if not Body or #Body == 0 then
        Logger:d(p11 .. " request. failed. Might be no connection. Status code: " .. tostring(StatusCode));

        return u1.EGAHTTPApiResponse.NoResponse;
    end;

    if StatusCode == 200 then
        return u1.EGAHTTPApiResponse.Ok;
    end;

    if StatusCode == 201 then
        return u1.EGAHTTPApiResponse.Created;
    end;

    if StatusCode == 0 or StatusCode == 401 then
        Logger:d(p11 .. " request. 401 - Unauthorized.");

        return u1.EGAHTTPApiResponse.Unauthorized;
    end;

    if StatusCode == 400 then
        Logger:d(p11 .. " request. 400 - Bad Request.");

        return u1.EGAHTTPApiResponse.BadRequest;
    end;

    if StatusCode ~= 500 then
        return u1.EGAHTTPApiResponse.UnknownResponseCode;
    end;

    Logger:d(p11 .. " request. 500 - Internal Server Error.");

    return u1.EGAHTTPApiResponse.InternalServerError;
end;

function u1.initRequest(p12, p13, p14, p15, p16, p17) -- Line: 93
    -- upvalues: u3 (copy), u1 (copy), RunService (copy), u2 (copy), Logger (copy), HttpService (copy), Version (copy), script_HashLib (copy), processRequestResponse (copy), Validation (copy)
    local u18 = u3 .. "/" .. u1.initializeUrlPath .. "?game_key=" .. p13 .. "&interval_seconds=0&configs_hash=" .. (p16.ConfigsHash or "");

    if RunService:IsStudio() then
        u18 = u2 .. "/5c6bcb5402204249437fb5a7a80a4959/" .. p12.initializeUrlPath;
    end;

    Logger:d("Sending \'init\' URL: " .. u18);
    local u19 = HttpService:JSONEncode({
        user_id = tostring(p17) .. p16.CustomUserId,
        sdk_version = "roblox " .. Version.SdkVersion,
        os_version = p16.OS,
        platform = p16.Platform,
        build = p15,
        session_num = p16.Sessions,
        random_salt = p16.Sessions
    }):gsub("\"country_code\":\"unknown\"", "\"country_code\":null");
    local v20 = u19;
    local u21;

    if p14 then
        local v22 = script_HashLib.hmac(script_HashLib.sha256, RunService:IsStudio() and "16813a12f718bc5c620f56944e1abc3ea13ccbac" or p14, v20, true);
        u21 = script_HashLib.base64_encode(v22);
    else
        Logger:w("Error encoding, invalid SecretKey");
        u21 = nil;
    end;

    Logger:d("init payload: " .. u19);
    local u23 = nil;
    local success, result = pcall(function() -- Line: 108
        -- upvalues: u23 (ref), HttpService (ref), u18 (ref), u21 (copy), u19 (ref)
        u23 = HttpService:RequestAsync({
            Method = "POST",
            Url = u18,
            Headers = {
                Authorization = u21,
                ["Content-Type"] = "application/json"
            },
            Body = u19
        });
    end);

    if not success then
        Logger:d("Failed Init Call. error: " .. result);

        return {
            body = nil,
            statusCode = u1.EGAHTTPApiResponse.UnknownResponseCode
        };
    end;

    Logger:d("init request content: " .. u23.Body);
    local v24 = processRequestResponse(u23, "Init");

    if v24 ~= u1.EGAHTTPApiResponse.Ok and (v24 ~= u1.EGAHTTPApiResponse.Created and v24 ~= u1.EGAHTTPApiResponse.BadRequest) then
        Logger:d("Failed Init Call. URL: " .. u18 .. ", JSONString: " .. u19 .. ", Authorization: " .. u21);

        return {
            body = nil,
            statusCode = v24
        };
    end;

    local u25 = nil;

    if not pcall(function() -- Line: 142
        -- upvalues: u25 (ref), HttpService (ref), u23 (ref)
        u25 = HttpService:JSONDecode(u23.Body);
    end) then
        Logger:d("Failed Init Call. Json decoding failed: " .. result);

        return {
            body = nil,
            statusCode = u1.EGAHTTPApiResponse.JsonDecodeFailed
        };
    end;

    if v24 ~= u1.EGAHTTPApiResponse.BadRequest then
        return Validation:validateAndCleanInitRequestResponse(u25, v24 == u1.EGAHTTPApiResponse.Created) and {
            statusCode = v24,
            body = u25
        } or {
            body = nil,
            statusCode = u1.EGAHTTPApiResponse.BadResponse
        };
    end;

    Logger:d("Failed Init Call. Bad request. Response: " .. u23.Body);

    return {
        body = nil,
        statusCode = v24
    };
end;

function u1.sendEventsInArray(p26, p27, p28, p29) -- Line: 179
    -- upvalues: Logger (copy), u2 (copy), RunService (copy), HttpService (copy), script_HashLib (copy), u1 (copy), processRequestResponse (copy)
    if p29 and #p29 ~= 0 then
        local u30 = u2 .. "/" .. p27 .. "/" .. p26.eventsUrlPath;

        if RunService:IsStudio() then
            u30 = u2 .. "/5c6bcb5402204249437fb5a7a80a4959/" .. p26.eventsUrlPath;
        end;

        Logger:d("Sending \'events\' URL: " .. u30);
        local u31 = HttpService:JSONEncode(p29):gsub("\"country_code\":\"unknown\"", "\"country_code\":null");
        local v32 = u31;
        local u33;

        if p28 then
            local v34 = script_HashLib.hmac(script_HashLib.sha256, RunService:IsStudio() and "16813a12f718bc5c620f56944e1abc3ea13ccbac" or p28, v32, true);
            u33 = script_HashLib.base64_encode(v34);
        else
            Logger:w("Error encoding, invalid SecretKey");
            u33 = nil;
        end;

        local u35 = nil;
        local success, result = pcall(function() -- Line: 199
            -- upvalues: u35 (ref), HttpService (ref), u30 (ref), u33 (copy), u31 (ref)
            u35 = HttpService:RequestAsync({
                Method = "POST",
                Url = u30,
                Headers = {
                    Authorization = u33,
                    ["Content-Type"] = "application/json"
                },
                Body = u31
            });
        end);

        if not success then
            Logger:d("Failed Events Call. error: " .. result);

            return {
                body = nil,
                statusCode = u1.EGAHTTPApiResponse.UnknownResponseCode
            };
        end;

        Logger:d("body: " .. u35.Body);
        local v36 = processRequestResponse(u35, "Events");

        if v36 ~= u1.EGAHTTPApiResponse.Ok and (v36 ~= u1.EGAHTTPApiResponse.Created and v36 ~= u1.EGAHTTPApiResponse.BadRequest) then
            Logger:d("Failed Events Call. URL: " .. u30 .. ", JSONString: " .. u31 .. ", Authorization: " .. u33);

            return {
                body = nil,
                statusCode = v36
            };
        end;

        local u37 = nil;
        pcall(function() -- Line: 233
            -- upvalues: u37 (ref), HttpService (ref), u35 (ref)
            u37 = HttpService:JSONDecode(u35.Body);
        end);

        if not u37 then
            Logger:d("Failed Events Call. Json decoding failed");

            return {
                body = nil,
                statusCode = u1.EGAHTTPApiResponse.JsonDecodeFailed
            };
        end;

        if v36 ~= u1.EGAHTTPApiResponse.BadRequest then
            return {
                statusCode = u1.EGAHTTPApiResponse.Ok,
                body = u37
            };
        end;

        Logger:d("Failed Events Call. Bad request. Response: " .. u35.Body);

        return {
            body = nil,
            statusCode = v36
        };
    end;

    Logger:d("sendEventsInArray called with missing eventArray");
end;

return u1;