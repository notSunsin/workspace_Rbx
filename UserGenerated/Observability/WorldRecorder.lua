-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Copies = require(ReplicatedStorage.UserGenerated.Observability.Copies);
local Motion = require(ReplicatedStorage.UserGenerated.Observability.Motion);
require(ReplicatedStorage.UserGenerated.Observability.Registry);
local Sequences = require(ReplicatedStorage.UserGenerated.Observability.Sequences);
local Op = Observability.Op;
local ValueType = Observability.ValueType;
local RootId = Observability.RootId;
local AssemblyRootProperty = Observability.AssemblyRootProperty;
local SurfaceIdProperty = Observability.SurfaceIdProperty;
local SurfaceIdAttribute = Observability.SurfaceIdAttribute;
local BakedTag = Observability.BakedTag;
local BakedIdAttribute = Observability.BakedIdAttribute;
local BakedOriginAttribute = Observability.BakedOriginAttribute;
local UnbakedTag = Observability.UnbakedTag;
local UnbakedAttribute = Observability.UnbakedAttribute;
local BakeIdProperty = Observability.BakeIdProperty;
local PivotProperty = Observability.PivotProperty;
local EmissionScaleProperty = Observability.EmissionScaleProperty;
local _, v1 = xpcall(function() -- Line: 126
    return workspace[nil];
end, function() -- Line: 128
    return debug.info(2, "f");
end);
local u4 = type(v1) ~= "function" and function(p2, p3) -- Line: 132
    return p2[p3];
end or v1;
local u5 = {
    Color = true,
    MeshId = true,
    TextureID = true
};
local u6 = {
    [ValueType.Float32] = true,
    [ValueType.Vector3] = true,
    [ValueType.Color3] = true,
    [ValueType.CFrame] = true
};
local u7 = {
    CFrame = true,
    Position = true,
    Orientation = true,
    Rotation = true
};
local u8 = { "Part0", "Part1", "C0", "C1", "Enabled" };
local u9 = {
    RigidConstraint = true,
    AnimationConstraint = true
};
local u10 = {
    Beam = true,
    Shirt = true,
    Pants = true,
    SpecialMesh = true,
    BlockMesh = true,
    CylinderMesh = true,
    FileMesh = true,
    Decal = true,
    Texture = true,
    SurfaceAppearance = true
};
local u11 = {
    Color = true,
    Transparency = true,
    LocalTransparencyModifier = true
};
local u12 = {
    [Enum.CameraType.Scriptable] = true,
    [Enum.CameraType.Fixed] = true,
    [Enum.CameraType.Watch] = true
};
local u13 = Enum.RenderPriority.Camera.Value + 1;
local u14 = {
    CFrame = true,
    Position = true,
    Orientation = true,
    Axis = true,
    SecondaryAxis = true
};

local function sequenceKey(p15: number, p16: number, p17: any) -- Line: 266
    -- upvalues: Sequences (copy)
    return `{p15}:{Sequences.key(Sequences.keypoints(p16, p17))}`;
end;

local function writeEncoded(p18: any, p19: string) -- Line: 271
    local v20 = #p19;
    p18:_ensure(v20);
    buffer.writestring(p18.buf, p18.len, p19);
    p18.len = p18.len + v20;
end;

local function predicts(p21: table, p22: number, p23) -- Line: 278
    -- upvalues: Motion (copy)
    if p22 < p21.T then
        return false;
    end;

    local v24 = Motion.at(p21.Base, p21.W, p21.V, p21.A, (p22 - p21.T) / 1000);

    return not Motion.apart(v24, p23, 0.2, 0.02);
end;

local function newPollQueue() -- Line: 289
    return {
        Cursor = 1,
        Set = setmetatable({}, {
            __mode = "k"
        }),
        List = {}
    };
end;

local function newWatch() -- Line: 304
    return {
        Connections = {},
        Kids = {},
        Names = {}
    };
end;

local function cframeMoved(p25, p26) -- Line: 311
    if (p25.Position - p26.Position).Magnitude > 0.02 then
        return true;
    end;

    local XVector = p25.XVector;
    local XVector2 = p26.XVector;
    local YVector = p25.YVector;
    local YVector2 = p26.YVector;

    return (math.abs(XVector.X - XVector2.X) > 0.003 or (math.abs(XVector.Y - XVector2.Y) > 0.003 or (math.abs(XVector.Z - XVector2.Z) > 0.003 or (math.abs(YVector.X - YVector2.X) > 0.003 or math.abs(YVector.Y - YVector2.Y) > 0.003)))) and true or math.abs(YVector.Z - YVector2.Z) > 0.003;
end;

local function rotationMoved(p27, p28) -- Line: 325
    -- upvalues: cframeMoved (copy)
    return cframeMoved(p27.Rotation, p28.Rotation);
end;

local function subjectPart(p29: userdata?) -- Line: 330
    if not p29 then
        return nil;
    end;

    if p29:IsA("Humanoid") then
        return p29.RootPart;
    end;

    if p29:IsA("BasePart") then
        return p29;
    end;

    if p29:IsA("Model") then
        return p29.PrimaryPart;
    end;

    return nil;
end;

local function isWorldGui(p30: userdata) -- Line: 346
    return p30:IsA("BillboardGui") or p30:IsA("SurfaceGui");
end;

local function inPlayerCharacter(p31: userdata) -- Line: 350
    -- upvalues: Players (copy)
    local Parent = p31.Parent;

    while Parent and Parent ~= workspace do
        if Parent:IsA("Model") and Players:GetPlayerFromCharacter(Parent) then
            return true;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

local function hasLocalTransparency(p32: userdata) -- Line: 361
    return p32:IsA("BasePart") or p32:IsA("Decal");
end;

local function particleHost(p33: userdata) -- Line: 367
    local Parent = p33.Parent;

    while Parent and Parent:IsA("Attachment") do
        Parent = Parent.Parent;
    end;

    if Parent and (Parent:IsA("BasePart") and not Parent:IsA("Terrain")) then
        return Parent;
    end;

    return nil;
end;

local function bakedId(p34: userdata) -- Line: 375
    -- upvalues: CollectionService (copy), BakedTag (copy), BakedIdAttribute (copy)
    if not ((p34:IsA("Model") or (p34:IsA("Folder") or p34:IsA("Configuration"))) and CollectionService:HasTag(p34, BakedTag)) then
        return nil;
    end;

    local Attribute = p34:GetAttribute(BakedIdAttribute);

    if type(Attribute) == "string" and Attribute ~= "" then
        return Attribute;
    end;

    return nil;
end;

local function bakedPivot(p35: userdata) -- Line: 384
    -- upvalues: BakedOriginAttribute (copy)
    local Attribute = p35:GetAttribute(BakedOriginAttribute);
    local Pivot = p35:GetPivot();

    if typeof(Attribute) == "CFrame" then
        return Pivot * Attribute:Inverse();
    end;

    return Pivot;
end;

local function seedKind(p36: userdata) -- Line: 391
    -- upvalues: u9 (copy), u10 (copy), bakedId (copy)
    if p36:IsA("BasePart") then
        return not p36:IsA("Terrain") and "part" or nil;
    end;

    if p36:IsA("Bone") then
        return "visual";
    end;

    local ClassName = p36.ClassName;

    return (p36:IsA("JointInstance") or (p36:IsA("WeldConstraint") or u9[ClassName])) and "joint" or (u10[ClassName] and "visual" or ((p36:IsA("BillboardGui") or p36:IsA("SurfaceGui")) and "gui" or (bakedId(p36) and "baked" or nil)));
end;

local u37 = {};
u37.__index = u37;

function u37.new(p38: any, p39: function, p40: function, p41: number, p42: boolean?) -- Line: 421
    -- upvalues: newPollQueue (copy), Codec (copy), u37 (copy), u11 (copy), RunService (copy), u13 (copy)
    local v43 = p38:FilterRoot(workspace);
    local v44 = {
        Registry = p38,
        Stream = p38.Stream,
        Clock = p38.Clock,
        TrackGui = p39,
        WatchAnimator = p40,
        MaxInstances = p41,
        BakeModels = p42 == true,
        Filtered = v43 ~= nil
    };
    local v45;

    if v43 == nil then
        v45 = false;
    else
        v45 = v43.Include;
    end;

    v44.Scoped = v45;
    v44.Count = 0;
    v44.Watches = {};
    v44.CharacterScopes = {};
    v44.PinSignals = {};
    v44.Ids = p38.Ids;
    v44.Kinds = setmetatable({}, {
        __mode = "k"
    });
    v44.Signals = setmetatable({}, {
        __mode = "k"
    });
    v44.AttachSignals = setmetatable({}, {
        __mode = "k"
    });
    v44.Kids = setmetatable({}, {
        __mode = "k"
    });
    v44.Roots = setmetatable({}, {
        __mode = "k"
    });
    v44.RootOf = setmetatable({}, {
        __mode = "k"
    });
    v44.JointParts = setmetatable({}, {
        __mode = "k"
    });
    v44.TerrainDriven = setmetatable({}, {
        __mode = "k"
    });
    v44.Held = setmetatable({}, {
        __mode = "k"
    });
    v44.InCharacter = setmetatable({}, {
        __mode = "k"
    });
    v44.Baked = setmetatable({}, {
        __mode = "k"
    });
    v44.BakedMemo = {};
    v44.Unbaked = {};
    v44.Particles = {};
    v44.ParticleHosts = {};
    v44.EmissionScale = nil;
    v44.EmissionScaleDirty = false;
    v44.LastCFrame = setmetatable({}, {
        __mode = "k"
    });
    v44.LastSent = setmetatable({}, {
        __mode = "k"
    });
    v44.SentCFrames = setmetatable({}, {
        __mode = "k"
    });
    v44.Motions = setmetatable({}, {
        __mode = "k"
    });
    v44.Samples = setmetatable({}, {
        __mode = "k"
    });
    v44.Candidates = setmetatable({}, {
        __mode = "k"
    });
    v44.Untrusted = setmetatable({}, {
        __mode = "k"
    });
    v44.Sampled = {};
    v44.WorldPoll = newPollQueue();
    v44.PlayerPolls = {};
    v44.PolledBy = setmetatable({}, {
        __mode = "k"
    });
    v44.SeqStates = setmetatable({}, {
        __mode = "k"
    });
    v44.SeqHolders = setmetatable({}, {
        __mode = "v"
    });
    v44.Groups = nil;
    v44.GroupOrder = {};
    v44.GroupedProps = {};
    v44.ValueScratch = Codec.newWriter(256);
    v44.Pending = {};
    v44.DirtyStructure = {};
    v44.DirtyName = {};
    v44.DirtyProps = {};
    v44.RootCheck = {};
    v44.AnchorCheck = {};
    v44.CameraSample = nil;
    v44.LastCamera = nil;
    v44.LastFov = 0;
    v44.Follow = nil;
    v44.LastCameraTime = (-1 / 0);
    v44.Connections = {};
    v44.Destroyed = false;
    local u46 = setmetatable(v44, u37);
    u46.ByName = p38.ClassPropsByName;

    for _, v in p38.ClassProps do
        for _, v2 in v do
            if u11[v2.Name] then
                u46.GroupedProps[v2.Id] = true;
            end;
        end;
    end;

    p38:AddResolver(function(p47: userdata, p48: number?) -- Line: 541
        -- upvalues: u46 (copy)
        return u46:_track(p47, p48);
    end);
    RunService:BindToRenderStep("UGReplayCameraSample", u13, function() -- Line: 544
        -- upvalues: u46 (copy)
        u46.CameraSample = u46:_sampleCamera();
    end);

    return u46;
