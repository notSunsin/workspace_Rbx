-- Decompiled with Potassium's decompiler.

local u44 = {
    resolveLinkCFrame = function(p1) -- Line: 11, Name: resolveLinkCFrame
        if p1:IsA("Attachment") then
            return p1.WorldCFrame;
        end;

        if p1:IsA("Model") then
            return p1:GetPivot();
        end;

        if p1:IsA("Bone") then
            return p1.TransformedWorldCFrame;
        end;

        return p1.CFrame;
    end,

    getParentScaleFactor = function(p2, p3, p4, p5) -- Line: 24, Name: getParentScaleFactor
        local v6 = 1;

        while p2 do
            local v7 = true;

            if p5 == "motion" then
                v7 = p2.ScaleMotion ~= false;
            elseif p5 == "rotation" then
                v7 = p2.ScaleRotation == true;
            end;

            if v7 then
                local v8;

                if p2.StaticValue then
                    v8 = math.max(0.001, p2.StaticValue);
                else
                    local math_clamp_ret = math.clamp((p3 - p2.StartTime) / p2.LifeTime, 0, 1);
                    v8 = math.max(0.001, p4.QueryPointsWithTime(math_clamp_ret, p2.Graph, p2.Seed));
                end;

                v6 = v6 * v8;
            end;

            p2 = p2.Parent;
        end;

        return v6;
    end,

    composeRotation = function(p9, p10, p11, p12) -- Line: 51, Name: composeRotation
        local CFrame_Angles_ret = CFrame.Angles(math.rad(p10), 0, 0);
        local CFrame_Angles_ret2 = CFrame.Angles(0, math.rad(p11), 0);
        local CFrame_Angles_ret3 = CFrame.Angles(0, 0, (math.rad(p12)));

        if p9 == "LocalXYZ" then
            return CFrame_Angles_ret * CFrame_Angles_ret2 * CFrame_Angles_ret3;
        end;

        if p9 == "LocalXZY" then
            return CFrame_Angles_ret * CFrame_Angles_ret3 * CFrame_Angles_ret2;
        end;

        if p9 == "LocalYXZ" then
            return CFrame_Angles_ret2 * CFrame_Angles_ret * CFrame_Angles_ret3;
        end;

        if p9 == "LocalYZX" then
            return CFrame_Angles_ret2 * CFrame_Angles_ret3 * CFrame_Angles_ret;
        end;

        if p9 == "LocalZXY" then
            return CFrame_Angles_ret3 * CFrame_Angles_ret * CFrame_Angles_ret2;
        end;

        if p9 == "LocalZYX" then
            return CFrame_Angles_ret3 * CFrame_Angles_ret2 * CFrame_Angles_ret;
        end;

        return CFrame_Angles_ret2 * CFrame_Angles_ret * CFrame_Angles_ret3;
    end,

    DirectionVectors = {
        [Enum.NormalId.Top] = {
            vector = "UpVector",
            multiplier = 1
        },
        [Enum.NormalId.Bottom] = {
            vector = "UpVector",
            multiplier = -1
        },
        [Enum.NormalId.Front] = {
            vector = "LookVector",
            multiplier = 1
        },
        [Enum.NormalId.Back] = {
            vector = "LookVector",
            multiplier = -1
        },
        [Enum.NormalId.Left] = {
            vector = "RightVector",
            multiplier = -1
        },
        [Enum.NormalId.Right] = {
            vector = "RightVector",
            multiplier = 1
        }
    },
    shapeFunctions = {
        [Enum.ParticleEmitterShape.Box] = function(p13, p14) -- Line: 76
            local v15 = (math.random() * 2 - 1) * p13.Size.X / 2;
            local v16 = (math.random() * 2 - 1) * p13.Size.Y / 2;
            local v17 = (math.random() * 2 - 1) * p13.Size.Z / 2;
            local Vector3_new_ret = Vector3.new(v15, v16, v17);
            local v18 = Vector3_new_ret.Magnitude > 0.0001 and (Vector3_new_ret.Unit or Vector3.new(0, 1, 0)) or Vector3.new(0, 1, 0);

            return Vector3_new_ret, Vector3_new_ret.Magnitude > 0.0001 and CFrame.lookAt(Vector3.new(), -v18) or CFrame.new(), v18;
        end,

        [Enum.ParticleEmitterShape.Sphere] = function(p19, p20) -- Line: 86
            local v21 = p19.Size.X / 2;
            local v22 = v21 * p20.ShapePartial;
            local v23 = (math.random() * (v21 ^ 3 - v22 ^ 3) + v22 ^ 3) ^ 0.3333333333333333;
            local v24 = math.random() * 2 * 3.141592653589793;
            local v25 = math.random() * 2 - 1;
            local math_acos_ret = math.acos(v25);
            local v26 = math.sin(math_acos_ret) * math.cos(v24);
            local v27 = math.sin(math_acos_ret) * math.sin(v24);
            local math_cos_ret = math.cos(math_acos_ret);
            local Vector3_new_ret = Vector3.new(v26, v27, math_cos_ret);

            return Vector3_new_ret * v23, CFrame.lookAt(Vector3.new(), -Vector3_new_ret), Vector3_new_ret;
        end,

        [Enum.ParticleEmitterShape.Cylinder] = function(p28, p29) -- Line: 99
            local v30 = p28.Size.X / 2;
            local Y = p28.Size.Y;
            local math_clamp_ret = math.clamp(p29.ShapePartial, 0, 1);
            local v31 = math.random() * (1 - math_clamp_ret * math_clamp_ret) + math_clamp_ret * math_clamp_ret;
            local math_sqrt_ret = math.sqrt(v31);
            local v32 = math.random() * 2 * 3.141592653589793;
            local v33 = math_sqrt_ret * v30 * math.cos(v32);
            local v34 = (math.random() * 2 - 1) * (Y / 2);
            local v35 = math_sqrt_ret * v30 * math.sin(v32);
            local Vector3_new_ret = Vector3.new(v33, v34, v35);
            local v36;

            if math.abs(v34) > Y / 2 - 0.01 then
                local math_sign_ret = math.sign(v34);
                v36 = Vector3.new(0, math_sign_ret, 0);
            else
                local Vector3_new_ret2 = Vector3.new(v33, 0, v35);
                v36 = Vector3_new_ret2.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret2.Unit;
            end;

            return Vector3_new_ret, CFrame.lookAt(Vector3.new(), -v36), v36;
        end,

        [Enum.ParticleEmitterShape.Disc] = function(p37, p38) -- Line: 123
            local v39 = p37.Size.X / 2;
            local math_clamp_ret = math.clamp(p38.ShapePartial, 0, 1);
            local v40 = math.random() * (1 - math_clamp_ret * math_clamp_ret) + math_clamp_ret * math_clamp_ret;
            local math_sqrt_ret = math.sqrt(v40);
            local v41 = math.random() * 2 * 3.141592653589793;
            local v42 = math_sqrt_ret * v39 * math.cos(v41);
            local v43 = math_sqrt_ret * v39 * math.sin(v41);
            local Vector3_new_ret = Vector3.new(v42, 0, v43);

            if Vector3_new_ret.Magnitude < 0.0001 then
                return Vector3_new_ret, CFrame.new(), Vector3.new(0, 1, 0);
            end;

            local Unit = Vector3_new_ret.Unit;

            return Vector3_new_ret, CFrame.lookAt(Vector3.new(), -Unit), Unit;
        end
    }
};

