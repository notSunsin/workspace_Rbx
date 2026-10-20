-- Decompiled with Potassium's decompiler.

local TypeRegistry = require(script.Parent.TypeRegistry);
local EventsCollision = require(script.Parent.EventsCollision);
local EventsPayload = require(script.Parent.EventsPayload);
local EventsSchema = require(script.Parent.EventsSchema);
local Pool = require(script.Parent.Pool);
local u1 = {};
local _ = TypeRegistry.CONFIG_NAME;
local u2 = {};
u1._frameCount = 0;
u1._burstDropped = 0;
u1._burstReportPending = false;
local u3 = false;
local u4 = 0;
local u5 = 0;
local u6 = {};
local u7 = {};
local u8 = 0;

local function nextChainId() -- Line: 49
    -- upvalues: u8 (ref)
    u8 = u8 + 1;

    return u8;
end;

function u1.newChainCtx() -- Line: 54
    -- upvalues: u8 (ref)
    local v9 = {
        Depth = 0
    };
    u8 = u8 + 1;
    v9.ChainId = u8;

    return v9;
end;

function u1.withEmitIndex(p10, p11) -- Line: 59
    if not p10 then
        return {
            EmitIndex = p11
        };
    end;

    local v12 = {
        EmitIndex = p11
    };

    for i, v in pairs(p10) do
        if i ~= "EmitIndex" then
            v12[i] = v;
        end;
    end;

    return v12;
end;

function u1.withEmitIndexAndCount(p13, p14, p15) -- Line: 69
    if not p13 then
        return {
            EmitIndex = p14,
            EmitCount = p15
        };
    end;

    local v16 = {
        EmitIndex = p14,
        EmitCount = p15
    };

    for i, v in pairs(p13) do
        if i ~= "EmitIndex" and i ~= "EmitCount" then
            v16[i] = v;
        end;
    end;

    return v16;
end;

function u1.withEvenOffset(p17, p18, p19, p20, p21, p22, p23) -- Line: 83
    local v24 = {
        EmitIndex = p18,
        EmitCount = p19
    };

    if p17 then
        for i, v in pairs(p17) do
            if i ~= "EmitIndex" and (i ~= "EmitCount" and (i ~= "EvenOffsetIdx_Pos" and (i ~= "EvenOffsetN_Pos" and (i ~= "EvenOffsetIdx_Rot" and i ~= "EvenOffsetN_Rot")))) then
                v24[i] = v;
            end;
        end;
    end;

    if p21 and p21 > 0 then
        v24.EvenOffsetIdx_Pos = p20;
        v24.EvenOffsetN_Pos = p21;
    end;

    if p23 and p23 > 0 then
        v24.EvenOffsetIdx_Rot = p22;
        v24.EvenOffsetN_Rot = p23;
    end;

    return v24;
end;

function u1.descendCtx(p25) -- Line: 107
    if p25 then
        return (p25.EventOriginCF ~= nil or (p25.IgnoreLink ~= nil or (p25.UseFullOrigin ~= nil or p25.EventOriginResolver ~= nil))) and {
            ChainCtx = p25.ChainCtx,
            EmitIndex = p25.EmitIndex,
            EmitCount = p25.EmitCount
        } or p25;
    end;

    return nil;
end;

local success = pcall(function() -- Line: 124
    return Instance.new("ModuleScript").Source;
end);

function u1._compile(p26) -- Line: 126
    -- upvalues: success (copy)
    if not success then
        local success2, result = pcall(require, p26);

        if not success2 then
            return nil, result;
        end;

        if type(result) == "function" then
            return result, nil, nil;
        end;

        return nil, "module must return function(payload)";
    end;

    local v27 = p26:Clone();
    v27.Name = "_CompiledEventModule";
    v27.Archivable = false;
    v27.Parent = p26.Parent;
    local success2, result = pcall(require, v27);

    if not success2 then
        v27:Destroy();

        return nil, result;
    end;

    if type(result) == "function" then
        return result, nil, v27;
    end;

    v27:Destroy();

    return nil, "module must return function(payload)";
end;

function u1._isCacheValid(p28, p29) -- Line: 148
    if not (p28 and (p29 and p29:IsA("ModuleScript"))) then
        return false;
    end;

    if p29.Name ~= "Module" then
        return false;
    end;

    local expectedEventCfg = p28.expectedEventCfg;

    if not (expectedEventCfg and expectedEventCfg.Parent) then
        return false;
    end;

    if expectedEventCfg.Name ~= p28.expectedEventName then
        return false;
    end;

    if expectedEventCfg.Parent and expectedEventCfg.Parent.Name == "Events" then
        return p29.Parent == expectedEventCfg;
    end;

    return false;
