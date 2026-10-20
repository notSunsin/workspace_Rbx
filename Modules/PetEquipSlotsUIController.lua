-- Decompiled with Potassium's decompiler.

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local TweenService = game:GetService("TweenService");
local PetEquipSlots_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetEquipSlots_UI");
local Main = PetEquipSlots_UI:WaitForChild("Main");
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local SellAllPets_RE = GameEvents:WaitForChild("SellAllPets_RE");
local SellPetShopSelected = GameEvents:WaitForChild("SellPetShopSelected");
local Favorite_Item_BE = GameEvents:WaitForChild("Favorite_Item_BE");
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local DataService = require(ReplicatedStorage.Modules.DataService);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetRarities = require(ReplicatedStorage.Data.PetRegistry.PetRarities);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local CalculatePetValue = require(ReplicatedStorage.Modules.CalculatePetValue);
require(ReplicatedStorage.Comma_Module);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local PetList = PetRegistry.PetList;
local TradeInButton = Main.Main.Holder.TradeInButton;
local Main2 = Main.Main.SellCosts.Main;
local TradeIn = TradeInButton.TradeIn;
local Confirm = TradeInButton.Confirm;
local Cancel = TradeInButton.Cancel;
local _ = Main2.Sell;
local _ = Main2.SellAll;
local REQUIRED_AGE = Main.Main.Holder.TextHolder.REQUIRED_AGE;
local Details = Main:WaitForChild("Details");
local SelectedPetWorth = Main.Main.SellCosts.Main.SelectedPetWorth;
local AllPetWorth = Main.Main.SellCosts.Main.AllPetWorth;
local SearchBar = Main.Main.Holder.SellFrame.BackgroundFrame.SearchBar;
local TextBox = SearchBar.Main.TextBox;
local ImageButton = SearchBar.Main.ImageButton;
local NO_RESULTS = Main.Main.Holder.SellFrame.BackgroundFrame.NO_RESULTS;
require(ReplicatedStorage.Modules.PetEggOddsController);
require(ReplicatedStorage.Data.PetEggData);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = nil;
local u5 = 0;
local u6 = {};
local u7 = {};
local u8 = nil;
local u9 = {};
local u10 = {};
local u11 = false;
local u12 = {
    Pet = "Pet",
    Egg = "Egg",
    EggInfo = "EggInfo",
    PetInventory = "PetInventory",
    PetSell = "PetSell"
};
u1.CurrentMode = "Pet";
local u13 = nil;
local u14 = {
    [0] = UDim2.new(1, 0, 0, 0),
    [1] = UDim2.new(1, 0, 0.175, 0),
    [2] = UDim2.new(1, 0, 0.375, 0),
    [3] = UDim2.new(1, 0, 0.575, 0),
    [4] = UDim2.new(1, 0, 0.775, 0),
    [5] = UDim2.new(1, 0, 1, 0)
};
local u15 = {
    Pet = {
        Title = "Trade in Pets for extra Pet Equip slots!",
        BaseColor = Color3.fromRGB(255, 175, 21),
        Stroke = Color3.fromRGB(134, 87, 11)
    },
    Egg = {
        Title = "Trade in Pets for extra Egg Equip slots!",
        BaseColor = Color3.fromRGB(83, 171, 52),
        Stroke = Color3.fromRGB(57, 100, 47)
    },
    PetInventory = {
        Title = "Trade in Pets for extra Pet Inventory capacity!",
        BaseColor = Color3.fromRGB(170, 0, 255),
        Stroke = Color3.fromRGB(100, 0, 150)
    },
    PetSell = {
        Title = "Sell your pets!",
        BaseColor = Color3.fromRGB(255, 102, 204),
        Stroke = Color3.fromRGB(104, 42, 83)
    }
};

local function TweenDetails(p16) -- Line: 106
    -- upvalues: TweenService (copy), Details (copy)
    local v17 = {
        Position = p16 and UDim2.new(0.8, 0, 0.5, 0) or UDim2.new(0.6, 0, 0.5, 0)
    };
    local v18 = {
        Scale = p16 and 1 or 0.1
    };
    local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    TweenService:Create(Details, TweenInfo_new_ret, v17):Play();
    local v19 = Details:FindFirstChildWhichIsA("UIScale");

    if v19 then
        TweenService:Create(v19, TweenInfo_new_ret, v18):Play();
    end;
end;

local function SetTradeButtonEnabled(p20) -- Line: 116
    -- upvalues: TradeIn (copy)
    TradeIn.BackgroundTransparency = p20 and 0 or 0.5;
    TradeIn.UIStroke.Transparency = p20 and 0 or 0.5;
    TradeIn.TextLabel.TextTransparency = p20 and 0 or 0.5;
end;

local function SetTradeConfirmationVisible(p21) -- Line: 122
    -- upvalues: TradeIn (copy), Confirm (copy), Cancel (copy)
    TradeIn.Visible = not p21;
    Confirm.Visible = p21;
    Cancel.Visible = p21;
end;

local function UpdateSelectedCost(p22) -- Line: 128
    -- upvalues: SelectedPetWorth (copy), NumberUtil (copy)
    SelectedPetWorth.Text = NumberUtil.DisplaySheckles(p22);
end;

local function UpdateAllCost(p23) -- Line: 138
    -- upvalues: AllPetWorth (copy), NumberUtil (copy)
    AllPetWorth.Text = NumberUtil.DisplaySheckles(p23);
end;

local function Color3ToHex(p24) -- Line: 148
    return string.format("%02X%02X%02X", p24.R * 255, p24.G * 255, p24.B * 255);
end;

local function BrightenColorHSV(p25, p26: number) -- Line: 152
    local v27, v28, v29 = p25:ToHSV();
    local math_clamp_ret = math.clamp(v29 + p26, 0, 1);

    return Color3.fromHSV(v27, v28, math_clamp_ret);
end;

local function StopDetailsRarityTween() -- Line: 158
    -- upvalues: u8 (ref)
    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;
end;

local function StartDetailsRarityTween(u30: userdata, u31: string, u32: string) -- Line: 165
    -- upvalues: u8 (ref)
    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    local u33 = 0;
    u8 = game:GetService("RunService").RenderStepped:Connect(function(p34) -- Line: 169
        -- upvalues: u33 (ref), u30 (copy), u31 (copy), u32 (copy)
        u33 = (u33 + p34 * 0.2) % 1;
        local Color3_fromHSV_ret = Color3.fromHSV(u33, 1, 1);
        local string_format_ret = string.format("%02X%02X%02X", Color3_fromHSV_ret.R * 255, Color3_fromHSV_ret.G * 255, Color3_fromHSV_ret.B * 255);
        u30.RichText = true;
        u30.Text = `{u31} <font color="#{string_format_ret}">[{u32}]</font>`;
    end);
