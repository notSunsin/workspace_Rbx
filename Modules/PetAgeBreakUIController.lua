-- Decompiled with Potassium's decompiler.

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local TweenService = game:GetService("TweenService");
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local DataService = require(ReplicatedStorage.Modules.DataService);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local CalculatePetValue = require(ReplicatedStorage.Modules.CalculatePetValue);
require(ReplicatedStorage.Comma_Module);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.PetServices.PetsService);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local PetAgeBreakMachineData = require(ReplicatedStorage.Data.PetAgeBreakMachineData);
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local PetList = PetRegistry.PetList;
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local PetAgeLimitBreak_Submit = GameEvents:WaitForChild("PetAgeLimitBreak_Submit");
local Favorite_Item_BE = GameEvents:WaitForChild("Favorite_Item_BE");
local PetAgeLimitBreak_Cancel = GameEvents.PetAgeLimitBreak_Cancel;
local PetAgeBreak_UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetAgeBreak_UI");
local Main = PetAgeBreak_UI:WaitForChild("Main");
local _ = Main.Main.SellCosts.Main.Sell;
local Details = Main:WaitForChild("Details");
local NoDupeText = Main:FindFirstChild("NoDupeText", true);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = nil;
local u5 = {};
local u6 = nil;

local function TweenDetails(p7) -- Line: 50
    -- upvalues: TweenService (copy), Details (copy)
    local v8 = {
        Position = p7 and UDim2.new(0.8, 0, 0.5, 0) or UDim2.new(0.6, 0, 0.5, 0)
    };
    local v9 = {
        Scale = p7 and 1 or 0.1
    };
    local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    TweenService:Create(Details, TweenInfo_new_ret, v8):Play();
    local v10 = Details:FindFirstChildWhichIsA("UIScale");

    if v10 then
        TweenService:Create(v10, TweenInfo_new_ret, v9):Play();
    end;
end;

local function RefreshToolCache() -- Line: 60
    -- upvalues: u4 (ref), LocalPlayer (copy)
    u4 = {};

    for _, child in LocalPlayer.Backpack:GetChildren() do
        local Attribute = child:GetAttribute("PET_UUID");

        if Attribute then
            u4[Attribute] = child;
        end;
    end;

    for _, child in LocalPlayer.Character:GetChildren() do
        local Attribute = child:GetAttribute("PET_UUID");

        if Attribute then
            u4[Attribute] = child;
        end;
    end;
end;

local function GetToolFromUUID(p11) -- Line: 72
    -- upvalues: u4 (ref), RefreshToolCache (copy)
    if not u4 then
        RefreshToolCache();
    end;

    return u4[p11];
end;

local function UpdateDetails(p12) -- Line: 78
    -- upvalues: PetList (copy), PetUtilities (copy), Details (copy)
    local v13 = PetList[p12.PetType];
    local PetData = p12.PetData;
    local Level = PetData.Level;
    local v14 = PetUtilities:CalculateWeight(PetData.BaseWeight, Level) * 100;
    local v15 = math.round(v14) / 100;
    Details.Holder.Header.PET_TEXT.Text = p12.PetType or "Unknown";
    Details.Holder.Display.Display.PET_NAME_CONFIG.Text = PetData.Name or "Unnamed";
    Details.Holder.Display.Display.PET_IMAGE.Image = v13.Icon or "";
    Details.Holder.Description.Display.PET_DESCRIPTION.Text = v13.Description or "No description available.";
    Details.Holder.Stats.Holder.Weight.PET_WEIGHT.Text = `Weight: {v15} KG`;
    Details.Holder.Stats.Holder.Age.PET_AGE.Text = `Age: {Level}`;
end;

local function SetSelectedStyle(p16, p17) -- Line: 92
    if not p16:FindFirstChild("Display") then
        return;
    end;

    if p17 then
        p16.Display.BackgroundColor3 = Color3.fromRGB(30, 100, 14);
        p16.Display.UIStroke.Color = Color3.fromRGB(37, 238, 38);
        p16.Display.SELECTED_VIGNETTE.Visible = true;

        return;
    end;

    p16.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
    p16.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
    p16.Display.SELECTED_VIGNETTE.Visible = false;
end;

