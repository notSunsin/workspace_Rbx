-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local SoundService = game:GetService("SoundService");
local CollectionService = game:GetService("CollectionService");
local v1 = {};
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local PlayerGui = Players.LocalPlayer.PlayerGui;
Random.new();
local u2 = CollectionService:GetTagged("BizzyBee2026")[1];
local SneakPeek = u2:FindFirstChild("SneakPeek");
local v3 = SneakPeek and SneakPeek.PrimaryPart and SneakPeek.PrimaryPart:FindFirstChildOfClass("ProximityPrompt");
local BeePreview = SoundService:WaitForChild("BeePreview");
local Bee = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("EventAssets"):WaitForChild("Bee");
BeePreview:WaitForChild("PopSound");

local function getModelRadius(p4) -- Line: 34
    local _, v5 = p4:GetBoundingBox();

    return math.max(v5.X, v5.Y, v5.Z) / 2;
end;

local function spawnBeeSound(p6) -- Line: 40
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://94077578405313";
    Sound.Looped = true;
    Sound.Volume = 0.2;
    Sound.RollOffMaxDistance = 30;
    Sound.RollOffMinDistance = 3;
    Sound.RollOffMode = Enum.RollOffMode.Linear;
    Sound.Parent = p6;
    Sound:Play();
    p6.AncestryChanged:Connect(function(p7: userdata, p8: userdata) -- Line: 51
        -- upvalues: Sound (copy)
        if p8:IsDescendantOf(workspace) then
            Sound:Play();

            return;
        end;

        Sound:Stop();
    end);
end;

local function StartRandomAnimationPlayback(p9) -- Line: 61
    local v10 = p9:FindFirstChildOfClass("AnimationController");
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://100425720753439";
    local v11 = v10:LoadAnimation(Animation);
    v11.Looped = true;
    v11:Play();
end;

local function MoveBeeRandomly(u12, u13) -- Line: 70
    -- upvalues: SneakPeek (copy), TweenService (copy), RunService (copy)
    task.spawn(function() -- Line: 71
        -- upvalues: SneakPeek (ref), u13 (copy), u12 (copy), TweenService (ref), RunService (ref)
        local v14 = math.random() * 3.141592653589793 * 2;

        while SneakPeek.Parent and (u13.Parent and u12.Parent) do
            local _, v15 = u13:GetBoundingBox();
            local v16 = math.max(v15.X, v15.Y, v15.Z) / 2;
            local _, v17 = u13:GetBoundingBox();
            local Position = u13:GetPivot().Position;
            local v18 = Position.Y - v17.Y / 4;
            local v19 = Position.Y + v17.Y / 2;
            local math_random_ret = math.random(10, 25);
            v14 = v14 + math.rad(math_random_ret) * (math.random(0, 1) == 1 and 1 or -1);
            local v20 = v16 + math.random(2, 6);
            local math_random_ret2 = math.random(0, (math.floor(v17.Y)));
            local v21 = Position.X + math.cos(v14) * v20;
            local math_clamp_ret = math.clamp(Position.Y + math_random_ret2, v18, v19);
            local v22 = Position.Z + math.sin(v14) * v20;
            local Vector3_new_ret = Vector3.new(v21, math_clamp_ret, v22);
            local PrimaryPart = u12.PrimaryPart;
            local Position2 = PrimaryPart.Position;
            local Unit = (Vector3_new_ret - Position2).Unit;
            local Unit2 = Vector3.new(Unit.X, 0, Unit.Z).Unit;
            local Magnitude = (Vector3_new_ret - Position2).Magnitude;
            local v23 = CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + Unit2) * CFrame.Angles(0, 1.5707963267948966, 3.141592653589793);
            local v24 = TweenService:Create(u12.PrimaryPart, TweenInfo.new(Magnitude / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                CFrame = v23
            });
            v24:Play();
            v24.Completed:Wait();
            local math_random_ret3 = math.random(1, 3);
            local CFrame2 = PrimaryPart.CFrame;
            local v25 = 0;

            while v25 < math_random_ret3 and u12.Parent do
                v25 = v25 + RunService.RenderStepped:Wait();
                local v26 = math.sin(v25 * 3.141592653589793 * 2) * 0.15;
                PrimaryPart.CFrame = CFrame2 * CFrame.new(0, v26, 0);
            end;
        end;
    end);
