-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local DiscoSetColor_RE = game.ReplicatedStorage.GameEvents.DiscoSetColor_RE;
require(game.ReplicatedStorage.Modules.TableUtils);
local Calculate_Weight = require(game.ReplicatedStorage.Calculate_Weight);
local GetPlayerFromPlant = require(ReplicatedStorage.Modules.GetPlayerFromPlant);
local FruitsEnums = require(ReplicatedStorage.Data.EnumRegistry.FruitsEnums);
local PlantsEnums = require(ReplicatedStorage.Data.EnumRegistry.PlantsEnums);
local PlantTraitsData = require(ReplicatedStorage.Modules.PlantTraitsData);
local Task = require(ReplicatedStorage.Modules.Task);
local ThrottledTaskQueue = require(ReplicatedStorage.Modules.Task.ThrottledTaskQueue);
local InfGrowPlantData = require(ReplicatedStorage.Data.InfGrowPlantData);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {
    Potato = CFrame.Angles(1.5707963267948966, 0, 0)
};

local function IsJexInStudio() -- Line: 66
    -- upvalues: RunService (copy), Players (copy)
    if not RunService:IsStudio() then
        return false;
    end;

    for _, v in Players:GetPlayers() do
        if v.Name == "JexSavron" then
            return true;
        end;
    end;

    return false;
end;

local function MakeMutationAddedPartsNonCollidable(p9: userdata) -- Line: 76
    if p9:IsA("BasePart") then
        p9.CanCollide = false;
        p9.CanTouch = false;
        p9.CanQuery = false;
        p9.Massless = true;
    end;

    for _, descendant in p9:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
        end;
    end;
end;

local function PlaceOrnamentOnPart(p10: userdata, p11: userdata, p12: userdata, p13: number, p14: number) -- Line: 94
    -- upvalues: MakeMutationAddedPartsNonCollidable (copy)
    local u15 = {
        Enum.NormalId.Top,
        Enum.NormalId.Bottom,
        Enum.NormalId.Left,
        Enum.NormalId.Right,
        Enum.NormalId.Front,
        Enum.NormalId.Back
    };
    local v16 = {
        Color3.fromRGB(210, 47, 255),
        Color3.fromRGB(255, 60, 60),
        Color3.fromRGB(57, 255, 133),
        Color3.fromRGB(255, 159, 33),
        Color3.fromRGB(69, 125, 255),
        Color3.fromRGB(255, 233, 105),
        Color3.fromRGB(255, 23, 23),
        Color3.fromRGB(138, 185, 255)
    };

    local function pointIntersectsPart(p17: vector, p18: userdata, p19: number) -- Line: 133
        local v20 = p18.CFrame:PointToObjectSpace(p17);
        local v21 = p18.Size.X / 2;
        local v22 = p18.Size.Y / 2;
        local v23 = p18.Size.Z / 2;

        return math.abs(v20.X) <= v21 + p19 and (math.abs(v20.Y) <= v22 + p19 and math.abs(v20.Z) <= v23 + p19);
    end;

    local function surfacePointForFace(p24: userdata, p25: vector, p26: number) -- Line: 145
        local v27 = p24.Size.X / 2;
        local v28 = p24.Size.Y / 2;
        local v29 = p24.Size.Z / 2;
        local v30 = p24.CFrame:VectorToObjectSpace(p25);
        local v31 = math.abs(v30.X) * v27 + math.abs(v30.Y) * v28 + math.abs(v30.Z) * v29;

        return p24.CFrame.Position + p25 * (v31 + p26);
    end;

    local v36 = (function(p32: userdata) -- Line: 104, Name: getDownwardFace
        -- upvalues: u15 (copy)
        local v33 = (-1 / 0);
        local v34 = nil;

        for _, v in ipairs(u15) do
            local v35 = p32.CFrame:VectorToWorldSpace(Vector3.FromNormalId(v)):Dot(Vector3.new(0, -1, 0));

            if v33 < v35 then
                v34 = v;
                v33 = v35;
            end;
        end;

        return v34;
    end)(p10);
    local v37 = p10.CFrame:VectorToWorldSpace(Vector3.FromNormalId(v36));
    local v38 = p12:Clone();
    local v39 = v38.PrimaryPart or v38:FindFirstChildWhichIsA("BasePart");

    if not v39 then
        v38:Destroy();

        return nil;
    end;

    v38.PrimaryPart = v39;
    local v40 = surfacePointForFace(p10, v37, p14 + p13 + v39.Size.Magnitude / 2);

    for _, descendant in ipairs(p11:GetDescendants()) do
        if descendant:IsA("BasePart") and (descendant ~= p10 and pointIntersectsPart(v40, descendant, p13)) then
            v38:Destroy();

            return nil;
        end;
    end;

    v38.Parent = p11;
    MakeMutationAddedPartsNonCollidable(v38);
    v39.Color = v16[math.random(1, #v16)];
    v39.CFrame = CFrame.new(v40, v40 + v37);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v39;
    WeldConstraint.Part1 = p10;
    WeldConstraint.Parent = v39;
    local Stem = v38:FindFirstChild("Stem");

    if Stem and Stem:IsA("BasePart") then
        local Position = v39.Position;
        local v41 = surfacePointForFace(p10, v37, 0);
        Stem.Size = Vector3.new(Stem.Size.X, (v41 - Position).Magnitude, Stem.Size.Z);
        Stem.CFrame = CFrame.lookAt((Position + v41) / 2, v41) * CFrame.Angles(1.5707963267948966, 0, 0);
        local WeldConstraint2 = Instance.new("WeldConstraint");
        WeldConstraint2.Part0 = Stem;
        WeldConstraint2.Part1 = v39;
        WeldConstraint2.Parent = Stem;
    end;

    return v38;
end;

local function AddBoundingFX(p42: table, p43: userdata, p44: userdata, p45: number?) -- Line: 225
    -- upvalues: u8 (copy)
    p42:_RemoveFX(p43, p44);
    local Name = p42.Name;

    if not Name then
        warn("No Name on Mutation", p42);

        return;
    end;

    local Color = p42.Color;

    if not Color then
        warn("No Color on Mutation", p42);

        return;
    end;

    local v46 = {};

    for _, descendant in p43:GetDescendants() do
        if (descendant:IsA("BasePart") or (descendant:IsA("UnionOperation") or descendant:IsA("MeshPart") and descendant.Transparency < 1)) and not descendant:HasTag("Effect") then
            table.insert(v46, descendant);
        end;
    end;

    if #v46 == 0 then
        return;
    end;

    local v47 = Vector3.new(inf, inf, inf);
    local v48 = Vector3.new(-inf, -inf, -inf);

    for _, v in v46 do
        local CFrame2 = v.CFrame;
        local Size = v.Size;
        local v49 = {
            CFrame2 * Vector3.new(-Size.X / 2, -Size.Y / 2, -Size.Z / 2),
            CFrame2 * Vector3.new(Size.X / 2, -Size.Y / 2, -Size.Z / 2),
            CFrame2 * Vector3.new(-Size.X / 2, Size.Y / 2, -Size.Z / 2),
            CFrame2 * Vector3.new(Size.X / 2, Size.Y / 2, -Size.Z / 2),
            CFrame2 * Vector3.new(-Size.X / 2, -Size.Y / 2, Size.Z / 2),
            CFrame2 * Vector3.new(Size.X / 2, -Size.Y / 2, Size.Z / 2),
            CFrame2 * Vector3.new(-Size.X / 2, Size.Y / 2, Size.Z / 2),
            CFrame2 * Vector3.new(Size.X / 2, Size.Y / 2, Size.Z / 2)
        };

        for _, v2 in ipairs(v49) do
            local math_min_ret = math.min(v47.X, v2.X);
            local math_min_ret2 = math.min(v47.Y, v2.Y);
            local math_min_ret3 = math.min(v47.Z, v2.Z);
            v47 = Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
            local math_max_ret = math.max(v48.X, v2.X);
            local math_max_ret2 = math.max(v48.Y, v2.Y);
            local math_max_ret3 = math.max(v48.Z, v2.Z);
            v48 = Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
        end;
    end;

    local Rotation = p43:GetPivot().Rotation;
    local v50 = CFrame.new((v47 + v48) / 2) * Rotation;
    local Name2 = p43.Name;

    if p43:IsA("Tool") then
        Name2 = p43.Item_String.Value;
    end;

    if u8[Name2] then
        v50 = v50 * u8[Name2];
    end;

    local Part = Instance.new("Part");
    Part.Name = `{Name}Shell`;
    Part.Size = v48 - v47 + Vector3.new(0.1, 0.1, 0.1);
    Part.CFrame = v50;
    Part.Anchored = false;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Massless = true;
    Part.Transparency = p45 or 0.5;
    Part.CastShadow = false;
    Part.Color = Color;
    Part.Material = Enum.Material.Ice;
    Part:AddTag((`Cleanup_{Name}`));
    Part:AddTag("Effect");
    local v51 = p43.PrimaryPart or (p43:FindFirstChild("Handle") or p43:FindFirstChildOfClass("BasePart"));

    if v51 then
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = Part;
        WeldConstraint.Part1 = v51;
        WeldConstraint.Parent = Part;
        Part.Parent = v51;
    else
        Part:Destroy();
    end;

    local v52 = game.ServerStorage.Mutation_FX:FindFirstChild(Name);

    if v52 then
        for _, child in v52:GetChildren() do
            local v53 = child:Clone();
            v53.Parent = p44;
            v53.Enabled = true;
            v53:AddTag((`Cleanup_{Name}`));
        end;
    end;

    for _, descendant in p43:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
            descendant.Reflectance = 0.3;
        end;
    end;
end;

local function RemoveBoundingFX(p54: table, p55: userdata, p56: userdata) -- Line: 347
    local Name = p54.Name;

    if not Name then
        warn("No Name on Mutation", p54);

        return;
    end;

    local function cleanup(p57) -- Line: 355
        -- upvalues: Name (copy)
        for _, descendant in p57:GetDescendants() do
            if descendant:HasTag((`Cleanup_{Name}`)) then
                descendant:Destroy();
            end;
        end;
    end;

    if p56 then
        cleanup(p56);
    end;

    if p55 then
        cleanup(p55);
    end;

    for _, descendant in p55:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
            descendant.Reflectance = 0;
        end;
    end;
end;

function u1.CanBeMutated(p58: table, p59: userdata) -- Line: 370
    -- upvalues: InfGrowPlantData (copy)
    if not p59 then
        warn("MutationHandler.CanBeMutated | No plant given!");

        return false;
    end;

    local v60 = p59:HasTag("Harvestable") or p59:HasTag("FruitTool");
    local v61 = InfGrowPlantData.InfGrowPlants[p59.Name];

    return v60 and (not v61 and true or (v61.CanBeMutated or false));
end;

local function GetFXPart(p62: userdata) -- Line: 391
    -- upvalues: RunService (copy), Players (copy)
    if not p62 then
        warn("MutationHandler.GetFXPart | No plant given!");

        return nil;
    end;

    if not p62:IsDescendantOf(game) then
        return nil;
    end;

    local v63 = {};

    if #v63 == 1 then
        return v63[1];
    end;

    if #v63 > 1 then
        return v63;
    end;

    local v64 = p62:IsA("Tool") and p62:WaitForChild("Handle", 0.3);

    if v64 then
        return v64;
    end;

    if p62.PrimaryPart then
        return p62.PrimaryPart;
    end;

    local v65;

    if RunService:IsStudio() then
        v65 = false;

        for _, v in Players:GetPlayers() do
            if v.Name == "JexSavron" then
                v65 = true;
                break;
            end;
        end;
    else
        v65 = false;
    end;

    if v65 then
        warn((`MutationHandler.GetFXPart | No valid FX part found for {p62:GetFullName()} of type {p62.ClassName}`));
    end;

    return nil;
end;

local function IsPermanentlyHidden(p66: userdata) -- Line: 434
    return p66:IsA("TrussPart") or (p66:GetAttribute("DontShow") ~= nil and true or p66:HasTag("NoMutationVisual"));
end;

local function SnapshotHiddenParts(p67: userdata) -- Line: 440
    local v68 = {};

    for _, descendant in p67:GetDescendants() do
        if descendant:IsA("BasePart") and (descendant:IsA("TrussPart") or (descendant:GetAttribute("DontShow") ~= nil or descendant:HasTag("NoMutationVisual"))) then
            v68[descendant] = descendant:IsA("TrussPart") and 1 or descendant.Transparency;
        end;
    end;

    return v68;
end;

local function RestoreHiddenParts(p69: table) -- Line: 452
    for i, v in p69 do
        if i.Parent and i.Transparency ~= v then
            i.Transparency = v;
        end;
    end;
end;

function u1.IsPartPermanentlyHidden(p70: table, p71: userdata) -- Line: 462
    local v72 = p71:IsA("BasePart") and (p71:IsA("TrussPart") or (p71:GetAttribute("DontShow") ~= nil and true or p71:HasTag("NoMutationVisual")));

    return v72;
end;

function u1.PreserveHiddenParts(p73: table, p74: userdata, p75: function) -- Line: 470
    -- upvalues: SnapshotHiddenParts (copy)
    if not p74 then
        p75();

        return;
    end;

    local v76 = SnapshotHiddenParts(p74);
    local success, result = pcall(p75);

    for i, v in v76 do
        if i.Parent and i.Transparency ~= v then
            i.Transparency = v;
        end;
    end;

    if not success then
        warn((`MutationHandler.PreserveHiddenParts | FX pass errored: {result}`));
    end;
end;

local u77 = {};

local function GetMutationFXCost(p78: table) -- Line: 486
    -- upvalues: u77 (copy)
    local v79 = u77[p78];

    if v79 then
        return v79;
    end;

    local v80 = game.ServerStorage.Mutation_FX:FindFirstChild(p78.Name);
    local v81 = v80 and #v80:GetDescendants() or 0;
    u77[p78] = v81;

    return v81;
end;

local function UpdateFX(u82: userdata) -- Line: 497
    -- upvalues: u1 (copy), u77 (copy), Task (copy), GetFXPart (copy)
    local u83 = {};
    local u84 = {};

    for _, v in u1:GetMutations() do
        if not u82:GetAttribute(v.Name) then
            u84[v] = v._RemoveFX;
        end;

        if u82:GetAttribute(v.Name) then
            local v85 = {
                Mutation = v,
                AddFunc = v._AddFX
            };
            local v86 = u77[v];

            if not v86 then
                local v87 = game.ServerStorage.Mutation_FX:FindFirstChild(v.Name);
                v86 = v87 and #v87:GetDescendants() or 0;
                u77[v] = v86;
            end;

            v85.Cost = v86;
            table.insert(u83, v85);
        end;
    end;

    table.sort(u83, function(p88, p89) -- Line: 509
        if p88.Cost == p89.Cost then
            return p88.Mutation.Name < p89.Mutation.Name;
        end;

        return p88.Cost > p89.Cost;
    end);

    return Task.run(function() -- Line: 517
        -- upvalues: u82 (copy), GetFXPart (ref), u1 (ref), u84 (copy), u83 (copy)
        local os_time_ret = os.time();

        while os.time() - os_time_ret <= 10 do
            task.wait();

            if u82:HasTag("PlantGenerated") or (u82:HasTag("FoodGenerated") or (u82:HasTag("Harvestable") or (u82:HasTag("FruitTool") or u82:HasTag("PlantScaled")))) then
                break;
            end;
        end;

        local u90 = GetFXPart(u82);

        local function ApplyFX(p91, p92, p93, p94) -- Line: 536
            if typeof(p94) == "table" then
                for _, v in ipairs(p94) do
                    p91(p92, p93, v);
                end;

                return;
            end;

            if p94 then
                p91(p92, p93, p94);
            end;
        end;

        local u95 = 0;
        u1:PreserveHiddenParts(u82, function() -- Line: 549
            -- upvalues: u84 (ref), ApplyFX (copy), u82 (ref), u90 (copy), u83 (ref), u95 (ref)
            for i, v in u84 do
                ApplyFX(v, i, u82, u90);
            end;

            for _, v in u83 do
                if u95 < 50 then
                    u95 = u95 + 1;
                    ApplyFX(v.AddFunc, v.Mutation, u82, u90);

                    if u95 % 5 == 0 then
                        if #u82:GetDescendants() > 800 then
                            break;
                        end;

                        task.wait();
                    end;
                end;
            end;
        end);
    end);
end;

local u96 = 0;

local function EnumerationGeneration() -- Line: 576
    -- upvalues: u96 (ref)
    u96 = u96 + 1;

    return u96;
end;

local u2161 = {
    Shocked = {
        Id = "a",
        Name = "Shocked",
        ValueMulti = 100,
        Color = Color3.fromRGB(255, 255, 100),

        _AddFX = function(p97: any, p98: userdata, p99: userdata) -- Line: 588, Name: _AddFX
            -- upvalues: u6 (copy)
            p97:_RemoveFX(p98, p99);

            if p99 then
                for _, child in game.ServerStorage.Mutation_FX.Shocked:GetChildren() do
                    local v100 = child:Clone();
                    v100.Parent = p99;
                    v100:AddTag("Cleanup_Shock");
                end;
            end;

            for _, descendant in p98:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                end;
            end;
        end,

        _RemoveFX = function(p101: any, p102: userdata, p103: userdata) -- Line: 611, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p103 then
                for _, child in p103:GetChildren() do
                    if child:HasTag("Cleanup_Shock") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p102:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and u6[descendant] then
                    if not descendant:HasTag("Effect") then
                        descendant.Material = u6[descendant];
                    end;

                    u6[descendant] = nil;
                end;
            end;
        end
    },
    Windstruck = {
        Id = "b",
        Name = "Windstruck",
        ValueMulti = 2,
        Color = Color3.fromRGB(162, 185, 209),

        _AddFX = function(p104: any, p105: userdata, p106: userdata) -- Line: 636, Name: _AddFX
            p104:_RemoveFX(p105, p106);

            if p106 then
                for _, child in game.ServerStorage.Mutation_FX.Twisted:GetChildren() do
                    local v107 = child:Clone();
                    v107.Parent = p106;
                    v107:AddTag("Cleanup_Windstruck");
                end;
            end;
        end,

        _RemoveFX = function(p108: any, p109: userdata, p110: userdata) -- Line: 651, Name: _RemoveFX
            if p110 then
                for _, child in p110:GetChildren() do
                    if child:HasTag("Cleanup_Windstruck") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Dawnbound = {
        Id = "c",
        Name = "Dawnbound",
        ValueMulti = 150,
        Color = Color3.fromRGB(255, 213, 0),

        _AddFX = function(p111: any, p112: userdata, p113: userdata) -- Line: 668, Name: _AddFX
            -- upvalues: u6 (copy)
            p111:_RemoveFX(p112, p113);

            if p113 then
                for _, child in game.ServerStorage.Mutation_FX.Twisted:GetChildren() do
                    local v114 = child:Clone();
                    v114.Parent = p113;
                    v114:AddTag("Cleanup_Dawnbound");
                end;
            end;

            for _, descendant in p112:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                    descendant.Reflectance = 0.05;
                    descendant:AddTag("DawnboundVisual");
                end;
            end;
        end,

        _RemoveFX = function(p115: any, p116: userdata, p117: userdata) -- Line: 695, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p117 then
                for _, child in p117:GetChildren() do
                    if child:HasTag("Cleanup_Dawnbound") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p116:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("DawnboundVisual") then
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("DawnboundVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Beanbound = {
        Id = "bb",
        Name = "Beanbound",
        ValueMulti = 100,
        Color = Color3.fromRGB(53, 184, 75),

        _AddFX = function(p118: any, p119: userdata, p120: userdata) -- Line: 726, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p118:_RemoveFX(p119, p120);
            local v121 = p119:FindFirstChild("Item_Seed") and (p119.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v121);
            local v122 = {
                Color3.fromRGB(30, 135, 45),
                Color3.fromRGB(45, 170, 60),
                Color3.fromRGB(53, 184, 75),
                Color3.fromRGB(75, 215, 85),
                Color3.fromRGB(105, 240, 105),
                Color3.fromRGB(145, 255, 120)
            };

            if p120 then
                for _, child in game.ServerStorage.Mutation_FX.Twisted:GetChildren() do
                    local v123 = child:Clone();
                    v123.Parent = p120;

                    if v123:IsA("ParticleEmitter") or (v123:IsA("Trail") or v123:IsA("Beam")) then
                        v123.Enabled = true;
                    end;

                    v123:AddTag("Cleanup_Beanbound");
                end;
            end;

            for _, descendant in p119:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    if descendant:IsA("UnionOperation") then
                        descendant.UsePartColor = true;
                    end;

                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = v122[Random_new_ret:NextInteger(1, #v122)];
                    descendant.Material = Enum.Material.Neon;
                    descendant.Reflectance = 0.05;
                    descendant:AddTag("BeanboundVisual");
                end;
            end;
        end,

        _RemoveFX = function(p124: any, p125: userdata, p126: userdata) -- Line: 775, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function Cleanup(p127) -- Line: 776
                for _, descendant in p127:GetDescendants() do
                    if descendant:HasTag("Cleanup_Beanbound") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p126 then
                Cleanup(p126);
            end;

            if p125 then
                Cleanup(p125);
            end;

            for _, descendant in p125:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BeanboundVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                    descendant:RemoveTag("BeanboundVisual");
                end;
            end;
        end
    },
    Twisted = {
        Id = "d",
        Name = "Twisted",
        ValueMulti = 5,
        Color = Color3.fromRGB(191, 191, 191),

        _AddFX = function(p128: any, p129: userdata, p130: userdata) -- Line: 812, Name: _AddFX
            p128:_RemoveFX(p129, p130);

            if p130 then
                for _, child in game.ServerStorage.Mutation_FX.Twisted:GetChildren() do
                    local v131 = child:Clone();
                    v131.Parent = p130;
                    v131:AddTag("Cleanup_Twisted");
                end;
            end;
        end,

        _RemoveFX = function(p132: any, p133: userdata, p134: userdata) -- Line: 827, Name: _RemoveFX
            if p134 then
                for _, child in p134:GetChildren() do
                    if child:HasTag("Twisted") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Cloudtouched = {
        Id = "e",
        Name = "Cloudtouched",
        ValueMulti = 5,
        Color = Color3.fromRGB(225, 255, 255),

        _AddFX = function(p135: any, p136: userdata, p137: userdata) -- Line: 844, Name: _AddFX
            p135:_RemoveFX(p136, p137);

            if p137 then
                for _, child in game.ServerStorage.Mutation_FX.Cloudtouched:GetChildren() do
                    local v138 = child:Clone();
                    v138.Parent = p137;
                    v138:AddTag("Cleanup_Cloudtouched");
                end;
            end;
        end,

        _RemoveFX = function(p139: any, p140: userdata, p141: userdata) -- Line: 859, Name: _RemoveFX
            if p141 then
                for _, child in p141:GetChildren() do
                    if child:HasTag("Cleanup_Cloudtouched") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Voidtouched = {
        Id = "f",
        Name = "Voidtouched",
        ValueMulti = 135,
        Color = Color3.fromRGB(225, 0, 255),

        _AddFX = function(p142: any, p143: userdata, p144: userdata) -- Line: 876, Name: _AddFX
            p142:_RemoveFX(p143, p144);

            if p144 then
                for _, child in game.ServerStorage.Mutation_FX.Voidtouched:GetChildren() do
                    local v145 = child:Clone();
                    v145.Parent = p144;
                    v145:AddTag("Cleanup_Voidtouched");
                end;
            end;
        end,

        _RemoveFX = function(p146: any, p147: userdata, p148: userdata) -- Line: 891, Name: _RemoveFX
            if p148 then
                for _, child in p148:GetChildren() do
                    if child:HasTag("Cleanup_Voidtouched") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Wet = {
        Id = "g",
        Name = "Wet",
        ValueMulti = 2,
        Color = Color3.fromRGB(64, 164, 223),

        _AddFX = function(p149: any, p150: userdata, p151: userdata) -- Line: 908, Name: _AddFX
            p149:_RemoveFX(p150, p151);

            if p151 then
                for _, child in game.ServerStorage.Mutation_FX.Wet:GetChildren() do
                    local v152 = child:Clone();
                    v152.Parent = p151;
                    v152.Enabled = true;
                    v152:AddTag("Cleanup_Wet");
                end;
            end;
        end,

        _RemoveFX = function(p153: any, p154: userdata, p155: userdata) -- Line: 922, Name: _RemoveFX
            if p155 then
                for _, child in p155:GetChildren() do
                    if child:HasTag("Cleanup_Wet") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Fried = {
        Id = "h",
        Name = "Fried",
        ValueMulti = 8,
        Color = Color3.fromRGB(223, 110, 34),

        _AddFX = function(p156: any, p157: userdata, p158: userdata) -- Line: 938, Name: _AddFX
            p156:_RemoveFX(p157, p158);

            if p158 then
                for _, child in game.ServerStorage.Mutation_FX.Fried:GetChildren() do
                    local v159 = child:Clone();
                    v159.Parent = p158;
                    v159.Enabled = true;
                    v159:AddTag("Cleanup_Fried");
                end;
            end;
        end,

        _RemoveFX = function(p160: any, p161: userdata, p162: userdata) -- Line: 952, Name: _RemoveFX
            if p162 then
                for _, child in p162:GetChildren() do
                    if child:HasTag("Cleanup_Fried") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Molten = {
        Id = "i",
        Name = "Molten",
        ValueMulti = 25,
        Color = Color3.fromRGB(223, 100, 0),

        _AddFX = function(p163: any, p164: userdata, p165: userdata) -- Line: 968, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p163:_RemoveFX(p164, p165);
            local v166 = { "Neon orange", "Br. yellowish orange", "Bright orange", "Bright red", "Bright yellow" };

            for _, descendant in p164:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.BrickColor.Color;
                    descendant.BrickColor = BrickColor.new(v166[Random.new():NextInteger(1, #v166)]);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("MoltenVisual");
                end;
            end;
        end,

        _RemoveFX = function(p167: any, p168: userdata, p169: userdata) -- Line: 993, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            for _, descendant in p168:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MoltenVisual") then
                    descendant.Reflectance = 0;
                    local v170;

                    if u3[descendant] then
                        v170 = BrickColor.new(u3[descendant]);
                    else
                        v170 = descendant.BrickColor;
                    end;

                    descendant.BrickColor = v170;
                    u3[descendant] = nil;
                    descendant:RemoveTag("MoltenVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Vamp = {
        Id = "Vam",
        Name = "Vamp",
        ValueMulti = 3,
        Color = Color3.fromRGB(139, 0, 0),

        _AddFX = function(p171: any, p172: userdata, p173: userdata) -- Line: 1018, Name: _AddFX
            -- upvalues: u3 (copy)
            p171:_RemoveFX(p172, p173);

            if p173 then
                for _, child in game.ServerStorage.Mutation_FX.Vamp:GetChildren() do
                    if child.Name == "CenterGlow" then
                        local v174 = child:Clone();
                        v174.Parent = p173;
                        v174.Glow.Enabled = true;

                        if v174:FindFirstChild("Flapping") then
                            v174.Flapping.PlaybackSpeed = math.random(7, 13) / 10;
                            v174.Flapping:Play();
                        end;

                        local _, v175 = p172:GetBoundingBox();
                        local _ = math.max(v175.X, v175.Y, v175.Z) * 0.3;
                        local v176 = {};

                        for _, v in ipairs(v174.Glow.Size.Keypoints) do
                            table.insert(v176, NumberSequenceKeypoint.new(v.Time, v.Value * 0.3, v.Envelope * 0.3));
                        end;

                        v174.Glow.Size = NumberSequence.new(v176);
                    else
                        local v177 = child:Clone();
                        v177.Parent = p173;
                        v177.Enabled = true;
                        v177:AddTag("Cleanup_Vamp");
                    end;
                end;
            end;

            for _, descendant in p172:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency ~= 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    local Color3_new_ret = Color3.new(0.545098, 0, 0);
                    descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.4);
                    descendant:AddTag("VampVisual");
                end;
            end;
        end,

        _RemoveFX = function(p178: any, p179: userdata, p180: userdata) -- Line: 1079, Name: _RemoveFX
            -- upvalues: u3 (copy)
            if p180 then
                for _, child in p180:GetChildren() do
                    if child:HasTag("Cleanup_Vamp") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p179:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("VampVisual") then
                    descendant:RemoveTag("VampVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Moonbled = {
        Id = "Mnb",
        Name = "Moonbled",
        ValueMulti = 25,
        Color = Color3.fromRGB(139, 139, 139),

        _AddFX = function(p181: any, p182: userdata, p183: userdata) -- Line: 1106, Name: _AddFX
            -- upvalues: u3 (copy)
            p181:_RemoveFX(p182, p183);

            if p183 then
                for _, child in game.ServerStorage.Mutation_FX.Moonbled:GetChildren() do
                    if child.Name == "CenterWave" then
                        local v184 = child:Clone();
                        v184.Parent = p183;
                        v184.Wave.Enabled = true;
                        local _, v185 = p182:GetBoundingBox();
                        local _ = math.max(v185.X, v185.Y, v185.Z) * 0.3;
                        local v186 = {};

                        for _, v in ipairs(v184.Wave.Size.Keypoints) do
                            table.insert(v186, NumberSequenceKeypoint.new(v.Time, v.Value * 0.3, v.Envelope * 0.3));
                        end;

                        v184.Wave.Size = NumberSequence.new(v186);
                    else
                        local v187 = child:Clone();
                        v187.Parent = p183;
                        v187.Enabled = true;
                        v187:AddTag("Cleanup_Moonbled");
                    end;
                end;
            end;

            for i, descendant in p182:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 3 == 0 then
                        local v188 = game.ServerStorage.Mutation_FX.Moonbled.Fog:Clone();
                        v188.Parent = descendant;
                        v188.Enabled = true;
                        v188.Rate = math.random(8, 25) / 10;
                        v188:AddTag("Cleanup_Moonbled");
                        local v189 = game.ServerStorage.Mutation_FX.Moonbled.Rays:Clone();
                        v189.Parent = descendant;
                        v189.Enabled = true;
                        v189.Rate = math.random(8, 25) / 10;
                        v189:AddTag("Cleanup_Moonbled");
                    end;

                    if not descendant:HasTag("Effect") and descendant.Transparency ~= 1 then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        local Color3_new_ret = Color3.new(0.658824, 0.658824, 0.658824);
                        descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.8);
                        descendant:AddTag("MoonbledVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p190: any, p191: userdata, p192: userdata) -- Line: 1175, Name: _RemoveFX
            -- upvalues: u3 (copy)
            if p192 then
                for _, child in p192:GetChildren() do
                    if child:HasTag("Cleanup_Moonbled") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p191:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MoonbledVisual") then
                    descendant:RemoveTag("MoonbledVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Moist = {
        Id = "Moi",
        Name = "Moist",
        ValueMulti = 3,
        Color = Color3.fromRGB(142, 161, 173),

        _AddFX = function(p193: any, p194: userdata, p195: userdata) -- Line: 1202, Name: _AddFX
            -- upvalues: u3 (copy)
            p193:_RemoveFX(p194, p195);

            if p195 then
                for _, child in game.ServerStorage.Mutation_FX.Moist:GetChildren() do
                    local v196 = child:Clone();
                    v196.Parent = p195;
                    v196.Enabled = true;
                    v196:AddTag("Cleanup_Moist");
                end;
            end;

            for i, descendant in p194:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 3 == 0 then
                        local v197 = game.ServerStorage.Mutation_FX.Moist.Drops:Clone();
                        v197.Parent = descendant;
                        v197.Enabled = true;
                        v197.Rate = math.random(5, 30) / 100;
                        v197:AddTag("Moist");
                        local v198 = game.ServerStorage.Mutation_FX.Moist.Mist:Clone();
                        v198.Parent = descendant;
                        v198.Enabled = true;
                        v198.Rate = math.random(2, 8) / 10;
                        v198:AddTag("Moist");
                    end;

                    if not descendant:HasTag("Effect") and descendant.Transparency ~= 1 then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        local Color3_new_ret = Color3.new(0, 0, 0);
                        descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.2);
                        descendant:AddTag("MoistVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p199: any, p200: userdata, p201: userdata) -- Line: 1246, Name: _RemoveFX
            -- upvalues: u3 (copy)
            if p201 then
                for _, child in p201:GetChildren() do
                    if child:HasTag("Cleanup_Moist") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p200:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MoistVisual") then
                    descendant:RemoveTag("MoistVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Crystalized = {
        Id = "Cry",
        Name = "Crystalized",
        ValueMulti = 25,
        Color = Color3.fromRGB(255, 255, 255),

        _AddFX = function(p202: any, p203: userdata, p204: userdata) -- Line: 1273, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p202:_RemoveFX(p203, p204);

            if p204 then
                for _, child in game.ServerStorage.Mutation_FX.Crystalized:GetChildren() do
                    local v205 = child:Clone();
                    v205.Parent = p204;
                    v205.Enabled = true;
                end;
            end;

            for i, descendant in p203:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 4 == 0 then
                        local v206 = game.ServerStorage.Mutation_FX.Crystalized.Aura:Clone();
                        v206.Parent = descendant;
                        v206.Enabled = true;
                        v206.Rate = math.random(8, 25) / 10;
                        v206:AddTag("Cleanup_Crystalized");
                        local v207 = game.ServerStorage.Mutation_FX.Crystalized.Sparkle:Clone();
                        v207.Parent = descendant;
                        v207.Enabled = true;
                        v207.Rate = math.random(8, 25) / 10;
                        v207:AddTag("Cleanup_Crystalized");
                    end;

                    if not descendant:HasTag("Effect") and descendant.Transparency ~= 1 then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Material = Enum.Material.Glass;
                        local Color3_new_ret = Color3.new(1, 1, 1);
                        descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.65);
                        descendant:AddTag("CrystalizedVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p208: any, p209: userdata, p210: userdata) -- Line: 1318, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p210 then
                for _, child in p210:GetChildren() do
                    if child:HasTag("Cleanup_Crystalized") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p209:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CrystalizedVisual") then
                    descendant:RemoveTag("CrystalizedVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Alienated = {
        Id = "Ali",
        Name = "Alienated",
        ValueMulti = 25,
        Color = Color3.fromRGB(55, 255, 0),

        _AddFX = function(p211: any, p212: userdata, p213: userdata) -- Line: 1348, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p211:_RemoveFX(p212, p213);

            if p213 then
                for _, child in game.ServerStorage.Mutation_FX.Alienated:GetChildren() do
                    local v214 = child:Clone();
                    v214.Parent = p213;
                    v214.Enabled = true;
                end;
            end;

            for i, descendant in p212:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 5 == 0 then
                        local v215 = game.ServerStorage.Mutation_FX.Alienated.Aura:Clone();
                        v215.Parent = descendant;
                        v215.Enabled = true;
                        v215.Rate = math.random(8, 25) / 20;
                        v215:AddTag("Cleanup_Alienated");
                        local v216 = game.ServerStorage.Mutation_FX.Alienated.Shines:Clone();
                        v216.Parent = descendant;
                        v216.Enabled = true;
                        v216.Rate = math.random(8, 25) / 30;
                        v216:AddTag("Cleanup_Alienated");
                    end;

                    if not descendant:HasTag("Effect") and descendant.Transparency ~= 1 then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Material = Enum.Material.Neon;
                        local Color3_new_ret = Color3.new(0, 1, 0.45098);
                        descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.4);
                        descendant:AddTag("AlienatedVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p217: any, p218: userdata, p219: userdata) -- Line: 1393, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p219 then
                for _, child in p219:GetChildren() do
                    if child:HasTag("Cleanup_Alienated") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p218:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("AlienatedVisual") then
                    descendant:RemoveTag("AlienatedVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Brewed = {
        Id = "Brw",
        Name = "Brewed",
        ValueMulti = 7,
        Color = Color3.fromRGB(65, 203, 74),

        _AddFX = function(p220: any, p221: userdata, p222: userdata) -- Line: 1423, Name: _AddFX
            -- upvalues: u3 (copy)
            p220:_RemoveFX(p221, p222);

            if p222 then
                for _, child in game.ServerStorage.Mutation_FX.Brewed:GetChildren() do
                    if child.Name == "CenterWave" then
                        local v223 = child:Clone();
                        v223.Parent = p222;
                        v223.Wave.Enabled = true;
                        local _, v224 = p221:GetBoundingBox();
                        local _ = math.max(v224.X, v224.Y, v224.Z) * 0.3;
                        local v225 = {};

                        for _, v in ipairs(v223.Wave.Size.Keypoints) do
                            table.insert(v225, NumberSequenceKeypoint.new(v.Time, v.Value * 0.3, v.Envelope * 0.3));
                        end;

                        v223.Wave.Size = NumberSequence.new(v225);
                    else
                        local v226 = child:Clone();
                        v226.Parent = p222;
                        v226.Enabled = true;
                        v226:AddTag("Cleanup_Brewed");
                    end;
                end;
            end;

            for i, descendant in p221:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 3 == 0 then
                        local v227 = game.ServerStorage.Mutation_FX.Brewed.Smoke:Clone();
                        v227.Parent = descendant;
                        v227.Enabled = true;
                        v227.Rate = math.random(8, 25) / 10;
                        v227:AddTag("Cleanup_Brewed");
                        local v228 = game.ServerStorage.Mutation_FX.Brewed.Drip:Clone();
                        v228.Parent = descendant;
                        v228.Enabled = true;
                        v228.Rate = math.random(8, 25) / 10;
                        v228:AddTag("Cleanup_Brewed");
                        local v229 = game.ServerStorage.Mutation_FX.Brewed.CenterWave.Wave:Clone();
                        v229.Parent = descendant;
                        v229.Enabled = true;
                        v229.Rate = math.random(8, 25) / 20;
                        v229:AddTag("Cleanup_Brewed");
                    end;

                    if not descendant:HasTag("Effect") and descendant.Transparency ~= 1 then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        local Color3_new_ret = Color3.new(0.247059, 0.658824, 0.215686);
                        descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.3);
                        descendant:AddTag("BrewedVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p230: any, p231: userdata, p232: userdata) -- Line: 1497, Name: _RemoveFX
            -- upvalues: u3 (copy)
            if p232 then
                for _, child in p232:GetChildren() do
                    if child:HasTag("Cleanup_Brewed") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p231:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BrewedVisual") then
                    descendant:RemoveTag("BrewedVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Ghostly = {
        Id = "GH",
        Name = "Ghostly",
        ValueMulti = 25,
        Color = Color3.fromRGB(170, 255, 255),

        _AddFX = function(p233: any, p234: userdata, p235: userdata) -- Line: 1524, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p233:_RemoveFX(p234, p235);
            local Children = game.ServerStorage.Mutation_FX.Ghostly:GetChildren();

            if p235 then
                for _, v in Children do
                    if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        local v236 = v:Clone();
                        v236.Parent = p235;
                        v236.Enabled = true;
                        v236:AddTag("Cleanup_Ghostly");
                    end;
                end;
            end;

            local v237 = 0;

            for _, descendant in p234:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:IsA("TrussPart") then
                    v237 = v237 + 1;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Glass;
                    descendant.Color = Color3.fromRGB(200, 235, 255);

                    if descendant.Transparency ~= 1 then
                        descendant.Transparency = 0.35;
                        descendant:SetAttribute("0Transparency", descendant.Transparency);
                    end;

                    descendant:AddTag("GhostlyVisual");

                    if v237 % 3 == 0 and #Children > 0 then
                        local v238 = Children[math.random(1, #Children)];

                        if v238:IsA("ParticleEmitter") then
                            local v239 = v238:Clone();
                            v239.Parent = descendant;
                            v239.Enabled = true;
                            v239:AddTag("Cleanup_Ghostly");
                        end;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p240: any, p241: userdata, p242: userdata) -- Line: 1575, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v244(p243) -- Line: 1576
                for _, descendant in p243:GetDescendants() do
                    if descendant:HasTag("Cleanup_Ghostly") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p242 then
                v244(p242);
            end;

            if p241 then
                v244(p241);
            end;

            for _, descendant in p241:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("GhostlyVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;

                    if descendant:GetAttribute("0Transparency") then
                        descendant.Transparency = descendant:GetAttribute("0Transparency");
                    end;

                    descendant:RemoveTag("GhostlyVisual");
                end;
            end;
        end
    },
    Haunted = {
        Id = "HA",
        Name = "Haunted",
        ValueMulti = 4,
        Color = Color3.fromRGB(150, 70, 230),

        _AddFX = function(p245: any, p246: userdata, p247: userdata) -- Line: 1610, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p245:_RemoveFX(p246, p247);
            local Children = game.ServerStorage.Mutation_FX.Haunted:GetChildren();

            if p247 then
                for _, v in Children do
                    if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        local v248 = v:Clone();
                        v248.Parent = p247;
                        v248.Enabled = true;
                        v248:AddTag("Cleanup_Haunted");
                    end;
                end;
            end;

            local v249 = {};
            local v250 = (1 / 0);
            local v251 = (-1 / 0);

            for _, descendant in p246:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:IsA("TrussPart") then
                    table.insert(v249, descendant);
                    local Y = descendant.Position.Y;

                    if Y < v250 then
                        v250 = Y;
                    end;

                    if v251 < Y then
                        v251 = Y;
                    end;
                end;
            end;

            local math_max_ret = math.max(v251 - v250, 0.001);
            local Color3_fromRGB_ret = Color3.fromRGB(70, 20, 130);
            local Color3_fromRGB_ret2 = Color3.fromRGB(205, 160, 255);

            for i, v in v249 do
                u3[v] = u3[v] or v.Color;
                u6[v] = u6[v] or v.Material;
                v.Material = Enum.Material.Glass;
                v.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, (math.clamp((v.Position.Y - v250) / math_max_ret, 0, 1)));

                if v.Transparency ~= 1 then
                    if v:GetAttribute("0Transparency") == nil then
                        v:SetAttribute("0Transparency", v.Transparency);
                    end;

                    v.Transparency = 0.35;
                end;

                v:AddTag("HauntedVisual");

                if i % 3 == 0 and #Children > 0 then
                    local v252 = Children[math.random(1, #Children)];

                    if v252:IsA("ParticleEmitter") then
                        local v253 = v252:Clone();
                        v253.Parent = v;
                        v253.Enabled = true;
                        v253:AddTag("Cleanup_Haunted");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p254: any, p255: userdata, p256: userdata) -- Line: 1670, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v258(p257) -- Line: 1671
                for _, descendant in p257:GetDescendants() do
                    if descendant:HasTag("Cleanup_Haunted") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p256 then
                v258(p256);
            end;

            if p255 then
                v258(p255);
            end;

            for _, descendant in p255:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("HauntedVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;

                    if descendant:GetAttribute("0Transparency") ~= nil then
                        descendant.Transparency = descendant:GetAttribute("0Transparency");
                        descendant:SetAttribute("0Transparency", nil);
                    end;

                    descendant:RemoveTag("HauntedVisual");
                end;
            end;
        end
    },
    Spooky = {
        Id = "SK",
        Name = "Spooky",
        ValueMulti = 8,
        Color = Color3.fromRGB(177, 177, 177),

        _AddFX = function(p259: any, p260: userdata, p261: userdata) -- Line: 1707, Name: _AddFX
            p259:_RemoveFX(p260, p261);
            local Children = game.ServerStorage.Mutation_FX.Spooky:GetChildren();
            local v262 = 0;
            local v263 = 0;

            for _, descendant in p260:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p261 then
                    v262 = v262 + 1;

                    if v262 % 2 == 0 and v263 < 8 then
                        v263 = v263 + 1;
                        local v264 = descendant;

                        for _, v in Children do
                            if v:IsA("ParticleEmitter") then
                                local v265 = v:Clone();
                                v265.Parent = v264;
                                v265.Enabled = true;
                                v265:AddTag("Cleanup_Spooky");
                            end;
                        end;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p266: any, p267: userdata, p268: userdata) -- Line: 1734, Name: _RemoveFX
            local function v270(p269) -- Line: 1735
                for _, descendant in p269:GetDescendants() do
                    if descendant:HasTag("Cleanup_Spooky") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p268 then
                v270(p268);
            end;

            if p267 then
                v270(p267);
            end;
        end
    },
    Volcanic = {
        Id = "Bla",
        Name = "Volcanic",
        ValueMulti = 25,
        Color = Color3.fromRGB(255, 82, 24),

        _AddFX = function(p271: any, p272: userdata, p273: userdata) -- Line: 1754, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p271:_RemoveFX(p272, p273);
            local v274 = { Color3.fromRGB(229, 67, 13), Color3.fromRGB(225, 89, 26), Color3.fromRGB(234, 71, 39) };

            if p273 then
                for _, child in game.ServerStorage.Mutation_FX.Volcanic:GetChildren() do
                    local v275 = child:Clone();
                    v275.Parent = p273;
                    v275.Enabled = true;
                    v275:AddTag("Cleanup_Volcanic");
                end;
            end;

            for i, descendant in p272:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v276 = game.ServerStorage.Mutation_FX.Volcanic.Burst:Clone();
                        v276.Parent = descendant;
                        v276.Enabled = true;
                        v276.Rate = math.random(6, 12) / 10;
                        v276:AddTag("Cleanup_Volcanic");
                        local v277 = game.ServerStorage.Mutation_FX.Volcanic.Glow:Clone();
                        v277.Parent = descendant;
                        v277.Enabled = true;
                        v277.Rate = math.random(9, 20) / 100;
                        v277:AddTag("Cleanup_Volcanic");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        descendant.Color = v274[Random.new():NextInteger(1, #v274)];
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Material = Enum.Material.Neon;
                        descendant:AddTag("VolcanicVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p278: any, p279: userdata, p280: userdata) -- Line: 1799, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p280 then
                for _, child in p280:GetChildren() do
                    if child:HasTag("Cleanup_Volcanic") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p279:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if descendant:HasTag("VolcanicVisual") then
                        descendant.Reflectance = 0;
                        local v281;

                        if u3[descendant] then
                            v281 = BrickColor.new(u3[descendant]);
                        else
                            v281 = descendant.BrickColor;
                        end;

                        descendant.BrickColor = v281;
                        u3[descendant] = nil;
                        descendant:RemoveTag("VolcanicVisual");

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    elseif descendant:HasTag("Cleanup_Volcanic") then
                        descendant:Destroy();
                    end;
                end;
            end;
        end
    },
    Slashbound = {
        Id = "SB",
        Name = "Slashbound",
        ValueMulti = 95,
        Color = Color3.fromRGB(200, 210, 220),

        _AddFX = function(p282: any, p283: userdata, p284: userdata) -- Line: 1832, Name: _AddFX
            -- upvalues: u5 (copy), u4 (copy)
            local Random_new_ret = Random.new(p283.Item_Seed.Value + 101);
            local v285 = {};

            for _, descendant in p283:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:HasTag("SlashboundVisual") then
                    u5[descendant] = u5[descendant] or descendant.Orientation;
                    u4[descendant] = u4[descendant] or descendant.Position;
                    table.insert(v285, descendant);
                end;
            end;

            table.sort(v285, function(p286, p287) -- Line: 1844
                -- upvalues: u4 (ref)
                return u4[p286].Y < u4[p287].Y;
            end);
            local v288 = #v285;

            for i, v in ipairs(v285) do
                local v289 = u5[v];
                local v290 = u4[v];

                if v289 and v290 then
                    local v291 = Random_new_ret:NextNumber(-v.Size.X, v.Size.X) * 0.28;
                    local math_clamp_ret = math.clamp(v291, -2, 2);
                    local v292 = Random_new_ret:NextNumber(-v.Size.Z, v.Size.Z) * 0.28;
                    local math_clamp_ret2 = math.clamp(v292, -2, 2);
                    local v293 = Random_new_ret:NextNumber(-v.Size.Y, v.Size.Y) * 0.1;

                    if v288 > 1 then
                        v293 = v293 + ((i - 1) / (v288 - 1) - 0.5) * 2;
                    end;

                    local math_clamp_ret3 = math.clamp(v293, -2, 2);
                    local v294 = v289.X + Random_new_ret:NextNumber(-16, 16);
                    local v295 = v289.Y + Random_new_ret:NextNumber(-16, 16);
                    local v296 = v289.Z + Random_new_ret:NextNumber(-16, 16);
                    v.Orientation = Vector3.new(v294, v295, v296);
                    v.Position = v290 + Vector3.new(math_clamp_ret, math_clamp_ret3, math_clamp_ret2);
                    v:AddTag("SlashboundVisual");
                end;
            end;
        end,

        _RemoveFX = function(p297: any, p298: userdata, p299: userdata) -- Line: 1885, Name: _RemoveFX
            -- upvalues: u5 (copy), u4 (copy)
            for _, descendant in p298:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("SlashboundVisual") then
                    descendant:RemoveTag("SlashboundVisual");

                    if not (descendant:HasTag("SlicedVisual") or descendant:HasTag("SeveredVisual")) then
                        descendant.Orientation = u5[descendant] or descendant.Orientation;
                        descendant.Position = u4[descendant] or descendant.Position;
                    end;
                end;
            end;
        end
    },
    Sliced = {
        Id = "Sl",
        Name = "Sliced",
        ValueMulti = 50,
        Color = Color3.fromRGB(223, 223, 223),

        _AddFX = function(p300: any, p301: userdata, p302: userdata) -- Line: 1905, Name: _AddFX
            -- upvalues: u5 (copy), u4 (copy)
            local Random_new_ret = Random.new(p301.Item_Seed.Value + 202);

            for _, descendant in p301:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:HasTag("SlicedVisual") then
                    u5[descendant] = u5[descendant] or descendant.Orientation;
                    u4[descendant] = u4[descendant] or descendant.Position;
                    local v303 = u5[descendant];
                    local v304 = u4[descendant];

                    if v303 and v304 then
                        local v305 = v303.X + Random_new_ret:NextNumber(-14, 14);
                        local v306 = v303.Y + Random_new_ret:NextNumber(-14, 14);
                        local v307 = v303.Z + Random_new_ret:NextNumber(-14, 14);
                        descendant.Orientation = Vector3.new(v305, v306, v307);
                        local v308 = Random_new_ret:NextNumber(-descendant.Size.X, descendant.Size.X) * 0.24;
                        local math_clamp_ret = math.clamp(v308, -1.6, 1.6);
                        local v309 = Random_new_ret:NextNumber(-descendant.Size.Y, descendant.Size.Y) * 0.09;
                        local math_clamp_ret2 = math.clamp(v309, -1.25, 1.25);
                        local v310 = Random_new_ret:NextNumber(-descendant.Size.Z, descendant.Size.Z) * 0.24;
                        local math_clamp_ret3 = math.clamp(v310, -1.6, 1.6);
                        descendant.Position = v304 + Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3);
                        descendant:AddTag("SlicedVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p311: any, p312: userdata, p313: userdata) -- Line: 1940, Name: _RemoveFX
            -- upvalues: u5 (copy), u4 (copy)
            for _, descendant in p312:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("SlicedVisual") then
                    descendant:RemoveTag("SlicedVisual");

                    if not (descendant:HasTag("SlashboundVisual") or descendant:HasTag("SeveredVisual")) then
                        descendant.Orientation = u5[descendant] or descendant.Orientation;
                        descendant.Position = u4[descendant] or descendant.Position;
                    end;
                end;
            end;
        end
    },
    Severed = {
        Id = "Se",
        Name = "Severed",
        ValueMulti = 40,
        Color = Color3.fromRGB(186, 211, 223),

        _AddFX = function(p314: any, p315: userdata, p316: userdata) -- Line: 1960, Name: _AddFX
            -- upvalues: u5 (copy), u4 (copy)
            local Random_new_ret = Random.new(p315.Item_Seed.Value + 303);
            local v317 = {};

            for _, descendant in p315:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:HasTag("SeveredVisual") then
                    u5[descendant] = u5[descendant] or descendant.Orientation;
                    u4[descendant] = u4[descendant] or descendant.Position;
                    table.insert(v317, descendant);
                end;
            end;

            table.sort(v317, function(p318, p319) -- Line: 1972
                -- upvalues: u4 (ref)
                return u4[p318].Y < u4[p319].Y;
            end);
            local v320 = #v317;

            for i, v in ipairs(v317) do
                local v321 = u5[v];
                local v322 = u4[v];

                if v321 and v322 then
                    local v323 = v321.X + Random_new_ret:NextNumber(-18, 18);
                    local v324 = v321.Y + Random_new_ret:NextNumber(-18, 18);
                    local v325 = v321.Z + Random_new_ret:NextNumber(-18, 18);
                    v.Orientation = Vector3.new(v323, v324, v325);
                    local v326 = Random_new_ret:NextNumber(-v.Size.X, v.Size.X) * 0.3;
                    local math_clamp_ret = math.clamp(v326, -2.25, 2.25);
                    local v327 = Random_new_ret:NextNumber(-v.Size.Z, v.Size.Z) * 0.3;
                    local math_clamp_ret2 = math.clamp(v327, -2.25, 2.25);
                    local v328 = Random_new_ret:NextNumber(-v.Size.Y, v.Size.Y) * 0.11;

                    if v320 > 1 then
                        v328 = v328 + ((i - 1) / (v320 - 1) - 0.5) * 2.25;
                    end;

                    local math_clamp_ret3 = math.clamp(v328, -2.25, 2.25);
                    v.Position = v322 + Vector3.new(math_clamp_ret, math_clamp_ret3, math_clamp_ret2);
                    v:AddTag("SeveredVisual");
                end;
            end;
        end,

        _RemoveFX = function(p329: any, p330: userdata, p331: userdata) -- Line: 2013, Name: _RemoveFX
            -- upvalues: u5 (copy), u4 (copy)
            for _, descendant in p330:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("SeveredVisual") then
                    descendant:RemoveTag("SeveredVisual");

                    if not (descendant:HasTag("SlashboundVisual") or descendant:HasTag("SlicedVisual")) then
                        descendant.Orientation = u5[descendant] or descendant.Orientation;
                        descendant.Position = u4[descendant] or descendant.Position;
                    end;
                end;
            end;
        end
    },
    Alienlike = {
        Id = "j",
        Name = "Alienlike",
        ValueMulti = 100,
        Color = Color3.fromRGB(0, 223, 197),

        _AddFX = function(p332: any, p333: userdata, p334: userdata) -- Line: 2033, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p332:_RemoveFX(p333, p334);

            if p334 then
                for _, child in game.ServerStorage.Mutation_FX.Alienlike:GetChildren() do
                    local v335 = child:Clone();
                    v335.Parent = p334;
                    v335.Enabled = true;
                    v335:AddTag("Cleanup_Alienlike");
                end;
            end;

            for _, descendant in p333:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(0, 255, 217);

                    if Random.new():NextInteger(1, 2) == 1 then
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Material = Enum.Material.ForceField;
                    end;

                    descendant:AddTag("AlienlikeVisual");
                end;
            end;
        end,

        _RemoveFX = function(p336: any, p337: userdata, p338: userdata) -- Line: 2063, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p338 then
                for _, child in p338:GetChildren() do
                    if child:HasTag("Cleanup_Alienlike") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p337:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("AlienlikeVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("AlienlikeVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Galactic = {
        Id = "k",
        Name = "Galactic",
        ValueMulti = 120,
        Color = Color3.fromRGB(243, 148, 255),

        _AddFX = function(p339: any, p340: userdata, p341: userdata) -- Line: 2095, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p339:_RemoveFX(p340, p341);

            if p341 then
                for _, child in game.ServerStorage.Mutation_FX.Galactic:GetChildren() do
                    local v342 = child:Clone();
                    v342.Parent = p341;
                    v342.Enabled = true;
                    v342:AddTag("Cleanup_Galactic");
                end;
            end;

            for _, descendant in p340:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(226, 152, 255);

                    if Random.new():NextInteger(1, 2) == 1 then
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Material = Enum.Material.Neon;
                    end;

                    descendant:AddTag("GalacticVisual");
                end;
            end;
        end,

        _RemoveFX = function(p343: any, p344: userdata, p345: userdata) -- Line: 2125, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p345 then
                for _, child in p345:GetChildren() do
                    if child:HasTag("Cleanup_Galactic") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p344:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GalacticVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("GalacticVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Drenched = {
        Id = "dr",
        Name = "Drenched",
        ValueMulti = 5,
        Color = Color3.fromRGB(0, 55, 228),

        _AddFX = function(p346: any, p347: userdata, p348: userdata) -- Line: 2157, Name: _AddFX
            -- upvalues: u3 (copy)
            p346:_RemoveFX(p347, p348);

            if p348 then
                for _, child in game.ServerStorage.Mutation_FX.Drenched:GetChildren() do
                    local v349 = child:Clone();
                    v349.Parent = p348;
                    v349.Enabled = true;
                    v349:AddTag("Cleanup_Drenched");
                end;
            end;

            for _, child in p347:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    u3[child] = u3[child] or child.Color;
                    local v350, v351, v352 = child.Color:ToHSV();
                    local math_clamp_ret = math.clamp(v351 + 0.1, v351, 1);
                    local math_clamp_ret2 = math.clamp(v352 + 0.05, v352, 1);
                    child.Color = Color3.fromHSV(v350, math_clamp_ret, math_clamp_ret2);
                end;
            end;
        end,

        _RemoveFX = function(p353: any, p354: userdata, p355: userdata) -- Line: 2193, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy), u7 (copy)
            if p355 then
                for _, child in p355:GetChildren() do
                    if child:HasTag("Cleanup_Drenched") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, child in p354:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Color = u3[child] or child.Color;
                    u3[child] = nil;

                    if u6[child] then
                        child.Material = u6[child];
                        u6[child] = nil;
                    end;

                    if u7[child] then
                        child.MaterialVariant = u7[child];
                        u7[child] = nil;
                    end;
                end;
            end;
        end
    },
    Aurora = {
        Id = "l",
        Name = "Aurora",
        ValueMulti = 90,
        Color = Color3.fromRGB(99, 89, 175),

        _AddFX = function(p356: any, p357: userdata, p358: userdata) -- Line: 2228, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p356:_RemoveFX(p357, p358);

            for i, descendant in p357:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 5 == 0 then
                        local v359 = game.ServerStorage.Mutation_FX.Aurora.Light:Clone();
                        v359.Parent = descendant;
                        v359.Enabled = true;
                        v359:AddTag("Cleanup_Aurora");
                    end;

                    if not descendant:HasTag("Effect") then
                        local v360 = Random.new():NextInteger(1, 3);
                        u3[descendant] = u3[descendant] or descendant.Color;

                        if v360 == 1 then
                            descendant.Color = Color3.fromRGB(150, 92, 186);
                        elseif v360 == 2 then
                            descendant.Color = Color3.fromRGB(87, 91, 171);
                        elseif v360 == 3 then
                            descendant.Color = Color3.fromRGB(76, 156, 165);
                        end;

                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Material = Enum.Material.Neon;
                        descendant:AddTag("AuroraVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p361: any, p362: userdata, p363: userdata) -- Line: 2261, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p363 then
                for _, child in p363:GetChildren() do
                    if child:HasTag("Cleanup_Aurora") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p362:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GalacticVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("AuroraVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Chilled = {
        Id = "m",
        Name = "Chilled",
        ValueMulti = 2,
        Color = Color3.fromRGB(135, 206, 250),

        _AddFX = function(p364: any, p365: userdata, p366: userdata) -- Line: 2293, Name: _AddFX
            p364:_RemoveFX(p365, p366);

            if p366 then
                for _, child in game.ServerStorage.Mutation_FX.Chilled:GetChildren() do
                    local v367 = child:Clone();
                    v367.Parent = p366;
                    v367.Enabled = true;
                    v367:AddTag("Cleanup_Chilled");
                end;
            end;

            for _, child in p365:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Reflectance = 0.1;
                end;
            end;
        end,

        _RemoveFX = function(p368: any, p369: userdata, p370: userdata) -- Line: 2311, Name: _RemoveFX
            if p370 then
                for _, child in p370:GetChildren() do
                    if child:HasTag("Cleanup_Chilled") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, child in p369:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Reflectance = 0;
                end;
            end;
        end
    },
    Sundried = {
        Id = "n",
        Name = "Sundried",
        ValueMulti = 85,
        Color = Color3.fromRGB(207, 93, 0),

        _AddFX = function(p371: any, p372: userdata, p373: userdata) -- Line: 2331, Name: _AddFX
            -- upvalues: u3 (copy)
            p371:_RemoveFX(p372, p373);

            for _, child in p372:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    u3[child] = u3[child] or child.Color;
                    child.Color = Color3.fromRGB(child.Color.R * 178.5, child.Color.G * 127.5, child.Color.B * 127.5);
                end;
            end;
        end,

        _RemoveFX = function(p374: any, p375: userdata, p376: userdata) -- Line: 2347, Name: _RemoveFX
            -- upvalues: u3 (copy)
            for _, child in p375:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Color = u3[child] or child.Color;
                    u3[child] = nil;
                end;
            end;
        end
    },
    Wiltproof = {
        Id = "o",
        Name = "Wiltproof",
        ValueMulti = 4,
        Color = Color3.fromRGB(0, 222, 155),

        _AddFX = function(p377: any, p378: userdata, p379: userdata) -- Line: 2364, Name: _AddFX
            -- upvalues: u3 (copy)
            p377:_RemoveFX(p378, p379);

            for _, child in p378:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    u3[child] = u3[child] or child.Color;
                    local Color = child.Color;
                    local v380 = Color.R * 0.3 + Color.G * 0.59 + Color.B * 0.11;
                    child.Color = Color3.new(math.clamp(v380 + (Color.R - v380) * 3, 0, 1), math.clamp(v380 + (Color.G - v380) * 4, 0, 1), (math.clamp(v380 + (Color.B - v380) * 3, 0, 1)));
                end;
            end;
        end,

        _RemoveFX = function(p381: any, p382: userdata, p383: userdata) -- Line: 2384, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy), u7 (copy)
            for _, child in p382:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Color = u3[child] or child.Color;
                    u3[child] = nil;

                    if u6[child] then
                        child.Material = u6[child];
                        u6[child] = nil;
                    end;

                    if u7[child] then
                        child.MaterialVariant = u7[child];
                        u7[child] = nil;
                    end;
                end;
            end;
        end
    },
    Verdant = {
        Id = "q",
        Name = "Verdant",
        ValueMulti = 4,
        Color = Color3.fromRGB(34, 139, 34),

        _AddFX = function(p384: any, p385: userdata, p386: userdata) -- Line: 2411, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p384:_RemoveFX(p385, p386);

            if p386 then
                for _, child in game.ServerStorage.Mutation_FX.Verdant:GetChildren() do
                    local v387 = child:Clone();
                    v387.Parent = p386;
                    v387.Enabled = true;
                    v387:AddTag("Cleanup_Verdant");
                end;
            end;

            for i, descendant in p385:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v388 = game.ServerStorage.Mutation_FX.Verdant.LeafSwirl:Clone();
                        v388.Parent = descendant;
                        v388.Enabled = true;
                        v388:AddTag("Cleanup_Verdant");
                    end;

                    if not descendant:HasTag("Effect") then
                        local Color = descendant.Color;
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = Color3.fromRGB(Color.R * 166 * 0.5, math.clamp(Color.G * 255 + 150, 0, 255) * 0.5, Color.B * 166 * 0.5);
                        descendant:AddTag("VerdantVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p389: any, p390: userdata, p391: userdata) -- Line: 2452, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p391 then
                for _, child in p391:GetChildren() do
                    if child:HasTag("Cleanup_Verdant") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p390:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("VerdantVisual") then
                    descendant:RemoveTag("VerdantVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Paradisal = {
        Id = "r",
        Name = "Paradisal",
        ValueMulti = 100,
        Color = Color3.fromRGB(176, 240, 0),

        _AddFX = function(p392: any, p393: userdata, p394: userdata) -- Line: 2484, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p392:_RemoveFX(p393, p394);

            if p394 then
                for _, child in game.ServerStorage.Mutation_FX.Paradisal:GetChildren() do
                    local v395 = child:Clone();
                    v395.Parent = p394;
                    v395.Enabled = true;
                    v395:AddTag("Cleanup_Paradisal");
                end;
            end;

            for i, descendant in p393:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v396 = game.ServerStorage.Mutation_FX.Paradisal.Rays:Clone();
                        v396.Parent = descendant;
                        v396.Enabled = true;
                        v396:AddTag("Cleanup_Paradisal");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = Color3.fromRGB(176, 240, 0);
                        descendant:AddTag("ParadisalVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p397: any, p398: userdata, p399: userdata) -- Line: 2520, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p399 then
                for _, child in p399:GetChildren() do
                    if child:HasTag("Cleanup_Paradisal") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p398:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ParadisalVisual") then
                    descendant:RemoveTag("ParadisalVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Glitched = {
        Id = "gli",
        Name = "Glitched",
        ValueMulti = 85,
        Color = Color3.fromRGB(240, 96, 228),

        _AddFX = function(p400: any, p401: userdata, p402: userdata) -- Line: 2552, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p400:_RemoveFX(p401, p402);

            if p402 then
                for _, child in game.ServerStorage.Mutation_FX.Glitched:GetChildren() do
                    local v403 = child:Clone();
                    v403.Parent = p402;
                    v403.Enabled = true;
                    v403:AddTag("Cleanup_Glitched");
                end;
            end;

            local v404 = {
                Color3.fromRGB(240, 96, 228),
                Color3.fromRGB(79, 237, 240),
                Color3.fromRGB(84, 240, 67),
                Color3.fromRGB(217, 217, 217),
                Color3.fromRGB(39, 39, 255)
            };

            for i, descendant in p401:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v405 = game.ServerStorage.Mutation_FX.Glitched.Glitchy:Clone();
                        v405.Parent = descendant;
                        v405.Enabled = true;
                        v405.Rate = math.random(12, 35) / 10;
                        v405:AddTag("Cleanup_Glitched");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = v404[math.random(1, #v404)];
                        descendant.Material = "ForceField";
                        descendant:AddTag("GlitchedVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p406: any, p407: userdata, p408: userdata) -- Line: 2595, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p408 then
                for _, child in p408:GetChildren() do
                    if child:HasTag("Cleanup_Glitched") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p407:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GlitchedVisual") then
                    descendant:RemoveTag("GlitchedVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Gilded = {
        Id = "Gil",
        Name = "Gilded",
        ValueMulti = 15,
        Color = Color3.fromRGB(255, 206, 58),

        _AddFX = function(p409: any, p410: userdata, p411: userdata) -- Line: 2627, Name: _AddFX
            -- upvalues: u6 (copy)
            p409:_RemoveFX(p410, p411);

            if p411 then
                for _, child in game.ServerStorage.Mutation_FX.Gilded:GetChildren() do
                    if child.Name ~= "Decals" then
                        local v412 = child:Clone();
                        v412.Parent = p411;
                        v412.Enabled = true;

                        for _, child2 in game.ServerStorage.Mutation_FX.Gilded.Decals:GetChildren() do
                            local v413 = child2:Clone();
                            v413:AddTag("Cleanup_Gilded");
                            v413.Parent = p411;
                        end;

                        v412:AddTag("Cleanup_Gilded");
                    end;
                end;
            end;

            for i, descendant in p410:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v414 = game.ServerStorage.Mutation_FX.Gilded.Sparkle:Clone();
                        v414.Parent = descendant;
                        v414.Enabled = true;
                        v414.Rate = math.random(8, 25) / 10;
                        v414:AddTag("Cleanup_Gilded");
                    end;

                    if not descendant:HasTag("Effect") then
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if descendant.Transparency ~= 1 then
                            descendant.Material = "Metal";
                            local v415 = descendant;

                            for _, child in game.ServerStorage.Mutation_FX.Gilded.Decals:GetChildren() do
                                local v416 = child:Clone();
                                v416:AddTag("GildedDecal");
                                v416.Parent = v415;
                            end;

                            v415:AddTag("GildedVisual");
                        end;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p417: any, p418: userdata, p419: userdata) -- Line: 2677, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p419 then
                for _, child in p419:GetChildren() do
                    if child:HasTag("Cleanup_Gilded") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p418:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if descendant:HasTag("GildedVisual") then
                        descendant:RemoveTag("GildedVisual");
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;

                        descendant.Reflectance = 0;
                    elseif descendant:HasTag("GildedDecal") then
                        descendant:Destroy();
                    end;
                end;
            end;
        end
    },
    Glimmering = {
        Id = "glm",
        Name = "Glimmering",
        ValueMulti = 2,
        Color = Color3.fromRGB(255, 135, 245),

        _AddFX = function(p420: any, p421: userdata, p422: userdata) -- Line: 2711, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p420:_RemoveFX(p421, p422);

            if p422 then
                for _, child in game.ServerStorage.Mutation_FX.Glimmering:GetChildren() do
                    local v423 = child:Clone();
                    v423.Parent = p422;
                    v423.Enabled = true;
                    v423:AddTag("Cleanup_Glimmering");
                end;
            end;

            local v424 = { Color3.fromRGB(246, 142, 255), Color3.fromRGB(176, 130, 255), Color3.fromRGB(255, 80, 238) };

            for i, descendant in p421:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v425 = game.ServerStorage.Mutation_FX.Glimmering.Sparkle:Clone();
                        v425.Parent = descendant;
                        v425.Enabled = true;
                        v425.Rate = math.random(8, 25) / 10;
                        v425:AddTag("Cleanup_Glimmering");
                        local Attachment = Instance.new("Attachment", descendant);
                        Attachment:AddTag("Cleanup_Glimmering");
                        local Attachment2 = Instance.new("Attachment", descendant);
                        Attachment2:AddTag("Cleanup_Glimmering");
                        Attachment.Position = Vector3.new(0, 0.1, 0);
                        Attachment2.Position = Vector3.new(0, -0.1, 0);
                        local Trail = Instance.new("Trail");
                        Trail.Color = ColorSequence.new(v424[2]);
                        Trail.LightInfluence = 0;
                        Trail.Brightness = 3;
                        Trail.Attachment0 = Attachment;
                        Trail.Attachment1 = Attachment2;
                        Trail.Lifetime = 0.3;
                        Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
                        Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) });
                        Trail.Parent = descendant;
                        Trail:AddTag("Cleanup_Glimmering");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if descendant.Transparency ~= 1 then
                            descendant.Color = v424[math.random(1, #v424)];
                            descendant.Material = "Neon";
                            descendant:SetAttribute("OTransparency", descendant.Transparency);
                            descendant.Transparency = 0.5;
                            descendant:AddTag("GlimmeringVisual");
                        end;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p426: any, p427: userdata, p428: userdata) -- Line: 2770, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p428 then
                for _, child in p428:GetChildren() do
                    if child:HasTag("Cleanup_Glimmering") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p427:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GlimmeringVisual") then
                    descendant:RemoveTag("GlimmeringVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Transparency = descendant:GetAttribute("OTransparency") or 0;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Luminous = {
        Id = "lum",
        Name = "Luminous",
        ValueMulti = 50,
        Color = Color3.fromRGB(85, 170, 255),

        _AddFX = function(p429: any, p430: userdata, p431: userdata) -- Line: 2803, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p429:_RemoveFX(p430, p431);
            local Children = game.ServerStorage.Mutation_FX.Luminous:GetChildren();
            local v432 = {
                Color3.fromRGB(255, 160, 255),
                Color3.fromRGB(255, 128, 255),
                Color3.fromRGB(255, 105, 240),
                Color3.fromRGB(255, 100, 200)
            };

            if p431 then
                for _, v in Children do
                    local v433 = v:Clone();
                    v433.Parent = p431;
                    v433.Enabled = true;
                    v433:AddTag("Cleanup_Luminous");
                end;
            end;

            local v434 = 0;

            for _, descendant in p430:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    v434 = v434 + 1;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if descendant.Transparency ~= 1 then
                            descendant.Color = v432[math.random(1, #v432)];
                            descendant.Material = Enum.Material.Neon;
                            descendant:SetAttribute("OTransparency", descendant.Transparency);
                            descendant.Transparency = 0.5;
                            descendant:AddTag("LuminousVisual");
                        end;
                    end;

                    if v434 % 2 == 0 and #Children > 0 then
                        local v435 = Children[math.random(1, #Children)]:Clone();
                        v435.Parent = descendant;
                        v435.Enabled = true;
                        v435:AddTag("Cleanup_Luminous");
                    end;

                    if v434 % 2 == 0 then
                        local Sparkle = game.ServerStorage.Mutation_FX.Luminous:FindFirstChild("Sparkle");

                        if Sparkle then
                            local v436 = Sparkle:Clone();
                            v436.Parent = descendant;
                            v436.Enabled = true;
                            v436.Rate = math.random(8, 25) / 10;
                            v436:AddTag("Cleanup_Luminous");
                        end;

                        local Attachment = Instance.new("Attachment", descendant);
                        Attachment:AddTag("Cleanup_Luminous");
                        local Attachment2 = Instance.new("Attachment", descendant);
                        Attachment2:AddTag("Cleanup_Luminous");
                        Attachment.Position = Vector3.new(0, 0.1, 0);
                        Attachment2.Position = Vector3.new(0, -0.1, 0);
                        local Trail = Instance.new("Trail");
                        Trail.Color = ColorSequence.new(Color3.fromRGB(255, 150, 255));
                        Trail.LightInfluence = 0;
                        Trail.Brightness = 3;
                        Trail.Attachment0 = Attachment;
                        Trail.Attachment1 = Attachment2;
                        Trail.Lifetime = 0.3;
                        Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
                        Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1.5), NumberSequenceKeypoint.new(1, 0) });
                        Trail.Parent = descendant;
                        Trail:AddTag("Cleanup_Luminous");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p437: any, p438: userdata, p439: userdata) -- Line: 2891, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v441(p440) -- Line: 2892
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p440:GetDescendants() do
                    if descendant:HasTag("Cleanup_Luminous") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("LuminousVisual") then
                        descendant:RemoveTag("LuminousVisual");
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant.Transparency = descendant:GetAttribute("OTransparency") or 0;

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;

            if p439 then
                v441(p439);
            end;

            if p438 then
                v441(p438);
            end;
        end
    },
    Cracked = {
        Id = "CRA",
        Name = "Cracked",
        ValueMulti = 4,
        Color = Color3.fromRGB(138, 127, 114),

        _AddFX = function(p442: any, p443: userdata, p444: userdata) -- Line: 2921, Name: _AddFX
            p442:_RemoveFX(p443, p444);
            local v445 = 0;

            for _, descendant in p443:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency <= 0.75) then
                    v445 = v445 + 1;

                    if v445 <= 8 then
                        local v446 = descendant;

                        for _, child in game.ServerStorage.Mutation_FX.Cracked:GetChildren() do
                            local v447 = child:Clone();
                            v447.Parent = v446;

                            if v447.ClassName == "ParticleEmitter" then
                                v447.Enabled = true;
                                v447.Rate = v447.Rate / v445;
                                v447.Color = ColorSequence.new(v446.Color);
                            else
                                v447.Transparency = math.clamp(v446.Transparency / 2, 0, 0.4) + 0.25;
                            end;
                        end;

                        v446:AddTag("CrackedVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p448: any, p449: userdata, p450: userdata) -- Line: 2948, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v452(p451) -- Line: 2949
                for _, descendant in p451:GetDescendants() do
                    if descendant:HasTag("Cleanup_Cracked") or descendant.Name == "CRACKSTEXTURE" then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p450 then
                v452(p450);
            end;

            if p449 then
                v452(p449);
            end;

            for _, descendant in p449:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CrackedVisual") then
                    if descendant:FindFirstChild("CrackedRubbleP") then
                        descendant.CrackedRubbleP:Destroy();
                    end;

                    if descendant:FindFirstChild("CrackedPixelSmokeP") then
                        descendant.CrackedPixelSmokeP:Destroy();
                    end;

                    descendant.Reflectance = 0;
                    u3[descendant] = nil;
                    descendant:RemoveTag("CrackedVisual");
                end;
            end;
        end
    },
    Enchanted = {
        Id = "Enc",
        Name = "Enchanted",
        ValueMulti = 50,
        Color = Color3.fromRGB(255, 214, 89),

        _AddFX = function(p453: any, p454: userdata, p455: userdata) -- Line: 2980, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p453:_RemoveFX(p454, p455);

            if p455 then
                for _, child in game.ServerStorage.Mutation_FX.Enchanted:GetChildren() do
                    local v456 = child:Clone();
                    v456.Parent = p455;
                    v456.Enabled = true;
                    v456:AddTag("Cleanup_Enchanted");
                end;
            end;

            local v457 = { Color3.fromRGB(255, 214, 89), Color3.fromRGB(255, 159, 80), Color3.fromRGB(255, 244, 123) };

            for i, descendant in p454:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v458 = game.ServerStorage.Mutation_FX.Enchanted.Sparkle:Clone();
                        v458.Parent = descendant;
                        v458.Enabled = true;
                        v458.Rate = math.random(8, 25) / 10;
                        v458:AddTag("Cleanup_Enchanted");
                        local Attachment = Instance.new("Attachment", descendant);
                        Attachment:AddTag("Cleanup_Enchanted");
                        local Attachment2 = Instance.new("Attachment", descendant);
                        Attachment2:AddTag("Cleanup_Enchanted");
                        Attachment.Position = Vector3.new(0, 0.1, 0);
                        Attachment2.Position = Vector3.new(0, -0.1, 0);
                        local Trail = Instance.new("Trail");
                        Trail.Color = ColorSequence.new(Color3.fromRGB(255, 214, 89));
                        Trail.LightInfluence = 0;
                        Trail.Brightness = 3;
                        Trail.Attachment0 = Attachment;
                        Trail.Attachment1 = Attachment2;
                        Trail.Lifetime = 0.3;
                        Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
                        Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) });
                        Trail.Parent = descendant;
                        Trail:AddTag("Cleanup_Enchanted");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if descendant.Transparency ~= 1 then
                            descendant.Color = v457[math.random(1, #v457)];
                            descendant.Material = "Neon";
                            descendant:SetAttribute("OTransparency", descendant.Transparency);
                            descendant.Transparency = 0.5;
                            descendant:AddTag("EnchantedVisual");
                        end;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p459: any, p460: userdata, p461: userdata) -- Line: 3036, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p461 then
                for _, child in p461:GetChildren() do
                    if child:HasTag("Cleanup_Enchanted") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p460:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("EnchantedVisual") then
                    descendant:RemoveTag("EnchantedVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Transparency = descendant:GetAttribute("OTransparency") or 0;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Frozen = {
        Id = "s",
        Name = "Frozen",
        ValueMulti = 10,
        Color = Color3.fromRGB(108, 184, 255),

        _AddFX = function(p462: any, p463: userdata, p464: userdata) -- Line: 3069, Name: _AddFX
            -- upvalues: AddBoundingFX (copy)
            AddBoundingFX(p462, p463, p464, 0.8);
        end,

        _RemoveFX = function(p465: any, p466: userdata, p467: userdata) -- Line: 3071, Name: _RemoveFX
            -- upvalues: RemoveBoundingFX (copy)
            RemoveBoundingFX(p465, p466, p467);
        end
    },
    Disco = {
        Id = "t",
        Name = "Disco",
        ValueMulti = 125,
        Color = Color3.fromRGB(255, 105, 180),

        _AddFX = function(p468: any, p469: userdata, p470: userdata) -- Line: 3080, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p468:_RemoveFX(p469, p470);

            local function LoopThroughObject(p471) -- Line: 3083
                -- upvalues: u3 (ref), u6 (ref), LoopThroughObject (copy)
                for _, child in p471:GetChildren() do
                    if child:IsA("BasePart") or child:IsA("UnionOperation") then
                        u3[child] = u3[child] or child.Color;
                        u6[child] = u6[child] or child.Material;
                        child.Material = Enum.Material.Neon;
                        child:AddTag("Discofied");
                    elseif child:IsA("Model") then
                        LoopThroughObject(child);
                    end;
                end;
            end;

            LoopThroughObject(p469);
        end,

        _RemoveFX = function(p472: any, p473: userdata, p474: userdata) -- Line: 3099, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy), DiscoSetColor_RE (copy)
            local v475 = {};

            for _, descendant in p473:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("Discofied") then
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("Discofied");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    table.insert(v475, {
                        Part = descendant,
                        Color = descendant.Color
                    });
                    local v476 = u6[descendant];

                    if v476 then
                        descendant.Material = v476;
                        u6[descendant] = nil;
                    end;
                end;
            end;

            if game:GetService("RunService"):IsServer() then
                DiscoSetColor_RE:FireAllClients(v475);
            end;
        end
    },
    Choc = {
        Id = "u",
        Name = "Choc",
        ValueMulti = 2,
        Color = Color3.fromRGB(92, 64, 51),
        StrokeColor = Color3.fromRGB(255, 255, 255),

        _AddFX = function(p477: any, p478: userdata, p479: userdata) -- Line: 3139, Name: _AddFX
            -- upvalues: u2 (copy)
            p477:_RemoveFX(p478, p479);
            local u480 = 0;

            local function u485(p481) -- Line: 3150
                -- upvalues: u480 (ref), u2 (ref), u485 (copy)
                for _, child in p481:GetChildren() do
                    if u480 >= 12 then
                        break;
                    end;

                    if child:IsA("BasePart") or child:IsA("UnionOperation") then
                        u480 = u480 + 1;
                        local u482 = child;
                        local u483 = {};

                        for _, child2 in game.ServerStorage.Mutation_Textures.Choc:GetChildren() do
                            local v484 = child2:Clone();
                            v484.Parent = u482;
                            v484.Transparency = u482.Transparency;
                            table.insert(u483, v484);
                            v484:AddTag("Cleanup_Choc");
                        end;

                        if u2[u482] then
                            u2[u482]:Disconnect();
                        end;

                        u2[u482] = u482.Changed:Connect(function() -- Line: 3166
                            -- upvalues: u482 (copy), u2 (ref), u483 (copy)
                            if u482.Transparency ~= 0 then
                                return;
                            end;

                            u2[u482]:Disconnect();

                            for _, v in u483 do
                                v.Transparency = 0;
                            end;
                        end);
                    elseif child:IsA("Model") then
                        u485(child);
                    end;
                end;
            end;

            u485(p478);
        end,

        _RemoveFX = function(p486: any, p487: userdata, p488: userdata) -- Line: 3184, Name: _RemoveFX
            -- upvalues: u2 (copy)
            for _, descendant in p487:GetDescendants() do
                if descendant:HasTag("Cleanup_Choc") then
                    descendant:Destroy();
                end;

                if u2[descendant] then
                    u2[descendant]:Disconnect();
                end;
            end;
        end
    },
    Plasma = {
        Id = "v",
        Name = "Plasma",
        ValueMulti = 5,
        Color = Color3.fromRGB(208, 43, 137),

        _AddFX = function(p489: any, p490: userdata, p491: userdata) -- Line: 3200, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p489:_RemoveFX(p490, p491);

            if p491 then
                for _, child in game.ServerStorage.Mutation_FX.Plasma:GetChildren() do
                    local v492 = child:Clone();
                    v492.Parent = p491;
                    v492.Enabled = true;
                    v492:AddTag("Cleanup_Plasma");
                end;
            end;

            for _, descendant in p490:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(189, 67, 142);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                    descendant.Reflectance = 0.05;
                    descendant:AddTag("PlasmaVisual");
                end;
            end;
        end,

        _RemoveFX = function(p493: any, p494: userdata, p495: userdata) -- Line: 3226, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v497(p496) -- Line: 3227
                for _, descendant in p496:GetDescendants() do
                    if descendant:HasTag("Cleanup_Plasma") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p495 then
                v497(p495);
            end;

            if p494 then
                v497(p494);
            end;

            for _, descendant in p494:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("PlasmaVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("PlasmaVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Heavenly = {
        Id = "w",
        Name = "Heavenly",
        ValueMulti = 5,
        Color = Color3.fromRGB(255, 249, 160),

        _AddFX = function(p498: any, p499: userdata, p500: userdata) -- Line: 3260, Name: _AddFX
            p498:_RemoveFX(p499, p500);

            if p500 then
                for _, child in game.ServerStorage.Mutation_FX.Heavenly:GetChildren() do
                    local v501 = child:Clone();
                    v501.Parent = p500;
                    v501.Enabled = true;
                    v501:AddTag("Cleanup_Heavenly");
                end;
            end;
        end,

        _RemoveFX = function(p502: any, p503: userdata, p504: userdata) -- Line: 3273, Name: _RemoveFX
            local function v506(p505) -- Line: 3274
                for _, descendant in p505:GetDescendants() do
                    if descendant:HasTag("Cleanup_Heavenly") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p504 then
                v506(p504);
            end;

            if p503 then
                v506(p503);
            end;
        end
    },
    Burnt = {
        Id = "x",
        Name = "Burnt",
        ValueMulti = 4,
        Color = Color3.fromRGB(40, 40, 40),

        _AddFX = function(p507: any, p508: userdata, p509: userdata) -- Line: 3291, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p507:_RemoveFX(p508, p509);

            if p509 then
                for _, child in game.ServerStorage.Mutation_FX.Burnt:GetChildren() do
                    local v510 = child:Clone();
                    v510.Parent = p509;
                    v510.Enabled = true;
                    v510:AddTag("Cleanup_Burnt");
                end;
            end;

            for _, descendant in p508:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(25, 25, 25);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Slate;
                    descendant.Reflectance = 0.05;
                    descendant:AddTag("BurntVisual");
                end;
            end;
        end,

        _RemoveFX = function(p511: any, p512: userdata, p513: userdata) -- Line: 3317, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v515(p514) -- Line: 3318
                for _, descendant in p514:GetDescendants() do
                    if descendant:HasTag("Cleanup_Burnt") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p513 then
                v515(p513);
            end;

            if p512 then
                v515(p512);
            end;

            for _, descendant in p512:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BurntVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("BurntVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Cooked = {
        Id = "y",
        Name = "Cooked",
        ValueMulti = 10,
        Color = Color3.fromRGB(210, 120, 60),

        _AddFX = function(p516: any, p517: userdata, p518: userdata) -- Line: 3351, Name: _AddFX
            -- upvalues: u3 (copy)
            p516:_RemoveFX(p517, p518);

            if p518 then
                for _, child in game.ServerStorage.Mutation_FX.Cooked:GetChildren() do
                    local v519 = child:Clone();
                    v519.Parent = p518;
                    v519.Enabled = true;
                    v519:AddTag("Cleanup_Cooked");
                end;
            end;

            for _, descendant in p517:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(210, 120, 60);
                    descendant:AddTag("CookedVisual");
                end;
            end;
        end,

        _RemoveFX = function(p520: any, p521: userdata, p522: userdata) -- Line: 3374, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v524(p523) -- Line: 3375
                for _, descendant in p523:GetDescendants() do
                    if descendant:HasTag("Cleanup_Cooked") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p522 then
                v524(p522);
            end;

            if p521 then
                v524(p521);
            end;

            for _, descendant in p521:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CookedVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("CookedVisual");
                    local v525 = u6[descendant];

                    if v525 then
                        descendant.Material = v525;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Sizzled = {
        Id = "SI",
        Name = "Sizzled",
        ValueMulti = 18,
        Color = Color3.fromRGB(210, 120, 60),

        _AddFX = function(p526: any, p527: userdata, p528: userdata) -- Line: 3409, Name: _AddFX
            -- upvalues: u3 (copy)
            p526:_RemoveFX(p527, p528);

            if p528 then
                for _, child in game.ServerStorage.Mutation_FX.Cooked:GetChildren() do
                    local v529 = child:Clone();
                    v529.Parent = p528;
                    v529.Enabled = true;
                    v529:AddTag("Cleanup_Sizzled");
                end;

                for _, child in game.ServerStorage.Mutation_FX.Fried:GetChildren() do
                    local v530 = child:Clone();
                    v530.Parent = p528;
                    v530.Enabled = true;
                    v530:AddTag("Cleanup_Sizzled");
                end;
            end;

            for _, descendant in p527:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(210, 120, 60);
                    descendant:AddTag("SizzledVisual");
                end;
            end;
        end,

        _RemoveFX = function(p531: any, p532: userdata, p533: userdata) -- Line: 3441, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v535(p534) -- Line: 3442
                for _, descendant in p534:GetDescendants() do
                    if descendant:HasTag("Cleanup_Sizzled") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p533 then
                v535(p533);
            end;

            if p532 then
                v535(p532);
            end;

            for _, descendant in p532:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("SizzledVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("SizzledVisual");
                    local v536 = u6[descendant];

                    if v536 then
                        descendant.Material = v536;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Gourmet = {
        Id = "GO",
        Name = "Gourmet",
        ValueMulti = 37,
        Color = Color3.fromRGB(195, 151, 47),

        _AddFX = function(p537: any, p538: userdata, p539: userdata) -- Line: 3478, Name: _AddFX
            -- upvalues: u3 (copy)
            p537:_RemoveFX(p538, p539);
            local Children = game.ServerStorage.Mutation_FX.Aromatic:GetChildren();
            local Children2 = game.ServerStorage.Mutation_FX.Spaghetti:GetChildren();
            local Children3 = game.ServerStorage.Mutation_FX.Cooked:GetChildren();
            local Children4 = game.ServerStorage.Mutation_FX.Fried:GetChildren();
            local v540 = {};

            for _, v in Children do
                table.insert(v540, v);
            end;

            for _, v in Children2 do
                table.insert(v540, v);
            end;

            for _, v in Children3 do
                table.insert(v540, v);
            end;

            for _, v in Children4 do
                table.insert(v540, v);
            end;

            if p539 then
                for _, v in v540 do
                    local v541 = v:Clone();
                    v541.Parent = p539;

                    if v541:IsA("ParticleEmitter") then
                        v541.Enabled = true;
                    end;

                    v541:AddTag("Cleanup_Gourmet");
                end;
            end;

            for _, descendant in p538:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency ~= 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(195, 151, 47);
                    descendant:AddTag("GourmetVisual");
                end;
            end;
        end,

        _RemoveFX = function(p542: any, p543: userdata, p544: userdata) -- Line: 3517, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v546(p545) -- Line: 3518
                for _, descendant in p545:GetDescendants() do
                    if descendant:HasTag("Cleanup_Gourmet") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p544 then
                v546(p544);
            end;

            if p543 then
                v546(p543);
            end;

            for _, descendant in p543:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GourmetVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("GourmetVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Moonlit = {
        Id = "z",
        Name = "Moonlit",
        ValueMulti = 2,
        Color = Color3.fromRGB(153, 141, 255),

        _AddFX = function(p547: any, p548: userdata, p549: userdata) -- Line: 3550, Name: _AddFX
            -- upvalues: u3 (copy)
            p547:_RemoveFX(p548, p549);

            if p549 then
                for _, child in game.ServerStorage.Mutation_FX.Moonlit:GetChildren() do
                    local v550 = child:Clone();
                    v550.Parent = p549;
                    v550.Enabled = true;
                    v550:AddTag("Cleanup_Moonlit");
                    v550:AddTag("Effect");
                end;
            end;

            for _, descendant in p548:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(62, 56, 86);
                    descendant.Reflectance = 0.3;
                    descendant:AddTag("MoonlitVisual");
                end;
            end;
        end,

        _RemoveFX = function(p551: any, p552: userdata, p553: userdata) -- Line: 3575, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p553 then
                for _, child in p553:GetChildren() do
                    if child:HasTag("Cleanup_Moonlit") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p552:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MoonlitVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("MoonlitVisual");
                    local v554 = u6[descendant];

                    if v554 then
                        descendant.Material = v554;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Moonbeam = {
        Id = "Mbm",
        Name = "Moonbeam",
        ValueMulti = 15,
        Color = Color3.fromRGB(190, 225, 255),

        _AddFX = function(p555: any, p556: userdata, p557: userdata) -- Line: 3610, Name: _AddFX
            -- upvalues: u3 (copy)
            p555:_RemoveFX(p556, p557);
            local Moonbeam = game.ServerStorage.Mutation_FX:FindFirstChild("Moonbeam");
            local v558 = not Moonbeam and {} or Moonbeam:GetChildren();

            local function EnableEmitters(p559: userdata) -- Line: 3616
                if p559:IsA("ParticleEmitter") or (p559:IsA("Trail") or p559:IsA("Beam")) then
                    p559.Enabled = true;
                end;

                for _, descendant in p559:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            if p557 then
                for _, v in v558 do
                    local v560 = v:Clone();
                    v560.Parent = p557;
                    EnableEmitters(v560);
                    v560:AddTag("Cleanup_Moonbeam");
                    v560:AddTag("Effect");
                end;
            end;

            local v561 = 0;

            for _, descendant in p556:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(150, 180, 214);
                    descendant.Reflectance = 0.45;
                    descendant:AddTag("MoonbeamVisual");

                    if descendant ~= p557 then
                        v561 = v561 + 1;

                        if v561 % 3 == 0 and #v558 > 0 then
                            local v562 = v558[math.random(1, #v558)]:Clone();
                            v562.Parent = descendant;
                            EnableEmitters(v562);
                            v562:AddTag("Cleanup_Moonbeam");
                            v562:AddTag("Effect");
                        end;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p563: any, p564: userdata, p565: userdata) -- Line: 3666, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v567(p566: userdata) -- Line: 3667
                for _, descendant in p566:GetDescendants() do
                    if descendant:HasTag("Cleanup_Moonbeam") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p565 then
                v567(p565);
            end;

            if p564 then
                v567(p564);
            end;

            for _, descendant in p564:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MoonbeamVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("MoonbeamVisual");
                    local v568 = u6[descendant];

                    if v568 then
                        descendant.Material = v568;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Heartstruck = {
        Id = "HeartStruckID",
        Name = "Heartstruck",
        ValueMulti = 3,
        Color = Color3.fromRGB(255, 56, 238),

        _AddFX = function(p569: any, p570: userdata, p571: userdata) -- Line: 3703, Name: _AddFX
            -- upvalues: u3 (copy)
            p569:_RemoveFX(p570, p571);

            if p571 then
                for _, child in game.ServerStorage.Mutation_FX.Heartstruck:GetChildren() do
                    local v572 = child:Clone();
                    v572.Parent = p571;
                    v572.Enabled = true;
                    v572:AddTag("Cleanup_Heartstruck");
                    v572:AddTag("Effect");
                end;
            end;

            for _, descendant in p570:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(255, 0, 0);
                    descendant.Reflectance = 0.3;
                    descendant:AddTag("HeartstuckVisual");
                end;
            end;
        end,

        _RemoveFX = function(p573: any, p574: userdata, p575: userdata) -- Line: 3728, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p575 then
                for _, child in p575:GetChildren() do
                    if child:HasTag("Cleanup_Heartstruck") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p574:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("HeartstuckVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("HeartstuckVisual");
                    local v576 = u6[descendant];

                    if v576 then
                        descendant.Material = v576;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Luck = {
        Id = "LuckID",
        Name = "Luck",
        ValueMulti = 3,
        Color = Color3.fromRGB(71, 255, 51),

        _AddFX = function(p577: any, p578: userdata, p579: userdata) -- Line: 3762, Name: _AddFX
            -- upvalues: u3 (copy)
            p577:_RemoveFX(p578, p579);

            for _, descendant in p578:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(0, 255, 0);
                    descendant.Material = Enum.Material.Foil;
                    descendant.Reflectance = 0.3;
                    descendant:AddTag("LuckVisual");
                end;
            end;
        end,

        _RemoveFX = function(p580: any, p581: userdata, p582: userdata) -- Line: 3788, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p582 then
                for _, child in p582:GetChildren() do
                    if child:HasTag("Cleanup_Luck") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p581:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("LuckVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("LuckVisual");
                    local v583 = u6[descendant];

                    if v583 then
                        descendant.Material = v583;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Bloodlit = {
        Id = "A",
        Name = "Bloodlit",
        ValueMulti = 4,
        Color = Color3.fromRGB(200, 0, 0),

        _AddFX = function(p584: any, p585: userdata, p586: userdata) -- Line: 3822, Name: _AddFX
            -- upvalues: u3 (copy)
            p584:_RemoveFX(p585, p586);

            if p586 then
                for _, child in game.ServerStorage.Mutation_FX.Bloodlit:GetChildren() do
                    local v587 = child:Clone();
                    v587.Parent = p586;
                    v587.Enabled = true;
                    v587:AddTag("Cleanup_Bloodlit");
                    v587:AddTag("Effect");
                end;
            end;

            for _, descendant in p585:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(143, 1, 3);
                    descendant.Reflectance = 0.3;
                    descendant:AddTag("BloodlitVisual");
                end;
            end;
        end,

        _RemoveFX = function(p588: any, p589: userdata, p590: userdata) -- Line: 3847, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p590 then
                for _, child in p590:GetChildren() do
                    if child:HasTag("Cleanup_Bloodlit") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p589:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BloodlitVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("BloodlitVisual");
                    local v591 = u6[descendant];

                    if v591 then
                        descendant.Material = v591;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Peppermint = {
        Id = "Pep",
        Name = "Peppermint",
        ValueMulti = 4,
        Color = Color3.fromRGB(255, 66, 66),

        _AddFX = function(p592: any, p593: userdata, p594: userdata) -- Line: 3881, Name: _AddFX
            -- upvalues: u3 (copy)
            p592:_RemoveFX(p593, p594);
            local v595 = false;

            for i, descendant in p593:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;

                    if i % 5 == 0 then
                        if v595 == false then
                            local v596 = game.ServerStorage.Mutation_FX.Peppermint.BitsW:Clone();
                            v596.Parent = descendant;
                            v596.Enabled = true;
                            v596.Rate = math.random(7, 12) / 10;
                            v596:AddTag("Cleanup_Peppermint");
                        else
                            local v597 = game.ServerStorage.Mutation_FX.Peppermint.BitsR:Clone();
                            v597.Parent = descendant;
                            v597.Enabled = true;
                            v597.Rate = math.random(7, 12) / 10;
                            v597:AddTag("Cleanup_Peppermint");
                        end;
                    end;

                    descendant.Color = v595 == false and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 0, 0);
                    descendant:AddTag("PeppermintVisual");
                    v595 = not v595;
                end;
            end;
        end,

        _RemoveFX = function(p598: any, p599: userdata, p600: userdata) -- Line: 3912, Name: _RemoveFX
            -- upvalues: u3 (copy)
            if p600 then
                for _, child in p600:GetChildren() do
                    if child:HasTag("Cleanup_Peppermint") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p599:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("PeppermintVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("PeppermintVisual");
                end;
            end;
        end
    },
    Zombified = {
        Id = "B",
        Name = "Zombified",
        ValueMulti = 25,
        Color = Color3.fromRGB(128, 199, 127),

        _AddFX = function(p601: any, p602: userdata, p603: userdata) -- Line: 3939, Name: _AddFX
            p601:_RemoveFX(p602, p603);

            if p603 then
                for _, child in game.ServerStorage.Mutation_FX.Zombified:GetChildren() do
                    local v604 = child:Clone();
                    v604.Parent = p603;
                    v604.Enabled = true;
                    v604:AddTag("Cleanup_Zombified");
                    v604:AddTag("Effect");
                end;
            end;

            for _, descendant in p602:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant:AddTag("ZombifiedVisual");
                end;
            end;
        end,

        _RemoveFX = function(p605: any, p606: userdata, p607: userdata) -- Line: 3959, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p607 then
                for _, child in p607:GetChildren() do
                    if child:HasTag("Cleanup_Zombified") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p606:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ZombifiedVisual") then
                    descendant:RemoveTag("ZombifiedVisual");
                    local v608 = u6[descendant];

                    if v608 then
                        descendant.Material = v608;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Celestial = {
        Id = "C",
        Name = "Celestial",
        ValueMulti = 120,
        Color = Color3.fromRGB(255, 0, 255),

        _AddFX = function(p609: any, p610: userdata, p611: userdata) -- Line: 3988, Name: _AddFX
            p609:_RemoveFX(p610, p611);

            if p611 then
                for _, child in game.ServerStorage.Mutation_FX.Celestial:GetChildren() do
                    local v612 = child:Clone();
                    v612.Parent = p611;
                    v612.Enabled = true;
                    v612:AddTag("Cleanup_Celestial");
                    v612:AddTag("Effect");
                end;
            end;

            for _, descendant in p610:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant.Reflectance = 0.5;
                    descendant:AddTag("CelestialVisual");
                end;
            end;
        end,

        _RemoveFX = function(p613: any, p614: userdata, p615: userdata) -- Line: 4011, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p615 then
                for _, child in p615:GetChildren() do
                    if child:HasTag("Cleanup_Celestial") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p614:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CelestialVisual") then
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("CelestialVisual");
                    local v616 = u6[descendant];

                    if v616 then
                        descendant.Material = v616;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Meteoric = {
        Id = "D",
        Name = "Meteoric",
        ValueMulti = 125,
        Color = Color3.fromRGB(73, 29, 193),

        _AddFX = function(p617: any, p618: userdata, p619: userdata) -- Line: 4042, Name: _AddFX
            p617:_RemoveFX(p618, p619);

            if p619 then
                for _, child in game.ServerStorage.Mutation_FX.Meteoric:GetChildren() do
                    local v620 = child:Clone();
                    v620.Parent = p619;
                    v620.Enabled = true;
                    v620:AddTag("Cleanup_Meteoric");
                    v620:AddTag("Effect");
                end;
            end;

            for _, descendant in p618:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant.Reflectance = 0.5;
                    descendant:AddTag("MeteoricVisual");
                end;
            end;
        end,

        _RemoveFX = function(p621: any, p622: userdata, p623: userdata) -- Line: 4065, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p623 then
                for _, child in p623:GetChildren() do
                    if child:HasTag("Cleanup_Meteoric") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p622:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MeteoricVisual") then
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("MeteoricVisual");
                    local v624 = u6[descendant];

                    if v624 then
                        descendant.Material = v624;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    HoneyGlazed = {
        Id = "E",
        Name = "HoneyGlazed",
        ValueMulti = 5,
        Color = Color3.fromRGB(255, 204, 0),

        _AddFX = function(p625: any, p626: userdata, p627: userdata) -- Line: 4096, Name: _AddFX
            p625:_RemoveFX(p626, p627);

            if p627 then
                for _, child in game.ServerStorage.Mutation_FX.Honey:GetChildren() do
                    local v628 = child:Clone();
                    v628.Parent = p627;
                    v628.Enabled = true;
                    v628:AddTag("Cleanup_Honey");
                    v628:AddTag("Effect");
                end;
            end;

            for _, descendant in p626:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant:AddTag("HoneyVisual");
                end;
            end;
        end,

        _RemoveFX = function(p629: any, p630: userdata, p631: userdata) -- Line: 4116, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p631 then
                for _, child in p631:GetChildren() do
                    if child:HasTag("Cleanup_Honey") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p630:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("HoneyVisual") then
                    descendant:RemoveTag("HoneyVisual");
                    local v632 = u6[descendant];

                    if v632 then
                        descendant.Material = v632;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Pollinated = {
        Id = "F",
        Name = "Pollinated",
        ValueMulti = 3,
        Color = Color3.fromRGB(255, 170, 0),

        _AddFX = function(p633: any, p634: userdata, p635: userdata) -- Line: 4146, Name: _AddFX
            -- upvalues: u3 (copy)
            p633:_RemoveFX(p634, p635);

            if p635 then
                for _, child in game.ServerStorage.Mutation_FX.Pollinated:GetChildren() do
                    local v636 = child:Clone();
                    v636.Parent = p635;
                    v636.Enabled = true;
                    v636:AddTag("Cleanup_Pollinated");
                    v636:AddTag("Effect");
                end;
            end;

            for _, descendant in p634:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(255, 170, 0);
                    descendant:AddTag("PollinatedlVisual");
                end;
            end;
        end,

        _RemoveFX = function(p637: any, p638: userdata, p639: userdata) -- Line: 4170, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p639 then
                for _, child in p639:GetChildren() do
                    if child:HasTag("Cleanup_Pollinated") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p638:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("PollinatedlVisual") then
                    descendant:RemoveTag("PollinatedVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v640 = u6[descendant];

                    if v640 then
                        descendant.Material = v640;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Amber = {
        Id = "G",
        Name = "Amber",
        ValueMulti = 10,
        Color = Color3.fromRGB(255, 192, 0),
        TimeData = {
            TimeToChange = 86400,
            AddMutationName = "OldAmber"
        },

        _AddFX = function(p641: any, p642: userdata, p643: userdata) -- Line: 4206, Name: _AddFX
            -- upvalues: AddBoundingFX (copy)
            AddBoundingFX(p641, p642, p643, 0.5);
        end,

        _RemoveFX = function(p644: any, p645: userdata, p646: userdata) -- Line: 4208, Name: _RemoveFX
            -- upvalues: RemoveBoundingFX (copy)
            RemoveBoundingFX(p644, p645, p646);
        end
    },
    OldAmber = {
        Id = "H",
        Name = "OldAmber",
        ValueMulti = 20,
        Color = Color3.fromRGB(252, 106, 33),
        TimeData = {
            TimeToChange = 172800,
            AddMutationName = "AncientAmber"
        },

        _AddFX = function(p647: any, p648: userdata, p649: userdata) -- Line: 4221, Name: _AddFX
            -- upvalues: AddBoundingFX (copy)
            AddBoundingFX(p647, p648, p649, 0.5);
        end,

        _RemoveFX = function(p650: any, p651: userdata, p652: userdata) -- Line: 4223, Name: _RemoveFX
            -- upvalues: RemoveBoundingFX (copy)
            RemoveBoundingFX(p650, p651, p652);
        end
    },
    AncientAmber = {
        Id = "I",
        Name = "AncientAmber",
        ValueMulti = 50,
        Color = Color3.fromRGB(204, 68, 0),

        _AddFX = function(p653: any, p654: userdata, p655: userdata) -- Line: 4232, Name: _AddFX
            -- upvalues: AddBoundingFX (copy)
            AddBoundingFX(p653, p654, p655, 0.5);
        end,

        _RemoveFX = function(p656: any, p657: userdata, p658: userdata) -- Line: 4234, Name: _RemoveFX
            -- upvalues: RemoveBoundingFX (copy)
            RemoveBoundingFX(p656, p657, p658);
        end
    },
    Sandy = {
        Id = "J",
        Name = "Sandy",
        ValueMulti = 3,
        Color = Color3.fromRGB(212, 191, 141),

        _AddFX = function(p659: any, p660: userdata, p661: userdata) -- Line: 4243, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p659:_RemoveFX(p660, p661);

            if p661 then
                for _, child in game.ServerStorage.Mutation_FX.Sandy:GetChildren() do
                    local v662 = child:Clone();
                    v662.Parent = p661;
                    v662.Enabled = true;
                    v662:AddTag("Cleanup_Sandy");
                end;
            end;

            for _, descendant in p660:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(240, 206, 119);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Sand;
                    descendant.Reflectance = 0;
                    descendant:AddTag("SandyVisual");
                end;
            end;
        end,

        _RemoveFX = function(p663: any, p664: userdata, p665: userdata) -- Line: 4269, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v667(p666) -- Line: 4270
                for _, descendant in p666:GetDescendants() do
                    if descendant:HasTag("Cleanup_Sandy") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p665 then
                v667(p665);
            end;

            if p664 then
                v667(p664);
            end;

            for _, descendant in p664:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("SandyVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("SandyVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Clay = {
        Id = "K",
        Name = "Clay",
        ValueMulti = 5,
        Color = Color3.fromRGB(147, 129, 122),

        _AddFX = function(p668: any, p669: userdata, p670: userdata) -- Line: 4303, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p668:_RemoveFX(p669, p670);

            if p670 then
                for _, child in game.ServerStorage.Mutation_FX.Clay:GetChildren() do
                    local v671 = child:Clone();
                    v671.Parent = p670;
                    v671.Enabled = true;
                    v671:AddTag("Cleanup_Clay");
                end;
            end;

            for _, descendant in p669:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(147, 129, 122);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Plaster;
                    descendant.Reflectance = 0.5;
                    descendant:AddTag("ClayVisual");
                end;
            end;
        end,

        _RemoveFX = function(p672: any, p673: userdata, p674: userdata) -- Line: 4331, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v676(p675) -- Line: 4332
                for _, descendant in p675:GetDescendants() do
                    if descendant:HasTag("Cleanup_Clay") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p674 then
                v676(p674);
            end;

            if p673 then
                v676(p673);
            end;

            for _, descendant in p673:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ClayVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("ClayVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Ceramic = {
        Id = "L",
        Name = "Ceramic",
        ValueMulti = 32,
        Color = Color3.fromRGB(234, 184, 146),

        _AddFX = function(p677: any, p678: userdata, p679: userdata) -- Line: 4367, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p677:_RemoveFX(p678, p679);

            if p679 then
                for _, child in game.ServerStorage.Mutation_FX.Ceramic:GetChildren() do
                    local v680 = child:Clone();
                    v680.Parent = p679;
                    v680.Enabled = true;
                    v680:AddTag("Cleanup_Ceramic");
                end;
            end;

            for _, descendant in p678:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(234, 184, 146);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Concrete;
                    descendant:AddTag("CeramicVisual");
                end;
            end;
        end,

        _RemoveFX = function(p681: any, p682: userdata, p683: userdata) -- Line: 4394, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v685(p684) -- Line: 4395
                for _, descendant in p684:GetDescendants() do
                    if descendant:HasTag("Cleanup_Ceramic") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p683 then
                v685(p683);
            end;

            if p682 then
                v685(p682);
            end;

            for _, descendant in p682:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CeramicVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("CeramicVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Friendbound = {
        Id = "M",
        Name = "Friendbound",
        ValueMulti = 70,
        Color = Color3.fromRGB(255, 0, 127),

        _AddFX = function(p686: any, p687: userdata, p688: userdata) -- Line: 4430, Name: _AddFX
            -- upvalues: u3 (copy)
            p686:_RemoveFX(p687, p688);

            if p688 then
                for _, child in game.ServerStorage.Mutation_FX.Friendbound:GetChildren() do
                    local v689 = child:Clone();
                    v689.Parent = p688;
                    v689.Enabled = true;
                    v689:AddTag("Cleanup_Friendbound");
                end;
            end;

            for _, descendant in p687:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = u3[descendant]:Lerp(Color3.fromRGB(255, 0, 127), 0.4);
                    descendant:AddTag("FriendboundVisual");
                end;
            end;
        end,

        _RemoveFX = function(p690: any, p691: userdata, p692: userdata) -- Line: 4462, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v694(p693) -- Line: 4463
                for _, descendant in p693:GetDescendants() do
                    if descendant:HasTag("Cleanup_Friendbound") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p692 then
                v694(p692);
            end;

            if p691 then
                v694(p691);
            end;

            for _, descendant in p691:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("FriendboundVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("FriendboundVisual");
                end;
            end;
        end
    },
    Tempestuous = {
        Id = "N",
        Name = "Tempestuous",
        ValueMulti = 12,
        Color = Color3.fromRGB(143, 163, 180),

        _AddFX = function(p695: any, p696: userdata, p697: userdata) -- Line: 4493, Name: _AddFX
            p695:_RemoveFX(p696, p697);

            if p697 then
                for _, v in { game.ServerStorage.Mutation_FX.Twisted, game.ServerStorage.Mutation_FX.Tempestuous } do
                    for _, child in v:GetChildren() do
                        local v698 = child:Clone();
                        v698.Parent = p697;
                        v698.Enabled = true;
                        v698:AddTag("Cleanup_Tempestuous");
                    end;
                end;
            end;

            for _, descendant in p696:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant:AddTag("TempestuousVisual");
                end;
            end;
        end,

        _RemoveFX = function(p699: any, p700: userdata, p701: userdata) -- Line: 4520, Name: _RemoveFX
            if p701 then
                for _, child in p701:GetChildren() do
                    if child:HasTag("Cleanup_Tempestuous") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p700:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("TempestuousVisual") then
                    descendant:RemoveTag("TempestuousVisual");
                end;
            end;
        end
    },
    Infected = {
        Id = "O",
        Name = "Infected",
        ValueMulti = 75,
        Color = Color3.fromRGB(67, 167, 0),

        _AddFX = function(p702: any, p703: userdata, p704: userdata) -- Line: 4545, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p702:_RemoveFX(p703, p704);

            if p704 then
                for _, child in game.ServerStorage.Mutation_FX.Infected:GetChildren() do
                    local v705 = child:Clone();
                    v705.Parent = p704;
                    v705.Enabled = true;
                    v705:AddTag("Cleanup_Infected");
                end;
            end;

            for _, descendant in p703:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(65, 175, 0);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant:AddTag("InfectedVisual");
                end;
            end;
        end,

        _RemoveFX = function(p706: any, p707: userdata, p708: userdata) -- Line: 4572, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v710(p709) -- Line: 4573
                for _, descendant in p709:GetDescendants() do
                    if descendant:HasTag("Cleanup_Infected") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p708 then
                v710(p708);
            end;

            if p707 then
                v710(p707);
            end;

            for _, descendant in p707:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("InfectedVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("InfectedVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Radioactive = {
        Id = "P",
        Name = "Radioactive",
        ValueMulti = 55,
        Color = Color3.fromRGB(98, 255, 0),

        _AddFX = function(p711: any, p712: userdata, p713: userdata) -- Line: 4608, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p711:_RemoveFX(p712, p713);

            if p713 then
                for _, child in game.ServerStorage.Mutation_FX.Radioactive:GetChildren() do
                    local v714 = child:Clone();
                    v714.Parent = p713;
                    v714.Enabled = true;
                    v714:AddTag("Cleanup_Radioactive");
                end;
            end;

            for _, descendant in p712:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(65, 175, 0);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("RadioactiveVisual");
                end;
            end;
        end,

        _RemoveFX = function(p715: any, p716: userdata, p717: userdata) -- Line: 4635, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v719(p718) -- Line: 4636
                for _, descendant in p718:GetDescendants() do
                    if descendant:HasTag("Cleanup_Radioactive") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p717 then
                v719(p717);
            end;

            if p716 then
                v719(p716);
            end;

            for _, descendant in p716:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("RadioactiveVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("RadioactiveVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Chakra = {
        Id = "R",
        Name = "Chakra",
        ValueMulti = 15,
        Color = Color3.fromRGB(255, 80, 65),

        _AddFX = function(p720: any, p721: userdata, p722: userdata) -- Line: 4671, Name: _AddFX
            p720:_RemoveFX(p721, p722);
            local Children = game.ServerStorage.Mutation_FX.Chakra:GetChildren();

            if p722 then
                for _, v in Children do
                    local v723 = v:Clone();
                    v723.Parent = p722;
                    v723.Enabled = true;
                    v723:AddTag("Cleanup_Chakra");
                end;
            end;

            local v724 = 0;

            for _, descendant in p721:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p722 then
                    v724 = v724 + 1;

                    if v724 % 3 == 0 then
                        local v725 = Children[math.random(1, #Children)]:Clone();
                        v725.Parent = descendant;
                        v725.Enabled = true;
                        v725:AddTag("Cleanup_Chakra");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p726: any, p727: userdata, p728: userdata) -- Line: 4700, Name: _RemoveFX
            local function v730(p729) -- Line: 4701
                for _, descendant in p729:GetDescendants() do
                    if descendant:HasTag("Cleanup_Chakra") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p728 then
                v730(p728);
            end;

            if p727 then
                v730(p727);
            end;
        end
    },
    FoxfireChakra = {
        Id = "S",
        Name = "FoxfireChakra",
        ValueMulti = 90,
        Color = Color3.fromRGB(255, 80, 65),

        _AddFX = function(p731: any, p732: userdata, p733: userdata) -- Line: 4720, Name: _AddFX
            p731:_RemoveFX(p732, p733);
            local Children = game.ServerStorage.Mutation_FX.FoxfireChakra:GetChildren();
            local v734 = nil;

            for _, v in Children do
                if v.Name == "Flames" then
                    v734 = v;
                    break;
                end;
            end;

            if p733 then
                for _, v in Children do
                    local v735 = v:Clone();
                    v735.Parent = p733;
                    v735.Enabled = true;
                    v735:AddTag("Cleanup_FoxfireChakra");
                end;
            end;

            local v736 = 0;

            for _, descendant in p732:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p733 then
                    v736 = v736 + 1;

                    if v736 % 2 == 0 then
                        local v737 = Children[math.random(1, #Children)]:Clone();
                        v737.Parent = descendant;
                        v737.Enabled = true;
                        v737:AddTag("Cleanup_FoxfireChakra");
                    end;

                    if v736 % 3 == 0 and v734 then
                        local v738 = v734:Clone();
                        v738.Parent = descendant;
                        v738.Enabled = true;
                        v738:AddTag("Cleanup_FoxfireChakra");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p739: any, p740: userdata, p741: userdata) -- Line: 4765, Name: _RemoveFX
            local function v743(p742) -- Line: 4766
                for _, descendant in p742:GetDescendants() do
                    if descendant:HasTag("Cleanup_FoxfireChakra") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p741 then
                v743(p741);
            end;

            if p740 then
                v743(p740);
            end;
        end
    },
    Cute = {
        Id = "CUTEID",
        Name = "Cute",
        ValueMulti = 20,
        Color = Color3.fromRGB(255, 170, 255),

        _AddFX = function(p744: any, p745: userdata, p746: userdata) -- Line: 4785, Name: _AddFX
            p744:_RemoveFX(p745, p746);
            local Children = game.ServerStorage.Mutation_FX.Cute:GetChildren();
            local v747 = nil;

            for _, v in Children do
                if v.Name == "Flames" then
                    v747 = v;
                    break;
                end;
            end;

            if p746 then
                for _, v in Children do
                    local v748 = v:Clone();
                    v748.Parent = p746;
                    v748.Enabled = true;
                    v748:AddTag("Cleanup_Cute");
                end;
            end;

            local v749 = 0;

            for _, descendant in p745:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p746 then
                    v749 = v749 + 1;

                    if v749 % 2 == 0 then
                        local v750 = Children[math.random(1, #Children)]:Clone();
                        v750.Parent = descendant;
                        v750.Enabled = true;
                        v750:AddTag("Cleanup_Cute");
                    end;

                    if v749 % 3 == 0 and v747 then
                        local v751 = v747:Clone();
                        v751.Parent = descendant;
                        v751.Enabled = true;
                        v751:AddTag("Cleanup_Cute");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p752: any, p753: userdata, p754: userdata) -- Line: 4830, Name: _RemoveFX
            local function v756(p755) -- Line: 4831
                for _, descendant in p755:GetDescendants() do
                    if descendant:HasTag("Cleanup_Cute") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p754 then
                v756(p754);
            end;

            if p753 then
                v756(p753);
            end;
        end
    },
    Heartbound = {
        Id = "SHeartbound",
        Name = "Heartbound",
        ValueMulti = 100,
        Color = Color3.fromRGB(255, 0, 0),

        _AddFX = function(p757: any, p758: userdata, p759: userdata) -- Line: 4850, Name: _AddFX
            p757:_RemoveFX(p758, p759);
            local Children = game.ServerStorage.Mutation_FX.Heartbound:GetChildren();
            local v760 = nil;

            for _, v in Children do
                if v.Name == "Flames" then
                    v760 = v;
                    break;
                end;
            end;

            if p759 then
                for _, v in Children do
                    local v761 = v:Clone();
                    v761.Parent = p759;
                    v761.Enabled = true;
                    v761:AddTag("Cleanup_Heartbound");
                end;
            end;

            local v762 = 0;

            for _, descendant in p758:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p759 then
                    v762 = v762 + 1;

                    if v762 % 2 == 0 then
                        local v763 = Children[math.random(1, #Children)]:Clone();
                        v763.Parent = descendant;
                        v763.Enabled = true;
                        v763:AddTag("Cleanup_Heartbound");
                    end;

                    if v762 % 3 == 0 and v760 then
                        local v764 = v760:Clone();
                        v764.Parent = descendant;
                        v764.Enabled = true;
                        v764:AddTag("Cleanup_Heartbound");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p765: any, p766: userdata, p767: userdata) -- Line: 4895, Name: _RemoveFX
            local function v769(p768) -- Line: 4896
                for _, descendant in p768:GetDescendants() do
                    if descendant:HasTag("Cleanup_Heartbound") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p767 then
                v769(p767);
            end;

            if p766 then
                v769(p766);
            end;
        end
    },
    CorruptChakra = {
        Id = "T",
        Name = "CorruptChakra",
        ValueMulti = 15,
        Color = Color3.fromRGB(0, 85, 255),

        _AddFX = function(p770: any, p771: userdata, p772: userdata) -- Line: 4915, Name: _AddFX
            p770:_RemoveFX(p771, p772);
            local Children = game.ServerStorage.Mutation_FX.CorruptChakra:GetChildren();

            if p772 then
                for _, v in Children do
                    local v773 = v:Clone();
                    v773.Parent = p772;
                    v773.Enabled = true;
                    v773:AddTag("Cleanup_CorruptChakra");
                end;
            end;

            local v774 = 0;

            for _, descendant in p771:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p772 then
                    v774 = v774 + 1;

                    if v774 % 3 == 0 then
                        local v775 = Children[math.random(1, #Children)]:Clone();
                        v775.Parent = descendant;
                        v775.Enabled = true;
                        v775:AddTag("Cleanup_CorruptChakra");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p776: any, p777: userdata, p778: userdata) -- Line: 4944, Name: _RemoveFX
            local function v780(p779) -- Line: 4945
                for _, descendant in p779:GetDescendants() do
                    if descendant:HasTag("Cleanup_CorruptChakra") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p778 then
                v780(p778);
            end;

            if p777 then
                v780(p777);
            end;
        end
    },
    CorruptFoxfireChakra = {
        Id = "U",
        Name = "CorruptFoxfireChakra",
        ValueMulti = 90,
        Color = Color3.fromRGB(0, 0, 255),

        _AddFX = function(p781: any, p782: userdata, p783: userdata) -- Line: 4964, Name: _AddFX
            p781:_RemoveFX(p782, p783);
            local Children = game.ServerStorage.Mutation_FX.CorruptFoxfireChakra:GetChildren();
            local v784 = nil;

            for _, v in Children do
                if v.Name == "Flames" then
                    v784 = v;
                    break;
                end;
            end;

            if p783 then
                for _, v in Children do
                    local v785 = v:Clone();
                    v785.Parent = p783;
                    v785.Enabled = true;
                    v785:AddTag("Cleanup_CorruptFoxfireChakra");
                end;
            end;

            local v786 = 0;

            for _, descendant in p782:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p783 then
                    v786 = v786 + 1;

                    if v786 % 2 == 0 then
                        local v787 = Children[math.random(1, #Children)]:Clone();
                        v787.Parent = descendant;
                        v787.Enabled = true;
                        v787:AddTag("Cleanup_CorruptFoxfireChakra");
                    end;

                    if v786 % 3 == 0 and v784 then
                        local v788 = v784:Clone();
                        v788.Parent = descendant;
                        v788.Enabled = true;
                        v788:AddTag("Cleanup_CorruptFoxfireChakra");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p789: any, p790: userdata, p791: userdata) -- Line: 5009, Name: _RemoveFX
            local function v793(p792) -- Line: 5010
                for _, descendant in p792:GetDescendants() do
                    if descendant:HasTag("Cleanup_CorruptFoxfireChakra") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p791 then
                v793(p791);
            end;

            if p790 then
                v793(p790);
            end;
        end
    },
    AscendedChakra = {
        Id = "ACH",
        Name = "AscendedChakra",
        ValueMulti = 230,
        Color = Color3.fromRGB(255, 255, 0),

        _AddFX = function(p794: any, p795: userdata, p796: userdata) -- Line: 5029, Name: _AddFX
            -- upvalues: u6 (copy), u3 (copy)
            p794:_RemoveFX(p795, p796);
            local Children = game.ServerStorage.Mutation_FX.AscendedChakra:GetChildren();
            local v797 = nil;

            for _, v in Children do
                if v.Name == "Flames" then
                    v797 = v;
                    break;
                end;
            end;

            if p796 then
                for _, v in Children do
                    local v798 = v:Clone();
                    v798.Parent = p796;
                    v798.Enabled = true;
                    v798:AddTag("Cleanup_AscendedChakra");
                end;
            end;

            local v799 = 0;

            for _, descendant in p795:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p796 then
                    v799 = v799 + 1;
                    descendant:AddTag("AscendedChakraVisual");
                    u6[descendant] = u6[descendant] or descendant.Material;
                    u3[descendant] = u3[descendant] or descendant.Color;

                    if v799 % 2 == 0 then
                        descendant.Color = Color3.fromRGB(255, 255, 255);
                    else
                        descendant.Color = Color3.fromRGB(255, 255, 0);
                    end;

                    if math.random() < 0.5 then
                        descendant.Material = Enum.Material.Neon;
                    else
                        descendant.Material = Enum.Material.ForceField;
                    end;

                    if v799 % 2 == 0 and #Children > 0 then
                        local v800 = Children[math.random(1, #Children)]:Clone();
                        v800.Parent = descendant;
                        v800.Enabled = true;
                        v800:AddTag("Cleanup_AscendedChakra");
                    end;

                    if v799 % 3 == 0 and v797 then
                        local v801 = v797:Clone();
                        v801.Parent = descendant;
                        v801.Enabled = true;
                        v801:AddTag("Cleanup_AscendedChakra");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p802: any, p803: userdata, p804: userdata) -- Line: 5094, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v806(p805) -- Line: 5095
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p805:GetDescendants() do
                    if descendant:HasTag("Cleanup_AscendedChakra") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("AscendedChakraVisual") then
                        descendant:RemoveTag("AscendedChakraVisual");
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;

            if p804 then
                v806(p804);
            end;

            if p803 then
                v806(p803);
            end;
        end
    },
    Static = {
        Id = "V",
        Name = "Static",
        ValueMulti = 8,
        Color = Color3.fromRGB(255, 255, 0),

        _AddFX = function(p807: any, p808: userdata, p809: userdata) -- Line: 5124, Name: _AddFX
            p807:_RemoveFX(p808, p809);

            if p809 then
                for _, child in game.ServerStorage.Mutation_FX.Static:GetChildren() do
                    local v810 = child:Clone();
                    v810.Parent = p809;
                    v810:AddTag("Cleanup_Static");
                end;
            end;
        end,

        _RemoveFX = function(p811: any, p812: userdata, p813: userdata) -- Line: 5137, Name: _RemoveFX
            if p813 then
                for _, child in p813:GetChildren() do
                    if child:HasTag("Cleanup_Static") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    HarmonisedChakra = {
        Id = "W",
        Name = "HarmonisedChakra",
        ValueMulti = 35,
        Color = Color3.fromRGB(170, 85, 255),

        _AddFX = function(p814: any, p815: userdata, p816: userdata) -- Line: 5153, Name: _AddFX
            p814:_RemoveFX(p815, p816);
            local Children = game.ServerStorage.Mutation_FX.HarmonisedChakra:GetChildren();

            if p816 then
                for _, v in Children do
                    local v817 = v:Clone();
                    v817.Parent = p816;
                    v817.Enabled = true;
                    v817:AddTag("Cleanup_HarmonisedChakra");
                end;
            end;

            local v818 = 0;

            for _, descendant in p815:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p816 then
                    v818 = v818 + 1;

                    if v818 % 3 == 0 then
                        local v819 = Children[math.random(1, #Children)]:Clone();
                        v819.Parent = descendant;
                        v819.Enabled = true;
                        v819:AddTag("Cleanup_HarmonisedChakra");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p820: any, p821: userdata, p822: userdata) -- Line: 5182, Name: _RemoveFX
            local function v824(p823) -- Line: 5183
                for _, descendant in p823:GetDescendants() do
                    if descendant:HasTag("Cleanup_HarmonisedChakra") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p822 then
                v824(p822);
            end;

            if p821 then
                v824(p821);
            end;
        end
    },
    HarmonisedFoxfireChakra = {
        Id = "X",
        Name = "HarmonisedFoxfireChakra",
        ValueMulti = 190,
        Color = Color3.fromRGB(170, 85, 255),

        _AddFX = function(p825: any, p826: userdata, p827: userdata) -- Line: 5202, Name: _AddFX
            p825:_RemoveFX(p826, p827);
            local Children = game.ServerStorage.Mutation_FX.HarmonisedFoxfireChakra:GetChildren();
            local v828 = nil;

            for _, v in Children do
                if v.Name == "Flames" then
                    v828 = v;
                    break;
                end;
            end;

            if p827 then
                for _, v in Children do
                    local v829 = v:Clone();
                    v829.Parent = p827;
                    v829.Enabled = true;
                    v829:AddTag("Cleanup_HarmonisedFoxfireChakra");
                end;
            end;

            local v830 = 0;

            for _, descendant in p826:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p827 then
                    v830 = v830 + 1;

                    if v830 % 2 == 0 then
                        local v831 = Children[math.random(1, #Children)]:Clone();
                        v831.Parent = descendant;
                        v831.Enabled = true;
                        v831:AddTag("Cleanup_HarmonisedFoxfireChakra");
                    end;

                    if v830 % 3 == 0 and v828 then
                        local v832 = v828:Clone();
                        v832.Parent = descendant;
                        v832.Enabled = true;
                        v832:AddTag("Cleanup_HarmonisedFoxfireChakra");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p833: any, p834: userdata, p835: userdata) -- Line: 5247, Name: _RemoveFX
            local function v837(p836) -- Line: 5248
                for _, descendant in p836:GetDescendants() do
                    if descendant:HasTag("Cleanup_HarmonisedFoxfireChakra") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p835 then
                v837(p835);
            end;

            if p834 then
                v837(p834);
            end;
        end
    },
    Pasta = {
        Id = "PA",
        Name = "Pasta",
        ValueMulti = 3,
        Color = Color3.fromRGB(255, 223, 128),

        _AddFX = function(p838: any, p839: userdata, p840: userdata) -- Line: 5267, Name: _AddFX
            p838:_RemoveFX(p839, p840);
            local v841 = {};

            for _, child in game.ServerStorage.Mutation_FX.Spaghetti:GetChildren() do
                if child.Name == "Pasta" then
                    table.insert(v841, child);
                end;
            end;

            if p840 then
                for _, v in v841 do
                    if not p840:FindFirstChild(v.Name) then
                        local v842 = v:Clone();
                        v842.Parent = p840;
                        v842.Enabled = true;
                        v842:AddTag("Cleanup_Pasta");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p843: any, p844: userdata, p845: userdata) -- Line: 5291, Name: _RemoveFX
            local function v847(p846) -- Line: 5292
                for _, descendant in p846:GetDescendants() do
                    if descendant:HasTag("Cleanup_Pasta") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p845 then
                v847(p845);
            end;

            if p844 then
                v847(p844);
            end;
        end
    },
    Sauce = {
        Id = "SA",
        Name = "Sauce",
        ValueMulti = 3,
        Color = Color3.fromRGB(200, 45, 35),

        _AddFX = function(p848: any, p849: userdata, p850: userdata) -- Line: 5310, Name: _AddFX
            p848:_RemoveFX(p849, p850);
            local v851 = {};

            for _, child in game.ServerStorage.Mutation_FX.Spaghetti:GetChildren() do
                if child.Name == "Sauce" then
                    table.insert(v851, child);
                end;
            end;

            if p850 then
                for _, v in v851 do
                    if not p850:FindFirstChild(v.Name) then
                        local v852 = v:Clone();
                        v852.Parent = p850;
                        v852.Enabled = true;
                        v852:AddTag("Cleanup_Sauce");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p853: any, p854: userdata, p855: userdata) -- Line: 5334, Name: _RemoveFX
            local function v857(p856) -- Line: 5335
                for _, descendant in p856:GetDescendants() do
                    if descendant:HasTag("Cleanup_Sauce") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p855 then
                v857(p855);
            end;

            if p854 then
                v857(p854);
            end;
        end
    },
    Meatball = {
        Id = "MB",
        Name = "Meatball",
        ValueMulti = 3,
        Color = Color3.fromRGB(139, 69, 19),

        _AddFX = function(p858: any, p859: userdata, p860: userdata) -- Line: 5353, Name: _AddFX
            p858:_RemoveFX(p859, p860);
            local v861 = {};

            for _, child in game.ServerStorage.Mutation_FX.Spaghetti:GetChildren() do
                if child.Name == "Meatball" then
                    table.insert(v861, child);
                end;
            end;

            if p860 then
                for _, v in v861 do
                    if not p860:FindFirstChild(v.Name) then
                        local v862 = v:Clone();
                        v862.Parent = p860;
                        v862.Enabled = true;
                        v862:AddTag("Cleanup_Meatball");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p863: any, p864: userdata, p865: userdata) -- Line: 5377, Name: _RemoveFX
            local function v867(p866) -- Line: 5378
                for _, descendant in p866:GetDescendants() do
                    if descendant:HasTag("Cleanup_Meatball") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p865 then
                v867(p865);
            end;

            if p864 then
                v867(p864);
            end;
        end
    },
    Spaghetti = {
        Id = "SP",
        Name = "Spaghetti",
        ValueMulti = 15,
        Color = Color3.fromRGB(255, 140, 70),

        _AddFX = function(p868: any, p869: userdata, p870: userdata) -- Line: 5396, Name: _AddFX
            p868:_RemoveFX(p869, p870);
            local Children = game.ServerStorage.Mutation_FX.Spaghetti:GetChildren();

            if p870 then
                for _, v in Children do
                    if not p870:FindFirstChild(v.Name) then
                        local v871 = v:Clone();
                        v871.Parent = p870;
                        v871.Enabled = true;
                        v871:AddTag("Cleanup_Spaghetti");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p872: any, p873: userdata, p874: userdata) -- Line: 5413, Name: _RemoveFX
            local function v876(p875) -- Line: 5414
                for _, descendant in p875:GetDescendants() do
                    if descendant:HasTag("Cleanup_Spaghetti") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p874 then
                v876(p874);
            end;

            if p873 then
                v876(p873);
            end;
        end
    },
    Eclipsed = {
        Id = "EC",
        Name = "Eclipsed",
        ValueMulti = 20,
        Color = Color3.fromRGB(44, 111, 162),

        _AddFX = function(p877: any, p878: userdata, p879: userdata) -- Line: 5432, Name: _AddFX
            -- upvalues: u3 (copy)
            p877:_RemoveFX(p878, p879);

            if p879 then
                for _, child in game.ServerStorage.Mutation_FX.Eclipsed:GetChildren() do
                    local v880 = child:Clone();
                    v880.Parent = p879;
                    v880.Enabled = true;
                    v880:AddTag("Cleanup_Eclipsed");
                end;
            end;

            for _, descendant in p878:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(0, 0, 0), 0.45);
                    descendant:AddTag("EclipsedVisual");
                end;
            end;
        end,

        _RemoveFX = function(p881: any, p882: userdata, p883: userdata) -- Line: 5458, Name: _RemoveFX
            -- upvalues: u3 (copy)
            if p883 then
                for _, child in p883:GetChildren() do
                    if child:HasTag("Cleanup_Eclipsed") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p882:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("EclipsedVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("EclipsedVisual");
                end;
            end;
        end
    },
    Enlightened = {
        Id = "EN",
        Name = "Enlightened",
        ValueMulti = 35,
        Color = Color3.fromRGB(255, 255, 255),

        _AddFX = function(p884: any, p885: userdata, p886: userdata) -- Line: 5485, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p884:_RemoveFX(p885, p886);
            local Color3_fromRGB_ret = Color3.fromRGB(218, 133, 65);
            local v887 = {};

            for _, descendant in p885:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    local Color = descendant.Color;
                    v887[Color] = (v887[Color] or 0) + 1;
                end;
            end;

            local v888 = 0;

            for i, v in pairs(v887) do
                if v888 <= v then
                    Color3_fromRGB_ret = i;
                    v888 = v;
                end;
            end;

            for _, descendant in p885:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) and descendant.Color == Color3_fromRGB_ret) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(218, 133, 65);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("EnlightenedVisual");
                end;
            end;

            if p886 then
                for _, child in game.ServerStorage.Mutation_FX.Enlightened:GetChildren() do
                    local v889 = child:Clone();
                    v889.Parent = p886;
                    v889.Enabled = true;
                    v889:AddTag("Cleanup_Enlightened");
                end;
            end;
        end,

        _RemoveFX = function(p890: any, p891: userdata, p892: userdata) -- Line: 5535, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v894(p893) -- Line: 5537
                for _, descendant in p893:GetDescendants() do
                    if descendant:HasTag("Cleanup_Enlightened") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p892 then
                v894(p892);
            end;

            if p891 then
                v894(p891);
            end;

            for _, descendant in p891:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("EnlightenedVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("EnlightenedVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Tranquil = {
        Id = "TQ",
        Name = "Tranquil",
        ValueMulti = 20,
        Color = Color3.fromRGB(255, 255, 255),

        _AddFX = function(p895: any, p896: userdata, p897: userdata) -- Line: 5568, Name: _AddFX
            p895:_RemoveFX(p896, p897);
            local Item_Seed = p896:FindFirstChild("Item_Seed");
            local v898 = not (Item_Seed and Item_Seed:IsA("NumberValue")) and 0 or Item_Seed.Value;
            local Random_new_ret = Random.new(v898);
            local Children = game.ServerStorage.Mutation_FX.Tranquil:GetChildren();
            local v899 = 0;

            for _, descendant in p896:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    v899 = v899 + 1;

                    if v899 % 5 == 0 or v899 == 1 then
                        local v900 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                        v900.Enabled = true;
                        v900.Rate = Random_new_ret:NextInteger(30, 50) * 0.01;
                        v900.Parent = descendant;
                        v900:AddTag("Cleanup_Tranquil");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p901: any, p902: userdata, p903: userdata) -- Line: 5593, Name: _RemoveFX
            local function v905(p904) -- Line: 5595
                for _, descendant in p904:GetDescendants() do
                    if descendant:HasTag("Cleanup_Tranquil") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p903 then
                v905(p903);
            end;

            if p902 then
                v905(p902);
            end;
        end
    },
    Corrupt = {
        Id = "CR",
        Name = "Corrupt",
        ValueMulti = 20,
        Color = Color3.fromRGB(176, 23, 26),

        _AddFX = function(p906: any, p907: userdata, p908: userdata) -- Line: 5612, Name: _AddFX
            p906:_RemoveFX(p907, p908);

            if p908 then
                for _, child in game.ServerStorage.Mutation_FX.Corrupt:GetChildren() do
                    local v909 = child:Clone();
                    v909.Parent = p908;
                    v909:AddTag("Cleanup_Corrupt");

                    if v909:IsA("ParticleEmitter") then
                        v909.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p907:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(176, 23, 26), 0.5);
                    descendant:AddTag("CorruptVisual");
                end;
            end;
        end,

        _RemoveFX = function(p910: any, p911: userdata, p912: userdata) -- Line: 5636, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v914(p913) -- Line: 5637
                for _, descendant in p913:GetDescendants() do
                    if descendant:HasTag("Cleanup_Corrupt") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p912 then
                v914(p912);
            end;

            for _, descendant in p911:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CorruptVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("CorruptVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Toxic = {
        Id = "TX",
        Name = "Toxic",
        ValueMulti = 15,
        Color = Color3.fromRGB(85, 255, 0),

        _AddFX = function(p915: any, p916: userdata, p917: userdata) -- Line: 5665, Name: _AddFX
            p915:_RemoveFX(p916, p917);

            if p917 then
                for _, child in game.ServerStorage.Mutation_FX.Toxic:GetChildren() do
                    local v918 = child:Clone();
                    v918.Parent = p917;
                    v918.Enabled = true;
                    v918:AddTag("Cleanup_Toxic");
                end;
            end;
        end,

        _RemoveFX = function(p919: any, p920: userdata, p921: userdata) -- Line: 5679, Name: _RemoveFX
            local function v923(p922) -- Line: 5680
                for _, descendant in p922:GetDescendants() do
                    if descendant:HasTag("Cleanup_Toxic") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p921 then
                v923(p921);
            end;

            if p920 then
                v923(p920);
            end;
        end
    },
    Acidic = {
        Id = "AC",
        Name = "Acidic",
        ValueMulti = 15,
        Color = Color3.fromRGB(224, 245, 129),

        _AddFX = function(p924: any, p925: userdata, p926: userdata) -- Line: 5697, Name: _AddFX
            p924:_RemoveFX(p925, p926);

            if p926 then
                for _, child in game.ServerStorage.Mutation_FX.Acidic:GetChildren() do
                    local v927 = child:Clone();
                    v927.Parent = p926;
                    v927.Enabled = true;
                    v927:AddTag("Cleanup_Acidic");
                end;
            end;
        end,

        _RemoveFX = function(p928: any, p929: userdata, p930: userdata) -- Line: 5710, Name: _RemoveFX
            local function v932(p931) -- Line: 5711
                for _, descendant in p931:GetDescendants() do
                    if descendant:HasTag("Cleanup_Acidic") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p930 then
                v932(p930);
            end;

            if p929 then
                v932(p929);
            end;
        end
    },
    Corrosive = {
        Id = "CV",
        Name = "Corrosive",
        ValueMulti = 40,
        Color = Color3.fromRGB(0, 255, 0),

        _AddFX = function(p933: any, p934: userdata, p935: userdata) -- Line: 5728, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p933:_RemoveFX(p934, p935);
            local v936 = {};

            for _, v in { "Acidic", "Toxic" } do
                for _, child in game.ServerStorage.Mutation_FX[v]:GetChildren() do
                    table.insert(v936, child);
                end;
            end;

            if p935 then
                for _, v in v936 do
                    local v937 = v:Clone();
                    v937.Parent = p935;
                    v937.Enabled = true;
                    v937:AddTag("Cleanup_Corrosive");
                end;
            end;

            local v938 = 0;

            for _, descendant in p934:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p935 then
                    v938 = v938 + 1;

                    if v938 % 2 == 0 and #v936 > 0 then
                        local v939 = v936[math.random(1, #v936)]:Clone();
                        v939.Parent = descendant;
                        v939.Enabled = true;
                        v939:AddTag("Cleanup_Corrosive");
                    end;

                    if Random.new():NextNumber() < 0.5 then
                        descendant:AddTag("CorrosiveVisual");
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = Color3.fromRGB(0, 255, 0);
                        descendant.Material = Enum.Material.Neon;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p940: any, p941: userdata, p942: userdata) -- Line: 5773, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v944(p943) -- Line: 5774
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p943:GetDescendants() do
                    if descendant:HasTag("Cleanup_Corrosive") then
                        descendant:Destroy();
                    elseif descendant:HasTag("CorrosiveVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        descendant.Material = u6[descendant] or descendant.Material;
                        u3[descendant] = nil;
                        u6[descendant] = nil;
                        descendant:RemoveTag("CorrosiveVisual");
                    end;
                end;
            end;

            if p942 then
                v944(p942);
            end;

            if p941 then
                v944(p941);
            end;
        end
    },
    Flaming = {
        Id = "FL",
        Name = "Flaming",
        ValueMulti = 25,
        Color = Color3.fromRGB(255, 85, 0),

        _AddFX = function(p945: any, p946: userdata, p947: userdata) -- Line: 5799, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p945:_RemoveFX(p946, p947);
            local Children = game.ServerStorage.Mutation_FX.Flaming:GetChildren();
            local v948 = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 128, 0), Color3.fromRGB(255, 255, 0) };

            if p947 then
                for _, v in Children do
                    local v949 = v:Clone();
                    v949.Parent = p947;
                    v949.Enabled = true;
                    v949:AddTag("Cleanup_Flaming");
                end;
            end;

            local v950 = 0;

            for _, descendant in p946:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p947 then
                    v950 = v950 + 1;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = v948[math.random(1, #v948)];

                    if v950 % 3 == 0 and #Children > 0 then
                        local v951 = Children[math.random(1, #Children)]:Clone();
                        v951.Parent = descendant;
                        v951.Enabled = true;
                        v951:AddTag("Cleanup_Flaming");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p952: any, p953: userdata, p954: userdata) -- Line: 5843, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v956(p955) -- Line: 5844
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p955:GetDescendants() do
                    if descendant:HasTag("Cleanup_Flaming") then
                        descendant:Destroy();
                    end;

                    if u3[descendant] then
                        descendant.Color = u3[descendant];
                        u3[descendant] = nil;
                    end;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;

            if p954 then
                v956(p954);
            end;

            if p953 then
                v956(p953);
            end;
        end
    },
    Blazing = {
        Id = "BZ",
        Name = "Blazing",
        ValueMulti = 52,
        Color = Color3.fromRGB(255, 90, 20),

        _AddFX = function(p957: any, p958: userdata, p959: userdata) -- Line: 5871, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p957:_RemoveFX(p958, p959);
            local Children = game.ServerStorage.Mutation_FX.Flaming:GetChildren();
            local v960 = { "Neon orange", "Br. yellowish orange", "Bright orange", "Bright red", "Bright yellow" };

            if p959 then
                for _, v in Children do
                    local v961 = v:Clone();
                    v961.Parent = p959;
                    v961.Enabled = true;
                    v961:AddTag("Cleanup_Blazing");
                end;
            end;

            local v962 = 0;

            for _, descendant in p958:GetDescendants() do
                if descendant:IsA("BasePart") then
                    v962 = v962 + 1;
                    u3[descendant] = u3[descendant] or descendant.BrickColor.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.BrickColor = BrickColor.new(v960[math.random(1, #v960)]);
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("BlazingVisual");

                    if descendant ~= p959 and (v962 % 2 == 0 and #Children > 0) then
                        local v963 = Children[math.random(1, #Children)]:Clone();
                        v963.Parent = descendant;
                        v963.Enabled = true;
                        v963:AddTag("Cleanup_Blazing");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p964: any, p965: userdata, p966: userdata) -- Line: 5918, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v969(p967) -- Line: 5919
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p967:GetDescendants() do
                    if descendant:HasTag("Cleanup_Blazing") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("BlazingVisual") then
                        local v968;

                        if u3[descendant] then
                            v968 = BrickColor.new(u3[descendant]);
                        else
                            v968 = descendant.BrickColor;
                        end;

                        descendant.BrickColor = v968;
                        u3[descendant] = nil;
                        descendant:RemoveTag("BlazingVisual");

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;

            if p966 then
                v969(p966);
            end;

            if p965 then
                v969(p965);
            end;
        end
    },
    Infernal = {
        Id = "IN",
        Name = "Infernal",
        ValueMulti = 180,
        Color = Color3.fromRGB(101, 255, 91),

        _AddFX = function(p970: any, p971: userdata, p972: userdata) -- Line: 5948, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p970:_RemoveFX(p971, p972);
            local Children = game.ServerStorage.Mutation_FX.Infernal:GetChildren();
            local v973 = {
                Color3.fromRGB(153, 255, 102),
                Color3.fromRGB(101, 255, 91),
                Color3.fromRGB(50, 205, 50),
                Color3.fromRGB(124, 252, 0),
                Color3.fromRGB(178, 255, 102)
            };

            if p972 then
                for _, v in Children do
                    local v974 = v:Clone();
                    v974.Parent = p972;
                    v974.Enabled = true;
                    v974:AddTag("Cleanup_Infernal");
                end;
            end;

            local v975 = 0;

            for _, descendant in p971:GetDescendants() do
                if descendant:IsA("BasePart") then
                    v975 = v975 + 1;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = v973[math.random(1, #v973)];
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("InfernalPlantVisual");

                    if v975 % 3 == 0 then
                        local Attachment = Instance.new("Attachment", descendant);
                        local Attachment2 = Instance.new("Attachment", descendant);
                        Attachment.Position = Vector3.new(0, 0.15, 0);
                        Attachment2.Position = Vector3.new(0, -0.15, 0);
                        Attachment:AddTag("Cleanup_Infernal");
                        Attachment2:AddTag("Cleanup_Infernal");
                        local Trail = Instance.new("Trail");
                        Trail.Color = ColorSequence.new(Color3.fromRGB(101, 255, 91));
                        Trail.LightInfluence = 0;
                        Trail.Brightness = 3;
                        Trail.Attachment0 = Attachment;
                        Trail.Attachment1 = Attachment2;
                        Trail.Lifetime = 0.3;
                        Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
                        Trail.WidthScale = NumberSequence.new(2);
                        Trail.Parent = descendant;
                        Trail:AddTag("Cleanup_Infernal");
                    end;

                    if descendant ~= p972 and #Children > 0 then
                        local v976 = Children[math.random(1, #Children)]:Clone();
                        v976.Parent = descendant;
                        v976.Enabled = true;
                        v976:AddTag("Cleanup_Infernal");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p977: any, p978: userdata, p979: userdata) -- Line: 6021, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v981(p980) -- Line: 6022
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p980:GetDescendants() do
                    if descendant:HasTag("Cleanup_Infernal") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("InfernalPlantVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant:RemoveTag("InfernalPlantVisual");

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;

            if p979 then
                v981(p979);
            end;

            if p978 then
                v981(p978);
            end;
        end
    },
    Goldsparkle = {
        Id = "GLDSPARKLE",
        Name = "Goldsparkle",
        ValueMulti = 500,
        Color = Color3.fromRGB(255, 255, 0),

        _AddFX = function(p982: any, p983: userdata, p984: userdata) -- Line: 6051, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p982:_RemoveFX(p983, p984);
            local v985 = p983:FindFirstChild("Item_Seed") and (p983.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v985);
            local Children = game.ServerStorage.Mutation_FX.Goldsparkle:GetChildren();
            local v986 = {
                Color3.fromRGB(255, 255, 140),
                Color3.fromRGB(255, 238, 90),
                Color3.fromRGB(255, 220, 45),
                Color3.fromRGB(255, 196, 35),
                Color3.fromRGB(255, 170, 20)
            };

            local function SetFXColor(p987: userdata, p988) -- Line: 6066
                if p987:IsA("ParticleEmitter") or (p987:IsA("Trail") or p987:IsA("Beam")) then
                    p987.Color = ColorSequence.new(p988);
                end;

                for _, descendant in p987:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                        descendant.Color = ColorSequence.new(p988);
                    end;
                end;
            end;

            local function EnableFX(p989: userdata) -- Line: 6078
                if p989:IsA("ParticleEmitter") or (p989:IsA("Trail") or p989:IsA("Beam")) then
                    p989.Enabled = true;
                end;

                for _, descendant in p989:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            if p984 then
                for _, v in Children do
                    local v990 = v:Clone();
                    SetFXColor(v990, v986[Random_new_ret:NextInteger(1, #v986)]);
                    EnableFX(v990);
                    v990.Parent = p984;
                    v990:AddTag("Cleanup_Goldsparkle");
                end;
            end;

            local v991 = 0;

            for _, descendant in p983:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    v991 = v991 + 1;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = v986[Random_new_ret:NextInteger(1, #v986)];
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("GoldsparkleVisual");

                    if descendant ~= p984 and v991 % 3 == 0 then
                        if #Children > 0 then
                            local v992 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                            SetFXColor(v992, v986[Random_new_ret:NextInteger(1, #v986)]);
                            EnableFX(v992);
                            v992.Parent = descendant;
                            v992:AddTag("Cleanup_Goldsparkle");
                        end;

                        local Attachment = Instance.new("Attachment");
                        Attachment.Position = Vector3.new(0, 0.15, 0);
                        Attachment.Parent = descendant;
                        Attachment:AddTag("Cleanup_Goldsparkle");
                        local Attachment2 = Instance.new("Attachment");
                        Attachment2.Position = Vector3.new(0, -0.15, 0);
                        Attachment2.Parent = descendant;
                        Attachment2:AddTag("Cleanup_Goldsparkle");
                        local Trail = Instance.new("Trail");
                        Trail.Color = ColorSequence.new(v986[Random_new_ret:NextInteger(1, #v986)]);
                        Trail.LightInfluence = 0;
                        Trail.Brightness = 3;
                        Trail.Attachment0 = Attachment;
                        Trail.Attachment1 = Attachment2;
                        Trail.Lifetime = 0.3;
                        Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
                        Trail.WidthScale = NumberSequence.new(2);
                        Trail.Parent = descendant;
                        Trail:AddTag("Cleanup_Goldsparkle");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p993: any, p994: userdata, p995: userdata) -- Line: 6162, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v997(p996) -- Line: 6163
                for _, descendant in p996:GetDescendants() do
                    if descendant:HasTag("Cleanup_Goldsparkle") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p995 then
                v997(p995);
            end;

            if p994 then
                v997(p994);
            end;

            for _, descendant in p994:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GoldsparkleVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant:RemoveTag("GoldsparkleVisual");
                end;
            end;
        end
    },
    Oil = {
        Id = "OL",
        Name = "Oil",
        ValueMulti = 15,
        Color = Color3.fromRGB(52, 52, 77),

        _AddFX = function(p998: any, p999: userdata, p1000: userdata) -- Line: 6198, Name: _AddFX
            p998:_RemoveFX(p999, p1000);

            if p1000 then
                for _, child in game.ServerStorage.Mutation_FX.Oil:GetChildren() do
                    local v1001 = child:Clone();
                    v1001.Parent = p1000;
                    v1001.Enabled = true;
                    v1001:AddTag("Cleanup_Oil");
                    v1001:AddTag("Effect");
                end;
            end;

            for _, descendant in p999:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant:AddTag("OilVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1002: any, p1003: userdata, p1004: userdata) -- Line: 6218, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p1004 then
                for _, child in p1004:GetChildren() do
                    if child:HasTag("Cleanup_Oil") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1003:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("OilVisual") then
                    descendant:RemoveTag("OilVisual");
                    local v1005 = u6[descendant];

                    if v1005 then
                        descendant.Material = v1005;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Boil = {
        Id = "BOL",
        Name = "Boil",
        ValueMulti = 15,
        Color = Color3.fromRGB(150, 178, 225),

        _AddFX = function(p1006: any, p1007: userdata, p1008: userdata) -- Line: 6247, Name: _AddFX
            p1006:_RemoveFX(p1007, p1008);

            if p1008 then
                for _, child in game.ServerStorage.Mutation_FX.Boil:GetChildren() do
                    local v1009 = child:Clone();
                    v1009.Parent = p1008;
                    v1009.Enabled = true;
                    v1009:AddTag("Cleanup_Boil");
                    v1009:AddTag("Effect");
                end;
            end;
        end,

        _RemoveFX = function(p1010: any, p1011: userdata, p1012: userdata) -- Line: 6262, Name: _RemoveFX
            if p1012 then
                for _, child in p1012:GetChildren() do
                    if child:HasTag("Cleanup_Boil") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    OilBoil = {
        Id = "OB",
        Name = "OilBoil",
        ValueMulti = 30,
        Color = Color3.fromRGB(99, 118, 149),

        _AddFX = function(p1013: any, p1014: userdata, p1015: userdata) -- Line: 6277, Name: _AddFX
            p1013:_RemoveFX(p1014, p1015);

            if p1015 then
                for _, child in game.ServerStorage.Mutation_FX.Oil:GetChildren() do
                    local v1016 = child:Clone();
                    v1016.Parent = p1015;
                    v1016.Enabled = true;
                    v1016:AddTag("Cleanup_OilBoil");
                    v1016:AddTag("Effect");
                end;
            end;

            if p1015 then
                for _, child in game.ServerStorage.Mutation_FX.Boil:GetChildren() do
                    local v1017 = child:Clone();
                    v1017.Parent = p1015;
                    v1017.Enabled = true;
                    v1017:AddTag("Cleanup_OilBoil");
                    v1017:AddTag("Effect");
                end;
            end;
        end,

        _RemoveFX = function(p1018: any, p1019: userdata, p1020: userdata) -- Line: 6302, Name: _RemoveFX
            if p1020 then
                for _, child in p1020:GetChildren() do
                    if child:HasTag("Cleanup_OilBoil") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Fortune = {
        Id = "FR",
        Name = "Fortune",
        ValueMulti = 50,
        Color = Color3.fromRGB(255, 192, 5),

        _AddFX = function(p1021: any, p1022: userdata, p1023: userdata) -- Line: 6317, Name: _AddFX
            p1021:_RemoveFX(p1022, p1023);

            if p1023 then
                for _, child in game.ServerStorage.Mutation_FX.Fortune:GetChildren() do
                    local v1024 = child:Clone();
                    v1024.Parent = p1023;
                    v1024.Enabled = true;
                    v1024:AddTag("Cleanup_Fortune");
                    v1024:AddTag("Effect");
                end;
            end;
        end,

        _RemoveFX = function(p1025: any, p1026: userdata, p1027: userdata) -- Line: 6332, Name: _RemoveFX
            if p1027 then
                for _, child in p1027:GetChildren() do
                    if child:HasTag("Cleanup_Fortune") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Bloom = {
        Id = "BL",
        Name = "Bloom",
        ValueMulti = 8,
        Color = Color3.fromRGB(170, 255, 0),

        _AddFX = function(p1028: any, p1029: userdata, p1030: userdata) -- Line: 6347, Name: _AddFX
            p1028:_RemoveFX(p1029, p1030);
            local Children = game.ServerStorage.Mutation_FX.Bloom:GetChildren();

            if p1030 then
                for _, v in Children do
                    if not p1030:FindFirstChild(v.Name) then
                        local v1031 = v:Clone();
                        v1031.Parent = p1030;
                        v1031.Enabled = true;
                        v1031:AddTag("Cleanup_Bloom");
                        v1031:AddTag("Effect");
                    end;
                end;
            end;

            local v1032 = {};

            for _, descendant in p1029:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1030 then
                    table.insert(v1032, descendant);
                end;
            end;

            (function(p1033) -- Line: 6374, Name: Shuffle
                for i = #p1033, 2, -1 do
                    local math_random_ret = math.random(1, i);
                    local v1034 = p1033[i];
                    p1033[i] = p1033[math_random_ret];
                    p1033[math_random_ret] = v1034;
                    local _ = i;
                end;

                return p1033;
            end)(v1032);

            for i = 1, math.floor(#v1032 * 0.25 + 0.5) do
                local v1035 = v1032[i];
                local v1036 = Children[math.random(1, #Children)]:Clone();
                v1036.Parent = v1035;
                v1036.Enabled = true;
                v1036:AddTag("Cleanup_Bloom");
                v1036:AddTag("Effect");
                local _ = i;
            end;
        end,

        _RemoveFX = function(p1037: any, p1038: userdata, p1039: userdata) -- Line: 6395, Name: _RemoveFX
            local function v1041(p1040) -- Line: 6396
                for _, descendant in p1040:GetDescendants() do
                    if descendant:HasTag("Cleanup_Bloom") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1039 then
                v1041(p1039);
            end;

            if p1038 then
                v1041(p1038);
            end;
        end
    },
    Rot = {
        Id = "RO",
        Name = "Rot",
        ValueMulti = 8,
        Color = Color3.fromRGB(85, 0, 127),

        _AddFX = function(p1042: any, p1043: userdata, p1044: userdata) -- Line: 6415, Name: _AddFX
            p1042:_RemoveFX(p1043, p1044);
            local Children = game.ServerStorage.Mutation_FX.Rot:GetChildren();

            if p1044 then
                for _, v in Children do
                    if not p1044:FindFirstChild(v.Name) then
                        local v1045 = v:Clone();
                        v1045.Parent = p1044;
                        v1045.Enabled = true;
                        v1045:AddTag("Cleanup_Rot");
                        v1045:AddTag("Effect");
                    end;
                end;
            end;

            local v1046 = {};

            for _, descendant in p1043:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1044 then
                    table.insert(v1046, descendant);
                end;
            end;

            (function(p1047) -- Line: 6442, Name: Shuffle
                for i = #p1047, 2, -1 do
                    local math_random_ret = math.random(1, i);
                    local v1048 = p1047[i];
                    p1047[i] = p1047[math_random_ret];
                    p1047[math_random_ret] = v1048;
                    local _ = i;
                end;

                return p1047;
            end)(v1046);

            for i = 1, math.floor(#v1046 * 0.25 + 0.5) do
                local v1049 = v1046[i];
                local v1050 = Children[math.random(1, #Children)]:Clone();
                v1050.Parent = v1049;
                v1050.Enabled = true;
                v1050:AddTag("Cleanup_Rot");
                v1050:AddTag("Effect");
                local _ = i;
            end;
        end,

        _RemoveFX = function(p1051: any, p1052: userdata, p1053: userdata) -- Line: 6463, Name: _RemoveFX
            local function v1055(p1054) -- Line: 6464
                for _, descendant in p1054:GetDescendants() do
                    if descendant:HasTag("Cleanup_Rot") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1053 then
                v1055(p1053);
            end;

            if p1052 then
                v1055(p1052);
            end;
        end
    },
    Gloom = {
        Id = "GL",
        Name = "Gloom",
        ValueMulti = 30,
        Color = Color3.fromRGB(85, 85, 127),

        _AddFX = function(p1056: any, p1057: userdata, p1058: userdata) -- Line: 6483, Name: _AddFX
            p1056:_RemoveFX(p1057, p1058);
            local Children = game.ServerStorage.Mutation_FX.Gloom:GetChildren();

            if p1058 then
                for _, v in Children do
                    if not p1058:FindFirstChild(v.Name) then
                        local v1059 = v:Clone();
                        v1059.Parent = p1058;
                        v1059.Enabled = true;
                        v1059:AddTag("Cleanup_Gloom");
                        v1059:AddTag("Effect");
                    end;
                end;
            end;

            local v1060 = {};

            for _, descendant in p1057:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1058 then
                    table.insert(v1060, descendant);
                end;
            end;

            (function(p1061) -- Line: 6510, Name: Shuffle
                for i = #p1061, 2, -1 do
                    local math_random_ret = math.random(1, i);
                    local v1062 = p1061[i];
                    p1061[i] = p1061[math_random_ret];
                    p1061[math_random_ret] = v1062;
                    local _ = i;
                end;

                return p1061;
            end)(v1060);

            for i = 1, math.floor(#v1060 * 0.25 + 0.5) do
                local v1063 = v1060[i];
                local v1064 = Children[math.random(1, #Children)]:Clone();
                v1064.Parent = v1063;
                v1064.Enabled = true;
                v1064:AddTag("Cleanup_Gloom");
                v1064:AddTag("Effect");
                local _ = i;
            end;
        end,

        _RemoveFX = function(p1065: any, p1066: userdata, p1067: userdata) -- Line: 6531, Name: _RemoveFX
            local function v1069(p1068) -- Line: 6532
                for _, descendant in p1068:GetDescendants() do
                    if descendant:HasTag("Cleanup_Gloom") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1067 then
                v1069(p1067);
            end;

            if p1066 then
                v1069(p1066);
            end;
        end
    },
    Blight = {
        Id = "BT",
        Name = "Blight",
        ValueMulti = 8,
        Color = Color3.fromRGB(170, 0, 255),

        _AddFX = function(p1070: any, p1071: userdata, p1072: userdata) -- Line: 6551, Name: _AddFX
            p1070:_RemoveFX(p1071, p1072);
            local Children = game.ServerStorage.Mutation_FX.Blight:GetChildren();

            if p1072 then
                for _, v in Children do
                    if not p1072:FindFirstChild(v.Name) then
                        local v1073 = v:Clone();
                        v1073.Parent = p1072;
                        v1073.Enabled = true;
                        v1073:AddTag("Cleanup_Blight");
                        v1073:AddTag("Effect");
                    end;
                end;
            end;

            local v1074 = {};

            for _, descendant in p1071:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1072 then
                    table.insert(v1074, descendant);
                end;
            end;

            (function(p1075) -- Line: 6575, Name: Shuffle
                for i = #p1075, 2, -1 do
                    local math_random_ret = math.random(1, i);
                    local v1076 = p1075[i];
                    p1075[i] = p1075[math_random_ret];
                    p1075[math_random_ret] = v1076;
                    local _ = i;
                end;

                return p1075;
            end)(v1074);

            for i = 1, math.floor(#v1074 * 0.25 + 0.5) do
                local v1077 = v1074[i];
                local v1078 = Children[math.random(1, #Children)]:Clone();
                v1078.Parent = v1077;
                v1078.Enabled = true;
                v1078:AddTag("Cleanup_Blight");
                v1078:AddTag("Effect");
                local _ = i;
            end;
        end,

        _RemoveFX = function(p1079: any, p1080: userdata, p1081: userdata) -- Line: 6595, Name: _RemoveFX
            local function v1083(p1082) -- Line: 6596
                for _, descendant in p1082:GetDescendants() do
                    if descendant:HasTag("Cleanup_Blight") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1081 then
                v1083(p1081);
            end;

            if p1080 then
                v1083(p1080);
            end;
        end
    },
    Pestilent = {
        Id = "PE",
        Name = "Pestilent",
        ValueMulti = 8,
        Color = Color3.fromRGB(85, 85, 0),

        _AddFX = function(p1084: any, p1085: userdata, p1086: userdata) -- Line: 6615, Name: _AddFX
            p1084:_RemoveFX(p1085, p1086);
            local Children = game.ServerStorage.Mutation_FX.Pestilent:GetChildren();

            if p1086 then
                for _, v in Children do
                    if not p1086:FindFirstChild(v.Name) then
                        local v1087 = v:Clone();
                        v1087.Parent = p1086;
                        v1087.Enabled = true;
                        v1087:AddTag("Cleanup_Pestilent");
                        v1087:AddTag("Effect");
                    end;
                end;
            end;

            local v1088 = {};

            for _, descendant in p1085:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1086 then
                    table.insert(v1088, descendant);
                end;
            end;

            (function(p1089) -- Line: 6639, Name: Shuffle
                for i = #p1089, 2, -1 do
                    local math_random_ret = math.random(1, i);
                    local v1090 = p1089[i];
                    p1089[i] = p1089[math_random_ret];
                    p1089[math_random_ret] = v1090;
                    local _ = i;
                end;

                return p1089;
            end)(v1088);

            for i = 1, math.floor(#v1088 * 0.25 + 0.5) do
                local v1091 = v1088[i];
                local v1092 = Children[math.random(1, #Children)]:Clone();
                v1092.Parent = v1091;
                v1092.Enabled = true;
                v1092:AddTag("Cleanup_Pestilent");
                v1092:AddTag("Effect");
                local _ = i;
            end;
        end,

        _RemoveFX = function(p1093: any, p1094: userdata, p1095: userdata) -- Line: 6659, Name: _RemoveFX
            local function v1097(p1096) -- Line: 6660
                for _, descendant in p1096:GetDescendants() do
                    if descendant:HasTag("Cleanup_Pestilent") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1095 then
                v1097(p1095);
            end;

            if p1094 then
                v1097(p1094);
            end;
        end
    },
    Umbral = {
        Id = "UM",
        Name = "Umbral",
        ValueMulti = 30,
        Color = Color3.fromRGB(30, 20, 55),

        _AddFX = function(p1098: any, p1099: userdata, p1100: userdata) -- Line: 6679, Name: _AddFX
            p1098:_RemoveFX(p1099, p1100);
            local Children = game.ServerStorage.Mutation_FX.Umbral:GetChildren();

            if p1100 then
                for _, v in Children do
                    if not p1100:FindFirstChild(v.Name) then
                        local v1101 = v:Clone();
                        v1101.Parent = p1100;
                        v1101.Enabled = true;
                        v1101:AddTag("Cleanup_Umbral");
                        v1101:AddTag("Effect");
                    end;
                end;
            end;

            local v1102 = {};

            for _, descendant in p1099:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1100 then
                    table.insert(v1102, descendant);
                end;
            end;

            (function(p1103) -- Line: 6703, Name: Shuffle
                for i = #p1103, 2, -1 do
                    local math_random_ret = math.random(1, i);
                    local v1104 = p1103[i];
                    p1103[i] = p1103[math_random_ret];
                    p1103[math_random_ret] = v1104;
                    local _ = i;
                end;

                return p1103;
            end)(v1102);

            for i = 1, math.floor(#v1102 * 0.25 + 0.5) do
                local v1105 = v1102[i];
                local v1106 = Children[math.random(1, #Children)]:Clone();
                v1106.Parent = v1105;
                v1106.Enabled = true;
                v1106:AddTag("Cleanup_Umbral");
                v1106:AddTag("Effect");
                local _ = i;
            end;
        end,

        _RemoveFX = function(p1107: any, p1108: userdata, p1109: userdata) -- Line: 6723, Name: _RemoveFX
            local function v1111(p1110) -- Line: 6724
                for _, descendant in p1110:GetDescendants() do
                    if descendant:HasTag("Cleanup_Umbral") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1109 then
                v1111(p1109);
            end;

            if p1108 then
                v1111(p1108);
            end;
        end
    },
    Shadowbound = {
        Id = "SH",
        Name = "Shadowbound",
        ValueMulti = 70,
        Color = Color3.fromRGB(25, 25, 45),

        _AddFX = function(p1112: any, p1113: userdata, p1114: userdata) -- Line: 6743, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1112:_RemoveFX(p1113, p1114);
            local Children = game.ServerStorage.Mutation_FX.Shadowbound:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1114 then
                for _, v in Children do
                    local v1115 = v:Clone();
                    v1115.Parent = p1114;
                    v1115.Enabled = true;
                    v1115:AddTag("Cleanup_Shadowbound");
                    v1115:AddTag("Effect");
                end;
            end;

            for _, descendant in p1113:GetDescendants() do
                if descendant:IsA("BasePart") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = Color3.fromRGB(25, 25, 45);
                    descendant.Material = Enum.Material.ForceField;
                    descendant.Transparency = 0.5;
                    descendant:AddTag("ShadowboundVisual");
                end;
            end;

            local v1116 = {};

            for _, descendant in p1113:GetDescendants() do
                if descendant:IsA("BasePart") and (descendant ~= p1114 and not descendant:HasTag("Effect")) then
                    table.insert(v1116, descendant);
                end;
            end;

            for i, v in ipairs(v1116) do
                if i % 2 == 0 then
                    local v1117 = Children[math.random(1, #Children)]:Clone();
                    v1117.Parent = v;
                    v1117.Enabled = true;
                    v1117:AddTag("Cleanup_Shadowbound");
                    v1117:AddTag("Effect");

                    if math.random() < 0.25 then
                        local v1118 = Children[math.random(1, #Children)]:Clone();
                        v1118.Parent = v;
                        v1118.Enabled = true;
                        v1118:AddTag("Cleanup_Shadowbound");
                        v1118:AddTag("Effect");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1119: any, p1120: userdata, p1121: userdata) -- Line: 6798, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1123(p1122) -- Line: 6799
                for _, descendant in p1122:GetDescendants() do
                    if descendant:HasTag("Cleanup_Shadowbound") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1121 then
                v1123(p1121);
            end;

            if p1120 then
                v1123(p1120);
            end;

            for _, descendant in p1120:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("ShadowboundVisual") then
                    descendant:RemoveTag("ShadowboundVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v1124 = u6[descendant];

                    if v1124 then
                        descendant.Material = v1124;
                        u6[descendant] = nil;
                    end;

                    descendant.Transparency = 0;
                end;
            end;
        end
    },
    Necrotic = {
        Id = "NC",
        Name = "Necrotic",
        ValueMulti = 8,
        Color = Color3.fromRGB(85, 85, 255),

        _AddFX = function(p1125: any, p1126: userdata, p1127: userdata) -- Line: 6835, Name: _AddFX
            p1125:_RemoveFX(p1126, p1127);
            local Children = game.ServerStorage.Mutation_FX.Necrotic:GetChildren();

            if p1127 then
                for _, v in Children do
                    if not p1127:FindFirstChild(v.Name) then
                        local v1128 = v:Clone();
                        v1128.Parent = p1127;
                        v1128.Enabled = true;
                        v1128:AddTag("Cleanup_Necrotic");
                        v1128:AddTag("Effect");
                    end;
                end;
            end;

            local v1129 = {};

            for _, descendant in p1126:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1127 then
                    table.insert(v1129, descendant);
                end;
            end;

            (function(p1130) -- Line: 6862, Name: Shuffle
                for i = #p1130, 2, -1 do
                    local math_random_ret = math.random(1, i);
                    local v1131 = p1130[i];
                    p1130[i] = p1130[math_random_ret];
                    p1130[math_random_ret] = v1131;
                    local _ = i;
                end;

                return p1130;
            end)(v1129);

            for i = 1, math.floor(#v1129 * 0.25 + 0.5) do
                local v1132 = v1129[i];
                local v1133 = Children[math.random(1, #Children)]:Clone();
                v1133.Parent = v1132;
                v1133.Enabled = true;
                v1133:AddTag("Cleanup_Necrotic");
                v1133:AddTag("Effect");
                local _ = i;
            end;
        end,

        _RemoveFX = function(p1134: any, p1135: userdata, p1136: userdata) -- Line: 6883, Name: _RemoveFX
            local function v1138(p1137) -- Line: 6884
                for _, descendant in p1137:GetDescendants() do
                    if descendant:HasTag("Cleanup_Necrotic") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1136 then
                v1138(p1136);
            end;

            if p1135 then
                v1138(p1135);
            end;
        end
    },
    Cyclonic = {
        Id = "CY",
        Name = "Cyclonic",
        ValueMulti = 50,
        Color = Color3.fromRGB(130, 230, 255),

        _AddFX = function(p1139: any, p1140: userdata, p1141: userdata) -- Line: 6903, Name: _AddFX
            p1139:_RemoveFX(p1140, p1141);
            local Children = game.ServerStorage.Mutation_FX.Cyclonic:GetChildren();

            if p1141 then
                for _, v in Children do
                    if not p1141:FindFirstChild(v.Name) then
                        local v1142 = v:Clone();
                        v1142.Parent = p1141;
                        v1142.Enabled = true;
                        v1142:AddTag("Cleanup_Cyclonic");
                    end;
                end;
            end;

            local v1143 = 0;

            for _, descendant in p1140:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1141 then
                    v1143 = v1143 + 1;

                    if v1143 % 2 == 0 then
                        local v1144 = Children[math.random(1, #Children)]:Clone();
                        v1144.Parent = descendant;
                        v1144.Enabled = true;
                        v1144:AddTag("Cleanup_Cyclonic");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1145: any, p1146: userdata, p1147: userdata) -- Line: 6933, Name: _RemoveFX
            local function v1149(p1148) -- Line: 6934
                for _, descendant in p1148:GetDescendants() do
                    if descendant:HasTag("Cleanup_Cyclonic") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1147 then
                v1149(p1147);
            end;

            if p1146 then
                v1149(p1146);
            end;
        end
    },
    Maelstrom = {
        Id = "MS",
        Name = "Maelstrom",
        ValueMulti = 100,
        Color = Color3.fromRGB(0, 60, 255),

        _AddFX = function(p1150: any, p1151: userdata, p1152: userdata) -- Line: 6952, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1150:_RemoveFX(p1151, p1152);
            local Children = game.ServerStorage.Mutation_FX.Maelstrom:GetChildren();
            local v1153 = {
                Stars1 = true
            };

            if p1152 then
                for _, v in Children do
                    if not p1152:FindFirstChild(v.Name) then
                        local v1154 = v:Clone();
                        v1154.Parent = p1152;
                        v1154.Enabled = true;
                        v1154:AddTag("Cleanup_Maelstrom");
                    end;
                end;
            end;

            local v1155 = {};
            local v1156 = 0;

            for _, descendant in p1151:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1152 then
                    table.insert(v1155, descendant);
                    local v1157 = descendant;

                    for _, v in Children do
                        if v1153[v.Name] and v1156 < 8 then
                            v1156 = v1156 + 1;
                            local v1158 = v:Clone();
                            v1158.Parent = v1157;
                            v1158.Enabled = true;
                            v1158:AddTag("Cleanup_Maelstrom");
                        end;
                    end;
                end;
            end;

            for _, v in v1155 do
                if Random.new():NextNumber() < 0.5 then
                    u3[v] = u3[v] or v.Color;
                    u6[v] = u6[v] or v.Material;
                    v.Color = Color3.fromRGB(0, 186, 186);
                    v.Material = Enum.Material.Neon;
                    v:AddTag("MaelstromVisual");
                end;
            end;

            local v1159 = {};

            for _, v in Children do
                if not v1153[v.Name] then
                    table.insert(v1159, v);
                end;
            end;

            local v1160 = 0;

            for i, v in v1155 do
                if i % 2 == 0 and (#v1159 > 0 and v1160 < 8) then
                    v1160 = v1160 + 1;
                    local v1161 = v1159[math.random(1, #v1159)]:Clone();
                    v1161.Parent = v;
                    v1161.Enabled = true;
                    v1161:AddTag("Cleanup_Maelstrom");
                end;
            end;
        end,

        _RemoveFX = function(p1162: any, p1163: userdata, p1164: userdata) -- Line: 7018, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1166(p1165) -- Line: 7019
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p1165:GetDescendants() do
                    if descendant:HasTag("Cleanup_Maelstrom") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("MaelstromVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;

                        descendant:RemoveTag("MaelstromVisual");
                    end;
                end;
            end;

            if p1164 then
                v1166(p1164);
            end;

            if p1163 then
                v1166(p1163);
            end;
        end
    },
    Stormcharged = {
        Id = "SC",
        Name = "Stormcharged",
        ValueMulti = 180,
        Color = Color3.fromRGB(148, 226, 255),

        _AddFX = function(p1167: any, p1168: userdata, p1169: userdata) -- Line: 7050, Name: _AddFX
            p1167:_RemoveFX(p1168, p1169);
            local v1170 = {};

            for _, v in { game.ServerStorage.Mutation_FX.Shocked:GetChildren(), game.ServerStorage.Mutation_FX.Static:GetChildren(), game.ServerStorage.Mutation_FX.Tempestuous:GetChildren() } do
                for _, v2 in v do
                    table.insert(v1170, v2);
                end;
            end;

            if p1169 then
                for _, v in v1170 do
                    if not p1169:FindFirstChild(v.Name) then
                        local v1171 = v:Clone();
                        v1171.Color = ColorSequence.new(Color3.fromRGB(148, 226, 255));
                        v1171.Parent = p1169;
                        v1171.Enabled = true;
                        v1171:AddTag("Cleanup_Stormcharged");
                    end;
                end;
            end;

            local v1172 = {};

            for _, descendant in p1168:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1169 then
                    table.insert(v1172, descendant);
                end;
            end;

            local Random_new_ret = Random.new();
            local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 100);
            local Color3_fromRGB_ret2 = Color3.fromRGB(0, 60, 255);

            for _, v in v1172 do
                if #v1170 > 0 then
                    local v1173 = v1170[Random_new_ret:NextInteger(1, #v1170)]:Clone();
                    v1173.Color = ColorSequence.new(Color3.fromRGB(148, 226, 255));
                    v1173.Parent = v;
                    v1173.Enabled = true;
                    v1173:AddTag("Cleanup_Stormcharged");
                end;

                v.Color = Random_new_ret:NextNumber() < 0.5 and Color3_fromRGB_ret and Color3_fromRGB_ret or Color3_fromRGB_ret2;
                v.Material = Enum.Material.Neon;
                v:AddTag("StormchargedVisual");
            end;
        end,

        _RemoveFX = function(p1174: any, p1175: userdata, p1176: userdata) -- Line: 7109, Name: _RemoveFX
            local function v1178(p1177) -- Line: 7110
                for _, descendant in p1177:GetDescendants() do
                    if descendant:HasTag("Cleanup_Stormcharged") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("StormchargedVisual") then
                        descendant:RemoveTag("StormchargedVisual");
                        descendant.Material = Enum.Material.Plastic;
                    end;
                end;
            end;

            if p1176 then
                v1178(p1176);
            end;

            if p1175 then
                v1178(p1175);
            end;
        end
    },
    Cosmic = {
        Id = "CS",
        Name = "Cosmic",
        ValueMulti = 240,
        Color = Color3.fromRGB(171, 171, 255),

        _AddFX = function(p1179: any, p1180: userdata, p1181: userdata) -- Line: 7133, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1179:_RemoveFX(p1180, p1181);
            local Children = game.ServerStorage.Mutation_FX.Cosmic:GetChildren();
            local v1182 = #Children;

            if p1181 then
                for _, v in Children do
                    if not p1181:FindFirstChild(v.Name) then
                        local v1183 = v:Clone();
                        v1183.Parent = p1181;
                        v1183.Enabled = true;
                        v1183:AddTag("Cleanup_Cosmic");
                    end;
                end;
            end;

            local v1184 = 0;

            for _, descendant in p1180:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1181 then
                    v1184 = v1184 + 1;

                    if v1182 > 0 then
                        local v1185 = Children[math.random(1, v1182)]:Clone();
                        v1185.Parent = descendant;
                        v1185.Enabled = true;
                        v1185:AddTag("Cleanup_Cosmic");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if math.random() < 0.5 then
                            descendant.Color = Color3.fromRGB(255, 255, 100);
                        else
                            descendant.Color = Color3.fromRGB(171, 171, 255);
                        end;

                        descendant.Material = Enum.Material.Neon;
                        descendant:AddTag("CosmicVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1186: any, p1187: userdata, p1188: userdata) -- Line: 7182, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1190(p1189) -- Line: 7183
                for _, descendant in p1189:GetDescendants() do
                    if descendant:HasTag("Cleanup_Cosmic") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1188 then
                v1190(p1188);
            end;

            if p1187 then
                v1190(p1187);
            end;

            for _, descendant in p1187:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CosmicVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;
                    descendant:RemoveTag("CosmicVisual");
                end;
            end;
        end
    },
    Webbed = {
        Id = "WB",
        Name = "Webbed",
        ValueMulti = 8,
        Color = Color3.fromRGB(255, 255, 255),

        _AddFX = function(p1191: any, p1192: userdata, p1193: userdata) -- Line: 7216, Name: _AddFX
            p1191:_RemoveFX(p1192, p1193);
            local Children = game.ServerStorage.Mutation_FX.Webbed:GetChildren();

            if p1193 then
                for _, v in Children do
                    if not p1193:FindFirstChild(v.Name) then
                        local v1194 = v:Clone();
                        v1194.Parent = p1193;
                        v1194.Enabled = true;
                        v1194:AddTag("Cleanup_Webbed");
                        v1194:AddTag("Effect");
                    end;
                end;
            end;

            local v1195 = {};

            for _, descendant in p1192:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1193 then
                    table.insert(v1195, descendant);
                end;
            end;

            (function(p1196) -- Line: 7242, Name: Shuffle
                for i = #p1196, 2, -1 do
                    local math_random_ret = math.random(1, i);
                    local v1197 = p1196[i];
                    p1196[i] = p1196[math_random_ret];
                    p1196[math_random_ret] = v1197;
                    local _ = i;
                end;

                return p1196;
            end)(v1195);

            for i = 1, math.floor(#v1195 * 0.25 + 0.5) do
                local v1198 = v1195[i];
                local v1199 = Children[math.random(1, #Children)]:Clone();
                v1199.Parent = v1198;
                v1199.Enabled = true;
                v1199:AddTag("Cleanup_Webbed");
                v1199:AddTag("Effect");
                local _ = i;
            end;
        end,

        _RemoveFX = function(p1200: any, p1201: userdata, p1202: userdata) -- Line: 7263, Name: _RemoveFX
            local function v1204(p1203) -- Line: 7264
                for _, descendant in p1203:GetDescendants() do
                    if descendant:HasTag("Cleanup_Webbed") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1202 then
                v1204(p1202);
            end;

            if p1201 then
                v1204(p1201);
            end;
        end
    },
    Astral = {
        Id = "AS",
        Name = "Astral",
        ValueMulti = 365,
        Color = Color3.fromRGB(255, 255, 100),

        _AddFX = function(p1205: any, p1206: userdata, p1207: userdata) -- Line: 7283, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1205:_RemoveFX(p1206, p1207);
            local Children = game.ServerStorage.Mutation_FX.Astral:GetChildren();
            local v1208 = #Children;

            if p1207 then
                for _, v in Children do
                    if not p1207:FindFirstChild(v.Name) then
                        local v1209 = v:Clone();
                        v1209.Parent = p1207;
                        v1209.Enabled = true;
                        v1209:AddTag("Cleanup_Astral");
                    end;
                end;
            end;

            local v1210 = 0;

            for _, descendant in p1206:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1207 then
                    v1210 = v1210 + 1;

                    if v1208 > 0 then
                        local v1211 = Children[math.random(1, v1208)]:Clone();
                        v1211.Parent = descendant;
                        v1211.Enabled = true;
                        v1211:AddTag("Cleanup_Astral");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if math.random() < 0.5 then
                            descendant.Color = Color3.fromRGB(255, 255, 100);
                        else
                            descendant.Color = Color3.fromRGB(255, 170, 255);
                        end;

                        descendant.Material = Enum.Material.Neon;
                        descendant:AddTag("AstralVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1212: any, p1213: userdata, p1214: userdata) -- Line: 7332, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1216(p1215) -- Line: 7333
                for _, descendant in p1215:GetDescendants() do
                    if descendant:HasTag("Cleanup_Astral") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1214 then
                v1216(p1214);
            end;

            if p1213 then
                v1216(p1213);
            end;

            for _, descendant in p1213:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("AstralVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;
                    descendant:RemoveTag("AstralVisual");
                end;
            end;
        end
    },
    Abyssal = {
        Id = "AB",
        Name = "Abyssal",
        ValueMulti = 240,
        Color = Color3.fromRGB(85, 0, 127),

        _AddFX = function(p1217: any, p1218: userdata, p1219: userdata) -- Line: 7366, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1217:_RemoveFX(p1218, p1219);
            local Children = game.ServerStorage.Mutation_FX.Abyssal:GetChildren();
            local _ = #Children;
            local v1220 = {};

            for _, v in Children do
                if v.Name ~= "Blackhole" then
                    table.insert(v1220, v);
                end;
            end;

            if p1219 then
                for _, v in Children do
                    if not p1219:FindFirstChild(v.Name) then
                        local v1221 = v:Clone();
                        v1221.Parent = p1219;
                        v1221.Enabled = true;
                        v1221:AddTag("Cleanup_Abyssal");
                    end;
                end;
            end;

            local v1222 = 0;

            for _, descendant in p1218:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1219 then
                    v1222 = v1222 + 1;

                    if #v1220 > 0 then
                        local v1223 = v1220[math.random(1, #v1220)]:Clone();
                        v1223.Parent = descendant;
                        v1223.Enabled = true;
                        v1223:AddTag("Cleanup_Abyssal");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if math.random() < 0.5 then
                            descendant.Color = Color3.fromRGB(170, 0, 255);
                        else
                            descendant.Color = Color3.fromRGB(85, 0, 127);
                        end;

                        descendant.Material = Enum.Material.Neon;
                        descendant:AddTag("AbyssalVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1224: any, p1225: userdata, p1226: userdata) -- Line: 7422, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1228(p1227) -- Line: 7423
                for _, descendant in p1227:GetDescendants() do
                    if descendant:HasTag("Cleanup_Abyssal") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1226 then
                v1228(p1226);
            end;

            if p1225 then
                v1228(p1225);
            end;

            for _, descendant in p1225:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("AbyssalVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;
                    descendant:RemoveTag("AbyssalVisual");
                end;
            end;
        end
    },
    Graceful = {
        Id = "GR",
        Name = "Graceful",
        ValueMulti = 77,
        Color = Color3.fromRGB(240, 240, 255),

        _AddFX = function(p1229: any, p1230: userdata, p1231: userdata) -- Line: 7456, Name: _AddFX
            p1229:_RemoveFX(p1230, p1231);
            local Children = game.ServerStorage.Mutation_FX.Graceful:GetChildren();
            local v1232 = 0;
            local v1233 = 0;

            for _, descendant in p1230:GetDescendants() do
                if descendant:IsA("BasePart") then
                    v1232 = v1232 + 1;

                    if v1232 % 2 == 0 and v1233 < 8 then
                        v1233 = v1233 + 1;
                        local v1234 = descendant;

                        for _, v in Children do
                            local v1235 = v:Clone();
                            v1235.Parent = v1234;
                            v1235.Enabled = true;
                            v1235:AddTag("Cleanup_Graceful");
                        end;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1236: any, p1237: userdata, p1238: userdata) -- Line: 7481, Name: _RemoveFX
            local function v1240(p1239) -- Line: 7482
                for _, descendant in p1239:GetDescendants() do
                    if descendant:HasTag("Cleanup_Graceful") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1238 then
                v1240(p1238);
            end;

            if p1237 then
                v1240(p1237);
            end;
        end
    },
    Jackpot = {
        Id = "JA",
        Name = "Jackpot",
        ValueMulti = 15,
        Color = Color3.fromRGB(255, 215, 0),

        _AddFX = function(p1241: any, p1242: userdata, p1243: userdata) -- Line: 7501, Name: _AddFX
            p1241:_RemoveFX(p1242, p1243);

            if p1243 then
                for _, child in game.ServerStorage.Mutation_FX.Jackpot:GetChildren() do
                    local v1244 = child:Clone();
                    v1244.Parent = p1243;
                    v1244:AddTag("Cleanup_Jackpot");

                    if v1244:IsA("ParticleEmitter") then
                        v1244.Enabled = true;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1245: any, p1246: userdata, p1247: userdata) -- Line: 7514, Name: _RemoveFX
            local function v1249(p1248) -- Line: 7515
                for _, descendant in p1248:GetDescendants() do
                    if descendant:HasTag("Cleanup_Jackpot") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1247 then
                v1249(p1247);
            end;
        end
    },
    Plagued = {
        Id = "PL",
        Name = "Plagued",
        ValueMulti = 102,
        Color = Color3.fromRGB(85, 85, 0),

        _AddFX = function(p1250: any, p1251: userdata, p1252: userdata) -- Line: 7532, Name: _AddFX
            p1250:_RemoveFX(p1251, p1252);

            if p1252 then
                for _, child in game.ServerStorage.Mutation_FX.Plagued:GetChildren() do
                    local v1253 = child:Clone();
                    v1253.Parent = p1252;
                    v1253.Enabled = true;
                    v1253:AddTag("Cleanup_Plagued");
                    v1253:AddTag("Effect");
                end;
            end;

            for _, descendant in p1251:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant:AddTag("PlaguedVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1254: any, p1255: userdata, p1256: userdata) -- Line: 7552, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p1256 then
                for _, child in p1256:GetChildren() do
                    if child:HasTag("Cleanup_Plagued") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1255:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("PlaguedVisual") then
                    descendant:RemoveTag("PlaguedVisual");
                    local v1257 = u6[descendant];

                    if v1257 then
                        descendant.Material = v1257;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Biohazard = {
        Id = "BH",
        Name = "Biohazard",
        ValueMulti = 157,
        Color = Color3.fromRGB(98, 255, 0),

        _AddFX = function(p1258: any, p1259: userdata, p1260: userdata) -- Line: 7581, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1258:_RemoveFX(p1259, p1260);
            local Children = game.ServerStorage.Mutation_FX.Plagued:GetChildren();
            local Children2 = game.ServerStorage.Mutation_FX.Radioactive:GetChildren();

            if p1260 then
                for _, v in Children do
                    local v1261 = v:Clone();
                    v1261.Parent = p1260;
                    v1261.Enabled = true;
                    v1261:AddTag("Cleanup_Biohazard");
                    v1261:AddTag("Effect");
                end;

                for _, v in Children2 do
                    local v1262 = v:Clone();
                    v1262.Parent = p1260;
                    v1262.Enabled = true;
                    v1262:AddTag("Cleanup_Biohazard");
                    v1262:AddTag("Effect");
                end;
            end;

            for _, descendant in p1259:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(65, 175, 0);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("RadioactiveVisual");
                    descendant:AddTag("BiohazardVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1263: any, p1264: userdata, p1265: userdata) -- Line: 7620, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1267(p1266) -- Line: 7621
                for _, descendant in p1266:GetDescendants() do
                    if descendant:HasTag("Cleanup_Biohazard") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1265 then
                v1267(p1265);
            end;

            if p1264 then
                v1267(p1264);
            end;

            for _, descendant in p1264:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BiohazardVisual") then
                    descendant:RemoveTag("BiohazardVisual");
                    descendant:RemoveTag("RadioactiveVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v1268 = u6[descendant];

                    if v1268 then
                        descendant.Material = v1268;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Contagion = {
        Id = "CO",
        Name = "Contagion",
        ValueMulti = 205,
        Color = Color3.fromRGB(98, 255, 0),

        _AddFX = function(p1269: any, p1270: userdata, p1271: userdata) -- Line: 7658, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1269:_RemoveFX(p1270, p1271);
            local Children = game.ServerStorage.Mutation_FX.Plagued:GetChildren();
            local Children2 = game.ServerStorage.Mutation_FX.Radioactive:GetChildren();

            if p1271 then
                for _, v in Children do
                    local v1272 = v:Clone();
                    v1272.Parent = p1271;
                    v1272.Enabled = true;
                    v1272:AddTag("Cleanup_Contagion");
                    v1272:AddTag("Effect");
                end;

                for _, v in Children2 do
                    local v1273 = v:Clone();
                    v1273.Parent = p1271;
                    v1273.Enabled = true;
                    v1273:AddTag("Cleanup_Contagion");
                    v1273:AddTag("Effect");
                end;
            end;

            local v1274 = {};

            for _, descendant in p1270:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant ~= p1271 then
                    table.insert(v1274, descendant);
                end;
            end;

            for i = 1, #v1274 do
                local v1275 = v1274[i];

                if i % 2 == 0 then
                    local v1276 = math.random(1, 2) == 1 and Children and Children or Children2;
                    local v1277 = v1276[math.random(1, #v1276)]:Clone();
                    v1277.Parent = v1275;
                    v1277.Enabled = true;
                    v1277:AddTag("Cleanup_Contagion");
                    v1277:AddTag("Effect");

                    if math.random() < 0.25 then
                        local v1278 = v1276 == Children and Children2 and Children2 or Children;
                        local v1279 = v1278[math.random(1, #v1278)]:Clone();
                        v1279.Parent = v1275;
                        v1279.Enabled = true;
                        v1279:AddTag("Cleanup_Contagion");
                        v1279:AddTag("Effect");
                    end;
                end;

                local v1280;

                if v1275:HasTag("Effect") then
                    v1280 = i;
                else
                    u3[v1275] = u3[v1275] or v1275.Color;
                    v1275.Color = Color3.fromRGB(65, 175, 0);
                    u6[v1275] = u6[v1275] or v1275.Material;
                    v1275.Material = Enum.Material.Neon;
                    v1275:AddTag("ContagionVisual");
                    v1280 = i;
                end;
            end;
        end,

        _RemoveFX = function(p1281: any, p1282: userdata, p1283: userdata) -- Line: 7718, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1285(p1284) -- Line: 7719
                for _, descendant in p1284:GetDescendants() do
                    if descendant:HasTag("Cleanup_Contagion") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1283 then
                v1285(p1283);
            end;

            if p1282 then
                v1285(p1282);
            end;

            for _, descendant in p1282:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ContagionVisual") then
                    descendant:RemoveTag("ContagionVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v1286 = u6[descendant];

                    if v1286 then
                        descendant.Material = v1286;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Blitzshock = {
        Id = "BS",
        Name = "Blitzshock",
        ValueMulti = 50,
        Color = Color3.fromRGB(0, 192, 245),

        _AddFX = function(p1287: any, p1288: userdata, p1289: userdata) -- Line: 7754, Name: _AddFX
            -- upvalues: u6 (copy), u3 (copy)
            p1287:_RemoveFX(p1288, p1289);

            if p1289 then
                for _, child in game.ServerStorage.Mutation_FX.Blitzshock:GetChildren() do
                    local v1290 = child:Clone();
                    v1290.Parent = p1289;
                    v1290:AddTag("Cleanup_Blitzshock");

                    if v1290:IsA("ParticleEmitter") then
                        v1290.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1288:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(0, 170, 255), 0.5);
                    descendant:AddTag("BlitzshockVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1291: any, p1292: userdata, p1293: userdata) -- Line: 7782, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1295(p1294) -- Line: 7784
                for _, descendant in p1294:GetDescendants() do
                    if descendant:HasTag("Cleanup_Blitzshock") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1293 then
                v1295(p1293);
            end;

            if p1292 then
                v1295(p1292);
            end;

            for _, descendant in p1292:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BlitzshockVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("BlitzshockVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Junkshock = {
        Id = "JS",
        Name = "Junkshock",
        ValueMulti = 45,
        Color = Color3.fromRGB(147, 247, 0),

        _AddFX = function(p1296: any, p1297: userdata, p1298: userdata) -- Line: 7816, Name: _AddFX
            -- upvalues: u6 (copy), u3 (copy)
            p1296:_RemoveFX(p1297, p1298);

            if p1298 then
                for _, child in game.ServerStorage.Mutation_FX.Junkshock:GetChildren() do
                    local v1299 = child:Clone();
                    v1299.Parent = p1298;
                    v1299:AddTag("Cleanup_Junkshock");

                    if v1299:IsA("ParticleEmitter") then
                        v1299.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1297:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Neon;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(0, 255, 36), 0.5);
                    descendant:AddTag("JunkshockVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1300: any, p1301: userdata, p1302: userdata) -- Line: 7841, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1304(p1303) -- Line: 7842
                for _, descendant in p1303:GetDescendants() do
                    if descendant:HasTag("Cleanup_Junkshock") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1302 then
                v1304(p1302);
            end;

            if p1301 then
                v1304(p1301);
            end;

            for _, descendant in p1301:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("JunkshockVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("JunkshockVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Touchdown = {
        Id = "TD",
        Name = "Touchdown",
        ValueMulti = 105,
        Color = Color3.fromRGB(203, 95, 0),

        _AddFX = function(p1305: any, p1306: userdata, p1307: userdata) -- Line: 7874, Name: _AddFX
            p1305:_RemoveFX(p1306, p1307);

            if p1307 then
                for _, child in game.ServerStorage.Mutation_FX.Touchdown:GetChildren() do
                    local v1308 = child:Clone();
                    v1308.Parent = p1307;
                    v1308.Enabled = true;
                    v1308:AddTag("Cleanup_Touchdown");
                end;
            end;
        end,

        _RemoveFX = function(p1309: any, p1310: userdata, p1311: userdata) -- Line: 7889, Name: _RemoveFX
            local function v1313(p1312) -- Line: 7891
                for _, descendant in p1312:GetDescendants() do
                    if descendant:HasTag("Cleanup_Touchdown") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1311 then
                v1313(p1311);
            end;

            if p1310 then
                v1313(p1310);
            end;
        end
    },
    Subzero = {
        Id = "SZ",
        Name = "Subzero",
        ValueMulti = 40,
        Color = Color3.fromRGB(0, 255, 255),

        _AddFX = function(p1314: any, p1315: userdata, p1316: userdata) -- Line: 7908, Name: _AddFX
            -- upvalues: AddBoundingFX (copy), u6 (copy), u7 (copy), u3 (copy)
            p1314:_RemoveFX(p1315, p1316);
            AddBoundingFX(p1314, p1315, p1316, 0.4);

            if p1316 then
                for _, child in game.ServerStorage.Mutation_FX.Subzero:GetChildren() do
                    local v1317 = child:Clone();
                    v1317.Parent = p1316;
                    v1317:AddTag("Cleanup_Subzero");

                    if v1317:IsA("ParticleEmitter") then
                        v1317.Enabled = true;
                    end;
                end;
            end;

            for _, child in p1315:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Reflectance = 0.35;
                end;
            end;

            for _, descendant in p1315:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Plastic;
                    u7[descendant] = u7[descendant] or descendant.MaterialVariant;
                    descendant.MaterialVariant = "Studs 2x2 Plastic Metal";
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(0, 255, 255), 0.5);
                    descendant:AddTag("SubzeroVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1318: any, p1319: userdata, p1320: userdata) -- Line: 7946, Name: _RemoveFX
            -- upvalues: RemoveBoundingFX (copy), u3 (copy), u7 (copy), u6 (copy)
            RemoveBoundingFX(p1318, p1319, p1320);

            local function v1322(p1321) -- Line: 7951
                for _, descendant in p1321:GetDescendants() do
                    if descendant:HasTag("Cleanup_Subzero") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1320 then
                v1322(p1320);
            end;

            if p1319 then
                v1322(p1319);
            end;

            for _, descendant in p1319:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    descendant.Reflectance = 0;

                    if descendant:HasTag("SubzeroVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant:RemoveTag("SubzeroVisual");
                        descendant.MaterialVariant = u7[descendant] or descendant.MaterialVariant;
                        u7[descendant] = nil;

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;
        end
    },
    Lightcycle = {
        Id = "lc",
        Name = "Lightcycle",
        ValueMulti = 50,
        Color = Color3.fromRGB(255, 255, 255),

        _AddFX = function(p1323: any, p1324: userdata, p1325: userdata) -- Line: 7989, Name: _AddFX
            -- upvalues: u3 (copy)
            p1323:_RemoveFX(p1324, p1325);
            p1324:AddTag("Lightcycle_Mutation");

            for _, descendant in p1324:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    local _ = descendant.Color;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant:AddTag("StoplightVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1326: any, p1327: userdata, p1328: userdata) -- Line: 8006, Name: _RemoveFX
            -- upvalues: u3 (copy)
            p1327:RemoveTag("Lightcycle_Mutation");

            for _, descendant in p1327:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("StoplightVisual") then
                    local v1329 = u3[descendant];

                    if v1329 then
                        descendant.Color = v1329;
                    end;

                    descendant:RemoveTag("StoplightVisual");
                end;
            end;
        end
    },
    Brainrot = {
        Id = "lca",
        Name = "Brainrot",
        ValueMulti = 100,
        Color = Color3.fromRGB(255, 108, 110),

        _AddFX = function(p1330: any, p1331: userdata, p1332: userdata) -- Line: 8029, Name: _AddFX
            p1330:_RemoveFX(p1331, p1332);

            if p1332 then
                for _, child in game.ServerStorage.Mutation_FX.Brainrot:GetChildren() do
                    local v1333 = child:Clone();
                    v1333.Parent = p1332;
                    v1333.Enabled = true;
                    v1333:AddTag("Cleanup_Brainrot");
                end;
            end;
        end,

        _RemoveFX = function(p1334: any, p1335: userdata, p1336: userdata) -- Line: 8044, Name: _RemoveFX
            local function v1338(p1337) -- Line: 8046
                for _, descendant in p1337:GetDescendants() do
                    if descendant:HasTag("Cleanup_Brainrot") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1336 then
                v1338(p1336);
            end;

            if p1335 then
                v1338(p1335);
            end;
        end
    },
    Warped = {
        Id = "wpa",
        Name = "Warped",
        ValueMulti = 75,
        Color = Color3.fromRGB(192, 52, 255),

        _AddFX = function(p1339: any, p1340: userdata, p1341: userdata) -- Line: 8063, Name: _AddFX
            p1339:_RemoveFX(p1340, p1341);

            if p1341 then
                for _, child in game.ServerStorage.Mutation_FX.Warped:GetChildren() do
                    local v1342 = child:Clone();
                    v1342.Parent = p1341;
                    v1342.Enabled = true;
                    v1342:AddTag("Cleanup_Warped");
                end;
            end;
        end,

        _RemoveFX = function(p1343: any, p1344: userdata, p1345: userdata) -- Line: 8074, Name: _RemoveFX
            local function v1347(p1346) -- Line: 8075
                for _, descendant in p1346:GetDescendants() do
                    if descendant:HasTag("Cleanup_Warped") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1345 then
                v1347(p1345);
            end;

            if p1344 then
                v1347(p1344);
            end;
        end
    },
    Azure = {
        Id = "azu",
        Name = "Azure",
        ValueMulti = 75,
        Color = Color3.fromRGB(0, 127, 255),

        _AddFX = function(p1348: any, p1349: userdata, p1350: userdata) -- Line: 8091, Name: _AddFX
            -- upvalues: u6 (copy)
            p1348:_RemoveFX(p1349, p1350);

            if p1350 then
                for _, child in game.ServerStorage.Mutation_FX.Azure:GetChildren() do
                    local v1351 = child:Clone();
                    v1351.Parent = p1350;
                    v1351.Enabled = true;
                    v1351:AddTag("Cleanup_Azure");
                end;
            end;

            for _, descendant in p1349:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.ForceField;
                    descendant.Reflectance = 0.5;
                end;
            end;
        end,

        _RemoveFX = function(p1352: any, p1353: userdata, p1354: userdata) -- Line: 8113, Name: _RemoveFX
            -- upvalues: u6 (copy)
            local function v1356(p1355) -- Line: 8114
                for _, descendant in p1355:GetDescendants() do
                    if descendant:HasTag("Cleanup_Azure") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1354 then
                v1356(p1354);
            end;

            if p1353 then
                v1356(p1353);
            end;

            for _, descendant in p1353:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and u6[descendant] then
                    if not descendant:HasTag("Effect") then
                        descendant.Material = u6[descendant];
                    end;

                    u6[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Terran = {
        Id = "ter",
        Name = "Terran",
        ValueMulti = 75,
        Color = Color3.fromRGB(163, 175, 142),

        _AddFX = function(p1357: any, p1358: userdata, p1359: userdata) -- Line: 8140, Name: _AddFX
            -- upvalues: u6 (copy)
            p1357:_RemoveFX(p1358, p1359);

            if p1359 then
                for _, child in game.ServerStorage.Mutation_FX.Terran:GetChildren() do
                    local v1360 = child:Clone();
                    v1360.Parent = p1359;
                    v1360.Enabled = true;
                    v1360:AddTag("Cleanup_Azure");
                end;
            end;

            for _, descendant in p1358:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.ForceField;
                    descendant.Reflectance = 0.5;
                end;
            end;
        end,

        _RemoveFX = function(p1361: any, p1362: userdata, p1363: userdata) -- Line: 8162, Name: _RemoveFX
            -- upvalues: u6 (copy)
            local function v1365(p1364) -- Line: 8163
                for _, descendant in p1364:GetDescendants() do
                    if descendant:HasTag("Cleanup_Terran") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1363 then
                v1365(p1363);
            end;

            if p1362 then
                v1365(p1362);
            end;

            for _, descendant in p1362:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and u6[descendant] then
                    if not descendant:HasTag("Effect") then
                        descendant.Material = u6[descendant];
                    end;

                    u6[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Aromatic = {
        Id = "ar",
        Name = "Aromatic",
        ValueMulti = 3,
        Color = Color3.fromRGB(162, 145, 57),

        _AddFX = function(p1366: any, p1367: userdata, p1368: userdata) -- Line: 8189, Name: _AddFX
            -- upvalues: u3 (copy)
            p1366:_RemoveFX(p1367, p1368);

            if p1368 then
                for _, child in game.ServerStorage.Mutation_FX.Aromatic:GetChildren() do
                    local v1369 = child:Clone();
                    v1369.Parent = p1368;
                    v1369:AddTag("Cleanup_Aromatic");

                    if v1369:IsA("ParticleEmitter") then
                        v1369.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1367:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(162, 145, 57), 0.3);
                    descendant:AddTag("AromaticVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1370: any, p1371: userdata, p1372: userdata) -- Line: 8217, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1374(p1373) -- Line: 8219
                for _, descendant in p1373:GetDescendants() do
                    if descendant:HasTag("Cleanup_Aromatic") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1372 then
                v1374(p1372);
            end;

            if p1371 then
                v1374(p1371);
            end;

            for _, descendant in p1371:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("AromaticVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("AromaticVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Gnomed = {
        Id = "gn",
        Name = "Gnomed",
        ValueMulti = 15,
        Color = Color3.fromRGB(0, 173, 239),

        _AddFX = function(p1375: any, p1376: userdata, p1377: userdata) -- Line: 8251, Name: _AddFX
            p1375:_RemoveFX(p1376, p1377);

            if p1377 then
                for _, child in game.ServerStorage.Mutation_FX.Gnomed:GetChildren() do
                    local v1378 = child:Clone();
                    v1378.Parent = p1377;
                    v1378.Enabled = true;
                    v1378:AddTag("Cleanup_Gnomed");
                end;
            end;

            for _, child in p1376:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Reflectance = 0.1;
                end;
            end;
        end,

        _RemoveFX = function(p1379: any, p1380: userdata, p1381: userdata) -- Line: 8269, Name: _RemoveFX
            if p1381 then
                for _, child in p1381:GetChildren() do
                    if child:HasTag("Cleanup_Gnomed") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, child in p1380:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Reflectance = 0;
                end;
            end;
        end
    },
    Fall = {
        Id = "fa",
        Name = "Fall",
        ValueMulti = 4,
        Color = Color3.fromRGB(204, 128, 61),

        _AddFX = function(p1382: any, p1383: userdata, p1384: userdata) -- Line: 8289, Name: _AddFX
            -- upvalues: u3 (copy)
            p1382:_RemoveFX(p1383, p1384);

            if p1384 then
                for _, child in game.ServerStorage.Mutation_FX.Fall:GetChildren() do
                    local v1385 = child:Clone();
                    v1385.Parent = p1384;
                    v1385:AddTag("Cleanup_Fall");

                    if v1385:IsA("ParticleEmitter") then
                        v1385.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1383:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(222, 160, 60), 0.5);
                    descendant:AddTag("FallVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1386: any, p1387: userdata, p1388: userdata) -- Line: 8317, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1390(p1389) -- Line: 8319
                for _, descendant in p1389:GetDescendants() do
                    if descendant:HasTag("Cleanup_Fall") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1388 then
                v1390(p1388);
            end;

            if p1387 then
                v1390(p1387);
            end;

            for _, descendant in p1387:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("FallVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("FallVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Blackout = {
        Id = "BO",
        Name = "Blackout",
        ValueMulti = 95,
        Color = Color3.fromRGB(26, 26, 26),

        _AddFX = function(p1391: any, p1392: userdata, p1393: userdata) -- Line: 8351, Name: _AddFX
            -- upvalues: u6 (copy), u7 (copy), u3 (copy)
            p1391:_RemoveFX(p1392, p1393);

            if p1393 then
                for _, child in game.ServerStorage.Mutation_FX.Blackout:GetChildren() do
                    local v1394 = child:Clone();
                    v1394.Parent = p1393;
                    v1394:AddTag("Cleanup_Blackout");

                    if v1394:IsA("ParticleEmitter") then
                        v1394.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1392:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Plastic;
                    u7[descendant] = u7[descendant] or descendant.MaterialVariant;
                    descendant.MaterialVariant = "Studs 2x2 Plastic Metal";
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(0, 0, 0), 0.9);
                    descendant:AddTag("BlackoutVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1395: any, p1396: userdata, p1397: userdata) -- Line: 8383, Name: _RemoveFX
            -- upvalues: u3 (copy), u7 (copy), u6 (copy)
            local function v1399(p1398) -- Line: 8385
                for _, descendant in p1398:GetDescendants() do
                    if descendant:HasTag("Cleanup_Blackout") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1397 then
                v1399(p1397);
            end;

            if p1396 then
                v1399(p1396);
            end;

            for _, descendant in p1396:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BlackoutVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("BlackoutVisual");
                    descendant.MaterialVariant = u7[descendant] or descendant.MaterialVariant;
                    u7[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Wilted = {
        Id = "WI",
        Name = "Wilted",
        ValueMulti = 10,
        Color = Color3.fromRGB(145, 145, 216),

        _AddFX = function(p1400: any, p1401: userdata, p1402: userdata) -- Line: 8421, Name: _AddFX
            -- upvalues: u3 (copy)
            p1400:_RemoveFX(p1401, p1402);
            local Children = game.ServerStorage.Mutation_FX.Wilted:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1402 then
                for _, v in Children do
                    local v1403 = v:Clone();

                    if v1403:IsA("ParticleEmitter") then
                        v1403.Color = ColorSequence.new(p1400.Color);
                    end;

                    v1403.Parent = p1402;
                    v1403.Enabled = true;
                    v1403:AddTag("Cleanup_Wilted");
                    v1403:AddTag("Effect");
                end;
            end;

            local v1404 = {};

            for _, descendant in p1401:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:HasTag("Effect") then
                    table.insert(v1404, descendant);
                end;
            end;

            for i, v in ipairs(v1404) do
                if i % 3 == 0 then
                    local v1405 = Children[math.random(1, #Children)]:Clone();

                    if v1405:IsA("ParticleEmitter") then
                        v1405.Color = ColorSequence.new(p1400.Color);
                    end;

                    v1405.Parent = v;
                    v1405.Enabled = true;
                    v1405:AddTag("Cleanup_Wilted");
                    v1405:AddTag("Effect");
                    u3[v] = u3[v] or v.Color;
                    v.Color = p1400.Color;
                end;
            end;
        end,

        _RemoveFX = function(p1406: any, p1407: userdata, p1408: userdata) -- Line: 8465, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v1410(p1409) -- Line: 8466
                for _, descendant in p1409:GetDescendants() do
                    if descendant:HasTag("Cleanup_Wilted") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1408 then
                v1410(p1408);
            end;

            if p1407 then
                v1410(p1407);
            end;

            for _, descendant in p1407:GetDescendants() do
                if descendant:IsA("BasePart") and u3[descendant] then
                    descendant.Color = u3[descendant];
                    u3[descendant] = nil;
                end;
            end;
        end
    },
    Withered = {
        Id = "WH",
        Name = "Withered",
        ValueMulti = 20,
        Color = Color3.fromRGB(59, 0, 89),

        _AddFX = function(p1411: any, p1412: userdata, p1413: userdata) -- Line: 8489, Name: _AddFX
            -- upvalues: u3 (copy)
            p1411:_RemoveFX(p1412, p1413);
            local Children = game.ServerStorage.Mutation_FX.Wilted:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1413 then
                for _, v in Children do
                    local v1414 = v:Clone();

                    if v1414:IsA("ParticleEmitter") then
                        v1414.Color = ColorSequence.new(p1411.Color);
                    end;

                    v1414.Parent = p1413;
                    v1414.Enabled = true;
                    v1414:AddTag("Cleanup_Withered");
                    v1414:AddTag("Effect");
                end;
            end;

            local v1415 = {};

            for _, descendant in p1412:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:HasTag("Effect") then
                    table.insert(v1415, descendant);
                end;
            end;

            for i, v in ipairs(v1415) do
                if i % 2 == 0 then
                    local v1416 = Children[math.random(1, #Children)]:Clone();

                    if v1416:IsA("ParticleEmitter") then
                        v1416.Color = ColorSequence.new(p1411.Color);
                    end;

                    v1416.Parent = v;
                    v1416.Enabled = true;
                    v1416:AddTag("Cleanup_Withered");
                    v1416:AddTag("Effect");
                    u3[v] = u3[v] or v.Color;
                    v.Color = p1411.Color;
                end;
            end;
        end,

        _RemoveFX = function(p1417: any, p1418: userdata, p1419: userdata) -- Line: 8533, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v1421(p1420) -- Line: 8534
                for _, descendant in p1420:GetDescendants() do
                    if descendant:HasTag("Cleanup_Withered") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1419 then
                v1421(p1419);
            end;

            if p1418 then
                v1421(p1418);
            end;

            for _, descendant in p1418:GetDescendants() do
                if descendant:IsA("BasePart") and u3[descendant] then
                    descendant.Color = u3[descendant];
                    u3[descendant] = nil;
                end;
            end;
        end
    },
    Desolate = {
        Id = "DE",
        Name = "Desolate",
        ValueMulti = 50,
        Color = Color3.fromRGB(85, 0, 0),

        _AddFX = function(p1422: any, p1423: userdata, p1424: userdata) -- Line: 8557, Name: _AddFX
            -- upvalues: u3 (copy)
            p1422:_RemoveFX(p1423, p1424);
            local Children = game.ServerStorage.Mutation_FX.Wilted:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1424 then
                for _, v in Children do
                    local v1425 = v:Clone();

                    if v1425:IsA("ParticleEmitter") then
                        v1425.Color = ColorSequence.new(p1422.Color);
                    end;

                    v1425.Parent = p1424;
                    v1425.Enabled = true;
                    v1425:AddTag("Cleanup_Desolate");
                    v1425:AddTag("Effect");
                end;
            end;

            local v1426 = {};

            for _, descendant in p1423:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:HasTag("Effect") then
                    table.insert(v1426, descendant);
                end;
            end;

            for i, v in ipairs(v1426) do
                if i % 1 == 0 then
                    local v1427 = Children[math.random(1, #Children)]:Clone();

                    if v1427:IsA("ParticleEmitter") then
                        v1427.Color = ColorSequence.new(p1422.Color);
                    end;

                    v1427.Parent = v;
                    v1427.Enabled = true;
                    v1427:AddTag("Cleanup_Desolate");
                    v1427:AddTag("Effect");
                    u3[v] = u3[v] or v.Color;
                    v.Color = p1422.Color;
                end;
            end;
        end,

        _RemoveFX = function(p1428: any, p1429: userdata, p1430: userdata) -- Line: 8601, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v1432(p1431) -- Line: 8602
                for _, descendant in p1431:GetDescendants() do
                    if descendant:HasTag("Cleanup_Desolate") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1430 then
                v1432(p1430);
            end;

            if p1429 then
                v1432(p1429);
            end;

            for _, descendant in p1429:GetDescendants() do
                if descendant:IsA("BasePart") and u3[descendant] then
                    descendant.Color = u3[descendant];
                    u3[descendant] = nil;
                end;
            end;
        end
    },
    Batty = {
        Id = "BA",
        Name = "Batty",
        ValueMulti = 45,
        Color = Color3.fromRGB(56, 56, 56),

        _AddFX = function(p1433: any, p1434: userdata, p1435: userdata) -- Line: 8625, Name: _AddFX
            -- upvalues: u6 (copy), u7 (copy), u3 (copy)
            p1433:_RemoveFX(p1434, p1435);

            if p1435 then
                for _, child in game.ServerStorage.Mutation_FX.Batty:GetChildren() do
                    local v1436 = child:Clone();
                    v1436.Parent = p1435;
                    v1436:AddTag("Cleanup_Batty");

                    if v1436:IsA("ParticleEmitter") then
                        v1436.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1434:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Plastic;
                    u7[descendant] = u7[descendant] or descendant.MaterialVariant;
                    descendant.MaterialVariant = "Studs 2x2 Plastic Metal";
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(0, 0, 0), 0.4);
                    descendant:AddTag("BattyVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1437: any, p1438: userdata, p1439: userdata) -- Line: 8657, Name: _RemoveFX
            -- upvalues: u3 (copy), u7 (copy), u6 (copy)
            local function v1441(p1440) -- Line: 8658
                for _, descendant in p1440:GetDescendants() do
                    if descendant:HasTag("Cleanup_Batty") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1439 then
                v1441(p1439);
            end;

            if p1438 then
                v1441(p1438);
            end;

            for _, descendant in p1438:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BattyVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("BattyVisual");
                    descendant.MaterialVariant = u7[descendant] or descendant.MaterialVariant;
                    u7[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Glossy = {
        Id = "GS",
        Name = "Glossy",
        ValueMulti = 30,
        Color = Color3.fromRGB(228, 255, 255),

        _AddFX = function(p1442: any, p1443: userdata, p1444: userdata) -- Line: 8695, Name: _AddFX
            -- upvalues: u6 (copy), u7 (copy), u3 (copy)
            p1442:_RemoveFX(p1443, p1444);

            if p1444 then
                for _, child in game.ServerStorage.Mutation_FX.Glossy:GetChildren() do
                    local v1445 = child:Clone();
                    v1445.Parent = p1444;
                    v1445:AddTag("Cleanup_Glossy");

                    if v1445:IsA("ParticleEmitter") then
                        v1445.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1443:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    descendant.Reflectance = 0.5;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Glass;
                    u7[descendant] = u7[descendant] or descendant.MaterialVariant;
                    descendant.MaterialVariant = "Studs 2x2 Plastic Metal";
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(228, 255, 255), 0.8);
                    descendant:AddTag("GlossyVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1446: any, p1447: userdata, p1448: userdata) -- Line: 8727, Name: _RemoveFX
            -- upvalues: u3 (copy), u7 (copy), u6 (copy)
            local function v1450(p1449) -- Line: 8728
                for _, descendant in p1449:GetDescendants() do
                    if descendant:HasTag("Cleanup_Glossy") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1448 then
                v1450(p1448);
            end;

            if p1447 then
                v1450(p1447);
            end;

            for _, descendant in p1447:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GlossyVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("GlossyVisual");
                    descendant.MaterialVariant = u7[descendant] or descendant.MaterialVariant;
                    u7[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Leeched = {
        Id = "LE",
        Name = "Leeched",
        ValueMulti = 70,
        Color = Color3.fromRGB(95, 26, 26),

        _AddFX = function(p1451: any, p1452: userdata, p1453: userdata) -- Line: 8764, Name: _AddFX
            -- upvalues: u6 (copy), u7 (copy), u3 (copy)
            p1451:_RemoveFX(p1452, p1453);

            if p1453 then
                for _, child in game.ServerStorage.Mutation_FX.Leeched:GetChildren() do
                    local v1454 = child:Clone();
                    v1454.Parent = p1453;
                    v1454:AddTag("Cleanup_Leeched");

                    if v1454:IsA("ParticleEmitter") then
                        v1454.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1452:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Plastic;
                    u7[descendant] = u7[descendant] or descendant.MaterialVariant;
                    descendant.MaterialVariant = "Studs 2x2 Plastic Metal";
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(0, 0, 0), 0.4);
                    descendant:AddTag("LeechedVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1455: any, p1456: userdata, p1457: userdata) -- Line: 8796, Name: _RemoveFX
            -- upvalues: u3 (copy), u7 (copy), u6 (copy)
            local function v1459(p1458) -- Line: 8797
                for _, descendant in p1458:GetDescendants() do
                    if descendant:HasTag("Cleanup_Leeched") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1457 then
                v1459(p1457);
            end;

            if p1456 then
                v1459(p1456);
            end;

            for _, descendant in p1456:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("LeechedVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("LeechedVisual");
                    descendant.MaterialVariant = u7[descendant] or descendant.MaterialVariant;
                    u7[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Lush = {
        Id = "LU",
        Name = "Lush",
        ValueMulti = 3,
        Color = Color3.fromRGB(85, 255, 0),

        _AddFX = function(p1460: any, p1461: userdata, p1462: userdata) -- Line: 8834, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1460:_RemoveFX(p1461, p1462);
            local v1463 = { "Bright green", "Earth green", "Shamrock", "Lime green", "Grime" };

            for _, descendant in p1461:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.BrickColor.Color;
                    descendant.BrickColor = BrickColor.new(v1463[Random.new():NextInteger(1, #v1463)]);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Plastic;
                    descendant:AddTag("LushVisual");
                end;
            end;

            local v1464 = game.ServerStorage:FindFirstChild("Mutation_FX") and game.ServerStorage.Mutation_FX:FindFirstChild("Lush");

            if not v1464 then
                return;
            end;

            local Children = v1464:GetChildren();

            if p1462 then
                for _, v in Children do
                    local v1465 = v:Clone();
                    v1465.Parent = p1462;

                    if v1465:IsA("ParticleEmitter") then
                        v1465.Enabled = true;
                    end;

                    v1465:AddTag("Cleanup_Lush");
                    v1465:AddTag("Effect");
                end;
            end;

            for i, descendant in ipairs(p1461:GetDescendants()) do
                if descendant:IsA("BasePart") and (not descendant:HasTag("Effect") and i % 3 == 0) then
                    local v1466 = descendant;

                    for _, v in Children do
                        if v.Name == "Swirls" then
                            local v1467 = v:Clone();
                            v1467.Parent = v1466;

                            if v1467:IsA("ParticleEmitter") then
                                v1467.Enabled = true;
                            end;

                            v1467:AddTag("Cleanup_Lush");
                            v1467:AddTag("Effect");
                        end;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1468: any, p1469: userdata, p1470: userdata) -- Line: 8888, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1472(p1471) -- Line: 8890
                for _, descendant in p1471:GetDescendants() do
                    if descendant:HasTag("Cleanup_Lush") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1470 then
                v1472(p1470);
            end;

            if p1469 then
                v1472(p1469);
            end;

            for _, descendant in p1469:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("LushVisual") then
                    descendant.Reflectance = 0;
                    local v1473;

                    if u3[descendant] then
                        v1473 = BrickColor.new(u3[descendant]);
                    else
                        v1473 = descendant.BrickColor;
                    end;

                    descendant.BrickColor = v1473;
                    u3[descendant] = nil;
                    descendant:RemoveTag("LushVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Nocturnal = {
        Id = "NL",
        Name = "Nocturnal",
        ValueMulti = 4,
        Color = Color3.fromRGB(61, 219, 255),

        _AddFX = function(p1474: any, p1475: userdata, p1476: userdata) -- Line: 8926, Name: _AddFX
            -- upvalues: u3 (copy)
            p1474:_RemoveFX(p1475, p1476);

            if p1476 then
                for _, child in game.ServerStorage.Mutation_FX.Nocturnal:GetChildren() do
                    local v1477 = child:Clone();
                    v1477.Parent = p1476;
                    v1477.Enabled = true;
                    v1477:AddTag("Cleanup_Nocturnal");
                    v1477:AddTag("Effect");
                end;
            end;

            for _, descendant in p1475:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(62, 56, 86);
                    descendant.Reflectance = 0.3;
                    descendant:AddTag("NocturnalVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1478: any, p1479: userdata, p1480: userdata) -- Line: 8951, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p1480 then
                for _, child in p1480:GetChildren() do
                    if child:HasTag("Cleanup_Nocturnal") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1479:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("NocturnalVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("NocturnalVisual");
                    local v1481 = u6[descendant];

                    if v1481 then
                        descendant.Material = v1481;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Arid = {
        Id = "AR",
        Name = "Arid",
        ValueMulti = 6,
        Color = Color3.fromRGB(255, 170, 0),

        _AddFX = function(p1482: any, p1483: userdata, p1484: userdata) -- Line: 8985, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1482:_RemoveFX(p1483, p1484);
            local v1485 = {
                Color3.fromRGB(255, 205, 60),
                Color3.fromRGB(255, 185, 85),
                Color3.fromRGB(230, 150, 50),
                Color3.fromRGB(200, 125, 35),
                Color3.fromRGB(255, 220, 140)
            };

            if p1484 then
                for _, child in game.ServerStorage.Mutation_FX.Arid:GetChildren() do
                    local v1486 = child:Clone();
                    v1486.Parent = p1484;
                    v1486.Enabled = true;
                    v1486:AddTag("Cleanup_Arid");
                end;
            end;

            for i, descendant in p1483:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    local v1487 = i % 5 == 0 and game.ServerStorage.Mutation_FX.Arid:FindFirstChild("LeafSwirl");

                    if v1487 then
                        local v1488 = v1487:Clone();
                        v1488.Parent = descendant;
                        v1488.Enabled = true;
                        v1488:AddTag("Cleanup_Arid");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = v1485[Random.new():NextInteger(1, #v1485)];
                        descendant.Material = Enum.Material.Sand;
                        descendant:AddTag("AridVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1489: any, p1490: userdata, p1491: userdata) -- Line: 9034, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1493(p1492) -- Line: 9035
                for _, descendant in p1492:GetDescendants() do
                    if descendant:HasTag("Cleanup_Arid") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1491 then
                v1493(p1491);
            end;

            if p1490 then
                v1493(p1490);
            end;

            for _, descendant in p1490:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("AridVisual") then
                    descendant:RemoveTag("AridVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Mirage = {
        Id = "MR",
        Name = "Mirage",
        ValueMulti = 25,
        Color = Color3.fromRGB(170, 255, 255),

        _AddFX = function(p1494: any, p1495: userdata, p1496: userdata) -- Line: 9072, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1494:_RemoveFX(p1495, p1496);

            if p1496 then
                for _, child in game.ServerStorage.Mutation_FX.Mirage:GetChildren() do
                    local v1497 = child:Clone();
                    v1497.Parent = p1496;
                    v1497.Enabled = true;
                    v1497:AddTag("Cleanup_Mirage");
                end;
            end;

            for i, descendant in p1495:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 4 == 0 then
                        local v1498 = game.ServerStorage.Mutation_FX.Mirage.Rays:Clone();
                        v1498.Parent = descendant;
                        v1498.Enabled = true;
                        v1498:AddTag("Cleanup_Mirage");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = Color3.fromRGB(170, 255, 255);
                        descendant.Material = Enum.Material.Glass;
                        descendant:AddTag("MirageVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1499: any, p1500: userdata, p1501: userdata) -- Line: 9109, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p1501 then
                for _, child in p1501:GetChildren() do
                    if child:HasTag("Cleanup_Mirage") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1500:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MirageVisual") then
                    descendant:RemoveTag("MirageVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Stampede = {
        Id = "ST",
        Name = "Stampede",
        ValueMulti = 50,
        Color = Color3.fromRGB(255, 170, 0),

        _AddFX = function(p1502: any, p1503: userdata, p1504: userdata) -- Line: 9141, Name: _AddFX
            -- upvalues: u5 (copy), u4 (copy)
            p1502:_RemoveFX(p1503, p1504);
            local v1505 = p1503:FindFirstChild("Item_Seed") and p1503.Item_Seed.Value or tick();
            local Random_new_ret = Random.new(v1505);
            local v1506 = 0;

            for _, descendant in p1503:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency <= 0.75) then
                    v1506 = v1506 + 1;
                    local v1507;

                    if v1506 <= 8 then
                        v1507 = descendant;

                        for _, child in game.ServerStorage.Mutation_FX.Stampede:GetChildren() do
                            local v1508 = child:Clone();
                            v1508.Parent = v1507;

                            if v1508:IsA("ParticleEmitter") then
                                v1508.Enabled = true;
                                v1508.Rate = v1508.Rate / v1506;
                                v1508.Color = ColorSequence.new(v1507.Color);
                            else
                                v1508.Transparency = math.clamp(v1507.Transparency / 2, 0, 0.4) + 0.25;
                            end;

                            v1508:AddTag("Cleanup_Stampede");
                        end;
                    else
                        v1507 = descendant;
                    end;

                    if not v1507:HasTag("StampedeVisual") then
                        u5[v1507] = u5[v1507] or v1507.Orientation;
                        u4[v1507] = u4[v1507] or v1507.Position;
                        local v1509 = u5[v1507];
                        local v1510 = u4[v1507];
                        local X = v1507.Size.X;
                        local v1511 = v1509.X + Random_new_ret:NextNumber(-6.4, 6.4);
                        local v1512 = v1509.Y + Random_new_ret:NextNumber(-6.4, 6.4);
                        local v1513 = v1509.Z + Random_new_ret:NextNumber(-6.4, 6.4);
                        v1507.Orientation = Vector3.new(v1511, v1512, v1513);
                        local v1514 = Random_new_ret:NextNumber(-X, X) * 0.2;
                        local v1515 = Random_new_ret:NextNumber(-X, X) * 0.2;
                        local v1516 = Random_new_ret:NextNumber(-X, X) * 0.2;
                        local math_clamp_ret = math.clamp(v1514, -1, 1);
                        local math_clamp_ret2 = math.clamp(v1515, -1, 1);
                        local math_clamp_ret3 = math.clamp(v1516, -1, 1);
                        v1507.Position = v1510 + Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3);
                        v1507:AddTag("StampedeVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1517: any, p1518: userdata, p1519: userdata) -- Line: 9199, Name: _RemoveFX
            -- upvalues: u5 (copy), u4 (copy), u3 (copy)
            local function v1521(p1520) -- Line: 9200
                for _, descendant in p1520:GetDescendants() do
                    if descendant:HasTag("Cleanup_Stampede") or descendant.Name == "CRACKSTEXTURE" then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1519 then
                v1521(p1519);
            end;

            if p1518 then
                v1521(p1518);
            end;

            for _, descendant in p1518:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("StampedeVisual") then
                    if u5[descendant] then
                        descendant.Orientation = u5[descendant];
                        u5[descendant] = nil;
                    end;

                    if u4[descendant] then
                        descendant.Position = u4[descendant];
                        u4[descendant] = nil;
                    end;

                    if descendant:FindFirstChild("StampedeRubbleP") then
                        descendant.StampedeRubbleP:Destroy();
                    end;

                    if descendant:FindFirstChild("StampedePixelSmokeP") then
                        descendant.StampedePixelSmokeP:Destroy();
                    end;

                    descendant.Reflectance = 0;
                    u3[descendant] = nil;
                    descendant:RemoveTag("StampedeVisual");
                end;
            end;
        end
    },
    Monsoon = {
        Id = "MO",
        Name = "Monsoon",
        ValueMulti = 50,
        Color = Color3.fromRGB(170, 255, 255),

        _AddFX = function(p1522: any, p1523: userdata, p1524: userdata) -- Line: 9241, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1522:_RemoveFX(p1523, p1524);
            local Children = game.ServerStorage.Mutation_FX.Monsoon:GetChildren();
            local Color3_fromRGB_ret = Color3.fromRGB(170, 255, 255);
            local v1525 = {};

            for _, descendant in p1523:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    table.insert(v1525, descendant);
                end;
            end;

            if p1524 and not table.find(v1525, p1524) then
                table.insert(v1525, p1524);
            end;

            local v1526 = 0;

            for i, v in ipairs(v1525) do
                local v1527;

                if i % 4 == 0 or v == p1524 then
                    v1527 = v1526 < 8;
                else
                    v1527 = false;
                end;

                if v1527 then
                    v1526 = v1526 + 1;
                end;

                local v1528 = v;

                for _, v2 in Children do
                    if v1527 then
                        local v1529 = v2:Clone();
                        v1529.Parent = v1528;
                        v1529.Enabled = true;
                        v1529:AddTag("Cleanup_Monsoon");
                        v1529:AddTag("Effect");
                    end;
                end;

                if not v1528:HasTag("Effect") then
                    u3[v1528] = u3[v1528] or v1528.Color;
                    u6[v1528] = u6[v1528] or v1528.Material;
                    OriginalTransparency = OriginalTransparency or {};
                    OriginalTransparency[v1528] = v1528.Transparency;
                    v1528.Color = Color3_fromRGB_ret;
                    v1528.Material = Enum.Material.Neon;
                    v1528.Transparency = 0.8;
                    v1528:AddTag("MonsoonVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1530: any, p1531: userdata, p1532: userdata) -- Line: 9286, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1534(p1533) -- Line: 9287
                for _, descendant in p1533:GetDescendants() do
                    if descendant:HasTag("Cleanup_Monsoon") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1532 then
                v1534(p1532);
            end;

            if p1531 then
                v1534(p1531);
            end;

            for _, descendant in p1531:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MonsoonVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;

                    if OriginalTransparency and OriginalTransparency[descendant] then
                        descendant.Transparency = OriginalTransparency[descendant];
                        OriginalTransparency[descendant] = nil;
                    else
                        descendant.Transparency = 0;
                    end;

                    descendant:RemoveTag("MonsoonVisual");
                end;
            end;
        end
    },
    Twilight = {
        Id = "TW",
        Name = "Twilight",
        ValueMulti = 4,
        Color = Color3.fromRGB(170, 170, 255),

        _AddFX = function(p1535: any, p1536: userdata, p1537: userdata) -- Line: 9326, Name: _AddFX
            -- upvalues: u3 (copy)
            p1535:_RemoveFX(p1536, p1537);

            if p1537 then
                for _, child in game.ServerStorage.Mutation_FX.Crepuscular:GetChildren() do
                    local v1538 = child:Clone();
                    v1538.Parent = p1537;
                    v1538.Enabled = true;
                    v1538:AddTag("Cleanup_Crepuscular");
                    v1538:AddTag("Effect");
                end;
            end;

            for _, descendant in p1536:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(170, 170, 255);
                    descendant.Reflectance = 0.3;
                    descendant:AddTag("CrepuscularVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1539: any, p1540: userdata, p1541: userdata) -- Line: 9351, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p1541 then
                for _, child in p1541:GetChildren() do
                    if child:HasTag("Cleanup_Crepuscular") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1540:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CrepuscularVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Reflectance = 0;
                    descendant:RemoveTag("CrepuscularVisual");
                    local v1542 = u6[descendant];

                    if v1542 then
                        descendant.Material = v1542;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Typhoon = {
        Id = "TY",
        Name = "Typhoon",
        ValueMulti = 30,
        Color = Color3.fromRGB(0, 174, 255),

        _AddFX = function(p1543: any, p1544: userdata, p1545: userdata) -- Line: 9385, Name: _AddFX
            p1543:_RemoveFX(p1544, p1545);
            local Children = game.ServerStorage.Mutation_FX.Typhoon:GetChildren();

            if p1545 then
                for _, v in Children do
                    if not p1545:FindFirstChild(v.Name) then
                        local v1546 = v:Clone();
                        v1546.Parent = p1545;
                        v1546.Enabled = true;
                        v1546:AddTag("Cleanup_Typhoon");
                    end;
                end;
            end;

            local v1547 = 0;

            for _, descendant in p1544:GetDescendants() do
                if descendant:IsA("BasePart") and descendant ~= p1545 then
                    v1547 = v1547 + 1;

                    if v1547 % 3 == 0 then
                        local v1548 = Children[math.random(1, #Children)]:Clone();
                        v1548.Parent = descendant;
                        v1548.Enabled = true;
                        v1548:AddTag("Cleanup_Typhoon");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1549: any, p1550: userdata, p1551: userdata) -- Line: 9415, Name: _RemoveFX
            local function v1553(p1552) -- Line: 9416
                for _, descendant in p1552:GetDescendants() do
                    if descendant:HasTag("Cleanup_Typhoon") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1551 then
                v1553(p1551);
            end;

            if p1550 then
                v1553(p1550);
            end;
        end
    },
    Wildfast = {
        Id = "WF",
        Name = "Wildfast",
        ValueMulti = 5,
        Color = Color3.fromRGB(255, 255, 0),

        _AddFX = function(p1554: any, p1555: userdata, p1556: userdata) -- Line: 9434, Name: _AddFX
            p1554:_RemoveFX(p1555, p1556);

            if p1556 then
                for _, child in game.ServerStorage.Mutation_FX.Wildfast:GetChildren() do
                    local v1557 = child:Clone();
                    v1557.Parent = p1556;
                    v1557:AddTag("Cleanup_Wildfast");
                end;
            end;
        end,

        _RemoveFX = function(p1558: any, p1559: userdata, p1560: userdata) -- Line: 9449, Name: _RemoveFX
            if p1560 then
                for _, child in p1560:GetChildren() do
                    if child:HasTag("Cleanup_Wildfast") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Tempered = {
        Id = "TE",
        Name = "Tempered",
        ValueMulti = 6,
        Color = Color3.fromRGB(255, 96, 17),

        _AddFX = function(p1561: any, p1562: userdata, p1563: userdata) -- Line: 9466, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1561:_RemoveFX(p1562, p1563);

            if p1563 then
                for _, child in game.ServerStorage.Mutation_FX.Tempered:GetChildren() do
                    local v1564 = child:Clone();
                    v1564.Parent = p1563;
                    v1564.Enabled = true;
                    v1564:AddTag("Cleanup_Tempered");
                end;
            end;

            for i, descendant in p1562:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    local _ = i % 5 == 0;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = Color3.fromRGB(255, 100, 28);
                        descendant.Material = Enum.Material.Neon;
                        descendant:AddTag("TemperedVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1565: any, p1566: userdata, p1567: userdata) -- Line: 9507, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1569(p1568) -- Line: 9508
                for _, descendant in p1568:GetDescendants() do
                    if descendant:HasTag("Cleanup_Tempered") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1567 then
                v1569(p1567);
            end;

            if p1566 then
                v1569(p1566);
            end;

            for _, descendant in p1566:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("TemperedVisual") then
                    descendant:RemoveTag("TemperedVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Charcoal = {
        Id = "CH",
        Name = "Charcoal",
        ValueMulti = 6,
        Color = Color3.fromRGB(71, 71, 71),

        _AddFX = function(p1570: any, p1571: userdata, p1572: userdata) -- Line: 9545, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1570:_RemoveFX(p1571, p1572);

            if p1572 then
                for _, child in game.ServerStorage.Mutation_FX.Charcoal:GetChildren() do
                    local v1573 = child:Clone();
                    v1573.Parent = p1572;
                    v1573.Enabled = true;
                    v1573:AddTag("Cleanup_Charcoal");
                end;
            end;

            for i, descendant in p1571:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    local _ = i % 5 == 0;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = Color3.fromRGB(71, 71, 71);
                        descendant.Material = Enum.Material.Sand;
                        descendant:AddTag("CharcoalVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1574: any, p1575: userdata, p1576: userdata) -- Line: 9585, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1578(p1577) -- Line: 9586
                for _, descendant in p1577:GetDescendants() do
                    if descendant:HasTag("Cleanup_Charcoal") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1576 then
                v1578(p1576);
            end;

            if p1575 then
                v1578(p1575);
            end;

            for _, descendant in p1575:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CharcoalVisual") then
                    descendant:RemoveTag("CharcoalVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Geode = {
        Id = "GD",
        Name = "Geode",
        ValueMulti = 5,
        Color = Color3.fromRGB(255, 0, 0),

        _AddFX = function(p1579: any, p1580: userdata, p1581: userdata) -- Line: 9623, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1579:_RemoveFX(p1580, p1581);
            local Children = game.ServerStorage.Mutation_FX.Geode:GetChildren();

            if #Children == 0 then
                return;
            end;

            local v1582 = {};

            for _, descendant in p1580:GetDescendants() do
                if descendant:IsA("BasePart") and (not descendant:HasTag("Effect") and descendant.Transparency < 0.9) then
                    table.insert(v1582, descendant);
                end;
            end;

            if #v1582 == 0 then
                return;
            end;

            local math_floor_ret = math.floor(#v1582 * 0.25);
            local math_max_ret = math.max(4, math_floor_ret);
            local Random_new_ret = Random.new(tick());
            local v1583 = {};

            while #v1583 < math_max_ret and #v1582 > 0 do
                local v1584 = Random_new_ret:NextInteger(1, #v1582);
                table.insert(v1583, table.remove(v1582, v1584));
            end;

            local v1585 = {
                {
                    Color = Color3.fromRGB(255, 50, 50),
                    Material = Enum.Material.Neon
                },
                {
                    Color = Color3.fromRGB(50, 255, 255),
                    Material = Enum.Material.Neon
                },
                {
                    Color = Color3.fromRGB(50, 255, 100),
                    Material = Enum.Material.Neon
                }
            };

            for _, v in v1583 do
                local v1586 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                v1586.Parent = v;
                v1586.Enabled = true;
                v1586:AddTag("Cleanup_Geode");
                v1586:AddTag("Effect");
                local v1587 = v1585[Random_new_ret:NextInteger(1, #v1585)];
                u3[v] = u3[v] or v.Color;
                u6[v] = u6[v] or v.Material;
                v.Color = v1587.Color;
                v.Material = v1587.Material;
                v:AddTag("GeodeVisual");
            end;
        end,

        _RemoveFX = function(p1588: any, p1589: userdata, p1590: userdata) -- Line: 9670, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1592(p1591) -- Line: 9671
                for _, descendant in p1591:GetDescendants() do
                    if descendant:HasTag("Cleanup_Geode") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1590 then
                v1592(p1590);
            end;

            if p1589 then
                v1592(p1589);
            end;

            for _, descendant in p1589:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GeodeVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant:RemoveTag("GeodeVisual");
                end;
            end;
        end
    },
    Supernatural = {
        Id = "SU",
        Name = "Supernatural",
        ValueMulti = 37,
        Color = Color3.fromRGB(79, 28, 110),

        _AddFX = function(p1593: any, p1594: userdata, p1595: userdata) -- Line: 9706, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1597(p1596) -- Line: 9707
                for _, descendant in p1596:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or (descendant:IsA("Smoke") or (descendant:IsA("Sparkles") or descendant:IsA("PointLight"))))) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            p1593:_RemoveFX(p1594, p1595);
            local Children = game.ServerStorage.Mutation_FX.Supernatural:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1595 then
                for _, v in Children do
                    local v1598 = v:Clone();
                    v1598.Parent = p1595;
                    v1597(v1598);
                    v1598:AddTag("Cleanup_Supernatural");
                    v1598:AddTag("Effect");
                end;
            end;

            for _, descendant in p1594:GetDescendants() do
                if descendant:IsA("BasePart") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = Color3.fromRGB(170, 215, 230);
                    descendant.Material = Enum.Material.Neon;
                    descendant.Transparency = 0.6;
                    descendant:AddTag("SupernaturalVisual");
                end;
            end;

            local v1599 = {};

            for _, descendant in p1594:GetDescendants() do
                if descendant:IsA("BasePart") and (descendant ~= p1595 and not descendant:HasTag("Effect")) then
                    table.insert(v1599, descendant);
                end;
            end;

            local v1600 = #Children > 6 and 3 or 2;

            for i, v in ipairs(v1599) do
                if i % v1600 == 0 then
                    local v1601 = Children[math.random(1, #Children)]:Clone();
                    v1601.Parent = v;
                    v1597(v1601);
                    v1601:AddTag("Cleanup_Supernatural");
                    v1601:AddTag("Effect");

                    if math.random() < 0.22 then
                        local v1602 = Children[math.random(1, #Children)]:Clone();
                        v1602.Parent = v;
                        v1597(v1602);
                        v1602:AddTag("Cleanup_Supernatural");
                        v1602:AddTag("Effect");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1603: any, p1604: userdata, p1605: userdata) -- Line: 9775, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1607(p1606) -- Line: 9776
                for _, descendant in p1606:GetDescendants() do
                    if descendant:HasTag("Cleanup_Supernatural") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1605 then
                v1607(p1605);
            end;

            if p1604 then
                v1607(p1604);
            end;

            for _, descendant in p1604:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("SupernaturalVisual") then
                    descendant:RemoveTag("SupernaturalVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v1608 = u6[descendant];

                    if v1608 then
                        descendant.Material = v1608;
                        u6[descendant] = nil;
                    end;

                    descendant.Transparency = 0;
                end;
            end;
        end
    },
    Stormbound = {
        Id = "STB",
        Name = "Stormbound",
        ValueMulti = 270,
        Color = Color3.fromRGB(25, 46, 89),

        _AddFX = function(p1609: any, p1610: userdata, p1611: userdata) -- Line: 9809, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1613(p1612) -- Line: 9811
                for _, descendant in p1612:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or (descendant:IsA("Smoke") or (descendant:IsA("Sparkles") or descendant:IsA("PointLight"))))) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            p1609:_RemoveFX(p1610, p1611);
            local Children = game.ServerStorage.Mutation_FX.Stormbound:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1611 then
                for _, v in Children do
                    local v1614 = v:Clone();
                    v1614.Parent = p1611;
                    v1613(v1614);
                    v1614:AddTag("Cleanup_Stormbound");
                    v1614:AddTag("Effect");
                end;
            end;

            local v1615 = {};

            for _, descendant in p1610:GetDescendants() do
                if descendant:IsA("BasePart") and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    table.insert(v1615, descendant);
                end;
            end;

            for i = 1, math.ceil(#v1615 * 1) do
                local math_random_ret = math.random(1, #v1615);
                local table_remove_ret = table.remove(v1615, math_random_ret);
                table_remove_ret.Material = Enum.Material.Neon;
                table_remove_ret.Transparency = 0.4;
                table_remove_ret:AddTag("StormboundVisual");
                table_remove_ret.Color = Color3.fromRGB(60, 75, 120);
                local _ = i;
            end;

            local v1616 = #Children <= 4 and 2 or 3;

            for i, v in ipairs(v1615) do
                if i % v1616 == 0 then
                    local v1617 = Children[math.random(1, #Children)]:Clone();
                    v1617.Parent = v;
                    v1613(v1617);
                    v1617:AddTag("Cleanup_Stormbound");
                    v1617:AddTag("Effect");

                    if math.random() < 0.15 then
                        local v1618 = Children[math.random(1, #Children)]:Clone();
                        v1618.Parent = v;
                        v1613(v1618);
                        v1618:AddTag("Cleanup_Stormbound");
                        v1618:AddTag("Effect");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1619: any, p1620: userdata, p1621: userdata) -- Line: 9883, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1623(p1622) -- Line: 9884
                for _, descendant in p1622:GetDescendants() do
                    if descendant:HasTag("Cleanup_Stormbound") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1621 then
                v1623(p1621);
            end;

            if p1620 then
                v1623(p1620);
            end;

            for _, descendant in p1620:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("StormboundVisual") then
                    descendant:RemoveTag("StormboundVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v1624 = u6[descendant];

                    if v1624 then
                        descendant.Material = v1624;
                        u6[descendant] = nil;
                    end;

                    descendant.Transparency = 0;
                end;
            end;
        end
    },
    SunScorched = {
        Id = "SCO",
        Name = "SunScorched",
        ValueMulti = 32,
        Color = Color3.fromRGB(210, 115, 30),

        _AddFX = function(p1625: any, p1626: userdata, p1627: userdata) -- Line: 9918, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1629(p1628) -- Line: 9919
                for _, descendant in p1628:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or (descendant:IsA("Smoke") or (descendant:IsA("Sparkles") or descendant:IsA("PointLight"))))) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            p1625:_RemoveFX(p1626, p1627);
            local Children = game.ServerStorage.Mutation_FX.SunScorched:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1627 then
                for _, v in Children do
                    local v1630 = v:Clone();
                    v1630.Parent = p1627;
                    v1629(v1630);
                    v1630:AddTag("Cleanup_SunScorched");
                    v1630:AddTag("Effect");
                end;
            end;

            local v1631 = {};

            for _, descendant in p1626:GetDescendants() do
                if descendant:IsA("BasePart") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Sand;
                    descendant.Color = Color3.fromRGB(210, 115, 30);
                    descendant:AddTag("SunScorchedVisual");
                    table.insert(v1631, descendant);
                end;
            end;

            local v1632 = #Children > 5 and 3 or 2;

            for i, v in ipairs(v1631) do
                if i % v1632 == 0 then
                    local v1633 = Children[math.random(1, #Children)]:Clone();
                    v1633.Parent = v;
                    v1629(v1633);
                    v1633:AddTag("Cleanup_SunScorched");
                    v1633:AddTag("Effect");

                    if math.random() < 0.18 then
                        local v1634 = Children[math.random(1, #Children)]:Clone();
                        v1634.Parent = v;
                        v1629(v1634);
                        v1634:AddTag("Cleanup_SunScorched");
                        v1634:AddTag("Effect");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1635: any, p1636: userdata, p1637: userdata) -- Line: 9981, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1639(p1638) -- Line: 9982
                for _, descendant in p1638:GetDescendants() do
                    if descendant:HasTag("Cleanup_SunScorched") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1637 then
                v1639(p1637);
            end;

            if p1636 then
                v1639(p1636);
            end;

            for _, descendant in p1636:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("SunScorchedVisual") then
                    descendant:RemoveTag("SunScorchedVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v1640 = u6[descendant];

                    if v1640 then
                        descendant.Material = v1640;
                        u6[descendant] = nil;
                    end;

                    descendant.Transparency = 0;
                end;
            end;
        end
    },
    Riptide = {
        Id = "RP",
        Name = "Riptide",
        ValueMulti = 80,
        Color = Color3.fromRGB(15, 151, 178),

        _AddFX = function(p1641: any, p1642: userdata, p1643: userdata) -- Line: 10015, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1645(p1644) -- Line: 10016
                for _, descendant in p1644:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or (descendant:IsA("Smoke") or (descendant:IsA("Sparkles") or descendant:IsA("PointLight"))))) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            p1641:_RemoveFX(p1642, p1643);
            local Children = game.ServerStorage.Mutation_FX.Riptide:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1643 then
                for _, v in Children do
                    local v1646 = v:Clone();
                    v1646.Parent = p1643;
                    v1645(v1646);
                    v1646:AddTag("Cleanup_Riptide");
                    v1646:AddTag("Effect");
                end;
            end;

            local v1647 = {};

            for _, descendant in p1642:GetDescendants() do
                if descendant:IsA("BasePart") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Glass;
                    descendant.Color = Color3.fromRGB(15, 151, 178);
                    descendant.Transparency = 0.3;
                    descendant:AddTag("RiptideVisual");
                    table.insert(v1647, descendant);
                end;
            end;

            for i, v in ipairs(v1647) do
                if i % 2 == 0 then
                    local v1648 = Children[math.random(1, #Children)]:Clone();
                    v1648.Parent = v;
                    v1645(v1648);
                    v1648:AddTag("Cleanup_Riptide");
                    v1648:AddTag("Effect");

                    if math.random() < 0.18 then
                        local v1649 = Children[math.random(1, #Children)]:Clone();
                        v1649.Parent = v;
                        v1645(v1649);
                        v1649:AddTag("Cleanup_Riptide");
                        v1649:AddTag("Effect");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1650: any, p1651: userdata, p1652: userdata) -- Line: 10078, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1654(p1653) -- Line: 10079
                for _, descendant in p1653:GetDescendants() do
                    if descendant:HasTag("Cleanup_Riptide") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1652 then
                v1654(p1652);
            end;

            if p1651 then
                v1654(p1651);
            end;

            for _, descendant in p1651:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("RiptideVisual") then
                    descendant:RemoveTag("RiptideVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v1655 = u6[descendant];

                    if v1655 then
                        descendant.Material = v1655;
                        u6[descendant] = nil;
                    end;

                    descendant.Transparency = 0;
                end;
            end;
        end
    },
    Grim = {
        Id = "GRM",
        Name = "Grim",
        ValueMulti = 170,
        Color = Color3.fromRGB(6, 7, 23),

        _AddFX = function(p1656: any, p1657: userdata, p1658: userdata) -- Line: 10112, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1660(p1659) -- Line: 10113
                for _, descendant in p1659:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or (descendant:IsA("Smoke") or (descendant:IsA("Sparkles") or descendant:IsA("PointLight"))))) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            p1656:_RemoveFX(p1657, p1658);
            local Children = game.ServerStorage.Mutation_FX.Grim:GetChildren();

            if #Children == 0 then
                return;
            end;

            if p1658 then
                for _, v in Children do
                    local v1661 = v:Clone();
                    v1661.Parent = p1658;
                    v1660(v1661);
                    v1661:AddTag("Cleanup_Grim");
                    v1661:AddTag("Effect");
                end;
            end;

            for _, descendant in p1657:GetDescendants() do
                if descendant:IsA("BasePart") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = Color3.fromRGB(10, 10, 25);
                    descendant:AddTag("GrimVisual");
                end;
            end;

            local v1662 = {};

            for _, descendant in p1657:GetDescendants() do
                if descendant:IsA("BasePart") and (descendant ~= p1658 and not descendant:HasTag("Effect")) then
                    table.insert(v1662, descendant);
                end;
            end;

            for i, v in ipairs(v1662) do
                if i % 2 == 0 then
                    local v1663 = Children[math.random(1, #Children)]:Clone();
                    v1663.Parent = v;
                    v1660(v1663);
                    v1663:AddTag("Cleanup_Grim");
                    v1663:AddTag("Effect");

                    if math.random() < 0.2 then
                        local v1664 = Children[math.random(1, #Children)]:Clone();
                        v1664.Parent = v;
                        v1660(v1664);
                        v1664:AddTag("Cleanup_Grim");
                        v1664:AddTag("Effect");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1665: any, p1666: userdata, p1667: userdata) -- Line: 10178, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1669(p1668) -- Line: 10179
                for _, descendant in p1668:GetDescendants() do
                    if descendant:HasTag("Cleanup_Grim") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1667 then
                v1669(p1667);
            end;

            if p1666 then
                v1669(p1666);
            end;

            for _, descendant in p1666:GetDescendants() do
                if descendant:IsA("BasePart") and descendant:HasTag("GrimVisual") then
                    descendant:RemoveTag("NGrimVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v1670 = u6[descendant];

                    if v1670 then
                        descendant.Material = v1670;
                        u6[descendant] = nil;
                    end;

                    descendant.Transparency = 0;
                end;
            end;
        end
    },
    Extraterrestrial = {
        Id = "ET",
        Name = "Extraterrestrial",
        ValueMulti = 130,
        Color = Color3.fromRGB(17, 0, 255),

        _AddFX = function(p1671: any, p1672: userdata, p1673: userdata) -- Line: 10212, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1671:_RemoveFX(p1672, p1673);
            local Random_new_ret = Random.new();
            local Extraterrestrial = game.ServerStorage.Mutation_FX.Extraterrestrial;

            if p1673 then
                for _, child in Extraterrestrial:GetChildren() do
                    local v1674 = child:Clone();
                    v1674.Parent = p1673;
                    v1674.Enabled = true;
                    v1674:AddTag("Cleanup_Extraterrestrial");
                end;
            end;

            local v1675 = {
                Color3.fromRGB(3, 23, 76),
                Color3.fromRGB(3, 96, 159),
                Color3.fromRGB(3, 142, 206),
                Color3.fromRGB(0, 149, 94),
                Color3.fromRGB(0, 255, 217),
                Color3.fromRGB(3, 23, 76)
            };

            for i, descendant in p1672:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 5 == 0 then
                        local Sparkle = Extraterrestrial:FindFirstChild("Sparkle");

                        if Sparkle then
                            local v1676 = Sparkle:Clone();
                            v1676.Parent = descendant;
                            v1676.Enabled = true;
                            v1676.Rate = Random_new_ret:NextNumber(17, 25) / 20;
                            v1676:AddTag("Cleanup_Extraterrestrial");
                        end;

                        local Swirls = Extraterrestrial:FindFirstChild("Swirls");

                        if Swirls then
                            local v1677 = Swirls:Clone();
                            v1677.Parent = descendant;
                            v1677.Enabled = true;
                            v1677.Rate = Random_new_ret:NextNumber(17, 25) / 30;
                            v1677:AddTag("Cleanup_Extraterrestrial");
                        end;
                    end;

                    if not descendant:HasTag("Effect") and descendant.Transparency ~= 1 then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if Random_new_ret:NextInteger(1, 9) == 1 then
                            descendant.Material = Enum.Material.Marble;
                        else
                            descendant.Material = Enum.Material.Neon;
                        end;

                        local v1678 = v1675[Random_new_ret:NextInteger(1, #v1675)];
                        descendant.Color = descendant.Color:Lerp(v1678, 0.9);
                        descendant:AddTag("ExtraterrestrialVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1679: any, p1680: userdata, p1681: userdata) -- Line: 10286, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1683(p1682) -- Line: 10287
                for _, descendant in p1682:GetDescendants() do
                    if descendant:HasTag("Cleanup_Extraterrestrial") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1681 then
                v1683(p1681);
            end;

            if p1680 then
                v1683(p1680);
            end;

            for _, descendant in p1680:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ExtraterrestrialVisual") then
                    descendant:RemoveTag("ExtraterrestrialVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Mineral = {
        Id = "MN",
        Name = "Mineral",
        ValueMulti = 18,
        Color = Color3.fromRGB(112, 88, 71),

        _AddFX = function(p1684: any, p1685: userdata, p1686: userdata) -- Line: 10325, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1684:_RemoveFX(p1685, p1686);

            if p1686 then
                for _, child in game.ServerStorage.Mutation_FX.Mineral:GetChildren() do
                    local v1687 = child:Clone();
                    v1687.Parent = p1686;
                    v1687.Enabled = true;
                end;
            end;

            local v1688 = 0;

            for i, descendant in p1685:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 3 == 0 and v1688 < 6 then
                        v1688 = v1688 + 1;
                        local v1689 = game.ServerStorage.Mutation_FX.Mineral.AmberParticle:Clone();
                        v1689.Parent = descendant;
                        v1689.Enabled = true;
                        v1689.Rate = math.random(17, 25) / 20;
                        v1689:AddTag("Cleanup_Mineral");
                        local v1690 = game.ServerStorage.Mutation_FX.Mineral.BurntSizzle:Clone();
                        v1690.Parent = descendant;
                        v1690.Enabled = true;
                        v1690.Rate = math.random(17, 25) / 30;
                        v1690:AddTag("Cleanup_Mineral");
                        local v1691 = game.ServerStorage.Mutation_FX.Mineral.CharcoalParticles:Clone();
                        v1691.Parent = descendant;
                        v1691.Enabled = true;
                        v1691.Rate = math.random(17, 25) / 30;
                        v1691:AddTag("Cleanup_Mineral");
                        local v1692 = game.ServerStorage.Mutation_FX.Mineral.ClayParticle:Clone();
                        v1692.Parent = descendant;
                        v1692.Enabled = true;
                        v1692.Rate = math.random(17, 25) / 30;
                        v1692:AddTag("Cleanup_Mineral");
                        local v1693 = game.ServerStorage.Mutation_FX.Mineral.brown:Clone();
                        v1693.Parent = descendant;
                        v1693.Enabled = true;
                        v1693.Rate = math.random(17, 25) / 30;
                        v1693:AddTag("Cleanup_Mineral");
                        local v1694 = game.ServerStorage.Mutation_FX.Mineral.green:Clone();
                        v1694.Parent = descendant;
                        v1694.Enabled = true;
                        v1694.Rate = math.random(17, 25) / 30;
                        v1694:AddTag("Cleanup_Mineral");
                    end;

                    Color3.new(0.0666667, 0.298039, 0.121569);

                    if not descendant:HasTag("Effect") and descendant.Transparency ~= 1 then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Material = Enum.Material.Rock;
                        local Color3_new_ret = Color3.new(0.298039, 0.266667, 0.137255);
                        descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.9);
                        descendant:AddTag("MineralVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1695: any, p1696: userdata, p1697: userdata) -- Line: 10401, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p1697 then
                for _, child in p1697:GetChildren() do
                    if child:HasTag("Cleanup_Mineral") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1696:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("MineralVisual") then
                    descendant:RemoveTag("MineralVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant.Material = u6[descendant] or descendant.Material;
                    u6[descendant] = nil;
                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    MindBender = {
        Id = "MBR",
        Name = "MindBender",
        ValueMulti = 175,
        Color = Color3.fromRGB(255, 48, 210),

        _AddFX = function(p1698: any, p1699: userdata, p1700: userdata) -- Line: 10433, Name: _AddFX
            p1698:_RemoveFX(p1699, p1700);

            if p1700 then
                for _, child in game.ServerStorage.Mutation_FX.MindBender:GetChildren() do
                    local v1701 = child:Clone();
                    v1701.Parent = p1700;
                    v1701.Enabled = true;
                    v1701:AddTag("Cleanup_MindBender");
                end;
            end;
        end,

        _RemoveFX = function(p1702: any, p1703: userdata, p1704: userdata) -- Line: 10446, Name: _RemoveFX
            local function v1706(p1705) -- Line: 10447
                for _, descendant in p1705:GetDescendants() do
                    if descendant:HasTag("Cleanup_MindBender") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1704 then
                v1706(p1704);
            end;

            if p1703 then
                v1706(p1703);
            end;
        end
    },
    Affluent = {
        Id = "AF",
        Name = "Affluent",
        ValueMulti = 70,
        Color = Color3.fromRGB(57, 238, 255),

        _AddFX = function(p1707: any, p1708: userdata, p1709: userdata) -- Line: 10463, Name: _AddFX
            p1707:_RemoveFX(p1708, p1709);
            p1709.Material = Enum.Material.Neon;
            local Color3_new_ret = Color3.new(0.14902, 0.898039, 0.898039);
            p1709.Color = p1709.Color:Lerp(Color3_new_ret, 0.9);
            p1709:AddTag("AffluentVisual");

            if p1709 then
                for _, child in game.ServerStorage.Mutation_FX.Affluent:GetChildren() do
                    local v1710 = child:Clone();
                    v1710.Parent = p1709;
                    v1710.Enabled = true;
                    v1710:AddTag("Cleanup_Affluent");
                end;
            end;
        end,

        _RemoveFX = function(p1711: any, p1712: userdata, p1713: userdata) -- Line: 10483, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1715(p1714) -- Line: 10484
                for _, descendant in p1714:GetDescendants() do
                    if descendant:HasTag("Cleanup_Affluent") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1713 then
                v1715(p1713);
            end;

            if p1712 then
                v1715(p1712);
            end;

            if p1713:HasTag("AffluentVisual") then
                p1713:RemoveTag("AffluentVisual");
                p1713.Color = u3[p1713] or p1713.Color;
                u3[p1713] = nil;
                p1713.Material = u6[p1713] or p1713.Material;
                u6[p1713] = nil;
                p1713.Reflectance = 0;
            end;
        end
    },
    Fractured = {
        Id = "FD",
        Name = "Fractured",
        ValueMulti = 92,
        Color = Color3.fromRGB(255, 3, 3),

        _AddFX = function(p1716: any, p1717: userdata, p1718: userdata) -- Line: 10510, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1716:_RemoveFX(p1717, p1718);

            for _, descendant in p1717:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency ~= 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.CrackedLava;
                    local Color3_new_ret = Color3.new(0.937255, 0.0352941, 0.0352941);
                    descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.9);
                    descendant:AddTag("FracturedVisual");
                end;
            end;

            if p1718 then
                for _, child in game.ServerStorage.Mutation_FX.Fractured:GetChildren() do
                    local v1719 = child:Clone();
                    v1719.Parent = p1718;
                    v1719.Enabled = true;
                    v1719:AddTag("Cleanup_Fractured");
                end;
            end;
        end,

        _RemoveFX = function(p1720: any, p1721: userdata, p1722: userdata) -- Line: 10545, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1724(p1723) -- Line: 10546
                for _, descendant in p1723:GetDescendants() do
                    if descendant:HasTag("Cleanup_Fractured") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1722 then
                v1724(p1722);
            end;

            if p1721 then
                v1724(p1721);
            end;

            if p1722:HasTag("FracturedVisual") then
                p1722:RemoveTag("FracturedVisual");
                p1722.Color = u3[p1722] or p1722.Color;
                u3[p1722] = nil;
                p1722.Material = u6[p1722] or p1722.Material;
                u6[p1722] = nil;
                p1722.Reflectance = 0;
            end;
        end
    },
    Coin = {
        Id = "CN",
        Name = "Coin",
        ValueMulti = 3,
        Color = Color3.fromRGB(255, 216, 0),

        _AddFX = function(p1725: any, p1726: userdata, p1727: userdata) -- Line: 10572, Name: _AddFX
            -- upvalues: u6 (copy)
            p1725:_RemoveFX(p1726, p1727);

            if p1727 then
                for _, child in game.ServerStorage.Mutation_FX.Coin:GetChildren() do
                    local v1728 = child:Clone();
                    v1728.Parent = p1727;
                    v1728.Enabled = true;
                    v1728:AddTag("Cleanup_Coin");
                end;
            end;

            for _, descendant in p1726:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.SmoothPlastic;
                    descendant:AddTag("CoinVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1729: any, p1730: userdata, p1731: userdata) -- Line: 10600, Name: _RemoveFX
            -- upvalues: u6 (copy)
            local function v1733(p1732) -- Line: 10601
                for _, descendant in p1732:GetDescendants() do
                    if descendant:HasTag("Cleanup_Coin") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1731 then
                v1733(p1731);
            end;

            if p1730 then
                v1733(p1730);
            end;

            for _, descendant in p1730:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CoinVisual") then
                    descendant:RemoveTag("CoinVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Arctic = {
        Id = "AT",
        Name = "Arctic",
        ValueMulti = 12,
        Color = Color3.fromRGB(255, 255, 255),

        _AddFX = function(p1734: any, p1735: userdata, p1736: userdata) -- Line: 10637, Name: _AddFX
            p1734:_RemoveFX(p1735, p1736);

            if p1736 then
                for _, child in game.ServerStorage.Mutation_FX.Arctic:GetChildren() do
                    local v1737 = child:Clone();
                    v1737.Parent = p1736;
                    v1737:AddTag("Cleanup_Arctic");

                    if v1737:IsA("ParticleEmitter") then
                        v1737.Enabled = true;
                    end;
                end;
            end;

            for _, descendant in p1735:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(255, 255, 255), 0.5);
                    descendant:AddTag("ArcticVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1738: any, p1739: userdata, p1740: userdata) -- Line: 10661, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1742(p1741) -- Line: 10662
                for _, descendant in p1741:GetDescendants() do
                    if descendant:HasTag("Arctic") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1740 then
                v1742(p1740);
            end;

            for _, descendant in p1739:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ArcticVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("ArcticVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Ornamented = {
        Id = "Orn",
        Name = "Ornamented",
        ValueMulti = 10,
        Color = Color3.fromRGB(34, 102, 50),

        _AddFX = function(p1743: any, p1744: userdata, p1745: userdata) -- Line: 10690, Name: _AddFX
            -- upvalues: PlaceOrnamentOnPart (copy), u3 (copy)
            p1743:_RemoveFX(p1744, p1745);
            local v1746 = false;

            for i, descendant in p1744:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant.Transparency ~= 1 then
                    if i % 5 == 0 or v1746 == false then
                        v1746 = true;
                        local v1747 = PlaceOrnamentOnPart(descendant, p1744, game.ServerStorage.Mutation_FX.Ornamented.OrnamentTemplate, 0.15, 0);

                        if v1747 then
                            v1747.PrimaryPart.Sparkles.Rate = math.random(2, 5) / 10;
                            v1747.PrimaryPart.Sparkles.Enabled = true;
                        end;
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        local Color3_new_ret = Color3.new(0.121569, 0.364706, 0.176471);
                        descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.8);
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1748: any, p1749: userdata, p1750: userdata) -- Line: 10725, Name: _RemoveFX
            -- upvalues: u3 (copy)
            if p1750 then
                for _, child in p1750:GetChildren() do
                    if child:HasTag("Cleanup_Ornamented") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1749:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if descendant:HasTag("OrnamentedVisual") then
                        descendant:RemoveTag("OrnamentedVisual");
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant.Reflectance = 0;
                    elseif descendant:HasTag("OrnamentedDecal") then
                        descendant:Destroy();
                    end;
                end;
            end;
        end
    },
    Glacial = {
        Id = "Gla",
        Name = "Glacial",
        ValueMulti = 25,
        Color = Color3.fromRGB(134, 255, 251),

        _AddFX = function(p1751: any, p1752: userdata, p1753: userdata) -- Line: 10754, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1751:_RemoveFX(p1752, p1753);

            if p1753 then
                for _, child in game.ServerStorage.Mutation_FX.Glacial:GetChildren() do
                    local v1754 = child:Clone();
                    v1754.Parent = p1753;
                    v1754.Enabled = true;
                    v1754:AddTag("Cleanup_Glacial");
                end;
            end;

            for i, descendant in p1752:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v1755 = game.ServerStorage.Mutation_FX.Glacial.Bits:Clone();
                        v1755.Parent = descendant;
                        v1755.Enabled = true;
                        v1755.Rate = math.random(8, 25) / 20;
                        v1755:AddTag("Cleanup_Glacial");
                        local v1756 = game.ServerStorage.Mutation_FX.Glacial.Frost:Clone();
                        v1756.Parent = descendant;
                        v1756.Enabled = true;
                        v1756.Rate = math.random(8, 25) / 20;
                        v1756:AddTag("Cleanup_Glacial");
                        local v1757 = game.ServerStorage.Mutation_FX.Glacial.Snowflake:Clone();
                        v1757.Parent = descendant;
                        v1757.Enabled = true;
                        v1757.Rate = math.random(8, 25) / 20;
                        v1757:AddTag("Cleanup_Glacial");
                    end;

                    if not descendant:HasTag("Effect") then
                        if descendant.Transparency ~= 1 then
                            u3[descendant] = u3[descendant] or descendant.Color;
                            u6[descendant] = u6[descendant] or descendant.Material;
                            descendant.Material = "Ice";
                            local Color3_new_ret = Color3.new(0.454902, 1, 1);
                            descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.65);
                        end;

                        u6[descendant] = u6[descendant] or descendant.Material;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1758: any, p1759: userdata, p1760: userdata) -- Line: 10804, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p1760 then
                for _, child in p1760:GetChildren() do
                    if child:HasTag("Cleanup_Glacial") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1759:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if descendant:HasTag("GlacialVisual") then
                        descendant:RemoveTag("GlacialVisual");
                        descendant.Color = u3[descendant] or descendant.Color;
                        descendant.Material = u6[descendant] or descendant.Material;
                        u3[descendant] = nil;
                        descendant.Reflectance = 0;
                    elseif descendant:HasTag("GlacialDecal") then
                        descendant:Destroy();
                    end;
                end;
            end;
        end
    },
    Snowtouched = {
        Id = "Snot",
        Name = "Snowtouched",
        ValueMulti = 5,
        Color = Color3.fromRGB(209, 209, 209),

        _AddFX = function(p1761: any, p1762: userdata, p1763: userdata) -- Line: 10834, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1761:_RemoveFX(p1762, p1763);

            if p1763 then
                for _, child in game.ServerStorage.Mutation_FX.Snowtouched:GetChildren() do
                    local v1764 = child:Clone();
                    v1764.Parent = p1763;
                    v1764.Enabled = true;
                    v1764:AddTag("Cleanup_Snowtouched");
                end;
            end;

            local v1765 = false;

            for i, descendant in p1762:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    if descendant.Transparency ~= 1 then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;

                        if i % 5 == 0 or v1765 == false then
                            descendant.Material = "Ice";
                            local Color3_new_ret = Color3.new(0.466667, 0.886275, 1);
                            descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.65);
                            local v1766 = game.ServerStorage.Mutation_FX.Snowtouched.Frost:Clone();
                            v1766.Parent = descendant;
                            v1766.Rate = math.random(2, 4) / 10;
                            v1766.Enabled = true;
                            v1766:AddTag("Cleanup_Snowtouched");
                            v1765 = true;
                        else
                            local Color3_new_ret = Color3.new(1, 1, 1);
                            descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.65);
                            local v1767 = game.ServerStorage.Mutation_FX.Snowtouched.Snow:Clone();
                            v1767.Parent = descendant;
                            v1767.Rate = math.random(4, 12) / 10;
                            v1767.Enabled = true;
                            v1767:AddTag("Cleanup_Snowtouched");
                        end;
                    end;

                    u6[descendant] = u6[descendant] or descendant.Material;
                end;
            end;
        end,

        _RemoveFX = function(p1768: any, p1769: userdata, p1770: userdata) -- Line: 10888, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p1770 then
                for _, child in p1770:GetChildren() do
                    if child:HasTag("Cleanup_Snowtouched") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1769:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if descendant:HasTag("SnowtouchedVisual") then
                        descendant:RemoveTag("SnowtouchedVisual");
                        descendant.Color = u3[descendant] or descendant.Color;
                        descendant.Material = u6[descendant] or descendant.Material;
                        u3[descendant] = nil;
                        descendant.Reflectance = 0;
                    elseif descendant:HasTag("SnowtouchedDecal") then
                        descendant:Destroy();
                    end;
                end;
            end;
        end
    },
    Snowy = {
        Id = "SN",
        Name = "Snowy",
        ValueMulti = 2,
        Color = Color3.fromRGB(157, 217, 255),

        _AddFX = function(p1771: any, p1772: userdata, p1773: userdata) -- Line: 10918, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1771:_RemoveFX(p1772, p1773);

            if p1773 then
                for _, child in game.ServerStorage.Mutation_FX.Snowy:GetChildren() do
                    local v1774 = child:Clone();
                    v1774.Parent = p1773;
                    v1774.Enabled = true;
                    v1774:AddTag("Cleanup_Snowy");
                end;
            end;

            for _, descendant in p1772:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = Color3.fromRGB(143, 155, 158);
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("SnowyVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1775: any, p1776: userdata, p1777: userdata) -- Line: 10948, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1779(p1778) -- Line: 10949
                for _, descendant in p1778:GetDescendants() do
                    if descendant:HasTag("Cleanup_Snowy") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1777 then
                v1779(p1777);
            end;

            if p1776 then
                v1779(p1776);
            end;

            for _, descendant in p1776:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("SnowyVisual") then
                    descendant:RemoveTag("SnowyVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Eggnog = {
        Id = "EG",
        Name = "Eggnog",
        ValueMulti = 8,
        Color = Color3.fromRGB(255, 188, 144),

        _AddFX = function(p1780: any, p1781: userdata, p1782: userdata) -- Line: 10986, Name: _AddFX
            p1780:_RemoveFX(p1781, p1782);

            if p1782 then
                for _, child in game.ServerStorage.Mutation_FX.Eggnog:GetChildren() do
                    local v1783 = child:Clone();
                    v1783.Parent = p1782;
                    v1783.Enabled = true;
                    v1783:AddTag("Cleanup_Eggnog");
                    v1783:AddTag("Effect");
                end;
            end;

            for _, descendant in p1781:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant:AddTag("EggnogVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1784: any, p1785: userdata, p1786: userdata) -- Line: 11006, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p1786 then
                for _, child in p1786:GetChildren() do
                    if child:HasTag("Cleanup_Eggnog") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1785:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("EggnogVisual") then
                    descendant:RemoveTag("EggnogVisual");
                    local v1787 = u6[descendant];

                    if v1787 then
                        descendant.Material = v1787;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Blizzard = {
        Id = "BD",
        Name = "Blizzard",
        ValueMulti = 40,
        Color = Color3.fromRGB(0, 170, 255),

        _AddFX = function(p1788: any, p1789: userdata, p1790: userdata) -- Line: 11036, Name: _AddFX
            -- upvalues: AddBoundingFX (copy), u6 (copy), u7 (copy), u3 (copy)
            p1788:_RemoveFX(p1789, p1790);
            AddBoundingFX(p1788, p1789, p1790, 0.4);

            if p1790 then
                for _, child in game.ServerStorage.Mutation_FX.Blizzard:GetChildren() do
                    local v1791 = child:Clone();
                    v1791.Parent = p1790;
                    v1791:AddTag("Cleanup_Blizzard");

                    if v1791:IsA("ParticleEmitter") then
                        v1791.Enabled = true;
                    end;
                end;
            end;

            for _, child in p1789:GetChildren() do
                if child:IsA("BasePart") or child:IsA("UnionOperation") then
                    child.Reflectance = 0.35;
                end;
            end;

            for _, descendant in p1789:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Plastic;
                    u7[descendant] = u7[descendant] or descendant.MaterialVariant;
                    descendant.MaterialVariant = "Studs 2x2 Plastic Metal";
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(0, 255, 255), 0.5);
                    descendant:AddTag("BlizzardVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1792: any, p1793: userdata, p1794: userdata) -- Line: 11074, Name: _RemoveFX
            -- upvalues: RemoveBoundingFX (copy), u3 (copy), u7 (copy), u6 (copy)
            RemoveBoundingFX(p1792, p1793, p1794);

            local function v1796(p1795) -- Line: 11079
                for _, descendant in p1795:GetDescendants() do
                    if descendant:HasTag("Cleanup_Blizzard") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1794 then
                v1796(p1794);
            end;

            if p1793 then
                v1796(p1793);
            end;

            for _, descendant in p1793:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    descendant.Reflectance = 0;

                    if descendant:HasTag("BlizzardVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant:RemoveTag("BlizzardVisual");
                        descendant.MaterialVariant = u7[descendant] or descendant.MaterialVariant;
                        u7[descendant] = nil;

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;
        end
    },
    Opulent = {
        Id = "OP",
        Name = "Opulent",
        ValueMulti = 5,
        Color = Color3.fromRGB(255, 67, 255),

        _AddFX = function(p1797: any, p1798: userdata, p1799: userdata) -- Line: 11117, Name: _AddFX
            -- upvalues: u3 (copy)
            p1797:_RemoveFX(p1798, p1799);

            if p1799 then
                for _, child in game.ServerStorage.Mutation_FX.Opulent:GetChildren() do
                    local v1800 = child:Clone();
                    v1800.Parent = p1799;
                    v1800:AddTag("Cleanup_Opulent");
                end;
            end;

            for _, descendant in p1798:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or descendant.Transparency and descendant.Transparency == 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(Color3.fromRGB(247, 15, 255), 0.5);
                    descendant:AddTag("OpulentVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1801: any, p1802: userdata, p1803: userdata) -- Line: 11147, Name: _RemoveFX
            -- upvalues: u3 (copy), u7 (copy), u6 (copy)
            if p1803 then
                for _, child in p1803:GetChildren() do
                    if child:HasTag("Cleanup_Opulent") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1802:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    descendant.Reflectance = 0;

                    if descendant:HasTag("OpulentVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant:RemoveTag("OpulentVisual");
                        descendant.MaterialVariant = u7[descendant] or descendant.MaterialVariant;
                        u7[descendant] = nil;

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;
        end
    },
    Gale = {
        Id = "GA",
        Name = "Gale",
        ValueMulti = 25,
        Color = Color3.fromRGB(138, 149, 167),

        _AddFX = function(p1804: any, p1805: userdata, p1806: userdata) -- Line: 11184, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1804:_RemoveFX(p1805, p1806);

            if p1806 then
                for _, child in game.ServerStorage.Mutation_FX.Gale:GetChildren() do
                    local v1807 = child:Clone();
                    v1807.Parent = p1806;
                    v1807.Enabled = true;
                    v1807:AddTag("Cleanup_Gale");
                end;
            end;

            for i, descendant in p1805:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v1808 = game.ServerStorage.Mutation_FX.Gale.Bits:Clone();
                        v1808.Parent = descendant;
                        v1808.Enabled = true;
                        v1808.Rate = math.random(8, 25) / 20;
                        v1808:AddTag("Cleanup_Gale");
                        local v1809 = game.ServerStorage.Mutation_FX.Gale.Frost:Clone();
                        v1809.Parent = descendant;
                        v1809.Enabled = true;
                        v1809.Rate = math.random(8, 25) / 20;
                        v1809:AddTag("Cleanup_Gale");
                        local v1810 = game.ServerStorage.Mutation_FX.Gale.Snowflake:Clone();
                        v1810.Parent = descendant;
                        v1810.Enabled = true;
                        v1810.Rate = math.random(8, 25) / 20;
                        v1810:AddTag("Cleanup_Gale");
                    end;

                    if not descendant:HasTag("Effect") then
                        if descendant.Transparency ~= 1 then
                            u3[descendant] = u3[descendant] or descendant.Color;
                            u6[descendant] = u6[descendant] or descendant.Material;
                            descendant.Material = "Ice";
                            local Color3_new_ret = Color3.new(0.521569, 0.568627, 0.603922);
                            descendant.Color = descendant.Color:Lerp(Color3_new_ret, 0.65);
                        end;

                        u6[descendant] = u6[descendant] or descendant.Material;
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1811: any, p1812: userdata, p1813: userdata) -- Line: 11234, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p1813 then
                for _, child in p1813:GetChildren() do
                    if child:HasTag("Cleanup_Glacial") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1812:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if descendant:HasTag("GlacialVisual") then
                        descendant:RemoveTag("GlacialVisual");
                        descendant.Color = u3[descendant] or descendant.Color;
                        descendant.Material = u6[descendant] or descendant.Material;
                        u3[descendant] = nil;
                        descendant.Reflectance = 0;
                    elseif descendant:HasTag("GlacialDecal") then
                        descendant:Destroy();
                    end;
                end;
            end;
        end
    },
    Sleepy = {
        Id = "SY",
        Name = "Sleepy",
        ValueMulti = 3,
        Color = Color3.fromRGB(139, 139, 139),

        _AddFX = function(p1814: any, p1815: userdata, p1816: userdata) -- Line: 11264, Name: _AddFX
            p1814:_RemoveFX(p1815, p1816);

            if p1816 then
                for _, child in game.ServerStorage.Mutation_FX.Sleepy:GetChildren() do
                    local v1817 = child:Clone();
                    v1817.Parent = p1816;
                    v1817.Enabled = true;
                    v1817:AddTag("Cleanup_Sleepy");
                end;
            end;
        end,

        _RemoveFX = function(p1818: any, p1819: userdata, p1820: userdata) -- Line: 11278, Name: _RemoveFX
            if p1820 then
                for _, child in p1820:GetChildren() do
                    if child:HasTag("Cleanup_Sleepy") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Firework = {
        Id = "FW",
        Name = "Firework",
        ValueMulti = 26,
        Color = Color3.fromRGB(255, 85, 0),

        _AddFX = function(p1821: any, p1822: userdata, p1823: userdata) -- Line: 11294, Name: _AddFX
            p1821:_RemoveFX(p1822, p1823);

            if p1823 then
                for _, child in game.ServerStorage.Mutation_FX.Firework:GetChildren() do
                    local v1824 = child:Clone();
                    v1824.Parent = p1823;
                    v1824.Enabled = true;
                    v1824:AddTag("Cleanup_Firework");
                end;
            end;
        end,

        _RemoveFX = function(p1825: any, p1826: userdata, p1827: userdata) -- Line: 11308, Name: _RemoveFX
            if p1827 then
                for _, child in p1827:GetChildren() do
                    if child:HasTag("Cleanup_Firework") then
                        child:Destroy();
                    end;
                end;
            end;
        end
    },
    Fiery = {
        Id = "fry",
        Name = "Fiery",
        ValueMulti = 2,
        Color = Color3.fromRGB(255, 115, 0),

        _AddFX = function(p1828: any, p1829: userdata, p1830: userdata) -- Line: 11324, Name: _AddFX
            -- upvalues: u3 (copy)
            p1828:_RemoveFX(p1829, p1830);
            local Children = game.ServerStorage.Mutation_FX.Fiery:GetChildren();
            local v1831 = { "Neon orange", "Br. yellowish orange", "Bright orange", "Bright red", "Bright yellow" };

            if p1830 then
                for _, v in Children do
                    local v1832 = v:Clone();
                    v1832.Parent = p1830;
                    v1832.Enabled = true;
                    v1832:AddTag("Cleanup_Fiery");
                end;
            end;

            local v1833 = 0;

            for _, descendant in p1829:GetDescendants() do
                if descendant:IsA("BasePart") then
                    v1833 = v1833 + 1;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(BrickColor.new(v1831[math.random(1, #v1831)]).Color, 0.75);
                    descendant:AddTag("FieryVisual");

                    if descendant ~= p1830 and (v1833 % 2 == 0 and #Children > 0) then
                        local v1834 = Children[math.random(1, #Children)]:Clone();
                        v1834.Parent = descendant;
                        v1834.Enabled = true;
                        v1834:AddTag("Cleanup_Fiery");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1835: any, p1836: userdata, p1837: userdata) -- Line: 11368, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1839(p1838) -- Line: 11369
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p1838:GetDescendants() do
                    if descendant:HasTag("Cleanup_Fiery") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("FieryVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant:RemoveTag("FieryVisual");

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;

            if p1837 then
                v1839(p1837);
            end;

            if p1836 then
                v1839(p1836);
            end;
        end
    },
    Fierywork = {
        Id = "fw",
        Name = "Fierywork",
        ValueMulti = 30,
        Color = Color3.fromRGB(255, 234, 0),

        _AddFX = function(p1840: any, p1841: userdata, p1842: userdata) -- Line: 11398, Name: _AddFX
            -- upvalues: u6 (copy), u3 (copy)
            p1840:_RemoveFX(p1841, p1842);
            local Children = game.ServerStorage.Mutation_FX.Fierywork:GetChildren();
            local v1843 = { "Neon orange", "Br. yellowish orange", "Bright orange", "Bright red", "Bright yellow" };

            if p1842 then
                for _, v in Children do
                    local v1844 = v:Clone();
                    v1844.Parent = p1842;
                    v1844.Enabled = true;
                    v1844:AddTag("Cleanup_Fierywork");
                end;
            end;

            local v1845 = 0;

            for _, descendant in p1841:GetDescendants() do
                if descendant:IsA("BasePart") then
                    v1845 = v1845 + 1;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = descendant.Color:Lerp(BrickColor.new(v1843[math.random(1, #v1843)]).Color, 0.5);
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("FieryworkVisual");

                    if descendant ~= p1842 and (v1845 % 2 == 0 and #Children > 0) then
                        local v1846 = Children[math.random(1, #Children)]:Clone();
                        v1846.Parent = descendant;
                        v1846.Enabled = true;
                        v1846:AddTag("Cleanup_Fierywork");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1847: any, p1848: userdata, p1849: userdata) -- Line: 11445, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1851(p1850) -- Line: 11446
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p1850:GetDescendants() do
                    if descendant:HasTag("Cleanup_Fierywork") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("FieryworkVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant:RemoveTag("FieryworkVisual");

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;

            if p1849 then
                v1851(p1849);
            end;

            if p1848 then
                v1851(p1848);
            end;
        end
    },
    Whalebound = {
        Id = "wh",
        Name = "Whalebound",
        ValueMulti = 50,
        Color = Color3.fromRGB(41, 73, 218),

        _AddFX = function(p1852: any, p1853: userdata, p1854: userdata) -- Line: 11475, Name: _AddFX
            p1852:_RemoveFX(p1853, p1854);

            if p1854 then
                for _, child in game.ServerStorage.Mutation_FX.Whalebound:GetChildren() do
                    local v1855 = child:Clone();
                    v1855.Parent = p1854;
                    v1855.Enabled = true;
                    v1855:AddTag("Cleanup_Whalebound");
                end;
            end;
        end,

        _RemoveFX = function(p1856: any, p1857: userdata, p1858: userdata) -- Line: 11490, Name: _RemoveFX
            local function v1860(p1859) -- Line: 11492
                for _, descendant in p1859:GetDescendants() do
                    if descendant:HasTag("Cleanup_Whalebound") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1858 then
                v1860(p1858);
            end;

            if p1857 then
                v1860(p1857);
            end;
        end
    },
    Festive = {
        Id = "FE",
        Name = "Festive",
        ValueMulti = 24,
        Color = Color3.fromRGB(34, 102, 50),

        _AddFX = function(p1861: any, p1862: userdata, p1863: userdata) -- Line: 11509, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1861:_RemoveFX(p1862, p1863);

            if p1863 then
                for _, child in game.ServerStorage.Mutation_FX.Festive:GetChildren() do
                    local v1864 = child:Clone();
                    v1864.Parent = p1863;

                    if v1864:IsA("ParticleEmitter") then
                        v1864.Enabled = true;
                    end;

                    v1864:AddTag("Cleanup_Festive");
                    v1864:AddTag("Effect");
                end;
            end;

            local v1865 = {};

            for _, descendant in p1862:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    table.insert(v1865, descendant);
                end;
            end;

            if #v1865 == 0 then
                return;
            end;

            table.sort(v1865, function(p1866, p1867) -- Line: 11536
                return p1866.Position.Y < p1867.Position.Y;
            end);
            local v1868 = #v1865;
            local math_floor_ret = math.floor(v1868 * 0.33);
            local math_floor_ret2 = math.floor(v1868 * 0.66);
            local Color3_fromRGB_ret = Color3.fromRGB(10, 60, 10);
            local Color3_fromRGB_ret2 = Color3.fromRGB(20, 120, 20);
            local Color3_fromRGB_ret3 = Color3.fromRGB(40, 180, 40);

            for i, v in v1865 do
                if v:IsA("UnionOperation") then
                    v.UsePartColor = true;
                end;

                u3[v] = u3[v] or v.Color;
                u6[v] = u6[v] or v.Material;
                v.Material = Enum.Material.Metal;
                v.Reflectance = 0.1;

                if i <= math_floor_ret then
                    v.Color = Color3_fromRGB_ret;
                elseif i <= math_floor_ret2 then
                    v.Color = Color3_fromRGB_ret2;
                else
                    v.Color = Color3_fromRGB_ret3;
                end;

                v:AddTag("FestiveVisual");
            end;
        end,

        _RemoveFX = function(p1869: any, p1870: userdata, p1871: userdata) -- Line: 11571, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1873(p1872) -- Line: 11572
                for _, descendant in p1872:GetDescendants() do
                    if descendant:HasTag("Cleanup_Festive") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1871 then
                v1873(p1871);
            end;

            if p1870 then
                v1873(p1870);
            end;

            for _, descendant in p1870:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("FestiveVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                    descendant:RemoveTag("FestiveVisual");
                end;
            end;
        end
    },
    Clockwork = {
        Id = "cw",
        Name = "Clockwork",
        ValueMulti = 15,
        Color = Color3.fromRGB(170, 128, 0),

        _AddFX = function(p1874: any, p1875: userdata, p1876: userdata) -- Line: 11608, Name: _AddFX
            p1874:_RemoveFX(p1875, p1876);

            if p1876 then
                for _, child in game.ServerStorage.Mutation_FX.Clockwork:GetChildren() do
                    local v1877 = child:Clone();
                    v1877.Parent = p1876;
                    v1877.Enabled = true;
                    v1877:AddTag("Cleanup_Clockwork");
                    v1877:AddTag("Effect");
                end;
            end;

            for _, descendant in p1875:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    descendant:AddTag("ClockworkVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1878: any, p1879: userdata, p1880: userdata) -- Line: 11628, Name: _RemoveFX
            -- upvalues: u6 (copy)
            if p1880 then
                for _, child in p1880:GetChildren() do
                    if child:HasTag("Cleanup_Clockwork") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1879:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ClockworkVisual") then
                    descendant:RemoveTag("ClockworkVisual");
                    local v1881 = u6[descendant];

                    if v1881 then
                        descendant.Material = v1881;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Whimsical = {
        Id = "WL",
        Name = "Whimsical",
        ValueMulti = 6,
        Color = Color3.fromRGB(255, 255, 0),

        _AddFX = function(p1882: any, p1883: userdata, p1884: userdata) -- Line: 11657, Name: _AddFX
            p1882:_RemoveFX(p1883, p1884);

            if p1884 then
                for _, child in game.ServerStorage.Mutation_FX.Whimsical:GetChildren() do
                    local v1885 = child:Clone();
                    v1885.Parent = p1884;
                    v1885.Enabled = true;
                    v1885:AddTag("Cleanup_Whimsicalt");
                end;
            end;
        end,

        _RemoveFX = function(p1886: any, p1887: userdata, p1888: userdata) -- Line: 11671, Name: _RemoveFX
            local function v1890(p1889) -- Line: 11673
                for _, descendant in p1889:GetDescendants() do
                    if descendant:HasTag("Cleanup_Whimsical") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1888 then
                v1890(p1888);
            end;

            if p1887 then
                v1890(p1887);
            end;
        end
    },
    Ash = {
        Id = "AH",
        Name = "Ash",
        ValueMulti = 4,
        Color = Color3.fromRGB(40, 40, 40),

        _AddFX = function(p1891: any, p1892: userdata, p1893: userdata) -- Line: 11690, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1891:_RemoveFX(p1892, p1893);

            if p1893 then
                for _, child in game.ServerStorage.Mutation_FX.Ash:GetChildren() do
                    local v1894 = child:Clone();
                    v1894.Parent = p1893;
                    v1894.Enabled = true;
                    v1894:AddTag("Cleanup_Ash");
                end;
            end;

            for _, descendant in p1892:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(40, 40, 40);
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Material = Enum.Material.Slate;
                    descendant.Reflectance = 0.05;
                    descendant:AddTag("AshVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1895: any, p1896: userdata, p1897: userdata) -- Line: 11716, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1899(p1898) -- Line: 11717
                for _, descendant in p1898:GetDescendants() do
                    if descendant:HasTag("Cleanup_Ash") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1897 then
                v1899(p1897);
            end;

            if p1896 then
                v1899(p1896);
            end;

            for _, descendant in p1896:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("AshVisual") then
                    descendant.Reflectance = 0;
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("AshVisual");

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Haze = {
        Id = "HZ",
        Name = "Haze",
        ValueMulti = 6,
        Color = Color3.fromRGB(70, 70, 70),

        _AddFX = function(p1900: any, p1901: userdata, p1902: userdata) -- Line: 11750, Name: _AddFX
            -- upvalues: u3 (copy)
            p1900:_RemoveFX(p1901, p1902);

            if p1902 then
                for _, child in game.ServerStorage.Mutation_FX.Haze:GetChildren() do
                    local v1903 = child:Clone();
                    v1903.Parent = p1902;
                    v1903.Enabled = true;
                    v1903:AddTag("Cleanup_Haze");
                    v1903:AddTag("Effect");
                end;
            end;

            for _, descendant in p1901:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(70, 70, 70);
                    descendant:AddTag("HazeVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1904: any, p1905: userdata, p1906: userdata) -- Line: 11774, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p1906 then
                for _, child in p1906:GetChildren() do
                    if child:HasTag("Cleanup_Haze") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p1905:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("HazeVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("HazeVisual");
                    local v1907 = u6[descendant];

                    if v1907 then
                        descendant.Material = v1907;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Smoldering = {
        Id = "SM",
        Name = "Smoldering",
        ValueMulti = 66,
        Color = Color3.fromRGB(170, 0, 0),

        _AddFX = function(p1908: any, p1909: userdata, p1910: userdata) -- Line: 11807, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1908:_RemoveFX(p1909, p1910);
            local Children = game.ServerStorage.Mutation_FX.Smoldering:GetChildren();
            local v1911 = {
                Color3.fromRGB(255, 255, 0),
                Color3.fromRGB(255, 170, 0),
                Color3.fromRGB(255, 85, 0),
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(170, 0, 0)
            };

            if p1910 then
                for _, v in Children do
                    local v1912 = v:Clone();
                    v1912.Parent = p1910;
                    v1912.Enabled = true;
                    v1912:AddTag("Cleanup_Smoldering");
                end;
            end;

            local v1913 = 0;

            for _, descendant in p1909:GetDescendants() do
                if descendant:IsA("BasePart") then
                    v1913 = v1913 + 1;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = v1911[math.random(1, #v1911)];
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("SmolderingVisual");

                    if v1913 % 3 == 0 then
                        local Attachment = Instance.new("Attachment", descendant);
                        local Attachment2 = Instance.new("Attachment", descendant);
                        Attachment.Position = Vector3.new(0, 0.15, 0);
                        Attachment2.Position = Vector3.new(0, -0.15, 0);
                        Attachment:AddTag("Cleanup_Smoldering");
                        Attachment2:AddTag("Cleanup_Smoldering");
                        local Trail = Instance.new("Trail");
                        Trail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0));
                        Trail.LightInfluence = 0;
                        Trail.Brightness = 3;
                        Trail.Attachment0 = Attachment;
                        Trail.Attachment1 = Attachment2;
                        Trail.Lifetime = 0.3;
                        Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
                        Trail.WidthScale = NumberSequence.new(2);
                        Trail.Parent = descendant;
                        Trail:AddTag("Cleanup_Smoldering");
                    end;

                    if descendant ~= p1910 and #Children > 0 then
                        local v1914 = Children[math.random(1, #Children)]:Clone();
                        v1914.Parent = descendant;
                        v1914.Enabled = true;
                        v1914:AddTag("Cleanup_Smoldering");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1915: any, p1916: userdata, p1917: userdata) -- Line: 11880, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v1919(p1918) -- Line: 11881
                -- upvalues: u3 (ref), u6 (ref)
                for _, descendant in p1918:GetDescendants() do
                    if descendant:HasTag("Cleanup_Smoldering") then
                        descendant:Destroy();
                    end;

                    if descendant:HasTag("SmolderingVisual") then
                        descendant.Color = u3[descendant] or descendant.Color;
                        u3[descendant] = nil;
                        descendant:RemoveTag("SmolderingVisual");

                        if u6[descendant] then
                            descendant.Material = u6[descendant];
                            u6[descendant] = nil;
                        end;
                    end;
                end;
            end;

            if p1917 then
                v1919(p1917);
            end;

            if p1916 then
                v1919(p1916);
            end;
        end
    },
    Gummy = {
        Id = "GU",
        Name = "Gummy",
        ValueMulti = 4,
        Color = Color3.fromRGB(255, 80, 80),

        _AddFX = function(p1920: any, p1921: userdata, p1922: userdata) -- Line: 11910, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1920:_RemoveFX(p1921, p1922);
            local v1923 = p1921:FindFirstChild("Item_Seed") and (p1921.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v1923);
            local v1924 = {
                Color3.fromRGB(80, 170, 255),
                Color3.fromRGB(80, 255, 120),
                Color3.fromRGB(255, 170, 80),
                Color3.fromRGB(190, 100, 255),
                Color3.fromRGB(255, 80, 80),
                Color3.fromRGB(255, 230, 90)
            };
            local v1925 = v1924[Random_new_ret:NextInteger(1, #v1924)];
            OriginalTransparency = OriginalTransparency or {};

            for _, descendant in p1921:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    OriginalTransparency[descendant] = OriginalTransparency[descendant] or descendant.Transparency;
                    descendant.Color = v1925;
                    descendant.Material = Enum.Material.Glass;
                    descendant.Transparency = 0.35;
                    descendant:AddTag("GummyVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1926: any, p1927: userdata, p1928: userdata) -- Line: 11945, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            OriginalTransparency = OriginalTransparency or {};

            for _, descendant in p1927:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("GummyVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Transparency = OriginalTransparency[descendant] or 0;
                    OriginalTransparency[descendant] = nil;
                    descendant:RemoveTag("GummyVisual");
                end;
            end;
        end
    },
    Floral = {
        Id = "FRL",
        Name = "Floral",
        ValueMulti = 25,
        Color = Color3.fromRGB(255, 182, 193),

        _AddFX = function(p1929: any, p1930: userdata, p1931: userdata) -- Line: 11975, Name: _AddFX
            -- upvalues: u3 (copy)
            p1929:_RemoveFX(p1930, p1931);
            local v1932 = p1930:FindFirstChild("Item_Seed") and (p1930.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v1932);
            local Children = game.ServerStorage.Mutation_FX.Floral:GetChildren();
            local v1933 = {
                Color3.fromRGB(255, 214, 224),
                Color3.fromRGB(255, 196, 214),
                Color3.fromRGB(255, 182, 193),
                Color3.fromRGB(245, 168, 200),
                Color3.fromRGB(232, 162, 196),
                Color3.fromRGB(220, 150, 190)
            };

            if p1931 then
                for _, v in Children do
                    local v1934 = v:Clone();
                    v1934.Parent = p1931;

                    if v1934:IsA("ParticleEmitter") then
                        v1934.Enabled = true;
                    end;

                    v1934:AddTag("Cleanup_Floral");
                end;
            end;

            for _, descendant in p1930:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not (descendant:HasTag("Effect") or (descendant.Transparency >= 1 or Random_new_ret:NextNumber() > 1)) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = v1933[Random_new_ret:NextInteger(1, #v1933)];
                    descendant:AddTag("FloralVisual");

                    if descendant ~= p1931 and #Children > 0 then
                        local v1935 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                        v1935.Parent = descendant;

                        if v1935:IsA("ParticleEmitter") then
                            v1935.Enabled = true;
                        end;

                        v1935:AddTag("Cleanup_Floral");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1936: any, p1937: userdata, p1938: userdata) -- Line: 12028, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v1940(p1939) -- Line: 12029
                for _, descendant in p1939:GetDescendants() do
                    if descendant:HasTag("Cleanup_Floral") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1938 then
                v1940(p1938);
            end;

            if p1937 then
                v1940(p1937);
            end;

            for _, descendant in p1937:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("FloralVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("FloralVisual");
                end;
            end;
        end
    },
    Blossoming = {
        Id = "BM",
        Name = "Blossoming",
        ValueMulti = 50,
        Color = Color3.fromRGB(236, 128, 255),

        _AddFX = function(p1941: any, p1942: userdata, p1943: userdata) -- Line: 12058, Name: _AddFX
            -- upvalues: u3 (copy)
            p1941:_RemoveFX(p1942, p1943);
            local v1944 = p1942:FindFirstChild("Item_Seed") and (p1942.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v1944);
            local Children = game.ServerStorage.Mutation_FX.Blossoming:GetChildren();
            local v1945 = { Color3.fromRGB(105, 158, 255), Color3.fromRGB(236, 128, 255), Color3.fromRGB(255, 129, 211) };

            for _, descendant in p1942:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = v1945[Random_new_ret:NextInteger(1, #v1945)];
                    descendant:AddTag("BlossomingVisual");

                    if #Children > 0 then
                        local v1946 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                        v1946.Parent = descendant;

                        if v1946:IsA("ParticleEmitter") then
                            v1946.Enabled = true;
                        end;

                        v1946:AddTag("Cleanup_Blossoming");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1947: any, p1948: userdata, p1949: userdata) -- Line: 12095, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v1951(p1950) -- Line: 12096
                for _, descendant in p1950:GetDescendants() do
                    if descendant:HasTag("Cleanup_Blossoming") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1949 then
                v1951(p1949);
            end;

            if p1948 then
                v1951(p1948);
            end;

            for _, descendant in p1948:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("BlossomingVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("BlossomingVisual");
                end;
            end;
        end
    },
    Candy = {
        Id = "CD",
        Name = "Candy",
        ValueMulti = 10,
        Color = Color3.fromRGB(255, 89, 89),

        _AddFX = function(p1952: any, p1953: userdata, p1954: userdata) -- Line: 12125, Name: _AddFX
            -- upvalues: u3 (copy)
            p1952:_RemoveFX(p1953, p1954);
            local v1955 = p1953:FindFirstChild("Item_Seed") and (p1953.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v1955);
            local Children = game.ServerStorage.Mutation_FX.Candy:GetChildren();
            local v1956 = { Color3.fromRGB(248, 248, 248), Color3.fromRGB(255, 89, 89) };

            if p1954 then
                for _, v in Children do
                    local v1957 = v:Clone();
                    v1957.Parent = p1954;

                    if v1957:IsA("ParticleEmitter") then
                        v1957.Enabled = true;
                    end;

                    v1957:AddTag("Cleanup_Candy");
                end;
            end;

            local v1958 = {};

            for _, descendant in p1953:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    table.insert(v1958, descendant);
                end;
            end;

            table.sort(v1958, function(p1959, p1960) -- Line: 12157
                return p1959.Position.Y < p1960.Position.Y;
            end);

            for i, v in v1958 do
                u3[v] = u3[v] or v.Color;
                v.Color = v1956[i % 2 + 1];
                v:AddTag("CandyVisual");

                if v ~= p1954 and (#Children > 0 and Random_new_ret:NextNumber() <= 0.5) then
                    local v1961 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                    v1961.Parent = v;

                    if v1961:IsA("ParticleEmitter") then
                        v1961.Enabled = true;
                    end;

                    v1961:AddTag("Cleanup_Candy");
                end;
            end;
        end,

        _RemoveFX = function(p1962: any, p1963: userdata, p1964: userdata) -- Line: 12180, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v1966(p1965) -- Line: 12181
                for _, descendant in p1965:GetDescendants() do
                    if descendant:HasTag("Cleanup_Candy") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1964 then
                v1966(p1964);
            end;

            if p1963 then
                v1966(p1963);
            end;

            for _, descendant in p1963:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("CandyVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("CandyVisual");
                end;
            end;
        end
    },
    Confection = {
        Id = "CF",
        Name = "Confection",
        ValueMulti = 18,
        Color = Color3.fromRGB(255, 160, 190),

        _AddFX = function(p1967: any, p1968: userdata, p1969: userdata) -- Line: 12210, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p1967:_RemoveFX(p1968, p1969);
            local v1970 = p1968:FindFirstChild("Item_Seed") and (p1968.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v1970);
            local Children = game.ServerStorage.Mutation_FX.Confection:GetChildren();
            local v1971 = { Color3.fromRGB(255, 170, 200), Color3.fromRGB(255, 135, 185), Color3.fromRGB(255, 110, 160) };
            local v1972 = {
                Color3.fromRGB(255, 89, 89),
                Color3.fromRGB(248, 248, 248),
                Color3.fromRGB(80, 170, 255),
                Color3.fromRGB(80, 255, 120),
                Color3.fromRGB(255, 170, 80),
                Color3.fromRGB(190, 100, 255),
                Color3.fromRGB(255, 230, 90)
            };
            OriginalTransparency = OriginalTransparency or {};
            local v1973 = {};

            for _, descendant in p1968:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    table.insert(v1973, descendant);
                end;
            end;

            table.sort(v1973, function(p1974, p1975) -- Line: 12242
                return p1974.Position.Y < p1975.Position.Y;
            end);

            if p1969 then
                for _, v in Children do
                    local v1976 = v:Clone();
                    v1976.Parent = p1969;

                    if v1976:IsA("ParticleEmitter") then
                        v1976.Enabled = true;
                        v1976:FindFirstChildWhichIsA("NumberValue");
                    end;

                    if v1976:IsA("ParticleEmitter") then
                        v1976.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v1972[Random_new_ret:NextInteger(1, #v1972)]), ColorSequenceKeypoint.new(1, v1972[Random_new_ret:NextInteger(1, #v1972)]) });
                    end;

                    v1976:AddTag("Cleanup_Confection");
                end;
            end;

            for _, v in v1973 do
                u3[v] = u3[v] or v.Color;
                u6[v] = u6[v] or v.Material;
                OriginalTransparency[v] = OriginalTransparency[v] or v.Transparency;
                v.Color = v1971[Random_new_ret:NextInteger(1, #v1971)];
                v.Material = Enum.Material.Glass;
                v.Transparency = 0.2;
                v:AddTag("ConfectionVisual");

                if v ~= p1969 and #Children > 0 then
                    local v1977 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                    v1977.Parent = v;

                    if v1977:IsA("ParticleEmitter") then
                        v1977.Enabled = true;
                        v1977.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v1972[Random_new_ret:NextInteger(1, #v1972)]), ColorSequenceKeypoint.new(1, v1972[Random_new_ret:NextInteger(1, #v1972)]) });
                    end;

                    v1977:AddTag("Cleanup_Confection");
                end;
            end;
        end,

        _RemoveFX = function(p1978: any, p1979: userdata, p1980: userdata) -- Line: 12298, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            OriginalTransparency = OriginalTransparency or {};

            local function v1982(p1981) -- Line: 12301
                for _, descendant in p1981:GetDescendants() do
                    if descendant:HasTag("Cleanup_Confection") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1980 then
                v1982(p1980);
            end;

            if p1979 then
                v1982(p1979);
            end;

            for _, descendant in p1979:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ConfectionVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Transparency = OriginalTransparency[descendant] or 0;
                    OriginalTransparency[descendant] = nil;
                    descendant:RemoveTag("ConfectionVisual");
                end;
            end;
        end
    },
    Spotty = {
        Id = "SPOT",
        Name = "Spotty",
        ValueMulti = 33,
        Color = Color3.fromRGB(0, 0, 0),

        _AddFX = function(p1983: any, p1984: userdata, p1985: userdata) -- Line: 12339, Name: _AddFX
            -- upvalues: u3 (copy)
            p1983:_RemoveFX(p1984, p1985);
            local v1986 = p1984:FindFirstChild("Item_Seed") and (p1984.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v1986);
            local Spotty = game.ServerStorage.Mutation_FX.Spotty;
            local Pink = Spotty:FindFirstChild("Pink");
            local Blue = Spotty:FindFirstChild("Blue");
            local Color3_fromRGB_ret = Color3.fromRGB(255, 34, 154);
            local Color3_fromRGB_ret2 = Color3.fromRGB(0, 124, 255);
            local Color3_fromRGB_ret3 = Color3.fromRGB(0, 0, 0);

            for _, descendant in p1984:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    local v1987 = Random_new_ret:NextNumber();
                    local v1988 = nil;

                    if v1987 <= 0.2 then
                        descendant.Color = Color3_fromRGB_ret;
                        v1988 = Pink;
                    elseif v1987 <= 0.4 then
                        descendant.Color = Color3_fromRGB_ret2;
                        v1988 = Blue;
                    else
                        descendant.Color = Color3_fromRGB_ret3;
                    end;

                    descendant:AddTag("SpottyVisual");

                    if v1988 then
                        local v1989 = v1988:Clone();
                        v1989.Parent = descendant;

                        if v1989:IsA("ParticleEmitter") then
                            v1989.Enabled = true;
                        end;

                        v1989:AddTag("Cleanup_Spotty");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p1990: any, p1991: userdata, p1992: userdata) -- Line: 12388, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v1994(p1993) -- Line: 12389
                for _, descendant in p1993:GetDescendants() do
                    if descendant:HasTag("Cleanup_Spotty") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p1992 then
                v1994(p1992);
            end;

            if p1991 then
                v1994(p1991);
            end;

            for _, descendant in p1991:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("SpottyVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("SpottyVisual");
                end;
            end;
        end
    },
    Pollinated_Poor = {
        Id = "PP",
        Name = "Pollinated_Poor",
        DisplayName = "Pollinated (Poor)",
        ValueMulti = 1,
        Color = Color3.fromRGB(140, 105, 35),

        _AddFX = function(p1995: any, p1996: userdata, p1997: userdata) -- Line: 12419, Name: _AddFX
            -- upvalues: u3 (copy)
            p1995:_RemoveFX(p1996, p1997);

            if p1997 then
                for _, child in game.ServerStorage.Mutation_FX.Pollinated_Poor:GetChildren() do
                    local v1998 = child:Clone();
                    v1998.Parent = p1997;
                    v1998.Enabled = true;
                    v1998:AddTag("Cleanup_PollinatedPoor");
                    v1998:AddTag("Effect");
                end;
            end;

            for _, descendant in p1996:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(140, 105, 35);
                    descendant:AddTag("PollinatedPoorVisual");
                end;
            end;
        end,

        _RemoveFX = function(p1999: any, p2000: userdata, p2001: userdata) -- Line: 12443, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p2001 then
                for _, child in p2001:GetChildren() do
                    if child:HasTag("Cleanup_PollinatedPoor") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p2000:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("PollinatedPoorVisual") then
                    descendant:RemoveTag("PollinatedPoorVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v2002 = u6[descendant];

                    if v2002 then
                        descendant.Material = v2002;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Pollinated_Fair = {
        Id = "PF",
        Name = "Pollinated_Fair",
        DisplayName = "Pollinated (Fair)",
        ValueMulti = 1,
        Color = Color3.fromRGB(200, 150, 20),

        _AddFX = function(p2003: any, p2004: userdata, p2005: userdata) -- Line: 12475, Name: _AddFX
            -- upvalues: u3 (copy)
            p2003:_RemoveFX(p2004, p2005);

            if p2005 then
                for _, child in game.ServerStorage.Mutation_FX.Pollinated_Fair:GetChildren() do
                    local v2006 = child:Clone();
                    v2006.Parent = p2005;
                    v2006.Enabled = true;
                    v2006:AddTag("Cleanup_PollinatedFair");
                    v2006:AddTag("Effect");
                end;
            end;

            for _, descendant in p2004:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(200, 150, 20);
                    descendant:AddTag("PollinatedFairVisual");
                end;
            end;
        end,

        _RemoveFX = function(p2007: any, p2008: userdata, p2009: userdata) -- Line: 12499, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p2009 then
                for _, child in p2009:GetChildren() do
                    if child:HasTag("Cleanup_PollinatedFair") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p2008:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("PollinatedFairVisual") then
                    descendant:RemoveTag("PollinatedFairVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v2010 = u6[descendant];

                    if v2010 then
                        descendant.Material = v2010;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Pollinated_Good = {
        Id = "PG",
        Name = "Pollinated_Good",
        DisplayName = "Pollinated (Good)",
        ValueMulti = 1,
        Color = Color3.fromRGB(255, 180, 30),

        _AddFX = function(p2011: any, p2012: userdata, p2013: userdata) -- Line: 12531, Name: _AddFX
            -- upvalues: u3 (copy)
            p2011:_RemoveFX(p2012, p2013);

            if p2013 then
                for _, child in game.ServerStorage.Mutation_FX.Pollinated_Good:GetChildren() do
                    local v2014 = child:Clone();
                    v2014.Parent = p2013;
                    v2014.Enabled = true;
                    v2014:AddTag("Cleanup_PollinatedGood");
                    v2014:AddTag("Effect");
                end;
            end;

            for _, descendant in p2012:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(255, 180, 30);
                    descendant:AddTag("PollinatedGoodVisual");
                end;
            end;
        end,

        _RemoveFX = function(p2015: any, p2016: userdata, p2017: userdata) -- Line: 12555, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p2017 then
                for _, child in p2017:GetChildren() do
                    if child:HasTag("Cleanup_PollinatedGood") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p2016:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("PollinatedGoodVisual") then
                    descendant:RemoveTag("PollinatedGoodVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v2018 = u6[descendant];

                    if v2018 then
                        descendant.Material = v2018;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Pollinated_Godly = {
        Id = "PY",
        Name = "Pollinated_Godly",
        DisplayName = "Pollinated (Godly)",
        ValueMulti = 1,
        Color = Color3.fromRGB(255, 230, 100),

        _AddFX = function(p2019: any, p2020: userdata, p2021: userdata) -- Line: 12587, Name: _AddFX
            -- upvalues: u3 (copy)
            p2019:_RemoveFX(p2020, p2021);

            if p2021 then
                for _, child in game.ServerStorage.Mutation_FX.Pollinated_Godly:GetChildren() do
                    local v2022 = child:Clone();
                    v2022.Parent = p2021;
                    v2022.Enabled = true;
                    v2022:AddTag("Cleanup_PollinatedGodly");
                    v2022:AddTag("Effect");
                end;
            end;

            for _, descendant in p2020:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = Color3.fromRGB(255, 230, 100);
                    descendant:AddTag("PollinatedGodlyVisual");
                end;
            end;
        end,

        _RemoveFX = function(p2023: any, p2024: userdata, p2025: userdata) -- Line: 12611, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p2025 then
                for _, child in p2025:GetChildren() do
                    if child:HasTag("Cleanup_PollinatedGodly") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p2024:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("PollinatedGodlyVisual") then
                    descendant:RemoveTag("PollinatedGodlyVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    local v2026 = u6[descendant];

                    if v2026 then
                        descendant.Material = v2026;
                        u6[descendant] = nil;
                    end;
                end;
            end;
        end
    },
    Honeygem = {
        Id = "HG",
        Name = "Honeygem",
        ValueMulti = 33,
        Color = Color3.fromRGB(255, 220, 70),

        _AddFX = function(p2027: any, p2028: userdata, p2029: userdata) -- Line: 12642, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p2027:_RemoveFX(p2028, p2029);
            local v2030 = p2028:FindFirstChild("Item_Seed") and (p2028.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v2030);
            local Children = game.ServerStorage.Mutation_FX.Honeygem:GetChildren();
            local Color3_fromRGB_ret = Color3.fromRGB(160, 105, 0);
            local Color3_fromRGB_ret2 = Color3.fromRGB(255, 245, 95);

            if p2029 then
                for _, v in Children do
                    local v2031 = v:Clone();
                    v2031.Parent = p2029;

                    if v2031:IsA("ParticleEmitter") then
                        v2031.Enabled = true;
                    end;

                    v2031:AddTag("Cleanup_Honeygem");
                end;
            end;

            local v2032 = {};

            for _, descendant in p2028:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    table.insert(v2032, descendant);
                end;
            end;

            table.sort(v2032, function(p2033, p2034) -- Line: 12670
                return p2033.Position.Y < p2034.Position.Y;
            end);
            local v2035 = #v2032;

            for i, v in v2032 do
                u3[v] = u3[v] or v.Color;
                u6[v] = u6[v] or v.Material;
                v.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, v2035 <= 1 and 1 or (i - 1) / (v2035 - 1));
                v.Material = Enum.Material.Glass;
                v:AddTag("HoneygemVisual");

                if v ~= p2029 and (#Children > 0 and Random_new_ret:NextNumber() <= 0.5) then
                    local v2036 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                    v2036.Parent = v;

                    if v2036:IsA("ParticleEmitter") then
                        v2036.Enabled = true;
                    end;

                    v2036:AddTag("Cleanup_Honeygem");
                end;
            end;
        end,

        _RemoveFX = function(p2037: any, p2038: userdata, p2039: userdata) -- Line: 12695, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v2041(p2040) -- Line: 12696
                for _, descendant in p2040:GetDescendants() do
                    if descendant:HasTag("Cleanup_Honeygem") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p2039 then
                v2041(p2039);
            end;

            if p2038 then
                v2041(p2038);
            end;

            for _, descendant in p2038:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("HoneygemVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant:RemoveTag("HoneygemVisual");
                end;
            end;
        end
    },
    Jellygem = {
        Id = "JE",
        Name = "Jellygem",
        ValueMulti = 25,
        Color = Color3.fromRGB(150, 90, 255),

        _AddFX = function(p2042: any, p2043: userdata, p2044: userdata) -- Line: 12731, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p2042:_RemoveFX(p2043, p2044);
            local v2045 = p2043:FindFirstChild("Item_Seed") and (p2043.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v2045);
            local Children = game.ServerStorage.Mutation_FX.Jellygem:GetChildren();
            local Color3_fromRGB_ret = Color3.fromRGB(3, 91, 255);
            local Color3_fromRGB_ret2 = Color3.fromRGB(190, 80, 255);

            if p2044 then
                for _, v in Children do
                    local v2046 = v:Clone();
                    v2046.Parent = p2044;

                    if v2046:IsA("ParticleEmitter") then
                        v2046.Enabled = true;
                    end;

                    v2046:AddTag("Cleanup_Jellygem");
                end;
            end;

            local v2047 = {};

            for _, descendant in p2043:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    table.insert(v2047, descendant);
                end;
            end;

            table.sort(v2047, function(p2048, p2049) -- Line: 12759
                return p2048.Position.Y < p2049.Position.Y;
            end);
            local v2050 = #v2047;

            for i, v in v2047 do
                u3[v] = u3[v] or v.Color;
                u6[v] = u6[v] or v.Material;
                v.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, v2050 <= 1 and 1 or (i - 1) / (v2050 - 1));
                v.Material = Enum.Material.Glass;
                v:AddTag("JellygemVisual");

                if v ~= p2044 and #Children > 0 then
                    local v2051 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                    v2051.Parent = v;

                    if v2051:IsA("ParticleEmitter") then
                        v2051.Enabled = true;
                    end;

                    v2051:AddTag("Cleanup_Jellygem");
                end;
            end;
        end,

        _RemoveFX = function(p2052: any, p2053: userdata, p2054: userdata) -- Line: 12784, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v2056(p2055) -- Line: 12785
                for _, descendant in p2055:GetDescendants() do
                    if descendant:HasTag("Cleanup_Jellygem") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p2054 then
                v2056(p2054);
            end;

            if p2053 then
                v2056(p2053);
            end;

            for _, descendant in p2053:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("JellygemVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant:RemoveTag("JellygemVisual");
                end;
            end;
        end
    },
    Resplendent = {
        Id = "RD",
        Name = "Resplendent",
        ValueMulti = 20,
        Color = Color3.fromRGB(109, 255, 101),

        _AddFX = function(p2057: any, p2058: userdata, p2059: userdata) -- Line: 12820, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p2057:_RemoveFX(p2058, p2059);

            if p2059 then
                for _, child in game.ServerStorage.Mutation_FX.Resplendent:GetChildren() do
                    local v2060 = child:Clone();
                    v2060.Parent = p2059;
                    v2060.Enabled = true;
                    v2060:AddTag("Cleanup_Resplendent");
                end;
            end;

            for i, descendant in p2058:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    if i % 6 == 0 then
                        local v2061 = game.ServerStorage.Mutation_FX.Resplendent.Rays:Clone();
                        v2061.Parent = descendant;
                        v2061.Enabled = true;
                        v2061:AddTag("Cleanup_Resplendent");
                    end;

                    if not descendant:HasTag("Effect") then
                        u3[descendant] = u3[descendant] or descendant.Color;
                        u6[descendant] = u6[descendant] or descendant.Material;
                        descendant.Color = Color3.fromRGB(176, 240, 0);
                        descendant:AddTag("ResplendentVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p2062: any, p2063: userdata, p2064: userdata) -- Line: 12856, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            if p2064 then
                for _, child in p2064:GetChildren() do
                    if child:HasTag("Cleanup_Resplendent") then
                        child:Destroy();
                    end;
                end;
            end;

            for _, descendant in p2063:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ResplendentVisual") then
                    descendant:RemoveTag("ResplendentVisual");
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                end;
            end;
        end
    },
    Sylvan = {
        Id = "SV",
        Name = "Sylvan",
        ValueMulti = 35,
        Color = Color3.fromRGB(65, 180, 80),

        _AddFX = function(p2065: any, p2066: userdata, p2067: userdata) -- Line: 12888, Name: _AddFX
            -- upvalues: u3 (copy)
            p2065:_RemoveFX(p2066, p2067);
            local v2068 = p2066:FindFirstChild("Item_Seed") and (p2066.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v2068);
            local Children = game.ServerStorage.Mutation_FX.Sylvan:GetChildren();
            local v2069 = {
                Color3.fromRGB(34, 139, 34),
                Color3.fromRGB(50, 160, 70),
                Color3.fromRGB(65, 180, 80),
                Color3.fromRGB(85, 200, 100),
                Color3.fromRGB(110, 220, 120),
                Color3.fromRGB(25, 100, 45)
            };

            if p2067 then
                for _, v in Children do
                    local v2070 = v:Clone();
                    v2070.Parent = p2067;

                    if v2070:IsA("ParticleEmitter") then
                        v2070.Enabled = true;
                    end;

                    v2070:AddTag("Cleanup_Sylvan");
                end;
            end;

            local v2071 = 0;

            for _, descendant in p2066:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    v2071 = v2071 + 1;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    descendant.Color = v2069[Random_new_ret:NextInteger(1, #v2069)];
                    descendant:AddTag("SylvanVisual");

                    if descendant ~= p2067 and (v2071 % 2 == 0 and #Children > 0) then
                        local v2072 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                        v2072.Parent = descendant;

                        if v2072:IsA("ParticleEmitter") then
                            v2072.Enabled = true;
                        end;

                        v2072:AddTag("Cleanup_Sylvan");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p2073: any, p2074: userdata, p2075: userdata) -- Line: 12942, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v2077(p2076) -- Line: 12943
                for _, descendant in p2076:GetDescendants() do
                    if descendant:HasTag("Cleanup_Sylvan") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p2075 then
                v2077(p2075);
            end;

            if p2074 then
                v2077(p2074);
            end;

            for _, descendant in p2074:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("SylvanVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("SylvanVisual");
                end;
            end;
        end
    },
    Ember = {
        Id = "EM",
        Name = "Ember",
        ValueMulti = 100,
        Color = Color3.fromRGB(255, 120, 0),

        _AddFX = function(p2078: any, p2079: userdata, p2080: userdata) -- Line: 12972, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p2078:_RemoveFX(p2079, p2080);
            local v2081 = p2079:FindFirstChild("Item_Seed") and (p2079.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v2081);
            local Ember = game.ServerStorage.Mutation_FX.Ember;
            local v2082 = {
                Color3.fromRGB(255, 55, 0),
                Color3.fromRGB(255, 120, 0),
                Color3.fromRGB(255, 190, 35),
                Color3.fromRGB(255, 80, 15),
                Color3.fromRGB(170, 35, 0)
            };
            local v2083 = {};
            local v2084 = {};

            for _, child in Ember:GetChildren() do
                if child:IsA("ParticleEmitter") or child:IsA("Trail") then
                    table.insert(v2083, child);
                elseif child:IsA("Attachment") then
                    table.insert(v2084, child);
                end;
            end;

            if p2080 then
                for _, v in v2084 do
                    local v2085 = v:Clone();
                    v2085.Parent = p2080;
                    v2085:AddTag("Cleanup_Ember");
                end;

                for _, v in v2083 do
                    local v2086 = v:Clone();
                    v2086.Parent = p2080;

                    if v2086:IsA("ParticleEmitter") then
                        v2086.Enabled = true;
                    elseif v2086:IsA("Trail") then
                        v2086.Enabled = true;
                    end;

                    v2086:AddTag("Cleanup_Ember");
                end;
            end;

            for _, descendant in p2079:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = v2082[Random_new_ret:NextInteger(1, #v2082)];
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("EmberVisual");
                    descendant:AddTag("EmberPart");

                    if descendant ~= p2080 and #v2083 > 0 then
                        local v2087 = v2083[Random_new_ret:NextInteger(1, #v2083)]:Clone();
                        v2087.Parent = descendant;

                        if v2087:IsA("ParticleEmitter") then
                            v2087.Enabled = true;
                        elseif v2087:IsA("Trail") then
                            v2087.Enabled = true;
                        end;

                        v2087:AddTag("Cleanup_Ember");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p2088: any, p2089: userdata, p2090: userdata) -- Line: 13046, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v2092(p2091) -- Line: 13047
                for _, descendant in p2091:GetDescendants() do
                    if descendant:HasTag("Cleanup_Ember") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p2090 then
                v2092(p2090);
            end;

            if p2089 then
                v2092(p2089);
            end;

            for _, descendant in p2089:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("EmberVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant:RemoveTag("EmberPart");
                    descendant:RemoveTag("EmberVisual");
                end;
            end;
        end
    },
    Shadow = {
        Id = "SD",
        Name = "Shadow",
        ValueMulti = 33,
        Color = Color3.fromRGB(35, 20, 55),

        _AddFX = function(p2093: any, p2094: userdata, p2095: userdata) -- Line: 13083, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p2093:_RemoveFX(p2094, p2095);
            local v2096 = p2094:FindFirstChild("Item_Seed") and (p2094.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v2096);
            local Shadow = game.ServerStorage.Mutation_FX.Shadow;
            local v2097 = {
                Color3.fromRGB(5, 5, 8),
                Color3.fromRGB(12, 8, 18),
                Color3.fromRGB(25, 10, 40),
                Color3.fromRGB(35, 20, 55),
                Color3.fromRGB(50, 25, 80)
            };
            local v2098 = {};

            for _, child in Shadow:GetChildren() do
                if child:IsA("ParticleEmitter") or child:IsA("Trail") then
                    table.insert(v2098, child);
                end;
            end;

            if p2095 then
                for _, v in v2098 do
                    local v2099 = v:Clone();
                    v2099.Parent = p2095;
                    v2099.Enabled = true;
                    v2099:AddTag("Cleanup_Shadow");
                end;
            end;

            local v2100 = 0;

            for _, descendant in p2094:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    v2100 = v2100 + 1;
                    u3[descendant] = u3[descendant] or descendant.Color;
                    u6[descendant] = u6[descendant] or descendant.Material;
                    descendant.Color = v2097[Random_new_ret:NextInteger(1, #v2097)];
                    descendant.Material = Enum.Material.Neon;
                    descendant:AddTag("ShadowVisual");

                    if descendant ~= p2095 and (v2100 % 4 == 0 and #v2098 > 0) then
                        local v2101 = v2098[Random_new_ret:NextInteger(1, #v2098)]:Clone();
                        v2101.Parent = descendant;
                        v2101.Enabled = true;
                        v2101:AddTag("Cleanup_Shadow");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p2102: any, p2103: userdata, p2104: userdata) -- Line: 13142, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v2106(p2105) -- Line: 13143
                for _, descendant in p2105:GetDescendants() do
                    if descendant:HasTag("Cleanup_Shadow") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p2104 then
                v2106(p2104);
            end;

            if p2103 then
                v2106(p2103);
            end;

            for _, descendant in p2103:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("ShadowVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant:RemoveTag("ShadowVisual");
                end;
            end;
        end
    },
    Tidal = {
        Id = "tid",
        Name = "Tidal",
        ValueMulti = 5,
        Color = Color3.fromRGB(35, 88, 211),

        _AddFX = function(p2107: any, p2108: userdata, p2109: userdata) -- Line: 13178, Name: _AddFX
            -- upvalues: u3 (copy), u6 (copy)
            p2107:_RemoveFX(p2108, p2109);
            local Children = game.ServerStorage.Mutation_FX.Tidal:GetChildren();
            local v2110 = {};
            local v2111 = 0;

            for _, descendant in p2108:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    table.insert(v2110, descendant);
                end;
            end;

            table.sort(v2110, function(p2112, p2113) -- Line: 13195
                return p2112.Position.Y < p2113.Position.Y;
            end);
            local Color3_fromRGB_ret = Color3.fromRGB(0, 45, 149);
            local Color3_fromRGB_ret2 = Color3.fromRGB(35, 88, 211);
            local Color3_fromRGB_ret3 = Color3.fromRGB(210, 245, 255);
            local v2114 = #v2110;

            for i, v in v2110 do
                u3[v] = u3[v] or v.Color;
                u6[v] = u6[v] or v.Material;
                local v2115 = v2114 <= 1 and 1 or (i - 1) / (v2114 - 1);

                if v2115 < 0.65 then
                    v.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, v2115 / 0.65);
                else
                    v.Color = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret3, (v2115 - 0.65) / 0.35);
                end;

                v.Material = Enum.Material.SmoothPlastic;
                v:AddTag("TidalVisual");

                if i % 5 == 0 and (#Children > 0 and v2111 < 8) then
                    v2111 = v2111 + 1;
                    local v2116 = v;

                    for _, v2 in Children do
                        local v2117 = v2:Clone();
                        v2117.Parent = v2116;

                        if v2117:IsA("ParticleEmitter") then
                            v2117.Enabled = true;
                        end;

                        v2117:AddTag("Cleanup_TidalVisual");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p2118: any, p2119: userdata, p2120: userdata) -- Line: 13233, Name: _RemoveFX
            -- upvalues: u3 (copy), u6 (copy)
            local function v2122(p2121) -- Line: 13234
                for _, descendant in p2121:GetDescendants() do
                    if descendant:HasTag("Cleanup_TidalVisual") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p2120 then
                v2122(p2120);
            end;

            if p2119 then
                v2122(p2119);
            end;

            for _, descendant in p2119:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("TidalVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;

                    if u6[descendant] then
                        descendant.Material = u6[descendant];
                        u6[descendant] = nil;
                    end;

                    descendant.Reflectance = 0;
                    descendant:RemoveTag("TidalVisual");
                end;
            end;
        end
    },
    Dream = {
        Id = "DR",
        Name = "Dream",
        ValueMulti = 15,
        Color = Color3.fromRGB(180, 190, 255),

        _AddFX = function(p2123: any, p2124: userdata, p2125: userdata) -- Line: 13270, Name: _AddFX
            -- upvalues: u3 (copy)
            p2123:_RemoveFX(p2124, p2125);
            local v2126 = p2124:FindFirstChild("Item_Seed") and (p2124.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v2126);
            local Children = game.ServerStorage.Mutation_FX.Dream:GetChildren();
            local Color3_fromRGB_ret = Color3.fromRGB(105, 165, 255);
            local Color3_fromRGB_ret2 = Color3.fromRGB(155, 185, 255);
            local Color3_fromRGB_ret3 = Color3.fromRGB(220, 190, 255);

            local function v2128(p2127: userdata) -- Line: 13281
                if p2127:IsA("ParticleEmitter") or (p2127:IsA("Trail") or p2127:IsA("Beam")) then
                    p2127.Enabled = true;
                end;

                for _, descendant in p2127:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            if p2125 then
                for _, v in Children do
                    local v2129 = v:Clone();
                    v2129.Parent = p2125;
                    v2128(v2129);
                    v2129:AddTag("Cleanup_Dream");
                end;
            end;

            local v2130 = {};

            for _, descendant in p2124:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    table.insert(v2130, descendant);
                end;
            end;

            table.sort(v2130, function(p2131, p2132) -- Line: 13313
                return p2131.Position.Y < p2132.Position.Y;
            end);
            local v2133 = #v2130;
            local v2134 = 0;

            for i, v in v2130 do
                u3[v] = u3[v] or v.Color;
                local v2135 = v2133 <= 1 and 1 or (i - 1) / (v2133 - 1);

                if v2135 < 0.5 then
                    v.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, v2135 / 0.5);
                else
                    v.Color = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret3, (v2135 - 0.5) / 0.5);
                end;

                v:AddTag("DreamVisual");

                if v ~= p2125 then
                    v2134 = v2134 + 1;

                    if v2134 % 3 == 0 and #Children > 0 then
                        local v2136 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                        v2136.Parent = v;
                        v2128(v2136);
                        v2136:AddTag("Cleanup_Dream");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p2137: any, p2138: userdata, p2139: userdata) -- Line: 13346, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v2141(p2140) -- Line: 13347
                for _, descendant in p2140:GetDescendants() do
                    if descendant:HasTag("Cleanup_Dream") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p2139 then
                v2141(p2139);
            end;

            if p2138 then
                v2141(p2138);
            end;

            for _, descendant in p2138:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("DreamVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("DreamVisual");
                end;
            end;
        end
    },
    Nightmare = {
        Id = "NM",
        Name = "Nightmare",
        ValueMulti = 15,
        Color = Color3.fromRGB(110, 70, 180),

        _AddFX = function(p2142: any, p2143: userdata, p2144: userdata) -- Line: 13376, Name: _AddFX
            -- upvalues: u3 (copy)
            p2142:_RemoveFX(p2143, p2144);
            local v2145 = p2143:FindFirstChild("Item_Seed") and (p2143.Item_Seed.Value or 1) or 1;
            local Random_new_ret = Random.new(v2145);
            local Children = game.ServerStorage.Mutation_FX.Nightmare:GetChildren();
            local Color3_fromRGB_ret = Color3.fromRGB(70, 20, 125);
            local Color3_fromRGB_ret2 = Color3.fromRGB(120, 70, 185);
            local Color3_fromRGB_ret3 = Color3.fromRGB(165, 215, 255);

            local function v2147(p2146: userdata) -- Line: 13387
                if p2146:IsA("ParticleEmitter") or (p2146:IsA("Trail") or p2146:IsA("Beam")) then
                    p2146.Enabled = true;
                end;

                for _, descendant in p2146:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            if p2144 then
                for _, v in Children do
                    local v2148 = v:Clone();
                    v2148.Parent = p2144;
                    v2147(v2148);
                    v2148:AddTag("Cleanup_Nightmare");
                end;
            end;

            local v2149 = {};

            for _, descendant in p2143:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and (not descendant:HasTag("Effect") and descendant.Transparency < 1) then
                    table.insert(v2149, descendant);
                end;
            end;

            table.sort(v2149, function(p2150, p2151) -- Line: 13419
                return p2150.Position.Y < p2151.Position.Y;
            end);
            local v2152 = #v2149;
            local v2153 = 0;

            for i, v in v2149 do
                u3[v] = u3[v] or v.Color;
                local v2154 = v2152 <= 1 and 1 or (i - 1) / (v2152 - 1);

                if v2154 < 0.5 then
                    v.Color = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, v2154 / 0.5);
                else
                    v.Color = Color3_fromRGB_ret2:Lerp(Color3_fromRGB_ret3, (v2154 - 0.5) / 0.5);
                end;

                v:AddTag("NightmareVisual");

                if v ~= p2144 then
                    v2153 = v2153 + 1;

                    if v2153 % 3 == 0 and #Children > 0 then
                        local v2155 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
                        v2155.Parent = v;
                        v2147(v2155);
                        v2155:AddTag("Cleanup_Nightmare");
                    end;
                end;
            end;
        end,

        _RemoveFX = function(p2156: any, p2157: userdata, p2158: userdata) -- Line: 13452, Name: _RemoveFX
            -- upvalues: u3 (copy)
            local function v2160(p2159) -- Line: 13453
                for _, descendant in p2159:GetDescendants() do
                    if descendant:HasTag("Cleanup_Nightmare") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if p2158 then
                v2160(p2158);
            end;

            if p2157 then
                v2160(p2157);
            end;

            for _, descendant in p2157:GetDescendants() do
                if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant:HasTag("NightmareVisual") then
                    descendant.Color = u3[descendant] or descendant.Color;
                    u3[descendant] = nil;
                    descendant:RemoveTag("NightmareVisual");
                end;
            end;
        end
    }
};
local u2162 = {};
local u2163 = {};

for i, v in u2161 do
    u2162[i] = v.Id;
end;

for i, v in u2161 do
    if u2163[v.Id] then
        error((`MutationHandler | Duplicate Enum for {i} and {u2163[v.Id]}`));
    end;

    u2163[v.Id] = i;
end;

table.freeze(u2162);
table.freeze(u2163);
table.freeze(u2161);

function u1.GetMutationsToEnums(p2164) -- Line: 13496
    -- upvalues: u2162 (copy)
    return u2162;
end;

function u1.GetEnumsToMutations(p2165) -- Line: 13498
    -- upvalues: u2163 (copy)
    return u2163;
end;

function u1.GetMutations(p2166) -- Line: 13501
    -- upvalues: u2161 (copy)
    return u2161;
end;

function u1.AddMutation(p2167: table, p2168: userdata, p2169: table, p2170: boolean?) -- Line: 13508
    -- upvalues: InfGrowPlantData (copy), RunService (copy), GetPlayerFromPlant (copy)
    if not p2168 then
        warn("MutationHandler:AddMutation | No plant");

        return;
    end;

    local v2171 = InfGrowPlantData.InfGrowPlants[p2168.Name];

    if v2171 and not v2171.CanBeMutated then
        warn((`Cannot mutate InfGrowPlant {p2168.Name}`));

        return;
    end;

    p2168:SetAttribute(p2169.Name, true);

    if RunService:IsServer() and not p2170 then
        local ServerScriptService = game:GetService("ServerScriptService");
        local GardenGuideService = require(ServerScriptService.Modules.GardenGuideService);
        local v2172 = GetPlayerFromPlant(p2168);

        if not v2172 then
            return;
        end;

        GardenGuideService:IncrementMutationCount(v2172, p2169.Name, "Applied");
    end;
end;

function u1.RemoveMutation(p2173: table, p2174: userdata, p2175: table) -- Line: 13536
    if p2174 then
        p2174:SetAttribute(p2175.Name, nil);

        return;
    end;

    warn("MutationHandler:RemoveMutation | No plant");
end;

function u1.GetPlantMutations(p2176: table, p2177: userdata, p2178: boolean?) -- Line: 13547
    -- upvalues: u2161 (copy)
    local v2179 = 0;
    local v2180 = {};
    local v2181 = p2178 and {} or nil;

    for _, v in u2161 do
        if p2177:GetAttribute(v.Name) then
            v2179 = v2179 + 1;
            v2180[v2179] = v;

            if v2181 then
                v2181[v2179] = v.Name;
            end;
        end;
    end;

    return v2180, v2179, v2181;
end;

function u1.GetPlantMutationsCount(p2182: table, p2183: userdata) -- Line: 13566
    -- upvalues: u2161 (copy)
    local v2184 = 0;

    for _, v in u2161 do
        if p2183:GetAttribute(v.Name) then
            v2184 = v2184 + 1;
        end;
    end;

    return v2184;
end;

function u1.GetPlantMutationsAsEnums(p2185: table, p2186: userdata) -- Line: 13576
    -- upvalues: u1 (copy)
    local v2187 = {};

    for _, v in u1:GetPlantMutations(p2186) do
        table.insert(v2187, v.Id);
    end;

    return v2187;
end;

function u1.GetMutationsAsString(p2188: table, p2189: userdata, p2190: boolean?) -- Line: 13587
    -- upvalues: u2161 (copy)
    local v2191 = "";

    for _, v in u2161 do
        local Name = v.Name;

        if p2189:GetAttribute(Name) then
            if v2191 ~= "" then
                v2191 = v2191 .. ", ";
            end;

            v2191 = v2191 .. (v.DisplayName or Name);
        end;
    end;

    if v2191 ~= "" and p2190 then
        v2191 = "[" .. v2191 .. "]";
    end;

    return v2191;
end;

function u1.ExtractMutationsFromEnumArray(p2192, p2193) -- Line: 13605
    -- upvalues: u2163 (copy), u2161 (copy)
    local v2194 = {};

    for _, v in p2193 do
        local v2195 = u2163[v];

        if v2195 then
            table.insert(v2194, u2161[v2195]);
        else
            warn((`MutationHandler:ExtractMutationsFromEnumArray | Mutation does not exist for {v}`));
        end;
    end;

    return v2194;
end;

function u1.ExtractMutationsFromString(p2196: table, p2197: string?) -- Line: 13621
    -- upvalues: u1 (copy)
    local v2198 = {};

    if not p2197 or p2197 == "" then
        return v2198;
    end;

    local v2199 = p2197:gsub("%[", ""):gsub("%]", ""):gsub("%s+", "");

    for i in string.gmatch(v2199, "([^,]+)") do
        local v2200 = i;
        local v2201 = false;

        for _, v in u1:GetMutations() do
            if v.Name == v2200 or v.DisplayName and v.DisplayName:gsub("%s+", "") == v2200 then
                table.insert(v2198, v);
                v2201 = true;
            end;
        end;

        if not v2201 then
            warn((`MutationHandler:ExtractMutationsFromString | Mutation name: {v2200} does not exist`));
        end;
    end;

    return v2198;
end;

function u1.TransferMutations(p2202: table, p2203: userdata, p2204: userdata) -- Line: 13650
    -- upvalues: InfGrowPlantData (copy), u1 (copy)
    local v2205 = InfGrowPlantData.InfGrowPlants[p2204.Name];

    if v2205 and not v2205.CanBeMutated then
        warn((`Cannot mutate InfGrowPlant {p2204.Name}`));

        return;
    end;

    for _, v in u1:GetMutations() do
        if p2203:GetAttribute(v.Name) then
            u1:AddMutation(p2204, v);
            u1:RemoveMutation(p2203, v);
        end;
    end;

    p2204:SetAttribute("WeightMulti", p2203:GetAttribute("WeightMulti") or 1);
end;

function u1.CalcValueMultiFromMuts(p2206: table, p2207: table) -- Line: 13668
    local v2208 = 1;

    for _, v in p2207 do
        v2208 = v2208 + (v.ValueMulti - 1);
    end;

    return math.max(1, v2208);
end;

function u1.CalcValueMulti(p2209: table, p2210: userdata) -- Line: 13682
    -- upvalues: u1 (copy)
    return u1:CalcValueMultiFromMuts((u1:GetPlantMutations(p2210)));
end;

function u1.SetToolName(p2211: table, u2212: userdata) -- Line: 13689
    -- upvalues: ReplicatedStorage (copy), Calculate_Weight (copy), u1 (copy), PlantTraitsData (copy)
    if not u2212:IsA("Tool") then
        return;
    end;

    task.spawn(function() -- Line: 13692
        -- upvalues: ReplicatedStorage (ref), u2212 (copy), Calculate_Weight (ref), u1 (ref), PlantTraitsData (ref)
        local ServerScriptService = game:GetService("ServerScriptService");
        local InventoryService = require(ServerScriptService.Modules.InventoryService);
        local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
        local v2213;

        if u2212:FindFirstChild("Item_String") then
            v2213 = u2212.Item_String.Value;
        else
            v2213 = nil;
        end;

        local v2214;

        if u2212:FindFirstChild("Weight") then
            v2214 = u2212.Weight;
        else
            v2214 = nil;
        end;

        local v2215, v2216;

        if u2212:GetAttribute(InventoryServiceEnums.OWNER) then
            local ToolData = InventoryService:GetToolData(u2212);
            v2213 = v2213 or ToolData.ItemName;

            if not ToolData then
                return;
            end;

            v2215 = ToolData.Variant or "Normal";
            v2216 = ToolData.Seed;
        else
            local Variant = u2212:WaitForChild("Variant", 0.3);

            if not Variant then
                return;
            end;

            local Item_Seed = u2212:WaitForChild("Item_Seed", 0.3);

            if not Item_Seed then
                return;
            end;

            v2215 = Variant.Value;
            v2216 = Item_Seed.Value;
        end;

        if not (v2215 and (v2216 and v2213)) then
            return;
        end;

        local v2217 = Calculate_Weight.Calculate_Weight(v2216, v2213) * (u2212:GetAttribute("WeightMulti") or 1);

        if u2212:HasTag("WaitForWeightValue") and v2214 then
            if not v2214:GetAttribute("SetWeight") then
                repeat
                    task.wait(0.5);
                until v2214:GetAttribute("SetWeight");
            end;

            v2217 = v2214.Value;
        end;

        local v2218 = u1:GetMutationsAsString(u2212):gsub("Pollinated %((.-)%)", "%1");

        if v2215 and (v2215 ~= "" and v2215 ~= "Normal") then
            v2218 = v2218 .. (#v2218 > 0 and ", " or "") .. v2215;
        end;

        local v2219 = v2218 == "" and "" or (`[{v2218}] ` or "");
        local v2220 = string.format("%.2f", v2217) .. "kg";

        if PlantTraitsData.EasterSlot[v2213] or (PlantTraitsData.HalloweenSlot[v2213] or PlantTraitsData.Honey[v2213]) then
            u2212.Name = "[" .. v2220 .. "] " .. v2219 .. v2213;

            return;
        end;

        u2212.Name = v2219 .. v2213 .. " [" .. v2220 .. "]";
    end);
end;

local u2221 = {};

for _, v in u2161 do
    u2221[v.Name] = v.Name;
end;

u1.MutationNames = u2221;
local u2222 = {};

function u1.CheckTimedPlants(p2223) -- Line: 13766
    -- upvalues: u2222 (copy), GetPlayerFromPlant (copy), FruitsEnums (copy), PlantsEnums (copy), u1 (copy), u2161 (copy)
    local Data_Module = require(game.ServerStorage.Data_Module);
    local ServerTimeNow = workspace:GetServerTimeNow();

    for i, _ in u2222 do
        local v2224 = GetPlayerFromPlant(i);

        if v2224 then
            local FruitData = Data_Module.GetFruitData(v2224, i);
            local MutationTimes = FruitsEnums.MutationTimes;

            if not FruitData then
                FruitData = Data_Module.GetPlantData(v2224, i);
                MutationTimes = PlantsEnums.MutationTimes;
            end;

            if FruitData then
                if FruitData[MutationTimes] then
                    local v2225 = i;
                    local v2226 = 0;

                    for i2, v in FruitData[MutationTimes] do
                        local v2227 = u1:GetEnumsToMutations()[i2];
                        local v2228 = u2161[v2227];

                        if v2228 then
                            local TimeData = v2228.TimeData;

                            if TimeData and (TimeData.TimeToChange and TimeData.AddMutationName) then
                                v2226 = v2226 + 1;

                                if ServerTimeNow - v >= TimeData.TimeToChange then
                                    v2225:SetAttribute(TimeData.AddMutationName, true);
                                end;
                            else
                                warn((`Invalid or nil TimeData for {v2227}, despite being in mutaionTimes`));
                            end;
                        else
                            warn((`No mutation for {i2}:{v2227}`));
                        end;
                    end;

                    if v2226 <= 0 then
                        warn((`{v2225.Name} in timedPlants, but no valid muts!`));
                    end;
                else
                    warn(`No Mutation Times for {i.Name} >`, i);
                end;
            else
                warn(`No Plant Data for {i:GetFullName()} >`, i);
            end;
        end;
    end;
end;

local function UpdateMutTimes(p2229: userdata) -- Line: 13832
    -- upvalues: GetPlayerFromPlant (copy), FruitsEnums (copy), PlantsEnums (copy), u1 (copy), u2161 (copy), u2222 (copy)
    if p2229:IsA("Tool") then
        return;
    end;

    if p2229:HasTag("FoodModel") then
        return;
    end;

    if p2229:HasTag("TESTING") then
        return;
    end;

    if p2229:GetAttribute("CommunityGarden") then
        return;
    end;

    local v2230 = p2229:FindFirstAncestor("Farm");

    if v2230 and v2230:GetAttribute("CommunityGarden") then
        return;
    end;

    if not p2229:IsDescendantOf(workspace) then
        return;
    end;

    local Data_Module = require(game.ServerStorage.Data_Module);
    local v2231 = GetPlayerFromPlant(p2229);

    if not v2231 then
        if p2229:GetAttribute("Testing") then
            return;
        end;

        warn("No player for plant >", p2229);

        return;
    end;

    local FruitData = Data_Module.GetFruitData(v2231, p2229);
    local MutationTimes = FruitsEnums.MutationTimes;

    if not FruitData then
        FruitData = Data_Module.GetPlantData(v2231, p2229);
        MutationTimes = PlantsEnums.MutationTimes;
    end;

    if not FruitData then
        warn(`No Plant Data for {p2229:GetFullName()} >`, p2229);

        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local math_floor_ret = math.floor(ServerTimeNow);
    FruitData[MutationTimes] = FruitData[MutationTimes] or {};

    for i, _ in FruitData[MutationTimes] do
        local v2232 = u1:GetEnumsToMutations()[i];
        local v2233 = u2161[v2232];

        if not (p2229:GetAttribute(v2232) and v2233.TimeData) then
            FruitData[MutationTimes][i] = nil;
        end;
    end;

    for i, _ in p2229:GetAttributes() do
        local v2234 = u2161[i];

        if v2234 and v2234.TimeData then
            local v2235 = u1:GetMutationsToEnums()[i];

            if not FruitData[MutationTimes][v2235] then
                FruitData[MutationTimes][v2235] = math_floor_ret;
            end;
        end;
    end;

    if next(FruitData[MutationTimes]) == nil then
        FruitData[MutationTimes] = nil;

        if u2222[p2229] then
            u2222[p2229] = nil;
        end;
    elseif not u2222[p2229] then
        u2222[p2229] = true;
    end;
end;

local u2236 = ThrottledTaskQueue.new(50, 0.25);
local u2237 = {};

local function QueueFXUpdate(u2238: userdata) -- Line: 13925
    -- upvalues: u2237 (copy), u2236 (copy), Task (copy), UpdateMutTimes (copy), UpdateFX (copy), u1 (copy)
    if u2237[u2238] then
        return;
    end;

    local script_MutationCombos = require(script.MutationCombos);
    u2237[u2238] = true;
    u2236:Enqueue(Task.new(function() -- Line: 13930
        -- upvalues: UpdateMutTimes (ref), u2238 (copy), script_MutationCombos (copy), UpdateFX (ref), u1 (ref), u2237 (ref)
        UpdateMutTimes(u2238);
        script_MutationCombos:HandleCombos(u2238);
        UpdateFX(u2238):Await();

        if u2238:HasTag("PlantGenerated") and not u2238:FindFirstAncestorWhichIsA("PlayerGui") then
            u1:SetToolName(u2238);
        end;

        task.wait(0.1);
        u2237[u2238] = nil;
    end));
end;

local u2239 = setmetatable({}, {
    __mode = "k"
});

local function MutatableAdded(u2240: userdata) -- Line: 13949
    -- upvalues: u2239 (copy), u2221 (copy), u2237 (copy), u2236 (copy), Task (copy), UpdateMutTimes (copy), UpdateFX (copy), u1 (copy), u3 (copy), u6 (copy), u2222 (copy)
    if u2240:HasTag("IGNORE_GROWABLE") then
        return;
    end;

    if u2240:GetAttribute("GrowthType") == "Fruit" then
        local v2241 = u2240:FindFirstAncestorWhichIsA("Model");

        if v2241 and v2241:HasTag("IGNORE_GROWABLE") then
            return;
        end;
    end;

    local script_MutationCombos = require(script.MutationCombos);

    if not u2240 then
        warn("MutationHandler.MutatableAdded | No plant");

        return;
    end;

    if u2239[u2240] then
        return;
    end;

    u2239[u2240] = true;
    local u2244 = u2240.AttributeChanged:Connect(function(p2242: string) -- Line: 13967
        -- upvalues: u2221 (ref), u2240 (copy), u2237 (ref), u2236 (ref), Task (ref), UpdateMutTimes (ref), UpdateFX (ref), u1 (ref)
        if not u2221[p2242] then
            return;
        end;

        local u2243 = u2240;

        if u2237[u2243] then
            return;
        end;

        local script_MutationCombos2 = require(script.MutationCombos);
        u2237[u2243] = true;
        u2236:Enqueue(Task.new(function() -- Line: 13930
            -- upvalues: UpdateMutTimes (ref), u2243 (copy), script_MutationCombos2 (copy), UpdateFX (ref), u1 (ref), u2237 (ref)
            UpdateMutTimes(u2243);
            script_MutationCombos2:HandleCombos(u2243);
            UpdateFX(u2243):Await();

            if u2243:HasTag("PlantGenerated") and not u2243:FindFirstAncestorWhichIsA("PlayerGui") then
                u1:SetToolName(u2243);
            end;

            task.wait(0.1);
            u2237[u2243] = nil;
        end));
    end);
    UpdateMutTimes(u2240);
    script_MutationCombos:HandleCombos(u2240);

    if not u2237[u2240] then
        local script_MutationCombos2 = require(script.MutationCombos);
        u2237[u2240] = true;
        u2236:Enqueue(Task.new(function() -- Line: 13930
            -- upvalues: UpdateMutTimes (ref), u2240 (copy), script_MutationCombos2 (copy), UpdateFX (ref), u1 (ref), u2237 (ref)
            UpdateMutTimes(u2240);
            script_MutationCombos2:HandleCombos(u2240);
            UpdateFX(u2240):Await();

            if u2240:HasTag("PlantGenerated") and not u2240:FindFirstAncestorWhichIsA("PlayerGui") then
                u1:SetToolName(u2240);
            end;

            task.wait(0.1);
            u2237[u2240] = nil;
        end));
    end;

    task.delay(nil, function() -- Line: 13990
        -- upvalues: u2240 (copy), u1 (ref)
        if not u2240 then
            return;
        end;

        if u2240:HasTag("PlantGenerated") and not u2240:FindFirstAncestorWhichIsA("PlayerGui") then
            u1:SetToolName(u2240);
        end;
    end);
    local u2246 = u2240.DescendantRemoving:Connect(function(p2245) -- Line: 13998
        -- upvalues: u3 (ref), u6 (ref)
        u3[p2245] = nil;
        u6[p2245] = nil;
    end);
    u2240.Destroying:Once(function() -- Line: 14004
        -- upvalues: u2222 (ref), u2240 (copy), u2239 (ref), u2244 (copy), u2246 (copy), u3 (ref), u6 (ref)
        u2222[u2240] = nil;
        u2239[u2240] = nil;

        if u2244 then
            u2244:Disconnect();
        end;

        u2246:Disconnect();

        for _, descendant in u2240:GetDescendants() do
            if descendant:IsA("BasePart") then
                u3[descendant] = nil;
                u6[descendant] = nil;
            end;
        end;
    end);
end;

if RunService:IsServer() then
    CollectionService:GetInstanceAddedSignal("Harvestable"):Connect(MutatableAdded);
    CollectionService:GetInstanceAddedSignal("FruitTool"):Connect(MutatableAdded);
    CollectionService:GetInstanceAddedSignal("FoodGenerated"):Connect(MutatableAdded);
    CollectionService:GetInstanceAddedSignal("PlantScaled"):Connect(function(u2247) -- Line: 14028
        -- upvalues: u1 (copy), u2237 (copy), u2236 (copy), Task (copy), UpdateMutTimes (copy), UpdateFX (copy)
        if not u1:CanBeMutated(u2247) then
            return;
        end;

        if not (u2247:IsA("Model") or u2247:IsA("Tool")) then
            return;
        end;

        if not u2237[u2247] then
            local script_MutationCombos = require(script.MutationCombos);
            u2237[u2247] = true;
            u2236:Enqueue(Task.new(function() -- Line: 13930
                -- upvalues: UpdateMutTimes (ref), u2247 (copy), script_MutationCombos (copy), UpdateFX (ref), u1 (ref), u2237 (ref)
                UpdateMutTimes(u2247);
                script_MutationCombos:HandleCombos(u2247);
                UpdateFX(u2247):Await();

                if u2247:HasTag("PlantGenerated") and not u2247:FindFirstAncestorWhichIsA("PlayerGui") then
                    u1:SetToolName(u2247);
                end;

                task.wait(0.1);
                u2237[u2247] = nil;
            end));
        end;

        u1:SetToolName(u2247);
    end);
    task.spawn(function() -- Line: 14039
        -- upvalues: u1 (copy)
        while true do
            task.wait(60);
            xpcall(function() -- Line: 14042
                -- upvalues: u1 (ref)
                u1:CheckTimedPlants();
            end, warn);
        end;
    end);
end;

return u1;