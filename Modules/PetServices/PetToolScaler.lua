-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
require(ReplicatedStorage.Modules.DataService);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};

local function ScalePet(p3: userdata) -- Line: 16
    -- upvalues: SettingsService (copy)
    if SettingsService:GetSetting("HeldPetScaling") then
        p3:ScaleTo(p3:GetAttribute("TrueScale") or 1);

        return;
    end;

    p3:ScaleTo(1);
end;

local function OnPetToolAdded(u4: userdata) -- Line: 27
    -- upvalues: u1 (copy), SettingsService (copy), u2 (copy)
    table.insert(u1, u4);
    local v6 = u4.AncestryChanged:Connect(function() -- Line: 31
        -- upvalues: u1 (ref), u4 (copy), SettingsService (ref)
        local table_find_ret = table.find(u1, u4);

        if u4:IsDescendantOf(workspace) then
            if not table_find_ret then
                table.insert(u1, u4);
            end;
        elseif table_find_ret then
            table.remove(u1, table_find_ret);
        end;

        local v5 = u4;

        if SettingsService:GetSetting("HeldPetScaling") then
            v5:ScaleTo(v5:GetAttribute("TrueScale") or 1);

            return;
        end;

        v5:ScaleTo(1);
    end);

    if u2[u4] then
        u2[u4]:Disconnect();
        u2[u4] = nil;
    end;

    u2[u4] = v6;

    if SettingsService:GetSetting("HeldPetScaling") then
        u4:ScaleTo(u4:GetAttribute("TrueScale") or 1);

        return;
    end;

    u4:ScaleTo(1);
end;

local v7 = {};

for _, v in CollectionService:GetTagged("PetToolModel") do
    if table.find(u1, v) == nil and v:IsDescendantOf(workspace) then
        OnPetToolAdded(v);
    end;
end;

CollectionService:GetInstanceAddedSignal("PetToolModel"):Connect(function(p8: userdata) -- Line: 63
    -- upvalues: OnPetToolAdded (copy)
    OnPetToolAdded(p8);
end);
CollectionService:GetInstanceRemovedSignal("PetToolModel"):Connect(function(p9: userdata) -- Line: 67
    -- upvalues: u1 (copy), u2 (copy)
    local table_find_ret = table.find(u1, p9);

    if table_find_ret then
        table.remove(u1, table_find_ret);
    end;

    if u2[p9] then
        u2[p9]:Disconnect();
        u2[p9] = nil;
    end;
end);
LocalPlayer.AttributeChanged:Connect(function(p10: string) -- Line: 79
    -- upvalues: u1 (copy), SettingsService (copy)
    if p10 ~= "HeldPetScaling" then
        return;
    end;

    for _, v in u1 do
        if SettingsService:GetSetting("HeldPetScaling") then
            v:ScaleTo(v:GetAttribute("TrueScale") or 1);
        else
            v:ScaleTo(1);
        end;
    end;
end);

return v7;