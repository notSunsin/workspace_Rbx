-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Utility = require(ReplicatedStorage.Modules.EffectController.Utility.Utility);

local function lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

local u4 = {};
local u5 = { "rbxassetid://13080396681", "rbxassetid://13080396467", "rbxassetid://13080396272", "rbxassetid://13080396046", "rbxassetid://13080395739", "rbxassetid://13080395411", "rbxassetid://13080395112", "rbxassetid://13080394784", "rbxassetid://13080394488", "rbxassetid://13080394240", "rbxassetid://13080394013", "rbxassetid://13080393801", "rbxassetid://13080393553", "rbxassetid://13080393316", "rbxassetid://13080393039", "rbxassetid://13080392801", "rbxassetid://13080392599", "rbxassetid://13080392299", "rbxassetid://13080392045", "rbxassetid://13080391819", "rbxassetid://13080391566", "rbxassetid://13080391273", "rbxassetid://13080391030", "rbxassetid://13080391030", "rbxassetid://13080390759", "rbxassetid://13080389960" };
local u20 = {
    EmitParticles = function(p6: any, p7: number?, p8: number?, p9: boolean?) -- Line: 44, Name: EmitParticles
        -- upvalues: TweenService (copy)
        local v10 = next;
        local Descendants, v11 = p6:GetDescendants();
        local v12 = p9 or false;
        local v13 = p8 or 0.5;
        local v14 = p7 or 2;

        for _, v in v10, Descendants, v11 do
            if v:IsA("ParticleEmitter") then
                if v:GetAttribute("EmitDelay") then
                    task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 52
                        -- upvalues: v (copy)
                        v:Emit(v:GetAttribute("EmitCount"));
                    end);
                else
                    v:Emit(v:GetAttribute("EmitCount"));
                end;
            elseif (v:IsA("PointLight") or v:IsA("SpotLight")) and v12 == false then
                TweenService:Create(v, TweenInfo.new(v13, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true, 0), {
                    Brightness = v14
                }):Play();
            end;
        end;
    end,

    ParticleHandler = function(p15, p16, p17) -- Line: 68, Name: ParticleHandler
        -- upvalues: TweenService (copy)
        local v18 = next;
        local Descendants, v19 = p15:GetDescendants();

        for _, v in v18, Descendants, v19 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = p16;
            elseif v:IsA("PointLight") or v:IsA("SpotLight") then
                TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Brightness = p17
                }):Play();
            end;
        end;
    end
};

function u20.OwnTrails(u21, p22, p23, u24, p25) -- Line: 80
    -- upvalues: u20 (copy), Debris (copy)
    local u26 = p23 or 15;
    local u27 = p22 or 15;
    local u28 = p25 or 3;
    coroutine.wrap(function() -- Line: 87
        -- upvalues: u21 (copy), u24 (copy), u27 (ref), u26 (ref), u20 (ref), Debris (ref), u28 (ref)
        local Position = u21.Position;
        local Position2 = u24.Position;
        local math_random_ret = math.random(-u27, u27);
        local math_random_ret2 = math.random(-u27, u27);
        local v29 = (Position + Position2) / 2 + Vector3.new(math_random_ret, math_random_ret2, math.random(-u27, u27));

        for i = 1, u26 do
            local v30 = i / u26;
            local v31 = Position + (v29 - Position) * v30;
            u21.Position = v31 + (v29 + (Position2 - v29) * v30 - v31) * v30;
            Position2 = u24.Position;
            task.wait();
            local _ = i;
        end;

        u20.ParticleHandler(u21, false, 0);
        Debris:AddItem(u21, u28);
    end)();
end;

