-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Signal = require(ReplicatedStorage.Modules.Signal);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local ShovelSkinRegistry = require(ReplicatedStorage.Data.ShovelSkinRegistry);
local Item_Module = require(ReplicatedStorage.Item_Module);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local LocalPlayer = Players.LocalPlayer;
local HarvestMoonIndexUI = LocalPlayer.PlayerGui:WaitForChild("HarvestMoonIndexUI");
local Panel = HarvestMoonIndexUI.Panel;
local Main = Panel.Main;
local ScrollingFrame = Main.ScrollingFrame;
local CATEGORY_TEMPLATE = ScrollingFrame.CATEGORY_TEMPLATE;
local CATEGORY_HOLDER_TEMPLATE = ScrollingFrame.CATEGORY_HOLDER_TEMPLATE;
local ITEM_TEMPLATE = CATEGORY_HOLDER_TEMPLATE.ITEM_TEMPLATE;
local Discovery = Main.Discovery;
local DESCRIPTION = Discovery.DESCRIPTION;
local PROGRESS = Discovery.Bar.PROGRESS;
local PROGRESS_SHADOW = Discovery.Bar.PROGRESS_SHADOW;
local Bar_Actual = Discovery.Bar.Bar_Actual;
local ITEM_REWARD = Discovery.ITEM_REWARD;
local HarvestMoonIndexService = ReplicatedStorage.GameEvents:WaitForChild("HarvestMoonIndexService");
local RefreshIndex = HarvestMoonIndexService:WaitForChild("RefreshIndex");
local ClaimReward = HarvestMoonIndexService:WaitForChild("ClaimReward");
local u2 = {
    RewardReadyChanged = Signal.new()
};
local Color3_fromRGB_ret = Color3.fromRGB(100, 100, 100);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);
local u3 = {};
local success, result = pcall(Item_Module.Return_All_Seed_Rarities);

if success and type(result) == "table" then
    for i, v in result do
        local v4 = v[1];

        if v4 then
            u3[tostring(v4)] = i;
        end;
    end;
end;

local u5 = {};
local u6 = false;
local u7 = false;
local u8 = false;

local function GetConfig() -- Line: 111
    -- upvalues: GameConfigController (copy)
    local Config = GameConfigController:GetConfig("HarvestMoonIndexConfig");

    return type(Config) == "table" and Config and Config or {};
end;

local function GetRewardConfig() -- Line: 116
    -- upvalues: GameConfigController (copy)
    local Config = GameConfigController:GetConfig("HarvestMoonIndexConfig");
    local Reward = (type(Config) == "table" and Config and Config or {}).Reward;

    return type(Reward) == "table" and Reward and Reward or {};
end;

local function GetRequiredCompletion() -- Line: 121
    -- upvalues: GameConfigController (copy)
    local Config = GameConfigController:GetConfig("HarvestMoonIndexConfig");
    local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
    local v9 = type(Reward) == "table" and Reward and Reward or {};

    return tonumber(v9.RequiredCompletion) or 0.8;
end;

local function GetItemKey(p10) -- Line: 125
    local v11 = p10.Key or `{p10.Type}:{p10.Value}`;

    return tostring(v11);
end;

local function SeedAwareName(p12: string, p13: string) -- Line: 129
    if p13 == "Seed" and not string.match(p12, "%sSeed$") then
        return `{p12} Seed`;
    end;

    return p12;
end;

local function GetItemDisplayName(p14) -- Line: 137
    if p14.DisplayName then
        return tostring(p14.DisplayName);
    end;

    local v15 = tostring(p14.Value or "Unknown");

    if tostring(p14.Type or "") == "Seed" and not string.match(v15, "%sSeed$") then
        return `{v15} Seed`;
    end;

    return v15;
end;

local function GetItemRarity(u16) -- Line: 145
    -- upvalues: ItemRarityFinder (copy)
    local Rarity = u16.Rarity;
    local v17;

    if Rarity then
        v17 = Rarity;
    else
        local v18;
        v18, v17 = pcall(function() -- Line: 149
            -- upvalues: ItemRarityFinder (ref), u16 (copy)
            return ItemRarityFinder(tostring(u16.Value or ""), (tostring(u16.Type or "")));
        end);

        if not v18 then
            v17 = Rarity;
        end;
    end;

    return v17;
