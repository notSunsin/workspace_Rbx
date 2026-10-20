-- Decompiled with Potassium's decompiler.

local os_clock_ret = os.clock();
local GuiService = game:GetService("GuiService");
local HttpService = game:GetService("HttpService");
local LocalizationService = game:GetService("LocalizationService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Stats = game:GetService("Stats");
local TeleportService = game:GetService("TeleportService");
local VoiceChatServiceHelper = require(ReplicatedStorage.UserGenerated.Roblox.VoiceChatServiceHelper);
local ThreadJoin = require(ReplicatedStorage.UserGenerated.Concurrency.ThreadJoin);
local ClientKit = require(ReplicatedStorage.UserGenerated.Analytics.ClientKit);
local UTF8Sub = require(ReplicatedStorage.UserGenerated.Strings.UTF8Sub);
local DeviceForm = require(ReplicatedStorage.UserGenerated.Roblox.DeviceForm);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;

function SafeGet(u2: any, u3: string, p4: any)
    local success, result = pcall(function(p5, p6) -- Line: 45
        -- upvalues: u2 (copy), u3 (copy)
        return u2[u3];
    end, u2, u3);

    if success then
        return result;
    end;

    return p4;
end;

function IsUWP()
    local success, result = pcall(function() -- Line: 52
        return tostring({ 1 }):match("^table: 0x(00000000%x+)$") ~= nil;
    end);

    return success and result;
end;

function IsWindows()
    -- upvalues: GuiService (copy)
    return SafeGet(GuiService, "IsWindows", false);
end;

function IsLoaded()
    -- upvalues: LocalPlayer (copy)
    if not game:IsLoaded() then
        return false;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        return Character.PrimaryPart and Character:FindFirstChild("Humanoid") and true or false;
    end;

    return false;
end;

task.spawn(function() -- Line: 78
    -- upvalues: u1 (ref)
    while not IsLoaded() do
        task.wait();
    end;

    u1 = os.clock();
end);

function GetStartTime()
    -- upvalues: os_clock_ret (copy)
    local _G___StartTime = _G.__StartTime;

    if type(_G___StartTime) == "number" then
        return _G___StartTime;
    end;

    return os_clock_ret;
end;

function GetLoadDurationAsync(p7: boolean?)
    -- upvalues: u1 (ref)
    local v8;

    while true do
        v8 = u1;

        if v8 then
            break;
        end;

        if p7 then
            return nil;
        end;

        task.wait();
    end;

    local v9 = v8 - GetStartTime();

    return math.max(0, v9);
end;

function Build()
    -- upvalues: GuiService (copy), LocalPlayer (copy), HttpService (copy), Stats (copy), UTF8Sub (copy), TeleportService (copy), DeviceForm (copy), LocalizationService (copy), VoiceChatServiceHelper (copy), ThreadJoin (copy)
    local v10 = GetLoadDurationAsync(false);
    local os_time_ret = os.time();
    local os_clock_ret2 = os.clock();
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v11 = elapsedTime();
    local GameSettings = UserSettings().GameSettings;
    local GuiInset, v12 = GuiService:GetGuiInset();
    local u13 = nil;
    pcall(function() -- Line: 126
        -- upvalues: LocalPlayer (ref), u13 (ref)
        local NetworkPing = LocalPlayer:GetNetworkPing();

        if NetworkPing > 0 then
            u13 = NetworkPing * 1000;
        end;
    end);
    local JoinData = LocalPlayer:GetJoinData();

    if JoinData.LaunchData ~= nil then
        pcall(function() -- Line: 134
            -- upvalues: JoinData (copy), HttpService (ref)
            JoinData.LaunchData = HttpService:JSONDecode(JoinData.LaunchData);
        end);
    end;

    local v14;

    if Stats.MemoryTrackingEnabled then
        v14 = {
            ContactsCount = Stats.ContactsCount,
            DataReceiveKbps = Stats.DataReceiveKbps,
            DataSendKbps = Stats.DataSendKbps,
            FrameTime = Stats.FrameTime,
            HeartbeatTime = Stats.HeartbeatTime,
            InstanceCount = Stats.InstanceCount,
            MovingPrimitivesCount = Stats.MovingPrimitivesCount,
            PhysicsReceiveKbps = Stats.PhysicsReceiveKbps,
            PhysicsSendKbps = Stats.PhysicsSendKbps,
            PhysicsStepTime = Stats.PhysicsStepTime,
            PrimitivesCount = Stats.PrimitivesCount,
            RenderCPUFrameTime = Stats.RenderCPUFrameTime,
            RenderGPUFrameTime = Stats.RenderGPUFrameTime,
            SceneDrawcallCount = Stats.SceneDrawcallCount,
            SceneTriangleCount = Stats.SceneTriangleCount,
            ShadowsDrawcallCount = Stats.ShadowsDrawcallCount,
            ShadowsTriangleCount = Stats.ShadowsTriangleCount,
            UI2DDrawcallCount = Stats.UI2DDrawcallCount,
            UI2DTriangleCount = Stats.UI2DTriangleCount,
            UI3DDrawcallCount = Stats.UI3DDrawcallCount,
            UI3DTriangleCount = Stats.UI3DTriangleCount
        };
        local v15 = {};

        for _, v in ipairs(Enum.DeveloperMemoryTag:GetEnumItems()) do
            local Name = v.Name;
            v15[Name == "PhysicsParts" and "BaseParts" or Name] = Stats:GetMemoryUsageMbForTag(v);
        end;

        v14.MemoryUsageMbForTag = v15;
        v14.TotalMemoryUsageMb = Stats:GetTotalMemoryUsageMb();
    else
        v14 = nil;
    end;

    local u16 = {
        System = {
            UWP = IsUWP(),
            Windows = IsWindows(),
            Time = os_time_ret,
            Clock = os_clock_ret2,
            ElapsedTime = v11,
            TimezoneOffset = os.date("%z"),
            Timezone = HttpService:UrlEncode((os.date("%Z"))),
            TimezoneDST = os.date("*t").isdst == true,
            HeapSize = gcinfo(),
            RobloxVersion = UTF8Sub(tostring(version()), 1, 20)
        },
        Game = {
            LoadingDuration = v10
        },
        LocalPlayer = {
            JoinData = JoinData,
            NetworkPing = u13
        },
        TeleportService = {
            TeleportData = TeleportService:GetLocalPlayerTeleportData()
        },
        Workspace = {
            ServerTimeNow = ServerTimeNow,
            RealPhysicsFPS = workspace:GetRealPhysicsFPS(),
            DistributedGameTime = workspace.DistributedGameTime,
            NumAwakeParts = workspace:GetNumAwakeParts(),
            PhysicsThrottling = workspace:GetPhysicsThrottling()
        },
        Stats = v14,
        UserInputService = {
            DeviceForm = DeviceForm.Get(),
            Platform = DeviceForm.GetPlatform()
        },
        GuiService = {
            IsTenFootInterface = GuiService:IsTenFootInterface(),
            TouchControlsEnabled = GuiService.TouchControlsEnabled,
            GuiInsetTopLeft = GuiInset,
            GuiInsetBotRight = v12,
            IsModalDialog = SafeGet(GuiService, "IsModalDialog", false),
            MenuIsOpen = GuiService.MenuIsOpen,
            PreferredTransparency = math.clamp(GuiService.PreferredTransparency, 0, 1),
            ReducedMotionEnabled = GuiService.ReducedMotionEnabled,
            CoreGuiNavigationEnabled = GuiService.CoreGuiNavigationEnabled,
            GuiNavigationEnabled = GuiService.GuiNavigationEnabled,
            AutoSelectGuiEnabled = GuiService.AutoSelectGuiEnabled
        },
        CurrentCamera = {
            ViewportSize = workspace.CurrentCamera.ViewportSize
        },
        LocalizationService = {
            RobloxLocaleId = LocalizationService.RobloxLocaleId:lower(),
            SystemLocaleId = UTF8Sub(LocalizationService.SystemLocaleId:lower(), 1, 1000)
        },
        VoiceChatService = {},
        UserSettings = {
            GameSettings = {
                ControlMode = GameSettings.ControlMode,
                VignetteEnabled = GameSettings.VignetteEnabled,
                ComputerCameraMovementMode = GameSettings.ComputerCameraMovementMode,
                ComputerMovementMode = GameSettings.ComputerMovementMode,
                GamepadCameraSensitivity = GameSettings.GamepadCameraSensitivity,
                MouseSensitivity = GameSettings.MouseSensitivity,
                RotationType = GameSettings.RotationType,
                SavedQualityLevel = GameSettings.SavedQualityLevel,
                TouchCameraMovementMode = GameSettings.TouchCameraMovementMode,
                TouchMovementMode = GameSettings.TouchMovementMode,
                InFullScreen = GameSettings:InFullScreen(),
                InStudioMode = GameSettings:InStudioMode()
            }
        }
    };
    local v17 = {};
    table.insert(v17, task.spawn(function() -- Line: 262
        -- upvalues: u16 (copy), VoiceChatServiceHelper (ref), LocalPlayer (ref)
        u16.VoiceChatService.VoiceEnabled = VoiceChatServiceHelper.IsVoiceEnabledForUserIdAsync(LocalPlayer.UserId, false);
    end));

    for _, v in ipairs(v17) do
        ThreadJoin(v);
    end;

    return u16;
end;

local u18 = false;

function Send()
    -- upvalues: u18 (ref), ClientKit (copy)
    if u18 then
        return true;
    end;

    u18 = true;
    local success = pcall(function() -- Line: 283
        -- upvalues: ClientKit (ref)
        local v19 = Build();
        ClientKit.AcceptRemote:FireServer(v19);
    end);
    u18 = false;

    return success;
end;

local u20 = (-1 / 0);
GuiService.MenuOpened:Connect(function() -- Line: 292
    -- upvalues: u20 (ref)
    local os_clock_ret2 = os.clock();

    if os_clock_ret2 - u20 > 15 then
        u20 = os_clock_ret2;
        Send();
    end;
end);
UserInputService.WindowFocusReleased:Connect(function() -- Line: 300
    -- upvalues: u20 (ref)
    local os_clock_ret2 = os.clock();

    if os_clock_ret2 - u20 > 15 then
        u20 = os_clock_ret2;
        Send();
    end;
end);
task.spawn(function() -- Line: 308
    while true do
        Send();
        task.wait(150 + 300 * math.random());
    end;
end);