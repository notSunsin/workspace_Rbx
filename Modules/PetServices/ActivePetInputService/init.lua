-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
game:GetService("GuiService");
game:GetService("CollectionService");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PetInformationUserInterfaceService = require(ReplicatedStorage.Modules.PetServices.PetInformationUserInterfaceService);
local PetActionUserInterfaceService = require(ReplicatedStorage.Modules.PetServices.PetActionUserInterfaceService);
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 16
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local GetMouseToWorld = require(ReplicatedStorage.Modules.GetMouseToWorld);
local Highlight = Instance.new("Highlight");
Highlight.FillTransparency = 1;
local u1 = nil;
local u2 = nil;

local function TargettingInputBegan() -- Line: 28
    -- upvalues: u2 (ref), TweenService (copy), Highlight (copy)
    if not u2 then
        return;
    end;

    TweenService:Create(Highlight, TweenInfo.new(0.2), {
        OutlineTransparency = 0.8
    }):Play();
end;

local function TargettingInputEnded() -- Line: 38
    -- upvalues: u2 (ref), TweenService (copy), Highlight (copy), LocalPlayer (copy), PetActionUserInterfaceService (copy)
    if not u2 then
        return;
    end;

    TweenService:Create(Highlight, TweenInfo.new(0.2), {
        OutlineTransparency = 0
    }):Play();

    if LocalPlayer:GetAttribute("DontOpenAction") then
        return;
    end;

    if PetActionUserInterfaceService.Target == u2 then
        PetActionUserInterfaceService:Toggle(false);

        return;
    end;

    if PetActionUserInterfaceService.Target ~= nil then
        PetActionUserInterfaceService:Toggle(false);
    end;

    task.delay(0.1, function() -- Line: 59
        -- upvalues: PetActionUserInterfaceService (ref), u2 (ref)
        PetActionUserInterfaceService:SetTarget(u2);
        PetActionUserInterfaceService:Toggle(true);
    end);
end;

local u4 = {
    [Enum.UserInputType.Touch] = { function(p3: userdata) -- Line: 67
            -- upvalues: TargettingInputBegan (copy)
            TargettingInputBegan();
        end },
    [Enum.UserInputType.MouseButton1] = { function() -- Line: 72
            -- upvalues: TargettingInputBegan (copy)
            TargettingInputBegan();
        end },
    [Enum.KeyCode.ButtonR2] = { function() -- Line: 77
            -- upvalues: TargettingInputBegan (copy)
            TargettingInputBegan();
        end }
};
local u6 = {
    [Enum.UserInputType.Touch] = { function(p5: userdata) -- Line: 85
            -- upvalues: TargettingInputEnded (copy)
            TargettingInputEnded();
        end },
    [Enum.UserInputType.MouseButton1] = { function() -- Line: 90
            -- upvalues: TargettingInputEnded (copy)
            TargettingInputEnded();
        end },
    [Enum.KeyCode.ButtonR2] = { function() -- Line: 95
            -- upvalues: TargettingInputEnded (copy)
            TargettingInputEnded();
        end }
};
UserInputService.InputBegan:Connect(function(u7, p8) -- Line: 101
    -- upvalues: u4 (copy)
    local v9 = u4[u7.KeyCode] or u4[u7.UserInputType];

    if not v9 then
        return;
    end;

    for _, v in v9 do
        task.spawn(function() -- Line: 108
            -- upvalues: v (copy), u7 (copy)
            v(u7);
        end);
    end;
end);
UserInputService.InputEnded:Connect(function(u10, p11) -- Line: 114
    -- upvalues: u6 (copy)
    local v12 = u6[u10.KeyCode] or u6[u10.UserInputType];

    if not v12 then
        return;
    end;

    for _, v in v12 do
        task.spawn(function() -- Line: 121
            -- upvalues: v (copy), u10 (copy)
            v(u10);
        end);
    end;
end);
UserInputService.TouchTap:Connect(function() -- Line: 127
    -- upvalues: TargettingInputBegan (copy)
    TargettingInputBegan();
end);
UserInputService.TouchEnded:Connect(function() -- Line: 131
    -- upvalues: TargettingInputEnded (copy)
    TargettingInputEnded();
end);
Highlight.Parent = script;
task.spawn(function() -- Line: 137
    -- upvalues: UserInputService (copy), u1 (ref), GetMouseToWorld (copy), PetActionUserInterfaceService (copy), PetInformationUserInterfaceService (copy), u2 (ref), Highlight (copy)
    while true do
        u1 = UserInputService:GetMouseLocation();
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterDescendantsInstances = {};
        local v13 = GetMouseToWorld(RaycastParams_new_ret, 1000);

        if v13 then
            v13 = v13.Instance;
        end;

        if v13 then
            v13 = v13:FindFirstAncestor("PetMover");
        end;

        if PetActionUserInterfaceService.Active then
            if PetActionUserInterfaceService.Target == PetActionUserInterfaceService.Target then
                PetInformationUserInterfaceService:Toggle(false);
            end;
        else
            PetInformationUserInterfaceService:SetTarget(v13);

            if v13 then
                PetInformationUserInterfaceService:Toggle(true);
            else
                PetInformationUserInterfaceService:Toggle(false);
            end;
        end;

        if v13 and v13:FindFirstChildWhichIsA("Model", true) then
            u2 = v13;

            if v13 then
                v13 = v13:FindFirstChildWhichIsA("Model", true);
            end;

            Highlight.Adornee = v13;
        else
            u2 = nil;
            Highlight.Adornee = nil;
        end;

        task.wait(0.2);
    end;
end);

return {};