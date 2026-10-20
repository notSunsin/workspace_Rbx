-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
local DataService = require(ReplicatedStorage.Modules.DataService);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local GameEvents = ReplicatedStorage.GameEvents;
local SetPin = GameEvents.TradeEvents.SetPin;
local DisablePin = GameEvents.TradeEvents.DisablePin;
local RequestPin = GameEvents.TradeEvents.RequestPin;
local ReplyPinRequest = GameEvents.TradeEvents.ReplyPinRequest;
local ButtonColors = SeasonPassStaticData.ButtonColors;
local PlayerGui = (Players.LocalPlayer or Players.PlayerAdded:Wait()).PlayerGui;
local PhraseTemplate = ReplicatedStorage.Modules.TradeTokens.Templates.PhraseTemplate;
local TradingPin = PlayerGui.TradingPin;
local TradingPinPadCreate = TradingPin.TradingPinPadCreate;
local TradingPinPadInput = TradingPin.TradingPinPadInput;
local RecoveryPhraseDisplay = TradingPin.RecoveryPhraseDisplay;
local RecoveryPhraseInput = TradingPin.RecoveryPhraseInput;
local ResetOptions = TradingPin.ResetOptions;
local u1 = "";
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local v6 = {};

local function hideAndShow(p7: userdata) -- Line: 46
    -- upvalues: TradingPin (copy)
    for _, child in TradingPin:GetChildren() do
        if not child:IsA("UILayout") and child.Name ~= "BlackBG" then
            child.Visible = false;
        end;
    end;

    p7.Visible = true;
end;

local function closeTradingPinMenu(p8: userdata?) -- Line: 57
    -- upvalues: GuiController (copy), TradingPin (copy)
    GuiController:Close(TradingPin);

    if p8 then
        GuiController:Open(p8);
    end;
end;

local function updateAttempts(p9: userdata, p10: string) -- Line: 65
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if not Data then
        warn("TradingPinController/OpenPinInput | No player data");

        return;
    end;

    if Data.TradeData.Pin[p10] then
        p9.Text = `You have <font color="rgb(255, 17, 17)">({Data.TradeData.Pin[p10].Attempts or -1})</font> attempts remaining today`;

        return;
    end;

    warn((`No attempt type with name {p10}`));
end;

local function confirmButtonVisuals(p11: userdata, p12: boolean) -- Line: 81
    -- upvalues: ButtonColors (copy)
    p11.Interactable = p12 and true or false;
    local v13;

    if p12 then
        v13 = ButtonColors.Green.Background;
    else
        v13 = ButtonColors.Gray.Background;
    end;

    p11.BackgroundColor3 = v13;
    local UIStroke = p11:FindFirstChild("UIStroke");

    if UIStroke then
        local v14;

        if p12 then
            v14 = ButtonColors.Green.ButtonStroke;
        else
            v14 = ButtonColors.Gray.ButtonStroke;
        end;

        UIStroke.Color = v14;
    end;

    local Label = p11:FindFirstChild("Label");
    local v15 = Label and Label:FindFirstChild("UIStroke");

    if v15 then
        local v16;

        if p12 then
            v16 = ButtonColors.Green.TextStroke;
        else
            v16 = ButtonColors.Gray.TextStroke;
        end;

        v15.Color = v16;
    end;
end;

local function DisplayRecoveryPhrase(p17: table) -- Line: 107
    -- upvalues: u5 (ref), RecoveryPhraseDisplay (copy), PhraseTemplate (copy), hideAndShow (copy)
    u5 = false;

    for _, child in RecoveryPhraseDisplay.RecoveryPhraseFrame:GetChildren() do
        if child:IsA("ImageButton") then
            child:Destroy();
        end;
    end;

    local v18 = 1;

    for _, v in p17 do
        local v19 = PhraseTemplate:Clone();
        v19.Label.Text = `{v18}. {v}`;
        v19.LayoutOrder = v18;
        v19.Name = `Phrase{v18}`;
        v19.Parent = RecoveryPhraseDisplay.RecoveryPhraseFrame;
        v18 = v18 + 1;
    end;

    RecoveryPhraseDisplay.Checkbox.Checkmark.Visible = false;
    hideAndShow(RecoveryPhraseDisplay);
end;

local function InitialisePinInputUI(p20: table, p21: string) -- Line: 137
    -- upvalues: u3 (ref), u2 (ref), u4 (ref), TradingPinPadInput (copy), u1 (ref), hideAndShow (copy)
    u3 = p21;
    u2 = p20.PrevGui;
    u4 = p20.RequestUUID;
    TradingPinPadInput.Header.Title.Text = u3 == "Trade" and "Trading Pin <font color=\"#ff2929\">(5.0s)</font>" or "Trading Pin";
    u1 = "";
    TradingPinPadInput.Input_Box.Input.Text = `{u1}`;
    hideAndShow(TradingPinPadInput);
