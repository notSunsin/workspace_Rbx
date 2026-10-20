-- Decompiled with Potassium's decompiler.

local TypeRegistry = require(script.Parent.TypeRegistry);
local u1 = {};
local u2 = { "OnEmit", "OnDeath", "OnDestruction", "OnHit" };
u1.EVENT_NAMES = u2;
u1.EVENTS_FOLDER_NAME = "Events";
local u3 = {
    AtPosition = true,
    AtSource = true,
    AtTarget = true,
    AtCFrame = true
};
u1.EMIT_MODES = u3;
local u4 = {
    Off = true,
    Kill = true,
    Stop = true,
    Bounce = true
};
u1.COLLISION_MODES = u4;

function u1.clampChainDepth(p5) -- Line: 24
    local v6 = tonumber(p5);

    if not v6 then
        return 4;
    end;

    local math_floor_ret = math.floor(v6);

    return math.clamp(math_floor_ret, 1, 32);
end;

function u1.safeEmitMode(p7) -- Line: 30
    -- upvalues: u3 (copy)
    return (type(p7) ~= "string" or not u3[p7]) and "AtPosition" or p7;
end;

function u1.safeCollisionMode(p8) -- Line: 35
    -- upvalues: u4 (copy)
    return (type(p8) ~= "string" or not u4[p8]) and "Off" or p8;
end;

function u1.clampUnit(p9, p10, p11, p12) -- Line: 40
    local v13 = tonumber(p9);

    if not v13 then
        return p12;
    end;

    if v13 < p10 then
        return p10;
    end;

    if p11 < v13 then
        return p11;
    end;

    return v13;
end;

local u14 = {
    Part = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    Beam = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Attachment = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    Model = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    PointLight = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Highlight = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    TrailEmitter = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Atmosphere = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Blur = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Bloom = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    ColorCorrection = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    ImageLabel = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Lightning = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    CameraShake = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    },
    Rocks = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = true
    },
    Rope = {
        OnEmit = true,
        OnDeath = true,
        OnDestruction = true,
        OnHit = false
    }
};
local u15 = {
    Enabled = false,
    EmitMode = "AtPosition",
    ScriptEnabled = false,
    ChainDepthLimit = 4,
    Collision = "Off",
    Bounciness = 0.7,
    Friction = 0.2,
    Spin = 0.5,
    HitCheckInterval = 0,
    CollisionGroup = ""
};

local function getConfig(p16) -- Line: 182
    -- upvalues: TypeRegistry (copy)
    if not p16 then
        return nil;
    end;

    local TypeFor = TypeRegistry.getTypeFor(p16);

    if TypeFor and not TypeFor.directAccess then
        return TypeRegistry.getConfig(p16);
    end;

    return nil;
end;

local function getTypeName(p17) -- Line: 189
    -- upvalues: TypeRegistry (copy)
    local _, v18 = TypeRegistry.getTypeFor(p17);

    return v18;
end;

function u1.read(p19) -- Line: 196
    -- upvalues: TypeRegistry (copy)
    local v20;

    if p19 then
        local TypeFor = TypeRegistry.getTypeFor(p19);

        if TypeFor and not TypeFor.directAccess then
            v20 = TypeRegistry.getConfig(p19);
        else
            v20 = nil;
        end;
    else
        v20 = nil;
    end;

    if not v20 then
        return nil;
    end;

    local Events = v20:FindFirstChild("Events");

    if Events and Events:IsA("Folder") then
        return Events;
    end;

    return nil;
end;

function u1.isValidForItem(p21, p22) -- Line: 207
    -- upvalues: TypeRegistry (copy), u1 (copy)
    local _, v23 = TypeRegistry.getTypeFor(p21);

    if v23 then
        return u1.isValidForTypeName(v23, p22);
    end;

    return false;
end;

function u1.isValidForTypeName(p24, p25) -- Line: 217
    -- upvalues: u14 (copy)
    local v26 = u14[p24];

    return v26 and v26[p25] == true and true or false;
end;

function u1.readEvent(p27, p28) -- Line: 223
    -- upvalues: u1 (copy)
    local v29 = u1.read(p27);

    if not v29 then
        return nil;
    end;

    local v30 = v29:FindFirstChild(p28);

    if v30 and v30:IsA("Configuration") then
        return v30;
    end;

    return nil;
