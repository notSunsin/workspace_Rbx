-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
require(ReplicatedStorage.Modules.CreateTagHandler);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local Mutations = MutationHandler:GetMutations();
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = nil;
local u5 = { "CropMutationEffects", "Effect", "PetMutationVFX", "ParticleEmitter", "VisualEffects" };

local function GetFXPart(p6: userdata) -- Line: 27
    if not p6 then
        warn("MutationHandler.GetFXPart | No plant given!");

        return nil;
    end;

    if not p6:IsDescendantOf(game) then
        return nil;
    end;

    local v7 = {};

    if #v7 == 1 then
        return v7[1];
    end;

    if #v7 > 1 then
        return v7;
    end;

    local v8 = p6:IsA("Tool") and p6:WaitForChild("Handle", 0.3);

    if v8 then
        return v8;
    end;

    if p6.PrimaryPart then
        return p6.PrimaryPart;
    end;

    return nil;
end;

local function Cleanup() -- Line: 56
    -- upvalues: u2 (copy), u4 (ref)
    for _, v in u2 do
        v:Disconnect();
    end;

    table.clear(u2);

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;
end;

local function ManuallyRemoveVisuals(p9: userdata) -- Line: 73
    -- upvalues: MutationHandler (copy)
    for _, descendant in p9:GetDescendants() do
        if descendant.Name ~= "RootPart" and descendant.Name ~= "Base" then
            if descendant:IsA("Decal") or (descendant:IsA("Texture") or (descendant:IsA("ParticleEmitter") or (descendant:HasTag("Effect") or (descendant:IsA("Attachment") or (descendant:IsA("PointLight") or descendant:IsA("Trail")))))) then
                descendant:Destroy();
            end;

            if (descendant:IsA("BasePart") or (descendant:IsA("UnionOperation") or descendant:IsA("MeshPart"))) and not MutationHandler:IsPartPermanentlyHidden(descendant) then
                descendant.Material = "Plastic";
                descendant.MaterialVariant = "Studs 2x2 Plastic";

                if descendant.Transparency > 0 and descendant.Transparency < 1 then
                    descendant.Transparency = 0;
                end;
            end;
        end;
    end;
end;

