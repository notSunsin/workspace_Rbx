-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
require(ReplicatedStorage.Data.TradeData);
local TradingController = require(ReplicatedStorage.Modules.TradeControllers.TradingController);
require(ReplicatedStorage.Modules.NumberUtil);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local AddToHistory = ReplicatedStorage.GameEvents.TradeEvents.Booths.AddToHistory;
local LocalPlayer = Players.LocalPlayer;
local TradeBoothHistory = LocalPlayer.PlayerGui.TradeBoothHistory;
local Close = TradeBoothHistory.Frame.Close;
local Sort = TradeBoothHistory.Frame.Sort;
local SearchBox = TradeBoothHistory.Frame.SearchFrame.SearchBox;
local ScrollingFrame = TradeBoothHistory.Frame.ScrollingFrame;
local BoothHistoryTemplate = ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothUITemplates.BoothHistoryTemplate;
local u1 = nil;
local u2 = nil;
local u3 = {};
local u4 = {};
local u5 = 0;
local u6 = workspace:GetServerTimeNow() - 2592000;
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size420x420 = Enum.ThumbnailSize.Size420x420;
local u7 = { "All", "Purchases", "Sales" };
local u8 = { "Asc", "Desc" };
local u9 = 1;
local u10 = 1;
local v11 = {};

local function AddToBoothHistory(p12) -- Line: 52
    -- upvalues: u3 (copy), BoothHistoryTemplate (copy), u4 (copy), u5 (ref), LocalPlayer (copy), Players (copy), HeadShot (copy), Size420x420 (copy), ItemNameFinder (copy), ItemImageFinder (copy), ScrollingFrame (copy)
    local id = p12.id;
    local v13 = u3[id];

    if not v13 then
        local v14 = BoothHistoryTemplate:Clone();
        u4[id] = p12;
        u5 = u5 + 1;
        u3[id] = v14;
        v13 = u3[id];
    end;

    local v15 = LocalPlayer.UserId == p12.seller.userId;
    local Title = v13.Spacer.Title;
    local Label = Title.Label;

    if p12.status.result == "Failed" then
        Label.Text = "Failed";
    else
        Label.Text = v15 and "Sold" or "Purchased";
    end;

    local v16;

    if v15 then
        v16 = Color3.fromRGB(255, 52, 52);
    else
        v16 = Color3.fromRGB(53, 255, 66);
    end;

    Label.TextColor3 = v16;
    local v17;

    if v15 then
        v17 = p12.buyer.username;
    else
        v17 = p12.seller.username;
    end;

    Title.PlrName.Text = v17;
    local v18;

    if v15 then
        v18 = p12.buyer.userId;
    else
        v18 = p12.seller.userId;
    end;

    Title.Frame.Headshot.Image = Players:GetUserThumbnailAsync(v18, HeadShot, Size420x420);

    if not p12.item.data then
        warn("Missing log item data?", p12);

        return;
    end;

    local v19;

    if p12.item.data.ItemData then
        v19 = p12.item.data.ItemData.ItemName;
    else
        v19 = p12.item.data.PetType or (p12.item.data.SkinID or "");
    end;

    v13.Spacer.ItemName.Text = ItemNameFinder(v19, p12.item.type);
    v13.Spacer.Time.Text = `{os.date("%I:%M %p (%x)", p12.finishTime)}`;
    v13.Spacer.Price.Amount.Text = `{p12.price}`;
    v13.Spacer.Item.ITEM_IMAGE.Image = ItemImageFinder(v19, p12.item.type);
    v13.Parent = ScrollingFrame;
    v13.Visible = true;
end;

local function InitializeBoothHistory() -- Line: 120
    -- upvalues: TradingController (copy), u6 (copy), u5 (ref), AddToBoothHistory (copy)
    local v20, v21 = TradingController:FetchBoothHistory();

    if not v20 then
        warn("Failed to find booth history on load.");
        v21 = {};
    end;

    local table_clone_ret = table.clone(v21);
    table.sort(table_clone_ret, function(p22, p23) -- Line: 130
        return p22.finishTime > p23.finishTime;
    end);

    for _, v in table_clone_ret do
        if v.status.result ~= "Failed" and (v.seller and (v.buyer and v.finishTime >= u6)) then
            if u5 > 50 then
                break;
            end;

            AddToBoothHistory(v);
        end;
    end;
end;

