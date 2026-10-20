-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../Signal");
local u2 = require("../GuiController");
local u3 = require("../Notification");
require("../ItemImageFinder");
local u4 = require("../ItemNameFinder");
local u5 = require("../ItemRarityFinder");
require("../GardenGuideModules/DataModules/GGStaticData");
local TradeItemHoverController = require(ReplicatedStorage.Modules.TradeControllers.TradeItemHoverController);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local TradeUIUtils = require(ReplicatedStorage.Modules.TradeControllers.TradeUIUtils);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
local FriendsAPI = require(ReplicatedStorage.Modules.FriendsAPI);
local Observers = require(ReplicatedStorage.Modules.Observers);
local u6 = Players.LocalPlayer or Players.PlayerAdded:Wait();
local PlrInventory = u6.PlayerGui.PlrInventory;
local Frame = PlrInventory.Frame;
local ScrollingFrame = Frame.ScrollingFrame;
local TextBox = Frame.Search.TextBox;
local Empty = Frame.Empty;
local TopBtns = Frame.TopBtns;
local Title = Frame.Title;
local Close = Frame.Close;
local AddFriend = Frame.AddFriend;
local Vector = Frame.Headshot.Vector;
local Sort = Frame.Sort;
local Vector2 = Sort.Vector;
local Label = Sort.Label;
local HoverableItemTemplate = ReplicatedStorage.Modules.TradeTokens.Templates.HoverableItemTemplate;
local u7 = {
    Seeds = { "Seed", "SeedPack" },
    Plants = { "Holdable" },
    Pets = { "Pet" },
    Crates = {}
};
local u8 = { "Name", "Rarity" };
local v58 = {
    OnUpdated = v1.new(),
    OnViewPlayerChanged = v1.new(),
    Query = "",
    SortType = "Rarity",
    SortAscending = true,

    Start = function(u9: table) -- Line: 114, Name: Start
        -- upvalues: u2 (copy), PlrInventory (copy), Close (copy), AddFriend (copy), PlayClickSound (copy), StarterGui (copy), TextBox (copy), Sort (copy), TopBtns (copy), u7 (copy), Observers (copy)
        u2:UsePopupAnims(PlrInventory);
        Close.Activated:Connect(function() -- Line: 118
            -- upvalues: u2 (ref), PlrInventory (ref), u9 (copy)
            u2:Close(PlrInventory);

            if u9.Redirect then
                u2:Open(u9.Redirect);
                u9.Redirect = nil;
            end;

            u9:ClearInventory();
        end);
        AddFriend.Activated:Connect(function() -- Line: 128
            -- upvalues: PlayClickSound (ref), u9 (copy), StarterGui (ref)
            PlayClickSound();

            if u9.Player then
                StarterGui:SetCore("PromptSendFriendRequest", u9.Player);
            end;
        end);
        TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 136
            -- upvalues: u9 (copy), TextBox (ref)
            u9.Query = TextBox.Text:lower();
            u9:RefreshDisplay();
        end);
        Sort.Activated:Connect(function() -- Line: 142
            -- upvalues: PlayClickSound (ref), u9 (copy)
            PlayClickSound();
            u9:ToggleSortType();
        end);

        for _, child in TopBtns:GetChildren() do
            if not child:IsA("UIComponent") then
                local Name = child.Name;

                if u7[Name] then
                    child.Activated:Connect(function() -- Line: 157
                        -- upvalues: PlayClickSound (ref), u9 (copy), Name (copy)
                        PlayClickSound();
                        u9:UpdateInventory(Name);
                    end);
                    u9.OnUpdated:Connect(function(p10) -- Line: 162
                        -- upvalues: Name (copy), child (copy)
                        if p10 == Name then
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

        Observers.observePlayer(function(u11) -- Line: 175
            -- upvalues: u9 (copy)
            local u12 = u11:GetAttributeChangedSignal("ViewInventoryPermission"):Connect(function() -- Line: 176
                -- upvalues: u9 (ref), u11 (copy)
                u9.OnViewPlayerChanged:Fire(u11);
            end);

            return function() -- Line: 179
                -- upvalues: u12 (copy)
                u12:Disconnect();
            end;
        end);
    end,

    CanViewInventory = function(p13: table, p14: userdata) -- Line: 185, Name: CanViewInventory
        -- upvalues: FriendsAPI (copy), u6 (copy)
        local Attribute = p14:GetAttribute("ViewInventoryPermission");

        if Attribute == "Everyone" then
            return true;
        end;

        if Attribute == "Friends" then
            return FriendsAPI:IsFriendsWithImmediate(u6, p14);
        end;

        return false;
    end,

    OpenInventory = function(p15: table, p16: userdata, p17: userdata?) -- Line: 196, Name: OpenInventory
        -- upvalues: u3 (copy), ReplicatedStorage (copy), u2 (copy), PlrInventory (copy)
        if not p15:CanViewInventory(p16) then
            u3:CreateNotification("You don\'t have permission to view the inventory of this user", false, 7);

            return;
        end;

        local v18, v19 = ReplicatedStorage.GameEvents.TradeEvents.ViewInventory:InvokeServer(p16);

        if not v18 or typeof(v19) ~= "table" then
            if typeof(v19) == "string" then
                u3:CreateNotification(v19, false, 7);

                return;
            end;

            u3:CreateNotification("Failed to load inventory", false, 7);

            return;
        end;

        p15:SetRedirect(p17);
        p15:SetInventory(p16, v19);
        u2:Open(PlrInventory);
    end,

    SetInventory = function(p20: table, u21: userdata, p22: table) -- Line: 215, Name: SetInventory
        -- upvalues: TextBox (copy), Title (copy), FriendsAPI (copy), u6 (copy), AddFriend (copy), Vector (copy), Players (copy)
        p20.Player = u21;
        p20.Inventory = p22;
        p20.Query = "";
        TextBox.Text = "";
        Title.Text = "@" .. u21.DisplayName .. "\'s Inventory";

        if FriendsAPI:IsFriendsWithImmediate(u6, u21) then
            AddFriend.Visible = false;
        else
            AddFriend.Visible = true;
        end;

        pcall(function() -- Line: 230
            -- upvalues: Vector (ref), Players (ref), u21 (copy)
            Vector.Image = Players:GetUserThumbnailAsync(u21.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48);
        end);
        p20:UpdateInventory("Plants");
    end,

    UpdateInventory = function(p23: table, p24: userdata?) -- Line: 242, Name: UpdateInventory
        if not p23.Inventory then
            warn("Inventory is not loaded");

            return;
        end;

        local v25 = p24 or (p23.CurrentCategory or "Seeds");
        p23.CurrentCategory = v25;
        p23:RefreshDisplay();
        p23.OnUpdated:Fire(v25);
    end,

    RefreshDisplay = function(p26: table) -- Line: 255, Name: RefreshDisplay
        -- upvalues: TradeUIUtils (copy), Empty (copy)
        if not p26.CurrentCategory then
            return;
        end;

        local v27 = p26:FilterItems((p26:GetItemsByCategory(p26.CurrentCategory)));
        local v28 = TradeUIUtils.SortTradeItems(p26.SortType, p26.SortAscending, v27);
        p26:ClearInventory();

        for _, v in v28 do
            p26:CreateItemCard(v);
        end;

        if #v28 == 0 then
            Empty.Visible = true;

            return;
        end;

        Empty.Visible = false;
    end,

    ClearInventory = function(p29: table) -- Line: 275, Name: ClearInventory
        -- upvalues: ScrollingFrame (copy), HoverableItemTemplate (copy)
        for _, child in ScrollingFrame:GetChildren() do
            if not child:IsA("UIComponent") and child ~= HoverableItemTemplate then
                child:Destroy();
            end;
        end;
    end,

    SetRedirect = function(p30: table, p31: userdata?) -- Line: 282, Name: SetRedirect
        p30.Redirect = p31;
    end,

    CreateItemCard = function(p32: table, p33: table) -- Line: 286, Name: CreateItemCard
        -- upvalues: HoverableItemTemplate (copy), TradeItemHoverController (copy), ScrollingFrame (copy)
        local v34 = HoverableItemTemplate:Clone();
        p32:UpdateItemCard(v34, p33);
        v34:SetAttribute("UUID", p33.id);
        v34:AddTag("TradingUserInterfaceTargetable");
        TradeItemHoverController:AddItemToData(p33.id, p33);

        if p33.tradeLock then
            v34.LockIcon.Visible = p33.tradeLock.Type == "Permanent" and true or p33.tradeLock.Type == "Date";
        end;

        v34.Price.Visible = false;
        v34.Visible = true;
        v34.Parent = ScrollingFrame;

        return v34;
    end,

    UpdateItemCard = function(p35: table, p36: any, p37: table) -- Line: 306, Name: UpdateItemCard
        -- upvalues: TradeUIUtils (copy)
        TradeUIUtils.PopulateItemFrame(p36, p37);
    end,

    FilterItems = function(p38: table, p39: table) -- Line: 335, Name: FilterItems
        -- upvalues: u4 (copy)
        if p38.Query == "" then
            return p39;
        end;

        local v40 = {};

        for _, v in p39 do
            if u4(v.data.Name or v.data.ItemName or (v.data.PetType or ""), v.type):lower():find(p38.Query, 1, true) then
                table.insert(v40, v);
            end;
        end;

        return v40;
    end,

    SortItems = function(u41: table, p42: table) -- Line: 353, Name: SortItems
        -- upvalues: u4 (copy), u5 (copy), TokenRAPController (copy)
        local table_clone_ret = table.clone(p42);
        table.sort(table_clone_ret, function(p43, p44) -- Line: 356
            -- upvalues: u41 (copy), u4 (ref), u5 (ref), TokenRAPController (ref)
            local v45 = nil;
            local v46 = nil;

            if u41.SortType == "Name" then
                v45 = u4(p43.data.Name or p43.data.ItemName or (p43.data.PetType or ""), p43.type);
                v46 = u4(p44.data.Name or p44.data.ItemName or (p44.data.PetType or ""), p44.type);
            elseif u41.SortType == "Rarity" then
                local v47 = u5(p43.data.Name or (p43.data.ItemName or p43.data.PetType), p43.type);
                local v48 = u5(p44.data.Name or (p44.data.ItemName or p44.data.PetType), p44.type);
                v45 = v47 and v47.Value or 0;
                v46 = v48 and v48.Value or 0;
            elseif u41.SortType == "RAP" then
                v45 = TokenRAPController:GetRAP(p43.type, p43.data) or 0;
                v46 = TokenRAPController:GetRAP(p44.type, p44.data) or 0;
            end;

            if u41.SortAscending then
                return v45 < v46;
            end;

            return v46 < v45;
        end);

        return table_clone_ret;
    end,

    GetItemsByCategory = function(p49: table, p50: userdata) -- Line: 384, Name: GetItemsByCategory
        -- upvalues: u7 (copy)
        if not p49.Inventory then
            return {};
        end;

        local v51 = u7[p50];

        if not v51 then
            warn((`No category types for {p50}`));

            return {};
        end;

        local v52 = {};

        for _, v in p49.Inventory do
            if table.find(v51, v.type) then
                table.insert(v52, v);
            end;
        end;

        return v52;
    end,

    ToggleSortOrder = function(p53: table, p54: any) -- Line: 405, Name: ToggleSortOrder
        -- upvalues: Vector2 (copy)
        p53.SortAscending = not p53.SortAscending;
        Vector2.Rotation = p53.SortAscending and 180 or 0;

        if p54 == nil or p54 == true then
            p53:RefreshDisplay();
        end;
    end,

    ToggleSortType = function(p55: table) -- Line: 413, Name: ToggleSortType
        -- upvalues: u8 (copy)
        if p55.SortAscending then
            p55:ToggleSortOrder();

            return;
        end;

        p55:ToggleSortOrder(false);
        p55:SetSortType(u8[table.find(u8, p55.SortType) % #u8 + 1]);
    end,

    SetSortType = function(p56: table, p57: userdata) -- Line: 423, Name: SetSortType
        -- upvalues: Label (copy)
        p56.SortType = p57;
        Label.Text = p57;
        p56:RefreshDisplay();
    end
};
task.spawn(v58.Start, v58);

return v58;