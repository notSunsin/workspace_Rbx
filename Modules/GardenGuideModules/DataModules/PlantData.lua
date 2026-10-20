-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SeedData = require(ReplicatedStorage.Data.SeedData);
local SeedShopData = require(ReplicatedStorage.Data.SeedShopData);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
require(ReplicatedStorage.Data.TravelingMerchant.TravelingMerchantData.SummerMerchantShopData);
local CropMasteryData = require(ReplicatedStorage.Data.CropMasteryData);
local DataService = require(ReplicatedStorage.Modules.DataService);
local MaxAges = require(ReplicatedStorage.Data.GrowableData.MaxAges);
local GrowableData = require(ReplicatedStorage.Data.GrowableData);
local GardenGuideData = require(ReplicatedStorage.Data.GardenGuideData);
require(ReplicatedStorage.Data.GardenGuideData.GardenGuideTypes);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local u1 = ReplicatedStorage.GameEvents.GardenGuide.GetGGBlacklist:InvokeServer();
local u2 = {
    Data = {},
    Total = 0,
    Unlocked = {}
};
local AllPlantData = GrowableData:GetAllPlantData();
local u3 = {};
local u4 = {};

local function GetAverageNumber(p5) -- Line: 69
    if typeof(p5) == "NumberRange" then
        return (p5.Max + p5.Min) / 2;
    end;

    warn("Argument 1 expected NumberRange, got " .. typeof(p5));

    return 0;
end;

local function CalculateAvgGrowTime(p6: string) -- Line: 78
    -- upvalues: MaxAges (copy), AllPlantData (copy)
    local v7 = MaxAges[p6];

    if not v7 then
        return 0;
    end;

    if not AllPlantData[p6] then
        return 0;
    end;

    local GrowTickTime = AllPlantData[p6].PlantData.GrowTickTime;
    local v8;

    if typeof(GrowTickTime) == "NumberRange" then
        v8 = (GrowTickTime.Max + GrowTickTime.Min) / 2;
    else
        warn("Argument 1 expected NumberRange, got " .. typeof(GrowTickTime));
        v8 = 0;
    end;

    return v7 / AllPlantData[p6].PlantData.GrowRate * v8;
end;

local function FormatData(p9, p10, p11, p12) -- Line: 90
    -- upvalues: DataService (copy), NumberUtil (copy), SeedShopData (copy), CropMasteryData (copy), u3 (copy), MaxAges (copy), AllPlantData (copy)
    local Data = DataService:GetData();

    if Data then
        local v13 = "(Record not set)";
        local v14;

        if p11 then
            v14 = p11.MaxWeight and (`{math.round(p11.MaxWeight * 100) / 100}kg` or "-") or "-";

            if p11.MaxWeightTime then
                v13 = os.date("%B %d %Y", p11.MaxWeightTime);
            elseif p11.MaxWeight then
                v13 = os.date("%B %d %Y", os.time());
            end;
        else
            v14 = "-";
        end;

        local v15 = "(Record not set)";
        local v16;

        if p11 then
            v16 = p11.MostValue and (NumberUtil.FormatCompactPrice(p11.MostValue) or "-") or "-";

            if p11.MostValueTime then
                v15 = os.date("%B %d %Y", p11.MostValueTime);
            elseif p11.MostValue then
                v15 = os.date("%B %d %Y", os.time());
            end;
        else
            v16 = "-";
        end;

        local v17 = "(Record not set)";
        local v18;

        if p11 then
            local _ = p11.BestVariant;
            local _ = p11.BestMutations;
            local v19 = {
                [""] = true,
                Normal = true
            };
            local v20 = {};

            for _, v in { p11.BestVariant, p11.BestMutations } do
                if v and not v19[v] then
                    table.insert(v20, v);
                end;
            end;

            v18 = #v20 > 0 and table.concat(v20, ", ") or "-";

            if p11.BestMutationsTime or p11.BestVariantTime then
                local math_max_ret = math.max(p11.BestMutationsTime or 0, p11.BestVariantTime or 0);
                v17 = os.date("%B %d %Y", math_max_ret);
            elseif p11.BestMutations or p11.BestVariant then
                v17 = os.date("%B %d %Y", os.time());
            end;
        else
            v18 = "-";
        end;

        local v21 = SeedShopData[p9];
        local v22 = not v21 and "Event Exclusive" or (not v21.DisplayInShop and v21.StockChance < 1 and "Event Exclusive" or p12.Source);
        local MaxMasteryLevel = CropMasteryData.MaxMasteryLevel;
        local MasteryLevel = CropMasteryData:GetMasteryLevel(Data, p9);
        local MasteryProgress = CropMasteryData:GetMasteryProgress(Data, p9);

        if not u3[p9] or #u3[p9] <= 0 then
            warn((`[!] {p9} has no plant traits. Won't show in GG until traits assigned...`));
        end;

        local v23 = {
            ImageId = p10.FruitIcon or "",
            Name = p9,
            Rarity = p10.SeedRarity
        };
        local v24;

        if p11 then
            v24 = p11.NewPlant or false;
        else
            v24 = false;
        end;

        v23.New = v24;
        v23.Seen = p11 and true or false;
        v23.Description = p10.AbilityDescription or "";
        v23.HarvestType = p12.ParentInfo and "Multi" or "Single";
        local compactFormat = NumberUtil.compactFormat;
        local v25 = MaxAges[p9];
        local v26;

        if v25 and AllPlantData[p9] then
            local GrowTickTime = AllPlantData[p9].PlantData.GrowTickTime;
            local v27;

            if typeof(GrowTickTime) == "NumberRange" then
                v27 = (GrowTickTime.Max + GrowTickTime.Min) / 2;
            else
                warn("Argument 1 expected NumberRange, got " .. typeof(GrowTickTime));
                v27 = 0;
            end;

            v26 = v25 / AllPlantData[p9].PlantData.GrowRate * v27;
        else
            v26 = 0;
        end;

        v23.Time = compactFormat(v26);
        v23.Source = v22;
        v23.Mastered = MaxMasteryLevel <= MasteryLevel;
        v23.MasteryLevel = MasteryLevel or "-";
        v23.MasteryProgress = MasteryProgress or "-";
        v23.Traits = u3[p9] or "-";
        v23.HarvestedCount = p11 and (p11.HarvestCount or 0) or 0;
        v23.PlantedCount = p11 and (p11.PlantedCount or 0) or 0;
        v23.SoldCount = p11 and p11.SoldCount or 0;
        v23.Records = {
            {
                RecordName = "Heaviest Harvest",
                RecordData = v14,
                RecordDate = v13
            },
            {
                RecordName = "Most Valuable",
                RecordData = v16,
                RecordDate = v15
            },
            {
                RecordName = "Best Mutations",
                RecordData = v18,
                RecordDate = v17
            }
        };

        return v23;
    end;

    warn("No player data in PlantData");
