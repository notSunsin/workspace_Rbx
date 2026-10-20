-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observers = require(ReplicatedStorage.Modules.Observers);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local LocalPlayer = Players.LocalPlayer;

local function pathResolver(u1: any, u2: table) -- Line: 10
    return function() -- Line: 11
        -- upvalues: u1 (copy), u2 (copy)
        local v3 = u1;

        for _, v in u2 do
            v3 = v3:WaitForChild(v, 10);

            if not v3 then
                return nil;
            end;
        end;

        return v3;
    end;
end;

local u4 = {};
local workspace_NPCS = workspace.NPCS;
local u5 = { "Gear Stands" };

local function v7() -- Line: 11
    -- upvalues: workspace_NPCS (copy), u5 (copy)
    local v6 = workspace_NPCS;

    for _, v in u5 do
        v6 = v6:WaitForChild(v, 10);

        if not v6 then
            return nil;
        end;
    end;

    return v6;
end;

local workspace_MapDecorations = workspace.MapDecorations;
local u8 = { "GearShopSign" };

local function v10() -- Line: 11
    -- upvalues: workspace_MapDecorations (copy), u8 (copy)
    local v9 = workspace_MapDecorations;

    for _, v in u8 do
        v9 = v9:WaitForChild(v, 10);

        if not v9 then
            return nil;
        end;
    end;

    return v9;
end;

local workspace_NPCS2 = workspace.NPCS;
local u11 = { "Raphael" };

local function v13() -- Line: 11
    -- upvalues: workspace_NPCS2 (copy), u11 (copy)
    local v12 = workspace_NPCS2;

    for _, v in u11 do
        v12 = v12:WaitForChild(v, 10);

        if not v12 then
            return nil;
        end;
    end;

    return v12;
end;

local workspace_NPCS3 = workspace.NPCS;
local u14 = { "Eloise" };

local function v16() -- Line: 11
    -- upvalues: workspace_NPCS3 (copy), u14 (copy)
    local v15 = workspace_NPCS3;

    for _, v in u14 do
        v15 = v15:WaitForChild(v, 10);

        if not v15 then
            return nil;
        end;
    end;

    return v15;
end;

local workspace_NPCS4 = workspace.NPCS;
local u17 = { "Quest Stand" };

local function v19() -- Line: 11
    -- upvalues: workspace_NPCS4 (copy), u17 (copy)
    local v18 = workspace_NPCS4;

    for _, v in u17 do
        v18 = v18:WaitForChild(v, 10);

        if not v18 then
            return nil;
        end;
    end;

    return v18;
end;

local workspace_NPCS5 = workspace.NPCS;
local u20 = { "Pet Stand" };

local function v22() -- Line: 11
    -- upvalues: workspace_NPCS5 (copy), u20 (copy)
    local v21 = workspace_NPCS5;

    for _, v in u20 do
        v21 = v21:WaitForChild(v, 10);

        if not v21 then
            return nil;
        end;
    end;

    return v21;
end;

local workspace_NPCS6 = workspace.NPCS;
local u23 = { "CosmeticStand" };

local function v25() -- Line: 11
    -- upvalues: workspace_NPCS6 (copy), u23 (copy)
    local v24 = workspace_NPCS6;

    for _, v in u23 do
        v24 = v24:WaitForChild(v, 10);

        if not v24 then
            return nil;
        end;
    end;

    return v24;
end;

local workspace_NPCS7 = workspace.NPCS;
local u26 = { "PetMutationMachine" };

local function v28() -- Line: 11
    -- upvalues: workspace_NPCS7 (copy), u26 (copy)
    local v27 = workspace_NPCS7;

    for _, v in u26 do
        v27 = v27:WaitForChild(v, 10);

        if not v27 then
            return nil;
        end;
    end;

    return v27;
end;

local u29 = workspace;
local u30 = { "CraftingTables" };

local function v32() -- Line: 11
    -- upvalues: u29 (copy), u30 (copy)
    local v31 = u29;

    for _, v in u30 do
        v31 = v31:WaitForChild(v, 10);

        if not v31 then
            return nil;
        end;
    end;

    return v31;
end;

local u33 = workspace;
local u34 = { "BlacksmithStand" };