end;

function u1.ensureExcludeListFolder(p31) -- Line: 235
    if not p31 then
        return nil;
    end;

    local ExcludeList = p31:FindFirstChild("ExcludeList");

    if not ExcludeList then
        ExcludeList = Instance.new("Folder");
        ExcludeList.Name = "ExcludeList";
        ExcludeList.Parent = p31;
    end;

    return ExcludeList;
end;

function u1.readEnabled(p32) -- Line: 266
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    local v33 = u1.read(p32);

    if not v33 then
        return nil;
    end;

    local v34 = nil;

    for _, v in ipairs(u2) do
        if u1.isValidForItem(p32, v) then
            local v35 = v33:FindFirstChild(v);

            if v35 and (v35:IsA("Configuration") and (v35:GetAttribute("Enabled") == true and not v35:GetAttribute("ImportedUntrusted"))) then
                local EmitTarget = v35:FindFirstChild("EmitTarget");
                local v36 = v35:GetAttribute("ScriptEnabled") == true;
                local v37;

                if v36 then
                    v37 = v35:FindFirstChild("Module") or nil;
                else
                    v37 = nil;
                end;

                if v37 and not v37:IsA("ModuleScript") then
                    v37 = nil;
                end;

                v34 = v34 or {};
                local v38 = {
                    Enabled = true,
                    EventName = v
                };
                local Attribute = v35:GetAttribute("EmitMode");
                v38.EmitMode = (type(Attribute) ~= "string" or not u3[Attribute]) and "AtPosition" or Attribute;
                v38.ScriptEnabled = v36;
                local Attribute2 = v35:GetAttribute("ChainDepthLimit");
                local v39 = tonumber(Attribute2);
                local v40;

                if v39 then
                    local math_floor_ret = math.floor(v39);
                    v40 = math.clamp(math_floor_ret, 1, 32);
                else
                    v40 = 4;
                end;

                v38.ChainDepthLimit = v40;
                v38.EmitTarget = EmitTarget and (EmitTarget:IsA("ObjectValue") and EmitTarget.Value) or nil;
                v38.Module = v37;
                local Attribute3 = v35:GetAttribute("Collision");
                v38.Collision = (type(Attribute3) ~= "string" or not u4[Attribute3]) and "Off" or Attribute3;
                local Attribute4 = v35:GetAttribute("Bounciness");
                local v41 = tonumber(Attribute4);
                v38.Bounciness = not v41 and 0.7 or (v41 < 0 and 0 or (v41 > 1 and 1 or v41));
                local Attribute5 = v35:GetAttribute("Friction");
                local v42 = tonumber(Attribute5);
                v38.Friction = not v42 and 0.2 or (v42 < 0 and 0 or (v42 > 1 and 1 or v42));
                local Attribute6 = v35:GetAttribute("Spin");
                local v43 = tonumber(Attribute6);
                v38.Spin = not v43 and 0.5 or (v43 < 0 and 0 or (v43 > 2 and 2 or v43));
                local Attribute7 = v35:GetAttribute("HitCheckInterval");
                local v44 = tonumber(Attribute7);
                v38.HitCheckInterval = not v44 and 0 or (v44 < 0 and 0 or (v44 > 0.5 and 0.5 or v44));
                v34[v] = v38;
            end;
        end;
    end;

    return v34;
end;

function u1.ensure(p45) -- Line: 308
    -- upvalues: TypeRegistry (copy)
    local v46;

    if p45 then
        local TypeFor = TypeRegistry.getTypeFor(p45);

        if TypeFor and not TypeFor.directAccess then
            v46 = TypeRegistry.getConfig(p45);
        else
            v46 = nil;
        end;
    else
        v46 = nil;
    end;

    if not v46 then
        return nil;
    end;

    local Events = v46:FindFirstChild("Events");

    if Events and Events:IsA("Folder") then
        return Events;
    end;

    if Events then
        Events:Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "Events";
    Folder.Parent = v46;

    return Folder;
end;

