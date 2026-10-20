-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local script_Particles = require(script.Particles);
local script_PlayHandle = require(script.PlayHandle);
local u1 = {
    Beam = {},
    _focused = true,
    _unfocusedAt = 0
};

if RunService:IsClient() then
    u1._focusConn = UserInputService.WindowFocused:Connect(function() -- Line: 114
        -- upvalues: u1 (copy)
        u1._focused = true;
        u1._unfocusedAt = 0;
    end);
    u1._blurConn = UserInputService.WindowFocusReleased:Connect(function() -- Line: 115
        -- upvalues: u1 (copy)
        u1._focused = false;
        u1._unfocusedAt = os.clock();
    end);
end;

u1.ActiveEmits = {};
u1.ActiveLoops = {};
u1.ActiveAnimates = {};
u1.ActiveChainLoops = {};
u1._evenCycleStore = {};
u1.Connection = nil;
u1._CachedFolder = nil;
u1._engineGen = 0;
u1.MAX_ACTIVE_PARTICLES = 1000;
u1._capWarnLastAt = 0;
u1._lingerVisualCount = 0;
u1._preloadedAssets = setmetatable({}, {
    __mode = "k"
});
require(script.GetData)(u1);
require(script.Transform)(u1);
require(script.Update)(u1);
require(script.UpdateBeam)(u1);
require(script.Timescale)(u1);
require(script.Emit)(u1);
require(script.EmitAnimate)(u1);
require(script.EmitModel)(u1);
require(script.UpdateModel)(u1);
require(script.PointLight)(u1);
require(script.Highlight)(u1);
require(script.Lightning)(u1);
require(script.CameraShake)(u1);
require(script.Rocks)(u1);
require(script.Rope)(u1);
require(script.TrailEmitter)(u1);
require(script.ScreenEmit)(u1);
require(script.ImageEmit)(u1);
require(script.LinkTrack)(u1);
require(script.Orientation)(u1);
require(script.ZOffset)(u1);
require(script.Engine)(u1);
require(script.EngineReplay)(u1);
require(script.PreSimulate)(u1);
require(script.RegisterEmit)(u1);
require(script.Lifecycle)(u1);

function u1._warnIfNotActivated(p2, p3) -- Line: 178
    if p2.Connection then
        return;
    end;

    if p2._notActivatedWarned then
        return;
    end;

    p2._notActivatedWarned = true;
    warn(string.format("[Part-Icles] :%s() called before :Activate()  -  particles will not update until the engine is activated. Call Particle:Activate() once at startup.", p3));
end;

function u1._applyEmitVisualPasses(p4, p5) -- Line: 189
    local Type = p5.Type;

    if Type ~= "Part" and (Type ~= "Model" and Type ~= "Attachment") then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
    end;

    local v6 = p5.Orientation and p5.Orientation ~= "None";
    local v7 = p5.ZOffset and p5.ZOffset ~= 0;

    if v6 or v7 then
        p5._postUpdateCF = Type == "Model" and p5.VisualPart:GetPivot() or p5.VisualPart.CFrame;
    end;

    if v6 then
        p4:ApplyOrientation(p5, 0.016666666666666666, workspace_CurrentCamera);
    end;

    if v7 then
        p4:ApplyZOffset(p5, workspace_CurrentCamera);
    end;
end;