end;

function u37._propId(p49: table, p50: string, p51: string) -- Line: 550
    local v52 = p49.ByName[p50];

    if v52 then
        v52 = v52[p51];
    end;

    return v52;
end;

function u37._kidsOf(p53: table, p54: userdata) -- Line: 555
    local v55 = p53.Kids[p54];

    if not v55 then
        v55 = setmetatable({}, {
            __mode = "k"
        });
        p53.Kids[p54] = v55;
    end;

    return v55;
end;

function u37._markProp(p56: table, p57: userdata, p58: number) -- Line: 564
    local v59 = p56.DirtyProps[p57];

    if not v59 then
        v59 = {};
        p56.DirtyProps[p57] = v59;
    end;

    v59[p58] = p56.Clock();
end;

function u37._isRecordedRoot(p60: table, p61: userdata, p62: userdata?) -- Line: 574
    local v63;

    if p62 == p61 then
        v63 = true;
    elseif p60.TerrainDriven[p61] == nil or p62 == nil then
        v63 = false;
    else
        v63 = p62:IsA("Terrain");
    end;

    return v63;
end;

local function terrainDrivenPart(p64: userdata, p65: userdata?, p66: userdata?) -- Line: 579
    if not p64:IsA("Motor6D") then
        return nil;
    end;

    if p65 and p65:IsA("Terrain") then
        if p66 and not p66:IsA("Terrain") then
            return p66;
        end;

        return nil;
    end;

    if p66 and p66:IsA("Terrain") then
        return p65;
    end;

    return nil;
end;

function u37._setJointParts(p67: table, p68: userdata, p69: userdata?, p70: userdata?) -- Line: 592
    -- upvalues: terrainDrivenPart (copy)
    local v71 = p67.JointParts[p68];
    local TerrainDriven = p67.TerrainDriven;

    if v71 then
        v71 = terrainDrivenPart(p68, v71[1], v71[2]);
    end;

    if v71 then
        local v72 = (TerrainDriven[v71] or 1) - 1;

        if v72 <= 0 then
            v72 = nil;
        end;

        TerrainDriven[v71] = v72;
    end;

    local v73 = terrainDrivenPart(p68, p69, p70);

    if v73 then
        TerrainDriven[v73] = (TerrainDriven[v73] or 0) + 1;
    end;

    p67.JointParts[p68] = { p69, p70 };
end;

local function attachmentOf(p74: userdata, p75: string) -- Line: 607
    -- upvalues: u4 (ref)
    local v76 = u4(p74, p75);

    if v76 and v76:IsA("Attachment") then
        return v76;
    end;

    return nil;
end;

local function attachmentEnd(p77: userdata?) -- Line: 613
    -- upvalues: u4 (ref)
    local v78;

    if p77 then
        v78 = u4(p77, "Parent");
    else
        v78 = p77;
    end;

    if p77 and (v78 and v78:IsA("BasePart")) then
        return v78, u4(p77, "CFrame");
    end;

    return nil, CFrame.identity;
end;

local function readAttachmentJoint(p79: userdata, p80: string) -- Line: 622
    -- upvalues: u4 (ref)
    if p80 == "Enabled" then
        local v81 = u4(p79, "Enabled") and (not p79:IsA("AnimationConstraint") or u4(p79, "IsKinematic"));

        return true, v81;
    end;

    local v82 = u4(p79, (p80 == "Part0" or p80 == "C0") and "Attachment0" or "Attachment1");

    if not (v82 and v82:IsA("Attachment")) then
        v82 = nil;
    end;

    local v83;

    if v82 then
        v83 = u4(v82, "Parent");
    else
        v83 = v82;
    end;

    local v84;

    if v82 and (v83 and v83:IsA("BasePart")) then
        v84 = u4(v82, "CFrame");
    else
        v84 = CFrame.identity;
        v83 = nil;
    end;

    local v85 = true;

    if p80 == "Part0" or p80 == "Part1" then
        return v85, v83;
    end;

    return v85, v84;
end;

function u37._jointEnds(p86: table, p87: userdata) -- Line: 631
    -- upvalues: u4 (ref)
    if p86.Kinds[p87] ~= "constraint" then
        return u4(p87, "Part0"), u4(p87, "Part1");
    end;

    local v88 = u4(p87, "Attachment0");

    if not (v88 and v88:IsA("Attachment")) then
        v88 = nil;
    end;

    local v89;

    if v88 then
        v89 = u4(v88, "Parent");
    else
        v89 = v88;
    end;

    if v88 and (v89 and v89:IsA("BasePart")) then
        u4(v88, "CFrame");
    else
        local _ = CFrame.identity;
        v89 = nil;
    end;

    local v90 = u4(p87, "Attachment1");

    if not (v90 and v90:IsA("Attachment")) then
        v90 = nil;
    end;

    local v91;

    if v90 then
        v91 = u4(v90, "Parent");
    else
        v91 = v90;
    end;

    if v90 and (v91 and v91:IsA("BasePart")) then
        u4(v90, "CFrame");

        return v89, v91;
    end;

    local _ = CFrame.identity;

    return v89, nil;
end;

function u37._read(p92: table, p93: userdata, p94: string) -- Line: 641
    -- upvalues: AssemblyRootProperty (copy), u4 (ref), readAttachmentJoint (copy), SurfaceIdProperty (copy), SurfaceIdAttribute (copy), BakeIdProperty (copy), bakedId (copy), PivotProperty (copy), BakedOriginAttribute (copy)
    if p94 == AssemblyRootProperty then
        local success, result = pcall(u4, p93, "AssemblyRootPart");

        if success then
            success = p92:_isRecordedRoot(p93, result);
        end;

        return true, success;
    end;

    if p92.Kinds[p93] == "constraint" then
        return readAttachmentJoint(p93, p94);
    end;

    if p94 == SurfaceIdProperty then
        local Attribute = p93:GetAttribute(SurfaceIdAttribute);

        return type(Attribute) == "string", Attribute;
    end;

    if p92.Kinds[p93] == "baked" then
        if p94 == BakeIdProperty then
            local v95 = bakedId(p93);

            return v95 ~= nil, v95;
        end;

        if p94 == PivotProperty then
            local v96 = p93:IsA("Model");

            if not p93:IsA("Model") then
                return v96, nil;
            end;

            local Attribute = p93:GetAttribute(BakedOriginAttribute);
            local Pivot = p93:GetPivot();

            if typeof(Attribute) == "CFrame" then
                return v96, Pivot * Attribute:Inverse();
            end;

            return v96, Pivot;
        end;
    end;

    if p94 ~= "C0" or not p93:IsA("WeldConstraint") then
        if p94 == "LocalTransparencyModifier" and (not p92.InCharacter[p93] and p92.Kinds[p93] ~= "particle") then
            return false, nil;
        end;

        return pcall(u4, p93, p94);
    end;

    local Part0 = p93.Part0;
    local Part1 = p93.Part1;

    if Part0 and Part1 then
        return true, Part0.CFrame:ToObjectSpace(Part1.CFrame);
    end;

    return true, CFrame.identity;
end;

function u37._updateInCharacter(p97: table, p98: userdata) -- Line: 677
    -- upvalues: inPlayerCharacter (copy), u4 (ref)
    if not (p98:IsA("BasePart") or p98:IsA("Decal")) then
        return;
    end;

    local v99 = inPlayerCharacter(p98);
    local v100 = v99 and (not p97.InCharacter[p98] and p97.Ids[p98]) and p97:_propId(u4(p98, "ClassName"), "LocalTransparencyModifier");

    if v100 then
        p97:_markProp(p98, v100);
    end;

    p97.InCharacter[p98] = v99 and true or nil;
end;

function u37._parentIdOf(p101: table, p102: userdata, p103: userdata?, p104: number?) -- Line: 691
    -- upvalues: RootId (copy), Lighting (copy)
    if p103 == nil then
        return nil;
    end;

    if p103 == workspace then
        return RootId.Workspace;
    end;

    if p103 == Lighting then
        if p102:IsA("Sky") then
            return RootId.Lighting;
        end;

        return nil;
    end;

    if p103:IsA("Terrain") then
        return RootId.Workspace;
    end;

    if not p101:_inBaked(p103) then
        return p101.Ids[p103] or p101.Registry:Resolve(p103, p104);
    end;

    if p101:_isUnbaked(p102) then
        return RootId.Workspace;
    end;

    return nil;
end;

function u37._inDomain(p105: table, p106: userdata) -- Line: 711
    -- upvalues: u4 (ref), Lighting (copy)
    if p106:IsA("Sky") then
        return u4(p106, "Parent") == Lighting;
    end;

    if not p106:IsDescendantOf(workspace) or p106:IsA("Terrain") or (p106:IsA("BillboardGui") or p106:IsA("SurfaceGui")) then
        return false;
    end;

    local v107;

    if p106:FindFirstAncestorWhichIsA("LayerCollector") == nil then
        v107 = p106:FindFirstAncestorWhichIsA("ViewportFrame") == nil;
    else
        v107 = false;
    end;

    return v107;
end;

function u37._isBakedRoot(p108: table, p109: userdata) -- Line: 724
    -- upvalues: bakedId (copy)
    if p108.Baked[p109] then
        return true;
    end;

    local v110;

    if p108.Ids[p109] == nil then
        v110 = bakedId(p109) ~= nil;
    else
        v110 = false;
    end;

    return v110;
end;

function u37._isUnbaked(p111: table, p112: userdata) -- Line: 731
    -- upvalues: UnbakedAttribute (copy)
    local v113;

    if p111.Unbaked[p112] == nil then
        v113 = false;
    else
        v113 = p112:GetAttribute(UnbakedAttribute) == true;
    end;

    return v113;
end;

function u37._inBaked(p114: table, p115: userdata?) -- Line: 738
    -- upvalues: u4 (ref)
    if not (p114.BakeModels and (p115 ~= nil and p115 ~= workspace)) then
        return false;
    end;

    local BakedMemo = p114.BakedMemo;
    local v116 = BakedMemo[p115];

    if v116 ~= nil then
        return v116;
    end;

    local v117 = not p114:_isUnbaked(p115) and (p114:_isBakedRoot(p115) or p114:_inBaked(u4(p115, "Parent")));
    BakedMemo[p115] = v117;

    return v117;
end;

function u37._hiddenByBake(p118: table, p119: userdata, p120: userdata?) -- Line: 754
    local v121 = p118:_inBaked(p120) and not p118:_isUnbaked(p119);

    return v121;
end;