end;

local function GetItemRarityRank(u19) -- Line: 164
    -- upvalues: u3 (copy), ItemRarityFinder (copy)
    local Rarity = u19.Rarity;
    local v20;

    if Rarity then
        v20 = Rarity;
    else
        local v21;
        v21, v20 = pcall(function() -- Line: 149
            -- upvalues: ItemRarityFinder (ref), u19 (copy)
            return ItemRarityFinder(tostring(u19.Value or ""), (tostring(u19.Type or "")));
        end);

        if not v21 then
            v20 = Rarity;
        end;
    end;

    return u3[tostring(v20)] or (1 / 0);
end;

local function GetItemRarityColor(u22) -- Line: 168
    -- upvalues: ItemRarityFinder (copy), Item_Module (copy)
    local Rarity = u22.Rarity;
    local v23;

    if Rarity then
        v23 = Rarity;
    else
        local v24;
        v24, v23 = pcall(function() -- Line: 149
            -- upvalues: ItemRarityFinder (ref), u22 (copy)
            return ItemRarityFinder(tostring(u22.Value or ""), (tostring(u22.Type or "")));
        end);

        if not v24 then
            v23 = Rarity;
        end;
    end;

    if not v23 then
        return nil;
    end;

    local v25 = Item_Module.Return_Rarity_Data((tostring(v23)));

    if v25 then
        v25 = v25[2];
    end;

    return v25;
end;

local function ApplyWrapperRarityColor(p26: userdata, u27: any) -- Line: 178
    -- upvalues: ItemRarityFinder (copy), GGStaticData (copy), Item_Module (copy)
    local Rarity = u27.Rarity;
    local v28;

    if Rarity then
        v28 = Rarity;
    else
        local v29;
        v29, v28 = pcall(function() -- Line: 149
            -- upvalues: ItemRarityFinder (ref), u27 (copy)
            return ItemRarityFinder(tostring(u27.Value or ""), (tostring(u27.Type or "")));
        end);

        if not v29 then
            v28 = Rarity;
        end;
    end;

    local v30 = v28 and tostring(v28) or nil;

    if v30 and GGStaticData.AnimatedColors[v30] then
        p26:SetAttribute("Rarity", v30);

        if p26:GetAttribute("_HarvestMoonIndexAnimatedRarity") ~= v30 then
            p26:SetAttribute("_HarvestMoonIndexAnimatedRarity", v30);
            GGStaticData.AnimatedColors[v30](p26);
        end;

        return;
    end;

    p26:SetAttribute("Rarity", v30 or "");
    p26:SetAttribute("_HarvestMoonIndexAnimatedRarity", nil);
    local Rarity2 = u27.Rarity;
    local v31;

    if Rarity2 then
        v31 = Rarity2;
    else
        local v32;
        v32, v31 = pcall(function() -- Line: 149
            -- upvalues: ItemRarityFinder (ref), u27 (copy)
            return ItemRarityFinder(tostring(u27.Value or ""), (tostring(u27.Type or "")));
        end);

        if not v32 then
            v31 = Rarity2;
        end;
    end;

    local v33;

    if v31 then
        v33 = Item_Module.Return_Rarity_Data((tostring(v31)));

        if v33 then
            v33 = v33[2];
        end;
    else
        v33 = nil;
    end;

    if v33 then
        p26.BackgroundColor3 = v33;
    end;
end;

local function GetItemImage(p34) -- Line: 202
    -- upvalues: ItemImageFinder (copy)
    if not p34.Icon then
        return ItemImageFinder(tostring(p34.Value or ""), (tostring(p34.Type or "")));
    end;

    local v35 = tostring(p34.Icon);

    if string.find(v35, "rbxassetid://", 1, true) then
        return v35;
    end;

    return `rbxassetid://{v35}`;
end;

