-- Decompiled with Potassium's decompiler.

local os_clock = os.clock;

function DiscretePulse(p1, p2, p3, p4, p5, p6, p7)
    local v8 = p3 / (2 * p4) - math.abs((p1 - p5 * p2 + 0.5 * p3) / p4);

    return math.clamp(v8, p6, p7);
end;

function NoiseBetween(p9, p10, p11, p12, p13)
    return p12 + (p13 - p12) * (math.noise(p9, p10, p11) + 0.5);
end;

function CubicBezier(p14, p15, p16, p17, p18)
    return p14 * (1 - p18) ^ 3 + p15 * 3 * p18 * (1 - p18) ^ 2 + p16 * 3 * (1 - p18) * p18 ^ 2 + p17 * p18 ^ 3;
end;

local Part = Instance.new("Part");
Part.TopSurface = 0;
Part.BottomSurface = 0;
Part.Anchored = true;
Part.CanCollide = false;
Part.Shape = "Cylinder";
Part.Name = "BoltPart";
Part.Material = Enum.Material.Neon;
Part.Color = Color3.new(1, 1, 1);
Part.Transparency = 1;
local u19 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):Inverse();
local u20 = {};
local u21 = {};
u21.__index = u21;

function u21.new(p22, p23, p24) -- Line: 45
    -- upvalues: u21 (copy), Part (copy), u19 (copy), os_clock (copy), u20 (copy)
    local v25 = setmetatable({}, u21);
    v25.Enabled = true;
    v25.Attachment0 = p22;
    v25.Attachment1 = p23;
    v25.CurveSize0 = 0;
    v25.CurveSize1 = 0;
    v25.MinRadius = 0;
    v25.MaxRadius = 2.4;
    v25.Frequency = 1;
    v25.AnimationSpeed = 7;
    v25.Thickness = 1;
    v25.MinThicknessMultiplier = 0.2;
    v25.MaxThicknessMultiplier = 1;
    v25.MinTransparency = 0;
    v25.MaxTransparency = 1;
    v25.PulseSpeed = 2;
    v25.PulseLength = 1000000;
    v25.FadeLength = 0.2;
    v25.ContractFrom = 0.5;
    v25.Color = Color3.new(1, 1, 1);
    v25.ColorOffsetSpeed = 3;
    v25.Parts = {};
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local WorldPosition = p22.WorldPosition;
    local v26 = p22.WorldPosition + p22.WorldAxis * v25.CurveSize0;
    local v27 = p23.WorldPosition - p23.WorldAxis * v25.CurveSize1;
    local WorldPosition2 = p23.WorldPosition;
    local v28 = p24 or 30;
    local v29 = WorldPosition;
    local v30 = v29;
    local v31 = v29;
    v29 = v30;
    v31 = v30;

    for i = 1, v28 do
        local v32 = CubicBezier(WorldPosition, v26, v27, WorldPosition2, i / v28);
        local v33;

        if i == v28 then
            v33 = v32;
        else
            v33 = CFrame.lookAt(v29, v32).Position or v32;
        end;

        local v34 = Part:Clone();
        v34.Size = Vector3.new((v33 - v30).Magnitude, 0, 0);
        v34.CFrame = CFrame.lookAt(0.5 * (v30 + v33), v33) * u19;
        v34.Parent = workspace_CurrentCamera;
        v34.Locked = true;
        v34.CastShadow = false;
        v25.Parts[i] = v34;
        v29 = v32;
        v30 = v33;
        local _ = i;
    end;

    v25.PartsHidden = false;
    v25.DisabledTransparency = 1;
    v25.StartT = os_clock();
    v25.RanNum = math.random() * 100;
    v25.RefIndex = #u20 + 1;
    u20[v25.RefIndex] = v25;

    return v25;
end;

function u21.Destroy(p35) -- Line: 110
    -- upvalues: u20 (copy)
    u20[p35.RefIndex] = nil;

    for i = 1, #p35.Parts do
        p35.Parts[i]:Destroy();
        local v36;

        if i % 100 == 0 then
            task.wait();
            v36 = i;
        else
            v36 = i;
        end;
    end;
end;

