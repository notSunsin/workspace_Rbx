-- Decompiled with Potassium's decompiler.

local ReplicatedFirst = game:GetService("ReplicatedFirst");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local SaveSlotUIController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotUIController);
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local SlotServiceTypes = require(ReplicatedStorage.Types.SlotServiceTypes);
local TeleportPlayer = require(ReplicatedStorage.Modules.TeleportPlayer);
require(script.ABTestTeleportButtons);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
GameEvents:WaitForChild("RecallWrenchTeleport");
GameEvents:WaitForChild("PlayerTeleportTriggered");
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer is nil");
local Teleport_UI = LocalPlayer.PlayerGui.Teleport_UI;
local Frame = Teleport_UI.Frame;
local u1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;

local function IsUpdateReady() -- Line: 39
    -- upvalues: ReplicatedFirst (copy)
    return workspace:GetServerTimeNow() >= ReplicatedFirst.GlobalUpdateTime.Value;
end;

local function IsEasterSlot() -- Line: 43
    -- upvalues: SaveSlotController (copy), SlotServiceTypes (copy)
    return SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.EASTER_2026);
end;

local function IsBeeSlot() -- Line: 47
    -- upvalues: SaveSlotController (copy), SlotServiceTypes (copy)
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();

    return CurrentSaveSlot and CurrentSaveSlot.IsBeeSlot == true and true or SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026);
end;

local function IsHalloweenSlot() -- Line: 57
    -- upvalues: SaveSlotController (copy)
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();
    local v5;

    if CurrentSaveSlot == nil then
        v5 = false;
    else
        v5 = CurrentSaveSlot.IsHalloweenSlot == true;
    end;

    return v5;
end;

local function GetHalloweenShopCFrame(p6: string) -- Line: 63
    -- upvalues: LocalPlayer (copy)
    local Halloween2026MarketModel = workspace.Interaction:FindFirstChild("Halloween2026MarketModel");

    if Halloween2026MarketModel then
        Halloween2026MarketModel = Halloween2026MarketModel:FindFirstChild(p6, true);
    end;

    if Halloween2026MarketModel then
        Halloween2026MarketModel = Halloween2026MarketModel:FindFirstChild("HumanoidRootPart");
    end;

    if not (Halloween2026MarketModel and Halloween2026MarketModel:IsA("BasePart")) then
        return nil;
    end;

    local v7 = Halloween2026MarketModel.Position + Halloween2026MarketModel.CFrame.LookVector * 8;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { LocalPlayer.Character };
    local v8 = workspace:Raycast(v7 + Vector3.new(0, 2, 0), Vector3.new(0, -20, 0), RaycastParams_new_ret);
    local v9;

    if v8 then
        v9 = v8.Position.Y + 3;
    else
        v9 = v7.Y;
    end;

    local Vector3_new_ret = Vector3.new(v7.X, v9, v7.Z);

    return CFrame.lookAt(Vector3_new_ret, (Vector3.new(Halloween2026MarketModel.Position.X, Vector3_new_ret.Y, Halloween2026MarketModel.Position.Z)));
end;

local function RenderTeleportVariant() -- Line: 82
    -- upvalues: SaveSlotController (copy), SlotServiceTypes (copy), UpdateService (copy), Frame (copy)
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();
    local v10;

    if CurrentSaveSlot == nil then
        v10 = false;
    else
        v10 = CurrentSaveSlot.IsHalloweenSlot == true;
    end;

    local CurrentSaveSlot2 = SaveSlotController:GetCurrentSaveSlot();
    local v11 = (CurrentSaveSlot2 and CurrentSaveSlot2.IsBeeSlot == true and true or SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026)) and not v10;
    local v12 = SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.EASTER_2026) and not (v11 or v10) and not UpdateService:IsHiddenAfterUpdate("Easter2026");
    local v13 = not v12 and (not v11 and not v10);
    Frame.Garden.Visible = v13;
    Frame.Seeds.Visible = v13;
    Frame.Sell.Visible = v13;
    Frame.Halloween_Garden.Visible = v10;
    Frame.Halloween_Seeds.Visible = v10;
    Frame.Halloween_Sell.Visible = v10;
    Frame.Easter_Garden.Visible = v12;
    Frame.Easter_Seeds.Visible = v12;
    Frame.Easter_Sell.Visible = v12;
    Frame.Bee_Garden.Visible = v11;
    Frame.Bee_Seeds.Visible = v11;
    Frame.Bee_Sell.Visible = v11;
