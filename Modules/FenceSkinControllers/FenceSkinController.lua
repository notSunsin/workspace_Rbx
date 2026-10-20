-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local DataService = require(ReplicatedStorage.Modules.DataService);

return {
    GetFenceSkin = function(p1) -- Line: 11, Name: GetFenceSkin
        -- upvalues: SaveSlotController (copy)
        return SaveSlotController:GetCurrentSaveSlot().SelectedFenceSkin or "DEFAULT";
    end,

    GetOwnedFences = function(p2) -- Line: 16, Name: GetOwnedFences
        -- upvalues: DataService (copy)
        local Data = DataService:GetData();

        if Data then
            local OwnedFences = Data.FenceSkinData.OwnedFences;

            if not OwnedFences.DEFAULT then
                OwnedFences.DEFAULT = true;
            end;

            return OwnedFences;
        end;
    end,

    Equip = function(p3: table, p4: string) -- Line: 28, Name: Equip
        -- upvalues: ReplicatedStorage (copy)
        if not p4 or type(p4) ~= "string" then
            return;
        end;

        ReplicatedStorage.GameEvents.FenceSkinService.Equip:FireServer(p4);
    end
};