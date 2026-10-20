-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local TradingController = require(ReplicatedStorage.Modules.TradeControllers.TradingController);
require(ReplicatedStorage.Data.TradeData);
require(ReplicatedStorage.Modules.TradeControllers.TradingUserInterfaceController.TradeUIItemValueCalculators);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.DataService);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.TradeMenu.TradeMenuTypes);
require(ReplicatedStorage.Modules.TradeControllers.TradingUserInterfaceController.TradeUIItemRenderers);
local TradingUserInterfaceController = require(ReplicatedStorage.Modules.TradeControllers.TradingUserInterfaceController);
local TradeUIStaticData = require(ReplicatedStorage.Modules.TradeControllers.TradingUserInterfaceController.TradeUIStaticData);
require(ReplicatedStorage.Modules.Spring);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
local ReplicationReciever = require(ReplicatedStorage.Modules.ReplicationReciever);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local TokenRAPs = ReplicationReciever.new("TokenRAPs");
local AddToHistory = ReplicatedStorage.GameEvents.TradeEvents.Booths.AddToHistory;
local TradeMenuTemplates = ReplicatedStorage.Modules.TradeMenu.TradeMenuTemplates;
local u1 = Players.LocalPlayer or Players.PlayerAdded:Wait();
local PlayerGui = u1.PlayerGui;
local _ = PlayerGui.TradingUI;
local TradeMenu = PlayerGui.TradeMenu;
local History = TradeMenu.TradeMenuFrame.FrameSECTIONS.History;
local ScrollingFrame = History.ScrollingFrame;
local Filter = History.Filter;
local Sort = History.Sort;
local Search = History.Search;
local HistoryTemplate = TradeMenuTemplates.HistoryTemplate;
local HistorySpacerTemplate = TradeMenuTemplates.HistorySpacerTemplate;
local SpacerItemTemplate = TradeMenuTemplates.SpacerItemTemplate;
local HeadShot = Enum.ThumbnailType.HeadShot;
local Size420x420 = Enum.ThumbnailSize.Size420x420;
local u2 = nil;
local u3 = {};
local u4 = 1;
local u5 = TradeUIStaticData.TimeLengths[u4];
local u6 = {};
local u7 = {};
local u8 = false;
local u9 = false;
local u10 = false;
local v11 = {};

