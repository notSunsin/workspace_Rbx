-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = Trove.new();
local u2 = {};
local u3 = 0;
local u4 = 0;

function u2.GetAmount(p5) -- Line: 19
    -- upvalues: u3 (ref)
    return u3;
end;

function u2.GetUpAmount(p6) -- Line: 20
    -- upvalues: u4 (ref)
    return u4;
end;

function u2.PlayBiteAnimation(p7, p8) -- Line: 22
    -- upvalues: RunService (copy), TweenService (copy), u3 (ref)
    local v9 = 0;

    while v9 < 0.3 do
        v9 = v9 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v9 / 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In);
        u3 = math.lerp(0, 20, Value);
        p8.TopJaw.DesiredAngle = -math.lerp(0, 0.7, Value);
        p8.BottomJaw.DesiredAngle = -math.lerp(0, 0.7, Value);
    end;

    local v10 = 0;

    while v10 < 0.1 do
        v10 = v10 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v10 / 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local math_lerp_ret = math.lerp(-0.7, 0.15, Value);
        p8.TopJaw.DesiredAngle = math_lerp_ret;
        p8.BottomJaw.DesiredAngle = math_lerp_ret;
    end;

    task.wait(0.4);
    local v11 = 0;

    while v11 < 0.4 do
        v11 = v11 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v11 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        local math_lerp_ret = math.lerp(0.15, 0, Value);
        p8.TopJaw.DesiredAngle = math_lerp_ret;
        p8.BottomJaw.DesiredAngle = math_lerp_ret;
    end;

    local v12 = 0;

    while v12 < 0.4 do
        v12 = v12 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v12 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        u3 = math.lerp(20, 0, Value);
    end;
end;

