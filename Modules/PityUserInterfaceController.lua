-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DataService = require(ReplicatedStorage.Modules.DataService);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local PityData = require(ReplicatedStorage.Data.PityData);
local LocalPlayer = Players.LocalPlayer;
local Character = LocalPlayer.Character;
local PityUI = LocalPlayer.PlayerGui:WaitForChild("PityUI");
local _ = PityUI.MainFrame.INSERTION_POINT;
local ITEM_ICON = PityUI.MainFrame.INSERTION_POINT.PITY_ITEM_TEMPLATE.TemplateSmaller.ITEM_ICON;
local ITEM_COUNTER = PityUI.MainFrame.INSERTION_POINT.PITY_ITEM_TEMPLATE.TemplateSmaller.ITEM_COUNTER;
local RainbowBackground = PityUI.MainFrame.INSERTION_POINT.PITY_ITEM_TEMPLATE.TemplateSmaller.RainbowBackground;
local u2 = nil;

local function HasAnyEntryHasPity(p3) -- Line: 28
    for _, v in p3 do
        if v.Pity then
            return true;
        end;
    end;

    return false;
end;

local function CheckForPityItem() -- Line: 37
    -- upvalues: Character (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), u2 (ref), PityData (copy), u1 (copy)
    local v4 = Character:FindFirstChildWhichIsA("Tool");
    local v5;

    if v4 then
        v5 = v4:GetAttribute(InventoryServiceEnums.ITEM_TYPE);
    else
        v5 = v4;
    end;

    local v6 = v5 == ItemTypeEnums["Seed Pack"];
    local v7 = v5 == ItemTypeEnums.PetEgg;

    if v4 then
        local v8;

        if v6 then
            v8 = v4:GetAttribute(InventoryServiceEnums.Type);
        elseif v7 then
            v8 = v4:GetAttribute(InventoryServiceEnums.EggName);
        else
            v8 = nil;
        end;

        u2 = v8;
    else
        u2 = nil;
    end;

    local v9 = u2 and PityData[u2] and PityData[u2].Items;

    if v9 then
        v9 = false;

        for _, v in v9 do
            if v.Pity then
                v9 = true;
                break;
            end;
        end;
    end;

    local v10;

    if v9 == nil then
        v10 = false;
    else
        v10 = u2 ~= nil;
    end;

    u1:Toggle(v10);
end;

local function HandleCharacter(p11: userdata) -- Line: 59
    -- upvalues: CheckForPityItem (copy)
    p11.ChildAdded:Connect(CheckForPityItem);
    p11.ChildRemoved:Connect(CheckForPityItem);
end;

if Character then
    Character.ChildAdded:Connect(CheckForPityItem);
    Character.ChildRemoved:Connect(CheckForPityItem);
end;

LocalPlayer.CharacterAdded:Connect(HandleCharacter);

local function GetCurrentSpinCount() -- Line: 70
    -- upvalues: PityData (copy), u2 (ref), DataService (copy)
    return PityData[u2] and (DataService:GetData().Pity[u2] or 0) or false;
end;

local function GetNextPityItem() -- Line: 79
    -- upvalues: u2 (ref), PityData (copy), DataService (copy)
    if u2 then
        local v12 = PityData[u2];

        if not v12 then
            return false;
        end;

        local v13 = DataService:GetData().Pity[u2] or 0;
        local v14 = (1 / 0);
        local v15 = nil;

        for _, v in v12.Items do
            if v.Pity and (v13 < v.Pity and v.Pity < v14) then
                v14 = v.Pity;
                v15 = v;
            end;
        end;

        return v15;
    end;
end;

local function GetNextPityItemTotalChanceRequired() -- Line: 101
    -- upvalues: u2 (ref), PityData (copy), DataService (copy)
    if u2 then
        local v16 = PityData[u2];

        if not v16 then
            return false;
        end;

        local v17 = DataService:GetData().Pity[u2] or 0;
        local v18 = 0;

        for _, v in v16.Items do
            if v.Pity then
                if v17 < v.Pity then
                    return v18;
                end;

                v18 = v18 + v.Pity;
            end;
        end;

        return nil;
    end;
end;

local function GetIcon() -- Line: 126
    -- upvalues: GetNextPityItem (copy)
    local v19 = GetNextPityItem();

    return v19 and v19.Icon or "";
end;

local function GetNextPityChance() -- Line: 132
    -- upvalues: GetNextPityItem (copy)
    local v20 = GetNextPityItem();

    return v20 and v20.Pity or 0;
end;

local function IsNextRainbow() -- Line: 137
    -- upvalues: GetNextPityItem (copy)
    local v21 = GetNextPityItem();

    if v21 then
        return v21.Type == "RainbowSeed" and true or string.find(v21.RewardId, "Rainbow ") ~= nil;
    end;

    return false;
end;

function u1.Render(p22) -- Line: 146
    -- upvalues: PityUI (copy), ITEM_ICON (copy), GetNextPityItem (copy), ITEM_COUNTER (copy), PityData (copy), u2 (ref), DataService (copy), RainbowBackground (copy)
    if not PityUI.Enabled then
        return;
    end;

    local v23 = GetNextPityItem();
    ITEM_ICON.Image = v23 and v23.Icon or "";
    local v24 = PityData[u2] and (DataService:GetData().Pity[u2] or 0) or false;
    local v25 = GetNextPityItem();
    ITEM_COUNTER.Text = `{v24}/{v25 and v25.Pity or 0}`;
    local v26 = GetNextPityItem();
    local v27;

    if v26 then
        v27 = v26.Type == "RainbowSeed" and true or string.find(v26.RewardId, "Rainbow ") ~= nil;
    else
        v27 = false;
    end;

    RainbowBackground.Visible = v27;
end;

DataService:GetPathSignal("Pity/@"):Connect(function() -- Line: 156
    -- upvalues: u1 (copy)
    u1:Render();
end);
u1:Render();

function u1.Toggle(p28, p29) -- Line: 162
    -- upvalues: PityUI (copy), u1 (copy)
    PityUI.Enabled = p29;

    if p29 then
        u1:Render();
    end;
end;

return u1;