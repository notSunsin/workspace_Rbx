-- Decompiled with Potassium's decompiler.

local Lighting = game:GetService("Lighting");
game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Utility = require(script.Parent.Parent.Utility.Utility);
local Tables = require(script.Parent.Parent.Utility.Tables);
local BoatTween = require(script.Parent.BoatTween);
local u1 = {};

function u1.CreateEffect(p2: table, p3: table) -- Line: 34
    -- upvalues: u1 (copy), Utility (copy)
    local v4 = p3.Object:Clone();
    v4.Parent = p3.Parent or workspace.Visuals;

    if p3.Position then
        v4:PivotTo(typeof(p3.Position) == "Vector3" and CFrame.new(p3.Position) or p3.Position);
    end;

    if p3.Emit then
        task.delay(p3.EmitDelay, u1.Emit, u1, v4, 1);
    end;

    if p3.Attach and (v4 and (p3.Parent and (p3.Parent:IsA("Part") or p3.Parent:IsA("BasePart")))) then
        if v4:IsA("Model") then
            u1:Attach(v4.PrimaryPart, p3.Parent);
        else
            u1:Attach(v4, p3.Parent);
        end;
    end;

    if p3.DebrisTime then
        Utility:AddItem(v4, p3.DebrisTime);
    end;

    if p3.RaycastColored then
        local v5 = workspace:Raycast(p3.RaycastColored.Origin, p3.RaycastColored.Direction, Utility.RayParams);

        if not v5 then
            return;
        end;

        for _, descendant in v4:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("Raycast") then
                descendant.Color = ColorSequence.new(v5.Instance.Color, v5.Instance.Color);
            end;
        end;
    end;

    return v4;
end;

function u1.Emit(p6: table, p7: userdata, u8: number?, p9: table?) -- Line: 76
    -- upvalues: TweenService (copy), RunService (copy)
    for _, descendant in p7:GetDescendants() do
        if not (p9 and p9[descendant.Name]) then
            if descendant:IsA("ParticleEmitter") then
                local v10 = descendant:GetAttribute("EmitDuration") or 0;

                if v10 < 0.05 then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 86
                        -- upvalues: descendant (copy)
                        descendant:Emit((descendant:GetAttribute("EmitCount")));
                    end);
                else
                    local u11 = os.clock() + v10;
                    task.spawn(function() -- Line: 92
                        -- upvalues: descendant (copy), u11 (copy)
                        repeat
                            descendant:Emit((descendant:GetAttribute("EmitCount")));
                            task.wait(0.1);
                        until u11 - os.clock() <= 0;
                    end);
                end;
            elseif descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight")) then
                TweenService:Create(descendant, TweenInfo.new(u8 or 1), {
                    Brightness = 0
                }):Play();
            elseif descendant:IsA("Decal") then
                TweenService:Create(descendant, TweenInfo.new(u8 or 1), {
                    Transparency = 1
                }):Play();
            elseif descendant:IsA("Beam") then
                local function UpdateTransparency(p12) -- Line: 104
                    -- upvalues: descendant (copy)
                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, p12), NumberSequenceKeypoint.new(1, p12) });
                end;

                task.spawn(function() -- Line: 111
                    -- upvalues: descendant (copy), u8 (copy), TweenService (ref), UpdateTransparency (copy), RunService (ref)
                    local os_clock_ret = os.clock();
                    local Value = descendant.Transparency.Keypoints[2].Value;

                    repeat
                        local v13 = (os.clock() - os_clock_ret) / u8;
                        UpdateTransparency((TweenService:GetValue(math.clamp(v13, Value, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)));
                        RunService.Heartbeat:Wait();
                    until u8 < os.clock() - os_clock_ret;

                    UpdateTransparency(1);
                end);
            end;
        end;
    end;
end;

function u1.Attach(p14: table, p15: userdata, p16: userdata, p17: number?) -- Line: 130
    -- upvalues: Utility (copy)
    local WeldConstraint = Instance.new("WeldConstraint");
    p15.Massless = true;
    p15.CanCollide = false;
    WeldConstraint.Part0 = p16;
    WeldConstraint.Part1 = p15;
    WeldConstraint.Parent = p15;

    if p17 then
        Utility:AddItem(WeldConstraint, p17);
    end;
end;

function u1.PlaySound(p18: table, p19: userdata, p20: userdata) -- Line: 146
    -- upvalues: Utility (copy)
    local v21 = p19:Clone();
    v21.Parent = p20;
    v21:Play();
    Utility:AddItem(v21, p19.TimeLength > 0.1 and p19.TimeLength or 1);

    return v21;
end;

function u1.SetScale(p22: table, p23: userdata, p24: number, p25: table) -- Line: 156
    for _, descendant in p23:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            if not (table.find(p25, descendant) or table.find(p25, descendant.Name)) then
                local v26 = descendant;
                local v27 = {};

                for _, v in ipairs(descendant.Size.Keypoints) do
                    table.insert(v27, NumberSequenceKeypoint.new(v.Time, v.Value * p24, v.Envelope * p24));
                end;

                local NumberSequence_new_ret = NumberSequence.new(v27);
                local NumberRange_new_ret = NumberRange.new(v26.Speed.Min * p24, v26.Speed.Max * p24);
                local v28 = v26.Acceleration * p24;
                v26.Size = NumberSequence_new_ret;
                v26.Speed = NumberRange_new_ret;
                v26.Acceleration = v28;
            end;
        elseif descendant:IsA("Attachment") then
            descendant.Position = descendant.Position * p24;
        elseif descendant:IsA("Beam") then
            descendant.CurveSize0 = descendant.CurveSize0 * p24;
            descendant.CurveSize1 = descendant.CurveSize1 * p24;
            descendant.Width0 = descendant.Width0 * p24;
            descendant.Width1 = descendant.Width1 * p24;
        end;
    end;

    p23:SetAttribute("Scale", p24);
end;

function u1.ScaleTo(p29: table, u30: userdata, u31: number, u32: number, p33: table) -- Line: 189
    -- upvalues: TweenService (copy), u1 (copy), RunService (copy)
    local u34 = p33 or ({} or p33);

    if not u34 then
        return;
    end;

    task.spawn(function() -- Line: 196
        -- upvalues: u30 (copy), u32 (copy), TweenService (ref), u31 (copy), u1 (ref), u34 (ref), RunService (ref)
        local os_clock_ret = os.clock();
        local v35 = u30:GetAttribute("Scale") or 1;

        repeat
            local v36 = (os.clock() - os_clock_ret) / u32;
            local Value = TweenService:GetValue(math.clamp(v36, 0, 1), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
            u1:SetScale(u30, v35 + (u31 - v35) * Value, u34);
            RunService.Heartbeat:Wait();
        until u32 < os.clock() - os_clock_ret or not u30;

        if not u30 then
            return;
        end;

        u1:SetScale(u30, u31, u34);
    end);
end;

function u1.AdjustSpeed(p37) -- Line: 218
end;

function u1.Recolor(p38) -- Line: 222
end;

if RunService:IsClient() then
    local CameraShaker = require(script.Parent.CameraShaker);
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u40 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p39) -- Line: 230
        -- upvalues: workspace_CurrentCamera (copy)
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * p39;
    end);
    u40:Start();

    function u1.ShakeCamera(p41: table, p42: string) -- Line: 236
        -- upvalues: u40 (copy), CameraShaker (copy)
        u40:Shake(CameraShaker.Presets[p42]);
    end;

    function u1.ShakeSustain(p43: table, p44: string) -- Line: 240
        -- upvalues: u40 (copy), CameraShaker (copy)
        return u40:ShakeSustain(CameraShaker.Presets[p44]);
    end;

    function u1.ShakeOnce(p45: table, p46: table) -- Line: 244
        -- upvalues: Tables (copy), u40 (copy)
        local v47 = Tables.Reconcile(p46, {
            Magnitude = 6,
            Roughness = 4,
            FadeInTime = 0.05,
            FadeOutTime = 0.75,
            PositionInfluence = Vector3.new(0.15, 0.15, 0.15),
            RotationInfluence = Vector3.new(1, 1, 1)
        });
        u40:ShakeOnce(v47.Magnitude, v47.Roughness, v47.FadeInTime, v47.FadeOutTime, v47.PosInfluence, v47.RotInfluence);
    end;
