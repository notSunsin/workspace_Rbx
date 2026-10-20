-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local _ = Players.LocalPlayer;
local script_Parent = script.Parent;

local function getRoot(p1: userdata) -- Line: 19
    return p1:FindFirstChild("HumanoidRootPart");
end;

local HumanoidRootPart = script_Parent:FindFirstChild("HumanoidRootPart");

if not HumanoidRootPart then
    warn("NPC has no HumanoidRootPart");

    return;
end;

local function getNearestPlayerRoot() -- Line: 29
    -- upvalues: Players (copy), HumanoidRootPart (copy)
    local v2 = (1 / 0);
    local v3 = nil;

    for _, v in ipairs(Players:GetPlayers()) do
        local Character = v.Character;

        if Character then
            local HumanoidRootPart2 = Character:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart2 then
                local Magnitude = (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude;

                if Magnitude < v2 and Magnitude <= 100 then
                    v3 = HumanoidRootPart2;
                    v2 = Magnitude;
                end;
            end;
        end;
    end;

    return v3;
end;

RunService.Heartbeat:Connect(function(p4) -- Line: 53
    -- upvalues: script_Parent (copy), HumanoidRootPart (copy), getNearestPlayerRoot (copy)
    if not script_Parent.Parent then
        return;
    end;

    if not HumanoidRootPart.Parent then
        return;
    end;

    local v5 = getNearestPlayerRoot();

    if not v5 then
        return;
    end;

    local Vector3_new_ret = Vector3.new(v5.Position.X, HumanoidRootPart.Position.Y, v5.Position.Z);
    local Pivot = script_Parent:GetPivot();
    script_Parent:PivotTo(Pivot:Lerp(CFrame.lookAt(Pivot.Position, Vector3_new_ret), (math.clamp(0.25 * p4 * 60, 0, 1))));
end);