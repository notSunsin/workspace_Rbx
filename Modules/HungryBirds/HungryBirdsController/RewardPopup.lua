-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Trove = require(ReplicatedStorage.Modules.Trove);
local v1 = {};
v1.__index = v1;
local u2 = {
    PopHeight = 3,
    PopDuration = 0.5,
    HoverDuration = 1.5,
    FollowDuration = 1,
    PartSize = Vector3.new(2, 2, 2),
    CurveHeight = 5,
    ImageSize = UDim2.fromScale(1, 1)
};
local script_RewardPart = script.RewardPart;
script_RewardPart.Parent = nil;

function v1.Create(p3: vector, p4: string, p5: table?, u6: function) -- Line: 30
    -- upvalues: u2 (copy), Trove (copy), script_RewardPart (copy), TweenService (copy), RunService (copy), Players (copy)
    local v7 = p5 or {};
    local v8 = v7.PopHeight or u2.PopHeight;
    local v9 = v7.PopDuration or u2.PopDuration;
    local v10 = v7.HoverDuration or u2.HoverDuration;
    local u11 = v7.FollowDuration or u2.FollowDuration;

    if not v7.ImageSize then
        local _ = u2.ImageSize;
    end;

    if not v7.PartSize then
        local _ = u2.PartSize;
    end;

    local u12 = v7.CurveHeight or u2.CurveHeight;
    local u13 = Trove.new();
    local u14 = script_RewardPart:Clone();
    u14.Position = p3;
    u14.Name = "DEBRIS";
    u13:Add(u14);
    u14.BillboardGui.ImageLabel.Image = p4;
    u14.Parent = workspace.Terrain;
    local v15 = p3 + Vector3.new(0, v8, 0);
    TweenService:Create(u14, TweenInfo.new(v9, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = v15
    }):Play();
    u13:Add(RunService.Heartbeat:Connect(function(p16) -- Line: 79
        -- upvalues: u14 (copy)
        if not u14 then
            return;
        end;

        local Sunshine = u14.BillboardGui.Sunshine;
        Sunshine.Rotation = Sunshine.Rotation + 45 * p16 % 360;
    end));
    u13:Add(task.delay(v9 + v10, function() -- Line: 88
        -- upvalues: Players (ref), u13 (copy), u14 (copy), RunService (ref), u11 (copy), u12 (copy), u6 (copy)
        local LocalPlayer = Players.LocalPlayer;

        if not (LocalPlayer and LocalPlayer.Character) then
            u13:Destroy();

            return;
        end;

        local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            u13:Destroy();

            return;
        end;

        local Position = u14.Position;
        local u17 = 0;
        u14.Anchored = true;
        u13:Add(RunService.Heartbeat:Connect(function(p18) -- Line: 117
            -- upvalues: u17 (ref), u11 (ref), HumanoidRootPart (copy), Position (copy), u12 (ref), u14 (ref), u13 (ref), u6 (ref)
            u17 = u17 + p18;
            local math_min_ret = math.min(u17 / u11, 1);
            local v19 = 1 - math.pow(1 - math_min_ret, 3);
            local v20 = HumanoidRootPart.Position + Vector3.new(0, 2, 0);
            local v21 = (Position + v20) / 2 + Vector3.new(0, u12, 0);
            u14.Position = Position:Lerp(v21, v19):Lerp(v21:Lerp(v20, v19), v19);
            local v22 = 1 - v19 * 0.5;
            u14.BillboardGui.Size = UDim2.fromScale(v22 * 4, v22 * 4);

            if math_min_ret >= 1 then
                u13:Destroy();

                if u6 then
                    u6();
                end;
            end;
        end));
    end));

    return u14;
end;

return v1;