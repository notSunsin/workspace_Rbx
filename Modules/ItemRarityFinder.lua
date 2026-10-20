-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetList = PetRegistry.PetList;
local PetEggs = PetRegistry.PetEggs;
local SeedData = require(ReplicatedStorage.Data.SeedData);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local GearData = require(ReplicatedStorage.Data.GearData);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local FenceSkinRegistry = require(ReplicatedStorage.Data.FenceSkinRegistry);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local ShovelSkinRegistry = require(ReplicatedStorage.Data.ShovelSkinRegistry);
local UpdateLogItemData = require(ReplicatedStorage.Data.UpdateLog.UpdateLogItemData);
local GearUtil = require(ReplicatedStorage.Modules.GearUtil);
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);

return function(p1: string, p2: string) -- Line: 28, Name: findItemRarity
    -- upvalues: FenceSkinRegistry (copy), SeedData (copy), CosmeticList (copy), PetEggs (copy), GearUtil (copy), GearData (copy), SeedPackData (copy), PetList (copy), BeeEnchantmentRegistry (copy), CurrencyData (copy), TradeBoothSkinRegistry (copy), ShovelSkinRegistry (copy), UpdateLogItemData (copy)
    if p2 == "Fence" or p2 == "Fences" then
        local v3 = FenceSkinRegistry[p1];

        if v3 then
            return v3.Rarity;
        end;
    elseif p2 == "Seed" or p2 == "Holdable" then
        local v4 = SeedData[p1];

        if v4 then
            return v4.SeedRarity;
        end;
    elseif p2 == "Cosmetic" then
        local v5 = CosmeticList[p1];

        if v5 then
            return v5.Rarity;
        end;
    elseif p2 == "Egg" or p2 == "PetEgg" then
        local v6 = PetEggs[p1];

        if v6 then
            return v6.EggRarity;
        end;
    elseif GearUtil.IsItemTypeGear(p2) then
        local function CullGearUsesFromString(p7: string) -- Line: 42
            return p7:gsub("%s*%[%d+x?%s+[Uu]ses%]%s*$", "");
        end;

        local v8 = p1:gsub("%s*%[%d+x?%s+[Uu]ses%]%s*$", "");
        local v9 = GearData[v8 == "Smith Hammer Harvest" and "Smith Hammer of Harvest" or v8];

        if v9 then
            return v9.GearRarity;
        end;
    elseif p2 == "Seed Pack" or p2 == "Pack" then
        local v10 = SeedPackData.Packs[p1];

        if v10 then
            return v10.Rarity or "";
        end;
    elseif p2 == "Fruit" then
        local v11 = SeedData[p1];

        if v11 then
            return v11.SeedRarity;
        end;
    elseif p2 == "Pet" then
        local v12 = PetList[p1];

        if v12 then
            return v12.Rarity;
        end;
    else
        if p2 == "Bee Shard" then
            local v13 = BeeEnchantmentRegistry.Entries[p1];

            return not (v13 and v13.Rarity) and "Common" or v13.Rarity;
        end;

        if p2 == "Currency" then
            local v14 = CurrencyData[p1];

            if v14 then
                return v14.Rarity;
            end;
        elseif p2 == "TradeBoothSkin" then
            local v15 = TradeBoothSkinRegistry[p1];

            if v15 then
                return v15.Rarity;
            end;
        elseif p2 == "ShovelSkin" then
            local v16 = ShovelSkinRegistry[p1];

            if v16 then
                return v16.Rarity;
            end;
        elseif p2 == "UpdateLogItem" and UpdateLogItemData[p1] then
            return "<font color=\"#676767\">Event Object</font>";
        end;
    end;

    return nil;
end;