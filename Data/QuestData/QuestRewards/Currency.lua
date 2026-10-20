-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);

return {
    Type = "Currency",

    Display = function(p1, p2) -- Line: 15, Name: Display
        -- upvalues: ReplicatedStorage (copy)
        local CurrencyData2 = require(ReplicatedStorage.Data.CurrencyData);

        return `+{p2.Data.Amount} {CurrencyData2[p2.Data.Type] and CurrencyData2[p2.Data.Type].CurrencyName or p2.Data.Type}`;
    end,

    DisplayIcon = function(p3, p4) -- Line: 23, Name: DisplayIcon
        -- upvalues: CurrencyData (copy)
        return CurrencyData[p4.Data.Type].Icon;
    end,

    Give = function(p5, p6, p7) -- Line: 27, Name: Give
        local ServerScriptService = game:GetService("ServerScriptService");

        return require(ServerScriptService.Modules.CurrencyService):Add(p6, p7.Data.Amount, false, nil, p7.Data.Type, Enum.AnalyticsEconomyTransactionType.Gameplay, "QuestRewards");
    end,

    Use = function(p8, p9) -- Line: 35, Name: Use
        return {
            Type = p8.Type,
            Data = p9
        };
    end
};