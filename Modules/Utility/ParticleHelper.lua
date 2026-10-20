-- Decompiled with Potassium's decompiler.

local u13 = {
    ToggleBeams = function(p1: table, p2: any, p3: boolean) -- Line: 9, Name: ToggleBeams
        if not p2 then
            warn("ParticleHelper:ToggleBeams | no beams provided");

            return;
        end;

        if typeof(p2) == "Instance" then
            p2 = p2:GetDescendants();
        end;

        for _, v in p2 do
            if v:IsA("Beam") then
                v.Enabled = p3;
            end;
        end;
    end,

    ToggleTrails = function(p4: table, p5: any, p6: boolean) -- Line: 24, Name: ToggleTrails
        if not p5 then
            warn("ParticleHelper:ToggleTrails | no trails provided");

            return;
        end;

        if typeof(p5) == "Instance" then
            p5 = p5:GetDescendants();
        end;

        for _, v in p5 do
            if v:IsA("Trail") then
                v.Enabled = p6;
            end;
        end;
    end,

    ToggleParticles = function(p7: table, p8: any, p9: boolean) -- Line: 39, Name: ToggleParticles
        if not p8 then
            warn("ParticleHelper:ToggleParticles | no particles provided");

            return;
        end;

        if typeof(p8) == "Instance" then
            p8 = p8:GetDescendants();
        end;

        for _, v in p8 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = p9;
            end;
        end;
    end,

    EmitParticles = function(p10: table, p11: any, u12: number?) -- Line: 54, Name: EmitParticles
        if not p11 then
            warn("ParticleHelper:EmitParticles | no particles provided");

            return;
        end;

        if typeof(p11) == "Instance" then
            p11 = p11:GetDescendants();
        end;

        for _, v in p11 do
            if v:IsA("ParticleEmitter") then
                task.delay(v:GetAttribute("EmitDelay") or 0, function() -- Line: 64
                    -- upvalues: v (copy), u12 (copy)
                    v:Emit(u12 or (v:GetAttribute("EmitCount") or 0));
                end);
            end;
        end;
    end
};

function u13.EmitTempParticles(p14: table, p15: userdata, p16: number?) -- Line: 75
    -- upvalues: u13 (copy)
    if not p15 then
        warn("ParticleHelper:EmitTempParticles | no particle parent provided");

        return nil;
    end;

    local u17 = p15:Clone();
    u17.Parent = workspace:FindFirstChild("Visuals") or workspace;
    u17.CFrame = p15.WorldCFrame;
    u13:EmitParticles(u17, p16);
    local v18 = 0;

    for _, descendant in u17:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            local v19 = descendant:GetAttribute("Lifetime") or descendant.Lifetime.Max;

            if v18 < v19 then
                v18 = v19;
            end;
        end;
    end;

    task.delay(v18, function() -- Line: 93
        -- upvalues: u17 (copy)
        u17:Destroy();
    end);

    return u17;
end;

return u13;