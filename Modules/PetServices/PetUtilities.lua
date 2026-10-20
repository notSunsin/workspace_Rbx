-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local ServerScriptService = game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local VFX = ReplicatedStorage.Assets.VFX;
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local FoodService = require(ReplicatedStorage.Modules.FoodService);
require(ReplicatedStorage.Modules.PetTraitsData);
local DisplayNameSanitizer = require(ReplicatedStorage.Modules.DisplayNameSanitizer);
require(ReplicatedStorage.Modules.ReplicationClass.DeepClone);
local SpottedEffect = VFX.SpottedEffect;
local PetConfig = PetRegistry.PetConfig;
local PetList = PetRegistry.PetList;
local PetEggs = PetRegistry.PetEggs;
local PassiveRegistry = PetRegistry.PassiveRegistry;
local XP_CONFIG = PetConfig.XP_CONFIG;
local _ = XP_CONFIG.XP_EXPONENTIAL;
local HUNGER_PER_WEIGHT = PetConfig.PET_FEEDING_CONFIG.HUNGER_PER_WEIGHT;
local SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL = PetConfig.WEIGHT_CONFIG.SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL;
local ExponentialScaler = require(ReplicatedStorage.Modules.ExponentialScaler);
local DecimalNumberFormat = require(ReplicatedStorage.Data.DecimalNumberFormat);
local DeepClone = require(ReplicatedStorage.Modules.ReplicationClass.DeepClone);
local u1 = ExponentialScaler.new({
    BaseCost = XP_CONFIG.XP_BASE_COST,
    ScalingFactor = XP_CONFIG.XP_EXPONENTIAL
});
local u2 = 0;

for i = 1, XP_CONFIG.MAX_LEVEL do
    u2 = u2 + u1:GetCost(i);
    local _ = i;
end;

local u5 = {
    GetCurrentLevelXPCost = function(p3, p4) -- Line: 53, Name: GetCurrentLevelXPCost
        -- upvalues: u1 (copy)
        return u1:GetCost(p4);
    end
};
local u6 = {
    ["Tiny Bird"] = true,
    ["Muddy Excavator"] = true,
    ["Fall Express"] = true,
    ["Mighty Bear"] = true,
    ["Wise Shopper"] = true,
    ["Prince of Fall"] = true,
    ["Swan Song"] = true,
    ["Bird of Grace"] = true,
    ["Squirrel Support"] = true,
    ["Harvest Stash"] = true,
    ["Whack-A-Marmot"] = true,
    ["Sugar Gliding"] = true,
    ["A Space Odd-Nut-sy"] = true,
    ["Salmon School"] = true,
    Woodpecking = true,
    Southbound = true,
    ["Adorable Haggler"] = true,
    Grounded = true
};
local u7 = {
    ["Snow-munition"] = true,
    ["Icy Fortifications"] = true,
    ["Arctic Scoundrel"] = true,
    ["Glacial Dragon"] = true,
    ["Frost Diety"] = true,
    ["GIANT Snow-munition"] = true,
    ["GIANT Icy Fortifications"] = true,
    ["Rainbow Arctic Scoundrel"] = true,
    ["Rainbow Glacial Dragon"] = true,
    ["Rainbow Frost Diety"] = true,
    ["Gift Wrat"] = true,
    ["Belly Slide"] = true,
    ["Christmas Carrot"] = true,
    ["Christmas Hen"] = true,
    ["Cold Belly"] = true,
    ["Jolly Croak"] = true,
    ["Coal Sack"] = true,
    ["Christmas Dove"] = true,
    ["Sleigh Synergy"] = true,
    ["Beast of Snow"] = true,
    Nutcracker = true,
    ["Yeti Night"] = true,
    ["Cold Gears"] = true,
    ["Festive Christmas Dove"] = true,
    ["Festive Sleigh Synergy"] = true,
    ["Festive Beast of Snow"] = true,
    ["Festive Nutcracker"] = true,
    ["Festive Yeti Night"] = true,
    ["Festive Cold Gears"] = true,
    ["Pine Beetle Duel"] = true,
    Eggnoginator = true,
    ["Cocoa Nap"] = true,
    ["Red-Nosed Reindeer"] = true,
    ["Shiny Nose"] = true,
    ["Yellow Christmas"] = true,
    ["Christmas Partridge"] = true,
    ["Merry Beary"] = true,
    ["Christmas Support"] = true,
    ["FREEZE!"] = true,
    ["Gnawing Hunger"] = true
};