function u44.applyPositionOffset(p45, p46, p47, p48, p49, p50, p51, p52, p53) -- Line: 144
    -- upvalues: u44 (copy)
    local v54, v55, v56;

    if p50 and p46.AxisLinks then
        local v57 = p50.sampleRangeAxes(p46, p46.AxisLinks, { "PosX", "PosY", "PosZ" }, p49, p51);
        v54 = v57.PosX;
        v55 = v57.PosY;
        v56 = v57.PosZ;
    else
        v54 = p49.RandomValueFromRange(p46.PosX or NumberRange.new(0));
        v55 = p49.RandomValueFromRange(p46.PosY or NumberRange.new(0));
        v56 = p49.RandomValueFromRange(p46.PosZ or NumberRange.new(0));
    end;

    if p53 and p53 ~= 1 then
        v54 = v54 * p53;
        v55 = v55 * p53;
        v56 = v56 * p53;
    end;

    if v54 == 0 and (v55 == 0 and v56 == 0) then
        return p45;
    end;

    local v58 = p46.PosMode or "Local";

    if v58 == "Local" then
        return p45 * CFrame.new(v54, v55, v56);
    end;

    local Vector3_new_ret = Vector3.new(v54, v55, v56);

    if v58 ~= "Global" then
        local v59;

        if p47 then
            v59 = u44.resolveLinkCFrame(p47);
        elseif p48:IsA("Attachment") then
            v59 = p48.WorldCFrame;
        elseif p48:IsA("Model") then
            v59 = p48:GetPivot();
        else
            v59 = p48.CFrame;
        end;

        Vector3_new_ret = v59:VectorToWorldSpace(Vector3_new_ret);
    end;

    if p52 then
        Vector3_new_ret = p52:VectorToObjectSpace(Vector3_new_ret) or Vector3_new_ret;
    end;

    return CFrame.new(p45.Position + Vector3_new_ret) * p45.Rotation;
end;

function u44.resolveDisplacement(p60, p61, p62, p63, p64, p65, p66) -- Line: 203
    if p61 ~= "Global" then
        if p61 == "RigidLocal" then
            p60 = p63:VectorToWorldSpace(p60);
        else
            p60 = p62:VectorToWorldSpace(p60);
        end;
    end;

    if p64 then
        return p64 * p60.X + p65 * p60.Y + p66 * p60.Z;
    end;

    return p60;
end;

function u44.applyContactAccel(p67, p68, p69) -- Line: 225
    if not (p68._settleEngaged and p68._lastHitNormal) then
        return p67;
    end;

    local _lastHitNormal = p68._lastHitNormal;

    if _lastHitNormal.Magnitude < 0.0001 then
        return p67;
    end;

    local v70 = p67:Dot(_lastHitNormal);

    if v70 >= 0 then
        return p67;
    end;

    if math.abs(v70) < 10 then
        return p67;
    end;

    local v71 = p67 - v70 * _lastHitNormal;
    local v72 = p68.Events and p68.Events.OnHit and (p68.Events.OnHit.Friction or 0.2) or 0.2;
    local v73;

    if p68._accelVel then
        local _accelVel = p68._accelVel;
        v73 = _accelVel - _accelVel:Dot(_lastHitNormal) * _lastHitNormal;
    else
        v73 = Vector3.new(0, 0, 0);
    end;

    local Magnitude = v73.Magnitude;
    local v74 = v72 * math.abs(v70);

    if Magnitude <= 0.0001 then
        return v71.Magnitude <= v74 and Vector3.new(0, 0, 0) or v71 - v71.Unit * v74;
    end;

    local v75 = -v73.Unit * v74;

    if Magnitude < v74 * (p69 or 0.016666666666666666) then
        v75 = -v73 / (p69 or 0.016666666666666666);
    end;

    return v71 + v75;
end;

return u44;