function u20.CreateTrails(p32, p33, u34, p35, p36, p37, p38) -- Line: 108
    -- upvalues: Debris (copy)
    local u39 = p33 or 15;
    local u40 = p32 or 15;
    local v41 = p38 or 2;
    local v42 = p35 or { Color3.fromRGB(255, 255, 255) };
    local v43 = v42[math.random(1, #v42)];
    local u44;

    if (p37 or false) and math.random(1, v41) == v41 then
        u44 = script.Trails.Trail2:Clone();
        u44.Attachment1.Trail.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, u40 * 0.01), NumberSequenceKeypoint.new(1, 0) });
    else
        u44 = script.Trails.Trail:Clone();
    end;

    u44.Attachment1.Trail.LightEmission = 0.5;
    u44.CFrame = u34.CFrame * CFrame.new(math.random(-u40, u40), math.random(-u40, u40), math.random(-u40, u40));
    u44.Attachment1.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v43), ColorSequenceKeypoint.new(1, v43) });
    u44.Parent = p36;
    coroutine.wrap(function() -- Line: 138
        -- upvalues: u44 (ref), u34 (copy), u40 (ref), u39 (ref), Debris (ref)
        local Position = u44.Position;
        local Position2 = u34.Position;
        local math_random_ret = math.random(-u40, u40);
        local math_random_ret2 = math.random(-u40, u40);
        local v45 = (Position + Position2) / 2 + Vector3.new(math_random_ret, math_random_ret2, math.random(-u40, u40));

        for i = 1, u39 do
            local v46 = i / u39;
            local v47 = Position + (v45 - Position) * v46;
            u44.Position = v47 + (v45 + (Position2 - v45) * v46 - v47) * v46;
            Position2 = u34.Position;
            task.wait();
            local _ = i;
        end;

        Debris:AddItem(u44, u44.Attachment1.Trail.Lifetime);
    end)();
end;

function u20.CreatePartTrails(p48, p49, u50) -- Line: 158
    -- upvalues: ReplicatedStorage2 (copy), Debris (copy), TweenService (copy)
    local u51 = p49 or 15;
    local v52 = p48 or 15;
    local Position = u50.Position;
    local math_random_ret = math.random(-v52, v52);
    local math_random_ret2 = math.random(-v52, v52);
    local u53 = Position + Vector3.new(math_random_ret, math_random_ret2, math.random(-v52, v52));
    local Position2 = u50.Position;
    local math_random_ret3 = math.random(-v52, v52);
    local math_random_ret4 = math.random(-v52, v52);
    local u54 = (u53 + Position2) / 2 + Vector3.new(math_random_ret3, math_random_ret4, math.random(-v52, v52));
    coroutine.wrap(function() -- Line: 166
        -- upvalues: u51 (ref), u53 (copy), u54 (copy), Position2 (ref), ReplicatedStorage2 (ref), Debris (ref), TweenService (ref), u50 (copy)
        for i = 1, u51 do
            local v55 = i / u51;
            local v56 = (i + 1) / u51;
            local v57 = u53;
            local v58 = v57 + (u54 - v57) * v55;
            local v59 = u54;
            local v60 = u53;
            local v61 = v60 + (u54 - v60) * v56;
            local v62 = u54;
            local v63 = v58 + (v59 + (Position2 - v59) * v55 - v58) * v55;
            local v64 = v61 + (v62 + (Position2 - v62) * v56 - v61) * v56;
            local Magnitude = (v64 - v63).Magnitude;
            local v65 = ReplicatedStorage2.GoIn:Clone();
            Debris:AddItem(v65, 0.025);
            v65.Position = v63;
            v65.CFrame = CFrame.lookAt(v65.Position, v64);
            v65.Parent = workspace.FX;
            TweenService:Create(v65, TweenInfo.new(0.025), {
                Size = Vector3.new(0.2, 0.2, Magnitude)
            }):Play();
            Position2 = u50.Position;
            task.wait();
            local _ = i;
        end;
    end)();
end;

function u20.Flipbook(p66: userdata, u67: number, u68: any) -- Line: 195
    local u69 = p66:FindFirstChildOfClass("Decal");

    if u69 and u68 then
        u69.Transparency = 1;
        coroutine.wrap(function() -- Line: 199
            -- upvalues: u68 (copy), u69 (copy), u67 (copy)
            for i = 1, #u68 do
                local v70 = u69;
                v70.Transparency = v70.Transparency - #u68 * 0.025;
                u69.Texture = u68[i];
                task.wait(1 / u67);
                local _ = i;
            end;

            u69.Texture = "";
        end)();
    end;
end;

