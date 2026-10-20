-- Decompiled with Potassium's decompiler.

local EncodingService = game:GetService("EncodingService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Stream = require(ReplicatedStorage.UserGenerated.Observability.Stream);
local Registry = require(ReplicatedStorage.UserGenerated.Observability.Registry);
local Recorder = require(ReplicatedStorage.UserGenerated.Observability.Recorder);
local WorldRecorder = require(ReplicatedStorage.UserGenerated.Observability.WorldRecorder);
local AnimationRecorder = require(ReplicatedStorage.UserGenerated.Observability.AnimationRecorder);
local SoundRecorder = require(ReplicatedStorage.UserGenerated.Observability.SoundRecorder);
local ParticleRecorder = require(ReplicatedStorage.UserGenerated.Observability.ParticleRecorder);
local Styles = require(ReplicatedStorage.UserGenerated.Observability.Styles);
local InputCapture = require(ReplicatedStorage.UserGenerated.Observability.InputCapture);
local BackpackRecorder = require(ReplicatedStorage.UserGenerated.Observability.BackpackRecorder);
local Uplink = require(ReplicatedStorage.UserGenerated.Observability.Uplink);
local Remotes = Observability.Remotes;
local u1 = false;
local u2 = nil;

local function run(p3) -- Line: 38
    -- upvalues: u2 (ref), Remotes (copy), Observability (copy), Styles (copy), Uplink (copy), RunService (copy), Stream (copy), EncodingService (copy), InputCapture (copy), SoundRecorder (copy), ParticleRecorder (copy), Registry (copy), BackpackRecorder (copy), Recorder (copy), AnimationRecorder (copy), WorldRecorder (copy)
    local os_clock_ret = os.clock();
    local ServerTimeNow = workspace:GetServerTimeNow();

    local function clock() -- Line: 41
        -- upvalues: os_clock_ret (copy)
        return (os.clock() - os_clock_ret) * 1000;
    end;

    local u4 = false;
    local u5 = nil;
    local u6 = nil;
    local u7 = nil;
    local u8 = nil;
    local u9 = nil;
    local u10 = nil;
    local u11 = nil;
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;

    local function stop(p15: string, p16: boolean) -- Line: 48
        -- upvalues: u4 (ref), u14 (ref), u2 (ref), Remotes (ref), u13 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), Observability (ref), u6 (ref), Styles (ref), u12 (ref), u5 (ref)
        if u4 then
            return;
        end;

        u4 = true;

        if u14 then
            u14:Destroy();
        end;

        u2 = nil;

        if p16 then
            Remotes.Stop:FireServer(p15);
        end;

        if u13 then
            u13:Disconnect();
        end;

        if u7 then
            u7:Destroy();
        end;

        if u8 then
            u8:Destroy();
        end;

        if u9 then
            u9:Destroy();
        end;

        if u10 then
            u10:Destroy();
        end;

        if u11 then
            u11:Destroy();
        end;

        Observability.SetEmitSink(nil);

        if u6 then
            u6:Destroy();
        end;

        Styles.Clear();

        if u12 then
            u12:Destroy();
        end;

        u5.Stopped = true;
    end;

    u2 = stop;
    u5 = Uplink.new(p3, function(p17) -- Line: 90
        -- upvalues: Remotes (ref)
        Remotes.Data:FireServer(p17);
    end, function(p18) -- Line: 92
        -- upvalues: stop (copy)
        stop(p18, true);
    end);
    u13 = RunService.Heartbeat:Connect(function(p19) -- Line: 95
        -- upvalues: u5 (ref)
        u5:Step(p19);
    end);
    local task_wait = task.wait;
    local v20 = os_clock_ret + p3.CaptureDelay - os.clock();
    task_wait((math.max(0, v20)));

    if u4 then
        return;
    end;

    local v23 = Stream.new(p3.BatchBytes, function(p21, p22) -- Line: 104
        -- upvalues: u5 (ref), EncodingService (ref)
        u5:Push(EncodingService:CompressBuffer(p21, Enum.CompressionAlgorithm.Zstd, 3), p22);
    end);
    u12 = InputCapture.new(clock);

    if p3.Audio == false then
        u10 = nil;
    else
        u10 = SoundRecorder.new(clock);
    end;

    if p3.Workspace.Enabled then
        u11 = ParticleRecorder.new(p3.Particles, clock);
        Observability.SetEmitSink(function(p24, p25) -- Line: 111
            -- upvalues: u11 (ref)
            u11:Emit(p24, p25);
        end);
    end;

    u6 = Registry.new(p3.Manifest, v23, clock);

    if p3.BackpackData == true then
        u14 = BackpackRecorder.new(u6);
    end;

    u7 = Recorder.new(u6, p3.PlayerGui.Enabled, false);
    u6:SetFilter(u7.PlayerGui, p3.PlayerGui);

    if p3.Workspace.Enabled then
        u6:SetFilter(workspace, p3.Workspace);
    end;

    v23.Init = true;
    v23:Time((os.clock() - os_clock_ret) * 1000);
    v23:ClockSync(ServerTimeNow);
    u12:WriteViewport(v23, true);

    if u14 then
        u14:Flush();
    end;

    local v26 = { u7.PlayerGui };

    if p3.Workspace.Enabled then
        table.insert(v26, workspace);
    end;

    Styles.Build(v26, u6.ClassPropsByName);
    u7:Snapshot();
    v23:Cut();
    v23.Init = false;

    if u4 then
        return;
    end;

    if p3.Workspace.Enabled then
        u9 = AnimationRecorder.new(u6);
        u8 = WorldRecorder.new(u6, function(p27: userdata) -- Line: 151
            -- upvalues: u7 (ref)
            u7:IdOf(p27);
        end, function(p28: userdata) -- Line: 153
            -- upvalues: u9 (ref)
            u9:Watch(p28);
        end, p3.MaxWorldInstances or 50000, p3.BakeModels ~= false);
        u7:StartWorld();
        u5:Burst(p3.BurstSeconds);
        v23:Time((os.clock() - os_clock_ret) * 1000);
        u8:WriteCamera();
        u8:Snapshot();
    end;

    if u10 then
        u10:Bind(u6);
    end;

    if u11 and u8 then
        u11:Bind(u8);
    end;

    if u4 then
        return;
    end;

    local function idOf(p29: userdata?) -- Line: 172
        -- upvalues: u7 (ref)
        return u7:IdOf(p29);
    end;

    local v30 = 1 / p3.TickRate;
    local os_clock_ret2 = os.clock();
    local v31 = os.clock() + v30;
    local os_clock_ret3 = os.clock();

    while not u4 do
        local task_wait2 = task.wait;
        local v32;

        if u8 then
            v32 = os_clock_ret3;
        else
            v32 = v31;
        end;

        local v33 = math.min(v31, v32) - os.clock();
        task_wait2((math.max(0, v33)));

        if u4 then
            break;
        end;

        local os_clock_ret4 = os.clock();
        local v34 = v31 <= os_clock_ret4;
        local v35;

        if u8 == nil then
            v35 = false;
        else
            v35 = os_clock_ret3 <= os_clock_ret4;
        end;

        if v34 or v35 then
            if v34 then
                v31 = v31 + v30;

                if v31 <= os_clock_ret4 then
                    v31 = os_clock_ret4 + v30;
                end;
            end;

            v23:BeginStage();

            if v34 then
                u12:Flush(v23, idOf);

                if u14 then
                    u14:Flush();
                end;

                u7:Flush();

                if u8 then
                    u8:Flush();
                end;

                if u9 then
                    u9:Flush();
                end;

                if u10 then
                    u10:Flush();
                end;

                if u11 then
                    u11:Flush();
                end;
            end;

            if v35 then
                os_clock_ret3 = u8:PollPlayers();
            end;

            v23:CommitStage();

            if os.clock() - os_clock_ret2 >= 1 then
                os_clock_ret2 = os.clock();
                v23:Cut();
            end;
        end;
    end;