end;

local function StopCardRarityTween(p35: string) -- Line: 178
    -- upvalues: u7 (copy)
    local v36 = u7[p35];

    if v36 then
        v36:Disconnect();
        u7[p35] = nil;
    end;
end;

local function StartCardRarityTween(u37: string, u38: userdata) -- Line: 186
    -- upvalues: u7 (copy)
    local v39 = u7[u37];

    if v39 then
        v39:Disconnect();
        u7[u37] = nil;
    end;

    local u40 = u38:FindFirstChildWhichIsA("UIStroke");
    local u41 = 0;
    u7[u37] = game:GetService("RunService").RenderStepped:Connect(function(p42) -- Line: 192
        -- upvalues: u38 (copy), u37 (copy), u7 (ref), u41 (ref), u40 (copy)
        if not (u38 and u38.Parent) then
            local v43 = u37;
            local v44 = u7[v43];

            if v44 then
                v44:Disconnect();
                u7[v43] = nil;
            end;

            return;
        end;

        u41 = (u41 + p42 * 0.2) % 1;
        local Color3_fromHSV_ret = Color3.fromHSV(u41, 1, 1);
        u38.TextColor3 = Color3_fromHSV_ret;

        if u40 then
            local v45, v46, v47 = Color3_fromHSV_ret:ToHSV();
            local math_clamp_ret = math.clamp(v47 + -0.4, 0, 1);
            u40.Color = Color3.fromHSV(v45, v46, math_clamp_ret);
        end;
    end);
end;

local function RefreshToolCache() -- Line: 208
    -- upvalues: u4 (ref), LocalPlayer (copy)
    u4 = {};

    for _, child in LocalPlayer.Backpack:GetChildren() do
        local Attribute = child:GetAttribute("PET_UUID");

        if Attribute then
            u4[Attribute] = child;
        end;
    end;

    for _, child in LocalPlayer.Character:GetChildren() do
        local Attribute = child:GetAttribute("PET_UUID");

        if Attribute then
            u4[Attribute] = child;
        end;
    end;
end;

local function GetToolFromUUID(p48) -- Line: 220
    -- upvalues: u4 (ref), RefreshToolCache (copy)
    if not u4 then
        RefreshToolCache();
    end;

    return u4[p48];
end;

local function GetAllSellablePets() -- Line: 226
    -- upvalues: DataService (copy), LocalPlayer (copy)
    local Data = DataService:GetData();

    if not Data then
        return {};
    end;

    local PetsData = Data.PetsData;

    if not PetsData then
        return {};
    end;

    local Data2 = PetsData.PetInventory.Data;

    local function isSellablePet(p49: userdata) -- Line: 237
        -- upvalues: Data2 (copy)
        local Attribute = p49:GetAttribute("PET_UUID");

        if not Attribute then
            return false;
        end;

        local v50 = Data2[Attribute];

        if v50 then
            return not v50.PetData.IsFavorite;
        end;

        return false;
    end;

    local v51 = {};

    for _, child in LocalPlayer.Backpack:GetChildren() do
        if child:IsA("Tool") then
            local Attribute = child:GetAttribute("PET_UUID");
            local v52;

            if Attribute then
                local v53 = Data2[Attribute];

                if v53 then
                    v52 = not v53.PetData.IsFavorite;
                else
                    v52 = false;
                end;
            else
                v52 = false;
            end;

            if v52 then
                table.insert(v51, child);
            end;
        end;
    end;

    for _, child in (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):GetChildren() do
        if child:IsA("Tool") then
            local Attribute = child:GetAttribute("PET_UUID");
            local v54;

            if Attribute then
                local v55 = Data2[Attribute];

                if v55 then
                    v54 = not v55.PetData.IsFavorite;
                else
                    v54 = false;
                end;
            else
                v54 = false;
            end;

            if v54 then
                table.insert(v51, child);
            end;
        end;
    end;

    return v51;
end;

local function CalculateAllSellablePetValue() -- Line: 270
    -- upvalues: LocalPlayer (copy), DataService (copy), CalculatePetValue (copy)
    if not LocalPlayer.Character then
        return -1;
    end;

    local Data = DataService:GetData();

    if not Data then
        return -1;
    end;

    local PetsData = Data.PetsData;

    if not PetsData then
        return -1;
    end;

    local Data2 = PetsData.PetInventory.Data;
    local v56 = {};

    for _, child in LocalPlayer.Backpack:GetChildren() do
        table.insert(v56, child);
    end;

    for _, child in LocalPlayer.Character:GetChildren() do
        table.insert(v56, child);
    end;

    local v57 = 0;

    for _, v in v56 do
        local Attribute = v:GetAttribute("PET_UUID");

        if Attribute then
            local v58 = Data2[Attribute];

            if v58 and not v58.PetData.IsFavorite then
                v57 = v57 + CalculatePetValue(v);
            end;
        end;
    end;

    return v57;
end;

