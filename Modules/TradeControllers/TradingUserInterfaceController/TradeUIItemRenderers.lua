-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local TradeUIItemValueCalculators = require(script.Parent.TradeUIItemValueCalculators);
require(ReplicatedStorage.Data.TradeData);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local Item_Module = require(ReplicatedStorage.Item_Module);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local TradeItemHover = PlayerGui:WaitForChild("TradeItemHover").TradeItemHover;
local Detail = TradeItemHover.CanvasGroup.Main.Item.Item.Detail;
local ITEM_NAME = TradeItemHover.CanvasGroup.Main.Item.ITEM_NAME;
local ITEM_NAME_SHADOW = TradeItemHover.CanvasGroup.Main.Item.ITEM_NAME_SHADOW;
local ITEM_RARITY = TradeItemHover.CanvasGroup.Main.Item.ITEM_RARITY;
local ITEM_RARITY_SHADOW = TradeItemHover.CanvasGroup.Main.Item.ITEM_RARITY_SHADOW;
local ITEM_IMAGE = TradeItemHover.CanvasGroup.Main.Item.Item.ITEM_IMAGE;
local LockIcon = TradeItemHover.CanvasGroup.Main.Item.LockIcon;
local Stats = TradeItemHover.CanvasGroup.Main.Stats;
local RAPValue = TradeItemHover.CanvasGroup.Main.RAPValue;
local SegmentTemplate = Stats.SegmentTemplate;
local _ = PlayerGui:WaitForChild("TradingUI").LiveTrade.MyPlr.ScrollingFrame.ItemTemplate;
SegmentTemplate.Visible = false;
local u1 = {};

local function CreateSegment() -- Line: 45
    -- upvalues: SegmentTemplate (copy), u1 (copy), Stats (copy)
    local v2 = SegmentTemplate:Clone();
    v2.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
    table.insert(u1, v2);
    v2.LayoutOrder = #u1;
    v2.Visible = true;
    v2.Parent = Stats;

    return v2;
end;

local u3 = {};

