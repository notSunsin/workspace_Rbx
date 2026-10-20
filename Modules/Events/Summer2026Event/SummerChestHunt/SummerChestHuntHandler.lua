-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local ContentProvider = game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local SummerChestIndex = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SummerChestIndex");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local FormatAbbreviated = require(ReplicatedStorage.UserGenerated.Strings.FormatAbbreviated);
local ItemOddsController = require(ReplicatedStorage.Modules.OddsControllers.ItemOddsController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u2 = require(ReplicatedStorage.Modules.Trove).new();
local Config = GameConfigController:GetConfig("SummerChestHuntConfig");
local Click = game:GetService("SoundService").Click;

local function click() -- Line: 35
    -- upvalues: Click (copy)
    Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    Click:Play();
end;

local u3 = {
    Divine = "Rainbow",
    ["Golden Chest"] = "Rainbow",
    Mythical = "Blue"
};

local function GetRewardEntries() -- Line: 51
    -- upvalues: Config (ref)
    local v4 = Config and Config.GlobalRewards or {};
    local v5 = Config and Config.GlobalRewardRarities or {};
    local v6 = {};

    for i, v in v4 do
        local v7 = v5[i] or (1 / 0);
        local v8 = i;

        for _, v2 in v do
            if v2.Display ~= nil then
                local v9 = `{v2.Type}_{v2.Value}`;
                local v10 = v6[v9];

                if not v10 or v7 < v10.RarityWeight then
                    v6[v9] = {
                        Value = v2.Value,
                        Type = v2.Type,
                        Quantity = v2.Quantity or 1,
                        Display = v2.Display,
                        Rainbow = v2.RainbowInterface,
                        Rarity = v8,
                        RarityWeight = v7
                    };
                end;
            end;
        end;
    end;

    local v11 = {};

    for _, v in v6 do
        table.insert(v11, v);
    end;

    table.sort(v11, function(p12, p13) -- Line: 81
        if p12.RarityWeight == p13.RarityWeight then
            return tostring(p12.Display) < tostring(p13.Display);
        end;

        return p12.RarityWeight < p13.RarityWeight;
    end);

    return v11;
end;

local u14 = {};
local u15 = {};
local u16 = nil;
local u17 = false;

local function OpenPage(p18: string) -- Line: 98
    -- upvalues: u15 (copy)
    for i, v in u15 do
        v.Visible = p18 == i;
    end;
end;

local function buildChestIndex() -- Line: 105
    -- upvalues: Config (ref), SummerChestIndex (copy), u16 (ref), u14 (copy), u15 (copy), u3 (copy), Click (copy), FormatAbbreviated (copy), ItemImageFinder (copy), ItemOddsController (copy), ItemInfoHover (copy), u17 (ref), GuiController (copy), RunService (copy)
    local v19 = Config and Config.GlobalRewards or {};
    local v20 = Config and Config.GlobalRewardRarities or {};
    local v21 = Config and Config.TierIcons or {};

    if not next(v19) then
        return;
    end;

    local EggIndex = SummerChestIndex:FindFirstChild("EggIndex");

    if not EggIndex then
        return;
    end;

    local Main = EggIndex.Main;

    if not u16 then
        local ItemTemplate = Main.ScrollingFrame:FindFirstChild("ItemTemplate");
        local PageTemplate = Main:FindFirstChild("PageTemplate");
        local v22;

        if PageTemplate then
            v22 = PageTemplate.ScrollingFrame:FindFirstChild("ItemTemplate");
        else
            v22 = PageTemplate;
        end;

        if not (ItemTemplate and (PageTemplate and v22)) then
            return;
        end;

        ItemTemplate.Parent = nil;
        v22.Parent = nil;
        PageTemplate.Parent = nil;
        u16 = {
            Egg = ItemTemplate,
            Reward = v22,
            Page = PageTemplate
        };
    end;

    for _, child in Main.ScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    for _, child in Main:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "ScrollingFrame" then
            child:Destroy();
        end;
    end;

    table.clear(u14);
    table.clear(u15);
    local v23 = (1 / 0);
    local v24 = nil;

    for i, v in v19 do
        local v25 = (v20[i] or 0) * (i == "Golden Chest" and -1 or 1);

        if v25 < v23 then
            v24 = i;
            v23 = v25;
        end;

        local v26 = u16.Egg:Clone();
        v26.EggName.Text = i;
        v26.LayoutOrder = v25;

        if v21[i] then
            v26.Icon.Image = v21[i];
        end;

        if u3[i] == "Rainbow" then
            u14[v26.OuterStroke.UIGradient] = true;
            v26.OuterStroke.UIGradient.Enabled = true;
            v26.OuterStroke.Color = Color3.fromRGB(255, 255, 255);
            v26.Details.InnerGlow.Visible = false;
            v26.UIGradient.Enabled = true;
            v26.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        elseif u3[i] == "Blue" then
            v26.OuterStroke.Color = Color3.fromRGB(25, 41, 53);
            v26.Details.InnerGlow.Visible = false;
            v26.Details.Glow.ImageColor3 = Color3.fromRGB(89, 146, 190);
            v26.BackgroundColor3 = Color3.fromRGB(56, 92, 120);
            v26.EggName.TextColor3 = Color3.fromRGB(113, 185, 240);
            v26.EggName.UIStroke.Color = Color3.fromRGB(25, 41, 53);
        end;

        v26.Parent = Main.ScrollingFrame;
        v26.SENSOR.Activated:Connect(function() -- Line: 169
            -- upvalues: i (copy), u15 (ref), Click (ref)
            local v27 = i;

            for i2, v2 in u15 do
                v2.Visible = v27 == i2;
            end;

            Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Click:Play();
        end);
        local v28 = u16.Page:Clone();
        v28.Title.Text = `{i} Reward{#v == 1 and "" or "s"}` .. " options";
        v28.Name = i;
        local v29 = i;
        local v30 = 0;

        for _, v2 in v do
            v30 = v30 + 1;
            local v31 = u16.Reward:Clone();
            v31.EntryName.Text = v2.Display or v2.Value;
            v31.Quantity.Text = (v2.Quantity or 1) > 1 and (`x{FormatAbbreviated(v2.Quantity)}` or "") or "";
            local success, result = pcall(ItemImageFinder, v2.Value, v2.Type);

            if success and result then
                v31.Icon.Image = result;
            end;

            local v32;

            if v2.RainbowInterface then
                v32 = v30 + 999 or v30;
            else
                v32 = v30;
            end;

            v31.LayoutOrder = v32;

            if v2.RainbowInterface then
                u14[v31.UIStroke.UIGradient] = true;
                v31.UIStroke.UIGradient.Enabled = true;
                v31.UIStroke.Color = Color3.fromRGB(255, 255, 255);
                v31.Details.InnerGlow.Visible = false;
                v31.UIGradient.Enabled = true;
                v31.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            end;

            ItemOddsController:ConnectOddsButton(v2, v31.OddsButton, SummerChestIndex);
            local u33 = `SummerChestHuntReward_{v29}_{v2.Type}_{v2.Value}`;
            pcall(function() -- Line: 205
                -- upvalues: ItemInfoHover (ref), u33 (copy), v2 (copy)
                ItemInfoHover:AddItemFromRewardWithQuantity(u33, {
                    Value = v2.Value,
                    Type = v2.Type,
                    Quantity = v2.Quantity or 1
                });
            end);
            v31:SetAttribute("UUID", u33);
            v31:AddTag("ItemInfoHoverTag");
            v31.Parent = v28.ScrollingFrame;
        end;

        u15[v29] = v28;
        v28.Parent = Main;
    end;

    if v24 then
        for i, v in u15 do
            v.Visible = v24 == i;
        end;
    end;

    if not u17 then
        u17 = true;
        EggIndex.Header.Close.Activated:Connect(function() -- Line: 227
            -- upvalues: GuiController (ref), SummerChestIndex (ref), Click (ref)
            GuiController:Close(SummerChestIndex);
            Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            Click:Play();
        end);
        RunService.Heartbeat:Connect(function(p34: number) -- Line: 231
            -- upvalues: u14 (ref)
            for i in u14 do
                i.Rotation = (i.Rotation + p34 * 30) % 360;
            end;
        end);
    end;
end;

local u35 = {};
local u36 = 0;

local function startRewardCycle() -- Line: 245
    -- upvalues: CollectionService (copy), u35 (copy), u36 (ref), GetRewardEntries (copy), ItemNameFinder (copy), ItemImageFinder (copy), ContentProvider (copy), u1 (copy), Config (ref)
    local v37 = CollectionService:GetTagged("SummerChestHuntPlatform")[1];

    while not v37 do
        task.wait(1);
        v37 = CollectionService:GetTagged("SummerChestHuntPlatform")[1];
    end;

    local RewardSign = v37:WaitForChild("RewardSign", 30);

    if not RewardSign then
        return;
    end;

    local RewardCycle = RewardSign:WaitForChild("RewardCycle", 30);

    if RewardCycle then
        RewardCycle = RewardCycle:WaitForChild("Attachment", 30);
    end;

    if RewardCycle then
        RewardCycle = RewardCycle:WaitForChild("BillboardGui", 30);
    end;

    if RewardCycle then
        RewardCycle = RewardCycle:WaitForChild("RewardFrame", 30);
    end;

    if not RewardCycle then
        return;
    end;

    local ITEM_IMAGE = RewardCycle:WaitForChild("ITEM_IMAGE");
    local Title = RewardCycle:WaitForChild("Title");

    local function buildPreviewIcons() -- Line: 263
        -- upvalues: u35 (ref), u36 (ref), ITEM_IMAGE (copy), GetRewardEntries (ref), ItemNameFinder (ref), ItemImageFinder (ref), RewardCycle (copy), ContentProvider (ref)
        for _, v in u35 do
            v:Destroy();
        end;

        table.clear(u35);
        u36 = 0;
        ITEM_IMAGE.Visible = false;

        for _, v in GetRewardEntries() do
            local v38 = ITEM_IMAGE:Clone();
            v38.Name = "RewardPreviewIcon";
            v38.Visible = false;
            v38:SetAttribute("DisplayName", v.Display or ItemNameFinder(tostring(v.Value), v.Type));
            local v39 = tostring(v.Value);
            local success, result = pcall(ItemImageFinder, v39, v.Type);

            if success and result then
                v38.Image = result;
            end;

            v38.Parent = RewardCycle;
            table.insert(u35, v38);
        end;

        if #u35 > 0 then
            task.spawn(function() -- Line: 285
                -- upvalues: ContentProvider (ref), u35 (ref)
                pcall(function() -- Line: 286
                    -- upvalues: ContentProvider (ref), u35 (ref)
                    ContentProvider:PreloadAsync(u35);
                end);
            end);
        end;
    end;

    local function advancePreview() -- Line: 291
        -- upvalues: u35 (ref), u36 (ref), Title (copy)
        if #u35 == 0 then
            return;
        end;

        if u35[u36] then
            u35[u36].Visible = false;
        end;

        u36 = u36 + 1;

        if u36 > #u35 then
            u36 = 1;
        end;

        local v40 = u35[u36];
        v40.Visible = true;
        Title.Text = `{v40:GetAttribute("DisplayName")}`;
    end;

    u1._rebuildPreview = buildPreviewIcons;
    buildPreviewIcons();

    if #u35 ~= 0 then
        if u35[u36] then
            u35[u36].Visible = false;
        end;

        u36 = u36 + 1;

        if u36 > #u35 then
            u36 = 1;
        end;

        local v41 = u35[u36];
        v41.Visible = true;
        Title.Text = `{v41:GetAttribute("DisplayName")}`;
    end;

    while true do
        repeat
            task.wait((math.max(Config and Config.REWARD_CYCLE_INTERVAL or 5, 0.1)));
        until #u35 ~= 0;

        if u35[u36] then
            u35[u36].Visible = false;
        end;

        u36 = u36 + 1;

        if u36 > #u35 then
            u36 = 1;
        end;

        local v42 = u35[u36];
        v42.Visible = true;
        Title.Text = `{v42:GetAttribute("DisplayName")}`;
    end;
end;

function u1.Start(p43) -- Line: 313
    -- upvalues: u2 (copy), Config (ref), GameConfigController (copy), buildChestIndex (copy), u1 (copy), startRewardCycle (copy)
    u2:Add(workspace:GetAttributeChangedSignal("SummerChestHuntConfig"):Connect(function() -- Line: 315
        -- upvalues: Config (ref), GameConfigController (ref), buildChestIndex (ref), u1 (ref)
        Config = GameConfigController:GetConfig("SummerChestHuntConfig");
        buildChestIndex();

        if u1._rebuildPreview then
            u1._rebuildPreview();
        end;
    end));
    u2:Add(task.spawn(buildChestIndex));
    u2:Add(task.spawn(startRewardCycle));
end;

local u44 = false;
EventRotationController.EventUpdated:Connect(function(p45: string, p46: string) -- Line: 329, Name: OnEventUpdated
    -- upvalues: u2 (copy), u44 (ref), u1 (copy)
    if p46 ~= "Summer2026Event" then
        u2:Clean();
        u44 = false;

        return;
    end;

    if u44 then
        return;
    end;

    u44 = true;
    u2:Clean();
    task.spawn(u1.Start, u1);
end);

return u1;