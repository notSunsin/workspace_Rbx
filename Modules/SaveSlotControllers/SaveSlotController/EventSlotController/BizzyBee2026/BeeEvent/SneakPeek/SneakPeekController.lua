-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local SoundService = game:GetService("SoundService");
local CollectionService = game:GetService("CollectionService");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local Random_new_ret = Random.new();
local script_Parent = script.Parent;
local SkillTreePrompt = script_Parent.PrimaryPart.SkillTreePrompt;
local BeePreview = SoundService:WaitForChild("BeePreview");
local Bee = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("EventAssets"):WaitForChild("Bee");
BeePreview:WaitForChild("PopSound");
local u1 = CollectionService:GetTagged("BizzyBee2026")[1];

local function getModelRadius(p2) -- Line: 32
    local _, v3 = p2:GetBoundingBox();

    return math.max(v3.X, v3.Y, v3.Z) / 2;
end;

local function spawnBeeSound(p4) -- Line: 38
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://94077578405313";
    Sound.Looped = true;
    Sound.Volume = 0.2;
    Sound.RollOffMaxDistance = 30;
    Sound.RollOffMinDistance = 3;
    Sound.RollOffMode = Enum.RollOffMode.Linear;
    Sound.Parent = p4;
    Sound:Play();
    p4.AncestryChanged:Connect(function(p5: userdata, p6: userdata) -- Line: 49
        -- upvalues: Sound (copy)
        if p6:IsDescendantOf(workspace) then
            Sound:Play();

            return;
        end;

        Sound:Stop();
    end);
end;

local function StartRandomAnimationPlayback(p7) -- Line: 60
    local v8 = p7:FindFirstChildOfClass("AnimationController");
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://100425720753439";
    local v9 = v8:LoadAnimation(Animation);
    v9.Looped = true;
    v9:Play();
end;

local function MoveBeeRandomly(u10, u11) -- Line: 185
    -- upvalues: script_Parent (copy), TweenService (copy), RunService (copy)
    task.spawn(function() -- Line: 186
        -- upvalues: script_Parent (ref), u11 (copy), u10 (copy), TweenService (ref), RunService (ref)
        local v12 = math.random() * 3.141592653589793 * 2;

        while script_Parent.Parent and (u11.Parent and u10.Parent) do
            local _, v13 = u11:GetBoundingBox();
            local v14 = math.max(v13.X, v13.Y, v13.Z) / 2;
            local _, v15 = u11:GetBoundingBox();
            local Position = u11:GetPivot().Position;
            local v16 = Position.Y - v15.Y / 4;
            local v17 = Position.Y + v15.Y / 2;
            local math_random_ret = math.random(10, 25);
            v12 = v12 + math.rad(math_random_ret) * (math.random(0, 1) == 1 and 1 or -1);
            local v18 = v14 + math.random(2, 6);
            local math_random_ret2 = math.random(0, (math.floor(v15.Y)));
            local v19 = Position.X + math.cos(v12) * v18;
            local math_clamp_ret = math.clamp(Position.Y + math_random_ret2, v16, v17);
            local v20 = Position.Z + math.sin(v12) * v18;
            local Vector3_new_ret = Vector3.new(v19, math_clamp_ret, v20);
            local Unit = (Vector3_new_ret - u10.PrimaryPart.Position).Unit;
            local Unit2 = Vector3.new(Unit.X, 0, Unit.Z).Unit;
            local Magnitude = (Vector3_new_ret - u10.PrimaryPart.Position).Magnitude;
            local v21 = CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + Unit2) * CFrame.Angles(0, 1.5707963267948966, 3.141592653589793);
            local v22 = TweenService:Create(u10.PrimaryPart, TweenInfo.new(Magnitude / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                CFrame = v21
            });
            v22:Play();
            v22.Completed:Wait();
            local math_random_ret3 = math.random(1, 3);
            local CFrame2 = u10.PrimaryPart.CFrame;
            local v23 = 0;

            while v23 < math_random_ret3 and u10.Parent do
                v23 = v23 + RunService.RenderStepped:Wait();
                local v24 = math.sin(v23 * 3.141592653589793 * 2) * 0.15;
                u10.PrimaryPart.CFrame = CFrame2 * CFrame.new(0, v24, 0);
            end;
        end;
    end);
