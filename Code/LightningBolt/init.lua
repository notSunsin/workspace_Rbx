-- Decompiled with Potassium's decompiler.

local os_clock = os.clock;
local Workspace = game:GetService("Workspace");
local RunService = game:GetService("RunService");
local CurrentCamera = Workspace.CurrentCamera;
local Part = Instance.new("Part");
Part.TopSurface = 0;
Part.BottomSurface = 0;
Part.Anchored = true;
Part.CanCollide = false;
Part.Locked = true;
Part.CastShadow = false;
Part.Shape = "Cylinder";
Part.Name = "BoltPart";
Part.Material = Enum.Material.Neon;
Part.Color = Color3.new(1, 1, 1);
Part.Transparency = 1;
local u1 = require(script.Parent.PartCache).new(Part, 190);
u1:SetCacheParent(CurrentCamera);

local function CubicBezier(p2, p3, p4, p5, p6) -- Line: 33
    return p3 * (1 - p2) ^ 3 + p4 * 3 * p2 * (1 - p2) ^ 2 + p5 * 3 * (1 - p2) * p2 ^ 2 + p6 * p2 ^ 3;
end;

local function DiscretePulse(p7, p8, p9, p10, p11, p12, p13) -- Line: 40
    local v14 = p10 / (2 * p11) - math.abs((p7 - p8 * p9 + 0.5 * p10) / p11);

    return math.clamp(v14, p12, p13);
end;

local function ExtrudeCenter(p15) -- Line: 44
    return math.exp(-5000 * (p15 - 0.5) ^ 10);
end;

local function NoiseBetween(p16, p17, p18, p19, p20) -- Line: 48
    return p19 + (p20 - p19) * (math.noise(p16, p17, p18) + 0.5);
end;

local u21 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):inverse();
local u22 = {};
local u23 = {
    __type = "LightningBolt"
};
u23.__index = u23;

function u23.new(p24, p25, p26) -- Line: 69
    -- upvalues: u23 (copy), CubicBezier (copy), DiscretePulse (copy), ExtrudeCenter (copy), u1 (copy), os_clock (copy), u22 (copy)
    local v27 = setmetatable({}, u23);
    v27.Enabled = true;
    v27.Attachment0 = p24;
    v27.Attachment1 = p25;
    v27.CurveSize0 = 0;
    v27.CurveSize1 = 0;
    v27.MinRadius = 0;
    v27.MaxRadius = 2.4;
    v27.Frequency = 1;
    v27.AnimationSpeed = 7;
    v27.Thickness = 1;
    v27.MinThicknessMultiplier = 0.2;
    v27.MaxThicknessMultiplier = 1;
    v27.MinTransparency = 0;
    v27.MaxTransparency = 1;
    v27.PulseSpeed = 2;
    v27.PulseLength = 1000000;
    v27.FadeLength = 0.2;
    v27.ContractFrom = 0.5;
    v27.Color = Color3.new(1, 1, 1);
    v27.ColorOffsetSpeed = 3;
    v27.SpaceCurveFunction = CubicBezier;
    v27.OpacityProfileFunction = DiscretePulse;
    v27.RadialProfileFunction = ExtrudeCenter;
    v27._Parts = {};

    for i = 1, p26 or 30 do
        v27._Parts[i] = u1:GetPart();
        local _ = i;
    end;

    v27._PartsHidden = false;
    v27._DisabledTransparency = 1;
    v27._StartT = os_clock();
    v27._RanNum = math.random() * 100;
    v27._RefIndex = #u22 + 1;
    u22[v27._RefIndex] = v27;

    return v27;
end;

function u23.Destroy(p28) -- Line: 154
    -- upvalues: u22 (copy), u1 (copy)
    u22[p28._RefIndex] = nil;

    for i = 1, #p28._Parts do
        u1:ReturnPart(p28._Parts[i]);
        local _ = i;
    end;
end;

