-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local u2 = {
    EffectInstance = nil,
    EmitDivider = 1,
    CurrentScale = 1,
    OriginalScale = {}
};
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local TableUtil = require(script.Parent:WaitForChild("TableUtil"));

local function evalColorSequence(p3: userdata, p4: number) -- Line: 26
    if p4 == 0 then
        return p3.Keypoints[1].Value;
    end;

    if p4 == 1 then
        return p3.Keypoints[#p3.Keypoints].Value;
    end;

    for i = 1, #p3.Keypoints - 1 do
        local v5 = p3.Keypoints[i];
        local v6 = p3.Keypoints[i + 1];

        if v5.Time <= p4 and p4 < v6.Time then
            local v7 = (p4 - v5.Time) / (v6.Time - v5.Time);

            return Color3.new((v6.Value.R - v5.Value.R) * v7 + v5.Value.R, (v6.Value.G - v5.Value.G) * v7 + v5.Value.G, (v6.Value.B - v5.Value.B) * v7 + v5.Value.B);
        end;

        local _ = i;
    end;
end;

function u1.new(p8: table) -- Line: 54
    -- upvalues: TableUtil (copy), u2 (copy), u1 (copy)
    local v9 = TableUtil.Reconcile(p8, u2);
    local v10 = {
        EffectInstance = v9.EffectInstance:Clone() or Instance.new("Part"),
        EmitDivider = v9.EmitDivider or 1,
        CurrentScale = v9.CurrentScale or 1,
        OriginalScale = v9.OriginalScale or {}
    };

    return setmetatable(v10, u1);
end;

function u1.SetCFrame(p11: table, p12) -- Line: 66
    if not p11.EffectInstance then
        return false;
    end;

    if p11.EffectInstance:IsA("BasePart") or (p11.EffectInstance:IsA("Part") or p11.EffectInstance:IsA("MeshPart")) then
        p11.EffectInstance.CFrame = p12;
    elseif p11.EffectInstance:IsA("Model") and p11.EffectInstance.PrimaryPart then
        p11.EffectInstance:SetPrimaryPartCFrame(p12);
    end;

    return true;
end;

function u1.AttachTo(p13: table, p14: userdata) -- Line: 78
    local WeldConstraint = Instance.new("WeldConstraint");
    p13.EffectInstance.Massless = true;
    p13.EffectInstance.CanCollide = false;
    WeldConstraint.Part0 = p14;
    WeldConstraint.Part1 = p13.EffectInstance;
    WeldConstraint.Parent = p13.EffectInstance;

    return WeldConstraint;
end;

function u1.Play(u15: table, p16: table) -- Line: 92
    if not u15.EffectInstance then
        return false;
    end;

    local Descendants = u15.EffectInstance:GetDescendants();
    table.insert(Descendants, u15.EffectInstance);
    local u17 = p16 or {};

    for _, v in ipairs(Descendants) do
        if v:IsA("ParticleEmitter") then
            local u18 = v:GetAttribute("EmitCount") or 1;
            local u19 = v:GetAttribute("EmitRepeat") or 1;
            local u20 = v:GetAttribute("EmitDelay") or 0;

            if u20 > 0 then
                task.delay(u20, function() -- Line: 107
                    -- upvalues: u19 (copy), u17 (ref), v (copy), u18 (copy), u15 (copy), u20 (copy)
                    for i = 1, u19 do
                        if not (table.find(u17, v) or table.find(u17, v.Name)) then
                            v:Emit((math.ceil(u18 / (u15.EmitDivider or 1))));
                        end;

                        task.wait(u20);
                        local _ = i;
                    end;
                end);
            else
                local v21 = v;

                for i = 1, u19 do
                    local v22;

                    if table.find(u17, v21) or table.find(u17, v21.Name) then
                        v22 = i;
                    else
                        v21:Emit((math.ceil(u18 / u15.EmitDivider)));
                        v22 = i;
                    end;
                end;
            end;
        end;
    end;

    return true;
end;

function u1.Emit(p23: table, p24: number, p25: table) -- Line: 128
    if not p23.EffectInstance then
        return false;
    end;

    local v26 = p25 or {};
    local v27 = p24 or 1;

    for _, descendant in ipairs(p23.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and not (table.find(v26, descendant) or table.find(v26, descendant.Name)) then
            descendant:Emit((math.ceil(v27 / p23.EmitDivider)));
        end;
    end;

    return true;
end;

function u1.EmitForSeconds(p28: table, p29: number, p30: table) -- Line: 145
    if not p28.EffectInstance then
        return false;
    end;

    local v31 = p30 or {};
    local u32 = {};

    for _, descendant in ipairs(p28.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local v33 = descendant:GetAttribute("EmitDelay") or 0;

            if not (table.find(v31, descendant) or table.find(v31, descendant.Name)) then
                if v33 > 0 then
                    task.delay(v33, function() -- Line: 158
                        -- upvalues: descendant (copy)
                        descendant.Enabled = true;
                    end);
                else
                    descendant.Enabled = true;
                end;

                table.insert(u32, descendant);
            end;
        end;
    end;

    task.delay(p29 or 1, function() -- Line: 169
        -- upvalues: u32 (copy)
        for _, v in ipairs(u32) do
            if v then
                v.Enabled = false;
            end;
        end;
    end);

    return true;
end;

function u1.Toggle(p34: table, p35: boolean, p36: table) -- Line: 179
    -- upvalues: TweenService (copy)
    if not p34.EffectInstance then
        return false;
    end;

    local v37 = p36 or {};

    for _, descendant in ipairs(p34.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            if not (table.find(v37, descendant) or table.find(v37, descendant.Name)) then
                local v38;

                if p35 == nil then
                    v38 = not descendant.Enabled;
                else
                    v38 = p35;
                end;

                descendant.Enabled = v38;
            end;
        elseif descendant:IsA("Beam") then
            descendant.Enabled = false;
        elseif descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
            TweenService:Create(descendant, TweenInfo.new(1), {
                Brightness = 0
            }):Play();
        end;
    end;

    return true;
end;

function u1.SetOriginalScale(p39: table, p40: userdata) -- Line: 200
    p39.OriginalScale[p40] = {};
    p39.OriginalScale[p40].Size = p40.Size;
    p39.OriginalScale[p40].Speed = p40.Speed;
    p39.OriginalScale[p40].Acceleration = p40.Acceleration;
end;

function u1.SetScale(p41: table, p42: number, p43: table, p44: boolean) -- Line: 207
    if not (p41.EffectInstance and p41.OriginalScale) then
        return false;
    end;

    p41.CurrentScale = p42;
    local v45 = p43 or {};

    for _, descendant in ipairs(p41.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            if not (table.find(v45, descendant) or table.find(v45, descendant.Name)) then
                if not p41.OriginalScale[descendant] or p44 then
                    p41:SetOriginalScale(descendant);
                end;

                local v46 = descendant;
                local v47 = {};

                for _, v in ipairs(p41.OriginalScale[descendant].Size.Keypoints) do
                    table.insert(v47, NumberSequenceKeypoint.new(v.Time, v.Value * p42, v.Envelope * p42));
                end;

                local NumberSequence_new_ret = NumberSequence.new(v47);
                local NumberRange_new_ret = NumberRange.new(p41.OriginalScale[v46].Speed.Min * p42, p41.OriginalScale[v46].Speed.Max * p42);
                local v48 = p41.OriginalScale[v46].Acceleration * p42;
                v46.Size = NumberSequence_new_ret;
                v46.Speed = NumberRange_new_ret;
                v46.Acceleration = v48;
            end;
        elseif descendant:IsA("Attachment") then
            descendant.Position = descendant.Position * p42;
        elseif descendant:IsA("Beam") then
            descendant.CurveSize0 = descendant.CurveSize0 * p42;
            descendant.CurveSize1 = descendant.CurveSize1 * p42;
            descendant.Width0 = descendant.Width0 * p42;
            descendant.Width1 = descendant.Width1 * p42;
        end;
    end;

    return true;
end;

function u1.SetColor(p49: table, p50: userdata, p51: table) -- Line: 250
    if not p49.EffectInstance then
        return false;
    end;

    local v52 = p51 or {};

    for _, descendant in ipairs(p49.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and not (table.find(v52, descendant) or table.find(v52, descendant.Name)) then
            descendant.Color = p50;
        end;
    end;

    return true;
end;

function u1.SetSize(p53: table, p54: userdata, p55: table) -- Line: 266
    if not p53.EffectInstance then
        return false;
    end;

    local v56 = p55 or {};

    for _, descendant in ipairs(p53.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and not (table.find(v56, descendant) or table.find(v56, descendant.Name)) then
            descendant.Size = p54;
        end;
    end;

    return true;
end;

function u1.SetDelayTimeScale(p57: table, p58: number, p59: table) -- Line: 282
    if not p57.EffectInstance then
        return false;
    end;

    local v60 = p59 or {};

    for _, descendant in ipairs(p57.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and not (table.find(v60, descendant) or (table.find(v60, descendant.Name) or not descendant:GetAttribute("EmitDelay"))) then
            descendant:SetAttribute("EmitDelay", descendant:GetAttribute("EmitDelay") * (1 / p58));
        end;
    end;

    return true;
end;

function u1.TweenScale(u61: table, u62: userdata, u63: number, p64: table) -- Line: 299
    -- upvalues: TweenService (copy), RunService (copy)
    local u65 = p64 or {};
    task.spawn(function() -- Line: 302
        -- upvalues: u61 (copy), u63 (copy), u62 (copy), TweenService (ref), u65 (ref), RunService (ref)
        local os_clock_ret = os.clock();
        local CurrentScale = u61.CurrentScale;
        u61.CurrentScale = u63;

        repeat
            local v66 = (os.clock() - os_clock_ret) / u62.Time;
            local Value = TweenService:GetValue(math.clamp(v66, 0, 1), u62.EasingStyle, u62.EasingDirection);
            u61:SetScale(CurrentScale + (u63 - CurrentScale) * Value, u65);
            RunService.Heartbeat:Wait();
        until os.clock() - os_clock_ret > u62.Time or not u61.EffectInstance;

        if not u61.EffectInstance then
            return;
        end;

        u61:SetScale(u63, u65);
    end);
end;

function u1.TweenColor(p67: table, u68: userdata, u69: userdata, p70: table) -- Line: 325
    -- upvalues: evalColorSequence (copy), TweenService (copy), RunService (copy)
    local v71 = p70 or {};
    local u72 = {};
    local u73 = {};

    for _, descendant in ipairs(p67.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and not (table.find(v71, descendant) or table.find(v71, descendant.Name)) then
            table.insert(u72, descendant);
        end;
    end;

    local function TickColor(p74) -- Line: 338
        -- upvalues: u72 (copy), u73 (copy), u69 (copy), evalColorSequence (ref)
        for _, v in ipairs(u72) do
            if v then
                if not u73[v] then
                    u73[v] = v.Color;
                end;

                local v75 = v;
                local v76 = {};

                for _, v2 in ipairs(u69.Keypoints) do
                    local v77 = evalColorSequence(u73[v75], v2.Time);
                    local Value = v2.Value;
                    table.insert(v76, ColorSequenceKeypoint.new(v2.Time, Color3.new(v77.R + (Value.R - v77.R) * p74, v77.G + (Value.G - v77.G) * p74, v77.B + (Value.B - v77.B) * p74)));
                end;

                v75.Color = ColorSequence.new(v76);
            end;
        end;
    end;

    task.spawn(function() -- Line: 359
        -- upvalues: u68 (copy), TweenService (ref), TickColor (copy), RunService (ref)
        local os_clock_ret = os.clock();

        repeat
            local v78 = (os.clock() - os_clock_ret) / u68.Time;
            TickColor((TweenService:GetValue(math.clamp(v78, 0, 1), u68.EasingStyle, u68.EasingDirection)));
            RunService.Heartbeat:Wait();
        until os.clock() - os_clock_ret > u68.Time;

        TickColor(1);
    end);
end;

function u1.IncrementDelay(p79: table, p80: any, p81: table) -- Line: 376
    local v82 = p81 or {};

    for _, descendant in ipairs(p79.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and not (table.find(v82, descendant) or (table.find(v82, descendant.Name) or not descendant:GetAttribute("EmitDelay"))) then
            descendant:SetAttribute("EmitDelay", descendant:GetAttribute("EmitDelay") + p80);
        end;
    end;
end;

function u1.UnLock(p83: table, p84: table) -- Line: 389
    local v85 = p84 or {};

    for _, descendant in ipairs(p83.EffectInstance:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and not (table.find(v85, descendant) or table.find(v85, descendant.Name)) then
            descendant.LockedToPart = false;
        end;
    end;
end;

function u1.Destroy(p86) -- Line: 401
    if p86.EffectInstance then
        p86.EffectInstance:Destroy();
    end;

    table.clear(p86);
    setmetatable(p86, nil);
end;

return u1;