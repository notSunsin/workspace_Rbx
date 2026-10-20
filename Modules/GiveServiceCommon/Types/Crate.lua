-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    Use = function(p1: table, p2: string, p3: number?) -- Line: 10, Name: Use
        local v4 = require(game.ReplicatedStorage.Data.CosmeticCrateRegistry.CosmeticCrates)[p2];
        local v5 = `Cosmetic Item "{p2}"" is not a valid entry. Please fix`;
        assert(v4, v5);

        return {
            Type = "Crate",
            Value = p2,
            Quantity = p3 or 1
        };
    end,

    Format = function(p6, p7) -- Line: 17, Name: Format
        -- upvalues: CommaFormatNumber (copy)
        local Value = p7.Value;

        return `{CommaFormatNumber(p7.Quantity or 1)}x {Value}`;
    end,

    GetImage = function(p8, p9) -- Line: 24, Name: GetImage
        -- upvalues: ReplicatedStorage (copy)
        return require(ReplicatedStorage.Modules.ItemImageFinder)(p9.Value, "Crate");
    end,

    GetRarity = function(p10, p11) -- Line: 29, Name: GetRarity
        return "Rare";
    end
};