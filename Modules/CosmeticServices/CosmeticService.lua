-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("HttpService");
local u1 = {};
local DataService = require(ReplicatedStorage.Modules.DataService);
local CosmeticRegistry = require(ReplicatedStorage.Data.CosmeticRegistry);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local CosmeticUtilities = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticUtilities);
local CosmeticUpgradeService = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticUpgradeService);
local Notification = require(ReplicatedStorage.Modules.Notification);
local CosmeticMutableStats = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticMutableStats);
local CosmeticPool = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticPool);
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local CosmeticService = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("CosmeticService");
local DEFAULT_PLACEMENT_CONFIG = CosmeticRegistry.InputConfig.DEFAULT_PLACEMENT_CONFIG;
local _ = CosmeticRegistry.CosmeticList;

function u1.HasMaxInventory(p2) -- Line: 26
    -- upvalues: DataService (copy), u1 (copy), CountDictionary (copy)
    local Data = DataService:GetData();

    if Data then
        local CosmeticData = Data.CosmeticData;

        if not CosmeticData.MutableStats then
            return warn("CosmeticService:HasMaxInventory Passed player has corrupted MutableStats!");
        end;

        local MutableStat = u1:GetMutableStat("MaxCosmeticsInInventory");

        if not MutableStat then
            return warn("CosmeticService:HasMaxInventory Passed player has corrupted MaxCosmeticsInInventory Stats!");
        end;

        local Inventory = CosmeticData.Inventory;

        if Inventory then
            return MutableStat <= CountDictionary(Inventory);
        end;

        return warn("CosmeticService:HasMaxInventory Passed player has corrupted CosmeticData.Inventory!");
    end;
end;

function u1.HasMaxEquipped(p3) -- Line: 39
    -- upvalues: DataService (copy), u1 (copy), SaveSlotController (copy), CountDictionary (copy)
    local Data = DataService:GetData();

    if Data then
        if not Data.CosmeticData.MutableStats then
            return warn("CosmeticService:HasMaxInventory Passed player has corrupted MutableStats!");
        end;

        local MutableStat = u1:GetMutableStat("MaxEquippedCosmetics");

        if not MutableStat then
            return warn("CosmeticService:HasMaxInventory Passed player has corrupted MaxEquippedCosmetics Stats!");
        end;

        local EquippedCosmetics = SaveSlotController:GetCurrentSaveSlot().EquippedCosmetics;

        if EquippedCosmetics then
            return MutableStat <= CountDictionary(EquippedCosmetics);
        end;

        return warn("CosmeticService:HasMaxInventory Passed player has corrupted CosmeticData.Inventory!");
    end;
end;

function u1.GetCosmeticArbitraryData(p4: table, p5: string) -- Line: 53
    -- upvalues: u1 (copy)
    local AllCosmetics = u1:GetAllCosmetics();

    if not AllCosmetics then
        return;
    end;

    local v6 = AllCosmetics[p5];

    if v6 then
        return v6.Data;
    end;
end;

function u1.GetMutableStat(p7: table, p8: string) -- Line: 60
    -- upvalues: DataService (copy), CosmeticMutableStats (copy), CosmeticUpgradeService (copy)
    local Data = DataService:GetData();

    if Data then
        local MutableStats = Data.CosmeticData.MutableStats;
        local v9 = CosmeticMutableStats[p8];
        local v10 = v9 and (v9.Default or 0) or 0;
        local v11 = MutableStats[p8] or 0;
        local v12 = v9 and v9.UpgradeData and v9.UpgradeData.MaxUpgrade;

        if v12 then
            v11 = math.min(v11, v12);
        end;

        if v9 then
            v9 = v9.BonusField;
        end;

        local v13 = v9 and MutableStats[v9] or 0;

        return v10 + CosmeticUpgradeService:GetUpgradeValue(p8, v11) + v13;
    end;
end;

function u1.CanEquipAtLocation(p14: table, p15: userdata) -- Line: 81
    -- upvalues: DEFAULT_PLACEMENT_CONFIG (copy), CosmeticUtilities (copy)
    local Character = p15.Character;

    if Character then
        return CosmeticUtilities:IsWithinFarm(p15, Character:GetPivot() * DEFAULT_PLACEMENT_CONFIG.CFRAME_OFFSET);
    end;

    return false;
end;

function u1.Equip(p16: table, p17: string) -- Line: 88
    -- upvalues: DataService (copy), SaveSlotController (copy), u1 (copy), Notification (copy), CountDictionary (copy), CosmeticService (copy)
    local Data = DataService:GetData();

    if Data then
        local _ = Data.CosmeticData;
        local EquippedCosmetics = SaveSlotController:GetCurrentSaveSlot().EquippedCosmetics;

        if not EquippedCosmetics then
            return warn("CosmeticService:HasMaxInventory Passed player has corrupted CosmeticData.Inventory!");
        end;

        if u1:HasMaxEquipped() then
            return Notification:CreateNotification((`Cannot place anymore you have max placed objects! {CountDictionary(EquippedCosmetics)}`));
        end;

        CosmeticService:FireServer("Equip", p17);

        return true;
    end;
end;

function u1.Unequip(p18: table, p19: string) -- Line: 101
    -- upvalues: CosmeticService (copy)
    CosmeticService:FireServer("Unequip", p19);

    return true;
end;

function u1.DestroyCosmetic(p20: table, p21: string) -- Line: 106
    -- upvalues: CosmeticService (copy)
    CosmeticService:FireServer("DestroyCosmetic", p21);

    return true;
end;

function u1.UnequipAll(p22) -- Line: 111
    -- upvalues: CosmeticService (copy)
    CosmeticService:FireServer("UnequipAll");

    return true;
end;

function u1.GetAllCosmetics(p23) -- Line: 116
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        return Data.CosmeticData.Inventory or warn("CosmeticService:GetAllCosmetics Passed player has corrupted CosmeticData.Inventory!");
    end;
end;

function u1.GetAllEquippedCosmetics(p24) -- Line: 123
    -- upvalues: DataService (copy), SaveSlotController (copy)
    local Data = DataService:GetData();

    if Data then
        local _ = Data.CosmeticData;

        return SaveSlotController:GetCurrentSaveSlot().EquippedCosmetics or warn("CosmeticService:HasMaxInventory Passed player has corrupted CosmeticData.Inventory!");
    end;
end;

function u1.GetPooledCounts(p25) -- Line: 133
    -- upvalues: DataService (copy), CosmeticPool (copy)
    local Data = DataService:GetData();

    if not Data then
        return {};
    end;

    local Pool = CosmeticPool.GetPool(Data);

    return not Pool and {} or CosmeticPool.CountAllOwned({
        CosmeticData = {
            Pool = Pool
        }
    });
end;

function u1.GetPlacedInAnySlot(p26) -- Line: 140
    -- upvalues: DataService (copy), CosmeticPool (copy)
    local Data = DataService:GetData();

    return Data and (CosmeticPool.CollectKnownReferences(Data) or {}) or {};
end;

function u1.IsCosmeticEquipped(p27: table, p28: string) -- Line: 145
    -- upvalues: DataService (copy), SaveSlotController (copy)
    local Data = DataService:GetData();

    if Data then
        local _ = Data.CosmeticData;
        local EquippedCosmetics = SaveSlotController:GetCurrentSaveSlot().EquippedCosmetics;

        if EquippedCosmetics then
            return EquippedCosmetics[p28] ~= nil;
        end;

        return warn("CosmeticService:HasMaxInventory Passed player has corrupted CosmeticData.Inventory!");
    end;
end;

return u1;