function u5.GetCurrentLevelState(p8: table, p9: number, p10: string, p11: userdata, p12: string) -- Line: 143
    -- upvalues: PassiveRegistry (copy), RunService (copy), ReplicatedStorage (copy), Players (copy), ServerScriptService (copy), u6 (copy), u7 (copy)
    local v13 = PassiveRegistry[p10];

    if not v13 then
        warn("Could not find passive", p10);

        return {};
    end;

    local v14, v15, v16;

    if RunService:IsClient() then
        v14 = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
        v15 = require(ReplicatedStorage.Modules.Gears.BonfireClientService);
        v16 = require(ReplicatedStorage.Modules.Gears.YuleLogClientService);

        if p11 == nil then
            p11 = Players.LocalPlayer or p11;
        end;
    else
        v14 = require(ServerScriptService.Modules.PetsServices.ActivePetsService);
        v15 = require(ServerScriptService.Modules.Gears.BonfireService);
        v16 = require(ServerScriptService.Modules.Gears.GenericGearService.Placeables.YuleLogHandler);
    end;

    local v17 = 0;

    if p11 then
        local Attribute = p11:GetAttribute("PetPassiveBonus");

        if typeof(Attribute) == "number" then
            v17 = math.min(Attribute, 30);
        end;

        local Attribute2 = p11:GetAttribute("SprinklerPetBoost");

        if typeof(Attribute2) == "number" then
            v17 = v17 + Attribute2;
        end;

        if u6[p10] then
            local Boost = v15:GetBoost(p11);

            if Boost then
                v17 = v17 + Boost.Pet;
            end;
        end;

        if u7[p10] then
            local Boost = v16:GetBoost(p11);

            if Boost then
                v17 = v17 + Boost.Pet;
            end;
        end;
    end;

    local v18 = {};

    for i, v in v13.States do
        local Base = v.Base;
        local v19 = v14:CalculateBoost(p11, p12, "PASSIVE_BOOST");

        if i == "Cooldown" then
            if v19 >= 0.06 then
                Base = Base - v.Base * (v19 - 1);
            end;
        else
            local v20 = v19 - 1;

            if p10 == "The Reins of Ruin" or (p10 == "The Ghostly Reins of Ruin" or (p10 == "Jumbo Blessing" or (p10 == "Rainbow Jumbo Blessing" or (p10 == "Reins of Destruction" or p10 == "Ghostly Reins of Destruction")))) then
                if v.Scale <= 0 then
                    Base = Base - v.Base * v20;
                else
                    Base = Base + v.Base * v20;
                end;
            else
                Base = Base + v.Base * v20;
            end;
        end;

        local v21 = p9 + v17;

        if v21 > 100 then
            if v21 <= 120 then
                v21 = (v21 - 100) * 0.25 + 100;
            else
                v21 = (v21 - 120) * 0.1 + 105;
            end;
        end;

        local v22 = Base + v.Scale * v21;

        if v.Min and v.Max then
            v22 = math.clamp(v22, v.Min, v.Max);
        elseif v.Min then
            v22 = math.max(v22, v.Min);
        elseif v.Max then
            v22 = math.min(v22, v.Max);
        end;

        v18[i] = v22;
    end;

    return v18;
end;

local u27 = {
    ColonTime = function(p23) -- Line: 256
        -- upvalues: TimeHelper (copy)
        return TimeHelper:GenerateColonFormatFromTime(p23);
    end,

    Percentage = function(p24) -- Line: 259
        return string.format("%.2f", p24 * 100);
    end,

    NoPrecision = function(p25) -- Line: 262
        local v26 = math.floor(p25 * 1000) / 1000;

        return string.format("%.3f", v26);
    end
};

function u5.GetPassiveString(p28: table, p29: number, p30: string, p31: userdata?, p32: string?) -- Line: 268
    -- upvalues: u5 (copy), PassiveRegistry (copy), u27 (copy), DecimalNumberFormat (copy)
    local CurrentLevelState = u5:GetCurrentLevelState(p29, p30, p31, p32);
    local v33 = PassiveRegistry[p30];
    local Description = v33.Description;
    local States = v33.States;

    for i, v in CurrentLevelState do
        local v34 = u27[States[i].Formatter];
        local v35 = v34 and v34(v) or tostring(DecimalNumberFormat(v));
        Description = Description:gsub(`<{i}>`, v35);
    end;

    return Description;