function u23.DestroyDissipate(u29, p30, p31) -- Line: 165
    -- upvalues: os_clock (copy), RunService (copy)
    local u32 = p30 or 0.2;
    local u33 = p31 or 0.5;
    local u34 = os_clock();
    local MinTransparency = u29.MinTransparency;
    local ContractFrom = u29.ContractFrom;
    local u35 = u29.ContractFrom + 1 / (#u29._Parts * u29.FadeLength);
    local MaxRadius = u29.MaxRadius;
    local MinThicknessMultiplier = u29.MinThicknessMultiplier;
    local u36 = nil;
    u36 = RunService.Heartbeat:Connect(function() -- Line: 175
        -- upvalues: os_clock (ref), u34 (copy), u29 (copy), MinThicknessMultiplier (copy), u32 (ref), MinTransparency (copy), ContractFrom (copy), u35 (copy), MaxRadius (copy), u33 (ref), u36 (ref)
        local v37 = os_clock() - u34;
        u29.MinThicknessMultiplier = MinThicknessMultiplier + (-2 - MinThicknessMultiplier) * v37 / u32;

        if v37 < u32 * 0.4 then
            u29.MinTransparency = MinTransparency + (ContractFrom - MinTransparency) * (v37 / (u32 * 0.4));

            return;
        end;

        if v37 >= u32 then
            if os_clock() - u29._StartT < (u29.PulseLength + 1) / u29.PulseSpeed then
                u29:Destroy();
            end;

            u36:Disconnect();
            u36 = nil;

            return;
        end;

        local v38 = (v37 - u32 * 0.4) / (u32 * 0.6);
        u29.MinTransparency = ContractFrom + (u35 - ContractFrom) * v38;
        u29.MaxRadius = MaxRadius * (1 + u33 * v38);
        u29.MinRadius = u29.MinRadius + (u29.MaxRadius - u29.MinRadius) * v38;
    end);
end;

function u23._UpdateGeometry(p39, p40, p41, p42, p43, p44, p45) -- Line: 203
    -- upvalues: u21 (copy)
    local v46 = p39.OpacityProfileFunction(p41, p42, p39.PulseSpeed, p39.PulseLength, p39.FadeLength, 1 - p39.MaxTransparency, 1 - p39.MinTransparency);
    local v47 = p39.Thickness * p43 * v46;
    local v48 = v47 > 0 and v46 and v46 or 0;
    local v49 = 1 - p39.ContractFrom;
    local v50 = #p39._Parts;

    if v49 < v48 then
        p40.Size = Vector3.new((p45 - p44).Magnitude, v47, v47);
        p40.CFrame = CFrame.lookAt((p44 + p45) * 0.5, p45) * u21;
        p40.Transparency = 1 - v48;

        return;
    end;

    if v49 - 1 / (v50 * p39.FadeLength) >= v48 then
        p40.Transparency = 1;

        return;
    end;

    local v51 = (1 - (v48 - (v49 - 1 / (v50 * p39.FadeLength))) * v50 * p39.FadeLength) * (p41 < p42 * p39.PulseSpeed - 0.5 * p39.PulseLength and 1 or -1);
    local v52 = (1 - math.abs(v51)) * (p45 - p44).Magnitude;
    p40.Size = Vector3.new(v52, v47, v47);
    p40.CFrame = CFrame.lookAt(p44 + (p45 - p44) * (math.max(0, v51) + (1 - math.abs(v51)) * 0.5), p45) * u21;
    p40.Transparency = 1 - v48;
end;

function u23._UpdateColor(p53, p54, p55, p56) -- Line: 249
    if typeof(p53.Color) == "Color3" then
        p54.Color = p53.Color;

        return;
    end;

    local v57 = (p53._RanNum + p55 - p56 * p53.ColorOffsetSpeed) % 1;
    local Keypoints = p53.Color.Keypoints;

    for i = 1, #Keypoints - 1 do
        if Keypoints[i].Time < v57 and v57 < Keypoints[i + 1].Time then
            p54.Color = Keypoints[i].Value:lerp(Keypoints[i + 1].Value, (v57 - Keypoints[i].Time) / (Keypoints[i + 1].Time - Keypoints[i].Time));

            return;
        end;

        local _ = i;
    end;
end;

function u23._Disable(p58) -- Line: 267
    p58.Enabled = false;

    for _, v in ipairs(p58._Parts) do
        v.Transparency = p58._DisabledTransparency;
    end;
end;

RunService.Heartbeat:Connect(function() -- Line: 274
    -- upvalues: u22 (copy), os_clock (copy)
    debug.profilebegin("LightningBolt");

    for _, v in pairs(u22) do
        if v.Enabled == true then
            v._PartsHidden = false;
            local MinRadius = v.MinRadius;
            local MaxRadius = v.MaxRadius;
            local _Parts = v._Parts;
            local v59 = #_Parts;
            local _RanNum = v._RanNum;
            local AnimationSpeed = v.AnimationSpeed;
            local Frequency = v.Frequency;
            local MinThicknessMultiplier = v.MinThicknessMultiplier;
            local MaxThicknessMultiplier = v.MaxThicknessMultiplier;
            local v60 = os_clock() - v._StartT;
            local SpaceCurveFunction = v.SpaceCurveFunction;
            local RadialProfileFunction = v.RadialProfileFunction;
            local v61 = (v.PulseLength + 1) / v.PulseSpeed;
            local Attachment0 = v.Attachment0;
            local Attachment1 = v.Attachment1;
            local WorldPosition = Attachment0.WorldPosition;
            local v62 = Attachment0.WorldPosition + Attachment0.WorldAxis * v.CurveSize0;
            local v63 = Attachment1.WorldPosition - Attachment1.WorldAxis * v.CurveSize1;
            local WorldPosition2 = Attachment1.WorldPosition;
            local v64 = SpaceCurveFunction(0, WorldPosition, v62, v63, WorldPosition2);

            if v60 < v61 then
                local v65 = v64;
                local v66 = v;

                for i = 1, v59 do
                    local v67 = _Parts[i];
                    local v68 = i / v59;
                    local v69 = AnimationSpeed * -v60 + Frequency * 10 * v68 - 0.2 + _RanNum * 4;
                    local v70 = 5 * (AnimationSpeed * 0.01 * -v60 / 10 + Frequency * v68) + _RanNum * 4;
                    local v71 = 0 + 0.6283185307179586 * (math.noise(5 * v69, 1.5, 1 * v70) + 0.5) + (0 + 5.654866776461628 * (math.noise(0.5 * v69, 1.5, 0.1 * v70) + 0.5));
                    local v72 = (MinRadius + (MaxRadius - MinRadius) * (math.noise(3.4, v70, v69) + 0.5)) * RadialProfileFunction(v68);
                    local v73 = MinThicknessMultiplier + (MaxThicknessMultiplier - MinThicknessMultiplier) * (math.noise(2.3, v70, v69) + 0.5);
                    local v74 = SpaceCurveFunction(v68, WorldPosition, v62, v63, WorldPosition2);
                    local v75;

                    if i == v59 then
                        v75 = v74;
                    else
                        local v76 = CFrame.new(v65, v74) * CFrame.Angles(0, 0, v71);
                        local CFrame_Angles = CFrame.Angles;
                        local v77 = 6.123233995736766e-17 + 0.9999999999999999 * (math.noise(v70, v69, 2.7) + 0.5);
                        local math_clamp_ret = math.clamp(v77, -1, 1);
                        v75 = (v76 * CFrame_Angles(math.acos(math_clamp_ret), 0, 0) * CFrame.new(0, 0, -v72)).Position or v74;
                    end;

                    v66:_UpdateGeometry(v67, v68, v60, v73, v64, v75);
                    v66:_UpdateColor(v67, v68, v60);
                    v65 = v74;
                    v64 = v75;
                    local _ = i;
                end;
            else
                v:Destroy();
            end;
        elseif v._PartsHidden == false then
            v._PartsHidden = true;
            v:_Disable();
        end;
    end;

    debug.profileend();
end);

return u23;