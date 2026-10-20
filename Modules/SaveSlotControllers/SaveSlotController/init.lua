-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local u1 = {};
require(ReplicatedStorage.Modules.GenerateRandomString);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.CountDictionary);
local SlotServiceTypes = require(ReplicatedStorage.Types.SlotServiceTypes);
local DisplayNameSanitizer = require(ReplicatedStorage.Modules.DisplayNameSanitizer);
u1.SLOT_NAME_MAX_LENGTH = 15;

function u1.GetSaveSlot(p2: table, p3: string) -- Line: 15
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        return Data.SaveSlots.AllSlots[p3];
    end;
end;

function u1.GetCurrentSaveSlot(p4) -- Line: 25
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        local SaveSlots = Data.SaveSlots;

        return SaveSlots.AllSlots[SaveSlots.SelectedSlot];
    end;
end;

function u1.OptInToSpecialSlot(p5, p6) -- Line: 36
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.GameEvents.SaveSlotService.OptInToSpecialSlot:FireServer(p6);
end;

function u1.IsSpecialSlotOptedIn(p7, p8) -- Line: 41
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        return Data.SaveSlots.AllSlots[p8] ~= nil;
    end;

    warn((`{script.Name} | PlayerData is nil`));
end;

function u1.IsCurrentSlotSpecial(p9, p10) -- Line: 50
    -- upvalues: DataService (copy), SlotServiceTypes (copy)
    local Data = DataService:GetData();

    if Data then
        local SelectedSlot = Data.SaveSlots.SelectedSlot;

        if p10 then
            return SelectedSlot == p10;
        end;

        return SlotServiceTypes.SpecialSlotKeys[SelectedSlot] ~= nil;
    end;

    warn((`{script.Name} | PlayerData is nil`));
end;

function u1.RememberUnlockage(p11) -- Line: 64
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.GameEvents.SaveSlotService.RememberUnlockage:FireServer();
end;

function u1.PurchaseSlot(p12) -- Line: 68
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.GameEvents.SaveSlotService.PurchaseSlot:FireServer();
end;

function u1.PurchaseEventSlot(p13: table, p14: string) -- Line: 72
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.GameEvents.SaveSlotService.PurchaseEventSlot:FireServer(p14);
end;

function u1.ChangeSlots(p15: table, p16: string) -- Line: 76
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.GameEvents.SaveSlotService.RequestChangeSlots:FireServer(p16);
end;

function u1.RenameSaveSlot(p17: table, p18: string, p19: string) -- Line: 80
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.GameEvents.SaveSlotService.RenameSaveSlot:FireServer(p18, p19);
end;

function u1.GetSlotDisplayName(p20: table, p21: string) -- Line: 85
    -- upvalues: u1 (copy), DisplayNameSanitizer (copy)
    local SaveSlot = u1:GetSaveSlot(p21);

    if not SaveSlot then
        return nil;
    end;

    local DisplayName = SaveSlot.DisplayName;

    if type(DisplayName) ~= "string" then
        return nil;
    end;

    local v22 = DisplayNameSanitizer.Sanitize(DisplayName, 15);

    if v22 == "" or not v22 then
        v22 = nil;
    end;

    return v22;
end;

function u1.HasPurchasedSlotFromAscension(p23) -- Line: 101
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if not Data then
        return false;
    end;

    local v24 = Data.GardenCoinShopStats.LifetimePurchases["Save Slot"];

    return v24 and v24 >= 1 and true or false;
end;

function u1.GetAllSlots(p25) -- Line: 115
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        return Data.SaveSlots.AllSlots;
    end;
end;

function u1.GetSaveSlotChangeSignal(p26) -- Line: 124
    -- upvalues: DataService (copy)
    if DataService:GetData() then
        return DataService:GetPathSignal("SaveSlots/SelectedSlot");
    end;
end;

function u1.GetMostRecentNormalSlot(p27) -- Line: 135
    -- upvalues: DataService (copy), SlotServiceTypes (copy)
    local Data = DataService:GetData();

    if not Data then
        return nil;
    end;

    local SaveSlots = Data.SaveSlots;

    if not (SaveSlots and SaveSlots.AllSlots) then
        return nil;
    end;

    local v28 = (-1 / 0);
    local v29 = nil;

    for i, v in SaveSlots.AllSlots do
        if typeof(v) == "table" and not (SlotServiceTypes.SpecialSlotKeys[i] or (SlotServiceTypes.PermanentEventSlots[i] or i == "BEE")) then
            local v30 = v.LastLoaded or 0;

            if v28 < v30 then
                v29 = i;
                v28 = v30;
            end;
        end;
    end;

    return v29 or (SaveSlots.AllSlots.DEFAULT and "DEFAULT" or nil);
end;

function u1.GetSelectedSlotKey(p31) -- Line: 185
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        return Data.SaveSlots.SelectedSlot;
    end;

    return nil;
end;

return u1;