end;

function u5.FindLocalPetModel(p36: table, p37: string) -- Line: 289
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged("PetModel") do
        if v.Name == p37 then
            return v;
        end;
    end;

    return nil;
end;

function u5.GetFoodWorthForAnimal(p38: table, p39: any, p40: userdata, p41: any) -- Line: 299
    -- upvalues: PetList (copy), InventoryServiceEnums (copy), FoodService (copy), HUNGER_PER_WEIGHT (copy)
    local HungerFruitMultipliers = PetList[p39].HungerFruitMultipliers;
    p40:GetAttribute(InventoryServiceEnums.ItemName);
    local v42 = HungerFruitMultipliers[p40] or 1;

    return FoodService:CalculateFoodValue(p40:GetAttribute(InventoryServiceEnums.ITEM_UUID), p41) * HUNGER_PER_WEIGHT * v42;
end;

function u5.GetFruitWorthForAnimal(p43: table, p44: any, p45: userdata) -- Line: 312
    -- upvalues: PetList (copy), InventoryServiceEnums (copy), CalculatePlantValue (copy), HUNGER_PER_WEIGHT (copy)
    local v46 = PetList[p44].HungerFruitMultipliers[p45:GetAttribute(InventoryServiceEnums.ItemName)] or 1;

    return CalculatePlantValue(p45) * HUNGER_PER_WEIGHT * v46;
end;

function u5.GetFruitWorthPercentageForAnimal(p47: table, p48: any, p49: userdata) -- Line: 324
    -- upvalues: u5 (copy), PetList (copy)
    return u5:GetFruitWorthForAnimal(p48, p49) / PetList[p48].DefaultHunger;
end;

function u5.NormalizeOdds(p50, p51) -- Line: 333
    local Items = p51.Items;
    local v52 = 0;

    for _, v in Items do
        v52 = v52 + v.ItemOdd;
    end;

    for i, v in Items do
        v.NormalizedOdd = v.ItemOdd / v52 * 100;
        v.Name = i;
    end;

    p51.TotalOdds = v52;

    return p51;
end;

function u5.CalculateWeight(p53, p54, p55, p56) -- Line: 352
    -- upvalues: SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL (copy)
    if p56 == "Chubby Chipmunk" then
        return p54;
    end;

    return p54 + p54 * SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL * p55;
end;

function u5.GetLevelProgress(p57: table, p58: number) -- Line: 365
    -- upvalues: u1 (copy), u2 (ref)
    if not p58 then
        warn("PetUtilities:GetLevelProgress | No Level!");

        return 0;
    end;

    local v59 = 0;

    for i = 1, p58 do
        v59 = v59 + u1:GetCost(i);
        local _ = i;
    end;

    return v59 / u2;
end;

for _, v in PetEggs do
    v.Color = v.Color or Color3.fromRGB(255, 252, 252);
    v.HatchTime = v.HatchTime or 6;
    v.RarityData = v.RarityData or {
        Items = {}
    };
    u5:NormalizeOdds(v.RarityData);
end;

function u5.CalcBoostTotal(p60: table, p61: number, p62: number) -- Line: 392
    local math_clamp_ret = math.clamp(p61, 0, 100);
    local math_clamp_ret2 = math.clamp(p62, 0, 100);

    return math.clamp(math_clamp_ret + (100 - math_clamp_ret) / 100 * math_clamp_ret2, 0, 100);
end;

function u5.GetBoostedRarityData(p63: table, p64: table, p65: number) -- Line: 404
    -- upvalues: DeepClone (copy)
    local v66 = DeepClone(p64);

    if p65 <= 0 then
        return v66;
    end;

    local v67 = 0;

    for _ in v66.Items do
        v67 = v67 + 1;
    end;

    local v68 = 1 / v67 * 100;
    local math_clamp_ret = math.clamp(p65 / 100, 0, 1);

    for _, v in v66.Items do
        local math_lerp_ret = math.lerp(v.NormalizedOdd, v68, math_clamp_ret);
        local math_clamp_ret2 = math.clamp(math_lerp_ret, 0, 100);
        v.NormalizedOdd = math_clamp_ret2;
        v.ItemOdd = math_clamp_ret2;
    end;

    return v66;
