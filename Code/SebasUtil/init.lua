-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
local VFXUtil = script:WaitForChild("VFXUtil");
local Visuals = workspace:WaitForChild("Visuals");
local u1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local Random_new_ret = Random.new();
local Vector3_FromNormalId_ret = Vector3.FromNormalId(Enum.NormalId.Top);

function u1.CubicBezier(p2: table, p3: number, p4: number, p5: number, p6: number, p7: number) -- Line: 18
    return (1 - p7) ^ 3 * p3 + p7 * 3 * (1 - p7) ^ 2 * p4 + p7 ^ 2 * 3 * (1 - p7) * p5 + p7 ^ 3 * p6;
end;

function u1.quadBezier(p8, p9, p10, p11, p12) -- Line: 22
    return (1 - p12) ^ 2 * p9 + 2 * (1 - p12) * p12 * p10 + p12 ^ 2 * p11;
end;

function u1.QuadraticEaseOut(p13: table, p14: number) -- Line: 26
    return math.lerp(p14 * p14, 1 - (1 - p14) * (1 - p14), p14);
end;

function u1.EaseBackIn(p15: table, p16: number?) -- Line: 33
    local u17 = p16 or 1.70158;

    return function(p18: number) -- Line: 35
        -- upvalues: u17 (ref)
        return p18 * p18 * ((u17 + 1) * p18 - u17);
    end;
end;

function u1.EaseBackOut(p19: table, p20: number?) -- Line: 40
    local u21 = p20 or 1.70158;

    return function(p22: number) -- Line: 42
        -- upvalues: u21 (ref)
        local v23 = p22 - 1;

        return v23 * v23 * ((u21 + 1) * v23 + u21) + 1;
    end;
end;

function u1.EaseBackInOut(p24: table, p25: number?) -- Line: 48
    local u26 = (p25 or 1.70158) * 1.525;

    return function(p27: number) -- Line: 50
        -- upvalues: u26 (ref)
        local v28 = p27 * 2;

        if v28 < 1 then
            return 0.5 * (v28 * v28 * ((u26 + 1) * v28 - u26));
        end;

        local v29 = v28 - 2;

        return 0.5 * (v29 * v29 * ((u26 + 1) * v29 + u26) + 2);
    end;
end;

function u1.lerp(p30, p31, p32, p33) -- Line: 61
    return p31 + (p32 - p31) * p33;
end;

function u1.invLerp(p34, p35, p36, p37) -- Line: 65
    return (p37 - p35) / (p36 - p35);
end;

function u1.remap(p38, p39, p40, p41, p42, p43) -- Line: 69
    -- upvalues: u1 (copy)
    local v44 = u1:invLerp(p40, p40, p43);

    return u1:lerp(p41, p42, (math.clamp(v44, 0, 1)));
end;

function u1.gaussianRandom(p45, p46, p47) -- Line: 74
    local v48, v49;

    repeat
        v49 = 2 * math.random() - 1;
        local v50 = 2 * math.random() - 1;
        v48 = math.pow(v49, 2) + math.pow(v50, 2);
    until v48 ~= 0 and v48 < 1;

    local v51 = math.log(v48) * -2 / v48;
    local math_sqrt_ret = math.sqrt(v51);

    return p46 + p47 * v49 * math_sqrt_ret;
end;

function u1.randomPointInSphere(p52, p53) -- Line: 86
    -- upvalues: u1 (copy)
    local v54 = 6.283185307179586 * math.random();
    local v55 = 2 * math.random() - 1;
    local math_acos_ret = math.acos(v55);
    local v56 = u1:gaussianRandom(0, p53 / 3);
    local math_min_ret = math.min(v56, p53);

    return math_min_ret * math.sin(math_acos_ret) * math.cos(v54), math_min_ret * math.sin(math_acos_ret) * math.sin(v54), math_min_ret * math.cos(math_acos_ret);
end;

function u1.randomPointInAnnulus(p57, p58, p59) -- Line: 99
    local v60 = 6.283185307179586 * math.random();
    local v61 = 2 * math.random() - 1;
    local math_acos_ret = math.acos(v61);
    local math_random_ret = math.random();
    local v62 = p58 + (p59 - p58) * math.sqrt(math_random_ret);

    return v62 * math.sin(math_acos_ret) * math.cos(v60), v62 * math.sin(math_acos_ret) * math.sin(v60), v62 * math.cos(math_acos_ret);
end;