function u1.Emit(p8, u9, p10, p11) -- Line: 210
    -- upvalues: u1 (copy)
    if not (u9 and u9.Parent) then
        return;
    end;

    p8:_warnIfNotActivated("Emit");
    local v12 = p8.MAX_ACTIVE_PARTICLES or 1000;

    if v12 <= #p8.ActiveEmits + (p8._lingerVisualCount or 0) then
        local os_clock_ret = os.clock();

        if os_clock_ret - (p8._capWarnLastAt or 0) >= 1 then
            p8._capWarnLastAt = os_clock_ret;
            warn(("[Part-Icles] active particle cap (%d) reached  -  new emits skipped (user Module code still runs)."):format(v12));
        end;

        return;
    end;

    if u9:IsA("Beam") and u9:FindFirstChild("PartIcleProperties") then
        p8:EmitBeam(u9, p10, p11);

        return;
    end;

    if not (u9:IsA("Beam") or u9:IsA("Trail") and not u9:FindFirstChild("PartIcleProperties")) then
        if u9:IsA("Trail") then
            p8:EmitTrail(u9, p10, p11);

            return;
        end;

        if u9:IsA("PointLight") then
            p8:EmitPointLight(u9, p10, p11);

            return;
        end;

        if u9:IsA("Highlight") then
            p8:EmitHighlight(u9, p10, p11);

            return;
        end;

        if u9:IsA("Attachment") then
            p8:EmitAttachment(u9, p10, p11);

            return;
        end;

        if u9:IsA("Model") then
            p8:EmitModel(u9, p10, p11);

            return;
        end;

        if u9:IsA("BlurEffect") then
            p8:EmitBlur(u9, p10, p11);

            return;
        end;

        if u9:IsA("BloomEffect") then
            p8:EmitBloom(u9, p10, p11);

            return;
        end;

        if u9:IsA("ColorCorrectionEffect") then
            p8:EmitColorCorrection(u9, p10, p11);

            return;
        end;

        if u9:IsA("Atmosphere") then
            p8:EmitAtmosphere(u9, p10, p11);

            return;
        end;

        if u9:IsA("ImageLabel") then
            p8:EmitImageLabel(u9, p10, p11);

            return;
        end;

        if u1._isLightning(u9) then
            p8:EmitLightning(u9, p10, p11);

            return;
        end;

        if u1._isCameraShake(u9) then
            p8:EmitCameraShake(u9, p10, p11);

            return;
        end;

        if u1._isRocks(u9) then
            p8:EmitRocks(u9, p10, p11);

            return;
        end;

        if u1._isRope(u9) then
            p8:EmitRope(u9, p10, p11);

            return;
        end;

        if u9:IsA("BasePart") then
            p8:EmitPart(u9, p10, p11);
        end;

        return;
    end;

    local Attribute = u9:GetAttribute("EmitDuration");
    local u13 = 0;

    if typeof(Attribute) == "number" then
        u13 = Attribute;
    elseif Attribute ~= nil then
        local v14, v15 = tostring(Attribute):match("([%-%.%d]+)%s*,%s*([%-%.%d]+)");
        local v16;

        if v14 and v15 then
            local v17 = tonumber(v14) or 0;
            local v18 = tonumber(v15) or 0;
            u13 = math.max(v17, v18);

            if not u13 then
                v16 = tostring(Attribute);
                u13 = tonumber(v16) or 0;
            end;
        else
            v16 = tostring(Attribute);
            u13 = tonumber(v16) or 0;
        end;
    end;

    if u13 > 0 then
        task.delay(u9:GetAttribute("EmitDelay") or 0, function() -- Line: 242
            -- upvalues: u9 (copy), u13 (ref)
            if not (u9 and u9.Parent) then
                return;
            end;

            u9.Enabled = true;
            task.delay(u13, function() -- Line: 245
                -- upvalues: u9 (ref)
                if u9 and u9.Parent then
                    u9.Enabled = false;
                end;
            end);
        end);
    end;
end;

local script_Duration = require(script.Duration);

function u1.await(p19) -- Line: 296
    if p19 == nil then
        return;
    end;

    if type(p19) ~= "number" then
        return;
    end;

    if p19 <= 0 then
        return;
    end;

    task.wait(p19);
end;

