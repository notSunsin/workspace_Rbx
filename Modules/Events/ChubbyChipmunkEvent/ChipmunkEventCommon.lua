-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
require(ReplicatedStorage.Types.PetTypes);
local ChipmunkEventRewardData = require(ReplicatedStorage.Data.Events.ChubbyChipmunkEvent.ChipmunkEventRewardData);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local u1 = {
    NUTTY_FEVER_PROGRESS_THRESHOLD = 1500,
    NUTTY_FEVER_DURATION = 300,
    TRACK_RESTART_COST = 1000000000000,
    TRACK_RESTART_COST_ROBUX = 89,
    PLANT_TRAIT_INTERVAL = 1800,
    POSSIBLE_PLANT_TRAITS = { "Nutty", "Fall", "Stalky", "Root", "Woody", "Leafy", "Berry" }
};

function u1.GetCurrentTrait(p2) -- Line: 31
    -- upvalues: u1 (copy)
    local v3 = os.time() / u1.PLANT_TRAIT_INTERVAL;
    local math_floor_ret = math.floor(v3);
    local Random_new_ret = Random.new(math_floor_ret);
    local Random_new_ret2 = Random.new(math_floor_ret - 1);
    local v4 = u1.POSSIBLE_PLANT_TRAITS[Random_new_ret2:NextInteger(1, #u1.POSSIBLE_PLANT_TRAITS)];
    local v5 = {};

    for _, v in u1.POSSIBLE_PLANT_TRAITS do
        if v ~= v4 then
            table.insert(v5, v);
        end;
    end;

    return v5[Random_new_ret:NextInteger(1, #v5)];
end;

local function GetPlayerPetData(p6: userdata, p7: string) -- Line: 52
    -- upvalues: RunService (copy), ReplicatedStorage (copy)
    if not RunService:IsServer() then
        return require(ReplicatedStorage.Modules.PetServices.PetsService):GetPlayerPetData(p7);
    end;

    local ServerScriptService = game:GetService("ServerScriptService");

    return require(ServerScriptService.Modules.PetsServices.PetsService):GetPlayerPetData(p6, p7);
end;

local function GetPlayerData(p8: userdata) -- Line: 64
    -- upvalues: RunService (copy), ReplicatedStorage (copy)
    if RunService:IsServer() then
        return require(game:GetService("ServerScriptService").Modules.DataService):GetPlayerData(p8);
    end;

    return require(ReplicatedStorage.Modules.DataService):GetData();
end;

function u1.IsToolValidChipmunk(p9: table, p10: userdata, p11: userdata?) -- Line: 74
    -- upvalues: GetPlayerPetData (copy), ChipmunkEventRewardData (copy), InventoryServiceEnums (copy)
    if not p11 then
        return false, "No Tool";
    end;

    local Attribute = p11:GetAttribute("PET_UUID");

    if not Attribute then
        return false, "Invalid Pet ID";
    end;

    local v12 = GetPlayerPetData(p10, Attribute);

    if not v12 then
        return false, "Not Pet Data";
    end;

    local PetType = v12.PetType;

    if not PetType then
        return false, "No ItemName";
    end;

    if ChipmunkEventRewardData.ValidPetTypes[PetType] == nil then
        return false, "Not a valid pet type";
    end;

    if p11:GetAttribute(InventoryServiceEnums.Favorite) then
        return false, "Can\'t take favourited pets!";
    end;

    return true, nil;
end;

function u1.GetChipmunkData(p13: table, p14: userdata) -- Line: 95
    -- upvalues: GetPlayerData (copy), GetPlayerPetData (copy)
    local v15 = GetPlayerData(p14);

    if not v15 then
        return nil;
    end;

    local ChipmunkID = v15.ChipmunkEvent.ChipmunkID;

    if ChipmunkID then
        return GetPlayerPetData(p14, ChipmunkID) or nil;
    end;

    return nil;
end;

function u1.CountUnclaimedRewards(p16: table, p17: userdata) -- Line: 115
    -- upvalues: u1 (copy), GetPlayerData (copy), PetUtilities (copy), ChipmunkEventRewardData (copy)
    local ChipmunkData = u1:GetChipmunkData(p17);

    if not (ChipmunkData and ChipmunkData.PetData) then
        return 0;
    end;

    local v18 = GetPlayerData(p17);

    if not v18 then
        return 0;
    end;

    local v19 = PetUtilities:CalculateWeight(ChipmunkData.PetData.BaseWeight or 1, ChipmunkData.PetData.Level, ChipmunkData.PetType);
    local v20 = 0;

    for _, v in ChipmunkEventRewardData.RewardBrackets do
        if v19 >= v.Weight and not v18.ChipmunkEvent.WeightTiersClaimed[`{v.Weight}`] then
            v20 = v20 + 1;
        end;
    end;

    return v20;
end;

return u1;