end;

function u1._invalidate(p30) -- Line: 159
    -- upvalues: u2 (copy)
    local u31 = u2[p30];

    if not u31 then
        return;
    end;

    if u31.sourceConn then
        u31.sourceConn:Disconnect();
        u31.sourceConn = nil;
    end;

    if u31.ancestryConn then
        u31.ancestryConn:Disconnect();
        u31.ancestryConn = nil;
    end;

    if u31.nameConn then
        u31.nameConn:Disconnect();
        u31.nameConn = nil;
    end;

    if u31.compiledClone then
        pcall(function() -- Line: 166
            -- upvalues: u31 (copy)
            u31.compiledClone:Destroy();
        end);
        u31.compiledClone = nil;
    end;

    u2[p30] = nil;
end;

function u1.compile(u32) -- Line: 173
    -- upvalues: u2 (copy), u1 (copy), success (copy)
    if not (u32 and u32:IsA("ModuleScript")) then
        return nil;
    end;

    local v33 = u2[u32];

    if v33 and (not v33.dirty and u1._isCacheValid(v33, u32)) then
        return v33.fn;
    end;

    if v33 then
        u1._invalidate(u32);
    end;

    local v34, v35, v36 = u1._compile(u32);

    if not v34 then
        u1.reportScriptError(u32, v35);

        return nil;
    end;

    local Parent = u32.Parent;

    if not (Parent and Parent:IsA("Configuration")) then
        v36:Destroy();

        return nil;
    end;

    local v37 = {
        dirty = false,
        fn = v34,
        expectedEventCfg = Parent,
        expectedEventName = Parent.Name,
        compiledClone = v36
    };

    if success then
        v37.sourceConn = u32:GetPropertyChangedSignal("Source"):Connect(function() -- Line: 204
            -- upvalues: u2 (ref), u32 (copy)
            if u2[u32] then
                u2[u32].dirty = true;
            end;
        end);
    end;

    v37.ancestryConn = u32.AncestryChanged:Connect(function() -- Line: 209
        -- upvalues: u1 (ref), u2 (ref), u32 (copy)
        if not u1._isCacheValid(u2[u32], u32) then
            u1._invalidate(u32);
        end;
    end);
    v37.nameConn = u32:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 216
        -- upvalues: u32 (copy)
        if u32.Name ~= "Module" then
            pcall(function() -- Line: 218
                -- upvalues: u32 (ref)
                u32.Name = "Module";
            end);
        end;
    end);
    u2[u32] = v37;

    return v34;
end;

function u1.cleanup() -- Line: 225
    -- upvalues: u2 (copy), u1 (copy), u5 (ref), u4 (ref), u3 (ref), u6 (copy), u7 (copy)
    local v38 = {};

    for i in pairs(u2) do
        table.insert(v38, i);
    end;

    for _, v in ipairs(v38) do
        u1._invalidate(v);
    end;

    u5 = u5 + 1;
    u1._frameCount = 0;
    u1._burstDropped = 0;
    u1._burstReportPending = false;
    u4 = 0;
    u3 = false;
    table.clear(u6);
    table.clear(u7);
end;

function u1._reportBurst() -- Line: 244
    -- upvalues: u1 (copy), u5 (ref)
    local v39 = u1;
    v39._burstDropped = v39._burstDropped + 1;

    if not u1._burstReportPending then
        u1._burstReportPending = true;
        local u40 = u5;
        task.delay(1, function() -- Line: 249
            -- upvalues: u40 (copy), u5 (ref), u1 (ref)
            if u40 ~= u5 then
                return;
            end;

            if u1._burstDropped > 0 then
                warn(("[Part-Icles Events] dropped %d event fires this second."):format(u1._burstDropped));
            end;

            u1._burstDropped = 0;
            u1._burstReportPending = false;
        end);
    end;
end;

function u1.reserveFrameFire() -- Line: 260
    -- upvalues: u1 (copy)
    if u1._frameCount >= 256 then
        u1._reportBurst();

        return false;
    end;

    local v41 = u1;
    v41._frameCount = v41._frameCount + 1;

    return true;
