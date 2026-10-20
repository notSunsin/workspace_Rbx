-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local RebirthShared = require(ReplicatedStorage.Modules.RebirthShared);
local DataService = require(ReplicatedStorage.Modules.DataService);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local CalculateRebirthReward = require(ReplicatedStorage.Modules.CalculateRebirthReward);
require(ReplicatedStorage:WaitForChild("Comma_Module"));
local Spring = require(ReplicatedStorage.Modules.Spring);
local RebirthConfigData = require(ReplicatedStorage.Data.RebirthConfigData);
local BuyRebirth = ReplicatedStorage:WaitForChild("GameEvents").BuyRebirth;
local LocalPlayer = Players.LocalPlayer;
local RebirthConfirmation = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RebirthConfirmation");
local ProgressBar = RebirthConfirmation:WaitForChild("Frame"):WaitForChild("ProgressBar");
local ShecklesProgressBar = ProgressBar:WaitForChild("ShecklesProgressBar");
local ShecklesAmount = ProgressBar:WaitForChild("ShecklesAmount");
local RequiredItemTemplate = RebirthConfirmation:FindFirstChild("RequiredItemTemplate", true);
local RebirthDetails = RebirthConfirmation:FindFirstChild("RebirthDetails", true);
local AscensionTimer = RebirthConfirmation:FindFirstChild("AscensionTimer", true);
local ReceiveText = RebirthConfirmation:FindFirstChild("ReceiveText", true);
local Mutations = MutationHandler:GetMutations();
local u1 = true;
local u2 = false;
local v3 = {};