function u37._track(p122: table, p123: userdata, p124: number?) -- Line: 760
    -- upvalues: Observability (copy), u4 (ref), bakedId (copy), u9 (copy), u10 (copy), inPlayerCharacter (copy), u5 (copy), AssemblyRootProperty (copy), PivotProperty (copy), ValueType (copy), Copies (copy), Codec (copy), Sequences (copy)
    local v125 = p122.Ids[p123];

    if v125 then
        return v125;
    end;

    if p122.Count >= p122.MaxInstances or (not p122:_inDomain(p123) or Observability.IsAudio(p123)) then
        return nil;
    end;

    local v126 = p123:IsA("ParticleEmitter");

    if v126 and not p122.Particles[p123] then
        return nil;
    end;

    local Registry = p122.Registry;
    local v127 = u4(p123, "Parent");

    if p122:_hiddenByBake(p123, v127) then
        return nil;
    end;

    local v128 = p122:_parentIdOf(p123, v127, p124);

    if v128 == nil then
        return nil;
    end;

    if Registry:MatchFilter(p123, v127) then
        p122:_watchFiltered(p123);

        return nil;
    end;

    local v129 = u4(p123, "ClassName");
    local v130 = "primitive";
    local v131 = Registry.ClassProps[v129];

    if v131 and #v131 > 0 then
        v130 = p122.BakeModels and bakedId(p123) and "baked" or (p123:IsA("BasePart") and "part" or (p123:IsA("WeldConstraint") and "weld" or (p123:IsA("JointInstance") and "joint" or (u9[v129] and "constraint" or (v126 and "particle" or ((u10[v129] or p123:IsA("Attachment")) and "visual" or (p123:IsA("Sky") and "sky" or v130)))))));
    end;

    if v130 == "primitive" then
        v131 = nil;
    else
        Registry:ResolveRefs(p123, v129, p124);

        if v130 == "constraint" then
            for _, v in { "Attachment0", "Attachment1" } do
                local v132 = u4(p123, v);

                if not (v132 and v132:IsA("Attachment")) then
                    v132 = nil;
                end;

                local v133;

                if v132 then
                    v133 = u4(v132, "Parent");
                else
                    v133 = v132;
                end;

                if v132 and (v133 and v133:IsA("BasePart")) then
                    u4(v132, "CFrame");
                else
                    local _ = CFrame.identity;
                    v133 = nil;
                end;

                if v133 then
                    Registry:Resolve(v133, p124);
                end;
            end;
        end;

        if p122.Ids[p123] then
            return p122.Ids[p123];
        end;
    end;

    local v134 = Registry:Allocate(p123, v128);
    p122.Count = p122.Count + 1;
    p122.Kinds[p123] = v130;

    if v131 and ((p123:IsA("BasePart") or p123:IsA("Decal")) and inPlayerCharacter(p123)) then
        p122.InCharacter[p123] = true;
    end;

    if v127 then
        p122:_kidsOf(v127)[p123] = true;
    end;

    local v135 = Registry:AddTime(p124);
    local v136;

    if v131 and v130 ~= "baked" then
        v136 = Registry:DefaultsFor(v129);
    else
        v136 = nil;
    end;

    local v137;

    if v130 == "part" then
        v137 = u4(p123, "Transparency") >= 1;
    else
        v137 = false;
    end;

    local v138 = {};
    local v139 = {};

    if v131 then
        local Ids = p122.Ids;

        for _, v in v131 do
            local Name = v.Name;

            if not (v137 and u5[Name]) then
                local v140, v141 = p122:_read(p123, Name);

                if v140 then
                    if Name == AssemblyRootProperty then
                        p122.Roots[p123] = v141;
                    elseif Name == "CFrame" and v130 == "part" or Name == PivotProperty and v130 == "baked" then
                        p122.LastCFrame[p123] = v141;
                    end;

                    local v142;

                    if v.Type == ValueType.Ref then
                        local refValue = Copies.refValue;
                        local v143;

                        if typeof(v141) == "Instance" then
                            v143 = Ids[v141];
                        else
                            v143 = nil;
                        end;

                        v142 = refValue(v143, v134);
                    else
                        v142 = v141;
                    end;

                    table.insert(v138, {
                        Prop = v,
                        Value = v141,
                        Stored = v142
                    });
                    v139[v.Id] = v142;
                end;
            end;
        end;
    end;

    local W = p122.Stream.W;
    local v144;

    if v131 then
        v144 = Registry.ClassIndex[v129] or Registry.UnknownClassId;
    else
        v144 = Registry.UnknownClassId;
    end;

    local v145, v146 = Registry.Copies:WriteHead(W, v134, v128, v144, u4(p123, "Name"), true, v139);
    local len = W.len;
    W:u16(0);
    local v147 = 0;

    if v131 then
        local v148 = {};

        for _, v in v138 do
            local Prop = v.Prop;
            local Value = v.Value;

            if Prop.Name == AssemblyRootProperty and not (Value or v145) then
                if v146 then
                    v146[Prop.Id] = false;
                end;
            else
                if Copies.differs(v145, v146, v136, Prop.Id, Value, v.Stored) then
                    Codec.varuint(W, Prop.Id);
                    Codec.writeValue(W, Prop.Type, Value);
                    v148[Prop.Id] = v135;
                    v147 = v147 + 1;
                end;

                if Sequences.Types[Prop.Type] then
                    p122:_setSequence(p123, Prop.Id, `{Prop.Id}:{Sequences.key(Sequences.keypoints(Prop.Type, Value))}`, v135);
                end;
            end;
        end;

        p122.LastSent[p123] = v148;

        if v137 then
            p122.Held[p123] = true;
        end;
    end;

    W:patchU16(len, v147);
    p122.Stream:EndRecord();
    p122:_connect(p123, v130, v129);

    if v130 ~= "baked" then
        if v130 == "part" then
            local success, result = pcall(u4, p123, "AssemblyRootPart");

            if success and result then
                p122.RootOf[p123] = result;
            end;

            if p122.Roots[p123] then
                p122:_updatePolling(p123);

                return v134;
            end;
        elseif v130 == "joint" or (v130 == "weld" or v130 == "constraint") then
            local v149, v150 = p122:_jointEnds(p123);
            p122:_setJointParts(p123, v149, v150);
            p122:_checkRoots(v149, v150, v135);
        end;

        return v134;
    end;

    p122.Baked[p123] = true;
    p122.BakedMemo[p123] = true;

    return v134;
end;

function u37._connect(u151: table, u152: userdata, u153: string, p154: string) -- Line: 933
    -- upvalues: u8 (copy), u4 (ref), u7 (copy), u14 (copy)
    local v155 = {};
    u151.Signals[u152] = v155;

    local function structure() -- Line: 936
        -- upvalues: u151 (copy), u152 (copy)
        u151.DirtyStructure[u152] = u151.Clock();
    end;

    local function rename() -- Line: 939
        -- upvalues: u151 (copy), u152 (copy)
        u151.DirtyName[u152] = u151.Clock();

        if u151.Registry.FilterAny then
            u151.DirtyStructure[u152] = u151.Clock();
        end;
    end;

    if u153 == "primitive" or u153 == "baked" then
        local PropertyChangedSignal = u152:GetPropertyChangedSignal("Parent");
        table.insert(v155, PropertyChangedSignal:Connect(structure));
        local PropertyChangedSignal2 = u152:GetPropertyChangedSignal("Name");
        table.insert(v155, PropertyChangedSignal2:Connect(rename));

        return;
    end;

    if u153 == "joint" or u153 == "weld" then
        local PropertyChangedSignal = u152:GetPropertyChangedSignal("Parent");
        table.insert(v155, PropertyChangedSignal:Connect(structure));
        local PropertyChangedSignal2 = u152:GetPropertyChangedSignal("Name");
        table.insert(v155, PropertyChangedSignal2:Connect(rename));

        for _, v in u8 do
            local u156 = u151:_propId(p154, v);

            if u156 and (u153 ~= "weld" or v ~= "C0" and v ~= "C1") then
                local PropertyChangedSignal3 = u152:GetPropertyChangedSignal(v);
                table.insert(v155, PropertyChangedSignal3:Connect(function() -- Line: 961
                    -- upvalues: u151 (copy), u152 (copy), u156 (copy)
                    u151:_markProp(u152, u156);
                end));
            end;
        end;

        return;
    end;

    if u153 ~= "constraint" then
        local u157 = u151.ByName[p154] or {};
        local CFrame2 = u157.CFrame;

        if not u152:IsA("Bone") then
            table.insert(v155, u152.Changed:Connect(function(p158: string) -- Line: 1034
                -- upvalues: u151 (copy), u152 (copy), u153 (copy), u7 (ref), CFrame2 (copy), u14 (ref), u157 (copy)
                if p158 == "Parent" then
                    u151.DirtyStructure[u152] = u151.Clock();

                    return;
                end;

                if p158 == "Name" then
                    u151.DirtyName[u152] = u151.Clock();

                    if u151.Registry.FilterAny then
                        u151.DirtyStructure[u152] = u151.Clock();
                    end;
                elseif u153 == "part" and u7[p158] then
                    if CFrame2 and u151.Roots[u152] then
                        u151:_markProp(u152, CFrame2);
                    end;
                else
                    if u153 == "part" and p158 == "Anchored" then
                        u151.AnchorCheck[u152] = true;

                        return;
                    end;

                    if CFrame2 and (u14[p158] and u152:IsA("Attachment")) then
                        u151:_markProp(u152, CFrame2);

                        return;
                    end;

                    local v159 = u157[p158];

                    if v159 then
                        u151:_markProp(u152, v159);
                    end;
                end;
            end));

            return;
        end;

        local PropertyChangedSignal = u152:GetPropertyChangedSignal("Parent");
        table.insert(v155, PropertyChangedSignal:Connect(structure));
        local PropertyChangedSignal2 = u152:GetPropertyChangedSignal("Name");
        table.insert(v155, PropertyChangedSignal2:Connect(rename));

        if CFrame2 then
            local PropertyChangedSignal3 = u152:GetPropertyChangedSignal("CFrame");
            table.insert(v155, PropertyChangedSignal3:Connect(function() -- Line: 1025
                -- upvalues: u151 (copy), u152 (copy), CFrame2 (copy)
                u151:_markProp(u152, CFrame2);
            end));
        end;

        return;
    end;

    local PropertyChangedSignal = u152:GetPropertyChangedSignal("Parent");
    table.insert(v155, PropertyChangedSignal:Connect(structure));
    local PropertyChangedSignal2 = u152:GetPropertyChangedSignal("Name");
    table.insert(v155, PropertyChangedSignal2:Connect(rename));
    local u160 = {};

    for _, v in u8 do
        local v161 = u151:_propId(p154, v);

        if v161 then
            table.insert(u160, v161);
        end;
    end;

    local function changed() -- Line: 978
        -- upvalues: u160 (copy), u151 (copy), u152 (copy)
        for _, v in u160 do
            u151:_markProp(u152, v);
        end;
    end;

    local function bindAttachments() -- Line: 983
        -- upvalues: u151 (copy), u152 (copy), u4 (ref), changed (copy)
        local v162 = u151.AttachSignals[u152];

        if v162 then
            for _, v in v162 do
                v:Disconnect();
            end;
        end;

        local v163 = {};

        for _, v in { "Attachment0", "Attachment1" } do
            local v164 = u4(u152, v);

            if not (v164 and v164:IsA("Attachment")) then
                v164 = nil;
            end;

            if v164 then
                local PropertyChangedSignal3 = v164:GetPropertyChangedSignal("CFrame");
                table.insert(v163, PropertyChangedSignal3:Connect(changed));
                local PropertyChangedSignal4 = v164:GetPropertyChangedSignal("Parent");
                table.insert(v163, PropertyChangedSignal4:Connect(changed));
            end;
        end;

        u151.AttachSignals[u152] = v163;
    end;

    bindAttachments();

    for _, v in { "Attachment0", "Attachment1" } do
        local PropertyChangedSignal3 = u152:GetPropertyChangedSignal(v);
        table.insert(v155, PropertyChangedSignal3:Connect(function() -- Line: 1004
            -- upvalues: bindAttachments (copy), u160 (copy), u151 (copy), u152 (copy)
            bindAttachments();

            for _, v2 in u160 do
                u151:_markProp(u152, v2);
            end;
        end));
    end;

    local PropertyChangedSignal3 = u152:GetPropertyChangedSignal("Enabled");
    table.insert(v155, PropertyChangedSignal3:Connect(changed));

    if u152:IsA("AnimationConstraint") then
        local PropertyChangedSignal4 = u152:GetPropertyChangedSignal("IsKinematic");
        table.insert(v155, PropertyChangedSignal4:Connect(changed));
    end;