end;

function u1.tickFrame() -- Line: 270
    -- upvalues: u1 (copy)
    u1._frameCount = 0;
end;

function u1.dropDepth(u42) -- Line: 274
    -- upvalues: u4 (ref), u3 (ref), u5 (ref)
    u4 = u4 + 1;

    if not u3 then
        u3 = true;
        local u43 = u5;
        task.delay(1, function() -- Line: 279
            -- upvalues: u43 (copy), u5 (ref), u4 (ref), u42 (copy), u3 (ref)
            if u43 ~= u5 then
                return;
            end;

            if u4 > 0 then
                warn(("[Part-Icles Events] dropped %d event fire(s) this second (chain depth limit reached%s)."):format(u4, u42 and " on " .. u42 or ""));
            end;

            u4 = 0;
            u3 = false;
        end);
    end;
end;

function u1.reportScriptError(p44, p45) -- Line: 291
    local v46 = p44 and p44:GetFullName() or "<destroyed>";
    warn(("[Part-Icles Events] %s\n  %s"):format(v46, (tostring(p45))));
end;

function u1.getWorldCF(p47) -- Line: 297
    local VisualPart = p47.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return nil;
    end;

    if VisualPart:IsA("BasePart") then
        return VisualPart.CFrame;
    end;

    if VisualPart:IsA("Attachment") then
        return VisualPart.WorldCFrame;
    end;

    if VisualPart:IsA("Model") then
        return VisualPart:GetPivot();
    end;

    if VisualPart:IsA("PointLight") then
        local Parent = VisualPart.Parent;

        if Parent and Parent:IsA("BasePart") then
            return Parent.CFrame;
        end;

        if Parent and Parent:IsA("Attachment") then
            return Parent.WorldCFrame;
        end;

        return nil;
    end;

    if not VisualPart:IsA("Beam") then
        return nil;
    end;

    local Attachment0 = VisualPart.Attachment0;

    if not Attachment0 then
        return nil;
    end;

    local Attachment1 = VisualPart.Attachment1;

    if Attachment1 then
        return CFrame.new((Attachment0.WorldPosition + Attachment1.WorldPosition) * 0.5);
    end;

    return CFrame.new(Attachment0.WorldPosition);
end;

function u1.getWorldPosition(p48) -- Line: 321
    -- upvalues: u1 (copy)
    local WorldCF = u1.getWorldCF(p48);

    return WorldCF and WorldCF.Position or nil;
end;

function u1.getSourceWorldCF(p49) -- Line: 326
    if not (p49 and p49.Parent) then
        return nil;
    end;

    if p49:IsA("BasePart") then
        return p49.CFrame;
    end;

    if p49:IsA("Attachment") then
        return p49.WorldCFrame;
    end;

    if p49:IsA("Model") then
        return p49:GetPivot();
    end;

    if p49:IsA("Beam") then
        local Attachment0 = p49.Attachment0;

        if not Attachment0 then
            return nil;
        end;

        local Attachment1 = p49.Attachment1;

        if Attachment1 then
            return CFrame.new((Attachment0.WorldPosition + Attachment1.WorldPosition) * 0.5);
        end;

        return CFrame.new(Attachment0.WorldPosition);
    end;

    if not p49:IsA("PointLight") then
        return nil;
    end;

    local Parent = p49.Parent;

    if Parent and Parent:IsA("BasePart") then
        return Parent.CFrame;
    end;

    if Parent and Parent:IsA("Attachment") then
        return Parent.WorldCFrame;
    end;

    return nil;
end;

