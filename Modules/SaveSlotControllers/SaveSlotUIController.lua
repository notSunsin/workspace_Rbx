-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local SaveSlotConfigData = require(ReplicatedStorage.Data.SaveSlotConfigData);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Comma_Module);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SlotServiceTypes = require(ReplicatedStorage.Types.SlotServiceTypes);
local SpecialSlotWindow = require(ReplicatedStorage.Modules.SpecialSlotWindow);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
require(ReplicatedStorage.Modules.ConfirmationPromptController);
local DisplayNameSanitizer = require(ReplicatedStorage.Modules.DisplayNameSanitizer);
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer is not found");
local Current_Biome = LocalPlayer:WaitForChild("Current_Biome");
local SaveSlotUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SaveSlotUI");
local u1 = {
    State = false,
    RenderedSlots = {}
};
local RenderedSlots = u1.RenderedSlots;
local SENSOR = SaveSlotUI.Frame.Frame.Holder.Header.Exit.SENSOR;
local ScrollingFrame = SaveSlotUI.Frame.Frame.Holder.Main.ScrollingFrame;
local EasterSlotTemplate = ScrollingFrame.EasterSlotTemplate;
EasterSlotTemplate.Visible = false;
local BeeSlotTemplate = ScrollingFrame.BeeSlotTemplate;
BeeSlotTemplate.Visible = false;
local HalloweenSlotTemplate = ScrollingFrame.HalloweenSlotTemplate;
HalloweenSlotTemplate.Visible = false;
local SlotTemplate = ScrollingFrame.SlotTemplate;
SlotTemplate.Visible = false;
local SLOT_NAME_MAX_LENGTH = SaveSlotController.SLOT_NAME_MAX_LENGTH;
local u2 = nil;
local u3 = false;
local u4 = 0;

local function GetSlotFallbackName(p5: string) -- Line: 67
    -- upvalues: SaveSlotController (copy)
    local SaveSlot = SaveSlotController:GetSaveSlot(p5);

    if SaveSlot then
        SaveSlot = SaveSlot.SlotName;
    end;

    return (type(SaveSlot) ~= "string" or SaveSlot == "") and "Save Slot" or SaveSlot;
end;

local function GetSlotTitleBox(p6: string) -- Line: 78
    -- upvalues: RenderedSlots (copy)
    local v7 = RenderedSlots[p6];

    if not v7 then
        return nil;
    end;

    local TextLabel = v7.Main.TextInstances.TextLabel;

    return TextLabel:IsA("TextBox") and TextLabel and TextLabel or nil;
end;

local function RefreshSlotTitle(p8: string) -- Line: 89
    -- upvalues: u2 (ref), RenderedSlots (copy), SaveSlotController (copy)
    if u2 == p8 then
        return;
    end;

    local v9 = RenderedSlots[p8];

    if not v9 then
        return;
    end;

    local TextLabel = v9.Main.TextInstances.TextLabel;
    local SlotDisplayName = SaveSlotController:GetSlotDisplayName(p8);

    if not SlotDisplayName then
        local SaveSlot = SaveSlotController:GetSaveSlot(p8);

        if SaveSlot then
            SaveSlot = SaveSlot.SlotName;
        end;

        SlotDisplayName = (type(SaveSlot) ~= "string" or SaveSlot == "") and "Save Slot" or SaveSlot;
    end;

    TextLabel.Text = SlotDisplayName;
end;

local function BeginSlotRename(p10: string) -- Line: 103
    -- upvalues: u2 (ref), RenderedSlots (copy), SaveSlotController (copy), u3 (ref)
    if u2 then
        return;
    end;

    local v11 = RenderedSlots[p10];
    local v12;

    if v11 then
        local TextLabel = v11.Main.TextInstances.TextLabel;
        v12 = TextLabel:IsA("TextBox") and TextLabel and TextLabel or nil;
    else
        v12 = nil;
    end;

    if not v12 then
        return;
    end;

    u2 = p10;
    v12.Interactable = true;
    v12.TextEditable = true;
    local SaveSlot = SaveSlotController:GetSaveSlot(p10);

    if SaveSlot then
        SaveSlot = SaveSlot.SlotName;
    end;

    v12.PlaceholderText = (type(SaveSlot) ~= "string" or SaveSlot == "") and "Save Slot" or SaveSlot;
    u3 = true;
    v12.Text = SaveSlotController:GetSlotDisplayName(p10) or "";
    u3 = false;
    v12:CaptureFocus();
    v12.CursorPosition = #v12.Text + 1;