end;

local function setPolled(p165: table, p166: userdata, p167: boolean) -- Line: 1057
    if not p167 or p165.Set[p166] then
        if not p167 then
            p165.Set[p166] = nil;
        end;

        return;
    end;

    p165.Set[p166] = true;
    table.insert(p165.List, p166);
end;

function u37._updatePolling(p168: table, p169: userdata) -- Line: 1068
    -- upvalues: u4 (ref)
    local v170;

    if p168.Roots[p169] == true and p168.Ids[p169] ~= nil then
        v170 = p168.TerrainDriven[p169] ~= nil and true or not u4(p169, "Anchored");
    else
        v170 = false;
    end;

    local v171;

    if v170 then
        v171 = p168:_characterPlayer(p169);
    else
        v171 = nil;
    end;

    p168:_setPlayerPolled(p169, v171);
    local WorldPoll = p168.WorldPoll;

    if v170 then
        v170 = v171 == nil;
    end;

    if not v170 or WorldPoll.Set[p169] then
        if not v170 then
            WorldPoll.Set[p169] = nil;
        end;

        return;
    end;

    WorldPoll.Set[p169] = true;
    table.insert(WorldPoll.List, p169);
end;

function u37._setPlayerPolled(p172: table, p173: userdata, p174: userdata?) -- Line: 1078
    -- upvalues: newPollQueue (copy)
    local v175 = p172.PolledBy[p173];

    if v175 == p174 then
        return;
    end;

    local v176 = v175 and p172.PlayerPolls[v175];

    if v176 then
        v176.Queue.Set[p173] = nil;
    end;

    p172.PolledBy[p173] = p174;

    if p174 then
        local v177 = p172.PlayerPolls[p174];

        if not v177 then
            v177 = {
                Queue = newPollQueue(),
                Next = os.clock()
            };
            p172.PlayerPolls[p174] = v177;
        end;

        local Queue = v177.Queue;

        if not Queue.Set[p173] then
            Queue.Set[p173] = true;
            table.insert(Queue.List, p173);
        end;
    end;
end;

function u37._checkRoots(p178: table, p179: userdata?, p180: userdata?, p181: number) -- Line: 1102
    local RootCheck = p178.RootCheck;

    for _, v in { p179, p180 } do
        if v and v:IsA("BasePart") then
            RootCheck[v] = p181;
            local v182 = p178.RootOf[v];

            if v182 then
                RootCheck[v182] = p181;
            end;
        end;
    end;
end;

function u37._writeProp(p183: table, p184: userdata, p185: number, p186: number, p187: any, p188: number, p189: boolean?) -- Line: 1118
    -- upvalues: ValueType (copy), Op (copy), Codec (copy), u6 (copy)
    local v190 = p183.LastSent[p184];

    if not v190 then
        v190 = {};
        p183.LastSent[p184] = v190;
    end;

    local v191 = p183.Registry.PropTypes[p186];
    local v192 = v190[p186];
    local v193;

    if v191 == ValueType.CFrame then
        v193 = typeof(p187) == "CFrame";
    else
        v193 = false;
    end;

    if v193 and v192 then
        if p188 < v192 then
            p188 = v192;
        end;
    end;

    local v194;

    if v193 and (p183.Kinds[p184] == "part" and not p183:_isCharacterPart(p184)) then
        local v195;
        v195, v194 = p183:_writeMotion(p184, p185, p186, p187, p188);

        if v195 then
            return;
        end;
    else
        v194 = false;
    end;

    local Prop = Op.Prop;
    local v196 = 0;
    local v197 = 0;
    local v198 = 0;
    local v199 = 0;
    local v200 = 0;
    local v201 = 0;
    local v202 = 0;
    local v203, v204, v205, v206;

    if v193 then
        v203, v204, v205, v206 = Codec.quantizeRotation(p187);
        local Position = p187.Position;
        local v207 = p183.SentCFrames[p184];

        if not v207 then
            v207 = {};
            p183.SentCFrames[p184] = v207;
        end;

        local v208 = v207[p186];

        if v208 then
            local Position2 = v208.Position;
            v196 = Codec.positionSteps(Position2.X, Position.X);
            v197 = Codec.positionSteps(Position2.Y, Position.Y);
            v198 = Codec.positionSteps(Position2.Z, Position.Z);
            local MaxPositionSteps = Codec.MaxPositionSteps;

            if math.abs(v196) <= MaxPositionSteps and (math.abs(v197) <= MaxPositionSteps and math.abs(v198) <= MaxPositionSteps) then
                local v209;

                if v208.K == v203 and (v208.A == v204 and v208.B == v205) then
                    v209 = v208.C == v206;
                else
                    v209 = false;
                end;

                if v196 == 0 and (v197 == 0 and (v198 == 0 and (v209 and not v194))) then
                    if p189 then
                        v190[p186] = p188;
                    end;

                    return;
                end;

                Prop = Op.CFrameDelta;
                v199 = v208.K;
                v200 = v208.A;
                v201 = v208.B;
                v202 = v208.C;
                local v210 = Codec.stepPosition(Position2.X, v196);
                local v211 = Codec.stepPosition(Position2.Y, v197);
                Position = Vector3.new(v210, v211, Codec.stepPosition(Position2.Z, v198));
            end;
        end;

        if v208 then
            v208.Position = Position;
            v208.K = v203;
            v208.A = v204;
            v208.B = v205;
            v208.C = v206;
        else
            v207[p186] = {
                Position = Position,
                K = v203,
                A = v204,
                B = v205,
                C = v206
            };
        end;
    else
        v206 = 0;
        v203 = 0;
        v205 = 0;
        v204 = 0;
    end;

    local v212;

    if u6[v191] and (p189 or v191 ~= ValueType.CFrame) and (v192 and (p188 - v192 <= 300 and v192 < p188)) then
        v212 = p188 - v192;
    else
        v212 = nil;
    end;

    v190[p186] = p188;

    if v191 == ValueType.Ref and typeof(p187) == "Instance" then
        p183.Registry:Resolve(p187, p188);
    end;

    local v213;

    if v212 then
        local math_round_ret = math.round(v212 / 10);
        v213 = math.clamp(math_round_ret, 1, 255);
    else
        v213 = 0;
    end;

    if not v193 then
        p183:_writeValue(p184, p185, p186, v191, p187, p188, v213);

        return;
    end;

    local Stream = p183.Stream;
    Stream:Time(p188);
    local W = Stream.W;

    if Prop == Op.CFrameDelta then
        W:u8(Prop);
        Codec.varuint(W, p185);
        Codec.varuint(W, p186);
        W:u8(v213);
        Codec.cframeDelta(W, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206);
    else
        if v212 then
            W:u8(Op.PropLerp);
            Codec.varuint(W, p185);
            Codec.varuint(W, p186);
            W:u8(v213);
        else
            W:u8(Op.Prop);
            Codec.varuint(W, p185);
            Codec.varuint(W, p186);
        end;

        Codec.position(W, p187);
        Codec.rotation(W, v203, v204, v205, v206);
    end;

    Stream:EndRecord();
end;

function u37._setSequence(p214: table, p215: userdata, p216: number, p217: string, p218: number) -- Line: 1229
    local v219 = p214.SeqStates[p215];

    if not v219 then
        v219 = {};
        p214.SeqStates[p215] = v219;
    end;

    local v220 = v219[p216];

    if v220 and p214.SeqHolders[v220.Key] == p215 then
        p214.SeqHolders[v220.Key] = nil;
    end;

    v219[p216] = {
        Key = p217,
        Time = p218
    };
    p214.SeqHolders[p217] = p215;
end;

function u37._writeValue(p221: table, p222: userdata, p223: number, p224: number, p225: number, p226: any, p227: number, p228: number) -- Line: 1245
    -- upvalues: Codec (copy)
    local ValueScratch = p221.ValueScratch;
    ValueScratch.len = 0;
    Codec.writeValue(ValueScratch, p225, p226);
    local buffer_readstring_ret = buffer.readstring(ValueScratch.buf, 0, ValueScratch.len);
    local Groups = p221.Groups;

    if not (Groups and p221.GroupedProps[p224]) then
        p221:_writeSingle(p222, p223, p224, p225, p226, p227, p228, buffer_readstring_ret);

        return;
    end;

    local v229 = `{p224}:{p228}:{math.floor(p227)}:{buffer_readstring_ret}`;
    local v230 = Groups[v229];

    if v230 then
        table.insert(v230.Members, {
            Inst = p222,
            Id = p223
        });

        return;
    end;

    local v231 = {
        PropId = p224,
        Type = p225,
        Value = p226,
        T = p227,
        LerpUnits = p228,
        Encoded = buffer_readstring_ret,
        Members = {
            {
                Inst = p222,
                Id = p223
            }
        }
    };
    Groups[v229] = v231;
    table.insert(p221.GroupOrder, v231);
end;

function u37._writeSingle(p232: table, p233: userdata, p234: number, p235: number, p236: number, p237: any, p238: number, p239: number, p240: string) -- Line: 1285
    -- upvalues: Sequences (copy), Op (copy), Codec (copy)
    local Stream = p232.Stream;
    Stream:Time(p238);
    local W = Stream.W;
    local v241;

    if Sequences.Types[p236] then
        v241 = `{p235}:{Sequences.key(Sequences.keypoints(p236, p237))}`;
    else
        v241 = nil;
    end;

    if v241 then
        local v242 = p232.SeqHolders[v241];
        local v243;

        if v242 then
            if v242 == p233 then
                v243 = false;
            else
                v243 = p232.Ids[v242];
            end;
        else
            v243 = v242;
        end;

        local v244;

        if v243 then
            v244 = p232.SeqStates[v242];
        else
            v244 = v243;
        end;

        if v244 then
            v244 = v244[p235];
        end;

        if v243 and (v244 and v244.Time <= p238) then
            Sequences.writeCopy(W, p234, p235, p239, v243);
            Stream:EndRecord();
            p232:_setSequence(p233, p235, v241, p238);

            return;
        end;
    end;

    if p239 > 0 then
        W:u8(Op.PropLerp);
        Codec.varuint(W, p234);
        Codec.varuint(W, p235);
        W:u8(p239);
    else
        W:u8(Op.Prop);
        Codec.varuint(W, p234);
        Codec.varuint(W, p235);
    end;

    local v245 = #p240;
    W:_ensure(v245);
    buffer.writestring(W.buf, W.len, p240);
    W.len = W.len + v245;
    Stream:EndRecord();

    if v241 then
        p232:_setSequence(p233, p235, v241, p238);
    end;
end;

