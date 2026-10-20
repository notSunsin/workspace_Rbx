-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local ShovelSkinRegistry = require(ReplicatedStorage.Data.ShovelSkinRegistry);
local Item_Module = require(ReplicatedStorage.Item_Module);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local script_SummerIndexConfig = require(script.SummerIndexConfig);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local LocalPlayer = Players.LocalPlayer;
local SummerIndexUI = LocalPlayer.PlayerGui.SummerIndexUI;
local Panel = SummerIndexUI.Panel;
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
local SummerIndexService = ReplicatedStorage.GameEvents:WaitForChild("SummerIndexService");
local RefreshIndex = SummerIndexService:WaitForChild("RefreshIndex");
local ClaimReward = SummerIndexService:WaitForChild("ClaimReward");
local u2 = {};
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

local function GetItemKey(p8) -- Line: 70
    local v9 = p8.Key or `{p8.Type}:{p8.Value}`;

    return tostring(v9);
end;

local function SeedAwareName(p10: string, p11: string) -- Line: 74
    if p11 == "Seed" and not string.match(p10, "%sSeed$") then
        return `{p10} Seed`;
    end;

    return p10;
end;

local function GetItemDisplayName(p12) -- Line: 82
    if p12.DisplayName then
        return tostring(p12.DisplayName);
    end;

    local v13 = tostring(p12.Value or "Unknown");

    if tostring(p12.Type or "") == "Seed" and not string.match(v13, "%sSeed$") then
        return `{v13} Seed`;
    end;

    return v13;
end;

local function GetItemRarity(u14) -- Line: 90
    -- upvalues: ItemRarityFinder (copy)
    local Rarity = u14.Rarity;
    local v15;

    if Rarity then
        v15 = Rarity;
    else
        local v16;
        v16, v15 = pcall(function() -- Line: 94
            -- upvalues: ItemRarityFinder (ref), u14 (copy)
            return ItemRarityFinder(tostring(u14.Value or ""), (tostring(u14.Type or "")));
        end);

        if not v16 then
            v15 = Rarity;
        end;
    end;

    return v15;
end;

local function GetItemRarityRank(u17) -- Line: 109
    -- upvalues: u3 (copy), ItemRarityFinder (copy)
    local Rarity = u17.Rarity;
    local v18;

    if Rarity then
        v18 = Rarity;
    else
        local v19;
        v19, v18 = pcall(function() -- Line: 94
            -- upvalues: ItemRarityFinder (ref), u17 (copy)
            return ItemRarityFinder(tostring(u17.Value or ""), (tostring(u17.Type or "")));
        end);

        if not v19 then
            v18 = Rarity;
        end;
    end;

    return u3[tostring(v18)] or (1 / 0);
end;

local function GetItemRarityColor(u20) -- Line: 113
    -- upvalues: ItemRarityFinder (copy), Item_Module (copy)
    local Rarity = u20.Rarity;
    local v21;

    if Rarity then
        v21 = Rarity;
    else
        local v22;
        v22, v21 = pcall(function() -- Line: 94
            -- upvalues: ItemRarityFinder (ref), u20 (copy)
            return ItemRarityFinder(tostring(u20.Value or ""), (tostring(u20.Type or "")));
        end);

        if not v22 then
            v21 = Rarity;
        end;
    end;

    if not v21 then
        return nil;
    end;

    local v23 = Item_Module.Return_Rarity_Data((tostring(v21)));

    if v23 then
        v23 = v23[2];
    end;

    return v23;
end;

