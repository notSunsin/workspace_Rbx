-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
LocalPlayer.CharacterAdded:Connect(function(p2) -- Line: 12
    -- upvalues: u1 (ref), Humanoid (ref)
    u1 = p2;
    Humanoid = u1:WaitForChild("Humanoid");
end);
local GetMouseToWorld = require(ReplicatedStorage.Modules.GetMouseToWorld);
local CosmeticRegistry = require(ReplicatedStorage.Data.CosmeticRegistry);
local RoundToNearestNumberVector3 = require(ReplicatedStorage.Modules.RoundToNearestNumberVector3);
local CosmeticPhyiscalityService = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticPhyiscalityService);
require(ReplicatedStorage.Modules.PlaySound);
local MOVEMENT_CONFIG = CosmeticRegistry.InputConfig.MOVEMENT_CONFIG;
local u3 = {
    LastCFrame = nil,
    ArchivedY = 0,
    RotationLock = false,
    CollisionPartsCache = {},
    Target = nil
};
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 37
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);

local function UnarchiveModelCollisions() -- Line: 41
    -- upvalues: u3 (copy)
    for i, v in u3.CollisionPartsCache do
        i.CanCollide = v;
    end;

    table.clear(u3.CollisionPartsCache);
end;

local function ArchiveModelCollisions(p4: userdata) -- Line: 49
    -- upvalues: u3 (copy)
    u3.CollisionPartsCache = {};

    for _, descendant in p4:GetDescendants() do
        if descendant:IsA("BasePart") then
            u3.CollisionPartsCache[descendant] = descendant.CanCollide;
            descendant.CanCollide = false;
        end;
    end;
end;

local Sound = Instance.new("Sound");
Sound.SoundId = "rbxassetid://100741940041305";
Sound.Volume = 0.5;
Sound.Looped = true;
Sound.Parent = ReplicatedStorage;

function u3.SetTarget(p5: table, p6: userdata) -- Line: 67
    -- upvalues: u3 (copy), Sound (copy), ArchiveModelCollisions (copy)
    u3.Target = p6;
    Sound[p6 and "Play" or "Stop"](Sound);

    for i, v in u3.CollisionPartsCache do
        i.CanCollide = v;
    end;

    table.clear(u3.CollisionPartsCache);

    if p6 then
        ArchiveModelCollisions(p6);
    end;
end;

function u3.ToggleRotationLock(p7: table, p8: boolean) -- Line: 79
    -- upvalues: u3 (copy)
    u3.RotationLock = p8;
end;

function u3.Nudge(p9: table, p10: vector) -- Line: 83
    -- upvalues: u3 (copy), workspace_CurrentCamera (ref), MOVEMENT_CONFIG (copy), CosmeticPhyiscalityService (copy)
    local Target = u3.Target;

    if not Target then
        return;
    end;

    local Parent = Target.Parent;

    if not (Parent and Parent:IsA("BasePart")) then
        return;
    end;

    local CFrame2 = workspace_CurrentCamera.CFrame;
    local Vector3_new_ret = Vector3.new(CFrame2.RightVector.X, 0, CFrame2.RightVector.Z);
    local Vector3_new_ret2 = Vector3.new(CFrame2.LookVector.X, 0, CFrame2.LookVector.Z);

    if Vector3_new_ret.Magnitude <= MOVEMENT_CONFIG.NEAR_ZERO_EPSILON then
        return;
    end;

    if Vector3_new_ret2.Magnitude <= MOVEMENT_CONFIG.NEAR_ZERO_EPSILON then
        return;
    end;

    local v11 = Vector3_new_ret.Unit * p10.X + Vector3_new_ret2.Unit * p10.Z + Vector3.new(0, p10.Y, 0);
    local v12 = Parent.CFrame + v11;
    u3.LastCFrame = v12;
    CosmeticPhyiscalityService:UpdateCFrame(Parent:GetAttribute("CosmeticUUID"), v12);
end;

