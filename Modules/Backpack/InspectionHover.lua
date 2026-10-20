-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local ItemNameFinder = require(ReplicatedStorage.Modules.ItemNameFinder);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local ItemDescriptionFinder = require(ReplicatedStorage.Modules.ItemDescriptionFinder);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local ReversedItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ReversedItemTypeEnums);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local PetTraitsData = require(ReplicatedStorage.Modules.PetTraitsData);
local GearUtil = require(ReplicatedStorage.Modules.GearUtil);
local FoodService = require(ReplicatedStorage.Modules.FoodService);
local GearData = require(ReplicatedStorage.Data.GearData);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local VariantsEnums = require(ReplicatedStorage.Data.EnumRegistry.VariantsEnums);
local BeeEggRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry);
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local ItemTypeOverride = require(ReplicatedStorage.Modules.ItemTypeOverride);
local u1 = {};
local u2 = false;
local u3 = {};

local function safeCall(p4, ...) -- Line: 33
    local success, result = pcall(p4, ...);

    if success then
        return result;
    end;

    return nil;
end;

local function getStringValue(p5: userdata, p6: string) -- Line: 41
    local v7 = p5:FindFirstChild(p6);

    if v7 and v7:IsA("StringValue") then
        return v7.Value;
    end;

    return nil;
end;

local function getToolUUID(p8: userdata) -- Line: 49
    -- upvalues: InventoryServiceEnums (copy)
    return p8:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (p8:GetAttribute("PET_UUID") or p8:GetAttribute("UUID"));
end;

local u9 = {
    ["Small Pet Toy"] = "Small Toy",
    ["Medium Pet Toy"] = "Medium Toy",
    ["Large Pet Toy"] = "Large Toy",
    ["Small Passive Boost"] = "Small Toy",
    ["Medium Passive Boost"] = "Medium Toy",
    ["Large Passive Boost"] = "Large Toy",
    ["Small XP Boost"] = "Small Treat",
    ["Medium XP Boost"] = "Medium Treat",
    ["Large XP Boost"] = "Smith Treat"
};

local function cleanToolDisplayName(p10) -- Line: 69
    -- upvalues: u9 (copy)
    if typeof(p10) ~= "string" or p10 == "" then
        return nil;
    end;

    local v11 = p10:match("^%s*(.-)%s*$");
    local v12 = nil;

    while v11 ~= v12 do
        local v13 = v11:gsub("%s*%b[]%s*$", ""):gsub("%s*[xX×]%s*[%d,]+%s*$", ""):gsub("%s*%(%s*[xX×]%s*[%d,]+%s*%)%s*$", ""):match("^%s*(.-)%s*$");
        v12 = v11;
        v11 = v13;
    end;

    if v11 == "" then
        return nil;
    end;

    return u9[v11] or v11;
end;

local function formatMutationStringForDisplay(p14) -- Line: 99
    if typeof(p14) ~= "table" then
        if p14 == nil or p14 == "" then
            return nil;
        end;

        return tostring(p14):gsub("_", " ");
    end;

    local v15 = {};

    for _, v in p14 do
        local v16 = tostring(v);
        table.insert(v15, v16:gsub("_", " "));
    end;

    return table.concat(v15, ", ");
end;

local function stripSeedSuffixForLookup(p17: string) -- Line: 117
    return p17:gsub("%s+[Ss]eed%s*$", "");
end;

local function ensureSeedSuffix(p18: string) -- Line: 121
    local v19 = p18:match("^%s*(.-)%s*$");

    if v19:lower():match("%sseed$") then
        return v19;
    end;

    return `{v19} Seed`;
end;

local u20 = {
    ["Small Pet Treat"] = "Small Treat",
    ["Medium Pet Treat"] = "Medium Treat",
    ["Large Pet Treat"] = "Smith Treat",
    ["Small Pet Toy"] = "Small Toy",
    ["Medium Pet Toy"] = "Medium Toy",
    ["Large Pet Toy"] = "Large Toy",
    ["Mutation Sprays"] = "Mutation Spray",
    ["Trade Sign"] = "Booth Sign"
};

local function normalizeLookupName(p21) -- Line: 144
    -- upvalues: cleanToolDisplayName (copy)
    local v22 = cleanToolDisplayName(p21);

    if v22 then
        return v22:gsub("%s+", ""):lower();
    end;

    return nil;
end;