end;

function v1.SpawnBees(p27) -- Line: 121
    -- upvalues: SneakPeek (copy), Bee (copy), spawnBeeSound (copy), u2 (copy), TweenService (copy), RunService (copy)
    local beehive = SneakPeek:FindFirstChild("beehive");

    if not beehive then
        warn("No hive");

        return;
    end;

    if SneakPeek:FindFirstChild("BeeHiveBee") then
        return;
    end;

    for i = 1, 4 do
        local u28 = Bee:Clone();
        u28:ScaleTo(0.5);
        u28:PivotTo(CFrame.new(beehive:GetPivot().Position) * CFrame.Angles(0, 0, 3.141592653589793));
        spawnBeeSound(u28.PrimaryPart);
        u28.Name = "BeeHiveBee";
        u28.Parent = u2;
        local v29 = u28:FindFirstChildOfClass("AnimationController");
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://100425720753439";
        local v30 = v29:LoadAnimation(Animation);
        v30.Looped = true;
        v30:Play();
        task.spawn(function() -- Line: 71
            -- upvalues: SneakPeek (ref), beehive (copy), u28 (copy), TweenService (ref), RunService (ref)
            local v31 = math.random() * 3.141592653589793 * 2;

            while SneakPeek.Parent and (beehive.Parent and u28.Parent) do
                local _, v32 = beehive:GetBoundingBox();
                local v33 = math.max(v32.X, v32.Y, v32.Z) / 2;
                local _, v34 = beehive:GetBoundingBox();
                local Position = beehive:GetPivot().Position;
                local v35 = Position.Y - v34.Y / 4;
                local v36 = Position.Y + v34.Y / 2;
                local math_random_ret = math.random(10, 25);
                v31 = v31 + math.rad(math_random_ret) * (math.random(0, 1) == 1 and 1 or -1);
                local v37 = v33 + math.random(2, 6);
                local math_random_ret2 = math.random(0, (math.floor(v34.Y)));
                local v38 = Position.X + math.cos(v31) * v37;
                local math_clamp_ret = math.clamp(Position.Y + math_random_ret2, v35, v36);
                local v39 = Position.Z + math.sin(v31) * v37;
                local Vector3_new_ret = Vector3.new(v38, math_clamp_ret, v39);
                local PrimaryPart = u28.PrimaryPart;
                local Position2 = PrimaryPart.Position;
                local Unit = (Vector3_new_ret - Position2).Unit;
                local Unit2 = Vector3.new(Unit.X, 0, Unit.Z).Unit;
                local Magnitude = (Vector3_new_ret - Position2).Magnitude;
                local v40 = CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + Unit2) * CFrame.Angles(0, 1.5707963267948966, 3.141592653589793);
                local v41 = TweenService:Create(u28.PrimaryPart, TweenInfo.new(Magnitude / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    CFrame = v40
                });
                v41:Play();
                v41.Completed:Wait();
                local math_random_ret3 = math.random(1, 3);
                local CFrame2 = PrimaryPart.CFrame;
                local v42 = 0;

                while v42 < math_random_ret3 and u28.Parent do
                    v42 = v42 + RunService.RenderStepped:Wait();
                    local v43 = math.sin(v42 * 3.141592653589793 * 2) * 0.15;
                    PrimaryPart.CFrame = CFrame2 * CFrame.new(0, v43, 0);
                end;
            end;
        end);
        local _ = i;
    end;
end;

v3.Triggered:Connect(function() -- Line: 148
    -- upvalues: GuiController (copy), PlayerGui (copy)
    GuiController:Open(PlayerGui.BeeSkillTreeUI);
end);

return v1;