end;

function u5.GetRandomPet(p69: table, u70: table, p71: userdata?, p72: number?) -- Line: 430
    -- upvalues: u5 (copy)
    if not p71 then
        warn("PetUtilities:GetRandomPet | RandomObject was not passed, replacing with random Random object!");
    end;

    local v73 = p71 or Random.new();

    if not (u70 and (u70.TotalOdds and u70.Items)) then
        return warn("GetRandomPet | RarityData is nil or invalid!");
    end;

    local BoostedRarityData = u5:GetBoostedRarityData(u70, p72 or 0);
    local TotalOdds = BoostedRarityData.TotalOdds;
    local Items = BoostedRarityData.Items;
    local v74 = v73:NextNumber() * TotalOdds;
    local v75 = {};

    for i, _ in Items do
        table.insert(v75, i);
    end;

    table.sort(v75, function(p76, p77) -- Line: 452
        -- upvalues: u70 (copy)
        local v78 = u70.Items[p76];
        local v79 = u70.Items[p77];

        if v78.ItemOdd == v79.ItemOdd then
            return p77 < p76;
        end;

        return v78.ItemOdd > v79.ItemOdd;
    end);
    local v80 = 0;

    for _, v in v75 do
        local v81 = Items[v];

        if v81 then
            v80 = v80 + v81.ItemOdd;

            if v80 >= v74 then
                return v81;
            end;
        else
            warn((`No item data found for key: {v}`));
        end;
    end;
end;

function u5.GetLookAt(p82, p83, p84) -- Line: 478
    return CFrame.new(p83, (Vector3.new(p84.X, p83.Y, p84.Z)));
end;