local function v36() -- Line: 11
    -- upvalues: u33 (copy), u34 (copy)
    local v35 = u33;

    for _, v in u34 do
        v35 = v35:WaitForChild(v, 10);

        if not v35 then
            return nil;
        end;
    end;

    return v35;
end;

local workspace_NPCS8 = workspace.NPCS;
local u37 = { "Isaac" };
u4[1], u4[2], u4[3], u4[4], u4[5], u4[6], u4[7], u4[8], u4[9], u4[10], u4[11] = v7, v10, v13, v16, v19, v22, v25, v28, v32, v36, function() -- Line: 11
    -- upvalues: workspace_NPCS8 (copy), u37 (copy)
    local v38 = workspace_NPCS8;

    for _, v in u37 do
        v38 = v38:WaitForChild(v, 10);

        if not v38 then
            return nil;
        end;
    end;

    return v38;
end;
local u39 = {};
local u40 = nil;

local function belongsToCurrentEvent(p41: userdata, p42: any) -- Line: 45
    -- upvalues: EventRotationUtils (copy)
    local Attribute = p41:GetAttribute("EventID");

    if not Attribute then
        return true;
    end;

    if not p42 then
        return false;
    end;

    local EventConfig = EventRotationUtils:GetEventConfig(Attribute);

    if not EventConfig or EventConfig.EventSet ~= p42.EventSet then
        return false;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(Attribute, EventConfig.EventSet);
    local EventInSetIndex2 = EventRotationUtils:GetEventInSetIndex(p42.EventID, p42.EventSet);
    local v43;

    if EventInSetIndex == nil or EventInSetIndex2 == nil then
        v43 = false;
    else
        v43 = EventInSetIndex <= EventInSetIndex2;
    end;

    return v43;
end;

local function restoreAll() -- Line: 58
    -- upvalues: EventRotationUtils (copy), u39 (copy), belongsToCurrentEvent (copy)
    local success, result = pcall(function() -- Line: 59
        -- upvalues: EventRotationUtils (ref)
        return EventRotationUtils:GetCurrentEvent();
    end);

    if not success then
        result = nil;
    end;

    for i, v in u39 do
        if belongsToCurrentEvent(i, result) and (i and (i.Parent == nil or i.Parent == script)) then
            pcall(function() -- Line: 70
                -- upvalues: i (copy), v (copy)
                i.Parent = v;
            end);
        end;
    end;

    table.clear(u39);
end;

local function hideTagged(u44: userdata) -- Line: 78
    -- upvalues: LocalPlayer (copy), u39 (copy)
    if not LocalPlayer:GetAttribute("FirstTimePlayer") then
        return nil;
    end;

    if u39[u44] ~= nil and u44.Parent == script then
        return nil;
    end;

    u39[u44] = u44.Parent;
    u44.Parent = script;
    local u45 = nil;
    u45 = u44.AncestryChanged:Connect(function(p46, p47) -- Line: 89
        -- upvalues: u45 (ref), u39 (ref), u44 (copy)
        if p47 == script then
            return;
        end;

        u45:Disconnect();
        u39[u44] = nil;
    end);

    return nil;
end;

local function HandleFTUE() -- Line: 102
    -- upvalues: LocalPlayer (copy), u40 (ref), restoreAll (copy), Observers (copy), hideTagged (copy), u4 (copy), u39 (copy)
    if LocalPlayer:GetAttribute("FirstTimePlayer") then
        if not u40 then
            u40 = Observers.observeTag("HideFTUE", hideTagged, { workspace });
        end;

        for _, v in u4 do
            task.spawn(function() -- Line: 136
                -- upvalues: v (copy), LocalPlayer (ref), u39 (ref)
                local v48 = v();

                if not v48 then
                    return;
                end;

                if not LocalPlayer:GetAttribute("FirstTimePlayer") then
                    return;
                end;

                if u39[v48] ~= nil then
                    return;
                end;

                u39[v48] = v48.Parent;
                v48.Parent = nil;
            end);
        end;

        return;
    end;

    if u40 then
        u40();
        u40 = nil;
    end;

    restoreAll();
end;

task.spawn(HandleFTUE);
LocalPlayer:GetAttributeChangedSignal("FirstTimePlayer"):Connect(HandleFTUE);

return {};