function u20.GroundSmoke(p71: userdata) -- Line: 211
    -- upvalues: TweenService (copy), u20 (copy), u5 (copy)
    local v72 = Random.new():NextNumber(125, 500);
    local u73 = script.SmokeMesh:Clone();
    u73.Decal.ZIndex = math.random(1, 10000000);
    u73.Decal.Color3 = Color3.fromRGB(1 * v72, 1 * v72, 1 * v72);
    local v74 = p71.CFrame * CFrame.new(0, -1, 0);
    local CFrame_Angles = CFrame.Angles;
    local math_random_ret = math.random(-360, 360);
    u73.CFrame = v74 * CFrame_Angles(0, math.rad(math_random_ret), 0);
    u73.Parent = workspace.World.Alive;
    TweenService:Create(u73.Mesh, TweenInfo.new(0.75), {
        Scale = Vector3.new(2, 0, 2) * Random.new():NextNumber(0.5, 1.25)
    }):Play();
    TweenService:Create(u73, TweenInfo.new(0.75), {
        CFrame = u73.CFrame * CFrame.Angles(0, -2.0943951023931953, 0) * CFrame.new(0, -2.5, 0)
    }):Play();
    TweenService:Create(u73.Decal, TweenInfo.new(0.125), {
        Transparency = 0
    }):Play();
    task.delay(0.1, function() -- Line: 223
        -- upvalues: TweenService (ref), u73 (copy)
        TweenService:Create(u73.Decal, TweenInfo.new(0.625), {
            Transparency = 1
        }):Play();
    end);
    u20.Flipbook(u73, 48, u5);
end;

function u20.ImpactFrame(p75, p76) -- Line: 230
    -- upvalues: Debris (copy)
    local v77 = next;
    local Children, v78 = game.Lighting:GetChildren();
    local u79 = p76 or 0.06;

    for _, v in v77, Children, v78 do
        if v:IsA("ColorCorrectionEffect") then
            v.Enabled = false;
        end;
    end;

    for i = 1, #p75 do
        local Highlight = Instance.new("Highlight");
        Highlight.FillTransparency = 0;
        Highlight.OutlineTransparency = 1;
        Highlight.FillColor = Color3.new(1, 1, 1);
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.Parent = p75[i];
        task.delay(u79 * 0.5, function() -- Line: 246
            -- upvalues: Highlight (copy)
            Highlight.FillColor = Color3.new(0, 0, 0);
        end);
        Debris:AddItem(Highlight, u79);
        local _ = i;
    end;

    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.new(0, 0, 0);
    ColorCorrectionEffect.Brightness = 3;
    task.delay(u79 * 0.5, function() -- Line: 255
        -- upvalues: ColorCorrectionEffect (copy), u79 (ref)
        ColorCorrectionEffect.TintColor = Color3.new(1, 1, 1);
        task.wait(u79 * 0.5);
        local v80 = next;
        local Children2, v81 = game.Lighting:GetChildren();

        for _, v in v80, Children2, v81 do
            if v:IsA("ColorCorrectionEffect") then
                v.Enabled = true;
            end;
        end;
    end);
    ColorCorrectionEffect.Parent = game.Lighting;
    Debris:AddItem(ColorCorrectionEffect, u79);
end;

function u20.BlackWhite(p82) -- Line: 270
    -- upvalues: Debris (copy)
    local u83 = p82 or 0.08;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    Debris:AddItem(ColorCorrectionEffect, 1);
    ColorCorrectionEffect.Contrast = 5;
    ColorCorrectionEffect.Saturation = -1;
    ColorCorrectionEffect.Enabled = false;
    ColorCorrectionEffect.Parent = game.Lighting;
    local ColorCorrectionEffect2 = Instance.new("ColorCorrectionEffect");
    Debris:AddItem(ColorCorrectionEffect2, 1);
    ColorCorrectionEffect2.Contrast = -3;
    ColorCorrectionEffect2.Saturation = -1;
    ColorCorrectionEffect2.Enabled = false;
    ColorCorrectionEffect2.Parent = game.Lighting;
    ColorCorrectionEffect.Enabled = true;
    task.delay(u83, function() -- Line: 288
        -- upvalues: ColorCorrectionEffect (copy), ColorCorrectionEffect2 (copy), u83 (ref)
        ColorCorrectionEffect.Enabled = false;
        ColorCorrectionEffect2.Enabled = true;
        task.wait(u83);
        ColorCorrectionEffect2.Enabled = false;
    end);
