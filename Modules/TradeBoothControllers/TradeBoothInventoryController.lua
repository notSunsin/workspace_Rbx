-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Signal = require(ReplicatedStorage.Modules.Signal);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Notification = require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
require(ReplicatedStorage.Modules.ItemRarityFinder);
require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local DeepCopy = require(ReplicatedStorage.UserGenerated.Collections.DeepCopy);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Data.TradeData);
local TradeItemHoverController = require(ReplicatedStorage.Modules.TradeControllers.TradeItemHoverController);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local TradeUIUtils = require(ReplicatedStorage.Modules.TradeControllers.TradeUIUtils);
require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
require(ReplicatedStorage.Modules.GardenGuideModules.VirtualList);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local TradeBoothInventory = PlayerGui.TradeBoothInventory;
local Frame = TradeBoothInventory.Frame;
local ScrollingFrame = Frame.ScrollingFrame;
local SearchBox = Frame.SearchFrame.SearchBox;
local Empty = Frame.Empty;
local TopBtns = Frame.TopBtns;
local Close = Frame.Close;
local Sort = Frame.Sort;
local Vector = Sort.Vector;
local Label = Sort.Label;
local HoverableItemTemplate = ReplicatedStorage.Modules.TradeTokens.Templates.HoverableItemTemplate;
local u1 = {
    Seeds = { "Seed", "SeedPack" },
    Plants = { "Holdable" },
    Pets = { "Pet" },
    TradeBoothSkins = { "TradeBoothSkin" },
    Crates = {}
};
local u2 = { "Name", "Rarity" };
local v3 = {
    _cache = {},
    OnUpdated = Signal.new(),
    Query = "",
    SortType = "Rarity",
    SortAscending = true
};

local function IsFavourited(p4) -- Line: 113
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("No player data");

        return;
    end;

    if not Data.PetsData then
        warn("No pet data");

        return;
    end;

    if Data.InventoryData then
        local v5 = false;
        local v6 = Data.InventoryData[p4.id];
        local v7 = Data.PetsData.PetInventory.Data[p4.id];

        if v6 then
            return v6.ItemData.IsFavorite or false;
        end;

        if v7 then
            v5 = v7.PetData.IsFavorite or false;
        end;

        return v5;
    end;

    warn("No item inventory data");
end;