function u1.UpdatePetCard(p18, u19, u20) -- Line: 109
    -- upvalues: Main (copy), u5 (copy), u6 (ref), SetSelectedStyle (copy), u4 (ref), u1 (copy), u3 (ref), u2 (ref), TweenDetails (copy), UpdateDetails (copy), CountDictionary (copy)
    local _ = Main.Main.Holder.SellFrame.BackgroundFrame.SellScrollingFrame;
    u19.Favorite.Visible = u20.PetData.IsFavorite and true or false;

    if u5[u19.Name] ~= nil then
        u5[u19.Name]:Disconnect();
        u5[u19.Name] = nil;
    end;

    u5[u19.Name] = u19.MouseButton1Click:Connect(function() -- Line: 119
        -- upvalues: u6 (ref), u20 (copy), SetSelectedStyle (ref), u19 (copy), u4 (ref), u1 (ref), u3 (ref), u2 (ref), TweenDetails (ref), UpdateDetails (ref), Main (ref), CountDictionary (ref)
        local v21;

        if u6 == u20.UUID then
            v21 = nil;
        else
            v21 = u20.UUID;
        end;

        u6 = v21;

        if not u20.PetData.IsFavorite then
            SetSelectedStyle(u19, not u19.Display.SELECTED_VIGNETTE.Visible);
            local v22 = u4[u20.UUID];

            if not (v22 and v22:IsDescendantOf(game)) then
                warn("Tool not found or destroyed:", u20.UUID);
                local v23 = u19;

                if not v23:FindFirstChild("Display") then
                    return;
                end;

                v23.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
                v23.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
                v23.Display.SELECTED_VIGNETTE.Visible = false;

                return;
            end;

            u1:ClearSelection();

            if u19.Display.SELECTED_VIGNETTE.Visible then
                u3[v22] = true;
                u2[u20.UUID] = u19;
                UpdateDetails(u20);
                TweenDetails(true);
            else
                u3[v22] = nil;
                u2[u20.UUID] = nil;
                TweenDetails(false);
            end;

            Main.Main.SellCosts.Main.SelectedAmount.Text = CountDictionary(u3) .. " Selected";
        end;
    end);
end;

function u1.GetPetFrame(p24: table, p25: string) -- Line: 151
    -- upvalues: Main (copy)
    return Main.Main.Holder.SellFrame.BackgroundFrame.SellScrollingFrame:FindFirstChild(p25);
end;

function u1.ClearSelection(p26) -- Line: 157
    -- upvalues: u2 (ref), Main (copy), u3 (ref), TweenDetails (copy)
    if next(u2) == nil then
        return;
    end;

    for _, v in pairs(u2) do
        if v:FindFirstChild("Display") then
            v.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
            v.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
            v.Display.SELECTED_VIGNETTE.Visible = false;
        end;
    end;

    Main.Main.SellCosts.Main.SelectedAmount.Text = 0 .. " Selected";
    u2 = {};
    u3 = {};
    TweenDetails(false);
end;

function u1.RefreshUI(p27) -- Line: 168
    -- upvalues: u6 (ref), TweenDetails (copy), RefreshToolCache (copy), DataService (copy), Main (copy), PetUtilities (copy), LocalPlayer (copy), u5 (copy), u4 (ref), PetList (copy), u1 (copy), NoDupeText (copy), CountDictionary (copy), PetAgeBreakMachineData (copy), NumberUtil (copy)
    u6 = nil;
    TweenDetails(false);
    RefreshToolCache();
    local Data = DataService:GetData();
    local _ = Data.PetsData.MutableStats;
    local PetAgeBreakMachine = Data.PetAgeBreakMachine;

    if not PetAgeBreakMachine.SubmittedPet then
        return;
    end;

    local SellScrollingFrame = Main.Main.Holder.SellFrame.BackgroundFrame.SellScrollingFrame;
    local TEMPLATE = SellScrollingFrame:FindFirstChild("TEMPLATE");

    for _, child in SellScrollingFrame:GetChildren() do
        if child:IsA("ImageButton") and child.Name ~= "TEMPLATE" then
            child:Destroy();
        end;
    end;

    TEMPLATE.Visible = false;
    local PetsSortedByAge = PetUtilities:GetPetsSortedByAge(LocalPlayer, 0, true, false);

    if not PetsSortedByAge or #PetsSortedByAge == 0 then
        return;
    end;

    for _, v in u5 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u5);

    for _, v in PetsSortedByAge do
        if v.PetData.Level >= 0 then
            local v28 = u4[v.UUID];

            if v28 and (v28.Parent and v.PetType == PetAgeBreakMachine.SubmittedPet.PetType) then
                local v29 = TEMPLATE:Clone();
                v29.Visible = true;
                v29.Name = v.UUID;
                v29.Favorite.Visible = v.PetData.IsFavorite and true or false;
                local v30 = PetList[v.PetType];
                v29.Display.PET_NAME.Text = v.PetType;
                local PET_AGE = v29.Display.PET_AGE;
                local Level = v.PetData.Level;
                local v31 = PetUtilities:CalculateWeight(v.PetData.BaseWeight, v.PetData.Level) * 100;
                PET_AGE.Text = `Age: {Level} • {math.round(v31) / 100} KG`;
                v29.Display.DetailHolder.PET_IMAGE.Image = v30.Icon;

                if v29:FindFirstChild("Display") then
                    v29.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
                    v29.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
                    v29.Display.SELECTED_VIGNETTE.Visible = false;
                end;

                u1:UpdatePetCard(v29, v);
                v29.Parent = SellScrollingFrame;
            end;
        end;
    end;

    NoDupeText.Visible = CountDictionary(u5) <= 0;
    Main.Main.SellCosts.Main.CostAmount.Text = `{NumberUtil.FormatCompactPrice((PetAgeBreakMachine.SubmittedPet.PetData.Level + 1 - PetAgeBreakMachineData.REQUIRED_PET_LEVEL) * PetAgeBreakMachineData.AGEUP_PRICE)} ¢`;
