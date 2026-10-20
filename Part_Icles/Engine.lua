-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Events = require(script.Parent.Events);
local EventsCollision = require(script.Parent.EventsCollision);
local Pool = require(script.Parent.Pool);
local Apply = require(script.Parent.CameraShake.Apply);
local u1 = 0;

return function(p2) -- Line: 23
    -- upvalues: RunService (copy), UserInputService (copy), Events (copy), Pool (copy), Apply (copy), EventsCollision (copy), u1 (ref)
    function p2.Activate(u3) -- Line: 26
        -- upvalues: RunService (ref), UserInputService (ref), Events (ref), Pool (ref), Apply (ref), EventsCollision (ref), u1 (ref)
        if u3.Connection then
            return;
        end;

        u3._engineGen = (u3._engineGen or 0) + 1;
        u3._notActivatedWarned = false;

        if RunService:IsClient() then
            if not u3._focusConn then
                u3._focusConn = UserInputService.WindowFocused:Connect(function() -- Line: 39
                    -- upvalues: u3 (copy)
                    u3._focused = true;
                    u3._unfocusedAt = 0;
                end);
            end;

            if not u3._blurConn then
                u3._blurConn = UserInputService.WindowFocusReleased:Connect(function() -- Line: 45
                    -- upvalues: u3 (copy)
                    u3._focused = false;
                    u3._unfocusedAt = os.clock();
                end);
            end;
        end;

        for _, v in ipairs({
            workspace,
            game:GetService("Lighting"),
            game:GetService("ReplicatedStorage"),
            game:GetService("StarterGui"),
            game:GetService("StarterPack"),
            game:GetService("ReplicatedFirst")
        }) do
            pcall(function() -- Line: 61
                -- upvalues: u3 (copy), v (copy)
                u3:Preload(v, false);
            end);
        end;

        local function u23(p4) -- Line: 64
            -- upvalues: Events (ref), Pool (ref), u3 (copy), Apply (ref), EventsCollision (ref)
            Events.tickFrame();
            local os_clock_ret = os.clock();
            Pool.tick(os_clock_ret);
            local ActiveEmits = u3.ActiveEmits;

            if #ActiveEmits == 0 then
                Apply.applyFrame();

                return;
            end;

            local workspace_CurrentCamera = workspace.CurrentCamera;
            local v5;

            if workspace_CurrentCamera then
                v5 = workspace_CurrentCamera.CFrame.Position;
            else
                v5 = nil;
            end;

            local v6 = 1;

            while v6 <= #ActiveEmits do
                local u7 = ActiveEmits[v6];
                local v8 = u7._forceDead == true;
                local CurrentStep = u7.CurrentStep;

                if not v8 then
                    if u7.Type == "Part" then
                        v8 = u3:UpdatePart(u7, p4, os_clock_ret);
                    elseif u7.Type == "Beam" then
                        v8 = u3:UpdateBeam(u7, p4, os_clock_ret);
                    elseif u7.Type == "PointLight" then
                        v8 = u3:UpdatePointLight(u7, p4, os_clock_ret);
                    elseif u7.Type == "Highlight" then
                        v8 = u3:UpdateHighlight(u7, p4, os_clock_ret);
                    elseif u7.Type == "TrailEmitter" then
                        v8 = u3:UpdateTrail(u7, p4, os_clock_ret);
                    elseif u7.Type == "Attachment" then
                        v8 = u3:UpdateAttachment(u7, p4, os_clock_ret);
                    elseif u7.Type == "Model" then
                        v8 = u3:UpdateModel(u7, p4, os_clock_ret);
                    elseif u7.Type == "Screen" then
                        v8 = u3:UpdateScreen(u7, p4, os_clock_ret);
                    elseif u7.Type == "ImageLabel" then
                        v8 = u3:UpdateImageLabel(u7, p4, os_clock_ret);
                    elseif u7.Type == "Lightning" then
                        v8 = u3:UpdateLightning(u7, p4, os_clock_ret);
                    elseif u7.Type == "CameraShake" then
                        v8 = u3:UpdateCameraShake(u7, p4, os_clock_ret);
                    elseif u7.Type == "Rocks" then
                        v8 = u3:UpdateRocks(u7, p4, os_clock_ret);
                    elseif u7.Type == "Rope" then
                        v8 = u3:UpdateRope(u7, p4, os_clock_ret);
                    end;
                end;

                if not v8 then
                    if u7.Link then
                        u3:ReapplyLink(u7);
                    end;

                    local Type = u7.Type;

                    if u7._settleEngaged and not (u7._collisionStopped or Type ~= "Part" and (Type ~= "Model" and Type ~= "Attachment")) then
                        EventsCollision.applySettle(u7, p4);
                    end;

                    if (Type == "Part" or (Type == "Model" or Type == "Attachment")) and (u7.Link or u7.CurrentStep ~= CurrentStep) then
                        u7._postUpdateCF = Type == "Model" and u7.VisualPart:GetPivot() or u7.VisualPart.CFrame;
                    end;

                    if u7.Orientation and u7.Orientation ~= "None" then
                        u3:ApplyOrientation(u7, p4, v5);
                    end;

                    if u7.ZOffset and u7.ZOffset ~= 0 then
                        u3:ApplyZOffset(u7, v5);
                    end;
                end;

                Events.afterUpdate(u3, u7, v8, os_clock_ret);

                if v8 then
                    u3:_fireOnDeath(u7);

                    if u7.IsAnimate then
                        if u7.AnimateItem and (u7.AnimateItem.Parent and u7.AnimateItem:GetAttribute("AnimateLoop")) then
                            u3:_replayAnimateCycle(u7, os_clock_ret);
                            v6 = v6 + 1;
                        else
                            local VisualPart = u7.VisualPart;
                            local Type = u7.Type;
                            local InitialAnchorCF = u7.InitialAnchorCF;
                            local InitialScale = u7.InitialScale;
                            local HasDecal = u7.HasDecal;
                            local AnimateItem = u7.AnimateItem;
                            local v9 = u7.PartLife or 0;
                            local u10 = (Type == "Part" or (Type == "Attachment" or Type == "Model")) and true or Type == "Beam";
                            local u11;

                            if AnimateItem then
                                u11 = (AnimateItem:GetAttribute("_animateFinishGen") or 0) + 1;
                                pcall(function() -- Line: 170
                                    -- upvalues: AnimateItem (copy), u11 (ref)
                                    AnimateItem:SetAttribute("_animateFinishGen", u11);
                                end);
                            else
                                u11 = nil;
                            end;

                            local function finishAnimate() -- Line: 172
                                -- upvalues: VisualPart (copy), u10 (copy), AnimateItem (copy), u3 (ref), u11 (ref), u7 (copy), InitialAnchorCF (copy), Type (copy), InitialScale (copy), HasDecal (copy)
                                if not (VisualPart and VisualPart.Parent) then
                                    return;
                                end;

                                if u10 and (AnimateItem and u3.ActiveAnimates[AnimateItem]) then
                                    return;
                                end;

                                if AnimateItem and (AnimateItem.Parent and (u11 and AnimateItem:GetAttribute("_animateFinishGen") ~= u11)) then
                                    return;
                                end;

                                u3:_fireOnDestruction(u7, VisualPart);

                                if InitialAnchorCF then
                                    if Type == "Model" then
                                        pcall(function() -- Line: 182
                                            -- upvalues: VisualPart (ref), InitialAnchorCF (ref)
                                            VisualPart:PivotTo(InitialAnchorCF);
                                        end);

                                        if InitialScale then
                                            pcall(function() -- Line: 183
                                                -- upvalues: VisualPart (ref), InitialScale (ref)
                                                VisualPart:ScaleTo(InitialScale);
                                            end);
                                        end;
                                    else
                                        pcall(function() -- Line: 184
                                            -- upvalues: VisualPart (ref), InitialAnchorCF (ref)
                                            VisualPart.CFrame = InitialAnchorCF;
                                        end);
                                    end;
                                end;

                                if Type == "Screen" or (Type == "ImageLabel" or (Type == "Lightning" or (Type == "Rocks" or Type == "Rope"))) then
                                    pcall(function() -- Line: 187
                                        -- upvalues: VisualPart (ref)
                                        VisualPart:Destroy();
                                    end);

                                    return;
                                end;

                                if Type ~= "Beam" and (Type ~= "Highlight" and Type ~= "TrailEmitter") then
                                    pcall(function() -- Line: 195
                                        -- upvalues: VisualPart (ref), HasDecal (ref), u7 (ref)
                                        VisualPart.Transparency = 1;
                                        local v12 = HasDecal and VisualPart:FindFirstChildOfClass("Decal");

                                        if v12 then
                                            v12.Transparency = 1;
                                        end;

                                        local v13 = u7._initialSAColor and VisualPart:FindFirstChildOfClass("SurfaceAppearance");

                                        if v13 then
                                            v13.Color = u7._initialSAColor;
                                        end;

                                        if u7._initialPartColor and VisualPart:IsA("BasePart") then
                                            VisualPart.Color = u7._initialPartColor;
                                        end;
                                    end);

                                    return;
                                end;

                                local u14 = u7.BeamSnapshot or (u7.HighlightSnapshot or u7.TrailEmitterSnapshot);

                                if u14 then
                                    pcall(function() -- Line: 191
                                        -- upvalues: u14 (copy), VisualPart (ref)
                                        for i, v in pairs(u14) do
                                            VisualPart[i] = v;
                                        end;
                                    end);
                                end;

                                pcall(function() -- Line: 193
                                    -- upvalues: VisualPart (ref)
                                    VisualPart.Enabled = false;
                                end);
                            end;

                            u3.ActiveAnimates[AnimateItem] = nil;

                            if v9 > 0 then
                                task.delay(v9, finishAnimate);
                            else
                                finishAnimate();
                            end;

                            if u7._scaleMapKeys and u3._parentScaleMap then
                                for _, v in ipairs(u7._scaleMapKeys) do
                                    u3._parentScaleMap[v] = nil;
                                end;
                            end;

                            if u7._nestedAlive then
                                u7._nestedAlive[1] = false;
                            end;

                            local v15 = #ActiveEmits;

                            if v6 < v15 then
                                ActiveEmits[v6] = ActiveEmits[v15];
                            end;

                            ActiveEmits[v15] = nil;
                        end;
                    else
                        local VisualPart = u7.VisualPart;

                        if u7.PartLife and u7.PartLife > 0 then
                            local _sourceItem = u7._sourceItem;

                            if _sourceItem and VisualPart then
                                u3._lingerByItem = u3._lingerByItem or {};
                                local v16 = u3._lingerByItem[_sourceItem] or {};
                                table.insert(v16, VisualPart);
                                u3._lingerByItem[_sourceItem] = v16;
                                pcall(function() -- Line: 234
                                    -- upvalues: VisualPart (copy)
                                    VisualPart:SetAttribute("_lingerCounted", true);
                                end);
                                local v17 = u3;
                                v17._lingerVisualCount = v17._lingerVisualCount + 1;
                            end;

                            u7._lingerStartTime = os.clock();
                            task.delay(u7.PartLife, function() -- Line: 241
                                -- upvalues: u3 (ref), u7 (copy), VisualPart (copy), _sourceItem (copy)
                                u3:_fireOnDestruction(u7, VisualPart);

                                if VisualPart then
                                    local u18 = false;
                                    pcall(function() -- Line: 245
                                        -- upvalues: u18 (ref), VisualPart (ref)
                                        u18 = VisualPart:GetAttribute("_lingerCounted") == true;
                                    end);

                                    if u18 then
                                        u3._lingerVisualCount = math.max(0, (u3._lingerVisualCount or 0) - 1);
                                        pcall(function() -- Line: 248
                                            -- upvalues: VisualPart (ref)
                                            VisualPart:SetAttribute("_lingerCounted", nil);
                                        end);
                                    end;

                                    u3:_releaseOrDestroy(u7, VisualPart);
                                end;

                                if _sourceItem and (u3._lingerByItem and u3._lingerByItem[_sourceItem]) then
                                    local v19 = u3._lingerByItem[_sourceItem];

                                    for i = #v19, 1, -1 do
                                        local v20;

                                        if v19[i] == VisualPart then
                                            local v21 = #v19;

                                            if i < v21 then
                                                v19[i] = v19[v21];
                                            end;

                                            v19[v21] = nil;
                                            v20 = i;
                                        else
                                            v20 = i;
                                        end;
                                    end;

                                    if #v19 == 0 then
                                        u3._lingerByItem[_sourceItem] = nil;
                                    end;
                                end;
                            end);
                        else
                            u3:_fireOnDestruction(u7, VisualPart);
                            u3:_releaseOrDestroy(u7, VisualPart);
                        end;

                        if u7._scaleMapKeys and u3._parentScaleMap then
                            for _, v in ipairs(u7._scaleMapKeys) do
                                u3._parentScaleMap[v] = nil;
                            end;
                        end;

                        if u7._nestedAlive then
                            u7._nestedAlive[1] = false;
                        end;

                        local v22 = #ActiveEmits;

                        if v6 < v22 then
                            ActiveEmits[v6] = ActiveEmits[v22];
                        end;

                        ActiveEmits[v22] = nil;
                    end;
                else
                    v6 = v6 + 1;
                end;
            end;

            Apply.applyFrame();
        end;

        if not RunService:IsClient() then
            u3.Connection = RunService.Heartbeat:Connect(u23);

            return;
        end;

        u1 = u1 + 1;
        u3._renderStepName = "PartIclesEngine_" .. u1;

        if pcall(function() -- Line: 297
            -- upvalues: RunService (ref), u3 (copy), u23 (copy)
            RunService:BindToRenderStep(u3._renderStepName, Enum.RenderPriority.Last.Value + 1, u23);
        end) then
            u3.Connection = "RenderStep";

            return;
        end;

        u3._renderStepName = nil;
        u3.Connection = RunService.RenderStepped:Connect(u23);
    end;

    function p2.Deactivate(u24) -- Line: 313
        -- upvalues: RunService (ref), Apply (ref), Pool (ref), Events (ref)
        u24._engineGen = (u24._engineGen or 0) + 1;

        if u24.Connection then
            if u24._renderStepName then
                pcall(function() -- Line: 321
                    -- upvalues: RunService (ref), u24 (copy)
                    RunService:UnbindFromRenderStep(u24._renderStepName);
                end);
                u24._renderStepName = nil;
            elseif typeof(u24.Connection) == "RBXScriptConnection" then
                u24.Connection:Disconnect();
            end;

            u24.Connection = nil;
        end;

        if u24._focusConn then
            u24._focusConn:Disconnect();
            u24._focusConn = nil;
        end;

        if u24._blurConn then
            u24._blurConn:Disconnect();
            u24._blurConn = nil;
        end;

        Apply.reset();

        if u24._parentScaleMap then
            table.clear(u24._parentScaleMap);
        end;

        if u24._lingerByItem then
            table.clear(u24._lingerByItem);
        end;

        if u24._evenCycleStore then
            table.clear(u24._evenCycleStore);
        end;

        u24._lingerVisualCount = 0;
        Pool.flushAll();

        for i = #u24.ActiveEmits, 1, -1 do
            local u25 = u24.ActiveEmits[i];

            if not (u25.IsAnimate and ((u25.Type == "Part" or (u25.Type == "Attachment" or u25.Type == "Beam")) and true or u25.Type == "Model")) and u25.VisualPart then
                pcall(function() -- Line: 355
                    -- upvalues: u25 (copy)
                    u25.VisualPart:Destroy();
                end);
            end;

            if u25._nestedAlive then
                u25._nestedAlive[1] = false;
            end;

            u24.ActiveEmits[i] = nil;
            local _ = i;
        end;

        local v26 = {};

        for i in pairs(u24.ActiveAnimates) do
            table.insert(v26, i);
        end;

        for _, v in ipairs(v26) do
            pcall(function() -- Line: 364
                -- upvalues: u24 (copy), v (copy)
                u24:_cancelAnimation(v);
            end);
        end;

        table.clear(u24.ActiveAnimates);

        for i, v in pairs(u24.ActiveLoops) do
            pcall(function() -- Line: 368
                -- upvalues: v (copy)
                task.cancel(v);
            end);
            u24.ActiveLoops[i] = nil;
        end;

        if u24.ActiveChainLoops then
            for _, v in pairs(u24.ActiveChainLoops) do
                for _, v2 in ipairs(v) do
                    pcall(task.cancel, v2);
                end;
            end;

            table.clear(u24.ActiveChainLoops);
        end;

        if u24._CachedFolder and u24._CachedFolder.Parent then
            u24._CachedFolder:Destroy();
        end;

        u24._CachedFolder = nil;

        if u24._CachedPoolFolder and u24._CachedPoolFolder.Parent then
            u24._CachedPoolFolder:Destroy();
        end;

        u24._CachedPoolFolder = nil;

        local function sweep(p27) -- Line: 386
            for _, descendant in p27:GetDescendants() do
                if descendant:GetAttribute("_PartIcleEmit") then
                    pcall(descendant.Destroy, descendant);
                end;
            end;
        end;

        sweep(workspace);
        sweep(game:GetService("Lighting"));
        local ScreenHost = require(script.Parent.ScreenHost);

        if ScreenHost.exists() then
            sweep(ScreenHost.get());
            ScreenHost.destroy();
        end;

        require(script.Parent.TexturePin).clear();
        Events.cleanup();

        if u24.LinkService and u24.LinkService.Deactivate then
            pcall(function() -- Line: 400
                -- upvalues: u24 (copy)
                u24.LinkService:Deactivate();
            end);
        end;
    end;

    function p2.GetFolder(p28) -- Line: 409
        if p28._CachedFolder and p28._CachedFolder.Parent then
            return p28._CachedFolder;
        end;

        local EmittedPartsUsingPart_icle = workspace.Terrain:FindFirstChild("EmittedPartsUsingPart_icle");

        if not EmittedPartsUsingPart_icle then
            EmittedPartsUsingPart_icle = Instance.new("Folder");
            EmittedPartsUsingPart_icle.Name = "EmittedPartsUsingPart_icle";
            EmittedPartsUsingPart_icle.Archivable = false;
            EmittedPartsUsingPart_icle.Parent = workspace.Terrain;
        end;

        p28._CachedFolder = EmittedPartsUsingPart_icle;

        return EmittedPartsUsingPart_icle;
    end;

    function p2.GetPoolFolder(p29) -- Line: 426
        if p29._CachedPoolFolder and p29._CachedPoolFolder.Parent then
            return p29._CachedPoolFolder;
        end;

        local Part_IclesPooled = workspace.Terrain:FindFirstChild("Part_IclesPooled");

        if not Part_IclesPooled then
            Part_IclesPooled = Instance.new("Folder");
            Part_IclesPooled.Name = "Part_IclesPooled";
            Part_IclesPooled.Archivable = false;
            Part_IclesPooled.Parent = workspace.Terrain;
        end;

        p29._CachedPoolFolder = Part_IclesPooled;

        return Part_IclesPooled;
    end;
end;