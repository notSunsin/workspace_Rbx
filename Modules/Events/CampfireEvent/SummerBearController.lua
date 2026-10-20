-- Decompiled with Potassium's decompiler.

local u1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
require(ReplicatedStorage.Modules.GuiController);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
require(ReplicatedStorage.Modules.CalculatePlantValue);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local Mutations = MutationHandler:GetMutations();
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("SummerBearConfig");
workspace:GetAttributeChangedSignal("SummerBearConfig"):Connect(function() -- Line: 24
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("SummerBearConfig");
end);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.ConfirmationPromptController);
require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.NPCDialogueController);
local Packs = require(ReplicatedStorage.Data.SeedPackData).Packs;
local SeedData = require(ReplicatedStorage.Data.SeedData);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local u2 = require(ReplicatedStorage.Modules.Trove).new();
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
local u3 = nil;
local u4 = nil;

local function IsRightTrait(p5, p6) -- Line: 49
    -- upvalues: PlantTraitsData (copy)
    return PlantTraitsData.HasTrait(p5, p6);
end;

local function GetMutationColor(p7) -- Line: 53
    -- upvalues: Mutations (copy)
    local v8 = Mutations[p7];

    if not v8 then
        return Color3.fromRGB(255, 255, 255);
    end;

    if v8.Color then
        return v8.Color;
    end;

    return Color3.fromRGB(255, 255, 255);
end;

local function DisconnectToolConnections() -- Line: 69
    -- upvalues: u3 (ref), u4 (ref)
    if u3 then
        u3:Disconnect();
        u3 = nil;
    end;

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;
end;

