-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local LocalPlayer = Players.LocalPlayer;
local v1 = {};

local function FindCosmeticPart(p2: string) -- Line: 18
    -- upvalues: GetFarm (copy), LocalPlayer (copy)
    local v3 = GetFarm(LocalPlayer);

    if v3 then
        v3 = v3:FindFirstChild("Important");
    end;

    if v3 then
        v3 = v3:FindFirstChild("Cosmetic_Physical");
    end;

    if not v3 then
        return nil;
    end;

    for _, child in v3:GetChildren() do
        if child:GetAttribute("CosmeticUUID") == p2 then
            return child;
        end;
    end;

    return nil;
end;

local function PrepareClone(p4: userdata) -- Line: 35
    -- upvalues: CollectionService (copy)
    local v5 = p4:Clone();

    for _, v in CollectionService:GetTags(v5) do
        v5:RemoveTag(v);
    end;

    for _, descendant in v5:GetDescendants() do
        local v6 = descendant;

        for _, v in CollectionService:GetTags(descendant) do
            v6:RemoveTag(v);
        end;

        if v6:IsA("LuaSourceContainer") or (v6:IsA("ProximityPrompt") or (v6:IsA("ClickDetector") or v6:IsA("Sound"))) then
            v6:Destroy();
        elseif v6:IsA("BasePart") then
            v6.Anchored = true;
            v6.CanCollide = false;
            v6.CanQuery = false;
            v6.CanTouch = false;
        end;
    end;

    return v5;
end;

local function HideOriginal(u7: userdata) -- Line: 63
    local u8 = {};

    for _, descendant in u7:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = 1;
            table.insert(u8, function() -- Line: 69
                -- upvalues: descendant (copy)
                descendant.LocalTransparencyModifier = 0;
            end);
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = 1;
            table.insert(u8, function() -- Line: 75
                -- upvalues: descendant (copy), Transparency (copy)
                descendant.Transparency = Transparency;
            end);
        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Light") or (descendant:IsA("Beam") or (descendant:IsA("Trail") or (descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui"))))) then
            local Enabled = descendant.Enabled;
            descendant.Enabled = false;
            table.insert(u8, function() -- Line: 81
                -- upvalues: descendant (copy), Enabled (copy)
                descendant.Enabled = Enabled;
            end);
        end;
    end;

    task.delay(2, function() -- Line: 87
        -- upvalues: u7 (copy), u8 (copy)
        if not u7:IsDescendantOf(workspace) then
            return;
        end;

        for _, v in u8 do
            v();
        end;
    end);
end;

local function GetTargetPosition(p9: vector) -- Line: 98
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character then
        return Character.Position;
    end;

    return p9;
end;

function v1.Play(p10: table, p11: string) -- Line: 108
    -- upvalues: FindCosmeticPart (copy), PrepareClone (copy), HideOriginal (copy), RunService (copy), LocalPlayer (copy)
    local v12 = FindCosmeticPart(p11);

    if v12 then
        v12 = v12:FindFirstChildWhichIsA("Model", true);
    end;

    if not v12 then
        return;
    end;

    local u13 = PrepareClone(v12);
    local Pivot = v12:GetPivot();
    local Scale = u13:GetScale();
    local Position = Pivot.Position;
    local u14 = Pivot - Position;
    HideOriginal(v12);
    u13.Parent = workspace.CurrentCamera;
    local u15 = 0;
    local u16 = nil;
    u16 = RunService.RenderStepped:Connect(function(p17) -- Line: 126
        -- upvalues: u15 (ref), u13 (copy), u16 (ref), Position (copy), LocalPlayer (ref), Scale (copy), u14 (copy)
        u15 = u15 + p17;
        local math_clamp_ret = math.clamp(u15 / 0.45, 0, 1);
        local v18 = math_clamp_ret * math_clamp_ret;

        if math_clamp_ret >= 1 or not u13.Parent then
            u16:Disconnect();
            u13:Destroy();

            return;
        end;

        local v19 = Position;
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if Character then
            v19 = Character.Position;
        end;

        local v20 = Position:Lerp(v19, v18);
        local v21 = math.sin(math_clamp_ret * 3.141592653589793) * 3;
        local v22 = v20 + Vector3.new(0, v21, 0);
        local CFrame_Angles_ret = CFrame.Angles(0, u15 * 9.42477796076938, 0);
        u13:ScaleTo((math.max(Scale * (1 - v18), 0.01)));
        u13:PivotTo(CFrame.new(v22) * u14 * CFrame_Angles_ret);
    end);
end;

return v1;