end;

function u20.BloomBlur() -- Line: 296
    -- upvalues: Debris (copy), TweenService (copy)
    local TweenInfo_new = TweenInfo.new;
    local BlurEffect = Instance.new("BlurEffect");
    local BloomEffect = Instance.new("BloomEffect");
    BlurEffect.Parent = game.Lighting;
    BloomEffect.Parent = game.Lighting;
    Debris:AddItem(BlurEffect, 0.5);
    Debris:AddItem(BloomEffect, 0.5);
    BlurEffect.Name = "Blur";
    BloomEffect.Name = "Bloom";
    TweenService:Create(BlurEffect, TweenInfo_new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = math.random(8, 12)
    }):Play();
    TweenService:Create(BloomEffect, TweenInfo_new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Intensity = 3,
        Size = 35,
        Threshold = 1
    }):Play();
    task.delay(0.1, function() -- Line: 312
        -- upvalues: TweenService (ref), BlurEffect (copy), TweenInfo_new (copy), BloomEffect (copy)
        TweenService:Create(BlurEffect, TweenInfo_new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        TweenService:Create(BloomEffect, TweenInfo_new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Intensity = 1,
            Size = 24,
            Threshold = 2
        }):Play();
    end);
end;

function u20.JustBlur(p84) -- Line: 319
    -- upvalues: Debris (copy), TweenService (copy)
    local TweenInfo_new = TweenInfo.new;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Parent = game.Lighting;
    Debris:AddItem(BlurEffect, p84);
    BlurEffect.Name = "Blur";
    TweenService:Create(BlurEffect, TweenInfo_new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = math.random(8, 12)
    }):Play();
    task.delay(p84 - 0.5, function() -- Line: 331
        -- upvalues: TweenService (ref), BlurEffect (copy), TweenInfo_new (copy)
        TweenService:Create(BlurEffect, TweenInfo_new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
    end);
end;

function u20.JustBloom(p85) -- Line: 336
    -- upvalues: Debris (copy), TweenService (copy)
    local v86 = p85 or 1;
    local TweenInfo_new = TweenInfo.new;
    local BloomEffect = Instance.new("BloomEffect");
    BloomEffect.Parent = game.Lighting;
    Debris:AddItem(BloomEffect, v86);
    BloomEffect.Name = "Bloom";
    TweenService:Create(BloomEffect, TweenInfo_new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Intensity = 3,
        Size = 35,
        Threshold = 1
    }):Play();
    task.delay(v86 - 0.5, function() -- Line: 345
        -- upvalues: TweenService (ref), BloomEffect (copy), TweenInfo_new (copy)
        TweenService:Create(BloomEffect, TweenInfo_new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Intensity = 1,
            Size = 24,
            Threshold = 2
        }):Play();
    end);
end;

function u20.AddColorDepth(p87, p88) -- Line: 350
    -- upvalues: Debris (copy), TweenService (copy)
    local u89 = p87 or 1;
    local u90 = p88 or 0.35;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    Debris:AddItem(ColorCorrectionEffect, u89 + u90);
    ColorCorrectionEffect.Saturation = 0.2;
    ColorCorrectionEffect.Contrast = 0.1;
    ColorCorrectionEffect.Parent = game.Lighting;
    task.delay(u90, function() -- Line: 360
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), u89 (ref), u90 (ref)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
            Saturation = 0.2,
            Contrast = 0.1
        }):Play();
        task.wait(u89 - u90);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
            Saturation = 0,
            Contrast = 0
        }):Play();
    end);
end;