function u1.randomPointInSphericalShell(p63, p64, p65) -- Line: 112
    if p65 < p64 then
        local v66 = p65;
        p65 = p64;
        p64 = v66;
    end;

    local math_max_ret = math.max(0, p64);
    local v67 = 6.283185307179586 * math.random();
    local v68 = 2 * math.random() - 1;
    local math_acos_ret = math.acos(v68);
    local v69 = math_max_ret ^ 3;
    local v70 = (v69 + (p65 ^ 3 - v69) * math.random()) ^ 0.3333333333333333;

    return v70 * math.sin(math_acos_ret) * math.cos(v67), v70 * math.sin(math_acos_ret) * math.sin(v67), v70 * math.cos(math_acos_ret);
end;

function u1.flat(p71: table, p72: table) -- Line: 132
    local u73 = {};

    local function flatten(p74) -- Line: 135
        -- upvalues: flatten (copy), u73 (copy)
        for _, v in ipairs(p74) do
            if typeof(v) == "table" then
                flatten(v);
            else
                table.insert(u73, v);
            end;
        end;
    end;

    flatten(p72);

    return u73;
end;

function u1.EmitAll(p75: table, p76: userdata) -- Line: 149
    for _, descendant in pairs(p76:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local Attribute = descendant:GetAttribute("EmitCount");
            local v77 = descendant:GetAttribute("EmitDelay") or 0;
            local Attribute2 = descendant:GetAttribute("EmitDuration");

            local function eparticle() -- Line: 156
                -- upvalues: Attribute2 (copy), descendant (copy)
                if Attribute2 and Attribute2 ~= 0 then
                    descendant.Enabled = true;
                    task.delay(Attribute2, function() -- Line: 159
                        -- upvalues: descendant (ref)
                        descendant.Enabled = false;
                    end);
                end;
            end;

            if Attribute then
                if v77 == 0 then
                    descendant:Emit(Attribute);

                    if Attribute2 and Attribute2 ~= 0 then
                        descendant.Enabled = true;
                        task.delay(Attribute2, function() -- Line: 159
                            -- upvalues: descendant (copy)
                            descendant.Enabled = false;
                        end);
                    end;
                else
                    task.delay(v77, function() -- Line: 170
                        -- upvalues: descendant (copy), Attribute (copy), Attribute2 (copy)
                        descendant:Emit(Attribute);

                        if Attribute2 and Attribute2 ~= 0 then
                            descendant.Enabled = true;
                            task.delay(Attribute2, function() -- Line: 159
                                -- upvalues: descendant (ref)
                                descendant.Enabled = false;
                            end);
                        end;
                    end);
                end;
            end;
        end;
    end;
end;

function u1.EmitOnce(p78: table, p79: userdata, p80: vector, p81: number?) -- Line: 180
    -- upvalues: Debris (copy), Visuals (copy), u1 (copy)
    local v82 = p79:Clone();
    Debris:AddItem(v82, p81 or 1);
    v82.Position = p80;
    v82.Parent = Visuals;
    u1:EmitAll(v82);
end;

function u1.ToggleAllBeams(p83: table, p84: userdata, p85: boolean) -- Line: 188
    for _, descendant in pairs(p84:GetDescendants()) do
        if descendant:IsA("Beam") then
            descendant.Enabled = p85;
        end;
    end;
end;

function u1.ToggleAllTrails(p86: table, p87: userdata, p88: boolean) -- Line: 196
    for _, descendant in pairs(p87:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = p88;
        end;
    end;
end;

function u1.ToggleAllParticles(p89: table, p90: userdata, p91: boolean) -- Line: 204
    for _, descendant in pairs(p90:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p91;
        end;
    end;
end;

function u1.EnableAllParticles(p92: table, p93: userdata) -- Line: 212
    -- upvalues: u1 (copy)
    u1:ToggleAllParticles(p93, true);
end;

function u1.DisableAllParticles(p94: table, p95: userdata) -- Line: 216
    -- upvalues: u1 (copy)
    u1:ToggleAllParticles(p95, false);
end;

function u1.EnableAllTrails(p96: table, p97: userdata) -- Line: 220
    -- upvalues: u1 (copy)
    u1:ToggleAllTrails(p97, true);
end;

function u1.DisableAllTrails(p98: table, p99: userdata) -- Line: 224
    -- upvalues: u1 (copy)
    u1:ToggleAllTrails(p99, false);
end;

function u1.PlaySound(p100: table, p101: any, p102: number, p103: userdata, p104: number?, p105: string?) -- Line: 228
    -- upvalues: SoundService (copy), TweenService (copy), Debris (copy)
    if p105 then
        p105 = SoundService:FindFirstChild(p105);
    end;

    local Sound = Instance.new("Sound");
    Sound.SoundId = p101;
    Sound.Volume = p102;
    Sound.Parent = p103;
    Sound.SoundGroup = p105;
    Sound:Play();
    task.delay(p104 or 1, function() -- Line: 244
        -- upvalues: Sound (copy), TweenService (ref), Debris (ref)
        if Sound ~= nil then
            local v106 = TweenService:Create(Sound, TweenInfo.new(0.2), {
                Volume = 0
            });
            v106:Play();
            v106.Completed:Connect(function() -- Line: 248
                -- upvalues: Debris (ref), Sound (ref)
                Debris:AddItem(Sound, 0);
            end);
        end;
    end);

    return Sound;
end;

function u1.SetupBeam(p107: table, p108: userdata, p109: userdata, p110: userdata) -- Line: 257
    p108.Attachment0 = p109;
    p108.Attachment1 = p110;
end;

function u1.AppearBeam(p111: table, p112: userdata, p113: number?) -- Line: 262
    -- upvalues: TweenService (copy)
    local v114 = TweenService:Create(p112, TweenInfo.new(p113 or 0.5), {
        Width0 = p112.Width0,
        Width1 = p112.Width1
    });
    v114:Play();
    p112.Width0 = 0;
    p112.Width1 = 0;
    p112.Enabled = true;

    return v114;
end;

function u1.AppearAllBeams(p115: table, p116: userdata, p117: number) -- Line: 276
    -- upvalues: u1 (copy)
    for _, descendant in ipairs(p116:GetDescendants()) do
        if descendant:IsA("Beam") then
            u1:AppearBeam(descendant, p117);
        end;
    end;
end;

function u1.DisableBeam(p118: table, p119: userdata, p120: number?) -- Line: 284
    -- upvalues: TweenService (copy)
    local v121 = TweenService:Create(p119, TweenInfo.new(p120 or 0.4), {
        Width0 = 0,
        Width1 = 0
    });
    v121:Play();

    return v121;
end;

function u1.DisableAllBeams(p122: table, p123: userdata, p124: number) -- Line: 297
    -- upvalues: u1 (copy)
    for _, descendant in ipairs(p123:GetDescendants()) do
        if descendant:IsA("Beam") then
            u1:DisableBeam(descendant, p124);
        end;
    end;
end;

function u1.FloorShockwave(p125: table, p126: userdata, p127: vector, p128: number?, p129: userdata?, p130: number?) -- Line: 305
    -- upvalues: Visuals (copy), VFXUtil (copy), Random_new_ret (copy), TweenService (copy), Debris (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterDescendantsInstances = { p126.Parent, Visuals };
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local v131 = workspace:Raycast(p126.Position, Vector3.new(0, p130 or -100, 0), p129 or RaycastParams_new_ret);
    local u132;

    if v131 then
        u132 = VFXUtil.Shockwave:Clone();
        u132.Parent = Visuals or workspace;
        u132.CanCollide = false;
        local CFrame_new_ret = CFrame.new(v131.Position, v131.Position + v131.Normal);
        local CFrame_Angles = CFrame.Angles;
        local v133 = Random_new_ret:NextNumber(-360, 360);
        u132.CFrame = CFrame_new_ret * CFrame_Angles(-1.5707963267948966, math.rad(v133), 0);
        local v134 = TweenService:Create(u132, TweenInfo.new(p128 or 0.5), {
            Transparency = 1,
            Size = p127,
            CFrame = u132.CFrame * CFrame.new(0, p127.Y / 2, 0)
        });
        v134:Play();
        v134.Completed:Connect(function() -- Line: 337
            -- upvalues: Debris (ref), u132 (ref)
            Debris:AddItem(u132, 0);
        end);
    else
        u132 = nil;
    end;

    return u132;
end;

function u1.FloorImageCrack(p135: table, p136, p137: number?, p138: number?, p139, p140: string?) -- Line: 345
    -- upvalues: Visuals (copy), TweenService (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Parent = Visuals or workspace;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.CanQuery = false;
    local CFrame_new_ret = CFrame.new(p136.Position, p136.Position + p136.Normal);
    local CFrame_Angles = CFrame.Angles;
    local math_random_ret = math.random(-180, 180);
    Part.CFrame = CFrame_new_ret * CFrame_Angles(-1.5707963267948966, math.rad(math_random_ret), 0);
    Part.Size = Vector3.new(p137 or 10, 0.1, p137 or 10);
    Part.Anchored = true;
    Part.Transparency = 1;
    local Decal = Instance.new("Decal");
    Decal.Parent = Part;
    Decal.Texture = p140 or "rbxassetid://8260787883";
    Decal.Face = "Top";
    Decal.Color3 = p139 or p136.Instance.Color;
    task.delay(p138 or 1, function() -- Line: 370
        -- upvalues: TweenService (ref), Decal (copy), Debris (ref), Part (copy)
        local v141 = TweenService:Create(Decal, TweenInfo.new(0.5), {
            Transparency = 1
        });
        v141:Play();
        v141.Completed:Connect(function() -- Line: 376
            -- upvalues: Debris (ref), Part (ref)
            Debris:AddItem(Part, 0.1);
        end);
    end);

    return Part;
end;

function u1.TimeScaleParticle(p142: table, p143: userdata, p144: number) -- Line: 384
    p143.Drag = p143.Drag * p144;
    p143.Speed = NumberRange.new(p143.Speed.Min * p144, p143.Speed.Max * p144);
    p143.Lifetime = NumberRange.new(p143.Lifetime.Min / p144, p143.Lifetime.Max / p144);
    p143.Rate = p143.Rate * p144;
    p143.RotSpeed = NumberRange.new(p143.RotSpeed.Min * p144, p143.RotSpeed.Max * p144);
    p143.Acceleration = p143.Acceleration * p144 ^ 2;

    if p143:GetAttribute("EmitDelay") then
        p143:SetAttribute("EmitDelay", p143:GetAttribute("EmitDelay") / p144);
    end;
end;

function u1.ScaleParticle(p145: table, p146: userdata, p147: number) -- Line: 399
    local v148 = {};

    for i, v in pairs(p146.Size.Keypoints) do
        v148[i] = NumberSequenceKeypoint.new(v.Time, v.Value * p147, v.Envelope * p147);
    end;

    p146.Size = NumberSequence.new(v148);
    p146.Drag = p146.Drag * p147;
    p146.Speed = NumberRange.new(p146.Speed.Min * p147, p146.Speed.Max * p147);
    p146.Lifetime = NumberRange.new(p146.Lifetime.Min * p147, p146.Lifetime.Max * p147);
    p146.Rate = p146.Rate * p147;
    p146.RotSpeed = NumberRange.new(p146.RotSpeed.Min * p147, p146.RotSpeed.Max * p147);
    p146.Acceleration = p146.Acceleration * p147;
end;

function u1.ScaleBeams(p149: table, p150: userdata, p151: userdata, p152: table, p153: number) -- Line: 421
    for _, v in ipairs(p152) do
        v.TextureLength = v.TextureLength * p153;
        v.ZOffset = v.ZOffset * p153;
        v.CurveSize0 = v.CurveSize0 * p153;
        v.CurveSize1 = v.CurveSize1 * p153;
        v.Width0 = v.Width0 * p153;
        v.Width1 = v.Width1 * p153;
    end;

    p150.Position = p150.Position * p153;
    p151.Position = p151.Position * p153;
end;

function u1.HeartbeatLoopFor(p154: table, u155: number, u156: function, u157: function) -- Line: 437
    -- upvalues: RunService (copy)
    local u158 = RunService:IsRunning() and time or os.clock;
    local u159 = nil;
    local u160 = u158();
    local u161 = false;
    u159 = RunService.Heartbeat:Connect(function(p162) -- Line: 449
        -- upvalues: u158 (copy), u160 (copy), u155 (copy), u156 (copy), u161 (ref), u157 (copy), u159 (ref)
        local v163 = u158() - u160;

        if v163 < u155 then
            u156(v163, p162, v163 / u155);

            return;
        end;

        if u161 == true or u157 == nil then
            if u159 ~= nil then
                u159:Disconnect();
                u159 = nil;
            end;
        else
            u161 = true;
            u157();

            if u159 ~= nil then
                u159:Disconnect();
                u159 = nil;
            end;
        end;
    end);

    return u159;
end;

function u1.RenderStepLoopFor(p164: table, u165: number, u166: function, p167: any, u168: function) -- Line: 475
    -- upvalues: RunService (copy)
    local u169 = RunService:IsRunning() and time or os.clock;
    local u170 = u169();
    local u171 = false;
    local u172 = "RenderStepLoop_" .. tostring(math.random(1000000000));
    RunService:BindToRenderStep(u172, p167, function(p173) -- Line: 487
        -- upvalues: u169 (copy), u170 (copy), u165 (copy), u166 (copy), u171 (ref), u168 (copy), RunService (ref), u172 (copy)
        local v174 = u169() - u170;

        if v174 < u165 then
            u166(v174, p173, v174 / u165);

            return;
        end;

        if not u171 and u168 then
            u171 = true;
            u168();
        end;

        RunService:UnbindFromRenderStep(u172);
    end);

    return function() -- Line: 501
        -- upvalues: RunService (ref), u172 (copy)
        RunService:UnbindFromRenderStep(u172);
    end;
end;

function u1.randPointInHorizDisc(p175, p176, p177) -- Line: 506
    -- upvalues: Random_new_ret (copy)
    local v178 = Random_new_ret:NextNumber(0, 6.283185307179586);
    local v179 = Random_new_ret:NextNumber(p176, p177);
    local v180 = math.cos(v178) * v179;
    local v181 = math.sin(v178) * v179;

    return Vector3.new(v180, 0, v181);
end;

function u1.InvertedSpringQuadraticParticles(p182: table, p183: userdata, p184: vector, p185: number) -- Line: 514
    -- upvalues: Visuals (copy), Random_new_ret (copy), RunService (copy), Debris (copy)
    local function quadraticCurve(p186, p187, p188, p189) -- Line: 536
        return p187 + p188 * p186 + p189 * p186 ^ 2 / 2;
    end;

    local function spring(p190, p191, p192) -- Line: 540
        return math.exp(-p191 * p190) * math.sin(p192 * p190);
    end;

    local u193 = {
        speed = 60,
        speedMinMultiplier = 0.5,
        speedMaxMultiplier = 1.5,
        gravity = -125,
        gravityMinMultiplier = 0.5,
        gravityMaXMultiplier = 1.5,
        lifetime = 0.8,
        lifetimeMinMultiplier = 1,
        lifetimeMaxMultiplier = 2,
        randomXZrotation = 40,
        randomYrotation = 180,
        amount = p185 or 40,
        parts = {}
    };

    for i = 1, p185 do
        local v194 = p183:Clone();
        v194.Parent = Visuals or workspace;
        v194.Position = p184;
        v194.CFrame = v194.CFrame * CFrame.Angles(Random_new_ret:NextNumber(-math.rad(u193.randomXZrotation), math.rad(u193.randomXZrotation) / 3), Random_new_ret:NextNumber(-math.rad(u193.randomYrotation), (math.rad(u193.randomYrotation))), Random_new_ret:NextNumber(-math.rad(u193.randomXZrotation), math.rad(u193.randomXZrotation) / 3));
        local parts = u193.parts;
        local v195 = {
            instance = v194,
            cframe = v194.CFrame,
            speed = u193.speed * Random_new_ret:NextNumber(u193.speedMinMultiplier, u193.speedMaxMultiplier),
            gravity = u193.gravity * Random_new_ret:NextNumber(u193.gravityMinMultiplier, u193.gravityMaXMultiplier),
            lifetime = u193.lifetime * Random_new_ret:NextNumber(u193.lifetimeMinMultiplier, u193.lifetimeMaxMultiplier),
            springMultiplier = math.random(1, u193.speedMaxMultiplier)
        };
        table.insert(parts, v195);
        local _ = i;
    end;

    local u196 = 0;
    local v202 = RunService.Heartbeat:Connect(function(p197) -- Line: 581
        -- upvalues: u196 (ref), u193 (copy), Debris (ref)
        u196 = u196 + p197;

        for _, v in pairs(u193.parts) do
            if u196 <= v.lifetime then
                local Position = v.cframe.Position;
                local v198 = v.cframe.RightVector * v.speed;
                local Vector3_new_ret = Vector3.new(0, -v.gravity, 0);
                local v199 = u196;
                v.instance.Position = Position + v198 * v199 + Vector3_new_ret * v199 ^ 2 / 2;
                local v200 = u196;
                local v201 = math.exp(-0.1 * v200) * math.sin(20 * v200);
                v.speed = v.speed + v201 * v.springMultiplier;
            else
                Debris:AddItem(v.instance, 0.5);
            end;
        end;
    end);
    task.wait(u193.lifetime * u193.lifetimeMaxMultiplier + 0.1);
    v202:Disconnect();

    return u193;
end;

function u1.ResizeParticles(p203: table, p204: userdata, p205: number) -- Line: 611
    local Model = Instance.new("Model");
    local Parent = p204.Parent;
    p204.Parent = Model;
    Model:ScaleTo(p205);
    p204.Parent = Parent;
    Model:Destroy();
end;

function u1.fadeLight(p206: table, p207: userdata, p208: number) -- Line: 621
    -- upvalues: TweenService (copy)
    TweenService:Create(p207, TweenInfo.new(p208), {
        Brightness = 0
    }):Play();
end;

function u1.fadeAllLights(p209: table, p210: userdata, p211: number) -- Line: 628
    -- upvalues: u1 (copy)
    for _, descendant in ipairs(p210:GetDescendants()) do
        if descendant:IsA("Light") then
            u1:fadeLight(descendant, p211);
        end;
    end;
end;

function u1.FadeAllBeamsTransparency(p212: table, p213: userdata, p214: number) -- Line: 636
    -- upvalues: TweenService (copy), RunService (copy)
    for _, descendant in p213:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Transparency = NumberSequence.new(0.6);
            descendant.Enabled = true;
            local u215 = p214 or 1;
            TweenService:Create(descendant, TweenInfo.new(u215, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                TextureSpeed = 0.1
            }):Play();
            local u216 = 0;
            local u217 = nil;
            u217 = RunService.Heartbeat:Connect(function(p218) -- Line: 659
                -- upvalues: u216 (ref), u215 (copy), descendant (copy), u217 (ref)
                u216 = u216 + p218;
                local math_min_ret = math.min(u216 / u215, 1);
                descendant.Transparency = NumberSequence.new(math_min_ret * 1);

                if u215 <= u216 then
                    descendant.Transparency = NumberSequence.new(1);
                    u217:Disconnect();
                end;
            end);
        end;
    end;
end;

function u1.OpenBeams(p219: table, p220: userdata, u221: number, u222: number) -- Line: 673
    -- upvalues: TweenService (copy)
    for _, descendant in ipairs(p220:GetDescendants()) do
        if descendant:IsA("Beam") then
            task.spawn(function() -- Line: 676
                -- upvalues: TweenService (ref), descendant (copy), u221 (copy), u222 (copy)
                TweenService:Create(descendant, TweenInfo.new(u221, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Width0 = descendant.Width0 * u222,
                    Width1 = descendant.Width1 * u222
                }):Play();
                descendant.Width0 = 0;
                descendant.Width1 = 0;
                descendant.Enabled = true;
            end);
        end;
    end;
end;

function u1.CloseBeams(p223: table, p224: userdata, u225: number) -- Line: 695
    -- upvalues: TweenService (copy)
    for _, descendant in ipairs(p224:GetDescendants()) do
        if descendant:IsA("Beam") then
            task.spawn(function() -- Line: 698
                -- upvalues: TweenService (ref), descendant (copy), u225 (copy)
                TweenService:Create(descendant, TweenInfo.new(u225, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

function u1.playSlash(p226: table, u227: userdata, u228: number, u229: number?, u230: number?) -- Line: 713
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 714
        -- upvalues: u227 (copy), u229 (copy), u1 (ref), u228 (copy), u230 (copy)
        local CFrame2 = u227.CFrame;
        local math_rad_ret = math.rad(u229 or 125);
        u1:RenderStepLoopFor(u228, function(p231, p232, p233) -- Line: 718
            -- upvalues: u227 (ref), CFrame2 (copy), math_rad_ret (copy)
            u227.CFrame = CFrame2 * CFrame.Angles(0, math_rad_ret * p233, 0);
        end, Enum.RenderPriority.Last.Value, function() -- Line: 720
        end);
        u1:OpenBeams(u227, 0.1, 1);
        task.wait(u230 or 0.1);
        u1:CloseBeams(u227, 0.2);
    end);
end;

function u1.GetRandomNormalCone(p234: table, p235: vector, p236: number) -- Line: 730
    -- upvalues: Vector3_FromNormalId_ret (copy), Random_new_ret (copy)
    local Unit = p235:Cross(p235:Cross(Vector3_FromNormalId_ret).Magnitude > 0.01 and Vector3_FromNormalId_ret or Vector3.new(1, 0, 0)).Unit;
    local v237 = Random_new_ret:NextNumber(0, p236);
    local math_rad_ret = math.rad(v237);
    local v238 = CFrame.fromAxisAngle(Unit, math_rad_ret):VectorToWorldSpace(p235);
    local v239 = Random_new_ret:NextNumber(0, 360);
    local math_rad_ret2 = math.rad(v239);

    return CFrame.fromAxisAngle(p235, math_rad_ret2):VectorToWorldSpace(v238);
end;

function u1.GetReflectedDirection(p240: table, p241: vector, p242: vector, p243: number) -- Line: 745
    -- upvalues: u1 (copy)
    return u1:GetRandomNormalCone((p241 - 2 * p241:Dot(p242) * p242).Unit, p243);
end;

function u1.CastToMouseCFrame(p244: table, p245: number?, p246: userdata, p247: boolean?, p248: userdata) -- Line: 756
    -- upvalues: workspace_CurrentCamera (copy)
    local v249 = workspace_CurrentCamera:ScreenPointToRay(p248.X, p248.Y);
    local v250 = workspace:Raycast(v249.Origin, v249.Direction * (p245 or 1000), p246);

    if not v250 then
        print("Raycast failed");

        return p248.Hit;
    end;

    local CFrame_new_ret = CFrame.new(v250.Position, v250.Position + v250.Normal);

    if p247 then
        return CFrame_new_ret * CFrame.Angles(-1.5707963267948966, 0, 0);
    end;

    return CFrame_new_ret;
end;

function u1.lockAndLookAtMouse(p251: table, u252: userdata, u253: userdata, u254: number) -- Line: 778
    -- upvalues: RunService (copy), Debris (copy)
    local Attachment = Instance.new("Attachment", u252);
    local VectorForce = Instance.new("VectorForce");
    VectorForce.Force = Vector3.new(0, workspace.Gravity * u252.AssemblyMass, 0);
    VectorForce.ApplyAtCenterOfMass = true;
    VectorForce.Attachment0 = Attachment;
    VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World;
    VectorForce.Parent = u252;
    local AlignOrientation = Instance.new("AlignOrientation");
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
    AlignOrientation.RigidityEnabled = true;
    AlignOrientation.MaxTorque = (1 / 0);
    AlignOrientation.Responsiveness = 200;
    AlignOrientation.Attachment0 = Attachment;
    AlignOrientation.Parent = u252;
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
    AlignPosition.MaxForce = (1 / 0);
    AlignPosition.Responsiveness = 200;
    AlignPosition.RigidityEnabled = true;
    AlignPosition.Attachment0 = Attachment;
    AlignPosition.Position = u252.Position;
    AlignPosition.Parent = u252;
    local u255 = tick();
    local u256 = nil;
    u256 = RunService.RenderStepped:Connect(function() -- Line: 807
        -- upvalues: u252 (copy), u256 (ref), u253 (copy), AlignOrientation (copy), u255 (copy), u254 (copy)
        if not (u252 and u252.Parent) then
            u256:Disconnect();

            return;
        end;

        AlignOrientation.CFrame = CFrame.lookAt(u252.Position, u252.Position + (u253.Hit.Position - u252.Position).Unit);

        if u254 <= tick() - u255 then
            u256:Disconnect();
        end;
    end);
    task.delay(u254, function() -- Line: 822
        -- upvalues: Debris (ref), Attachment (copy), VectorForce (copy), AlignOrientation (copy), AlignPosition (copy)
        Debris:AddItem(Attachment, 0);
        Debris:AddItem(VectorForce, 0);
        Debris:AddItem(AlignOrientation, 0);
        Debris:AddItem(AlignPosition, 0);
    end);
end;

function u1.ColorFrame(p257: table, p258: number, u259: number, p260, p261: vector, p262: number, p263: boolean) -- Line: 830
    -- upvalues: workspace_CurrentCamera (copy), Lighting (copy), TweenService (copy)
    if (p262 or 99999) >= (workspace_CurrentCamera.CFrame.Position - (p261 or workspace_CurrentCamera.CFrame.Position)).Magnitude then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.TintColor = Color3.new(1, 1, 1);
        ColorCorrectionEffect.Parent = Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(p258), {
            TintColor = p260
        }):Play();

        if not p263 then
            task.delay(p258, function() -- Line: 856
                -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), u259 (copy)
                if ColorCorrectionEffect then
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(u259), {
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                    task.wait(u259 + 0.05);

                    if ColorCorrectionEffect then
                        ColorCorrectionEffect:Destroy();
                    end;
                end;
            end);
        end;

        return ColorCorrectionEffect;
    end;
end;

function u1.ImpactFrame(p264: table, u265: number, u266: number, u267: table, u268, p269: vector, p270: number) -- Line: 874
    -- upvalues: workspace_CurrentCamera (copy), Lighting (copy)
    if p270 < (workspace_CurrentCamera.CFrame.Position - p269).Magnitude then
        return;
    end;

    task.defer(function() -- Line: 887
        -- upvalues: u267 (copy), u268 (copy), Lighting (ref), u266 (copy), u265 (copy)
        local v271 = {};

        for _, v in u267 do
            local Highlight = Instance.new("Highlight");
            Highlight.Name = "ImpactHighlight";
            Highlight.FillColor = u268;
            Highlight.OutlineTransparency = 1;
            Highlight.Parent = v;
            table.insert(v271, Highlight);
        end;

        local Impact = Lighting:FindFirstChild("Impact");

        if not Impact then
            Impact = Instance.new("ColorCorrectionEffect");
            Impact.Brightness = 0;
            Impact.Contrast = 0;
            Impact.Saturation = 0;
            Impact.Enabled = true;
            Impact.TintColor = Color3.fromRGB(255, 255, 255);
            Impact.Name = "Impact";
            Impact.Parent = Lighting;
        end;

        local v272 = Impact:Clone();
        v272.Parent = game:GetService("Lighting");
        v272.Brightness = -1;
        v272.Contrast = -100;
        v272.Saturation = -1;

        for i = 1, u266 do
            v272.Contrast = -100;
            task.wait(u265);
            v272.Contrast = 100;
            task.wait(u265);
            local _ = i;
        end;

        v272.Brightness = 0;
        v272.Contrast = 0;
        v272.Saturation = 0;
        v272:Destroy();

        for _, v in ipairs(v271) do
            if v.Parent ~= nil then
                v:Destroy();
            end;
        end;

        table.clear(v271);
    end);
end;

function u1.Shake(p273: table, u274: userdata, u275: number, p276: number?, p277: number?, p278: boolean?, p279: vector?, p280: boolean?, p281: number?) -- Line: 952
    -- upvalues: Random_new_ret (copy), RunService (copy)
    local CFrame2 = u274.CFrame;
    local u282 = tick();
    local u283 = nil;
    local u284 = p276 or 0.1;
    local u285 = p277 or 10;
    local u286 = p278 ~= false;
    local u287 = p279 or Vector3.new(1, 1, 1);
    local u288 = p280 or false;
    local u289 = p281 or 0.05;

    local function noise(p290: number, p291: number, p292: number) -- Line: 974
        local math_noise_ret = math.noise(p290, p291, p292);

        return math.clamp(math_noise_ret, -1, 1);
    end;

    local u293 = Random_new_ret:NextNumber(0, 1000000);
    u283 = RunService.Heartbeat:Connect(function(p294) -- Line: 984
        -- upvalues: u274 (copy), u283 (ref), u282 (copy), u275 (copy), CFrame2 (copy), u284 (ref), u286 (ref), u293 (ref), u287 (ref), u288 (ref), u289 (ref), u285 (ref)
        if not (u274 and u274.Parent) then
            if u283 then
                u283:Disconnect();
            end;

            return;
        end;

        local v295 = tick() - u282;

        if u275 <= v295 then
            u274.CFrame = CFrame2;

            if u283 then
                u283:Disconnect();
            end;

            return;
        end;

        local v296 = u284;

        if u286 then
            v296 = u284 * (1 - v295 / u275);
        end;

        local math_noise_ret = math.noise(u293, 0, 0);
        local v297 = math.clamp(math_noise_ret, -1, 1) * v296 or 0;
        local math_noise_ret2 = math.noise(0, u293 * 1.3, 0);
        local v298 = math.clamp(math_noise_ret2, -1, 1) * v296 or 0;
        local math_noise_ret3 = math.noise(0, 0, u293 * 0.8);
        local v299 = math.clamp(math_noise_ret3, -1, 1) * v296 or 0;
        local v300 = Vector3.new(v297, v298, v299) * u287;
        local v301 = CFrame2.Position + v300;
        local CFrame_identity = CFrame.identity;

        if u288 then
            local math_noise_ret4 = math.noise(u293 * 0.7, 0, 0);
            local v302 = math.clamp(math_noise_ret4, -1, 1) * u289 * v296 * u287.X;
            local math_noise_ret5 = math.noise(0, u293 * 0.9, 0);
            local v303 = math.clamp(math_noise_ret5, -1, 1) * u289 * v296 * u287.Y;
            local math_noise_ret6 = math.noise(0, 0, u293 * 0.5);
            local v304 = math.clamp(math_noise_ret6, -1, 1) * u289 * v296 * u287.Z;
            CFrame_identity = CFrame.Angles(v302, v303, v304);
        end;

        u274.CFrame = CFrame.new(v301) * CFrame2.Rotation * CFrame_identity;
        u293 = u293 + p294 * u285;
    end);

    return function(p305: boolean) -- Line: 1043
        -- upvalues: u283 (ref), u274 (copy), CFrame2 (copy)
        if u283 then
            u283:Disconnect();
        end;

        if u274 and (u274.Parent and p305) then
            u274.CFrame = CFrame2;
        end;
    end;
end;

return u1;