-- Decompiled with Potassium's decompiler.

local u26 = {
    build = function(p1, p2, p3, p4) -- Line: 40, Name: build
        local v5;

        if p4 then
            v5 = p4.Position or nil;
        else
            v5 = nil;
        end;

        local os_clock_ret = os.clock();
        local v6 = p1.StartTime and (math.max(0, os_clock_ret - p1.StartTime) or 0) or 0;
        local v7 = p1.LifeTime or 0;
        local v8 = v7 > 0 and (math.min(1, v6 / v7) or 0) or 0;
        local math_max_ret = math.max(0, v7 - v6);
        local v9 = {
            SourceItem = p1._sourceItem,
            Source = p1._sourceItem,
            Particle = p1.VisualPart,
            RenderTemplate = p1.VisualPart,
            WorldCFrame = p4,
            WorldPosition = v5,
            LifeProgress = v8,
            TimeRemaining = math_max_ret,
            StartTime = p1.StartTime,
            LifeTime = v7,
            SpeedMultiplier = p1.SpeedMultiplier or 1,
            ChainDepth = p1.EventChainCtx and (p1.EventChainCtx.Depth or 0) or 0
        };
        local v10;

        if p3 then
            v10 = p3.EmitCount;
        else
            v10 = p3;
        end;

        v9.EmitCount = v10;
        v9._eventName = p2;

        if p2 == "OnEmit" then
            v9.EmitPosition = v5;

            if p3 then
                p3 = p3.EmitIndex;
            end;

            v9.EmitIndex = p3;

            return v9;
        end;

        if p2 ~= "OnDeath" then
            if p2 == "OnDestruction" then
                v9.DeathPosition = v5;

                if p1._lingerStartTime then
                    v9.LingerElapsed = math.max(0, os_clock_ret - p1._lingerStartTime);

                    return v9;
                end;

                v9.LingerElapsed = 0;
            end;

            return v9;
        end;

        v9.DeathPosition = v5;

        if p1.StartTime then
            v9.Age = math.max(0, os_clock_ret - p1.StartTime);

            return v9;
        end;

        v9.Age = p1.LifeTime;

        return v9;
    end,

    applyColor = function(p11, u12) -- Line: 94, Name: applyColor
        if typeof(u12) ~= "Color3" then
            return;
        end;

        p11.SkipColor = true;
        local VisualPart = p11.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return;
        end;

        local Type = p11.Type;

        if Type == "Part" or Type == "Model" then
            if VisualPart:IsA("BasePart") then
                pcall(function() -- Line: 101
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.Color = u12;
                end);
            end;

            local u13 = VisualPart.FindFirstChildOfClass and VisualPart:FindFirstChildOfClass("SurfaceAppearance");

            if u13 then
                pcall(function() -- Line: 103
                    -- upvalues: u13 (copy), u12 (copy)
                    u13.Color = u12;
                end);
            end;
        else
            if Type == "Beam" or (Type == "TrailEmitter" or Type == "BeamNative") then
                pcall(function() -- Line: 105
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.Color = ColorSequence.new(u12);
                end);

                return;
            end;

            if Type == "PointLight" then
                pcall(function() -- Line: 107
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.Color = u12;
                end);

                return;
            end;

            if Type == "Highlight" then
                pcall(function() -- Line: 109
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.FillColor = u12;
                end);
                pcall(function() -- Line: 110
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.OutlineColor = u12;
                end);

                return;
            end;

            if Type == "ImageLabel" then
                pcall(function() -- Line: 112
                    -- upvalues: VisualPart (copy), u12 (copy)
                    VisualPart.ImageColor3 = u12;
                end);

                return;
            end;

            if Type == "Screen" then
                if p11.Kind == "ColorCorrection" then
                    pcall(function() -- Line: 115
                        -- upvalues: VisualPart (copy), u12 (copy)
                        VisualPart.TintColor = u12;
                    end);

                    return;
                end;

                if p11.Kind == "Atmosphere" then
                    pcall(function() -- Line: 117
                        -- upvalues: VisualPart (copy), u12 (copy)
                        VisualPart.Color = u12;
                    end);
                end;
            else
                local u14 = (Type == "Lightning" or (Type == "Rocks" or Type == "Rope")) and p11._rig;

                if u14 then
                    local u15 = u14.partCount or u14.chunkCap;
                    pcall(function() -- Line: 124
                        -- upvalues: u15 (copy), u14 (copy), u12 (copy)
                        for i = 1, u15 do
                            u14.parts[i].Color = u12;
                            local _ = i;
                        end;
                    end);
                end;
            end;
        end;
    end,

    applyTransparency = function(p16, p17) -- Line: 138, Name: applyTransparency
        if type(p17) ~= "number" then
            return;
        end;

        local math_min_ret = math.min(1, p17);
        local math_max_ret = math.max(0, math_min_ret);
        p16.SkipTransparency = true;
        local VisualPart = p16.VisualPart;

        if not (VisualPart and VisualPart.Parent) then
            return;
        end;

        local Type = p16.Type;

        if Type == "Part" or Type == "Model" then
            if VisualPart:IsA("BasePart") then
                pcall(function() -- Line: 146
                    -- upvalues: VisualPart (copy), math_max_ret (ref)
                    VisualPart.Transparency = math_max_ret;
                end);
            end;

            local u18 = VisualPart.FindFirstChildOfClass and VisualPart:FindFirstChildOfClass("Decal");

            if u18 then
                pcall(function() -- Line: 148
                    -- upvalues: u18 (copy), math_max_ret (ref)
                    u18.Transparency = math_max_ret;
                end);
            end;
        elseif Type == "Beam" or (Type == "TrailEmitter" or Type == "BeamNative") then
            pcall(function() -- Line: 150
                -- upvalues: VisualPart (copy), math_max_ret (ref)
                VisualPart.Transparency = NumberSequence.new(math_max_ret);
            end);
        elseif Type == "PointLight" then
            local u19 = p16._baseBrightness or VisualPart.Brightness;
            p16._baseBrightness = u19;
            pcall(function() -- Line: 154
                -- upvalues: VisualPart (copy), u19 (copy), math_max_ret (ref)
                VisualPart.Brightness = u19 * (1 - math_max_ret);
            end);
        elseif Type == "Highlight" then
            pcall(function() -- Line: 156
                -- upvalues: VisualPart (copy), math_max_ret (ref)
                VisualPart.FillTransparency = math_max_ret;
            end);
            pcall(function() -- Line: 157
                -- upvalues: VisualPart (copy), math_max_ret (ref)
                VisualPart.OutlineTransparency = math_max_ret;
            end);
        elseif Type == "ImageLabel" then
            pcall(function() -- Line: 159
                -- upvalues: VisualPart (copy), math_max_ret (ref)
                VisualPart.ImageTransparency = math_max_ret;
            end);
        elseif Type == "Lightning" or (Type == "Rocks" or Type == "Rope") then
            p16._curTrans = math_max_ret;
            local _rig = p16._rig;

            if _rig then
                local u20 = _rig.partCount or _rig.chunkCap;
                pcall(function() -- Line: 165
                    -- upvalues: u20 (copy), _rig (copy), math_max_ret (ref)
                    for i = 1, u20 do
                        _rig.parts[i].Transparency = math_max_ret;
                        local _ = i;
                    end;
                end);
            end;
        end;
    end,

    attachSkipSetters = function(p21, u22) -- Line: 179, Name: attachSkipSetters
        function p21.SetSkipColor(p23) -- Line: 180
            -- upvalues: u22 (copy)
            u22.SkipColor = p23 == true;
        end;

        function p21.SetSkipTransparency(p24) -- Line: 181
            -- upvalues: u22 (copy)
            u22.SkipTransparency = p24 == true;
        end;

        function p21.SetSkipSize(p25) -- Line: 182
            -- upvalues: u22 (copy)
            u22.SkipSize = p25 == true;
        end;
    end
};

