-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MicroprofileCapture = require(ReplicatedStorage.UserGenerated.Analytics.MicroprofileCapture);
local RunService = game:GetService("RunService");
local LogService = game:GetService("LogService");
local Stats = game:GetService("Stats");
local GuiService = game:GetService("GuiService");
local Workspace = game:GetService("Workspace");
local DeviceForm = require(ReplicatedStorage.UserGenerated.Roblox.DeviceForm);
local MicroProfilerConfig = require(ReplicatedStorage.UserGenerated.Analytics.MicroProfilerConfig);
local DataModel = require(ReplicatedStorage.UserGenerated.DataModel);
local LocalPlayer = Players.LocalPlayer;

local function diag(...) -- Line: 52
end;

local function diagWarn(...) -- Line: 57
end;

diag("script running; userId =", LocalPlayer.UserId);

local function WaitRemote(p1: string) -- Line: 70
    -- upvalues: diag (copy), diagWarn (copy)
    local v2 = script.Parent:WaitForChild(p1, 10);

    if v2 then
        diag("resolved remote:", p1, (`({v2.ClassName})`));

        return v2;
    end;

    diagWarn("MISSING remote (WaitForChild timed out after 10s):", p1);

    return v2;
end;

local Fps = script.Parent:WaitForChild("Fps", 10);

if Fps then
    diag("resolved remote:", "Fps", (`({Fps.ClassName})`));
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "Fps");
end;

local LibMPDevice = script.Parent:WaitForChild("LibMPDevice", 10);

if LibMPDevice then
    diag("resolved remote:", "LibMPDevice", (`({LibMPDevice.ClassName})`));
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LibMPDevice");
end;

local LibMPRequiring = script.Parent:WaitForChild("LibMPRequiring", 10);

if LibMPRequiring then
    diag("resolved remote:", "LibMPRequiring", (`({LibMPRequiring.ClassName})`));
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LibMPRequiring");
end;

local LibMPRequired = script.Parent:WaitForChild("LibMPRequired", 10);

if LibMPRequired then
    diag("resolved remote:", "LibMPRequired", (`({LibMPRequired.ClassName})`));
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LibMPRequired");
end;

local LibMPFrame = script.Parent:WaitForChild("LibMPFrame", 10);

if LibMPFrame then
    diag("resolved remote:", "LibMPFrame", (`({LibMPFrame.ClassName})`));
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LibMPFrame");
end;

local LiveRequest = script.Parent:WaitForChild("LiveRequest", 10);

if LiveRequest then
    diag("resolved remote:", "LiveRequest", (`({LiveRequest.ClassName})`));
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LiveRequest");
end;

local LiveResponse = script.Parent:WaitForChild("LiveResponse", 10);

if LiveResponse then
    diag("resolved remote:", "LiveResponse", (`({LiveResponse.ClassName})`));
else
    diagWarn("MISSING remote (WaitForChild timed out after 10s):", "LiveResponse");
end;

local u3 = nil;
local u4 = nil;
local table_create_ret = table.create(60, 0);
local table_create_ret2 = table.create(60, 0);
local u5 = -1;
RunService.RenderStepped:Connect(function(p6: number) -- Line: 100
    -- upvalues: u5 (ref), table_create_ret (copy), table_create_ret2 (copy)
    local os_clock_ret = os.clock();
    local v7 = math.floor(os_clock_ret) % 60 + 1;

    if v7 ~= u5 then
        table_create_ret[v7] = 0;
        table_create_ret2[v7] = 0;
        u5 = v7;
    end;

    local v8 = table_create_ret;
    v8[v7] = v8[v7] + 1;
    local v9 = table_create_ret2;
    v9[v7] = v9[v7] + p6;
end);

