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
local FallMarketIndexUI = Players.LocalPlayer.PlayerGui:WaitForChild("FallMarketIndexUI");
local Panel = FallMarketIndexUI.Panel;
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
local ITEM_NAME = ITEM_REWARD.ITEM_NAME;
local Position = ITEM_NAME.Position;
local UDim2_fromScale_ret = UDim2.fromScale(Position.X.Scale, 1 - Position.Y.Scale - ITEM_NAME.Size.Y.Scale);
local FallMarketIndexService = ReplicatedStorage.GameEvents:WaitForChild("FallMarketIndexService");
local RefreshIndex = FallMarketIndexService:WaitForChild("RefreshIndex");
local ClaimReward = FallMarketIndexService:WaitForChild("ClaimReward");
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

local function GetConfig() -- Line: 100
    -- upvalues: GameConfigController (copy)
    local Config = GameConfigController:GetConfig("FallMarketIndexConfig");

    return type(Config) == "table" and Config and Config or {};
end;

local function GetRewardConfig() -- Line: 105
    -- upvalues: GameConfigController (copy)
    local Config = GameConfigController:GetConfig("FallMarketIndexConfig");
    local Reward = (type(Config) == "table" and Config and Config or {}).Reward;

    return type(Reward) == "table" and Reward and Reward or {};
end;

local function GetRequiredCompletion() -- Line: 110
    -- upvalues: GameConfigController (copy)
    local Config = GameConfigController:GetConfig("FallMarketIndexConfig");
    local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
    local v9 = type(Reward) == "table" and Reward and Reward or {};

    return tonumber(v9.RequiredCompletion) or 0.8;
end;

local function ToPercent(p10: number) -- Line: 114
    return math.floor(p10 * 100 + 0.5);
end;

local function MeetsRequiredCompletion(p11: number) -- Line: 119
    -- upvalues: GameConfigController (copy)
    local math_floor_ret = math.floor(p11 * 100 + 0.5);
    local Config = GameConfigController:GetConfig("FallMarketIndexConfig");
    local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
    local v12 = type(Reward) == "table" and Reward and Reward or {};
    local v13 = (tonumber(v12.RequiredCompletion) or 0.8) * 100 + 0.5;

    return math.floor(v13) <= math_floor_ret;
end;

local function GetItemKey(p14) -- Line: 123
    local v15 = p14.Key or `{p14.Type}:{p14.Value}`;

    return tostring(v15);
end;

local function SeedAwareName(p16: string, p17: string) -- Line: 127
    if p17 == "Seed" and not string.match(p16, "%sSeed$") then
        return `{p16} Seed`;
    end;

    return p16;
end;

local function GetItemDisplayName(p18) -- Line: 135
    if p18.DisplayName then
        return tostring(p18.DisplayName);
    end;

    local v19 = tostring(p18.Value or "Unknown");

    if tostring(p18.Type or "") == "Seed" and not string.match(v19, "%sSeed$") then
        return `{v19} Seed`;
    end;

    return v19;
end;

local function GetItemRarity(u20) -- Line: 143
    -- upvalues: ItemRarityFinder (copy)
    local Rarity = u20.Rarity;
    local v21;

    if Rarity then
        v21 = Rarity;
    else
        local v22;
        v22, v21 = pcall(function() -- Line: 147
            -- upvalues: ItemRarityFinder (ref), u20 (copy)
            return ItemRarityFinder(tostring(u20.Value or ""), (tostring(u20.Type or "")));
        end);

        if not v22 then
            v21 = Rarity;
        end;
    end;

    return v21;
end;

local function GetItemRarityRank(u23) -- Line: 159
    -- upvalues: u3 (copy), ItemRarityFinder (copy)
    local Rarity = u23.Rarity;
    local v24;

    if Rarity then
        v24 = Rarity;
    else
        local v25;
        v25, v24 = pcall(function() -- Line: 147
            -- upvalues: ItemRarityFinder (ref), u23 (copy)
            return ItemRarityFinder(tostring(u23.Value or ""), (tostring(u23.Type or "")));
        end);

        if not v25 then
            v24 = Rarity;
        end;
    end;

    return u3[tostring(v24)] or (1 / 0);
end;