end;

function u1.CreateLighting(p48: table, p49: string, p50: table, p51: number?) -- Line: 261
    -- upvalues: Lighting (copy), Utility (copy)
    local Instance_new_ret = Instance.new(p49);
    Instance_new_ret.Parent = Lighting;

    for i, v in p50 do
        if Instance_new_ret[i] then
            Instance_new_ret[i] = v;
        end;
    end;

    if p51 then
        Utility:AddItem(Instance_new_ret, p51);
    end;

    return Instance_new_ret;
end;

function u1.UpdateStatus(p52: table, p53: any, u54: boolean, p55: table?) -- Line: 278
    -- upvalues: BoatTween (copy), TweenService (copy)
    if typeof(p53) == "Instance" then
        p53 = p53:GetDescendants() or p53;
    end;

    for _, v in p53 do
        if not (p55 and p55[v.Name]) then
            task.spawn(function() -- Line: 286
                -- upvalues: v (copy), u54 (copy), BoatTween (ref), TweenService (ref)
                if v:IsA("ParticleEmitter") then
                    v.Enabled = u54;

                    return;
                end;

                if not (v:IsA("Beam") or v:IsA("Trail")) then
                    if v:IsA("PointLight") or v:IsA("SpotLight") then
                        if u54 then
                            v.Enabled = false;

                            return;
                        end;

                        TweenService:Create(v, TweenInfo.new(1), {
                            Brightness = 0
                        }):Play();
                    end;

                    return;
                end;

                if u54 then
                    v.Enabled = true;

                    return;
                end;

                local u56 = BoatTween:Create(v, {
                    Time = 1,
                    EasingStyle = "EntranceExpressive",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = v:IsA("Beam") and {
                        TextureSpeed = 0,
                        Transparency = NumberSequence.new(1, 1)
                    } or {
                        Transparency = NumberSequence.new(1, 1)
                    }
                });
                u56:Play();
                u56.Completed:Connect(function() -- Line: 310
                    -- upvalues: u56 (copy)
                    u56:Destroy();
                end);
            end);
        end;
    end;
end;

return u1;