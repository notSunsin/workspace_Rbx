-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TradeFindSellerController = require(ReplicatedStorage.Modules.TradeControllers.TradeFindSellerController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.NumberUtil);
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
local TradePlazaUtils = require(ReplicatedStorage.Modules.TradePlaza.TradePlazaUtils);
local VirtualList = require(ReplicatedStorage.Modules.GardenGuideModules.VirtualList);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPUtil);
local ReplicationReciever = require(ReplicatedStorage.Modules.ReplicationReciever);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local TokenRAPs = ReplicationReciever.new("TokenRAPs");
local PlayerGui = Players.LocalPlayer.PlayerGui;
local ButtonColors = SeasonPassStaticData.ButtonColors;
local TradePlazaIndex = PlayerGui:WaitForChild("TradePlazaIndex");
local BuyTokens = PlayerGui:WaitForChild("BuyTokens");
local TokensInfo = PlayerGui:WaitForChild("TokensInfo");
local Frame = TradePlazaIndex.Frame;
local ItemsList = Frame.Sections.ItemsList;
local GridSFrame = ItemsList.GridSFrame;
local ItemsVirtualList = ItemsList.ItemsVirtualList;
local RAPHistory = Frame.Sections.RAPHistory;
local u1 = { "Seeds", "Plants", "Pets", "Crates", "TradeBoothSkins" };
local u2 = "Plants";
local u3 = {
    GridType = "TradePlazaIndex",
    ColumnCount = 7,
    RowCount = 3,
    PoolSize = 21,
    GapSize = 5
};
local u4 = "";
local u5 = 1;
local u6 = { "Rarity Asc", "Rarity Desc" };
local u7 = {};

local function backButtonFunc() -- Line: 53
    -- upvalues: ItemsList (copy), RAPHistory (copy)
    ItemsList.Visible = true;
    RAPHistory.Visible = false;
end;

local function LoadIndexItems(p8: string, p9: string?) -- Line: 59
    -- upvalues: GridSFrame (copy), TradePlazaUtils (copy), u6 (copy), u5 (ref), VirtualList (copy), ItemsVirtualList (copy), u3 (copy)
    GridSFrame.CanvasPosition = Vector2.zero;
    local ItemsForCategory = TradePlazaUtils.GetItemsForCategory(p8, p9);
    TradePlazaUtils.SortItems(ItemsForCategory, u6[u5]);
    VirtualList(ItemsVirtualList, GridSFrame, ItemsForCategory, u3);
end;

local function SetUpSideBar() -- Line: 69
    -- upvalues: Frame (copy), ButtonColors (copy), PlayClickSound (copy), ItemsList (copy), RAPHistory (copy), u1 (copy), u2 (ref), u4 (ref), GridSFrame (copy), TradePlazaUtils (copy), u6 (copy), u5 (ref), VirtualList (copy), ItemsVirtualList (copy), u3 (copy)
    local SideBtns = Frame.SideBtns;

    local function selectThisButton(p10: userdata) -- Line: 72
        -- upvalues: SideBtns (copy), ButtonColors (ref)
        for _, child in SideBtns:GetChildren() do
            if child:IsA("ImageButton") then
                local v11 = child == p10;
                local v12;

                if v11 then
                    v12 = ButtonColors.Green.Background;
                else
                    v12 = ButtonColors.Brown.Background;
                end;

                child.BackgroundColor3 = v12;
                local UIStroke = child:FindFirstChild("UIStroke");

                if UIStroke then
                    local v13;

                    if v11 then
                        v13 = ButtonColors.Green.ButtonStroke;
                    else
                        v13 = ButtonColors.Brown.ButtonStroke;
                    end;

                    UIStroke.Color = v13;
                end;

                local Label = child:FindFirstChild("Label");

                if Label then
                    local UIStroke2 = Label:FindFirstChild("UIStroke");

                    if UIStroke2 then
                        local v14;

                        if v11 then
                            v14 = ButtonColors.Green.TextStroke;
                        else
                            v14 = ButtonColors.Brown.TextStroke;
                        end;

                        UIStroke2.Color = v14;
                    end;
                end;
            end;
        end;
    end;

    for _, child in SideBtns:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 108
                -- upvalues: PlayClickSound (ref), selectThisButton (copy), child (copy), ItemsList (ref), RAPHistory (ref), u1 (ref), u2 (ref), u4 (ref), GridSFrame (ref), TradePlazaUtils (ref), u6 (ref), u5 (ref), VirtualList (ref), ItemsVirtualList (ref), u3 (ref)
                PlayClickSound();
                selectThisButton(child);
                ItemsList.Visible = true;
                RAPHistory.Visible = false;

                if not table.find(u1, child.Name) then
                    warn((`No valid category found for {child.Name}`));

                    return;
                end;

                u2 = child.Name;
                GridSFrame.CanvasPosition = Vector2.zero;
                local ItemsForCategory = TradePlazaUtils.GetItemsForCategory(u2, u4);
                TradePlazaUtils.SortItems(ItemsForCategory, u6[u5]);
                VirtualList(ItemsVirtualList, GridSFrame, ItemsForCategory, u3);
            end);
        end;
    end;