function u20.GroundRocks(p91, p92, p93, p94, p95, u96, u97) -- Line: 367
    -- upvalues: Utility (copy), TweenService (copy)
    local v98 = p92 or -10;

    for i = 1, p93 do
        local CFrame_new_ret = CFrame.new(p91);
        local v99 = workspace:Raycast(CFrame_new_ret.Position, Vector3.new(0, v98, 0), Utility.RayParams);
        local v100;

        if v99 and (v99.Instance and v99.Position) then
            local Part = Instance.new("Part");
            Part.Parent = workspace.World.ClientEffects;
            Part.Name = "Rock";
            Part.Anchored = false;
            Part.CanCollide = true;
            Part.CollisionGroup = "Humanoid";
            local v101 = math.random(10, p94 * 100) / 100;
            Part.Size = Vector3.new(v101, v101 / 1.5, v101 / 1.5);
            local CFrame_new_ret2 = CFrame.new(v99.Position);
            local CFrame_Angles = CFrame.Angles;
            local math_random_ret = math.random(-360, 360);
            local math_rad_ret = math.rad(math_random_ret);
            local math_random_ret2 = math.random(-360, 360);
            local math_rad_ret2 = math.rad(math_random_ret2);
            local math_random_ret3 = math.random(-360, 360);
            Part.CFrame = CFrame_new_ret2 * CFrame_Angles(math_rad_ret, math_rad_ret2, (math.rad(math_random_ret3)));
            Part.Material = v99.Material;
            Part.MaterialVariant = v99.Instance.MaterialVariant;
            Part.Color = v99.Instance.Color;
            local v102 = Random.new():NextInteger(-2, 2);
            local v103 = Random.new():NextInteger(-2, 2);
            local Unit = (v99.Position + Vector3.new(0, 5, 0) - (v99.Position + Vector3.new(v102, 1, v103))).Unit;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Name = "Fly";
            BodyVelocity.Parent = Part;
            BodyVelocity.P = 2000;
            BodyVelocity.MaxForce = Vector3.new(25000, 25000, 25000);
            BodyVelocity.Velocity = Unit * p95;
            task.delay(0.2, function() -- Line: 401
                -- upvalues: BodyVelocity (copy), u96 (copy), TweenService (ref), Part (copy), u97 (copy)
                BodyVelocity:Destroy();
                task.wait(u96);
                TweenService:Create(Part, TweenInfo.new(u97, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = Vector3.new()
                }):Play();
                task.wait(1);
                Part:Destroy();
            end);
            v100 = i;
        else
            v100 = i;
        end;
    end;
end;

function u20.JuanGroundRock(p104, u105) -- Line: 412
    -- upvalues: Utility (copy), Debris (copy), TweenService (copy)
    local math_random_ret = math.random(0, 30);
    local Position = p104.Position;
    local v106 = workspace:Raycast(p104.Position, Vector3.new(0, -25, 0), Utility.RayParams);

    if v106 then
        local u107 = script.Rocks.Rock:Clone();
        local v108 = u107.Size.X * Random.new():NextNumber(1, 2.25);
        local v109 = u107.Size.Y * Random.new():NextNumber(1, 2.25);
        local v110 = u107.Size.Z * Random.new():NextNumber(1, 1.9);
        local Vector3_new_ret = Vector3.new(v108, v109, v110);
        Debris:AddItem(u107, 3);
        u107.CFrame = p104.CFrame * CFrame.new(-u105 * Random.new():NextNumber(1, 1.5), -v106.Distance, 0);
        u107.Size = Vector3.new(0, 0, 0);
        u107.Parent = workspace.World.ClientEffects;
        local CFrame_lookAt_ret = CFrame.lookAt(u107.Position, Position);
        local CFrame_Angles = CFrame.Angles;
        local math_rad_ret = math.rad(math_random_ret);
        local math_random_ret2 = math.random(-10, 10);
        local math_rad_ret2 = math.rad(math_random_ret2);
        local math_random_ret3 = math.random(-10, 10);
        u107.CFrame = CFrame_lookAt_ret * CFrame_Angles(math_rad_ret, math_rad_ret2, (math.rad(math_random_ret3)));
        u107.BrickColor = BrickColor.new("Dark grey");
        u107.Material = Enum.Material.Concrete;
        u107.MaterialVariant = v106.Instance.MaterialVariant;
        TweenService:Create(u107, TweenInfo.new(0.3), {
            Size = Vector3_new_ret
        }):Play();
        local u111 = 90 - math_random_ret;
        task.delay(1.7, function() -- Line: 433
            -- upvalues: TweenService (ref), u107 (copy), u105 (copy), u111 (copy)
            TweenService:Create(u107, TweenInfo.new(1), {
                CFrame = u107.CFrame * CFrame.new(-(u105 * 2), -11.5, 0) * CFrame.Angles(math.rad(u111), 0, 0)
            }):Play();
        end);
    end;