end;

local function WatchTeleportVariant() -- Line: 105
    -- upvalues: SaveSlotController (copy), SlotServiceTypes (copy), UpdateService (copy), u2 (ref), u3 (ref), u4 (ref), RenderTeleportVariant (copy)
    while true do
        local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();
        local v14;

        if CurrentSaveSlot == nil then
            v14 = false;
        else
            v14 = CurrentSaveSlot.IsHalloweenSlot == true;
        end;

        local CurrentSaveSlot2 = SaveSlotController:GetCurrentSaveSlot();
        local v15 = (CurrentSaveSlot2 and CurrentSaveSlot2.IsBeeSlot == true and true or SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026)) and not v14;
        local v16 = SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.EASTER_2026) and not (v15 or v14) and not UpdateService:IsHiddenAfterUpdate("Easter2026");

        if u2 ~= v16 or (u3 ~= v15 or u4 ~= v14) then
            u2 = v16;
            u3 = v15;
            u4 = v14;
            RenderTeleportVariant();
        end;

        task.wait(0.2);
    end;
end;

local function TeleportToGarden() -- Line: 122
    -- upvalues: GetFarm (copy), LocalPlayer (copy), u1 (copy), Notification (copy)
    local v17 = GetFarm(LocalPlayer);

    if v17 == nil then
        Notification:CreateNotification("You haven\'t been a assigned to a farm yet! Please be patient.");

        return;
    end;

    u1:Move(v17.Spawn_Point.CFrame, "Farm");
end;

local function TeleportToSeeds() -- Line: 131
    -- upvalues: SaveSlotController (copy), GetHalloweenShopCFrame (copy), u1 (copy), SlotServiceTypes (copy), UpdateService (copy)
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();
    local v18;

    if CurrentSaveSlot == nil then
        v18 = false;
    else
        v18 = CurrentSaveSlot.IsHalloweenSlot == true;
    end;

    if v18 then
        v18 = GetHalloweenShopCFrame("HalloweenSam");
    end;

    if v18 then
        u1:Move(v18, "Scary Seeds");

        return;
    end;

    local CurrentSaveSlot2 = SaveSlotController:GetCurrentSaveSlot();

    if CurrentSaveSlot2 and CurrentSaveSlot2.IsBeeSlot == true and true or SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026) then
        u1:Move(workspace.Tutorial_Points.Tutorial_Point_1.CFrame, "Seed Shop");

        return;
    end;

    if SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.EASTER_2026) and not UpdateService:IsHiddenAfterUpdate("Easter2026") then
        u1:Move(workspace.Tutorial_Points.Tutorial_Point_1.CFrame, "Seed Shop");

        return;
    end;

    u1:Move(workspace.Tutorial_Points.Tutorial_Point_1.CFrame, "Seed Shop");
end;

local function TeleportToSell() -- Line: 144
    -- upvalues: SaveSlotController (copy), GetHalloweenShopCFrame (copy), u1 (copy), SlotServiceTypes (copy), UpdateService (copy)
    local CurrentSaveSlot = SaveSlotController:GetCurrentSaveSlot();
    local v19;

    if CurrentSaveSlot == nil then
        v19 = false;
    else
        v19 = CurrentSaveSlot.IsHalloweenSlot == true;
    end;

    if v19 then
        v19 = GetHalloweenShopCFrame("SinisterSteven");
    end;

    if v19 then
        u1:Move(v19, "Sinister Sales");

        return;
    end;

    local CurrentSaveSlot2 = SaveSlotController:GetCurrentSaveSlot();

    if not (CurrentSaveSlot2 and CurrentSaveSlot2.IsBeeSlot == true or SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.BIZZYBEE_2026)) then
        if SaveSlotController:IsCurrentSlotSpecial(SlotServiceTypes.SpecialSlotKeys.EASTER_2026) and not UpdateService:IsHiddenAfterUpdate("Easter2026") then
            u1:Move(workspace.Tutorial_Points.Tutorial_Point_2.CFrame, "Sell Shop");

            return;
        end;

        u1:Move(workspace.Tutorial_Points.Tutorial_Point_2.CFrame, "Sell Shop");

        return;
    end;

    local BeeEvent = workspace.Interaction.UpdateItems:FindFirstChild("BeeEvent");
    local v20;

    if BeeEvent then
        v20 = BeeEvent.HoneyMachine2026.HoneyMachineTeleport.CFrame;
    else
        v20 = CFrame.new(-77.701, 6.581, -7.35);
    end;

    u1:Move(v20, "Compressor");