local function getRecentAvgFps() -- Line: 110
    -- upvalues: table_create_ret (copy), table_create_ret2 (copy)
    local v10 = 0;
    local v11 = 0;

    for i = 1, 60 do
        v10 = v10 + table_create_ret[i];
        v11 = v11 + table_create_ret2[i];
        local _ = i;
    end;

    return v11 <= 0 and 0 or v10 / v11;
end;

local u12 = {};

local function GetBucket(p13: number) -- Line: 147
    -- upvalues: u12 (copy)
    local v14 = u12[p13];

    if not v14 then
        v14 = {
            Frames = 0,
            Time = 0,
            Spikes = 0
        };
        u12[p13] = v14;
    end;

    return v14;
end;

local u15 = 0;
local u16 = 0;
local u17 = 0;
local u18 = false;
local table_create_ret3 = table.create(60, 0);
local u19 = 0;
local u20 = 0;
local table_create_ret4 = table.create(60, 0);

local function GetMedian() -- Line: 167
    -- upvalues: u19 (ref), table_create_ret4 (copy), table_create_ret3 (copy)
    if u19 < 60 then
        return 0;
    end;

    for i = 1, 60 do
        table_create_ret4[i] = table_create_ret3[i];
        local _ = i;
    end;

    table.sort(table_create_ret4);

    return (table_create_ret4[30] + table_create_ret4[31]) * 0.5;
end;

local function ReportBucket(p21: number) -- Line: 180
    -- upvalues: u12 (copy), Fps (copy), diag (copy)
    local v22 = u12[p21];

    if not v22 or v22.Time <= 0 then
        return;
    end;

    local v23 = v22.Frames / v22.Time;
    Fps:FireServer(p21, v23, v22.Spikes);
    diag("fired Fps: minute", p21, "avgFps", math.round(v23), "spikes", v22.Spikes);
end;

local u24 = nil;
u24 = RunService.RenderStepped:Connect(function(p25: number) -- Line: 191
    -- upvalues: GetMedian (copy), u18 (ref), u16 (ref), u12 (copy), u20 (ref), table_create_ret3 (copy), u19 (ref), u15 (ref), Fps (copy), diag (copy), u17 (ref), u24 (ref)
    local v26 = GetMedian();

    if v26 > 0 then
        if v26 * 3 < p25 then
            if not u18 then
                local v27 = u16;
                local v28 = u12[v27];

                if not v28 then
                    v28 = {
                        Frames = 0,
                        Time = 0,
                        Spikes = 0
                    };
                    u12[v27] = v28;
                end;

                v28.Spikes = v28.Spikes + 1;
                u18 = true;
            end;
        else
            u18 = false;
        end;
    end;

    u20 = u20 % 60 + 1;
    table_create_ret3[u20] = p25;

    if u19 < 60 then
        u19 = u19 + 1;
    end;

    local v29 = u16;
    local v30 = u12[v29];

    if not v30 then
        v30 = {
            Frames = 0,
            Time = 0,
            Spikes = 0
        };
        u12[v29] = v30;
    end;

    v30.Frames = v30.Frames + 1;
    v30.Time = v30.Time + p25;
    u15 = u15 + p25;
    local math_floor_ret = math.floor(u15 / 60);

    if math_floor_ret ~= u16 then
        for i = u16, math.min(math_floor_ret, 300) - 1 do
            local v31 = u12[i];
            local v32;

            if v31 then
                if v31.Time <= 0 then
                    v32 = i;
                else
                    local v33 = v31.Frames / v31.Time;
                    Fps:FireServer(i, v33, v31.Spikes);
                    diag("fired Fps: minute", i, "avgFps", math.round(v33), "spikes", v31.Spikes);
                    v32 = i;
                end;
            else
                v32 = i;
            end;
        end;

        u16 = math_floor_ret;
        u17 = 0;
    end;

    if u16 >= 300 then
        if u24 then
            u24:Disconnect();
            u24 = nil;
        end;

        return;
    end;

    u17 = u17 + p25;

    if u17 >= 15 then
        u17 = 0;
        local v34 = u16;
        local v35 = u12[v34];

        if v35 then
            if v35.Time <= 0 then
                return;
            end;

            local v36 = v35.Frames / v35.Time;
            Fps:FireServer(v34, v36, v35.Spikes);
            diag("fired Fps: minute", v34, "avgFps", math.round(v36), "spikes", v35.Spikes);
        end;
    end;
end);
task.spawn(function() -- Line: 255
    -- upvalues: DeviceForm (copy), diag (copy), LibMPDevice (copy), diagWarn (copy)
    for i = 1, 5 do
        local v37 = DeviceForm.Get();
        diag("device report attempt", i, "->", not v37 and "nil" or v37.Name);

        if v37 then
            LibMPDevice:FireServer(v37);
            diag("fired LibMPDevice:", v37.Name);

            return;
        end;

        task.wait(1);
        local _ = i;
    end;

    diagWarn("device never resolved after 5 attempts; LibMPDevice was NOT fired");
end);
local u38 = false;

