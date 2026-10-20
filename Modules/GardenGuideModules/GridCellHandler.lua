-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local script_Parent = script.Parent;
local DetailsViewHandler = require(script_Parent.DetailsViewHandler);
require(script_Parent.SortButtonsLogic);
local GGButtonEffects = require(script_Parent.GGButtonEffects);
local GGStaticData = require(script_Parent.DataModules.GGStaticData);
local DataService = require(ReplicatedStorage.Modules.DataService);
local GGData = require(script_Parent.DataModules.GGData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local GGUI = require(script_Parent.GGUI);
local GardenGuide_RE_MarkOffNew = ReplicatedStorage.GameEvents.GardenGuide.GardenGuide_RE_MarkOffNew;
local GridCellTemplate = script_Parent.Templates.GridCellTemplate;
local MainMenu = Players.LocalPlayer.PlayerGui.GardenGuide.MainMenu;
local MainMenuFrame = MainMenu.MainMenuFrame;
local GridView = MainMenuFrame.GridView;
local _ = GridView.CompletionBar;
local TopBar = MainMenu.TopBar;
local SearchBar = MainMenuFrame.SearchBar;
local _ = TopBar.Title;
local _ = TopBar.ControlFrame.Exit;
local _ = TopBar.ControlFrame.Back;
local FilterSidebar = MainMenu.FilterSidebar;
local Sort = FilterSidebar.Main.Sort;
local Filter = FilterSidebar.Main.Filter;
local u1 = {};

local function ToggleCellUI(p2: userdata, p3: string) -- Line: 42
    p2:FindFirstChild("OBTAINED_IMAGE");
    local NewBanner = p2:FindFirstChild("NewBanner");
    local Cover = p2:FindFirstChild("Cover");
    p2:FindFirstChild("HarvestBar");
    local Mastery = p2:FindFirstChild("Mastery");
    local ITEM_NAME = p2:FindFirstChild("ITEM_NAME");
    local ITEM_NAME_SHADOW = p2:FindFirstChild("ITEM_NAME_SHADOW");
    local ITEM_IMAGE = p2:FindFirstChild("ITEM_IMAGE");
    local Attribute = p2:GetAttribute("Seen");
    ITEM_NAME.Visible = Attribute;
    ITEM_NAME_SHADOW.Visible = Attribute;
    Cover.Visible = not Attribute;
    ITEM_IMAGE.ImageColor3 = Attribute and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
    Mastery.Image = p2:GetAttribute("Mastered") and "rbxassetid://140518329666464" or "rbxassetid://99302990527020";
    local v4;

    if Attribute then
        v4 = p3 == "Plant";
    else
        v4 = Attribute;
    end;

    Mastery.Visible = v4;

    if Attribute then
        NewBanner.Visible = p2:GetAttribute("New");

        return;
    end;

    NewBanner.Visible = false;
end;

local function GridCellButtonFunc(p5: userdata, p6: userdata) -- Line: 74
    -- upvalues: GGData (copy), GardenGuide_RE_MarkOffNew (copy), ToggleCellUI (copy), FilterSidebar (copy), Sort (copy), Filter (copy), SearchBar (copy), GGUI (copy), MainMenuFrame (copy), DetailsViewHandler (copy)
    local v7 = p6.Name:gsub("Menu", "");
    local Data = GGData[v7].Data;
    local v8 = Data[p5.Name] or Data[p5.Name:gsub(" ", "")];

    if not v8 then
        warn((`No data for {p5.Name} in {v7}Data`));

        return;
    end;

    if not p6 then
        warn("No prev page for passing datatype");

        return;
    end;

    local v9 = p6.Name:gsub("Menu", "");
    GardenGuide_RE_MarkOffNew:FireServer(v9, v8.Name);
    p5:SetAttribute("New", false);
    ToggleCellUI(p5, v9);
    v8.New = false;
    p6.Visible = false;
    FilterSidebar.Visible = false;
    Sort.Visible = false;
    Filter.Visible = false;
    local Text = SearchBar.Main.TextBox.Text;
    GGUI.ChangeTopBar(v8.DisplayName or v8.Name, false);
    SearchBar.Main.TextBox.Text = Text;
    local v10 = MainMenuFrame:FindFirstChild((`{v8.Name}Details`));

    if not v10 then
        if GGUI.CurrentDetail then
            GGUI.CurrentDetail:Destroy();
        end;

        v10 = DetailsViewHandler.CreateDetailsView(MainMenuFrame, v8, v9);
    end;

    if v10 then
        v10.Visible = true;
        GGUI.CurrentDetail = v10;
    end;

    GGUI.GoNextPage(v10, p6);
end;

function u1.RemakeGridCell(p11: userdata, p12: userdata, p13: table, p14: string) -- Line: 114
    -- upvalues: GGStaticData (copy), SeedData (copy), ToggleCellUI (copy), DataService (copy)
    p11.Name = p13.Name;

    if GGStaticData.RarityColorMap[p13.Rarity] then
        if GGStaticData.AnimatedColors[p13.Rarity] then
            GGStaticData.AnimatedColors[p13.Rarity](p11);
        else
            p11.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(GGStaticData.RarityColorMap[p13.Rarity], 0.75);
        end;
    else
        p11.BackgroundColor3 = Color3.fromRGB(80, 80, 80);
    end;

    if p14 == "Mutation" then
        p11.BackgroundColor3 = Color3.fromRGB(133, 82, 51):Lerp(p13.Color, 0.75);
    end;

    p11:FindFirstChild("ITEM_IMAGE").Image = p13.ImageId;
    local ITEM_NAME = p11:FindFirstChild("ITEM_NAME");
    local ITEM_NAME_SHADOW = p11:FindFirstChild("ITEM_NAME_SHADOW");
    local v15 = p13.DisplayName or p13.Name;
    local v16 = SeedData[v15];

    if v16 then
        if v16.DisplayName then
            v15 = v16.DisplayName:gsub("Seed", "") or v15;
        end;
    end;

    ITEM_NAME.Text = v15;
    ITEM_NAME_SHADOW.Text = v15;
    p11:SetAttribute("DetailsId", p13.Name);
    p11:SetAttribute("New", p13.New);
    p11:SetAttribute("Seen", p13.Seen);
    p11:SetAttribute("Rarity", p13.Rarity);
    p11:SetAttribute("Event", p13.Source);
    p11:SetAttribute("Mastered", p13.Mastered);
    ToggleCellUI(p11, p14);

    if p13.Traits then
        p11:SetAttribute("Traits", (p13.Traits:gsub("<[^>]->", "")));
    end;

    p11:FindFirstChild("SENSOR").Interactable = DataService:GetData().GardenGuide[`{p14}Data`][p13.Name] and true or false;
    p11.Visible = true;
end;

function u1.CreateGridCell(u17: userdata, p18: table, p19: string) -- Line: 179
    -- upvalues: GridCellTemplate (copy), u1 (copy), GridCellButtonFunc (copy)
    local u20 = GridCellTemplate:Clone();
    u1.RemakeGridCell(u20, u17, p18, p19);
    local SENSOR = u20:FindFirstChild("SENSOR");
    local u21 = SENSOR.Activated:Connect(function() -- Line: 188
        -- upvalues: GridCellButtonFunc (ref), u20 (copy), u17 (copy)
        GridCellButtonFunc(u20, u17);
    end);
    SENSOR.Destroying:Once(function() -- Line: 191
        -- upvalues: u21 (ref)
        if u21 then
            u21:Disconnect();
            u21 = nil;
        end;
    end);

    return u20;
end;

function u1.UpdateGridCell(p22: string, p23: any, p24: string, p25: userdata) -- Line: 201
    -- upvalues: GridView (copy), GGButtonEffects (copy)
    local v26 = GridView:FindFirstChild((`{p22}Menu`)):FindFirstChild(p24);

    if v26 then
        v26:SetAttribute("New", true);
        v26:SetAttribute("Seen", true);
        local SENSOR = v26:FindFirstChild("SENSOR");
        SENSOR.Interactable = true;
        GGButtonEffects.AddHoverEffect(SENSOR);

        return v26;
    end;
end;

return u1;