end;

local function ResetUsingRecoveryPhrase() -- Line: 153
    -- upvalues: RecoveryPhraseInput (copy), updateAttempts (copy), hideAndShow (copy)
    updateAttempts(RecoveryPhraseInput.Attempts, "Disable");

    for _, child in RecoveryPhraseInput.PhraseInputFrame:GetChildren() do
        if child:IsA("ImageButton") then
            child:FindFirstChild("TextBox").Text = "";
        end;
    end;

    hideAndShow(RecoveryPhraseInput);
end;

local function ResetUsingTradingPin() -- Line: 169
    -- upvalues: TradingPinPadInput (copy), u2 (ref), u3 (ref), u4 (ref), u1 (ref), hideAndShow (copy), updateAttempts (copy)
    local Attempts = TradingPinPadInput.Attempts;
    local v22 = {
        PrevGui = u2
    };
    u3 = "Reset";
    u2 = v22.PrevGui;
    u4 = v22.RequestUUID;
    TradingPinPadInput.Header.Title.Text = u3 == "Trade" and "Trading Pin <font color=\"#ff2929\">(5.0s)</font>" or "Trading Pin";
    u1 = "";
    TradingPinPadInput.Input_Box.Input.Text = `{u1}`;
    hideAndShow(TradingPinPadInput);
    updateAttempts(Attempts, "Disable");
end;

local function TradeRequestedPinInput(u23: string, u24: number) -- Line: 176
    -- upvalues: TradingPinPadInput (copy), u3 (ref), u2 (ref), u4 (ref), u1 (ref), hideAndShow (copy), updateAttempts (copy), GuiController (copy), TradingPin (copy), ReplyPinRequest (copy)
    local Attempts = TradingPinPadInput.Attempts;
    local v25 = {
        RequestUUID = u23
    };
    u3 = "Trade";
    u2 = v25.PrevGui;
    u4 = v25.RequestUUID;
    TradingPinPadInput.Header.Title.Text = u3 == "Trade" and "Trading Pin <font color=\"#ff2929\">(5.0s)</font>" or "Trading Pin";
    u1 = "";
    TradingPinPadInput.Input_Box.Input.Text = `{u1}`;
    hideAndShow(TradingPinPadInput);
    updateAttempts(Attempts, "Match");
    GuiController:Open(TradingPin);
    task.spawn(function() -- Line: 184
        -- upvalues: TradingPinPadInput (ref), u24 (copy), TradingPin (ref), GuiController (ref), ReplyPinRequest (ref), u23 (copy)
        local Title = TradingPinPadInput.Header.Title;
        local v26 = u24;

        while v26 > 0 and TradingPin.Enabled do
            Title.Text = `Trading Pin <font color="#ff2929">({math.round(v26 * 10 / 10)}s)</font>`;
            task.wait(0.1);
            v26 = v26 - 0.1;
        end;

        GuiController:Close(TradingPin);

        if v26 <= 0 then
            ReplyPinRequest:InvokeServer(u23, false);
        end;
    end);
end;

local function SetUpPhraseInputUI() -- Line: 200
    -- upvalues: RecoveryPhraseInput (copy), PlayClickSound (copy), u2 (ref), GuiController (copy), TradingPin (copy), Notification (copy), DisablePin (copy), updateAttempts (copy)
    RecoveryPhraseInput.Close.Activated:Connect(function() -- Line: 202
        -- upvalues: PlayClickSound (ref), u2 (ref), GuiController (ref), TradingPin (ref)
        PlayClickSound();
        local v27 = u2;
        GuiController:Close(TradingPin);

        if v27 then
            GuiController:Open(v27);
        end;
    end);
    RecoveryPhraseInput.Confirm.Activated:Connect(function() -- Line: 209
        -- upvalues: PlayClickSound (ref), RecoveryPhraseInput (ref), Notification (ref), DisablePin (ref), updateAttempts (ref), u2 (ref), GuiController (ref), TradingPin (ref)
        PlayClickSound();
        local v28 = {};
        local v29 = {};

        for _, child in RecoveryPhraseInput.PhraseInputFrame:GetChildren() do
            if child:IsA("ImageButton") then
                table.insert(v28, child);
            end;
        end;

        table.sort(v28, function(p30, p31) -- Line: 220
            return p30.LayoutOrder < p31.LayoutOrder;
        end);

        for _, v in v28 do
            local TextBox = v:FindFirstChild("TextBox");

            if TextBox then
                if TextBox.Text == "" then
                    Notification:CreateNotification("Not all boxes are filled");

                    return;
                end;

                table.insert(v29, TextBox.Text);
            end;
        end;

        if not DisablePin:InvokeServer("RecoveryPhrase", v29) then
            Notification:CreateNotification("Incorrect recovery phrase!");
            updateAttempts(RecoveryPhraseInput.Attempts, "Disable");

            return;
        end;

        local v32 = u2;
        GuiController:Close(TradingPin);

        if v32 then
            GuiController:Open(v32);
        end;
    end);