function u1.ensureEvent(p47, p48) -- Line: 324
    -- upvalues: u1 (copy), u15 (copy)
    if not u1.isValidForItem(p47, p48) then
        return nil;
    end;

    local v49 = u1.ensure(p47);

    if not v49 then
        return nil;
    end;

    local v50 = v49:FindFirstChild(p48);

    if v50 and v50:IsA("Configuration") then
        return v50;
    end;

    if v50 then
        v50:Destroy();
    end;

    local Configuration = Instance.new("Configuration");
    Configuration.Name = p48;

    for i, v in pairs(u15) do
        Configuration:SetAttribute(i, v);
    end;

    local ObjectValue = Instance.new("ObjectValue");
    ObjectValue.Name = "EmitTarget";
    ObjectValue.Value = nil;
    ObjectValue.Parent = Configuration;
    local ModuleScript = Instance.new("ModuleScript");
    ModuleScript.Name = "Module";
    ModuleScript.Source = "--[[\n\tPart-Icles event handler.\n\n\tSource emitters supported: Part / Beam / PointLight / Attachment / Model /\n\tHighlight / TrailEmitter / Blur / Bloom / ColorCorrection / Atmosphere /\n\tImageLabel.\n\n\tRaw ParticleEmitters and raw Trails are NOT supported as event SOURCES (they\n\thave no event-binding UI). As event TARGETS they ARE supported: a raw PE\n\ttarget gets wrapped in a holder Part at the emit-position; a raw Trail target\n\temits in-place (the position override is ignored).\n]]\n-- ============================================================================\n--  READ ONLY  (data fields  -  writing has no engine effect)\n-- ============================================================================\n--   Shared (every event scope)\n--     payload.Source                            -- the source emitter Instance\n--     payload.Particle, payload.RenderTemplate  -- the live emitted clone (RenderTemplate is a legacy alias)\n--     payload.WorldCFrame                       -- world-space CFrame (nil for screen types)\n--     payload.WorldPosition                     -- world position (nil for screen types)\n--     payload.StartTime                         -- os.clock() at spawn\n--     payload.LifeTime                          -- configured lifetime in seconds (use SetLifetime to change)\n--     payload.LifeProgress                      -- t in [0, 1] of life elapsed (clamped)\n--     payload.TimeRemaining                     -- seconds until natural death (max(0, LifeTime - elapsed))\n--     payload.SpeedMultiplier                   -- current bounce-attenuated speed scalar (1 by default)\n--     payload.ChainDepth                        -- depth of this event in the cross-emitter chain (0 = root)\n--\n--   OnEmit only\n--     payload.EmitPosition                      -- Vector3 (alias for WorldPosition in OnEmit scope)\n--     payload.EmitIndex                         -- 1-based batch index\n--     payload.EmitCount                         -- batch size when emitted via burst (nil otherwise)\n--\n--   OnHit only\n--     payload.HitPosition                       -- Vector3\n--     payload.HitNormal                         -- Vector3\n--     payload.HitInstance, payload.Other        -- the hit Instance (Other is an alias)\n--\n--   OnDeath only\n--     payload.DeathPosition                     -- Vector3 (alias for WorldPosition in OnDeath scope)\n--     payload.Age                               -- particle age in seconds\n--\n--   OnDestruction only\n--     payload.DeathPosition                     -- Vector3 (alias for WorldPosition in OnDestruction scope)\n--     payload.LingerElapsed                     -- seconds elapsed since linger started\n--\n-- ============================================================================\n--  MUTATORS  (functions  -  call to change the live particle\'s state)\n--             All mutators are available in every event scope.\n-- ============================================================================\n--   Emission control\n--     payload.Emit(target, mode)         -- mode = \"AtPosition\"|\"AtSource\"|\"AtTarget\"|\"AtCFrame\"\n--     payload.Kill()                     -- destroy/disable particle; Animate-mode-aware\n--     payload.Resurrect()                -- undo a Kill (clears _killedManually + _forceDead)\n--\n--   Graph-channel override (auto-skip future graph writes on that channel)\n--     payload.SetColor(color3)\n--     payload.SetTransparency(scalar)\n--     payload.SetSize(size)              -- BasePart.Size (Vector3) / Model ScaleTo / ImageLabel UDim2\n--\n--   Graph-channel skip (manual gate; no value write)\n--     payload.SetSkipColor(bool)\n--     payload.SetSkipTransparency(bool)\n--     payload.SetSkipSize(bool)          -- Part only for now\n--\n--   Lifecycle\n--     payload.SetLifetime(seconds)       -- set NEW total LifeTime; <=0.001 = instant kill next frame\n--     payload.FreezeTime(bool)           -- toggle effective-elapsed advance (true = paused)\n--     payload.Pause(seconds)             -- temporary FreezeTime; auto-clears after duration\n--\n--   Spatial / kinematic\n--     payload.Teleport(cframe)           -- write VisualPart to a new CFrame (Part/Attachment/Model only)\n--     payload.SetVelocity(vec3)          -- replace BaseDirection (unit) + speed override (magnitude)\n--     payload.SetSpeedMultiplier(scalar) -- multiplicative scalar applied per-step\n--     payload.AddSpin(vec3)              -- add angular velocity to pData._spinRate\n--     payload.AddImpulse(vec3)           -- kick pData._accelVel (acceleration-velocity accumulator)\nreturn function(payload)\n\t-- your code here\nend\n";
    ModuleScript.Parent = Configuration;
    Configuration.Parent = v49;

    return Configuration;
