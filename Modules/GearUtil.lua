-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GearData = require(ReplicatedStorage.Data.GearData);

return {
    IsItemTypeGear = function(p1: string) -- Line: 9, Name: IsItemTypeGear
        -- upvalues: GearData (copy)
        return p1 == "Gear" and true or ((p1 == "Sprinkler" or (p1 == "Favorite Tool" or (p1 == "FriendshipPot" or (p1 == "Harvest Tool" or (p1 == "Lightning Rod" or (p1 == "Nectar Staff" or (p1 == "Night Staff" or (p1 == "Pollen Radar" or (p1 == "Recall Wrench" or (p1 == "Event Lantern" or (p1 == "Pet Pouch" or (p1 == "SprayBottle" or (p1 == "MutationSpray" or (p1 == "Star Caller" or (p1 == "Trowel" or (p1 == "Watering Can" or (p1 == "Tranquil Radar" or (p1 == "Glimmering Radar" or (p1 == "Corrupt Radar" or (p1 == "Fertilizer" or (p1 == "PetBoost" or (p1 == "PetShard" or (p1 == "Fairy Summoner" or (p1 == "Fairy Caller" or (p1 == "Luminous Wand" or (p1 == "Fairy Net" or (p1 == "Fairy Jar" or p1 == "Bee Egg"))))))))))))))))))))))))))) and true or GearData[p1] ~= nil);
    end
};