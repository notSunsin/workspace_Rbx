-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
local DataService = require(ReplicatedStorage.Modules.DataService);
local TradingPinController = require(ReplicatedStorage.Modules.TradeMenu.TradingPinController);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local GameEvents = ReplicatedStorage.GameEvents;
local SetViewInventoryPermission = GameEvents.TradeEvents.SetViewInventoryPermission;
local SetTradeRequestPermission = GameEvents.TradeEvents:FindFirstChild("SetTradeRequestPermission");
local SetUnfairTradeWarning = GameEvents.TradeEvents.SetUnfairTradeWarning;
local ButtonColors = SeasonPassStaticData.ButtonColors;
local _ = ReplicatedStorage.Modules.TradeTokens.Templates;
local PlayerGui = (Players.LocalPlayer or Players.PlayerAdded:Wait()).PlayerGui;
PlayerGui:WaitForChild("TradingPin");
local TradeMenu = PlayerGui:WaitForChild("TradeMenu");
local ScrollingFrame = TradeMenu.TradeMenuFrame.FrameSECTIONS.Settings.ScrollingFrame;
local ViewInventory = ScrollingFrame.ViewInventory;
local TradeRequests = ScrollingFrame:FindFirstChild("TradeRequests");
local TradingPin = ScrollingFrame.TradingPin;
local UnfairTradesWarning = ScrollingFrame.UnfairTradesWarning;
local TradingPin2 = TradeMenu.TradeMenuFrame.FrameSECTIONS.Settings.ScrollingFrame.TradingPin;
local v1 = {};
local u2 = { "Everyone", "Friends", "No one" };
local u3 = "No one";
local u4 = "Everyone";
local u5 = true;

local function enabledButtonVisual(p6: userdata, p7: userdata, p8: boolean) -- Line: 41
    -- upvalues: ButtonColors (copy)
    local v9;

    if p8 then
        v9 = ButtonColors.Green;
    else
        v9 = ButtonColors.Red;
    end;

    local UIGradient = p6:FindFirstChild("UIGradient");

    if v9.Gradient then
        UIGradient.Color = v9.Gradient;
    end;

    local UIStroke = p6:FindFirstChild("UIStroke");

    if v9.ButtonStrokeAlt then
        UIStroke.Color = v9.ButtonStrokeAlt;
    end;

    p6:FindFirstChild("Label"):FindFirstChild("UIStroke").Color = v9.TextStroke;
    p7.Text = p8 and "ENABLED" or "DISABLED";
end;

local function selectButtonVisual(p10: userdata, p11: boolean) -- Line: 61
    -- upvalues: ButtonColors (copy)
    local v12;

    if p11 then
        v12 = ButtonColors.Green;
    else
        v12 = ButtonColors.Blue;
    end;

    p10.BackgroundColor3 = v12.Background;
    p10:FindFirstChild("UIStroke").Color = v12.ButtonStroke;
    p10:FindFirstChild("Label"):FindFirstChild("UIStroke").Color = v12.TextStroke;
    p10:FindFirstChild("Vector").Visible = p11;
end;

local function deselectAllButtons(p13: userdata) -- Line: 77
    -- upvalues: selectButtonVisual (copy)
    for _, child in p13:GetChildren() do
        if child:IsA("ImageButton") then
            selectButtonVisual(child, false);
        end;
    end;
end;

