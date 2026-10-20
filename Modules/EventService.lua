-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.Signal);
local Trove = require(ReplicatedStorage.Modules.Trove);
local u1 = {};
u1.__index = u1;
local u2 = {};

function u1.new(p3: string, p4: string) -- Line: 38
    -- upvalues: u1 (copy), Trove (copy), u2 (copy)
    local v5 = setmetatable({}, u1);
    v5.ServiceName = p3;
    v5.UpdateServiceKey = p4;
    v5.Connections = {};
    v5.IsRunning = false;
    v5._trove = Trove.new();
    u2[p4] = v5;

    return v5;
end;

function u1.Bind(p6, p7) -- Line: 53
    p6._trove:Add(p7);
end;

function u1.Unbind(p8, p9) -- Line: 59
    p8._trove:Remove(p9);
end;

function u1.ClearTrove(p10) -- Line: 67
    p10._trove:Clean();
end;

function u1.Initialize(u11) -- Line: 72
    -- upvalues: TradeWorldController (copy), UpdateService (copy)
    task.spawn(function() -- Line: 73
        -- upvalues: TradeWorldController (ref), UpdateService (ref), u11 (copy)
        if TradeWorldController:IsInWorld() then
            return;
        end;

        if UpdateService:IsHiddenAfterUpdate(u11.UpdateServiceKey) then
            return;
        end;

        if UpdateService:IsHiddenFromUpdate(u11.UpdateServiceKey) then
            UpdateService.OnUpdated:Wait();

            if UpdateService:IsHiddenFromUpdate(u11.UpdateServiceKey) then
                return;
            end;

            if UpdateService:IsHiddenAfterUpdate(u11.UpdateServiceKey) then
                return;
            end;
        end;

        print((`[EventService] [{u11.ServiceName}] Starting up...`));
        u11.IsRunning = true;
        u11:OnStarted();
        UpdateService.OnUpdated:Wait();

        if UpdateService:IsHiddenAfterUpdate(u11.UpdateServiceKey) then
            u11:Shutdown();
        end;
    end);
end;

function u1.Shutdown(p12) -- Line: 99
    if not p12.IsRunning then
        return;
    end;

    print((`[EventService] [{p12.ServiceName}] Shutting down...`));
    p12.IsRunning = false;
    p12:OnStopped();
    p12:ClearTrove();
    p12._trove:Destroy();
end;

function u1.OnStarted(p13) -- Line: 117
end;

function u1.OnStopped(p14) -- Line: 122
end;

function u1.StartEvent(p15) -- Line: 127
end;

function u1.EndEvent(p16) -- Line: 132
end;

function u1.IsEventRunning(p17: string) -- Line: 136
    -- upvalues: TradeWorldController (copy), u2 (copy)
    if TradeWorldController:IsInWorld() then
        return false;
    end;

    local v18 = u2[p17];

    if v18 then
        return v18.IsRunning;
    end;

    return false;
end;

return u1;