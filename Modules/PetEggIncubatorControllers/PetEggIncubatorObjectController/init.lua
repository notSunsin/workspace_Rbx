-- Decompiled with Potassium's decompiler.

local u1 = {};
game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PetEggIncubatorController = require(ReplicatedStorage.Modules.PetEggIncubatorControllers.PetEggIncubatorController);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local PetEggIncubationConfig = require(ReplicatedStorage.Data.PetRegistry.PetEggIncubationConfig);
require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local GetPlayerFromFarm = require(ReplicatedStorage.Modules.GetPlayerFromFarm);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
require(ReplicatedStorage.Modules.InventoryService);
require(ReplicatedStorage.Modules.Notification);
local DataService = require(ReplicatedStorage.Modules.DataService);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
require(ReplicatedStorage.Modules.Observers);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Signal = require(ReplicatedStorage.Modules.Signal);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EggModels = ReplicatedStorage.Assets.Models.EggModels;
local u2 = nil;
local u3 = Signal.new();
local u4 = nil;
local u5 = {};

function u1.UpdateRender(p6, u7) -- Line: 45
    -- upvalues: PetEggIncubatorController (copy), DataService (copy), GetPlayerFromFarm (copy), LocalPlayer (copy), u2 (ref), PetRegistry (copy), Spring (copy), TimeHelper (copy), PetEggIncubationConfig (copy), u5 (copy), u3 (copy)
    local MachineData = PetEggIncubatorController:GetMachineData(u7);

    if not MachineData then
        return;
    end;

    if not DataService:GetData() then
        return;
    end;

    local u8 = GetPlayerFromFarm((u7:FindFirstAncestor("Farm")));
    local billboard = u7.Model.OuterGlass.billboard;

    local function getProximityPromptActionText() -- Line: 57
        -- upvalues: u8 (copy), LocalPlayer (ref), u2 (ref), MachineData (copy)
        return u8 == LocalPlayer and (u2 and u2:HasTag("FruitTool") and "Submit Fuel" or (MachineData.IncubatedEgg == nil and "Submit Egg" or "Remove Egg")) or "Boost";
    end;

    local function updateProximityPromptLabel() -- Line: 73
        -- upvalues: u7 (copy), u8 (copy), LocalPlayer (ref), u2 (ref), MachineData (copy)
        u7.Model.InnerGlass.ProximityPrompt.ActionText = u8 == LocalPlayer and (u2 and u2:HasTag("FruitTool") and "Submit Fuel" or (MachineData.IncubatedEgg == nil and "Submit Egg" or "Remove Egg")) or "Boost";
    end;

    local function updateLabel() -- Line: 77
        -- upvalues: u7 (copy), MachineData (copy), PetRegistry (ref), Spring (ref), billboard (copy), TimeHelper (ref)
        u7.Parent:GetAttribute("IsDoubled");

        if MachineData.IncubatorEnergy > 0 then
            local _ = MachineData.IncubatedEgg == nil;
        end;

        local v9 = MachineData.HatchTime or 0;
        local v10;

        if MachineData.IncubatedEgg then
            local HatchTime = PetRegistry.PetEggs[MachineData.IncubatedEgg].HatchTime;
            v10 = (HatchTime - v9) / HatchTime;
        else
            v10 = 0;
        end;

        u7.Model.EggModelExtents.Extents:SetAttribute("HatchTime", v9);
        Spring.target(billboard.xp.bar.holder.content, 1, 5, {
            Size = UDim2.fromScale(v10, 1)
        });
        billboard.xp.bar.canvas.label.Text = v9 == 0 and "Ready" or TimeHelper:GenerateColonFormatFromTime(v9);
        billboard.xp.Visible = MachineData.IncubatedEgg ~= nil;

        if not billboard.xp.Visible then
            Spring.stop(billboard.xp.bar.holder.content);
            billboard.xp.bar.holder.content.Size = UDim2.fromScale(0, 1);
        end;
    end;

    local v11 = MachineData.IncubatorEnergy / PetEggIncubationConfig.MaxFuelCapacity;
    local v12 = math.round(v11 * 10000) / 100;
    billboard.fuel.bar.canvas.label.Text = `FUEL {v12}%`;
    Spring.target(billboard.fuel.bar.holder.content, 1, 5, {
        Size = UDim2.fromScale(v11, 1)
    });
    local IncubationTrove = u5[u7].IncubationTrove;
    IncubationTrove:Add(u7.Parent:GetAttributeChangedSignal("IsDoubled"):Connect(updateLabel));
    updateLabel();
    IncubationTrove:Add(u3:Connect(updateProximityPromptLabel));
    u7.Model.InnerGlass.ProximityPrompt.ActionText = u8 == LocalPlayer and (u2 and u2:HasTag("FruitTool") and "Submit Fuel" or (MachineData.IncubatedEgg == nil and "Submit Egg" or "Remove Egg")) or "Boost";