end;

function u1.Move(p21: table, p22, p23: string) -- Line: 165
    -- upvalues: LocalPlayer (copy), TeleportPlayer (copy)
    if LocalPlayer:GetAttribute("InWaspWaveSurvival") == true then
        return;
    end;

    TeleportPlayer(LocalPlayer, p22, p23);
end;

local function ShowExtraTeleports(p24: boolean?) -- Line: 246
end;

local function RenderButtons() -- Line: 254
    -- upvalues: LocalPlayer (copy), RenderTeleportVariant (copy)
    LocalPlayer:GetAttribute("OtherButtons");
    RenderTeleportVariant();
end;

local function RenderWaspWaveTeleportVisibility() -- Line: 261
    -- upvalues: Teleport_UI (copy), LocalPlayer (copy)
    Teleport_UI.Enabled = LocalPlayer:GetAttribute("InWaspWaveSurvival") ~= true;
end;

LocalPlayer:GetAttribute("OtherButtons");
RenderTeleportVariant();
LocalPlayer:GetAttributeChangedSignal("OtherButtons"):Connect(RenderButtons);
Teleport_UI.Enabled = LocalPlayer:GetAttribute("InWaspWaveSurvival") ~= true;
LocalPlayer:GetAttributeChangedSignal("InWaspWaveSurvival"):Connect(RenderWaspWaveTeleportVisibility);
task.spawn(function() -- Line: 173, Name: BindButtons
    -- upvalues: Frame (copy), SaveSlotUIController (copy), GetFarm (copy), LocalPlayer (copy), u1 (copy), Notification (copy), TeleportToSeeds (copy), TeleportToSell (copy)
    Frame.Garden.Activated:Connect(function() -- Line: 174
        -- upvalues: SaveSlotUIController (ref), GetFarm (ref), LocalPlayer (ref), u1 (ref), Notification (ref)
        if SaveSlotUIController.State then
            return;
        end;

        local v25 = GetFarm(LocalPlayer);

        if v25 == nil then
            Notification:CreateNotification("You haven\'t been a assigned to a farm yet! Please be patient.");

            return;
        end;

        u1:Move(v25.Spawn_Point.CFrame, "Farm");
    end);
    Frame.Easter_Garden.Activated:Connect(function() -- Line: 179
        -- upvalues: SaveSlotUIController (ref), GetFarm (ref), LocalPlayer (ref), u1 (ref), Notification (ref)
        if SaveSlotUIController.State then
            return;
        end;

        local v26 = GetFarm(LocalPlayer);

        if v26 == nil then
            Notification:CreateNotification("You haven\'t been a assigned to a farm yet! Please be patient.");

            return;
        end;

        u1:Move(v26.Spawn_Point.CFrame, "Farm");
    end);
    Frame.Bee_Garden.Activated:Connect(function() -- Line: 184
        -- upvalues: SaveSlotUIController (ref), GetFarm (ref), LocalPlayer (ref), u1 (ref), Notification (ref)
        if SaveSlotUIController.State then
            return;
        end;

        local v27 = GetFarm(LocalPlayer);

        if v27 == nil then
            Notification:CreateNotification("You haven\'t been a assigned to a farm yet! Please be patient.");

            return;
        end;

        u1:Move(v27.Spawn_Point.CFrame, "Farm");
    end);
    Frame.Halloween_Garden.Activated:Connect(function() -- Line: 189
        -- upvalues: SaveSlotUIController (ref), GetFarm (ref), LocalPlayer (ref), u1 (ref), Notification (ref)
        if SaveSlotUIController.State then
            return;
        end;

        local v28 = GetFarm(LocalPlayer);

        if v28 == nil then
            Notification:CreateNotification("You haven\'t been a assigned to a farm yet! Please be patient.");

            return;
        end;

        u1:Move(v28.Spawn_Point.CFrame, "Farm");
    end);
    Frame.Seeds.Activated:Connect(function() -- Line: 194
        -- upvalues: SaveSlotUIController (ref), TeleportToSeeds (ref)
        if SaveSlotUIController.State then
            return;
        end;

        TeleportToSeeds();
    end);
    Frame.Easter_Seeds.Activated:Connect(function() -- Line: 199
        -- upvalues: SaveSlotUIController (ref), TeleportToSeeds (ref)
        if SaveSlotUIController.State then
            return;
        end;

        TeleportToSeeds();
    end);
    Frame.Bee_Seeds.Activated:Connect(function() -- Line: 204
        -- upvalues: SaveSlotUIController (ref), TeleportToSeeds (ref)
        if SaveSlotUIController.State then
            return;
        end;

        TeleportToSeeds();
    end);
    Frame.Halloween_Seeds.Activated:Connect(function() -- Line: 209
        -- upvalues: SaveSlotUIController (ref), TeleportToSeeds (ref)
        if SaveSlotUIController.State then
            return;
        end;

        TeleportToSeeds();
    end);
    Frame.Sell.Activated:Connect(function() -- Line: 214
        -- upvalues: SaveSlotUIController (ref), TeleportToSell (ref)
        if SaveSlotUIController.State then
            return;
        end;

        TeleportToSell();
    end);
    Frame.Easter_Sell.Activated:Connect(function() -- Line: 219
        -- upvalues: SaveSlotUIController (ref), TeleportToSell (ref)
        if SaveSlotUIController.State then
            return;
        end;

        TeleportToSell();
    end);
    Frame.Bee_Sell.Activated:Connect(function() -- Line: 224
        -- upvalues: SaveSlotUIController (ref), TeleportToSell (ref)
        if SaveSlotUIController.State then
            return;
        end;

        TeleportToSell();
    end);
    Frame.Halloween_Sell.Activated:Connect(function() -- Line: 229
        -- upvalues: SaveSlotUIController (ref), TeleportToSell (ref)
        if SaveSlotUIController.State then
            return;
        end;

        TeleportToSell();
    end);
    Frame.Gear.Activated:Connect(function() -- Line: 234
        -- upvalues: SaveSlotUIController (ref), u1 (ref)
        if SaveSlotUIController.State then
            return;
        end;

        u1:Move(workspace.Tutorial_Points.Tutorial_Point_3.CFrame, "Sell Shop");
    end);
    Frame.Pets.Activated:Connect(function() -- Line: 239
        -- upvalues: SaveSlotUIController (ref), u1 (ref)
        if SaveSlotUIController.State then
            return;
        end;

        u1:Move(workspace.Tutorial_Points.Tutorial_Point_4.CFrame, "Sell Shop");
    end);
end);
task.spawn(function() -- Line: 272, Name: CheckHasWrench
    -- upvalues: DataService (copy), LocalPlayer (copy)
    local Data = DataService:GetData();

    if not Data then
        warn((`No player data for {LocalPlayer.Name}`));

        return;
    end;

    local InventoryData = Data.InventoryData;

    if InventoryData then
        for _, v in InventoryData do
            if v.ItemType == "Recall Wrench" then
                return;
            end;
        end;

        return;
    end;

    warn((`No player inventory data for {LocalPlayer.Name}`));
end);
task.spawn(RenderButtons);
task.spawn(RenderWaspWaveTeleportVisibility);
task.spawn(WatchTeleportVariant);

return u1;