local function ToggleTradingPinButton() -- Line: 89
    -- upvalues: DataService (copy), TradingPin2 (copy), enabledButtonVisual (copy), TradingPin (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("TradeMenuSettingsController/ToggleTradingPinButton | No player data");

        return;
    end;

    local Current = TradingPin2.Current;
    enabledButtonVisual(Current, Current.Label, Data.TradeData.Pin.Pin and true or false);
    local Reset = TradingPin.Reset;
    TradingPin.Set.Visible = not Data.TradeData.Pin.Pin;
    Reset.Visible = Data.TradeData.Pin.Pin and true or false;
end;

local function SetupInventoryViewAccess() -- Line: 111
    -- upvalues: DataService (copy), u3 (ref), ViewInventory (copy), deselectAllButtons (copy), selectButtonVisual (copy), PlayClickSound (copy), u2 (copy), SetViewInventoryPermission (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("TradeMenuSettingsController/SetupInventoryViewAcess | No player data");

        return;
    end;

    u3 = Data.TradeData.ViewInventoryPermission;
    local v14 = ViewInventory.Options:FindFirstChild(u3);

    if not v14 then
        warn((`Cannot find inventory access button: {u3}`));

        return;
    end;

    deselectAllButtons(ViewInventory.Options);
    selectButtonVisual(v14, true);

    for _, child in ViewInventory.Options:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 132
                -- upvalues: PlayClickSound (ref), u3 (ref), child (copy), deselectAllButtons (ref), ViewInventory (ref), selectButtonVisual (ref), u2 (ref), SetViewInventoryPermission (ref)
                PlayClickSound();
                u3 = child.Name;
                deselectAllButtons(ViewInventory.Options);
                selectButtonVisual(child, true);

                if table.find(u2, u3) then
                    SetViewInventoryPermission:FireServer(u3);

                    return;
                end;

                warn("Not a valid permission name");
            end);
        end;
    end;
end;

local function SetupTradeRequestAccess() -- Line: 148
    -- upvalues: TradeRequests (copy), SetTradeRequestPermission (copy), DataService (copy), u4 (ref), deselectAllButtons (copy), selectButtonVisual (copy), PlayClickSound (copy), u2 (copy)
    if not (TradeRequests and SetTradeRequestPermission) then
        warn("TradeMenuSettingsController/SetupTradeRequestAccess | Trade request setting is missing from this place; republish it");

        return;
    end;

    local Data = DataService:GetData();

    if not Data then
        warn("TradeMenuSettingsController/SetupTradeRequestAccess | No player data");

        return;
    end;

    u4 = Data.TradeData.TradeRequestPermission or "Everyone";
    local v15 = TradeRequests.Options:FindFirstChild(u4);

    if not v15 then
        warn((`Cannot find trade request access button: {u4}`));

        return;
    end;

    deselectAllButtons(TradeRequests.Options);
    selectButtonVisual(v15, true);

    for _, child in TradeRequests.Options:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 174
                -- upvalues: PlayClickSound (ref), u4 (ref), child (copy), deselectAllButtons (ref), TradeRequests (ref), selectButtonVisual (ref), u2 (ref), SetTradeRequestPermission (ref)
                PlayClickSound();
                u4 = child.Name;
                deselectAllButtons(TradeRequests.Options);
                selectButtonVisual(child, true);

                if table.find(u2, u4) then
                    SetTradeRequestPermission:FireServer(u4);

                    return;
                end;

                warn("Not a valid permission name");
            end);
        end;
    end;
end;

