-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetList = PetRegistry.PetList;
local PetEggs = PetRegistry.PetEggs;
local SeedData = require(ReplicatedStorage.Data.SeedData);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local GearData = require(ReplicatedStorage.Data.GearData);
local GearUtil = require(ReplicatedStorage.Modules.GearUtil);
require(ReplicatedStorage.Data.CurrencyData);
local FenceSkinRegistry = require(ReplicatedStorage.Data.FenceSkinRegistry);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local ShovelSkinRegistry = require(ReplicatedStorage.Data.ShovelSkinRegistry);
local UpdateLogItemData = require(ReplicatedStorage.Data.UpdateLog.UpdateLogItemData);
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);

local function CullGearUsesFromDescription(p1: string) -- Line: 27
    return p1:gsub("%s*%.%s*%d+%s+[Uu]ses%.?%s*$", "");
end;

function FindItemDescription(p2: string, p3: string)
    -- upvalues: PetList (copy), SeedData (copy), GearUtil (copy), GearData (copy), CullGearUsesFromDescription (copy), SeedPackData (copy), PetEggs (copy), CosmeticCrates (copy), CosmeticList (copy), BeeEnchantmentRegistry (copy), TradeBoothSkinRegistry (copy), FenceSkinRegistry (copy), ShovelSkinRegistry (copy), UpdateLogItemData (copy)
    if p3 == "Pet" then
        local v4 = PetList[p2];

        if v4 and (v4.Description and v4.Description ~= "") then
            return v4.Description;
        end;
    else
        if p3 == "Seed" then
            local v5 = SeedData[p2];

            if v5 then
                if v5.Description and v5.Description ~= "" then
                    return v5.Description;
                end;

                if v5.AbilityDescription and v5.AbilityDescription ~= "" then
                    return v5.AbilityDescription;
                end;
            end;

            return `Plant this seed in your garden and watch it grow into a {p2:gsub(" Seed", "")} plant.`;
        end;

        if p3 == "Holdable" or p3 == "Fruit" then
            local v6 = SeedData[p2];

            if v6 then
                if v6.Description and v6.Description ~= "" then
                    return v6.Description;
                end;

                if v6.AbilityDescription and v6.AbilityDescription ~= "" then
                    return v6.AbilityDescription;
                end;
            end;

            if p3 == "Fruit" then
                return `A fresh {p2}, harvested straight from the garden. Sell it or use it in recipes!`;
            end;
        elseif GearUtil.IsItemTypeGear(p3) then
            local function CullGearUsesFromString(p7: string) -- Line: 65
                return p7:gsub("%s*%[%d+x?%s+[Uu]ses%]%s*$", "");
            end;

            local v8 = p2:gsub("%s*%[%d+x?%s+[Uu]ses%]%s*$", "");
            local v9 = GearData[v8 == "Smith Hammer Harvest" and "Smith Hammer of Harvest" or v8];

            if v9 and (v9.GearDescription and v9.GearDescription ~= "") then
                return CullGearUsesFromDescription(v9.GearDescription);
            end;
        else
            if p3 == "Seed Pack" or p3 == "Pack" then
                local v10 = SeedPackData.Packs[p2];

                return not (v10 and (v10.Description and v10.Description ~= "")) and (string.find(p2, "Chest") and "Contains an item. Open the chest to find out what it is." or (string.find(p2, "Container") and "Contains a Trade Booth Skin. Open the container to find out what it is." or "Contains a seed. Open the pack to find out what it is.")) or v10.Description;
            end;

            if p3 == "PetEgg" or p3 == "Egg" then
                local v11 = PetEggs[p2];

                return not (v11 and (v11.Description and v11.Description ~= "")) and "Place this egg in your garden and wait for it to hatch into a pet." or v11.Description;
            end;

            if p3 == "CosmeticCrate" or p3 == "Crate" then
                local v12 = CosmeticCrates[p2];

                return not (v12 and (v12.Description and v12.Description ~= "")) and "Contains a cosmetic. Place the crate in your garden and wait for it to open to find out what it is." or v12.Description;
            end;

            if p3 == "Cosmetic" then
                local v13 = CosmeticList[p2];

                if v13 and (v13.Description and v13.Description ~= "") then
                    return v13.Description;
                end;
            elseif p3 == "Bee Shard" then
                local v14 = BeeEnchantmentRegistry.Entries[p2];

                if v14 and (v14.Description and v14.Description ~= "") then
                    return v14.Description;
                end;
            else
                if p3 == "Currency" then
                    return "This is a currency. Use it to purchase things.";
                end;

                if p3 == "TradeBoothSkin" then
                    if TradeBoothSkinRegistry[p2] then
                        return TradeBoothSkinRegistry[p2].Description or `Decorate your Trade Booth with a {p2} style`;
                    end;
                elseif p3 == "Fences" or p3 == "Fence" then
                    if FenceSkinRegistry[p2] then
                        return FenceSkinRegistry[p2].Description or `Fence with a {p2} style`;
                    end;
                elseif p3 == "ShovelSkin" then
                    local v15 = ShovelSkinRegistry[p2];

                    if v15 then
                        return v15.Description;
                    end;
                else
                    local v16 = p3 == "UpdateLogItem" and UpdateLogItemData[p2];

                    if v16 then
                        return v16.Description;
                    end;
                end;
            end;
        end;
    end;

    return "";
end;

return FindItemDescription;