function u5.GetGeneratedEclipsePositions(p85: table, p86: table) -- Line: 482
    local TargetCFrame = p86.TargetCFrame;

    if not TargetCFrame then
        return warn("GetGeneratedEclipsePositions: There is no TargetCFrame in Config:", p86, debug.traceback());
    end;

    local TotalPositions = p86.TotalPositions;

    if not TotalPositions then
        return warn("GetGeneratedEclipsePositions: There is no TotalPositions in Config:", p86, debug.traceback());
    end;

    local v87 = p86.StartingRowAmount or 5;
    local v88 = p86.RadiusIncrementX or 3;
    local v89 = p86.RadiusIncrementZ or 3;
    local v90 = p86.Angle or 0.39269908169872414;
    local v91 = {};
    local v92 = 1;

    while #v91 < TotalPositions do
        local math_min_ret = math.min(v87, TotalPositions - #v91);
        local v93 = math_min_ret == 1 and 0 or v90 * (math_min_ret - 1) / 2;

        for i = 1, math_min_ret do
            local v94 = v90 * (i - 1) - v93;
            local v95 = math.sin(v94) * v92 * v88;
            local v96 = math.cos(v94) * v92 * v89;
            local Position = (TargetCFrame * CFrame.new(v95, 0, v96)).Position;
            table.insert(v91, Position);
            local _ = i;
        end;

        v92 = v92 + 1;
        v87 = v87 + 1;
    end;

    return v91;
end;

function u5.GetPetsSortedByAge(p97: table, p98: userdata, p99: number, p100: boolean, p101: boolean) -- Line: 523
    -- upvalues: RunService (copy), ServerScriptService (copy), DeepClone (copy), ReplicatedStorage (copy)
    local v102 = p100 or false;
    local v103 = p101 or false;
    local v104 = p99 or 0;

    if RunService:IsServer() then
        local PlayerDataAsync = require(ServerScriptService.Modules.DataService):GetPlayerDataAsync(p98);

        if not PlayerDataAsync then
            return;
        end;

        local EquippedPets = PlayerDataAsync.PetsData.EquippedPets;
        local v105 = {};

        for i, v in PlayerDataAsync.PetsData.PetInventory.Data do
            if v.PetData.Level >= v104 then
                local v106;

                if v103 then
                    if table.find(EquippedPets, i) then
                        v106 = DeepClone(v);
                        v106.UUID = i;
                        table.insert(v105, v106);
                    end;
                elseif not (v102 and table.find(EquippedPets, i)) then
                    v106 = DeepClone(v);
                    v106.UUID = i;
                    table.insert(v105, v106);
                end;
            end;
        end;

        table.sort(v105, function(p107, p108) -- Line: 555
            return p107.PetData.Level > p108.PetData.Level;
        end);

        return v105;
    end;

    if not RunService:IsClient() then
        return;
    end;

    local PlayerDatastorePetData = require(ReplicatedStorage.Modules.PetServices.ActivePetsService):GetPlayerDatastorePetData(p98.Name);
    local EquippedPets = PlayerDatastorePetData.EquippedPets;
    local v109 = {};

    for i, v in PlayerDatastorePetData.PetInventory.Data do
        if v.PetData.Level >= v104 then
            local v110;

            if v103 then
                if table.find(EquippedPets, i) then
                    v110 = DeepClone(v);
                    v110.UUID = i;
                    table.insert(v109, v110);
                end;
            elseif not (v102 and table.find(EquippedPets, i)) then
                v110 = DeepClone(v);
                v110.UUID = i;
                table.insert(v109, v110);
            end;
        end;
    end;

    table.sort(v109, function(p111, p112) -- Line: 587
        return p111.PetData.Level > p112.PetData.Level;
    end);

    return v109;
end;

function u5.HasActivePetOfType(p113: table, p114: userdata, p115: string) -- Line: 595
    if not (p114 and p115) then
        return false;
    end;

    local PetsSortedByAge = p113:GetPetsSortedByAge(p114, 0, false, true);

    if not PetsSortedByAge then
        return false;
    end;

    for _, v in PetsSortedByAge do
        if v and (v.PetData and v.PetType == p115) then
            return true;
        end;
    end;

    return false;
end;

function u5.GetPetByUUID(p116: table, p117: userdata, p118: string) -- Line: 613
    -- upvalues: RunService (copy), ServerScriptService (copy), DeepClone (copy), ReplicatedStorage (copy)
    if not (p117 and p118) then
        return nil;
    end;

    if RunService:IsServer() then
        local PlayerDataAsync = require(ServerScriptService.Modules.DataService):GetPlayerDataAsync(p117);

        if not PlayerDataAsync then
            return nil;
        end;

        local v119 = PlayerDataAsync.PetsData.PetInventory.Data[p118];

        if not v119 then
            return nil;
        end;

        local v120 = DeepClone(v119);
        v120.UUID = p118;

        return v120;
    end;

    if RunService:IsClient() then
        local PlayerDatastorePetData = require(ReplicatedStorage.Modules.PetServices.ActivePetsService):GetPlayerDatastorePetData(p117.Name);

        if not PlayerDatastorePetData then
            return nil;
        end;

        local v121 = PlayerDatastorePetData.PetInventory.Data[p118];

        if not v121 then
            return nil;
        end;

        local v122 = DeepClone(v121);
        v122.UUID = p118;

        return v122;
    end;
end;

u5.LOADOUT_NAME_MAX_LENGTH = 15;

function u5.FilterLoadoutNameInput(p123, p124) -- Line: 647
    -- upvalues: DisplayNameSanitizer (copy)
    return DisplayNameSanitizer.FilterInput(p124, 15);
end;

function u5.SanitizeLoadoutName(p125, p126) -- Line: 651
    -- upvalues: DisplayNameSanitizer (copy)
    return DisplayNameSanitizer.Sanitize(p126, 15);
end;

function u5.AbilityFX(p127, p128, p129) -- Line: 656
    -- upvalues: RunService (copy), SpottedEffect (copy), Debris (copy)
    local v130;

    if RunService:IsServer() then
        v130 = require(game.ServerScriptService.Modules.PetsServices.ActivePetsService);
    else
        v130 = require(game.ReplicatedStorage.Modules.PetServices.ActivePetsService);
    end;

    local v131 = SpottedEffect:Clone();
    v131.CFrame = CFrame.new(v130:GetRealPosition(p128, p129)) * CFrame.new(0, 3, 0);
    v131.Parent = workspace;
    v131.SpottedFX.SpotParticle:Emit(1);
    Debris:AddItem(v131, 3);
end;

return u5;