local u13 = nil;
RunService.RenderStepped:Connect(function() -- Line: 111
    -- upvalues: u3 (copy), CollectionService (copy), u1 (ref), GetMouseToWorld (copy), MOVEMENT_CONFIG (copy), RoundToNearestNumberVector3 (copy), workspace_CurrentCamera (ref), u13 (ref), TweenService (copy), Sound (copy), Humanoid (ref), CosmeticPhyiscalityService (copy)
    local Target = u3.Target;

    if not Target then
        return;
    end;

    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged("CosmeticHitBox");
    RaycastParams_new_ret:AddToFilter(CollectionService:GetTagged("BeeHover"));
    RaycastParams_new_ret:AddToFilter(Target);
    RaycastParams_new_ret:AddToFilter(workspace.PetsPhysical);
    RaycastParams_new_ret:AddToFilter(u1);
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local v14 = GetMouseToWorld(RaycastParams_new_ret, MOVEMENT_CONFIG.MAX_RAY_DISTANCE);

    if not (v14 and v14.Instance) then
        return;
    end;

    local Position = v14.Position;
    local Normal = v14.Normal;
    Target:GetExtentsSize();
    local v15 = Position + Normal * 0;
    local v16 = RoundToNearestNumberVector3(v15, MOVEMENT_CONFIG.MOVEMENT_ROUNDING);
    local X = v16.X;
    local Y = v16.Y;
    local Z = v16.Z;
    local math_abs_ret = math.abs(Normal.X);
    local math_abs_ret2 = math.abs(Normal.Y);
    local math_abs_ret3 = math.abs(Normal.Z);
    local math_max_ret = math.max(math_abs_ret, math_abs_ret2, math_abs_ret3);

    if math.abs(math_max_ret - math_abs_ret2) < MOVEMENT_CONFIG.NEAR_ZERO_EPSILON then
        Y = v15.Y;
    elseif math.abs(math_max_ret - math_abs_ret) < MOVEMENT_CONFIG.NEAR_ZERO_EPSILON then
        X = v15.X;
    else
        Z = v15.Z;
    end;

    local Vector3_new_ret = Vector3.new(X, Y, Z);
    local v17 = Normal:Cross(Vector3.new(0, 0, 1));
    local v18;

    if v17.Magnitude < MOVEMENT_CONFIG.NEAR_ZERO_EPSILON then
        v18 = Normal:Cross(Vector3.new(1, 0, 0)).Unit;
    else
        v18 = v17.Unit;
    end;

    local Unit = v18:Cross(Normal).Unit;
    local LookVector = workspace_CurrentCamera.CFrame.LookVector;
    local Vector3_new_ret2 = Vector3.new(LookVector.X, 0, LookVector.Z);
    local v19 = Vector3_new_ret2.Magnitude < MOVEMENT_CONFIG.NEAR_ZERO_EPSILON and Vector3.new(-0, -0, -1) or Vector3_new_ret2.Unit;
    local v20 = v19 - v19:Dot(Normal) * Normal;
    local v21;

    if v20.Magnitude < MOVEMENT_CONFIG.NEAR_ZERO_EPSILON then
        v21 = Unit;
    else
        v21 = v20.Unit;
    end;

    local v22 = -2;

    for _, v in {
        Unit,
        -Unit,
        v18,
        -v18
    } do
        local v23 = v21:Dot(v);

        if v23 >= v22 then
            Unit = v;
            v22 = v23;
        end;
    end;

    local v24 = Vector3_new_ret + Unit;
    local v25;

    if u3.RotationLock then
        local Rotation = Target:GetPivot().Rotation;
        v25 = CFrame.new(Vector3_new_ret) * Rotation;
    else
        v25 = CFrame.lookAt(Vector3_new_ret, v24, Normal);
    end;

    local Parent = Target.Parent;

    if u3.LastCFrame == v25 then
        if not u13 then
            u13 = task.delay(0.25, function() -- Line: 207
                -- upvalues: TweenService (ref), Sound (ref)
                local v26 = TweenService:Create(Sound, TweenInfo.new(0.2), {
                    Volume = 0
                });
                v26.Completed:Once(function() -- Line: 213
                    -- upvalues: Sound (ref)
                    Sound.Playing = false;
                end);
                v26:Play();
            end);
        end;

        return;
    end;

    if u13 then
        task.cancel(u13);
        u13 = nil;
        TweenService:Create(Sound, TweenInfo.new(0), {
            Volume = 0.5
        }):Play();
    end;

    Humanoid.Sit = false;
    Sound.Playing = true;
    u3.LastCFrame = v25;
    local _ = u3.RotationLock;
    CosmeticPhyiscalityService:UpdateCFrame(Parent:GetAttribute("CosmeticUUID"), v25);
end);

return u3;