end;

Remotes.Start.OnClientEvent:Connect(function(u36) -- Line: 230
    -- upvalues: u1 (ref), run (copy), u2 (ref)
    if u1 then
        return;
    end;

    u1 = true;
    task.spawn(function() -- Line: 235
        -- upvalues: run (ref), u36 (copy), u2 (ref)
        local success, result = pcall(run, u36);

        if not success then
            warn("[UGUIReplay]", result);

            if u2 then
                u2("error", true);
            end;
        end;
    end);
end);
Remotes.Emit.OnClientEvent:Connect(function(p37, p38) -- Line: 248
    -- upvalues: Observability (copy)
    if typeof(p37) == "Instance" and type(p38) == "number" then
        Observability.RecordEmit(p37, p38);
    end;
end);
Remotes.Stop.OnClientEvent:Connect(function(p39: string) -- Line: 254
    -- upvalues: u2 (ref)
    if u2 then
        u2(p39, false);
    end;
end);
Players.LocalPlayer.OnTeleport:Connect(function(p40) -- Line: 262
    -- upvalues: u2 (ref), Remotes (copy)
    if not u2 then
        return;
    end;

    if p40 == Enum.TeleportState.Started then
        Remotes.Teleport:FireServer(true);

        return;
    end;

    if p40 == Enum.TeleportState.Failed then
        Remotes.Teleport:FireServer(false);
    end;
end);