local function GetTopThree(p12) -- Line: 65
    -- upvalues: TokenRAPController (copy)
    local v13 = p12.sheckles or 0;
    local v14 = p12.tokens or 0;
    local v15 = {};

    for _, v in p12.items do
        local v16 = {
            Data = v,
            Value = TokenRAPController:GetRAP(v.type, v.data) or 0
        };
        table.insert(v15, v16);
    end;

    if v13 > 0 then
        table.insert(v15, {
            Data = "Sheckles",
            Value = v13
        });
    end;

    if v14 > 0 then
        table.insert(v15, {
            Data = "Tokens",
            Value = v14
        });
    end;

    table.sort(v15, function(p17, p18) -- Line: 99
        return p17.Value > p18.Value;
    end);
    local v19 = {};

    for i = 1, math.min(3, #v15) do
        table.insert(v19, v15[i]);
        local _ = i;
    end;

    return v19;
end;

local function CalculateTradeItemsRAP(p20) -- Line: 112
    -- upvalues: TokenRAPController (copy)
    local _ = p20.sheckles or 0;
    local v21 = p20.tokens or 0;
    local v22 = 0;

    for _, v in p20.items do
        v22 = v22 + (TokenRAPController:GetRAP(v.type, v.data) or 0);
    end;

    return v22 + v21;
end;

local function CreateTradedItem(p23: string, p24: any, p25: any, p26: any) -- Line: 131
    -- upvalues: ItemImageFinder (copy)
    p26.Direction.Text = p23;
    local Direction = p26.Direction;
    local v27;

    if p23 == "Given" then
        v27 = Color3.fromRGB(255, 133, 133);
    else
        v27 = Color3.fromRGB(133, 255, 131);
    end;

    Direction.TextColor3 = v27;

    if p24.Data == "Tokens" or p24.Data == "Sheckles" then
        if p24.Data == "Sheckles" then
            p26.Title.Text = "Sheckles";
            p26.Vector.Image = "rbxassetid://81639977198818";
        elseif p24.Data == "Tokens" then
            p26.Title.Text = "Tokens";
            p26.Vector.Image = "rbxassetid://81017486282262";
        else
            p26.Title.Text = "Traded Item";
            p26.Vector.Image = "rbxassetid://6937742258";
        end;
    else
        local type = p24.Data.type;
        local data = p24.Data.data;
        p26.Title.Text = data.ItemName or "No Name Found";
        p26.Vector.Image = ItemImageFinder(data.ItemName, type);
    end;

    p26.Parent = p25;
    p26.Visible = true;
end;

local function CreateTradeHistoryEntry(u28: any, p29: number) -- Line: 158
    -- upvalues: u5 (ref), u1 (copy), ScrollingFrame (copy), u7 (copy), HistoryTemplate (copy), Players (copy), HeadShot (copy), Size420x420 (copy), CalculateTradeItemsRAP (copy), NumberUtil (copy), GetTopThree (copy), HistorySpacerTemplate (copy), SpacerItemTemplate (copy), CreateTradedItem (copy), u3 (copy), PlayClickSound (copy), TweenService (copy), TradingUserInterfaceController (copy), TradeMenu (copy)
    if not u28.offers then
        return;
    end;

    local startTime = u28.startTime;
    local finishTime = u28.finishTime;
    local users = u28.users;
    local result = u28.status.result;

    if startTime < u5 then
        return;
    end;

    local v30 = users[1].userId == u1.UserId and 1 or 2;
    local v31 = v30 == 1 and 2 or 1;
    local v32 = ScrollingFrame:FindFirstChild((`{u28.id}`));

    if not (u7[u28.id] or v32) then
        v32 = HistoryTemplate:Clone();
        v32.Name = `{u28.id}`;
    end;

    v32.Headshot.Image = Players:GetUserThumbnailAsync(users[v31].userId, HeadShot, Size420x420);
    local os_date_ret = os.date("%I:%M %p (%x)", finishTime);
    v32.TradeTime.Text = os_date_ret;
    local v33 = `{result} trade with @{users[v31].username}`;
    v32.TradeWithTitle.Text = v33;
    local v34 = CalculateTradeItemsRAP(u28.offers[v30]);
    local v35 = CalculateTradeItemsRAP(u28.offers[v31]);
    v32.RAPgave.Text = `Tokens given: {NumberUtil.FormatCompactPrice(v34)}`;
    v32.RAPgot.Text = `Tokens received: {NumberUtil.FormatCompactPrice(v35)}`;
    v32.LayoutOrder = p29 * 10;
    v32.Parent = ScrollingFrame;
    v32.Visible = true;
    local v36 = GetTopThree(u28.offers[v30]);
    local v37 = GetTopThree(u28.offers[v31]);
    local u38 = ScrollingFrame:FindFirstChild((`{u28.id}Spacer`));

    if not (u7[u28.id] or u38) then
        u38 = HistorySpacerTemplate:Clone();
        u38.Name = `{u28.id}Spacer`;
    end;

    local HistorySpacerButton = u38.HistorySpacerButton;

    local function populateTopThree(p39: string, p40: any) -- Line: 214
        -- upvalues: HistorySpacerButton (copy), u28 (copy), u7 (ref), SpacerItemTemplate (ref), CreateTradedItem (ref)
        for i, v in p40 do
            local v41 = HistorySpacerButton:FindFirstChild(p39);
            local v42 = v41:FindFirstChild((`{p39}{u28.id}TopItem{i}`));

            if not u7[u28.id] then
                v42 = SpacerItemTemplate:Clone();
                v42.Name = `{p39}{u28.id}TopItem{i}`;
            end;

            CreateTradedItem(p39, v, v41, v42);
        end;
    end;

    populateTopThree("Given", v36);
    populateTopThree("Received", v37);
    u38.LayoutOrder = p29 * 10 + 1;
    u38.Parent = ScrollingFrame;
    u38.Visible = false;

    if u7[u28.id] then
        return;
    end;

    u7[u28.id] = {
        StartTime = startTime,
        TradedWith = string.lower(users[v31].username),
        HistoryEntry = v32,
        HistoryDetails = u38
    };
    v32.Activated:Connect(function() -- Line: 246
        -- upvalues: u3 (ref), u38 (ref), PlayClickSound (ref), TweenService (ref), HistorySpacerButton (copy)
        if u3[u38] then
            return;
        end;

        PlayClickSound();
        local u43 = not u38.Visible;
        local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quad);

        if u43 then
            u38.Visible = u43;
        end;

        local v44 = {};
        local v45;

        if u43 then
            v45 = UDim2.fromScale(0, 0);
        else
            v45 = UDim2.fromScale(0, -1);
        end;

        v44.Position = v45;
        local v46 = TweenService:Create(HistorySpacerButton, TweenInfo_new_ret, v44);
        v46:Play();
        u3[u38] = v46;
        v46.Completed:Once(function() -- Line: 269
            -- upvalues: u3 (ref), u38 (ref), u43 (copy)
            if u3[u38] then
                u3[u38] = nil;
            end;

            u38.Visible = u43;
        end);
    end);
    HistorySpacerButton.View.Activated:Connect(function() -- Line: 279
        -- upvalues: PlayClickSound (ref), TradingUserInterfaceController (ref), u28 (copy), TradeMenu (ref)
        PlayClickSound();
        TradingUserInterfaceController.CreatePastTrade(u28, TradeMenu);
    end);