function u1._absoluteEmitFire(p20, u21, p22, p23) -- Line: 306
    -- upvalues: script_Particles (copy)
    if u21:GetAttribute("Transformed") then
        p20:EnableEmit(u21, nil, p23);

        return;
    end;

    local u24 = p20:_makeAliveCheck();

    if not u21:IsA("ParticleEmitter") then
        if u21:IsA("Trail") then
            if p22 then
                return;
            end;

            script_Particles.EnableEmitSingle(u21, u24);

            return;
        end;

        if u21:IsA("Beam") then
            if p22 then
                return;
            end;

            local u25 = tonumber(u21:GetAttribute("EmitDuration")) or 0;
            local v26 = tonumber(u21:GetAttribute("EmitDelay")) or 0;

            if u25 > 0 then
                local u27 = script_Particles.ReadNativeGen(u21);

                local function doEmit() -- Line: 357
                    -- upvalues: u24 (copy), script_Particles (ref), u21 (copy), u27 (copy), u25 (copy)
                    if not (u24() and script_Particles.IsNativeGenCurrent(u21, u27)) then
                        return;
                    end;

                    script_Particles.SetEnabledForDuration(u21, u25);
                end;

                if v26 > 0 then
                    task.delay(v26, doEmit);

                    return;
                end;

                if u24() then
                    if not script_Particles.IsNativeGenCurrent(u21, u27) then
                        return;
                    end;

                    script_Particles.SetEnabledForDuration(u21, u25);
                end;
            end;

            return;
        end;

        local v28;

        if u21:IsA("BasePart") or u21:IsA("Attachment") then
            v28 = not p22;
        else
            v28 = u21:IsA("Model") and not p22;
        end;

        if v28 then
            script_Particles.EnableEmit(u21, u24);
        end;

        local v29 = v28 or p22;

        for _, child in u21:GetChildren() do
            if not (u21:IsA("BasePart") and (child:IsA("BasePart") and not child:GetAttribute("Transformed"))) then
                p20:_absoluteEmitFire(child, v29, p23);
            end;
        end;

        return;
    end;

    if p22 then
        return;
    end;

    local u30 = tonumber(u21:GetAttribute("EmitCount")) or 1;
    local v31 = tonumber(u21:GetAttribute("EmitDelay")) or 0;
    local u32 = tonumber(u21:GetAttribute("EmitDuration")) or 0;

    if u30 <= 0 and u32 <= 0 then
        return;
    end;

    local u33 = script_Particles.ReadNativeGen(u21);

    local function v34() -- Line: 329
        -- upvalues: u24 (copy), script_Particles (ref), u21 (copy), u33 (copy), u30 (copy), u32 (copy)
        if not (u24() and script_Particles.IsNativeGenCurrent(u21, u33)) then
            return;
        end;

        if u30 > 0 then
            u21:Emit(u30);
        end;

        if u32 > 0 then
            script_Particles.SetEnabledForDuration(u21, u32);
        end;
    end;

    if v31 > 0 then
        task.delay(v31, v34);

        return;
    end;

    v34();
end;

function u1.AbsoluteEmit(p35, p36, p37, p38) -- Line: 396
    -- upvalues: script_Duration (copy)
    p35:_warnIfNotActivated("AbsoluteEmit");

    if not p36 then
        return 0;
    end;

    p35:_absoluteEmitFire(p36, p37, p38);

    return script_Duration.computeMaxDuration(p36, 0);
end;

