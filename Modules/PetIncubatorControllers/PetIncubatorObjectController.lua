-- Decompiled with Potassium's decompiler.

local u1 = {};
game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PetIncubatorController = require(ReplicatedStorage.Modules.PetIncubatorControllers.PetIncubatorController);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local PetIncubationConfig = require(ReplicatedStorage.Data.PetRegistry.PetIncubationConfig);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local GetPlayerFromFarm = require(ReplicatedStorage.Modules.GetPlayerFromFarm);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
require(ReplicatedStorage.Modules.InventoryService);
local PetConfig = require(ReplicatedStorage.Data.PetRegistry.PetConfig);
local DataService = require(ReplicatedStorage.Modules.DataService);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Trove = require(ReplicatedStorage.Modules.Trove);
local u2 = nil;
local MAX_LEVEL = PetConfig.XP_CONFIG.MAX_LEVEL;
local u3 = nil;
local u4 = {};

function u1.UpdateRender(p5: table, p6: userdata, p7: boolean?) -- Line: 38
    -- upvalues: u4 (copy), LocalPlayer (copy), TimeHelper (copy), PetIncubationConfig (copy), Spring (copy), PetIncubatorController (copy), u2 (ref), DataService (copy), PetUtilities (copy), MAX_LEVEL (copy)
    if (u4[p6] or {}).Owner ~= LocalPlayer then
        return;
    end;

    local billboard = p6.Model.OuterGlass.billboard;
    local v8 = p6:GetAttribute("BoostTime") or 0;
    local v9 = tonumber(v8);

    if v9 then
        billboard.boost.Visible = v9 ~= 0;
        billboard.boost.bar.canvas.label.Text = `[2x EXP] {TimeHelper:GenerateColonFormatFromTime(v9)}`;
        Spring.target(billboard.boost.bar.holder.content, 1, 5, {
            Size = UDim2.fromScale(v9 / PetIncubationConfig.BoostAmountPerPlayer, 1)
        });

        if p7 then
            return;
        end;
    end;

    local u10 = PetIncubatorController:GetMachineData(p6) or {
        IncubatorEnergy = PetIncubationConfig.DefaultFuel
    };

    local function getProximityPromptActionText() -- Line: 54
        -- upvalues: u2 (ref), u10 (copy)
        return u2 and u2:HasTag("FruitTool") and "Submit Fuel" or (u10.IncubatedPetUUID == nil and "Insert Pet" or "Remove Pet");
    end;

    p6.Model.InnerGlass.ProximityPrompt.ActionText = u2 and u2:HasTag("FruitTool") and "Submit Fuel" or (u10.IncubatedPetUUID == nil and "Insert Pet" or "Remove Pet");
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local Data2 = Data.PetsData.PetInventory.Data;

    if not Data2 then
        return;
    end;

    local v11 = Data2[u10.IncubatedPetUUID];

    if v11 then
        local Level = v11.PetData.Level;
        local v12 = v11.PetData.LevelProgress / PetUtilities:GetCurrentLevelXPCost(Level);
        Spring.target(billboard.xp.bar.holder.content, 1, 5, {
            Size = UDim2.fromScale(v12, 1)
        });
        billboard.xp.bar.canvas.label.Text = Level < MAX_LEVEL and `[LVL {Level}] {math.round(v12 * 10000) / 100}%` or "[MAX LVL]";
    end;

    billboard.xp.Visible = v11 ~= nil;

    if not billboard.xp.Visible then
        Spring.stop(billboard.xp.bar.holder.content);
        billboard.xp.bar.holder.content.Size = UDim2.fromScale(0, 1);
    end;

    local v13 = u10.IncubatorEnergy / PetIncubationConfig.MaxFuelCapacity;
    local v14 = math.ceil(v13 * 10000) / 100;
    billboard.fuel.bar.canvas.label.Text = `FUEL {v14}%`;
    Spring.target(billboard.fuel.bar.holder.content, 1, 5, {
        Size = UDim2.fromScale(v13, 1)
    });
end;

function u1.UpdateAll(p15) -- Line: 101
    -- upvalues: u4 (copy), u1 (copy)
    for i in u4 do
        task.spawn(function() -- Line: 103
            -- upvalues: u1 (ref), i (copy)
            u1:UpdateRender(i);
        end);
    end;