return {
    ItemRenderers = {
        Pet = function(u4) -- Line: 135
            -- upvalues: TradeUIItemValueCalculators (copy), u3 (copy), RAPValue (copy), TokenRAPController (copy), PetRegistry (copy), ITEM_NAME (copy), ITEM_NAME_SHADOW (copy), ITEM_IMAGE (copy), ITEM_RARITY (copy), ITEM_RARITY_SHADOW (copy), Item_Module (copy), TweenService (copy), Detail (copy), PetUtilities (copy), SegmentTemplate (copy), u1 (copy), Stats (copy), NumberUtil (copy), PetMutationRegistry (copy), LockIcon (copy)
            local type = u4.type;
            local _ = u4.id;
            local data = u4.data;
            local v5 = TradeUIItemValueCalculators[type];
            local v6;

            if data.FakeItem then
                v6 = nil;
            else
                v6 = not v5 and 0 or v5(u4);
            end;

            u3.Pet = u4;

            local function updateValue(p7: number?) -- Line: 148
                -- upvalues: u3 (ref), u4 (copy), RAPValue (ref)
                if u3.Pet ~= u4 then
                    return nil;
                end;

                RAPValue.Price.Text = not p7 and "???" or `{p7}`;

                return nil;
            end;

            local RAP = TokenRAPController:GetRAP(type, data);

            if u3.Pet == u4 then
                RAPValue.Price.Text = not RAP and "???" or `{RAP}`;
            end;

            if not RAP then
                task.defer(function() -- Line: 159
                    -- upvalues: TokenRAPController (ref), type (copy), data (copy), u3 (ref), u4 (copy), RAPValue (ref)
                    local RAPAsync = TokenRAPController:GetRAPAsync(type, data);

                    if u3.Pet == u4 then
                        RAPValue.Price.Text = not RAPAsync and "???" or `{RAPAsync}`;
                    end;

                    return nil;
                end);
            end;

            local v8 = PetRegistry.PetList[data.PetType];
            ITEM_NAME.Text = data.PetType;
            ITEM_NAME_SHADOW.Text = data.PetType;
            local v9 = not v8 and "No Rarity" or v8.Rarity;
            ITEM_IMAGE.Image = not v8 and "rbxassetid://6937742258" or v8.Icon;
            ITEM_RARITY.Text = v9;
            ITEM_RARITY_SHADOW.Text = v9;
            local v10 = Item_Module.Return_Rarity_Data(v9);
            local TweenInfo_new_ret = TweenInfo.new(0.2);
            local v11 = {};
            local v12;

            if v10 then
                v12 = v10[2];
            else
                v12 = Color3.fromRGB(255, 255, 255);
            end;

            v11.TextColor3 = v12;
            TweenService:Create(ITEM_RARITY, TweenInfo_new_ret, v11):Play();

            for _, child in Detail:GetChildren() do
                if child:IsA("Frame") then
                    local TweenInfo_new_ret2 = TweenInfo.new(0.2);
                    local v13 = {};
                    local v14;

                    if v10 then
                        v14 = v10[2];
                    else
                        v14 = Color3.fromRGB(43, 13, 0);
                    end;

                    v13.BackgroundColor3 = v14;
                    TweenService:Create(child, TweenInfo_new_ret2, v13):Play();
                end;
            end;

            if v6 then
                local string_format_ret = string.format("%0.2fkg", PetUtilities:CalculateWeight(data.PetData.BaseWeight, data.PetData.Level));
                local v15 = SegmentTemplate:Clone();
                v15.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v15);
                v15.LayoutOrder = #u1;
                v15.Visible = true;
                v15.Parent = Stats;
                v15.ITEM_STAT_NAME.Text = "Weight";
                v15.ITEM_STAT_NAME_SHADOW.Text = "Weight";
                v15.STAT_VALUE.Text = string_format_ret;
                v15.STAT_VALUE_SHADOW.Text = string_format_ret;
                local v16 = SegmentTemplate:Clone();
                v16.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v16);
                v16.LayoutOrder = #u1;
                v16.Visible = true;
                v16.Parent = Stats;
                v16.ITEM_STAT_NAME.Text = "Sheckles";
                v16.ITEM_STAT_NAME_SHADOW.Text = "Sheckles";
                v16.STAT_VALUE.Text = `{NumberUtil.DisplaySheckles(v6)}`;
                v16.STAT_VALUE_SHADOW.Text = `{NumberUtil.DisplaySheckles(v6)}`;
            end;

            if not data.FakeItem then
                local v17 = SegmentTemplate:Clone();
                v17.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v17);
                v17.LayoutOrder = #u1;
                v17.Visible = true;
                v17.Parent = Stats;
                v17.ITEM_STAT_NAME.Text = "Name";
                v17.ITEM_STAT_NAME_SHADOW.Text = "Name";
                v17.STAT_VALUE.Text = data.PetType;
                v17.STAT_VALUE_SHADOW.Text = data.PetType;
                local v18 = SegmentTemplate:Clone();
                v18.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v18);
                v18.LayoutOrder = #u1;
                v18.Visible = true;
                v18.Parent = Stats;
                v18.ITEM_STAT_NAME.Text = "Age";
                v18.ITEM_STAT_NAME_SHADOW.Text = "Age";
                v18.STAT_VALUE.Text = data.PetData.Level;
                v18.STAT_VALUE_SHADOW.Text = data.PetData.Level;
            end;

            local MutationType = data.PetData.MutationType;

            if MutationType and not data.FakeItem then
                local v19 = PetMutationRegistry.EnumToPetMutation[MutationType];
                local v20 = PetMutationRegistry.PetMutationRegistry[v19];
                local v21 = SegmentTemplate:Clone();
                v21.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v21);
                v21.LayoutOrder = #u1;
                v21.Visible = true;
                v21.Parent = Stats;
                v21.ITEM_STAT_NAME.Text = "Mutations";
                v21.ITEM_STAT_NAME_SHADOW.Text = "Mutations";
                v21.STAT_VALUE.Visible = false;
                v21.STAT_VALUE_SHADOW.Visible = false;
                local v22 = SegmentTemplate:Clone();
                v22.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v22);
                v22.LayoutOrder = #u1;
                v22.Visible = true;
                v22.Parent = Stats;
                v22.ITEM_STAT_NAME.Text = `\t{v19}`;
                v22.ITEM_STAT_NAME_SHADOW.Text = `\t{v19}`;
                v22.STAT_VALUE.Visible = false;
                v22.STAT_VALUE_SHADOW.Visible = false;

                if PetMutationRegistry.PetMutationRegistry.Rainbow.EnumId == MutationType then
                    v22.ITEM_STAT_NAME:AddTag("RainbowText");
                else
                    v22.ITEM_STAT_NAME.TextColor3 = v20.Color;
                end;
            end;

            LockIcon.Visible = false;
            local tradeLock = u4.tradeLock;

            if tradeLock then
                local Type = tradeLock.Type;
                local Value = tradeLock.Value;
                local v23 = SegmentTemplate:Clone();
                v23.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v23);
                v23.LayoutOrder = #u1;
                v23.Visible = true;
                v23.Parent = Stats;
                v23.ITEM_STAT_NAME.Text = "Trade Cooldown";
                v23.ITEM_STAT_NAME_SHADOW.Text = "Trade Cooldown";

                if Type == "Permanent" then
                    v23.STAT_VALUE.Text = "Untradable";
                    v23.STAT_VALUE_SHADOW.Text = "Untradable";
                    LockIcon.Visible = true;

                    return;
                end;

                if Type == "Date" then
                    local ServerTimeNow = workspace:GetServerTimeNow();
                    local v24 = Value - math.ceil(ServerTimeNow);
                    v23.STAT_VALUE.Text = `Tradable in {NumberUtil.compactFormat(v24)}`;
                    v23.STAT_VALUE_SHADOW.Text = `Tradable in {NumberUtil.compactFormat(v24)}`;
                    LockIcon.Visible = true;

                    return;
                end;

                if Type == "Listing" then
                    v23.STAT_VALUE.Text = `{Value}`;
                    v23.STAT_VALUE_SHADOW.Text = `{Value}`;
                    LockIcon.Visible = false;
                end;
            end;
        end,

        Holdable = function(u25) -- Line: 275
            -- upvalues: SeedData (copy), TradeUIItemValueCalculators (copy), u3 (copy), RAPValue (copy), TokenRAPController (copy), ITEM_NAME (copy), ITEM_NAME_SHADOW (copy), ITEM_IMAGE (copy), ITEM_RARITY (copy), ITEM_RARITY_SHADOW (copy), Item_Module (copy), TweenService (copy), Detail (copy), Calculate_Weight (copy), SegmentTemplate (copy), u1 (copy), Stats (copy), NumberUtil (copy), MutationHandler (copy), LockIcon (copy)
            local type = u25.type;
            local _ = u25.id;
            local data = u25.data;
            local v26 = SeedData[data.ItemName];
            local v27 = TradeUIItemValueCalculators[type];
            local v28;

            if data.FakeItem then
                v28 = nil;
            else
                v28 = not v27 and 0 or v27(u25);
            end;

            u3.Holdable = u25;

            local function _(p29: number?) -- Line: 289
                -- upvalues: u3 (ref), u25 (copy), RAPValue (ref)
                if u3.Holdable ~= u25 then
                    return nil;
                end;

                RAPValue.Price.Text = not p29 and "???" or `{p29}`;

                return nil;
            end;

            local RAP = TokenRAPController:GetRAP(type, data);

            if u3.Holdable == u25 then
                RAPValue.Price.Text = not RAP and "???" or `{RAP}`;
            end;

            if not RAP then
                task.defer(function() -- Line: 300
                    -- upvalues: TokenRAPController (ref), type (copy), data (copy), u3 (ref), u25 (copy), RAPValue (ref)
                    local RAPAsync = TokenRAPController:GetRAPAsync(type, data);

                    if u3.Holdable == u25 then
                        RAPValue.Price.Text = not RAPAsync and "???" or `{RAPAsync}`;
                    end;

                    return nil;
                end);
            end;

            local DisplayName = v26.DisplayName;

            if DisplayName and type ~= "Fruit" then
                DisplayName = DisplayName:gsub("Seed", "");
            end;

            ITEM_NAME.Text = DisplayName or data.ItemName;
            ITEM_NAME_SHADOW.Text = ITEM_NAME.Text;
            ITEM_IMAGE.Image = v26.FruitIcon;
            ITEM_RARITY.Text = v26.SeedRarity;
            ITEM_RARITY_SHADOW.Text = v26.SeedRarity;
            local v30 = Item_Module.Return_Rarity_Data(v26.SeedRarity);
            local TweenInfo_new_ret = TweenInfo.new(0.2);
            local v31 = {};
            local v32;

            if v30 then
                v32 = v30[2];
            else
                v32 = Color3.fromRGB(255, 255, 255);
            end;

            v31.TextColor3 = v32;
            TweenService:Create(ITEM_RARITY, TweenInfo_new_ret, v31):Play();

            for _, child in Detail:GetChildren() do
                if child:IsA("Frame") then
                    local TweenInfo_new_ret2 = TweenInfo.new(0.2);
                    local v33 = {};
                    local v34;

                    if v30 then
                        v34 = v30[2];
                    else
                        v34 = Color3.fromRGB(43, 13, 0);
                    end;

                    v33.BackgroundColor3 = v34;
                    TweenService:Create(child, TweenInfo_new_ret2, v33):Play();
                end;
            end;

            if v28 then
                local string_format_ret = string.format("%0.2fkg", Calculate_Weight.Calculate_Weight(data.Seed, data.ItemName) * (data.WeightMultiplier or 1));
                local v35 = SegmentTemplate:Clone();
                v35.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v35);
                v35.LayoutOrder = #u1;
                v35.Visible = true;
                v35.Parent = Stats;
                v35.ITEM_STAT_NAME.Text = "Weight";
                v35.ITEM_STAT_NAME_SHADOW.Text = "Weight";
                v35.STAT_VALUE.Text = string_format_ret;
                v35.STAT_VALUE_SHADOW.Text = string_format_ret;
                local v36 = SegmentTemplate:Clone();
                v36.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v36);
                v36.LayoutOrder = #u1;
                v36.Visible = true;
                v36.Parent = Stats;
                v36.ITEM_STAT_NAME.Text = "Sheckles";
                v36.ITEM_STAT_NAME_SHADOW.Text = "Sheckles";
                v36.STAT_VALUE.Text = NumberUtil.DisplaySheckles(v28);
                v36.STAT_VALUE_SHADOW.Text = NumberUtil.DisplaySheckles(v28);
            end;

            if data.MutationString ~= "" or data.Variant ~= "Normal" then
                local v37 = SegmentTemplate:Clone();
                v37.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v37);
                v37.LayoutOrder = #u1;
                v37.Visible = true;
                v37.Parent = Stats;
                v37.ITEM_STAT_NAME.Text = "Mutations";
                v37.ITEM_STAT_NAME_SHADOW.Text = "Mutations";
                v37.STAT_VALUE.Visible = false;
                v37.STAT_VALUE_SHADOW.Visible = false;

                if data.Variant ~= "Normal" then
                    local v38 = SegmentTemplate:Clone();
                    v38.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                    table.insert(u1, v38);
                    v38.LayoutOrder = #u1;
                    v38.Visible = true;
                    v38.Parent = Stats;
                    v38.ITEM_STAT_NAME.Text = `\t{data.Variant}`;
                    v38.ITEM_STAT_NAME_SHADOW.Text = `\t{data.Variant}`;
                    v38.STAT_VALUE.Visible = false;
                    v38.STAT_VALUE_SHADOW.Visible = false;

                    if data.Variant == "Rainbow" then
                        v38.ITEM_STAT_NAME:AddTag("RainbowText");
                    elseif data.Variant == "Gold" then
                        v38.ITEM_STAT_NAME.TextColor3 = Color3.fromHex("#FFD700");
                    end;
                end;

                for _, v in MutationHandler:ExtractMutationsFromString(data.MutationString) do
                    local v39 = SegmentTemplate:Clone();
                    v39.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                    table.insert(u1, v39);
                    v39.LayoutOrder = #u1;
                    v39.Visible = true;
                    v39.Parent = Stats;
                    local v40 = v.DisplayName or v.Name;
                    v39.ITEM_STAT_NAME.Text = `\t{v40}`;
                    v39.ITEM_STAT_NAME_SHADOW.Text = `\t{v40}`;
                    v39.ITEM_STAT_NAME.TextColor3 = v.Color;
                    v39.STAT_VALUE.Visible = false;
                    v39.STAT_VALUE_SHADOW.Visible = false;
                end;
            end;

            LockIcon.Visible = false;
            local tradeLock = u25.tradeLock;

            if tradeLock then
                local Type = tradeLock.Type;
                local Value = tradeLock.Value;
                local v41 = SegmentTemplate:Clone();
                v41.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v41);
                v41.LayoutOrder = #u1;
                v41.Visible = true;
                v41.Parent = Stats;
                v41.ITEM_STAT_NAME.Text = "Trade Cooldown";
                v41.ITEM_STAT_NAME_SHADOW.Text = "Trade Cooldown";

                if Type == "Permanent" then
                    v41.STAT_VALUE.Text = "Untradable";
                    v41.STAT_VALUE_SHADOW.Text = "Untradable";
                    LockIcon.Visible = true;

                    return;
                end;

                if Type == "Date" then
                    local ServerTimeNow = workspace:GetServerTimeNow();
                    local v42 = Value - math.ceil(ServerTimeNow);
                    v41.STAT_VALUE.Text = `Tradable in {NumberUtil.compactFormat(v42)}`;
                    v41.STAT_VALUE_SHADOW.Text = `Tradable in {NumberUtil.compactFormat(v42)}`;
                    LockIcon.Visible = true;

                    return;
                end;

                if Type == "Listing" then
                    v41.STAT_VALUE.Text = `{Value}`;
                    v41.STAT_VALUE_SHADOW.Text = `{Value}`;
                    LockIcon.Visible = false;
                end;
            end;
        end,

        ["Packaged Seed"] = function(p43) -- Line: 414
            -- upvalues: SeedData (copy), TradeUIItemValueCalculators (copy), ITEM_NAME (copy), ITEM_NAME_SHADOW (copy), ITEM_IMAGE (copy), ITEM_RARITY (copy), ITEM_RARITY_SHADOW (copy), Item_Module (copy), TweenService (copy), Detail (copy), SegmentTemplate (copy), u1 (copy), Stats (copy)
            local _ = p43.id;
            local data = p43.data;
            local v44 = SeedData[data.ItemName];
            local v45 = TradeUIItemValueCalculators[p43.type];

            if v45 then
                v45(p43);
            end;

            ITEM_NAME.Text = v44.SeedName;
            ITEM_NAME_SHADOW.Text = v44.SeedName;
            ITEM_IMAGE.Image = v44.Asset;
            ITEM_RARITY.Text = v44.SeedRarity;
            ITEM_RARITY_SHADOW.Text = v44.SeedRarity;
            local v46 = Item_Module.Return_Rarity_Data(v44.SeedRarity);
            local TweenInfo_new_ret = TweenInfo.new(0.2);
            local v47 = {};
            local v48;

            if v46 then
                v48 = v46[2];
            else
                v48 = Color3.fromRGB(255, 255, 255);
            end;

            v47.TextColor3 = v48;
            TweenService:Create(ITEM_RARITY, TweenInfo_new_ret, v47):Play();

            for _, child in Detail:GetChildren() do
                if child:IsA("Frame") then
                    local TweenInfo_new_ret2 = TweenInfo.new(0.2);
                    local v49 = {};
                    local v50;

                    if v46 then
                        v50 = v46[2];
                    else
                        v50 = Color3.fromRGB(43, 13, 0);
                    end;

                    v49.BackgroundColor3 = v50;
                    TweenService:Create(child, TweenInfo_new_ret2, v49):Play();
                end;
            end;

            if data.Variant ~= "Normal" then
                local v51 = SegmentTemplate:Clone();
                v51.BackgroundTransparency = #u1 % 2 == 0 and 0.96 or 0.9;
                table.insert(u1, v51);
                v51.LayoutOrder = #u1;
                v51.Visible = true;
                v51.Parent = Stats;
                v51.ITEM_STAT_NAME.Text = `\t{data.Variant}`;
                v51.ITEM_STAT_NAME_SHADOW.Text = `\t{data.Variant}`;
                v51.STAT_VALUE.Visible = false;
                v51.STAT_VALUE_SHADOW.Visible = false;

                if data.Variant == "Rainbow" then
                    v51.ITEM_STAT_NAME:AddTag("RainbowText");

                    return;
                end;

                if data.Variant == "Gold" then
                    v51.ITEM_STAT_NAME.TextColor3 = Color3.fromHex("#FFD700");
                end;
            end;
        end,

        TradeBoothSkin = function(u52) -- Line: 458
            -- upvalues: TradeBoothSkinRegistry (copy), u3 (copy), RAPValue (copy), TokenRAPController (copy), ItemNameFinder (copy), ITEM_NAME (copy), ITEM_NAME_SHADOW (copy), ItemImageFinder (copy), ITEM_IMAGE (copy), ItemRarityFinder (copy), ITEM_RARITY (copy), ITEM_RARITY_SHADOW (copy), Item_Module (copy), TweenService (copy), Detail (copy)
            local type = u52.type;
            local _ = u52.id;
            local data = u52.data;
            local _ = TradeBoothSkinRegistry[data.SkinID];
            u3.TradeBoothSkin = u52;

            local function _(p53: number?) -- Line: 466
                -- upvalues: u3 (ref), u52 (copy), RAPValue (ref)
                if u3.TradeBoothSkin ~= u52 then
                    return nil;
                end;

                RAPValue.Price.Text = not p53 and "???" or `{p53}`;

                return nil;
            end;

            local RAP = TokenRAPController:GetRAP(type, data);

            if u3.TradeBoothSkin == u52 then
                RAPValue.Price.Text = not RAP and "???" or `{RAP}`;
            end;

            if not RAP then
                task.defer(function() -- Line: 477
                    -- upvalues: TokenRAPController (ref), type (copy), data (copy), u3 (ref), u52 (copy), RAPValue (ref)
                    local RAPAsync = TokenRAPController:GetRAPAsync(type, data);

                    if u3.TradeBoothSkin == u52 then
                        RAPValue.Price.Text = not RAPAsync and "???" or `{RAPAsync}`;
                    end;

                    return nil;
                end);
            end;

            local v54 = ItemNameFinder(data.SkinID, type);
            ITEM_NAME.Text = v54;
            ITEM_NAME_SHADOW.Text = v54;
            ITEM_IMAGE.Image = ItemImageFinder(data.SkinID, type);
            local v55 = ItemRarityFinder(data.SkinID, type);
            ITEM_RARITY.Text = v55;
            ITEM_RARITY_SHADOW.Text = v55;
            local v56 = Item_Module.Return_Rarity_Data(v55);
            local TweenInfo_new_ret = TweenInfo.new(0.2);
            local v57 = {};
            local v58;

            if v56 then
                v58 = v56[2];
            else
                v58 = Color3.fromRGB(255, 255, 255);
            end;

            v57.TextColor3 = v58;
            TweenService:Create(ITEM_RARITY, TweenInfo_new_ret, v57):Play();

            for _, child in Detail:GetChildren() do
                if child:IsA("Frame") then
                    local TweenInfo_new_ret2 = TweenInfo.new(0.2);
                    local v59 = {};
                    local v60;

                    if v56 then
                        v60 = v56[2];
                    else
                        v60 = Color3.fromRGB(43, 13, 0);
                    end;

                    v59.BackgroundColor3 = v60;
                    TweenService:Create(child, TweenInfo_new_ret2, v59):Play();
                end;
            end;
        end
    },
    ItemRenderTypes = {
        Pet = function(p61, p62) -- Line: 65
            -- upvalues: PetRegistry (copy), PetUtilities (copy), Item_Module (copy)
            local Weight = p61.Weight;
            local Vector = p61.Vector;
            local _ = p62.type;
            local _ = p62.id;
            local data = p62.data;
            local v63 = PetRegistry.PetList[data.PetType];
            p61.Title.Text = data.PetType;
            Weight.Text = string.format("%0.2fkg", PetUtilities:CalculateWeight(data.PetData.BaseWeight, data.PetData.Level));
            Vector.Image = not v63 and "rbxassetid://6937742258" or v63.Icon;
            local v64 = Item_Module.Return_Rarity_Data(not v63 and "No Rarity" or v63.Rarity);
            local Stroke = p61.Stroke;
            local v65;

            if v64 then
                v65 = v64[2];
            else
                v65 = Color3.fromRGB(56, 23, 8);
            end;

            Stroke.ImageColor3 = v65;
        end,

        Holdable = function(p66, p67) -- Line: 84
            -- upvalues: SeedData (copy), Calculate_Weight (copy), Item_Module (copy)
            local Title = p66.Title;
            local Weight = p66.Weight;
            local Vector = p66.Vector;
            local _ = p67.id;
            local data = p67.data;
            local v68 = SeedData[data.ItemName];
            local DisplayName = v68.DisplayName;

            if p67.type ~= "Fruit" and DisplayName then
                DisplayName = DisplayName:gsub("Seed", "");
            end;

            Title.Text = DisplayName or data.ItemName;
            Weight.Text = string.format("%0.2fkg", (Calculate_Weight.Calculate_Weight(data.Seed, data.ItemName) or 0) * (data.WeightMultiplier or 1));
            Vector.Image = v68.FruitIcon;
            local v69 = Item_Module.Return_Rarity_Data(v68.SeedRarity);
            local Stroke = p66.Stroke;
            local v70;

            if v69 then
                v70 = v69[2];
            else
                v70 = Color3.fromRGB(56, 23, 8);
            end;

            Stroke.ImageColor3 = v70;
        end,

        ["Packaged Seed"] = function(p71, p72) -- Line: 108
            -- upvalues: SeedData (copy), Item_Module (copy)
            local Weight = p71.Weight;
            local Vector = p71.Vector;
            local _ = p72.type;
            local _ = p72.id;
            local data = p72.data;
            local v73 = SeedData[data.ItemName];
            p71.Title.Text = data.ItemName;
            Weight.Text = "Seed";
            Vector.Image = v73.Asset;
            local v74 = Item_Module.Return_Rarity_Data(v73.SeedRarity);
            local Stroke = p71.Stroke;
            local v75;

            if v74 then
                v75 = v74[2];
            else
                v75 = Color3.fromRGB(56, 23, 8);
            end;

            Stroke.ImageColor3 = v75;
        end
    },

    CleanUpAllSegments = function() -- Line: 56, Name: CleanupAllSegments
        -- upvalues: u1 (copy)
        for _, v in u1 do
            v:Destroy();
        end;

        table.clear(u1);
    end
};