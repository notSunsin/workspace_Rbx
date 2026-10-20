-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = workspace:FindFirstChildOfClass("Terrain");
local u2 = {};
local u3 = {
    UpdateQueue = table.create(10)
};

function u3.Init(p4, p5) -- Line: 12
    -- upvalues: u3 (copy), RunService (copy)
    u3.Lifetime = p5.Lifetime or 3;
    u3.Direction = p5.Direction or Vector3.new(1, 0, 0);
    u3.Speed = p5.Speed or 6;
    u3.Color = p5.Color or Color3.fromRGB(255, 255, 255);

    if u3.UpdateConnection then
        u3.UpdateConnection:Disconnect();
        u3.UpdateConnection = nil;
    end;

    for _, v in ipairs(u3.UpdateQueue) do
        v.Attachment0:Destroy();
        v.Attachment1:Destroy();
        v.Trail:Destroy();
    end;

    table.clear(u3.UpdateQueue);
    u3.LastSpawned = os.clock();
    local u6 = 1 / (p5.SpawnRate or 25);
    local os_clock_ret = os.clock();
    u3.UpdateConnection = RunService.Heartbeat:Connect(function() -- Line: 37
        -- upvalues: u3 (ref), u6 (copy), os_clock_ret (ref)
        local os_clock_ret2 = os.clock();

        if u6 < os_clock_ret2 - u3.LastSpawned then
            u3:Create();
            u3.LastSpawned = os_clock_ret2;
        end;

        if os_clock_ret2 - os_clock_ret < 0.04 then
            return;
        end;

        os_clock_ret = os_clock_ret2;

        for i, v in ipairs(u3.UpdateQueue) do
            local v7 = os_clock_ret2 - v.StartClock;

            if v.Lifetime <= v7 then
                v.Attachment0:Destroy();
                v.Attachment1:Destroy();
                v.Trail:Destroy();
                local v8 = #u3.UpdateQueue;
                u3.UpdateQueue[i] = u3.UpdateQueue[v8];
                u3.UpdateQueue[v8] = nil;
            else
                v.Trail.MaxLength = 80 - 100 * (v7 / v.Lifetime);
                local v9 = (os_clock_ret2 + v.Seed) * (v.Speed * 0.05);
                local Position = v.Position;
                local Attachment0 = v.Attachment0;
                local Position2 = (CFrame.new(Position, Position + v.Direction) * CFrame.new(0, 0, v.Speed * -v7)).Position;
                local v10 = math.sin(v9) * 0.5;
                local v11 = math.sin(v9) * 0.8;
                local v12 = math.sin(v9) * 0.5;
                Attachment0.WorldPosition = Position2 + Vector3.new(v10, v11, v12);
                v.Attachment1.WorldPosition = v.Attachment0.WorldPosition + Vector3.new(0, 0.65, 0);
            end;
        end;
    end);
end;

function u3.Cleanup(p13) -- Line: 85
    -- upvalues: u3 (copy)
    if u3.UpdateConnection then
        u3.UpdateConnection:Disconnect();
        u3.UpdateConnection = nil;
    end;

    for _, v in ipairs(u3.UpdateQueue) do
        v.Attachment0:Destroy();
        v.Attachment1:Destroy();
        v.Trail:Destroy();
    end;

    table.clear(u3.UpdateQueue);
end;

function u3.Create(p14, p15) -- Line: 101
    -- upvalues: u2 (copy), u3 (copy), u1 (copy)
    local v16 = p15 or u2;
    local v17 = v16.Lifetime or u3.Lifetime;
    local Position = v16.Position;

    if not Position then
        local CFrame2 = workspace.CurrentCamera.CFrame;
        local CFrame_Angles = CFrame.Angles;
        local math_random_ret = math.random(-30, 70);
        local math_rad_ret = math.rad(math_random_ret);
        local math_random_ret2 = math.random(-80, 80);
        Position = CFrame2 * CFrame_Angles(math_rad_ret, math.rad(math_random_ret2), 0) * CFrame.new(0, 0, math.random(200, 600) * -0.3).Position;
    end;

    local v18 = v16.Direction or u3.Direction;
    local v19 = v16.Speed or u3.Speed;
    local v20 = v16.Color or u3.Color;

    if v19 <= 0 then
        return;
    end;

    local Attachment = Instance.new("Attachment");
    local Attachment2 = Instance.new("Attachment");
    local Trail = Instance.new("Trail");
    Trail.Attachment0 = Attachment;
    Trail.Attachment1 = Attachment2;
    Trail.WidthScale = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.1, 1),
        NumberSequenceKeypoint.new(0.4, 1),
        NumberSequenceKeypoint.new(1, 0)
    });
    Trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.15, 0.75),
        NumberSequenceKeypoint.new(0.85, 0.75),
        NumberSequenceKeypoint.new(1, 1)
    });
    Attachment.WorldPosition = Position;
    Attachment2.WorldPosition = Position + Vector3.new(0, 0.65, 0);
    Attachment.Parent = u1;
    Attachment2.Parent = u1;
    Trail.LightInfluence = 1;
    Trail.LightEmission = 1;
    Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v20), ColorSequenceKeypoint.new(1, v20) });
    Trail.FaceCamera = true;
    Trail.Texture = "rbxassetid://137241715738629";
    Trail.Parent = Attachment;
    local v21 = {
        Attachment0 = Attachment,
        Attachment1 = Attachment2,
        Trail = Trail,
        Lifetime = v17 + math.random(-10, 10) * 0.1,
        Position = Position,
        Direction = v18,
        Speed = v19 + math.random(-10, 10) * 0.1,
        StartClock = os.clock(),
        Seed = math.random(1, 1000) * 0.1
    };
    local WorldPosition = Attachment.WorldPosition;
    local v22 = math.sin((v21.StartClock + v21.Seed) * (v21.Speed * 0.2)) * 0.8;
    Attachment.WorldPosition = WorldPosition + Vector3.new(0, v22, 0);
    u3.UpdateQueue[#u3.UpdateQueue + 1] = v21;
end;

return u3;