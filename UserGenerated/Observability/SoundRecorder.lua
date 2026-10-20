-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Op = Observability.Op;
local ValueType = Observability.ValueType;
local RootId = Observability.RootId;
local _, v1 = xpcall(function() -- Line: 61
    return workspace[nil];
end, function() -- Line: 63
    return debug.info(2, "f");
end);
local u4 = type(v1) ~= "function" and function(p2, p3) -- Line: 67
    return p2[p3];
end or v1;
local WorldCFrameProperty = Observability.WorldCFrameProperty;
local OnCameraProperty = Observability.OnCameraProperty;
local DistanceAttenuationProperty = Observability.DistanceAttenuationProperty;
local AngleAttenuationProperty = Observability.AngleAttenuationProperty;
local MasterVolumeProperty = Observability.MasterVolumeProperty;
local u5 = {
    CoreGui = true,
    CorePackages = true
};
local u6 = {
    AudioPlayer = "IsPlaying",
    AudioTextToSpeech = "IsPlaying",
    AudioWindSynthesizer = "Enabled"
};
local u7 = {
    Sound = true,
    AudioEmitter = true,
    AudioListener = true
};

local function isPositionSource(p8: userdata?) -- Line: 153
    local v9;

    if p8 == nil then
        v9 = false;
    else
        v9 = p8:IsA("BasePart") or p8:IsA("Attachment");
    end;

    return v9;
end;

local function worldCFrameOf(p10: userdata?) -- Line: 159
    if p10 == nil then
        return nil;
    end;

    if p10 == workspace then
        return CFrame.identity;
    end;

    if p10:IsA("BasePart") then
        return p10.CFrame;
    end;

    if p10:IsA("Attachment") then
        return p10.WorldCFrame;
    end;

    if p10:IsA("Camera") then
        return p10.CFrame;
    end;

    if p10:IsA("PVInstance") then
        return p10:GetPivot();
    end;

    return nil;
end;

