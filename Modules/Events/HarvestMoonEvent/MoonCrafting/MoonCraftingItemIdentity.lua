-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local ReversedItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ReversedItemTypeEnums);
local PetBoostRegistry = require(ReplicatedStorage.Data.PetRegistry.PetBoostRegistry);
local u1 = {};
local v2 = {};

for _, v in { "Harvest Tool", "Watering Can", "Recall Wrench", "Fairy Jar", "Fairy Net", "Luminous Wand", "Fairy Caller", "Fairy Targeter", "Fairy Power Extender", "Fairy Summoner", "Favorite Tool" } do
    local v3 = ItemTypeEnums[v];

    if v3 then
        u1[v3] = true;
    end;
end;

function v2.FromTool(p4: userdata) -- Line: 79
    -- upvalues: InventoryServiceEnums (copy), ReversedItemTypeEnums (copy), PetsService (copy), ItemTypeEnums (copy), PetBoostRegistry (copy), u1 (copy), InventoryService (copy)
    if not p4 then
        return nil;
    end;

    local Attribute = p4:GetAttribute(InventoryServiceEnums.ITEM_TYPE);
    local v5 = ReversedItemTypeEnums[Attribute] or p4:GetAttribute("ItemType");
    local Attribute2 = p4:GetAttribute(InventoryServiceEnums.ItemName);
    local Attribute3 = p4:GetAttribute("PET_UUID");
    local v6;

    if Attribute3 then
        v6 = PetsService:GetPlayerPetData(Attribute3);
    else
        v6 = Attribute3;
    end;

    if v5 then
        if v5 == ReversedItemTypeEnums[ItemTypeEnums.PetEgg] then
            Attribute2 = p4:GetAttribute(InventoryServiceEnums.EggName);
        elseif v5 == ReversedItemTypeEnums[ItemTypeEnums.CosmeticCrate] then
            Attribute2 = p4:GetAttribute(InventoryServiceEnums.CrateType);
        elseif Attribute3 and v6 then
            Attribute2 = v6.PetType;
        elseif v5 == ReversedItemTypeEnums[ItemTypeEnums.SprayBottle] then
            Attribute2 = p4:GetAttribute(InventoryServiceEnums.SprayType);
        elseif v5 == ReversedItemTypeEnums[ItemTypeEnums.PetBoost] then
            local Attribute4 = p4:GetAttribute(InventoryServiceEnums.PetBoostSize);
            local Attribute5 = p4:GetAttribute(InventoryServiceEnums.PetBoostType);
            Attribute2 = `{Attribute4} {PetBoostRegistry.BoostTypeToPetModelName[Attribute5]}`;
        elseif v5 == ReversedItemTypeEnums[ItemTypeEnums["Seed Pack"]] then
            Attribute2 = p4:GetAttribute(InventoryServiceEnums.Type);
        elseif v5 == ReversedItemTypeEnums[ItemTypeEnums.PetShard] then
            Attribute2 = p4:GetAttribute(InventoryServiceEnums.ShardType);
        elseif Attribute and u1[Attribute] then
            Attribute2 = ReversedItemTypeEnums[Attribute];
        end;
    else
        local ToolData = InventoryService:GetToolData(p4);

        if not (ToolData and ToolData.ItemType) then
            return nil;
        end;

        v5 = ToolData.ItemType;
        Attribute2 = v5;
    end;

    local v7 = p4:GetAttribute(InventoryServiceEnums.ITEM_UUID) or Attribute3;

    return v5 and (Attribute2 and v7) and {
        ItemType = v5,
        ItemName = Attribute2,
        UUID = v7
    } or nil;
end;

function v2.FromInventoryData(p8: string, p9: table) -- Line: 144
    -- upvalues: ReversedItemTypeEnums (copy), ItemTypeEnums (copy), PetBoostRegistry (copy)
    if not p9 then
        return nil;
    end;

    local v10;

    if p8 == ReversedItemTypeEnums[ItemTypeEnums.PetEgg] then
        v10 = p9.EggName;
    elseif p8 == ReversedItemTypeEnums[ItemTypeEnums.CosmeticCrate] then
        v10 = p9.CrateType;
    elseif p8 == ReversedItemTypeEnums[ItemTypeEnums.SprayBottle] then
        v10 = p9.SprayType;
    elseif p8 == ReversedItemTypeEnums[ItemTypeEnums.PetBoost] then
        v10 = `{p9.PetBoostSize} {PetBoostRegistry.BoostTypeToPetModelName[p9.PetBoostType]}`;
    elseif p8 == ReversedItemTypeEnums[ItemTypeEnums["Seed Pack"]] then
        v10 = p9.Type;
    elseif p8 == ReversedItemTypeEnums[ItemTypeEnums.PetShard] then
        v10 = p9.ShardType;
    else
        v10 = p9.ItemName or ReversedItemTypeEnums[p9.ITEM_TYPE];
    end;

    return v10 or (p9.ItemName or p8);
end;

return v2;