local function _clearSettleState(p27) -- Line: 196
    p27._settleEngaged = false;
    p27._restTimer = 0;
    p27._settleRotDamp = 1;
    p27._settleContactPos = nil;
    p27._settleSpawnHalf = nil;
    p27._lastHitNormal = nil;
    p27._collisionStopped = false;
    p27._displacementMirrorX = nil;
    p27._displacementMirrorY = nil;
    p27._displacementMirrorZ = nil;
end;

function u26.applyTeleport(p28, u29) -- Line: 209
    if typeof(u29) ~= "CFrame" then
        return;
    end;

    p28._settleEngaged = false;
    p28._restTimer = 0;
    p28._settleRotDamp = 1;
    p28._settleContactPos = nil;
    p28._settleSpawnHalf = nil;
    p28._lastHitNormal = nil;
    p28._collisionStopped = false;
    p28._displacementMirrorX = nil;
    p28._displacementMirrorY = nil;
    p28._displacementMirrorZ = nil;
    local VisualPart = p28.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    local Type = p28.Type;

    if Type == "Part" then
        pcall(function() -- Line: 216
            -- upvalues: VisualPart (copy), u29 (copy)
            VisualPart.CFrame = u29;
        end);
    elseif Type == "Attachment" then
        local Parent = VisualPart.Parent;

        if Parent and Parent:IsA("BasePart") then
            pcall(function() -- Line: 221
                -- upvalues: VisualPart (copy), Parent (copy), u29 (copy)
                VisualPart.CFrame = Parent.CFrame:ToObjectSpace(u29);
            end);
        else
            pcall(function() -- Line: 223
                -- upvalues: VisualPart (copy), u29 (copy)
                VisualPart.CFrame = u29;
            end);
        end;
    else
        if Type ~= "Model" then
            return;
        end;

        pcall(function() -- Line: 226
            -- upvalues: VisualPart (copy), u29 (copy)
            VisualPart:PivotTo(u29);
        end);
    end;

    if Type == "Attachment" then
        local Parent = VisualPart.Parent;

        if Parent and Parent:IsA("BasePart") then
            p28.LocalCF = Parent.CFrame:ToObjectSpace(u29);
        else
            p28.LocalCF = u29;
        end;
    else
        local Link = p28.Link;

        if Link and Link.Parent then
            local v30;

            if Link:IsA("Attachment") then
                v30 = Link.WorldCFrame;
            elseif Link:IsA("Model") then
                v30 = Link:GetPivot();
            else
                v30 = Link.CFrame;
            end;

            p28.LocalCF = v30:ToObjectSpace(u29);
        else
            p28.LocalCF = u29;
        end;
    end;

    p28._localWorldCF = p28.LocalCF;

    if Type == "Attachment" then
        p28._postUpdateCF = VisualPart.CFrame;
    elseif Type == "Model" then
        p28._postUpdateCF = VisualPart:GetPivot();
    else
        p28._postUpdateCF = u29;
    end;

    p28.CurrentPosition = u29.Position;
    p28.LastHitCheckPos = u29.Position;
    p28._lastOrientPos = nil;