local function ApplyWrapperRarityColor(p24: userdata, u25: any) -- Line: 124
    -- upvalues: ItemRarityFinder (copy), GGStaticData (copy), Item_Module (copy)
    local Rarity = u25.Rarity;
    local v26;

    if Rarity then
        v26 = Rarity;
    else
        local v27;
        v27, v26 = pcall(function() -- Line: 94
            -- upvalues: ItemRarityFinder (ref), u25 (copy)
            return ItemRarityFinder(tostring(u25.Value or ""), (tostring(u25.Type or "")));
        end);

        if not v27 then
            v26 = Rarity;
        end;
    end;

    local v28 = v26 and tostring(v26) or nil;

    if v28 and GGStaticData.AnimatedColors[v28] then
        p24:SetAttribute("Rarity", v28);

        if p24:GetAttribute("_SummerIndexAnimatedRarity") ~= v28 then
            p24:SetAttribute("_SummerIndexAnimatedRarity", v28);
            GGStaticData.AnimatedColors[v28](p24);
        end;

        return;
    end;

    p24:SetAttribute("Rarity", v28 or "");
    p24:SetAttribute("_SummerIndexAnimatedRarity", nil);
    local Rarity2 = u25.Rarity;
    local v29;

    if Rarity2 then
        v29 = Rarity2;
    else
        local v30;
        v30, v29 = pcall(function() -- Line: 94
            -- upvalues: ItemRarityFinder (ref), u25 (copy)
            return ItemRarityFinder(tostring(u25.Value or ""), (tostring(u25.Type or "")));
        end);

        if not v30 then
            v29 = Rarity2;
        end;
    end;

    local v31;

    if v29 then
        v31 = Item_Module.Return_Rarity_Data((tostring(v29)));

        if v31 then
            v31 = v31[2];
        end;
    else
        v31 = nil;
    end;

    if v31 then
        p24.BackgroundColor3 = v31;
    end;
end;

local function GetItemImage(p32) -- Line: 148
    -- upvalues: ItemImageFinder (copy)
    if not p32.Icon then
        return ItemImageFinder(tostring(p32.Value or ""), (tostring(p32.Type or "")));
    end;

    local v33 = tostring(p32.Icon);

    if string.find(v33, "rbxassetid://", 1, true) then
        return v33;
    end;

    return `rbxassetid://{v33}`;
end;

local function SetNameAndShadow(p34: userdata, p35: string) -- Line: 162
    local ITEM_NAME = p34:FindFirstChild("ITEM_NAME", true);

    if ITEM_NAME and ITEM_NAME:IsA("TextLabel") then
        ITEM_NAME.Text = p35;
        local ITEM_NAME_SHADOW = ITEM_NAME:FindFirstChild("ITEM_NAME_SHADOW", true);

        if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
            ITEM_NAME_SHADOW.Text = p35;
        end;
    end;
end;

local function SetRewardName(p36: string, p37: boolean) -- Line: 174
    -- upvalues: ITEM_REWARD (copy)
    local ITEM_NAME = ITEM_REWARD:FindFirstChild("ITEM_NAME", true);

    if ITEM_NAME and ITEM_NAME:IsA("TextLabel") then
        ITEM_NAME.Text = p36;
        ITEM_NAME.Visible = p37;
        local ITEM_NAME_SHADOW = ITEM_NAME:FindFirstChild("ITEM_NAME_SHADOW", true);

        if ITEM_NAME_SHADOW and ITEM_NAME_SHADOW:IsA("TextLabel") then
            ITEM_NAME_SHADOW.Text = p36;
            ITEM_NAME_SHADOW.Visible = p37;
        end;
    end;
end;

local function SetItemFrameState(p38: userdata, p39: any, p40: boolean) -- Line: 188
    -- upvalues: ApplyWrapperRarityColor (copy), SetNameAndShadow (copy), GetItemImage (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy)
    local Wrapper = p38:FindFirstChild("Wrapper");

    if not Wrapper then
        return;
    end;

    if Wrapper:IsA("GuiObject") then
        ApplyWrapperRarityColor(Wrapper, p39);
    end;

    local v41;

    if p40 then
        if p39.DisplayName then
            v41 = tostring(p39.DisplayName);
        else
            v41 = tostring(p39.Value or "Unknown");

            if tostring(p39.Type or "") == "Seed" and not string.match(v41, "%sSeed$") then
                v41 = `{v41} Seed`;
            end;
        end;
    else
        v41 = "";
    end;

    SetNameAndShadow(Wrapper, v41);
    local ITEM_IMAGE = Wrapper:FindFirstChild("ITEM_IMAGE");

    if ITEM_IMAGE and ITEM_IMAGE:IsA("ImageLabel") then
        ITEM_IMAGE.Image = GetItemImage(p39);
        local v42;

        if p40 then
            v42 = Color3_fromRGB_ret2;
        else
            v42 = Color3_fromRGB_ret;
        end;

        ITEM_IMAGE.ImageColor3 = v42;
    end;

    local OBTAINED_IMAGE = Wrapper:FindFirstChild("OBTAINED_IMAGE");

    if OBTAINED_IMAGE and OBTAINED_IMAGE:IsA("GuiObject") then
        OBTAINED_IMAGE.Visible = p40;
    end;

    local Cover = Wrapper:FindFirstChild("Cover");

    if Cover and Cover:IsA("GuiObject") then
        Cover.Visible = not p40;
    end;