end;

SkillTreePrompt.Triggered:Connect(function() -- Line: 251
    -- upvalues: GuiController (copy), PlayerGui (copy)
    GuiController:Open(PlayerGui.BeeSkillTreeUI);
end);
(function() -- Line: 234, Name: SpawnBees
    -- upvalues: script_Parent (copy), Bee (copy), Random_new_ret (copy), spawnBeeSound (copy), u1 (copy), TweenService (copy), RunService (copy)
    local beehive = script_Parent.beehive;

    for i = 1, 4 do
        local u25 = Bee:Clone();
        u25:ScaleTo(0.5);
        u25:PivotTo(CFrame.new(beehive:GetPivot().Position) * CFrame.Angles(0, 0, 3.141592653589793));
        task.delay(Random_new_ret:NextNumber(0, 1), function() -- Line: 242
            -- upvalues: spawnBeeSound (ref), u25 (copy), u1 (ref)
            spawnBeeSound(u25.PrimaryPart);
            u25.Parent = u1;
        end);
        local v26 = u25:FindFirstChildOfClass("AnimationController");
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://100425720753439";
        local v27 = v26:LoadAnimation(Animation);
        v27.Looped = true;
        v27:Play();
        task.spawn(function() -- Line: 186
            -- upvalues: script_Parent (ref), beehive (copy), u25 (copy), TweenService (ref), RunService (ref)
            local v28 = math.random() * 3.141592653589793 * 2;

            while script_Parent.Parent and (beehive.Parent and u25.Parent) do
                local _, v29 = beehive:GetBoundingBox();
                local v30 = math.max(v29.X, v29.Y, v29.Z) / 2;
                local _, v31 = beehive:GetBoundingBox();
                local Position = beehive:GetPivot().Position;
                local v32 = Position.Y - v31.Y / 4;
                local v33 = Position.Y + v31.Y / 2;
                local math_random_ret = math.random(10, 25);
                v28 = v28 + math.rad(math_random_ret) * (math.random(0, 1) == 1 and 1 or -1);
                local v34 = v30 + math.random(2, 6);
                local math_random_ret2 = math.random(0, (math.floor(v31.Y)));
                local v35 = Position.X + math.cos(v28) * v34;
                local math_clamp_ret = math.clamp(Position.Y + math_random_ret2, v32, v33);
                local v36 = Position.Z + math.sin(v28) * v34;
                local Vector3_new_ret = Vector3.new(v35, math_clamp_ret, v36);
                local Unit = (Vector3_new_ret - u25.PrimaryPart.Position).Unit;
                local Unit2 = Vector3.new(Unit.X, 0, Unit.Z).Unit;
                local Magnitude = (Vector3_new_ret - u25.PrimaryPart.Position).Magnitude;
                local v37 = CFrame.lookAt(Vector3_new_ret, Vector3_new_ret + Unit2) * CFrame.Angles(0, 1.5707963267948966, 3.141592653589793);
                local v38 = TweenService:Create(u25.PrimaryPart, TweenInfo.new(Magnitude / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    CFrame = v37
                });
                v38:Play();
                v38.Completed:Wait();
                local math_random_ret3 = math.random(1, 3);
                local CFrame2 = u25.PrimaryPart.CFrame;
                local v39 = 0;

                while v39 < math_random_ret3 and u25.Parent do
                    v39 = v39 + RunService.RenderStepped:Wait();
                    local v40 = math.sin(v39 * 3.141592653589793 * 2) * 0.15;
                    u25.PrimaryPart.CFrame = CFrame2 * CFrame.new(0, v40, 0);
                end;
            end;
        end);
        local _ = i;
    end;
end)();

return {};