end;

function u26.applyAddSpin(p31, p32) -- Line: 273
    if typeof(p32) ~= "Vector3" then
        return;
    end;

    p31._spinRate = (p31._spinRate or Vector3.new(0, 0, 0)) + p32;
end;

function u26.applyAddImpulse(p33, p34) -- Line: 280
    if typeof(p34) ~= "Vector3" then
        return;
    end;

    p33._settleEngaged = false;
    p33._restTimer = 0;
    p33._settleRotDamp = 1;
    p33._settleContactPos = nil;
    p33._settleSpawnHalf = nil;
    p33._lastHitNormal = nil;
    p33._collisionStopped = false;
    p33._displacementMirrorX = nil;
    p33._displacementMirrorY = nil;
    p33._displacementMirrorZ = nil;
    p33._accelVel = (p33._accelVel or Vector3.new(0, 0, 0)) + p34;
end;

function u26.applyFreezeTime(p35, p36) -- Line: 289
    p35._timeFrozen = p36 == true;
    p35._freezeTimeExplicit = p36 == true;
end;

function u26.applyPause(u37, p38) -- Line: 298
    if type(p38) ~= "number" or p38 <= 0 then
        return;
    end;

    u37._timeFrozen = true;
    local u39 = (u37._pauseGen or 0) + 1;
    u37._pauseGen = u39;
    task.delay(p38, function() -- Line: 303
        -- upvalues: u37 (copy), u39 (copy)
        if u37._pauseGen == u39 and not u37._freezeTimeExplicit then
            u37._timeFrozen = false;
        end;
    end);