end;

local function SetUpPhraseDisplayUI() -- Line: 250
    -- upvalues: RecoveryPhraseDisplay (copy), PlayClickSound (copy), u2 (ref), GuiController (copy), TradingPin (copy), ButtonColors (copy), u5 (ref), confirmButtonVisuals (copy)
    RecoveryPhraseDisplay.Close.Activated:Connect(function() -- Line: 252
        -- upvalues: PlayClickSound (ref), u2 (ref), GuiController (ref), TradingPin (ref)
        PlayClickSound();
        local v33 = u2;
        GuiController:Close(TradingPin);

        if v33 then
            GuiController:Open(v33);
        end;
    end);
    local Checkbox = RecoveryPhraseDisplay.Checkbox;
    local Checkmark = Checkbox.Checkmark;
    Checkbox.Activated:Connect(function() -- Line: 261
        -- upvalues: PlayClickSound (ref), Checkmark (copy)
        PlayClickSound();
        Checkmark.Visible = not Checkmark.Visible;
    end);
    local Confirm = RecoveryPhraseDisplay.Confirm;
    Confirm.Interactable = false;
    Confirm.BackgroundColor3 = ButtonColors.Gray.Background;
    Confirm.UIStroke.Color = ButtonColors.Gray.ButtonStroke;
    Confirm.Label.UIStroke.Color = ButtonColors.Gray.TextStroke;
    Confirm.Activated:Connect(function() -- Line: 271
        -- upvalues: PlayClickSound (ref), u5 (ref), u2 (ref), GuiController (ref), TradingPin (ref)
        PlayClickSound();
        u5 = true;
        local v34 = u2;
        GuiController:Close(TradingPin);

        if v34 then
            GuiController:Open(v34);
        end;
    end);
    Checkmark:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 278
        -- upvalues: confirmButtonVisuals (ref), Confirm (copy), Checkmark (copy)
        confirmButtonVisuals(Confirm, Checkmark.Visible);
    end);
end;

local function SetUpCreatePinUI() -- Line: 284
    -- upvalues: TradingPin (copy), PlayClickSound (copy), u2 (ref), GuiController (copy), u1 (ref), SetPin (copy), Notification (copy), TradingPinPadCreate (copy), RecoveryPhraseDisplay (copy), DisplayRecoveryPhrase (copy)
    TradingPin.TradingPinPadCreate.Header.Close.Activated:Connect(function() -- Line: 286
        -- upvalues: PlayClickSound (ref), u2 (ref), GuiController (ref), TradingPin (ref)
        PlayClickSound();
        local v35 = u2;
        GuiController:Close(TradingPin);

        if v35 then
            GuiController:Open(v35);
        end;
    end);
    TradingPin.TradingPinPadCreate.Buttons.Confirm.Activated:Connect(function() -- Line: 293
        -- upvalues: PlayClickSound (ref), u1 (ref), SetPin (ref), Notification (ref), TradingPinPadCreate (ref), RecoveryPhraseDisplay (ref), DisplayRecoveryPhrase (ref)
        PlayClickSound();
        local v36 = {};

        for _, v in u1:split("") do
            local v37 = tonumber(v);
            local v38 = assert(v37);
            table.insert(v36, v38);
        end;

        local v39, v40 = SetPin:InvokeServer(v36);

        if not v39 then
            Notification:CreateNotification("Failed to set trading pin");

            return;
        end;

        TradingPinPadCreate.Visible = false;
        RecoveryPhraseDisplay.Visible = false;
        DisplayRecoveryPhrase(v40);
    end);
end;

