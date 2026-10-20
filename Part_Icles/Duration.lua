-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local u1 = {};

local function resolveDuration(p2) -- Line: 15
    if p2 == nil then
        return 0;
    end;

    if typeof(p2) == "number" then
        return p2;
    end;

    local v3 = {};

    for i in tostring(p2):gmatch("[^,]+") do
        local v4 = tonumber(i:match("^%s*(.-)%s*$"));

        if v4 then
            table.insert(v3, v4);
        end;
    end;

    if #v3 == 0 then
        return 0;
    end;

    if #v3 == 1 then
        return v3[1];
    end;

    return math.max(v3[1], v3[2]);
end;

function u1.computeTrueLifetime(p5, p6, p7) -- Line: 32
    -- upvalues: Graph (copy)
    if not p5 or p5 <= 0 then
        return 0;
    end;

    if not p6 then
        return p5;
    end;

    if Graph.IsStatic(p6) then
        local StaticValue = Graph.GetStaticValue(p6, 1);

        if StaticValue == 1 then
            return p5;
        end;

        if StaticValue == 0 then
            return nil;
        end;

        if StaticValue > 0 then
            return p5 / StaticValue;
        end;

        return p5 / -StaticValue;
    end;

    local v8 = p7 or {};
    local v9 = Graph.QueryPointsWithTime(0, p6, v8) < 0;
    local v10 = p5 / 200;
    local v11 = v9 and p5 and p5 or 0;
    local v12 = 0;

    for i = 1, 200 do
        local v13 = v11 + Graph.QueryPointsWithTime(i / 200, p6, v8) * v10;

        if not v9 and p5 <= v13 then
            return v12 + (p5 - v11) / (v13 - v11) * v10;
        end;

        if v9 and v13 <= 0 then
            return v12 + v11 / (v11 - v13) * v10;
        end;

        v12 = v12 + v10;
        v11 = v13;
        local _ = i;
    end;

    local v14 = Graph.QueryPointsWithTime(1, p6, v8);

    if v9 then
        if v14 >= 0 then
            return nil;
        end;

        return v12 + v11 / -v14;
    end;

    if v14 <= 0 then
        return nil;
    end;

    return v12 + (p5 - v11) / v14;
end;

function u1.computeItemLifecycle(p15) -- Line: 85
    -- upvalues: resolveDuration (copy), u1 (copy)
    if not p15:GetAttribute("Transformed") then
        if not p15:IsA("ParticleEmitter") then
            if p15:IsA("Trail") then
                local v16 = p15:GetAttribute("EmitDelay") or 0;
                local v17 = resolveDuration(p15:GetAttribute("EmitDuration"));

                return v17 > 0 and {
                    infinite = false,
                    emitDelay = v16,
                    emitDur = v17,
                    lifecycle = p15.Lifetime or 0
                } or nil;
            end;

            if not p15:IsA("Beam") then
                return nil;
            end;

            local v18 = tonumber(p15:GetAttribute("EmitDelay")) or 0;
            local v19 = tonumber(p15:GetAttribute("EmitDuration")) or 0;

            return v19 > 0 and {
                lifecycle = 0,
                infinite = false,
                emitDelay = v18,
                emitDur = v19
            } or nil;
        end;

        local Attribute = p15:GetAttribute("EmitCount");
        local v20 = tonumber(p15:GetAttribute("EmitDelay")) or 0;
        local v21 = tonumber(p15:GetAttribute("EmitDuration")) or 0;

        if (Attribute == nil and 1 or Attribute) <= 0 and v21 <= 0 then
            return nil;
        end;

        local Lifetime = p15.Lifetime;

        return {
            infinite = false,
            emitDelay = v20,
            emitDur = v21,
            lifecycle = typeof(Lifetime) == "NumberRange" and (Lifetime.Max or 0) or 0
        };
    end;

    local PartIcleProperties = p15:FindFirstChild("PartIcleProperties");
    local v22 = p15:GetAttribute("EmitDelay") or 0;
    local v23 = resolveDuration(p15:GetAttribute("EmitDuration"));
    local Attribute = p15:GetAttribute("EmitCount");
    local v24 = p15:GetAttribute("EmissionMode") or "Emit";
    local v25 = p15:GetAttribute("AnimateLoop") == true;

    if v24 == "Animate" and (v25 and v23 <= 0) then
        return {
            emitDur = 0,
            lifecycle = 0,
            infinite = true,
            emitDelay = v22
        };
    end;

    if (Attribute == nil and 1 or Attribute) <= 0 and v23 <= 0 and v24 ~= "Animate" then
        return nil;
    end;

    local v26;

    if PartIcleProperties then
        v26 = PartIcleProperties:GetAttribute("Lifetime");
    else
        v26 = PartIcleProperties;
    end;

    local v27 = 0;

    if typeof(v26) == "NumberRange" then
        v26 = v26.Max;
    elseif type(v26) ~= "number" then
        v26 = v27;
    end;

    local v28;

    if PartIcleProperties then
        v28 = PartIcleProperties:GetAttribute("Timescale");
    else
        v28 = PartIcleProperties;
    end;

    local v29 = u1.computeTrueLifetime(v26, v28, nil);

    if v29 == nil then
        return {
            lifecycle = 0,
            infinite = true,
            emitDelay = v22,
            emitDur = v23
        };
    end;

    local v30 = PartIcleProperties and PartIcleProperties:GetAttribute("PartLife") or 0;

    if v24 == "Animate" then
        if v23 < v29 then
            v23 = v29;
        end;
    end;

    return {
        infinite = false,
        emitDelay = v22,
        emitDur = v23,
        lifecycle = v29 + v30
    };
end;

function u1.computeMaxDuration(p31, p32) -- Line: 151
    -- upvalues: u1 (copy)
    if not p31 then
        return 0;
    end;

    local v33 = p32 or 0;
    local v34 = u1.computeItemLifecycle(p31);
    local v35 = 0;
    local v36 = false;

    if v34 then
        if v34.infinite then
            return nil;
        end;

        v35 = v33 + v34.emitDelay + v34.emitDur + v34.lifecycle;
        v33 = v33 + v34.emitDelay;
        p31:GetAttribute("Transformed");
    elseif p31:GetAttribute("Transformed") then
        v36 = true;
    end;

    if not v36 then
        for _, child in ipairs(p31:GetChildren()) do
            if child.Name == "RenderTemplate" then
                for _, descendant in ipairs(child:GetDescendants()) do
                    if descendant:GetAttribute("Transformed") then
                        local v37 = u1.computeMaxDuration(descendant, v33);

                        if v37 == nil then
                            return nil;
                        end;

                        if v35 < v37 then
                            v35 = v37;
                        end;
                    end;
                end;
            else
                local v38 = u1.computeMaxDuration(child, v33);

                if v38 == nil then
                    return nil;
                end;

                if v35 < v38 then
                    v35 = v38;
                end;
            end;
        end;
    end;

    return v35;
end;

return u1;