end;

local function GetAllIndexItems() -- Line: 217
    -- upvalues: script_SummerIndexConfig (copy)
    local v43 = {};

    for _, v in script_SummerIndexConfig.Categories do
        for _, v2 in v.Items do
            table.insert(v43, v2);
        end;
    end;

    return v43;
end;

local function GetIndexData() -- Line: 229
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerIndexData;
    end;

    return Data;
end;

local function IsItemDiscovered(p44) -- Line: 234
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerIndexData;
    end;

    if Data then
        Data = Data.Discovered;
    end;

    if type(Data) ~= "table" then
        return false;
    end;

    local v45 = p44.Key or `{p44.Type}:{p44.Value}`;

    return Data[tostring(v45)] == true;
end;

local function GetCompletion() -- Line: 245
    -- upvalues: GetAllIndexItems (copy), DataService (copy)
    local v46 = 0;
    local v47 = 0;

    for _, v in GetAllIndexItems() do
        v46 = v46 + 1;
        local Data = DataService:GetData();

        if Data then
            Data = Data.SummerIndexData;
        end;

        if Data then
            Data = Data.Discovered;
        end;

        local v48;

        if type(Data) == "table" then
            local v49 = v.Key or `{v.Type}:{v.Value}`;
            v48 = Data[tostring(v49)] == true;
        else
            v48 = false;
        end;

        if v48 then
            v47 = v47 + 1;
        end;
    end;

    return v47, v46, v46 <= 0 and 0 or math.clamp(v47 / v46, 0, 1);
end;

local function IsRewardClaimed() -- Line: 262
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerIndexData;
    end;

    local v50;

    if type(Data) == "table" then
        v50 = Data.RewardClaimed == true;
    else
        v50 = false;
    end;

    return v50;
end;

local function UpdateCampfireCollectionReadyLabels(p51: boolean) -- Line: 268
    -- upvalues: CollectionService (copy)
    local v52 = p51 and "Ready!" or "";

    for _, v in CollectionService:GetTagged("CampfireCollectionReady") do
        if v:IsA("TextLabel") then
            v.Text = v52;
        end;
    end;
end;

local function SetRewardState() -- Line: 278
    -- upvalues: GetCompletion (copy), script_SummerIndexConfig (copy), DataService (copy), UpdateCampfireCollectionReadyLabels (copy), ShovelSkinRegistry (copy), ITEM_REWARD (copy), Color3_fromRGB_ret2 (copy), SetRewardName (copy)
    local _, _, v53 = GetCompletion();
    local v54 = tonumber(script_SummerIndexConfig.Reward.RequiredCompletion) or 0.8;
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerIndexData;
    end;

    local v55;

    if type(Data) == "table" then
        v55 = Data.RewardClaimed == true;
    else
        v55 = false;
    end;

    local v56 = v54 <= v53;
    local v57;

    if v56 then
        v57 = not v55;
    else
        v57 = v56;
    end;

    UpdateCampfireCollectionReadyLabels(v57);
    local v58 = tostring(script_SummerIndexConfig.Reward.DisplayName or "Campfire Shovel");
    local v59 = ShovelSkinRegistry[tostring(script_SummerIndexConfig.Reward.ShovelSkin or "Campfire")];
    local ITEM_IMAGE = ITEM_REWARD:FindFirstChild("ITEM_IMAGE", true);

    if ITEM_IMAGE and ITEM_IMAGE:IsA("ImageLabel") then
        if v59 then
            v59 = v59.Icon;
        end;

        if v59 then
            ITEM_IMAGE.Image = string.find(v59, "rbxassetid://", 1, true) and v59 and v59 or `rbxassetid://{v59}`;
        end;

        ITEM_IMAGE.ImageColor3 = Color3_fromRGB_ret2;
    end;

    local OBTAINED_IMAGE = ITEM_REWARD:FindFirstChild("OBTAINED_IMAGE", true);

    if OBTAINED_IMAGE and OBTAINED_IMAGE:IsA("GuiObject") then
        OBTAINED_IMAGE.Visible = v55;
    end;

    local Cover = ITEM_REWARD:FindFirstChild("Cover", true);

    if Cover and Cover:IsA("GuiObject") then
        Cover.Visible = v55;
    end;

    local CLAIM_BUTTON = ITEM_REWARD:FindFirstChild("CLAIM_BUTTON", true);

    if CLAIM_BUTTON and CLAIM_BUTTON:IsA("GuiObject") then
        local v60;

        if v56 then
            v60 = not v55;
        else
            v60 = v56;
        end;

        CLAIM_BUTTON.Visible = v60;
    end;

    if v55 then
        SetRewardName("", true);
    elseif v56 then
        SetRewardName("", false);
    else
        SetRewardName(v58, true);
    end;

    ITEM_REWARD:SetAttribute("RewardDisplayName", v58);
