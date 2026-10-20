-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local RebirthConfigData = require(ReplicatedStorage.Data.RebirthConfigData);
require(ReplicatedStorage.Data.DefaultData);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = nil;
local u2 = nil;

if RunService:IsServer() then
    u1 = require(ServerScriptService.UserGenerated.Server.ServerABTests);
    u2 = require(ServerScriptService.Modules.DataService);
elseif RunService:IsClient() then
    u1 = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
    u2 = require(ReplicatedStorage.Modules.DataService);
end;

local u3 = Signal.new();
local u4 = {
    OnRebirthUnlock = u3
};

local function GetPlayerData(p5: userdata) -- Line: 33
    -- upvalues: RunService (copy), u2 (ref)
    if RunService:IsServer() then
        return u2:GetPlayerDataAsync(p5, 30);
    end;

    if RunService:IsClient() then
        return u2:GetData();
    end;

    return nil;
end;

local function GetPathSignal(p6: userdata, p7: any) -- Line: 42
    -- upvalues: RunService (copy), u2 (ref)
    if RunService:IsServer() then
        return u2:GetPathSignal(p6, p7);
    end;

    if RunService:IsClient() then
        return u2:GetPathSignal(p7);
    end;

    return nil;
end;

function u4.HasBeenAssignedABTest(p8: table, p9: userdata) -- Line: 51
    -- upvalues: u1 (ref)
    if u1.GetAssignmentsAsync(p9, true) then
        return u1.GetAttributeAsync(p9, "AB_FTURebirthUnlocks", false) and true or false;
    end;

    return false;
end;

function u4.HasUnlockedFeature(p10: table, p11: userdata, p12: string) -- Line: 65
    -- upvalues: RebirthConfigData (copy), RunService (copy), u2 (ref)
    local v13 = RebirthConfigData.REBIRTH_UNLOCKS[p12];

    if not v13 then
        warn((`{p12} not found in ConfigData`));

        return true;
    end;

    if not p10:HasBeenAssignedABTest(p11) then
        return true;
    end;

    local v14;

    if RunService:IsServer() then
        v14 = u2:GetPlayerDataAsync(p11, 30);
    elseif RunService:IsClient() then
        v14 = u2:GetData();
    else
        v14 = nil;
    end;

    if v14 then
        return v13 <= v14.RebirthData.TotalRebirths;
    end;

    return false;
end;

local u15 = {
    Seed = require(ReplicatedStorage.Data.SeedShopData),
    Egg = require(ReplicatedStorage.Data.PetEggData),
    Gear = require(ReplicatedStorage.Data.GearShopData).Gear
};

function u4.HasUnlockedShopItem(p16: table, p17: userdata, p18: string, p19: string) -- Line: 84
    -- upvalues: u15 (copy), RunService (copy), u2 (ref)
    if not p16:HasBeenAssignedABTest(p17) then
        return true;
    end;

    local v20 = u15[p18];

    if not v20 and p18 ~= "ALL" then
        return true;
    end;

    local v21 = nil;
    local v22;

    if p18 == "ALL" and string.match(p19, "Seed") then
        v22 = string.gsub(p19, " Seed", "");

        if u15.Seed[v22] then
            v21 = u15.Seed[v22];
        else
            v22 = p19;
        end;
    else
        v22 = p19;
    end;

    if p18 == "ALL" and not v21 then
        for _, v in u15 do
            v21 = v[v22];

            if v21 then
                break;
            end;
        end;
    else
        v21 = v20[v22];
    end;

    if not v21 then
        warn((`{v22} not found in ShopData of {p18}`));

        return true;
    end;

    local RebirthRequirement = v21.RebirthRequirement;

    if not RebirthRequirement then
        return true;
    end;

    local v23;

    if RunService:IsServer() then
        v23 = u2:GetPlayerDataAsync(p17, 30);
    elseif RunService:IsClient() then
        v23 = u2:GetData();
    else
        v23 = nil;
    end;

    if v23 then
        return RebirthRequirement <= v23.RebirthData.TotalRebirths;
    end;

    return false;
end;

function u4.GetRemainingRebirthsNeededForItem(p24: table, p25: userdata, p26: string, p27: string) -- Line: 127
    -- upvalues: u15 (copy), RunService (copy), u2 (ref)
    if not p24:HasBeenAssignedABTest(p25) then
        return 0;
    end;

    local v28 = u15[p26];

    if not v28 then
        return 0;
    end;

    local v29 = v28[p27];

    if not v29 then
        warn((`{p27} not found in ShopData of {p26}`));

        return 0;
    end;

    local RebirthRequirement = v29.RebirthRequirement;

    if not RebirthRequirement then
        return 0;
    end;

    local v30;

    if RunService:IsServer() then
        v30 = u2:GetPlayerDataAsync(p25, 30);
    elseif RunService:IsClient() then
        v30 = u2:GetData();
    else
        v30 = nil;
    end;

    return not v30 and 0 or math.floor(RebirthRequirement - v30.RebirthData.TotalRebirths);
end;

function u4.GetRemainingRebirthsNeededForFeature(p31: table, p32: userdata, p33: string) -- Line: 145
    -- upvalues: RebirthConfigData (copy), RunService (copy), u2 (ref)
    if not p31:HasBeenAssignedABTest(p32) then
        return 0;
    end;

    local v34 = RebirthConfigData.REBIRTH_UNLOCKS[p33];

    if v34 then
        local v35;

        if RunService:IsServer() then
            v35 = u2:GetPlayerDataAsync(p32, 30);
        elseif RunService:IsClient() then
            v35 = u2:GetData();
        else
            v35 = nil;
        end;

        return not v35 and 0 or math.floor(v34 - v35.RebirthData.TotalRebirths);
    end;

    warn((`{p33} not found in REBIRTH_UNLOCKS}`));

    return 0;
end;

local function OnPlayerAdded(u36: userdata) -- Line: 157
    -- upvalues: u4 (copy), RunService (copy), u2 (ref), RebirthConfigData (copy), u3 (copy)
    if not u4:HasBeenAssignedABTest(u36) then
        return;
    end;

    local u37;

    if RunService:IsServer() then
        u37 = u2:GetPlayerDataAsync(u36, 30);
    elseif RunService:IsClient() then
        u37 = u2:GetData();
    else
        u37 = nil;
    end;

    local v38;

    if RunService:IsServer() then
        v38 = u2:GetPathSignal(u36, "RebirthData/TotalRebirths");
    elseif RunService:IsClient() then
        v38 = u2:GetPathSignal("RebirthData/TotalRebirths");
    else
        v38 = nil;
    end;

    if not v38 then
        return;
    end;

    v38:Connect(function() -- Line: 165
        -- upvalues: RebirthConfigData (ref), u37 (copy), u3 (ref), u36 (copy)
        for i, v in RebirthConfigData.REBIRTH_UNLOCKS do
            if not u37 then
                return;
            end;

            if u37.RebirthData.TotalRebirths >= v then
                u3:Fire(u36, i);
            end;
        end;
    end);
end;

Players.PlayerAdded:Connect(OnPlayerAdded);
task.spawn(function() -- Line: 178
    -- upvalues: RunService (copy), OnPlayerAdded (copy), Players (copy)
    if RunService:IsClient() then
        OnPlayerAdded(Players.LocalPlayer);
    end;
end);

return u4;