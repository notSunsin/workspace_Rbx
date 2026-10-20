-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local HoneyJar = ReplicatedStorage.Assets.HoneyJar;
require(ReplicatedStorage.Modules.SoundPlayer);
local v19 = {
    SpawnRewards = function(p1: table, u2: vector, u3: string) -- Line: 16, Name: SpawnRewards
        -- upvalues: HoneyJar (copy)
        local u4 = HoneyJar:Clone();
        u4:PivotTo(CFrame.new(u2));
        u4.Parent = workspace;
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
        RaycastParams_new_ret.FilterDescendantsInstances = { workspace.BasePlate.TopBaseplate };
        local v5 = workspace:Raycast(u2 + Vector3.new(0, 1, 0), Vector3.new(0, -50, 0));
        local Vector3_new_ret = Vector3.new(u2.X, (v5 and v5.Position.Y or u2.Y - 2) + 1.5, u2.Z);
        local PointLight = Instance.new("PointLight");
        PointLight.Brightness = 2;
        PointLight.Range = 16;
        PointLight.Color = Color3.fromRGB(255, 180, 40);
        PointLight.Parent = u4.PrimaryPart;
        local RunService = game:GetService("RunService");

        local function easeInQuart(p6) -- Line: 42
            return p6 * p6 * p6 * p6;
        end;

        local function easeOutQuart(p7) -- Line: 43
            local v8 = 1 - p7;

            return 1 - v8 * v8 * v8 * v8;
        end;

        local u9 = 0;
        local u10 = nil;
        u10 = RunService.Heartbeat:Connect(function(p11) -- Line: 47
            -- upvalues: u9 (ref), u2 (copy), Vector3_new_ret (copy), u4 (copy), PointLight (copy), RunService (copy), u10 (ref), u3 (copy)
            u9 = u9 + p11;
            local math_clamp_ret = math.clamp(u9 / 0.45, 0, 1);
            local math_lerp_ret = math.lerp(u2.Y, Vector3_new_ret.Y, math_clamp_ret * math_clamp_ret * math_clamp_ret * math_clamp_ret);
            u4:PivotTo(CFrame.new(u2.X, math_lerp_ret, u2.Z));
            local v12 = 1 - math_clamp_ret;
            PointLight.Brightness = math.lerp(2, 1.5, 1 - v12 * v12 * v12 * v12);

            if math_clamp_ret >= 1 then
                PointLight.Brightness = 8;
                PointLight.Range = 25.6;
                local u13 = 0;
                local u14 = nil;
                u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 62
                    -- upvalues: u13 (ref), PointLight (ref), u14 (ref)
                    u13 = u13 + p15;
                    local math_clamp_ret2 = math.clamp(u13 / 0.4, 0, 1);
                    local v16 = 1 - math_clamp_ret2;
                    PointLight.Brightness = math.lerp(8, 1.5, 1 - v16 * v16 * v16 * v16);
                    local v17 = 1 - math_clamp_ret2;
                    PointLight.Range = math.lerp(25.6, 16, 1 - v17 * v17 * v17 * v17);

                    if math_clamp_ret2 >= 1 then
                        u14:Disconnect();
                    end;
                end);
                u10:Disconnect();
                u4:AddTag("HoneyJarReward");
                u4:SetAttribute("Ticket", u3);
            end;
        end);
    end,

    Start = function(p18) -- Line: 82, Name: Start
    end
};
task.spawn(v19.Start, v19);

return v19;