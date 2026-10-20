-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Comma_Module);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);

return {
    Type = "Sheckles",

    Display = function(p1, p2) -- Line: 15, Name: Display
        -- upvalues: NumberUtil (copy)
        return `+{NumberUtil.DisplaySheckles(p2.Data.Amount)}`;
    end,

    DisplayIcon = function(p3, p4) -- Line: 20, Name: DisplayIcon
        -- upvalues: CurrencyData (copy)
        return CurrencyData.Sheckles.Icon;
    end,

    Give = function(p5, p6, p7) -- Line: 24, Name: Give
        local ServerScriptService = game:GetService("ServerScriptService");

        return require(ServerScriptService.Modules.CurrencyService):Add(p6, p7.Data.Amount, nil, nil, nil, Enum.AnalyticsEconomyTransactionType.Gameplay, "QuestRewards");
    end,

    Use = function(p8, p9) -- Line: 32, Name: Use
        return {
            Type = p8.Type,
            Data = p9
        };
    end
};