local function UpdateDetails(p59) -- Line: 306
    -- upvalues: PetList (copy), PetUtilities (copy), PetRegistry (copy), u8 (ref), Details (copy)
    local v60 = PetList[p59.PetType];
    local PetData = p59.PetData;
    local Level = PetData.Level;
    local v61 = PetUtilities:CalculateWeight(PetData.BaseWeight, Level) * 100;
    local v62 = math.round(v61) / 100;
    local u63 = p59.PetType or "Unknown";
    local u64 = v60 and (v60.Rarity or "Common") or "Common";
    local v65 = PetRegistry.PetRarities[u64];
    local v66 = v65 and v65.Color or Color3.fromRGB(255, 255, 255);

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    Details.Holder.Header.PET_TEXT.RichText = true;

    if u64 == "Prismatic" then
        local PET_TEXT = Details.Holder.Header.PET_TEXT;

        if u8 then
            u8:Disconnect();
            u8 = nil;
        end;

        local u67 = 0;
        u8 = game:GetService("RunService").RenderStepped:Connect(function(p68) -- Line: 169
            -- upvalues: u67 (ref), PET_TEXT (copy), u63 (copy), u64 (copy)
            u67 = (u67 + p68 * 0.2) % 1;
            local Color3_fromHSV_ret = Color3.fromHSV(u67, 1, 1);
            local string_format_ret = string.format("%02X%02X%02X", Color3_fromHSV_ret.R * 255, Color3_fromHSV_ret.G * 255, Color3_fromHSV_ret.B * 255);
            PET_TEXT.RichText = true;
            PET_TEXT.Text = `{u63} <font color="#{string_format_ret}">[{u64}]</font>`;
        end);
    else
        local string_format_ret = string.format("%02X%02X%02X", v66.R * 255, v66.G * 255, v66.B * 255);
        Details.Holder.Header.PET_TEXT.Text = `{u63} <font color="#{string_format_ret}">[{u64}]</font>`;
    end;

    Details.Holder.Display.Display.PET_NAME_CONFIG.Text = PetData.Name or "Unnamed";
    Details.Holder.Display.Display.PET_IMAGE.Image = v60 and (v60.Icon or "") or "";
    Details.Holder.Description.Display.PET_DESCRIPTION.Text = v60 and v60.Description or "No description available.";
    Details.Holder.Stats.Holder.Weight.PET_WEIGHT.Text = `Weight: {v62} KG`;
    Details.Holder.Stats.Holder.Age.PET_AGE.Text = `Age: {Level}`;
end;

local function SetSelectedStyle(p69, p70) -- Line: 334
    if not p69:FindFirstChild("Display") then
        return;
    end;

    if p70 then
        p69.Display.BackgroundColor3 = Color3.fromRGB(30, 100, 14);
        p69.Display.UIStroke.Color = Color3.fromRGB(37, 238, 38);
        p69.Display.SELECTED_VIGNETTE.Visible = true;

        return;
    end;

    p69.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
    p69.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
    p69.Display.SELECTED_VIGNETTE.Visible = false;
end;

local function BuildSearchHaystack(p71: any, p72: string) -- Line: 352
    return string.lower((`{p71.PetType} {p72} {p71.PetData.Name or ""} {p71.PetData.Level or 0}`));
end;

local function MatchesSearch(p73: string) -- Line: 356
    -- upvalues: u10 (copy)
    for _, v in u10 do
        if not string.find(p73, v, 1, true) then
            return false;
        end;
    end;

    return true;
end;

local function ApplySellSearch() -- Line: 365
    -- upvalues: u9 (copy), MatchesSearch (copy), NO_RESULTS (copy), u10 (copy)
    local v74 = 0;

    for i = #u9, 1, -1 do
        local v75 = u9[i];
        local v76;

        if v75.Card.Parent then
            local v77 = v75.BaseVisible and MatchesSearch(v75.Haystack);

            if v75.Card.Visible ~= v77 then
                v75.Card.Visible = v77;
            end;

            if v77 then
                v74 = v74 + 1;
                v76 = i;
            else
                v76 = i;
            end;
        else
            table.remove(u9, i);
            v76 = i;
        end;
    end;

    local v78;

    if v74 == 0 then
        v78 = #u10 > 0;
    else
        v78 = false;
    end;

    NO_RESULTS.Visible = v78;
end;

local function QueueSellSearch() -- Line: 388
    -- upvalues: u11 (ref), u10 (copy), TextBox (copy), ApplySellSearch (copy)
    if u11 then
        return;
    end;

    u11 = true;
    task.defer(function() -- Line: 392
        -- upvalues: u11 (ref), u10 (ref), TextBox (ref), ApplySellSearch (ref)
        u11 = false;
        table.clear(u10);

        for i in string.gmatch(string.lower(TextBox.Text), "%S+") do
            table.insert(u10, i);
        end;

        ApplySellSearch();
    end);
end;

function u1.UpdatePetCard(p79, u80, u81) -- Line: 405
    -- upvalues: Main (copy), u6 (copy), u13 (ref), SetSelectedStyle (copy), TradeIn (copy), CalculatePetValue (copy), u4 (ref), RefreshToolCache (copy), u5 (ref), u3 (ref), u2 (ref), TweenDetails (copy), UpdateDetails (copy), SelectedPetWorth (copy), NumberUtil (copy)
    local u82 = p79.CurrentMode == "PetSell";
    local u83 = u82 and Main.Main.Holder.SellFrame.BackgroundFrame.SellScrollingFrame or Main.Main.Holder.ScrollingFrame.Content;
    u80.Favorite.Visible = u81.PetData.IsFavorite and true or false;

    if u6[u80.Name] then
        u6[u80.Name]:Disconnect();
        u6[u80.Name] = nil;
    end;

    u6[u80.Name] = u80.MouseButton1Click:Connect(function() -- Line: 418
        -- upvalues: u13 (ref), u81 (copy), u82 (copy), u83 (copy), SetSelectedStyle (ref), TradeIn (ref), u80 (copy), CalculatePetValue (ref), u4 (ref), RefreshToolCache (ref), u5 (ref), u3 (ref), u2 (ref), TweenDetails (ref), UpdateDetails (ref), SelectedPetWorth (ref), NumberUtil (ref)
        local v84;

        if u13 == u81.UUID then
            v84 = nil;
        else
            v84 = u81.UUID;
        end;

        u13 = v84;

        if u82 then
            if not u81.PetData.IsFavorite then
                SetSelectedStyle(u80, not u80.Display.SELECTED_VIGNETTE.Visible);
                local UUID = u81.UUID;

                if not u4 then
                    RefreshToolCache();
                end;

                local v85 = CalculatePetValue(u4[UUID]);
                local v86 = u4[u81.UUID];

                if not (v86 and v86:IsDescendantOf(game)) then
                    warn("Tool not found or destroyed:", u81.UUID);
                    local v87 = u80;

                    if not v87:FindFirstChild("Display") then
                        return;
                    end;

                    v87.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
                    v87.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
                    v87.Display.SELECTED_VIGNETTE.Visible = false;

                    return;
                end;

                if u80.Display.SELECTED_VIGNETTE.Visible then
                    u5 = u5 + v85;
                    u3[v86] = true;
                    u2[u81.UUID] = u80;
                    UpdateDetails(u81);
                    TweenDetails(true);
                else
                    u5 = u5 - v85;
                    u3[v86] = nil;
                    u2[u81.UUID] = nil;
                    TweenDetails(false);
                end;

                SelectedPetWorth.Text = NumberUtil.DisplaySheckles(u5);
            end;
        else
            for _, child in u83:GetChildren() do
                if child:IsA("ImageButton") and child:FindFirstChild("Display") then
                    SetSelectedStyle(child, child.Name == u13);
                end;
            end;

            local v88 = u13 ~= nil;
            TradeIn.BackgroundTransparency = v88 and 0 or 0.5;
            TradeIn.UIStroke.Transparency = v88 and 0 or 0.5;
            TradeIn.TextLabel.TextTransparency = v88 and 0 or 0.5;
        end;

        if not u82 then
            if u13 then
                UpdateDetails(u81);
                TweenDetails(true);

                return;
            end;

            TweenDetails(false);
        end;
    end);