end;

function u1.setEnabled(p51, p52, p53) -- Line: 351
    -- upvalues: u1 (copy)
    if p53 then
        local v54 = u1.ensureEvent(p51, p52);

        if not v54 then
            return nil;
        end;

        v54:SetAttribute("Enabled", true);

        return v54;
    end;

    local v55 = u1.readEvent(p51, p52);

    if not v55 then
        return nil;
    end;

    v55:SetAttribute("Enabled", false);

    return v55;
end;

function u1.trustEvent(p56, p57) -- Line: 374
    -- upvalues: u1 (copy)
    local v58 = u1.readEvent(p56, p57);

    if not v58 then
        return false;
    end;

    if not v58:GetAttribute("ImportedUntrusted") then
        return false;
    end;

    v58:SetAttribute("ImportedUntrusted", nil);

    return true;
end;

function u1.trustAllEvents(p59) -- Line: 388
    -- upvalues: u1 (copy)
    local v60 = u1.read(p59);

    if not v60 then
        return false;
    end;

    local v61 = false;

    for _, child in ipairs(v60:GetChildren()) do
        if child:IsA("Configuration") and child:GetAttribute("ImportedUntrusted") then
            child:SetAttribute("ImportedUntrusted", nil);
            v61 = true;
        end;
    end;

    return v61;
end;

function u1.stampImportedUntrusted(p62) -- Line: 410
    -- upvalues: u1 (copy)
    local v63 = u1.read(p62);

    if not v63 then
        return false;
    end;

    local v64 = false;

    for _, child in ipairs(v63:GetChildren()) do
        if child:IsA("Configuration") then
            child:SetAttribute("ImportedUntrusted", true);
            child:SetAttribute("Enabled", false);
            v64 = true;
        end;
    end;

    return v64;
end;

function u1.deleteEvent(p65, p66) -- Line: 427
    -- upvalues: u1 (copy)
    local v67 = u1.readEvent(p65, p66);

    if not v67 then
        return false;
    end;

    v67:Destroy();
    local v68 = u1.read(p65);

    if v68 and #v68:GetChildren() == 0 then
        v68:Destroy();
    end;

    return true;
end;