local function resolveGearKey(p23) -- Line: 153
    -- upvalues: cleanToolDisplayName (copy), GearData (copy), u20 (copy)
    local v24 = cleanToolDisplayName(p23);

    if not v24 then
        return nil;
    end;

    if GearData[v24] then
        return v24;
    end;

    local v25 = u20[v24];

    if v25 and GearData[v25] then
        return v25;
    end;

    if v24:sub(-1) == "s" then
        local v26 = v24:sub(1, -2);

        if GearData[v26] then
            return v26;
        end;
    end;

    local v27 = cleanToolDisplayName(v24);
    local v28;

    if v27 then
        v28 = v27:gsub("%s+", ""):lower();
    else
        v28 = nil;
    end;

    for i, v in GearData do
        if typeof(v) == "table" then
            local v29 = cleanToolDisplayName(i);
            local v30;

            if v29 then
                v30 = v29:gsub("%s+", ""):lower();
            else
                v30 = nil;
            end;

            if v30 == v28 then
                return i;
            end;

            local v31 = cleanToolDisplayName(v.GearName);
            local v32;

            if v31 then
                v32 = v31:gsub("%s+", ""):lower();
            else
                v32 = nil;
            end;

            if v32 == v28 then
                return i;
            end;

            local v33 = cleanToolDisplayName(v.DisplayName);
            local v34;

            if v33 then
                v34 = v33:gsub("%s+", ""):lower();
            else
                v34 = nil;
            end;

            if v34 == v28 then
                return i;
            end;

            local v35 = cleanToolDisplayName(v.Name);
            local v36;

            if v35 then
                v36 = v35:gsub("%s+", ""):lower();
            else
                v36 = nil;
            end;

            if v36 == v28 then
                return i;
            end;
        end;
    end;

    return nil;
end;

local function addCandidate(p37: table, p38: any) -- Line: 207
    -- upvalues: cleanToolDisplayName (copy)
    local v39 = cleanToolDisplayName(p38);

    if not v39 then
        return;
    end;

    if not table.find(p37, v39) then
        table.insert(p37, v39);
    end;
end;

local function stripVariantFromName(p40: string) -- Line: 218
    -- upvalues: SeedData (copy), VariantsEnums (copy)
    if SeedData[p40] then
        return p40;
    end;

    for i, _ in VariantsEnums do
        p40 = p40:gsub(`{i} `, "");
    end;

    return p40;
end;

local function resolveGearKeyFromCandidates(p41: table) -- Line: 230
    -- upvalues: resolveGearKey (copy)
    for _, v in p41 do
        local v42 = resolveGearKey(v);

        if v42 then
            return v42;
        end;
    end;

    return nil;
end;

local function resolveSeedTypeFromTraits(p43: string) -- Line: 241
    -- upvalues: PlantTraitsData (copy)
    return PlantTraitsData.HasTrait(p43, "Honey") and "Honey Seed" or (PlantTraitsData.HasTrait(p43, "Easter") and "Easter Seed" or "Seed");
end;