end;

local function CommitSlotRename(p13: string) -- Line: 128
    -- upvalues: u2 (ref), u4 (ref), RenderedSlots (copy), DisplayNameSanitizer (copy), SLOT_NAME_MAX_LENGTH (copy), SaveSlotController (copy)
    if u2 ~= p13 then
        return;
    end;

    u2 = nil;
    u4 = os.clock();
    local v14 = RenderedSlots[p13];
    local v15;

    if v14 then
        local TextLabel = v14.Main.TextInstances.TextLabel;
        v15 = TextLabel:IsA("TextBox") and TextLabel and TextLabel or nil;
    else
        v15 = nil;
    end;

    if not v15 then
        return;
    end;

    v15.Interactable = false;
    v15.TextEditable = false;
    v15.PlaceholderText = "";
    local v16 = DisplayNameSanitizer.Sanitize(v15.Text, SLOT_NAME_MAX_LENGTH);

    if v16 ~= (SaveSlotController:GetSlotDisplayName(p13) or "") then
        SaveSlotController:RenameSaveSlot(p13, v16);
    end;

    if u2 == p13 then
        return;
    end;

    local v17 = RenderedSlots[p13];

    if not v17 then
        return;
    end;

    local TextLabel = v17.Main.TextInstances.TextLabel;
    local SlotDisplayName = SaveSlotController:GetSlotDisplayName(p13);

    if not SlotDisplayName then
        local SaveSlot = SaveSlotController:GetSaveSlot(p13);

        if SaveSlot then
            SaveSlot = SaveSlot.SlotName;
        end;

        SlotDisplayName = (type(SaveSlot) ~= "string" or SaveSlot == "") and "Save Slot" or SaveSlot;
    end;

    TextLabel.Text = SlotDisplayName;
end;

local function ReleaseActiveRename() -- Line: 155
    -- upvalues: u2 (ref), RenderedSlots (copy)
    if not u2 then
        return;
    end;

    local v18 = RenderedSlots[u2];
    local v19;

    if v18 then
        local TextLabel = v18.Main.TextInstances.TextLabel;
        v19 = TextLabel:IsA("TextBox") and TextLabel and TextLabel or nil;
    else
        v19 = nil;
    end;

    if v19 then
        v19:ReleaseFocus();

        return;
    end;

    u2 = nil;
end;

local function SetupSlotRename(u20: string, p21: any) -- Line: 169
    -- upvalues: u2 (ref), u4 (ref), ReleaseActiveRename (copy), BeginSlotRename (copy), CommitSlotRename (copy), u3 (ref), DisplayNameSanitizer (copy), SLOT_NAME_MAX_LENGTH (copy)
    local TextLabel = p21.TextLabel;
    local Rename = p21:FindFirstChild("Rename");
    TextLabel.Interactable = false;
    TextLabel.TextEditable = false;
    TextLabel.PlaceholderText = "";

    if not Rename then
        return;
    end;

    Rename.SENSOR.Activated:Connect(function() -- Line: 181
        -- upvalues: u2 (ref), u4 (ref), ReleaseActiveRename (ref), BeginSlotRename (ref), u20 (copy)
        if u2 or os.clock() - u4 < 0.25 then
            return ReleaseActiveRename();
        end;

        BeginSlotRename(u20);
    end);
    TextLabel.FocusLost:Connect(function() -- Line: 190
        -- upvalues: CommitSlotRename (ref), u20 (copy)
        CommitSlotRename(u20);
    end);
    TextLabel:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 194
        -- upvalues: u2 (ref), u20 (copy), u3 (ref), DisplayNameSanitizer (ref), TextLabel (copy), SLOT_NAME_MAX_LENGTH (ref)
        if u2 ~= u20 or u3 then
            return;
        end;

        local v22 = DisplayNameSanitizer.FilterInput(TextLabel.Text, SLOT_NAME_MAX_LENGTH);

        if v22 == TextLabel.Text then
            return;
        end;

        local CursorPosition = TextLabel.CursorPosition;
        u3 = true;
        TextLabel.Text = v22;
        TextLabel.CursorPosition = math.min(CursorPosition, #v22 + 1);
        u3 = false;
    end);
end;

local function DestroyRenderedSlot(p23: string) -- Line: 213
    -- upvalues: RenderedSlots (copy), u2 (ref)
    if RenderedSlots[p23] then
        if u2 == p23 then
            u2 = nil;
        end;

        RenderedSlots[p23]:Destroy();
        RenderedSlots[p23] = nil;
    end;
