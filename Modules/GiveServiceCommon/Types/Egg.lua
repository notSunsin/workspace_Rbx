-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    Use = function(p1: table, p2: string, p3: number) -- Line: 12, Name: Use
        local v4 = require(game.ReplicatedStorage.Data.PetRegistry.PetEggs)[p2];
        local v5 = `Egg Item "{p2}" is not a valid entry. Please fix`;
        assert(v4, v5);

        return {
            Type = "Egg",
            Value = p2,
            Quantity = p3
        };
    end,

    Format = function(p6, p7) -- Line: 19, Name: Format
        -- upvalues: CommaFormatNumber (copy)
        local Value = p7.Value;

        return `{CommaFormatNumber(p7.Quantity or 1)}x {Value}`;
    end,

    GetImage = function(p8, p9) -- Line: 26, Name: GetImage
        -- upvalues: ReplicatedStorage (copy)
        return require(ReplicatedStorage.Modules.ItemImageFinder)(p9.Value, "Egg");
    end,

    GetRarity = function(p10, p11) -- Line: 31, Name: GetRarity
        -- upvalues: ReplicatedStorage (copy)
        local PetEggs = require(ReplicatedStorage.Data.PetRegistry.PetEggs);

        return not PetEggs and "Common" or PetEggs[p11.Value].EggRarity;
    end
};