local function SetNameAndShadow(p36: userdata, p37: string) -- Line: 216
    local ITEM_NAME = p36:FindFirstChild("ITEM_NAME", true);

    if ITEM_NAME and ITEM_NAME:IsA("TextLabel") then
        ITEM_NAME.Text = p37;
        local ITEM_NAME_SHADOW = ITEM_NAME:FindFirstChild("ITEM_NAME_SHADOW", true);

        if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
            ITEM_NAME_SHADOW.Text = p37;
        end;
    end;
end;

local function SetRewardName(p38: string, p39: boolean) -- Line: 228
    -- upvalues: ITEM_REWARD (copy)
    local ITEM_NAME = ITEM_REWARD:FindFirstChild("ITEM_NAME", true);

    if ITEM_NAME and ITEM_NAME:IsA("TextLabel") then
        ITEM_NAME.Text = p38;
        ITEM_NAME.Visible = p39;
        local ITEM_NAME_SHADOW = ITEM_NAME:FindFirstChild("ITEM_NAME_SHADOW", true);

        if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
            ITEM_NAME_SHADOW.Text = p38;
            ITEM_NAME_SHADOW.Visible = p39;
        end;
    end;
end;

local function SetItemFrameState(p40: userdata, p41: any, p42: boolean) -- Line: 242
    -- upvalues: ApplyWrapperRarityColor (copy), SetNameAndShadow (copy), GetItemImage (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    local Wrapper = p40:FindFirstChild("Wrapper");

    if not Wrapper then
        return;
    end;

    if Wrapper:IsA("GuiObject") then
        ApplyWrapperRarityColor(Wrapper, p41);
    end;

    local v43;

    if p42 then
        if p41.DisplayName then
            v43 = tostring(p41.DisplayName);
        else
            v43 = tostring(p41.Value or "Unknown");

            if tostring(p41.Type or "") == "Seed" and not string.match(v43, "%sSeed$") then
                v43 = `{v43} Seed`;
            end;
        end;
    else
        v43 = "";
    end;

    SetNameAndShadow(Wrapper, v43);
    local ITEM_IMAGE = Wrapper:FindFirstChild("ITEM_IMAGE");

    if ITEM_IMAGE and ITEM_IMAGE:IsA("ImageLabel") then
        ITEM_IMAGE.Image = GetItemImage(p41);
        local v44;

        if p42 then
            v44 = Color3_fromRGB_ret2;
        else
            v44 = Color3_fromRGB_ret;
        end;

        ITEM_IMAGE.ImageColor3 = v44;
    end;

    local OBTAINED_IMAGE = Wrapper:FindFirstChild("OBTAINED_IMAGE");

    if OBTAINED_IMAGE and OBTAINED_IMAGE:IsA("GuiObject") then
        OBTAINED_IMAGE.Visible = p42;
    end;

    local Cover = Wrapper:FindFirstChild("Cover");

    if Cover and Cover:IsA("GuiObject") then
        Cover.Visible = not p42;
    end;
end;

local function GetAllIndexItems() -- Line: 271
    -- upvalues: GameConfigController (copy)
    local v45 = {};
    local Config = GameConfigController:GetConfig("HarvestMoonIndexConfig");
    local Categories = (type(Config) == "table" and Config and Config or {}).Categories;

    if type(Categories) ~= "table" then
        return v45;
    end;

    for _, v in Categories do
        if type(v) == "table" and type(v.Items) == "table" then
            for _, v2 in v.Items do
                table.insert(v45, v2);
            end;
        end;
    end;

    return v45;
end;

local function GetIndexData() -- Line: 292
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonIndexData;
    end;

    return Data;
end;

local function IsItemDiscovered(p46) -- Line: 297
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonIndexData;
    end;

    if Data then
        Data = Data.Discovered;
    end;

    if type(Data) ~= "table" then
        return false;
    end;

    local v47 = p46.Key or `{p46.Type}:{p46.Value}`;

    return Data[tostring(v47)] == true;
end;

local function GetCompletion() -- Line: 308
    -- upvalues: GetAllIndexItems (copy), DataService (copy)
    local v48 = 0;
    local v49 = 0;

    for _, v in GetAllIndexItems() do
        v48 = v48 + 1;
        local Data = DataService:GetData();

        if Data then
            Data = Data.HarvestMoonIndexData;
        end;

        if Data then
            Data = Data.Discovered;
        end;

        local v50;

        if type(Data) == "table" then
            local v51 = v.Key or `{v.Type}:{v.Value}`;
            v50 = Data[tostring(v51)] == true;
        else
            v50 = false;
        end;

        if v50 then
            v49 = v49 + 1;
        end;
    end;

    return v49, v48, v48 <= 0 and 0 or math.clamp(v49 / v48, 0, 1);
end;

local function IsRewardClaimed() -- Line: 325
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonIndexData;
    end;

    local v52;

    if type(Data) == "table" then
        v52 = Data.RewardClaimed == true;
    else
        v52 = false;
    end;

    return v52;
end;

local function UpdateReadyLabels(p53: boolean) -- Line: 331
    -- upvalues: CollectionService (copy)
    local v54 = p53 and "Ready!" or "";

    for _, v in CollectionService:GetTagged("HarvestMoonCollectionReady") do
        if v:IsA("TextLabel") then
            v.Text = v54;
        end;
    end;
end;

local function SetRewardState() -- Line: 341
    -- upvalues: GetCompletion (copy), DataService (copy), GameConfigController (copy), UpdateReadyLabels (copy), u8 (ref), u2 (copy), ShovelSkinRegistry (copy), ITEM_REWARD (copy), Color3_fromRGB_ret2 (copy), SetRewardName (copy)
    local _, v55, v56 = GetCompletion();
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonIndexData;
    end;

    local v57;

    if type(Data) == "table" then
        v57 = Data.RewardClaimed == true;
    else
        v57 = false;
    end;

    local v58;

    if v55 > 0 then
        local Config = GameConfigController:GetConfig("HarvestMoonIndexConfig");
        local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
        local v59 = type(Reward) == "table" and Reward and Reward or {};
        v58 = (tonumber(v59.RequiredCompletion) or 0.8) <= v56;
    else
        v58 = false;
    end;

    local v60;

    if v58 then
        v60 = not v57;
    else
        v60 = v58;
    end;

    UpdateReadyLabels(v60);

    if v60 ~= u8 then
        u8 = v60;
        u2.RewardReadyChanged:Fire(v60);
    end;

    local Config = GameConfigController:GetConfig("HarvestMoonIndexConfig");
    local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
    local v61 = type(Reward) == "table" and Reward and Reward or {};
    local v62 = tostring(v61.DisplayName or "Harvest Moon Shovel");
    local v63 = ShovelSkinRegistry[tostring(v61.ShovelSkin or "HarvestMoon")];
    local ITEM_IMAGE = ITEM_REWARD:FindFirstChild("ITEM_IMAGE", true);

    if ITEM_IMAGE and ITEM_IMAGE:IsA("ImageLabel") then
        if v63 then
            v63 = v63.Icon;
        end;

        if v63 then
            ITEM_IMAGE.Image = string.find(v63, "rbxassetid://", 1, true) and v63 and v63 or `rbxassetid://{v63}`;
        end;

        ITEM_IMAGE.ImageColor3 = Color3_fromRGB_ret2;
    end;

    local OBTAINED_IMAGE = ITEM_REWARD:FindFirstChild("OBTAINED_IMAGE", true);

    if OBTAINED_IMAGE and OBTAINED_IMAGE:IsA("GuiObject") then
        OBTAINED_IMAGE.Visible = v57;
    end;

    local Cover = ITEM_REWARD:FindFirstChild("Cover", true);

    if Cover and Cover:IsA("GuiObject") then
        Cover.Visible = v57;
    end;

    local CLAIM_BUTTON = ITEM_REWARD:FindFirstChild("CLAIM_BUTTON", true);

    if CLAIM_BUTTON and CLAIM_BUTTON:IsA("GuiObject") then
        local v64;

        if v58 then
            v64 = not v57;
        else
            v64 = v58;
        end;

        CLAIM_BUTTON.Visible = v64;
    end;

    if v57 then
        SetRewardName("", true);
    elseif v58 then
        SetRewardName("", false);
    else
        SetRewardName(v62, true);
    end;

    ITEM_REWARD:SetAttribute("RewardDisplayName", v62);
end;

local function Render() -- Line: 397
    -- upvalues: GetCompletion (copy), PROGRESS (copy), PROGRESS_SHADOW (copy), Bar_Actual (copy), GetAllIndexItems (copy), u5 (copy), SetItemFrameState (copy), DataService (copy), SetRewardState (copy)
    local v65, v66, v67 = GetCompletion();
    local v68 = `{v65} / {v66} Discovered ({math.floor(v67 * 100 + 0.5)}%)`;
    PROGRESS.Text = v68;
    PROGRESS_SHADOW.Text = v68;
    Bar_Actual.Size = UDim2.fromScale(v67, 1);

    for _, v in GetAllIndexItems() do
        local v69 = v.Key or `{v.Type}:{v.Value}`;
        local v70 = u5[tostring(v69)];

        if v70 then
            local Data = DataService:GetData();

            if Data then
                Data = Data.HarvestMoonIndexData;
            end;

            if Data then
                Data = Data.Discovered;
            end;

            local v71;

            if type(Data) == "table" then
                local v72 = v.Key or `{v.Type}:{v.Value}`;
                v71 = Data[tostring(v72)] == true;
            else
                v71 = false;
            end;

            SetItemFrameState(v70, v, v71);
        end;
    end;

    SetRewardState();
end;

local function RequestServerRefresh() -- Line: 419
    -- upvalues: RefreshIndex (copy)
    local success2, result2 = pcall(function() -- Line: 420
        -- upvalues: RefreshIndex (ref)
        return RefreshIndex:InvokeServer();
    end);

    if not success2 then
        warn("HarvestMoonIndexController: failed to refresh index:", result2);
    end;
end;

local function QueueServerRefresh() -- Line: 429
    -- upvalues: u6 (ref), RefreshIndex (copy), Render (copy)
    if u6 then
        return;
    end;

    u6 = true;
    task.defer(function() -- Line: 436
        -- upvalues: u6 (ref), RefreshIndex (ref), Render (ref)
        u6 = false;
        local success2, result2 = pcall(function() -- Line: 420
            -- upvalues: RefreshIndex (ref)
            return RefreshIndex:InvokeServer();
        end);

        if not success2 then
            warn("HarvestMoonIndexController: failed to refresh index:", result2);
        end;

        Render();
    end);
end;

local function ClearBuiltList() -- Line: 443
    -- upvalues: ScrollingFrame (copy), CATEGORY_TEMPLATE (copy), CATEGORY_HOLDER_TEMPLATE (copy), u5 (copy)
    for _, child in ScrollingFrame:GetChildren() do
        if child ~= CATEGORY_TEMPLATE and (child ~= CATEGORY_HOLDER_TEMPLATE and child:IsA("GuiObject")) then
            child:Destroy();
        end;
    end;

    table.clear(u5);
end;

local function HighlightDescriptionPercent() -- Line: 455
    -- upvalues: DESCRIPTION (copy)
    if DESCRIPTION:GetAttribute("_PercentHighlighted") then
        return;
    end;

    local string_gsub_ret, v73 = string.gsub(DESCRIPTION.Text, "(%d+%%)", "<font color=\"#FFC21E\">%1</font>", 1);

    if v73 > 0 then
        DESCRIPTION.RichText = true;
        DESCRIPTION.Text = string_gsub_ret;
        DESCRIPTION:SetAttribute("_PercentHighlighted", true);
    end;
end;

local function Build() -- Line: 474
    -- upvalues: u7 (ref), DESCRIPTION (copy), CATEGORY_TEMPLATE (copy), CATEGORY_HOLDER_TEMPLATE (copy), ITEM_TEMPLATE (copy), ClearBuiltList (copy), GameConfigController (copy), Render (copy), ScrollingFrame (copy), u3 (copy), ItemRarityFinder (copy), u5 (copy)
    if u7 then
        return;
    end;

    u7 = true;

    if not DESCRIPTION:GetAttribute("_PercentHighlighted") then
        local string_gsub_ret, v74 = string.gsub(DESCRIPTION.Text, "(%d+%%)", "<font color=\"#FFC21E\">%1</font>", 1);

        if v74 > 0 then
            DESCRIPTION.RichText = true;
            DESCRIPTION.Text = string_gsub_ret;
            DESCRIPTION:SetAttribute("_PercentHighlighted", true);
        end;
    end;

    CATEGORY_TEMPLATE.Visible = false;
    CATEGORY_HOLDER_TEMPLATE.Visible = false;
    ITEM_TEMPLATE.Visible = false;
    ClearBuiltList();
    local v75 = 0;
    local Config = GameConfigController:GetConfig("HarvestMoonIndexConfig");
    local Categories = (type(Config) == "table" and Config and Config or {}).Categories;

    if type(Categories) ~= "table" then
        Render();

        return;
    end;

    for _, v in Categories do
        if type(v) == "table" and type(v.Items) == "table" then
            local v76 = v75 + 1;
            local v77 = CATEGORY_TEMPLATE:Clone();
            v77.Name = `{v.Name}_Header`;
            v77.Visible = true;
            v77.LayoutOrder = v76;
            local Title = v77:FindFirstChild("Title", true);

            if Title and Title:IsA("TextLabel") then
                local v78 = tostring(v.Name);
                Title.Text = v78;
                local Title_Shadow = Title:FindFirstChild("Title_Shadow");

                if Title_Shadow and Title_Shadow:IsA("TextLabel") then
                    Title_Shadow.Text = v78;
                end;
            end;

            v77.Parent = ScrollingFrame;
            v75 = v76 + 1;
            local v79 = CATEGORY_HOLDER_TEMPLATE:Clone();
            v79.Name = `{v.Name}_Holder`;
            v79.Visible = true;
            v79.LayoutOrder = v75;
            v79.Parent = ScrollingFrame;
            local ITEM_TEMPLATE2 = v79:FindFirstChild("ITEM_TEMPLATE");

            if ITEM_TEMPLATE2 and ITEM_TEMPLATE2:IsA("GuiObject") then
                ITEM_TEMPLATE2.Visible = false;
            end;

            local v80 = {};

            for i, v2 in v.Items do
                local v81 = {
                    Config = v2,
                    Order = i
                };
                local Rarity = v2.Rarity;
                local v82;

                if Rarity then
                    v82 = Rarity;
                else
                    local v83;
                    v83, v82 = pcall(function() -- Line: 149
                        -- upvalues: ItemRarityFinder (ref), v2 (copy)
                        return ItemRarityFinder(tostring(v2.Value or ""), (tostring(v2.Type or "")));
                    end);

                    if not v83 then
                        v82 = Rarity;
                    end;
                end;

                v81.Rank = u3[tostring(v82)] or (1 / 0);
                table.insert(v80, v81);
            end;

            table.sort(v80, function(p84, p85) -- Line: 546
                if p84.Rank == p85.Rank then
                    return p84.Order < p85.Order;
                end;

                return p84.Rank < p85.Rank;
            end);

            for i, v2 in v80 do
                local Config2 = v2.Config;
                local v86 = ITEM_TEMPLATE:Clone();
                local v87 = Config2.Key or `{Config2.Type}:{Config2.Value}`;
                v86.Name = tostring(v87);
                v86.LayoutOrder = i;
                v86.Visible = true;
                v86.Parent = v79;
                local v88 = Config2.Key or `{Config2.Type}:{Config2.Value}`;
                u5[tostring(v88)] = v86;
            end;
        end;
    end;

    Render();
end;

local function Rebuild() -- Line: 569
    -- upvalues: u7 (ref), Build (copy)
    u7 = false;
    Build();
end;

local function u96() -- Line: 574
    -- upvalues: DataService (copy), GetCompletion (copy), GameConfigController (copy), ClaimReward (copy), u6 (ref), RefreshIndex (copy), Render (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonIndexData;
    end;

    local v89;

    if type(Data) == "table" then
        v89 = Data.RewardClaimed == true;
    else
        v89 = false;
    end;

    if v89 then
        return;
    end;

    local _, v90, v91 = GetCompletion();

    if v90 > 0 then
        local Config = GameConfigController:GetConfig("HarvestMoonIndexConfig");
        local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
        local v92 = type(Reward) == "table" and Reward and Reward or {};

        if v91 >= (tonumber(v92.RequiredCompletion) or 0.8) then
            local v93, v94, v95 = pcall(function() -- Line: 585
                -- upvalues: ClaimReward (ref)
                return ClaimReward:InvokeServer();
            end);

            if not v93 then
                warn("HarvestMoonIndexController: failed to claim reward:", v94);

                return;
            end;

            if not v94 and v95 then
                warn("HarvestMoonIndexController:", v95);
            end;

            if u6 then
                return;
            end;

            u6 = true;
            task.defer(function() -- Line: 436
                -- upvalues: u6 (ref), RefreshIndex (ref), Render (ref)
                u6 = false;
                local success2, result2 = pcall(function() -- Line: 420
                    -- upvalues: RefreshIndex (ref)
                    return RefreshIndex:InvokeServer();
                end);

                if not success2 then
                    warn("HarvestMoonIndexController: failed to refresh index:", result2);
                end;

                Render();
            end);
        end;
    end;
end;

local function HookRewardButton() -- Line: 601
    -- upvalues: ITEM_REWARD (copy), SetupButton (copy), u96 (copy)
    local CLAIM_BUTTON = ITEM_REWARD:FindFirstChild("CLAIM_BUTTON", true);

    if not CLAIM_BUTTON then
        return;
    end;

    local SENSOR = CLAIM_BUTTON:FindFirstChild("SENSOR");

    if not (SENSOR and SENSOR:IsA("GuiButton")) then
        return;
    end;

    if SENSOR:GetAttribute("_HarvestMoonIndexHooked") then
        return;
    end;

    SENSOR:SetAttribute("_HarvestMoonIndexHooked", true);
    SetupButton({
        legacy = true,
        offset = 0.05,
        instance = SENSOR,
        scale = SENSOR:FindFirstChildOfClass("UIScale"),
        onclick = u96
    });
end;

local u97 = false;

local function HookGuiController() -- Line: 629
    -- upvalues: u97 (ref), GuiController (copy), HarvestMoonIndexUI (copy), Panel (copy), Build (copy), HookRewardButton (copy), RefreshIndex (copy), Render (copy)
    if u97 then
        return;
    end;

    u97 = true;
    GuiController:UsePopupAnims(HarvestMoonIndexUI);
    local Close = Panel:FindFirstChild("Close", true);

    if Close and Close:IsA("GuiButton") then
        Close.Activated:Connect(function() -- Line: 640
            -- upvalues: GuiController (ref), HarvestMoonIndexUI (ref)
            GuiController:Close(HarvestMoonIndexUI);
        end);
    end;

    GuiController:GetStateForGui(HarvestMoonIndexUI).Visible:Observe(function(p98: boolean) -- Line: 646
        -- upvalues: Build (ref), HookRewardButton (ref), RefreshIndex (ref), Render (ref)
        if not p98 then
            return;
        end;

        Build();
        HookRewardButton();
        local success2, result2 = pcall(function() -- Line: 420
            -- upvalues: RefreshIndex (ref)
            return RefreshIndex:InvokeServer();
        end);

        if not success2 then
            warn("HarvestMoonIndexController: failed to refresh index:", result2);
        end;

        Render();
    end);
end;

local function ConnectDataSignal(u99: string, p100: any) -- Line: 659
    -- upvalues: DataService (copy), u1 (copy)
    local success2, result2 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u99 (copy)
        return DataService:GetPathSignal(u99);
    end);

    if success2 and result2 then
        u1:Add(result2:Connect(p100));
    end;
end;

function u2.IsRewardReady() -- Line: 670
    -- upvalues: u8 (ref)
    return u8;
end;

function u2.Open() -- Line: 675
    -- upvalues: GuiController (copy), HarvestMoonIndexUI (copy)
    GuiController:Open(HarvestMoonIndexUI);
end;

function u2.Start() -- Line: 679
    -- upvalues: Build (copy), HookRewardButton (copy), HookGuiController (copy), RefreshIndex (copy), Render (copy), DataService (copy), u1 (copy), QueueServerRefresh (copy), Rebuild (copy), LocalPlayer (copy), GuiController (copy), HarvestMoonIndexUI (copy)
    Build();
    HookRewardButton();
    HookGuiController();
    local success2, result2 = pcall(function() -- Line: 420
        -- upvalues: RefreshIndex (ref)
        return RefreshIndex:InvokeServer();
    end);

    if not success2 then
        warn("HarvestMoonIndexController: failed to refresh index:", result2);
    end;

    Render();
    local v101 = Render;
    local u102 = "HarvestMoonIndexData";
    local success3, result3 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u102 (copy)
        return DataService:GetPathSignal(u102);
    end);

    if success3 and result3 then
        u1:Add(result3:Connect(v101));
    end;

    local v103 = Render;
    local u104 = "HarvestMoonIndexData/Discovered";
    local success4, result4 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u104 (copy)
        return DataService:GetPathSignal(u104);
    end);

    if success4 and result4 then
        u1:Add(result4:Connect(v103));
    end;

    local v105 = Render;
    local u106 = "HarvestMoonIndexData/RewardClaimed";
    local success5, result5 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u106 (copy)
        return DataService:GetPathSignal(u106);
    end);

    if success5 and result5 then
        u1:Add(result5:Connect(v105));
    end;

    local v107 = QueueServerRefresh;
    local u108 = "InventoryData";
    local success6, result6 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u108 (copy)
        return DataService:GetPathSignal(u108);
    end);

    if success6 and result6 then
        u1:Add(result6:Connect(v107));
    end;

    local v109 = QueueServerRefresh;
    local u110 = "InventoryData/@";
    local success7, result7 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u110 (copy)
        return DataService:GetPathSignal(u110);
    end);

    if success7 and result7 then
        u1:Add(result7:Connect(v109));
    end;

    local v111 = QueueServerRefresh;
    local u112 = "PetsData/PetInventory/Data";
    local success8, result8 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u112 (copy)
        return DataService:GetPathSignal(u112);
    end);

    if success8 and result8 then
        u1:Add(result8:Connect(v111));
    end;

    local v113 = QueueServerRefresh;
    local u114 = "PetsData/PetInventory/Data/@";
    local success9, result9 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u114 (copy)
        return DataService:GetPathSignal(u114);
    end);

    if success9 and result9 then
        u1:Add(result9:Connect(v113));
    end;

    local v115 = QueueServerRefresh;
    local u116 = "CosmeticData/Inventory";
    local success10, result10 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u116 (copy)
        return DataService:GetPathSignal(u116);
    end);

    if success10 and result10 then
        u1:Add(result10:Connect(v115));
    end;

    local v117 = QueueServerRefresh;
    local u118 = "CosmeticData/Inventory/@";
    local success11, result11 = pcall(function() -- Line: 660
        -- upvalues: DataService (ref), u118 (copy)
        return DataService:GetPathSignal(u118);
    end);

    if success11 and result11 then
        u1:Add(result11:Connect(v117));
    end;

    u1:Add(workspace:GetAttributeChangedSignal("HarvestMoonIndexConfig"):Connect(Rebuild));
    Render();

    if LocalPlayer.Name == "Luaappp" then
        game:GetService("UserInputService").InputBegan:Connect(function(p119, p120) -- Line: 707
            -- upvalues: GuiController (ref), HarvestMoonIndexUI (ref)
            if p120 then
                return;
            end;

            if p119.KeyCode == Enum.KeyCode.Z then
                GuiController:Open(HarvestMoonIndexUI);
            end;
        end);
    end;
end;

EventRotationClientBinder:Bind({
    EventSet = "HarvestMoonEvent",
    Script = script,

    OnStart = function() -- Line: 720, Name: OnStart
        -- upvalues: u2 (copy)
        task.spawn(u2.Start);
    end,

    OnStop = function() -- Line: 721, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u2;