end;

local function SetCurrentBiomeForSlotKey(p24: string) -- Line: 224
    -- upvalues: SlotServiceTypes (copy), Current_Biome (copy)
    if p24 == SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 then
        Current_Biome.Value = "BeeGarden";

        return;
    end;

    if p24 == SlotServiceTypes.SpecialSlotKeys.HALLOWEEN_2026 then
        Current_Biome.Value = "GhoulGarden";

        return;
    end;

    Current_Biome.Value = "Day_Time";
end;

local function SyncCurrentBiomeWithSaveSlot() -- Line: 234
    -- upvalues: SaveSlotController (copy), Current_Biome (copy)
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();

    if not CurrentSaveSlot then
        return;
    end;

    if CurrentSaveSlot.IsBeeSlot then
        Current_Biome.Value = "BeeGarden";

        return;
    end;

    if CurrentSaveSlot.IsHalloweenSlot then
        Current_Biome.Value = "GhoulGarden";

        return;
    end;

    Current_Biome.Value = "Day_Time";
end;

function u1.Toggle(p25, p26) -- Line: 249
    -- upvalues: u1 (copy), u2 (ref), RenderedSlots (copy), GuiController (copy), SaveSlotUI (copy)
    u1.State = p26;

    if not p26 and u2 then
        local v27 = RenderedSlots[u2];
        local v28;

        if v27 then
            local TextLabel = v27.Main.TextInstances.TextLabel;
            v28 = TextLabel:IsA("TextBox") and TextLabel and TextLabel or nil;
        else
            v28 = nil;
        end;

        if v28 then
            v28:ReleaseFocus();
        else
            u2 = nil;
        end;
    end;

    if p26 then
        GuiController:Open(SaveSlotUI);

        return;
    end;

    GuiController:Close(SaveSlotUI);
end;