end;

function u1.GetPetFrame(p89: table, p90: string) -- Line: 467
    -- upvalues: Main (copy)
    return (p89.CurrentMode == "PetSell" and Main.Main.Holder.SellFrame.BackgroundFrame.SellScrollingFrame or Main.Main.Holder.ScrollingFrame.Content):FindFirstChild(p90);
end;

function u1.SetMode(p91, p92) -- Line: 475
    -- upvalues: u13 (ref), u8 (ref), TweenDetails (copy), TradeIn (copy), Confirm (copy), Cancel (copy), Main (copy), TextBox (copy), u15 (copy)
    p91.CurrentMode = p92;
    u13 = nil;

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    TweenDetails(false);
    TradeIn.BackgroundTransparency = 0.5;
    TradeIn.UIStroke.Transparency = 0.5;
    TradeIn.TextLabel.TextTransparency = 0.5;
    TradeIn.Visible = true;
    Confirm.Visible = false;
    Cancel.Visible = false;
    local v93 = (p92 == "Pet" or p92 == "Egg") and true or p92 == "PetInventory";
    local v94 = p92 == "PetSell";
    local Holder = Main.Main.Holder;
    local v95 = {
        BAR = Main.Main.BAR,
        EggInfo = Holder.EggInfo,
        ScrollingFrame = Holder.ScrollingFrame,
        TradeInButton = Holder.TradeInButton,
        OddsButton = Holder.EggInfo.Content.TEMPLATE.Display.OddsButton,
        TextHolder = Holder.TextHolder,
        SellScrollingFrame = Holder.SellFrame.BackgroundFrame.SellScrollingFrame,
        SellFrame = Holder.SellFrame,
        SellCosts = Main.Main.SellCosts,
        AgePrompt = Holder.AgePromptText
    };

    if v94 then
        v95.BAR.Visible = false;
        v95.ScrollingFrame.Visible = false;
        v95.TradeInButton.Visible = false;
        v95.TextHolder.Visible = false;
        v95.AgePrompt.Visible = false;
        v95.EggInfo.Visible = false;
        v95.SellFrame.Visible = true;
        v95.SellCosts.Visible = true;
    else
        v95.BAR.Visible = v93;
        v95.ScrollingFrame.Visible = v93;
        v95.TradeInButton.Visible = v93;
        v95.TextHolder.Visible = v93;
        v95.AgePrompt.Visible = v93;
        v95.EggInfo.Visible = not v93;
        v95.OddsButton.Visible = not v93;
        v95.SellCosts.Visible = false;
        v95.SellFrame.Visible = false;
        TextBox:ReleaseFocus();
        TextBox.Text = "";
    end;

    if u15[p92] then
        local v96 = u15[p92];
        Main.Main.Header.Title.Text = v96.Title;
        Main.Main.Header.BackgroundColor3 = v96.BaseColor;
        Main.Main.Header.Title.UIStroke.Color = v96.Stroke;
    else
        Main.Main.Header.Title.Text = "Egg Rarity Info";
        Main.Main.Header.BackgroundColor3 = Color3.fromRGB(35, 150, 238);
        Main.Main.Header.Title.UIStroke.Color = Color3.fromRGB(17, 74, 117);
    end;

    p91:RefreshUI(v94);
end;

function u1.ClearSelection(p97) -- Line: 538
    -- upvalues: u2 (ref), Main (copy), u5 (ref), u3 (ref), u8 (ref), TweenDetails (copy)
    if next(u2) == nil then
        return;
    end;

    for _, v in u2 do
        if v:FindFirstChild("Display") then
            v.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
            v.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
            v.Display.SELECTED_VIGNETTE.Visible = false;
        end;
    end;

    Main.Main.SellCosts.Main.SelectedPetWorth.Text = 0 .. "¢";
    u5 = 0;
    u2 = {};
    u3 = {};

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    TweenDetails(false);
end;

