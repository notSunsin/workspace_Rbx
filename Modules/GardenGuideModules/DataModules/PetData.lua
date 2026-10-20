-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PetList = require(ReplicatedStorage.Data.PetRegistry.PetList);
local PetEggs = require(ReplicatedStorage.Data.PetRegistry.PetEggs);
local PetEggData = require(ReplicatedStorage.Data.PetEggData);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.GardenGuideData);
require(ReplicatedStorage.Data.GardenGuideData.GardenGuideTypes);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local CraftingRecipeRegistry = require(ReplicatedStorage.Data.CraftingData.CraftingRecipeRegistry);
local u1 = ReplicatedStorage.GameEvents.GardenGuide.GetGGBlacklist:InvokeServer();
local u2 = {
    Data = {},
    Total = 0,
    Unlocked = {}
};
local Data = DataService:GetData();
local u3 = {};
local u4 = {};

local function FormatData(p5, p6, p7) -- Line: 79
    -- upvalues: NumberUtil (copy), u3 (copy), PetEggData (copy), CraftingRecipeRegistry (copy)
    local v8 = "(Record not set)";
    local v9;

    if p7 then
        v9 = p7.MaxBaseWeight and (`{math.round(p7.MaxBaseWeight * 100) / 100}kg` or "-") or "-";

        if p7.MaxBaseWeightTime then
            v8 = os.date("%B %d %Y", p7.MaxBaseWeightTime);
        elseif p7.MaxBaseWeight then
            v8 = os.date("%B %d %Y", os.time());
        end;
    else
        v9 = "-";
    end;

    local v10 = "(Record not set)";
    local v11;

    if p7 then
        v11 = p7.MaxLevel and (NumberUtil.FormatCompactPrice(p7.MaxLevel) or "-") or "-";

        if p7.MaxLevelTime then
            v10 = os.date("%B %d %Y", p7.MaxLevelTime);
        elseif p7.MaxLevel then
            v10 = os.date("%B %d %Y", os.time());
        end;
    else
        v11 = "-";
    end;

    local v12 = {};

    for _, v in u3[p5].EggTypes do
        if PetEggData[v] then
            table.insert(v12, "Pet Shop");
        end;

        table.insert(v12, v);
    end;

    local v13 = CraftingRecipeRegistry.ItemRecipes[p5];

    if v13 and (not v13.DisplayInCrafting or v13.DisplayInCrafting ~= false) and table.find(v13.MachineTypes, "GearEventWorkbench") then
        table.insert(v12, "Crafting");
    end;

    if #v12 == 0 then
        table.insert(v12, "Event Exclusive");
    end;

    local table_concat_ret = table.concat(v12, ", ");
    local v14 = "0";

    if #u3[p5].HatchTimes == 1 then
        v14 = `{NumberUtil.compactFormat(u3[p5].HatchTimes[1])}`;
    elseif #u3[p5].HatchTimes > 1 then
        v14 = `{NumberUtil.compactFormat((math.min(table.unpack(u3[p5].HatchTimes))))} - {NumberUtil.compactFormat((math.max(table.unpack(u3[p5].HatchTimes))))}`;
    end;

    local v15 = {
        ImageId = p6.Icon or "",
        Name = p5,
        Rarity = p6.Rarity,
        Description = p6.Description or ""
    };
    local v16;

    if p7 then
        v16 = p7.NewPet or false;
    else
        v16 = false;
    end;

    v15.New = v16;
    v15.Seen = p7 and true or false;
    v15.HarvestedCount = p7 and (p7.HatchCount or 0) or 0;
    v15.Progress = p7 and (p7.HatchCount or 0) or 0;
    v15.Time = v14;
    v15.Source = table_concat_ret;
    v15.Records = {
        {
            RecordName = "Heaviest Hatched",
            RecordData = v9,
            RecordDate = v8
        },
        {
            RecordName = "Highest Level",
            RecordData = v11,
            RecordDate = v10
        },
        {
            RecordName = "-",
            RecordData = "-",
            RecordDate = "-"
        }
    };

    return v15;
end;

local function GatherData() -- Line: 171
    -- upvalues: PetList (copy), u1 (copy), u2 (copy)
    for i, _ in PetList do
        if not u1.PetBlacklist[i] then
            local v17 = u2;
            v17.Total = v17.Total + 1;

            if not u2.Data[i] then
                u2.UpdateData(i);
            end;
        end;
    end;
end;

function u2.UpdateData(p18: string) -- Line: 181
    -- upvalues: PetList (copy), Data (copy), u1 (copy), UpdateService (copy), u2 (copy), FormatData (copy)
    local v19 = PetList[p18];

    if not v19 then
        warn((`PetData | No PetList data for pet {p18}`));

        return;
    end;

    local v20 = Data.GardenGuide.PetData[p18];

    if u1.PetBlacklist[p18] then
        return;
    end;

    if not UpdateService:IsUpdateDone() and UpdateService:IsHiddenFromUpdate(p18) then
        return;
    end;

    u2.Data[p18] = FormatData(p18, v19, v20);

    if v20 and not table.find(u2.Unlocked, p18) then
        table.insert(u2.Unlocked, p18);
    end;
end;

function u2.RegatherData() -- Line: 201
    -- upvalues: u2 (copy), GatherData (copy)
    u2.Total = 0;
    GatherData();
end;

(function() -- Line: 62, Name: ReverseChestData
    -- upvalues: SeedPackData (copy), u4 (copy)
    for i, v in SeedPackData.Packs do
        if string.find(i, "Chest") and not string.find(i, "Exotic") then
            local v21 = i;

            for _, v2 in v.Items do
                if v2.Type == "Pet" then
                    if not u4[v2.RewardId] then
                        u4[v2.RewardId] = {};
                    end;

                    table.insert(u4[v2.RewardId], v21);
                end;
            end;
        end;
    end;
end)();
(function() -- Line: 30, Name: ReverseEggData
    -- upvalues: PetList (copy), u3 (copy), PetEggs (copy), u4 (copy)
    for i, _ in PetList do
        if not u3[i] then
            u3[i] = {
                EggTypes = {},
                HatchTimes = {}
            };
        end;

        local v22 = i;

        for i2, v in PetEggs do
            if i2 ~= "Fake Egg" and not (string.find(i2, "Exotic") or (string.find(i2, "Premium") or not v.RarityData.Items[v22])) then
                table.insert(u3[v22].EggTypes, i2);
                table.insert(u3[v22].HatchTimes, v.HatchTime);
            end;
        end;

        if u4[v22] then
            for _, v in u4[v22] do
                table.insert(u3[v22].EggTypes, v);
            end;
        end;

        if #u3[v22].EggTypes == 0 then
            table.insert(u3[v22].EggTypes, "Event Exclusive");
        end;
    end;
end)();
GatherData();

return u2;