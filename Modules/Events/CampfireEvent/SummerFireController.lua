-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("SummerFireConfig");
workspace:GetAttributeChangedSignal("SummerFireConfig"):Connect(function() -- Line: 10
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("SummerFireConfig");
end);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local Notification = require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.NPCDialogueController);
require(ReplicatedStorage.Modules.EventShopUIController);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
require(ReplicatedStorage.Top_Text);
require(ReplicatedStorage.Modules.TeamEventControllers.UserInterface.TeamEventQuestsUIController);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = Trove.new();
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local u2 = {};
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local Submit = ReplicatedStorage.GameEvents.SummerFire.Submit;
local u3 = false;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;

local function IsHoney(p8) -- Line: 53
    -- upvalues: PlantTraitsData (copy)
    return PlantTraitsData.Honey[p8] == true;
end;

local function GetCurrentToolValue(p9: boolean?) -- Line: 58
    -- upvalues: LocalPlayer (copy), InventoryServiceEnums (copy), Notification (copy), Config (ref), InventoryService (copy), PlantTraitsData (copy), SeedData (copy), MutationHandler (copy), Calculate_Weight (copy), CalculatePlantValue (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil, nil, nil;
    end;

    local v10 = nil;

    for _, child in Character:GetChildren() do
        if child:IsA("Tool") and (child:HasTag("FruitTool") and child:GetAttribute(InventoryServiceEnums.ITEM_UUID)) then
            v10 = child;
            break;
        end;
    end;

    if not v10 then
        if p9 then
            Notification:CreateNotification(Config.MESSAGE_ENUMS.NO_PLANT);
        end;

        return nil, nil, nil;
    end;

    local ToolData = InventoryService:GetToolData(v10);

    if not ToolData then
        if p9 then
            Notification:CreateNotification(Config.MESSAGE_ENUMS.ERROR);
        end;

        return nil, nil, nil;
    end;

    local ItemData = ToolData.ItemData;

    if not ItemData then
        if p9 then
            Notification:CreateNotification(Config.MESSAGE_ENUMS.ERROR);
        end;

        return nil, nil, nil;
    end;

    if PlantTraitsData.Honey[ItemData.ItemName] == true then
        Notification:CreateNotification(Config.MESSAGE_ENUMS.NO_HONEY);

        return nil, nil, nil;
    end;

    local v11 = SeedData[ItemData.ItemName];

    if not v11 then
        if p9 then
            Notification:CreateNotification(Config.MESSAGE_ENUMS.ERROR_NO_SEED);
        end;

        return nil, nil, nil;
    end;

    local v12 = MutationHandler:CalcValueMultiFromMuts(MutationHandler:ExtractMutationsFromString(ItemData.MutationString));
    local v13 = ItemData.WeightMultiplier or 1;
    local v14, _ = Calculate_Weight.Calculate_Weight(ItemData.Seed, ItemData.ItemName);
    local v15 = CalculatePlantValue({
        name = ItemData.ItemName,
        variant = ItemData.Variant,
        weight = v14 * v13,
        mutationMultiplier = math.log10(10 + v12),
        fruitVersion = ItemData.FruitVersion
    });
    local math_max_ret = math.max(v15 * (Config.PLANT_MULTIPLIERS_RARITY[v11.SeedRarity] or Config.PLANT_MULTIPLIERS_RARITY.FallBack), 0);
    local v16 = Config.MAX_EMBERS_PER_SUBMISSION[v11.SeedRarity] or Config.MAX_EMBERS_PER_SUBMISSION.FallBack;
    local v17 = math.log10(math_max_ret + 1) * Config.EMBER_LOG_SCALE;
    local math_ceil_ret = math.ceil(v17);

    return math.min(math_ceil_ret, v16), ItemData.ItemName, v10;
end;

local function DisconnectToolConnections() -- Line: 131
    -- upvalues: u4 (ref), u5 (ref)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    if u5 then
        u5:Disconnect();
        u5 = nil;
    end;
end;

function u2.Start(p18) -- Line: 144
    -- upvalues: CollectionService (copy), Config (ref), LocalPlayer (copy), InventoryServiceEnums (copy), InventoryService (copy), PlantTraitsData (copy), SeedData (copy), MutationHandler (copy), Calculate_Weight (copy), CalculatePlantValue (copy), u3 (ref), GetCurrentToolValue (copy), Comma_Module (copy), u4 (ref), u5 (ref), u1 (copy), u7 (ref), Submit (copy), Notification (copy), ConfirmationPromptController (copy), GuiController (copy), PlayerGui (copy), u6 (ref), TweenInfo_new_ret (copy), TweenService (copy)
    local u19 = CollectionService:GetTagged("SummerFireBillboard")[1];
    local u20 = CollectionService:GetTagged("SummerFireModel")[1];
    local u21 = workspace:GetAttribute(Config.WORKSPACE_EMBER_COUNT) or 0;
    local u22 = workspace:GetAttribute(Config.WORKSPACE_EMBER_COUNT_MAX) or 10;
    local u23 = workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE) or 0;

    local function GetAllPlantsValue() -- Line: 153
        -- upvalues: LocalPlayer (ref), InventoryServiceEnums (ref), InventoryService (ref), PlantTraitsData (ref), SeedData (ref), MutationHandler (ref), Calculate_Weight (ref), CalculatePlantValue (ref), Config (ref), u21 (ref), u23 (ref)
        local Character = LocalPlayer.Character;

        if not Character then
            warn("SummerFireController:SubmitAll | No Character!");

            return nil;
        end;

        local v24 = {};

        for _, child in Character:GetChildren() do
            if child:IsA("Tool") then
                table.insert(v24, child);
            end;
        end;

        local Backpack = LocalPlayer:FindFirstChild("Backpack");

        if Backpack then
            for _, child in Backpack:GetChildren() do
                if child:IsA("Tool") then
                    table.insert(v24, child);
                end;
            end;
        end;

        local v25 = 0;

        for _, v in v24 do
            if v:IsA("Tool") and (v:HasTag("FruitTool") and (v:GetAttribute(InventoryServiceEnums.ITEM_UUID) and not v:GetAttribute(InventoryServiceEnums.Favorite))) then
                local ToolData = InventoryService:GetToolData(v);

                if ToolData then
                    local ItemData = ToolData.ItemData;

                    if ItemData and PlantTraitsData.Honey[ItemData.ItemName] ~= true then
                        local v26 = SeedData[ItemData.ItemName];

                        if v26 then
                            local v27 = MutationHandler:CalcValueMultiFromMuts(MutationHandler:ExtractMutationsFromString(ItemData.MutationString));
                            local v28 = ItemData.WeightMultiplier or 1;
                            local v29, _ = Calculate_Weight.Calculate_Weight(ItemData.Seed, ItemData.ItemName);
                            local v30 = CalculatePlantValue({
                                name = ItemData.ItemName,
                                variant = ItemData.Variant,
                                weight = v29 * v28,
                                mutationMultiplier = math.log10(10 + v27),
                                fruitVersion = ItemData.FruitVersion
                            });
                            local math_max_ret = math.max(v30 * (Config.PLANT_MULTIPLIERS_RARITY[v26.SeedRarity] or Config.PLANT_MULTIPLIERS_RARITY.FallBack), 0);
                            local v31 = Config.MAX_EMBERS_PER_SUBMISSION[v26.SeedRarity] or Config.MAX_EMBERS_PER_SUBMISSION.FallBack;
                            local v32 = math.log10(math_max_ret + 1) * Config.EMBER_LOG_SCALE;
                            local math_ceil_ret = math.ceil(v32);
                            v25 = v25 + math.min(math_ceil_ret, v31);
                            local v33 = v25 + u21;
                            local v34 = Config.COSTS[u23 + 1];

                            if v34 and v34 <= v33 or Config.HARD_CAP <= v33 then
                                break;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return v25;
    end;

    local function CheckCurrentTool() -- Line: 225
        -- upvalues: u3 (ref), u19 (copy), GetCurrentToolValue (ref), Config (ref), u21 (ref), Comma_Module (ref)
        if u3 == false then
            u19.Enabled = false;

            return;
        end;

        local v35, v36 = GetCurrentToolValue();

        if not v35 then
            u19.Enabled = false;

            return;
        end;

        local v37 = workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE) or 0;
        local v38;

        if Config.MAX_TIERS <= v37 then
            local math_max_ret = math.max(Config.HARD_CAP - u21, 0);
            v38 = math.min(v35, math_max_ret);
        else
            local math_min_ret = math.min(v37 + 1, Config.MAX_TIERS);

            if Config.MAX_TIERS <= math_min_ret then
                local math_max_ret = math.max(Config.HARD_CAP - u21, 0);
                v38 = math.min(v35, math_max_ret);
            else
                local v39 = Config.COSTS[math_min_ret] or 0;
                local v40 = v39 + math.floor(((Config.COSTS[math_min_ret + 1] or v39) - v39) * Config.PASSED_TIER_PERCENT) - u21;
                local math_max_ret = math.max(v40, 0);
                v38 = math.min(v35, math_max_ret);
            end;
        end;

        local PlantName = u19:FindFirstChild("PlantName");

        if v36 and PlantName then
            PlantName.Text = v36;
        end;

        local v41 = Comma_Module.Comma((`{v38}`));
        local PlantValue = u19:FindFirstChild("PlantValue");

        if PlantValue then
            PlantValue.Text = Config.MESSAGE_ENUMS.CLIENT_SUBMIT_MESSAGE:gsub("SUBMIT_AMOUNT", (tostring(v41)));
        end;

        u19.Enabled = true;
    end;

    local function SetupCharacter(p42: userdata) -- Line: 279
        -- upvalues: u4 (ref), u5 (ref), CheckCurrentTool (copy), u1 (ref)
        if u4 then
            u4:Disconnect();
            u4 = nil;
        end;

        if u5 then
            u5:Disconnect();
            u5 = nil;
        end;

        CheckCurrentTool();
        u4 = p42.ChildAdded:Connect(function(p43) -- Line: 285
            -- upvalues: CheckCurrentTool (ref)
            if p43:IsA("Tool") then
                CheckCurrentTool();
            end;
        end);
        u1:Add(u4);
        u5 = p42.ChildRemoved:Connect(function(p44) -- Line: 292
            -- upvalues: CheckCurrentTool (ref)
            if p44:IsA("Tool") then
                CheckCurrentTool();
            end;
        end);
        u1:Add(u5);
    end;

    u1:Add((workspace:GetAttributeChangedSignal(Config.WORKSPACE_EMBER_COUNT):Connect(function() -- Line: 302
        -- upvalues: u21 (ref), Config (ref), CheckCurrentTool (copy)
        u21 = workspace:GetAttribute(Config.WORKSPACE_EMBER_COUNT);
        CheckCurrentTool();
    end)));
    u1:Add((workspace:GetAttributeChangedSignal(Config.WORKSPACE_EMBER_COUNT_MAX):Connect(function() -- Line: 310
        -- upvalues: u22 (ref), Config (ref), CheckCurrentTool (copy)
        u22 = workspace:GetAttribute(Config.WORKSPACE_EMBER_COUNT_MAX);
        CheckCurrentTool();
    end)));
    u1:Add((workspace:GetAttributeChangedSignal(Config.WORKSPACE_ATTRIBUTE):Connect(function() -- Line: 317
        -- upvalues: u23 (ref), Config (ref)
        u23 = workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE);
    end)));
    local v45 = {};

    for _, v in CollectionService:GetTagged("SummerFirePrompt") do
        local Attribute = v:GetAttribute("Type");

        if Attribute == "Submit" or Attribute == "SubmitAll" then
            local v53 = v.Triggered:Connect(function() -- Line: 329
                -- upvalues: u7 (ref), Attribute (copy), GetAllPlantsValue (copy), Config (ref), GetCurrentToolValue (ref), Submit (ref), LocalPlayer (ref), InventoryServiceEnums (ref), Notification (ref), ConfirmationPromptController (ref)
                u7 = nil;
                local v46;

                if Attribute == "SubmitAll" then
                    local v47 = GetAllPlantsValue();

                    if v47 == nil or v47 <= 0 then
                        return;
                    end;

                    v46 = {
                        Title = Config.MESSAGE_ENUMS.CONFIRM_PROMPT_TOP,
                        Header = Config.MESSAGE_ENUMS.CONFIRM_ALL,
                        Middle = `+{v47} Embers`
                    };
                else
                    local v48, v49, v50 = GetCurrentToolValue(true);

                    if not (v48 and (v49 and v50)) then
                        return;
                    end;

                    if v48 < Config.HARD_CAP then
                        Submit:FireServer(Attribute);

                        return;
                    end;

                    u7 = v50;
                    v46 = {
                        Title = Config.MESSAGE_ENUMS.CONFIRM_PROMPT_TOP,
                        Header = Config.MESSAGE_ENUMS.CONFIRM:gsub("PLANT_NAME", (tostring(v49))),
                        Middle = `{v49}`
                    };
                end;

                local function confirm(p51) -- Line: 363
                    -- upvalues: Submit (ref), LocalPlayer (ref), InventoryServiceEnums (ref), Notification (ref), Config (ref), u7 (ref)
                    if p51 == "SubmitAll" then
                        Submit:FireServer(p51);

                        return;
                    end;

                    local Character = LocalPlayer.Character;

                    if not Character then
                        return;
                    end;

                    local v52 = nil;

                    for _, child in Character:GetChildren() do
                        if child:IsA("Tool") and (child:HasTag("FruitTool") and child:GetAttribute(InventoryServiceEnums.ITEM_UUID)) then
                            v52 = child;
                            break;
                        end;
                    end;

                    if not v52 then
                        Notification:CreateNotification(Config.MESSAGE_ENUMS.NO_PLANT);

                        return;
                    end;

                    if v52 == u7 then
                        Submit:FireServer(p51);

                        return;
                    end;

                    Notification:CreateNotification(Config.MESSAGE_ENUMS.SWITCHED_CONFIRM);
                end;

                ConfirmationPromptController:Open(v46, {
                    ConfirmCallback = function() -- Line: 400, Name: ConfirmCallback
                        -- upvalues: confirm (copy), Attribute (ref)
                        confirm(Attribute);
                    end
                });
            end);
            table.insert(v45, v53);
            local v54 = v.PromptShown:Connect(function() -- Line: 407
                -- upvalues: u3 (ref), CheckCurrentTool (copy)
                u3 = true;
                CheckCurrentTool();
            end);
            table.insert(v45, v54);
            local v55 = v.PromptHidden:Connect(function() -- Line: 414
                -- upvalues: u3 (ref), CheckCurrentTool (copy)
                u3 = false;
                CheckCurrentTool();
            end);
            table.insert(v45, v55);
        elseif v:GetAttribute("Type") == "UI" then
            local u56 = v.Parent and v.Parent.Parent;
            local v57 = v.Triggered:Connect(function() -- Line: 426
                -- upvalues: GuiController (ref), PlayerGui (ref), u6 (ref), TweenInfo_new_ret (ref), TweenService (ref)
                GuiController:Open(PlayerGui:WaitForChild("SummerCrafting"));

                if u6 then
                    game.Debris:AddItem(u6, TweenInfo_new_ret.Time);
                    TweenService:Create(u6, TweenInfo_new_ret, {
                        OutlineTransparency = 1
                    }):Play();
                end;
            end);
            table.insert(v45, v57);
            local v58 = v.PromptShown:Connect(function() -- Line: 437
                -- upvalues: u6 (ref), u56 (copy), TweenService (ref), TweenInfo_new_ret (ref)
                u6 = Instance.new("Highlight");
                u6.DepthMode = Enum.HighlightDepthMode.Occluded;
                u6.FillTransparency = 1;
                u6.OutlineTransparency = 1;
                u6.Adornee = u56;
                u6.Parent = u56;
                TweenService:Create(u6, TweenInfo_new_ret, {
                    OutlineTransparency = 0
                }):Play();
            end);
            table.insert(v45, v58);
            local v59 = v.PromptHidden:Connect(function() -- Line: 450
                -- upvalues: u6 (ref), TweenInfo_new_ret (ref), TweenService (ref)
                if u6 then
                    game.Debris:AddItem(u6, TweenInfo_new_ret.Time);
                    TweenService:Create(u6, TweenInfo_new_ret, {
                        OutlineTransparency = 1
                    }):Play();
                end;
            end);
            table.insert(v45, v59);
        end;
    end;

    for _, v in v45 do
        u1:Add(v);
    end;

    u1:Add((LocalPlayer.CharacterAdded:Connect(SetupCharacter)));

    if LocalPlayer.Character then
        SetupCharacter(LocalPlayer.Character);
    end;

    local u60 = nil;
    u1:Add((task.spawn(function() -- Line: 478
        -- upvalues: u20 (copy), u60 (ref)
        while true do
            local v61 = not u20.Parent:IsA("Folder");

            if v61 ~= u60 then
                for _, descendant in u20:GetDescendants() do
                    if descendant:IsA("Sound") then
                        if descendant:GetAttribute("OGVolume") == nil then
                            descendant:SetAttribute("OGVolume", descendant.Volume);
                        end;

                        descendant.Volume = v61 and 0 or descendant:GetAttribute("OGVolume");
                    end;
                end;
            end;

            u60 = v61;
            task.wait(5);
        end;
    end)));
end;

local u62 = false;
EventRotationController.EventUpdated:Connect(function(p63: string, p64: string) -- Line: 501, Name: OnEventUpdated
    -- upvalues: u1 (copy), u62 (ref), u2 (copy)
    if p64 ~= "CampfireEvent" then
        u1:Clean();
        u62 = false;

        return;
    end;

    if u62 then
        return;
    end;

    u62 = true;
    u1:Clean();
    task.spawn(u2.Start, u2);
end);

return u2;