local function resolveFinderArgs(p44: userdata, p45: any) -- Line: 250
    -- upvalues: InventoryServiceEnums (copy), ReversedItemTypeEnums (copy), cleanToolDisplayName (copy), stripVariantFromName (copy), resolveGearKey (copy), GearUtil (copy)
    local v46 = p44:GetAttribute(InventoryServiceEnums.ITEM_TYPE) or p44:GetAttribute("ItemType");
    local v47 = ReversedItemTypeEnums[v46] or v46;
    local v48 = p45.Value or (p45.ItemName or p45.Name) or (p44:GetAttribute(InventoryServiceEnums.ItemName) or p44:GetAttribute("ItemName") or (p44:GetAttribute("Value") or p44:GetAttribute("Seed")));

    if not v48 then
        local Item_String = p44:FindFirstChild("Item_String");
        local v49;

        if Item_String and Item_String:IsA("StringValue") then
            v49 = Item_String.Value;
        else
            v49 = nil;
        end;

        v48 = v49 or p44.Name;
    end;

    local v50 = cleanToolDisplayName(v48) or tostring(v48);
    local v51 = cleanToolDisplayName(p44.Name);

    if p44:GetAttribute("PET_UUID") then
        return v50, "Pet";
    end;

    if v47 == "PetEgg" or v47 == "Egg" then
        return v50, "PetEgg";
    end;

    if v47 == "CosmeticCrate" or v47 == "Crate" then
        return v50, "CosmeticCrate";
    end;

    if v47 == "Food" then
        return v50, "Food";
    end;

    if v47 == "Seed" then
        local v52 = (v51 or v50):match("^%s*(.-)%s*$");

        if not v52:lower():match("%sseed$") then
            v52 = `{v52} Seed`;
        end;

        return stripVariantFromName((v52:gsub("%s+[Ss]eed%s*$", ""))), "Seed", v52;
    end;

    if v47 == "Holdable" or v47 == "Fruit" then
        return v50, tostring(v47);
    end;

    if v47 == "Seed Pack" then
        return p45.Type or v50, tostring(v47);
    end;

    local v53 = v50 == "Bee Shard" and p44:GetAttribute(InventoryServiceEnums.EnchantmentType);

    if v53 then
        return v53, "Bee Shard";
    end;

    local v54 = {};
    local v55 = cleanToolDisplayName(p45.ItemName);

    if v55 and not table.find(v54, v55) then
        table.insert(v54, v55);
    end;

    local v56 = cleanToolDisplayName(p45.Value);

    if v56 and not table.find(v54, v56) then
        table.insert(v54, v56);
    end;

    local v57 = cleanToolDisplayName(p45.Name);

    if v57 and not table.find(v54, v57) then
        table.insert(v54, v57);
    end;

    local v58 = cleanToolDisplayName((p44:GetAttribute(InventoryServiceEnums.ItemName)));

    if v58 and not table.find(v54, v58) then
        table.insert(v54, v58);
    end;

    local v59 = cleanToolDisplayName((p44:GetAttribute("ItemName")));

    if v59 and not table.find(v54, v59) then
        table.insert(v54, v59);
    end;

    local v60 = cleanToolDisplayName((p44:GetAttribute("Value")));

    if v60 and not table.find(v54, v60) then
        table.insert(v54, v60);
    end;

    local v61 = cleanToolDisplayName((p44:GetAttribute("ItemType")));

    if v61 and not table.find(v54, v61) then
        table.insert(v54, v61);
    end;

    if p44:GetAttribute(InventoryServiceEnums.ShardType) then
        local v62 = cleanToolDisplayName((`{p44:GetAttribute(InventoryServiceEnums.ShardType)} {p44:GetAttribute(InventoryServiceEnums.ShardMutationName)}`));

        if v62 and not table.find(v54, v62) then
            table.insert(v54, v62);
        end;
    end;

    if p44:GetAttribute(InventoryServiceEnums.SprayType) then
        local v63 = cleanToolDisplayName((`{p44:GetAttribute(InventoryServiceEnums.SprayType)} {p44:GetAttribute(InventoryServiceEnums.SprayMutationName)}`));

        if v63 and not table.find(v54, v63) then
            table.insert(v54, v63);
        end;
    end;

    local v64 = cleanToolDisplayName(v50);

    if v64 and not table.find(v54, v64) then
        table.insert(v54, v64);
    end;

    local v65 = cleanToolDisplayName(p44.Name);

    if v65 and not table.find(v54, v65) then
        table.insert(v54, v65);
    end;

    local v66 = cleanToolDisplayName(v47);

    if v66 and not table.find(v54, v66) then
        table.insert(v54, v66);
    end;

    local v67;

    for _, v in v54 do
        v67 = resolveGearKey(v);

        if v67 then
            break;
        end;
    end;

    if v67 then
        return v67, "Gear";
    end;

    if v47 and GearUtil.IsItemTypeGear((tostring(v47))) then
        return v50, tostring(v47);
    end;

    return tostring(v48), tostring(v47 or "Gear");
end;

local function getFoodRarity(p68: userdata, p69: any) -- Line: 356
    -- upvalues: InventoryServiceEnums (copy), FoodService (copy)
    if typeof(p69) ~= "table" then
        return nil;
    end;

    local u70 = p68:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (p68:GetAttribute("PET_UUID") or p68:GetAttribute("UUID"));
    local u71 = {
        ItemType = "Food",
        ItemData = p69
    };
    local success, result = pcall(function() -- Line: 368
        -- upvalues: FoodService (ref), u70 (copy), u71 (copy)
        return FoodService:CalculateFoodRarityString(u70 or "", u71);
    end);

    if success and (result and result ~= "") then
        return result;
    end;

    return nil;
end;

