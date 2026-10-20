-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Bezier = require(ReplicatedStorage.Code.Bezier);
local TweenModel = require(ReplicatedStorage.Modules.TweenModel);
local RunTreeGrowKitAnimation = ReplicatedStorage.GameEvents.RunTreeGrowKitAnimation;
local u2 = {
    Can = {
        Count = 0,
        Direction = Vector3.new(-0, -0, -1),
        Model = script.Can
    },
    Fertiliser = {
        Count = 0,
        Direction = Vector3.new(1, 0, 0),
        Model = script.Fertiliser
    },
    Reclaimer = {
        Count = 0,
        Direction = Vector3.new(0, 0, 1),
        Model = script.Reclaimer
    },
    Trowel = {
        Count = 0,
        Direction = Vector3.new(-1, -0, -0),
        Model = script.Trowel
    }
};

local function GetLowestValueKey(p3: table) -- Line: 75
    local v4 = (1 / 0);
    local v5 = nil;

    for i, v in pairs(p3) do
        if v.Count < v4 then
            v4 = v.Count;
            v5 = i;
        end;
    end;

    return v5, v4;
end;

function u1.StartAnimation(p6: table, p7: userdata, p8: userdata) -- Line: 91
    -- upvalues: RunService (copy), RunTreeGrowKitAnimation (copy), ReplicatedStorage (copy), u2 (copy), TweenModel (copy), Bezier (copy)
    if RunService:IsServer() then
        RunTreeGrowKitAnimation:FireClient(p7, p8);

        return;
    end;

    local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
    local SoundData = require(ReplicatedStorage.Data.SoundData);

    if not p7 then
        return;
    end;

    if not p8 then
        return;
    end;

    local v9 = p7.Character or p7.CharacterAdded:Wait();
    local v10 = v9:FindFirstChildOfClass("Tool");
    local v11;

    if v10 and v10:HasTag("TreeGrowerKit") then
        v11 = v10:FindFirstChild("Tree Grower Kit");
    else
        v11 = nil;
    end;

    local v12 = (1 / 0);
    local v13 = nil;

    for i, v in pairs(u2) do
        if v.Count < v12 then
            v12 = v.Count;
            v13 = i;
        end;
    end;

    local v14 = u2[v13];
    v14.Count = v14.Count + 1;
    local v15 = u2[v13].Model:Clone();
    local v16 = (v11 and v11:GetPivot() or v9:GetPivot()) * CFrame.new(u2[v13].Direction * 5);
    v15:PivotTo(v16);

    if v11 then
        local v17 = v11:FindFirstChild(v13);

        if v17 then
            v15:PivotTo(v17:GetPivot());
        end;

        TweenModel(v15, TweenInfo.new(1, Enum.EasingStyle.Elastic), {
            CFrame = v16,
            Scale = v15:GetScale()
        }):Play();
    end;

    local v18 = {
        PlaybackSpeed = math.random(95, 105) / 100
    };
    SoundPlayer:PlaySound(SoundData.Tools.Generic.Equip, v18);
    SoundPlayer:PlaySound(SoundData.General.PopSound, v18);
    v15.Parent = workspace.Visuals;
    task.wait(1.1);
    local v19 = 0;

    while v19 < 1 do
        v19 = v19 + game:GetService("RunService").Heartbeat:Wait();
        local Position = v16.Position;
        local Position2 = p8:GetPivot().Position;
        local v20 = (Position + Position2) / 2 + Vector3.new(0, Position.Y + 7, 0);
        local v21 = Bezier.new(Position, v20, Position2):Get((game.TweenService:GetValue(v19 / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)));
        v15:PivotTo(CFrame.new(v21));
    end;

    SoundPlayer:PlaySound("rbxassetid://131982914016274", v18);
    SoundPlayer:PlaySound("rbxassetid://98997625344529", v18);

    if v15 then
        v15:Destroy();
    end;

    local v22 = u2[v13];
    v22.Count = v22.Count - 1;
end;

if RunService:IsClient() then
    RunTreeGrowKitAnimation.OnClientEvent:Connect(function(p23: userdata) -- Line: 182
        -- upvalues: u1 (copy), Players (copy)
        u1:StartAnimation(Players.LocalPlayer, p23);
    end);
end;

return u1;