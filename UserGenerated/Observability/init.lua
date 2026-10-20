-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local u1 = {
    Version = 11,
    RootId = table.freeze({
        PlayerGui = 0,
        Workspace = 1,
        Lighting = 2
    }),
    FirstInstanceId = 3,
    Op = table.freeze({
        Time = 0,
        Add = 1,
        Remove = 2,
        Reparent = 3,
        Rename = 4,
        Prop = 5,
        Viewport = 6,
        Pointer = 7,
        Selected = 8,
        SafeArea = 9,
        Defaults = 10,
        PropLerp = 11,
        SeqCopy = 12,
        SeqShift = 13,
        Camera = 14,
        CFramePos = 15,
        CFrameRot = 16,
        UDim2Part = 17,
        CFrameMotion = 18,
        Copy = 19,
        KeyDown = 20,
        KeyUp = 21,
        CameraFollow = 22,
        Keyframe = 23,
        ClockSync = 24,
        Emit = 25,
        PropMany = 26,
        DropTemplates = 27,
        TemplateNext = 28,
        Template = 29,
        CopyBase = 30,
        Start = 31,
        TimeDelta = 32,
        CFrameDelta = 33
    }),
    TemplateNext = table.freeze({
        Add = 1,
        Keep = 2
    }),
    ValueType = table.freeze({
        Bool = 1,
        Int32 = 2,
        Float32 = 3,
        Float64 = 4,
        String = 5,
        Enum = 6,
        UDim = 7,
        UDim2 = 8,
        Vector2 = 9,
        Vector3 = 10,
        Color3 = 11,
        Rect = 12,
        Font = 13,
        ColorSequence = 14,
        NumberSequence = 15,
        NumberRange = 16,
        Content = 17,
        CFrame = 18,
        Vector2int16 = 19,
        Int64 = 20,
        Ref = 21
    }),
    PointerKind = table.freeze({
        Mouse = 1,
        Touch = 2,
        VirtualCursor = 3
    }),
    PointerState = table.freeze({
        Move = 0,
        Down = 1,
        Up = 2
    }),
    StopReason = table.freeze({
        Dropped = "dropped",
        Capped = "capped",
        Closed = "closed"
    }),
    AssemblyRootProperty = "AssemblyRoot",
    SurfaceIdAttribute = "__UG_SurfaceId",
    SurfaceIdProperty = "SurfaceId",
    BakedTag = "UG_REPLAY_BAKED",
    BakedIdAttribute = "UG_REPLAY_BAKED_ID",
    BakedOriginAttribute = "UG_REPLAY_BAKED_ORIGIN",
    UnbakedTag = "UG_REPLAY_UNBAKED",
    UnbakedAttribute = "UG_REPLAY_UNBAKED",
    BakeIdProperty = "BakeId",
    PivotProperty = "Pivot",
    AudioSources = table.freeze({
        Sound = true,
        AudioPlayer = true,
        AudioTextToSpeech = true,
        AudioWindSynthesizer = true
    }),
    AudioEffects = table.freeze({
        AudioFader = true,
        AudioEqualizer = true,
        AudioFilter = true,
        AudioReverb = true,
        AudioEcho = true,
        AudioCompressor = true,
        AudioLimiter = true,
        AudioGate = true,
        AudioPitchShifter = true,
        AudioChorus = true,
        AudioFlanger = true,
        AudioTremolo = true,
        AudioDistortion = true,
        AudioChannelMixer = true,
        AudioChannelSplitter = true
    }),
    AudioClasses = table.freeze({
        Sound = true,
        SoundGroup = true,
        SoundService = true,
        AudioPlayer = true,
        AudioTextToSpeech = true,
        AudioWindSynthesizer = true,
        AudioEmitter = true,
        AudioListener = true,
        AudioDeviceOutput = true,
        Wire = true
    })
};
local u2 = {};

function u1.IsAudio(p3: userdata) -- Line: 542
    -- upvalues: u2 (copy), u1 (copy)
    local ClassName = p3.ClassName;
    local v4 = u2[ClassName];

    if v4 == nil then
        v4 = (u1.AudioClasses[ClassName] == true or u1.AudioEffects[ClassName] == true) and true or p3:IsA("SoundEffect");
        u2[ClassName] = v4;
    end;

    return v4;
end;