local function SplitWordWithSpace(p72: string) -- Line: 379
    if #string.split(p72, " ") > 1 then
        return p72;
    end;

    return p72:gsub("(%u%l*)", function(p73) -- Line: 385
        return p73 .. " ";
    end):match("^%s*(.-)%s*$");
end;

local function buildInfo(u74: userdata) -- Line: 390
    -- upvalues: safeCall (copy), InventoryService (copy), resolveFinderArgs (copy), ItemNameFinder (copy), ItemDescriptionFinder (copy), ItemImageFinder (copy), ItemRarityFinder (copy), formatMutationStringForDisplay (copy), GearUtil (copy), BeeEggRegistry (copy), PlantTraitsData (copy), ItemTypeOverride (copy), SplitWordWithSpace (copy), InventoryServiceEnums (copy), MutationHandler (copy), GearData (copy), getFoodRarity (copy), Calculate_Weight (copy), NumberUtil (copy), PetsService (copy), PetMutationRegistry (copy), PetUtilities (copy), PetTraitsData (copy)
    local v75 = safeCall(function() -- Line: 391
        -- upvalues: InventoryService (ref), u74 (copy)
        return InventoryService:GetToolData(u74);
    end);
    local v76 = not (v75 and v75.ItemData) and {} or v75.ItemData;
    local v77, v78, v79 = resolveFinderArgs(u74, v76);
    local v80 = v79 or (safeCall(ItemNameFinder, v77, v78) or u74.Name);
    local v81 = safeCall(ItemDescriptionFinder, v77, v78) or (u74.ToolTip or "");
    local v82 = safeCall(ItemImageFinder, v77, v78) or (u74.TextureId or "");
    local v83 = safeCall(ItemRarityFinder, v77, v78);

    if (not v82 or v82 == "") and (u74.TextureId and u74.TextureId ~= "") then
        v82 = u74.TextureId;
    end;

    local v84 = formatMutationStringForDisplay(v76.MutationString or u74:GetAttribute("MutationString") or (u74:GetAttribute("Mutations") or v76.Mutations));
    local v85 = GearUtil.IsItemTypeGear(v78) and "Gear" or v78;
    local v86 = BeeEggRegistry.Entries[v77] and "Bee Egg" or (v85 == "Holdable" and "Plant" or v85);
    local v87 = v86 == "Seed" and (PlantTraitsData.HasTrait(v77, "Honey") and "Honey Seed" or (PlantTraitsData.HasTrait(v77, "Easter") and "Easter Seed" or "Seed")) or v86;

    if ItemTypeOverride[v80] then
        v87 = ItemTypeOverride[v80];
    end;

    local v88 = v81:match("%S") == nil and v87 == "Gear" and (u74.ToolTip or "") or v81;
    local v89 = {
        Type = `{SplitWordWithSpace(v87)}`
    };
    local v90 = u74:GetAttribute(InventoryServiceEnums.SprayMutationName) or v76.SprayMutationName;

    if v90 then
        local v91 = MutationHandler:GetMutations()[v90];
        local v92;

        if v91 then
            v92 = v91.DisplayName or (v91.Name or v90);
        else
            v92 = v90;
        end;

        v89.Mutation = v92;
        local v93 = GearData[`Mutation Spray {v90}`];

        if v93 and v93.GearRarity then
            v89.Rarity = v93.GearRarity;
        end;
    end;

    if v78 == "Food" then
        local v94 = getFoodRarity(u74, v76);

        if v94 then
            v89.Rarity = v94;
        end;

        if v84 and v84 ~= "" then
            v89.PlantMutations = string.split(v84, ", ");
        end;

        if u74:GetAttribute("Weight") then
            v89.Weight = `{u74:GetAttribute("Weight")}kg`;
        end;

        if v76.Ingredients then
            v89.FoodIngredients = {};

            for _, v in v76.Ingredients do
                table.insert(v89.FoodIngredients, v.ItemData.ItemName);
            end;
        end;
    else
        if v83 and v87 ~= "Seed Pack" then
            v89.Rarity = v83;
        end;

        local v95 = v76.Quantity or u74:GetAttribute("Quantity");

        if v95 then
            v89.Quantity = v95;
        end;

        local v96 = v76.Uses or (u74:GetAttribute(InventoryServiceEnums.Uses) or u74:GetAttribute("Uses"));

        if v96 then
            v89.Uses = v96;
        end;

        local v97 = v76.Variant or u74:GetAttribute("Variant");

        if v97 then
            v89.Variant = v97;
        end;

        if v84 and v84 ~= "" then
            local MutationsAsString = MutationHandler:GetMutationsAsString(u74);
            v89.PlantMutations = string.split(MutationsAsString, ", ");
        end;

        if v76.Seed then
            local v98 = Calculate_Weight.Calculate_Weight(v76.Seed, v76.ItemName) * v76.WeightMultiplier;
            v89.Weight = `{NumberUtil.RoundToDP(v98, 2)}kg`;
        end;
    end;

    if v78 == "Pet" then
        local PlayerPetData = PetsService:GetPlayerPetData(u74:GetAttribute("PET_UUID") or "");
        local v99;

        if PlayerPetData then
            v99 = PlayerPetData.PetData;
        else
            v99 = PlayerPetData;
        end;

        if v99 then
            if v99.Level then
                v89.Age = v99.Level;
            end;

            if v99.Hunger then
                v89.Hunger = v99.Hunger;
            end;

            if v99.MutationType then
                v89.PetMutation = PetMutationRegistry.EnumToPetMutation[v99.MutationType];
            end;

            local v100 = tonumber(v99.BaseWeight or PlayerPetData.BaseWeight);
            local v101 = tonumber(v99.Level) or 1;
            local PetType = PlayerPetData.PetType;

            if v100 and PetType then
                local v102 = PetUtilities:CalculateWeight(v100, v101, PetType);
                v89.Weight = `{NumberUtil.RoundToDP(v102, 2)}kg`;
            end;

            local TraitsAsString = PetTraitsData.GetTraitsAsString(PlayerPetData.PetType);
            v89.Traits = string.split(TraitsAsString, ", ");
        end;
    end;

    local v103;

    if typeof(v88) == "string" then
        v103 = v88:match("%S") ~= nil;
    else
        v103 = false;
    end;

    return {
        DisplayName = v80,
        Description = v103 and v88 and v88 or "",
        ItemImage = v82,
        Properties = v89,
        DetailsOnly = not v103
    };
