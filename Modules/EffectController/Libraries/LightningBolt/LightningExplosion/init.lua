-- Decompiled with Potassium's decompiler.

local script_Parent = require(script.Parent);
local LightningSparks = require(script.Parent.LightningSparks);
local Random_new_ret = Random.new();
local os_clock = os.clock;

function RandomVectorOffsetBetween(p1, p2, p3)
    -- upvalues: Random_new_ret (copy)
    local v4 = CFrame.lookAt(Vector3.new(), p1) * CFrame.Angles(0, 0, Random_new_ret:NextNumber(0, 6.283185307179586));
    local CFrame_Angles = CFrame.Angles;
    local v5 = Random_new_ret:NextNumber(math.cos(p3), (math.cos(p2)));

    return (v4 * CFrame_Angles(math.acos(v5), 0, 0)).LookVector;
end;

local u6 = {};
local u7 = {};
u7.__index = u7;

function u7.new(p8, p9, p10, p11, p12, p13) -- Line: 20
    -- upvalues: u7 (copy), Random_new_ret (copy), script_Parent (copy), LightningSparks (copy), os_clock (copy), u6 (copy)
    local v14 = setmetatable({}, u7);
    v14.Size = p9 or 1;
    v14.NumBolts = p10 or 14;
    v14.Color = p11 or ColorSequence.new(Color3.new(1, 0, 0), Color3.new(0, 0, 1));
    v14.BoltColor = p12 or Color3.new(0.3, 0.3, 1);
    v14.UpVector = p13 or Vector3.new(0, 1, 0);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Part = Instance.new("Part");
    Part.Name = "LightningExplosion";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Locked = true;
    Part.CastShadow = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.05, 0.05, 0.05);
    Part.CFrame = CFrame.lookAt(p8 + Vector3.new(0, 0.5, 0), p8 + Vector3.new(0, 0.5, 0) + v14.UpVector) * CFrame.lookAt(Vector3.new(), Vector3.new(0, 1, 0)):Inverse();
    Part.Parent = workspace_CurrentCamera;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = Part;
    Attachment.CFrame = CFrame.new();
    local v15 = script.ExplosionBrightspot:Clone();
    local v16 = script.GlareEmitter:Clone();
    local v17 = script.PlasmaEmitter:Clone();
    local math_clamp_ret = math.clamp(v14.Size, 0, 1);
    v16.Size = NumberSequence.new(math_clamp_ret * 30);
    v17.Size = NumberSequence.new(math_clamp_ret * 18);
    v17.Speed = NumberRange.new(math_clamp_ret * 100);
    v15.Parent = Attachment;
    v16.Parent = Attachment;
    v17.Parent = Attachment;
    local Color = v14.Color;

    if typeof(Color) == "Color3" then
        local ColorSequence_new_ret = ColorSequence.new(Color);
        local ColorSequence_new_ret2 = ColorSequence.new(Color);
        v16.Color = ColorSequence_new_ret;
        v17.Color = ColorSequence_new_ret2;
        local Color3_toHSV_ret, _, v18 = Color3.toHSV(Color);
        v15.Color = ColorSequence.new(Color3.fromHSV(Color3_toHSV_ret, 0.5, v18));
    else
        v16.Color = Color;
        v17.Color = Color;
        local Keypoints = Color.Keypoints;

        for i = 1, #Keypoints do
            local Color3_toHSV_ret, _, v19 = Color3.toHSV(Keypoints[i].Value);
            Keypoints[i] = ColorSequenceKeypoint.new(Keypoints[i].Time, Color3.fromHSV(Color3_toHSV_ret, 0.5, v19));
            local _ = i;
        end;

        v15.Color = ColorSequence.new(Keypoints);
    end;

    v15.Enabled = true;
    v16.Enabled = true;
    v17.Enabled = true;
    local v20 = {};

    for i = 1, v14.NumBolts do
        local v21 = {};
        local v22 = {};
        local WorldPosition = Attachment.WorldPosition;
        local v23 = RandomVectorOffsetBetween(v14.UpVector, 1.1344640137963142, 1.3962634015954636);
        v21.WorldPosition = WorldPosition;
        v21.WorldAxis = v23;
        local v24 = Attachment.WorldPosition + v21.WorldAxis * Random_new_ret:NextNumber(20, 40) * 1.4 * math_clamp_ret;
        local v25 = RandomVectorOffsetBetween(-v14.UpVector, 1.2217304763960306, 1.9198621771937625);
        v22.WorldPosition = v24;
        v22.WorldAxis = v25;
        local v26 = script_Parent.new(v21, v22, 10);
        v26.AnimationSpeed = 0;
        v26.Thickness = 1;
        v26.Color = v14.BoltColor;
        v26.PulseLength = 0.8;
        v26.ColorOffsetSpeed = 20;
        v26.Frequency = 2;
        v26.MinRadius = 0;
        v26.MaxRadius = math_clamp_ret * 4;
        v26.FadeLength = 0.4;
        v26.PulseSpeed = 5;
        v26.MinThicknessMultiplier = 0.7;
        v26.MaxThicknessMultiplier = 1;
        local v27 = LightningSparks.new(v26, 5);
        v27.MinDistance = 7.5;
        v27.MaxDistance = 10;
        v26.Velocity = (v22.WorldPosition - v21.WorldPosition).Unit * 0.1 * math_clamp_ret;
        v20[#v20 + 1] = v26;
        local _ = i;
    end;

    v14.Bolts = v20;
    v14.Attachment = Attachment;
    v14.Part = Part;
    v14.StartT = os_clock();
    v14.RefIndex = #u6 + 1;
    u6[v14.RefIndex] = v14;

    return v14;
end;

function u7.Destroy(p28) -- Line: 122
    -- upvalues: u6 (copy)
    u6[p28.RefIndex] = nil;
    p28.Part:Destroy();

    for i = 1, #p28.Bolts do
        p28.Bolts[i] = nil;
        local _ = i;
    end;
end;

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 133
    -- upvalues: u6 (copy), os_clock (copy)
    for _, v in pairs(u6) do
        local v29 = os_clock() - v.StartT;
        local Attachment = v.Attachment;

        if v29 < 0.7 then
            if v29 > 0.2 then
                local GlareEmitter = Attachment.GlareEmitter;
                local PlasmaEmitter = Attachment.PlasmaEmitter;
                Attachment.ExplosionBrightspot.Enabled = false;
                GlareEmitter.Enabled = false;
                PlasmaEmitter.Enabled = false;
            end;

            local v30 = v;

            for i = 1, #v.Bolts do
                local v31 = v30.Bolts[i];
                v31.Attachment1.WorldPosition = v31.Attachment1.WorldPosition + v31.Velocity;
                local _ = i;
            end;
        else
            v:Destroy();
        end;
    end;
end);

return u7;