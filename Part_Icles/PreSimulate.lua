-- Decompiled with Potassium's decompiler.

local Graph = require(script.Parent.Graph);
local PartConstants = require(script.Parent.PartConstants);
local Turbulence = require(script.Parent.Turbulence);
local DirectionVectors = PartConstants.DirectionVectors;

return function(p1) -- Line: 14
    -- upvalues: PartConstants (copy), Turbulence (copy), Graph (copy), DirectionVectors (copy)
    function p1.PreSimulateForward(p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) -- Line: 20
        -- upvalues: PartConstants (ref), Turbulence (ref), Graph (ref), DirectionVectors (ref)
        local v12 = p3.LinkMode or "Follow";
        local v13;

        if p8 then
            v13 = PartConstants.resolveLinkCFrame(p8);

            if v12 == "Follow" or v12 == "Pivot" then
                v13 = CFrame.new(v13.Position);
            end;
        else
            v13 = CFrame.new();
        end;

        local v14;

        if v12 == "Weld" or (v12 == "WeldWithoutRotation" or v12 == "RigidLocal") then
            v14 = p8 ~= nil;
        else
            v14 = false;
        end;

        local math_max_ret = math.max(1, p3.TotalKeyFrames);

        if not p10 or p10 >= math_max_ret then
            p10 = p3.InvertMotion and math_max_ret > 500 and 500 or math_max_ret;
        end;

        local v15 = p9 / p10;
        local Position = p5.Position;
        local v16 = v13:ToObjectSpace(p5);
        local EmissionDirection = p3.EmissionDirection;
        local v17 = p3.RotMode or "OverLife";
        local v18 = 0;
        local v19 = 0;
        local v20 = 0;
        local v21;

        if p3.AccelerationTowardsInstance == true and (p3.AccelTarget ~= nil and p3.AccelStrength ~= nil) then
            v21 = not p3.InvertMotion;
        else
            v21 = false;
        end;

        local v22 = nil;

        if v21 then
            local AccelTarget = p3.AccelTarget;

            if AccelTarget:IsA("Bone") then
                v22 = AccelTarget.TransformedWorldCFrame.Position;
            elseif AccelTarget:IsA("BasePart") then
                v22 = AccelTarget.Position;
            elseif AccelTarget:IsA("Attachment") then
                v22 = AccelTarget.WorldPosition;
            elseif AccelTarget:IsA("Model") then
                local success, result = pcall(AccelTarget.GetPivot, AccelTarget);

                if success and result then
                    v22 = result.Position;
                end;
            end;

            if not v22 then
                v21 = false;
            end;
        end;

        local v23 = Vector3.new(0, 0, 0);
        local v24 = p4.AccelStrength or {};
        local v25 = (p3.PosOffsetX ~= nil or p3.PosOffsetY ~= nil) and true or p3.PosOffsetZ ~= nil;
        local v26 = v14 and v13:ToObjectSpace(p5).Rotation or p5.Rotation;
        local v27 = Vector3.new(0, 0, 0);
        local v28 = Turbulence.isLive(p3.Turbulence);
        local v29;

        if v28 then
            p4.Turbulence = p4.Turbulence or Graph.GenerateSeed(v28);
            p4._turbSeed = p4._turbSeed or math.random() * 997 + 0.5;
            v29 = PartConstants.resolveDisplacement(Turbulence.sampleRaw(v28, p4.Turbulence, p4._turbSeed, p3.TurbulenceFrequency or 1, p9, 0), p3.DisplacementMode or "Global", v26, p11 or v26);
        else
            v29 = Vector3.new(0, 0, 0);
        end;

        local v30 = { v13:ToObjectSpace(p5) };

        for i = 1, p10 do
            local v31 = i / p10;
            local v32 = v31 * p9;
            local v33 = (p6 * (Graph.QueryPointsWithTime(v31, p3.Speed, p4.Speed) * math.exp(-p3.ParticleData.Drag * v32)) + p3.ParticleData.Acceleration * v32) * v15;

            if v21 then
                local v34 = v22 - Position;
                local Magnitude = v34.Magnitude;

                if Magnitude > 0.0001 then
                    local v35 = Graph.QueryPointsWithTime(v31, p3.AccelStrength, v24);

                    if v35 and v35 ~= 0 then
                        v23 = v23 + v34 * (v35 * v15 / Magnitude);
                        v33 = v33 + v23 * v15;
                    end;
                end;
            end;

            local v36, v37;

            if v25 then
                local v38 = p3.PosOffsetX and (Graph.QueryPointsWithTime(v31, p3.PosOffsetX, p4.PosOffsetX) or 0) or 0;
                local v39 = p3.PosOffsetY and (Graph.QueryPointsWithTime(v31, p3.PosOffsetY, p4.PosOffsetY) or 0) or 0;
                local v40 = p3.PosOffsetZ and (Graph.QueryPointsWithTime(v31, p3.PosOffsetZ, p4.PosOffsetZ) or 0) or 0;
                v36 = PartConstants.resolveDisplacement(Vector3.new(v38, v39, v40), p3.DisplacementMode or "Global", v26, p11 or v26);
                v37 = v36 - v27;
            else
                v36 = v27;
                v37 = Vector3.new(0, 0, 0);
            end;

            local v41;

            if v28 then
                v41 = PartConstants.resolveDisplacement(Turbulence.sampleRaw(v28, p4.Turbulence, p4._turbSeed, p3.TurbulenceFrequency or 1, p9, v31), p3.DisplacementMode or "Global", v26, p11 or v26);
                v37 = v37 + (v41 - v29);
            else
                v41 = v29;
            end;

            local v42;

            if v14 then
                v42 = (p3.DisplacementMode or "Global") == "Local";
            else
                v42 = v14;
            end;

            if v14 then
                v33 = v13:VectorToObjectSpace(v33) or v33;
            end;

            if v14 and not v42 then
                v37 = v13:VectorToObjectSpace(v37) or v37;
            end;

            v16 = CFrame.new(v33 + v37) * v16;
            local v43 = Graph.QueryPointsWithTime(v31, p3.RotSpeedX, p4.RotSpeedX);
            local v44 = Graph.QueryPointsWithTime(v31, p3.RotSpeedY, p4.RotSpeedY);
            local v45 = Graph.QueryPointsWithTime(v31, p3.RotSpeedZ, p4.RotSpeedZ);
            local v46 = p3.RotOrder or "Global";
            local v47;

            if v17 == "Speed" then
                v18 = v18 + v43 * v15;
                v19 = v19 + v44 * v15;
                v20 = v20 + v45 * v15;
                v47 = PartConstants.composeRotation(v46, v18, v19, v20);
            else
                v47 = PartConstants.composeRotation(v46, v43, v44, v45);
            end;

            local v48 = v13 * v16 * v47;
            Position = v48.Position;

            if p3.VelocityVectored then
                local v49 = DirectionVectors[EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                p6 = (v48 * p7)[v49.vector] * v49.multiplier;
            end;

            v30[i] = v13:ToObjectSpace(v48);
            v27 = v36;
            v29 = v41;
            local _ = i;
        end;

        return v30, p10;
    end;

    function p1.PreSimulateAttachmentForward(p50, p51, p52, p53, p54, p55, p56, p57, p58) -- Line: 171
        -- upvalues: Turbulence (ref), Graph (ref), PartConstants (ref), DirectionVectors (ref)
        local math_max_ret = math.max(1, p51.TotalKeyFrames);

        if not p57 or p57 >= math_max_ret then
            p57 = p51.InvertMotion and math_max_ret > 500 and 500 or math_max_ret;
        end;

        local v59 = p56 / p57;
        local EmissionDirection = p51.EmissionDirection;
        local v60 = p51.RotMode or "OverLife";
        local v61 = 0;
        local v62 = 0;
        local v63 = 0;
        local v64 = (p51.PosOffsetX ~= nil or p51.PosOffsetY ~= nil) and true or p51.PosOffsetZ ~= nil;
        local Rotation = p53.Rotation;
        local v65 = Vector3.new(0, 0, 0);
        local v66 = Turbulence.isLive(p51.Turbulence);
        local v67;

        if v66 then
            p52.Turbulence = p52.Turbulence or Graph.GenerateSeed(v66);
            p52._turbSeed = p52._turbSeed or math.random() * 997 + 0.5;
            v67 = PartConstants.resolveDisplacement(Turbulence.sampleRaw(v66, p52.Turbulence, p52._turbSeed, p51.TurbulenceFrequency or 1, p56, 0), p51.DisplacementMode or "Global", Rotation, p58 or Rotation);
        else
            v67 = Vector3.new(0, 0, 0);
        end;

        local v68 = { p53 };

        for i = 1, p57 do
            local v69 = i / p57;
            local v70 = v69 * p56;
            local v71 = (p54 * (Graph.QueryPointsWithTime(v69, p51.Speed, p52.Speed) * math.exp(-p51.ParticleData.Drag * v70)) + p51.ParticleData.Acceleration * v70) * v59;
            local v72;

            if v64 then
                local v73 = p51.PosOffsetX and (Graph.QueryPointsWithTime(v69, p51.PosOffsetX, p52.PosOffsetX) or 0) or 0;
                local v74 = p51.PosOffsetY and (Graph.QueryPointsWithTime(v69, p51.PosOffsetY, p52.PosOffsetY) or 0) or 0;
                local v75 = p51.PosOffsetZ and (Graph.QueryPointsWithTime(v69, p51.PosOffsetZ, p52.PosOffsetZ) or 0) or 0;
                v72 = PartConstants.resolveDisplacement(Vector3.new(v73, v74, v75), p51.DisplacementMode or "Global", Rotation, p58 or Rotation);
                v71 = v71 + (v72 - v65);
            else
                v72 = v65;
            end;

            local v76;

            if v66 then
                v76 = PartConstants.resolveDisplacement(Turbulence.sampleRaw(v66, p52.Turbulence, p52._turbSeed, p51.TurbulenceFrequency or 1, p56, v69), p51.DisplacementMode or "Global", Rotation, p58 or Rotation);
                v71 = v71 + (v76 - v67);
            else
                v76 = v67;
            end;

            p53 = CFrame.new(v71) * p53;
            local v77 = Graph.QueryPointsWithTime(v69, p51.RotSpeedX, p52.RotSpeedX);
            local v78 = Graph.QueryPointsWithTime(v69, p51.RotSpeedY, p52.RotSpeedY);
            local v79 = Graph.QueryPointsWithTime(v69, p51.RotSpeedZ, p52.RotSpeedZ);
            local v80 = p51.RotOrder or "Global";
            local v81;

            if v60 == "Speed" then
                v61 = v61 + v77 * v59;
                v62 = v62 + v78 * v59;
                v63 = v63 + v79 * v59;
                v81 = PartConstants.composeRotation(v80, v61, v62, v63);
            else
                v81 = PartConstants.composeRotation(v80, v77, v78, v79);
            end;

            local v82 = p53 * v81;

            if p51.VelocityVectored then
                local v83 = DirectionVectors[EmissionDirection] or DirectionVectors[Enum.NormalId.Top];
                p54 = (v82 * p55)[v83.vector] * v83.multiplier;
            end;

            v68[i] = v82;
            v65 = v72;
            v67 = v76;
            local _ = i;
        end;

        return v68, p57;
    end;
end;