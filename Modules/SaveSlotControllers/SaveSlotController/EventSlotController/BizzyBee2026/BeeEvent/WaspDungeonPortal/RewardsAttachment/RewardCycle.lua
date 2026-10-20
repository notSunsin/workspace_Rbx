-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local WaspWaveSurvivalConfig = require(ReplicatedStorage.Data.BeeEvent.WaspWaveSurvivalConfig);

local function CloneReward(p1) -- Line: 14
    if typeof(p1) == "table" then
        return typeof(p1.Type) == "string" and p1.Value ~= nil and {
            Type = p1.Type,
            Value = p1.Value,
            Quantity = p1.Quantity,
            Variant = p1.Variant,
            CustomImage = p1.CustomImage
        } or nil;
    end;

    return nil;
end;

local function AddReward(p2: table, p3: any) -- Line: 32
    -- upvalues: CloneReward (copy)
    local v4 = CloneReward(p3);

    if v4 then
        table.insert(p2, v4);
    end;
end;

local v5 = {};

for _, v in (function() -- Line: 39, Name: GetBestRewardsFromConfig
    -- upvalues: WaspWaveSurvivalConfig (copy), CloneReward (copy)
    local Rewards = WaspWaveSurvivalConfig.Rewards;
    local v6 = {};

    if not Rewards then
        return v6;
    end;

    local v7 = {};

    for _, v in Rewards.Guaranteed or {} do
        table.insert(v7, v);
    end;

    table.sort(v7, function(p8, p9) -- Line: 53
        return (tonumber(p8.MinWave) or 0) > (tonumber(p9.MinWave) or 0);
    end);

    for _, v in v7 do
        for _, v2 in v.Rewards or {} do
            local v10 = CloneReward(v2);

            if v10 then
                table.insert(v6, v10);
            end;
        end;
    end;

    for _, v in Rewards.ChaseItems or {} do
        local v11 = CloneReward(v.Reward);

        if v11 then
            table.insert(v6, v11);
        end;
    end;

    return v6;
end)() do
    if v.Value == "Swivel Stinger" then
        table.insert(v5, v);
    end;
end;

if #v5 == 0 then
    return;
end;

local v12 = {};
local v13 = {};

for _, v in v5 do
    local v14 = `{v.Type}:{v.Variant or ""}:{tostring(v.Value)}`;

    if not v12[v14] then
        v12[v14] = true;
        table.insert(v13, v);
    end;
end;

for i = #v13, 2, -1 do
    local math_random_ret = math.random(1, i);
    local v15 = v13[i];
    v13[i] = v13[math_random_ret];
    v13[math_random_ret] = v15;
    local _ = i;
end;

local Frame = script.Parent:WaitForChild("BillboardGui"):WaitForChild("Frame");
local BestTemplate = Frame:WaitForChild("BestTemplate");
BestTemplate.Visible = false;
local v16 = {};
local v17 = BestTemplate:Clone();
v17.LayoutOrder = 1;
v17.Visible = true;
v17.Parent = Frame;
table.insert(v16, v17);
local v18 = v13[1];
local v19 = tostring(v18.Value);
local v20;

if v18.Variant then
    v20 = `{v18.Variant} {v19}`;
else
    v20 = v19;
end;

for _, v in v16 do
    v.Inner.RewardNameText.Text = v20;
    v.Inner.QuantityText.Text = `x{v18.Quantity or 1}`;
    v.Inner.Vector.Image = v18.CustomImage or ItemImageFinder(v19, v18.Type);
end;