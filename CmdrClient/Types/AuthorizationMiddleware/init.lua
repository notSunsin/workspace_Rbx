-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
game:GetService("HttpService");
local RunService = game:GetService("RunService");
game:GetService("MarketplaceService");
local ServerScriptService = game:GetService("ServerScriptService");
local NeedCommandAuthorization = require(ReplicatedStorage.Data.NeedCommandAuthorization);
local IsCommandAuthorized = require(ReplicatedStorage.Modules.IsCommandAuthorized);

return function(p1) -- Line: 19
    -- upvalues: IsCommandAuthorized (copy), RunService (copy), NeedCommandAuthorization (copy), ServerScriptService (copy)
    p1:RegisterHook("BeforeRun", function(p2) -- Line: 20
        -- upvalues: IsCommandAuthorized (ref), RunService (ref), NeedCommandAuthorization (ref), ServerScriptService (ref)
        local Executor = p2.Executor;

        if not IsCommandAuthorized(Executor) then
            return "You don\'t have permission to run this command please verify that your UserId is in \"ReplicatedStorage.Data.AuthorizedUsers\"";
        end;

        if p2.Executor and (p2.RawText and RunService:IsServer()) then
            require(script.LogCommand)(p2);

            if NeedCommandAuthorization[Executor.UserId] and not ((p2.Data or {}).Data or {}).AuthorizedToRunBy then
                require(ServerScriptService.Modules.GuestEventServices.CommandRequestService):RequestCommand(Executor, p2);

                return "QUEUED COMMAND!";
            end;
        end;
    end);
end;