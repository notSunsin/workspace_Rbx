-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Types.PetTypes);
local PetList = require(ReplicatedStorage.Data.PetRegistry.PetList);

local function GetListOfPetsWithTrait(p1: string) -- Line: 9
    -- upvalues: ReplicatedStorage (copy)
    local PetTraitsData = require(ReplicatedStorage.Modules.PetTraitsData);

    if not PetTraitsData[p1] then
        warn((`PetBoostRegistry.GetListOfPetsWithTrait | No trait named {p1}!`));

        return {};
    end;

    local v2 = {};

    for i, _ in PetTraitsData[p1] do
        table.insert(v2, i);
    end;

    return v2;
end;

return {
    BoostTypeToBaseValue = {
        PASSIVE_BOOST = 1,
        PET_XP_BOOST = 1,
        SIZE_MODIFICATION = 1
    },
    PetModelNameToBoostType = {
        Toy = "PASSIVE_BOOST",
        Treat = "PET_XP_BOOST",
        Bowl = "SIZE_MODIFICATION",
        Lollipop = "LEVEL_BOOST",
        Chew = "ABILITY_REFRESH"
    },
    BoostTypeToPetModelName = {
        PASSIVE_BOOST = "Toy",
        PET_XP_BOOST = "Treat",
        SIZE_MODIFICATION = "Bowl",
        LEVEL_BOOST = "Lollipop",
        ABILITY_REFRESH = "Chew"
    },
    CleanBoostType = {
        PASSIVE_BOOST = "Passive Boost",
        PET_XP_BOOST = "XP Boost",
        SIZE_MODIFICATION = "Size Boost",
        LEVEL_BOOST = "Level Boost",
        ABILITY_REFRESH = "Ability Refresh"
    },
    BoostTypeStatData = {
        PASSIVE_BOOST = {
            BaseValue = 1,
            Amount = {
                Small = 0.1,
                Medium = 0.2,
                Large = 0.3
            },
            Time = {
                Small = 300,
                Medium = 300,
                Large = 400
            }
        },
        PET_XP_BOOST = {
            BaseValue = 1,
            Amount = {
                Small = 0.5,
                Medium = 2,
                Large = 3,
                Christmas = 4,
                Smith = 5
            },
            Time = {
                Small = 43200,
                Medium = 86400,
                Large = 86400,
                Christmas = 108000,
                Smith = 129600
            }
        },
        SIZE_MODIFICATION = {
            BaseValue = 1,
            Amount = {
                Small = 10,
                Medium = 30
            },
            Time = {
                Small = 10,
                Medium = 30
            }
        },
        LEVEL_BOOST = {
            BaseValue = 1,
            Amount = {
                Small = 1,
                Medium = 1,
                Levelup = 1,
                Acorn = 1,
                Silver = 5,
                Gold = 10,
                Rainbow = 25,
                Mega = 100,
                Pumpkin = 1,
                Beetle = 1
            },
            Time = {
                Small = 1,
                Medium = 1,
                Levelup = 1,
                Acorn = 1,
                Silver = 1,
                Gold = 1,
                Rainbow = 1,
                Mega = 1,
                Pumpkin = 1,
                Beetle = 1
            }
        },
        ABILITY_REFRESH = {
            BaseValue = 1,
            Amount = {
                Energy = 1,
                Beetle = 1
            },
            Time = {
                Energy = 1,
                Beetle = 1
            }
        }
    },
    BoostPetWhitelist = {
        ["Acorn Lollipop"] = GetListOfPetsWithTrait("Fall"),
        ["Pumpkin Lollipop"] = GetListOfPetsWithTrait("Halloween"),
        ["Beetle Lollipop"] = (function(p3: string) -- Line: 27, Name: GetPetsWithName
            -- upvalues: ReplicatedStorage (copy), PetList (copy)
            local PetTraitsData = require(ReplicatedStorage.Modules.PetTraitsData);
            local v4 = string.lower(p3) .. "$";

            for i in PetList do
                if string.match(string.lower(i), v4) and not PetTraitsData[p3][i] then
                    PetTraitsData.AddToTrait(i, p3);
                end;
            end;

            if not PetTraitsData[p3] then
                warn((`PetBoostRegistry.GetListOfPetsWithTrait | No trait named {p3}!`));

                return {};
            end;

            local v5 = {};

            for i, _ in PetTraitsData[p3] do
                table.insert(v5, i);
            end;

            return v5;
        end)("Beetle"),
        ["Beetle Chew"] = GetListOfPetsWithTrait("Beetle"),
        ["Christmas Treat"] = GetListOfPetsWithTrait("Christmas")
    },
    ShouldDisplayConfirmationPrompt = {
        ["Silver Lollipop"] = true,
        ["Gold Lollipop"] = true,
        ["Rainbow Lollipop"] = true,
        ["Mega Lollipop"] = true
    }
};