game:GetService("RunService").Heartbeat:Connect(function() -- Line: 126
    -- upvalues: u20 (copy), os_clock (copy), u19 (copy)
    for _, v in pairs(u20) do
        if v.Enabled == true then
            v.PartsHidden = false;
            local v37 = 1 - v.MaxTransparency;
            local v38 = 1 - v.MinTransparency;
            local MinRadius = v.MinRadius;
            local MaxRadius = v.MaxRadius;
            local Thickness = v.Thickness;
            local Parts = v.Parts;
            local v39 = #Parts;
            local RanNum = v.RanNum;
            local StartT = v.StartT;
            local AnimationSpeed = v.AnimationSpeed;
            local Frequency = v.Frequency;
            local MinThicknessMultiplier = v.MinThicknessMultiplier;
            local MaxThicknessMultiplier = v.MaxThicknessMultiplier;
            local Attachment0 = v.Attachment0;
            local Attachment1 = v.Attachment1;
            local WorldPosition = Attachment0.WorldPosition;
            local v40 = Attachment0.WorldPosition + Attachment0.WorldAxis * v.CurveSize0;
            local v41 = Attachment1.WorldPosition - Attachment1.WorldAxis * v.CurveSize1;
            local WorldPosition2 = Attachment1.WorldPosition;
            local v42 = os_clock() - StartT;
            local PulseLength = v.PulseLength;
            local PulseSpeed = v.PulseSpeed;
            local FadeLength = v.FadeLength;
            local Color = v.Color;
            local ColorOffsetSpeed = v.ColorOffsetSpeed;
            local v43 = 1 - v.ContractFrom;

            if v42 < (PulseLength + 1) / PulseSpeed then
                local v44 = WorldPosition;
                local v45 = v44;
                local v46 = v44;
                v44 = v45;
                v46 = v45;

                for i = 1, v39 do
                    local v47 = Parts[i];
                    local v48 = i / v39;
                    local v49 = DiscretePulse(v48, PulseSpeed, PulseLength, FadeLength, v42, v37, v38);
                    local v50 = CubicBezier(WorldPosition, v40, v41, WorldPosition2, v48);
                    local v51 = -v42;
                    local v52 = AnimationSpeed * v51 + Frequency * 10 * v48 - 0.2 + RanNum * 4;
                    local v53 = 5 * (AnimationSpeed * 0.01 * v51 / 10 + Frequency * v48) + RanNum * 4;
                    local v54 = NoiseBetween(5 * v52, 1.5, 1 * v53, 0, 0.6283185307179586) + NoiseBetween(0.5 * v52, 1.5, 0.1 * v53, 0, 5.654866776461628);
                    local v55 = NoiseBetween(3.4, v53, v52, MinRadius, MaxRadius) * math.exp((v48 - 0.5) ^ 10 * -5000);
                    local v56 = NoiseBetween(2.3, v53, v52, MinThicknessMultiplier, MaxThicknessMultiplier);
                    local v57;

                    if i == v39 then
                        v57 = v50;
                    else
                        local v58 = CFrame.new(v44, v50) * CFrame.Angles(0, 0, v54);
                        local CFrame_Angles = CFrame.Angles;
                        local v59 = NoiseBetween(v53, v52, 2.7, 6.123233995736766e-17, 1);
                        local math_clamp_ret = math.clamp(v59, -1, 1);
                        v57 = (v58 * CFrame_Angles(math.acos(math_clamp_ret), 0, 0) * CFrame.new(0, 0, -v55)).Position or v50;
                    end;

                    if v43 < v49 then
                        v47.Size = Vector3.new((v57 - v45).Magnitude, Thickness * v56 * v49, Thickness * v56 * v49);
                        v47.CFrame = CFrame.lookAt(0.5 * (v45 + v57), v57) * u19;
                        v47.Transparency = 1 - v49;
                    elseif v43 - 1 / (v39 * FadeLength) < v49 then
                        local v60 = (1 - (v49 - (v43 - 1 / (v39 * FadeLength))) * v39 * FadeLength) * (v48 < v42 * PulseSpeed - 0.5 * PulseLength and 1 or -1);
                        local v61 = (1 - math.abs(v60)) * (v57 - v45).Magnitude;
                        v47.Size = Vector3.new(v61, Thickness * v56 * v49, Thickness * v56 * v49);
                        v47.CFrame = CFrame.lookAt(v45 + (v57 - v45) * (math.max(0, v60) + (1 - math.abs(v60)) * 0.5), v57) * u19;
                        v47.Transparency = 1 - v49;
                    else
                        v47.Transparency = 1;
                    end;

                    local v62;

                    if typeof(Color) == "Color3" then
                        v47.Color = Color;
                        v62 = i;
                    else
                        local v63 = (RanNum + v48 - v42 * ColorOffsetSpeed) % 1;
                        local Keypoints = Color.Keypoints;
                        v62 = i;

                        for i2 = 1, #Keypoints - 1 do
                            if Keypoints[v62].Time < v63 and v63 < Keypoints[v62 + 1].Time then
                                v47.Color = Keypoints[v62].Value:lerp(Keypoints[v62 + 1].Value, (v63 - Keypoints[v62].Time) / (Keypoints[v62 + 1].Time - Keypoints[v62].Time));
                                break;
                            end;

                            local _ = i2;
                        end;
                    end;

                    v44 = v50;
                    v45 = v57;
                end;
            else
                v:Destroy();
            end;
        elseif v.PartsHidden == false then
            v.PartsHidden = true;
            local DisabledTransparency = v.DisabledTransparency;
            local v64 = v;

            for i = 1, #v.Parts do
                v64.Parts[i].Transparency = DisabledTransparency;
                local _ = i;
            end;
        end;
    end;
end);

return u21;