function u1.RefreshUI(p98, p99) -- Line: 551
    -- upvalues: u13 (ref), u9 (copy), NO_RESULTS (copy), u12 (copy), TweenDetails (copy), TradeIn (copy), Confirm (copy), Cancel (copy), RefreshToolCache (copy), DataService (copy), REQUIRED_AGE (copy), Main (copy), u14 (copy), CalculateAllSellablePetValue (copy), AllPetWorth (copy), NumberUtil (copy), u7 (copy), PetUtilities (copy), LocalPlayer (copy), u5 (ref), u6 (copy), u4 (ref), PetList (copy), PetRegistry (copy), StartCardRarityTween (copy), u1 (copy), ApplySellSearch (copy)
    u13 = nil;
    table.clear(u9);
    NO_RESULTS.Visible = false;

    if p99 == nil then
        p99 = p98.CurrentMode == u12.Sell;
    end;

    TweenDetails(false);
    TradeIn.BackgroundTransparency = 0.5;
    TradeIn.UIStroke.Transparency = 0.5;
    TradeIn.TextLabel.TextTransparency = 0.5;
    TradeIn.Visible = true;
    Confirm.Visible = false;
    Cancel.Visible = false;

    if p99 then
        RefreshToolCache();
    end;

    local Data = DataService:GetData();
    local _ = Data.PetsData.MutableStats;
    local CurrentMode = p98.CurrentMode;
    local v100 = CurrentMode == "Pet";
    local v101 = CurrentMode == "Egg";
    local v102 = CurrentMode == "PetInventory";
    local v103 = 0;

    if p99 then
        local v104 = CalculateAllSellablePetValue();
        AllPetWorth.Text = NumberUtil.DisplaySheckles(v104);
    else
        local v105;

        if v100 then
            v105 = Data.PetsData.PurchasedEquipSlots or 0;
        elseif v101 then
            v105 = Data.PetsData.PurchasedEggSlots or 0;
        else
            v105 = v102 and (Data.PetsData.PurchasedPetInventorySlots or 0) or 0;
        end;

        v103 = ({ 20, 30, 45, 60, 75 })[v105 + 1] or 999;

        if v105 >= 5 then
            REQUIRED_AGE.Text = "You have reached the maximum number of slots!";
            Main.Main.Holder.ScrollingFrame.Visible = false;
            Main.Main.Holder.TradeInButton.Visible = false;
        else
            REQUIRED_AGE.Text = `Required age for next slot unlock: <font color="#ffbe19">{v103}</font>`;
        end;

        Main.Main.BAR.ACTUAL_BAR.Size = u14[math.clamp(v105, 0, 5)] or u14[0];
        local IncrementalListing = Main.Main.BAR.IncrementalListing;

        for i, v in { "One", "Two", "Three", "Four", "Five" } do
            local v106 = IncrementalListing:FindFirstChild(v);

            if v106 then
                local v107 = v106:FindFirstChildWhichIsA("UIGradient");

                if v107 then
                    v107.Enabled = i <= v105;
                end;

                local v108;

                if v102 then
                    v108 = i * 5 or i;
                else
                    v108 = i;
                end;

                v106.Text = `+{v108} Extra`;
            end;
        end;

        local Title = IncrementalListing:FindFirstChild("Title");

        if Title and Title:FindFirstChild("UIGradient") then
            Title.UIGradient.Enabled = v105 >= 5;
        end;

        if v105 >= 5 then
            return;
        end;
    end;

    local v109 = p99 and Main.Main.Holder.SellFrame.BackgroundFrame.SellScrollingFrame or Main.Main.Holder.ScrollingFrame.Content;
    local TEMPLATE = v109:FindFirstChild("TEMPLATE");

    for _, child in v109:GetChildren() do
        if child:IsA("ImageButton") and child.Name ~= "TEMPLATE" then
            local Name = child.Name;
            local v110 = u7[Name];

            if v110 then
                v110:Disconnect();
                u7[Name] = nil;
            end;

            child:Destroy();
        end;
    end;

    TEMPLATE.Visible = false;
    local PetsSortedByAge = PetUtilities:GetPetsSortedByAge(LocalPlayer, 0, true, false);

    if not PetsSortedByAge or #PetsSortedByAge == 0 then
        return;
    end;

    u5 = 0;

    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);

    for i, _ in u7 do
        local v111 = u7[i];

        if v111 then
            v111:Disconnect();
            u7[i] = nil;
        end;
    end;

    table.clear(u7);

    for _, v in PetsSortedByAge do
        if v.PetData.Level >= v103 then
            local v112, v113, v114, v115, v116, v117, v118, v119, v120, v121, v122, v123, v124, v125, v126, v127, v128, v129;

            if p99 then
                local v130 = u4[v.UUID];

                if v130 and v130.Parent then
                    v112 = TEMPLATE:Clone();
                    v112.Visible = true;
                    v112.Name = v.UUID;
                    v112.Visible = not v.PetData.IsFavorite;
                    v113 = PetList[v.PetType];
                    v114 = v113 and (v113.Rarity or "Common") or "Common";
                    v115 = PetRegistry.PetRarities[v114];
                    v116 = v115 and v115.Color or Color3.fromRGB(255, 255, 255);
                    v117, v118, v119 = v116:ToHSV();
                    v120 = math.clamp(v119 + -0.4, 0, 1);
                    v121 = Color3.fromHSV(v117, v118, v120);
                    v112.Display.PET_NAME.Text = v.PetType;
                    v122 = v112.Display.PET_AGE;
                    v123 = v.PetData.Level;
                    v124 = PetUtilities:CalculateWeight(v.PetData.BaseWeight, v.PetData.Level) * 100;
                    v122.Text = `Age: {v123} • {math.round(v124) / 100} KG`;
                    v112.Display.PET_RARITY.Text = v114;
                    v125 = v112.Name;
                    v126 = u7[v125];

                    if v126 then
                        v126:Disconnect();
                        u7[v125] = nil;
                    end;

                    if v114 == "Prismatic" then
                        StartCardRarityTween(v112.Name, v112.Display.PET_RARITY);
                    else
                        v112.Display.PET_RARITY.TextColor3 = v116;
                        v127 = v112.Display.PET_RARITY:FindFirstChildWhichIsA("UIStroke");

                        if v127 then
                            v127.Color = v121;
                        end;
                    end;

                    if v113 then
                        v112.Display.DetailHolder.PET_IMAGE.Visible = true;
                        v112.Display.DetailHolder.PET_IMAGE.Image = v113.Icon;
                    else
                        v112.Display.DetailHolder.PET_IMAGE.Visible = false;
                    end;

                    if v112:FindFirstChild("Display") then
                        v112.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
                        v112.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
                        v112.Display.SELECTED_VIGNETTE.Visible = false;
                    end;

                    u1:UpdatePetCard(v112, v);

                    if p99 then
                        v128 = u9;
                        v129 = {
                            Card = v112,
                            Haystack = string.lower((`{v.PetType} {v114} {v.PetData.Name or ""} {v.PetData.Level or 0}`)),
                            BaseVisible = v112.Visible
                        };
                        table.insert(v128, v129);
                    end;

                    v112.Parent = v109;
                end;
            else
                v112 = TEMPLATE:Clone();
                v112.Visible = true;
                v112.Name = v.UUID;
                v112.Visible = not v.PetData.IsFavorite;
                v113 = PetList[v.PetType];
                v114 = v113 and (v113.Rarity or "Common") or "Common";
                v115 = PetRegistry.PetRarities[v114];
                v116 = v115 and v115.Color or Color3.fromRGB(255, 255, 255);
                v117, v118, v119 = v116:ToHSV();
                v120 = math.clamp(v119 + -0.4, 0, 1);
                v121 = Color3.fromHSV(v117, v118, v120);
                v112.Display.PET_NAME.Text = v.PetType;
                v122 = v112.Display.PET_AGE;
                v123 = v.PetData.Level;
                v124 = PetUtilities:CalculateWeight(v.PetData.BaseWeight, v.PetData.Level) * 100;
                v122.Text = `Age: {v123} • {math.round(v124) / 100} KG`;
                v112.Display.PET_RARITY.Text = v114;
                v125 = v112.Name;
                v126 = u7[v125];

                if v126 then
                    v126:Disconnect();
                    u7[v125] = nil;
                end;

                if v114 == "Prismatic" then
                    StartCardRarityTween(v112.Name, v112.Display.PET_RARITY);
                else
                    v112.Display.PET_RARITY.TextColor3 = v116;
                    v127 = v112.Display.PET_RARITY:FindFirstChildWhichIsA("UIStroke");

                    if v127 then
                        v127.Color = v121;
                    end;
                end;

                if v113 then
                    v112.Display.DetailHolder.PET_IMAGE.Visible = true;
                    v112.Display.DetailHolder.PET_IMAGE.Image = v113.Icon;
                else
                    v112.Display.DetailHolder.PET_IMAGE.Visible = false;
                end;

                if v112:FindFirstChild("Display") then
                    v112.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
                    v112.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
                    v112.Display.SELECTED_VIGNETTE.Visible = false;
                end;

                u1:UpdatePetCard(v112, v);

                if p99 then
                    v128 = u9;
                    v129 = {
                        Card = v112,
                        Haystack = string.lower((`{v.PetType} {v114} {v.PetData.Name or ""} {v.PetData.Level or 0}`)),
                        BaseVisible = v112.Visible
                    };
                    table.insert(v128, v129);
                end;

                v112.Parent = v109;
            end;
        end;
    end;

    if p99 then
        ApplySellSearch();
    end;
