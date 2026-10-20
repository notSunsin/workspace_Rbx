-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
require(ReplicatedStorage.Types.PetTypes);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
require(ReplicatedStorage.Data.DefaultData);
local u1 = {
    RAPCacheLifetime = 60,
    ItemTypes = { "Pet", "Holdable", "TradeBoothSkin" },
    NumItemTiers = {
        Pet = 3,
        Holdable = 10,
        TradeBoothSkin = 1
    }
};

local function getHoldableTierFromMultiplier(p2: number) -- Line: 81
    -- upvalues: u1 (copy)
    local math_clamp_ret = math.clamp(p2, 1, 100000);
    local v3 = math.log10(math_clamp_ret) / 5;
    local math_floor_ret = math.floor(1 + (u1.NumItemTiers.Holdable - 1) * v3 ^ 1.4285714285714286);

    return math.clamp(math_floor_ret, 1, u1.NumItemTiers.Holdable);
end;

local function getPetTierFromLevel(p4: number) -- Line: 94
    -- upvalues: u1 (copy)
    local math_max_ret = math.max(p4, 1);

    if math_max_ret >= 100 then
        return u1.NumItemTiers.Pet;
    end;

    local v5 = math.floor(math_max_ret / 10) + 1;

    return math.clamp(v5, 1, u1.NumItemTiers.Pet - 1);
end;

function u1.GetItemId(p6, p7) -- Line: 107
    -- upvalues: u1 (copy), MutationHandler (copy)
    if p6 == "Pet" then
        local v8;

        if p7.PetData then
            v8 = p7.PetData.MutationType;
        else
            v8 = nil;
        end;

        local math_max_ret = math.max(p7.PetData and (p7.PetData.Level or 1) or 1, 1);
        local v9;

        if math_max_ret >= 100 then
            v9 = u1.NumItemTiers.Pet;
        else
            local v10 = math.floor(math_max_ret / 10) + 1;
            v9 = math.clamp(v10, 1, u1.NumItemTiers.Pet - 1);
        end;

        return `Pet-{p7.PetType}-{(not v8 or v8 == "") and "Normal" or v8}-T{v9}`;
    end;

    if p6 ~= "Holdable" then
        return p6 ~= "TradeBoothSkin" and "Unknown" or `TradeBoothSkin-{p7.SkinID}-T{1}`;
    end;

    local v11 = not p7.Variant and "Normal" or p7.Variant;
    local v12 = MutationHandler:CalcValueMultiFromMuts((MutationHandler:ExtractMutationsFromString(p7.MutationString)));
    local math_clamp_ret = math.clamp(v12, 1, 100000);
    local v13 = math.log10(math_clamp_ret) / 5;
    local math_floor_ret = math.floor(1 + (u1.NumItemTiers.Holdable - 1) * v13 ^ 1.4285714285714286);
    local math_clamp_ret2 = math.clamp(math_floor_ret, 1, u1.NumItemTiers.Holdable);

    return `Holdable-{p7.ItemName}-{v11}-T{math_clamp_ret2}`;
end;

function u1.IsValidItem(p14, p15) -- Line: 137
    -- upvalues: u1 (copy), PetMutationRegistry (copy), MutationHandler (copy), ReplicatedStorage (copy)
    if typeof(p14) ~= "string" or not table.find(u1.ItemTypes, p14) then
        return false;
    end;

    if typeof(p15) ~= "table" then
        return false;
    end;

    if p14 == "Pet" then
        local v16;

        if typeof(p15.PetData) == "table" then
            v16 = p15.PetData.MutationType;
        else
            v16 = nil;
        end;

        local v17;

        if v16 == nil or v16 == "Normal" then
            v17 = true;
        elseif typeof(v16) == "string" then
            v17 = PetMutationRegistry.EnumToPetMutation[v16] ~= nil;
        else
            v17 = false;
        end;

        local v18;

        if typeof(p15.PetData) == "table" then
            v18 = p15.PetData.Level;
        else
            v18 = nil;
        end;

        local v19;

        if v18 == nil then
            v19 = true;
        elseif typeof(v18) == "number" and math.floor(v18) == v18 then
            v19 = math.clamp(v18, 0, 1000) == v18;
        else
            v19 = false;
        end;

        return v17 and v19;
    end;

    if p14 ~= "Holdable" then
        if p14 == "TradeBoothSkin" then
            return require(ReplicatedStorage.Data.TradeBoothSkinRegistry)[p15.SkinID] ~= nil;
        end;

        return false;
    end;

    local v20 = typeof(not p15.Variant and "Normal" or p15.Variant) == "string";
    local v21 = 0;
    local v22 = MutationHandler:ExtractMutationsFromString(p15.MutationString);
    local MutationString = p15.MutationString;

    if MutationString then
        local v23 = MutationString:gsub("%[", ""):gsub("%]", ""):gsub("%s+", "");

        for _ in string.gmatch(v23, "([^,]+)") do
            v21 = v21 + 1;
        end;
    end;

    return v20 and v21 == #v22;
end;

function u1.GetItemData(p24, p25, p26) -- Line: 200
    if p25 == "Holdable" or p25 == "Packaged Seed" then
        local v27 = p24.InventoryData[p26];

        if v27 then
            return v27.ItemData;
        end;
    else
        if p25 == "Pet" then
            return p24.PetsData.PetInventory.Data[p26];
        end;

        if p25 == "TradeBoothSkin" and p24.TradeBoothSkinData.OwnedSkins[p26] then
            return {
                SkinID = p26
            };
        end;
    end;

    return nil;
end;

function u1.GetDefaultItemData(p28, p29) -- Line: 221
    return p28 == "Pet" and {
        PetType = p29,
        PetData = {
            MutationType = "Normal",
            Level = 0,
            LevelProgress = 0,
            Hunger = 0,
            BaseWeight = 1,
            Boosts = {}
        },
        PetAbility = {}
    } or (p28 == "Holdable" and {
        MutationString = "",
        ItemName = p29
    } or (p28 == "TradeBoothSkin" and {
        SkinID = p29
    } or nil));
end;

return u1;