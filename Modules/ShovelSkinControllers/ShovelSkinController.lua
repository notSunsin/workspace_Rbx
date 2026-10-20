-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
local v1 = {};

local function ownsRainbow(p2) -- Line: 11
    local v3;

    if p2 == nil or p2.PermanentGears == nil then
        v3 = false;
    else
        v3 = p2.PermanentGears["Rainbow Shovel"] == true;
    end;

    return v3;
end;

function v1.GetShovelSkin(p4) -- Line: 15
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if not (Data and Data.ShovelSkinData) then
        return "DEFAULT";
    end;

    local Equipped = Data.ShovelSkinData.Equipped;

    if Equipped ~= nil and Equipped ~= "" then
        return Equipped;
    end;

    local v5;

    if Data == nil or Data.PermanentGears == nil then
        v5 = false;
    else
        v5 = Data.PermanentGears["Rainbow Shovel"] == true;
    end;

    return v5 and "Rainbow" or "DEFAULT";
end;

function v1.GetOwnedShovels(p6) -- Line: 25
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();
    local v7 = Data and Data.ShovelSkinData and (Data.ShovelSkinData.OwnedShovels or {}) or {};
    v7.DEFAULT = true;
    local v8;

    if Data == nil or Data.PermanentGears == nil then
        v8 = false;
    else
        v8 = Data.PermanentGears["Rainbow Shovel"] == true;
    end;

    if v8 then
        v7.Rainbow = true;
    end;

    return v7;
end;

function v1.Equip(p9: table, p10: string) -- Line: 35
    -- upvalues: ReplicatedStorage (copy)
    if not p10 or type(p10) ~= "string" then
        return;
    end;

    ReplicatedStorage.GameEvents.ShovelSkinService.Equip:FireServer(p10);
end;

return v1;