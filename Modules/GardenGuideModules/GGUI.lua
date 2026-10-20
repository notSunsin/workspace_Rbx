-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GardenGuideModules = ReplicatedStorage.Modules.GardenGuideModules;
local GGButtonEffects = require(GardenGuideModules.GGButtonEffects);
local GGData = require(GardenGuideModules.DataModules.GGData);
local Signal = require(ReplicatedStorage.Modules.Signal);
local GardenGuide = Players.LocalPlayer.PlayerGui.GardenGuide;
local MainMenu = GardenGuide.MainMenu;
local MainMenuFrame = MainMenu.MainMenuFrame;
local GridView = MainMenuFrame.GridView;
local CompletionBar = GridView.CompletionBar;
local SearchBar = MainMenuFrame.SearchBar;
local TopBar = MainMenu.TopBar;
local Title = TopBar.Title;
local Exit = TopBar.ControlFrame.Exit;
local Back = TopBar.ControlFrame.Back;
local FilterSidebar = GardenGuide.MainMenu.FilterSidebar;
local Sort = FilterSidebar.Main.Sort;
local _ = TopBar.SORT_BUTTON.Main.SENSOR;
local Filter = FilterSidebar.Main.Filter;
local _ = TopBar.FILTER_BUTTON.Main.SENSOR;
local u1 = {
    GridSFrame = GridView.GridSFrame,
    SearchBar = SearchBar,
    OnPageOrderUpdate = Signal.new(),
    PageOrder = {},
    PrevPage = nil,
    CurrentPage = nil,
    CurrentDetail = nil,
    FilterAlgo = nil,
    FilterType = nil,
    SortAlgo = nil
};

function u1.GoNextPage(p2: userdata, p3: userdata, p4: boolean?) -- Line: 53
    -- upvalues: GGButtonEffects (copy), u1 (copy), Exit (copy), Back (copy)
    if not p4 then
        GGButtonEffects.Click();
    end;

    p2.Visible = true;
    p3.Visible = false;
    u1.CurrentPage = p2;
    u1.PrevPage = p3;

    if #u1.PageOrder == 0 then
        table.insert(u1.PageOrder, p3);
    end;

    table.insert(u1.PageOrder, p2);
    u1.OnPageOrderUpdate:Fire();

    if #u1.PageOrder > 1 then
        Exit.Visible = true;
        Back.Visible = true;

        return;
    end;

    Exit.Visible = true;
    Back.Visible = false;
end;

function u1.GoBackPage() -- Line: 79
    -- upvalues: GGButtonEffects (copy), u1 (copy), Exit (copy), Back (copy)
    GGButtonEffects.Click();
    local v5 = u1.PageOrder[#u1.PageOrder];
    local v6 = u1.PageOrder[#u1.PageOrder - 1];
    v6.Visible = true;
    v5.Visible = false;
    table.remove(u1.PageOrder, #u1.PageOrder);
    u1.CurrentPage = v6;
    u1.PrevPage = v5;
    local v7 = u1.CurrentPage.Name:gsub("Menu", ""):gsub("View", "");
    u1.ChangeTopBar(v7, string.find(u1.CurrentPage.Name, "Menu") and true or false);

    if u1.CurrentDetail then
        u1.CurrentDetail:Destroy();
    end;

    if #u1.PageOrder > 1 then
        Exit.Visible = true;
        Back.Visible = true;
        u1.CurrentDetail = u1.CurrentPage;
    else
        Exit.Visible = true;
        Back.Visible = false;
        table.remove(u1.PageOrder, #u1.PageOrder);
    end;

    u1.OnPageOrderUpdate:Fire();
end;

function u1.NewPageOrder(p8: userdata, p9: userdata?) -- Line: 111
    -- upvalues: u1 (copy), Exit (copy), Back (copy)
    if p9 then
        p9.Visible = false;
    end;

    p8.Visible = true;
    u1.CurrentPage = p8;
    Exit.Visible = true;
    Back.Visible = false;
    u1.PageOrder = { p8 };
    u1.OnPageOrderUpdate:Fire();
end;

function u1.ChangeTopBar(p10: string, p11: boolean) -- Line: 127
    -- upvalues: GGData (copy), Title (copy), TopBar (copy), u1 (copy), Sort (copy), Filter (copy), FilterSidebar (copy), CompletionBar (copy), SearchBar (copy), GridView (copy)
    if GGData[p10] then
        Title.Text = `{p10}s`;
        TopBar.SORT_BUTTON.Visible = p11;
        TopBar.FILTER_BUTTON.Visible = p11;
    else
        Title.Text = p10;
        TopBar.SORT_BUTTON.Visible = false;
        TopBar.FILTER_BUTTON.Visible = false;
    end;

    u1.SortAlgo = nil;
    u1.FilterAlgo = nil;
    u1.FilterType = nil;
    Sort.Visible = false;
    Filter.Visible = false;
    FilterSidebar.Visible = false;
    CompletionBar.Visible = p11;
    SearchBar.Visible = p11;
    SearchBar.Main.TextBox.Text = "";
    GridView.Visible = p11;
    u1.GridSFrame.Visible = p11;
end;

return u1;