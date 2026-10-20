-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    Use = function(p1: table, p2: string) -- Line: 9, Name: Use
        local v3 = require(game.ReplicatedStorage.Data.FenceSkinRegistry)[p2];
        local v4 = `Fence Item "{p2}" is not a valid entry. Please fix`;
        assert(v3, v4);

        return {
            Type = "Fences",
            Value = p2
        };
    end,

    Format = function(p5, p6) -- Line: 17, Name: Format
        -- upvalues: ReplicatedStorage (copy)
        local v7 = require(ReplicatedStorage.Data.FenceSkinRegistry)[p6.Value];

        return not v7 and "N/A" or v7.DisplayName;
    end,

    GetImage = function(p8, p9) -- Line: 26, Name: GetImage
        -- upvalues: ReplicatedStorage (copy)
        return require(ReplicatedStorage.Modules.ItemImageFinder)(p9.Value, "Fences");
    end,

    GetRarity = function(p10, p11) -- Line: 31, Name: GetRarity
        -- upvalues: ReplicatedStorage (copy)
        local v12 = require(ReplicatedStorage.Data.FenceSkinRegistry)[p11.Value];

        return not v12 and "Common" or v12.Rarity;
    end
};