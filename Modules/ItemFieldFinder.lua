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
local FoodRecipeData = require(ReplicatedStorage.Data.FoodRecipeData);
local FenceSkinRegistry = require(ReplicatedStorage.Data.FenceSkinRegistry);
local GearUtil = require(ReplicatedStorage.Modules.GearUtil);
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;

local function GetItemRecord(p1: string, p2: string) -- Line: 24
    -- upvalues: PetList (copy), FenceSkinRegistry (copy), SeedData (copy), GearUtil (copy), GearData (copy), SeedPackData (copy), PetEggs (copy), CosmeticCrates (copy), CosmeticList (copy), CurrencyData (copy), FoodRecipeData (copy)
    if p2 == "Pet" then
        return PetList[p1];
    end;

    if p2 == "Fence" then
        return FenceSkinRegistry[p1];
    end;

    if p2 == "Seed" or p2 == "Holdable" then
        return SeedData[p1];
    end;

    if GearUtil.IsItemTypeGear(p2) then
        return GearData[p1];
    end;

    if p2 == "Seed Pack" then
        if SeedPackData and SeedPackData.Packs then
            return SeedPackData.Packs[p1];
        end;
    else
        if p2 == "PetEgg" or p2 == "Egg" then
            return PetEggs[p1];
        end;

        if p2 == "CosmeticCrate" or p2 == "Crate" then
            return CosmeticCrates[p1];
        end;

        if p2 == "Cosmetic" then
            return CosmeticList[p1];
        end;

        if p2 == "Currency" then
            return CurrencyData[p1];
        end;

        if p2 == "Food" and (FoodRecipeData and FoodRecipeData.Recipes) then
            return FoodRecipeData.Recipes[p1];
        end;
    end;

    return nil;
end;

local function FindImageForRecord(p3: any, p4: string, p5: string) -- Line: 53
    -- upvalues: GearUtil (copy)
    if p5 == "Pet" then
        return p3 and p3.Icon or "rbxassetid://6937742258";
    end;

    if p5 == "Fence" then
        return not (p3 and p3.Icon) and "rbxassetid://6937742258" or "rbxassetid://" .. tostring(p3.Icon);
    end;

    if p5 == "Seed" then
        return p3 and p3.Asset or "rbxassetid://6937742258";
    end;

    if p5 == "Holdable" then
        return p3 and p3.FruitIcon or "rbxassetid://6937742258";
    end;

    if GearUtil.IsItemTypeGear(p5) then
        return p3 and p3.Asset or "rbxassetid://6937742258";
    end;

    if p5 == "Seed Pack" then
        return p3 and p3.Icon or "rbxassetid://6937742258";
    end;

    if p5 == "PetEgg" or p5 == "Egg" then
        return p3 and p3.Icon or "rbxassetid://6937742258";
    end;

    if p5 == "CosmeticCrate" or p5 == "Crate" then
        return p3 and p3.Icon or "rbxassetid://6937742258";
    end;

    if p5 == "Cosmetic" then
        return p3 and p3.Icon or "rbxassetid://6937742258";
    end;

    if p5 == "Currency" then
        return p3 and p3.Icon or "rbxassetid://6937742258";
    end;

    if p5 == "Food" then
        return p3 and p3.ImageId or "rbxassetid://6937742258";
    end;

    warn((`No image found for {p4} of item type {p5}`));

    return "rbxassetid://6937742258";
end;

local function FindFieldInRecord(p6: any, p7: string) -- Line: 87
    if typeof(p6) == "table" then
        if p6[p7] ~= nil then
            return p6[p7];
        end;

        local string_lower_ret = string.lower(p7);

        for i, v in pairs(p6) do
            if typeof(i) == "string" and string.find(string.lower(i), string_lower_ret, 1, true) then
                print(("ItemFieldFinder matched key \'%s\' for field \'%s\'"):format(i, p7));

                return v;
            end;
        end;
    end;

    return nil;
end;

return function(p8: string, p9: string, p10: string) -- Line: 106, Name: ItemFieldFinder
    -- upvalues: GetItemRecord (copy), FindImageForRecord (copy), FindFieldInRecord (copy)
    local v11 = GetItemRecord(p8, p9);

    if p10 == "Image" then
        if v11 then
            return FindImageForRecord(v11, p8, p9);
        end;

        warn((`No image found for {p8} of item type {p9}`));

        return "rbxassetid://6937742258";
    end;

    if not v11 then
        warn((`No record found for {p8} of item type {p9}`));

        return nil;
    end;

    local v12 = FindFieldInRecord(v11, p10);

    if v12 == nil then
        warn((`No field containing "{p10}" found for {p8} of item type {p9}`));
    end;

    return v12;
end;