local function StartCapture(p39: userdata) -- Line: 270
    -- upvalues: u38 (ref), diag (copy), LibMPRequiring (copy), diagWarn (copy), LibMPRequired (copy), MicroProfilerConfig (copy), u4 (ref), u3 (ref), RunService (copy), MicroprofileCapture (copy), LibMPFrame (copy)
    if u38 then
        return;
    end;

    u38 = true;
    diag("StartCapture: module delivered ->", p39:GetFullName());
    LibMPRequiring:FireServer();
    diag("fired LibMPRequiring");
    local success, result = pcall(require, p39);

    if not success or type(result) ~= "table" then
        diagWarn("require(LibMP) failed:", result);

        return;
    end;

    diag("require(LibMP) ok");
    LibMPRequired:FireServer();
    diag("fired LibMPRequired");
    local u40 = MicroProfilerConfig.FramesBefore:Get();
    local u41 = MicroProfilerConfig.FramesAfter:Get();
    local Control = result.Control;
    local os_clock_ret = os.clock();

    while not Control:IsBackendReady() do
        if os.clock() - os_clock_ret > 30 then
            diagWarn("LibMP backend not ready after 30s; capture disabled");

            return;
        end;

        task.wait();
    end;

    local success2, result2 = pcall(function() -- Line: 311
        -- upvalues: Control (copy), u40 (copy), u41 (copy)
        Control:SetFrameLimit(u40 + u41 + 1);
        Control:EnableProfiler(true);
        Control:EnableCapture(true);
    end);

    if not success2 then
        diagWarn("LibMP setup failed:", result2);

        return;
    end;

    u4 = Control;
    u3 = result;
    diag("LibMP capture armed; window =", u40, "+1+", u41);
    local u42 = 0;
    local u43 = (-1 / 0);
    local u44 = 0;
    local u45 = nil;
    local u46 = nil;
    task.spawn(function() -- Line: 341
        -- upvalues: result (copy), diagWarn (ref), u42 (ref), MicroProfilerConfig (ref), u44 (ref), u46 (ref), u45 (ref), diag (ref), u43 (ref), u41 (copy), RunService (ref), MicroprofileCapture (ref), Control (copy), LibMPFrame (ref)
        task.wait(2);
        local u47 = result.Session.OpenFromLiveData();

        if u47 and u47:IsValid() then
            while u42 < MicroProfilerConfig.MaxFramesPerSession:Get() do
                task.wait(0.03);
                pcall(function() -- Line: 355
                    -- upvalues: u47 (copy), u44 (ref), u46 (ref), u45 (ref), MicroProfilerConfig (ref), diag (ref), u43 (ref), u41 (ref), RunService (ref), MicroprofileCapture (ref), result (ref), Control (ref), u42 (ref), LibMPFrame (ref), diagWarn (ref)
                    u47:SetSyncRequired();
                    local v48 = u47:FetchGlobalDesc();
                    local TickToMsCpu = v48.TickToMsCpu;
                    local TickToMsGpu = v48.TickToMsGpu;
                    local FrameIdMin = u47:GetFrameIdMin();
                    local FrameIdMax = u47:GetFrameIdMax();

                    if FrameIdMax == 0 or (type(TickToMsCpu) ~= "number" or TickToMsCpu <= 0) then
                        return;
                    end;

                    local math_max_ret = math.max(FrameIdMin, u44 + 1);
                    local v49 = 0;
                    local u50 = 0;
                    local v51 = 0;
                    local v52 = 0;
                    local v53 = 0;
                    local v54 = 0;

                    for i = math_max_ret, FrameIdMax do
                        local v55 = u47:FetchFrameDesc(i);
                        local v56;

                        if v55 then
                            local FrameAbsoluteId = v55.FrameAbsoluteId;

                            if u46 then
                                local _ = FrameAbsoluteId - u46;
                            end;

                            if v55.IsPaused then
                                v56 = i;
                            else
                                local v57 = (v55.TickEndCpu - v55.TickStartCpu) * TickToMsCpu;
                                local v58 = (type(TickToMsGpu) ~= "number" or TickToMsGpu <= 0) and 0 or math.max((v55.TickEndGpu - v55.TickStartGpu) * TickToMsGpu, 0);
                                local v59;

                                if u45 == nil or u46 == nil then
                                    v59 = false;
                                else
                                    v59 = FrameAbsoluteId == u46 + 1;
                                end;

                                local v60 = not (v59 and u45) and 0 or (v55.TickStartCpu - u45) * TickToMsCpu;
                                u45 = v55.TickStartCpu;
                                u46 = FrameAbsoluteId;
                                local math_max_ret2 = math.max(v57, v60);

                                if v49 < math_max_ret2 then
                                    v54 = v60;
                                    v53 = v58;
                                    v52 = v57;
                                    v51 = FrameAbsoluteId;
                                    u50 = i;
                                    v49 = math_max_ret2;
                                    v56 = u50;
                                    local v61 = u50;
                                    u50 = v56;
                                    v61 = v56;
                                else
                                    v56 = i;
                                end;
                            end;
                        else
                            v56 = i;
                        end;
                    end;

                    if math_max_ret <= FrameIdMax then
                        u44 = FrameIdMax;
                    end;

                    if MicroProfilerConfig.LaggyFrameMs:Get() <= v49 then
                        diag("laggy frame", u50, "abs", v51, "peakMs", string.format("%.2f", v49), "[ cpu", string.format("%.2f", v52), "gpu", string.format("%.2f", v53), "interval", string.format("%.2f", v54), "]");

                        if os.clock() - u43 >= MicroProfilerConfig.MinFrameInterval:Get() then
                            for i = 1, u41 do
                                RunService.RenderStepped:Wait();
                                local _ = i;
                            end;

                            local v62, v63 = MicroprofileCapture.Run(function() -- Line: 461
                                -- upvalues: MicroprofileCapture (ref), result (ref), Control (ref), u50 (ref), MicroProfilerConfig (ref)
                                return MicroprofileCapture.Export(result, Control:CaptureToBufferSync(), u50, MicroProfilerConfig.MaxDumpBytes:Get());
                            end);

                            if v62 then
                                u42 = u42 + 1;
                                u43 = os.clock();
                                LibMPFrame:FireServer(v62, v49);
                            else
                                diagWarn("export rejected:", v63);
                            end;
                        end;
                    end;
                end);
            end;

            u47:Dispose();

            return;
        end;

        diagWarn("OpenFromLiveData failed; client laggy-frame capture disabled");

        if u47 then
            u47:Dispose();
        end;
    end);