function u2.PlaySpitAnimation(p13: table, p14: any, p15: function?) -- Line: 63
    -- upvalues: RunService (copy), TweenService (copy), u4 (ref)
    local v16 = 0;

    while v16 < 0.2 do
        v16 = v16 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v16 / 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        u4 = math.lerp(0, -5, Value);
        p14.TopJaw.DesiredAngle = math.lerp(0, 0.15, Value);
        p14.BottomJaw.DesiredAngle = math.lerp(0, 0.15, Value);
    end;

    local v17 = 0;

    while v17 < 0.4 do
        v17 = v17 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v17 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        u4 = math.lerp(-5, 15, Value);
        p14.TopJaw.DesiredAngle = math.lerp(0.15, -0.5, Value);
        p14.BottomJaw.DesiredAngle = math.lerp(0.15, -0.5, Value);
    end;

    local v18 = script.Gold:Clone();
    v18.PitchShiftSoundEffect.Octave = Random.new():NextNumber(1, 1.2);
    v18.Parent = p14;
    v18:Play();
    game.Debris:AddItem(v18, 5);
    p14.Spit:Play();

    for _, descendant in p14.Base.Emitter:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));

            if descendant.Name == "Spit" then
                task.delay(0.4, function() -- Line: 96
                    -- upvalues: descendant (copy)
                    local v19 = descendant:GetAttribute("EmitCount") / 2;
                    descendant:Emit((math.round(v19)));
                end);
            end;
        end;
    end;

    local v20;

    if p15 then
        p15();
        v20 = 0;
    else
        v20 = 0;
    end;

    while v20 < 0.2 do
        v20 = v20 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v20 / 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        u4 = math.lerp(15, 20, Value);
        p14.TopJaw.DesiredAngle = math.lerp(-0.5, -0.9, Value);
        p14.BottomJaw.DesiredAngle = math.lerp(-0.5, -0.9, Value);
    end;

    local v21 = 0;

    while v21 < 0.4 do
        v21 = v21 + RunService.Heartbeat:Wait();
        local Value = TweenService:GetValue(v21 / 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        u4 = math.lerp(20, 0, Value);
        p14.TopJaw.DesiredAngle = math.lerp(-0.9, 0, Value);
        p14.BottomJaw.DesiredAngle = math.lerp(-0.9, 0, Value);
    end;
end;

function u2.StartOrbitLoop(p22: table, p23: userdata) -- Line: 126
    -- upvalues: RunService (copy), Players (copy), u3 (ref), u4 (ref)
    local u24 = p23:QueryDescendants(".AngryPlantOrbit")[1];
    local WorldCFrame = u24.UpAndAround1.WorldCFrame;
    local WorldCFrame2 = u24.UpAndAround2.WorldCFrame;
    local CFrame2 = u24.Center.CFrame;
    local CFrame3 = u24.Attachment.CFrame;
    local CFrame4 = u24.CFrame;
    local u25 = 0;

    return task.spawn(function() -- Line: 137
        -- upvalues: RunService (ref), u25 (ref), u24 (copy), WorldCFrame (copy), WorldCFrame2 (copy), CFrame2 (copy), Players (ref), CFrame4 (copy), CFrame3 (copy), u3 (ref), u4 (ref)
        while true do
            local v26 = RunService.Heartbeat:Wait();
            u25 = u25 + v26;
            local UpAndAround1 = u24.UpAndAround1;
            local v27 = CFrame.new(WorldCFrame.Position) * CFrame.Angles(0, math.rad(u25 * 90), 0);
            local CFrame_new = CFrame.new;
            local math_sin_ret = math.sin(u25 * 90);
            UpAndAround1.WorldCFrame = v27 * CFrame_new(0, math.rad(math_sin_ret), 1);
            local UpAndAround2 = u24.UpAndAround2;
            local v28 = CFrame.new(WorldCFrame2.Position) * CFrame.Angles(0, math.rad(u25 * -90), 0);
            local CFrame_new2 = CFrame.new;
            local math_sin_ret2 = math.sin(u25 * -90);
            UpAndAround2.WorldCFrame = v28 * CFrame_new2(0, math.rad(math_sin_ret2), 1);
            local Center = u24.Center;
            local v29 = math.rad(u25 * 35) * 7;
            local math_cos_ret = math.cos(v29);
            local math_rad_ret = math.rad(u25 * 120);
            local v30 = (math.sin(math_rad_ret) + 1) / 2 * 2;
            Center.CFrame = CFrame2 + Vector3.new(math_cos_ret, v30, 0);
            local v31 = nil;
            local v32 = nil;

            for _, v in Players:GetPlayers() do
                if v.Character then
                    local Magnitude = (v.Character:GetPivot().Position - u24.Position).Magnitude;

                    if not v31 or Magnitude < v31 then
                        v32 = v;
                        v31 = Magnitude;
                    end;
                end;
            end;

            if v32 then
                local v33 = CFrame.new(u24.Position, v32.Character:GetPivot().Position).LookVector * Vector3.new(1, 0, 1);
                local v34 = CFrame4.LookVector:Dot(-v33);

                if math.acos(v34) > 1.5707963267948966 then
                    v33 = -CFrame4.LookVector:Lerp(v33, -1.995200412208242).Unit;
                end;

                u24.CFrame = u24.CFrame:Lerp(CFrame.new(u24.Position, u24.Position - v33), (math.min(v26 * 5, 1)));
            end;

            local Attachment = u24.Attachment;
            local CFrame_new3 = CFrame.new;
            local v35 = math.rad(u25 * 35) * 1;
            local v36 = CFrame3 * CFrame_new3(0, math.cos(v35), 0);
            local CFrame_Angles = CFrame.Angles;
            local math_rad_ret2 = math.rad(u25 * 90);
            local v37 = math.sin(math_rad_ret2) * 6;
            Attachment.CFrame = v36 * CFrame_Angles(0, 0, (math.rad(v37)));
            local Attachment2 = u24.Attachment;
            Attachment2.CFrame = Attachment2.CFrame * CFrame.new(u3, 0, 0);
            local Center2 = u24.Center;
            Center2.CFrame = Center2.CFrame * CFrame.new(0, 0, u3);
            u24.Attachment.WorldCFrame = CFrame.new(0, u4, 0) * u24.Attachment.WorldCFrame;
            u24.Center.WorldCFrame = CFrame.new(0, u4, 0) * u24.Center.WorldCFrame;
            u24.Attachment.CFrame = u24.Attachment.CFrame * CFrame.Angles(0, 0, (math.rad(u4 / 20 * 140)));
        end;
    end);
end;

function u2.StartHeadMonitor(p38, p39) -- Line: 195
    local u40 = p39:QueryDescendants(".AngryPlantMainModel")[1];
    local Position = u40.Base.Position;

    return task.spawn(function() -- Line: 200
        -- upvalues: u40 (copy), Position (copy)
        while true do
            repeat
                task.wait(0.5);
            until (u40.Base.Position - Position).Magnitude >= 100;

            u40["8"].Base.Enabled = false;
            task.wait(0.1);
            u40["8"].Base.Enabled = true;
        end;
    end);
end;

function u2.Start(p41) -- Line: 213
    -- upvalues: EventRotationUtils (copy), u1 (copy), u2 (copy)
    local v42 = EventRotationUtils:GetEventIDModelsWait("AngryPlantEvent")[1];
    u1:Add(u2:StartOrbitLoop(v42));
    u1:Add(u2:StartHeadMonitor(v42));
end;

local u43 = false;
EventRotationController.EventUpdated:Connect(function(p44: string, p45: string) -- Line: 221, Name: OnEventUpdated
    -- upvalues: u1 (copy), u43 (ref), u2 (copy)
    if p45 ~= "AngryPlantEvent" then
        u1:Clean();
        u43 = false;

        return;
    end;

    if u43 then
        return;
    end;

    u43 = true;
    u1:Clean();
    task.spawn(u2.Start, u2);
end);

return u2;