function u1.RenderSlots(p29) -- Line: 263
    -- upvalues: SaveSlotController (copy), Current_Biome (copy), CountDictionary (copy), SlotServiceTypes (copy), RenderedSlots (copy), SlotTemplate (copy), SyncCurrentBiomeWithSaveSlot (copy), SetupSlotRename (copy), TimeHelper (copy), ScrollingFrame (copy), u2 (ref), Chalk (copy), SpecialSlotWindow (copy), UpdateService (copy), EasterSlotTemplate (copy), BeeSlotTemplate (copy), HalloweenSlotTemplate (copy), SaveSlotConfigData (copy), NumberUtil (copy)
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();

    if CurrentSaveSlot then
        if CurrentSaveSlot.IsBeeSlot then
            Current_Biome.Value = "BeeGarden";
        elseif CurrentSaveSlot.IsHalloweenSlot then
            Current_Biome.Value = "GhoulGarden";
        else
            Current_Biome.Value = "Day_Time";
        end;
    end;

    local AllSlots = SaveSlotController:GetAllSlots();
    CountDictionary(AllSlots);
    local CurrentSaveSlot2 = SaveSlotController:GetCurrentSaveSlot();
    local v30 = workspace:GetServerTimeNow() // 1;

    for i, v in AllSlots do
        if not SlotServiceTypes.SpecialSlotKeys[i] then
            local v31 = RenderedSlots[i];

            if not v31 then
                v31 = SlotTemplate:Clone();
                RenderedSlots[i] = v31;
                v31.Main.Buttons.Load.SENSOR.Activated:Connect(function() -- Line: 284
                    -- upvalues: i (copy), SlotServiceTypes (ref), Current_Biome (ref), SaveSlotController (ref), SyncCurrentBiomeWithSaveSlot (ref)
                    local v32 = i;

                    if v32 == SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 then
                        Current_Biome.Value = "BeeGarden";
                    elseif v32 == SlotServiceTypes.SpecialSlotKeys.HALLOWEEN_2026 then
                        Current_Biome.Value = "GhoulGarden";
                    else
                        Current_Biome.Value = "Day_Time";
                    end;

                    SaveSlotController:ChangeSlots(i);
                    task.defer(SyncCurrentBiomeWithSaveSlot);
                end);
                local TextInstances = v31.Main.TextInstances;
                local TextLabel1 = TextInstances.TextLabel1;
                SetupSlotRename(i, TextInstances);
                local LastLoaded = v.LastLoaded;
                local v33;

                if LastLoaded and LastLoaded > 0 then
                    v33 = v30 - LastLoaded;
                else
                    v33 = nil;
                end;

                TextLabel1.Text = `Last Loaded: {(not v33 or v33 <= 2) and "now" or `{TimeHelper:GenerateTextFromTime(v33, true)} Ago`}`;
                v31.Visible = true;
                v31.Parent = ScrollingFrame;
            end;

            if v31:FindFirstChild("Main") then
                local v34 = v == CurrentSaveSlot2;
                local SelectedOverlay = v31.Main.Buttons.SelectedOverlay;
                v31.Main.Buttons.Load.Visible = not v34;
                SelectedOverlay.Visible = v34;

                if u2 ~= i then
                    local v35 = RenderedSlots[i];

                    if v35 then
                        local TextLabel = v35.Main.TextInstances.TextLabel;
                        local SlotDisplayName = SaveSlotController:GetSlotDisplayName(i);

                        if not SlotDisplayName then
                            local SaveSlot = SaveSlotController:GetSaveSlot(i);

                            if SaveSlot then
                                SaveSlot = SaveSlot.SlotName;
                            end;

                            SlotDisplayName = (type(SaveSlot) ~= "string" or SaveSlot == "") and "Save Slot" or SaveSlot;
                        end;

                        TextLabel.Text = SlotDisplayName;
                    end;
                end;
            end;
        end;
    end;

    for i, v in SlotServiceTypes.SpecialSlotEntries do
        local v36 = v.DisplayName or "Special";
        local v37 = v.Color or Color3.fromRGB(255, 170, 0);
        Chalk.color(v37)(v36 .. "Garden");
        local UpdateGate = v.UpdateGate;
        local v38 = AllSlots[i];

        if i == SlotServiceTypes.SpecialSlotKeys.EASTER_2026 and not v38 then
            if RenderedSlots[i] then
                if u2 == i then
                    u2 = nil;
                end;

                RenderedSlots[i]:Destroy();
                RenderedSlots[i] = nil;
            end;
        elseif v38 or SpecialSlotWindow.IsOpen(i) then
            if i ~= SlotServiceTypes.SpecialSlotKeys.EASTER_2026 and (i ~= SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 and UpdateGate) and ((UpdateService:IsHiddenFromUpdate(UpdateGate) or UpdateService:IsHiddenAfterUpdate(UpdateGate)) and not v38) then
                if RenderedSlots[i] then
                    if u2 == i then
                        u2 = nil;
                    end;

                    RenderedSlots[i]:Destroy();
                    RenderedSlots[i] = nil;
                end;
            else
                if RenderedSlots[i] then
                    if u2 == i then
                        u2 = nil;
                    end;

                    RenderedSlots[i]:Destroy();
                    RenderedSlots[i] = nil;
                end;

                local v39;

                if i == SlotServiceTypes.SpecialSlotKeys.EASTER_2026 then
                    v39 = EasterSlotTemplate:Clone();
                elseif i == SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 then
                    v39 = BeeSlotTemplate:Clone();
                elseif i == SlotServiceTypes.SpecialSlotKeys.HALLOWEEN_2026 then
                    v39 = HalloweenSlotTemplate:Clone();
                else
                    v39 = SlotTemplate:Clone();
                end;

                RenderedSlots[i] = v39;
                v39.Visible = true;
                v39.Parent = ScrollingFrame;
                local TextInstances = v39.Main.TextInstances;
                local TextLabel = TextInstances.TextLabel;
                local TextLabel1 = TextInstances.TextLabel1;
                local Rename = TextInstances:FindFirstChild("Rename");

                if Rename then
                    Rename.Visible = false;
                end;

                if TextLabel:IsA("TextBox") then
                    TextLabel.Interactable = false;
                    TextLabel.TextEditable = false;
                end;

                local Load = v39.Main.Buttons.Load;
                local SelectedOverlay = v39.Main.Buttons.SelectedOverlay;

                if v38 then
                    if i == SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 then
                        TextLabel.Text = "Bizzy Bee";
                    else
                        TextLabel.Text = v38.SlotName;
                    end;

                    local LastLoaded = v38.LastLoaded;
                    local v40;

                    if LastLoaded and LastLoaded > 0 then
                        v40 = v30 - LastLoaded;
                    else
                        v40 = nil;
                    end;

                    TextLabel1.Text = `Last Loaded: {(not v40 or v40 <= 2) and "now" or `{TimeHelper:GenerateTextFromTime(v40, true)} Ago`}`;
                    local v41 = v38 == CurrentSaveSlot2;
                    Load.Visible = not v41;
                    SelectedOverlay.Visible = v41;
                    Load.SENSOR.Activated:Connect(function() -- Line: 425
                        -- upvalues: i (copy), SlotServiceTypes (ref), Current_Biome (ref), SaveSlotController (ref), SyncCurrentBiomeWithSaveSlot (ref)
                        local v42 = i;

                        if v42 == SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 then
                            Current_Biome.Value = "BeeGarden";
                        elseif v42 == SlotServiceTypes.SpecialSlotKeys.HALLOWEEN_2026 then
                            Current_Biome.Value = "GhoulGarden";
                        else
                            Current_Biome.Value = "Day_Time";
                        end;

                        SaveSlotController:ChangeSlots(i);
                        task.defer(SyncCurrentBiomeWithSaveSlot);
                    end);
                else
                    TextLabel.Text = v36;
                    TextLabel1.Text = "Limited Event Slot";
                    Load.Visible = true;
                    SelectedOverlay.Visible = false;

                    if i == SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 then
                        Load.BackgroundColor3 = Color3.fromRGB(38, 238, 38);
                        Load.UIStroke.Color = Color3.fromRGB(3, 126, 3);
                        Load.LOAD_BUTTON.Text = "$1B";
                        Load.LOAD_BUTTON.UIStroke.Color = Color3.fromRGB(2, 72, 2);
                        Load.LOAD_BUTTON.UIStroke.Thickness = 1.553;
                    else
                        Load.LOAD_BUTTON.Text = "Opt In";
                    end;

                    Load.SENSOR.Activated:Connect(function() -- Line: 448
                        -- upvalues: i (copy), SlotServiceTypes (ref), SaveSlotController (ref), Current_Biome (ref), SyncCurrentBiomeWithSaveSlot (ref)
                        if i == SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 then
                            SaveSlotController:PurchaseEventSlot(SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026);

                            return;
                        end;

                        local v43 = i;

                        if v43 == SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026 then
                            Current_Biome.Value = "BeeGarden";
                        elseif v43 == SlotServiceTypes.SpecialSlotKeys.HALLOWEEN_2026 then
                            Current_Biome.Value = "GhoulGarden";
                        else
                            Current_Biome.Value = "Day_Time";
                        end;

                        SaveSlotController:OptInToSpecialSlot(i);
                        SaveSlotController:ChangeSlots(i);
                        task.defer(SyncCurrentBiomeWithSaveSlot);
                    end);
                end;
            end;
        elseif RenderedSlots[i] then
            if u2 == i then
                u2 = nil;
            end;

            RenderedSlots[i]:Destroy();
            RenderedSlots[i] = nil;
        end;
    end;

    local v44 = 0;

    for i, _ in AllSlots do
        if not SlotServiceTypes.SpecialSlotKeys[i] then
            v44 = v44 + 1;
        end;
    end;

    local v45 = v44 + 1;

    if SaveSlotController:HasPurchasedSlotFromAscension() and v44 < SaveSlotConfigData.MAX_SLOTS then
        v45 = v45 - 1;
    end;

    if not SaveSlotController:HasPurchasedSlotFromAscension() and v44 == SaveSlotConfigData.MAX_SLOTS - 1 then
        ScrollingFrame.SlotPurchaseTemplate.Visible = false;

        return;
    end;

    local v46 = `${NumberUtil.FormatCompactPrice(SaveSlotConfigData.PRICES[v45] or -1)}`;
    ScrollingFrame.SlotPurchaseTemplate.Main.TextInstances.TextLabel1.Text = `{v46} or <font color="#26ff26">399</font>`;
    ScrollingFrame.SlotPurchaseTemplate.Main.Buttons.Purchase.LOAD_BUTTON.Text = v46;
    ScrollingFrame.SlotPurchaseTemplate.Visible = v44 < SaveSlotConfigData.MAX_SLOTS;