local function FilterAndSort() -- Line: 156
    -- upvalues: u7 (copy), u9 (ref), u4 (copy), LocalPlayer (copy), u3 (copy), u2 (ref), u8 (copy), u10 (ref)
    local v24 = u7[u9];
    local v25 = {};

    for _, v in u4 do
        local v26 = LocalPlayer.UserId == v.seller.userId;
        local v27 = {
            Log = v,
            UI = u3[v.id]
        };
        u3[v.id].Visible = false;

        if v24 == "Purchases" and not v26 then
            u3[v.id].Visible = true;
        elseif v24 == "Sales" and v26 then
            u3[v.id].Visible = true;
        elseif v24 == "All" then
            u3[v.id].Visible = true;
        end;

        if #u2 > 0 then
            local string_find_ret = string.find(string.lower(v.seller.username), u2);
            local string_find_ret2 = string.find(string.lower(v.buyer.username), u2);
            local v28;

            if v.item.data.ItemData then
                v28 = v.item.data.ItemData.ItemName;
            else
                v28 = v.item.data.PetType or "";
            end;

            if string_find_ret or (string_find_ret2 or string.find(string.lower(v28), u2)) then
                table.insert(v25, v27);
            else
                u3[v.id].Visible = false;
            end;
        else
            table.insert(v25, v27);
        end;
    end;

    if u8[u10] == "Desc" then
        table.sort(v25, function(p29, p30) -- Line: 197
            return p29.Log.finishTime < p30.Log.finishTime;
        end);
    else
        table.sort(v25, function(p31, p32) -- Line: 201
            return p31.Log.finishTime > p32.Log.finishTime;
        end);
    end;

    for i, v in v25 do
        v.UI.LayoutOrder = i;
    end;
end;

local function SetUpSortButton() -- Line: 212
    -- upvalues: u8 (copy), u10 (ref), TradeBoothHistory (copy), Sort (copy), u9 (ref), u7 (copy), FilterAndSort (copy)
    TradeBoothHistory.Frame.Sort.Vector.Rotation = u8[u10] == "Asc" and 180 or 0;
    Sort.Activated:Connect(function() -- Line: 218
        -- upvalues: u10 (ref), u9 (ref), u7 (ref), u8 (ref), FilterAndSort (ref), TradeBoothHistory (ref)
        if u10 == 2 then
            u9 = math.max((u9 + 1) % (#u7 + 1), 1);
        end;

        u10 = math.max((u10 + 1) % (#u8 + 1), 1);
        FilterAndSort();
        local v33 = u8[u10];
        TradeBoothHistory.Frame.Sort.Label.Text = `{u7[u9]}`;
        TradeBoothHistory.Frame.Sort.Vector.Rotation = v33 == "Asc" and 180 or 0;
    end);
end;

function v11.Start(p34) -- Line: 240
    -- upvalues: TradeWorldController (copy), Close (copy), GuiController (copy), TradeBoothHistory (copy), u1 (ref), SearchBox (copy), u2 (ref), FilterAndSort (copy), AddToHistory (copy), AddToBoothHistory (copy), u8 (copy), u10 (ref), Sort (copy), u9 (ref), u7 (copy), InitializeBoothHistory (copy)
    if not TradeWorldController:IsInWorld() then
        return;
    end;

    Close.Activated:Connect(function() -- Line: 246
        -- upvalues: GuiController (ref), TradeBoothHistory (ref), u1 (ref)
        GuiController:Close(TradeBoothHistory);

        if u1 then
            GuiController:Open(u1);
            u1 = nil;
        end;
    end);
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 255
        -- upvalues: u2 (ref), SearchBox (ref), FilterAndSort (ref)
        u2 = string.lower(SearchBox.Text);
        FilterAndSort();
    end);
    GuiController:GetStateForGui(TradeBoothHistory).Visible:Observe(function(p35: boolean) -- Line: 262
        -- upvalues: u2 (ref), SearchBox (ref)
        if p35 then
            return;
        end;

        u2 = "";
        SearchBox.Text = u2;
    end);
    AddToHistory.OnClientEvent:Connect(function(p36) -- Line: 273
        -- upvalues: AddToBoothHistory (ref)
        AddToBoothHistory(p36);
    end);
    TradeBoothHistory.Frame.Sort.Vector.Rotation = u8[u10] == "Asc" and 180 or 0;
    Sort.Activated:Connect(function() -- Line: 218
        -- upvalues: u10 (ref), u9 (ref), u7 (ref), u8 (ref), FilterAndSort (ref), TradeBoothHistory (ref)
        if u10 == 2 then
            u9 = math.max((u9 + 1) % (#u7 + 1), 1);
        end;

        u10 = math.max((u10 + 1) % (#u8 + 1), 1);
        FilterAndSort();
        local v37 = u8[u10];
        TradeBoothHistory.Frame.Sort.Label.Text = `{u7[u9]}`;
        TradeBoothHistory.Frame.Sort.Vector.Rotation = v37 == "Asc" and 180 or 0;
    end);
    InitializeBoothHistory();
    FilterAndSort();
end;

task.spawn(v11.Start, v11);

return v11;