end;

function u1.Clear(p104) -- Line: 549
    -- upvalues: u3 (copy), ItemInfoHover (copy)
    for i in u3 do
        ItemInfoHover:RemoveItemFromData(i);
    end;

    table.clear(u3);

    for _, v in p104 do
        if v and v.Frame then
            v.Frame:RemoveTag("ItemInfoHoverTag");
            v.Frame:SetAttribute("UUID", nil);
        end;
    end;
end;

local u105 = false;
local u106 = nil;
local u107 = nil;

local function DoRefresh(p108: any, p109: boolean?) -- Line: 567
    -- upvalues: u1 (copy), u2 (ref), InventoryServiceEnums (copy), buildInfo (copy), ItemInfoHover (copy), u3 (copy)
    u1.Clear(p108);

    if not u2 then
        return;
    end;

    if not p109 then
        return;
    end;

    for _, v in p108 do
        if v and (v.Frame and (v.Tool and v.Frame.Visible ~= false)) then
            local Tool = v.Tool;
            local v110 = Tool:GetAttribute(InventoryServiceEnums.ITEM_UUID) or (Tool:GetAttribute("PET_UUID") or Tool:GetAttribute("UUID"));

            if v110 then
                local v111 = "BackpackInspection_" .. tostring(v110);
                local v112 = buildInfo(v.Tool);

                if v112 then
                    ItemInfoHover:AddItemToData(v111, v112);
                    u3[v111] = true;
                    v.Frame:AddTag("ItemInfoHoverTag");
                    v.Frame:SetAttribute("UUID", v111);
                end;
            end;
        end;
    end;
end;

function u1.Refresh(p113: any, p114: boolean?) -- Line: 609
    -- upvalues: u106 (ref), u107 (ref), u105 (ref), DoRefresh (copy)
    u106 = p113;
    u107 = p114;

    if u105 then
        return;
    end;

    u105 = true;
    task.defer(function() -- Line: 618
        -- upvalues: u105 (ref), u106 (ref), u107 (ref), DoRefresh (ref)
        u105 = false;
        local v115 = u106;
        u106 = nil;
        DoRefresh(v115, u107);
    end);
end;

function u1.SetActive(p116: boolean, p117: any, p118: boolean?) -- Line: 629
    -- upvalues: u2 (ref), u1 (copy)
    u2 = p116;
    u1.Refresh(p117, p118);
end;

return u1;