end;

local function Render() -- Line: 326
    -- upvalues: GetCompletion (copy), PROGRESS (copy), PROGRESS_SHADOW (copy), Bar_Actual (copy), GetAllIndexItems (copy), u5 (copy), SetItemFrameState (copy), DataService (copy), SetRewardState (copy)
    local v61, v62, v63 = GetCompletion();
    local v64 = `{v61} / {v62} Discovered ({math.floor(v63 * 100 + 0.5)}%)`;
    PROGRESS.Text = v64;
    PROGRESS_SHADOW.Text = v64;
    Bar_Actual.Size = UDim2.fromScale(v63, 1);

    for _, v in GetAllIndexItems() do
        local v65 = v.Key or `{v.Type}:{v.Value}`;
        local v66 = u5[tostring(v65)];

        if v66 then
            local Data = DataService:GetData();

            if Data then
                Data = Data.SummerIndexData;
            end;

            if Data then
                Data = Data.Discovered;
            end;

            local v67;

            if type(Data) == "table" then
                local v68 = v.Key or `{v.Type}:{v.Value}`;
                v67 = Data[tostring(v68)] == true;
            else
                v67 = false;
            end;

            SetItemFrameState(v66, v, v67);
        end;
    end;

    SetRewardState();
end;

local function RequestServerRefresh() -- Line: 349
    -- upvalues: RefreshIndex (copy)
    local success2, result2 = pcall(function() -- Line: 350
        -- upvalues: RefreshIndex (ref)
        return RefreshIndex:InvokeServer();
    end);

    if not success2 then
        warn("SummerIndexController: failed to refresh index:", result2);
    end;
end;

local function QueueServerRefresh() -- Line: 359
    -- upvalues: u6 (ref), RefreshIndex (copy), Render (copy)
    if u6 then
        return;
    end;

    u6 = true;
    task.defer(function() -- Line: 366
        -- upvalues: u6 (ref), RefreshIndex (ref), Render (ref)
        u6 = false;
        local success2, result2 = pcall(function() -- Line: 350
            -- upvalues: RefreshIndex (ref)
            return RefreshIndex:InvokeServer();
        end);

        if not success2 then
            warn("SummerIndexController: failed to refresh index:", result2);
        end;

        Render();
    end);
end;

local function ClearBuiltList() -- Line: 373
    -- upvalues: ScrollingFrame (copy), CATEGORY_TEMPLATE (copy), CATEGORY_HOLDER_TEMPLATE (copy), u5 (copy)
    for _, child in ScrollingFrame:GetChildren() do
        if child ~= CATEGORY_TEMPLATE and (child ~= CATEGORY_HOLDER_TEMPLATE and child:IsA("GuiObject")) then
            child:Destroy();
        end;
    end;

    table.clear(u5);
end;