end;

function u1.Start(p32) -- Line: 236
    -- upvalues: GuiController (copy), PetAgeBreak_UI (copy), u4 (ref), u3 (ref), u1 (copy), Main (copy), PetAgeLimitBreak_Cancel (copy), Notification (copy), DataService (copy), PetsService (copy), PetAgeBreakMachineData (copy), NumberUtil (copy), ReplicatedStorage (copy), ConfirmationPromptController (copy), PetAgeLimitBreak_Submit (copy), u2 (ref), u6 (ref)
    GuiController:UsePopupAnims(PetAgeBreak_UI);

    if u4 ~= nil then
        table.clear(u4);
        u4 = {};
    end;

    if u3 ~= nil then
        table.clear(u3);
        u3 = {};
    end;

    local u33 = {};

    local function IsDebounced(p34: any, p35: number?) -- Line: 248
        -- upvalues: u33 (copy)
        if u33[p34] and (p35 or 0.5) > tick() - u33[p34] then
            return true;
        end;

        u33[p34] = tick();

        return false;
    end;

    u1:ClearSelection();
    u1:RefreshUI();
    Main.Main.Header.Exit.SENSOR.MouseButton1Click:Connect(function() -- Line: 257
        -- upvalues: u33 (copy), u1 (ref), GuiController (ref), PetAgeBreak_UI (ref)
        local v36;

        if u33.ExitHeader and (nil or 0.5) > tick() - u33.ExitHeader then
            v36 = true;
        else
            u33.ExitHeader = tick();
            v36 = false;
        end;

        if v36 then
            return;
        end;

        u1:ClearSelection();
        GuiController:Close(PetAgeBreak_UI);
    end);
    Main.Main.Header.CancelAge.SENSOR.MouseButton1Click:Connect(function() -- Line: 263
        -- upvalues: PetAgeLimitBreak_Cancel (ref), u1 (ref), GuiController (ref), PetAgeBreak_UI (ref)
        PetAgeLimitBreak_Cancel:FireServer();
        u1:ClearSelection();
        GuiController:Close(PetAgeBreak_UI);
    end);
    Main.Main.SellCosts.Main.Clear.SENSOR.MouseButton1Click:Connect(function() -- Line: 270
        -- upvalues: u33 (copy), u1 (ref)
        local v37;

        if u33.Clear and (nil or 0.5) > tick() - u33.Clear then
            v37 = true;
        else
            u33.Clear = tick();
            v37 = false;
        end;

        if v37 then
            return;
        end;

        u1:ClearSelection();
    end);
    Main.Main.SellCosts.Main.Sell.SENSOR.MouseButton1Click:Connect(function() -- Line: 275
        -- upvalues: u33 (copy), u3 (ref), Notification (ref), DataService (ref), PetsService (ref), PetAgeBreakMachineData (ref), NumberUtil (ref), ReplicatedStorage (ref), ConfirmationPromptController (ref), PetAgeLimitBreak_Submit (ref), u4 (ref), u2 (ref), u1 (ref), u6 (ref), GuiController (ref), PetAgeBreak_UI (ref)
        local v38;

        if u33.Sell and (nil or 0.5) > tick() - u33.Sell then
            v38 = true;
        else
            u33.Sell = tick();
            v38 = false;
        end;

        if v38 then
            return;
        end;

        local v39 = {};

        for i, _ in u3 do
            local Attribute = i:GetAttribute("PET_UUID");
            table.insert(v39, Attribute);
        end;

        if #v39 ~= 1 then
            Notification:CreateNotification("Please submit one pet only!");

            return;
        end;

        local Data = DataService:GetData();
        local PetAgeBreakMachine = Data.PetAgeBreakMachine;

        for _, v in v39 do
            local PlayerPetData = PetsService:GetPlayerPetData(v);

            if not PlayerPetData then
                Notification:CreateNotification("Invalid Pet Submitted!");

                return;
            end;

            if PlayerPetData.PetType ~= PetAgeBreakMachine.SubmittedPet.PetType then
                Notification:CreateNotification((`You can only submit {PetAgeBreakMachine.SubmittedPet.PetType}.`));

                return;
            end;
        end;

        local v40 = (PetAgeBreakMachine.SubmittedPet.PetData.Level + 1 - PetAgeBreakMachineData.REQUIRED_PET_LEVEL) * PetAgeBreakMachineData.AGEUP_PRICE;

        if Data.Sheckles < v40 then
            Notification:CreateNotification((`You need {NumberUtil.DisplaySheckles(v40)}`));

            return;
        end;

        local PlayerPetData = PetsService:GetPlayerPetData(v39[1]);
        print(PlayerPetData);
        local v41 = require(ReplicatedStorage.Data.PetRegistry.PetList)[PlayerPetData.PetType];
        local v42 = not v41 and "Common" or v41.Rarity;
        ConfirmationPromptController:Open({
            Title = "Pet Fuse Confirmation",
            Header = "Are you sure you want to use this pet as the dupe?",
            Footer = "This will fuse this pet into the higher level pet!",
            Middle = `{PlayerPetData.PetType} [Age {PlayerPetData.PetData.Level}]`,
            AnimatedWords = {
                [`{PlayerPetData.PetType}`] = v42
            }
        }, {
            ConfirmEvent = PetAgeLimitBreak_Submit,
            ConfirmEventData = { v39 }
        });

        for _, v in v39 do
            u4[v] = nil;

            if u2[v] then
                u2[v]:Destroy();
                u2[v] = nil;
            end;
        end;

        u1:ClearSelection();
        table.clear(u3);
        table.clear(u2);
        u6 = nil;
        u1:RefreshUI();
        GuiController:Close(PetAgeBreak_UI);
    end);
    DataService:GetPathSignal("PetAgeBreakMachine/SubmittedPet"):Connect(function() -- Line: 358
        -- upvalues: DataService (ref), u1 (ref), GuiController (ref), PetAgeBreak_UI (ref)
        task.wait(0.5);
        local PetAgeBreakMachine = DataService:GetData().PetAgeBreakMachine;
        u1:RefreshUI();

        if not PetAgeBreakMachine.SubmittedPet then
            GuiController:Close(PetAgeBreak_UI);
        end;
    end);
