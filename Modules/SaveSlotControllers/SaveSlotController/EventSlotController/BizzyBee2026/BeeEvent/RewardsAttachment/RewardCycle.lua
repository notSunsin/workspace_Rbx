-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RewardDataTypes = require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local v1 = {
    RewardDataTypes.SeedPackReward({
        Value = "Honey Hive Seed Pack",
        Type = "Seed Pack",
        Quantity = 1
    }),
    RewardDataTypes.EggReward({
        Value = "Hive Egg",
        Type = "Egg",
        Quantity = 1
    }),
    RewardDataTypes.PetReward({
        Value = "Professor Bee",
        Type = "Pet"
    }),
    RewardDataTypes.SeedReward({
        Value = "Honey Birds of Paradise",
        Type = "Seed",
        Quantity = 1
    }),
    RewardDataTypes.PetReward({
        Value = "Empress Bee",
        Type = "Pet"
    }),
    RewardDataTypes.PetReward({
        Value = "Elemental Bee",
        Type = "Pet"
    }),
    RewardDataTypes.SeedReward({
        Value = "Honey Bumble Bulb",
        Type = "Seed",
        Quantity = 1
    }),
    RewardDataTypes.SeedReward({
        Value = "Honey Hive Petal",
        Type = "Seed",
        Quantity = 1
    })
};

if #v1 == 0 then
    return;
end;

local v2 = {};
local v3 = {};

for _, v in v1 do
    local v4 = (v.Variant or "") .. ":" .. v.Value;

    if not v2[v4] then
        v2[v4] = true;
        table.insert(v3, v);
    end;
end;

for i = #v3, 2, -1 do
    local math_random_ret = math.random(1, i);
    local v5 = v3[i];
    v3[i] = v3[math_random_ret];
    v3[math_random_ret] = v5;
    local _ = i;
end;

local Frame = script.Parent:WaitForChild("BillboardGui"):WaitForChild("Frame");
local BestTemplate = Frame:WaitForChild("BestTemplate");
BestTemplate.Visible = false;
local v6 = {};
local v7 = BestTemplate:Clone();
v7.LayoutOrder = 1;
v7.Visible = true;
v7.Parent = Frame;
table.insert(v6, v7);
local v8 = BestTemplate:Clone();
v8.LayoutOrder = 2;
v8.Visible = true;
v8.Parent = Frame;
table.insert(v6, v8);
local v9 = BestTemplate:Clone();
v9.LayoutOrder = 3;
v9.Visible = true;
v9.Parent = Frame;
table.insert(v6, v9);
local v10 = 1;

while true do
    for i, v in v6 do
        local v11 = v3[(v10 + i - 2) % #v3 + 1];
        local v12;

        if v11.Variant then
            v12 = `{v11.Variant} {v11.Value}`;
        else
            v12 = v11.Value;
        end;

        v.Inner.RewardNameText.Text = v12;
        v.Inner.QuantityText.Text = `x{v11.Quantity or 1}`;
        v.Inner.Vector.Image = v11.CustomImage or ItemImageFinder(v11.Value, v11.Type);
    end;

    task.wait(5);
    v10 = v10 % #v3 + 1;
end;