u1.EmissionScaleProperty = "EmissionScale";
u1.WorldCFrameProperty = "WorldCFrame";
u1.OnCameraProperty = "OnCamera";
u1.DistanceAttenuationProperty = "DistanceAttenuation";
u1.AngleAttenuationProperty = "AngleAttenuation";
u1.MasterVolumeProperty = "MasterVolume";
u1.PolledProperties = table.freeze({});
u1.MaxMessageBytes = 131072;
u1.MaxStringBytes = 16384;
u1.Remotes = table.freeze({
    Start = script:WaitForChild("Start"),
    Data = script:WaitForChild("Data"),
    Stop = script:WaitForChild("Stop"),
    Teleport = script:WaitForChild("Teleport"),
    Emit = script:WaitForChild("Emit")
});
local u5 = nil;

function u1.RecordEmit(p6: userdata, p7: number?) -- Line: 605
    -- upvalues: u5 (ref)
    if typeof(p6) ~= "Instance" or not p6:IsA("ParticleEmitter") then
        return;
    end;

    local v8 = tonumber(p7) or 16;
    local math_floor_ret = math.floor(v8);
    local v9 = u5;

    if v9 and math_floor_ret > 0 then
        v9(p6, math_floor_ret);
    end;
end;

function u1.SetEmitSink(p10: function?) -- Line: 617
    -- upvalues: u5 (ref)
    u5 = p10;
end;

u1.DefaultCaptureInterval = 0.05;
u1.LocalCaptureInterval = 0.016666666666666666;
u1.MinCaptureInterval = 0.016666666666666666;
u1.MaxCaptureInterval = 0.25;
u1.CaptureIntervalAttribute = "UG_REPLAY_CAPTURE_INTERVAL";
local u11 = nil;
local u12 = nil;

local function askCaptureRate(p13: function, p14: userdata) -- Line: 641
    -- upvalues: u1 (copy)
    local success, result = pcall(p13, p14);

    if not success then
        warn("[UGUIReplay] capture rate callback:", result);

        return nil;
    end;

    local v15 = tonumber(result);

    if v15 and v15 == v15 then
        return math.clamp(v15, u1.MinCaptureInterval, u1.MaxCaptureInterval);
    end;

    return nil;
end;

local function refreshCaptureRates(p16: function?) -- Line: 654
    -- upvalues: Players (copy), u1 (copy)
    for _, v in Players:GetPlayers() do
        local v17;

        if p16 then
            local success, result = pcall(p16, v);

            if success then
                local v18 = tonumber(result);

                if v18 and v18 == v18 then
                    v17 = math.clamp(v18, u1.MinCaptureInterval, u1.MaxCaptureInterval);
                else
                    v17 = nil;
                end;
            else
                warn("[UGUIReplay] capture rate callback:", result);
                v17 = nil;
            end;
        else
            v17 = nil;
        end;

        if v:GetAttribute(u1.CaptureIntervalAttribute) ~= v17 then
            v:SetAttribute(u1.CaptureIntervalAttribute, v17);
        end;
    end;
end;

function u1.SetCaptureRateCallback(u19: function?) -- Line: 682
    -- upvalues: u11 (ref), RunService (copy), u12 (ref), refreshCaptureRates (copy)
    if u19 ~= nil and type(u19) ~= "function" then
        return;
    end;

    u11 = u19;

    if not RunService:IsServer() then
        return;
    end;

    if u12 then
        task.cancel(u12);
        u12 = nil;
    end;

    refreshCaptureRates(u19);

    if u19 then
        u12 = task.spawn(function() -- Line: 696
            -- upvalues: refreshCaptureRates (ref), u19 (copy)
            while true do
                task.wait(0.25);
                refreshCaptureRates(u19);
            end;
        end);
    end;
end;

function u1.CaptureIntervalOf(p20: userdata) -- Line: 706
    -- upvalues: u11 (ref), RunService (copy), u1 (copy), Players (copy)
    local v21 = u11;

    if v21 and not RunService:IsServer() then
        local success, result = pcall(v21, p20);
        local v22;

        if success then
            local v23 = tonumber(result);

            if v23 and v23 == v23 then
                v22 = math.clamp(v23, u1.MinCaptureInterval, u1.MaxCaptureInterval);
            else
                v22 = nil;
            end;
        else
            warn("[UGUIReplay] capture rate callback:", result);
            v22 = nil;
        end;

        if v22 then
            return v22;
        end;
    end;

    local Attribute = p20:GetAttribute(u1.CaptureIntervalAttribute);

    if type(Attribute) == "number" and Attribute == Attribute then
        return math.clamp(Attribute, u1.MinCaptureInterval, u1.MaxCaptureInterval);
    end;

    if p20 == Players.LocalPlayer then
        return u1.LocalCaptureInterval;
    end;

    return u1.DefaultCaptureInterval;
end;

return table.freeze(u1);