function u1.sanitize(p69) -- Line: 445
    -- upvalues: u1 (copy), u2 (copy), u15 (copy), u3 (copy), u4 (copy)
    local v70 = u1.read(p69);

    if not v70 then
        return false;
    end;

    local v71 = {};
    local v72 = false;

    for _, v in ipairs(u2) do
        v71[v] = true;
    end;

    for _, child in ipairs(v70:GetChildren()) do
        if child:IsA("Configuration") and v71[child.Name] then
            if u1.isValidForItem(p69, child.Name) then
                local v73 = child;

                for i, v in pairs(u15) do
                    if v73:GetAttribute(i) == nil then
                        v73:SetAttribute(i, v);
                        v72 = true;
                    end;
                end;

                local Attribute = v73:GetAttribute("ChainDepthLimit");
                local v74 = tonumber(Attribute);
                local v75;

                if v74 then
                    local math_floor_ret = math.floor(v74);
                    v75 = math.clamp(math_floor_ret, 1, 32);
                else
                    v75 = 4;
                end;

                if Attribute ~= v75 then
                    v73:SetAttribute("ChainDepthLimit", v75);
                    v72 = true;
                end;

                local Attribute2 = v73:GetAttribute("EmitMode");
                local v76 = (type(Attribute2) ~= "string" or not u3[Attribute2]) and "AtPosition" or Attribute2;

                if Attribute2 ~= v76 then
                    v73:SetAttribute("EmitMode", v76);
                    v72 = true;
                end;

                local Attribute3 = v73:GetAttribute("Collision");
                local v77 = (type(Attribute3) ~= "string" or not u4[Attribute3]) and "Off" or Attribute3;

                if Attribute3 ~= v77 then
                    v73:SetAttribute("Collision", v77);
                    v72 = true;
                end;

                for _, v in ipairs({ {
                        name = "Bounciness",
                        lo = 0,
                        hi = 1,
                        default = 0.7
                    }, {
                        name = "Friction",
                        lo = 0,
                        hi = 1,
                        default = 0.2
                    }, {
                        name = "Spin",
                        lo = 0,
                        hi = 2,
                        default = 0.5
                    }, {
                        name = "HitCheckInterval",
                        lo = 0,
                        hi = 0.5,
                        default = 0
                    } }) do
                    local Attribute4 = v73:GetAttribute(v.name);
                    local lo = v.lo;
                    local hi = v.hi;
                    local default = v.default;
                    local v78 = tonumber(Attribute4);

                    if v78 then
                        if v78 < lo then
                            v78 = lo;
                        elseif hi < v78 then
                            v78 = hi;
                        end;
                    else
                        v78 = default;
                    end;

                    if Attribute4 ~= v78 then
                        v73:SetAttribute(v.name, v78);
                        v72 = true;
                    end;
                end;

                local EmitTarget = v73:FindFirstChild("EmitTarget");

                if not (EmitTarget and EmitTarget:IsA("ObjectValue")) then
                    if EmitTarget then
                        EmitTarget:Destroy();
                    end;

                    local ObjectValue = Instance.new("ObjectValue");
                    ObjectValue.Name = "EmitTarget";
                    ObjectValue.Parent = v73;
                    v72 = true;
                end;

                local Module = v73:FindFirstChild("Module");

                if not (Module and Module:IsA("ModuleScript")) then
                    if Module then
                        Module:Destroy();
                    end;

                    local ModuleScript = Instance.new("ModuleScript");
                    ModuleScript.Name = "Module";
                    ModuleScript.Source = "--[[\n\tPart-Icles event handler.\n\n\tSource emitters supported: Part / Beam / PointLight / Attachment / Model /\n\tHighlight / TrailEmitter / Blur / Bloom / ColorCorrection / Atmosphere /\n\tImageLabel.\n\n\tRaw ParticleEmitters and raw Trails are NOT supported as event SOURCES (they\n\thave no event-binding UI). As event TARGETS they ARE supported: a raw PE\n\ttarget gets wrapped in a holder Part at the emit-position; a raw Trail target\n\temits in-place (the position override is ignored).\n]]\n-- ============================================================================\n--  READ ONLY  (data fields  -  writing has no engine effect)\n-- ============================================================================\n--   Shared (every event scope)\n--     payload.Source                            -- the source emitter Instance\n--     payload.Particle, payload.RenderTemplate  -- the live emitted clone (RenderTemplate is a legacy alias)\n--     payload.WorldCFrame                       -- world-space CFrame (nil for screen types)\n--     payload.WorldPosition                     -- world position (nil for screen types)\n--     payload.StartTime                         -- os.clock() at spawn\n--     payload.LifeTime                          -- configured lifetime in seconds (use SetLifetime to change)\n--     payload.LifeProgress                      -- t in [0, 1] of life elapsed (clamped)\n--     payload.TimeRemaining                     -- seconds until natural death (max(0, LifeTime - elapsed))\n--     payload.SpeedMultiplier                   -- current bounce-attenuated speed scalar (1 by default)\n--     payload.ChainDepth                        -- depth of this event in the cross-emitter chain (0 = root)\n--\n--   OnEmit only\n--     payload.EmitPosition                      -- Vector3 (alias for WorldPosition in OnEmit scope)\n--     payload.EmitIndex                         -- 1-based batch index\n--     payload.EmitCount                         -- batch size when emitted via burst (nil otherwise)\n--\n--   OnHit only\n--     payload.HitPosition                       -- Vector3\n--     payload.HitNormal                         -- Vector3\n--     payload.HitInstance, payload.Other        -- the hit Instance (Other is an alias)\n--\n--   OnDeath only\n--     payload.DeathPosition                     -- Vector3 (alias for WorldPosition in OnDeath scope)\n--     payload.Age                               -- particle age in seconds\n--\n--   OnDestruction only\n--     payload.DeathPosition                     -- Vector3 (alias for WorldPosition in OnDestruction scope)\n--     payload.LingerElapsed                     -- seconds elapsed since linger started\n--\n-- ============================================================================\n--  MUTATORS  (functions  -  call to change the live particle\'s state)\n--             All mutators are available in every event scope.\n-- ============================================================================\n--   Emission control\n--     payload.Emit(target, mode)         -- mode = \"AtPosition\"|\"AtSource\"|\"AtTarget\"|\"AtCFrame\"\n--     payload.Kill()                     -- destroy/disable particle; Animate-mode-aware\n--     payload.Resurrect()                -- undo a Kill (clears _killedManually + _forceDead)\n--\n--   Graph-channel override (auto-skip future graph writes on that channel)\n--     payload.SetColor(color3)\n--     payload.SetTransparency(scalar)\n--     payload.SetSize(size)              -- BasePart.Size (Vector3) / Model ScaleTo / ImageLabel UDim2\n--\n--   Graph-channel skip (manual gate; no value write)\n--     payload.SetSkipColor(bool)\n--     payload.SetSkipTransparency(bool)\n--     payload.SetSkipSize(bool)          -- Part only for now\n--\n--   Lifecycle\n--     payload.SetLifetime(seconds)       -- set NEW total LifeTime; <=0.001 = instant kill next frame\n--     payload.FreezeTime(bool)           -- toggle effective-elapsed advance (true = paused)\n--     payload.Pause(seconds)             -- temporary FreezeTime; auto-clears after duration\n--\n--   Spatial / kinematic\n--     payload.Teleport(cframe)           -- write VisualPart to a new CFrame (Part/Attachment/Model only)\n--     payload.SetVelocity(vec3)          -- replace BaseDirection (unit) + speed override (magnitude)\n--     payload.SetSpeedMultiplier(scalar) -- multiplicative scalar applied per-step\n--     payload.AddSpin(vec3)              -- add angular velocity to pData._spinRate\n--     payload.AddImpulse(vec3)           -- kick pData._accelVel (acceleration-velocity accumulator)\nreturn function(payload)\n\t-- your code here\nend\n";
                    ModuleScript.Parent = v73;
                    v72 = true;
                end;

                for _, child2 in ipairs(v73:GetChildren()) do
                    if child2.Name == "_CompiledEventModule" then
                        child2:Destroy();
                        v72 = true;
                    end;
                end;
            else
                child:Destroy();
                v72 = true;
            end;
        else
            child:Destroy();
            v72 = true;
        end;
    end;

    if #v70:GetChildren() == 0 then
        v70:Destroy();
        v72 = true;
    end;

    return v72;
