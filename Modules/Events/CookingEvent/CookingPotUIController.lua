-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.FoodService);
require(ReplicatedStorage.Modules.InventoryService);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.UpdateService);
local Spr = require(ReplicatedStorage.Code.Spr);
local GardenGuideUIController = require(ReplicatedStorage.Modules.GardenGuideModules.GardenGuideUIController);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local CookingPotService_RE = ReplicatedStorage.GameEvents:WaitForChild("CookingPotService_RE");
local u1 = Trove.new();
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "No player");
local u2 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local _ = LocalPlayer.PlayerGui;
local u3 = {};

local function CanSubmitPlant() -- Line: 33
    -- upvalues: DataService (copy)
    local IsCooking = DataService:GetData().CookingPot.IsCooking;
    local v4 = DataService:GetData().CookingPot.CookingEndTime or nil;
    local FinishedFoodRawData = DataService:GetData().CookingPot.FinishedFoodRawData;

    if IsCooking then
        return false;
    end;

    return (not FinishedFoodRawData or v4) and true or false;
end;

function u3.Start(p5) -- Line: 44
    -- upvalues: CollectionService (copy), TweenService (copy), DataService (copy), u2 (copy), NumberUtil (copy), u1 (copy), Spr (copy), CookingPotService_RE (copy), LocalPlayer (copy), GardenGuideUIController (copy)
    local u6 = CollectionService:GetTagged("CookingEventModel")[1];
    local SubmitFoodProxPrompt = u6.CookingPotPart.SubmitFoodProxPrompt;
    local GetFoodProxPrompt = u6.CookingPotPart.GetFoodProxPrompt;
    local SkipCookingProxPrompt = u6.CookingPotPart.SkipCookingProxPrompt;
    local CookingIngredientGui = u6.IngredientsBoard.CookingIngredientGui;
    local InsidePotFrame = CookingIngredientGui.Background.InsidePotFrame;
    local PotItemTemplate = u6.Templates.PotItemTemplate;
    local EmptyPotFrame = CookingIngredientGui.Background.ExtraUI.EmptyPotFrame;
    local EmptyButton = EmptyPotFrame:FindFirstChild("EmptyButton");
    local StartCookingFrame = u6.ResultsListPart.SurfaceGui.StartCookingFrame;
    local TimeLabel = u6.IngredientsBoard.CookTimeDisplay.Face.SurfaceGui.TimeDisplayFrame.TimeLabel;
    local TextColor3 = TimeLabel.TextColor3;
    local Button = u6.CookButton.Button;
    local UI = Button.UI;
    local CookingButtonGui = UI.CookingButtonGui;
    local CookButton = CookingButtonGui.CookButton;
    local TextLabel = CookingButtonGui.TextLabel;
    local _ = Button.Position - u6:GetPivot().Position;
    local v7 = CollectionService:GetTagged("MutationDial")[1];
    local NeedleMotor = v7.Dial.Center.NeedleMotor;
    local ChanceText = v7.Dial.Back.DialGui.DialFrame.ChanceText;
    v7.Dial.Needle:GetPivot();
    local Color3_fromRGB_ret = Color3.fromRGB(128, 128, 128);
    local Color3_fromRGB_ret2 = Color3.fromRGB(91, 154, 76);
    local CFrame2 = Button.CFrame;
    local CFrame3 = UI.CFrame;
    local u8 = Button.CFrame * CFrame.new(-0.25, 0, 0);
    local u9 = UI.CFrame * CFrame.new(0, 0, 0.25);
    local AddItem = u6.PotModel.AddItem;
    local StartCooking = u6.PotModel.StartCooking;
    local SkipCooking = u6.PotModel.SkipCooking;
    local CookingDone = u6.PotModel.CookingDone;
    local Click = game.SoundService.Click;

    local function ToggleButtonVisual(p10: boolean) -- Line: 101
        -- upvalues: Click (copy), TweenService (ref), Button (copy), u8 (copy), UI (copy), u9 (copy), CFrame2 (copy), CFrame3 (copy)
        if not p10 then
            TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Circular), {
                CFrame = CFrame2
            }):Play();
            TweenService:Create(UI, TweenInfo.new(0.2, Enum.EasingStyle.Circular), {
                CFrame = CFrame3
            }):Play();

            return;
        end;

        Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        Click.Playing = true;
        Click.TimePosition = 0;
        TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Circular), {
            CFrame = u8
        }):Play();
        TweenService:Create(UI, TweenInfo.new(0.2, Enum.EasingStyle.Circular), {
            CFrame = u9
        }):Play();
    end;

    local function UpdateProxPrompts() -- Line: 131
        -- upvalues: DataService (ref), StartCookingFrame (copy), SubmitFoodProxPrompt (copy), GetFoodProxPrompt (copy), SkipCookingProxPrompt (copy), Button (copy), Color3_fromRGB_ret (copy), CookButton (copy), Color3_fromRGB_ret2 (copy), ToggleButtonVisual (copy), u2 (ref)
        local IsCooking = DataService:GetData().CookingPot.IsCooking;
        local v11 = DataService:GetData().CookingPot.CookingEndTime or nil;
        local FinishedFoodRawData = DataService:GetData().CookingPot.FinishedFoodRawData;

        if IsCooking then
            StartCookingFrame.Visible = false;
            SubmitFoodProxPrompt.Enabled = false;
            GetFoodProxPrompt.Enabled = false;
            SkipCookingProxPrompt.Enabled = true;
            Button.Color = Color3_fromRGB_ret;
            CookButton.Interactable = false;
        elseif FinishedFoodRawData and not v11 then
            SubmitFoodProxPrompt.Enabled = false;
            GetFoodProxPrompt.Enabled = true;
            SkipCookingProxPrompt.Enabled = false;
            Button.Color = Color3_fromRGB_ret;
            CookButton.Interactable = false;
        elseif not (FinishedFoodRawData or (IsCooking or v11)) then
            SubmitFoodProxPrompt.Enabled = false;
            GetFoodProxPrompt.Enabled = false;
            SkipCookingProxPrompt.Enabled = false;
            Button.Color = Color3_fromRGB_ret2;
            ToggleButtonVisual(false);
            CookButton.Interactable = true;
        end;

        local v12 = u2:FindFirstChildOfClass("Tool");

        if v12 and v12:HasTag("FruitTool") then
            local IsCooking2 = DataService:GetData().CookingPot.IsCooking;
            local v13 = DataService:GetData().CookingPot.CookingEndTime or nil;
            local FinishedFoodRawData2 = DataService:GetData().CookingPot.FinishedFoodRawData;
            local v14;

            if IsCooking2 then
                v14 = false;
            else
                v14 = (not FinishedFoodRawData2 or v13) and true or false;
            end;

            SubmitFoodProxPrompt.Enabled = v14;
        end;
    end;

    local function UpdateTimeDisplay() -- Line: 172
        -- upvalues: DataService (ref), NumberUtil (ref), TimeLabel (copy), TextColor3 (copy)
        local Data = DataService:GetData();
        local IsCooking = Data.CookingPot.IsCooking;

        if IsCooking then
            return;
        end;

        local CookTimeTotal = Data.CookingPot.CookTimeTotal;
        local v15 = workspace:GetAttribute("KitchenStormLevel") or 0;
        TimeLabel.Text = `⌛{NumberUtil.toMS(CookTimeTotal)}`;
        local v16;

        if v15 > 0 then
            v16 = Color3.fromRGB(0, 170, 0);
        else
            v16 = TextColor3;
        end;

        TimeLabel.TextColor3 = v16;

        if next(Data.CookingPot.SubmittedIngredients) == nil and not IsCooking then
            TimeLabel.Text = "⌛00:00";
            TimeLabel.TextColor3 = TextColor3;
        end;
    end;

    local NumberValue = Instance.new("NumberValue");
    u1:Add(NumberValue.Changed:Connect(function(p17) -- Line: 195
        -- upvalues: NeedleMotor (copy)
        local CFrame_fromOrientation = CFrame.fromOrientation;
        local math_lerp_ret = math.lerp(45, -225, p17);
        NeedleMotor.C0 = CFrame_fromOrientation(math.rad(math_lerp_ret), 0, 0);
    end));

    local function UpdateMutationDial() -- Line: 201
        -- upvalues: DataService (ref), Spr (ref), NumberValue (copy), ChanceText (copy)
        local Data = DataService:GetData();

        if not Data then
            warn("No playerData!");

            return;
        end;

        local v18 = Data.CookingPot.MutationChance or 0;
        Spr.stop(NumberValue, "Value");
        Spr.target(NumberValue, 0.4, 2, {
            Value = v18
        });
        ChanceText.Text = `{math.round(v18 * 100)}%`;
        ChanceText.TextColor3 = Color3.fromRGB(170, 0, 0):Lerp(Color3.fromRGB(0, 85, 0), v18);
    end;

    local function ClearIngredients() -- Line: 221
        -- upvalues: InsidePotFrame (copy)
        for _, child in InsidePotFrame:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;
    end;

    local function SetUpProxPrompts() -- Line: 239
        -- upvalues: u1 (ref), SubmitFoodProxPrompt (copy), CookingPotService_RE (ref), GetFoodProxPrompt (copy), AddItem (copy), SkipCookingProxPrompt (copy), SkipCooking (copy)
        u1:Add(SubmitFoodProxPrompt.Triggered:Connect(function(p19: userdata) -- Line: 240
            -- upvalues: CookingPotService_RE (ref)
            CookingPotService_RE:FireServer("SubmitHeldPlant");
        end));
        u1:Add(GetFoodProxPrompt.Triggered:Connect(function(p20: userdata) -- Line: 244
            -- upvalues: CookingPotService_RE (ref), AddItem (ref)
            CookingPotService_RE:FireServer("GetFoodFromPot");
            AddItem:Play();
        end));
        u1:Add(SkipCookingProxPrompt.Triggered:Connect(function(p21: userdata) -- Line: 249
            -- upvalues: CookingPotService_RE (ref), SkipCooking (ref)
            CookingPotService_RE:FireServer("TrySkipCooking");
            SkipCooking:Play();
        end));
    end;

    local function SetUpButtons() -- Line: 255
        -- upvalues: u1 (ref), EmptyButton (copy), CookingPotService_RE (ref), AddItem (copy), InsidePotFrame (copy), StartCookingFrame (copy), EmptyPotFrame (copy), CookButton (copy), DataService (ref), ClearIngredients (copy), Button (copy), ToggleButtonVisual (copy), Color3_fromRGB_ret2 (copy), TextLabel (copy)
        u1:Add(EmptyButton.Activated:Connect(function() -- Line: 256
            -- upvalues: CookingPotService_RE (ref), AddItem (ref), InsidePotFrame (ref), StartCookingFrame (ref)
            CookingPotService_RE:FireServer("EmptyPot");
            AddItem:Play();

            for _, child in InsidePotFrame:GetChildren() do
                if child:IsA("Frame") then
                    child:Destroy();
                end;
            end;

            StartCookingFrame.Visible = #InsidePotFrame:GetChildren() > 2;
        end));
        u1:Add(EmptyButton.MouseEnter:Connect(function() -- Line: 267
            -- upvalues: EmptyPotFrame (ref)
            EmptyPotFrame.BackgroundColor3 = Color3.fromRGB(254, 0, 0);
        end));
        u1:Add(EmptyButton.MouseLeave:Connect(function() -- Line: 270
            -- upvalues: EmptyPotFrame (ref)
            EmptyPotFrame.BackgroundColor3 = Color3.fromRGB(254, 138, 138);
        end));
        u1:Add(CookButton.Activated:Connect(function() -- Line: 274
            -- upvalues: DataService (ref), CookingPotService_RE (ref), ClearIngredients (ref), StartCookingFrame (ref), InsidePotFrame (ref), Button (ref), ToggleButtonVisual (ref)
            if DataService:GetData().CookingPot.IsCooking then
                return;
            end;

            CookingPotService_RE:FireServer("CookBest");
            ClearIngredients();
            StartCookingFrame.Visible = #InsidePotFrame:GetChildren() > 2;
            Button.Color = Color3.fromRGB(76, 127, 63);
            ToggleButtonVisual(true);
            task.delay(1, function() -- Line: 286
                -- upvalues: DataService (ref), ToggleButtonVisual (ref)
                if DataService:GetData().CookingPot.IsCooking == false then
                    ToggleButtonVisual(false);
                end;
            end);
        end));
        u1:Add(CookButton.MouseEnter:Connect(function() -- Line: 292
            -- upvalues: DataService (ref), Button (ref)
            if DataService:GetData().CookingPot.IsCooking then
                return;
            end;

            Button.Color = Color3.fromRGB(102, 172, 85);
        end));
        u1:Add(CookButton.MouseLeave:Connect(function() -- Line: 298
            -- upvalues: DataService (ref), Button (ref), Color3_fromRGB_ret2 (ref)
            if DataService:GetData().CookingPot.IsCooking then
                return;
            end;

            Button.Color = Color3_fromRGB_ret2;
        end));
        u1:Add(CookButton:GetPropertyChangedSignal("Interactable"):Connect(function() -- Line: 304
            -- upvalues: TextLabel (ref), CookButton (ref)
            TextLabel.Visible = CookButton.Interactable;
        end));
    end;

    local function PlantAdded(u22: string, p23: string?, p24: string) -- Line: 309
        -- upvalues: PotItemTemplate (copy), InsidePotFrame (copy), StartCookingFrame (copy), AddItem (copy), UpdateMutationDial (copy)
        if p24 ~= "OLD_KITCHEN_COOKING_EVENT" then
            return;
        end;

        local v25 = PotItemTemplate:Clone();
        v25.Name = u22;
        v25.Parent = InsidePotFrame;
        StartCookingFrame.Visible = #InsidePotFrame:GetChildren() > 2;
        local ItemNameLabel = v25:WaitForChild("ItemNameLabel");
        local string_rep_ret = string.rep(" ", #u22);
        ItemNameLabel.Text = string_rep_ret;
        task.spawn(function() -- Line: 324
            -- upvalues: u22 (copy), ItemNameLabel (copy), string_rep_ret (copy)
            for i = 1, #u22 do
                if not ItemNameLabel then
                    return;
                end;

                ItemNameLabel.Text = string.sub(u22, 1, i);
                local v26 = ItemNameLabel;
                v26.Text = v26.Text .. string.sub(string_rep_ret, i + 1);
                task.wait(0.07);
                local _ = i;
            end;
        end);
        AddItem:Play();
        UpdateMutationDial();
    end;

    local function UpdateGuiState() -- Line: 344
        -- upvalues: u6 (copy), CookingIngredientGui (copy), CookingButtonGui (copy)
        local v27 = u6:IsDescendantOf(workspace);
        CookingIngredientGui.Enabled = v27;
        CookingButtonGui.Enabled = v27;
    end;

    local u32 = {
        PlantAdded = PlantAdded,

        ToggleGetProxPrompt = function(p28: string?, p29: string) -- Line: 338, Name: ToggleGetProxPrompt
            -- upvalues: StartCookingFrame (copy), InsidePotFrame (copy), GetFoodProxPrompt (copy)
            if p29 ~= "OLD_KITCHEN_COOKING_EVENT" then
                return;
            end;

            StartCookingFrame.Visible = #InsidePotFrame:GetChildren() > 2;
            GetFoodProxPrompt.ActionText = p28 or "Get Cooked Food";
        end,

        CookingStarted = function(p30: string) -- Line: 350, Name: CookingStarted
            -- upvalues: StartCooking (copy), ClearIngredients (copy)
            if p30 ~= "OLD_KITCHEN_COOKING_EVENT" then
                return;
            end;

            StartCooking:Play();
            ClearIngredients();
        end,

        CookingFinished = function(p31: string) -- Line: 356, Name: CookingFinished
            -- upvalues: CookingDone (copy)
            if p31 ~= "OLD_KITCHEN_COOKING_EVENT" then
                return;
            end;

            CookingDone:Play();
        end
    };

    local function TrackToolChanges(p33: userdata) -- Line: 368
        -- upvalues: u1 (ref), SubmitFoodProxPrompt (copy), DataService (ref)
        u1:Add(p33.ChildAdded:Connect(function(p34) -- Line: 369
            -- upvalues: SubmitFoodProxPrompt (ref), DataService (ref)
            if p34:IsA("Tool") and p34:HasTag("FruitTool") then
                local IsCooking = DataService:GetData().CookingPot.IsCooking;
                local v35 = DataService:GetData().CookingPot.CookingEndTime or nil;
                local FinishedFoodRawData = DataService:GetData().CookingPot.FinishedFoodRawData;
                local v36;

                if IsCooking then
                    v36 = false;
                else
                    v36 = (not FinishedFoodRawData or v35) and true or false;
                end;

                SubmitFoodProxPrompt.Enabled = v36;
            end;
        end));
        u1:Add(p33.ChildRemoved:Connect(function(p37) -- Line: 375
            -- upvalues: SubmitFoodProxPrompt (ref)
            SubmitFoodProxPrompt.Enabled = false;
        end));
    end;

    local function InitialIngrBoard() -- Line: 380
        -- upvalues: DataService (ref), PlantAdded (copy)
        for i, v in DataService:GetData().CookingPot.SubmittedIngredients do
            PlantAdded(v.ItemData.ItemName, i, "OLD_KITCHEN_COOKING_EVENT");
        end;
    end;

    u1:Add(CookingPotService_RE.OnClientEvent:Connect(function(p38, ...) -- Line: 387
        -- upvalues: u32 (copy)
        if not u32[p38] then
            return;
        end;

        u32[p38](...);
    end));
    u1:Add(LocalPlayer.CharacterAdded:Connect(function(p39: userdata) -- Line: 392
        -- upvalues: TrackToolChanges (copy)
        TrackToolChanges(p39);
    end));
    u1:Add(u6.AncestryChanged:Connect(function() -- Line: 397
        -- upvalues: u6 (copy), CookingIngredientGui (copy), CookingButtonGui (copy)
        local v40 = u6:IsDescendantOf(workspace);
        CookingIngredientGui.Enabled = v40;
        CookingButtonGui.Enabled = v40;
    end));
    local v41 = u6:IsDescendantOf(workspace);
    CookingIngredientGui.Enabled = v41;
    CookingButtonGui.Enabled = v41;
    SetUpButtons();
    SetUpProxPrompts();
    UpdateProxPrompts();
    UpdateTimeDisplay();
    TrackToolChanges(u2);
    InitialIngrBoard();
    UpdateMutationDial();
    u1:Add(DataService:GetPathSignal("CookingPot/@"):Connect(function() -- Line: 411
        -- upvalues: UpdateProxPrompts (copy), UpdateTimeDisplay (copy), UpdateMutationDial (copy)
        UpdateProxPrompts();
        UpdateTimeDisplay();
        UpdateMutationDial();
    end));
    u1:Add(workspace:GetAttributeChangedSignal("KitchenStormLevel"):Connect(UpdateTimeDisplay));
    local v42 = CollectionService:GetTagged("CookingEventRecipeBook")[1];

    if v42 then
        u1:Add(v42:FindFirstChild("ProxPromptPart"):FindFirstChild("RecipeProxPrompt").Triggered:Connect(function() -- Line: 424
            -- upvalues: GardenGuideUIController (ref)
            GardenGuideUIController:OpenGGOnPage("Food");
        end));
    end;
end;

local u43 = false;
EventRotationController.EventUpdated:Connect(function(p44: string, p45: string) -- Line: 431, Name: OnEventUpdated
    -- upvalues: u1 (copy), u43 (ref), u3 (copy)
    if p45 ~= "CookingEvent" then
        u1:Clean();
        u43 = false;

        return;
    end;

    if u43 then
        return;
    end;

    u43 = true;
    u1:Clean();
    task.spawn(u3.Start, u3);
end);

return u3;