end;

function u20.throwRock(p112, p113: any, p114: any, p115: any) -- Line: 440
    -- upvalues: Debris (copy), TweenService (copy)
    local v116 = p115 or 180;
    local u117 = script.Rocks["Rock" .. math.random(1, 3)]:Clone();
    u117.Size = u117.Size * Random.new():NextNumber(1.01, p113 or 2);
    u117.CanCollide = false;
    local v118 = p112 * CFrame.new(math.random(-5, 5), math.random(0, 5), math.random(-5, 5));
    local CFrame_Angles = CFrame.Angles;
    local math_random_ret = math.random(-v116, v116);
    local math_rad_ret = math.rad(math_random_ret);
    local math_random_ret2 = math.random(-v116, v116);
    u117.CFrame = v118 * CFrame_Angles(math_rad_ret, 0, (math.rad(math_random_ret2)));
    u117.Parent = workspace.World.ClientEffects;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(100000000, 100000000, 100000000);
    BodyVelocity.P = 1000;
    BodyVelocity.Velocity = u117.CFrame.UpVector * math.random(15, p114 or 75);
    BodyVelocity.Parent = u117;
    Debris:AddItem(BodyVelocity, 0.2);
    task.delay(0.1, function() -- Line: 457
        -- upvalues: u117 (copy)
        u117.CanCollide = true;
    end);
    task.delay(2, function() -- Line: 460
        -- upvalues: u117 (copy), TweenService (ref), Debris (ref)
        u117.Start.Trail.Enabled = false;
        TweenService:Create(u117, TweenInfo.new(0.5), {
            Size = Vector3.new(0, 0, 0)
        }):Play();
        Debris:AddItem(u117, 0.5);
    end);
end;

