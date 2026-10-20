-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(script.Parent.VListTypes);
local VListCellRenderers = require(script.Parent.VListCellRenderers);
local GGData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGData);
local GGUI = require(ReplicatedStorage.Modules.GardenGuideModules.GGUI);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local DetailsViewHandler = require(ReplicatedStorage.Modules.GardenGuideModules.DetailsViewHandler);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local TokenRAPChartController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPChartController);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
require(ReplicatedStorage.Modules.NumberUtil);
local GardenGuide_RE_MarkOffNew = ReplicatedStorage.GameEvents.GardenGuide.GardenGuide_RE_MarkOffNew;
local PlayerGui = Players.LocalPlayer.PlayerGui;
local _ = ReplicatedStorage.Data.TradePlaza.IndexTemplates.ItemTemplate;
local RarityColorMap = GGStaticData.RarityColorMap;
local _ = GGStaticData.AnimatedColors;

return {
    GardenGuide = function(p1, p2, p3) -- Line: 31
        -- upvalues: GGData (copy), GardenGuide_RE_MarkOffNew (copy), VListCellRenderers (copy), PlayerGui (copy), GGUI (copy), DetailsViewHandler (copy)
        local v4 = p3.DataType or "";

        if not GGData[v4] then
            warn((`No data for {v4} in GGData`));

            return;
        end;

        local Data = GGData[v4].Data;
        local v5 = Data[p1.Name] or Data[p1.Name:gsub(" ", "")];

        if not v5 then
            warn((`No data for {p1.Name} in {v4}Data`));

            return;
        end;

        if not p1.Parent then
            warn("No prev page for passing datatype");

            return;
        end;

        local v6 = p1.Parent.Name:gsub("Menu", "");
        GardenGuide_RE_MarkOffNew:FireServer(v6, v5.Name);
        p1:SetAttribute("New", false);
        VListCellRenderers.ToggleGGCellUI(p1, p2, p3);
        v5.New = false;
        p1.Parent.Visible = false;
        local MainMenu = PlayerGui.GardenGuide.MainMenu;
        local MainMenuFrame = MainMenu.MainMenuFrame;
        local _ = MainMenu.TopBar;
        local SearchBar = MainMenuFrame.SearchBar;
        local FilterSidebar = MainMenu.FilterSidebar;
        local Sort = FilterSidebar.Main.Sort;
        local Filter = FilterSidebar.Main.Filter;
        FilterSidebar.Visible = false;
        Sort.Visible = false;
        Filter.Visible = false;
        local Text = SearchBar.Main.TextBox.Text;
        GGUI.ChangeTopBar(v5.DisplayName or v5.Name, false);
        SearchBar.Main.TextBox.Text = Text;
        local v7 = MainMenuFrame:FindFirstChild((`{v5.Name}Details`));

        if not v7 then
            if GGUI.CurrentDetail then
                GGUI.CurrentDetail:Destroy();
            end;

            v7 = DetailsViewHandler.CreateDetailsView(MainMenuFrame, v5, v6);
        end;

        if v7 then
            v7.Visible = true;
            GGUI.CurrentDetail = v7;
        end;

        GGUI.GoNextPage(v7, p1.Parent);
    end,

    TradePlazaIndex = function(u8, p9) -- Line: 90
        -- upvalues: PlayClickSound (copy), PlayerGui (copy), RarityColorMap (copy), TokenRAPChartController (copy)
        PlayClickSound();
        local Attribute = u8:GetAttribute("Name");
        local Attribute2 = u8:GetAttribute("ImageId");
        local Attribute3 = u8:GetAttribute("Rarity");
        local Attribute4 = u8:GetAttribute("ItemID");
        local Attribute5 = u8:GetAttribute("ItemType");
        local Frame = PlayerGui:WaitForChild("TradePlazaIndex").Frame;
        local ItemsList = Frame.Sections.ItemsList;
        local RAPHistory = Frame.Sections.RAPHistory;
        RAPHistory:SetAttribute("CurrentItem", Attribute);
        RAPHistory:SetAttribute("CurrentItemType", Attribute5);
        RAPHistory.Title.Text = `{Attribute}`;
        RAPHistory.ItemImg.Image = Attribute2;
        local RarityArea = RAPHistory.RarityArea;
        local v10;

        if Attribute3 then
            v10 = RarityColorMap[Attribute3];
        else
            v10 = Color3.fromRGB();
        end;

        RarityArea.BackgroundColor3 = v10;
        RarityArea.TextLabel.Text = not Attribute3 and "No Rarity" or `{Attribute3}`;
        local Amount = RAPHistory.Price.Amount;
        u8:GetAttributeChangedSignal("RAPValue"):Connect(function() -- Line: 119, Name: updateRap
            -- upvalues: u8 (copy), Amount (copy)
            local Attribute6 = u8:GetAttribute("RAPValue");
            Amount.Text = Attribute6 and `{Attribute6}` or "??";

            return nil;
        end);
        local Attribute6 = u8:GetAttribute("RAPValue");
        Amount.Text = Attribute6 and `{Attribute6}` or "??";
        TokenRAPChartController:Show(Attribute5, Attribute4);
        ItemsList.Visible = false;
        RAPHistory.Visible = true;
    end,

    TradeBoothInventory = function(p11, p12) -- Line: 134
        -- upvalues: PlayClickSound (copy), DataService (copy), Notification (copy), PlayerGui (copy), ReplicatedStorage (copy)
        PlayClickSound();
        local TradeData = DataService:GetData().TradeData;
        local Item = p12.Item;

        if TradeData.TradeLocks[Item.type] and TradeData.TradeLocks[Item.type][Item.id] then
            Notification:CreateNotification("This item is on trade cooldown, you can\'t list it!");

            return;
        end;

        local TradeBoothInventory = PlayerGui.TradeBoothInventory;

        if TradeBoothInventory.Frame.RightSide.RightSideFrame.Visible and TradeBoothInventory.Frame.RightSide.RightSideFrame.Item.ITEM_NAME.Text == Item.data.ItemName then
            TradeBoothInventory.Frame.RightSide.RightSideFrame.Visible = false;

            return;
        end;

        require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothCreateListingController):PromptListItem(Item, TradeBoothInventory);
    end
};