end;

local function GatherData() -- Line: 203
    -- upvalues: SeedData (copy), u1 (copy), u2 (copy)
    local u28 = {};

    for i, _ in SeedData do
        if not u1.PlantBlacklist[i] then
            local v29 = u2;
            v29.Total = v29.Total + 1;
            table.insert(u28, i);

            if not u2.Data[i] then
                u2.UpdateData(i);
            end;
        end;
    end;

    task.spawn(function() -- Line: 215
        -- upvalues: u28 (copy), u2 (ref)
        for _, v in u28 do
            local _ = u2.Data[v];
        end;
    end);
end;

function u2.UpdateData(p30: string) -- Line: 224
    -- upvalues: DataService (copy), GardenGuideData (copy), SeedData (copy), u1 (copy), UpdateService (copy), u2 (copy), FormatData (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("No player data in PlantData");

        return;
    end;

    local v31 = GardenGuideData.Entries[p30];

    if not v31 then
        warn((`PlantData | No GardenGuideEntry for plant {p30}`));

        return;
    end;

    local v32 = SeedData[p30];

    if not v32 then
        warn((`PlantData | No SeedData for plant {p30}`));

        return;
    end;

    local v33 = Data.GardenGuide.PlantData[p30];

    if u1.PlantBlacklist[p30] then
        return;
    end;

    if not UpdateService:IsUpdateDone() and UpdateService:IsHiddenFromUpdate(p30) then
        return;
    end;

    u2.Data[p30] = FormatData(p30, v32, v33, v31);

    if v33 and not table.find(u2.Unlocked, p30) then
        table.insert(u2.Unlocked, p30);
    end;
end;

function u2.RegatherData() -- Line: 250
    -- upvalues: u2 (copy), GatherData (copy)
    u2.Total = 0;
    GatherData();
end;

(function() -- Line: 54, Name: ReverseSeedPackData
    -- upvalues: SeedPackData (copy), u4 (copy)
    for i, v in SeedPackData.Packs do
        if not (string.find(i, "Rainbow Exotic") or string.find(i, "Rainbow")) then
            local v34 = v;

            for _, v2 in v.Items do
                if not (v2.Type ~= "Seed" and (v2.Type ~= "RainbowSeed" and v2.Type ~= "SilverSeed") or u4[v2.RewardId]) then
                    u4[v2.RewardId] = v34.DisplayName;
                end;
            end;
        end;
    end;
end)();
(function() -- Line: 33, Name: CreatePlantTraitsRef
    -- upvalues: SeedData (copy), PlantTraitsData (copy), u1 (copy), u3 (copy)
    for i, _ in SeedData do
        local TraitsAsString = PlantTraitsData.GetTraitsAsString(i);

        for i2, _ in u1.PlantTraitsBlacklist do
            if string.find(TraitsAsString, i2) then
                local string_split_ret = string.split(TraitsAsString, ", ");
                local table_find_ret = table.find(string_split_ret, "<font color=\"#FFFFFF\">Apple</font>");

                if table_find_ret then
                    table.remove(string_split_ret, table_find_ret);
                end;

                TraitsAsString = table.concat(string_split_ret, ", ");
            end;
        end;

        u3[i] = TraitsAsString;
    end;
end)();
GatherData();

return u2;