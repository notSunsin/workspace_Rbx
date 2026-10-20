-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local v1 = {};

local function ShuffleArray(p2) -- Line: 10
    for i = #p2, 2, -1 do
        local math_random_ret = math.random(1, i);
        local v3 = p2[i];
        p2[i] = p2[math_random_ret];
        p2[math_random_ret] = v3;
        local _ = i;
    end;
end;

local function SplitTokens(p4: string, p5: string) -- Line: 17
    local v6 = {};

    for i in string.gmatch(p4, (`[^${p5}]+`)) do
        v6[#v6 + 1] = string.lower(i);
    end;

    return v6;
end;

function v1.CountPlants(p7: userdata, u8: string?, p9: string?, u10: boolean?) -- Line: 26
    -- upvalues: PlantTraitsData (copy)
    if not p7 then
        return 0;
    end;

    local Plants_Physical = p7:FindFirstChild("Plants_Physical", true);

    if not Plants_Physical then
        return 0;
    end;

    local u11 = p9 and string.lower(p9) or nil;
    local v12 = 0;

    for _, child in Plants_Physical:GetChildren() do
        if child:IsA("Model") then
            local function IsValid(p13: userdata) -- Line: 40
                -- upvalues: u10 (copy), u8 (copy), PlantTraitsData (ref), child (copy), u11 (copy)
                if u10 and p13:GetAttribute("Favorited") then
                    return false;
                end;

                if u8 and not PlantTraitsData.HasTrait(child.Name, u8) then
                    return false;
                end;

                return (not u11 or string.find(string.lower(p13.Name), u11)) and true or false;
            end;

            if IsValid(child) then
                v12 = v12 + 1;
            end;

            local Fruits = child:FindFirstChild("Fruits");

            if Fruits then
                for _, child2 in Fruits:GetChildren() do
                    if child2:IsA("Model") and IsValid(child2) then
                        v12 = v12 + 1;
                    end;
                end;
            end;
        end;
    end;

    return v12;
end;

function v1.GetAllPlants(p14: userdata, p15: string?, p16: string?, p17: boolean?, p18: boolean?) -- Line: 73
    -- upvalues: PlantTraitsData (copy)
    local v19 = {};

    if not p14 then
        return v19;
    end;

    local Plants_Physical = p14:FindFirstChild("Plants_Physical", true);

    if not Plants_Physical then
        return v19;
    end;

    local v20 = p16 and string.lower(p16) or nil;

    for _, child in Plants_Physical:GetChildren() do
        if not (not child:IsA("Model") or p17 and child:GetAttribute("Favorited") or (p15 and not PlantTraitsData.HasTrait(child.Name, p15) or v20 and not string.find(string.lower(child.Name), v20))) then
            local v21;

            if p18 then
                local Fruits = child:FindFirstChild("Fruits");

                if not Fruits then
                    v21 = child;
                    v19[#v19 + 1] = v21;
                end;

                v21 = child;
                local v22 = false;

                for _, child2 in Fruits:GetChildren() do
                    if child2:IsA("Model") and child2:GetAttribute("Favorited") then
                        v22 = true;
                        break;
                    end;
                end;

                if not v22 then
                    v19[#v19 + 1] = v21;
                end;
            else
                v21 = child;
                v19[#v19 + 1] = v21;
            end;
        end;
    end;

    return v19;
end;

function v1.GetHarvestableFruits(p23: userdata, u24: string?, p25: string?, u26: boolean?) -- Line: 122
    -- upvalues: CollectionService (copy), PlantTraitsData (copy)
    local u27 = {};

    if not p23 then
        return u27;
    end;

    local Plants_Physical = p23:FindFirstChild("Plants_Physical", true);

    if not Plants_Physical then
        return u27;
    end;

    local u28 = p25 and string.lower(p25) or nil;

    for _, child in Plants_Physical:GetChildren() do
        if child:IsA("Model") then
            local function TryAdd(p29: userdata) -- Line: 136
                -- upvalues: CollectionService (ref), u26 (copy), u24 (copy), PlantTraitsData (ref), child (copy), u28 (copy), u27 (copy)
                if not p29:IsA("Model") then
                    return;
                end;

                if not CollectionService:HasTag(p29, "Harvestable") then
                    return;
                end;

                if u26 and p29:GetAttribute("Favorited") then
                    return;
                end;

                if u24 and not PlantTraitsData.HasTrait(child.Name, u24) then
                    return;
                end;

                if u28 and not string.find(string.lower(p29.Name), u28) then
                    return;
                end;

                u27[#u27 + 1] = p29;
            end;

            TryAdd(child);
            local Fruits = child:FindFirstChild("Fruits");

            if Fruits then
                for _, child2 in Fruits:GetChildren() do
                    TryAdd(child2);
                end;
            end;
        end;
    end;

    return u27;
end;

function v1.GetPlantsInRadius(p30: userdata, p31: vector, p32: number, p33: string?, p34: boolean?) -- Line: 159
    -- upvalues: PlantTraitsData (copy)
    if not p30 then
        return {};
    end;

    local Plants_Physical = p30:FindFirstChild("Plants_Physical", true);

    if not Plants_Physical then
        return {};
    end;

    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    OverlapParams_new_ret.FilterDescendantsInstances = { Plants_Physical };
    local v35 = {};
    local v36 = {};

    for _, v in workspace:GetPartBoundsInRadius(p31, p32, OverlapParams_new_ret) do
        local v37 = v:FindFirstAncestorOfClass("Model");

        if v37 and not v35[v37] then
            v35[v37] = true;

            if not (p34 and v37:GetAttribute("Favorited")) and ((not p33 or PlantTraitsData.HasTrait(v37.Name, p33)) and v37:FindFirstChild("Grow")) then
                v36[#v36 + 1] = v37;
            end;
        end;
    end;

    return v36;
end;

function v1.CountPetsByNameContains(p38: userdata, p39: string) -- Line: 198
    -- upvalues: PetUtilities (copy), SplitTokens (copy)
    local v40 = PetUtilities:GetPetsSortedByAge(p38, 0, false, true) or {};
    local v41 = SplitTokens(p39, ";");
    local v42 = 0;

    for _, v in v40 do
        local string_lower_ret = string.lower(v.PetType);

        for _, v2 in v41 do
            if string.find(string_lower_ret, v2) then
                v42 = v42 + 1;
                break;
            end;
        end;
    end;

    return v42;
end;

function v1.CountObjectsByName(p43: userdata, p44: string) -- Line: 218
    if not p43 then
        return 0;
    end;

    local Important = p43:FindFirstChild("Important", true);

    if not Important then
        return 0;
    end;

    local Objects_Physical = Important:FindFirstChild("Objects_Physical");

    if not Objects_Physical then
        return 0;
    end;

    local string_lower_ret = string.lower(p44);
    local v45 = 0;

    for _, child in Objects_Physical:GetChildren() do
        if string.find(string.lower(child.Name), string_lower_ret) then
            v45 = v45 + 1;
        end;
    end;

    return v45;
end;

function v1.FindCosmeticsInFarm(p46: userdata, p47: table) -- Line: 241
    local v48 = {};

    if not p46 then
        return v48;
    end;

    local Important = p46:FindFirstChild("Important", true);

    if not Important then
        return v48;
    end;

    local Cosmetic_Physical = Important:FindFirstChild("Cosmetic_Physical");

    if not Cosmetic_Physical then
        return v48;
    end;

    for _, child in Cosmetic_Physical:GetChildren() do
        if child:IsA("Model") then
            local v49 = child;

            for _, v in p47 do
                local v50 = v49:FindFirstChild(v);

                if v50 and v50:IsA("Model") then
                    v48[#v48 + 1] = v50:GetPivot();
                elseif v50 and v50:IsA("BasePart") then
                    v48[#v48 + 1] = v50.CFrame;
                end;
            end;
        end;
    end;

    return v48;
end;

function v1.GetRandomFromArray(p51) -- Line: 267
    if #p51 == 0 then
        return nil;
    end;

    return p51[math.random(1, #p51)];
end;

function v1.Shuffle(p52) -- Line: 272
    -- upvalues: ShuffleArray (copy)
    ShuffleArray(p52);
end;

return v1;