function u20.LeftRightRock(p119, p120, p121, p122) -- Line: 467
    -- upvalues: Utility (copy), Debris (copy), TweenService (copy)
    local RayParams = Utility.RayParams;
    local v123 = workspace:Raycast(p119.Position, Vector3.new(0, -p120 or -25, 0), RayParams);

    if v123 then
        local Part = Instance.new("Part");
        Debris:AddItem(Part, 3);
        Part.Anchored = true;
        Part.CanCollide = true;
        Part.CFrame = CFrame.new(v123.Position, v123.Position + v123.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        Part.Position = Part.Position + p119.CFrame.RightVector * p121;
        local math_random_ret = math.random(-360, 360);
        local math_random_ret2 = math.random(-360, 360);
        Part.Orientation = Vector3.new(math_random_ret, math_random_ret2, math.random(-360, 360));
        Part.Material = v123.Instance.Material;
        Part.MaterialVariant = v123.Instance.MaterialVariant;
        Part.Color = v123.Instance.Color;
        Part.Parent = workspace.World.ClientEffects;
        local u124 = Part:Clone();
        Debris:AddItem(u124, 3);
        u124.CFrame = CFrame.new(v123.Position, v123.Position + v123.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        u124.Position = u124.Position + p119.CFrame.RightVector * -p121;
        local math_random_ret3 = math.random(-360, 360);
        local math_random_ret4 = math.random(-360, 360);
        u124.Orientation = Vector3.new(math_random_ret3, math_random_ret4, math.random(-360, 360));
        u124.Parent = workspace.World.ClientEffects;
        TweenService:Create(Part, TweenInfo.new(0.2), {
            Size = Vector3.new(1, 1, 1) * p122
        }):Play();
        TweenService:Create(u124, TweenInfo.new(0.2), {
            Size = Vector3.new(1, 1, 1) * p122
        }):Play();
        task.delay(2.5, function() -- Line: 496
            -- upvalues: TweenService (ref), Part (copy), u124 (copy)
            TweenService:Create(Part, TweenInfo.new(0.5), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
            TweenService:Create(u124, TweenInfo.new(0.5), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
        end);
    end;
end;

function u20.Crater(p125, p126, p127, p128, p129, p130, p131) -- Line: 503
    -- upvalues: Utility (copy), Debris (copy), TweenService (copy)
    local v132 = p129 or 1;
    local v133 = p130 or 360;
    local v134 = p131 or 0;
    local v135 = p128 or 5;
    local v136 = p126 or 12;
    local RayParams = Utility.RayParams;
    local v137 = workspace:Raycast(p125.Position, Vector3.new(0, p127 or -25, 0), RayParams);
    local v138 = 0;

    if v137 then
        local Position = (p125.CFrame * CFrame.new(0, -v137.Distance, -1)).Position;
        local v139 = script.Part:Clone();
        Debris:AddItem(v139, 1);
        v139.Anchored = true;
        v139.CanCollide = true;
        v139.CFrame = CFrame.new(v137.Position, v137.Position + v137.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        v139.CFrame = CFrame.lookAt(v139.Position, Position) * CFrame.Angles(0, math.rad(v134), 0);
        v139.Parent = workspace.World.ClientEffects;

        for i = 1, v136 do
            v139.CFrame = CFrame.lookAt(v139.Position, Position) * CFrame.Angles(0, math.rad(v134), 0) * CFrame.Angles(0, math.rad(v138), 0);
            local Part = Instance.new("Part");
            Debris:AddItem(Part, 3);
            Part.Anchored = true;
            Part.CanCollide = true;
            Part.CFrame = v139.CFrame * CFrame.new(0, 0, -v135);
            local math_random_ret = math.random(-360, 360);
            local math_random_ret2 = math.random(-360, 360);
            Part.Orientation = Vector3.new(math_random_ret, math_random_ret2, math.random(-360, 360));
            Part.Material = v137.Instance.Material;
            Part.MaterialVariant = v137.Instance.MaterialVariant;
            Part.Color = v137.Instance.Color;
            Part.Parent = workspace.World.ClientEffects;
            v138 = v138 + v133 / v136;
            TweenService:Create(Part, TweenInfo.new(0.2), {
                Size = Vector3.new(1, 1, 1) * v132
            }):Play();
            task.delay(2.5, function() -- Line: 544
                -- upvalues: TweenService (ref), Part (copy)
                TweenService:Create(Part, TweenInfo.new(0.5), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();
            end);
            local _ = i;
        end;
    end;
end;

function u20.DecreaseBeamSize(p140, p141) -- Line: 552
    -- upvalues: TweenService (copy)
    local v142 = next;
    local Descendants, v143 = p140:GetDescendants();

    for _, v in v142, Descendants, v143 do
        if v:IsA("Beam") then
            TweenService:Create(v, TweenInfo.new(p141), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;
end;

function u20.CreateWeld(p144, p145) -- Line: 569
    local Weld = Instance.new("Weld");
    Weld.Part0 = p144;
    Weld.Part1 = p145;
    Weld.Parent = p144;

    return Weld;
end;

function u20.RememberParticleSize(p146) -- Line: 577
    -- upvalues: u4 (copy)
    local v147 = next;
    local Descendants, v148 = p146:GetDescendants();

    for _, v in v147, Descendants, v148 do
        if v:IsA("ParticleEmitter") then
            u4[v.Name] = v.Size.Keypoints[2].Value;
        end;
    end;
end;

function u20.UnRememberParticleSize(p149) -- Line: 585
    -- upvalues: u4 (copy)
    local v150 = next;
    local Descendants, v151 = p149:GetDescendants();

    for _, v in v150, Descendants, v151 do
        if v:IsA("ParticleEmitter") then
            u4[v.Name] = nil;
        end;
    end;
end;

function u20.ScaleParticles(p152, p153) -- Line: 593
    -- upvalues: u4 (copy)
    local v154 = next;
    local Descendants, v155 = p152:GetDescendants();

    for _, v in v154, Descendants, v155 do
        if v:IsA("ParticleEmitter") then
            if u4[v.Name] then
                local v156 = u4[v.Name] + p153;
                v.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, v156) });
            else
                warn(v.Name, "Has No Saved Scale Value");
            end;
        end;
    end;
end;

return u20;