local function HighlightDescriptionPercent() -- Line: 385
    -- upvalues: DESCRIPTION (copy)
    if DESCRIPTION:GetAttribute("_PercentHighlighted") then
        return;
    end;

    local string_gsub_ret, v69 = string.gsub(DESCRIPTION.Text, "(%d+%%)", "<font color=\"#FFC21E\">%1</font>", 1);

    if v69 > 0 then
        DESCRIPTION.RichText = true;
        DESCRIPTION.Text = string_gsub_ret;
        DESCRIPTION:SetAttribute("_PercentHighlighted", true);
    end;
end;

local function Build() -- Line: 404
    -- upvalues: u7 (ref), DESCRIPTION (copy), CATEGORY_TEMPLATE (copy), CATEGORY_HOLDER_TEMPLATE (copy), ITEM_TEMPLATE (copy), ClearBuiltList (copy), script_SummerIndexConfig (copy), ScrollingFrame (copy), u3 (copy), ItemRarityFinder (copy), u5 (copy), Render (copy)
    if u7 then
        return;
    end;

    u7 = true;

    if not DESCRIPTION:GetAttribute("_PercentHighlighted") then
        local string_gsub_ret, v70 = string.gsub(DESCRIPTION.Text, "(%d+%%)", "<font color=\"#FFC21E\">%1</font>", 1);

        if v70 > 0 then
            DESCRIPTION.RichText = true;
            DESCRIPTION.Text = string_gsub_ret;
            DESCRIPTION:SetAttribute("_PercentHighlighted", true);
        end;
    end;

    CATEGORY_TEMPLATE.Visible = false;
    CATEGORY_HOLDER_TEMPLATE.Visible = false;
    ITEM_TEMPLATE.Visible = false;
    ClearBuiltList();
    local v71 = 0;

    for _, v in script_SummerIndexConfig.Categories do
        local v72 = v71 + 1;
        local v73 = CATEGORY_TEMPLATE:Clone();
        v73.Name = `{v.Name}_Header`;
        v73.Visible = true;
        v73.LayoutOrder = v72;
        local Title = v73:FindFirstChild("Title", true);

        if Title and Title:IsA("TextLabel") then
            local v74 = tostring(v.Name);
            Title.Text = v74;
            local Title_Shadow = Title:FindFirstChild("Title_Shadow");

            if Title_Shadow and Title_Shadow:IsA("TextLabel") then
                Title_Shadow.Text = v74;
            end;
        end;

        v73.Parent = ScrollingFrame;
        v71 = v72 + 1;
        local v75 = CATEGORY_HOLDER_TEMPLATE:Clone();
        v75.Name = `{v.Name}_Holder`;
        v75.Visible = true;
        v75.LayoutOrder = v71;
        v75.Parent = ScrollingFrame;
        local ITEM_TEMPLATE2 = v75:FindFirstChild("ITEM_TEMPLATE");

        if ITEM_TEMPLATE2 and ITEM_TEMPLATE2:IsA("GuiObject") then
            ITEM_TEMPLATE2.Visible = false;
        end;

        local v76 = {};

        for i, v2 in v.Items do
            local v77 = {
                Config = v2,
                Order = i
            };
            local Rarity = v2.Rarity;
            local v78;

            if Rarity then
                v78 = Rarity;
            else
                local v79;
                v79, v78 = pcall(function() -- Line: 94
                    -- upvalues: ItemRarityFinder (ref), v2 (copy)
                    return ItemRarityFinder(tostring(v2.Value or ""), (tostring(v2.Type or "")));
                end);

                if not v79 then
                    v78 = Rarity;
                end;
            end;

            v77.Rank = u3[tostring(v78)] or (1 / 0);
            table.insert(v76, v77);
        end;

        table.sort(v76, function(p80, p81) -- Line: 466
            if p80.Rank == p81.Rank then
                return p80.Order < p81.Order;
            end;

            return p80.Rank < p81.Rank;
        end);

        for i, v2 in v76 do
            local Config = v2.Config;
            local v82 = ITEM_TEMPLATE:Clone();
            local v83 = Config.Key or `{Config.Type}:{Config.Value}`;
            v82.Name = tostring(v83);
            v82.LayoutOrder = i;
            v82.Visible = true;
            v82.Parent = v75;
            local v84 = Config.Key or `{Config.Type}:{Config.Value}`;
            u5[tostring(v84)] = v82;
        end;
    end;

    Render();
