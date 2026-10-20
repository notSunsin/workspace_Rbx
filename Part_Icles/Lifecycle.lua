-- Decompiled with Potassium's decompiler.

local Selection = game:GetService("Selection");
local RunService = game:GetService("RunService");
local u1 = RunService:IsStudio();
local success = pcall(function() -- Line: 11
    -- upvalues: Selection (copy)
    return Selection:Get();
end);
local u2 = RunService:IsClient() and RunService.PreRender or RunService.Heartbeat;
local TypeRegistry = require(script.Parent.TypeRegistry);
local Particles = require(script.Parent.Particles);
local Events = require(script.Parent.Events);
local Pool = require(script.Parent.Pool);
local EvenCycle = require(script.Parent.EvenCycle);

return function(u3) -- Line: 22
    -- upvalues: TypeRegistry (copy), EvenCycle (copy), Particles (copy), success (copy), Events (copy), u2 (copy), u1 (copy), Selection (copy), Pool (copy)
    local function cancelAnimation(p4, p5) -- Line: 25
        local u6 = p4.ActiveAnimates[p5];

        if not u6 then
            return;
        end;

        if (u6.Type == "Beam" or (u6.Type == "Highlight" or u6.Type == "TrailEmitter")) and (u6.VisualPart and u6.VisualPart.Parent) then
            local u7 = u6.BeamSnapshot or (u6.HighlightSnapshot or u6.TrailEmitterSnapshot);

            if u7 then
                pcall(function() -- Line: 35
                    -- upvalues: u7 (copy), u6 (copy)
                    for i, v in pairs(u7) do
                        u6.VisualPart[i] = v;
                    end;
                end);
            end;

            u6.VisualPart.Enabled = false;
        end;

        if u6.InitialAnchorCF and (u6.VisualPart and u6.VisualPart.Parent) then
            if u6.Type == "Model" then
                u6.VisualPart:PivotTo(u6.InitialAnchorCF);

                if u6.InitialScale then
                    pcall(function() -- Line: 45
                        -- upvalues: u6 (copy)
                        u6.VisualPart:ScaleTo(u6.InitialScale);
                    end);
                end;
            elseif u6.Type ~= "Beam" then
                u6.VisualPart.CFrame = u6.InitialAnchorCF;
            end;
        end;

        if (u6.Type == "Part" or u6.Type == "Attachment") and (u6.VisualPart and u6.VisualPart.Parent) then
            pcall(function() -- Line: 53
                -- upvalues: u6 (copy)
                u6.VisualPart.Transparency = 1;
                local v8 = u6.HasDecal and u6.VisualPart:FindFirstChildOfClass("Decal");

                if v8 then
                    v8.Transparency = 1;
                end;
            end);
        end;

        if (u6.Type == "Screen" or (u6.Type == "ImageLabel" or (u6.Type == "Lightning" or (u6.Type == "Rocks" or u6.Type == "Rope")))) and u6.VisualPart then
            pcall(function() -- Line: 63
                -- upvalues: u6 (copy)
                u6.VisualPart:Destroy();
            end);
        end;

        if u6._scaleMapKeys and p4._parentScaleMap then
            for _, v in ipairs(u6._scaleMapKeys) do
                p4._parentScaleMap[v] = nil;
            end;
        end;

        for i = #p4.ActiveEmits, 1, -1 do
            if p4.ActiveEmits[i] == u6 then
                local v9 = #p4.ActiveEmits;

                if i < v9 then
                    p4.ActiveEmits[i] = p4.ActiveEmits[v9];
                end;

                p4.ActiveEmits[v9] = nil;
                break;
            end;

            local _ = i;
        end;

        p4.ActiveAnimates[p5] = nil;
    end;

    function u3._cancelAnimation(p10, p11) -- Line: 83
        -- upvalues: cancelAnimation (copy)
        cancelAnimation(p10, p11);
    end;

    local function haltEmission(p12, u13, p14) -- Line: 90
        -- upvalues: u3 (copy), cancelAnimation (copy), TypeRegistry (ref), EvenCycle (ref), Particles (ref)
        if u3.ActiveLoops[u13] then
            task.cancel(u3.ActiveLoops[u13]);
            u3.ActiveLoops[u13] = nil;
        end;

        local v15 = u3.ActiveChainLoops[u13];

        if v15 then
            for _, v in ipairs(v15) do
                pcall(task.cancel, v);
            end;

            u3.ActiveChainLoops[u13] = nil;
        end;

        u13:SetAttribute("AnimateLoop", false);
        local u16 = (u13:GetAttribute("_emitGen") or 0) + 1;
        pcall(function() -- Line: 102
            -- upvalues: u13 (copy), u16 (copy)
            u13:SetAttribute("_emitGen", u16);
        end);

        if p14 then
            cancelAnimation(p12, u13);
        end;

        local Config = TypeRegistry.getConfig(u13);

        if Config then
            Config:SetAttribute("Enabled", false);
        end;

        pcall(function() -- Line: 106
            -- upvalues: u13 (copy)
            u13:SetAttribute("_PartIclePlaying", nil);
        end);
        EvenCycle.clear(p12._evenCycleStore, u13:GetAttribute("_EvenCycleId") or u13);

        for _, descendant in ipairs(u13:GetDescendants()) do
            if descendant:GetAttribute("Transformed") then
                if p14 then
                    p12:Disable(descendant);
                else
                    p12:SoftDisable(descendant);
                end;
            elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                if p14 then
                    Particles.CancelNative(descendant);
                else
                    pcall(function() -- Line: 114
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            elseif descendant:IsA("Beam") or descendant:IsA("Highlight") then
                pcall(function() -- Line: 116
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end;

    function u3.Disable(p17, p18) -- Line: 124
        -- upvalues: success (ref), haltEmission (copy)
        if not p18 then
            return;
        end;

        local v19 = success and (game:GetService("RunService"):IsEdit() and game:GetService("ChangeHistoryService")) or nil;

        if v19 then
            v19:SetWaypoint("Part-Icles: Before Disable");
        end;

        haltEmission(p17, p18, true);
        local ActiveEmits = p17.ActiveEmits;

        for i = #ActiveEmits, 1, -1 do
            local v20 = ActiveEmits[i];
            local v21;

            if v20 and v20._sourceItem == p18 then
                if v20.VisualPart and v20.VisualPart.Parent then
                    p17:_releaseOrDestroy(v20, v20.VisualPart);
                end;

                if v20._scaleMapKeys and p17._parentScaleMap then
                    v21 = i;

                    for _, v in ipairs(v20._scaleMapKeys) do
                        p17._parentScaleMap[v] = nil;
                    end;
                else
                    v21 = i;
                end;

                local v22 = #ActiveEmits;

                if v21 < v22 then
                    ActiveEmits[v21] = ActiveEmits[v22];
                end;

                ActiveEmits[v22] = nil;
            else
                v21 = i;
            end;
        end;

        if p17._lingerByItem and p17._lingerByItem[p18] then
            for _, v in ipairs(p17._lingerByItem[p18]) do
                if v then
                    local u23 = false;
                    pcall(function() -- Line: 153
                        -- upvalues: u23 (ref), v (copy)
                        u23 = v:GetAttribute("_lingerCounted") == true;
                    end);

                    if u23 then
                        p17._lingerVisualCount = math.max(0, (p17._lingerVisualCount or 0) - 1);
                        pcall(function() -- Line: 156
                            -- upvalues: v (copy)
                            v:SetAttribute("_lingerCounted", nil);
                        end);
                    end;

                    if v.Parent then
                        pcall(function() -- Line: 159
                            -- upvalues: v (copy)
                            v:Destroy();
                        end);
                    end;
                end;
            end;

            p17._lingerByItem[p18] = nil;
        end;

        if v19 then
            v19:SetWaypoint("Part-Icles: Disable");
        end;
    end;

    local function _hasTransformedAncestor(p24, p25) -- Line: 169
        local Parent = p24.Parent;

        while Parent and Parent ~= p25 do
            if Parent:GetAttribute("Transformed") then
                return true;
            end;

            Parent = Parent.Parent;
        end;

        return false;
    end;

    function u3.AbsoluteEnable(p26, u27, p28) -- Line: 184
        -- upvalues: TypeRegistry (ref), _hasTransformedAncestor (copy)
        if not u27 then
            return;
        end;

        if u27:GetAttribute("Transformed") then
            pcall(function() -- Line: 193
                -- upvalues: u27 (copy)
                u27:SetAttribute("_PartIclePlaying", true);
            end);
            local Config = TypeRegistry.getConfig(u27);

            if Config then
                Config:SetAttribute("Enabled", true);
            end;

            p26:Enable(u27, nil, (1 / 0));

            return;
        end;

        if u27:IsA("ParticleEmitter") or (u27:IsA("Trail") or u27:IsA("Beam")) then
            if p28 then
                return;
            end;

            pcall(function() -- Line: 202
                -- upvalues: u27 (copy)
                u27.Enabled = true;
            end);

            return;
        end;

        local v29;

        if u27:IsA("BasePart") or u27:IsA("Attachment") then
            v29 = not p28;
        else
            v29 = u27:IsA("Model") and not p28;
        end;

        if v29 then
            for _, descendant in ipairs(u27:GetDescendants()) do
                if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam"))) and not (descendant:GetAttribute("Transformed") or _hasTransformedAncestor(descendant, u27)) then
                    pcall(function() -- Line: 211
                        -- upvalues: descendant (copy)
                        descendant.Enabled = true;
                    end);
                end;
            end;
        end;

        local v30 = v29 or p28;

        for _, child in u27:GetChildren() do
            if not (u27:IsA("BasePart") and (child:IsA("BasePart") and not child:GetAttribute("Transformed"))) then
                p26:AbsoluteEnable(child, v30);
            end;
        end;
    end;

    function u3.SoftDisable(p31, p32) -- Line: 227
        -- upvalues: success (ref), haltEmission (copy)
        if not p32 then
            return;
        end;

        local v33 = success and (game:GetService("RunService"):IsEdit() and game:GetService("ChangeHistoryService")) or nil;

        if v33 then
            v33:SetWaypoint("Part-Icles: Before Soft Disable");
        end;

        haltEmission(p31, p32, false);

        if v33 then
            v33:SetWaypoint("Part-Icles: Soft Disable");
        end;
    end;

    function u3.AbsoluteDisable(p34, u35, p36) -- Line: 240
        -- upvalues: _hasTransformedAncestor (copy)
        if not u35 then
            return;
        end;

        if u35:GetAttribute("Transformed") then
            p34:SoftDisable(u35);

            return;
        end;

        if u35:IsA("ParticleEmitter") or (u35:IsA("Trail") or u35:IsA("Beam")) then
            if p36 then
                return;
            end;

            pcall(function() -- Line: 248
                -- upvalues: u35 (copy)
                u35.Enabled = false;
            end);

            return;
        end;

        local v37;

        if u35:IsA("BasePart") or u35:IsA("Attachment") then
            v37 = not p36;
        else
            v37 = u35:IsA("Model") and not p36;
        end;

        if v37 then
            for _, descendant in ipairs(u35:GetDescendants()) do
                if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam"))) and not (descendant:GetAttribute("Transformed") or _hasTransformedAncestor(descendant, u35)) then
                    pcall(function() -- Line: 257
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;

        local v38 = v37 or p36;

        for _, child in u35:GetChildren() do
            if not (u35:IsA("BasePart") and (child:IsA("BasePart") and not child:GetAttribute("Transformed"))) then
                p34:AbsoluteDisable(child, v38);
            end;
        end;
    end;

    function u3.EmitAnimate(p39, p40, p41, p42) -- Line: 271
        -- upvalues: u3 (copy), cancelAnimation (copy)
        p39:_warnIfNotActivated("EmitAnimate");

        if (p40:IsA("BlurEffect") or (p40:IsA("BloomEffect") or p40:IsA("ColorCorrectionEffect") or (p40:IsA("Atmosphere") or p40:IsA("ImageLabel")) or (u3._isLightning(p40) or u3._isCameraShake(p40) or (u3._isRocks(p40) or u3._isRope(p40))))) and p39.ActiveAnimates[p40] then
            return;
        end;

        cancelAnimation(p39, p40);

        if p40:IsA("Beam") then
            p39:EmitBeamAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("Trail") and p40:FindFirstChild("PartIcleProperties") then
            p39:EmitTrailAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("Highlight") then
            p39:EmitHighlightAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("Attachment") then
            p39:EmitAttachmentAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("Model") then
            p39:EmitModelAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("BlurEffect") then
            p39:EmitBlurAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("BloomEffect") then
            p39:EmitBloomAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("ColorCorrectionEffect") then
            p39:EmitColorCorrectionAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("Atmosphere") then
            p39:EmitAtmosphereAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("ImageLabel") then
            p39:EmitImageLabelAnimate(p40, p41, p42);

            return;
        end;

        if u3._isLightning(p40) then
            p39:EmitLightningAnimate(p40, p41, p42);

            return;
        end;

        if u3._isCameraShake(p40) then
            p39:EmitCameraShakeAnimate(p40, p41, p42);

            return;
        end;

        if u3._isRocks(p40) then
            p39:EmitRocksAnimate(p40, p41, p42);

            return;
        end;

        if u3._isRope(p40) then
            p39:EmitRopeAnimate(p40, p41, p42);

            return;
        end;

        if p40:IsA("BasePart") then
            p39:EmitPartAnimate(p40, p41, p42);
        end;
    end;

    function u3.EnableEmit(u43, u44, u45, u46) -- Line: 302
        -- upvalues: Particles (ref), EvenCycle (ref), TypeRegistry (ref), Events (ref)
        u43:_warnIfNotActivated("EnableEmit");
        local v47 = u44:GetAttribute("EmissionMode") or "Emit";
        local Attribute = u44:GetAttribute("EmitCount");
        local v48 = Attribute == nil and 1 or Attribute;
        local u49 = v48 <= 0 and (u46 and u46.EventDriven) and 1 or v48;
        local v50 = u44:GetAttribute("EmitDelay") or 0;
        local u51 = Particles.parseDuration(u44:GetAttribute("EmitDuration")) or 0;

        if v47 ~= "Animate" and (u49 <= 0 and u51 <= 0) then
            return;
        end;

        local u52;

        if u46 then
            u52 = u46.ChainCtx ~= nil;
        else
            u52 = u46;
        end;

        local u53;

        if u46 then
            u53 = u46._parentAlive ~= nil;
        else
            u53 = u46;
        end;

        local u54 = u52 or (u53 or u51 <= 0);

        if not (u52 or u53) then
            EvenCycle.ensureIds(u44);
        end;

        local u55;

        if u54 then
            u55 = nil;
        else
            u55 = (u44:GetAttribute("_emitGen") or 0) + 1;
            pcall(function() -- Line: 330
                -- upvalues: u44 (copy), u55 (ref)
                u44:SetAttribute("_emitGen", u55);
            end);
        end;

        local u56 = u43._engineGen or 0;

        local function genStillCurrent() -- Line: 334
            -- upvalues: u43 (copy), u56 (copy), u44 (copy), u54 (copy), u55 (ref), u46 (copy)
            if u43.Connection == nil then
                return false;
            end;

            if (u43._engineGen or 0) ~= u56 then
                return false;
            end;

            if not u44.Parent then
                return false;
            end;

            if u54 or (u44:GetAttribute("_emitGen") or 0) == u55 then
                return not (u46 and (u46._parentAlive and not u46._parentAlive[1]));
            end;

            return false;
        end;

        if v47 == "Animate" then
            local function doAnimate() -- Line: 347
                -- upvalues: u43 (copy), u56 (copy), u44 (copy), u54 (copy), u55 (ref), u46 (copy), u51 (copy), u45 (copy)
                local v57;

                if u43.Connection == nil or ((u43._engineGen or 0) ~= u56 or not (u44.Parent and (u54 or (u44:GetAttribute("_emitGen") or 0) == u55))) then
                    v57 = false;
                else
                    v57 = not (u46 and (u46._parentAlive and not u46._parentAlive[1]));
                end;

                if not v57 then
                    return;
                end;

                if u51 > 0 then
                    u44:SetAttribute("AnimateLoop", true);
                    task.delay(u51, function() -- Line: 351
                        -- upvalues: u43 (ref), u56 (ref), u44 (ref), u54 (ref), u55 (ref), u46 (ref)
                        local v58;

                        if u43.Connection == nil or ((u43._engineGen or 0) ~= u56 or not (u44.Parent and (u54 or (u44:GetAttribute("_emitGen") or 0) == u55))) then
                            v58 = false;
                        else
                            v58 = not (u46 and (u46._parentAlive and not u46._parentAlive[1]));
                        end;

                        if not v58 then
                            return;
                        end;

                        if u44:GetAttribute("AnimateLoop") then
                            u44:SetAttribute("AnimateLoop", false);
                        end;
                    end);
                end;

                u43:EmitAnimate(u44, u45, u46);
            end;

            if v50 > 0 then
                task.delay(v50, doAnimate);
            else
                doAnimate();
            end;

            return;
        end;

        local Config = TypeRegistry.getConfig(u44);

        local function doEmit() -- Line: 364
            -- upvalues: u43 (copy), u56 (copy), u44 (copy), u54 (copy), u55 (ref), u46 (copy), EvenCycle (ref), Config (copy), u49 (ref), u45 (copy), Events (ref), u51 (copy), u52 (copy), u53 (copy)
            local v59;

            if u43.Connection == nil or ((u43._engineGen or 0) ~= u56 or not (u44.Parent and (u54 or (u44:GetAttribute("_emitGen") or 0) == u55))) then
                v59 = false;
            else
                v59 = not (u46 and (u46._parentAlive and not u46._parentAlive[1]));
            end;

            if not v59 then
                return;
            end;

            local v60, v61 = EvenCycle.evenFlags(Config);
            local v62, v63, v64, v65;

            if v60 or v61 then
                local v66 = u44:GetAttribute("_EvenCycleId") or u44;
                local v67 = Config and Config:GetAttribute("Rate") or 10;
                v62, v63, v64, v65 = EvenCycle.advance(u43._evenCycleStore, v66, Config, v67, v60, v61);
            else
                v63 = 0;
                v64 = 1;
                v65 = 0;
                v62 = 1;
            end;

            for i = 1, u49 do
                u43:Emit(u44, u45, Events.withEvenOffset(u46, i, u49, v62, v63, v64, v65));
                local _ = i;
            end;

            if u51 > 0 then
                if u52 or u53 then
                    u43:Enable(u44, u45, u51, u46);

                    return;
                end;

                u44:SetAttribute("_PartIclePlaying", true);

                if Config then
                    Config:SetAttribute("Enabled", true);
                end;

                u43:Enable(u44, u45, u51, u46);
                task.delay(u51, function() -- Line: 393
                    -- upvalues: u43 (ref), u56 (ref), u44 (ref), u54 (ref), u55 (ref), u46 (ref), Config (ref)
                    local v68;

                    if u43.Connection == nil or ((u43._engineGen or 0) ~= u56 or not (u44.Parent and (u54 or (u44:GetAttribute("_emitGen") or 0) == u55))) then
                        v68 = false;
                    else
                        v68 = not (u46 and (u46._parentAlive and not u46._parentAlive[1]));
                    end;

                    if not v68 then
                        return;
                    end;

                    if Config and Config.Parent then
                        Config:SetAttribute("Enabled", false);
                    end;

                    u44:SetAttribute("_PartIclePlaying", nil);
                end);
            end;
        end;

        if v50 > 0 then
            task.delay(v50, doEmit);
        else
            doEmit();
        end;
    end;

    function u3.Enable(u69, u70, u71, p72, u73) -- Line: 407
        -- upvalues: TypeRegistry (ref), u3 (copy), u2 (ref), u1 (ref), success (ref), Selection (ref), EvenCycle (ref), Events (ref)
        u69:_warnIfNotActivated("Enable");
        local Data = u69:GetData(u70);

        if not Data then
            return;
        end;

        if (u70:GetAttribute("EmissionMode") or "Emit") == "Animate" then
            u70:SetAttribute("AnimateLoop", true);
            u69:EmitAnimate(u70, u71, u73);

            return;
        end;

        local u74 = p72 or (1 / 0);
        local Config = TypeRegistry.getConfig(u70);
        local v75;

        if u73 then
            v75 = u73.ChainCtx ~= nil;
        else
            v75 = u73;
        end;

        local u76;

        if u73 then
            u76 = u73._parentAlive ~= nil;
        else
            u76 = u73;
        end;

        local u77;

        if u73 then
            u77 = u73._playToken;
        else
            u77 = u73;
        end;

        local u78 = u77 ~= nil;
        local u79 = v75 or (u76 or u78);
        local u80 = u69._engineGen or 0;

        local function loopBody() -- Line: 431
            -- upvalues: u70 (copy), u79 (copy), u69 (copy), u80 (copy), u76 (copy), u73 (copy), u78 (copy), u77 (copy), u3 (ref), u74 (copy), Data (copy), u2 (ref), u1 (ref), success (ref), Selection (ref), Config (copy), EvenCycle (ref), u71 (copy), Events (ref)
            local os_clock_ret = os.clock();
            local v81 = 0;
            local v82 = u70:GetAttribute("_EvenCycleId") or u70;

            while not (u79 and (u69._engineGen or 0) ~= u80 or (u76 and (u73._parentAlive and not u73._parentAlive[1]) or u78 and not u77.Alive)) do
                if not (u70 and u70.Parent) then
                    if not u79 then
                        u3.ActiveLoops[u70] = nil;

                        return;
                    end;

                    break;
                end;

                if u74 <= os.clock() - os_clock_ret then
                    if not u79 then
                        u3.ActiveLoops[u70] = nil;

                        return;
                    end;

                    break;
                end;

                if not (u79 or Data.CheckEnabled()) then
                    u3.ActiveLoops[u70] = nil;

                    return;
                end;

                local v83 = u2:Wait();

                if u1 and (success and not (u3._focused or #Selection:Get() ~= 0 and (u3._unfocusedAt <= 0 or os.clock() - u3._unfocusedAt <= 600))) then
                    v81 = 0;
                else
                    local v84 = Config and Config:GetAttribute("Rate") or 10;

                    if v84 <= 0 then
                        v81 = 0;
                    else
                        local v85 = 1 / v84;
                        v81 = v81 + v83;
                        local v86 = (Data.PosXEven or (Data.PosYEven or Data.PosZEven)) == true;
                        local v87;

                        if (Data.RotXEven or (Data.RotYEven or Data.RotZEven)) == true then
                            v87 = true;
                        else
                            v87 = false;
                        end;

                        while v85 <= v81 do
                            v81 = v81 - v85;

                            if v86 or v87 then
                                local v88, v89, v90, v91 = EvenCycle.advance(u69._evenCycleStore, v82, Config, v84, v86, v87);
                                u69:Emit(u70, u71, Events.withEvenOffset(u73, 1, 1, v88, v89, v90, v91));
                            else
                                u69:Emit(u70, u71, u73);
                            end;
                        end;
                    end;
                end;
            end;
        end;

        if u79 then
            local task_spawn_ret = task.spawn(function() -- Line: 483
                -- upvalues: loopBody (copy), u3 (ref), u70 (copy)
                loopBody();
                local coroutine_running_ret = coroutine.running();
                local v92 = u3.ActiveChainLoops[u70];

                if not v92 then
                    return;
                end;

                for i = #v92, 1, -1 do
                    if v92[i] == coroutine_running_ret then
                        table.remove(v92, i);
                        break;
                    end;

                    local _ = i;
                end;

                if #v92 == 0 then
                    u3.ActiveChainLoops[u70] = nil;
                end;
            end);
            local v93 = u3.ActiveChainLoops[u70];

            if not v93 then
                v93 = {};
                u3.ActiveChainLoops[u70] = v93;
            end;

            table.insert(v93, task_spawn_ret);

            if u78 then
                table.insert(u77.Loops, task_spawn_ret);
            end;
        else
            if u3.ActiveLoops[u70] then
                task.cancel(u3.ActiveLoops[u70]);
            end;

            u3.ActiveLoops[u70] = task.spawn(loopBody);
        end;
    end;

    local u94 = {};
    local u95 = false;

    function u3.EnableEmitAt(p96, p97, p98, p99) -- Line: 507
        -- upvalues: u94 (copy), u95 (ref)
        if not (p97 and (p97.Parent and p98)) then
            return;
        end;

        if not (p97:IsA("BasePart") or (p97:IsA("Attachment") or p97:IsA("Model"))) then
            local ClassName = p97.ClassName;

            if not u94[ClassName] then
                u94[ClassName] = true;
                warn(("[Part-Icles] EnableEmitAt does not support %s targets (origin override is BasePart/Attachment/Model only). Emit skipped."):format(ClassName));
            end;

            return;
        end;

        if (p97:GetAttribute("EmissionMode") or "Emit") == "Animate" then
            if not u95 then
                u95 = true;
                warn("[Part-Icles] EnableEmitAt does not support Animate-mode targets in v1; use EmitMode=AtTarget for Animate sources. Emit skipped.");
            end;

            return;
        end;

        local v100 = p99 or {};

        if v100.Link ~= nil then
            p96:SetLink(p97, v100.Link, v100.LinkMode or "Weld");
        end;

        if v100.EmitParent ~= nil then
            p96:SetEmitParent(p97, v100.EmitParent);
        end;

        p96:EnableEmit(p97, nil, {
            ChainCtx = v100.ChainCtx,
            EventOriginCF = p98,
            EventOriginResolver = v100.OriginResolver,
            UseFullOrigin = v100.UseFullOrigin ~= false,
            IgnoreLink = v100.IgnoreLink == true,
            EventDriven = v100.EventDriven == true
        });
    end;

    function u3._fireOnDeath(p101, p102) -- Line: 551
        -- upvalues: Events (ref)
        if p102.Events and (p102.Events.OnDeath and (not p102._killedManually or p102._fireOnDeathOverride)) then
            Events.fire(p101, p102, "OnDeath", p102.EventChainCtx, nil);
        end;
    end;

    function u3._fireOnDestruction(p103, p104, p105) -- Line: 559
        -- upvalues: Events (ref)
        if p104.Events and (p104.Events.OnDestruction and (p105 and p105.Parent)) then
            Events.fire(p103, p104, "OnDestruction", p104.EventChainCtx, nil);
        end;
    end;

    function u3._releaseOrDestroy(p106, p107, u108) -- Line: 566
        -- upvalues: TypeRegistry (ref), Pool (ref)
        if p107._extraLights then
            for _, v in ipairs(p107._extraLights) do
                pcall(function() -- Line: 571
                    -- upvalues: v (copy)
                    v:Destroy();
                end);
            end;

            p107._extraLights = nil;
        end;

        if not u108 then
            return;
        end;

        if not u108.Parent then
            return;
        end;

        if p107.IsAnimate or not (p107._sourceRT and p107._poolKind) then
            pcall(function() -- Line: 578
                -- upvalues: u108 (copy)
                u108:Destroy();
            end);

            return;
        end;

        local v109 = nil;
        local _sourceItem = p107._sourceItem;

        if _sourceItem and _sourceItem.Parent then
            local Config = TypeRegistry.getConfig(_sourceItem);

            if Config then
                v109 = Config:GetAttribute("Rate");
            end;
        end;

        Pool.release(u108, p107._sourceRT, p107._poolKind, v109);
    end;

    function u3._makeAliveCheck(u110) -- Line: 592
        local u111 = u110._engineGen or 0;

        return function() -- Line: 594
            -- upvalues: u110 (copy), u111 (copy)
            local v112;

            if u110.Connection == nil then
                v112 = false;
            else
                v112 = (u110._engineGen or 0) == u111;
            end;

            return v112;
        end;
    end;

    function u3._fireAnimateCycleRestartEvents(p113, p114) -- Line: 600
        -- upvalues: Events (ref)
        if p114.Events and p114.Events.OnHit then
            p114.LastHitCheckPos = Events.getWorldPosition(p114);
            p114.LastHitCheckTime = nil;
        end;

        if p114.Events and p114.Events.OnEmit then
            local v115 = Events.makePayload(p113, p114, "OnEmit", {
                EmitIndex = nil,
                ChainCtx = p114.EventChainCtx
            });
            Events.fire(p113, p114, "OnEmit", p114.EventChainCtx, v115);
        end;
    end;

    function u3._killParticle(p116, p117, p118) -- Line: 613
        -- upvalues: TypeRegistry (ref)
        p117._killedManually = true;
        p117._fireOnDeathOverride = (p118 or {}).fireOnDeath == true;
        p117._forceDead = true;
        p117.PartLife = 0;
        local u119 = p117.IsAnimate and p117._sourceItem;

        if u119 then
            pcall(function() -- Line: 622
                -- upvalues: u119 (copy), TypeRegistry (ref)
                u119:SetAttribute("AnimateLoop", false);
                local Config = TypeRegistry.getConfig(u119);

                if Config then
                    Config:SetAttribute("Enabled", false);
                end;
            end);
        end;
    end;
end;