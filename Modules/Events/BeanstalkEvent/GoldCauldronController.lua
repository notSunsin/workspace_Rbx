-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local IsMobile = require(ReplicatedStorage.Modules.OptimisationControllers.IsMobile);
local Trove = require(ReplicatedStorage.Modules.Trove);
local Spring = require(ReplicatedStorage.Modules.Spring);
local LocalPlayer = Players.LocalPlayer;
local Config = GameConfigController:GetConfig("GoldCauldronConfig");
workspace:GetAttributeChangedSignal("GoldCauldronConfig"):Connect(function() -- Line: 27
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("GoldCauldronConfig");
end);
local v1 = {};
local u2 = Trove.new();
local u3 = Trove.new();
local u4 = nil;

local function substitute(p5: string, p6: table) -- Line: 39
    for i, v in p6 do
        p5 = p5:gsub("%[" .. i .. "%]", function() -- Line: 42
            -- upvalues: v (copy)
            return v;
        end);
    end;

    return p5;
end;

local function formatCountdown(p7: number) -- Line: 48
    -- upvalues: Config (ref), substitute (copy)
    local DISPLAY = Config.DISPLAY;
    local math_ceil_ret = math.ceil(p7);
    local v8 = math_ceil_ret <= 0 and 0 or math_ceil_ret;

    if v8 < 60 then
        return substitute(DISPLAY.COOK_SECONDS, {
            S = tostring(v8)
        });
    end;

    local COOK_CLOCK = DISPLAY.COOK_CLOCK;
    local v9 = {};
    local math_floor_ret = math.floor(v8 / 60);
    v9.M = tostring(math_floor_ret);
    v9.SS = string.format("%02d", v8 % 60);

    return substitute(COOK_CLOCK, v9);
end;

local function formatKg(p10: number) -- Line: 66
    return string.format("%0.2f", p10):gsub("0+$", ""):gsub("%.$", "");
end;

local function cauldronData() -- Line: 71
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.GoldCauldronData;
    end;

    return Data;
end;

local function serverNow() -- Line: 77
    local ServerTimeNow = workspace:GetServerTimeNow();

    return ServerTimeNow > 0 and ServerTimeNow and ServerTimeNow or os.time();
end;

local function isOnCooldown(p11) -- Line: 84
    local v12;

    if p11 == nil then
        v12 = false;
    else
        v12 = (p11.CooldownEndsAt or 0) > 0;
    end;

    return v12;
end;

local function timerFraction(p13: number, p14: number?) -- Line: 89
    if not p14 or p14 <= 0 then
        return 1;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v15 = ServerTimeNow > 0 and ServerTimeNow and ServerTimeNow or os.time();

    return math.clamp((p13 - v15) / p14, 0, 1);
end;

local function hexToColor(p16: string?, p17) -- Line: 94
    if type(p16) ~= "string" or p16 == "" then
        return p17;
    end;

    local success, result = pcall(Color3.fromHex, p16);

    if success then
        p17 = result or p17;
    end;

    return p17;
end;

local function adoptStrayEffects(p18: userdata, p19: userdata?) -- Line: 101
    if not p19 then
        return;
    end;

    for _, child in p18:GetChildren() do
        if child:IsA("ParticleEmitter") or (child:IsA("PointLight") or child:IsA("SpotLight")) then
            child.Parent = p19;
        end;
    end;
end;

local function collect(p20: userdata?, p21: string, p22: string) -- Line: 111
    local v23 = {};

    if not p20 then
        return v23;
    end;

    for _, child in p20:GetChildren() do
        if child:IsA(p21) and child.Name == p22 then
            table.insert(v23, child);
        end;
    end;

    return v23;
end;

local function distanceTo(p24: userdata?) -- Line: 123
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    return not (p24 and Character) and (1 / 0) or (Character.Position - p24.Position).Magnitude;
end;

local function waitFor(p25: userdata?, p26: string, p27: number?) -- Line: 134
    if p25 then
        return p25:WaitForChild(p26, p27 or 10);
    end;

    return nil;
end;