local function DisableCropFX(u10: userdata) -- Line: 112
    -- upvalues: MutationHandler (copy), Mutations (copy), GetFXPart (copy), ManuallyRemoveVisuals (copy)
    local PlantMutations = MutationHandler:GetPlantMutations(u10);
    task.defer(function() -- Line: 116
        -- upvalues: MutationHandler (ref), u10 (copy), PlantMutations (copy), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
        MutationHandler:PreserveHiddenParts(u10, function() -- Line: 120
            -- upvalues: PlantMutations (ref), Mutations (ref), u10 (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
            for _, v in PlantMutations do
                local v11 = Mutations[v.Name];
                v11._RemoveFX(v11, u10, (GetFXPart(u10)));
            end;

            ManuallyRemoveVisuals(u10);
        end);
    end);
end;

local function DisablePetFX(u12: userdata) -- Line: 136
    -- upvalues: ManuallyRemoveVisuals (copy)
    task.defer(function() -- Line: 137
        -- upvalues: ManuallyRemoveVisuals (ref), u12 (copy)
        ManuallyRemoveVisuals(u12);
    end);
end;

local function DisableAllPetFX() -- Line: 143
    -- upvalues: SettingsService (copy), CollectionService (copy), ManuallyRemoveVisuals (copy)
    if not SettingsService:GetSetting("PerformanceMode") then
        return;
    end;

    local v13 = 0;

    for _, v in CollectionService:GetTagged("PetModel") do
        if v:IsDescendantOf(workspace) then
            task.defer(function() -- Line: 137
                -- upvalues: ManuallyRemoveVisuals (ref), v (copy)
                ManuallyRemoveVisuals(v);
            end);
            v13 = v13 + 1;

            if v13 % 50 == 0 then
                task.wait();
            end;
        end;
    end;
end;

local function DisableAllCropFX() -- Line: 156
    -- upvalues: SettingsService (copy), CollectionService (copy), MutationHandler (copy), Mutations (copy), GetFXPart (copy), ManuallyRemoveVisuals (copy)
    if not SettingsService:GetSetting("PerformanceMode") then
        return;
    end;

    local v14 = 0;

    for _, v in CollectionService:GetTagged("PlantGenerated") do
        if v:HasTag("Harvestable") or v:HasTag("FruitTool") then
            local PlantMutations = MutationHandler:GetPlantMutations(v);
            task.defer(function() -- Line: 116
                -- upvalues: MutationHandler (ref), v (copy), PlantMutations (copy), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                MutationHandler:PreserveHiddenParts(v, function() -- Line: 120
                    -- upvalues: PlantMutations (ref), Mutations (ref), v (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                    for _, v2 in PlantMutations do
                        local v15 = Mutations[v2.Name];
                        v15._RemoveFX(v15, v, (GetFXPart(v)));
                    end;

                    ManuallyRemoveVisuals(v);
                end);
            end);
            v14 = v14 + 1;

            if v14 % 50 == 0 then
                task.wait();
            end;
        end;
    end;
end;

local function DisableAllCropFXOfPlayer(p16: userdata) -- Line: 169
    -- upvalues: SettingsService (copy), GetFarm (copy), CollectionService (copy), MutationHandler (copy), Mutations (copy), GetFXPart (copy), ManuallyRemoveVisuals (copy)
    if not SettingsService:GetSetting("PerformanceMode") then
        return;
    end;

    local v17 = GetFarm(p16);

    if not v17 then
        return;
    end;

    local v18 = 0;

    for _, v in CollectionService:GetTagged("PlantGenerated") do
        if (v:HasTag("Harvestable") or v:HasTag("FruitTool")) and v:IsAncestorOf(v17) then
            local PlantMutations = MutationHandler:GetPlantMutations(v);
            task.defer(function() -- Line: 116
                -- upvalues: MutationHandler (ref), v (copy), PlantMutations (copy), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                MutationHandler:PreserveHiddenParts(v, function() -- Line: 120
                    -- upvalues: PlantMutations (ref), Mutations (ref), v (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                    for _, v2 in PlantMutations do
                        local v19 = Mutations[v2.Name];
                        v19._RemoveFX(v19, v, (GetFXPart(v)));
                    end;

                    ManuallyRemoveVisuals(v);
                end);
            end);
            v18 = v18 + 1;

            if v18 % 50 == 0 then
                task.wait();
            end;
        end;
    end;
end;

local function DisableAllPetFXOfPlayer(p20: userdata) -- Line: 187
    -- upvalues: SettingsService (copy), GetFarm (copy), CollectionService (copy), ManuallyRemoveVisuals (copy)
    if not SettingsService:GetSetting("PerformanceMode") then
        return;
    end;

    local v21 = GetFarm(p20);

    if not v21 then
        return;
    end;

    for _, v in CollectionService:GetTagged("PetModel") do
        if v:IsAncestorOf(v21) and v:IsDescendantOf(workspace) then
            task.defer(function() -- Line: 137
                -- upvalues: ManuallyRemoveVisuals (ref), v (copy)
                ManuallyRemoveVisuals(v);
            end);
        end;
    end;
end;

function u1.Enable(p22) -- Line: 203
    -- upvalues: SettingsService (copy), u2 (copy), u4 (ref), CollectionService (copy), MutationHandler (copy), Mutations (copy), GetFXPart (copy), ManuallyRemoveVisuals (copy), u5 (copy), LocalPlayer (copy), DisableAllCropFX (copy), DisableAllPetFX (copy)
    if not SettingsService:GetSetting("PerformanceMode") then
        return;
    end;

    for _, v in u2 do
        v:Disconnect();
    end;

    table.clear(u2);

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("PlantGenerated");
    table.insert(u2, InstanceAddedSignal:Connect(function(u23: userdata) -- Line: 209
        -- upvalues: MutationHandler (ref), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
        if not u23:HasTag("Harvestable") then
            return;
        end;

        local v26 = u23.AttributeChanged:Connect(function() -- Line: 213
            -- upvalues: u23 (copy), MutationHandler (ref), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
            task.defer(function() -- Line: 214
                -- upvalues: u23 (ref), MutationHandler (ref), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                local u24 = u23;
                local PlantMutations = MutationHandler:GetPlantMutations(u24);
                task.defer(function() -- Line: 116
                    -- upvalues: MutationHandler (ref), u24 (copy), PlantMutations (copy), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                    MutationHandler:PreserveHiddenParts(u24, function() -- Line: 120
                        -- upvalues: PlantMutations (ref), Mutations (ref), u24 (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                        for _, v in PlantMutations do
                            local v25 = Mutations[v.Name];
                            v25._RemoveFX(v25, u24, (GetFXPart(u24)));
                        end;

                        ManuallyRemoveVisuals(u24);
                    end);
                end);
            end);
        end);
        task.wait(60);
        task.defer(function() -- Line: 222
            -- upvalues: u23 (copy), MutationHandler (ref), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
            local u27 = u23;
            local PlantMutations = MutationHandler:GetPlantMutations(u27);
            task.defer(function() -- Line: 116
                -- upvalues: MutationHandler (ref), u27 (copy), PlantMutations (copy), Mutations (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                MutationHandler:PreserveHiddenParts(u27, function() -- Line: 120
                    -- upvalues: PlantMutations (ref), Mutations (ref), u27 (ref), GetFXPart (ref), ManuallyRemoveVisuals (ref)
                    for _, v in PlantMutations do
                        local v28 = Mutations[v.Name];
                        v28._RemoveFX(v28, u27, (GetFXPart(u27)));
                    end;

                    ManuallyRemoveVisuals(u27);
                end);
            end);
        end);

        if v26 then
            v26:Disconnect();
        end;
    end));
    local InstanceAddedSignal2 = CollectionService:GetInstanceAddedSignal("PetModel");
    table.insert(u2, InstanceAddedSignal2:Connect(function(u29: userdata) -- Line: 233
        -- upvalues: ManuallyRemoveVisuals (ref)
        task.wait(5);
        task.defer(function() -- Line: 235
            -- upvalues: u29 (copy), ManuallyRemoveVisuals (ref)
            local u30 = u29;
            task.defer(function() -- Line: 137
                -- upvalues: ManuallyRemoveVisuals (ref), u30 (copy)
                ManuallyRemoveVisuals(u30);
            end);
        end);
    end));
    local InstanceAddedSignal3 = CollectionService:GetInstanceAddedSignal("VisualEffects");
    table.insert(u2, InstanceAddedSignal3:Connect(function(u31: userdata) -- Line: 241
        task.defer(function() -- Line: 242
            -- upvalues: u31 (copy)
            if u31:IsA("ParticleEmitter") then
                u31.Enabled = false;
            end;
        end);
    end));
    local InstanceAddedSignal4 = CollectionService:GetInstanceAddedSignal("ParticleEmitter");
    table.insert(u2, InstanceAddedSignal4:Connect(function(u32: userdata) -- Line: 250
        task.defer(function() -- Line: 251
            -- upvalues: u32 (copy)
            if u32:IsA("ParticleEmitter") then
                u32.Enabled = false;
            end;
        end);
    end));
    task.defer(function() -- Line: 259
        -- upvalues: u5 (ref), CollectionService (ref)
        local v33 = 0;

        for _, v in u5 do
            for _, v2 in CollectionService:GetTagged(v) do
                if v2:IsA("ParticleEmitter") then
                    v2.Enabled = false;
                end;

                v33 = v33 + 1;

                if v33 % 200 == 0 then
                    task.wait();
                end;
            end;
        end;
    end);

    if not LocalPlayer:GetAttribute("FarmFullyLoaded") then
        u4 = LocalPlayer:GetAttributeChangedSignal("FarmFullyLoaded"):Connect(function() -- Line: 280
            -- upvalues: LocalPlayer (ref), DisableAllCropFX (ref), DisableAllPetFX (ref)
            if LocalPlayer:GetAttribute("FarmFullyLoaded") ~= true then
                return;
            end;

            task.wait(10);
            DisableAllCropFX();
            DisableAllPetFX();
        end);

        return;
    end;

    DisableAllCropFX();
    DisableAllPetFX();
end;

LocalPlayer:GetAttributeChangedSignal("PerformanceMode"):Connect(function() -- Line: 289
    -- upvalues: LocalPlayer (copy), u1 (copy), u2 (copy), u4 (ref)
    if LocalPlayer:GetAttribute("PerformanceMode") then
        u1:Enable();

        return;
    end;

    for _, v in u2 do
        v:Disconnect();
    end;

    table.clear(u2);

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;
end);
task.defer(u1.Enable, u1);
Players.PlayerAdded:Connect(function(u34: userdata) -- Line: 299
    -- upvalues: LocalPlayer (copy), u3 (copy), SettingsService (copy), DisableAllCropFXOfPlayer (copy)
    if u34 == LocalPlayer then
        return;
    end;

    u3[u34] = u34:GetAttributeChangedSignal("FarmFullyLoaded"):Connect(function() -- Line: 303
        -- upvalues: SettingsService (ref), LocalPlayer (ref), DisableAllCropFXOfPlayer (ref), u34 (copy)
        if not SettingsService:GetSetting("PerformanceMode") then
            return;
        end;

        if LocalPlayer:GetAttribute("FarmFullyLoaded") ~= true then
            return;
        end;

        task.wait(10);
        DisableAllCropFXOfPlayer(u34);
    end);
end);
Players.PlayerRemoving:Connect(function(p35: userdata) -- Line: 312
    -- upvalues: u3 (copy)
    if u3[p35] then
        u3[p35]:Disconnect();
        u3[p35] = nil;
    end;
end);

return u1;