local function GetItemRarityColor(u26) -- Line: 163
    -- upvalues: ItemRarityFinder (copy), Item_Module (copy)
    local Rarity = u26.Rarity;
    local v27;

    if Rarity then
        v27 = Rarity;
    else
        local v28;
        v28, v27 = pcall(function() -- Line: 147
            -- upvalues: ItemRarityFinder (ref), u26 (copy)
            return ItemRarityFinder(tostring(u26.Value or ""), (tostring(u26.Type or "")));
        end);

        if not v28 then
            v27 = Rarity;
        end;
    end;

    if not v27 then
        return nil;
    end;

    local v29 = Item_Module.Return_Rarity_Data((tostring(v27)));

    if v29 then
        v29 = v29[2];
    end;

    return v29;
end;

local function ApplyWrapperRarityColor(p30: userdata, u31: any) -- Line: 173
    -- upvalues: ItemRarityFinder (copy), GGStaticData (copy), Item_Module (copy)
    local Rarity = u31.Rarity;
    local v32;

    if Rarity then
        v32 = Rarity;
    else
        local v33;
        v33, v32 = pcall(function() -- Line: 147
            -- upvalues: ItemRarityFinder (ref), u31 (copy)
            return ItemRarityFinder(tostring(u31.Value or ""), (tostring(u31.Type or "")));
        end);

        if not v33 then
            v32 = Rarity;
        end;
    end;

    local v34 = v32 and tostring(v32) or nil;

    if v34 and GGStaticData.AnimatedColors[v34] then
        p30:SetAttribute("Rarity", v34);

        if p30:GetAttribute("_FallMarketIndexAnimatedRarity") ~= v34 then
            p30:SetAttribute("_FallMarketIndexAnimatedRarity", v34);
            GGStaticData.AnimatedColors[v34](p30);
        end;

        return;
    end;

    p30:SetAttribute("Rarity", v34 or "");
    p30:SetAttribute("_FallMarketIndexAnimatedRarity", nil);
    local Rarity2 = u31.Rarity;
    local v35;

    if Rarity2 then
        v35 = Rarity2;
    else
        local v36;
        v36, v35 = pcall(function() -- Line: 147
            -- upvalues: ItemRarityFinder (ref), u31 (copy)
            return ItemRarityFinder(tostring(u31.Value or ""), (tostring(u31.Type or "")));
        end);

        if not v36 then
            v35 = Rarity2;
        end;
    end;

    local v37;

    if v35 then
        v37 = Item_Module.Return_Rarity_Data((tostring(v35)));

        if v37 then
            v37 = v37[2];
        end;
    else
        v37 = nil;
    end;

    if v37 then
        p30.BackgroundColor3 = v37;
    end;
end;

local function ToAssetId(p38: string) -- Line: 197
    if string.find(p38, "rbxassetid://", 1, true) then
        return p38;
    end;

    return `rbxassetid://{p38}`;
end;

local function GetItemImage(p39) -- Line: 201
    -- upvalues: ItemImageFinder (copy)
    if not p39.Icon then
        return ItemImageFinder(tostring(p39.Value or ""), (tostring(p39.Type or "")));
    end;

    local v40 = tostring(p39.Icon);

    if string.find(v40, "rbxassetid://", 1, true) then
        return v40;
    end;

    return `rbxassetid://{v40}`;
end;

local function SetNameAndShadow(p41: userdata, p42: string, p43: boolean?) -- Line: 209
    local ITEM_NAME2 = p41:FindFirstChild("ITEM_NAME", true);

    if ITEM_NAME2 and ITEM_NAME2:IsA("TextLabel") then
        ITEM_NAME2.Text = p42;

        if p43 ~= nil then
            ITEM_NAME2.Visible = p43;
        end;

        local ITEM_NAME_SHADOW = ITEM_NAME2:FindFirstChild("ITEM_NAME_SHADOW", true);

        if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
            ITEM_NAME_SHADOW.Text = p42;

            if p43 ~= nil then
                ITEM_NAME_SHADOW.Visible = p43;
            end;
        end;
    end;
end;