local function bind(u28: userdata) -- Line: 139
    -- upvalues: u4 (ref), u3 (copy), Config (ref), DataService (copy), Spring (copy), substitute (copy), formatCountdown (copy), LocalPlayer (copy), collect (copy), adoptStrayEffects (copy), SettingsService (copy), IsMobile (copy), RunService (copy)
    if u4 == u28 then
        return;
    end;

    local u29;

    if u28 then
        u29 = u28:WaitForChild("MeshPart", 10);
    else
        u29 = nil;
    end;

    local v30;

    if u29 then
        v30 = u29:WaitForChild("Attachment", 10);
    else
        v30 = nil;
    end;

    local v31;

    if v30 then
        v31 = v30:WaitForChild("billboard", 10);
    else
        v31 = nil;
    end;

    local v32;

    if v31 then
        v32 = v31:WaitForChild("bar", 10);
    else
        v32 = nil;
    end;

    if not v32 then
        warn("GoldCauldronController | No billboard bar on the Gold Cauldron model");

        return;
    end;

    if not u28:IsDescendantOf(workspace) then
        return;
    end;

    if u4 == u28 then
        return;
    end;

    u3:Clean();
    u4 = u28;
    local u33;

    if v32 then
        u33 = v32:WaitForChild("progress", 10);
    else
        u33 = nil;
    end;

    local u34;

    if v32 then
        u34 = v32:WaitForChild("remaining", 10);
    else
        u34 = nil;
    end;

    local v35;

    if v32 then
        v35 = v32:WaitForChild("holder", 10);
    else
        v35 = nil;
    end;

    local u36;

    if v35 then
        u36 = v35:WaitForChild("content", 10);
    else
        u36 = nil;
    end;

    local function getSound(p37: string?) -- Line: 163
        -- upvalues: u29 (copy)
        if not (u29 and (type(p37) == "string" and p37 ~= "")) then
            return nil;
        end;

        local v38 = u29:FindFirstChild(p37);

        if not (v38 and (v38:IsA("Sound") and v38)) then
            v38 = nil;
        end;

        return v38;
    end;

    local function playSound(p39: string?) -- Line: 169
        -- upvalues: u29 (copy)
        local v40;

        if u29 and (type(p39) == "string" and p39 ~= "") then
            v40 = u29:FindFirstChild(p39);

            if not (v40 and (v40:IsA("Sound") and v40)) then
                v40 = nil;
            end;
        else
            v40 = nil;
        end;

        if v40 then
            v40:Play();
        end;
    end;

    if u34 then
        u34.Visible = true;
        u34.Text = Config.DISPLAY.TITLE;
    end;

    local u41 = nil;
    local u42 = nil;

    local function render() -- Line: 184
        -- upvalues: DataService (ref), Config (ref), u41 (ref), u29 (copy), u42 (ref), u36 (copy), Spring (ref), u34 (copy), u33 (copy), substitute (ref), formatCountdown (ref)
        local Data = DataService:GetData();

        if Data then
            Data = Data.GoldCauldronData;
        end;

        if not Data then
            return;
        end;

        local DISPLAY = Config.DISPLAY;
        local v43 = Data.GoalWeight or 0;
        local math_clamp_ret = math.clamp(Data.Weight or 0, 0, v43 > 0 and v43 and v43 or (1 / 0));
        local v44;

        if Data == nil then
            v44 = false;
        else
            v44 = (Data.CooldownEndsAt or 0) > 0;
        end;

        local v45 = Config.SOUNDS or {};

        if u41 == nil or u41 >= math_clamp_ret then
            if u42 == false and v44 then
                local REWARD = v45.REWARD;
                local v46;

                if u29 and (type(REWARD) == "string" and REWARD ~= "") then
                    v46 = u29:FindFirstChild(REWARD);

                    if not (v46 and (v46:IsA("Sound") and v46)) then
                        v46 = nil;
                    end;
                else
                    v46 = nil;
                end;

                if v46 then
                    v46:Play();
                end;
            end;
        else
            local SUBMIT = v45.SUBMIT;
            local v47;

            if u29 and (type(SUBMIT) == "string" and SUBMIT ~= "") then
                v47 = u29:FindFirstChild(SUBMIT);

                if not (v47 and (v47:IsA("Sound") and v47)) then
                    v47 = nil;
                end;
            else
                v47 = nil;
            end;

            if v47 then
                v47:Play();
            end;
        end;

        u41 = math_clamp_ret;
        u42 = v44;

        if u36 then
            local v48;

            if v44 then
                local CooldownEndsAt = Data.CooldownEndsAt;
                local CooldownTotal = Data.CooldownTotal;

                if CooldownTotal and CooldownTotal > 0 then
                    local ServerTimeNow = workspace:GetServerTimeNow();
                    local v49 = ServerTimeNow > 0 and ServerTimeNow and ServerTimeNow or os.time();
                    v48 = math.clamp((CooldownEndsAt - v49) / CooldownTotal, 0, 1);
                else
                    v48 = 1;
                end;
            else
                v48 = v43 > 0 and (math_clamp_ret / v43 or 0) or 0;
            end;

            local VISUALS = Config.VISUALS;
            Spring.target(u36, VISUALS.BAR_DAMPING or 0.75, VISUALS.BAR_FREQUENCY or 3.5, {
                Size = UDim2.fromScale(math.clamp(v48, 0, 1), 1)
            });
        end;

        if u34 then
            u34.Visible = not v44;
        end;

        if u33 then
            local v50;

            if v44 then
                local COOKING = DISPLAY.COOKING;
                local v51 = {};
                local CooldownEndsAt = Data.CooldownEndsAt;
                local ServerTimeNow = workspace:GetServerTimeNow();
                v51.TIME = formatCountdown(CooldownEndsAt - (ServerTimeNow > 0 and ServerTimeNow and ServerTimeNow or os.time()));
                v50 = substitute(COOKING, v51);
            else
                local REMAINING = DISPLAY.REMAINING;
                local v52 = {};
                local math_max_ret = math.max(v43 - math_clamp_ret, 0);
                v52.KG = string.format("%0.2f", math_max_ret):gsub("0+$", ""):gsub("%.$", "");
                v50 = substitute(REMAINING, v52);
            end;

            u33.Text = v50;
        end;
    end;

    for _, v in { "Weight", "GoalWeight", "CooldownEndsAt" } do
        pcall(function() -- Line: 223
            -- upvalues: u3 (ref), DataService (ref), v (copy), render (copy)
            u3:Add(DataService:GetPathSignal((`GoldCauldronData/{v}`)):Connect(render));
        end);
    end;

    if u36 then
        u3:Add(function() -- Line: 229
            -- upvalues: Spring (ref), u36 (copy)
            Spring.stop(u36);
        end);
    end;

    local u53 = (v31 and v31.MaxDistance or 100) + 25;
    u3:Add(task.spawn(function() -- Line: 234
        -- upvalues: Config (ref), u29 (copy), LocalPlayer (ref), u53 (copy), render (copy)
        local v54 = false;

        while true do
            task.wait(v54 and (Config.VISUALS.BAR_UPDATE_RATE or 0.1) or 0.5);
            local v55 = u29;
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            v54 = (not (v55 and Character) and (1 / 0) or (Character.Position - v55.Position).Magnitude) <= u53;

            if v54 then
                render();
            end;
        end;
    end));
    local u56;

    if u28 then
        u56 = u28:WaitForChild("Water", 10);
    else
        u56 = nil;
    end;

    local v57;

    if u28 then
        v57 = u28:WaitForChild("SpoonSpinner", 10);
    else
        v57 = nil;
    end;

    local u58;

    if u28 then
        u58 = u28:WaitForChild("SpinPlayerCollider", 10);
    else
        u58 = nil;
    end;

    local v59;

    if u28 then
        v59 = u28:WaitForChild("CauldronVFX", 10);
    else
        v59 = nil;
    end;

    local v60;

    if v59 then
        v60 = v59:WaitForChild("Attachment", 10);
    else
        v60 = nil;
    end;

    local function pending(p61: userdata?, p62: string) -- Line: 255
        local v63;

        if p61 == nil then
            v63 = false;
        else
            v63 = p61:FindFirstChild(p62) == nil;
        end;

        return v63;
    end;

    local v64 = os.clock() + 3;

    while os.clock() < v64 do
        local v65;

        if v60 == nil then
            v65 = false;
        else
            v65 = v60:FindFirstChild("Swirl Outline") == nil;
        end;

        if not v65 then
            local v66;

            if u56 == nil then
                v66 = false;
            else
                v66 = u56:FindFirstChild("SmallSteam") == nil;
            end;

            if not v66 then
                local v67;

                if v57 == nil then
                    v67 = false;
                else
                    v67 = v57:FindFirstChild("Union") == nil;
                end;

                if not v67 then
                    local v68;

                    if u28 == nil then
                        v68 = false;
                    else
                        v68 = u28:FindFirstChild("flames") == nil;
                    end;

                    if not v68 then
                        local v69;

                        if u28 == nil then
                            v69 = false;
                        else
                            v69 = u28:FindFirstChild("SmallSteam") == nil;
                        end;

                        if not v69 then
                            local v70;

                            if u28 == nil then
                                v70 = false;
                            else
                                v70 = u28:FindFirstChild("PointLight") == nil;
                            end;

                            if not v70 then
                                break;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        task.wait(0.1);
    end;

    if u4 ~= u28 then
        return;
    end;

    local u71 = collect(v60, "ParticleEmitter", "Swirl Outline");
    adoptStrayEffects(u28, u56);
    local u72 = collect(u56, "ParticleEmitter", "SmallSteam");
    local u73 = collect(u56, "ParticleEmitter", "flames");
    local u74;

    if u56 then
        u74 = u56:FindFirstChildWhichIsA("PointLight");
    else
        u74 = u56;
    end;

    local u75 = u56 and u56.Color or Color3.new(1, 1, 1);
    local u76;

    if u56 then
        u76 = u56.CFrame;
    else
        u76 = u56;
    end;

    local u77;

    if u56 then
        u77 = u56.Size;
    else
        u77 = u56;
    end;

    local u78;

    if u56 then
        u78 = u56.Position.Y - u56.Size.Y / 2;
    else
        u78 = u56;
    end;

    local u79 = u74 and (u74.Brightness or 1) or 1;
    local u80 = 0;
    local u81;

    if v57 then
        u81 = v57.Position;
    else
        u81 = v57;
    end;

    local u82 = {};
    local u83 = {};

    if v57 then
        table.insert(u82, v57);
        table.insert(u83, v57.CFrame);

        for _, descendant in v57:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                table.insert(u82, descendant);
                table.insert(u83, descendant.CFrame);
            end;
        end;
    end;

    local u84 = 0;
    local u85 = nil;
    local u86 = nil;

    local function applyVisuals(p87: boolean) -- Line: 305
        -- upvalues: u86 (ref), Config (ref), u72 (copy), u71 (copy), u73 (copy), u74 (copy), u79 (copy), u56 (copy), u75 (copy), u29 (copy), u85 (ref)
        if u86 == p87 then
            return;
        end;

        u86 = p87;
        local VISUALS = Config.VISUALS;

        for _, v in u72 do
            v.Rate = p87 and VISUALS.COOK_STEAM_RATE or VISUALS.IDLE_STEAM_RATE;
            v.Enabled = true;
        end;

        for _, v in u71 do
            v.Rate = p87 and VISUALS.COOK_SWIRL_RATE or VISUALS.IDLE_SWIRL_RATE;
            v.Enabled = true;
        end;

        for _, v in u73 do
            v.Rate = VISUALS.FLAME_RATE;
            v.Enabled = p87;
        end;

        if u74 then
            local v88 = VISUALS.IDLE_LIGHT_BRIGHTNESS or u79;

            if p87 then
                v88 = VISUALS.COOK_LIGHT_BRIGHTNESS or v88;
            end;

            u74.Brightness = v88;
        end;

        if u56 then
            local v89;

            if p87 then
                local COOK_WATER_COLOR = VISUALS.COOK_WATER_COLOR;
                v89 = u75;

                if type(COOK_WATER_COLOR) == "string" and COOK_WATER_COLOR ~= "" then
                    local success, result = pcall(Color3.fromHex, COOK_WATER_COLOR);

                    if success then
                        v89 = result or v89;
                    end;
                end;

                if not v89 then
                    v89 = u75;
                end;
            else
                v89 = u75;
            end;

            u56.Color = v89;
        end;

        local v90 = Config.SOUNDS and Config.SOUNDS.COOKING_LOOP;
        local v91;

        if u29 and (type(v90) == "string" and v90 ~= "") then
            v91 = u29:FindFirstChild(v90);

            if not (v91 and (v91:IsA("Sound") and v91)) then
                v91 = nil;
            end;
        else
            v91 = nil;
        end;

        if v91 then
            v91.Looped = true;

            if p87 then
                v91:Resume();
            else
                v91:Pause();
            end;
        end;

        if u85 then
            u85(p87);
        end;
    end;

    local u92 = Config.VISUALS.UPDATE_RATE or 0.05;
    local u93 = true;

    local function readPerformanceMode() -- Line: 345
        -- upvalues: SettingsService (ref), u93 (ref)
        local success, result = pcall(SettingsService.GetSetting, SettingsService, "PerformanceMode");

        if success then
            u93 = not result;
        end;
    end;

    u3:Add(task.spawn(function() -- Line: 350
        -- upvalues: IsMobile (ref), u92 (ref), SettingsService (ref), u93 (ref)
        local success, result = pcall(IsMobile);

        if success and result then
            u92 = 0.05;
        end;

        local success2, result2 = pcall(SettingsService.GetSetting, SettingsService, "PerformanceMode");

        if success2 then
            u93 = not result2;
        end;
    end));
    u3:Add(DataService:GetPathSignal("Settings/@"):Connect(readPerformanceMode));
    local u94 = Config.VISUALS.ACTIVE_DISTANCE or 250;
    u3:Add(task.spawn(function() -- Line: 359
        -- upvalues: u92 (ref), u29 (copy), LocalPlayer (ref), u94 (copy), u28 (copy), DataService (ref), applyVisuals (copy), Config (ref), u56 (copy), u77 (copy), u78 (copy), u80 (ref), u93 (ref), u76 (copy), u81 (copy), u82 (copy), u84 (ref), u83 (copy)
        local os_clock_ret = os.clock();
        local v95 = false;

        while true do
            task.wait(v95 and u92 or 0.5);
            local os_clock_ret2 = os.clock();
            local v96 = os_clock_ret2 - os_clock_ret;
            local v97 = u29;
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            v95 = (not (v97 and Character) and (1 / 0) or (Character.Position - v97.Position).Magnitude) <= u94;

            if v95 and u28:IsDescendantOf(workspace) then
                local Data = DataService:GetData();

                if Data then
                    Data = Data.GoldCauldronData;
                end;

                local v98;

                if Data == nil then
                    v98 = false;
                else
                    v98 = (Data.CooldownEndsAt or 0) > 0;
                end;

                applyVisuals(v98);
                local VISUALS = Config.VISUALS;

                if u56 and (u77 and u78) then
                    local v99 = VISUALS.LIQUID_MIN_HEIGHT or 0.15;
                    local v100 = Data and (Data.GoalWeight or 0) or 0;
                    u80 = u80 + ((v98 and 1 or (v100 > 0 and (Data and math.clamp((Data.Weight or 0) / v100, 0, 1)) or 0)) - u80) * math.clamp(v96 * (VISUALS.LIQUID_LERP or 4), 0, 1);
                    local v101 = v99 + (u77.Y - v99) * u80;

                    if u93 and v98 then
                        local v102 = os.clock() * (VISUALS.BOIL_SPEED or 7);
                        v101 = v101 + math.sin(v102) * (VISUALS.BOIL_HEIGHT or 0.09);
                    end;

                    local math_max_ret = math.max(v101, 0.05);

                    if math.abs(math_max_ret - u56.Size.Y) > 0.004 then
                        u56.Size = Vector3.new(u77.X, math_max_ret, u77.Z);
                        u56.CFrame = CFrame.new(u76.X, u78 + math_max_ret / 2, u76.Z) * u76.Rotation;
                    end;
                end;

                if u93 and (u81 and #u82 > 0) then
                    u84 = (u84 + math.rad((v98 and VISUALS.COOK_STIR_SPEED or VISUALS.IDLE_STIR_SPEED) * v96)) % 6.283185307179586;
                    local v103 = CFrame.new(u81) * CFrame.Angles(0, u84, 0) * CFrame.new(-u81);
                    local table_create_ret = table.create(#u82);

                    for i, _ in u82 do
                        table_create_ret[i] = v103 * u83[i];
                    end;

                    workspace:BulkMoveTo(u82, table_create_ret, Enum.BulkMoveMode.FireCFrameChanged);
                end;
            end;

            os_clock_ret = os_clock_ret2;
        end;
    end));
    u3:Add(function() -- Line: 418
        -- upvalues: Config (ref), u29 (copy), u56 (copy), u76 (copy), u77 (copy)
        local v104 = Config.SOUNDS and Config.SOUNDS.COOKING_LOOP;
        local v105;

        if u29 and (type(v104) == "string" and v104 ~= "") then
            v105 = u29:FindFirstChild(v104);

            if not (v105 and (v105:IsA("Sound") and v105)) then
                v105 = nil;
            end;
        else
            v105 = nil;
        end;

        if v105 then
            v105:Pause();
        end;

        if u56 and (u76 and u77) then
            u56.Size = u77;
            u56.CFrame = u76;
        end;
    end);

    if u58 then
        local u106 = {
            ["Left Leg"] = true,
            ["Right Leg"] = true
        };
        local u107 = nil;

        local function isLocal(p108: userdata) -- Line: 434
            -- upvalues: LocalPlayer (ref)
            local Character = LocalPlayer.Character;
            local v109;

            if Character == nil then
                v109 = false;
            else
                v109 = p108:IsDescendantOf(Character);
            end;

            return v109;
        end;

        local function stopSpin() -- Line: 439
            -- upvalues: u107 (ref)
            if u107 then
                u107:Disconnect();
                u107 = nil;
            end;
        end;

        local function startSpin() -- Line: 446
            -- upvalues: u107 (ref), RunService (ref), LocalPlayer (ref), DataService (ref), stopSpin (copy), Config (ref)
            if u107 then
                return;
            end;

            u107 = RunService.Heartbeat:Connect(function(p110) -- Line: 448
                -- upvalues: LocalPlayer (ref), DataService (ref), stopSpin (ref), Config (ref)
                local Character = LocalPlayer.Character;
                local v111;

                if Character then
                    v111 = Character:FindFirstChild("HumanoidRootPart");
                else
                    v111 = Character;
                end;

                if v111 then
                    local Data = DataService:GetData();

                    if Data then
                        Data = Data.GoldCauldronData;
                    end;

                    local v112;

                    if Data == nil then
                        v112 = false;
                    else
                        v112 = (Data.CooldownEndsAt or 0) > 0;
                    end;

                    if v112 then
                        Character:PivotTo(Character:GetPivot() * CFrame.Angles(0, math.rad((Config.VISUALS.PLAYER_SPIN_SPEED or 90) * p110), 0));

                        return;
                    end;
                end;

                return stopSpin();
            end);
        end;

        u3:Add(u58.Touched:Connect(function(p113) -- Line: 457
            -- upvalues: u106 (copy), LocalPlayer (ref), DataService (ref), u107 (ref), RunService (ref), stopSpin (copy), Config (ref)
            if u106[p113.Name] then
                local Character = LocalPlayer.Character;
                local v114;

                if Character == nil then
                    v114 = false;
                else
                    v114 = p113:IsDescendantOf(Character);
                end;

                if v114 then
                    local Data = DataService:GetData();

                    if Data then
                        Data = Data.GoldCauldronData;
                    end;

                    local v115;

                    if Data == nil then
                        v115 = false;
                    else
                        v115 = (Data.CooldownEndsAt or 0) > 0;
                    end;

                    if v115 then
                        if u107 then
                            return;
                        end;

                        u107 = RunService.Heartbeat:Connect(function(p116) -- Line: 448
                            -- upvalues: LocalPlayer (ref), DataService (ref), stopSpin (ref), Config (ref)
                            local Character2 = LocalPlayer.Character;
                            local v117;

                            if Character2 then
                                v117 = Character2:FindFirstChild("HumanoidRootPart");
                            else
                                v117 = Character2;
                            end;

                            if v117 then
                                local Data2 = DataService:GetData();

                                if Data2 then
                                    Data2 = Data2.GoldCauldronData;
                                end;

                                local v118;

                                if Data2 == nil then
                                    v118 = false;
                                else
                                    v118 = (Data2.CooldownEndsAt or 0) > 0;
                                end;

                                if v118 then
                                    Character2:PivotTo(Character2:GetPivot() * CFrame.Angles(0, math.rad((Config.VISUALS.PLAYER_SPIN_SPEED or 90) * p116), 0));

                                    return;
                                end;
                            end;

                            return stopSpin();
                        end);
                    end;
                end;
            end;
        end));
        u3:Add(u58.TouchEnded:Connect(function(p119) -- Line: 462
            -- upvalues: LocalPlayer (ref), u107 (ref)
            local Character = LocalPlayer.Character;
            local v120;

            if Character == nil then
                v120 = false;
            else
                v120 = p119:IsDescendantOf(Character);
            end;

            if v120 and u107 then
                u107:Disconnect();
                u107 = nil;
            end;
        end));
        u3:Add(stopSpin);

        u85 = function(p121: boolean) -- Line: 470
            -- upvalues: stopSpin (copy), u58 (copy), u106 (copy), LocalPlayer (ref), startSpin (copy)
            if not p121 then
                return stopSpin();
            end;

            for _, v in u58:GetTouchingParts() do
                if u106[v.Name] then
                    local Character = LocalPlayer.Character;
                    local v122;

                    if Character == nil then
                        v122 = false;
                    else
                        v122 = v:IsDescendantOf(Character);
                    end;

                    if v122 then
                        return startSpin();
                    end;
                end;
            end;
        end;

        local Data = DataService:GetData();

        if Data then
            Data = Data.GoldCauldronData;
        end;

        local v123;

        if Data == nil then
            v123 = false;
        else
            v123 = (Data.CooldownEndsAt or 0) > 0;
        end;

        u85(v123);
    end;
end;

local function unbind(p124: userdata) -- Line: 480
    -- upvalues: u4 (ref), u3 (copy)
    if u4 ~= p124 then
        return;
    end;

    u3:Clean();
    u4 = nil;
end;

function v1.GetBoundModel(p125) -- Line: 486
    -- upvalues: u4 (ref)
    return u4;
end;

local function tryBindExisting() -- Line: 490
    -- upvalues: CollectionService (copy), Config (ref), bind (copy)
    local v126 = CollectionService:GetTagged(Config.MODEL_TAG)[1];

    if v126 and (v126:IsA("Model") and v126:IsDescendantOf(workspace)) then
        bind(v126);
    end;
end;

local function startWatching() -- Line: 500
    -- upvalues: u2 (copy), CollectionService (copy), Config (ref), bind (copy), u4 (ref), u3 (copy), tryBindExisting (copy)
    u2:Add(CollectionService:GetInstanceAddedSignal(Config.MODEL_TAG):Connect(function(p127) -- Line: 501
        -- upvalues: bind (ref)
        if p127:IsA("Model") then
            task.defer(bind, p127);
        end;
    end));
    u2:Add(CollectionService:GetInstanceRemovedSignal(Config.MODEL_TAG):Connect(function(p128) -- Line: 506
        -- upvalues: u4 (ref), u3 (ref)
        if p128:IsA("Model") then
            if u4 ~= p128 then
                return;
            end;

            u3:Clean();
            u4 = nil;
        end;
    end));
    u2:Add(function() -- Line: 511
        -- upvalues: u4 (ref), u3 (ref)
        if u4 then
            if u4 ~= u4 then
                return;
            end;

            u3:Clean();
            u4 = nil;
        end;
    end);
    task.spawn(tryBindExisting);
end;

local u129 = false;
EventRotationController.EventUpdated:Connect(function(p130: string, p131: string) -- Line: 518, Name: OnEventUpdated
    -- upvalues: u2 (copy), u129 (ref), EventRotationUtils (copy), startWatching (copy)
    if p131 ~= "BeanstalkEvent" then
        u2:Clean();
        u129 = false;

        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p130, p131);

    if not EventInSetIndex then
        return;
    end;

    if EventInSetIndex < 2 then
        return;
    end;

    if u129 then
        return;
    end;

    u129 = true;
    u2:Clean();
    startWatching();
end);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent and LoadedEvent.EventSet == "BeanstalkEvent" then
    local EventID = LoadedEvent.EventID;
    local EventSet = LoadedEvent.EventSet;

    if EventSet == "BeanstalkEvent" then
        local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(EventID, EventSet);

        if EventInSetIndex and (EventInSetIndex >= 2 and not u129) then
            u129 = true;
            u2:Clean();
            startWatching();
        end;
    else
        u2:Clean();
        u129 = false;
    end;
end;

return v1;