end;

function u1.UpdateAll(p13) -- Line: 113
    -- upvalues: u5 (copy), u1 (copy)
    for i in u5 do
        task.spawn(function() -- Line: 115
            -- upvalues: u1 (ref), i (copy)
            u1:UpdateRender(i);
        end);
    end;
end;

function u1.Start(p14) -- Line: 121
    -- upvalues: CreateTagHandler (copy), GetPlayerFromFarm (copy), Trove (copy), u5 (copy), Spring (copy), LocalPlayer (copy), u4 (ref), PetEggIncubatorController (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), EggModels (copy), PetRegistry (copy), DataService (copy), u1 (copy), u2 (ref), u3 (copy)
    CreateTagHandler({
        Tag = "PetEggIncubator",

        OnInstanceAdded = function(u15) -- Line: 124, Name: OnInstanceAdded
            -- upvalues: GetPlayerFromFarm (ref), Trove (ref), u5 (ref), Spring (ref), LocalPlayer (ref), u4 (ref), PetEggIncubatorController (ref), InventoryServiceEnums (ref), ItemTypeEnums (ref), EggModels (ref), PetRegistry (ref), DataService (ref), u1 (ref)
            local v16 = GetPlayerFromFarm((u15:FindFirstAncestor("Farm")));
            local v17 = Trove.new();
            local u18 = v17:Extend();
            u5[u15] = {
                Trove = v17,
                IncubationTrove = v17:Extend()
            };
            local ProximityPrompt = u15:WaitForChild("Model"):WaitForChild("InnerGlass"):WaitForChild("ProximityPrompt");

            for _, child in u15.Model.OuterGlass.billboard:GetChildren() do
                if child:IsA("Frame") then
                    child.bar.canvas.GroupTransparency = 1;
                end;
            end;

            ProximityPrompt.PromptShown:Connect(function() -- Line: 145
                -- upvalues: u15 (copy), Spring (ref)
                for _, child in u15.Model.OuterGlass.billboard:GetChildren() do
                    if child:IsA("Frame") then
                        Spring.target(child.bar.canvas, 1, 5, {
                            GroupTransparency = 0
                        });
                    end;
                end;
            end);
            ProximityPrompt.PromptHidden:Connect(function() -- Line: 152
                -- upvalues: u15 (copy), Spring (ref)
                if not u15.Parent then
                    return;
                end;

                for _, child in u15.Model.OuterGlass.billboard:GetChildren() do
                    if child:IsA("Frame") then
                        Spring.target(child.bar.canvas, 1, 5, {
                            GroupTransparency = 1
                        });
                    end;
                end;
            end);

            if LocalPlayer == v16 then
                v17:Add(ProximityPrompt.Triggered:Connect(function() -- Line: 161
                    -- upvalues: LocalPlayer (ref), u4 (ref), PetEggIncubatorController (ref), u15 (copy), InventoryServiceEnums (ref), ItemTypeEnums (ref)
                    local Character = LocalPlayer.Character;

                    if not Character then
                        return;
                    end;

                    if u4 then
                        return;
                    end;

                    u4 = true;
                    task.delay(0.5, function() -- Line: 170
                        -- upvalues: u4 (ref)
                        u4 = false;
                    end);
                    local MachineData = PetEggIncubatorController:GetMachineData(u15);

                    if not MachineData then
                        return;
                    end;

                    local Attribute = u15.Parent:GetAttribute("CosmeticUUID");

                    if not Attribute then
                        return;
                    end;

                    local v19 = Character:FindFirstChildWhichIsA("Tool");
                    local v20;

                    if v19 then
                        v20 = v19:GetAttribute(InventoryServiceEnums.ITEM_TYPE);

                        if v19:HasTag("FruitTool") then
                            PetEggIncubatorController:SubmitItem(Attribute);

                            return;
                        end;
                    else
                        v20 = nil;
                    end;

                    if MachineData.IncubatedEgg then
                        PetEggIncubatorController:RemoveEgg(Attribute, true);

                        return;
                    end;

                    if not v19 or v20 ~= ItemTypeEnums.PetEgg then
                        return;
                    end;

                    PetEggIncubatorController:InputEgg(Attribute);
                end));
            else
                v17:Add(ProximityPrompt.Triggered:Connect(function() -- Line: 197
                    -- upvalues: LocalPlayer (ref), u4 (ref), u15 (copy), PetEggIncubatorController (ref)
                    if not LocalPlayer.Character then
                        return;
                    end;

                    if u4 then
                        return;
                    end;

                    if not u15.Parent:GetAttribute("CosmeticUUID") then
                        return;
                    end;

                    u4 = true;
                    task.delay(0.5, function() -- Line: 209
                        -- upvalues: u4 (ref)
                        u4 = false;
                    end);
                    PetEggIncubatorController:Boost(u15);
                end));
            end;

            local function UpdateEggModel() -- Line: 217
                -- upvalues: u18 (copy), u15 (copy), EggModels (ref), PetRegistry (ref), PetEggIncubatorController (ref), DataService (ref)
                u18:Clean();
                local Attribute = u15.Parent:GetAttribute("EggName");

                if not Attribute then
                    return;
                end;

                local v21 = EggModels:FindFirstChild(Attribute);

                if not v21 then
                    return warn((`Could not find egg model associated with {Attribute}`));
                end;

                local u22 = u18:Clone(v21);
                u22.Name = "Egg";
                local Extents = u15.Model.EggModelExtents.Extents;
                local HatchTime = PetRegistry.PetEggs[Attribute].HatchTime;
                workspace.Terrain.EggParticle.WorldCFrame = Extents:GetPivot();

                for _, descendant in workspace.Terrain.EggParticle:GetDescendants() do
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;

                local function UpdateScale() -- Line: 238
                    -- upvalues: PetEggIncubatorController (ref), u15 (ref), HatchTime (copy), u22 (copy), Extents (copy)
                    local MachineData = PetEggIncubatorController:GetMachineData(u15);
                    u22:ScaleTo((math.clamp(1 - 0.5 * ((MachineData and MachineData.HatchTime or HatchTime) / HatchTime), 0.2, 1)));
                    u22:PivotTo(Extents:GetPivot());
                end;

                u18:Add(Extents:GetAttributeChangedSignal("TimeToHatch"):Connect(UpdateScale));
                u18:Add(DataService:GetPathSignal("PetsData/PetEggIncubatorData/@"):Connect(UpdateScale));
                local MachineData = PetEggIncubatorController:GetMachineData(u15);
                local v23;

                if MachineData then
                    v23 = MachineData.HatchTime or HatchTime;
                else
                    v23 = HatchTime;
                end;

                u22:ScaleTo((math.clamp(1 - 0.5 * (v23 / HatchTime), 0.2, 1)));
                u22:PivotTo(Extents:GetPivot());

                if u22.PrimaryPart then
                    u22.PrimaryPart.Anchored = false;
                    local v24 = u18:Add(Instance.new("WeldConstraint"));
                    v24.Part0 = u22.PrimaryPart;
                    v24.Part1 = Extents;
                    v24.Parent = u22.PrimaryPart;
                end;

                u22.Parent = Extents;
            end;

            u1:UpdateRender(u15);
            v17:Add(u15.Parent:GetAttributeChangedSignal("EggName"):Connect(UpdateEggModel));
            UpdateEggModel();
        end,

        OnInstanceRemoved = function(p25) -- Line: 266, Name: OnInstanceRemoved
            -- upvalues: u5 (ref)
            if u5[p25].Trove then
                u5[p25].Trove:Destroy();
            end;

            u5[p25] = nil;
        end
    });
    DataService:GetPathSignal("PetsData/PetEggIncubatorData/@"):Connect(function() -- Line: 273
        -- upvalues: u1 (ref)
        u1:UpdateAll();
    end);

    local function ChangeToolState(p26: userdata?) -- Line: 277
        -- upvalues: u2 (ref), u3 (ref)
        if u2 == p26 then
            return;
        end;

        u2 = p26;
        u3:Fire(p26);
    end;

    local function OnCharacterAdded(p27: userdata) -- Line: 286
        -- upvalues: u2 (ref), u3 (ref)
        local v28 = p27:FindFirstChildOfClass("Tool");

        if u2 ~= v28 then
            u2 = v28;
            u3:Fire(v28);
        end;

        p27.ChildAdded:Connect(function(p29: userdata) -- Line: 289
            -- upvalues: u2 (ref), u3 (ref)
            if p29:IsA("Tool") then
                if u2 == p29 then
                    return;
                end;

                u2 = p29;
                u3:Fire(p29);
            end;
        end);
        p27.ChildRemoved:Connect(function(p30: userdata) -- Line: 295
            -- upvalues: u2 (ref), u3 (ref)
            if p30:IsA("Tool") then
                if u2 == nil then
                    return;
                end;

                u2 = nil;
                u3:Fire(nil);
            end;
        end);
    end;

    LocalPlayer.CharacterAdded:Connect(OnCharacterAdded);

    if LocalPlayer.Character then
        task.spawn(OnCharacterAdded, LocalPlayer.Character);
    end;
end;

task.spawn(u1.Start, u1);

return u1;