function u1.makeHitParams(p50) -- Line: 355
    -- upvalues: EventsSchema (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local v51 = {};

    if p50.VisualPart then
        table.insert(v51, p50.VisualPart);
    end;

    if p50._sourceItem then
        table.insert(v51, p50._sourceItem);
    end;

    if p50._sourceItem then
        local RenderTemplate = p50._sourceItem:FindFirstChild("RenderTemplate");

        if RenderTemplate then
            table.insert(v51, RenderTemplate);
        end;

        local EmitParent = p50._sourceItem:FindFirstChild("EmitParent");

        if EmitParent and (EmitParent:IsA("ObjectValue") and EmitParent.Value) then
            table.insert(v51, EmitParent.Value);
        end;
    end;

    if p50.VisualPart and (p50.VisualPart:IsA("Attachment") and p50.VisualPart.Parent) then
        table.insert(v51, p50.VisualPart.Parent);
    end;

    if p50._sourceItem then
        local v52 = EventsSchema.readEvent(p50._sourceItem, "OnHit");

        if v52 then
            local Attribute = v52:GetAttribute("CollisionGroup");

            if type(Attribute) == "string" and Attribute ~= "" then
                pcall(function() -- Line: 386
                    -- upvalues: RaycastParams_new_ret (copy), Attribute (copy)
                    RaycastParams_new_ret.CollisionGroup = Attribute;
                end);
            end;

            local ExcludeList = v52:FindFirstChild("ExcludeList");

            if ExcludeList then
                for _, child in ipairs(ExcludeList:GetChildren()) do
                    if child:IsA("ObjectValue") and child.Value then
                        table.insert(v51, child.Value);
                    end;
                end;
            end;
        end;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v51;
    RaycastParams_new_ret.IgnoreWater = true;

    return RaycastParams_new_ret;
end;

function u1.makePayload(p53, p54, p55, p56) -- Line: 404
    -- upvalues: EventsPayload (copy), u1 (copy)
    return EventsPayload.build(p54, p55, p56, u1.getWorldCF(p54));
end;

function u1.resolveEmitModeCF(p57, p58, p59) -- Line: 417
    -- upvalues: u1 (copy)
    if p57 == "AtPosition" then
        if p58 and p58._eventName == "OnEmit" then
            local WorldCF = u1.getWorldCF(p59);

            if WorldCF then
                return WorldCF;
            end;

            if p59.CurrentPosition then
                return CFrame.new(p59.CurrentPosition);
            end;
        end;

        local v60 = p58.HitPosition or (p58.DeathPosition or p58.EmitPosition);

        if v60 and (p58._eventName == "OnHit" and p58.HitNormal) then
            v60 = v60 + p58.HitNormal * 0.1;
        end;

        return v60 and CFrame.new(v60) or nil;
    end;

    if p57 == "AtSource" then
        return u1.getSourceWorldCF(p59._sourceItem);
    end;

    if p57 ~= "AtCFrame" then
        return nil;
    end;

    local v61 = p58 and p58._eventName == "OnEmit" and u1.getWorldCF(p59);

    if v61 then
        return v61;
    end;

    local v62;

    if p58 then
        v62 = p58.WorldCFrame;
    else
        v62 = p58;
    end;

    if v62 and (p58._eventName == "OnHit" and p58.HitNormal) then
        v62 = v62 + p58.HitNormal * 0.1;
    end;

    return v62 or nil;
end;

function u1._supportsOriginOverride(p63) -- Line: 446
    return p63:IsA("BasePart") or (p63:IsA("Attachment") or p63:IsA("Model"));
end;

local function _newHolderPart() -- Line: 452
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Massless = true;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.001, 0.001, 0.001);
    Part.Archivable = false;

    return Part;
end;

local function _anchorClone(p64) -- Line: 466
    if p64:IsA("BasePart") then
        p64.Anchored = true;
    end;

    for _, descendant in ipairs(p64:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;
end;

local function _positionClone(p65, p66) -- Line: 475
    if p65:IsA("Model") then
        p65:PivotTo(p66);

        return;
    end;

    if p65:IsA("BasePart") then
        p65.CFrame = p66;

        return;
    end;

    if p65:IsA("Attachment") then
        p65.WorldCFrame = p66;
    end;
end;

local function _getAttachmentHolder(p67) -- Line: 488
    local Folder = p67:GetFolder();
    local _AttachmentHolder = Folder:FindFirstChild("_AttachmentHolder");

    if _AttachmentHolder then
        return _AttachmentHolder;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Massless = true;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.001, 0.001, 0.001);
    Part.Archivable = false;
    Part.Name = "_AttachmentHolder";
    Part.CFrame = CFrame.new();
    Part.Parent = Folder;

    return Part;
end;