function v3.Start(u8: table) -- Line: 146
    -- upvalues: GuiController (copy), TradeBoothInventory (copy), Close (copy), SearchBox (copy), Sort (copy), PlayClickSound (copy), TopBtns (copy), u1 (copy), DataService (copy), DeepCopy (copy), PlayerGui (copy)
    GuiController:UsePopupAnims(TradeBoothInventory);
    Close.Activated:Connect(function() -- Line: 150
        -- upvalues: GuiController (ref), TradeBoothInventory (ref), u8 (copy)
        GuiController:Close(TradeBoothInventory);

        if u8.Redirect then
            GuiController:Open(u8.Redirect);
            u8.Redirect = nil;
        end;

        u8:ClearInventory();
    end);
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 160
        -- upvalues: u8 (copy), SearchBox (ref)
        u8.Query = SearchBox.Text:lower();
        u8:RefreshDisplay();
    end);
    Sort.Activated:Connect(function() -- Line: 166
        -- upvalues: PlayClickSound (ref), u8 (copy)
        PlayClickSound();
        u8:ToggleSortType();
    end);

    for _, child in TopBtns:GetChildren() do
        if not child:IsA("UIComponent") then
            local Name = child.Name;

            if u1[Name] then
                child.Activated:Connect(function() -- Line: 181
                    -- upvalues: PlayClickSound (ref), u8 (copy), Name (copy)
                    PlayClickSound();
                    u8:UpdateInventory(Name);
                end);
                u8.OnUpdated:Connect(function(p9) -- Line: 186
                    -- upvalues: Name (copy), child (copy)
                    if p9 == Name then
                        child.BackgroundColor3 = Color3.new(0.2, 0.9, 0.2);
                        child.UIStroke.Color = Color3.new(0, 0.6, 0);
                        child.Label.UIStroke.Color = Color3.new(0, 0.3, 0);

                        return;
                    end;

                    child.BackgroundColor3 = Color3.new(0.5, 0.3, 0.2);
                    child.UIStroke.Color = Color3.new(0.4, 0.25, 0.15);
                    child.Label.UIStroke.Color = Color3.new(0.25, 0.15, 0);
                end);
            else
                warn((`No category types for {Name}`));
            end;
        end;
    end;

    local StateForGui = GuiController:GetStateForGui(TradeBoothInventory);
    local Data = DataService:GetData();

    local function buildInventory() -- Line: 203
        -- upvalues: Data (copy), DeepCopy (ref)
        local v10 = {};

        for i, v in Data.InventoryData do
            if v.ItemType == "Holdable" or v.ItemType == "Packaged Seed" then
                local v11 = {
                    id = i,
                    type = v.ItemType,
                    data = DeepCopy(v.ItemData)
                };
                v11.tradeLock = Data.TradeData.TradeLocks[v.ItemType] and Data.TradeData.TradeLocks[v.ItemType][i];
                table.insert(v10, v11);
            end;
        end;

        for i, v in Data.PetsData.PetInventory.Data do
            if not Data.SummerFireEventData or Data.SummerFireEventData.RitualPet ~= i then
                local v12 = {
                    type = "Pet",
                    id = i,
                    data = DeepCopy(v)
                };
                v12.tradeLock = Data.TradeData.TradeLocks.Pet and Data.TradeData.TradeLocks.Pet[i];
                table.insert(v10, v12);
            end;
        end;

        for i, v in Data.TradeBoothSkinData.OwnedSkins do
            if typeof(v) ~= "boolean" and v > 0 then
                local v13 = {
                    type = "TradeBoothSkin",
                    id = i,
                    data = {
                        SkinID = i
                    }
                };
                v13.tradeLock = Data.TradeData.TradeLocks.TradeBoothSkin and Data.TradeData.TradeLocks.TradeBoothSkin[i];
                table.insert(v10, v13);
            end;
        end;

        return v10;
    end;

    DataService:GetPathSignal("PetsData/PetInventory/Data/*"):Connect(function() -- Line: 259
        -- upvalues: buildInventory (copy), u8 (copy), StateForGui (copy)
        u8.Inventory = buildInventory();

        if StateForGui.Visible:Get() and u8.CurrentCategory == "Pets" then
            u8:UpdateInventory(u8.CurrentCategory);
        end;
    end);
    DataService:GetPathSignal("InventoryData/*"):Connect(function() -- Line: 262
        -- upvalues: buildInventory (copy), u8 (copy), StateForGui (copy)
        u8.Inventory = buildInventory();

        if StateForGui.Visible:Get() and u8.CurrentCategory == "Holdable" then
            u8:UpdateInventory(u8.CurrentCategory);
        end;
    end);
    DataService:GetPathSignal("TradeBoothSkinData/OwnedSkins/*"):Connect(function() -- Line: 265
        -- upvalues: buildInventory (copy), u8 (copy), StateForGui (copy)
        u8.Inventory = buildInventory();

        if StateForGui.Visible:Get() and u8.CurrentCategory == "TradeBoothSkins" then
            u8:UpdateInventory(u8.CurrentCategory);
        end;
    end);
    task.spawn(function(p14) -- Line: 249, Name: updateInventory
        -- upvalues: buildInventory (copy), u8 (copy), StateForGui (copy)
        u8.Inventory = buildInventory();

        if StateForGui.Visible:Get() and (p14 == nil or p14 == u8.CurrentCategory) then
            u8:UpdateInventory(u8.CurrentCategory);
        end;
    end);
    StateForGui.Visible:Observe(function(p15: boolean) -- Line: 270
        -- upvalues: u8 (copy), SearchBox (ref)
        if p15 then
            u8:UpdateInventory("Plants");

            return;
        end;

        u8.Query = "";
        SearchBox.Text = "";
    end);
    PlayerGui:WaitForChild("TradeItemHover").TradeItemHover.CanvasGroup.GroupTransparency = 1;
end;

function v3.SetRedirect(p16: table, p17: userdata?) -- Line: 285
    p16.Redirect = p17;
end;

function v3.CreateItemCard(p18: table, u19: any) -- Line: 289
    -- upvalues: HoverableItemTemplate (copy), TradeItemHoverController (copy), IsFavourited (copy), TradeBoothInventory (copy), PlayClickSound (copy), DataService (copy), Notification (copy), ReplicatedStorage (copy), ScrollingFrame (copy)
    local v20 = HoverableItemTemplate:Clone();
    p18:UpdateItemCard(v20, u19);
    v20:SetAttribute("UUID", u19.id);
    v20:AddTag("TradingUserInterfaceTargetable");
    TradeItemHoverController:AddItemToData(u19.id, u19);

    if u19.tradeLock then
        v20.LockIcon.Visible = u19.tradeLock.Type == "Permanent" and true or u19.tradeLock.Type == "Date";
    end;

    v20.FavIcon.Visible = IsFavourited(u19);
    TradeBoothInventory.Frame.RightSide.RightSideFrame:SetAttribute("ItemID", u19.id);
    local u21 = v20.SENSOR.Activated:Connect(function() -- Line: 307
        -- upvalues: PlayClickSound (ref), DataService (ref), u19 (copy), Notification (ref), TradeBoothInventory (ref), IsFavourited (ref), ReplicatedStorage (ref)
        PlayClickSound();
        local Data = DataService:GetData();

        if Data.TradeData.TradeLocks[u19.type] and Data.TradeData.TradeLocks[u19.type][u19.id] then
            Notification:CreateNotification("This item is on trade cooldown, you can\'t list it!");
            TradeBoothInventory.Frame.RightSide.RightSideFrame.Visible = false;

            return;
        end;

        if IsFavourited(u19) then
            Notification:CreateNotification("This item is favorited, you can\'t list it!");
            TradeBoothInventory.Frame.RightSide.RightSideFrame.Visible = false;

            return;
        end;

        if TradeBoothInventory.Frame.RightSide.RightSideFrame.Visible and TradeBoothInventory.Frame.RightSide.RightSideFrame:GetAttribute("ItemID") == u19.id then
            TradeBoothInventory.Frame.RightSide.RightSideFrame.Visible = false;

            return;
        end;

        require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothCreateListingController):PromptListItem(u19, TradeBoothInventory);
    end);
    v20.Destroying:Once(function() -- Line: 339
        -- upvalues: u21 (copy)
        u21:Disconnect();
    end);
    v20.Visible = true;
    v20.Parent = ScrollingFrame;
    p18._cache[u19.id] = v20;

    return v20;
