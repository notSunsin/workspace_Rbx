-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local GuiService = game:GetService("GuiService");
local CosmeticEffectsUtils = require(ReplicatedStorage.Modules.CosmeticEffects.CosmeticEffectsUtils);
local CosmeticEffectInvoker = require(ReplicatedStorage.Modules.CosmeticEffects.CosmeticEffectInvoker);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local u1 = {};

local function findFirstAnscentorWithTag(p2: userdata?, p3: string) -- Line: 23
    if not p2 then
        return p2;
    end;

    repeat
        p2 = p2.Parent;
    until not p2 or p2:HasTag(p3);

    return p2;
end;

local function castRayFromScreen(p4) -- Line: 35
    -- upvalues: workspace_CurrentCamera (copy), u1 (ref)
    local function visualizeRay(p5: vector, p6: vector, p7: number, p8) -- Line: 36
        local v9;

        if p8 then
            v9 = p8.Position;
        else
            v9 = p5 + p6 * p7;
        end;

        local Part = Instance.new("Part");
        Part.Size = Vector3.new(0.05, 0.05, (v9 - p5).Magnitude);
        Part.CFrame = CFrame.new(p5, v9) * CFrame.new(0, 0, -Part.Size.Z / 2);
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.Material = Enum.Material.Neon;
        Part.Color = p8 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0);
        Part.Parent = workspace;
        game:GetService("Debris"):AddItem(Part, 5);
    end;

    local v10 = workspace_CurrentCamera:ViewportPointToRay(p4.X, p4.Y);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterDescendantsInstances = u1;
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;

    return workspace:Raycast(v10.Origin, v10.Direction * 50, RaycastParams_new_ret);
end;

local function TryActivateCosmeticEffect(p11) -- Line: 70
    -- upvalues: castRayFromScreen (copy), CosmeticEffectInvoker (copy)
    local v12 = castRayFromScreen(p11);

    if not v12 then
        return;
    end;

    local Instance2 = v12.Instance;

    if not Instance2 then
        return;
    end;

    if Instance2 then
        repeat
            Instance2 = Instance2.Parent;
        until not Instance2 or Instance2:HasTag("CosmeticEffect");
    end;

    if not Instance2 then
        warn("Cannot find Cosmetic Model Instance");

        return;
    end;

    local Attribute = Instance2:GetAttribute("EffectType");

    if Attribute then
        CosmeticEffectInvoker:PlayEffect(Instance2, Attribute);

        return;
    end;

    warn((`No EffectType attribute found on {Instance2}`));
end;

UserInputService.InputBegan:Connect(function(p13: userdata, p14: boolean) -- Line: 97
    -- upvalues: CosmeticEffectsUtils (copy), LocalPlayer (copy), TryActivateCosmeticEffect (copy), UserInputService (copy)
    if p14 then
        return;
    end;

    local v15 = CosmeticEffectsUtils.IsPlayerOnFarm(LocalPlayer);

    if p13.UserInputType == Enum.UserInputType.MouseButton1 and v15 then
        TryActivateCosmeticEffect(UserInputService:GetMouseLocation());
    end;
end);
UserInputService.TouchTap:Connect(function(p16: table, p17: boolean) -- Line: 110
    -- upvalues: CosmeticEffectsUtils (copy), LocalPlayer (copy), TryActivateCosmeticEffect (copy), GuiService (copy)
    if p17 then
        return;
    end;

    local v18 = CosmeticEffectsUtils.IsPlayerOnFarm(LocalPlayer);

    if #p16 > 0 and v18 then
        TryActivateCosmeticEffect(p16[1] + GuiService:GetGuiInset());
    end;
end);
CreateTagHandler({
    Tag = "CosmeticEffect",

    OnInstanceAdded = function(p19: userdata) -- Line: 123, Name: OnInstanceAdded
        -- upvalues: u1 (ref), CollectionService (copy)
        if not p19:IsDescendantOf(workspace) then
            return;
        end;

        u1 = CollectionService:GetTagged("CosmeticEffect");
    end,

    OnInstanceRemoved = function(p20: userdata) -- Line: 129, Name: OnInstanceRemoved
        -- upvalues: u1 (ref), CollectionService (copy)
        u1 = CollectionService:GetTagged("CosmeticEffect");
    end
});

return {};