local function _stampAuthoredEnabled(u68) -- Line: 504
    local function visit(u69) -- Line: 505
        if u69:IsA("ParticleEmitter") or u69:IsA("Trail") then
            pcall(function() -- Line: 507
                -- upvalues: u69 (copy)
                u69:SetAttribute("_PartIcleAuthoredEnabled", u69.Enabled);
            end);
        end;
    end;

    if u68:IsA("ParticleEmitter") or u68:IsA("Trail") then
        pcall(function() -- Line: 507
            -- upvalues: u68 (copy)
            u68:SetAttribute("_PartIcleAuthoredEnabled", u68.Enabled);
        end);
    end;

    for _, descendant in ipairs(u68:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            pcall(function() -- Line: 507
                -- upvalues: descendant (copy)
                descendant:SetAttribute("_PartIcleAuthoredEnabled", descendant.Enabled);
            end);
        end;
    end;
end;

local function _restoreAuthoredEnabled(p70) -- Line: 516
    local function v72(u71) -- Line: 517
        if u71:IsA("ParticleEmitter") or u71:IsA("Trail") then
            local Attribute = u71:GetAttribute("_PartIcleAuthoredEnabled");
            pcall(function() -- Line: 520
                -- upvalues: u71 (copy), Attribute (copy)
                u71.Enabled = Attribute == true;
            end);
        end;
    end;

    v72(p70);

    for _, descendant in ipairs(p70:GetDescendants()) do
        v72(descendant);
    end;
end;

local function _killEmittersForRelease(u73) -- Line: 530
    local function _(u74) -- Line: 531
        if u74:IsA("ParticleEmitter") or u74:IsA("Trail") then
            pcall(function() -- Line: 533
                -- upvalues: u74 (copy)
                u74.Enabled = false;
            end);
        end;
    end;

    if u73:IsA("ParticleEmitter") or u73:IsA("Trail") then
        pcall(function() -- Line: 533
            -- upvalues: u73 (copy)
            u73.Enabled = false;
        end);
    end;

    for _, descendant in ipairs(u73:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            pcall(function() -- Line: 533
                -- upvalues: descendant (copy)
                descendant.Enabled = false;
            end);
        end;
    end;
end;

local function _kindFor(p75) -- Line: 543
    return p75:IsA("BasePart") and "Part" or (p75:IsA("Model") and "Model" or (p75:IsA("Folder") and "Model" or (p75:IsA("Attachment") and "Attachment" or (p75:IsA("ParticleEmitter") and "Part" or "Part"))));
end;

local function _computeCloneLifetime(p76) -- Line: 554
    local u77 = 2;

    local function v86(u78) -- Line: 556
        -- upvalues: u77 (ref)
        if not u78:IsA("ParticleEmitter") then
            if u78:IsA("Trail") then
                local v79 = tonumber(u78:GetAttribute("EmitDuration")) or 0;
                local u80 = 2;
                pcall(function() -- Line: 567
                    -- upvalues: u80 (ref), u78 (copy)
                    u80 = math.max(u80, u78.Lifetime);
                end);
                local v81 = v79 + u80 + 0.5;

                if u77 < v81 then
                    u77 = v81;
                end;
            end;

            return;
        end;

        local v82 = tonumber(u78:GetAttribute("EmitDelay")) or 0;
        local v83 = tonumber(u78:GetAttribute("EmitDuration")) or 0;
        local u84 = 2;
        pcall(function() -- Line: 561
            -- upvalues: u84 (ref), u78 (copy)
            u84 = math.max(u84, u78.Lifetime.Max);
        end);
        local v85 = v82 + v83 + u84 + 0.5;

        if u77 < v85 then
            u77 = v85;
        end;
    end;

    v86(p76);

    for _, descendant in ipairs(p76:GetDescendants()) do
        v86(descendant);
    end;

    return u77 > 600 and 600 or u77;
end;

local function _buildEmitClone(u87) -- Line: 591
    -- upvalues: _stampAuthoredEnabled (copy)
    local u88 = nil;

    if u87:IsA("BasePart") then
        u88 = u87:Clone();
        u88.Archivable = false;
    elseif u87:IsA("Model") then
        u88 = u87:Clone();
        u88.Archivable = false;
    elseif u87:IsA("Folder") then
        u88 = Instance.new("Model");
        u88.Archivable = false;
        local v89 = u87:Clone();
        v89.Archivable = false;
        v89.Parent = u88;

        for _, descendant in ipairs(v89:GetDescendants()) do
            if descendant:IsA("BasePart") and not descendant:GetAttribute("_isAnchor") then
                u88.WorldPivot = CFrame.new(descendant.Position);
                break;
            end;
        end;
    elseif u87:IsA("Attachment") then
        u88 = u87:Clone();
    elseif u87:IsA("ParticleEmitter") then
        u88 = Instance.new("Part");
        u88.Anchored = true;
        u88.CanCollide = false;
        u88.CanQuery = false;
        u88.CanTouch = false;
        u88.Massless = true;
        u88.Transparency = 1;
        u88.Size = Vector3.new(0.001, 0.001, 0.001);
        u88.Archivable = false;

        if u87.Parent and u87.Parent:IsA("BasePart") then
            pcall(function() -- Line: 630
                -- upvalues: u88 (copy), u87 (copy)
                u88.Size = u87.Parent.Size;
            end);
        end;

        u87:Clone().Parent = u88;
    end;

    if u88 then
        _stampAuthoredEnabled(u88);
        pcall(function() -- Line: 641
            -- upvalues: u88 (ref)
            u88:SetAttribute("_PartIcleEmit", true);
        end);
    end;

    return u88;
end;

function u1._emitTransformed(p90, p91, u92, u93, u94, p95, p96) -- Line: 650
    -- upvalues: u1 (copy), u6 (copy), u7 (copy)
    local v97 = p95 or u1.newChainCtx();
    local v98 = v97.Depth + 1;

    if (p96 or 4) <= v98 then
        if u93 then
            u93 = u93._eventName;
        end;

        u1.dropDepth(u93);

        return;
    end;

    local v99 = {
        ChainId = v97.ChainId,
        Depth = v98
    };
    local v100 = {
        EventDriven = true,
        ChainCtx = v99
    };

    if u92 == "AtTarget" then
        p90:EnableEmit(p91, nil, v100);

        return;
    end;

    if not u1._supportsOriginOverride(p91) then
        local v101 = tostring(u92) .. ":" .. p91.ClassName;

        if not u6[v101] then
            u6[v101] = true;
            warn(("[Part-Icles Events] transformed %s target requires EmitMode=AtTarget"):format(p91.ClassName));
        end;

        return;
    end;

    local u102 = u1.resolveEmitModeCF(u92, u93, u94);

    if u102 then
        if p90.EnableEmitAt then
            p90:EnableEmitAt(p91, u102, {
                IgnoreLink = true,
                EventDriven = true,
                ChainCtx = v99,

                OriginResolver = function() -- Line: 692, Name: originResolver
                    -- upvalues: u1 (ref), u92 (copy), u93 (copy), u94 (copy), u102 (copy)
                    return u1.resolveEmitModeCF(u92, u93, u94) or u102;
                end,

                UseFullOrigin = u92 == "AtCFrame"
            });

            return;
        end;

        warn("[Part-Icles Events] EnableEmitAt missing on particle; skipped origin-override emit");

        return;
    end;

    local v103 = tostring(u92);

    if u93 then
        u93 = u93._eventName;
    end;

    local v104 = v103 .. ":" .. tostring(u93);

    if not u7[v104] then
        u7[v104] = true;
        warn(("[Part-Icles Events] EmitMode %q has no resolvable origin (payload position nil)"):format((tostring(u92))));
    end;
end;

function u1.emitTargetInstance(u105, u106, p107, p108, p109, u110, p111) -- Line: 714
    -- upvalues: u1 (copy), _kindFor (copy), Pool (copy), _buildEmitClone (copy), _restoreAuthoredEnabled (copy), _anchorClone (copy), _computeCloneLifetime (copy), _killEmittersForRelease (copy)
    if not (u106 and u106.Parent) then
        return;
    end;

    if p107 == nil or (p107 == "AtTarget" or u106:IsA("Trail")) then
        if u106:GetAttribute("Transformed") then
            u1._emitTransformed(u105, u106, p107, p108, p109, u110, p111);

            return;
        end;

        pcall(function() -- Line: 721
            -- upvalues: u105 (copy), u106 (copy), u110 (copy)
            u105:AbsoluteEmit(u106, false, {
                ChainCtx = u110
            });
        end);

        return;
    end;

    if u106:GetAttribute("Transformed") then
        u1._emitTransformed(u105, u106, p107, p108, p109, u110, p111);

        return;
    end;

    local u112 = u1.resolveEmitModeCF(p107, p108, p109);

    if not u112 then
        pcall(function() -- Line: 733
            -- upvalues: u105 (copy), u106 (copy), u110 (copy)
            u105:AbsoluteEmit(u106, false, {
                ChainCtx = u110
            });
        end);

        return;
    end;

    local u113 = _kindFor(u106);
    local u114 = Pool.acquire(u106, u113);
    local v115;

    if u114 then
        v115 = false;
    else
        u114 = _buildEmitClone(u106);

        if not u114 then
            pcall(function() -- Line: 744
                -- upvalues: u105 (copy), u106 (copy), u110 (copy)
                u105:AbsoluteEmit(u106, false, {
                    ChainCtx = u110
                });
            end);

            return;
        end;

        v115 = true;
    end;

    if not v115 then
        _restoreAuthoredEnabled(u114);
        Pool.restoreTrails(u114, u113);
    end;

    if u114:IsA("Attachment") then
        local Folder = u105:GetFolder();
        local _AttachmentHolder = Folder:FindFirstChild("_AttachmentHolder");

        if not _AttachmentHolder then
            _AttachmentHolder = Instance.new("Part");
            _AttachmentHolder.Anchored = true;
            _AttachmentHolder.CanCollide = false;
            _AttachmentHolder.CanQuery = false;
            _AttachmentHolder.CanTouch = false;
            _AttachmentHolder.Massless = true;
            _AttachmentHolder.Transparency = 1;
            _AttachmentHolder.Size = Vector3.new(0.001, 0.001, 0.001);
            _AttachmentHolder.Archivable = false;
            _AttachmentHolder.Name = "_AttachmentHolder";
            _AttachmentHolder.CFrame = CFrame.new();
            _AttachmentHolder.Parent = Folder;
        end;

        u114.Parent = _AttachmentHolder;
        u114.WorldCFrame = u112;
    else
        _anchorClone(u114);
        local v116 = u114;

        if v116:IsA("Model") then
            v116:PivotTo(u112);
        elseif v116:IsA("BasePart") then
            v116.CFrame = u112;
        elseif v116:IsA("Attachment") then
            v116.WorldCFrame = u112;
        end;

        u114.Parent = u105:GetFolder();
        local v117 = u114;

        if v117:IsA("Model") then
            v117:PivotTo(u112);
        elseif v117:IsA("BasePart") then
            v117.CFrame = u112;
        elseif v117:IsA("Attachment") then
            v117.WorldCFrame = u112;
        end;
    end;

    local u118 = {
        SkipClone = true,
        ChainCtx = u110,
        UseFullOrigin = p107 == "AtCFrame",
        IgnoreLink = p107 == "AtPosition" and true or p107 == "AtCFrame"
    };
    pcall(function() -- Line: 786
        -- upvalues: u105 (copy), u114 (ref), u112 (copy), u118 (copy)
        u105:AbsoluteEmitAt(u114, u112, u118);
    end);
    local v119 = _computeCloneLifetime(u114);
    task.delay(v119, function() -- Line: 791
        -- upvalues: u114 (ref), _killEmittersForRelease (ref), Pool (ref), u106 (copy), u113 (copy)
        if not u114.Parent then
            return;
        end;

        _killEmittersForRelease(u114);
        Pool.release(u114, u106, u113, nil);
    end);
end;

function u1.fire(u120, u121, p122, p123, p124) -- Line: 800
    -- upvalues: u1 (copy), EventsPayload (copy)
    local u125 = p123 or u1.newChainCtx();
    local u126 = u121.Events and u121.Events[p122];

    if not (u126 and u126.Enabled) then
        return;
    end;

    local v127 = tonumber(u126.ChainDepthLimit) or 4;
    local math_floor_ret = math.floor(v127);
    local math_clamp_ret = math.clamp(math_floor_ret, 1, 32);

    if math_clamp_ret <= u125.Depth then
        u1.dropDepth(p122);

        return;
    end;

    if not (u126.EmitTarget or u126.Module) then
        return;
    end;

    local u128 = p124 or u1.makePayload(u120, u121, p122, nil);
    u128._eventName = u128._eventName or p122;

    if not u1.reserveFrameFire() then
        return;
    end;

    u128.Source = u128.Source or u121._sourceItem;
    u128.Particle = u128.Particle or u121.VisualPart;
    u128.RenderTemplate = u128.RenderTemplate or u128.Particle;

    if u126.Module then
        function u128.Emit(p129, p130) -- Line: 831
            -- upvalues: u1 (ref), u120 (copy), u126 (copy), u128 (ref), u121 (copy), u125 (ref), math_clamp_ret (copy)
            u1.emitTargetInstance(u120, p129, p130 or u126.EmitMode, u128, u121, u125, math_clamp_ret);
        end;

        function u128.Kill() -- Line: 834
            -- upvalues: u120 (copy), u121 (copy)
            if u120._killParticle then
                u120:_killParticle(u121, {
                    fireOnDeath = false
                });
            end;
        end;

        EventsPayload.attachSkipSetters(u128, u121);

        function u128.SetColor(p131) -- Line: 841
            -- upvalues: EventsPayload (ref), u121 (copy)
            EventsPayload.applyColor(u121, p131);
        end;

        function u128.SetTransparency(p132) -- Line: 842
            -- upvalues: EventsPayload (ref), u121 (copy)
            EventsPayload.applyTransparency(u121, p132);
        end;

        function u128.Teleport(p133) -- Line: 843
            -- upvalues: EventsPayload (ref), u121 (copy)
            EventsPayload.applyTeleport(u121, p133);
        end;

        EventsPayload.attachAdvancedSetters(u128, u121);

        function u128.SetSpeedMultiplier(p134) -- Line: 845
            -- upvalues: u121 (copy)
            if type(p134) == "number" then
                u121.SpeedMultiplier = p134;
            end;
        end;

        function u128.SetLifetime(p135) -- Line: 850
            -- upvalues: u121 (copy)
            if type(p135) == "number" then
                u121.LifeTime = math.max(0.001, p135);
            end;
        end;
    end;

    local v136 = #u120.ActiveEmits + (u120._lingerVisualCount or 0) >= (u120.MAX_ACTIVE_PARTICLES or 1000);

    if v136 and (u126.EmitTarget and not u1._capSkipWarned) then
        u1._capSkipWarned = true;
        warn("[Part-Icles Events] active-particle cap reached; event EmitTargets are being skipped");
    end;

    if u126.EmitTarget and not v136 then
        u1.emitTargetInstance(u120, u126.EmitTarget, u126.EmitMode, u128, u121, u125, math_clamp_ret);
    end;

    local u137 = u126.Module and u1.compile(u126.Module);

    if u137 then
        task.spawn(function() -- Line: 869
            -- upvalues: u137 (copy), u128 (ref), u1 (ref), u126 (copy)
            local v138, v139 = xpcall(u137, debug.traceback, u128);

            if not v138 then
                u1.reportScriptError(u126.Module, v139);
            end;
        end);
    end;
end;

function u1.afterUpdate(p140, p141, p142, p143) -- Line: 884
    -- upvalues: u1 (copy), EventsCollision (copy)
    if not (p141.Events and p141.Events.OnHit) then
        return;
    end;

    if p141._ownsOnHit then
        return;
    end;

    if p141._lastEffectiveDt and p141._lastEffectiveDt < 0 then
        p141.LastHitCheckPos = u1.getWorldPosition(p141);
        p141.LastHitCheckTime = p143;

        return;
    end;

    local WorldPosition = u1.getWorldPosition(p141);

    if not WorldPosition then
        return;
    end;

    if not p141.LastHitCheckPos then
        p141.LastHitCheckPos = WorldPosition;
        p141.LastHitCheckTime = p143;

        return;
    end;

    local v144 = p141.Events.OnHit.HitCheckInterval or 0;

    if v144 > 0 and p143 - (p141.LastHitCheckTime or 0) < v144 then
        return;
    end;

    local LastHitCheckPos = p141.LastHitCheckPos;
    local v145 = p143 - (p141.LastHitCheckTime or p143);
    local v146 = v145 <= 0 and 0.016666666666666666 or v145;
    local v147 = WorldPosition - LastHitCheckPos;

    if v147.Magnitude > 0.05 then
        local v148 = workspace:Raycast(LastHitCheckPos, v147, p141.HitParams);

        if v148 then
            if not p141._hitFired then
                local v149 = u1.makePayload(p140, p141, "OnHit", nil);
                v149.HitInstance = v148.Instance;
                v149.Other = v148.Instance;
                v149.HitPosition = v148.Position;
                v149.HitNormal = v148.Normal;
                u1.fire(p140, p141, "OnHit", p141.EventChainCtx, v149);

                if EventsCollision.handle(p140, p141, v148, v147, v146) == "snap" then
                    return;
                end;
            end;
        elseif not p141._collisionStopped then
            p141._hitFired = false;
        end;

        p141.LastHitCheckPos = WorldPosition;
        p141.LastHitCheckTime = p143;
    end;
end;

return u1;