end;

function u1.snapshot(p79) -- Line: 559
    -- upvalues: u1 (copy), u2 (copy)
    local v80 = u1.read(p79);

    if not v80 then
        return nil;
    end;

    local v81 = nil;

    for _, v in ipairs(u2) do
        local v82 = v80:FindFirstChild(v);

        if v82 and v82:IsA("Configuration") then
            v81 = v81 or {};
            local v83 = {
                Enabled = v82:GetAttribute("Enabled"),
                EmitMode = v82:GetAttribute("EmitMode"),
                ScriptEnabled = v82:GetAttribute("ScriptEnabled"),
                ChainDepthLimit = v82:GetAttribute("ChainDepthLimit"),
                Collision = v82:GetAttribute("Collision"),
                Bounciness = v82:GetAttribute("Bounciness"),
                Friction = v82:GetAttribute("Friction"),
                Spin = v82:GetAttribute("Spin"),
                HitCheckInterval = v82:GetAttribute("HitCheckInterval"),
                ImportedUntrusted = v82:GetAttribute("ImportedUntrusted") == true
            };
            local EmitTarget = v82:FindFirstChild("EmitTarget");

            if EmitTarget and EmitTarget:IsA("ObjectValue") then
                v83.EmitTargetPresent = true;
                v83.EmitTargetValue = EmitTarget.Value;
                v83.EmitTargetPath = EmitTarget.Value and EmitTarget.Value:GetFullName() or nil;
            end;

            local Module = v82:FindFirstChild("Module");

            if Module and Module:IsA("ModuleScript") then
                v83.ModuleSource = Module.Source;
            end;

            v81[v] = v83;
        end;
    end;

    return v81;