end;

function u26.applySetSize(p40, u41) -- Line: 313
    p40.SkipSize = true;
    local VisualPart = p40.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    local Type = p40.Type;

    if Type == "Part" or Type == "Model" then
        if typeof(u41) == "Vector3" and VisualPart:IsA("BasePart") then
            pcall(function() -- Line: 320
                -- upvalues: VisualPart (copy), u41 (copy)
                VisualPart.Size = u41;
            end);

            return;
        end;

        if typeof(u41) == "Vector3" and Type == "Model" then
            pcall(function() -- Line: 323
                -- upvalues: VisualPart (copy), u41 (copy)
                VisualPart:ScaleTo((math.max(0.001, u41.X)));
            end);
        end;
    elseif Type == "ImageLabel" and typeof(u41) == "UDim2" then
        pcall(function() -- Line: 326
            -- upvalues: VisualPart (copy), u41 (copy)
            VisualPart.Size = u41;
        end);
    end;
end;

function u26.applySetVelocity(p42, p43) -- Line: 333
    if p43 == nil then
        p42._speedOverride = nil;

        return;
    end;

    if typeof(p43) ~= "Vector3" then
        return;
    end;

    p42._settleEngaged = false;
    p42._restTimer = 0;
    p42._settleRotDamp = 1;
    p42._settleContactPos = nil;
    p42._settleSpawnHalf = nil;
    p42._lastHitNormal = nil;
    p42._collisionStopped = false;
    p42._displacementMirrorX = nil;
    p42._displacementMirrorY = nil;
    p42._displacementMirrorZ = nil;
    local Magnitude = p43.Magnitude;

    if Magnitude < 0.0001 then
        p42.SpeedMultiplier = 0;
        p42._speedOverride = 0;

        return;
    end;

    p42.BaseDirection = p43 / Magnitude;
    p42._speedOverride = Magnitude;
end;

function u26.applyResurrect(p44) -- Line: 353
    p44._killedManually = false;
    p44._forceDead = false;
end;

function u26.attachAdvancedSetters(p45, u46) -- Line: 360
    -- upvalues: u26 (copy)
    function p45.AddSpin(p47) -- Line: 361
        -- upvalues: u26 (ref), u46 (copy)
        u26.applyAddSpin(u46, p47);
    end;

    function p45.AddImpulse(p48) -- Line: 362
        -- upvalues: u26 (ref), u46 (copy)
        u26.applyAddImpulse(u46, p48);
    end;

    function p45.FreezeTime(p49) -- Line: 363
        -- upvalues: u26 (ref), u46 (copy)
        u26.applyFreezeTime(u46, p49);
    end;

    function p45.Pause(p50) -- Line: 364
        -- upvalues: u26 (ref), u46 (copy)
        u26.applyPause(u46, p50);
    end;

    function p45.SetSize(p51) -- Line: 365
        -- upvalues: u26 (ref), u46 (copy)
        u26.applySetSize(u46, p51);
    end;

    function p45.SetVelocity(p52) -- Line: 366
        -- upvalues: u26 (ref), u46 (copy)
        u26.applySetVelocity(u46, p52);
    end;

    function p45.Resurrect() -- Line: 367
        -- upvalues: u26 (ref), u46 (copy)
        u26.applyResurrect(u46);
    end;
end;

return u26;