local function SetItemFrameState(p44: userdata, p45: any, p46: boolean) -- Line: 227
    -- upvalues: ApplyWrapperRarityColor (copy), ItemImageFinder (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    local Wrapper = p44:FindFirstChild("Wrapper");

    if not Wrapper then
        return;
    end;

    if Wrapper:IsA("GuiObject") then
        ApplyWrapperRarityColor(Wrapper, p45);
    end;

    local v47;

    if p46 then
        if p45.DisplayName then
            v47 = tostring(p45.DisplayName);
        else
            v47 = tostring(p45.Value or "Unknown");

            if tostring(p45.Type or "") == "Seed" and not string.match(v47, "%sSeed$") then
                v47 = `{v47} Seed`;
            end;
        end;
    else
        v47 = "";
    end;

    local ITEM_NAME2 = Wrapper:FindFirstChild("ITEM_NAME", true);

    if ITEM_NAME2 and ITEM_NAME2:IsA("TextLabel") then
        ITEM_NAME2.Text = v47;
        local ITEM_NAME_SHADOW = ITEM_NAME2:FindFirstChild("ITEM_NAME_SHADOW", true);

        if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
            ITEM_NAME_SHADOW.Text = v47;
        end;
    end;

    local ITEM_IMAGE = Wrapper:FindFirstChild("ITEM_IMAGE");

    if ITEM_IMAGE and ITEM_IMAGE:IsA("ImageLabel") then
        local v48;

        if p45.Icon then
            v48 = tostring(p45.Icon);

            if not string.find(v48, "rbxassetid://", 1, true) then
                v48 = `rbxassetid://{v48}`;
            end;
        else
            v48 = ItemImageFinder(tostring(p45.Value or ""), (tostring(p45.Type or "")));
        end;

        ITEM_IMAGE.Image = v48;
        local v49;

        if p46 then
            v49 = Color3_fromRGB_ret2;
        else
            v49 = Color3_fromRGB_ret;
        end;

        ITEM_IMAGE.ImageColor3 = v49;
    end;

    local OBTAINED_IMAGE = Wrapper:FindFirstChild("OBTAINED_IMAGE");

    if OBTAINED_IMAGE and OBTAINED_IMAGE:IsA("GuiObject") then
        OBTAINED_IMAGE.Visible = p46;
    end;

    local Cover = Wrapper:FindFirstChild("Cover");

    if Cover and Cover:IsA("GuiObject") then
        Cover.Visible = not p46;
    end;
end;

local function GetAllIndexItems() -- Line: 256
    -- upvalues: GameConfigController (copy)
    local v50 = {};
    local Config = GameConfigController:GetConfig("FallMarketIndexConfig");
    local Categories = (type(Config) == "table" and Config and Config or {}).Categories;

    if type(Categories) ~= "table" then
        return v50;
    end;

    for _, v in Categories do
        if type(v) == "table" and type(v.Items) == "table" then
            for _, v2 in v.Items do
                table.insert(v50, v2);
            end;
        end;
    end;

    return v50;
end;

local function GetIndexData() -- Line: 277
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.FallMarketIndexData;
    end;

    return Data;
end;

local function IsItemDiscovered(p51) -- Line: 282
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.FallMarketIndexData;
    end;

    if Data then
        Data = Data.Discovered;
    end;

    if type(Data) ~= "table" then
        return false;
    end;

    local v52 = p51.Key or `{p51.Type}:{p51.Value}`;

    return Data[tostring(v52)] == true;
end;

local function GetCompletion() -- Line: 293
    -- upvalues: GetAllIndexItems (copy), DataService (copy)
    local v53 = 0;
    local v54 = 0;

    for _, v in GetAllIndexItems() do
        v53 = v53 + 1;
        local Data = DataService:GetData();

        if Data then
            Data = Data.FallMarketIndexData;
        end;

        if Data then
            Data = Data.Discovered;
        end;

        local v55;

        if type(Data) == "table" then
            local v56 = v.Key or `{v.Type}:{v.Value}`;
            v55 = Data[tostring(v56)] == true;
        else
            v55 = false;
        end;

        if v55 then
            v54 = v54 + 1;
        end;
    end;

    return v54, v53, v53 <= 0 and 0 or math.clamp(v54 / v53, 0, 1);
end;

local function IsRewardClaimed() -- Line: 310
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.FallMarketIndexData;
    end;

    local v57;

    if type(Data) == "table" then
        v57 = Data.RewardClaimed == true;
    else
        v57 = false;
    end;

    return v57;
end;

local function ApplyReadyLabel(p58: userdata, p59: boolean) -- Line: 316
    if p58:IsA("TextLabel") then
        p58.Text = p59 and "Ready!" or "";
    end;
end;

local function UpdateReadyLabels(p60: boolean) -- Line: 322
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged("FallMarketCollectionReady") do
        if v:IsA("TextLabel") then
            v.Text = p60 and "Ready!" or "";
        end;
    end;
end;

local function SetRewardState() -- Line: 328
    -- upvalues: GetCompletion (copy), DataService (copy), GameConfigController (copy), CollectionService (copy), u8 (ref), u2 (copy), ShovelSkinRegistry (copy), ITEM_REWARD (copy), Color3_fromRGB_ret2 (copy), ITEM_NAME (copy), UDim2_fromScale_ret (copy), Position (copy)
    local _, v61, v62 = GetCompletion();
    local Data = DataService:GetData();

    if Data then
        Data = Data.FallMarketIndexData;
    end;

    local v63;

    if type(Data) == "table" then
        v63 = Data.RewardClaimed == true;
    else
        v63 = false;
    end;

    local v64;

    if v61 > 0 then
        local math_floor_ret = math.floor(v62 * 100 + 0.5);
        local Config = GameConfigController:GetConfig("FallMarketIndexConfig");
        local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
        local v65 = type(Reward) == "table" and Reward and Reward or {};
        local v66 = (tonumber(v65.RequiredCompletion) or 0.8) * 100 + 0.5;
        v64 = math.floor(v66) <= math_floor_ret;
    else
        v64 = false;
    end;

    local v67;

    if v64 then
        v67 = not v63;
    else
        v67 = v64;
    end;

    for _, v in CollectionService:GetTagged("FallMarketCollectionReady") do
        if v:IsA("TextLabel") then
            v.Text = v67 and "Ready!" or "";
        end;
    end;

    if v67 ~= u8 then
        u8 = v67;
        u2.RewardReadyChanged:Fire(v67);
    end;

    local Config = GameConfigController:GetConfig("FallMarketIndexConfig");
    local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
    local v68 = type(Reward) == "table" and Reward and Reward or {};
    local v69 = tostring(v68.DisplayName or "Fall Shovel");
    local v70 = ShovelSkinRegistry[tostring(v68.ShovelSkin or "FallShovel")];
    local ITEM_IMAGE = ITEM_REWARD:FindFirstChild("ITEM_IMAGE", true);

    if ITEM_IMAGE and ITEM_IMAGE:IsA("ImageLabel") then
        if v70 then
            v70 = v70.Icon;
        end;

        if v70 then
            if not string.find(v70, "rbxassetid://", 1, true) then
                v70 = `rbxassetid://{v70}`;
            end;

            ITEM_IMAGE.Image = v70;
        end;

        ITEM_IMAGE.ImageColor3 = Color3_fromRGB_ret2;
    end;

    local OBTAINED_IMAGE = ITEM_REWARD:FindFirstChild("OBTAINED_IMAGE", true);

    if OBTAINED_IMAGE and OBTAINED_IMAGE:IsA("GuiObject") then
        OBTAINED_IMAGE.Visible = v63;
    end;

    local Cover = ITEM_REWARD:FindFirstChild("Cover", true);

    if Cover and Cover:IsA("GuiObject") then
        Cover.Visible = v63;
    end;

    local CLAIM_BUTTON = ITEM_REWARD:FindFirstChild("CLAIM_BUTTON", true);

    if CLAIM_BUTTON and CLAIM_BUTTON:IsA("GuiObject") then
        CLAIM_BUTTON.Visible = v67;
    end;

    local v71;

    if v67 then
        v71 = UDim2_fromScale_ret;
    else
        v71 = Position;
    end;

    ITEM_NAME.Position = v71;

    if v63 then
        local ITEM_NAME2 = ITEM_REWARD:FindFirstChild("ITEM_NAME", true);

        if ITEM_NAME2 and ITEM_NAME2:IsA("TextLabel") then
            ITEM_NAME2.Text = "";
            ITEM_NAME2.Visible = true;
            local ITEM_NAME_SHADOW = ITEM_NAME2:FindFirstChild("ITEM_NAME_SHADOW", true);

            if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
                ITEM_NAME_SHADOW.Text = "";
                ITEM_NAME_SHADOW.Visible = true;
            end;
        end;
    elseif v64 then
        local ITEM_NAME2 = ITEM_REWARD:FindFirstChild("ITEM_NAME", true);

        if ITEM_NAME2 and ITEM_NAME2:IsA("TextLabel") then
            ITEM_NAME2.Text = "Ready to Claim!";
            ITEM_NAME2.Visible = true;
            local ITEM_NAME_SHADOW = ITEM_NAME2:FindFirstChild("ITEM_NAME_SHADOW", true);

            if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
                ITEM_NAME_SHADOW.Text = "Ready to Claim!";
                ITEM_NAME_SHADOW.Visible = true;
            end;
        end;
    else
        local ITEM_NAME2 = ITEM_REWARD:FindFirstChild("ITEM_NAME", true);

        if ITEM_NAME2 and ITEM_NAME2:IsA("TextLabel") then
            ITEM_NAME2.Text = v69;
            ITEM_NAME2.Visible = true;
            local ITEM_NAME_SHADOW = ITEM_NAME2:FindFirstChild("ITEM_NAME_SHADOW", true);

            if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
                ITEM_NAME_SHADOW.Text = v69;
                ITEM_NAME_SHADOW.Visible = true;
            end;
        end;
    end;

    ITEM_REWARD:SetAttribute("RewardDisplayName", v69);
end;

local function Render() -- Line: 384
    -- upvalues: GetCompletion (copy), PROGRESS (copy), PROGRESS_SHADOW (copy), Bar_Actual (copy), GetAllIndexItems (copy), u5 (copy), SetItemFrameState (copy), DataService (copy), SetRewardState (copy)
    local v72, v73, v74 = GetCompletion();
    local v75 = `{v72} / {v73} Discovered ({math.floor(v74 * 100 + 0.5)}%)`;
    PROGRESS.Text = v75;
    PROGRESS_SHADOW.Text = v75;
    Bar_Actual.Size = UDim2.fromScale(v74, 1);

    for _, v in GetAllIndexItems() do
        local v76 = v.Key or `{v.Type}:{v.Value}`;
        local v77 = u5[tostring(v76)];

        if v77 then
            local Data = DataService:GetData();

            if Data then
                Data = Data.FallMarketIndexData;
            end;

            if Data then
                Data = Data.Discovered;
            end;

            local v78;

            if type(Data) == "table" then
                local v79 = v.Key or `{v.Type}:{v.Value}`;
                v78 = Data[tostring(v79)] == true;
            else
                v78 = false;
            end;

            SetItemFrameState(v77, v, v78);
        end;
    end;

    SetRewardState();
end;

local function RequestServerRefresh() -- Line: 406
    -- upvalues: RefreshIndex (copy)
    local success2, result2 = pcall(function() -- Line: 407
        -- upvalues: RefreshIndex (ref)
        return RefreshIndex:InvokeServer();
    end);

    if not success2 then
        warn("FallMarketIndexController: failed to refresh index:", result2);
    end;
end;

local function QueueServerRefresh() -- Line: 416
    -- upvalues: u6 (ref), RefreshIndex (copy), Render (copy)
    if u6 then
        return;
    end;

    u6 = true;
    task.defer(function() -- Line: 423
        -- upvalues: u6 (ref), RefreshIndex (ref), Render (ref)
        u6 = false;
        local success2, result2 = pcall(function() -- Line: 407
            -- upvalues: RefreshIndex (ref)
            return RefreshIndex:InvokeServer();
        end);

        if not success2 then
            warn("FallMarketIndexController: failed to refresh index:", result2);
        end;

        Render();
    end);
end;

local function ClearBuiltList() -- Line: 430
    -- upvalues: ScrollingFrame (copy), CATEGORY_TEMPLATE (copy), CATEGORY_HOLDER_TEMPLATE (copy), u5 (copy)
    for _, child in ScrollingFrame:GetChildren() do
        if child ~= CATEGORY_TEMPLATE and (child ~= CATEGORY_HOLDER_TEMPLATE and child:IsA("GuiObject")) then
            child:Destroy();
        end;
    end;

    table.clear(u5);
end;

local function HighlightDescriptionPercent() -- Line: 440
    -- upvalues: DESCRIPTION (copy)
    if DESCRIPTION:GetAttribute("_PercentHighlighted") then
        return;
    end;

    local string_gsub_ret, v80 = string.gsub(DESCRIPTION.Text, "(%d+%%)", "<font color=\"#FFC21E\">%1</font>", 1);

    if v80 > 0 then
        DESCRIPTION.RichText = true;
        DESCRIPTION.Text = string_gsub_ret;
        DESCRIPTION:SetAttribute("_PercentHighlighted", true);
    end;
end;

local function Build() -- Line: 459
    -- upvalues: u7 (ref), DESCRIPTION (copy), CATEGORY_TEMPLATE (copy), CATEGORY_HOLDER_TEMPLATE (copy), ITEM_TEMPLATE (copy), ClearBuiltList (copy), GameConfigController (copy), Render (copy), ScrollingFrame (copy), u3 (copy), ItemRarityFinder (copy), u5 (copy)
    if u7 then
        return;
    end;

    u7 = true;

    if not DESCRIPTION:GetAttribute("_PercentHighlighted") then
        local string_gsub_ret, v81 = string.gsub(DESCRIPTION.Text, "(%d+%%)", "<font color=\"#FFC21E\">%1</font>", 1);

        if v81 > 0 then
            DESCRIPTION.RichText = true;
            DESCRIPTION.Text = string_gsub_ret;
            DESCRIPTION:SetAttribute("_PercentHighlighted", true);
        end;
    end;

    CATEGORY_TEMPLATE.Visible = false;
    CATEGORY_HOLDER_TEMPLATE.Visible = false;
    ITEM_TEMPLATE.Visible = false;
    ClearBuiltList();
    local v82 = 0;
    local Config = GameConfigController:GetConfig("FallMarketIndexConfig");
    local Categories = (type(Config) == "table" and Config and Config or {}).Categories;

    if type(Categories) ~= "table" then
        Render();

        return;
    end;

    for _, v in Categories do
        if type(v) == "table" and type(v.Items) == "table" then
            local v83 = v82 + 1;
            local v84 = tostring(v.Name);
            local v85 = CATEGORY_TEMPLATE:Clone();
            v85.Name = `{v84}_Header`;
            v85.Visible = true;
            v85.LayoutOrder = v83;
            local Title = v85:FindFirstChild("Title", true);

            if Title and Title:IsA("TextLabel") then
                Title.Text = v84;
                local Title_Shadow = Title:FindFirstChild("Title_Shadow");

                if Title_Shadow and Title_Shadow:IsA("TextLabel") then
                    Title_Shadow.Text = v84;
                end;
            end;

            v85.Parent = ScrollingFrame;
            v82 = v83 + 1;
            local v86 = CATEGORY_HOLDER_TEMPLATE:Clone();
            v86.Name = `{v84}_Holder`;
            v86.Visible = true;
            v86.LayoutOrder = v82;
            v86.Parent = ScrollingFrame;
            local ITEM_TEMPLATE2 = v86:FindFirstChild("ITEM_TEMPLATE");

            if ITEM_TEMPLATE2 and ITEM_TEMPLATE2:IsA("GuiObject") then
                ITEM_TEMPLATE2.Visible = false;
            end;

            local v87 = {};

            for i, v2 in v.Items do
                local v88 = {
                    Config = v2,
                    Order = i
                };
                local Rarity = v2.Rarity;
                local v89;

                if Rarity then
                    v89 = Rarity;
                else
                    local v90;
                    v90, v89 = pcall(function() -- Line: 147
                        -- upvalues: ItemRarityFinder (ref), v2 (copy)
                        return ItemRarityFinder(tostring(v2.Value or ""), (tostring(v2.Type or "")));
                    end);

                    if not v90 then
                        v89 = Rarity;
                    end;
                end;

                v88.Rank = u3[tostring(v89)] or (1 / 0);
                table.insert(v87, v88);
            end;

            table.sort(v87, function(p91, p92) -- Line: 531
                if p91.Rank == p92.Rank then
                    return p91.Order < p92.Order;
                end;

                return p91.Rank < p92.Rank;
            end);

            for i, v2 in v87 do
                local Config2 = v2.Config;
                local v93 = Config2.Key or `{Config2.Type}:{Config2.Value}`;
                local v94 = tostring(v93);
                local v95 = ITEM_TEMPLATE:Clone();
                v95.Name = v94;
                v95.LayoutOrder = i;
                v95.Visible = true;
                v95.Parent = v86;
                u5[v94] = v95;
            end;
        end;
    end;

    Render();
end;

local function Rebuild() -- Line: 555
    -- upvalues: u7 (ref), Build (copy)
    u7 = false;
    Build();
end;

local function u104() -- Line: 560
    -- upvalues: DataService (copy), GetCompletion (copy), GameConfigController (copy), ClaimReward (copy), u6 (ref), RefreshIndex (copy), Render (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.FallMarketIndexData;
    end;

    local v96;

    if type(Data) == "table" then
        v96 = Data.RewardClaimed == true;
    else
        v96 = false;
    end;

    if v96 then
        return;
    end;

    local _, v97, v98 = GetCompletion();

    if v97 > 0 then
        local math_floor_ret = math.floor(v98 * 100 + 0.5);
        local Config = GameConfigController:GetConfig("FallMarketIndexConfig");
        local Reward = (type(Config) == "table" and Config and Config or {}).Reward;
        local v99 = type(Reward) == "table" and Reward and Reward or {};
        local v100 = (tonumber(v99.RequiredCompletion) or 0.8) * 100 + 0.5;

        if math.floor(v100) <= math_floor_ret then
            local v101, v102, v103 = pcall(function() -- Line: 571
                -- upvalues: ClaimReward (ref)
                return ClaimReward:InvokeServer();
            end);

            if not v101 then
                warn("FallMarketIndexController: failed to claim reward:", v102);

                return;
            end;

            if not v102 and v103 then
                warn("FallMarketIndexController:", v103);
            end;

            if u6 then
                return;
            end;

            u6 = true;
            task.defer(function() -- Line: 423
                -- upvalues: u6 (ref), RefreshIndex (ref), Render (ref)
                u6 = false;
                local success2, result2 = pcall(function() -- Line: 407
                    -- upvalues: RefreshIndex (ref)
                    return RefreshIndex:InvokeServer();
                end);

                if not success2 then
                    warn("FallMarketIndexController: failed to refresh index:", result2);
                end;

                Render();
            end);
        end;
    end;
end;

local function HookRewardButton() -- Line: 587
    -- upvalues: ITEM_REWARD (copy), SetupButton (copy), u104 (copy)
    local CLAIM_BUTTON = ITEM_REWARD:FindFirstChild("CLAIM_BUTTON", true);

    if not CLAIM_BUTTON then
        return;
    end;

    local SENSOR = CLAIM_BUTTON:FindFirstChild("SENSOR");

    if not (SENSOR and SENSOR:IsA("GuiButton")) then
        return;
    end;

    if SENSOR:GetAttribute("_FallMarketIndexHooked") then
        return;
    end;

    SENSOR:SetAttribute("_FallMarketIndexHooked", true);
    SetupButton({
        legacy = true,
        offset = 0.05,
        instance = SENSOR,
        scale = SENSOR:FindFirstChildOfClass("UIScale"),
        onclick = u104
    });
end;

local u105 = false;

local function HookGuiController() -- Line: 615
    -- upvalues: u105 (ref), GuiController (copy), FallMarketIndexUI (copy), Panel (copy), Build (copy), HookRewardButton (copy), RefreshIndex (copy), Render (copy)
    if u105 then
        return;
    end;

    u105 = true;
    GuiController:UsePopupAnims(FallMarketIndexUI);
    local Close = Panel:FindFirstChild("Close", true);

    if Close and Close:IsA("GuiButton") then
        Close.Activated:Connect(function() -- Line: 626
            -- upvalues: GuiController (ref), FallMarketIndexUI (ref)
            GuiController:Close(FallMarketIndexUI);
        end);
    end;

    GuiController:GetStateForGui(FallMarketIndexUI).Visible:Observe(function(p106: boolean) -- Line: 632
        -- upvalues: Build (ref), HookRewardButton (ref), RefreshIndex (ref), Render (ref)
        if not p106 then
            return;
        end;

        Build();
        HookRewardButton();
        local success2, result2 = pcall(function() -- Line: 407
            -- upvalues: RefreshIndex (ref)
            return RefreshIndex:InvokeServer();
        end);

        if not success2 then
            warn("FallMarketIndexController: failed to refresh index:", result2);
        end;

        Render();
    end);
end;

local function ConnectDataSignal(u107: string, p108: any) -- Line: 645
    -- upvalues: DataService (copy)
    local success2, result2 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u107 (copy)
        return DataService:GetPathSignal(u107);
    end);

    if success2 and result2 then
        result2:Connect(p108);
    end;
end;

function u2.IsRewardReady() -- Line: 655
    -- upvalues: u8 (ref)
    return u8;
end;

function u2.Open() -- Line: 659
    -- upvalues: GuiController (copy), FallMarketIndexUI (copy)
    GuiController:Open(FallMarketIndexUI);
end;

function u2.Start() -- Line: 663
    -- upvalues: Build (copy), HookRewardButton (copy), HookGuiController (copy), RefreshIndex (copy), Render (copy), DataService (copy), QueueServerRefresh (copy), Rebuild (copy), CollectionService (copy), u8 (ref)
    Build();
    HookRewardButton();
    HookGuiController();
    local success2, result2 = pcall(function() -- Line: 407
        -- upvalues: RefreshIndex (ref)
        return RefreshIndex:InvokeServer();
    end);

    if not success2 then
        warn("FallMarketIndexController: failed to refresh index:", result2);
    end;

    Render();
    local v109 = Render;
    local u110 = "FallMarketIndexData";
    local success3, result3 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u110 (copy)
        return DataService:GetPathSignal(u110);
    end);

    if success3 and result3 then
        result3:Connect(v109);
    end;

    local v111 = Render;
    local u112 = "FallMarketIndexData/Discovered";
    local success4, result4 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u112 (copy)
        return DataService:GetPathSignal(u112);
    end);

    if success4 and result4 then
        result4:Connect(v111);
    end;

    local v113 = Render;
    local u114 = "FallMarketIndexData/RewardClaimed";
    local success5, result5 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u114 (copy)
        return DataService:GetPathSignal(u114);
    end);

    if success5 and result5 then
        result5:Connect(v113);
    end;

    local v115 = QueueServerRefresh;
    local u116 = "InventoryData";
    local success6, result6 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u116 (copy)
        return DataService:GetPathSignal(u116);
    end);

    if success6 and result6 then
        result6:Connect(v115);
    end;

    local v117 = QueueServerRefresh;
    local u118 = "InventoryData/@";
    local success7, result7 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u118 (copy)
        return DataService:GetPathSignal(u118);
    end);

    if success7 and result7 then
        result7:Connect(v117);
    end;

    local v119 = QueueServerRefresh;
    local u120 = "PetsData/PetInventory/Data";
    local success8, result8 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u120 (copy)
        return DataService:GetPathSignal(u120);
    end);

    if success8 and result8 then
        result8:Connect(v119);
    end;

    local v121 = QueueServerRefresh;
    local u122 = "PetsData/PetInventory/Data/@";
    local success9, result9 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u122 (copy)
        return DataService:GetPathSignal(u122);
    end);

    if success9 and result9 then
        result9:Connect(v121);
    end;

    local v123 = QueueServerRefresh;
    local u124 = "CosmeticData/Inventory";
    local success10, result10 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u124 (copy)
        return DataService:GetPathSignal(u124);
    end);

    if success10 and result10 then
        result10:Connect(v123);
    end;

    local v125 = QueueServerRefresh;
    local u126 = "CosmeticData/Inventory/@";
    local success11, result11 = pcall(function() -- Line: 646
        -- upvalues: DataService (ref), u126 (copy)
        return DataService:GetPathSignal(u126);
    end);

    if success11 and result11 then
        result11:Connect(v125);
    end;

    workspace:GetAttributeChangedSignal("FallMarketIndexConfig"):Connect(Rebuild);
    CollectionService:GetInstanceAddedSignal("FallMarketCollectionReady"):Connect(function(p127) -- Line: 687
        -- upvalues: u8 (ref)
        local v128 = u8;

        if p127:IsA("TextLabel") then
            p127.Text = v128 and "Ready!" or "";
        end;
    end);
end;

EventRotationClientBinder:Bind({
    EventSet = "FallMarketEvent",
    MinPartIndex = 3,
    Script = script,

    OnStart = function() -- Line: 696, Name: OnStart
        -- upvalues: u2 (copy)
        task.spawn(u2.Start);
    end,

    OnStop = function() -- Line: 697, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u2;