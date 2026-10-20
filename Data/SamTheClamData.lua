-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    TIME_TO_PROCESS = 3600,
    EGG_NAME = "Coastal Egg",
    MIN_EGGS = 1,
    MAX_EGGS = 6,
    SUMMER_PET_CHANCE = 0.05,
    DIMA_MUTATION = "Tidal",
    SUMMER_PET_POOL = { {
            PetName = "Pelican",
            Weight = 80,
            PostUpdateWeight = 40
        }, {
            PetName = "Nautilus",
            Weight = 40
        }, {
            PetName = "Manta Ray",
            Weight = 20
        }, {
            PetName = "Hippocampus",
            Weight = 5
        } },
    DIMA_UPGRADES = { {
            MinWeight = 40,
            ProcessTime = 3000
        }, {
            MinWeight = 80,
            ProcessTime = 2400
        }, {
            MinWeight = 120,
            ProcessTime = 1800
        } }
};

function u1.GetActivePetPool() -- Line: 35
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
    local v2 = workspace:GetServerTimeNow() > UpdateService:GetUpdateTime();
    local v3 = {};

    for _, v in u1.SUMMER_PET_POOL do
        if not UpdateService:IsHiddenFromUpdate(v.PetName) then
            local table_clone_ret = table.clone(v);

            if v2 and table_clone_ret.PostUpdateWeight then
                table_clone_ret.Weight = table_clone_ret.PostUpdateWeight;
            end;

            table.insert(v3, table_clone_ret);
        end;
    end;

    return v3;
end;

function u1.GetMaxDimaUpgradeLevel() -- Line: 57
    -- upvalues: u1 (copy)
    return #u1.DIMA_UPGRADES;
end;

function u1.GetProcessTime(p4: number?) -- Line: 64
    -- upvalues: u1 (copy)
    local v5 = tonumber(p4) or 0;
    local math_floor_ret = math.floor(v5);
    local math_clamp_ret = math.clamp(math_floor_ret, 0, #u1.DIMA_UPGRADES);
    local v6 = u1.DIMA_UPGRADES[math_clamp_ret];

    if v6 then
        return v6.ProcessTime;
    end;

    return u1.TIME_TO_PROCESS;
end;

return u1;