local function SetupTradingPin() -- Line: 190
    -- upvalues: DataService (copy), TradingPin (copy), PlayClickSound (copy), TradingPinController (copy), TradeMenu (copy), enabledButtonVisual (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("TradeMenuSettingsController/SetupTradingPin | No player data");

        return;
    end;

    local Set = TradingPin.Set;
    Set.Activated:Connect(function() -- Line: 198
        -- upvalues: PlayClickSound (ref), TradingPinController (ref), TradeMenu (ref)
        PlayClickSound();
        TradingPinController.CreateTradingPin(TradeMenu);
    end);
    local Reset = TradingPin.Reset;
    Reset.Activated:Connect(function() -- Line: 204
        -- upvalues: PlayClickSound (ref), TradingPinController (ref), TradeMenu (ref)
        PlayClickSound();
        TradingPinController.ResetPinSystem(TradeMenu);
    end);
    Set.Visible = not Data.TradeData.Pin.Pin;
    Reset.Visible = not Set.Visible;
    enabledButtonVisual(TradingPin.Current, TradingPin.Current.Label, Reset.Visible);
end;

local function SetupUnfairTradeWarning() -- Line: 215
    -- upvalues: DataService (copy), UnfairTradesWarning (copy), u5 (ref), enabledButtonVisual (copy), SetUnfairTradeWarning (copy), PlayClickSound (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("TradeMenuSettingsController/SetupUnfairTradeWarning | No player data");

        return;
    end;

    local Options = UnfairTradesWarning.Options;
    local Enable = Options.Enable;
    local Disable = Options.Disable;
    local Current = UnfairTradesWarning.Current;

    local function toggleButton() -- Line: 227
        -- upvalues: Disable (copy), u5 (ref), Enable (copy), enabledButtonVisual (ref), Current (copy), SetUnfairTradeWarning (ref)
        Disable.BackgroundTransparency = u5 and 0 or 0.5;
        Disable.Label.TextTransparency = u5 and 0 or 0.5;
        Enable.BackgroundTransparency = u5 and 0.5 or 0;
        Enable.Label.TextTransparency = u5 and 0.5 or 0;
        enabledButtonVisual(Current, Current.Label, u5);
        SetUnfairTradeWarning:FireServer(u5);
    end;

    u5 = Data.TradeData.UnfairTradeWarning;
    Disable.BackgroundTransparency = u5 and 0 or 0.5;
    Disable.Label.TextTransparency = u5 and 0 or 0.5;
    Enable.BackgroundTransparency = u5 and 0.5 or 0;
    Enable.Label.TextTransparency = u5 and 0.5 or 0;
    enabledButtonVisual(Current, Current.Label, u5);
    SetUnfairTradeWarning:FireServer(u5);
    Enable.Activated:Connect(function() -- Line: 239
        -- upvalues: PlayClickSound (ref), u5 (ref), Disable (copy), Enable (copy), enabledButtonVisual (ref), Current (copy), SetUnfairTradeWarning (ref)
        PlayClickSound();
        u5 = true;
        Disable.BackgroundTransparency = u5 and 0 or 0.5;
        Disable.Label.TextTransparency = u5 and 0 or 0.5;
        Enable.BackgroundTransparency = u5 and 0.5 or 0;
        Enable.Label.TextTransparency = u5 and 0.5 or 0;
        enabledButtonVisual(Current, Current.Label, u5);
        SetUnfairTradeWarning:FireServer(u5);
    end);
    Disable.Activated:Connect(function() -- Line: 245
        -- upvalues: PlayClickSound (ref), u5 (ref), Disable (copy), Enable (copy), enabledButtonVisual (ref), Current (copy), SetUnfairTradeWarning (ref)
        PlayClickSound();
        u5 = false;
        Disable.BackgroundTransparency = u5 and 0 or 0.5;
        Disable.Label.TextTransparency = u5 and 0 or 0.5;
        Enable.BackgroundTransparency = u5 and 0.5 or 0;
        Enable.Label.TextTransparency = u5 and 0.5 or 0;
        enabledButtonVisual(Current, Current.Label, u5);
        SetUnfairTradeWarning:FireServer(u5);
    end);
end;

function v1.SetUpSettingsUI() -- Line: 254
    -- upvalues: SetupInventoryViewAccess (copy), SetupTradeRequestAccess (copy), SetupTradingPin (copy), SetupUnfairTradeWarning (copy)
    SetupInventoryViewAccess();
    SetupTradeRequestAccess();
    SetupTradingPin();
    SetupUnfairTradeWarning();
end;

local PathSignal = DataService:GetPathSignal("TradeData/Pin/@");

if PathSignal then
    PathSignal:Connect(function(p16: string, p17: any, p18: string) -- Line: 264
        -- upvalues: DataService (copy), ToggleTradingPinButton (copy)
        if not p17 then
            return;
        end;

        local string_split_ret = string.split(p18, "/");
        local v19;

        if #string_split_ret >= 3 then
            v19 = string_split_ret[3];
        else
            v19 = nil;
        end;

        if not v19 then
            warn(`No changes {v19}`, string_split_ret);

            return;
        end;

        local Data = DataService:GetData();

        if not Data then
            warn("No player data");

            return;
        end;

        if v19 == "Pin" and Data.TradeData.Pin.Pin then
            ToggleTradingPinButton();

            return;
        end;

        if v19 ~= "Match" or Data.TradeData.Pin.Pin ~= nil then
            return;
        end;

        ToggleTradingPinButton();
    end);
end;

return v1;