local function serializeCurve(p11: table?) -- Line: 178
    if type(p11) ~= "table" then
        return "";
    end;

    local v12 = {};

    for i in p11 do
        if type(i) == "number" then
            table.insert(v12, i);
        end;
    end;

    table.sort(v12);
    local table_create_ret = table.create(#v12);

    for i, v in v12 do
        table_create_ret[i] = string.format("%.4g:%.4g", v, p11[v]);
    end;

    return table.concat(table_create_ret, ",");
end;

local function cframeMoved(p13, p14) -- Line: 196
    return (p13.Position - p14.Position).Magnitude > 0.05 and true or ((p13.XVector - p14.XVector).Magnitude > 0.003 and true or (p13.YVector - p14.YVector).Magnitude > 0.003);
end;

local function differs(p15: number, p16: any, p17: any) -- Line: 204
    -- upvalues: ValueType (copy)
    if p16 == nil or p17 == nil then
        return p16 ~= p17;
    end;

    if p15 ~= ValueType.Float32 and p15 ~= ValueType.Float64 then
        if p15 == ValueType.CFrame then
            return (p16.Position - p17.Position).Magnitude > 0.05 and true or ((p16.XVector - p17.XVector).Magnitude > 0.003 and true or (p16.YVector - p17.YVector).Magnitude > 0.003);
        end;

        return p16 ~= p17;
    end;

    local math_abs_ret = math.abs(p17 - p16);
    local math_abs_ret2 = math.abs(p16);

    return math.max(1, math_abs_ret2) * 0.001 < math_abs_ret;
end;

local u18 = {};
u18.__index = u18;

function u18.new(p19: function) -- Line: 219
    -- upvalues: u18 (copy)
    local v20 = {
        Registry = nil,
        Destroyed = false,
        Walked = false,
        GraphDirty = true,
        GraphTime = (-1 / 0),
        MasterVolumeReadable = true,
        Clock = p19,
        Connections = {},
        WalkQueue = {},
        Seen = setmetatable({}, {
            __mode = "k"
        }),
        SoundSignals = setmetatable({}, {
            __mode = "k"
        }),
        RemovalWatched = setmetatable({}, {
            __mode = "k"
        }),
        Candidates = {},
        Ghosts = {},
        GraphSources = {},
        Wires = {},
        Listeners = {},
        ActiveSources = {},
        Graph = {},
        Wanted = {},
        Nodes = {}
    };
    local u21 = setmetatable(v20, u18);

    for _, child in game:GetChildren() do
        u21:_watchService(child);
    end;

    table.insert(u21.Connections, game.ChildAdded:Connect(function(p22) -- Line: 262
        -- upvalues: u21 (copy)
        u21:_watchService(p22);
    end));

    return u21;
end;

function u18._watchService(u23: table, u24: userdata) -- Line: 269
    -- upvalues: u4 (ref), u5 (copy), SoundService (copy), Players (copy)
    local success, result = pcall(u4, u24, "ClassName");

    if not success or u5[result] then
        return;
    end;

    local success2, result2 = pcall(function() -- Line: 274
        -- upvalues: u24 (copy), u23 (copy)
        return u24.DescendantAdded:Connect(function(p25) -- Line: 275
            -- upvalues: u23 (ref)
            u23:_see(p25);
        end);
    end);

    if not success2 then
        return;
    end;

    table.insert(u23.Connections, result2);

    if u24 == SoundService or u24 == Players then
        table.insert(u23.WalkQueue, u24);

        return;
    end;

    table.insert(u23.WalkQueue, 1, u24);
end;

function u18._see(p26: table, p27: userdata) -- Line: 293
    -- upvalues: u4 (ref), u6 (copy)
    if p26.Destroyed or p26.Seen[p27] then
        return;
    end;

    local success, result = pcall(u4, p27, "ClassName");

    if not success then
        return;
    end;

    if result == "Sound" then
        p26.Seen[p27] = true;
        p26:_watchSound(p27);

        return;
    end;

    local v28 = u6[result];

    if v28 then
        p26.Seen[p27] = true;
        p26.GraphSources[p27] = v28;
        p26.GraphDirty = true;

        return;
    end;

    if result ~= "Wire" then
        if result == "AudioListener" then
            p26.Seen[p27] = true;
            p26.Listeners[p27] = true;
            p26.GraphDirty = true;
        end;

        return;
    end;

    p26.Seen[p27] = true;
    p26.Wires[p27] = true;
    p26.GraphDirty = true;
end;

function u18._watchSound(u29: table, u30: userdata) -- Line: 322
    local v32 = { u30.Played:Connect(function() -- Line: 323, Name: maybePlaying
            -- upvalues: u29 (copy), u30 (copy)
            u29.Candidates[u30] = true;
        end), u30.Changed:Connect(function(p31: string) -- Line: 328
            -- upvalues: u29 (copy), u30 (copy)
            if p31 == "Playing" then
                u29.Candidates[u30] = true;

                return;
            end;

            if p31 == "PlayOnRemove" then
                u29:_watchRemoval(u30);
            end;
        end) };
    u29.SoundSignals[u30] = v32;

    if u30.IsPlaying or u30.Playing then
        u29.Candidates[u30] = true;
    end;

    if u30.PlayOnRemove then
        u29:_watchRemoval(u30);
    end;
end;

function u18._watchRemoval(u33: table, u34: userdata) -- Line: 348
    -- upvalues: worldCFrameOf (copy)
    local v35 = u33.SoundSignals[u34];

    if not v35 or u33.RemovalWatched[u34] then
        return;
    end;

    u33.RemovalWatched[u34] = true;

    local function removed(p36) -- Line: 354
        -- upvalues: u34 (copy), u33 (copy)
        if not (u34.PlayOnRemove and (not u33.Ghosts[u34] and u34.SoundId ~= "")) then
            return;
        end;

        local TimeLength = u34.TimeLength;
        local TimePosition = u34.TimePosition;
        local math_max_ret = math.max(u34.PlaybackSpeed, 0.01);
        u33.Ghosts[u34] = {
            CFrame = p36,
            Position = TimePosition,
            EndsAt = u33.Clock() + (TimeLength <= 0 and 10000 or math.max(0, TimeLength - TimePosition) / math_max_ret * 1000)
        };
    end;

    table.insert(v35, u34.Destroying:Connect(function() -- Line: 369
        -- upvalues: removed (copy), u34 (copy), worldCFrameOf (ref)
        local Parent = u34.Parent;
        local v37;

        if Parent == nil then
            v37 = false;
        else
            v37 = Parent:IsA("BasePart") or Parent:IsA("Attachment");
        end;

        local v38;

        if v37 then
            v38 = worldCFrameOf(u34.Parent);
        else
            v38 = nil;
        end;

        removed(v38);
    end));
    table.insert(v35, u34.AncestryChanged:Connect(function() -- Line: 375
        -- upvalues: u34 (copy), removed (copy)
        if not u34:IsDescendantOf(game) then
            removed(nil);
        end;
    end));
end;

function u18._walk(p39: table, p40: number) -- Line: 384
    local WalkQueue = p39.WalkQueue;

    while #WalkQueue > 0 and os.clock() < p40 do
        local table_remove_ret = table.remove(WalkQueue);
        p39:_see(table_remove_ret);
        local success, result = pcall(table_remove_ret.GetChildren, table_remove_ret);

        if success then
            table.move(result, 1, #result, #WalkQueue + 1, WalkQueue);
        end;
    end;
end;

function u18.Bind(p41, p42) -- Line: 397
    p41.Registry = p42;
    table.clear(p41.Nodes);
    p41.GraphDirty = true;
    p41.Enabled = p42.ClassProps.Sound ~= nil;
end;

function u18._soundAudible(p43: table, p44: userdata) -- Line: 408
    local v45 = p44.IsPlaying and p44:IsDescendantOf(game);

    return v45;
end;

function u18._traceGraph(p46) -- Line: 414
    -- upvalues: Players (copy), u4 (ref)
    local LocalPlayer = Players.LocalPlayer;
    local u47 = {};

    for _, v in { p46.Wires, p46.Listeners } do
        local v48 = v;

        for i in v do
            if not i:IsDescendantOf(game) then
                v48[i] = nil;
                p46.Seen[i] = nil;
            end;
        end;
    end;

    for i in p46.Wires do
        local success, result = pcall(u4, i, "SourceInstance");
        local success2, result2 = pcall(u4, i, "TargetInstance");

        if success and (success2 and (result and result2)) then
            local v49 = u47[result];

            if not v49 then
                v49 = {};
                u47[result] = v49;
            end;

            table.insert(v49, i);
        end;
    end;

    local u50 = {};

    for i in p46.Listeners do
        local success, result = pcall(u4, i, "AudioInteractionGroup");

        if success then
            local v51 = u50[result];

            if not v51 then
                v51 = {};
                u50[result] = v51;
            end;

            table.insert(v51, i);
        end;
    end;

    local function nextOf(p52: userdata) -- Line: 450
        -- upvalues: u47 (copy), u4 (ref), u50 (copy)
        local v53 = {};

        for _, v in u47[p52] or {} do
            table.insert(v53, u4(v, "TargetInstance"));
        end;

        if u4(p52, "ClassName") == "AudioEmitter" then
            local success, result = pcall(u4, p52, "AudioInteractionGroup");

            for _, v in success and u50[result] or {} do
                table.insert(v53, v);
            end;
        end;

        return v53;
    end;

    local v54 = {};
    local v55 = {};

    for i in p46.ActiveSources do
        table.insert(v54, i);
    end;

    while #v54 > 0 do
        local table_remove_ret = table.remove(v54);

        if not v55[table_remove_ret] then
            local v56 = nextOf(table_remove_ret);
            v55[table_remove_ret] = v56;

            for _, v in v56 do
                if not v55[v] then
                    table.insert(v54, v);
                end;
            end;
        end;
    end;

    local v57 = {};

    for i in v55 do
        if u4(i, "ClassName") == "AudioDeviceOutput" then
            local success, result = pcall(u4, i, "Player");

            if success and (result == nil or result == LocalPlayer) then
                v57[i] = true;
            end;
        end;
    end;

    local v58 = true;

    while true do
        if not v58 then
            local v59 = {};

            for i in v57 do
                v59[i] = true;

                for _, v in u47[i] or {} do
                    if v57[u4(v, "TargetInstance")] then
                        v59[v] = true;
                    end;
                end;
            end;

            p46.Graph = v59;

            return;
        end;

        v58 = false;

        for i, v in v55 do
            if not v57[i] then
                local v60 = i;

                for _, v2 in v do
                    if v57[v2] then
                        v57[v60] = true;
                        v58 = true;
                        break;
                    end;
                end;
            end;
        end;
    end;
end;

function u18._serviceId(p61: table, p62: userdata?) -- Line: 524
    -- upvalues: RootId (copy), SoundService (copy)
    if p62 == nil or p62 == workspace then
        return RootId.Workspace;
    end;

    if p62 == SoundService then
        return p61:_ensure(SoundService) or RootId.Workspace;
    end;

    return p61.Registry:StandIn(p62);
end;

function u18._containerOf(p63: table, p64: userdata?) -- Line: 536
    -- upvalues: RootId (copy), SoundService (copy), Observability (copy)
    if p64 == nil then
        return RootId.Workspace, nil, nil;
    end;

    local v65 = p63.Nodes[p64];

    if v65 then
        return v65.Id, nil, v65;
    end;

    if p64 == SoundService then
        return p63:_serviceId(SoundService), nil, nil;
    end;

    if not Observability.IsAudio(p64) then
        local v66 = p63.Registry:Resolve(p64);

        if v66 then
            return v66, p64, nil;
        end;
    end;

    while p64.Parent and p64.Parent ~= game do
        p64 = p64.Parent;
    end;

    if p64.Parent ~= game then
        p64 = nil;
    end;

    return p63:_serviceId(p64), nil, nil;
end;

function u18._placement(p67: table, p68: userdata, p69: string) -- Line: 561
    -- upvalues: u4 (ref), SoundService (copy), RootId (copy), u7 (copy)
    local v70 = u4(p68, "Parent");

    if p68 == SoundService then
        return RootId.Workspace, nil, nil, "none";
    end;

    local v71 = p67.Ghosts[p68];

    if v71 then
        local Workspace = RootId.Workspace;
        local v72 = nil;
        local v73 = nil;

        if v71.CFrame then
            return Workspace, v72, v73, "world";
        end;

        return Workspace, v72, v73, "none";
    end;

    local v74 = p69 == "SoundGroup" and (v70 and v70:IsA("SoundGroup")) and (p67.Nodes[v70] or p67:_ensureNode(v70));

    if v74 then
        return v74.Id, nil, v74, "none";
    end;

    if not u7[p69] then
        local v75, v76, v77 = p67:_containerOf(v70);

        return v75, v76, v77, "none";
    end;

    if p69 ~= "Sound" and (v70 and v70 == workspace.CurrentCamera) then
        local v78, v79, v80 = p67:_containerOf(v70);

        return v78, v79, v80, "camera";
    end;

    local v81;

    if v70 == nil then
        v81 = false;
    else
        v81 = v70:IsA("BasePart") or v70:IsA("Attachment");
    end;

    if not v81 then
        if p69 == "Sound" or v70 == nil then
            v81 = false;
        else
            v81 = v70:IsA("PVInstance");
        end;
    end;

    if not v81 then
        local v82, v83, v84 = p67:_containerOf(v70);

        return v82, v83, v84, "none";
    end;

    if v70 == v70 then
        local v85;

        if v70 == nil then
            v85 = false;
        else
            v85 = v70:IsA("BasePart") or v70:IsA("Attachment");
        end;

        local v86 = v85 and p67.Registry:Resolve(v70);

        if v86 then
            return v86, v70, nil, "parent";
        end;
    end;

    local v87, v88, v89 = p67:_containerOf(v70);

    return v87, v88, v89, "world";
end;

local function contentUri(p90: userdata) -- Line: 605
    -- upvalues: u4 (ref)
    local success, result = pcall(u4, p90, "AudioContent");

    if not success or typeof(result) ~= "Content" then
        return "";
    end;

    local Uri = result.Uri;

    return type(Uri) ~= "string" and "" or Uri;
end;

function u18._read(p91: table, p92: table, u93: string) -- Line: 615
    -- upvalues: WorldCFrameProperty (copy), worldCFrameOf (copy), u4 (ref), OnCameraProperty (copy), DistanceAttenuationProperty (copy), AngleAttenuationProperty (copy), serializeCurve (copy), MasterVolumeProperty (copy), SoundService (copy)
    local Inst = p92.Inst;
    local v94 = p91.Ghosts[Inst];

    if u93 == WorldCFrameProperty then
        if p92.Mode ~= "world" then
            return false, nil;
        end;

        if v94 then
            return v94.CFrame ~= nil, v94.CFrame;
        end;

        local v95 = worldCFrameOf(u4(Inst, "Parent"));

        return v95 ~= nil, v95;
    end;

    if u93 == OnCameraProperty then
        return p92.Mode == "camera", true;
    end;

    if u93 == DistanceAttenuationProperty or u93 == AngleAttenuationProperty then
        local success, result = pcall(function() -- Line: 630
            -- upvalues: u93 (copy), DistanceAttenuationProperty (ref), Inst (copy)
            if u93 == DistanceAttenuationProperty then
                return Inst:GetDistanceAttenuation();
            end;

            return Inst:GetAngleAttenuation();
        end);

        if not success then
            result = nil;
        end;

        return success, serializeCurve(result);
    end;

    if u93 == MasterVolumeProperty then
        if not p91.MasterVolumeReadable then
            return false, nil;
        end;

        local success, result = pcall(function() -- Line: 640
            return UserSettings():GetService("UserGameSettings").MasterVolume;
        end);
        p91.MasterVolumeReadable = success;

        return success, result;
    end;

    if Inst ~= SoundService or u93 ~= "ListenerType" and u93 ~= "ListenerCFrame" then
        local success, result = pcall(u4, Inst, u93);

        if success and (u93 == "SoundId" or u93 == "Asset") and result == "" then
            local success2, result2 = pcall(u4, Inst, "AudioContent");

            if success2 and typeof(result2) == "Content" then
                local Uri = result2.Uri;

                if type(Uri) == "string" then
                    return success, Uri;
                end;

                return success, "";
            end;

            result = "";
        end;

        return success, result;
    end;

    local Listener, v96 = SoundService:GetListener();

    if u93 == "ListenerType" then
        return true, Listener;
    end;

    if Listener == Enum.ListenerType.CFrame then
        return typeof(v96) == "CFrame", v96;
    end;

    if Listener == Enum.ListenerType.Camera or typeof(v96) ~= "Instance" then
        return false, nil;
    end;

    local v97 = worldCFrameOf(v96);

    return v97 ~= nil, v97;
end;

function u18._stored(p98: table, p99: number, p100: any) -- Line: 668
    -- upvalues: ValueType (copy)
    if p99 ~= ValueType.Ref then
        return p100;
    end;

    if typeof(p100) == "Instance" then
        return p98.Registry.Ids[p100];
    end;

    return nil;
end;

function u18._writeProp(p101: table, p102: table, p103: any, p104: any, p105: number, p106: number?) -- Line: 675
    -- upvalues: Op (copy), Codec (copy)
    local Stream = p101.Registry.Stream;
    Stream:Time(p105);
    local W = Stream.W;

    if p106 then
        W:u8(Op.PropLerp);
        Codec.varuint(W, p102.Id);
        Codec.varuint(W, p103.Id);
        local math_round_ret = math.round(p106 / 10);
        W:u8((math.clamp(math_round_ret, 1, 255)));
    else
        W:u8(Op.Prop);
        Codec.varuint(W, p102.Id);
        Codec.varuint(W, p103.Id);
    end;

    Codec.writeValue(W, p103.Type, p104);
    Stream:EndRecord();
end;

function u18._ensureNode(p107: table, p108: userdata) -- Line: 695
    local v109 = p107.Nodes[p108];

    if v109 then
        return v109;
    end;

    if not p107.Wanted[p108] then
        return nil;
    end;

    local v110 = p107:_ensure(p108) and p107.Nodes[p108];

    return v110;
end;

function u18._ensure(p111: table, p112: userdata) -- Line: 708
    -- upvalues: u4 (ref), Codec (copy)
    local v113 = p111.Nodes[p112];

    if v113 then
        return v113.Id;
    end;

    local Registry = p111.Registry;
    local v114 = u4(p112, "ClassName");
    local v115 = Registry.ClassIndex[v114];
    local v116 = Registry.ClassProps[v114];

    if v115 == nil or v116 == nil then
        return nil;
    end;

    if v114 == "Sound" then
        local v117 = u4(p112, "SoundGroup");

        if v117 then
            p111:_ensureNode(v117);
        end;
    elseif v114 == "Wire" then
        for _, v in { "SourceInstance", "TargetInstance" } do
            local v118 = u4(p112, v);

            if v118 then
                p111:_ensureNode(v118);
            end;
        end;
    end;

    local v119 = nil;
    local v120, v121, v122;

    if p112:IsA("SoundEffect") then
        v120 = p111:_ensureNode(u4(p112, "Parent"));

        if not v120 then
            return nil;
        end;

        v121 = v120.Id;
        v122 = "none";
    else
        v121, v119, v120, v122 = p111:_placement(p112, v114);
    end;

    if p111.Nodes[p112] then
        return p111.Nodes[p112].Id;
    end;

    local v123 = p111.Clock();
    local v124 = Registry:Allocate(p112, v121);
    local v125 = Registry:AddTime(v123);
    local v126 = {
        Position = 0,
        Speed = 0,
        Inst = p112,
        ClassName = v114,
        Id = v124,
        ParentId = v121,
        ParentInst = v119,
        ParentNode = v120,
        Children = {},
        Mode = v122,
        Values = {},
        PollTime = v125,
        CurveTime = v125,
        PositionTime = v125,
        WantedAt = v123
    };

    if v120 then
        v120.Children[v126] = true;
    end;

    p111.Nodes[p112] = v126;
    local v127 = Registry:DefaultsFor(v114) or {};
    local W = Registry.Stream.W;
    Registry.Copies:WriteHead(W, v124, v121, v115, u4(p112, "Name"), false);
    local len = W.len;
    W:u16(0);
    local v128 = p111.Ghosts[p112];
    local v129 = 0;

    for _, v in v116 do
        local Name = v.Name;
        local v130, v131 = p111:_read(v126, Name);

        if v130 then
            if Name == "TimePosition" then
                local success, result = pcall(u4, p112, "PlaybackSpeed");
                v126.Speed = (not success or type(result) ~= "number") and 1 or result;

                if v128 then
                    v131 = v128.Position;
                end;

                v131 = v131 + (v125 - v123) / 1000 * v126.Speed;
                v126.Position = v131;
                v126.PositionTime = v125;
            end;

            local v132 = p111:_stored(v.Type, v131);
            v126.Values[Name] = v132;

            if Name == "TimePosition" or v132 ~= nil and v127[v.Id] ~= v131 then
                Codec.varuint(W, v.Id);
                Codec.writeValue(W, v.Type, v131);
                v129 = v129 + 1;
            end;
        end;
    end;

    W:patchU16(len, v129);
    Registry.Stream:EndRecord();

    return v124;
end;

function u18._forget(p133: table, p134: table) -- Line: 813
    for i in p134.Children do
        p133:_forget(i);
    end;

    if p134.ParentNode then
        p134.ParentNode.Children[p134] = nil;
    end;

    p133.Nodes[p134.Inst] = nil;
    p133.Registry:Free(p134.Inst);
end;

function u18._remove(p135: table, p136: table, p137: number) -- Line: 824
    -- upvalues: Op (copy), Codec (copy)
    local Stream = p135.Registry.Stream;
    Stream:Time((math.max(p137, p136.PollTime)));
    local W = Stream.W;
    W:u8(Op.Remove);
    Codec.varuint(W, p136.Id);
    Stream:EndRecord();
    p135:_forget(p136);
end;

function u18._drifted(p138: table, p139: table, p140: number, p141: number) -- Line: 835
    -- upvalues: u4 (ref)
    local Inst = p139.Inst;
    local v142 = p140 - (p139.Position + (p141 - p139.PositionTime) / 1000 * p139.Speed);
    local success, result = pcall(u4, Inst, "TimeLength");
    local success2, result2 = pcall(u4, Inst, p139.ClassName == "Sound" and "Looped" or "Looping");

    if success and (success2 and (result2 and result > 0)) then
        local success3, result3 = pcall(u4, Inst, "LoopRegion");

        if success3 and ((p139.ClassName ~= "Sound" and true or u4(Inst, "PlaybackRegionsEnabled")) and (typeof(result3) == "NumberRange" and result3.Max > result3.Min)) then
            result = math.min(result3.Max, result) - result3.Min;
        end;

        if result > 0 then
            v142 = (v142 + result / 2) % result - result / 2;
        end;
    end;

    return math.abs(v142) > 0.05;
end;

function u18._poll(p143: table, p144: table, p145: number) -- Line: 855
    -- upvalues: DistanceAttenuationProperty (copy), AngleAttenuationProperty (copy), differs (copy), ValueType (copy), u4 (ref)
    local v146 = p143.Registry.ClassProps[p144.ClassName];
    local v147 = p145 - p144.PollTime;

    if v147 <= 0 or v147 > 300 then
        v147 = nil;
    end;

    local v148 = p143.Ghosts[p144.Inst] ~= nil;
    local v149 = p145 - p144.CurveTime >= 500;

    if v149 then
        p144.CurveTime = p145;
    end;

    local v150 = false;

    for _, v in v146 do
        local Name = v.Name;

        if Name ~= "TimePosition" and (not v148 or Name == "Volume") and (Name ~= DistanceAttenuationProperty and Name ~= AngleAttenuationProperty or v149) then
            local v151, v152 = p143:_read(p144, Name);

            if v151 then
                local v153 = p143:_stored(v.Type, v152);

                if differs(v.Type, p144.Values[Name], v153) then
                    p144.Values[Name] = v153;

                    if v.Type == ValueType.Ref and (v152 ~= nil and v153 == nil) then
                        v152 = nil;
                    end;

                    v150 = (Name == "PlaybackSpeed" or (Name == "Looped" or Name == "Looping")) and true or v150;
                    local v154;

                    if v.Type == ValueType.Float32 or v.Type == ValueType.CFrame then
                        v154 = v147;
                    else
                        v154 = nil;
                    end;

                    p143:_writeProp(p144, v, v152, p145, v154);
                end;
            end;
        end;
    end;

    local success, result = pcall(u4, p144.Inst, "TimePosition");

    if success and (not v148 and type(result) == "number") then
        if v150 or p143:_drifted(p144, result, p145) then
            for _, v in v146 do
                if v.Name == "TimePosition" then
                    p143:_writeProp(p144, v, result, p145);
                    break;
                end;
            end;

            p144.Position = result;
            p144.PositionTime = p145;
        end;

        local success2, result2 = pcall(u4, p144.Inst, "PlaybackSpeed");

        if success2 and math.abs(result2 - p144.Speed) > 0.001 then
            p144.Position = result;
            p144.PositionTime = p145;
            p144.Speed = result2;
        end;
    end;

    p144.PollTime = p145;
end;

function u18._collect(p155: table, p156: number) -- Line: 917
    -- upvalues: SoundService (copy), u4 (ref)
    local u157 = {};
    p155.Wanted = u157;
    u157[SoundService] = true;

    local function wantGroupChain(p158: userdata?) -- Line: 922
        -- upvalues: u157 (copy)
        while p158 and (p158:IsA("SoundGroup") and not u157[p158]) do
            u157[p158] = true;

            for _, child in p158:GetChildren() do
                if child:IsA("SoundEffect") then
                    u157[child] = true;
                end;
            end;

            p158 = p158.Parent;
        end;
    end;

    local function wantSound(p159: userdata) -- Line: 933
        -- upvalues: u157 (copy), wantGroupChain (copy)
        u157[p159] = true;

        for _, child in p159:GetChildren() do
            if child:IsA("SoundEffect") then
                u157[child] = true;
            end;
        end;

        wantGroupChain(p159.SoundGroup);
    end;

    for i in p155.Candidates do
        if p155:_soundAudible(i) then
            wantSound(i);
        elseif not i.Playing then
            p155.Candidates[i] = nil;
        end;
    end;

    for i, v in p155.Ghosts do
        if v.EndsAt <= p156 then
            p155.Ghosts[i] = nil;
        else
            wantSound(i);
        end;
    end;

    local ActiveSources = p155.ActiveSources;

    for i, v in p155.GraphSources do
        if i:IsDescendantOf(game) then
            local success, result = pcall(u4, i, v);

            if success then
                success = result == true;
            end;

            if success ~= (ActiveSources[i] == true) then
                ActiveSources[i] = success and true or nil;
                p155.GraphDirty = true;
            end;
        else
            p155.GraphSources[i] = nil;
            p155.Seen[i] = nil;
        end;
    end;

    for i in ActiveSources do
        if p155.GraphSources[i] == nil then
            ActiveSources[i] = nil;
            p155.GraphDirty = true;
        end;
    end;

    if p155.GraphDirty or p156 - p155.GraphTime >= 1000 then
        p155.GraphDirty = false;
        p155.GraphTime = p156;

        if next(ActiveSources) or next(p155.Graph) then
            p155:_traceGraph();
        end;
    end;

    for i in p155.Graph do
        u157[i] = true;
    end;
end;

function u18.Flush(p160) -- Line: 993
    -- upvalues: SoundService (copy)
    if p160.Destroyed or not (p160.Registry and p160.Enabled) then
        return;
    end;

    local v161 = p160.Clock();
    p160:_walk(os.clock() + (p160.Walked and 0.0005 or 0.002));

    if #p160.WalkQueue == 0 then
        p160.Walked = true;
    end;

    p160:_collect(v161);
    local Wanted = p160.Wanted;
    local Ids = p160.Registry.Ids;

    for i, v in table.clone(p160.Nodes) do
        if p160.Nodes[i] == v then
            local v162;

            if v.ParentInst == nil or Ids[v.ParentInst] == v.ParentId then
                if v.ParentNode == nil then
                    v162 = false;
                else
                    v162 = p160.Nodes[v.ParentNode.Inst] ~= v.ParentNode;
                end;
            else
                v162 = true;
            end;

            if v162 then
                p160:_forget(v);
            else
                local v163 = Wanted[i] ~= nil;

                if v163 then
                    v.WantedAt = v161;
                elseif p160.GraphSources[i] == nil and (i ~= SoundService and v.ClassName ~= "Sound") then
                    if v161 - v.WantedAt < 3000 then
                        v163 = i:IsDescendantOf(game);
                    else
                        v163 = false;
                    end;
                end;

                if v163 then
                    if not (i:IsA("SoundEffect") or (i == SoundService or p160.Ghosts[i])) then
                        local v164, _, _, v165 = p160:_placement(i, v.ClassName);

                        if v164 ~= v.ParentId or v165 ~= v.Mode then
                            p160:_remove(v, v161);
                        end;
                    end;
                else
                    p160:_remove(v, v161);
                end;
            end;
        end;
    end;

    for i in Wanted do
        local v166 = p160.Nodes[i];

        if v166 then
            p160:_poll(v166, v161);
        elseif i ~= SoundService or p160.Nodes[SoundService] == nil then
            p160:_ensure(i);
        end;
    end;

    for i, v in p160.Nodes do
        if not Wanted[i] and v.PollTime < v161 then
            p160:_poll(v, v161);
        end;
    end;
end;

function u18.Destroy(p167) -- Line: 1054
    p167.Destroyed = true;

    for _, v in p167.Connections do
        v:Disconnect();
    end;

    table.clear(p167.Connections);

    for _, v in p167.SoundSignals do
        for _, v2 in v do
            v2:Disconnect();
        end;
    end;

    table.clear(p167.SoundSignals);
    table.clear(p167.Nodes);
    table.clear(p167.Candidates);
    table.clear(p167.Ghosts);
end;

return u18;