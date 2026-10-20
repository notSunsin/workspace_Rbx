-- Decompiled with Potassium's decompiler.

local GardenGuide = game:GetService("Players").LocalPlayer.PlayerGui.GardenGuide;
local MainMenu = GardenGuide.MainMenu;
local MainMenuFrame = MainMenu.MainMenuFrame;
local GridView = MainMenuFrame.GridView;
local TopBar = MainMenu.TopBar;
local FilterSidebar = MainMenu.FilterSidebar;

return {
    GardenGuideScreen = GardenGuide,
    MainMenu = MainMenu,
    MainMenuFrame = MainMenuFrame,
    GridView = GridView,
    MenuGrids = GridView.GridSFrame,
    CompletionBar = GridView.CompletionBar,
    DailyQuestView = MainMenuFrame.DailyQuestView,
    PlayerStatsView = MainMenuFrame.PlayerStatsView,
    AchievementsView = MainMenuFrame.AchievementsView,
    TopBar = TopBar,
    TitleLabel = TopBar.Title,
    ExitFrame = TopBar.ControlFrame.Exit,
    BackFrame = TopBar.ControlFrame.Back,
    SideMenuButtons = MainMenu.SideMenu.Main.ButtonHolder,
    DropDownMenus = FilterSidebar,
    SortDropDown = FilterSidebar.Main.Sort,
    SortButton = TopBar.SORT_BUTTON.Main.SENSOR,
    FilterDropDown = FilterSidebar.Main.Filter,
    FilterButton = TopBar.FILTER_BUTTON.Main.SENSOR
};