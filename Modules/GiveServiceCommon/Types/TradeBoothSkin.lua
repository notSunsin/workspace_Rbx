-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    Use = function(p1: table, p2: string, p3: number?) -- Line: 9, Name: Use
        local v4 = require(game.ReplicatedStorage.Data.TradeBoothSkinRegistry)[p2];
        local v5 = `TradeBoothSkin Item "{p2}" is not a valid entry. Please fix`;
        assert(v4, v5);

        return {
            Type = "TradeBoothSkin",
            Value = p2,
            Quantity = p3 or 1
        };
    end,

    Format = function(p6, p7) -- Line: 17, Name: Format
        -- upvalues: ReplicatedStorage (copy)
        local v8 = require(ReplicatedStorage.Data.TradeBoothSkinRegistry)[p7.Value];

        return not v8 and "N/A" or v8.DisplayName;
    end,

    GetImage = function(p9, p10) -- Line: 26, Name: GetImage
        -- upvalues: ReplicatedStorage (copy)
        return require(ReplicatedStorage.Modules.ItemImageFinder)(p10.Value, "TradeBoothSkin");
    end,

    GetRarity = function(p11, p12) -- Line: 31, Name: GetRarity
        -- upvalues: ReplicatedStorage (copy)
        local v13 = require(ReplicatedStorage.Data.TradeBoothSkinRegistry)[p12.Value];

        return not v13 and "Common" or v13.Rarity;
    end
};