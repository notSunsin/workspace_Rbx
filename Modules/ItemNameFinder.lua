-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local _ = PetRegistry.PetList;
local _ = PetRegistry.PetEggs;
local SeedData = require(ReplicatedStorage.Data.SeedData);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local GearData = require(ReplicatedStorage.Data.GearData);
require(ReplicatedStorage.Data.CurrencyData);
require(ReplicatedStorage.Data.FoodRecipeData);
local FenceSkinRegistry = require(ReplicatedStorage.Data.FenceSkinRegistry);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local ShovelSkinRegistry = require(ReplicatedStorage.Data.ShovelSkinRegistry);
local UpdateLogItemData = require(ReplicatedStorage.Data.UpdateLog.UpdateLogItemData);
local GearUtil = require(ReplicatedStorage.Modules.GearUtil);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local _ = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);

function FindItemName(p1: string, p2: string)
    -- upvalues: FenceSkinRegistry (copy), SeedData (copy), GearUtil (copy), GearData (copy), SeedPackData (copy), BeeEnchantmentRegistry (copy), CurrencyData (copy), TradeBoothSkinRegistry (copy), ShovelSkinRegistry (copy), UpdateLogItemData (copy)
    if p2 == "Fence" or p2 == "Fences" then
        local v3 = FenceSkinRegistry[p1];

        if v3 then
            return v3.DisplayName;
        end;

        return p1;
    end;

    if p2 == "Seed" then
        local v4 = SeedData[p1];

        if v4 then
            return v4.DisplayName or v4.SeedName;
        end;

        return p1;
    end;

    if p2 == "Cosmetic" then
        return p1;
    end;

    if p2 == "Egg" or p2 == "PetEgg" then
        return p1;
    end;

    if GearUtil.IsItemTypeGear(p2) then
        local function CullGearUsesFromString(p5: string) -- Line: 55
            return p5:gsub("%s*%[%d+x?%s+[Uu]ses%]%s*$", "");
        end;

        local v6 = p1:gsub("%s*%[%d+x?%s+[Uu]ses%]%s*$", "");
        local v7 = v6 == "Smith Hammer Harvest" and "Smith Hammer of Harvest" or v6;
        local v8 = GearData[v7];

        if v8 then
            return v8.GearName;
        end;

        if p1 == "Shovel [Destroy Plants]" then
            return "Shovel";
        end;

        warn((`No name found for {v7} of item type {p2}`));

        return p1;
    end;

    if p2 == "Seed Pack" or p2 == "Pack" then
        local v9 = SeedPackData.Packs[p1];

        if v9 then
            return v9.DisplayName;
        end;

        return p1;
    end;

    if p2 == "Fruit" or p2 == "Holdable" then
        if p1 == "Candy Blossom 2026" then
            return "Candy Blossom";
        end;

        local v10 = SeedData[p1];

        return v10 and v10.DisplayName or p1;
    end;

    if p2 == "Pet" then
        return p1;
    end;

    if p2 == "Bee Shard" then
        local v11 = BeeEnchantmentRegistry.Entries[p1];

        if v11 then
            p1 = v11.DisplayName or p1;
        end;

        return p1 .. (p1 == "Bee Shard" and "" or " Bee Shard");
    end;

    if p2 == "Currency" then
        local v12 = CurrencyData[p1];

        if v12 then
            return v12.CurrencyName;
        end;

        return p1;
    end;

    if p2 == "Crate" or p2 == "CosmeticCrate" then
        return p1;
    end;

    if p2 == "TradeBoothSkin" then
        local v13 = TradeBoothSkinRegistry[p1];

        if v13 then
            return v13.DisplayName;
        end;

        return p1;
    end;

    if p2 == "Food" then
        return p1;
    end;

    if p2 == "ShovelSkin" then
        local v14 = ShovelSkinRegistry[p1];

        if v14 then
            return v14.DisplayName;
        end;
    elseif p2 == "UpdateLogItem" then
        local v15 = UpdateLogItemData[p1];

        if v15 then
            return v15.DisplayName;
        end;
    elseif p2 == "XP" then
        return "XP";
    end;

    return p1;
end;

return FindItemName;