local function SetUpTradingPinInputUI() -- Line: 314
    -- upvalues: TradingPinPadInput (copy), confirmButtonVisuals (copy), u1 (ref), PlayClickSound (copy), u2 (ref), GuiController (copy), TradingPin (copy), u3 (ref), ReplyPinRequest (copy), u4 (ref), DisablePin (copy), Notification (copy)
    local function wrongPinWarning() -- Line: 315
        -- upvalues: TradingPinPadInput (ref), confirmButtonVisuals (ref), u1 (ref)
        TradingPinPadInput.Input_Box.WarningText.Text = "<font color=\"rgb(255, 17, 17)\">Wrong pin or no attempts!</font>";
        TradingPinPadInput.Input_Box.Input.Visible = false;
        TradingPinPadInput.Input_Box.WarningText.Visible = true;
        confirmButtonVisuals(TradingPinPadInput.Buttons.Confirm, false);
        task.wait(3);
        u1 = "";
        TradingPinPadInput.Input_Box.Input.Text = `{u1}`;
        TradingPinPadInput.Input_Box.Input.Visible = true;
        TradingPinPadInput.Input_Box.WarningText.Visible = false;
        confirmButtonVisuals(TradingPinPadInput.Buttons.Confirm, true);
    end;

    TradingPinPadInput.Header.Close.Activated:Connect(function() -- Line: 331
        -- upvalues: PlayClickSound (ref), u2 (ref), GuiController (ref), TradingPin (ref), u3 (ref), ReplyPinRequest (ref), u4 (ref)
        PlayClickSound();
        local v41 = u2;
        GuiController:Close(TradingPin);

        if v41 then
            GuiController:Open(v41);
        end;

        if u3 == "Trade" then
            ReplyPinRequest:InvokeServer(u4, false);
        end;
    end);
    TradingPinPadInput.Buttons.Confirm.Activated:Connect(function() -- Line: 341
        -- upvalues: PlayClickSound (ref), u1 (ref), u3 (ref), DisablePin (ref), wrongPinWarning (copy), ReplyPinRequest (ref), u4 (ref), Notification (ref), u2 (ref), GuiController (ref), TradingPin (ref)
        PlayClickSound();
        local v42 = {};

        for _, v in u1:split("") do
            local v43 = tonumber(v);
            local v44 = assert(v43);
            table.insert(v42, v44);
        end;

        if u3 == "Reset" then
            if not DisablePin:InvokeServer("Pin", v42) then
                task.spawn(wrongPinWarning);

                return;
            end;
        elseif u3 == "Trade" then
            local v45, v46 = ReplyPinRequest:InvokeServer(u4, v42);

            if not v45 then
                task.spawn(wrongPinWarning);

                return;
            end;

            if v45 and not v46 then
                Notification:CreateNotification("Wrong pin or no attempts!");
            end;
        end;

        local v47 = u2;
        GuiController:Close(TradingPin);

        if v47 then
            GuiController:Open(v47);
        end;
    end);
end;

local function SetUpResetOptionsUI() -- Line: 372
    -- upvalues: ResetOptions (copy), PlayClickSound (copy), u2 (ref), GuiController (copy), TradingPin (copy), TradingPinPadInput (copy), u3 (ref), u4 (ref), u1 (ref), hideAndShow (copy), updateAttempts (copy), ResetUsingRecoveryPhrase (copy)
    ResetOptions.Close.Activated:Connect(function() -- Line: 374
        -- upvalues: PlayClickSound (ref), u2 (ref), GuiController (ref), TradingPin (ref)
        PlayClickSound();
        local v48 = u2;
        GuiController:Close(TradingPin);

        if v48 then
            GuiController:Open(v48);
        end;
    end);
    ResetOptions.Options.Pin.Activated:Connect(function() -- Line: 380
        -- upvalues: PlayClickSound (ref), TradingPinPadInput (ref), u2 (ref), u3 (ref), u4 (ref), u1 (ref), hideAndShow (ref), updateAttempts (ref)
        PlayClickSound();
        local Attempts = TradingPinPadInput.Attempts;
        local v49 = {
            PrevGui = u2
        };
        u3 = "Reset";
        u2 = v49.PrevGui;
        u4 = v49.RequestUUID;
        TradingPinPadInput.Header.Title.Text = u3 == "Trade" and "Trading Pin <font color=\"#ff2929\">(5.0s)</font>" or "Trading Pin";
        u1 = "";
        TradingPinPadInput.Input_Box.Input.Text = `{u1}`;
        hideAndShow(TradingPinPadInput);
        updateAttempts(Attempts, "Disable");
    end);
    ResetOptions.Options.Phrase.Activated:Connect(function() -- Line: 386
        -- upvalues: PlayClickSound (ref), ResetUsingRecoveryPhrase (ref)
        PlayClickSound();
        ResetUsingRecoveryPhrase();
    end);
end;

