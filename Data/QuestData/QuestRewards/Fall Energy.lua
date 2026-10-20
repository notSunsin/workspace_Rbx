-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local _ = ReplicatedStorage.GameEvents.Events.FallMarketEvent.FallMarketHarvestEnergy;

return {
    Type = "Fall Energy",

    Display = function(p1, p2) -- Line: 15, Name: Display
        return `+{p2.Data.Amount}`;
    end,

    DisplayIcon = function(p3, p4) -- Line: 19, Name: DisplayIcon
        return "rbxassetid://6937742258";
    end,

    Give = function(p5, p6, p7) -- Line: 23, Name: Give
        -- upvalues: UpdateService (copy)
        local ServerScriptService = game:GetService("ServerScriptService");
        local DataService = require(ServerScriptService.Modules.DataService);

        if UpdateService:IsHiddenFromUpdate("Fall Energy") then
            return false;
        end;

        local PlayerData = DataService:GetPlayerData(p6);

        if not PlayerData then
            warn((`No PlayerData for {p6.Name}!`));

            return false;
        end;

        local FallMarket = PlayerData.FallMarket;
        FallMarket.FallEnergy = FallMarket.FallEnergy + p7.Data.Amount;

        return true;
    end,

    Use = function(p8, p9) -- Line: 42, Name: Use
        return {
            Type = p8.Type,
            Data = p9
        };
    end
};