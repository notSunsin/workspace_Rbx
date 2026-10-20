-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local WaspRewardOddsShared = require(ReplicatedStorage.Modules.BeeEventV2Controllers.WaspRewardOddsShared);
local BeeEggRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);

local function GetRewardImage(p1: string, p2: string) -- Line: 10
    -- upvalues: BeeEggRegistry (copy), ItemImageFinder (copy)
    local v3 = BeeEggRegistry.Entries[p1];

    if v3 and v3.Icon then
        return v3.Icon;
    end;

    return ItemImageFinder(p1, p2);
end;

local v9 = (function() -- Line: 20, Name: GetCarouselRewards
    -- upvalues: WaspRewardOddsShared (copy)
    local v4 = script:GetAttribute("WaspName") or "Wasp King";
    local v5 = script:GetAttribute("LootingBonus") or 0;
    local v6 = {};

    for _, v in WaspRewardOddsShared.GetOdds(v4, v5) do
        table.insert(v6, {
            Value = v.Value,
            Type = v.Type,
            Min = v.Min,
            Max = v.Max,
            Tier = v.Tier,
            PerCrateChance = v.PerCrateChance
        });
    end;

    table.sort(v6, function(p7, p8) -- Line: 38
        return (p7.PerCrateChance or 0) < (p8.PerCrateChance or 0);
    end);

    return v6;
end)();

if #v9 == 0 then
    return;
end;

local Frame = script.Parent:WaitForChild("BillboardGui"):WaitForChild("Frame");
local BestTemplate = Frame:WaitForChild("BestTemplate");
BestTemplate.Visible = false;
local v10 = BestTemplate:Clone();
v10.LayoutOrder = 1;
v10.Visible = true;
v10.Parent = Frame;
local v11 = 1;

while true do
    local v12 = v9[v11];
    v10.Inner.RewardNameText.Text = v12.Value;
    v10.Inner.QuantityText.Text = "";
    v10.Inner.QuantityText.Visible = false;
    local Value = v12.Value;
    local Type = v12.Type;
    local v13 = BeeEggRegistry.Entries[Value];
    local v14;

    if v13 and v13.Icon then
        v14 = v13.Icon;
    else
        v14 = ItemImageFinder(Value, Type);
    end;

    v10.Inner.Vector.Image = v14;
    local v15;

    if v14 == nil then
        v15 = false;
    else
        v15 = v14 ~= "";
    end;

    v10.Inner.Vector.Visible = v15;
    task.wait(5);
    v11 = v11 % #v9 + 1;
end;