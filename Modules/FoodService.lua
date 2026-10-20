-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
local Item_Module = require(ReplicatedStorage.Item_Module);
local SeedCombine = require(ReplicatedStorage.Modules.SeedCombine);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local u1 = Item_Module.Return_All_Seed_Rarities();
local u2 = {
    IndexedRarities = {}
};
local u3 = {
    Normal = 0,
    Silver = 1,
    Gold = 1,
    Rainbow = 3,
    Diamond = 3,
    Jelly = 3,
    Ember = 3
};

for i, v in ipairs(u1) do
    u2.IndexedRarities[v[1]] = i;
end;

local u4 = {
    Soup = true
};

function u2.GetRootPlants(p5: table, p6: string?, p7: table) -- Line: 52
    local v8 = {};

    if p7.ItemType == "Holdable" then
        if p6 then
            v8[p6] = p7;

            return v8;
        end;

        warn("SOMEHOW no UUID for holdable/plant >", p7);

        return v8;
    end;

    local Ingredients = p7.ItemData.Ingredients;

    if not Ingredients then
        return v8;
    end;

    for i, v in Ingredients do
        for i2, v2 in p5:GetRootPlants(i, v) do
            v8[i2] = v2;
        end;
    end;

    return v8;
end;

function u2.GetMaxRootDepth(p9: table, p10: string, p11: table) -- Line: 89
    if p11.ItemType == "Holdable" then
        return 1;
    end;

    local Ingredients = p11.ItemData.Ingredients;

    if not Ingredients then
        return 1;
    end;

    local v12 = 0;

    for i, v in Ingredients do
        local MaxRootDepth = p9:GetMaxRootDepth(i, v);

        if v12 < MaxRootDepth then
            v12 = MaxRootDepth;
        end;
    end;

    return v12 + 1;
end;

function u2.CalculateFoodScale(p13: table, p14: string?, p15: table) -- Line: 115
    -- upvalues: u2 (copy), Calculate_Weight (copy), Item_Module (copy)
    local v16 = 0;
    local v17 = 0;

    for _, v in u2:GetRootPlants(p14, p15) do
        local ItemData = v.ItemData;

        if ItemData then
            local ItemName = ItemData.ItemName;
            local v18 = (Calculate_Weight.Calculate_Weight(ItemData.Seed, ItemData.ItemName) or 0) * (ItemData.WeightMultiplier or 1);
            local v19 = Item_Module.Return_Data(ItemName);

            if v19 and #v19 >= 2 then
                v16 = v16 + v18 / v19[2];
                v17 = v17 + 1;
            else
                warn("ItemData is invalid for plant:", ItemName);
            end;
        else
            warn("PlantData is missing for item:", v.ItemType);
        end;
    end;

    return (v17 == 0 or v16 == 0) and 1 or v16 / v17;
end;

function u2.CalculateFoodValue(p20: table, p21: string?, p22: table) -- Line: 162
    -- upvalues: u2 (copy), Calculate_Weight (copy), MutationHandler (copy), CalculatePlantValue (copy)
    local v23 = 0;

    for _, v in u2:GetRootPlants(p21, p22) do
        local ItemData = v.ItemData;
        local v24 = (Calculate_Weight.Calculate_Weight(ItemData.Seed, ItemData.ItemName) or 0) * (ItemData.WeightMultiplier or 1) * 100;
        local v25 = math.round(v24) / 100;
        local v26 = MutationHandler:CalcValueMultiFromMuts((MutationHandler:ExtractMutationsFromString(ItemData.MutationString or "")));
        v23 = v23 + CalculatePlantValue({
            name = ItemData.ItemName,
            variant = ItemData.Variant or "Normal",
            weight = v25,
            mutationMultiplier = v26,
            fruitVersion = ItemData.FruitVersion
        });
    end;

    return v23;
end;