end;

local function TimeFilter() -- Line: 286
    -- upvalues: u8 (ref), TradeUIStaticData (copy), u4 (ref), u5 (ref), Filter (copy), u7 (copy), u6 (copy), CreateTradeHistoryEntry (copy), History (copy)
    u8 = true;
    local TimeLengths = TradeUIStaticData.TimeLengths;
    u4 = math.max((u4 + 1) % (#TimeLengths + 1), 1);
    u5 = TimeLengths[u4];
    local v47 = TradeUIStaticData.TimeLengthDisplay[u4];
    Filter:FindFirstChild("Label").Text = `Last {v47}`;

    if u4 == 1 then
        for i, v in u7 do
            if v.StartTime < u5 then
                v.HistoryEntry:Destroy();
                v.HistoryDetails:Destroy();
                u7[i] = nil;
            end;
        end;
    end;

    local v48 = {};

    for _, v in u6 do
        if v.startTime >= u5 then
            table.insert(v48, v);
        end;
    end;

    table.sort(v48, function(p49, p50) -- Line: 318
        return p49.startTime > p50.startTime;
    end);

    for i, v in v48 do
        if u7[v.id] then
            u7[v.id].HistoryEntry.LayoutOrder = i * 10;
            u7[v.id].HistoryDetails.LayoutOrder = i * 10 + 1;
        else
            CreateTradeHistoryEntry(v, i);
        end;
    end;

    History.Empty.Visible = #v48 == 0;
    History.Empty.Text = `No history found in the last {v47}`;
    u8 = false;
end;

local function TimeSort() -- Line: 340
    -- upvalues: u9 (ref), u10 (ref), Sort (copy), u7 (copy)
    u9 = true;
    u10 = not u10;
    Sort:FindFirstChild("Label").Text = "Trade Time";
    Sort:FindFirstChild("Vector").Rotation = u10 and 0 or 180;
    local v51 = {};

    for _, v in u7 do
        table.insert(v51, v);
    end;

    if u10 then
        table.sort(v51, function(p52: table, p53: table) -- Line: 356
            return p52.StartTime > p53.StartTime;
        end);
    else
        table.sort(v51, function(p54: table, p55: table) -- Line: 360
            return p54.StartTime < p55.StartTime;
        end);
    end;

    for i = 1, #v51 do
        v51[i].HistoryEntry.LayoutOrder = i * 10;
        v51[i].HistoryDetails.LayoutOrder = i * 10 + 1;
        local _ = i;
    end;

    u9 = false;
end;

local function UpdateTradeHistory(p56) -- Line: 374
    -- upvalues: CreateTradeHistoryEntry (copy), ScrollingFrame (copy), History (copy)
    CreateTradeHistoryEntry(p56, 0);

    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("ImageButton") then
            child.LayoutOrder = child.LayoutOrder + 10;
        end;
    end;

    History.Empty.Visible = false;
end;

local function RefreshTradeHistory() -- Line: 389
    -- upvalues: u2 (ref), CreateTradeHistoryEntry (copy), History (copy)
    if not u2 then
        warn("No Saved Trade History");

        return;
    end;

    for i, v in u2 do
        CreateTradeHistoryEntry(v, i);
    end;

    History.Empty.Visible = #u2 == 0;
end;

function v11.SetUpHistoryUI() -- Line: 407
    -- upvalues: TradingController (copy), u2 (ref), TradeUIStaticData (copy), u6 (copy), u4 (ref), TimeFilter (copy), Filter (copy), PlayClickSound (copy), u8 (ref), u9 (ref), TimeSort (copy), Sort (copy), Search (copy), u7 (copy), TokenRAPs (copy), RefreshTradeHistory (copy)
    local v57, v58 = TradingController:FetchTradeHistory();

    if not v57 then
        warn("Failed to find booth history on load.");
        v58 = {};
    end;

    local table_clone_ret = table.clone(v58);
    u2 = table_clone_ret;
    table.sort(table_clone_ret, function(p59, p60) -- Line: 419
        return p59.startTime > p60.startTime;
    end);

    for _, v in table_clone_ret do
        if v.status.result ~= "Failed" and v.startTime >= TradeUIStaticData.TimeLengths[#TradeUIStaticData.TimeLengths] then
            table.insert(u6, v);
        end;
    end;

    u4 = 0;
    TimeFilter();
    Filter.Activated:Connect(function() -- Line: 439
        -- upvalues: PlayClickSound (ref), u8 (ref), u9 (ref), TimeFilter (ref)
        PlayClickSound();

        if not (u8 or u9) then
            TimeFilter();
        end;
    end);
    TimeSort();
    Sort.Activated:Connect(function() -- Line: 448
        -- upvalues: PlayClickSound (ref), u9 (ref), u8 (ref), TimeSort (ref)
        PlayClickSound();

        if not (u9 or u8) then
            TimeSort();
        end;
    end);
    Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 456
        -- upvalues: Search (ref), u7 (ref)
        local string_lower_ret = string.lower(Search.TextBox.Text);

        for _, v in u7 do
            if string.find(v.TradedWith, string_lower_ret) then
                v.HistoryEntry.Visible = true;
                v.HistoryDetails.Visible = false;
            else
                v.HistoryEntry.Visible = false;
                v.HistoryDetails.Visible = false;
            end;
        end;
    end);
    local PathSignal = TokenRAPs:GetPathSignal("RAPs/@");

    if PathSignal then
        PathSignal:Connect(RefreshTradeHistory);
    end;

    TokenRAPs:GetDataAsync();
end;

AddToHistory.OnClientEvent:Connect(function(p61) -- Line: 478
    -- upvalues: u8 (ref), UpdateTradeHistory (copy)
    if not u8 then
        UpdateTradeHistory(p61);
    end;
end);

return v11;