local function GetResetTime() -- Line: 45
    -- upvalues: DataService (copy), RebirthConfigData (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();

    return DataService:GetData().RebirthData.LastRebirthTime + RebirthConfigData.RESET_TIME - math.floor(ServerTimeNow);
end;

local function IsConfirmEnabled() -- Line: 54
    -- upvalues: DataService (copy), RebirthShared (copy), LocalPlayer (copy)
    local Data = DataService:GetData();

    if not Data then
        return false;
    end;

    local v4 = RebirthShared:CalculatePrice(Data.RebirthData.TotalRebirths, LocalPlayer);
    local v5 = RebirthShared:IsRebirthAvailable(LocalPlayer) and v4 <= Data.Sheckles;

    return v5;
end;

local function SetupTimer() -- Line: 64
    -- upvalues: DataService (copy), RebirthConfigData (copy), AscensionTimer (copy), NumberUtil (copy)
    while true do
        local ServerTimeNow = workspace:GetServerTimeNow();
        local v6 = DataService:GetData().RebirthData.LastRebirthTime + RebirthConfigData.RESET_TIME - math.floor(ServerTimeNow);

        if v6 <= 0 then
            AscensionTimer.Visible = false;
        else
            AscensionTimer.Visible = true;
            AscensionTimer.Text = "Next Ascension " .. NumberUtil.compactFormat(v6);
        end;

        task.wait(1);
    end;
end;

local function UpdateProgressBar() -- Line: 79
    -- upvalues: DataService (copy), RebirthShared (copy), LocalPlayer (copy), ShecklesProgressBar (copy), ShecklesAmount (copy), NumberUtil (copy), RebirthConfirmation (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local v7 = RebirthShared:CalculatePrice(Data.RebirthData.TotalRebirths, LocalPlayer);
    local math_min_ret = math.min(Data.Sheckles / v7, 1);
    ShecklesProgressBar.Size = UDim2.fromScale(math_min_ret, 1);
    ShecklesAmount.Text = NumberUtil.DisplaySheckles((math.round(Data.Sheckles))) .. " / " .. NumberUtil.DisplaySheckles(v7);
    local Data2 = DataService:GetData();
    local v8;

    if Data2 then
        local v9 = RebirthShared:CalculatePrice(Data2.RebirthData.TotalRebirths, LocalPlayer);
        v8 = RebirthShared:IsRebirthAvailable(LocalPlayer) and v9 <= Data2.Sheckles;
    else
        v8 = false;
    end;

    RebirthConfirmation.Frame.ItemFrame.Frame.Confirm.HoverImage = v8 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
    RebirthConfirmation.Frame.ItemFrame.Frame.Confirm.Image = v8 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
end;

local function UpdateRebirthReward() -- Line: 96
    -- upvalues: DataService (copy), RebirthShared (copy), LocalPlayer (copy), NumberUtil (copy), ReceiveText (copy), CalculateRebirthReward (copy), u2 (ref)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local v10 = RebirthShared:CalculatePrice(Data.RebirthData.TotalRebirths, LocalPlayer);
    local v11 = NumberUtil.FormatCompactPrice(v10);
    ReceiveText.Text = `You will get <font color="#5dd937">{CalculateRebirthReward(Data.Sheckles)} Garden Coins</font> but lose <font color="#FF0000">{v11}</font> sheckles!`;

    if u2 then
        ReceiveText.Text = `You will get <font color="#5dd937">{CalculateRebirthReward(Data.Sheckles)} Garden Coins</font> but lose <font color="#FF0000">ALL</font> your sheckles!`;
    end;
end;

local function UpdateRequiredFruits() -- Line: 110
    -- upvalues: u1 (ref), RebirthConfirmation (copy), DataService (copy), RebirthDetails (copy), RequiredItemTemplate (copy), ItemImageFinder (copy), Mutations (copy)
    if not u1 then
        RebirthConfirmation.Frame.Display.Visible = false;

        return;
    end;

    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local RebirthData = Data.RebirthData;

    if not RebirthData then
        return;
    end;

    local RequiredPlants = RebirthData.RequiredPlants;

    for _, child in RebirthDetails:GetChildren() do
        if child:IsA("Frame") and not child:IsA("UIGridLayout") then
            child:Destroy();
        end;
    end;

    for _, v in RequiredPlants do
        local v12 = RequiredItemTemplate:Clone();
        v12.Parent = RebirthDetails;
        v12.Visible = true;
        local v13 = ItemImageFinder(v.FruitName, "Holdable");

        if v13 then
            v12.Detail.ItemImageLabel.Image = v13;
        end;

        v12.Detail.ItemImageLabel.Visible = true;
        local v14 = v;
        local v15 = "";

        for i, v2 in v.Mutations do
            local v16 = Mutations[v2];
            local v17 = `<font color="#{v16.Color:ToHex()}">{v2}</font>`;

            if v16.StrokeColor then
                v17 = `<stroke color="#{v16.StrokeColor:ToHex()}">{v17}</stroke>`;
            end;

            v15 = v15 .. `{v17}{i == #v14.Mutations and "" or "<br/>"}`;
        end;

        v12.ItemName.Text = v14.FruitName;
        v12.ItemMutations.Text = v15;
        v12.ItemAmount.Visible = false;
    end;
end;

local function SetupConfirmationUI() -- Line: 163
    -- upvalues: RebirthConfirmation (copy), GuiController (copy), RebirthShared (copy), LocalPlayer (copy), Spring (copy), AscensionTimer (copy), DataService (copy), BuyRebirth (copy), UpdateProgressBar (copy), UpdateRequiredFruits (copy), UpdateRebirthReward (copy)
    RebirthConfirmation.Frame.Frame.ExitButton.MouseButton1Click:Connect(function() -- Line: 164
        -- upvalues: GuiController (ref), RebirthConfirmation (ref)
        GuiController:Close(RebirthConfirmation);
    end);
    RebirthConfirmation.Frame.ItemFrame.Frame.Cancel.MouseButton1Click:Connect(function() -- Line: 168
        -- upvalues: GuiController (ref), RebirthConfirmation (ref)
        GuiController:Close(RebirthConfirmation);
    end);
    RebirthConfirmation.Frame.ItemFrame.Frame.Confirm.MouseButton1Click:Connect(function() -- Line: 172
        -- upvalues: RebirthShared (ref), LocalPlayer (ref), Spring (ref), AscensionTimer (ref), DataService (ref), GuiController (ref), RebirthConfirmation (ref), BuyRebirth (ref)
        if not RebirthShared:IsRebirthAvailable(LocalPlayer) then
            Spring.stop(AscensionTimer);
            Spring.stop(AscensionTimer.UIStroke);
            AscensionTimer.UIStroke.Color = Color3.fromRGB(100, 25, 25);
            AscensionTimer.TextColor3 = Color3.fromRGB(255, 75, 75);
            Spring.target(AscensionTimer, 1, 1, {
                TextColor3 = Color3.fromRGB(255, 255, 255)
            });
            Spring.target(AscensionTimer.UIStroke, 1, 1, {
                Color = Color3.fromRGB(0, 63, 0)
            });
        end;

        local Data = DataService:GetData();
        local v18;

        if Data then
            local v19 = RebirthShared:CalculatePrice(Data.RebirthData.TotalRebirths, LocalPlayer);
            v18 = RebirthShared:IsRebirthAvailable(LocalPlayer) and v19 <= Data.Sheckles;
        else
            v18 = false;
        end;

        if not v18 then
            return;
        end;

        GuiController:Close(RebirthConfirmation);
        BuyRebirth:FireServer();
    end);
    UpdateProgressBar();
    UpdateRequiredFruits();
    UpdateRebirthReward();
end;

function v3.Start(p20) -- Line: 194
    -- upvalues: GuiController (copy), RebirthConfirmation (copy), SetupConfirmationUI (copy), DataService (copy), UpdateProgressBar (copy), UpdateRebirthReward (copy), UpdateRequiredFruits (copy), SetupTimer (copy)
    GuiController:UsePopupAnims(RebirthConfirmation);
    SetupConfirmationUI();
    DataService:GetPathSignal("Sheckles"):Connect(function() -- Line: 198
        -- upvalues: UpdateProgressBar (ref), UpdateRebirthReward (ref)
        UpdateProgressBar();
        UpdateRebirthReward();
    end);
    DataService:GetPathSignal("RebirthData"):Connect(function() -- Line: 203
        -- upvalues: UpdateProgressBar (ref), UpdateRequiredFruits (ref)
        UpdateProgressBar();
        UpdateRequiredFruits();
    end);
    DataService:GetPathSignal("RebirthData/@"):Connect(function() -- Line: 208
        -- upvalues: UpdateProgressBar (ref), UpdateRequiredFruits (ref)
        UpdateProgressBar();
        UpdateRequiredFruits();
    end);
    task.spawn(SetupTimer);
end;

local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);

if ClientABTests.GetAssignmentsAsync(LocalPlayer, true) then
    local Attributes = ClientABTests.GetAttributes(LocalPlayer);
    local v21 = Attributes and Attributes.AB_AscensionVariant;

    if v21 then
        u2 = v21 == "AllShecklesNoPlant" and true or v21 == "AllShecklesNeedPlant";
        u1 = v21 ~= "RequiredShecklesNoPlant" and v21 ~= "AllShecklesNoPlant";
    end;
end;

task.spawn(v3.Start, v3);

return v3;