end;

function u1.Start(p16) -- Line: 109
    -- upvalues: CreateTagHandler (copy), GetPlayerFromFarm (copy), Trove (copy), u4 (copy), Spring (copy), LocalPlayer (copy), u3 (ref), PetIncubatorController (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), u2 (ref), u1 (copy), SelectiveAssetReplication (copy), RunService (copy), DataService (copy)
    CreateTagHandler({
        Tag = "PetIncubator",

        OnInstanceAdded = function(u17: userdata) -- Line: 112, Name: OnInstanceAdded
            -- upvalues: GetPlayerFromFarm (ref), Trove (ref), u4 (ref), Spring (ref), LocalPlayer (ref), u3 (ref), PetIncubatorController (ref), InventoryServiceEnums (ref), ItemTypeEnums (ref), u2 (ref), u1 (ref), SelectiveAssetReplication (ref), RunService (ref)
            local v18 = GetPlayerFromFarm((u17:FindFirstAncestor("Farm")));
            local v19 = Trove.new();
            local u20 = v19:Extend();
            u4[u17] = {
                Trove = v19,
                Owner = v18,
                IncubationTrove = u20
            };
            local ProximityPrompt = u17:WaitForChild("Model"):WaitForChild("InnerGlass"):WaitForChild("ProximityPrompt");

            for _, child in u17.Model.OuterGlass.billboard:GetChildren() do
                if child:IsA("Frame") then
                    child.bar.canvas.GroupTransparency = 1;
                end;
            end;

            ProximityPrompt.PromptShown:Connect(function() -- Line: 134
                -- upvalues: u17 (copy), Spring (ref)
                for _, child in u17.Model.OuterGlass.billboard:GetChildren() do
                    if child:IsA("Frame") then
                        Spring.target(child.bar.canvas, 1, 5, {
                            GroupTransparency = 0
                        });
                    end;
                end;
            end);
            ProximityPrompt.PromptHidden:Connect(function() -- Line: 141
                -- upvalues: u17 (copy), Spring (ref)
                if not u17.Parent then
                    return;
                end;

                for _, child in u17.Model.OuterGlass.billboard:GetChildren() do
                    if child:IsA("Frame") then
                        Spring.target(child.bar.canvas, 1, 5, {
                            GroupTransparency = 1
                        });
                    end;
                end;
            end);

            if LocalPlayer == v18 then
                ProximityPrompt.Triggered:Connect(function() -- Line: 150
                    -- upvalues: LocalPlayer (ref), u3 (ref), PetIncubatorController (ref), u17 (copy), InventoryServiceEnums (ref), ItemTypeEnums (ref)
                    local Character = LocalPlayer.Character;

                    if not Character then
                        return;
                    end;

                    if u3 then
                        return;
                    end;

                    u3 = true;
                    task.delay(0.5, function() -- Line: 159
                        -- upvalues: u3 (ref)
                        u3 = false;
                    end);
                    local v21 = PetIncubatorController:GetMachineData(u17) or {};
                    local v22 = Character:FindFirstChildWhichIsA("Tool");
                    local v23;

                    if v22 then
                        v23 = v22:GetAttribute(InventoryServiceEnums.ITEM_TYPE);

                        if v22:HasTag("FruitTool") then
                            PetIncubatorController:SubmitItem(u17.Parent);

                            return;
                        end;
                    else
                        v23 = nil;
                    end;

                    if v21.IncubatedPetUUID then
                        PetIncubatorController:RemovePet(u17.Parent);

                        return;
                    end;

                    if not v22 or v23 ~= ItemTypeEnums.Pet then
                        return;
                    end;

                    PetIncubatorController:InputPet(u17.Parent);
                end);

                local function onCharacterAdded(p24: userdata) -- Line: 183
                    -- upvalues: u2 (ref), u1 (ref), u17 (copy)
                    u2 = p24:FindFirstChildOfClass("Tool");
                    u1:UpdateRender(u17);
                    p24.ChildAdded:Connect(function(p25: userdata) -- Line: 187
                        -- upvalues: u2 (ref), u1 (ref), u17 (ref)
                        if p25:IsA("Tool") then
                            u2 = p25;
                            u1:UpdateRender(u17);
                        end;
                    end);
                    p24.ChildRemoved:Connect(function(p26: userdata) -- Line: 194
                        -- upvalues: u2 (ref), u1 (ref), u17 (ref)
                        if p26:IsA("Tool") then
                            u2 = nil;
                            u1:UpdateRender(u17);
                        end;
                    end);
                end;

                v19:Add(LocalPlayer.CharacterAdded:Connect(onCharacterAdded));

                if LocalPlayer.Character then
                    task.spawn(onCharacterAdded, LocalPlayer.Character);
                end;
            else
                u17.Model.InnerGlass.ProximityPrompt.ActionText = "Boost";
                u17.Model.OuterGlass.billboard.Enabled = false;
                ProximityPrompt.Triggered:Connect(function() -- Line: 207
                    -- upvalues: LocalPlayer (ref), u3 (ref), u17 (copy), PetIncubatorController (ref)
                    if not LocalPlayer.Character then
                        return;
                    end;

                    if u3 then
                        return;
                    end;

                    if not u17:GetAttribute("PetType") then
                        return;
                    end;

                    u3 = true;
                    task.delay(0.5, function() -- Line: 219
                        -- upvalues: u3 (ref)
                        u3 = false;
                    end);
                    PetIncubatorController:Boost(u17.Parent);
                end);
            end;

            local function UpdatePetModel() -- Line: 227
                -- upvalues: u17 (copy), u20 (copy), SelectiveAssetReplication (ref), RunService (ref)
                local Attribute = u17:GetAttribute("PetType");
                u20:Clean();

                if not Attribute then
                    return;
                end;

                local PetModelExtents = u17.Model.PetModelExtents;
                local u27 = u20:Add(SelectiveAssetReplication:GetAssetAsync("PetAssets", Attribute):Clone());
                local PrimaryPart = u27.PrimaryPart;
                u27.Name = "PetModel";

                if PrimaryPart then
                    PrimaryPart.Anchored = true;
                else
                    for _, child in u27:GetChildren() do
                        if child:IsA("BasePart") then
                            child.Anchored = true;
                        end;
                    end;
                end;

                u27:PivotTo(CFrame.new(PetModelExtents:GetPivot().Position) * CFrame.Angles(math.random(360), math.random(360), math.random(360)));
                local ExtentsSize = u27:GetExtentsSize();
                local ExtentsSize2 = PetModelExtents:GetExtentsSize();
                u27:ScaleTo((math.min(ExtentsSize2.X / ExtentsSize.X, ExtentsSize2.Y / ExtentsSize.Y, ExtentsSize2.Z / ExtentsSize.Z)));
                u27.Parent = u17;
                u20:Add(RunService.RenderStepped:Connect(function(p28: number) -- Line: 261
                    -- upvalues: u17 (ref), u27 (copy), PetModelExtents (copy)
                    local Attribute2 = u17:GetAttribute("BoostTime");

                    if Attribute2 then
                        Attribute2 = Attribute2 > 0;
                    end;

                    local CFrame_Angles_ret = CFrame.Angles(math.random() * p28, math.random() * p28 * (Attribute2 and 10 or 1), 0);
                    u27:PivotTo(CFrame.new(PetModelExtents:GetPivot().Position) * u27:GetPivot().Rotation * CFrame_Angles_ret);
                end));
            end;

            v19:Add(u17:GetAttributeChangedSignal("PetType"):Connect(UpdatePetModel));
            v19:Add(u17:GetAttributeChangedSignal("BoostTime"):Connect(function() -- Line: 270
                -- upvalues: u1 (ref), u17 (copy)
                u1:UpdateRender(u17, true);
            end));
            u1:UpdateRender(u17);
            UpdatePetModel();
        end,

        OnInstanceRemoved = function(p29) -- Line: 276, Name: OnInstanceRemoved
            -- upvalues: u4 (ref)
            if u4[p29].Trove then
                u4[p29].Trove:Destroy();
            end;

            u4[p29] = nil;
        end
    });
    DataService:GetPathSignal("PetsData/PetIncubatorData/@"):Connect(function() -- Line: 283
        -- upvalues: u1 (ref)
        u1:UpdateAll();
    end);
end;

task.spawn(u1.Start);

return u1;