end;

local function RefreshSellUI() -- Line: 729
    -- upvalues: u3 (ref), u4 (ref), u2 (ref), u1 (copy), u13 (ref), u5 (ref), SelectedPetWorth (copy), NumberUtil (copy), CalculateAllSellablePetValue (copy), AllPetWorth (copy), Main (copy)
    for i, _ in u3 do
        local Attribute = i:GetAttribute("PET_UUID");
        u4[Attribute] = nil;

        if u2[Attribute] then
            u2[Attribute]:Destroy();
            u2[Attribute] = nil;
        end;
    end;

    u1:ClearSelection();
    table.clear(u3);
    table.clear(u2);
    u13 = nil;
    SelectedPetWorth.Text = NumberUtil.DisplaySheckles(u5);
    local v131 = CalculateAllSellablePetValue();
    AllPetWorth.Text = NumberUtil.DisplaySheckles(v131);
    u1:SetMode("PetSell");
    Main.Main.SellCosts.Main.SelectedPetWorth.Text = 0 .. "¢";
    u5 = 0;
    u1:RefreshUI(true);
end;

function u1.Start(p132) -- Line: 754
    -- upvalues: GuiController (copy), PetEquipSlots_UI (copy), u4 (ref), u3 (ref), u1 (copy), TradeIn (copy), u13 (ref), REQUIRED_AGE (copy), Confirm (copy), Cancel (copy), GameEvents (copy), Main (copy), TextBox (copy), Details (copy), u8 (ref), u5 (ref), QueueSellSearch (copy), ImageButton (copy), GetAllSellablePets (copy), Notification (copy), ConfirmationPromptController (copy), NumberUtil (copy), CalculateAllSellablePetValue (copy), SellAllPets_RE (copy), RefreshSellUI (copy), PetsService (copy), PetList (copy), PetRarities (copy), CalculatePetValue (copy), RefreshToolCache (copy), u2 (ref), SellPetShopSelected (copy), SelectedPetWorth (copy), AllPetWorth (copy)
    GuiController:UsePopupAnims(PetEquipSlots_UI);

    if u4 ~= nil then
        table.clear(u4);
        u4 = {};
    end;

    if u3 ~= nil then
        table.clear(u3);
        u3 = {};
    end;

    local u133 = {};

    local function IsDebounced(p134: any, p135: number?) -- Line: 767
        -- upvalues: u133 (copy)
        if u133[p134] and (p135 or 0.5) > tick() - u133[p134] then
            return true;
        end;

        u133[p134] = tick();

        return false;
    end;

    if u1.CurrentMode == nil then
        u1.CurrentMode = "EggInfo";
    end;

    u1:SetMode(u1.CurrentMode);

    if u1.CurrentMode == "PetSell" then
        u1:ClearSelection();
    end;

    u1:RefreshUI(u1.CurrentMode == "PetSell");
    TradeIn.SENSOR.MouseButton1Click:Connect(function() -- Line: 780
        -- upvalues: u133 (copy), u13 (ref), REQUIRED_AGE (ref), TradeIn (ref), Confirm (ref), Cancel (ref)
        local v136;

        if u133.TradeInStart and (nil or 0.5) > tick() - u133.TradeInStart then
            v136 = true;
        else
            u133.TradeInStart = tick();
            v136 = false;
        end;

        if v136 or not u13 then
            return;
        end;

        REQUIRED_AGE.Text = "Are you sure you want to trade in this pet?";
        TradeIn.Visible = false;
        Confirm.Visible = true;
        Cancel.Visible = true;
    end);
    Confirm.SENSOR.MouseButton1Click:Connect(function() -- Line: 786
        -- upvalues: u133 (copy), u13 (ref), GameEvents (ref), u1 (ref), TradeIn (ref), Confirm (ref), Cancel (ref)
        local v137;

        if u133.TradeConfirm and (nil or 0.5) > tick() - u133.TradeConfirm then
            v137 = true;
        else
            u133.TradeConfirm = tick();
            v137 = false;
        end;

        if v137 or not u13 then
            return;
        end;

        GameEvents.UnlockSlotFromPet:FireServer(u13, u1.CurrentMode);
        task.wait(1);
        u1:RefreshUI(false);
        u13 = nil;
        TradeIn.BackgroundTransparency = 0.5;
        TradeIn.UIStroke.Transparency = 0.5;
        TradeIn.TextLabel.TextTransparency = 0.5;
        TradeIn.Visible = true;
        Confirm.Visible = false;
        Cancel.Visible = false;
    end);
    Cancel.SENSOR.MouseButton1Click:Connect(function() -- Line: 796
        -- upvalues: u133 (copy), TradeIn (ref), Confirm (ref), Cancel (ref), u1 (ref)
        local v138;

        if u133.TradeCancel and (nil or 0.5) > tick() - u133.TradeCancel then
            v138 = true;
        else
            u133.TradeCancel = tick();
            v138 = false;
        end;

        if v138 then
            return;
        end;

        TradeIn.Visible = true;
        Confirm.Visible = false;
        Cancel.Visible = false;
        u1:RefreshUI(false);
    end);
    Main.Main.Header.Exit.SENSOR.MouseButton1Click:Connect(function() -- Line: 802
        -- upvalues: u133 (copy), TextBox (ref), u1 (ref), GuiController (ref), PetEquipSlots_UI (ref)
        local v139;

        if u133.ExitHeader and (nil or 0.5) > tick() - u133.ExitHeader then
            v139 = true;
        else
            u133.ExitHeader = tick();
            v139 = false;
        end;

        if v139 then
            return;
        end;

        TextBox:ReleaseFocus();
        TextBox.Text = "";
        u1:ClearSelection();
        GuiController:Close(PetEquipSlots_UI);
    end);
    Details.Holder.Header.EXIT_BUTTON.SENSOR.MouseButton1Click:Connect(function() -- Line: 810
        -- upvalues: u133 (copy), u13 (ref), TradeIn (ref), u8 (ref), u1 (ref)
        local v140;

        if u133.ExitDetails and (nil or 0.5) > tick() - u133.ExitDetails then
            v140 = true;
        else
            u133.ExitDetails = tick();
            v140 = false;
        end;

        if v140 then
            return;
        end;

        u13 = nil;
        TradeIn.BackgroundTransparency = 0.5;
        TradeIn.UIStroke.Transparency = 0.5;
        TradeIn.TextLabel.TextTransparency = 0.5;

        if u8 then
            u8:Disconnect();
            u8 = nil;
        end;

        u1:SetMode("Pet");
    end);
    Main.Main.SideBar.ButtonList.PetEquipSlots.SENSOR.MouseButton1Click:Connect(function() -- Line: 818
        -- upvalues: u133 (copy), u1 (ref)
        local v141;

        if u133.PetButton and (nil or 0.5) > tick() - u133.PetButton then
            v141 = true;
        else
            u133.PetButton = tick();
            v141 = false;
        end;

        if v141 then
            return;
        end;

        u1:SetMode("Pet");
    end);
    Main.Main.SideBar.ButtonList.EggEquipSlots.SENSOR.MouseButton1Click:Connect(function() -- Line: 823
        -- upvalues: u133 (copy), u1 (ref)
        local v142;

        if u133.EggButton and (nil or 0.5) > tick() - u133.EggButton then
            v142 = true;
        else
            u133.EggButton = tick();
            v142 = false;
        end;

        if v142 then
            return;
        end;

        u1:SetMode("Egg");
    end);
    Main.Main.SideBar.ButtonList.PetInventorySlots.SENSOR.MouseButton1Click:Connect(function() -- Line: 828
        -- upvalues: u133 (copy), u1 (ref)
        local v143;

        if u133.InventoryButton and (nil or 0.5) > tick() - u133.InventoryButton then
            v143 = true;
        else
            u133.InventoryButton = tick();
            v143 = false;
        end;

        if v143 then
            return;
        end;

        u1:SetMode("PetInventory");
    end);
    Main.Main.SideBar.ButtonList.EggInfo.SENSOR.MouseButton1Click:Connect(function() -- Line: 833
        -- upvalues: u133 (copy), u1 (ref)
        local v144;

        if u133.EggInfoButton and (nil or 0.5) > tick() - u133.EggInfoButton then
            v144 = true;
        else
            u133.EggInfoButton = tick();
            v144 = false;
        end;

        if v144 then
            return;
        end;

        u1:SetMode("EggInfo");
    end);
    Main.Main.SideBar.ButtonList.PetSell.SENSOR.MouseButton1Click:Connect(function() -- Line: 837
        -- upvalues: u133 (copy), u1 (ref), Main (ref), u5 (ref)
        local v145;

        if u133.PetSell and (nil or 0.5) > tick() - u133.PetSell then
            v145 = true;
        else
            u133.PetSell = tick();
            v145 = false;
        end;

        if v145 then
            return;
        end;

        u1:SetMode("PetSell");
        Main.Main.SellCosts.Main.SelectedPetWorth.Text = 0 .. "¢";
        u5 = 0;
        u1:RefreshUI(true);
    end);
    TextBox:GetPropertyChangedSignal("Text"):Connect(QueueSellSearch);
    ImageButton.MouseButton1Click:Connect(function() -- Line: 846
        -- upvalues: TextBox (ref)
        if TextBox.Text == "" then
            TextBox:CaptureFocus();

            return;
        end;

        TextBox.Text = "";
        TextBox:ReleaseFocus();
    end);
    Main.Main.SellCosts.Main.SellAll.SENSOR.MouseButton1Click:Connect(function() -- Line: 855
        -- upvalues: u133 (copy), GetAllSellablePets (ref), Notification (ref), GuiController (ref), PetEquipSlots_UI (ref), ConfirmationPromptController (ref), NumberUtil (ref), CalculateAllSellablePetValue (ref), SellAllPets_RE (ref), RefreshSellUI (ref)
        local v146;

        if u133.SellAll and (nil or 0.5) > tick() - u133.SellAll then
            v146 = true;
        else
            u133.SellAll = tick();
            v146 = false;
        end;

        if v146 then
            return;
        end;

        if #GetAllSellablePets() == 0 then
            Notification:CreateNotification("You have no pets to sell!");

            return;
        end;

        GuiController:Close(PetEquipSlots_UI);
        ConfirmationPromptController:Open({
            Title = "Sell All Pets Confirmation",
            Header = "Are you sure you want to sell all Unfavorited pets?",
            Footer = "This action is irreversible.",
            Middle = `You will receive: {NumberUtil.DisplaySheckles((CalculateAllSellablePetValue()))}`
        }, {
            ConfirmEvent = SellAllPets_RE,

            ConfirmCallback = function() -- Line: 878, Name: ConfirmCallback
                -- upvalues: RefreshSellUI (ref), GuiController (ref), PetEquipSlots_UI (ref)
                RefreshSellUI();
                task.wait(0.25);
                GuiController:Open(PetEquipSlots_UI);
            end,

            RejectCallback = function() -- Line: 883, Name: RejectCallback
                -- upvalues: RefreshSellUI (ref), GuiController (ref), PetEquipSlots_UI (ref)
                RefreshSellUI();
                task.wait(0.25);
                GuiController:Open(PetEquipSlots_UI);
            end
        });
    end);
    Main.Main.SellCosts.Main.Clear.SENSOR.MouseButton1Click:Connect(function() -- Line: 891
        -- upvalues: u133 (copy), u1 (ref)
        local v147;

        if u133.Clear and (nil or 0.5) > tick() - u133.Clear then
            v147 = true;
        else
            u133.Clear = tick();
            v147 = false;
        end;

        if v147 then
            return;
        end;

        u1:ClearSelection();
    end);
    Main.Main.SellCosts.Main.Sell.SENSOR.MouseButton1Click:Connect(function() -- Line: 896
        -- upvalues: u133 (copy), u3 (ref), PetsService (ref), PetList (ref), PetRarities (ref), CalculatePetValue (ref), u4 (ref), RefreshToolCache (ref), Notification (ref), ConfirmationPromptController (ref), NumberUtil (ref), u2 (ref), SellPetShopSelected (ref), u1 (ref), u5 (ref), u13 (ref), SelectedPetWorth (ref), CalculateAllSellablePetValue (ref), AllPetWorth (ref), GuiController (ref), PetEquipSlots_UI (ref), RefreshSellUI (ref)
        local v148;

        if u133.Sell and (nil or 0.5) > tick() - u133.Sell then
            v148 = true;
        else
            u133.Sell = tick();
            v148 = false;
        end;

        if v148 then
            return;
        end;

        local v149 = 0;
        local v150 = {};
        local v151 = {};

        for i, _ in u3 do
            local Attribute = i:GetAttribute("PET_UUID");
            local PlayerPetData = PetsService:GetPlayerPetData(Attribute);

            if PlayerPetData then
                local v152 = PetList[PlayerPetData.PetType];
                local v153 = not v152 and "Common" or v152.Rarity;
                local v154 = PetRarities[v153].Color or Color3.fromRGB(255, 255, 255);
                local v155 = `<font color="rgb({math.floor(v154.R * 255)},{math.floor(v154.G * 255)},{math.floor(v154.B * 255)})">{PlayerPetData.PetType}</font>`;
                table.insert(v150, v155);
                v151[`{PlayerPetData.PetType}`] = v153;

                if not u4 then
                    RefreshToolCache();
                end;

                v149 = v149 + CalculatePetValue(u4[Attribute]);
            end;
        end;

        if #v150 == 0 then
            Notification:CreateNotification("No pets selected!");

            return;
        end;

        ConfirmationPromptController:Open({
            Title = "Sell Pet Confirmation",
            Footer = "This action is irreversible.",
            Header = `Are you sure you want to sell your pets for {NumberUtil.DisplaySheckles(v149)}`,
            Middle = table.concat(v150, ", "),
            AnimatedWords = v151
        }, {
            ConfirmCallback = function() -- Line: 937, Name: ConfirmCallback
                -- upvalues: u3 (ref), u4 (ref), u2 (ref), SellPetShopSelected (ref), u1 (ref), u5 (ref), u13 (ref), SelectedPetWorth (ref), NumberUtil (ref), CalculateAllSellablePetValue (ref), AllPetWorth (ref), GuiController (ref), PetEquipSlots_UI (ref)
                for i, _ in u3 do
                    local Attribute = i:GetAttribute("PET_UUID");
                    u4[Attribute] = nil;

                    if u2[Attribute] then
                        u2[Attribute]:Destroy();
                        u2[Attribute] = nil;
                    end;

                    SellPetShopSelected:FireServer(i);

                    if i.Parent then
                        i.AncestryChanged:Wait();
                    end;
                end;

                u1:ClearSelection();
                u5 = 0;
                table.clear(u3);
                table.clear(u2);
                u13 = nil;
                u1:RefreshUI(true);
                SelectedPetWorth.Text = NumberUtil.DisplaySheckles(u5);
                local v156 = CalculateAllSellablePetValue();
                AllPetWorth.Text = NumberUtil.DisplaySheckles(v156);
                task.wait(0.25);
                GuiController:Open(PetEquipSlots_UI);
            end,

            RejectCallback = function() -- Line: 967, Name: RejectCallback
                -- upvalues: RefreshSellUI (ref), GuiController (ref), PetEquipSlots_UI (ref)
                RefreshSellUI();
                task.wait(0.25);
                GuiController:Open(PetEquipSlots_UI);
            end
        });
    end);

    local function OnUIOpened() -- Line: 976
        -- upvalues: PetEquipSlots_UI (ref), u1 (ref)
        if PetEquipSlots_UI.Enabled then
            u1:SetMode(u1.CurrentMode);
        end;
    end;

    PetEquipSlots_UI:GetPropertyChangedSignal("Enabled"):Connect(OnUIOpened);