function u1.AbsoluteEmitAt(u39, u40, u41, p42) -- Line: 441
    -- upvalues: script_Duration (copy), script_PlayHandle (copy), script_Particles (copy)
    u39:_warnIfNotActivated("AbsoluteEmitAt");

    if not (u40 and u41) then
        return nil, 0;
    end;

    local u43 = p42 or {};
    local v44 = script_Duration.computeMaxDuration(u40, 0);
    local u45 = {
        Alive = true,
        Loops = {},
        Clones = {},
        Duration = v44
    };
    local v46 = script_PlayHandle.new(u39, u45);
    local u47;

    if u43.LinkOverride == true then
        u47 = u43.Link ~= nil;
    else
        u47 = false;
    end;

    if u40:GetAttribute("Transformed") then
        if u43.Link ~= nil then
            u39:SetLink(u40, u43.Link, u43.LinkMode or "Weld");
        end;

        if u43.EmitParent ~= nil then
            u39:SetEmitParent(u40, u43.EmitParent);
        end;

        local v48 = {
            ChainCtx = u43.ChainCtx,
            UseFullOrigin = u43.UseFullOrigin ~= false,
            IgnoreLink = u43.IgnoreLink == true,
            _playToken = u45
        };

        if not u47 then
            v48.EventOriginCF = u41;
            v48.EventOriginResolver = u43.OriginResolver;
        end;

        u39:EnableEmit(u40, nil, v48);

        return v46, v44;
    end;

    if not (u40:IsA("BasePart") or (u40:IsA("Model") or u40:IsA("Attachment"))) then
        return nil, 0;
    end;

    local v49 = nil;
    local u50;

    if u40:IsA("Model") then
        local v51;
        v51, u50 = pcall(u40.GetPivot, u40);

        if not v51 then
            u50 = v49;
        end;
    elseif u40:IsA("BasePart") then
        u50 = u40.CFrame;
    elseif u40:IsA("Attachment") then
        u50 = u40.WorldCFrame;
    else
        u50 = v49;
    end;

    local function readWorldCF(p52) -- Line: 493
        if p52:IsA("Model") then
            local success, result = pcall(p52.GetPivot, p52);

            return success and result and result or nil;
        end;

        if p52:IsA("Attachment") then
            return p52.WorldCFrame;
        end;

        if p52:IsA("BasePart") then
            return p52.CFrame;
        end;

        return nil;
    end;

    local function originFor(p53) -- Line: 500
        -- upvalues: u50 (ref), u41 (copy), readWorldCF (copy)
        if not u50 then
            return u41;
        end;

        local v54 = readWorldCF(p53);

        if v54 then
            return u41 * u50:ToObjectSpace(v54);
        end;

        return u41;
    end;

    local function ctxFor(p55) -- Line: 507
        -- upvalues: u43 (ref), u45 (copy), u47 (copy), u50 (ref), u41 (copy), readWorldCF (copy)
        local v56 = {
            ChainCtx = u43.ChainCtx,
            UseFullOrigin = u43.UseFullOrigin ~= false,
            IgnoreLink = u43.IgnoreLink == true,
            _playToken = u45
        };

        if not u47 then
            local v57;

            if u50 then
                local v58 = readWorldCF(p55);

                if v58 then
                    v57 = u41 * u50:ToObjectSpace(v58);
                else
                    v57 = u41;
                end;
            else
                v57 = u41;
            end;

            v56.EventOriginCF = v57;
            v56.EventOriginResolver = u43.OriginResolver;
        end;

        return v56;
    end;

    if (u43.ApplyToAll or u47) and (u43.Link ~= nil or u43.EmitParent ~= nil) then
        local function applyAuthoring(p59) -- Line: 525
            -- upvalues: u43 (ref), u39 (copy), applyAuthoring (copy)
            if p59:GetAttribute("Transformed") then
                if u43.Link ~= nil then
                    u39:SetLink(p59, u43.Link, u43.LinkMode or "Weld");
                end;

                if u43.EmitParent ~= nil then
                    u39:SetEmitParent(p59, u43.EmitParent);
                end;
            end;

            for _, child in p59:GetChildren() do
                applyAuthoring(child);
            end;
        end;

        applyAuthoring(u40);
    end;

    local function walkTransformed(p60) -- Line: 542
        -- upvalues: u39 (copy), ctxFor (copy), walkTransformed (copy)
        if p60:GetAttribute("Transformed") then
            u39:EnableEmit(p60, nil, (ctxFor(p60)));

            return;
        end;

        for _, child in p60:GetChildren() do
            walkTransformed(child);
        end;
    end;

    walkTransformed(u40);

    if u43.SkipClone then
        script_Particles.EnableEmit(u40, u39:_makeAliveCheck());

        return v46, v44;
    end;

    local function _underTransformedAncestor(p61) -- Line: 565
        -- upvalues: u40 (copy)
        local Parent = p61.Parent;

        while Parent and Parent ~= u40 do
            if Parent:GetAttribute("Transformed") then
                return true;
            end;

            Parent = Parent.Parent;
        end;

        return false;
    end;

    local v62 = false;

    for _, descendant in ipairs(u40:GetDescendants()) do
        if (descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam"))) and not (descendant:GetAttribute("Transformed") or _underTransformedAncestor(descendant)) then
            v62 = true;
            break;
        end;
    end;

    if not v62 then
        return v46, v44;
    end;

    local success, result = pcall(u40.Clone, u40);

    if not (success and result) then
        return v46, v44;
    end;

    pcall(function() -- Line: 585
        -- upvalues: result (copy)
        result.Archivable = false;
    end);

    for _, descendant in ipairs(result:GetDescendants()) do
        if descendant:GetAttribute("Transformed") then
            pcall(function() -- Line: 591
                -- upvalues: descendant (copy)
                descendant:Destroy();
            end);
        end;
    end;

    if result:IsA("BasePart") then
        pcall(function() -- Line: 595
            -- upvalues: result (copy)
            result.Anchored = true;
        end);
    end;

    for _, descendant in ipairs(result:GetDescendants()) do
        if descendant:IsA("BasePart") then
            pcall(function() -- Line: 597
                -- upvalues: descendant (copy)
                descendant.Anchored = true;
            end);
        end;
    end;

    if u43.UseFullOrigin == false and u50 then
        u41 = CFrame.new(u41.Position) * u50.Rotation;
    end;

    if result:IsA("Model") then
        pcall(function() -- Line: 607
            -- upvalues: result (copy), u41 (ref)
            result:PivotTo(u41);
        end);
    elseif result:IsA("BasePart") then
        pcall(function() -- Line: 609
            -- upvalues: result (copy), u41 (ref)
            result.CFrame = u41;
        end);
    elseif result:IsA("Attachment") then
        pcall(function() -- Line: 611
            -- upvalues: result (copy)
            result:Destroy();
        end);

        return v46, v44;
    end;

    result.Parent = u39:GetFolder();
    table.insert(u45.Clones, result);
    u39:_absoluteEmitFire(result, nil, nil);
    task.delay(v44 or 60, function() -- Line: 625
        -- upvalues: result (copy)
        if result and result.Parent then
            pcall(function() -- Line: 626
                -- upvalues: result (ref)
                result:Destroy();
            end);
        end;
    end);

    return v46, v44;
end;

local script_TexturePin = require(script.TexturePin);

local function _isPreloadable(p63) -- Line: 646
    return p63:GetAttribute("Transformed") or (p63:IsA("ParticleEmitter") or p63:IsA("Trail"));
end;

local function _walk(p64, u65, u66) -- Line: 647
    if not p64 then
        return;
    end;

    local function visit(p67) -- Line: 649
        -- upvalues: u65 (copy), u66 (copy), visit (copy)
        if (p67:GetAttribute("Transformed") or (p67:IsA("ParticleEmitter") or p67:IsA("Trail"))) and (u65 or p67:GetAttribute("PreloadTexture") == true) then
            u66(p67);
        end;

        for _, child in p67:GetChildren() do
            visit(child);
        end;
    end;

    visit(p64);
end;

function u1.Preload(p68, p69, u70) -- Line: 658
    -- upvalues: script_TexturePin (copy)
    local pinSubtree = script_TexturePin.pinSubtree;

    if not p69 then
        return;
    end;

    local function u72(p71) -- Line: 649
        -- upvalues: u70 (copy), pinSubtree (copy), u72 (copy)
        if (p71:GetAttribute("Transformed") or (p71:IsA("ParticleEmitter") or p71:IsA("Trail"))) and (u70 or p71:GetAttribute("PreloadTexture") == true) then
            pinSubtree(p71);
        end;

        for _, child in p71:GetChildren() do
            u72(child);
        end;
    end;

    u72(p69);
end;

function u1.Deload(p73, p74, u75) -- Line: 660
    -- upvalues: script_TexturePin (copy)
    local unpinSubtree = script_TexturePin.unpinSubtree;

    if not p74 then
        return;
    end;

    local function u77(p76) -- Line: 649
        -- upvalues: u75 (copy), unpinSubtree (copy), u77 (copy)
        if (p76:GetAttribute("Transformed") or (p76:IsA("ParticleEmitter") or p76:IsA("Trail"))) and (u75 or p76:GetAttribute("PreloadTexture") == true) then
            unpinSubtree(p76);
        end;

        for _, child in p76:GetChildren() do
            u77(child);
        end;
    end;

    u77(p74);
end;

u1.LinkService = require(script.LinkService);

function u1.SetLink(p78, u79, p80, u81) -- Line: 673
    if not (u79 and u79:GetAttribute("Transformed")) then
        return;
    end;

    if p80 == "camera" then
        pcall(function() -- Line: 676
            -- upvalues: u79 (copy)
            u79:SetAttribute("LinkSource", "Camera");
        end);
    elseif p80 == nil then
        pcall(function() -- Line: 678
            -- upvalues: u79 (copy)
            u79:SetAttribute("LinkSource", "None");
        end);
        local Link = u79:FindFirstChild("Link");

        if Link and Link:IsA("ObjectValue") then
            Link.Value = nil;
        end;
    elseif typeof(p80) == "Instance" then
        local Link = u79:FindFirstChild("Link");

        if not Link then
            Link = Instance.new("ObjectValue");
            Link.Name = "Link";
            Link.Parent = u79;
        end;

        Link.Value = p80;
        pcall(function() -- Line: 689
            -- upvalues: u79 (copy)
            u79:SetAttribute("LinkSource", "Object");
        end);
    end;

    if u81 then
        pcall(function() -- Line: 691
            -- upvalues: u79 (copy), u81 (copy)
            u79:SetAttribute("LinkMode", u81);
        end);
    end;
end;

function u1.SetEmitParent(p82, p83, p84) -- Line: 696
    if not (p83 and p83:GetAttribute("Transformed")) then
        return;
    end;

    if p84 == nil then
        local EmitParent = p83:FindFirstChild("EmitParent");

        if EmitParent then
            pcall(function() -- Line: 700
                -- upvalues: EmitParent (copy)
                EmitParent:Destroy();
            end);
        end;

        return;
    end;

    if typeof(p84) ~= "Instance" then
        return;
    end;

    local EmitParent = p83:FindFirstChild("EmitParent");

    if not EmitParent then
        EmitParent = Instance.new("ObjectValue");
        EmitParent.Name = "EmitParent";
        EmitParent.Parent = p83;
    end;

    EmitParent.Value = p84;
end;

return u1;