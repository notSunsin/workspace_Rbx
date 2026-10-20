-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Item_Module = require(ReplicatedStorage.Item_Module);
local GrowableData = require(ReplicatedStorage.Data.GrowableData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local SeedShopData = require(ReplicatedStorage.Data.SeedShopData);
local script_GardenGuideTypes = require(script.GardenGuideTypes);
local u1 = {
    Apple = {
        Source = "Seed Shop",
        Obtainable = true
    }
};
(function() -- Line: 27, Name: PopulateEntries
    -- upvalues: Item_Module (copy), GrowableData (copy), SeedData (copy), u1 (copy), script_GardenGuideTypes (copy), SeedShopData (copy)
    local v2 = Item_Module.Return_All_Data();
    local AllPlantData = GrowableData:GetAllPlantData();

    for _, v in v2 do
        local v3 = v[1];

        if v3 and v3 ~= "" then
            local v4 = v[2] or 0;
            local v5 = v[3] or 0;
            local _ = v[4] or 0;
            local v6 = u1[v3] or script_GardenGuideTypes.DefaultEntry();
            v6.Name = v3;
            v6.BaseWeight = v4;
            v6.BaseValue = v5;
            u1[v3] = v6;
        else
            print((`Invalid name for {v} in Item_Module`));
        end;
    end;

    for i, v in AllPlantData do
        local v7 = (v.PlantData.GrowTickTime.Min + v.PlantData.GrowTickTime.Max) / 2;
        local GrowRate = v.PlantData.GrowRate;

        if v.FruitData then
            v7 = (v.FruitData.GrowTickTime.Min + v.FruitData.GrowTickTime.Max) / 2;
            GrowRate = v.FruitData.GrowRate;
        end;

        local v8;

        if v.PlantData.GrowFruitTime then
            v8 = (v.PlantData.GrowFruitTime.Min + v.PlantData.GrowFruitTime.Max) / 2 or nil;
        else
            v8 = nil;
        end;

        local v9 = u1[i] or script_GardenGuideTypes.DefaultEntry();
        v9.TimePerAge = v7 * GrowRate;

        if v8 then
            v9.ParentInfo = v9.ParentInfo or script_GardenGuideTypes.DefaultEntryParent();
            v9.ParentInfo.FruitTime = v8;

            if not v.FruitData then
                warn((`No fruit data for {i}, despite having FruitTime!`));
            end;
        end;

        u1[i] = v9;
    end;

    for i, v in SeedData do
        local v10 = SeedShopData[i];
        local v11, v12, v13;

        if v10 then
            v11 = v10.Price or 0;
            v12 = v10.DisplayInShop and "Seed Shop" or "Event Exclusive";
            v13 = v10.DisplayInShop or false;
        else
            v11 = 0;
            v12 = "Event Exclusive";
            v13 = false;
        end;

        local v14 = v.SeedRarity or "Unknown";
        local v15 = u1[i] or script_GardenGuideTypes.DefaultEntry();
        v15.Name = i;
        v15.SeedPrice = v11;
        v15.Rarity = v14;
        v15.Source = v12;
        v15.Obtainable = v13;
        u1[i] = v15;
    end;
end)();

return {
    UseTool = false,
    Entries = u1
};