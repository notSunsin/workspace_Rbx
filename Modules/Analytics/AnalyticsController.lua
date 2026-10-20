-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local AnalyticsService = ReplicatedStorage.GameEvents.Analytics.AnalyticsService;
local DeviceForm = require(ReplicatedStorage.UserGenerated.Roblox.DeviceForm);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local AnalyticsTypes = require(ReplicatedStorage.Types.AnalyticsTypes);
local v1 = {};

local function TryGet(p2: function) -- Line: 28
    local success, result = pcall(p2);

    if success then
        return result;
    end;

    return nil;
end;

local function WaitForLoaded(p3: number) -- Line: 35
    -- upvalues: Players (copy)
    local v4 = os.clock() + p3;

    while not (Players.LocalPlayer and Players.LocalPlayer:GetAttribute("Finished_Loading")) do
        if v4 <= os.clock() then
            return nil;
        end;

        task.wait(0.1);
    end;

    return workspace.DistributedGameTime;
end;

local function WaitForViewport(p5: number) -- Line: 47
    local v6 = os.clock() + p5;
    local v7;

    while true do
        v7 = workspace.CurrentCamera;

        if v7 and (v7.ViewportSize.X > 1 and v7.ViewportSize.Y > 1) then
            break;
        end;

        if v6 <= os.clock() then
            return nil;
        end;

        task.wait(0.1);
    end;

    return v7.ViewportSize;
end;

local function SendSessionStart() -- Line: 61
    -- upvalues: TradeWorldController (copy), WaitForLoaded (copy), WaitForViewport (copy), AnalyticsTypes (copy), DeviceForm (copy), UserInputService (copy), AnalyticsService (copy)
    local v8;

    if TradeWorldController:IsInWorld() then
        v8 = nil;
    else
        v8 = WaitForLoaded(120);
    end;

    local v9 = WaitForViewport(10);
    local v10 = {};
    local success, result = pcall(DeviceForm.Get);

    if not success then
        result = nil;
    end;

    v10.Platform = result;
    local success2, result2 = pcall(DeviceForm.GetPlatform);

    if not success2 then
        result2 = nil;
    end;

    v10.OS = result2 or Enum.Platform.None;
    local success3, result3 = pcall(function() -- Line: 69
        -- upvalues: UserInputService (ref)
        return UserInputService.PreferredInput;
    end);

    if not success3 then
        result3 = nil;
    end;

    v10.InputMethod = result3;
    local v11;

    if v9 then
        v11 = math.round(v9.X);
    else
        v11 = nil;
    end;

    v10.ViewWidth = v11;
    local v12;

    if v9 then
        v12 = math.round(v9.Y);
    else
        v12 = nil;
    end;

    v10.ViewHeight = v12;
    local v13;

    if v8 then
        local v14 = math.round(v8 * 10) / 10;
        v13 = math.min(v14, 600);
    else
        v13 = nil;
    end;

    v10.LoadSeconds = v13;
    local v15 = AnalyticsTypes:SessionStartPayload(v10);
    AnalyticsService.StartSession:FireServer(v15);
end;

function v1.Start(p16) -- Line: 80
    -- upvalues: SendSessionStart (copy)
    SendSessionStart();
end;

task.spawn(v1.Start, v1);

return v1;