local function CalculateAverageRarity(p27: string, p28: table) -- Line: 208
    -- upvalues: u2 (copy), SeedData (copy), u3 (copy), u4 (copy), u1 (copy)
    local v29 = 0;
    local v30 = 0;

    for _, v in u2:GetRootPlants(p27, p28) do
        local ItemData = v.ItemData;
        local v31 = SeedData[ItemData.ItemName];
        v29 = v29 + ((u2.IndexedRarities[v31 == nil and "Common" or v31.SeedRarity] or 1) + (u3[ItemData.Variant or "Normal"] or 0));
        v30 = v30 + 1;
    end;

    local v32 = math.max(1, v29) / math.max(1, v30) + (v30 >= 4 and 1 or 0);
    local ItemName = p28.ItemData.ItemName;

    if not ItemName then
        warn("FoodService:CalculateRarity | No Food Name Found!");
    end;

    if u4[ItemName] then
        v32 = math.max(0.001, v32) / 2;
    end;

    local math_floor_ret = math.floor(v32);

    return math.clamp(math_floor_ret, 1, #u1);
end;

function u2.CalculateFoodRarityString(p33: table, p34: string, p35: table) -- Line: 281
    -- upvalues: CalculateAverageRarity (copy), u1 (copy)
    local v36 = CalculateAverageRarity(p34, p35);
    local v37 = u1[math.min(v36, #u1)];

    return not v37 and "Sloppy" or v37[1];
end;

function u2.CalculateFoodRarityNumber(p38: table, p39: string, p40: table) -- Line: 300
    -- upvalues: CalculateAverageRarity (copy)
    return CalculateAverageRarity(p39, p40);
end;

function u2.CalculateSeed(p41: table, p42: string?, p43: table) -- Line: 315
    -- upvalues: u2 (copy), SeedCombine (copy)
    local v44 = {};

    for _, v in u2:GetRootPlants(p42, p43) do
        table.insert(v44, v.ItemData.Seed);
    end;

    return SeedCombine:SeedCombine32(v44);
end;

local function HashString(p45: string) -- Line: 335
    local v46 = 5381;

    for i = 1, #p45 do
        local v47 = v46 * 33 + p45:byte(i);
        v46 = bit32.band(v47, 4294967295);
        local _ = i;
    end;

    return v46;
end;

local function StepThreshold(p48: number, p49: number?) -- Line: 347
    return p48 <= 0 and 0 or 1 - (1 - math.clamp((0.2 + (p49 or 0)) * p48, 0, 1)) ^ (1 / p48);
end;

function u2.CalculateMutations(p50: table, p51: string?, p52: table) -- Line: 361
    -- upvalues: UpdateService (copy), u2 (copy), MutationHandler (copy), HashString (copy)
    if UpdateService:IsHiddenFromUpdate("CookingMutations") then
        return "", {};
    end;

    local v53 = {};

    for _, v in u2:GetRootPlants(p51, p52) do
        local ItemData = v.ItemData;

        for _, v2 in MutationHandler:ExtractMutationsFromString(ItemData.MutationString) do
            v53[v2.Name] = v53[v2.Name] or {};
            table.insert(v53[v2.Name], ItemData.Seed);
        end;
    end;

    local v54 = p52.ItemData.MadeDuringKitchenStorm and 0.2 or 0;
    local v55 = {};
    local v56 = {};

    for i, v in v53 do
        local v57 = #v;
        local v58 = HashString(i);
        local v59 = i;
        local v60 = 1;

        for _, v2 in v do
            local v61 = Random.new((bit32.bxor(v2, v58))):NextNumber();

            if v61 < v60 then
                v60 = v61;
            end;
        end;

        local v62 = v57 <= 0 and 0 or 1 - (1 - math.clamp((0.2 + (v54 or 0)) * v57, 0, 1)) ^ (1 / v57);
        v56[v59] = 1 - (1 - v62) ^ v57;

        if v60 <= v62 then
            table.insert(v55, v59);
        end;
    end;

    table.sort(v55);

    return table.concat(v55, ", "), v56;
end;

return u2;