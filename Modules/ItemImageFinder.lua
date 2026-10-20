-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetList = PetRegistry.PetList;
local PetEggs = PetRegistry.PetEggs;
local SeedData = require(ReplicatedStorage.Data.SeedData);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local GearData = require(ReplicatedStorage.Data.GearData);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);
local FoodRecipeData = require(ReplicatedStorage.Data.FoodRecipeData);
local FenceSkinRegistry = require(ReplicatedStorage.Data.FenceSkinRegistry);
local GearUtil = require(ReplicatedStorage.Modules.GearUtil);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local ShovelSkinRegistry = require(ReplicatedStorage.Data.ShovelSkinRegistry);
local UpdateLogItemData = require(ReplicatedStorage.Data.UpdateLog.UpdateLogItemData);
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;

function FindItemImage(p1: string, p2: string)
    -- upvalues: PetList (copy), FenceSkinRegistry (copy), SeedData (copy), GearUtil (copy), GearData (copy), SeedPackData (copy), PetEggs (copy), CosmeticCrates (copy), CosmeticList (copy), CurrencyData (copy), FoodRecipeData (copy), TradeBoothSkinRegistry (copy), BeeEnchantmentRegistry (copy), ShovelSkinRegistry (copy), UpdateLogItemData (copy)
    if p2 == "Pet" then
        local v3 = PetList[p1];

        return not v3 and "rbxassetid://6937742258" or v3.Icon;
    end;

    if p2 == "Fence" or p2 == "Fences" then
        local v4 = FenceSkinRegistry[p1];

        return not v4 and "rbxassetid://6937742258" or "rbxassetid://" .. v4.Icon;
    end;

    if p2 == "Seed" then
        local v5 = SeedData[p1];

        return not v5 and "rbxassetid://6937742258" or v5.Asset;
    end;

    if p2 == "RandomSeed" then
        return "rbxassetid://103471197086046";
    end;

    if p2 == "Holdable" or p2 == "Fruit" then
        local v6 = SeedData[p1];

        return not v6 and "rbxassetid://6937742258" or v6.FruitIcon;
    end;

    if GearUtil.IsItemTypeGear(p2) then
        local function CullGearUsesFromString(p7: string) -- Line: 63
            return p7:gsub("%s*%[%d+x?%s+[Uu]ses%]%s*$", "");
        end;

        local v8 = p1:gsub("%s*%[%d+x?%s+[Uu]ses%]%s*$", "");
        local v9 = v8 == "Smith Hammer Harvest" and "Smith Hammer of Harvest" or v8;
        local v10 = GearData[v9];

        if v10 then
            return v10.Asset;
        end;

        if p1 == "Shovel [Destroy Plants]" then
            return "rbxassetid://91314518527541";
        end;

        warn((`No image found for {v9} of item type {p2}`));

        return "rbxassetid://6937742258";
    end;

    if p2 == "Seed Pack" or p2 == "Pack" then
        local v11 = SeedPackData.Packs[p1];

        if v11 and v11.Icon then
            return v11.Icon;
        end;

        warn((`No image found for {p1} of item type {p2}`));

        return "rbxassetid://6937742258";
    end;

    if p2 == "PetEgg" or p2 == "Egg" then
        local v12 = PetEggs[p1];

        return not v12 and "rbxassetid://6937742258" or v12.Icon;
    end;

    if p2 == "CosmeticCrate" or p2 == "Crate" then
        local v13 = CosmeticCrates[p1];

        return not v13 and "rbxassetid://6937742258" or v13.Icon;
    end;

    if p2 == "Cosmetic" then
        local v14 = CosmeticList[p1];

        return not v14 and "rbxassetid://6937742258" or v14.Icon;
    end;

    if p2 == "Currency" then
        local v15 = CurrencyData[p1];

        return not v15 and "rbxassetid://6937742258" or v15.Icon;
    end;

    if p2 == "Food" then
        return FoodRecipeData.Recipes[p1].ImageId;
    end;

    if p2 == "TradeBoothSkin" then
        local v16 = TradeBoothSkinRegistry[p1];

        return not v16 and "rbxassetid://6937742258" or v16.Icon;
    end;

    if p2 == "Bee Shard" then
        local v17 = BeeEnchantmentRegistry.Entries[p1];

        if v17 and v17.Icon then
            return v17.Icon;
        end;
    elseif p2 == "ShovelSkin" then
        local v18 = ShovelSkinRegistry[p1];

        if v18 then
            return `rbxassetid://{v18.Icon}` or "rbxassetid://6937742258";
        end;
    else
        local v19 = p2 == "UpdateLogItem" and UpdateLogItemData[p1];

        if v19 then
            return v19.ImageID;
        end;
    end;

    return "rbxassetid://6937742258";
end;

return FindItemImage;