function u37._flushGroups(p246) -- Line: 1330
    -- upvalues: Op (copy), Codec (copy), Sequences (copy)
    p246.Groups = nil;
    local GroupOrder = p246.GroupOrder;
    p246.GroupOrder = {};
    local Stream = p246.Stream;

    for _, v in GroupOrder do
        local Members = v.Members;
        local PropId = v.PropId;
        local Type = v.Type;
        local T = v.T;

        if #Members == 1 then
            local v247 = Members[1];
            p246:_writeSingle(v247.Inst, v247.Id, PropId, Type, v.Value, T, v.LerpUnits, v.Encoded);
        else
            table.sort(Members, function(p248, p249) -- Line: 1343
                return p248.Id < p249.Id;
            end);
            Stream:Time(T);
            local W = Stream.W;
            W:u8(Op.PropMany);
            Codec.varuint(W, PropId);
            W:u8(v.LerpUnits);
            Codec.varuint(W, #Members);
            local v250 = v;
            local v251 = 0;

            for _, v2 in Members do
                Codec.varuint(W, v2.Id - v251);
                v251 = v2.Id;
            end;

            local Encoded = v250.Encoded;
            local v252 = #Encoded;
            W:_ensure(v252);
            buffer.writestring(W.buf, W.len, Encoded);
            W.len = W.len + v252;
            Stream:EndRecord();

            if Sequences.Types[Type] then
                local v253 = `{PropId}:{Sequences.key(Sequences.keypoints(Type, v250.Value))}`;

                for _, v2 in Members do
                    p246:_setSequence(v2.Inst, PropId, v253, T);
                end;
            end;
        end;
    end;
end;

function u37._writeMotion(p254: table, p255: userdata, p256: number, p257: number, p258, p259: number) -- Line: 1372
    -- upvalues: Motion (copy), Codec (copy)
    p254.Sampled[p255] = true;
    local v260 = p254.Samples[p255];
    local v261;

    if v260 then
        v261 = v260.T;
    else
        v261 = v260;
    end;

    local v262;

    if v260 then
        v262 = v260.CFrame;
    else
        v262 = v260;
    end;

    local v263;

    if v260 then
        v263 = v260.BeforeT;
    else
        v263 = v260;
    end;

    local v264;

    if v260 then
        v264 = v260.Before;
    else
        v264 = v260;
    end;

    if v260 then
        local CFrame2 = v260.CFrame;
        v260.BeforeT = v260.T;
        v260.Before = CFrame2;
        v260.T = p259;
        v260.CFrame = p258;
    else
        p254.Samples[p255] = {
            T = p259,
            CFrame = p258
        };
    end;

    local v265 = p254.Motions[p255];
    local v266;

    if v265 then
        local v267;

        if p259 < v265.T then
            v267 = false;
        else
            local v268 = Motion.at(v265.Base, v265.W, v265.V, v265.A, (p259 - v265.T) / 1000);
            v267 = not Motion.apart(v268, p258, 0.2, 0.02);
        end;

        if v267 then
            v265.Hits = v265.Hits + 1;

            return true, false;
        end;

        p254.Motions[p255] = nil;
        v266 = true;

        if v265.Hits == 0 then
            p254.Untrusted[p255] = true;
        end;
    else
        v266 = false;
    end;

    if not (v262 and (v261 and (p259 > v261 and p259 - v261 <= 250))) then
        p254.Candidates[p255] = nil;

        return false, v266;
    end;

    local v269, v270 = Motion.between(v262, p258, (p259 - v261) / 1000);
    local v271 = v269.Magnitude < 0.002 and Vector3.new(0, 0, 0) or v269;

    if v270.Magnitude < 0.02 and v271 == Vector3.new(0, 0, 0) then
        p254.Candidates[p255] = nil;

        return false, v266;
    end;

    local v272 = Vector3.new(0, 0, 0);
    local v273, v274;

    if v271 == Vector3.new(0, 0, 0) and (v264 and (v263 and (v263 < v261 and v261 - v263 <= 250))) then
        v273, v274 = Motion.accelerating(v264.Position, v262.Position, p258.Position, v263 / 1000, v261 / 1000, p259 / 1000);

        if v274.Magnitude < 0.05 then
            v274 = v272;
            v273 = v270;
        end;
    else
        v274 = v272;
        v273 = v270;
    end;

    local v275 = {
        Hits = 0,
        PropId = p257,
        T = p259,
        Base = p258,
        W = v271,
        V = v273,
        A = v274
    };

    if p254.Untrusted[p255] then
        local v276 = p254.Candidates[p255];
        p254.Candidates[p255] = v275;

        if not v276 then
            return false, v266;
        end;

        local v277;

        if p259 < v276.T then
            v277 = false;
        else
            local v278 = Motion.at(v276.Base, v276.W, v276.V, v276.A, (p259 - v276.T) / 1000);
            v277 = not Motion.apart(v278, p258, 0.2, 0.02);
        end;

        if not v277 then
            return false, v266;
        end;

        p254.Untrusted[p255] = nil;
        p254.Candidates[p255] = nil;
    end;

    p254.Motions[p255] = v275;
    local v279, v280, v281, v282 = Codec.quantizeRotation(p258);
    local v283 = p254.SentCFrames[p255];

    if not v283 then
        v283 = {};
        p254.SentCFrames[p255] = v283;
    end;

    local v284 = v283[p257];
    local v285;

    if v284 == nil or (v284.K ~= v279 or (v284.A ~= v280 or v284.B ~= v281)) then
        v285 = false;
    else
        v285 = v284.C == v282;
    end;

    v283[p257] = {
        Position = p258.Position,
        K = v279,
        A = v280,
        B = v281,
        C = v282
    };
    local Stream = p254.Stream;
    Stream:Time(p259);
    Motion.write(Stream.W, p256, p257, p258, v271, v273, v274, v285);
    Stream:EndRecord();
    local v286 = p254.LastSent[p255];

    if v286 then
        v286[p257] = p259;
    end;

    return true, v266;
end;

function u37._checkMotions(p287) -- Line: 1469
    -- upvalues: u4 (ref)
    local v288 = p287.Clock();
    local v289 = {};

    for i in p287.Motions do
        if not p287.Sampled[i] then
            table.insert(v289, i);
        end;
    end;

    for _, v in v289 do
        local v290 = p287.Motions[v];
        local v291 = p287.Ids[v];

        if v291 then
            local v292 = u4(v, "CFrame");
            p287.LastCFrame[v] = v292;
            p287:_writeProp(v, v291, v290.PropId, v292, v288);
        else
            p287.Motions[v] = nil;
        end;
    end;

    table.clear(p287.Sampled);
end;

function u37._isCharacterPart(p293: table, p294: userdata) -- Line: 1493
    return p293:_characterPlayer(p294) ~= nil;
end;

function u37._characterPlayer(p295: table, p296: userdata) -- Line: 1498
    -- upvalues: u4 (ref), Players (copy)
    local v297 = u4(p296, "Parent");

    if v297 then
        return Players:GetPlayerFromCharacter(v297);
    end;

    return nil;
end;

function u37._untrack(p298: table, p299: userdata) -- Line: 1503
    local v300 = p298.Kinds[p299];

    if v300 == "joint" or (v300 == "weld" or v300 == "constraint") then
        local v301 = p298.JointParts[p299];

        if v301 then
            p298:_checkRoots(v301[1], v301[2], p298.Clock());
        end;

        p298:_setJointParts(p299, nil, nil);
    end;

    if p298.Ids[p299] then
        p298.Count = p298.Count - 1;
    end;

    p298.Registry:Free(p299);
    p298.Registry:NotifyUntracked(p299);
    p298.Kinds[p299] = nil;
    p298.Roots[p299] = nil;
    p298.RootOf[p299] = nil;
    p298.JointParts[p299] = nil;
    p298.Held[p299] = nil;
    p298.InCharacter[p299] = nil;
    p298.Baked[p299] = nil;
    p298.BakedMemo[p299] = nil;
    p298.LastCFrame[p299] = nil;
    p298.LastSent[p299] = nil;
    p298.SeqStates[p299] = nil;
    p298.SentCFrames[p299] = nil;
    p298.Motions[p299] = nil;
    p298.Samples[p299] = nil;
    p298.Candidates[p299] = nil;
    p298.Untrusted[p299] = nil;
    p298.WorldPoll.Set[p299] = nil;
    p298:_setPlayerPolled(p299, nil);
    p298.DirtyProps[p299] = nil;
    p298.DirtyName[p299] = nil;

    for _, v in { p298.Signals, p298.AttachSignals } do
        local v302 = v[p299];

        if v302 then
            for _, v2 in v302 do
                v2:Disconnect();
            end;

            v[p299] = nil;
        end;
    end;
end;

function u37._untrackTree(p303: table, p304: userdata, p305: userdata?) -- Line: 1550
    local v306;

    if p305 then
        local v307 = p303.Kids[p305];

        if v307 then
            v307[p304] = nil;
            v306 = { p304 };
        else
            v306 = { p304 };
        end;
    else
        v306 = { p304 };
    end;

    while #v306 > 0 do
        local table_remove_ret = table.remove(v306);
        local v308 = p303.Kids[table_remove_ret];

        if v308 then
            for i in v308 do
                table.insert(v306, i);
            end;

            p303.Kids[table_remove_ret] = nil;
        end;

        p303:_untrack(table_remove_ret);
    end;
end;

function u37._watchFiltered(u309: table, u310: userdata) -- Line: 1573
    -- upvalues: seedKind (copy)
    u309.Registry:WatchFiltered(u310, function() -- Line: 1574
        -- upvalues: u309 (copy), u310 (copy), seedKind (ref)
        if u309.Destroyed then
            return;
        end;

        local v311 = u309.Clock();
        u309.DirtyStructure[u310] = v311;

        for _, descendant in u310:GetDescendants() do
            if seedKind(descendant) then
                u309.DirtyStructure[descendant] = v311;
            end;
        end;
    end);
end;

function u37._discover(p312: table, p313: userdata, p314: number) -- Line: 1588
    -- upvalues: seedKind (copy), u4 (ref)
    local v315 = seedKind(p313);

    if v315 == "gui" then
        if not p312:_inBaked(u4(p313, "Parent")) then
            p312.TrackGui(p313);
        end;
    else
        if v315 == "baked" and not p312.BakeModels then
            return;
        end;

        if v315 or p312.Particles[p313] then
            p312:_track(p313, p314);
        end;
    end;
end;

function u37._mark(p316: table, p317: userdata) -- Line: 1602
    -- upvalues: seedKind (copy), u4 (ref)
    local v318 = p317:IsA("Animator");

    if not (v318 or seedKind(p317)) or p316:_hiddenByBake(p317, u4(p317, "Parent")) then
        return;
    end;

    if v318 then
        p316.WatchAnimator(p317);

        return;
    end;

    p316.DirtyStructure[p317] = p316.Clock();
end;

function u37._walk(p319: table, p320: number) -- Line: 1616
    -- upvalues: u4 (ref)
    local Registry = p319.Registry;
    local Pending = p319.Pending;

    while #Pending > 0 do
        if p320 <= os.clock() then
            return false;
        end;

        local table_remove_ret = table.remove(Pending);
        local v321 = u4(table_remove_ret, "Parent");

        if v321 ~= nil then
            if Registry:MatchFilter(table_remove_ret, v321) then
                p319:_watchFiltered(table_remove_ret);
            else
                p319:_discover(table_remove_ret, p319.Clock());

                if table_remove_ret:IsA("Animator") then
                    p319.WatchAnimator(table_remove_ret);
                end;

                if not (table_remove_ret:IsA("BillboardGui") or table_remove_ret:IsA("SurfaceGui") or p319:_inBaked(table_remove_ret)) then
                    for _, child in table_remove_ret:GetChildren() do
                        table.insert(Pending, child);
                    end;
                end;
            end;
        end;
    end;

    return true;
end;

function u37._scope(u322: table, p323: userdata) -- Line: 1650
    -- upvalues: newWatch (copy)
    local v324 = newWatch();

    if u322.Scoped then
        table.insert(v324.Connections, p323.DescendantAdded:Connect(function(p325) -- Line: 1655
            -- upvalues: u322 (copy)
            u322:_mark(p325);
        end));
    end;

    table.insert(u322.Pending, p323);

    return v324;
end;

local function closeWatch(p326: any, p327: table, p328: userdata) -- Line: 1664
    -- upvalues: closeWatch (copy)
    local v329 = p327[p328];

    if not v329 then
        return;
    end;

    p327[p328] = nil;

    for _, v in v329.Connections do
        v:Disconnect();
    end;

    for _, v in v329.Names do
        v:Disconnect();
    end;

    for i in v329.Kids do
        closeWatch(p326, p326.Watches, i);
    end;
end;

function u37._watchPath(u330: table, p331: userdata, u332: any) -- Line: 1685
    -- upvalues: newWatch (copy), closeWatch (copy), u4 (ref)
    if next(u332.Children) == nil then
        return;
    end;

    local u333 = newWatch();
    u330.Watches[p331] = u333;

    local function check(p334: userdata) -- Line: 1691
        -- upvalues: u333 (copy), closeWatch (ref), u330 (copy), u332 (copy), u4 (ref)
        if u333.Kids[p334] then
            u333.Kids[p334] = nil;
            closeWatch(u330, u330.Watches, p334);
        end;

        local v335 = u332.Children[u4(p334, "Name")];

        if v335 == nil or u330.Destroyed then
            return;
        end;

        u333.Kids[p334] = true;

        if v335.Marked then
            u330.Watches[p334] = u330:_scope(p334);

            return;
        end;

        u330:_watchPath(p334, v335);
    end;

    local function added(u336: userdata) -- Line: 1707
        -- upvalues: u333 (copy), check (copy)
        if u333.Names[u336] then
            return;
        end;

        u333.Names[u336] = u336:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 1711
            -- upvalues: check (ref), u336 (copy)
            check(u336);
        end);
        check(u336);
    end;

    table.insert(u333.Connections, p331.ChildAdded:Connect(added));
    table.insert(u333.Connections, p331.ChildRemoved:Connect(function(p337) -- Line: 1719
        -- upvalues: u333 (copy), closeWatch (ref), u330 (copy)
        local v338 = u333.Names[p337];

        if v338 then
            v338:Disconnect();
            u333.Names[p337] = nil;
        end;

        if u333.Kids[p337] then
            u333.Kids[p337] = nil;
            closeWatch(u330, u330.Watches, p337);
        end;
    end));

    for _, child in p331:GetChildren() do
        added(child);
    end;
