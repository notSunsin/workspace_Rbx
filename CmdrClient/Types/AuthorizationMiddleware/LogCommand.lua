-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local MarketplaceService = game:GetService("MarketplaceService");
local ServerStorage = game:GetService("ServerStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local RunService = game:GetService("RunService");
local GameConfigService = require(ServerScriptService.Modules.GameConfigService);
local SPPServices = ServerScriptService.Modules.SPPServices;
local EventLogging = require(SPPServices.EventLogging);
require(SPPServices.EventLogging.EventLoggingClient);
local SECRETS_DO_NOT_EXPOSE_TO_CLIENT = require(ServerStorage.SECRETS_DO_NOT_EXPOSE_TO_CLIENT);

local function IsSPPLoggingEnabled() -- Line: 27
    -- upvalues: GameConfigService (copy)
    return GameConfigService:GetConfig("CommandLoggingToSPPEnabled") == true;
end;

local function WrapInCodeBlockSmall(p1) -- Line: 31
    return ("``%s``"):format((tostring(p1)));
end;

local function FetchThumbnailUrl(u2) -- Line: 36
    -- upvalues: HttpService (copy)
    local success, result = pcall(function() -- Line: 37
        -- upvalues: u2 (copy), HttpService (ref)
        return HttpService:JSONDecode((HttpService:GetAsync("https://thumbnails.roproxy.com/v1/assets?assetIds=" .. u2 .. "&returnPolicy=PlaceHolder&size=512x512&format=Png&isCircular=false"))).data[1].imageUrl;
    end);

    if success then
        return result;
    end;

    return nil;
end;

local function FetchGameAssetData() -- Line: 49
    -- upvalues: MarketplaceService (copy)
    local success, result = pcall(function() -- Line: 50
        -- upvalues: MarketplaceService (ref)
        return MarketplaceService:GetProductInfo(game.PlaceId, Enum.InfoType.Asset);
    end);

    if success then
        return result;
    end;

    return nil;
end;

local u3 = nil;
local u4 = nil;

local function SetupGameAsset() -- Line: 64
    -- upvalues: u3 (ref), MarketplaceService (copy), u4 (ref), HttpService (copy)
    if not u3 then
        local success, result = pcall(function() -- Line: 50
            -- upvalues: MarketplaceService (ref)
            return MarketplaceService:GetProductInfo(game.PlaceId, Enum.InfoType.Asset);
        end);

        if not success then
            result = nil;
        end;

        u3 = result;
    end;

    if not u4 then
        local game_PlaceId = game.PlaceId;
        local success, result = pcall(function() -- Line: 37
            -- upvalues: game_PlaceId (copy), HttpService (ref)
            return HttpService:JSONDecode((HttpService:GetAsync("https://thumbnails.roproxy.com/v1/assets?assetIds=" .. game_PlaceId .. "&returnPolicy=PlaceHolder&size=512x512&format=Png&isCircular=false"))).data[1].imageUrl;
        end);

        if not success then
            result = nil;
        end;

        u4 = result;
    end;
end;

local function LogToWebhook(p5) -- Line: 74
    -- upvalues: SECRETS_DO_NOT_EXPOSE_TO_CLIENT (copy), u3 (ref), MarketplaceService (copy), u4 (ref), HttpService (copy), RunService (copy)
    local v6 = ({
        [7500518143] = SECRETS_DO_NOT_EXPOSE_TO_CLIENT.ANAYLITICS_CMDR_DEV,
        [7835737630] = SECRETS_DO_NOT_EXPOSE_TO_CLIENT.ANAYLITICS_CMDR_QA,
        [7436755782] = SECRETS_DO_NOT_EXPOSE_TO_CLIENT.ANAYLITICS_CMDR_PROD
    })[game.GameId];

    if not u3 then
        local success, result = pcall(function() -- Line: 50
            -- upvalues: MarketplaceService (ref)
            return MarketplaceService:GetProductInfo(game.PlaceId, Enum.InfoType.Asset);
        end);

        if not success then
            result = nil;
        end;

        u3 = result;
    end;

    if not u4 then
        local game_PlaceId = game.PlaceId;
        local success, result = pcall(function() -- Line: 37
            -- upvalues: game_PlaceId (copy), HttpService (ref)
            return HttpService:JSONDecode((HttpService:GetAsync("https://thumbnails.roproxy.com/v1/assets?assetIds=" .. game_PlaceId .. "&returnPolicy=PlaceHolder&size=512x512&format=Png&isCircular=false"))).data[1].imageUrl;
        end);

        if not success then
            result = nil;
        end;

        u4 = result;
    end;

    local v7 = game.JobId == "" and "UNKNOWN" or tostring(game.JobId);
    local Executor = p5.Executor;
    local v8 = {
        content = "",
        attachments = {}
    };
    local v9 = {};
    local v10 = {
        color = 28152
    };
    local RawText = p5.RawText;
    local Name = u3.Name;
    local v11 = `https://www.roblox.com/games/{game.PlaceId}/`;
    local v12 = ("``%s``"):format((tostring(v7)));
    local v13 = RunService:IsStudio();
    v10.description = ("```lua\n%s```\n**Execution Context**\nPlace: [%s](%s)\nJobId: %s\nIsStudio: %s\nExecutor: %s\n"):format(RawText, Name, v11, v12, ("``%s``"):format((tostring(v13))), (`**[{Executor.Name}](https://www.roblox.com/users/{Executor.UserId}/profile)**`));
    v10.title = "CMDR Command Ran";
    v10.thumbnail = {
        url = u4
    };
    v9[1] = v10;
    v8.embeds = v9;
    HttpService:RequestAsync({
        Method = "POST",
        Url = v6,
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(v8)
    });
end;

local function LogToSPP(p14) -- Line: 120
    -- upvalues: EventLogging (copy)
    local Executor = p14.Executor;
    local v15 = game.JobId == "" and "UNKNOWN" or tostring(game.JobId);
    EventLogging.Log({
        event_type = "admin.execute_command." .. p14.Name,
        actor_id = tostring(Executor.UserId),
        payload = {
            command_text = p14.RawText,
            job_id = v15
        }
    });
end;

return function(p16) -- Line: 136, Name: LogCommand
    -- upvalues: LogToWebhook (copy), GameConfigService (copy), LogToSPP (copy)
    task.spawn(LogToWebhook, p16);

    if GameConfigService:GetConfig("CommandLoggingToSPPEnabled") == true then
        task.spawn(LogToSPP, p16);
    end;
end;