end;

local function SetUpSortButton() -- Line: 126
    -- upvalues: ItemsList (copy), u6 (copy), u5 (ref), PlayClickSound (copy), u2 (ref), u4 (ref), GridSFrame (copy), TradePlazaUtils (copy), VirtualList (copy), ItemsVirtualList (copy), u3 (copy)
    local Sort = ItemsList.Sort;
    Sort.Label.Text = `{u6[u5]:gsub(" Asc", ""):gsub(" Desc", "")}`;
    local string_find_ret = string.find(u6[u5], "Asc");
    local Vector = Sort.Vector;
    Vector.Rotation = string_find_ret and 180 or 0;
    Sort.Activated:Connect(function() -- Line: 134
        -- upvalues: PlayClickSound (ref), u5 (ref), u6 (ref), Sort (copy), Vector (copy), u2 (ref), u4 (ref), GridSFrame (ref), TradePlazaUtils (ref), VirtualList (ref), ItemsVirtualList (ref), u3 (ref)
        PlayClickSound();
        u5 = math.max((u5 + 1) % (#u6 + 1), 1);
        local v15 = u6[u5]:gsub(" Asc", ""):gsub(" Desc", "");
        Sort.Label.Text = `{v15}`;
        Vector.Rotation = string.find(u6[u5], "Asc") and 180 or 0;
        GridSFrame.CanvasPosition = Vector2.zero;
        local ItemsForCategory = TradePlazaUtils.GetItemsForCategory(u2, u4);
        TradePlazaUtils.SortItems(ItemsForCategory, u6[u5]);
        VirtualList(ItemsVirtualList, GridSFrame, ItemsForCategory, u3);
    end);
end;

local function SetUpSearchBar() -- Line: 153
    -- upvalues: Frame (copy), u4 (ref), u2 (ref), GridSFrame (copy), TradePlazaUtils (copy), u6 (copy), u5 (ref), VirtualList (copy), ItemsVirtualList (copy), u3 (copy)
    local SearchBox = Frame.Sections.ItemsList.SearchBox;
    u4 = SearchBox.Text;
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 156
        -- upvalues: u4 (ref), SearchBox (copy), u2 (ref), GridSFrame (ref), TradePlazaUtils (ref), u6 (ref), u5 (ref), VirtualList (ref), ItemsVirtualList (ref), u3 (ref)
        u4 = SearchBox.Text;
        GridSFrame.CanvasPosition = Vector2.zero;
        local ItemsForCategory = TradePlazaUtils.GetItemsForCategory(u2, u4);
        TradePlazaUtils.SortItems(ItemsForCategory, u6[u5]);
        VirtualList(ItemsVirtualList, GridSFrame, ItemsForCategory, u3);
    end);
end;

local function SetUpRAPHistoryButtons() -- Line: 163
    -- upvalues: RAPHistory (copy), PlayClickSound (copy), ItemsList (copy), TradeFindSellerController (copy)
    RAPHistory.Back.Activated:Connect(function() -- Line: 166
        -- upvalues: PlayClickSound (ref), ItemsList (ref), RAPHistory (ref)
        PlayClickSound();
        ItemsList.Visible = true;
        RAPHistory.Visible = false;
    end);
    RAPHistory.FindSellers.Activated:Connect(function() -- Line: 173
        -- upvalues: PlayClickSound (ref), RAPHistory (ref), TradeFindSellerController (ref)
        PlayClickSound();
        local Attribute = RAPHistory:GetAttribute("CurrentItem");
        local Attribute2 = RAPHistory:GetAttribute("CurrentItemType");

        if Attribute and Attribute2 then
            TradeFindSellerController:Prompt(Attribute2, Attribute);

            return;
        end;

        warn((`No current item attribute set: {Attribute}`));
    end);
end;

function u7.Initialize() -- Line: 188
    -- upvalues: u2 (ref), u4 (ref), GridSFrame (copy), TradePlazaUtils (copy), u6 (copy), u5 (ref), VirtualList (copy), ItemsVirtualList (copy), u3 (copy), ItemsList (copy), RAPHistory (copy)
    GridSFrame.CanvasPosition = Vector2.zero;
    local ItemsForCategory = TradePlazaUtils.GetItemsForCategory(u2, u4);
    TradePlazaUtils.SortItems(ItemsForCategory, u6[u5]);
    VirtualList(ItemsVirtualList, GridSFrame, ItemsForCategory, u3);
    ItemsList.Visible = true;
    RAPHistory.Visible = false;
end;

function u7.Start(p16) -- Line: 194
    -- upvalues: GuiController (copy), TradePlazaIndex (copy), DataService (copy), Frame (copy), ItemsVirtualList (copy), u2 (ref), u4 (ref), GridSFrame (copy), TradePlazaUtils (copy), u6 (copy), u5 (ref), VirtualList (copy), u3 (copy), PlayClickSound (copy), Comma_Module (copy), BuyTokens (copy), TokensInfo (copy), SetUpSideBar (copy), SetUpSortButton (copy), u7 (copy), TokenRAPs (copy)
    GuiController:UsePopupAnims(TradePlazaIndex);
    local Data = DataService:GetData();

    if not Data then
        warn("TradeMenuController | No player data found");

        return;
    end;

    Frame.Close.Activated:Connect(function() -- Line: 203
        -- upvalues: GuiController (ref), TradePlazaIndex (ref)
        GuiController:Close(TradePlazaIndex);
    end);
    ItemsVirtualList:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 207
        -- upvalues: u2 (ref), u4 (ref), GridSFrame (ref), TradePlazaUtils (ref), u6 (ref), u5 (ref), VirtualList (ref), ItemsVirtualList (ref), u3 (ref)
        GridSFrame.CanvasPosition = Vector2.zero;
        local ItemsForCategory = TradePlazaUtils.GetItemsForCategory(u2, u4);
        TradePlazaUtils.SortItems(ItemsForCategory, u6[u5]);
        VirtualList(ItemsVirtualList, GridSFrame, ItemsForCategory, u3);
    end);

    local function setupInterfaceToggle(p17, u18, u19) -- Line: 212
        -- upvalues: PlayClickSound (ref), GuiController (ref)
        p17.Activated:Connect(function() -- Line: 213
            -- upvalues: PlayClickSound (ref), u18 (copy), GuiController (ref), u19 (copy)
            PlayClickSound();
            local Close = u18:FindFirstChild("Close", true);

            if Close then
                Close.Activated:Once(function() -- Line: 217
                    -- upvalues: GuiController (ref), u18 (ref), u19 (ref)
                    GuiController:Close(u18);
                    GuiController:Open(u19);
                end);
            end;

            GuiController:Open(u18);
        end);
    end;

    local TokenCounter = TradePlazaIndex.Frame.TokenCounter;
    TokenCounter.Label.Text = `Tokens: {Comma_Module.Comma(Data.TradeData.Tokens)}`;
    DataService:GetPathSignal("TradeData/Tokens"):Connect(function() -- Line: 231
        -- upvalues: TokenCounter (copy), Comma_Module (ref), Data (copy)
        TokenCounter.Label.Text = `Tokens: {Comma_Module.Comma(Data.TradeData.Tokens)}`;
    end);
    local u20 = BuyTokens;
    local u21 = TradePlazaIndex;
    TokenCounter.Buy.Activated:Connect(function() -- Line: 213
        -- upvalues: PlayClickSound (ref), u20 (copy), GuiController (ref), u21 (copy)
        PlayClickSound();
        local Close = u20:FindFirstChild("Close", true);

        if Close then
            Close.Activated:Once(function() -- Line: 217
                -- upvalues: GuiController (ref), u20 (ref), u21 (ref)
                GuiController:Close(u20);
                GuiController:Open(u21);
            end);
        end;

        GuiController:Open(u20);
    end);
    local u22 = TokensInfo;
    local u23 = TradePlazaIndex;
    TokenCounter.Info.Activated:Connect(function() -- Line: 213
        -- upvalues: PlayClickSound (ref), u22 (copy), GuiController (ref), u23 (copy)
        PlayClickSound();
        local Close = u22:FindFirstChild("Close", true);

        if Close then
            Close.Activated:Once(function() -- Line: 217
                -- upvalues: GuiController (ref), u22 (ref), u23 (ref)
                GuiController:Close(u22);
                GuiController:Open(u23);
            end);
        end;

        GuiController:Open(u22);
    end);
    SetUpSideBar();
    local SearchBox = Frame.Sections.ItemsList.SearchBox;
    u4 = SearchBox.Text;
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 156
        -- upvalues: u4 (ref), SearchBox (copy), u2 (ref), GridSFrame (ref), TradePlazaUtils (ref), u6 (ref), u5 (ref), VirtualList (ref), ItemsVirtualList (ref), u3 (ref)
        u4 = SearchBox.Text;
        GridSFrame.CanvasPosition = Vector2.zero;
        local ItemsForCategory = TradePlazaUtils.GetItemsForCategory(u2, u4);
        TradePlazaUtils.SortItems(ItemsForCategory, u6[u5]);
        VirtualList(ItemsVirtualList, GridSFrame, ItemsForCategory, u3);
    end);
    SetUpSortButton();
    u7.Initialize();
    local PathSignal = TokenRAPs:GetPathSignal("RAPs/@");

    if PathSignal then
        PathSignal:Connect(function(p24: string, p25: any, p26: string) -- Line: 248
            -- upvalues: u7 (ref)
            print(p24, p25, p26);
            u7.Initialize();
        end);
    end;

    TokenRAPs:GetDataAsync(20);
end;

if TradeWorldController:IsInWorld() then
    task.spawn(u7.Start, u7);
end;

return u7;