end;

function u37._markAll(p339: table, p340: table) -- Line: 1736
    local v341 = p339.Clock();

    for _, v in p340 do
        p339.DirtyStructure[v] = v341;
    end;
end;

function u37._pin(u342: table, u343: userdata) -- Line: 1744
    if not u342.PinSignals[u343] then
        u342.PinSignals[u343] = u343.AncestryChanged:Connect(function() -- Line: 1746
            -- upvalues: u342 (copy), u343 (copy)
            if u342.Registry.Pins[u343] then
                u342:_markAll(u342.Registry:Pin(u343));
            end;
        end);
    end;

    u342:_markAll(u342.Registry:Pin(u343));
end;

function u37._unpin(p344: table, p345: userdata) -- Line: 1755
    local v346 = p344.PinSignals[p345];

    if v346 then
        v346:Disconnect();
        p344.PinSignals[p345] = nil;
    end;

    p344:_markAll(p344.Registry:Unpin(p345));
end;

function u37._characterAdded(p347: table, p348: userdata) -- Line: 1764
    if p347.Destroyed then
        return;
    end;

    p347:TrackCharacter(p348);

    if not p347.Filtered or p347.CharacterScopes[p348] then
        return;
    end;

    p347:_pin(p348);
    p347.CharacterScopes[p348] = p347:_scope(p348);
end;

function u37._characterRemoving(p349: table, p350: userdata) -- Line: 1776
    -- upvalues: closeWatch (copy)
    if p349.CharacterScopes[p350] then
        closeWatch(p349, p349.CharacterScopes, p350);
        p349:_unpin(p350);
    end;
end;

function u37._watchPlayers(u351) -- Line: 1783
    -- upvalues: Players (copy)
    local function watch(p352: userdata) -- Line: 1784
        -- upvalues: u351 (copy)
        table.insert(u351.Connections, p352.CharacterAdded:Connect(function(p353) -- Line: 1787
            -- upvalues: u351 (ref)
            u351:_characterAdded(p353);
        end));
        table.insert(u351.Connections, p352.CharacterRemoving:Connect(function(p354) -- Line: 1793
            -- upvalues: u351 (ref)
            u351:_characterRemoving(p354);
        end));

        if p352.Character then
            u351:_characterAdded(p352.Character);
        end;
    end;

    table.insert(u351.Connections, Players.PlayerAdded:Connect(watch));
    table.insert(u351.Connections, Players.PlayerRemoving:Connect(function(p355) -- Line: 1804
        -- upvalues: u351 (copy)
        u351.PlayerPolls[p355] = nil;
    end));

    for _, v in Players:GetPlayers() do
        watch(v);
    end;
end;

function u37._watchBaked(u356) -- Line: 1815
    -- upvalues: CollectionService (copy), BakedTag (copy), bakedId (copy)
    local Connections = u356.Connections;
    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal(BakedTag);
    table.insert(Connections, InstanceAddedSignal:Connect(function(p357) -- Line: 1818
        -- upvalues: bakedId (ref), u356 (copy)
        if bakedId(p357) then
            u356:_pin(p357);
        end;
    end));
    local Connections2 = u356.Connections;
    local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(BakedTag);
    table.insert(Connections2, InstanceRemovedSignal:Connect(function(p358) -- Line: 1826
        -- upvalues: u356 (copy)
        if u356.PinSignals[p358] then
            u356:_unpin(p358);
        end;
    end));

    for _, v in CollectionService:GetTagged(BakedTag) do
        if bakedId(v) then
            u356:_pin(v);
            table.insert(u356.Pending, v);
        end;
    end;
end;

function u37._watchUnbaked(u359) -- Line: 1842
    -- upvalues: CollectionService (copy), UnbakedTag (copy), closeWatch (copy)
    local function v362(u360: userdata) -- Line: 1843
        -- upvalues: u359 (copy)
        if u359.Unbaked[u360] or u359.Destroyed then
            return;
        end;

        local v361 = u359:_scope(u360);
        u359.Unbaked[u360] = v361;
        table.insert(v361.Connections, u360.AncestryChanged:Connect(function() -- Line: 1851
            -- upvalues: u359 (ref), u360 (copy)
            table.insert(u359.Pending, u360);
        end));
        table.clear(u359.BakedMemo);

        if u359.Filtered then
            u359:_pin(u360);
        end;
    end;

    local Connections = u359.Connections;
    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal(UnbakedTag);
    table.insert(Connections, InstanceAddedSignal:Connect(v362));
    local Connections2 = u359.Connections;
    local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal(UnbakedTag);
    table.insert(Connections2, InstanceRemovedSignal:Connect(function(p363) -- Line: 1863
        -- upvalues: u359 (copy), closeWatch (ref)
        if not u359.Unbaked[p363] then
            return;
        end;

        closeWatch(u359, u359.Unbaked, p363);
        table.clear(u359.BakedMemo);

        if u359.PinSignals[p363] then
            u359:_unpin(p363);
        end;

        u359.DirtyStructure[p363] = u359.Clock();
    end));

    for _, v in CollectionService:GetTagged(UnbakedTag) do
        v362(v);
    end;
end;

function u37._holdParticleHost(p364: table, p365: userdata) -- Line: 1882
    local v366 = p364.ParticleHosts[p365];

    if v366 then
        v366.Count = v366.Count + 1;

        return;
    end;

    local v367 = {
        Watch = nil,
        Count = 1
    };
    p364.ParticleHosts[p365] = v367;

    if p364.Filtered then
        p364:_pin(p365);
        v367.Watch = p364:_scope(p365);
    end;
end;

function u37._releaseParticleHost(p368: table, p369: userdata) -- Line: 1896
    local v370 = p368.ParticleHosts[p369];

    if not v370 then
        return;
    end;

    v370.Count = v370.Count - 1;

    if v370.Count > 0 then
        return;
    end;

    p368.ParticleHosts[p369] = nil;

    if v370.Watch then
        for _, v in v370.Watch.Connections do
            v:Disconnect();
        end;
    end;

    if p368.PinSignals[p369] and not (p368.CharacterScopes[p369] or (p368.Baked[p369] or p368.Unbaked[p369])) then
        p368:_unpin(p369);
    end;
end;

function u37.AddParticle(p371: table, p372: userdata) -- Line: 1920
    -- upvalues: particleHost (copy)
    if p371.Destroyed or p371:_inBaked(p372) then
        return;
    end;

    local v373 = particleHost(p372) or p372;
    local v374 = p371.Particles[p372];

    if v374 == v373 then
        return;
    end;

    p371.Particles[p372] = v373;
    p371:_holdParticleHost(v373);

    if v374 then
        p371:_releaseParticleHost(v374);
    end;

    p371.DirtyStructure[p372] = p371.Clock();
end;

function u37.SetEmissionScale(p375: table, p376: number) -- Line: 1939
    if p376 ~= p375.EmissionScale then
        p375.EmissionScale = p376;
        p375.EmissionScaleDirty = true;
    end;
end;

function u37._flushEmissionScale(p377) -- Line: 1946
    -- upvalues: EmissionScaleProperty (copy), Op (copy), Codec (copy), RootId (copy)
    local EmissionScale = p377.EmissionScale;
    local v378 = p377:_propId("Workspace", EmissionScaleProperty);

    if not (p377.EmissionScaleDirty and (EmissionScale and v378)) then
        return;
    end;

    p377.EmissionScaleDirty = false;
    local Stream = p377.Stream;
    Stream:Time(p377.Clock());
    local W = Stream.W;
    W:u8(Op.Prop);
    Codec.varuint(W, RootId.Workspace);
    Codec.varuint(W, v378);
    W:f32(EmissionScale);
    Stream:EndRecord();
end;

function u37.RemoveParticle(p379: table, p380: userdata) -- Line: 1964
    local v381 = p379.Particles[p380];

    if not v381 then
        return;
    end;

    p379.Particles[p380] = nil;
    p379:_releaseParticleHost(v381);
    p379.DirtyStructure[p380] = p379.Clock();
end;