end;

task.spawn(function() -- Line: 488
    -- upvalues: LocalPlayer (copy), diag (copy), MicroProfilerConfig (copy), StartCapture (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
    diag("waiting for LibMP module:", MicroProfilerConfig.ModuleName);
    task.spawn(function(p64: string) -- Line: 492, Name: waitForLibMP
        -- upvalues: PlayerGui (copy), MicroProfilerConfig (ref), diag (ref), StartCapture (ref)
        local v65 = PlayerGui:WaitForChild(p64, (1 / 0)):WaitForChild(MicroProfilerConfig.ModuleName, (1 / 0));

        if v65:IsA("ModuleScript") then
            diag("found LibMP module via", p64);
            StartCapture(v65);
        end;
    end, MicroProfilerConfig.ContainerName);
    local v66 = PlayerGui:WaitForChild("__UG_LiveLibMPGui", (1 / 0)):WaitForChild(MicroProfilerConfig.ModuleName, (1 / 0));

    if v66:IsA("ModuleScript") then
        diag("found LibMP module via", "__UG_LiveLibMPGui");
        StartCapture(v66);
    end;
end);

local function ensureArmed(p67: number) -- Line: 519
    -- upvalues: u4 (ref)
    if u4 then
        return u4;
    end;

    local os_clock_ret = os.clock();

    while not u4 and os.clock() - os_clock_ret < p67 do
        task.wait(0.1);
    end;

    return u4;
end;

local function collectClientLogs() -- Line: 530
    -- upvalues: LogService (copy)
    local LogHistory = LogService:GetLogHistory();
    local v68 = {};

    for i = math.max(1, #LogHistory - 400 + 1), #LogHistory do
        local v69 = LogHistory[i];
        local v70 = tostring(v69.message);

        if #v70 > 1000 then
            v70 = string.sub(v70, 1, 1000) .. "…";
        end;

        local v71 = {
            message = v70
        };
        local v72;

        if typeof(v69.messageType) == "EnumItem" then
            v72 = v69.messageType.Name;
        else
            v72 = tostring(v69.messageType);
        end;

        v71.messageType = v72;
        v71.timestamp = v69.timestamp;
        table.insert(v68, v71);
        local _ = i;
    end;

    return v68;
end;

local function captureClientMicroprofiler(u73: number) -- Line: 551
    -- upvalues: MicroprofileCapture (copy), ensureArmed (copy), u3 (ref), MicroProfilerConfig (copy), RunService (copy)
    return MicroprofileCapture.Run(function() -- Line: 552
        -- upvalues: ensureArmed (ref), u3 (ref), MicroProfilerConfig (ref), u73 (copy), RunService (ref), MicroprofileCapture (ref)
        local u74 = ensureArmed(8);
        local v75;

        if u74 then
            v75 = u3;
        else
            v75 = u74;
        end;

        assert(v75, "libmp_unavailable");
        local u76 = MicroProfilerConfig.FramesBefore:Get() + MicroProfilerConfig.FramesAfter:Get() + 1;
        local success, result = pcall(function() -- Line: 556
            -- upvalues: u74 (copy), u73 (ref), RunService (ref), MicroprofileCapture (ref), u3 (ref)
            u74:SetFrameLimit(u73);
            u74:EnableProfiler(true);
            u74:EnableCapture(true);

            for i = 1, u73 + 12 do
                RunService.RenderStepped:Wait();
                local _ = i;
            end;

            return MicroprofileCapture.Export(u3, u74:CaptureToBufferSync(), nil, 67108864);
        end);
        pcall(function() -- Line: 565
            -- upvalues: u74 (copy), u76 (copy)
            u74:SetFrameLimit(u76);
        end);

        if not success then
            error(result, 0);
        end;

        return result;
    end);
end;

local u77 = nil;

local function getDeviceName() -- Line: 577
    -- upvalues: u77 (ref), DeviceForm (copy)
    if u77 then
        return u77;
    end;

    local v78 = DeviceForm.Get();

    if v78 then
        u77 = v78.Name;
    end;

    return u77;
end;

local function getClientMemoryMb() -- Line: 589
    -- upvalues: Stats (copy)
    local success, result = pcall(function() -- Line: 590
        -- upvalues: Stats (ref)
        return Stats:GetTotalMemoryUsageMb();
    end);

    if success and type(result) == "number" then
        return result;
    end;

    return nil;
end;

local function getClientMeta() -- Line: 601
    -- upvalues: getRecentAvgFps (copy), u77 (ref), DeviceForm (copy), Workspace (copy), GuiService (copy)
    local u79 = {
        avgFps = getRecentAvgFps()
    };
    local v80;

    if u77 then
        v80 = u77;
    else
        local v81 = DeviceForm.Get();

        if v81 then
            u77 = v81.Name;
        end;

        v80 = u77;
    end;

    u79.device = v80;
    u79.engineVersion = version();
    pcall(function() -- Line: 607
        -- upvalues: Workspace (ref), u79 (copy)
        local CurrentCamera = Workspace.CurrentCamera;

        if CurrentCamera then
            local ViewportSize = CurrentCamera.ViewportSize;
            u79.renderResolution = {
                x = math.round(ViewportSize.X),
                y = math.round(ViewportSize.Y)
            };
        end;
    end);
    pcall(function() -- Line: 614
        -- upvalues: GuiService (ref), u79 (copy)
        local ViewportDisplaySize = GuiService.ViewportDisplaySize;
        u79.displaySize = {
            x = math.round(ViewportDisplaySize.X),
            y = math.round(ViewportDisplaySize.Y)
        };
    end);
    pcall(function() -- Line: 620
        -- upvalues: u79 (copy)
        u79.savedQualityLevel = UserSettings().GameSettings.SavedQualityLevel.Value;
    end);

    return u79;
end;

local u82 = false;

local function captureDataModelSnapshot(p83) -- Line: 632
    -- upvalues: getRecentAvgFps (copy), DataModel (copy)
    if type(p83) ~= "table" then
        return nil, nil;
    end;

    local v84 = getRecentAvgFps();
    local v85;

    if v84 > 0 then
        v85 = 1 / v84;
    else
        v85 = nil;
    end;

    local success, result = pcall(DataModel.capture, p83, v85);

    if not success or type(result) ~= "table" then
        return nil, nil;
    end;

    if result.TimedOut then
        return {
            TimedOut = true
        }, nil;
    end;

    if typeof(result.Buffer) == "buffer" and buffer.len(result.Buffer) <= 67108864 then
        return {
            Classes = result.Classes,
            Props = result.Props,
            Truncated = result.Truncated
        }, result.Buffer;
    end;

    return {
        Truncated = true
    }, nil;
end;

LiveRequest.OnClientEvent:Connect(function(u86, u87, u88) -- Line: 650
    -- upvalues: LiveResponse (copy), getRecentAvgFps (copy), u77 (ref), DeviceForm (copy), Stats (copy), collectClientLogs (copy), u82 (ref), MicroprofileCapture (copy), ensureArmed (copy), u3 (ref), MicroProfilerConfig (copy), RunService (copy), getClientMeta (copy), captureDataModelSnapshot (copy)
    if type(u86) ~= "string" or type(u87) ~= "string" then
        return;
    end;

    task.spawn(function() -- Line: 654
        -- upvalues: u87 (copy), LiveResponse (ref), u86 (copy), getRecentAvgFps (ref), u77 (ref), DeviceForm (ref), Stats (ref), collectClientLogs (ref), u82 (ref), u88 (copy), MicroprofileCapture (ref), ensureArmed (ref), u3 (ref), MicroProfilerConfig (ref), RunService (ref), getClientMeta (ref), captureDataModelSnapshot (ref)
        if u87 ~= "fps" then
            if u87 == "output" then
                LiveResponse:FireServer(u86, {
                    logs = collectClientLogs()
                });

                return;
            end;

            if u87 == "microprofiler" then
                if u82 then
                    LiveResponse:FireServer(u86, {
                        error = "busy"
                    });

                    return;
                end;

                u82 = true;
                local u89 = nil;
                local u90 = nil;
                local success, result = pcall(function() -- Line: 670
                    -- upvalues: u88 (ref), MicroprofileCapture (ref), ensureArmed (ref), u3 (ref), MicroProfilerConfig (ref), RunService (ref), u89 (ref), getClientMeta (ref), captureDataModelSnapshot (ref), u90 (ref)
                    local v91 = (type(u88) ~= "table" or type(u88.frames) ~= "number") and 128 or u88.frames;
                    local math_floor_ret = math.floor(v91);
                    local math_clamp_ret = math.clamp(math_floor_ret, 8, 256);
                    local v92;

                    if type(u88) == "table" then
                        v92 = u88.dataModel;
                    else
                        v92 = nil;
                    end;

                    local v96, v97 = MicroprofileCapture.Run(function() -- Line: 552
                        -- upvalues: ensureArmed (ref), u3 (ref), MicroProfilerConfig (ref), math_clamp_ret (copy), RunService (ref), MicroprofileCapture (ref)
                        local u93 = ensureArmed(8);
                        local v94;

                        if u93 then
                            v94 = u3;
                        else
                            v94 = u93;
                        end;

                        assert(v94, "libmp_unavailable");
                        local u95 = MicroProfilerConfig.FramesBefore:Get() + MicroProfilerConfig.FramesAfter:Get() + 1;
                        local success, result = pcall(function() -- Line: 556
                            -- upvalues: u93 (copy), math_clamp_ret (ref), RunService (ref), MicroprofileCapture (ref), u3 (ref)
                            u93:SetFrameLimit(math_clamp_ret);
                            u93:EnableProfiler(true);
                            u93:EnableCapture(true);

                            for i = 1, math_clamp_ret + 12 do
                                RunService.RenderStepped:Wait();
                                local _ = i;
                            end;

                            return MicroprofileCapture.Export(u3, u93:CaptureToBufferSync(), nil, 67108864);
                        end);
                        pcall(function() -- Line: 565
                            -- upvalues: u93 (copy), u95 (copy)
                            u93:SetFrameLimit(u95);
                        end);

                        if not success then
                            error(result, 0);
                        end;

                        return result;
                    end);

                    if not v96 then
                        u89 = {
                            error = v97 or "libmp_unavailable"
                        };

                        return;
                    end;

                    if #v96 > 67108864 then
                        u89 = {
                            error = "Dump size over 64mb. Cannot be retrieved."
                        };

                        return;
                    end;

                    u89 = {
                        ok = true,
                        meta = getClientMeta(),
                        Microprofile = v96
                    };

                    if v92 then
                        local v98, v99 = captureDataModelSnapshot(v92);

                        if v98 then
                            u89.snapshot = v98;
                            u90 = v99;
                        end;
                    end;
                end);
                u82 = false;
                u89 = not success and {
                    error = tostring(result)
                } or u89;
                LiveResponse:FireServer(u86, u89, nil, u90);
            end;

            return;
        end;

        local v100 = {
            fps = getRecentAvgFps()
        };
        local v101;

        if u77 then
            v101 = u77;
        else
            local v102 = DeviceForm.Get();

            if v102 then
                u77 = v102.Name;
            end;

            v101 = u77;
        end;

        v100.device = v101;
        local success, result = pcall(function() -- Line: 590
            -- upvalues: Stats (ref)
            return Stats:GetTotalMemoryUsageMb();
        end);

        if not success or type(result) ~= "number" then
            result = nil;
        end;

        v100.memory = result;
        LiveResponse:FireServer(u86, v100);
    end);
end);