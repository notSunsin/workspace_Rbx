-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    Use = function(p1: table, p2: string, p3: number?) -- Line: 11, Name: Use
        return {
            Type = "Fruit",
            Value = p2,
            Quantity = p3 or 1
        };
    end,

    Format = function(p4, p5) -- Line: 15, Name: Format
        -- upvalues: CommaFormatNumber (copy)
        local Value = p5.Value;

        return `{CommaFormatNumber(p5.Quantity or 1)}x {Value}`;
    end,

    GetImage = function(p6, p7) -- Line: 22, Name: GetImage
        -- upvalues: ReplicatedStorage (copy)
        return require(ReplicatedStorage.Modules.ItemImageFinder)(p7.Value, "Holdable");
    end,

    GetRarity = function(p8, p9) -- Line: 27, Name: GetRarity
        -- upvalues: ReplicatedStorage (copy)
        local v10 = require(ReplicatedStorage.Data.SeedData)[p9.Value];

        return not v10 and "Common" or v10.SeedRarity;
    end
};