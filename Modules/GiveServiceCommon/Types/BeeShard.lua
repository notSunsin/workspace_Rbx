-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);

return {
    Use = function(p1: table, p2: string, p3: number?) -- Line: 12, Name: Use
        -- upvalues: BeeEnchantmentRegistry (copy)
        local v4 = BeeEnchantmentRegistry.Entries[p2];
        local v5 = `Bee Shard "{p2}" is not a valid enchantment entry. Please fix`;
        assert(v4, v5);

        return {
            Type = "Bee Shard",
            Value = p2,
            Quantity = p3 or 1
        };
    end,

    Format = function(p6, p7) -- Line: 23, Name: Format
        -- upvalues: BeeEnchantmentRegistry (copy), CommaFormatNumber (copy)
        local v8 = BeeEnchantmentRegistry.Entries[p7.Value];
        local v9 = v8 and v8.DisplayName or p7.Value;

        return `{CommaFormatNumber(p7.Quantity or 1)}x {v9}{v9 == "Bee Shard" and "" or " Bee Shard"}`;
    end,

    GetImage = function(p10, p11) -- Line: 32, Name: GetImage
        -- upvalues: BeeEnchantmentRegistry (copy)
        local v12 = BeeEnchantmentRegistry.Entries[p11.Value];

        return not (v12 and v12.Icon) and "rbxassetid://0" or v12.Icon;
    end,

    GetRarity = function(p13, p14) -- Line: 41, Name: GetRarity
        -- upvalues: BeeEnchantmentRegistry (copy)
        local v15 = BeeEnchantmentRegistry.Entries[p14.Value];

        return not v15 and "Common" or v15.Rarity;
    end
};