end;

local function u90() -- Line: 489
    -- upvalues: DataService (copy), GetCompletion (copy), script_SummerIndexConfig (copy), ClaimReward (copy), u6 (ref), RefreshIndex (copy), Render (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.SummerIndexData;
    end;

    local v85;

    if type(Data) == "table" then
        v85 = Data.RewardClaimed == true;
    else
        v85 = false;
    end;

    if v85 then
        return;
    end;

    local _, _, v86 = GetCompletion();

    if v86 < (tonumber(script_SummerIndexConfig.Reward.RequiredCompletion) or 0.8) then
        return;
    end;

    local v87, v88, v89 = pcall(function() -- Line: 501
        -- upvalues: ClaimReward (ref)
        return ClaimReward:InvokeServer();
    end);

    if not v87 then
        warn("SummerIndexController: failed to claim reward:", v88);

        return;
    end;

    if not v88 and v89 then
        warn("SummerIndexController:", v89);
    end;

    if u6 then
        return;
    end;

    u6 = true;
    task.defer(function() -- Line: 366
        -- upvalues: u6 (ref), RefreshIndex (ref), Render (ref)
        u6 = false;
        local success2, result2 = pcall(function() -- Line: 350
            -- upvalues: RefreshIndex (ref)
            return RefreshIndex:InvokeServer();
        end);

        if not success2 then
            warn("SummerIndexController: failed to refresh index:", result2);
        end;

        Render();
    end);
end;

local function HookRewardButton() -- Line: 517
    -- upvalues: ITEM_REWARD (copy), SetupButton (copy), u90 (copy)
    local CLAIM_BUTTON = ITEM_REWARD:FindFirstChild("CLAIM_BUTTON", true);

    if not CLAIM_BUTTON then
        return;
    end;

    local SENSOR = CLAIM_BUTTON:FindFirstChild("SENSOR");

    if not (SENSOR and SENSOR:IsA("GuiButton")) then
        return;
    end;

    if SENSOR:GetAttribute("_SummerIndexHooked") then
        return;
    end;

    SENSOR:SetAttribute("_SummerIndexHooked", true);
    SetupButton({
        legacy = true,
        offset = 0.05,
        instance = SENSOR,
        scale = SENSOR:FindFirstChildOfClass("UIScale"),
        onclick = u90
    });
end;

local u91 = false;

local function HookGuiController() -- Line: 545
    -- upvalues: u91 (ref), GuiController (copy), SummerIndexUI (copy), Panel (copy), Build (copy), HookRewardButton (copy), RefreshIndex (copy), Render (copy)
    if u91 then
        return;
    end;

    u91 = true;
    GuiController:UsePopupAnims(SummerIndexUI);
    local Close = Panel:FindFirstChild("Close", true);

    if Close and Close:IsA("GuiButton") then
        Close.Activated:Connect(function() -- Line: 556
            -- upvalues: GuiController (ref), SummerIndexUI (ref)
            GuiController:Close(SummerIndexUI);
        end);
    end;

    GuiController:GetStateForGui(SummerIndexUI).Visible:Observe(function(p92: boolean) -- Line: 562
        -- upvalues: Build (ref), HookRewardButton (ref), RefreshIndex (ref), Render (ref)
        if not p92 then
            return;
        end;

        Build();
        HookRewardButton();
        local success2, result2 = pcall(function() -- Line: 350
            -- upvalues: RefreshIndex (ref)
            return RefreshIndex:InvokeServer();
        end);

        if not success2 then
            warn("SummerIndexController: failed to refresh index:", result2);
        end;

        Render();
    end);
end;

local function ConnectDataSignal(u93: string, p94: any) -- Line: 575
    -- upvalues: DataService (copy), u1 (copy)
    local success2, result2 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u93 (copy)
        return DataService:GetPathSignal(u93);
    end);

    if success2 and result2 then
        u1:Add((result2:Connect(p94)));
    end;
end;