function u37.WriteEmit(p382: table, p383: userdata, p384: number, p385: number) -- Line: 1976
    -- upvalues: Op (copy), Codec (copy)
    if p382.Destroyed or not p382:_inDomain(p383) then
        return false;
    end;

    local Registry = p382.Registry;
    local NextId = Registry.NextId;
    local v386 = {};
    local v387;

    if p382:_inBaked(p383) then
        while p383 and (p383 ~= workspace and not p382:_isBakedRoot(p383)) do
            table.insert(v386, 1, p383.Name);
            p383 = p383.Parent;
        end;

        if p383 == nil or p383 == workspace then
            return false;
        end;

        v387 = p382.Ids[p383] or p382:_track(p383, p385);
    else
        p382:AddParticle(p383);
        v387 = p382.Ids[p383] or p382:_track(p383, p385);
    end;

    if not v387 then
        return false;
    end;

    if NextId <= v387 then
        p385 = math.max(p385, Registry.AddFloor);
    end;

    local Stream = p382.Stream;
    Stream:Time(p385);
    local W = Stream.W;
    W:u8(Op.Emit);
    Codec.varuint(W, v387);
    Codec.varuint(W, p384);
    Codec.varuint(W, #v386);

    for _, v in v386 do
        Codec.str(W, v);
    end;

    Stream:EndRecord();

    return true;
end;

function u37.Snapshot(u388) -- Line: 2023
    -- upvalues: Lighting (copy)
    if u388.Scoped then
        local v389 = u388.Registry:FilterRoot(workspace);

        if v389 then
            u388:_watchPath(workspace, v389);
        end;
    else
        table.insert(u388.Connections, workspace.DescendantAdded:Connect(function(p390) -- Line: 2032
            -- upvalues: u388 (copy)
            u388:_mark(p390);
        end));

        for _, child in workspace:GetChildren() do
            table.insert(u388.Pending, child);
        end;
    end;

    u388:_watchPlayers();

    if u388.BakeModels then
        u388:_watchUnbaked();
    end;

    if u388.Filtered and u388.BakeModels then
        u388:_watchBaked();
    end;

    local function markSky(p391: userdata) -- Line: 2048
        -- upvalues: u388 (copy)
        if p391:IsA("Sky") then
            u388.DirtyStructure[p391] = u388.Clock();
        end;
    end;

    table.insert(u388.Connections, Lighting.ChildAdded:Connect(markSky));
    table.insert(u388.Connections, Lighting.ChildRemoved:Connect(markSky));
    local v392 = u388.Clock();

    for _, child in Lighting:GetChildren() do
        if child:IsA("Sky") then
            u388:_track(child, v392);
        end;
    end;

    while not u388:_walk(os.clock() + 0.002) do
        task.wait();

        if u388.Destroyed then
            return;
        end;
    end;
end;

function u37._flushStructure(p393) -- Line: 2071
    -- upvalues: u4 (ref), Op (copy), Codec (copy)
    local Stream = p393.Stream;
    local Ids = p393.Ids;
    local DirtyStructure = p393.DirtyStructure;
    p393.DirtyStructure = {};
    local Registry = p393.Registry;
    local v394 = {};
    local v395 = {};
    local v396 = {};
    local v397 = {};

    for i in DirtyStructure do
        local v398 = Ids[i];

        if v398 and p393.Signals[i] then
            local v399 = u4(i, "Parent");

            if v399 == nil or (not p393:_inDomain(i) or (p393:_hiddenByBake(i, v399) or p393.Kinds[i] == "particle" and not p393.Particles[i])) then
                v394[v398] = true;
                table.insert(v395, i);
            else
                local v400;

                if Registry.FilterAny then
                    local v401 = {};

                    if Registry:Rematch(i, v399, p393.Kids, v401) then
                        table.insert(v401, i);
                    end;

                    v400 = i;

                    for _, v in v401 do
                        v397[v] = DirtyStructure[v400];
                    end;
                else
                    v400 = i;
                end;

                if not v397[v400] then
                    table.insert(v396, v400);
                end;
            end;
        end;
    end;

    for i in v397 do
        v394[Ids[i]] = true;
        table.insert(v395, i);
        p393:_watchFiltered(i);
    end;

    for _, v in v395 do
        local v402 = Ids[v];

        if v402 then
            local v403 = p393.Registry.ParentIds[v];

            if not v394[v403] then
                Stream:Time(DirtyStructure[v] or v397[v]);
                local W = Stream.W;
                W:u8(Op.Remove);
                Codec.varuint(W, v402);
                Stream:EndRecord();
            end;

            p393:_untrackTree(v, p393.Registry.ById[v403]);
        end;
    end;

    for _, v in v396 do
        local v404 = Ids[v];

        if v404 then
            local v405 = DirtyStructure[v];
            local v406 = u4(v, "Parent");
            local v407 = p393:_parentIdOf(v, v406, v405);
            local v408 = p393.Registry.ParentIds[v];

            if v407 == nil then
                Stream:Time(v405);
                local W = Stream.W;
                W:u8(Op.Remove);
                Codec.varuint(W, v404);
                Stream:EndRecord();
                p393:_untrackTree(v, p393.Registry.ById[v408]);
            elseif v407 ~= v408 then
                p393.Registry.ParentIds[v] = v407;
                local v409 = p393.Registry.ById[v408];

                if v409 then
                    v409 = p393.Kids[v409];
                end;

                if v409 then
                    v409[v] = nil;
                end;

                p393:_kidsOf(v406)[v] = true;
                Stream:Time((math.max(v405, p393.Registry.AddFloor)));
                local W = Stream.W;
                W:u8(Op.Reparent);
                Codec.varuint(W, v404);
                Codec.varuint(W, v407);
                Stream:EndRecord();
                p393:_updateInCharacter(v);

                if p393.Roots[v] then
                    p393:_updatePolling(v);
                end;
            end;
        end;
    end;

    local v410 = {};

    for i in DirtyStructure do
        if not Ids[i] then
            table.insert(v410, i);
        end;
    end;

    table.sort(v410, function(p411, p412) -- Line: 2180
        -- upvalues: DirtyStructure (copy)
        return DirtyStructure[p411] < DirtyStructure[p412];
    end);
    local v413 = os.clock() + 0.0015;

    for i, v in v410 do
        if v413 <= os.clock() then
            local DirtyStructure2 = p393.DirtyStructure;

            for i2 = i, #v410 do
                local v414 = v410[i2];
                local v415;

                if DirtyStructure2[v414] == nil then
                    DirtyStructure2[v414] = DirtyStructure[v414];
                    v415 = i2;
                else
                    v415 = i2;
                end;
            end;

            return;
        end;

        if u4(v, "Parent") ~= nil then
            p393:_discover(v, DirtyStructure[v]);
        end;
    end;
end;

function u37._flushRoots(p416) -- Line: 2201
    -- upvalues: u4 (ref), AssemblyRootProperty (copy)
    local RootCheck = p416.RootCheck;
    p416.RootCheck = {};
    local Ids = p416.Ids;

    while next(RootCheck) do
        local v417 = {};
        RootCheck = v417;

        for i, v in RootCheck do
            local v418 = Ids[i];

            if v418 and p416.Kinds[i] == "part" then
                local success, result = pcall(u4, i, "AssemblyRootPart");

                if success then
                    if result then
                        if result ~= i and (p416.RootOf[i] ~= result and not RootCheck[result]) then
                            RootCheck[result] = v;
                        end;

                        p416.RootOf[i] = result;
                    end;

                    local v419 = p416:_isRecordedRoot(i, result);

                    if v419 == (p416.Roots[i] == true) then
                        v417 = RootCheck;
                    else
                        p416.Roots[i] = v419;
                        local v420 = u4(i, "ClassName");
                        local v421 = p416:_propId(v420, AssemblyRootProperty);

                        if v421 then
                            p416:_writeProp(i, v418, v421, v419, v);
                        end;

                        if v419 then
                            local v422 = p416:_propId(v420, "CFrame");
                            local v423 = u4(i, "CFrame");

                            if v422 and p416.LastCFrame[i] ~= v423 then
                                p416.LastCFrame[i] = v423;
                                p416:_writeProp(i, v418, v422, v423, v);
                            end;
                        end;

                        p416:_updatePolling(i);
                        v417 = RootCheck;
                    end;
                else
                    v417 = RootCheck;
                end;
            else
                v417 = RootCheck;
            end;

            RootCheck = v417;
        end;
    end;
end;

function u37._flushProps(p424) -- Line: 2247
    -- upvalues: u4 (ref), u5 (copy), AssemblyRootProperty (copy)
    local Ids = p424.Ids;
    local DirtyProps = p424.DirtyProps;
    p424.DirtyProps = {};
    p424.Groups = {};
    local ClassProps = p424.Registry.ClassProps;

    for i in p424.AnchorCheck do
        if Ids[i] and p424.Roots[i] then
            p424:_updatePolling(i);
        end;
    end;

    table.clear(p424.AnchorCheck);

    for i, v in DirtyProps do
        local v425 = Ids[i];
        local v426 = p424.Kinds[i];

        if v425 and v426 then
            local v427 = u4(i, "ClassName");
            local v428 = p424.Held[i];
            local v429 = ClassProps[v427];

            if v429 then
                local v430 = nil;
                local v431;

                if v426 == "part" then
                    v431 = p424.ByName[v427] and v[p424.ByName[v427].Transparency];

                    if v431 then
                        local v432 = u4(i, "Transparency") >= 1;

                        if v428 and not v432 then
                            p424.Held[i] = nil;
                            v428 = nil;
                        elseif v432 then
                            p424.Held[i] = true;
                            v431 = v430;
                            v428 = true;
                        else
                            v431 = v430;
                        end;
                    else
                        v431 = v430;
                    end;
                else
                    v431 = v430;
                end;

                local v433 = i;
                local v434 = v;
                local v435 = false;

                for _, v2 in v429 do
                    local Id = v2.Id;
                    local Name = v2.Name;
                    local v436 = v434[Id];

                    if v436 or v431 and u5[Name] then
                        local v437 = v436 or v431;

                        if not (v428 and u5[Name] or (Name == AssemblyRootProperty or v426 == "weld" and Name == "C0")) then
                            local v438, v439 = p424:_read(v433, Name);

                            if v438 then
                                if v426 == "part" and Name == "CFrame" then
                                    if p424.Roots[v433] and p424.LastCFrame[v433] ~= v439 then
                                        p424.LastCFrame[v433] = v439;

                                        if v426 == "joint" or (v426 == "weld" or v426 == "constraint") then
                                            v435 = (Name == "Part0" or (Name == "Part1" or Name == "Enabled")) and true or v435;
                                        end;

                                        p424:_writeProp(v433, v425, Id, v439, v437);
                                    end;
                                else
                                    if v426 == "joint" or (v426 == "weld" or v426 == "constraint") then
                                        v435 = (Name == "Part0" or (Name == "Part1" or Name == "Enabled")) and true or v435;
                                    end;

                                    p424:_writeProp(v433, v425, Id, v439, v437);
                                end;
                            end;
                        end;
                    end;
                end;

                if v435 then
                    local v440 = p424.Clock();
                    local v441 = p424.JointParts[v433];

                    if v441 then
                        p424:_checkRoots(v441[1], v441[2], v440);
                    end;

                    local v442, v443 = p424:_jointEnds(v433);
                    p424:_setJointParts(v433, v442, v443);
                    p424:_checkRoots(v442, v443, v440);

                    if v426 == "weld" then
                        local v444 = p424:_propId(v427, "C0");
                        local v445, v446 = p424:_read(v433, "C0");

                        if v444 and v445 then
                            p424:_writeProp(v433, v425, v444, v446, v440);
                        end;
                    end;
                end;
            end;
        end;
    end;

    p424:_flushGroups();
end;

function u37._flushNames(p447) -- Line: 2344
    -- upvalues: Op (copy), Codec (copy)
    local DirtyName = p447.DirtyName;
    p447.DirtyName = {};
    local Stream = p447.Stream;

    for i, v in DirtyName do
        local v448 = p447.Ids[i];

        if v448 and p447.Signals[i] then
            Stream:Time(v);
            local W = Stream.W;
            W:u8(Op.Rename);
            Codec.varuint(W, v448);
            Codec.str(W, i.Name);
            Stream:EndRecord();
        end;
    end;
end;

function u37._poll(p449: table, p450: table) -- Line: 2362
    -- upvalues: u4 (ref), cframeMoved (copy)
    local List = p450.List;
    local Set = p450.Set;
    local v451 = #List;

    if v451 == 0 then
        return;
    end;

    local Ids = p449.Ids;
    local v452 = os.clock() + 0.001;
    local Cursor = p450.Cursor;
    local v453 = p449.Clock();
    local v454 = 0;

    while v454 < math.min(v451, 400) and os.clock() < v452 do
        Cursor = #List < Cursor and 1 or Cursor;
        local v455 = List[Cursor];
        v454 = v454 + 1;
        local v456;

        if v455 then
            v456 = Ids[v455];
        else
            v456 = v455;
        end;

        if v455 and (Set[v455] and v456) then
            Cursor = Cursor + 1;
            local v457 = u4(v455, "CFrame");
            local v458 = p449.LastCFrame[v455];

            if not v458 or cframeMoved(v458, v457) then
                p449.LastCFrame[v455] = v457;
                local v459 = p449:_propId(u4(v455, "ClassName"), "CFrame");

                if v459 then
                    p449:_writeProp(v455, v456, v459, v457, v453, true);
                end;
            end;
        else
            List[Cursor] = List[#List];
            List[#List] = nil;

            if #List == 0 then
                break;
            end;
        end;
    end;

    p450.Cursor = Cursor;
end;

function u37._followedRoot(p460: table, p461: userdata) -- Line: 2406
    -- upvalues: u12 (copy), u4 (ref)
    if u12[p461.CameraType] then
        return nil;
    end;

    local CameraSubject = p461.CameraSubject;

    if CameraSubject then
        if CameraSubject:IsA("Humanoid") then
            CameraSubject = CameraSubject.RootPart;
        elseif not CameraSubject:IsA("BasePart") then
            if CameraSubject:IsA("Model") then
                CameraSubject = CameraSubject.PrimaryPart;
            else
                CameraSubject = nil;
            end;
        end;
    else
        CameraSubject = nil;
    end;

    if not CameraSubject then
        return nil;
    end;

    if not p460.Roots[CameraSubject] then
        CameraSubject = u4(CameraSubject, "AssemblyRootPart");
    end;

    if CameraSubject and (p460.Ids[CameraSubject] and p460.Roots[CameraSubject]) then
        return CameraSubject;
    end;

    return nil;
end;

function u37._sampleCamera(p462) -- Line: 2418
    -- upvalues: u4 (ref)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return nil;
    end;

    local v463 = p462:_followedRoot(workspace_CurrentCamera);

    return {
        CFrame = workspace_CurrentCamera.CFrame,
        Fov = workspace_CurrentCamera.FieldOfView,
        Focus = workspace_CurrentCamera.Focus.Position,
        Root = v463,
        RootPosition = not v463 and Vector3.new(0, 0, 0) or u4(v463, "Position")
    };
end;

function u37._lerpUnits(p464: table, p465: number, p466: boolean) -- Line: 2433
    local v467 = p465 - p464.LastCameraTime;

    if not (p466 and (v467 > 0 and v467 <= 300)) then
        return 0;
    end;

    local math_round_ret = math.round(v467 / 10);

    return math.clamp(math_round_ret, 1, 255);
end;

function u37._flushCamera(p468) -- Line: 2440
    -- upvalues: cframeMoved (copy), Op (copy), Codec (copy)
    local v469 = p468.CameraSample or p468:_sampleCamera();

    if not v469 then
        return;
    end;

    local Root = v469.Root;

    if Root and (p468.Ids[Root] and p468.Roots[Root]) then
        p468:_flushFollow(v469, Root);

        return;
    end;

    local CFrame2 = v469.CFrame;
    local Fov = v469.Fov;
    local LastCamera = p468.LastCamera;

    if LastCamera and (not cframeMoved(LastCamera, CFrame2) and math.abs(Fov - p468.LastFov) < 0.05) then
        return;
    end;

    local v470 = p468.Clock();
    local v471 = p468:_lerpUnits(v470, LastCamera ~= nil);
    p468.LastCamera = CFrame2;
    p468.LastFov = Fov;
    p468.Follow = nil;
    p468.LastCameraTime = v470;
    local Stream = p468.Stream;
    Stream:Time(v470);
    local W = Stream.W;
    W:u8(Op.Camera);
    W:u8(v471);
    Codec.cframe(W, CFrame2);
    W:f32(Fov);
    Stream:EndRecord();
end;

function u37._flushFollow(p472: table, p473: table, p474: userdata) -- Line: 2473
    -- upvalues: cframeMoved (copy), Op (copy), Codec (copy)
    local CFrame2 = p473.CFrame;
    local Fov = p473.Fov;
    local v475 = CFrame2.Position - p473.RootPosition;
    local v476 = p473.Focus - p473.RootPosition;
    local Follow = p472.Follow;
    local Rotation = CFrame2.Rotation;
    local v477;

    if Follow and Follow.Root == p474 then
        v477 = 0;

        if cframeMoved(Follow.Rotation.Rotation, Rotation.Rotation) then
            v477 = bit32.bor(v477, 4);
        else
            Rotation = Follow.Rotation;
        end;

        if (Follow.Focus + Rotation * Follow.Offset - v475).Magnitude > 0.02 then
            if (v476 - Follow.Focus).Magnitude > 0.02 then
                v477 = bit32.bor(v477, 1);
            else
                v476 = Follow.Focus;
            end;

            v477 = bit32.bor(v477, 2);
        end;

        if math.abs(Fov - Follow.Fov) >= 0.05 then
            v477 = bit32.bor(v477, 8);
        end;

        if v477 == 0 then
            return;
        end;
    else
        v477 = 15;
    end;

    local v478;

    if bit32.btest(v477, 2) then
        v478 = Rotation:VectorToObjectSpace(v475 - v476);
    else
        v478 = Follow.Offset;
    end;

    local v479 = p472.Clock();
    local v480;

    if Follow == nil then
        v480 = false;
    else
        v480 = Follow.Root == p474;
    end;

    local v481 = p472:_lerpUnits(v479, v480);
    local v482 = {
        Root = p474,
        Focus = v476,
        Offset = v478,
        Rotation = Rotation
    };
    local v483;

    if bit32.btest(v477, 8) then
        v483 = Fov;
    else
        v483 = Follow.Fov;
    end;

    v482.Fov = v483;
    p472.Follow = v482;
    p472.LastCamera = nil;
    p472.LastCameraTime = v479;
    local Stream = p472.Stream;
    Stream:Time(v479);
    local W = Stream.W;
    W:u8(Op.CameraFollow);
    W:u8(v481);
    Codec.varuint(W, p472.Ids[p474]);
    W:u8(v477);

    if bit32.btest(v477, 1) then
        W:f32(v476.X);
        W:f32(v476.Y);
        W:f32(v476.Z);
    end;

    if bit32.btest(v477, 2) then
        W:f32(v478.X);
        W:f32(v478.Y);
        W:f32(v478.Z);
    end;

    if bit32.btest(v477, 4) then
        Codec.rotation(W, Codec.quantizeRotation(Rotation));
    end;

    if bit32.btest(v477, 8) then
        W:f32(Fov);
    end;

    Stream:EndRecord();
end;

function u37.TrackCharacter(p484: table, p485: userdata) -- Line: 2546
    for _, descendant in p485:GetDescendants() do
        if p484.Ids[descendant] and p484.Kinds[descendant] then
            p484:_updateInCharacter(descendant);

            if p484.Roots[descendant] then
                p484:_updatePolling(descendant);
            end;
        end;
    end;
end;

function u37.WriteCamera(p486) -- Line: 2558
    p486.LastCamera = nil;
    p486.Follow = nil;
    p486.LastCameraTime = (-1 / 0);
    p486.CameraSample = nil;
    p486:_flushCamera();
end;

function u37._pollBaked(p487) -- Line: 2568
    -- upvalues: BakedOriginAttribute (copy), cframeMoved (copy), u4 (ref), PivotProperty (copy)
    local v488 = p487.Clock();

    for i in p487.Baked do
        local v489 = p487.Ids[i];

        if v489 and i:IsA("Model") then
            local Attribute = i:GetAttribute(BakedOriginAttribute);
            local Pivot = i:GetPivot();

            if typeof(Attribute) == "CFrame" then
                Pivot = Pivot * Attribute:Inverse();
            end;

            local v490 = p487.LastCFrame[i];

            if not v490 or cframeMoved(v490, Pivot) then
                p487.LastCFrame[i] = Pivot;
                local v491 = p487:_propId(u4(i, "ClassName"), PivotProperty);

                if v491 then
                    p487:_writeProp(i, v489, v491, Pivot, v488, true);
                end;
            end;
        end;
    end;
end;

function u37.Flush(p492) -- Line: 2589
    table.clear(p492.BakedMemo);
    p492:_flushStructure();
    p492:_walk(os.clock() + 0.001);
    p492:_flushNames();
    p492:_flushRoots();
    p492:_flushProps();
    p492:_flushRoots();
    p492:_pollBaked();
    p492:_poll(p492.WorldPoll);
    p492:_checkMotions();
    p492:_flushCamera();
    p492:_flushEmissionScale();
end;

function u37.PollPlayers(p493) -- Line: 2609
    -- upvalues: Observability (copy)
    local os_clock_ret = os.clock();
    local v494 = os_clock_ret + Observability.DefaultCaptureInterval;

    for i, v in p493.PlayerPolls do
        if next(v.Queue.Set) ~= nil then
            if v.Next <= os_clock_ret then
                local v495 = Observability.CaptureIntervalOf(i);
                v.Next = v.Next + v495;

                if v.Next <= os_clock_ret then
                    v.Next = os_clock_ret + v495;
                end;

                p493:_poll(v.Queue);
            end;

            v494 = math.min(v494, v.Next);
        end;
    end;

    return v494;
end;

function u37.Destroy(p496) -- Line: 2630
    -- upvalues: RunService (copy), closeWatch (copy), newPollQueue (copy)
    p496.Destroyed = true;
    RunService:UnbindFromRenderStep("UGReplayCameraSample");
    p496.CameraSample = nil;
    p496.Follow = nil;

    for _, v in p496.Connections do
        v:Disconnect();
    end;

    table.clear(p496.Connections);

    for _, v in { p496.Signals, p496.AttachSignals } do
        for _, v2 in v do
            for _, v3 in v2 do
                v3:Disconnect();
            end;
        end;

        table.clear(v);
    end;

    for _, v in { p496.Watches, p496.CharacterScopes, p496.Unbaked } do
        local v497 = v;

        for i in v do
            closeWatch(p496, v497, i);
        end;
    end;

    for _, v in p496.ParticleHosts do
        if v.Watch then
            for _, v2 in v.Watch.Connections do
                v2:Disconnect();
            end;
        end;
    end;

    table.clear(p496.ParticleHosts);
    table.clear(p496.Particles);

    for _, v in p496.PinSignals do
        v:Disconnect();
    end;

    table.clear(p496.PinSignals);
    table.clear(p496.Kids);
    table.clear(p496.Kinds);
    table.clear(p496.Roots);
    table.clear(p496.RootOf);
    table.clear(p496.JointParts);
    table.clear(p496.TerrainDriven);
    table.clear(p496.Held);
    table.clear(p496.InCharacter);
    table.clear(p496.Baked);
    table.clear(p496.BakedMemo);
    table.clear(p496.LastCFrame);
    table.clear(p496.SentCFrames);
    table.clear(p496.LastSent);
    table.clear(p496.SeqStates);
    table.clear(p496.SeqHolders);
    p496.WorldPoll = newPollQueue();
    table.clear(p496.PlayerPolls);
    table.clear(p496.PolledBy);
    table.clear(p496.Pending);
    p496.DirtyStructure = {};
    p496.DirtyName = {};
    p496.DirtyProps = {};
    p496.RootCheck = {};
end;

return u37;