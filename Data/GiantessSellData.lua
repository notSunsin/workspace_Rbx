-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.Data.PetRegistry.PetEggs);
require(game.ReplicatedStorage.Data.SeedData);
require(game.ReplicatedStorage.Data.SeedPackData);
require(game.ReplicatedStorage.Data.GearData);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local u1 = {
    SellData = {
        Carrot = {
            SellType = "Item",
            RewardName = "Mythical Egg",
            RewardQuantity = 1,
            RewardType = "Egg"
        },
        Strawberry = {
            SellType = "Item",
            RewardName = "Mysterious Crate",
            RewardQuantity = 1,
            RewardType = "Crate"
        },
        Blueberry = {
            SellType = "Item",
            RewardName = "Sheckles",
            RewardQuantity = 500,
            RewardType = "Currency"
        },
        Flower = {
            SellType = "PlantTrait",
            RewardName = "Sheckles",
            RewardQuantity = 1000,
            RewardType = "Currency",
            CustomResponse = "Ooh, pretty!"
        }
    }
};

function u1.GetRewardFor(p2: table, p3: userdata) -- Line: 64
    -- upvalues: InventoryServiceEnums (copy), u1 (copy), PlantTraitsData (copy)
    local Attribute = p3:GetAttribute(InventoryServiceEnums.ItemName);
    p3:GetAttribute(InventoryServiceEnums.ITEM_TYPE);

    if u1[Attribute] == nil then
        for _, v in PlantTraitsData.GetTraits(Attribute) do
            local v4 = u1.SellData[v];

            if v4 ~= nil and v4.SellType == "PlantTrait" then
                return v4;
            end;
        end;
    end;

    return u1.SellData[Attribute];
end;

function u1.IsSellable(p5, p6) -- Line: 80
    -- upvalues: u1 (copy)
    if not p6:IsA("Tool") then
        return false;
    end;

    p6:FindFirstChild("Item_String");

    return u1:GetRewardFor(p6) ~= nil;
end;

function u1.GetSellableTools(p7: table, p8: any, p9: boolean?) -- Line: 91
    -- upvalues: InventoryServiceEnums (copy), u1 (copy)
    local v10 = {};

    if not v10 then
        return v10;
    end;

    for _, child in p8:GetChildren() do
        if child:IsA("Tool") and (child:FindFirstChild("Item_String") and not (child:GetAttribute(InventoryServiceEnums.Favorite) and (p9 == true or p9 == nil))) and u1:GetRewardFor(child) ~= nil then
            table.insert(v10, child);
        end;
    end;

    return v10;
end;

return u1;