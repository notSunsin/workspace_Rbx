-- Decompiled with Potassium's decompiler.

local u1 = {};
game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local GardenLevelData = require(ReplicatedStorage.Data.GardenLevel.GardenLevelData);
local Particle2D = require(ReplicatedStorage.Code.Particle2D);
require(ReplicatedStorage.Code.Spr);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
require(ReplicatedStorage.Data.SoundData);
local RE_ExperienceGained = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("RE_ExperienceGained");
local u2 = Players.LocalPlayer.PlayerGui:WaitForChild("Experience Bar");
local CurrentLevelTextLabel = u2:FindFirstChild("CurrentLevelTextLabel", true);
local NextLevelTextLabel = u2:FindFirstChild("NextLevelTextLabel", true);
local PROGRESS_FILL = u2:FindFirstChild("PROGRESS_FILL", true);
local PROGRESSION_AMOUNT = u2:FindFirstChild("PROGRESSION_AMOUNT", true);

local function PlaySound(p3) -- Line: 39
    -- upvalues: SoundPlayer (copy), ReplicatedStorage (copy)
    local u4 = SoundPlayer:PlaySound(p3, nil, nil, ReplicatedStorage);
    u4.Ended:Once(function() -- Line: 42
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
    u4:Play();

    return u4;
end;

local function burstParticles() -- Line: 50
    -- upvalues: NextLevelTextLabel (copy), u2 (copy), TweenService (copy), Particle2D (copy)
    local Random_new_ret = Random.new();

    for i = 1, 10 do
        local v5 = Random_new_ret:NextNumber(0, 359);
        local v6 = Random_new_ret:NextInteger(20, 45);
        local v7 = Random_new_ret:NextNumber(-10, 10);
        local math_rad_ret = math.rad(v5);
        local v8 = v7 * math.cos(math_rad_ret);
        local math_rad_ret2 = math.rad(v5);
        local v9 = v7 * math.sin(math_rad_ret2);
        local v10 = NextLevelTextLabel.AbsolutePosition + NextLevelTextLabel.AbsoluteSize / 2;
        local u11;

        if Random_new_ret:NextInteger(0, 1) == 1 then
            u11 = script.Sparkle:Clone();
        else
            u11 = script.Sparkle2:Clone();
        end;

        u11.Position = UDim2.fromOffset(v10.X, v10.Y) + UDim2.fromOffset(v8, v9);
        u11.Size = UDim2.fromOffset(v6, v6);
        u11.Parent = u2;
        local u12 = Random_new_ret:NextNumber(0, 0.5);
        task.spawn(function() -- Line: 70
            -- upvalues: TweenService (ref), u11 (copy), u12 (copy)
            TweenService:Create(u11, TweenInfo.new(1), {
                ImageTransparency = u12
            }):Play();
            task.wait(1);
            TweenService:Create(u11, TweenInfo.new(1), {
                ImageTransparency = 1
            }):Play();
        end);
        local UDim2_fromOffset = UDim2.fromOffset;
        local math_rad_ret3 = math.rad(v5);
        local v13 = math.cos(math_rad_ret3) * 500;
        local math_rad_ret4 = math.rad(v5);
        local v14 = UDim2_fromOffset(v13, math.sin(math_rad_ret4) * -500);
        local UDim2_fromOffset_ret = UDim2.fromOffset(0, 4);
        Particle2D.createParticle(u11, 1.5, v14, Random_new_ret:NextInteger(-45, 45), UDim2_fromOffset_ret, UDim2.fromOffset(5, 5), 0, 0, nil, 0.3);
        local _ = i;
    end;
end;

local u15 = {};
local u16 = false;
local u17 = nil;

function u1.UpdateProgression(p18) -- Line: 87
    -- upvalues: u16 (ref), u15 (copy), u2 (copy), TweenService (copy), GardenLevelData (copy), u17 (ref), PROGRESS_FILL (copy), CurrentLevelTextLabel (copy), NextLevelTextLabel (copy), PROGRESSION_AMOUNT (copy), SoundPlayer (copy), ReplicatedStorage (copy), RunService (copy), burstParticles (copy), u1 (copy)
    if u16 then
        return;
    end;

    local table_remove_ret = table.remove(u15, 1);

    if not table_remove_ret then
        return;
    end;

    local table_unpack_ret, v19, v20 = table.unpack(table_remove_ret);
    u16 = true;
    u2.Enabled = true;
    TweenService:Create(u2.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.15)
    }):Play();
    task.wait(0.1);
    local MaxLevel = GardenLevelData.GetMaxLevel();
    local v21 = GardenLevelData.CalculateLevel(table_unpack_ret);
    local math_min_ret = math.min(v21, MaxLevel);
    local math_min_ret2 = math.min(table_unpack_ret, GardenLevelData.CalculateXPForLevel(MaxLevel));
    local math_min_ret3 = math.min(v19, GardenLevelData.CalculateXPForLevel(MaxLevel));
    local v22 = GardenLevelData.CalculateLevel(math_min_ret3);
    local math_min_ret4 = math.min(v22, MaxLevel);
    local v23 = MaxLevel <= math_min_ret4;
    local v24;

    if math_min_ret == math_min_ret4 then
        v24 = false;
    else
        v24 = not v20;
    end;

    for i = math_min_ret, math_min_ret4 do
        local v25 = MaxLevel <= i and true or v20;
        local v26 = GardenLevelData.CalculateXPForLevel(i);
        local v27 = GardenLevelData.CalculateXPForLevel(i + 1);
        local v28 = v27 - v26;
        local math_min_ret5 = math.min(v27, math_min_ret3);

        if v24 and (not v25 and math_min_ret < i) then
            if u17 then
                u17:Stop();
                u17 = nil;
            end;

            PROGRESS_FILL.Size = UDim2.fromScale(0, 1);
        end;

        CurrentLevelTextLabel.Text = math.min(i, MaxLevel);
        NextLevelTextLabel.Text = math.min(i + 1, MaxLevel);
        local v29 = i == MaxLevel and 1 or (math_min_ret5 - v26) / v28;
        local v30;

        if v25 then
            PROGRESS_FILL.Size = UDim2.fromScale(v29, 1);
            PROGRESSION_AMOUNT.Text = v23 and "Max Level" or `{GardenLevelData.GetXPEarnedCurrentLevel(math_min_ret5)}/{v28}`;
            v30 = i;
        else
            TweenService:Create(PROGRESS_FILL, TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(v29, 1)
            }):Play();
            local u31 = SoundPlayer:PlaySound("rbxassetid://107236243618748", nil, nil, ReplicatedStorage);
            u31.Ended:Once(function() -- Line: 42
                -- upvalues: u31 (copy)
                u31:Destroy();
            end);
            u31:Play();
            u17 = u31;
            v30 = i;
            local v32 = 0;

            while v32 < 0.5 do
                v32 = v32 + RunService.Heartbeat:Wait();
                local math_clamp_ret = math.clamp(v32 / 0.5, 0, 1);
                local math_lerp_ret = math.lerp(math_min_ret2, math_min_ret5, math_clamp_ret);
                local math_floor_ret = math.floor(math_lerp_ret);
                local XPEarnedCurrentLevel = GardenLevelData.GetXPEarnedCurrentLevel(math_floor_ret);

                if math_floor_ret == math_min_ret5 then
                    XPEarnedCurrentLevel = GardenLevelData.GetXPEarnedCurrentLevel(math_floor_ret - 1) + 1;
                end;

                PROGRESSION_AMOUNT.Text = `{XPEarnedCurrentLevel}/{v28}`;
            end;
        end;

        if v24 and not v25 then
            local u33 = SoundPlayer:PlaySound("rbxassetid://98153553011954", nil, nil, ReplicatedStorage);
            u33.Ended:Once(function() -- Line: 42
                -- upvalues: u33 (copy)
                u33:Destroy();
            end);
            u33:Play();
            local v34 = TweenService:Create(NextLevelTextLabel.Parent.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Scale = 1.15
            });
            v34:Play();
            burstParticles();
            v34.Completed:Wait();
            TweenService:Create(NextLevelTextLabel.Parent.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                Scale = 1
            }):Play();
        end;

        math_min_ret2 = math_min_ret5;
    end;

    local v35 = v20 and 4 or 2;

    while v35 > 0 and #u15 <= 0 do
        v35 = v35 - task.wait(0.1);
    end;

    u16 = false;

    if #u15 > 0 then
        u1:UpdateProgression();
    end;

    TweenService:Create(u2.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0.5, -0.5)
    }):Play();
    task.wait(0.5);
    u2.Enabled = false;
end;

RE_ExperienceGained.OnClientEvent:Connect(function(p36: number, p37: number) -- Line: 215
    -- upvalues: u15 (copy), u17 (ref), u1 (copy)
    table.insert(u15, { p36, p37 });

    if u17 then
        u17:Stop();
    end;

    u1:UpdateProgression();
end);

function u1.Start(p38) -- Line: 221
    -- upvalues: DataService (copy), UpdateService (copy), u15 (copy), u1 (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    if UpdateService:IsHiddenFromUpdate("Garden Levels") then
        return;
    end;

    local TotalExperience = Data.GardenLevel.TotalExperience;
    table.insert(u15, { TotalExperience, TotalExperience, true });
    u1:UpdateProgression();
end;

task.spawn(u1.Start, u1);

return u1;