end;

function u1.Open(p43) -- Line: 373
    -- upvalues: u1 (copy), GuiController (copy), PetAgeBreak_UI (copy)
    u1:RefreshUI();
    GuiController:Open(PetAgeBreak_UI);
end;

Favorite_Item_BE.Event:Connect(function(p44: userdata) -- Line: 378
    -- upvalues: PetsService (copy), u1 (copy), CalculatePetValue (copy), u4 (ref), RefreshToolCache (copy), u3 (ref), u2 (ref)
    if not p44 then
        warn("PetAgeBreakUIController:Favorite_Item_BE | No pet tool!");

        return;
    end;

    local Attribute = p44:GetAttribute("PET_UUID");

    if not Attribute then
        return;
    end;

    task.wait(0.25);
    local PlayerPetData = PetsService:GetPlayerPetData(Attribute);

    if not PlayerPetData then
        return warn("PetAgeBreakUIController:Favorite_Item_BE | No pet data found!");
    end;

    local PetFrame = u1:GetPetFrame(Attribute);

    if not PetFrame then
        return;
    end;

    if PetFrame then
        u1:UpdatePetCard(PetFrame, PlayerPetData);

        if PetFrame:FindFirstChild("Display") then
            PetFrame.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
            PetFrame.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
            PetFrame.Display.SELECTED_VIGNETTE.Visible = false;
        end;
    else
        u1:RefreshUI();
    end;

    local UUID = PlayerPetData.UUID;

    if not u4 then
        RefreshToolCache();
    end;

    CalculatePetValue(u4[UUID]);

    if PlayerPetData.PetData.IsFavorite and (u3[p44] and u2[PlayerPetData.UUID]) then
        u3[p44] = nil;
        u2[PlayerPetData.UUID] = nil;
    end;
end);
task.spawn(u1.Start, u1);

return u1;