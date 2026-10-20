-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local BeeEggRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry);

return {
    Use = function(p1: table, p2: string, p3: number?) -- Line: 15, Name: Use
        -- upvalues: BeeEggRegistry (copy)
        local v4 = BeeEggRegistry.Entries[p2];
        local v5 = `Bee Egg "{p2}" is not a valid BeeEggRegistry entry. Please fix`;
        assert(v4, v5);

        return {
            Type = "Bee Egg",
            Value = p2,
            Quantity = p3 or 1
        };
    end,

    Format = function(p6, p7) -- Line: 25, Name: Format
        -- upvalues: CommaFormatNumber (copy)
        return `{CommaFormatNumber(p7.Quantity or 1)}x {p7.Value}`;
    end,

    GetImage = function(p8, p9) -- Line: 29, Name: GetImage
        -- upvalues: BeeEggRegistry (copy)
        local v10 = BeeEggRegistry.Entries[p9.Value];

        return not (v10 and v10.Icon) and "rbxassetid://0" or v10.Icon;
    end,

    GetRarity = function(p11, p12) -- Line: 38, Name: GetRarity
        -- upvalues: BeeEggRegistry (copy)
        local v13 = BeeEggRegistry.Entries[p12.Value];

        return not (v13 and v13.Rarity) and "Common" or v13.Rarity;
    end
};