function u1.Start(p9) -- Line: 82
    -- upvalues: CollectionService (copy), DataService (copy), Config (ref), Packs (copy), Chalk (copy), GetMutationColor (copy), LocalPlayer (copy), InventoryServiceEnums (copy), InventoryService (copy), SeedData (copy), Calculate_Weight (copy), MutationHandler (copy), PlantTraitsData (copy), u2 (copy), u3 (ref), u4 (ref)
    local u10 = CollectionService:GetTagged("SummerBearBillboard")[1];
    local u11 = CollectionService:GetTagged("SummerBearModel")[1];
    local Target = u11:WaitForChild("Target");
    local TotalBillboard = u11:WaitForChild("TotalBillboard");
    local Data = DataService:GetData();

    local function AdjustRewards(p12: number) -- Line: 90
        -- upvalues: Config (ref), Packs (ref), u11 (copy), TotalBillboard (copy)
        local v13 = #Config.REWARDS;
        local math_clamp_ret = math.clamp(p12 + 1, 1, v13);
        local _ = Packs[Config.REWARDS[math_clamp_ret].Value];
        u11.BarSurface.BarBG.Fill.Size = UDim2.new(p12 / v13, 0, 1, 0);
        u11.BarSurface.BarBG.TextLabel.Text = tostring(p12) .. "/" .. tostring(v13);
        TotalBillboard.Frame.BestTemplate.Inner.RewardNameText.Text = tostring(p12) .. "/" .. tostring(v13);
    end;

    local function GetCurrentToolValue() -- Line: 101
        -- upvalues: Data (copy), Config (ref), Chalk (ref), GetMutationColor (ref), Target (copy), AdjustRewards (copy), LocalPlayer (ref), InventoryServiceEnums (ref), InventoryService (ref), SeedData (ref), Calculate_Weight (ref), MutationHandler (ref), PlantTraitsData (ref)
        local v14 = Data.SummerFireEventData.CurrentLevel or 0;
        local Attribute = workspace:GetAttribute(Config.WORKSPACE_TRAIT_NAME);
        local math_clamp_ret = math.clamp(v14 + 1, 1, #Config.WEIGHTS);
        local v15 = Config.WEIGHTS[math_clamp_ret];
        local v16 = Config.MUTATION_LIST[math_clamp_ret];
        local v17 = string.lower(v16) == "normal" and "" or `, {Chalk.color(GetMutationColor(v16))(v16)}`;
        Target.ImageLabel.Mutation.Text = `{tostring(v15)}kg+{v17}`;
        AdjustRewards(v14);
        local Character = LocalPlayer.Character;

        if not Character then
            return false, "Error loading your character!";
        end;

        local v18 = nil;

        for _, child in Character:GetChildren() do
            if child:IsA("Tool") and (child:HasTag("FruitTool") and child:GetAttribute(InventoryServiceEnums.ITEM_UUID)) then
                v18 = child;
                break;
            end;
        end;

        if not v18 then
            return false, Config.MESSAGE_ENUMS.NO_PLANT;
        end;

        local ToolData = InventoryService:GetToolData(v18);

        if not ToolData then
            return false, Config.MESSAGE_ENUMS.ERROR;
        end;

        local ItemData = ToolData.ItemData;

        if not ItemData then
            return false, Config.MESSAGE_ENUMS.ERROR;
        end;

        if not SeedData[ItemData.ItemName] then
            return false, Config.MESSAGE_ENUMS.ERROR_NO_SEED;
        end;

        local v19 = ItemData.WeightMultiplier or 1;
        local v20, _ = Calculate_Weight.Calculate_Weight(ItemData.Seed, ItemData.ItemName);
        local v21 = v20 * v19;
        local v22 = false;

        for _, v in MutationHandler:ExtractMutationsFromString(ItemData.MutationString) do
            if v.Name == v16 then
                v22 = true;
                break;
            end;
        end;

        if not PlantTraitsData.HasTrait(ItemData.ItemName, Attribute) then
            return false, Config.MESSAGE_ENUMS.WRONG_PLANT_ALL1:gsub("TRAIT_NAME", (tostring(Attribute))):gsub("MUTATION_NAME", (tostring(v16))):gsub("REQUIRED_KG", (tostring(v15))):gsub("MY_KG", (tostring(v21)));
        end;

        if not (v16 == "Normal" and true or v22) then
            return false, Config.MESSAGE_ENUMS.WRONG_PLANT_ALL2:gsub("TRAIT_NAME", (tostring(Attribute))):gsub("MUTATION_NAME", (tostring(v16))):gsub("REQUIRED_KG", (tostring(v15))):gsub("MY_KG", (tostring(v21)));
        end;

        if v21 < v15 then
            return false, Config.MESSAGE_ENUMS.WRONG_PLANT_ALL3:gsub("TRAIT_NAME", (tostring(Attribute))):gsub("MUTATION_NAME", (tostring(v16))):gsub("REQUIRED_KG", (tostring(v15))):gsub("MY_KG", (tostring(v21)));
        end;

        return true, "";
    end;

    local function CheckCurrentTool() -- Line: 180
        -- upvalues: GetCurrentToolValue (copy), u10 (copy), Config (ref)
        local v23, v24 = GetCurrentToolValue();

        if v23 == false then
            u10.Container.ClientText.Text = v24;

            return;
        end;

        u10.Container.ClientText.Text = Config.MESSAGE_ENUMS.BLANK_SUBMIT_CLIENT;
    end;

    local v25, v26 = GetCurrentToolValue();

    if v25 == false then
        u10.Container.ClientText.Text = v26;
    else
        u10.Container.ClientText.Text = Config.MESSAGE_ENUMS.BLANK_SUBMIT_CLIENT;
    end;

    u2:Add((DataService:GetPathSignal("SummerFireEventData/CurrentLevel"):Connect(function() -- Line: 191
        -- upvalues: GetCurrentToolValue (copy), u10 (copy), Config (ref)
        local v27, v28 = GetCurrentToolValue();

        if v27 == false then
            u10.Container.ClientText.Text = v28;

            return;
        end;

        u10.Container.ClientText.Text = Config.MESSAGE_ENUMS.BLANK_SUBMIT_CLIENT;
    end)));
    u2:Add((workspace:GetAttributeChangedSignal(Config.WORKSPACE_TRAIT_NAME):Connect(function() -- Line: 197
        -- upvalues: GetCurrentToolValue (copy), u10 (copy), Config (ref)
        local v29, v30 = GetCurrentToolValue();

        if v29 == false then
            u10.Container.ClientText.Text = v30;

            return;
        end;

        u10.Container.ClientText.Text = Config.MESSAGE_ENUMS.BLANK_SUBMIT_CLIENT;
    end)));

    local function SetupCharacter(p31: userdata) -- Line: 203
        -- upvalues: u3 (ref), u4 (ref), GetCurrentToolValue (copy), u10 (copy), Config (ref), u2 (ref)
        if u3 then
            u3:Disconnect();
            u3 = nil;
        end;

        if u4 then
            u4:Disconnect();
            u4 = nil;
        end;

        local v32, v33 = GetCurrentToolValue();

        if v32 == false then
            u10.Container.ClientText.Text = v33;
        else
            u10.Container.ClientText.Text = Config.MESSAGE_ENUMS.BLANK_SUBMIT_CLIENT;
        end;

        u3 = p31.ChildAdded:Connect(function(p34) -- Line: 209
            -- upvalues: GetCurrentToolValue (ref), u10 (ref), Config (ref)
            if p34:IsA("Tool") then
                local v35, v36 = GetCurrentToolValue();

                if v35 == false then
                    u10.Container.ClientText.Text = v36;

                    return;
                end;

                u10.Container.ClientText.Text = Config.MESSAGE_ENUMS.BLANK_SUBMIT_CLIENT;
            end;
        end);
        u2:Add(u3);
        u4 = p31.ChildRemoved:Connect(function(p37) -- Line: 216
            -- upvalues: GetCurrentToolValue (ref), u10 (ref), Config (ref)
            if p37:IsA("Tool") then
                local v38, v39 = GetCurrentToolValue();

                if v38 == false then
                    u10.Container.ClientText.Text = v39;

                    return;
                end;

                u10.Container.ClientText.Text = Config.MESSAGE_ENUMS.BLANK_SUBMIT_CLIENT;
            end;
        end);
        u2:Add(u4);
    end;

    u2:Add((LocalPlayer.CharacterAdded:Connect(SetupCharacter)));

    if LocalPlayer.Character then
        SetupCharacter(LocalPlayer.Character);
    end;
end;

local u40 = false;
EventRotationController.EventUpdated:Connect(function(p41: string, p42: string) -- Line: 249, Name: OnEventUpdated
    -- upvalues: u2 (copy), u40 (ref), EventRotationUtils (copy), u1 (copy)
    if p42 ~= "CampfireEvent" then
        u2:Clean();
        u40 = false;

        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p41, p42);

    if not EventInSetIndex then
        return;
    end;

    if EventInSetIndex < 2 then
        return;
    end;

    if u40 then
        return;
    end;

    u40 = true;
    u2:Clean();
    task.spawn(u1.Start, u1);
end);

return u1;