end;

Favorite_Item_BE.Event:Connect(function(p157: userdata) -- Line: 984
    -- upvalues: PetsService (copy), u1 (copy), u9 (copy), CalculatePetValue (copy), u4 (ref), RefreshToolCache (copy), u3 (ref), u2 (ref), u5 (ref), SelectedPetWorth (copy), NumberUtil (copy), CalculateAllSellablePetValue (copy), AllPetWorth (copy)
    if not p157 then
        warn("PetEquipSlotsUIController:Favorite_Item_BE | No pet tool!");

        return;
    end;

    local Attribute = p157:GetAttribute("PET_UUID");

    if not Attribute then
        return;
    end;

    task.wait(0.25);
    local PlayerPetData = PetsService:GetPlayerPetData(Attribute);

    if not PlayerPetData then
        return warn("PetEquipSlotsUIController:Favorite_Item_BE | No pet data found!");
    end;

    local PetFrame = u1:GetPetFrame(Attribute);

    if not PetFrame then
        return;
    end;

    if PetFrame then
        u1:UpdatePetCard(PetFrame, PlayerPetData);

        if PetFrame:FindFirstChild("Display") then
            PetFrame.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
            PetFrame.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
            PetFrame.Display.SELECTED_VIGNETTE.Visible = false;
        end;

        for _, v in u9 do
            if v.Card == PetFrame then
                v.BaseVisible = not PlayerPetData.PetData.IsFavorite;
                break;
            end;
        end;
    else
        u1:RefreshUI(u1.CurrentMode == "PetSell");
    end;

    local UUID = PlayerPetData.UUID;

    if not u4 then
        RefreshToolCache();
    end;

    local v158 = CalculatePetValue(u4[UUID]);

    if PlayerPetData.PetData.IsFavorite and (u3[p157] and u2[PlayerPetData.UUID]) then
        u5 = u5 - v158;
        u5 = math.clamp(u5, 0, u5);
        u3[p157] = nil;
        u2[PlayerPetData.UUID] = nil;
    end;

    SelectedPetWorth.Text = NumberUtil.DisplaySheckles(u5);
    local v159 = CalculateAllSellablePetValue();
    AllPetWorth.Text = NumberUtil.DisplaySheckles(v159);
end);
task.spawn(u1.Start, u1);

return u1;