end;

function v3.UpdateItemCard(p22: table, p23: any, p24: any) -- Line: 351
    -- upvalues: TradeUIUtils (copy)
    TradeUIUtils.PopulateItemFrame(p23, p24);
end;

function v3.FilterItems(p25: table, p26: table) -- Line: 355
    -- upvalues: DataService (copy), ItemNameFinder (copy)
    local v27 = {};

    for _, v in DataService:GetData().TradeData.Listings do
        v27[v.ItemId] = true;
    end;

    if p25.Query == "" then
        local v28 = {};

        for _, v in p26 do
            if not v27[v.id] then
                table.insert(v28, v);
            end;
        end;

        return v28;
    end;

    local v29 = {};

    for _, v in p26 do
        if not v27[v.id] and ItemNameFinder(v.data.Name or v.data.ItemName or (v.data.PetType or ""), v.type):lower():find(p25.Query, 1, true) then
            table.insert(v29, v);
        end;
    end;

    return v29;
end;

function v3.GetItemsByCategory(p30: table, p31: userdata) -- Line: 392
    -- upvalues: DataService (copy), u1 (copy)
    if not p30.Inventory then
        return {};
    end;

    local Data = DataService:GetData();

    if Data then
        local v32 = u1[p31];

        if not v32 then
            warn((`No category types for {p31}`));

            return {};
        end;

        local v33 = {};

        for _, v in p30.Inventory do
            if table.find(v32, v.type) and (v.type ~= "TradeBoothSkin" or v.id ~= "Default" and v.id ~= Data.TradeBoothSkinData.CurrentSkin) then
                table.insert(v33, v);
            end;
        end;

        return v33;
    end;
end;

function v3.UpdateInventory(p34: table, p35: userdata?) -- Line: 423
    if not p34.Inventory then
        warn("Inventory is not loaded");

        return;
    end;

    local v36 = p35 or (p34.CurrentCategory or "Seeds");
    p34.CurrentCategory = v36;
    p34:RefreshDisplay();
    p34.OnUpdated:Fire(v36);
end;

function v3.RefreshDisplay(p37: table) -- Line: 436
    -- upvalues: TradeUIUtils (copy), Empty (copy), TradeBoothInventory (copy)
    if not p37.CurrentCategory then
        return;
    end;

    local v38 = p37:FilterItems((p37:GetItemsByCategory(p37.CurrentCategory)));
    local v39 = TradeUIUtils.SortTradeItems(p37.SortType, p37.SortAscending, v38);
    local v40 = {};

    for i, v in v39 do
        v40[v.id] = true;
        local v41 = p37._cache[v.id];

        if v41 then
            p37:UpdateItemCard(v41, v);
            v41.LayoutOrder = i;
        else
            p37:CreateItemCard(v).LayoutOrder = i;
        end;
    end;

    for i, v in p37._cache do
        if not v40[i] then
            v:Destroy();
            p37._cache[i] = nil;
        end;
    end;

    if #v39 == 0 then
        Empty.Visible = true;
    else
        Empty.Visible = false;
    end;

    TradeBoothInventory.Frame.RightSide.RightSideFrame.Visible = false;
end;

function v3.ClearInventory(p42: table) -- Line: 487
    -- upvalues: ScrollingFrame (copy), HoverableItemTemplate (copy)
    for _, child in ScrollingFrame:GetChildren() do
        if not child:IsA("UIComponent") and child ~= HoverableItemTemplate then
            child:Destroy();
        end;
    end;

    table.clear(p42._cache);
end;

function v3.ToggleSortOrder(p43: table, p44: any) -- Line: 496
    -- upvalues: Vector (copy)
    p43.SortAscending = not p43.SortAscending;
    Vector.Rotation = p43.SortAscending and 180 or 0;

    if p44 == nil or p44 == true then
        p43:RefreshDisplay();
    end;
end;

function v3.ToggleSortType(p45: table) -- Line: 504
    -- upvalues: u2 (copy)
    if p45.SortAscending then
        p45:ToggleSortOrder();

        return;
    end;

    p45:ToggleSortOrder(false);
    p45:SetSortType(u2[table.find(u2, p45.SortType) % #u2 + 1]);
end;

function v3.SetSortType(p46: table, p47: userdata) -- Line: 514
    -- upvalues: Label (copy)
    p46.SortType = p47;
    Label.Text = p47;
    p46:RefreshDisplay();
end;

if TradeWorldController:IsInWorld() then
    task.spawn(v3.Start, v3);
end;

return v3;