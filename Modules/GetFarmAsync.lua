-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);

return function(p1: userdata) -- Line: 11, Name: GetFarmAsync
    -- upvalues: TradeWorldController (copy), GetFarm (copy), Players (copy)
    if TradeWorldController:IsInWorld() then
        return nil;
    end;

    local v2 = GetFarm(p1);

    if v2 then
        return v2;
    end;

    local os_clock_ret = os.clock();
    local v3;

    while true do
        task.wait();
        v3 = GetFarm(p1);

        if not p1:IsDescendantOf(Players) then
            break;
        end;

        if os.clock() - os_clock_ret > 15 then
            warn("GetFarmAsync timed out for", p1);

            return v3;
        end;

        if v3 then
            break;
        end;
    end;

    return v3;
end;