local UserInputService = game:GetService("UserInputService");

function u2.Start() -- Line: 588
    -- upvalues: Build (copy), HookRewardButton (copy), HookGuiController (copy), RefreshIndex (copy), Render (copy), DataService (copy), u1 (copy), QueueServerRefresh (copy), LocalPlayer (copy), UserInputService (copy), GuiController (copy), SummerIndexUI (copy)
    Build();
    HookRewardButton();
    HookGuiController();
    local success2, result2 = pcall(function() -- Line: 350
        -- upvalues: RefreshIndex (ref)
        return RefreshIndex:InvokeServer();
    end);

    if not success2 then
        warn("SummerIndexController: failed to refresh index:", result2);
    end;

    Render();
    local v95 = Render;
    local u96 = "SummerIndexData";
    local success3, result3 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u96 (copy)
        return DataService:GetPathSignal(u96);
    end);

    if success3 and result3 then
        u1:Add((result3:Connect(v95)));
    end;

    local v97 = Render;
    local u98 = "SummerIndexData/Discovered";
    local success4, result4 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u98 (copy)
        return DataService:GetPathSignal(u98);
    end);

    if success4 and result4 then
        u1:Add((result4:Connect(v97)));
    end;

    local v99 = Render;
    local u100 = "SummerIndexData/RewardClaimed";
    local success5, result5 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u100 (copy)
        return DataService:GetPathSignal(u100);
    end);

    if success5 and result5 then
        u1:Add((result5:Connect(v99)));
    end;

    local v101 = QueueServerRefresh;
    local u102 = "InventoryData";
    local success6, result6 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u102 (copy)
        return DataService:GetPathSignal(u102);
    end);

    if success6 and result6 then
        u1:Add((result6:Connect(v101)));
    end;

    local v103 = QueueServerRefresh;
    local u104 = "InventoryData/@";
    local success7, result7 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u104 (copy)
        return DataService:GetPathSignal(u104);
    end);

    if success7 and result7 then
        u1:Add((result7:Connect(v103)));
    end;

    local v105 = QueueServerRefresh;
    local u106 = "PetsData/PetInventory/Data";
    local success8, result8 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u106 (copy)
        return DataService:GetPathSignal(u106);
    end);

    if success8 and result8 then
        u1:Add((result8:Connect(v105)));
    end;

    local v107 = QueueServerRefresh;
    local u108 = "PetsData/PetInventory/Data/@";
    local success9, result9 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u108 (copy)
        return DataService:GetPathSignal(u108);
    end);

    if success9 and result9 then
        u1:Add((result9:Connect(v107)));
    end;

    local v109 = QueueServerRefresh;
    local u110 = "CosmeticData/Inventory";
    local success10, result10 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u110 (copy)
        return DataService:GetPathSignal(u110);
    end);

    if success10 and result10 then
        u1:Add((result10:Connect(v109)));
    end;

    local v111 = QueueServerRefresh;
    local u112 = "CosmeticData/Inventory/@";
    local success11, result11 = pcall(function() -- Line: 576
        -- upvalues: DataService (ref), u112 (copy)
        return DataService:GetPathSignal(u112);
    end);

    if success11 and result11 then
        u1:Add((result11:Connect(v111)));
    end;

    Render();

    if LocalPlayer.Name == "Luaappp" then
        UserInputService.InputBegan:Connect(function(p113, p114) -- Line: 612
            -- upvalues: GuiController (ref), SummerIndexUI (ref)
            if p114 then
                return;
            end;

            if p113.KeyCode == Enum.KeyCode.V then
                GuiController:Open(SummerIndexUI);
            end;
        end);
    end;
end;

local u115 = false;
EventRotationController.EventUpdated:Connect(function(p116: string, p117: string) -- Line: 622, Name: OnEventUpdated
    -- upvalues: u1 (copy), u115 (ref), u2 (copy)
    if p117 ~= "CampfireEvent" then
        u1:Clean();
        u115 = false;

        return;
    end;

    if p116 ~= "CampfireEventPart4" then
        return;
    end;

    if u115 then
        return;
    end;

    u115 = true;
    u1:Clean();
    task.spawn(u2.Start);
end);

return u2;