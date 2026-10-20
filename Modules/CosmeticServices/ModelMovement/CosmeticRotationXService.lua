-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("CollectionService");
local UserInputService = game:GetService("UserInputService");
require(ReplicatedStorage.Modules.GetMouseToWorld);
local RoundToNearestNumber = require(ReplicatedStorage.Modules.RoundToNearestNumber);
local CosmeticRegistry = require(ReplicatedStorage.Data.CosmeticRegistry);
local CosmeticPhyiscalityService = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticPhyiscalityService);
require(ReplicatedStorage.Modules.PlaySound);
local ROTATION_CONFIG = CosmeticRegistry.InputConfig.ROTATION_CONFIG;
local u1 = {
    CurrentOffset = 0,
    Target = nil,
    StartPivot = nil,
    LastCFrame = nil,
    Target = nil
};
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 25
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local u2 = 0;

function u1.SetTarget(p3: table, p4: userdata) -- Line: 31
    -- upvalues: u1 (copy), u2 (ref), UserInputService (copy)
    u1.LastCFrame = nil;
    u2 = UserInputService:GetMouseLocation().Y;
    u1.Target = nil;
    u1.CurrentOffset = 0;
    local v5;

    if p4 then
        v5 = p4.Parent:GetPivot();
    else
        v5 = nil;
    end;

    u1.StartPivot = v5;
    u1.Target = p4;
end;

local Sound = Instance.new("Sound");
Sound.SoundId = "rbxassetid://103926661258479";
Sound.Volume = 0.2;
Sound.Parent = ReplicatedStorage;

local function UpdatePosition() -- Line: 46
    -- upvalues: u1 (copy), UserInputService (copy), u2 (ref), RoundToNearestNumber (copy), ROTATION_CONFIG (copy), Sound (copy), CosmeticPhyiscalityService (copy)
    if not u1.Target then
        return;
    end;

    local Y = UserInputService:GetMouseLocation().Y;
    local v6 = u1;
    v6.CurrentOffset = v6.CurrentOffset + (Y - u2);
    u2 = Y;
    local v7 = RoundToNearestNumber(u1.CurrentOffset, ROTATION_CONFIG.ROTATION_ROUNDING_PIXEL) / ROTATION_CONFIG.ROTATION_ROUNDING_PIXEL;
    local v8 = u1.StartPivot * CFrame.Angles(math.rad(v7 * ROTATION_CONFIG.ROTATION_STEP_DEGREE), 0, 0);
    local Parent = u1.Target.Parent;

    if u1.LastCFrame == v8 then
        return;
    end;

    u1.LastCFrame = v8;
    Sound.PlaybackSpeed = Random.new():NextNumber(0.95, 1.05);
    Sound:Play();
    CosmeticPhyiscalityService:UpdateCFrame(Parent:GetAttribute("CosmeticUUID"), v8);
end;

RunService.RenderStepped:Connect(function() -- Line: 75
    -- upvalues: UpdatePosition (copy)
    UpdatePosition();
end);
local u11 = {
    [Enum.KeyCode.DPadLeft] = {
        Test = function() -- Line: 81
            -- upvalues: u1 (copy)
            local v9 = u1;
            v9.CurrentOffset = v9.CurrentOffset - 30;
        end
    },
    [Enum.KeyCode.DPadRight] = {
        Test = function() -- Line: 86
            -- upvalues: u1 (copy)
            local v10 = u1;
            v10.CurrentOffset = v10.CurrentOffset + 30;
        end
    }
};
local u12 = {};
UserInputService.InputBegan:Connect(function(u13, p14) -- Line: 104
    -- upvalues: u11 (copy)
    local v15 = u11[u13.KeyCode] or u11[u13.UserInputType];

    if not v15 then
        return;
    end;

    for _, v in v15 do
        task.spawn(function() -- Line: 108
            -- upvalues: v (copy), u13 (copy)
            v(u13);
        end);
    end;
end);
UserInputService.InputEnded:Connect(function(u16, p17) -- Line: 114
    -- upvalues: u12 (copy)
    local v18 = u12[u16.KeyCode] or u12[u16.UserInputType];

    if not v18 then
        return;
    end;

    for _, v in v18 do
        task.spawn(function() -- Line: 118
            -- upvalues: v (copy), u16 (copy)
            v(u16);
        end);
    end;
end);

return u1;