end;

function u1.apply(p84, p85) -- Line: 603
    -- upvalues: u1 (copy), u3 (copy), u4 (copy)
    if not p85 then
        return false;
    end;

    local v86 = false;

    for i, v in pairs(p85) do
        if u1.isValidForItem(p84, i) then
            local v87 = u1.ensureEvent(p84, i);

            if v87 then
                if v.Enabled ~= nil then
                    v87:SetAttribute("Enabled", v.Enabled == true);
                end;

                if v.EmitMode ~= nil then
                    local EmitMode = v.EmitMode;
                    v87:SetAttribute("EmitMode", (type(EmitMode) ~= "string" or not u3[EmitMode]) and "AtPosition" or EmitMode);
                end;

                if v.ScriptEnabled ~= nil then
                    v87:SetAttribute("ScriptEnabled", v.ScriptEnabled == true);
                end;

                if v.ChainDepthLimit ~= nil then
                    local v88 = tonumber(v.ChainDepthLimit);
                    local v89;

                    if v88 then
                        local math_floor_ret = math.floor(v88);
                        v89 = math.clamp(math_floor_ret, 1, 32);
                    else
                        v89 = 4;
                    end;

                    v87:SetAttribute("ChainDepthLimit", v89);
                end;

                if v.Collision ~= nil then
                    local Collision = v.Collision;
                    v87:SetAttribute("Collision", (type(Collision) ~= "string" or not u4[Collision]) and "Off" or Collision);
                end;

                if v.Bounciness ~= nil then
                    local v90 = tonumber(v.Bounciness);
                    v87:SetAttribute("Bounciness", not v90 and 0.7 or (v90 < 0 and 0 or (v90 > 1 and 1 or v90)));
                end;

                if v.Friction ~= nil then
                    local v91 = tonumber(v.Friction);
                    v87:SetAttribute("Friction", not v91 and 0.2 or (v91 < 0 and 0 or (v91 > 1 and 1 or v91)));
                end;

                if v.Spin ~= nil then
                    local v92 = tonumber(v.Spin);
                    v87:SetAttribute("Spin", not v92 and 0.5 or (v92 < 0 and 0 or (v92 > 2 and 2 or v92)));
                end;

                if v.HitCheckInterval ~= nil then
                    local v93 = tonumber(v.HitCheckInterval);
                    v87:SetAttribute("HitCheckInterval", not v93 and 0 or (v93 < 0 and 0 or (v93 > 0.5 and 0.5 or v93)));
                end;

                if v.ImportedUntrusted == true then
                    v87:SetAttribute("ImportedUntrusted", true);
                else
                    v87:SetAttribute("ImportedUntrusted", nil);
                end;

                local EmitTarget = v87:FindFirstChild("EmitTarget");

                if EmitTarget and (EmitTarget:IsA("ObjectValue") and v.EmitTargetPresent) then
                    EmitTarget.Value = v.EmitTargetValue;
                end;

                local Module = v87:FindFirstChild("Module");

                if Module and (Module:IsA("ModuleScript") and v.ModuleSource ~= nil) then
                    Module.Source = v.ModuleSource;
                end;

                v86 = true;
            end;
        end;
    end;

    return v86;
end;

return u1;