end;

function u1.UpdateTime(p47) -- Line: 489
    -- upvalues: SaveSlotController (copy), RenderedSlots (copy), TimeHelper (copy)
    local AllSlots = SaveSlotController:GetAllSlots();
    local ServerTimeNow = workspace:GetServerTimeNow();

    for i, v in AllSlots do
        local v48 = RenderedSlots[i];

        if v48 then
            local LastLoaded = v.LastLoaded;
            local v49;

            if LastLoaded and LastLoaded > 0 then
                v49 = ServerTimeNow - LastLoaded;
            else
                v49 = nil;
            end;

            v48.Main.TextInstances.TextLabel1.Text = `Last Loaded: {(not v49 or v49 <= 2) and "now" or `{TimeHelper:GenerateTextFromTime(ServerTimeNow - v.LastLoaded, true)} Ago`}`;
        end;
    end;
end;

task.spawn(function() -- Line: 516
    -- upvalues: u1 (copy)
    while true do
        u1:UpdateTime();
        task.wait(1);
    end;
end);
task.spawn(function() -- Line: 523
    -- upvalues: GuiController (copy), SaveSlotUI (copy), MarketController (copy), ScrollingFrame (copy), DevProductIds (copy), u1 (copy), u2 (ref), RenderedSlots (copy), SENSOR (copy), SaveSlotController (copy), Current_Biome (copy), DataService (copy), UpdateService (copy)
    GuiController:UsePopupAnims(SaveSlotUI);
    local StateForGui = GuiController:GetStateForGui(SaveSlotUI);
    MarketController:SetPriceLabel(ScrollingFrame.SlotPurchaseTemplate.Main.Buttons.PurchaseRobux.LOAD_BUTTON, DevProductIds.SaveSlotPurchase.PurchaseID, "<font weight=\"200\">:robux:</font>:value:");
    MarketController:SetPriceLabel(ScrollingFrame.SlotPurchaseTemplate.Main.TextInstances.TextLabel1, DevProductIds.SaveSlotPurchase.PurchaseID, "$25B or <font color=\"#26ff26\">:robux::value:</font>");
    StateForGui.Visible:Observe(function(p50: boolean) -- Line: 540
        -- upvalues: u1 (ref), u2 (ref), RenderedSlots (ref)
        u1.State = p50;

        if p50 then
            u1:RenderSlots();

            return;
        end;

        if not u2 then
            return;
        end;

        local v51 = RenderedSlots[u2];
        local v52;

        if v51 then
            local TextLabel = v51.Main.TextInstances.TextLabel;
            v52 = TextLabel:IsA("TextBox") and TextLabel and TextLabel or nil;
        else
            v52 = nil;
        end;

        if v52 then
            v52:ReleaseFocus();

            return;
        end;

        u2 = nil;
    end);
    SENSOR.Activated:Connect(function() -- Line: 550
        -- upvalues: u1 (ref)
        u1:Toggle(false);
    end);
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();

    if CurrentSaveSlot then
        if CurrentSaveSlot.IsBeeSlot then
            Current_Biome.Value = "BeeGarden";
        elseif CurrentSaveSlot.IsHalloweenSlot then
            Current_Biome.Value = "GhoulGarden";
        else
            Current_Biome.Value = "Day_Time";
        end;
    end;

    assert(DataService:GetPathSignal("SaveSlots/@")):Connect(function() -- Line: 556
        -- upvalues: SaveSlotController (ref), Current_Biome (ref), StateForGui (copy), u1 (ref)
        local CurrentSaveSlot2 = SaveSlotController:GetCurrentSaveSlot();

        if CurrentSaveSlot2 then
            if CurrentSaveSlot2.IsBeeSlot then
                Current_Biome.Value = "BeeGarden";
            elseif CurrentSaveSlot2.IsHalloweenSlot then
                Current_Biome.Value = "GhoulGarden";
            else
                Current_Biome.Value = "Day_Time";
            end;
        end;

        if StateForGui.Visible:Get() then
            u1:RenderSlots();
        end;
    end);
    ScrollingFrame.SlotPurchaseTemplate.Main.Buttons.Purchase.SENSOR.Activated:Connect(function() -- Line: 564
        -- upvalues: SaveSlotController (ref)
        SaveSlotController:PurchaseSlot();
    end);
    ScrollingFrame.SlotPurchaseTemplate.Main.Buttons.PurchaseRobux.SENSOR.Activated:Connect(function() -- Line: 568
        -- upvalues: DevProductIds (ref), MarketController (ref)
        MarketController:PromptPurchase(DevProductIds.SaveSlotPurchase.PurchaseID, Enum.InfoType.Product);
    end);
    UpdateService.OnUpdated:Connect(function() -- Line: 574
        -- upvalues: u1 (ref)
        u1:RenderSlots();
    end);
end);

return u1;