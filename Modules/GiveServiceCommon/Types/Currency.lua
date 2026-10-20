-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    Use = function(p1: table, p2: string, p3: number?) -- Line: 10, Name: Use
        local v4 = p2 or "Sheckles";
        local v5 = require(game.ReplicatedStorage.Data.CurrencyData)[v4];
        local v6 = `Currency Item "{v4}" is not a valid entry. Please fix`;
        assert(v5, v6);

        return {
            Type = "Currency",
            Value = v4,
            Quantity = p3 or 1
        };
    end,

    Format = function(p7, p8) -- Line: 19, Name: Format
        -- upvalues: CommaFormatNumber (copy)
        local Value = p8.Value;

        return `{CommaFormatNumber(p8.Quantity or 1)}x {Value}`;
    end,

    GetImage = function(p9, p10) -- Line: 26, Name: GetImage
        -- upvalues: ReplicatedStorage (copy)
        return require(ReplicatedStorage.Modules.ItemImageFinder)(p10.Value, "Currency");
    end,

    GetRarity = function(p11, p12) -- Line: 31, Name: GetRarity
        -- upvalues: ReplicatedStorage (copy)
        local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);

        return not CurrencyData and "Common" or CurrencyData[p12.Value].Rarity;
    end
};