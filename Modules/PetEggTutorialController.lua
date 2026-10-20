-- Decompiled with Potassium's decompiler.

game:GetService("ServerScriptService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local TutorialUtils = require(ReplicatedStorage.Modules.TutorialController.TutorialUtils);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local PetCardUserInterfaceService = require(ReplicatedStorage.Modules.PetServices.PetCardUserInterfaceService);
local PetActionUserInterfaceService = require(ReplicatedStorage.Modules.PetServices.PetActionUserInterfaceService);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
require(ReplicatedStorage.Modules.ActivePetsUIController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local Arrow_Module = require(ReplicatedStorage.Arrow_Module);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetEggData = require(ReplicatedStorage.Data.PetEggData);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u61 = {
    Run = function(p1) -- Line: 40, Name: Run
        -- upvalues: LocalPlayer (copy), GetFarmAsync (copy), DataService (copy), RunService (copy), Arrow_Module (copy), CollectionService (copy), InventoryService (copy), PetRegistry (copy), PetEggData (copy), RebirthUnlocksSharedService (copy), Notification (copy), TutorialUtils (copy), ReplicatedStorage (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), ActivePetsService (copy), PlayerGui (copy), FastTween (copy), workspace_CurrentCamera (copy), PetActionUserInterfaceService (copy), PetCardUserInterfaceService (copy), SoundService (copy)
        if not LocalPlayer.Character then
            LocalPlayer.CharacterAdded:Wait();
        end;

        local u2 = GetFarmAsync(LocalPlayer);

        if not u2 then
            warn("PetEggTutorialController:Run || Failed to execute tutorial because player has no farm");

            return;
        end;

        local Data = DataService:GetData();

        if not Data then
            warn("PetEggTutorialController:Run || Failed to execute tutorial because player data is missing");

            return;
        end;

        if not workspace.NPCS:WaitForChild("Pet Stand", 10) then
            warn("PetEggTutorialController:Run || Failed to execute tutorial because Pet Stand is missing");

            return;
        end;

        if not RunService:IsStudio() then
            return;
        end;

        local function createArrow(p3) -- Line: 68
            -- upvalues: Arrow_Module (ref), LocalPlayer (ref)
            local u4 = Arrow_Module.GenerateArrow(LocalPlayer, p3, math.random(1, 1000000));

            return function() -- Line: 70
                -- upvalues: Arrow_Module (ref), u4 (copy)
                Arrow_Module.Remove_Arrow(u4);
            end;
        end;

        local function getRandomClickPosition() -- Line: 75
            -- upvalues: u2 (copy), CollectionService (ref)
            local v5 = nil;

            for _, child in u2.Important.Plant_Locations:GetChildren() do
                if child:IsA("BasePart") then
                    local Random_new_ret = Random.new();
                    local v6 = child;
                    local v7 = 15;
                    local v8;

                    while true do
                        if v7 <= 0 then
                            v8 = v5;
                            break;
                        end;

                        v8 = v6.Position + Random_new_ret:NextUnitVector() * Vector3.new(v6.Size.X, 0, v6.Size.Z) * 0.5 * 0.7;
                        local OverlapParams_new_ret = OverlapParams.new();
                        OverlapParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged("Harvestable");
                        OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
                        OverlapParams_new_ret.MaxParts = 1;

                        if #workspace:GetPartBoundsInRadius(v8, 10, OverlapParams_new_ret) == 0 then
                            break;
                        end;

                        v7 = v7 - 1;
                    end;

                    if v8 then
                        break;
                    end;

                    v5 = v8;
                end;
            end;
        end;

        local function hasEggInInventory() -- Line: 108
            -- upvalues: InventoryService (ref)
            local v10 = InventoryService:Find("PetEgg", function(p9: table) -- Line: 109
                return p9.EggName == "Common Egg";
            end);

            if type(v10) == "table" then
                return next(v10) ~= nil;
            end;

            return false;
        end;

        local function hasPlacedEgg() -- Line: 120
            -- upvalues: Data (copy)
            for _, v in Data.SavedObjects do
                if type(v) == "table" and (v.ObjectType == "PetEgg" and (type(v.Data) == "table" and v.Data.EggName == "Common Egg")) then
                    return true;
                end;
            end;

            for _, v in Data.SaveSlots.AllSlots.DEFAULT.SavedObjects do
                if type(v) == "table" and (v.ObjectType == "PetEgg" and (type(v.Data) == "table" and v.Data.EggName == "Common Egg")) then
                    return true;
                end;
            end;

            return false;
        end;

        local function hasPets() -- Line: 156
            -- upvalues: Data (copy)
            return next(Data.PetsData.PetInventory.Data) ~= nil;
        end;

        local function getFirstPlacedPet() -- Line: 160
            -- upvalues: Data (copy)
            local _, v11 = next(Data.PetsData.EquippedPets);

            return v11;
        end;

        local function hasPlacedPets() -- Line: 165
            -- upvalues: Data (copy)
            return next(Data.PetsData.EquippedPets) ~= nil;
        end;

        local u12 = false;
        local u13 = false;

        local function canSkipStep7() -- Line: 173
            -- upvalues: u12 (ref)
            return not u12;
        end;

        local function canSkipStep6() -- Line: 177
            -- upvalues: Data (copy)
            return next(Data.PetsData.EquippedPets) ~= nil;
        end;

        local function canSkipStep5() -- Line: 181
            -- upvalues: Data (copy)
            return next(Data.PetsData.PetInventory.Data) ~= nil or next(Data.PetsData.EquippedPets) ~= nil;
        end;

        local function canSkipStep4() -- Line: 185
            -- upvalues: hasPlacedEgg (copy), Data (copy)
            return hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or next(Data.PetsData.EquippedPets) ~= nil);
        end;

        local function canSkipStep3() -- Line: 189
            -- upvalues: hasPlacedEgg (copy), Data (copy)
            return hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or next(Data.PetsData.EquippedPets) ~= nil);
        end;

        local function canSkipStep2() -- Line: 193
            -- upvalues: InventoryService (ref), hasPlacedEgg (copy), Data (copy)
            local v15 = InventoryService:Find("PetEgg", function(p14: table) -- Line: 109
                return p14.EggName == "Common Egg";
            end);
            local v16;

            if type(v15) == "table" then
                v16 = next(v15) ~= nil;
            else
                v16 = false;
            end;

            return v16 or hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or next(Data.PetsData.EquippedPets) ~= nil);
        end;

        local function canSkipStep1() -- Line: 197
            -- upvalues: InventoryService (ref), hasPlacedEgg (copy), Data (copy), hasPlacedPets (copy)
            local v18 = InventoryService:Find("PetEgg", function(p17: table) -- Line: 109
                return p17.EggName == "Common Egg";
            end);
            local v19;

            if type(v18) == "table" then
                v19 = next(v18) ~= nil;
            else
                v19 = false;
            end;

            return v19 or hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or hasPlacedPets());
        end;

        local function executeStep1() -- Line: 202
            -- upvalues: InventoryService (ref), hasPlacedEgg (copy), hasPets (copy), canSkipStep6 (copy), Data (copy), PetRegistry (ref), PetEggData (ref)
            local v21 = InventoryService:Find("PetEgg", function(p20: table) -- Line: 109
                return p20.EggName == "Common Egg";
            end);
            local v22;

            if type(v21) == "table" then
                v22 = next(v21) ~= nil;
            else
                v22 = false;
            end;

            if v22 or hasPlacedEgg() or (hasPets() or canSkipStep6()) then
                return true;
            end;

            local v23 = false;

            for _, v in Data.PetEggStock.Stocks do
                if v.EggName == "Common Egg" and v.Stock > 0 then
                    v23 = true;
                    break;
                end;
            end;

            if not PetRegistry.PetEggs["Common Egg"] then
                return false;
            end;

            local v24 = PetEggData["Common Egg"];

            if v24 then
                return v23 and Data.Sheckles >= v24.Price * 1.03 and true or false;
            end;

            return false;
        end;

        local function loopStep1() -- Line: 234
            -- upvalues: executeStep1 (copy), DataService (ref), RebirthUnlocksSharedService (ref), LocalPlayer (ref)
            while not executeStep1() do
                local u25 = false;
                local coroutine_running_ret = coroutine.running();

                local function triggerUpdate() -- Line: 242
                    -- upvalues: u25 (ref), coroutine_running_ret (copy)
                    u25 = true;

                    if coroutine.status(coroutine_running_ret) == "suspended" then
                        task.spawn(coroutine_running_ret);
                    end;
                end;

                local v26 = assert(DataService:GetPathSignal("Sheckles")):Connect(triggerUpdate);
                local v27 = assert(DataService:GetPathSignal("PetEggStock/@")):Connect(triggerUpdate);
                local v28;

                if RebirthUnlocksSharedService:HasBeenAssignedABTest(LocalPlayer) then
                    v28 = assert(DataService:GetPathSignal("InventoryData/@")):Connect(triggerUpdate);
                else
                    v28 = nil;
                end;

                if not u25 then
                    coroutine.yield();
                end;

                v26:Disconnect();
                v27:Disconnect();

                if v28 then
                    v28:Disconnect();
                end;
            end;

            return true;
        end;

        local function executeStep2() -- Line: 274
            -- upvalues: InventoryService (ref), hasPlacedEgg (copy), Data (copy), hasPlacedPets (copy), Arrow_Module (ref), LocalPlayer (ref), executeStep1 (copy)
            local v30 = InventoryService:Find("PetEgg", function(p29: table) -- Line: 109
                return p29.EggName == "Common Egg";
            end);
            local v31;

            if type(v30) == "table" then
                v31 = next(v30) ~= nil;
            else
                v31 = false;
            end;

            if v31 or hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or hasPlacedPets()) then
                return true;
            end;

            local Position = workspace.Tutorial_Points.Tutorial_Point_4.Position;
            local u32 = Arrow_Module.GenerateArrow(LocalPlayer, Position, math.random(1, 1000000));

            local function v33() -- Line: 70
                -- upvalues: Arrow_Module (ref), u32 (copy)
                Arrow_Module.Remove_Arrow(u32);
            end;

            while true do
                local v35 = InventoryService:Find("PetEgg", function(p34: table) -- Line: 109
                    return p34.EggName == "Common Egg";
                end);
                local v36;

                if type(v35) == "table" then
                    v36 = next(v35) ~= nil;
                else
                    v36 = false;
                end;

                if v36 or hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or hasPlacedPets()) then
                    v33();

                    return true;
                end;

                if not ((not LocalPlayer.Character or LocalPlayer:DistanceFromCharacter(Position) > 8) and executeStep1()) then
                    v33();

                    return executeStep1();
                end;

                task.wait(0.25);
            end;
        end;

        local function executeStep3() -- Line: 308
            -- upvalues: hasPlacedEgg (copy), Data (copy), Notification (ref)
            if hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or next(Data.PetsData.EquippedPets) ~= nil) then
                return true;
            end;

            Notification:CreateNotification("Buy a Common Egg!");

            return true;
        end;

        local u37 = nil;

        local function executeStep4() -- Line: 321
            -- upvalues: hasPlacedEgg (copy), Data (copy), InventoryService (ref), DataService (ref), u2 (copy), TutorialUtils (ref), Notification (ref), Arrow_Module (ref), LocalPlayer (ref), u37 (ref), getRandomClickPosition (copy), ReplicatedStorage (ref), u13 (ref)
            if hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or next(Data.PetsData.EquippedPets) ~= nil) then
                return true;
            end;

            while true do
                local v39 = InventoryService:Find("PetEgg", function(p38: table) -- Line: 109
                    return p38.EggName == "Common Egg";
                end);
                local v40;

                if type(v39) == "table" then
                    v40 = next(v39) ~= nil;
                else
                    v40 = false;
                end;

                if v40 then
                    local Position = u2.Spawn_Point.CFrame.Position;

                    if TutorialUtils.getDistanceTo(Position) > 10 then
                        Notification:CreateNotification("Go back to your farm");
                        local u41 = Arrow_Module.GenerateArrow(LocalPlayer, Position, math.random(1, 1000000));

                        local function v42() -- Line: 70
                            -- upvalues: Arrow_Module (ref), u41 (copy)
                            Arrow_Module.Remove_Arrow(u41);
                        end;

                        TutorialUtils.waitUntilDistance(Position, 10);
                        v42();
                    end;

                    Notification:CreateNotification("Equip the egg and place it in your Farm");

                    if not u37 then
                        u37 = getRandomClickPosition();
                    end;

                    local v43 = ReplicatedStorage.Tutorial_Parts.Tutorial_Click:Clone();
                    v43.Size = Vector3.new(0.001, 0.001, 0.001);
                    v43.Position = u37 or (u2.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;
                    v43.Parent = workspace.Click_Points;

                    while not hasPlacedEgg() do
                        assert(DataService:GetPathSignal("SaveSlots/AllSlots/DEFAULT/SavedObjects/@")):Wait();
                    end;

                    u13 = true;
                    v43:Destroy();

                    return true;
                end;

                assert(DataService:GetPathSignal("InventoryData/@")):Wait();
            end;
        end;

        local function executeStep5() -- Line: 370
            -- upvalues: Data (copy), u13 (ref), Notification (ref), CollectionService (ref), LocalPlayer (ref), InventoryServiceEnums (ref), TutorialUtils (ref), Arrow_Module (ref), DataService (ref)
            if next(Data.PetsData.PetInventory.Data) ~= nil or next(Data.PetsData.EquippedPets) ~= nil then
                return true;
            end;

            local function getHatchTimer() -- Line: 375
                -- upvalues: Data (ref)
                local v44 = (1 / 0);

                for _, v in Data.SavedObjects do
                    if type(v) == "table" and (v.ObjectType == "PetEgg" and (type(v.Data) == "table" and (v.Data.EggName == "Common Egg" and type(v.Data.TimeToHatch) == "number"))) then
                        v44 = math.min(v44, v.Data.TimeToHatch);
                    end;
                end;

                for _, v in Data.SaveSlots.AllSlots.DEFAULT.SavedObjects do
                    if type(v) == "table" and (v.ObjectType == "PetEgg" and (type(v.Data) == "table" and v.Data.EggName == "Common Egg")) then
                        v44 = math.min(v44, v.Data.TimeToHatch);
                    end;
                end;

                return v44;
            end;

            local v45 = getHatchTimer();
            local _ = v45 <= 0;

            if v45 > 0 and u13 then
                Notification:CreateNotification("Wait until your egg is ready");
            end;

            while getHatchTimer() > 0 and next(Data.PetsData.PetInventory.Data) == nil do
                task.wait(1);
            end;

            Notification:CreateNotification("Your egg is ready to hatch!");

            local function getEggToPoint() -- Line: 425
                -- upvalues: CollectionService (ref), LocalPlayer (ref), InventoryServiceEnums (ref)
                for _, v in CollectionService:GetTagged("PetEggServer") do
                    if v:GetAttribute("OWNER") == LocalPlayer.Name and (v:GetAttribute(InventoryServiceEnums.EggName) == "Common Egg" and v:GetAttribute("READY")) then
                        return v;
                    end;
                end;

                return nil;
            end;

            local v46;

            if next(Data.PetsData.PetInventory.Data) ~= nil then
                v46 = nil;
            else
                v46 = getEggToPoint();
            end;

            local v47;

            if v46 then
                v47 = v46:GetPivot().Position;
            else
                v47 = nil;
            end;

            if v46 ~= nil and v47 ~= nil then
                if TutorialUtils.getDistanceTo(v47) > 7 then
                    local u48 = Arrow_Module.GenerateArrow(LocalPlayer, v47, math.random(1, 1000000));

                    local function v49() -- Line: 70
                        -- upvalues: Arrow_Module (ref), u48 (copy)
                        Arrow_Module.Remove_Arrow(u48);
                    end;

                    TutorialUtils.waitUntilDistance(v47, 7);
                    v49();
                end;

                Notification:CreateNotification("Hatch the egg!");
            end;

            while next(Data.PetsData.PetInventory.Data) == nil do
                assert(DataService:GetPathSignal("PetsData/PetInventory/@")):Wait();
            end;

            task.wait(0.5);

            while workspace.Visuals:FindFirstChild("Common Egg") or workspace.Visuals:FindFirstChild("EggExplode") do
                task.wait();
            end;

            task.wait(0.5);

            return true;
        end;

        local function executeStep6() -- Line: 468
            -- upvalues: Data (copy), LocalPlayer (ref), InventoryServiceEnums (ref), ItemTypeEnums (ref), Notification (ref), ReplicatedStorage (ref), u37 (ref), u2 (copy), DataService (ref), u12 (ref)
            if next(Data.PetsData.EquippedPets) ~= nil then
                return true;
            end;

            local v50 = LocalPlayer.Character:FindFirstChildOfClass("Tool");

            if v50 and v50:GetAttribute(InventoryServiceEnums.ITEM_TYPE) == ItemTypeEnums.Pet then
                Notification:CreateNotification("Now with your pet in hands, tap on your Farm");
            else
                Notification:CreateNotification("Now equip your pet and tap on your Farm");
            end;

            local v51 = ReplicatedStorage.Tutorial_Parts.Tutorial_Click:Clone();
            v51.Size = Vector3.new(0.001, 0.001, 0.001);
            v51.Position = u37 or (u2.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;
            v51.Parent = workspace.Click_Points;

            while next(Data.PetsData.EquippedPets) == nil do
                assert(DataService:GetPathSignal("PetsData/EquippedPets/@")):Wait();
            end;

            u12 = true;
            v51:Destroy();

            return true;
        end;

        local function executeStep7() -- Line: 497
            -- upvalues: u12 (ref), Data (copy), ActivePetsService (ref), LocalPlayer (ref), PlayerGui (ref), FastTween (ref), RunService (ref), workspace_CurrentCamera (ref), PetActionUserInterfaceService (ref), PetCardUserInterfaceService (ref), CollectionService (ref), SoundService (ref)
            if not u12 then
                return true;
            end;

            local _, u52 = next(Data.PetsData.EquippedPets);

            if not u52 then
                return true;
            end;

            local v53 = 15;

            while not ActivePetsService:GetClientPetStateUUID(LocalPlayer.Name, u52) and v53 > 0 do
                v53 = v53 - task.wait();
            end;

            if v53 <= 0 then
                return true;
            end;

            PlayerGui.PetEggTutorial.Enabled = true;
            local FocusPoint = PlayerGui.PetEggTutorial.FocusPoint;
            local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
            local TweenInfo_new_ret2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            FocusPoint.Size = UDim2.fromScale(1.5, 1.5);
            FastTween(FocusPoint, TweenInfo_new_ret2, {
                Size = UDim2.fromScale(0.3, 0.3)
            });
            FastTween(FocusPoint, TweenInfo_new_ret, {
                ImageTransparency = 0.3
            });
            FastTween(FocusPoint.UIStroke, TweenInfo_new_ret, {
                Transparency = 0.3
            });
            local v56 = RunService.PreRender:Connect(function() -- Line: 536
                -- upvalues: ActivePetsService (ref), LocalPlayer (ref), u52 (copy), workspace_CurrentCamera (ref), FocusPoint (copy)
                local ClientPetStateUUID = ActivePetsService:GetClientPetStateUUID(LocalPlayer.Name, u52);

                if ClientPetStateUUID and ClientPetStateUUID.LastUpdatedPosition then
                    local v54, v55 = workspace_CurrentCamera:WorldToScreenPoint(ClientPetStateUUID.LastUpdatedPosition);

                    if v55 then
                        FocusPoint.Position = UDim2.fromOffset(v54.X, v54.Y);
                        FocusPoint.Visible = true;

                        return;
                    end;
                end;

                FocusPoint.Position = UDim2.fromScale(1.5, 1.5);
                FocusPoint.Visible = false;
            end);
            FocusPoint.Step1.Visible = true;
            FastTween(FocusPoint.Step1.Label1, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                TextTransparency = 0
            });
            FastTween(FocusPoint.Step1.Label2, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.3), {
                TextTransparency = 0
            });
            local v57 = 7;

            while not PetActionUserInterfaceService.Active and v57 > 0 do
                v57 = v57 - task.wait();
            end;

            FastTween(FocusPoint, TweenInfo_new_ret, {
                ImageTransparency = 1
            });
            FastTween(FocusPoint.UIStroke, TweenInfo_new_ret, {
                Transparency = 1
            });
            FastTween(FocusPoint.Step1.Label1, TweenInfo_new_ret, {
                TextTransparency = 1
            });
            FastTween(FocusPoint.Step1.Label2, TweenInfo_new_ret, {
                TextTransparency = 1
            });
            task.wait(0.5);
            FocusPoint.Step1.Visible = false;
            v56:Disconnect();

            while not PlayerGui.PetUI.Enabled or PlayerGui.PetUI.PetCard.Main.Position.X.Scale > 1 do
                task.wait();
            end;

            if not PetCardUserInterfaceService.Active then
                PetCardUserInterfaceService:Toggle(true);
            end;

            local Toggle = PetCardUserInterfaceService.Toggle;

            function PetCardUserInterfaceService.Toggle() -- Line: 600
            end;

            FastTween(PlayerGui.PetUI.Background, TweenInfo_new_ret, {
                BackgroundTransparency = 0.3
            });
            task.wait(0.5);
            local v58 = {};

            for _, v in CollectionService:GetTagged("PetTooltip") do
                if v:IsDescendantOf(PlayerGui.PetUI) then
                    if v.Parent.Parent:FindFirstChild("HUNGER_BAR") then
                        table.insert(v58, 1, v);
                    elseif v.Parent.Parent:FindFirstChild("PET_LEVEL") then
                        table.insert(v58, 2, v);
                    elseif v.Parent.Parent:FindFirstChild("PET_WEIGHT") then
                        table.insert(v58, 3, v);
                    elseif v.Parent.Parent:FindFirstChild("PET_ABILITY") then
                        table.insert(v58, 4, v);
                    end;
                end;
            end;

            for _, v in v58 do
                SoundService.Click:Play();
                v:SetAttribute("ForceTooltip", true);
                task.wait(3);
            end;

            task.wait(3);

            for _, v in v58 do
                local v59;

                if v.Parent.Parent:FindFirstChild("PET_ABILITY") then
                    v59 = false;
                else
                    v59 = nil;
                end;

                v:SetAttribute("ForceTooltip", v59);
            end;

            FastTween(PlayerGui.PetUI.Background, TweenInfo_new_ret, {
                BackgroundTransparency = 1
            });
            PetCardUserInterfaceService.Toggle = Toggle;

            return true;
        end;

        while task.wait() do
            ReplicatedStorage.GameEvents.EggTutorial:FireServer(1);
            loopStep1();
            ReplicatedStorage.GameEvents.EggTutorial:FireServer(2);

            if executeStep2() then
                ReplicatedStorage.GameEvents.EggTutorial:FireServer(3);
                local v60;

                if hasPlacedEgg() or (next(Data.PetsData.PetInventory.Data) ~= nil or hasPlacedPets()) then
                    v60 = true;
                else
                    Notification:CreateNotification("Buy a Common Egg!");
                    v60 = true;
                end;

                if v60 then
                    ReplicatedStorage.GameEvents.EggTutorial:FireServer(4);

                    if executeStep4() then
                        ReplicatedStorage.GameEvents.EggTutorial:FireServer(5);

                        if executeStep5() then
                            ReplicatedStorage.GameEvents.EggTutorial:FireServer(6);

                            if executeStep6() then
                                ReplicatedStorage.GameEvents.EggTutorial:FireServer(7);

                                if executeStep7() then
                                    ReplicatedStorage.GameEvents.EggTutorial:FireServer(8);
                                    break;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end
};

function u61.Start(p62) -- Line: 690
    -- upvalues: TradeWorldController (copy), ReplicatedStorage (copy), u61 (copy)
    if TradeWorldController:IsInWorld() then
        return;
    end;

    ReplicatedStorage.GameEvents.EggTutorial.OnClientEvent:Connect(function(p63: userdata) -- Line: 695
        -- upvalues: u61 (ref)
        u61:Run();
    end);
end;

task.spawn(u61.Start, u61);

return u61;