local function SetUpPinButtons(p50) -- Line: 393
    -- upvalues: u1 (ref)
    local Buttons = p50.Buttons;
    local Input = p50.Input_Box.Input;

    for _, child in Buttons:GetChildren() do
        if string.find(child.Name, "Num") then
            child.Activated:Connect(function() -- Line: 403
                -- upvalues: u1 (ref), child (copy), Input (copy)
                if #u1 < 4 then
                    u1 = `{u1}{child.Name:gsub("Num", "")}`;
                    Input.Text = u1;
                end;
            end);
        end;
    end;

    Buttons.Delete.Activated:Connect(function() -- Line: 414
        -- upvalues: u1 (ref), Input (copy)
        if #u1 > 0 then
            u1 = u1:sub(1, #u1 - 1);
            Input.Text = u1;
        end;
    end);
end;

function v6.CreateTradingPin(p51: userdata) -- Line: 423
    -- upvalues: u2 (ref), u1 (ref), TradingPinPadCreate (copy), hideAndShow (copy), GuiController (copy), TradingPin (copy)
    u2 = p51;
    u1 = "";
    TradingPinPadCreate.Input_Box.Input.Text = `{u1}`;
    hideAndShow(TradingPinPadCreate);
    GuiController:Open(TradingPin);

    if u2 then
        GuiController:Close(u2);
    end;
end;

function v6.ResetPinSystem(p52: userdata) -- Line: 437
    -- upvalues: u2 (ref), hideAndShow (copy), ResetOptions (copy), GuiController (copy), TradingPin (copy)
    u2 = p52;
    hideAndShow(ResetOptions);
    GuiController:Open(TradingPin);

    if u2 then
        GuiController:Close(u2);
    end;
end;

function v6.SetUpTradingPinUI(p53) -- Line: 448
    -- upvalues: SetUpPhraseDisplayUI (copy), SetUpPhraseInputUI (copy), SetUpCreatePinUI (copy), SetUpTradingPinInputUI (copy), SetUpResetOptionsUI (copy), SetUpPinButtons (copy), TradingPinPadInput (copy), TradingPinPadCreate (copy), TradingPin (copy), u1 (ref), confirmButtonVisuals (copy)
    SetUpPhraseDisplayUI();
    SetUpPhraseInputUI();
    SetUpCreatePinUI();
    SetUpTradingPinInputUI();
    SetUpResetOptionsUI();
    SetUpPinButtons(TradingPinPadInput);
    SetUpPinButtons(TradingPinPadCreate);
    local u54 = nil;
    TradingPin:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 460
        -- upvalues: TradingPin (ref), u54 (ref), u1 (ref), confirmButtonVisuals (ref)
        if TradingPin.Enabled then
            u54 = task.spawn(function() -- Line: 463
                -- upvalues: TradingPin (ref), u1 (ref), confirmButtonVisuals (ref)
                while TradingPin.Enabled do
                    local v55;

                    if #u1 == 4 then
                        v55 = true;
                    else
                        v55 = false;
                    end;

                    local Confirm = TradingPin.TradingPinPadInput.Buttons.Confirm;
                    confirmButtonVisuals(TradingPin.TradingPinPadCreate.Buttons.Confirm, v55);
                    confirmButtonVisuals(Confirm, v55);
                    task.wait();
                end;
            end);

            return;
        end;

        if u54 then
            task.cancel(u54);
        end;
    end);
end;

RequestPin.OnClientEvent:Connect(function(p56: string, p57: number) -- Line: 487
    -- upvalues: TradeRequestedPinInput (copy)
    TradeRequestedPinInput(p56, p57 - workspace:GetServerTimeNow());
end);
local PathSignal = DataService:GetPathSignal("TradeData/Pin/Disable/Attempts");

if PathSignal then
    PathSignal:Connect(function(p58: string, p59: any, p60: string) -- Line: 495
        -- upvalues: DataService (copy), TradingPinPadInput (copy)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        TradingPinPadInput.Attempts.Text = `You have <font color="rgb(255, 17, 17)">({Data.TradeData.Pin.Disable.Attempts})</font> attempts remaining today`;
    end);
end;

local PathSignal2 = DataService:GetPathSignal("TradeData/Pin/Match/Attempts");

if PathSignal2 then
    PathSignal2:Connect(function(p61: string, p62: any, p63: string) -- Line: 510
        -- upvalues: DataService (copy), TradingPinPadInput (copy)
        local Data = DataService:GetData();

        if not Data then
            return;
        end;

        TradingPinPadInput.Attempts.Text = `You have <font color="rgb(255, 17, 17)">({Data.TradeData.Pin.Match.Attempts})</font> attempts remaining today`;
    end);
end;

return v6;