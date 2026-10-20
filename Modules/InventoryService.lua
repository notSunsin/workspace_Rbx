-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local LocalPlayer = game.Players.LocalPlayer;
local u9 = {
    GetToolData = function(p1: table, p2: userdata) -- Line: 21, Name: GetToolData
        -- upvalues: InventoryServiceEnums (copy), DataService (copy)
        if not p2 then
            return warn("InventoryService:GetToolData | Player is Nil!", debug.traceback());
        end;

        if not p2:IsA("Tool") then
            return warn(`InventoryService:GetToolData | {p2} is not of 'Tool' type!`, debug.traceback());
        end;

        local Attribute = p2:GetAttribute(InventoryServiceEnums.ITEM_UUID);

        if not Attribute then
            return nil;
        end;

        local v3 = DataService:GetData().InventoryData[Attribute];

        if v3 then
            return v3;
        end;
    end,

    Find = function(p4: table, p5: string, p6: function?) -- Line: 36, Name: Find
        -- upvalues: DataService (copy)
        local v7 = p6 or function() -- Line: 37
            return true;
        end;
        local v8 = {};
        local Data = DataService:GetData();

        if not Data then
            return v8;
        end;

        for i, v in Data.InventoryData do
            if v.ItemType == p5 and v7(v.ItemData) then
                v8[i] = v;
            end;
        end;

        return v8;
    end
};

function u9.IsMaxInventory(p10) -- Line: 55
    -- upvalues: u9 (copy), CountDictionary (copy), LocalPlayer (copy)
    return CountDictionary((u9:Find("Holdable"))) >= 200 + (LocalPlayer:GetAttribute("BonusBackpackSize") or 0);
end;

return u9;