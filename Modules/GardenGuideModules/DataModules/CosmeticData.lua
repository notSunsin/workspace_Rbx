-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticList);
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry.CosmeticCrates);
local CosmeticCrateShopData = require(ReplicatedStorage.Data.CosmeticCrateShopData);
local CosmeticItemShopData = require(ReplicatedStorage.Data.CosmeticItemShopData);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.GardenGuideData);
require(ReplicatedStorage.Data.GardenGuideData.GardenGuideTypes);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local u1 = ReplicatedStorage.GameEvents.GardenGuide.GetGGBlacklist:InvokeServer();
local u2 = {
    Data = {},
    Total = 0,
    Unlocked = {}
};
local Data = DataService:GetData();
local u3 = {};

local function FormatData(p4, p5, p6) -- Line: 49
    -- upvalues: CosmeticCrateShopData (copy), u3 (copy), CosmeticItemShopData (copy), NumberUtil (copy)
    local v7 = (CosmeticCrateShopData[u3[p4].CrateType] or CosmeticItemShopData[p4]) and "Cosmetic Shop" or "Admin/Event Exclusive";
    local v8 = {
        ImageId = p5.Icon or "",
        Name = p4,
        Rarity = p5.Rarity,
        Description = p5.Description or ""
    };
    local v9;

    if p6 then
        v9 = p6.NewCosmetic or false;
    else
        v9 = false;
    end;

    v8.New = v9;
    v8.Seen = p6 and true or false;
    v8.HarvestedCount = p6 and (p6.OwnCount or 0) or 0;
    v8.Progress = p6 and (p6.OwnCount or 0) or 0;
    v8.Time = NumberUtil.compactFormat(u3[p4].OpenTime);
    v8.Source = v7;
    v8.Records = { {
            RecordName = "Heaviest Harvest",
            RecordData = nil,
            RecordDate = nil
        }, {
            RecordName = "Most Valuable",
            RecordData = nil,
            RecordDate = nil
        }, {
            RecordName = "Best Mutations",
            RecordData = nil,
            RecordDate = nil
        } };

    return v8;
end;

local function GatherData() -- Line: 90
    -- upvalues: CosmeticList (copy), u1 (copy), u2 (copy)
    for i, _ in CosmeticList do
        if not u1.CosmeticBlacklist[i] then
            local v10 = u2;
            v10.Total = v10.Total + 1;

            if not u2.Data[i] then
                u2.UpdateData(i);
            end;
        end;
    end;
end;

function u2.UpdateData(p11: string) -- Line: 100
    -- upvalues: CosmeticList (copy), Data (copy), u1 (copy), UpdateService (copy), u2 (copy), FormatData (copy)
    local v12 = CosmeticList[p11];

    if not v12 then
        warn((`CosmeticData | No CosmeticData for item {p11}`));

        return;
    end;

    local v13 = Data.GardenGuide.CosmeticData[p11];

    if u1.CosmeticBlacklist[p11] then
        return;
    end;

    if not UpdateService:IsUpdateDone() and UpdateService:IsHiddenFromUpdate(p11) then
        return;
    end;

    u2.Data[p11] = FormatData(p11, v12, v13);

    if v13 and not table.find(u2.Unlocked, p11) then
        table.insert(u2.Unlocked, p11);
    end;
end;

function u2.RegatherData() -- Line: 120
    -- upvalues: u2 (copy), GatherData (copy)
    u2.Total = 0;
    GatherData();
end;

(function() -- Line: 27, Name: ReverseCrateData
    -- upvalues: CosmeticList (copy), CosmeticCrates (copy), u3 (copy)
    for i, _ in CosmeticList do
        local v14 = i;

        for i2, v in CosmeticCrates do
            if v.CosmeticRolls.Items[v14] then
                u3[v14] = {
                    CrateType = i2,
                    OpenTime = v.OpenTime
                };
                break;
            end;
        end;

        if not u3[v14] then
            u3[v14] = {
                CrateType = "Unknown",
                OpenTime = 0
            };
        end;
    end;
end)();
GatherData();

return u2;