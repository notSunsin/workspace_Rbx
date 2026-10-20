-- Decompiled with Potassium's decompiler.

local v1 = {};
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SkyboxManager = require(ReplicatedStorage.Modules.SkyboxManager);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local u2 = { "NightEvent", "BloodMoonEvent" };
local NightLighting = script:FindFirstChild("NightLighting");
local MoonBeamEnviormentFx = script:FindFirstChild("MoonBeamEnviormentFx");
local u3 = {
    Atmosphere = { "Density", "Offset", "Glare", "Haze", "Color", "Decay" },
    BlurEffect = { "Size" },
    DepthOfFieldEffect = { "FarIntensity", "FocusDistance", "InFocusRadius", "NearIntensity" },
    ColorCorrectionEffect = { "Brightness", "Contrast", "Saturation", "TintColor" },
    SunRaysEffect = { "Intensity", "Spread" }
};
local u4 = {
    GeographicLatitude = -9,
    ShadowSoftness = 0.2,
    Ambient = Color3.fromRGB(138, 138, 138)
};
local u5;

if NightLighting then
    u5 = NightLighting:FindFirstChildOfClass("Sky");
else
    u5 = NightLighting;
end;

if u5 then
    SkyboxManager.AddSkybox(u5);
end;

local function GetOwnEffect(p6: string, p7: string) -- Line: 61
    -- upvalues: Lighting (copy)
    local v8 = Lighting:FindFirstChild(p7);

    if v8 then
        return v8;
    end;

    local Instance_new_ret = Instance.new(p6);
    Instance_new_ret.Name = p7;
    Instance_new_ret.Parent = Lighting;

    return Instance_new_ret;
end;

local HarvestMoonColor = Lighting:FindFirstChild("HarvestMoonColor");

if not HarvestMoonColor then
    HarvestMoonColor = Instance.new("ColorCorrectionEffect");
    HarvestMoonColor.Name = "HarvestMoonColor";
    HarvestMoonColor.Parent = Lighting;
end;

local HarvestMoonBlur = Lighting:FindFirstChild("HarvestMoonBlur");

if not HarvestMoonBlur then
    HarvestMoonBlur = Instance.new("BlurEffect");
    HarvestMoonBlur.Name = "HarvestMoonBlur";
    HarvestMoonBlur.Parent = Lighting;
end;

HarvestMoonBlur.Size = 0;
local u9 = nil;
local u10 = false;
local u11 = Lighting:FindFirstChildOfClass("Atmosphere");
local DepthOfField = Lighting:FindFirstChild("DepthOfField");

local function Snapshot(p12: userdata?) -- Line: 87
    -- upvalues: u3 (copy)
    if not p12 then
        return nil;
    end;

    local v13 = u3[p12.ClassName];

    if not v13 then
        return nil;
    end;

    local v14 = {};

    for _, v in v13 do
        v14[v] = p12[v];
    end;

    return v14;
end;

local function ApplyProps(p15: userdata?, p16: table?, p17: number) -- Line: 100
    -- upvalues: TweenService (copy)
    if not (p15 and p16) then
        return;
    end;

    TweenService:Create(p15, TweenInfo.new(p17), p16):Play();
end;

local function TemplateValues(p18: string) -- Line: 105
    -- upvalues: NightLighting (copy), u3 (copy)
    if not NightLighting then
        return nil;
    end;

    local v19 = NightLighting:FindFirstChild(p18);

    if not v19 then
        return nil;
    end;

    local v20 = u3[v19.ClassName];

    if not v20 then
        return nil;
    end;

    local v21 = {};

    for _, v in v20 do
        v21[v] = v19[v];
    end;

    return v21;
end;

local u22;

if NightLighting then
    local Orange = NightLighting:FindFirstChild("Orange");

    if Orange then
        local v23 = u3[Orange.ClassName];

        if v23 then
            u22 = {};

            for _, v in v23 do
                u22[v] = Orange[v];
            end;
        else
            u22 = nil;
        end;
    else
        u22 = nil;
    end;
else
    u22 = nil;
end;

local u24;

if NightLighting then
    local Blur = NightLighting:FindFirstChild("Blur");

    if Blur then
        local v25 = u3[Blur.ClassName];

        if v25 then
            u24 = {};

            for _, v in v25 do
                u24[v] = Blur[v];
            end;
        else
            u24 = nil;
        end;
    else
        u24 = nil;
    end;
else
    u24 = nil;
end;

local u26;

if NightLighting then
    local DepthOfField2 = NightLighting:FindFirstChild("DepthOfField");

    if DepthOfField2 then
        local v27 = u3[DepthOfField2.ClassName];

        if v27 then
            u26 = {};

            for _, v in v27 do
                u26[v] = DepthOfField2[v];
            end;
        else
            u26 = nil;
        end;
    else
        u26 = nil;
    end;
else
    u26 = nil;
end;

local u28;

if NightLighting then
    local NightColor = NightLighting:FindFirstChild("NightColor");

    if NightColor then
        local v29 = u3[NightColor.ClassName];

        if v29 then
            u28 = {};

            for _, v in v29 do
                u28[v] = NightColor[v];
            end;
        else
            u28 = nil;
        end;
    else
        u28 = nil;
    end;
else
    u28 = nil;
end;

local u30 = {
    Lighting = {
        Ambient = Lighting.Ambient,
        Brightness = Lighting.Brightness,
        ExposureCompensation = Lighting.ExposureCompensation,
        GeographicLatitude = Lighting.GeographicLatitude,
        ShadowSoftness = Lighting.ShadowSoftness
    }
};
local v31;

if u11 then
    local v32 = u3[u11.ClassName];

    if v32 then
        v31 = {};

        for _, v in v32 do
            v31[v] = u11[v];
        end;
    else
        v31 = nil;
    end;
else
    v31 = nil;
end;

u30.Atmosphere = v31;
local v33;

if DepthOfField then
    local v34 = u3[DepthOfField.ClassName];

    if v34 then
        v33 = {};

        for _, v in v34 do
            v33[v] = DepthOfField[v];
        end;
    else
        v33 = nil;
    end;
else
    v33 = nil;
end;

u30.DepthOfField = v33;
local u35 = nil;

local function GetVisualsFolder() -- Line: 132
    local WeatherVisuals = workspace:FindFirstChild("WeatherVisuals");

    if WeatherVisuals then
        return WeatherVisuals;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "WeatherVisuals";
    Folder.Parent = workspace;

    return Folder;
end;

local function StopEnvironmentFX() -- Line: 142
    -- upvalues: u35 (ref)
    if u35 then
        u35:Destroy();
        u35 = nil;
    end;
end;

local function StartEnvironmentFX() -- Line: 153
    -- upvalues: MoonBeamEnviormentFx (copy), u35 (ref)
    if not (MoonBeamEnviormentFx and MoonBeamEnviormentFx:IsA("BasePart")) then
        return;
    end;

    if u35 then
        u35:Destroy();
        u35 = nil;
    end;

    local v36 = MoonBeamEnviormentFx:Clone();
    v36.Anchored = true;
    v36.CanCollide = false;
    v36.CanQuery = false;
    v36.CanTouch = false;
    v36.CastShadow = false;
    v36.Transparency = 1;
    local WeatherVisuals = workspace:FindFirstChild("WeatherVisuals");

    if not WeatherVisuals then
        WeatherVisuals = Instance.new("Folder");
        WeatherVisuals.Name = "WeatherVisuals";
        WeatherVisuals.Parent = workspace;
    end;

    v36.Parent = WeatherVisuals;
    u35 = v36;
end;

local function IsAnotherSkyOwnerActive() -- Line: 176
    -- upvalues: u2 (copy), HttpService (copy)
    for _, v in u2 do
        if workspace:GetAttribute(v) then
            return true;
        end;
    end;

    local Attribute = workspace:GetAttribute("CurrentWeatherEvents");

    if type(Attribute) ~= "string" then
        return false;
    end;

    local success, result = pcall(HttpService.JSONDecode, HttpService, Attribute);

    if not success or type(result) ~= "table" then
        return false;
    end;

    for _, v in result do
        if v ~= "HarvestMoon" then
            return true;
        end;
    end;

    return false;
end;

local function StartAmbience(p37: boolean) -- Line: 199
    -- upvalues: u9 (ref), SoundPlayer (copy), SoundData (copy), TweenService (copy)
    u9 = SoundPlayer:PlaySound(SoundData.Weather.Ambience, {
        RollOffMaxDistance = 10000,
        RollOffMinDistance = 10,
        PlaybackSpeed = 1,
        RollOffMode = Enum.RollOffMode.Inverse,
        Volume = p37 and 0.1 or 0
    }, nil, workspace);

    if not p37 and u9 then
        TweenService:Create(u9, TweenInfo.new(1), {
            Volume = 0.1
        }):Play();
    end;
end;

local function StopAmbience() -- Line: 213
    -- upvalues: u9 (ref), TweenService (copy)
    local u38 = u9;
    u9 = nil;

    if not u38 then
        return;
    end;

    TweenService:Create(u38, TweenInfo.new(1), {
        Volume = 0
    }):Play();
    task.delay(1, function() -- Line: 219
        -- upvalues: u38 (copy)
        if u38 and u38.Parent then
            u38:Stop();
        end;
    end);
end;

local function WriteLightingDefaults(p39, p40: number, p41: number) -- Line: 227
    -- upvalues: Lighting (copy)
    Lighting:SetAttribute("DefaultAmbient", p39);
    Lighting:SetAttribute("DefaultExposure", p40);
    Lighting:SetAttribute("DefaultBrightness", p41);
end;

local u42 = nil;

local function CancelPendingRestore() -- Line: 235
    -- upvalues: u42 (ref)
    if u42 then
        u42:Disconnect();
        u42 = nil;
    end;
end;

local function RestoreSharedLighting() -- Line: 242
    -- upvalues: u30 (copy), Lighting (copy), TweenService (copy), u11 (copy), DepthOfField (copy)
    local ExposureCompensation = u30.Lighting.ExposureCompensation;
    local Brightness = u30.Lighting.Brightness;
    Lighting:SetAttribute("DefaultAmbient", u30.Lighting.Ambient);
    Lighting:SetAttribute("DefaultExposure", ExposureCompensation);
    Lighting:SetAttribute("DefaultBrightness", Brightness);
    TweenService:Create(Lighting, TweenInfo.new(5), u30.Lighting):Play();
    local v43 = u11;
    local Atmosphere = u30.Atmosphere;

    if v43 and Atmosphere then
        TweenService:Create(v43, TweenInfo.new(5), Atmosphere):Play();
    end;

    local v44 = DepthOfField;
    local DepthOfField2 = u30.DepthOfField;

    if v44 then
        if not DepthOfField2 then
            return;
        end;

        TweenService:Create(v44, TweenInfo.new(5), DepthOfField2):Play();
    end;
end;

local function RestoreWhenFree(p45: string) -- Line: 254
    -- upvalues: u2 (copy), u10 (ref), u42 (ref), IsAnotherSkyOwnerActive (copy), RestoreSharedLighting (copy)
    if p45 ~= "CurrentWeatherEvents" and not table.find(u2, p45) then
        return;
    end;

    if u10 then
        if u42 then
            u42:Disconnect();
            u42 = nil;
        end;

        return;
    end;

    if IsAnotherSkyOwnerActive() then
        return;
    end;

    if u42 then
        u42:Disconnect();
        u42 = nil;
    end;

    RestoreSharedLighting();
end;

local function CreateEvent(p46: boolean?) -- Line: 272
    -- upvalues: u10 (ref), u42 (ref), u4 (copy), u30 (copy), Lighting (copy), u5 (copy), SkyboxManager (copy), TweenService (copy), u11 (copy), u22 (copy), DepthOfField (copy), u26 (copy), HarvestMoonBlur (copy), u24 (copy), HarvestMoonColor (copy), u28 (copy), MoonBeamEnviormentFx (copy), u35 (ref), StartAmbience (copy)
    if u10 then
        return;
    end;

    u10 = true;

    if u42 then
        u42:Disconnect();
        u42 = nil;
    end;

    local v47 = p46 and 0.1 or 5;
    local ExposureCompensation = u30.Lighting.ExposureCompensation;
    local Brightness = u30.Lighting.Brightness;
    Lighting:SetAttribute("DefaultAmbient", u4.Ambient);
    Lighting:SetAttribute("DefaultExposure", ExposureCompensation);
    Lighting:SetAttribute("DefaultBrightness", Brightness);

    if u5 then
        SkyboxManager.UpdateSkybox(u5, 5);
    end;

    TweenService:Create(Lighting, TweenInfo.new(v47), u4):Play();
    local v48 = u11;
    local v49 = u22;

    if v48 and v49 then
        TweenService:Create(v48, TweenInfo.new(v47), v49):Play();
    end;

    local v50 = DepthOfField;
    local v51 = u26;

    if v50 and v51 then
        TweenService:Create(v50, TweenInfo.new(v47), v51):Play();
    end;

    local v52 = HarvestMoonBlur;
    local v53 = u24;

    if v52 and v53 then
        TweenService:Create(v52, TweenInfo.new(v47), v53):Play();
    end;

    local v54 = HarvestMoonColor;
    local v55 = u28;

    if v54 and v55 then
        TweenService:Create(v54, TweenInfo.new(v47), v55):Play();
    end;

    if MoonBeamEnviormentFx and MoonBeamEnviormentFx:IsA("BasePart") then
        if u35 then
            u35:Destroy();
            u35 = nil;
        end;

        local v56 = MoonBeamEnviormentFx:Clone();
        v56.Anchored = true;
        v56.CanCollide = false;
        v56.CanQuery = false;
        v56.CanTouch = false;
        v56.CastShadow = false;
        v56.Transparency = 1;
        local WeatherVisuals = workspace:FindFirstChild("WeatherVisuals");

        if not WeatherVisuals then
            WeatherVisuals = Instance.new("Folder");
            WeatherVisuals.Name = "WeatherVisuals";
            WeatherVisuals.Parent = workspace;
        end;

        v56.Parent = WeatherVisuals;
        u35 = v56;
    end;

    StartAmbience(p46 == true);
end;

local function ResetEvent(p57: boolean?) -- Line: 298
    -- upvalues: u10 (ref), u35 (ref), StopAmbience (copy), TweenService (copy), HarvestMoonColor (copy), HarvestMoonBlur (copy), u5 (copy), SkyboxManager (copy), IsAnotherSkyOwnerActive (copy), u42 (ref), RestoreWhenFree (copy), RestoreSharedLighting (copy)
    if not u10 then
        return;
    end;

    u10 = false;

    if u35 then
        u35:Destroy();
        u35 = nil;
    end;

    if p57 then
        return;
    end;

    StopAmbience();
    TweenService:Create(HarvestMoonColor, TweenInfo.new(5), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    TweenService:Create(HarvestMoonBlur, TweenInfo.new(5), {
        Size = 0
    }):Play();

    if u5 then
        task.delay(5, function() -- Line: 318
            -- upvalues: u10 (ref), SkyboxManager (ref), u5 (ref)
            if u10 then
                return;
            end;

            SkyboxManager.UpdateSkybox(u5, 0);
        end);
    end;

    if not IsAnotherSkyOwnerActive() then
        RestoreSharedLighting();

        return;
    end;

    if u42 then
        u42:Disconnect();
        u42 = nil;
    end;

    u42 = workspace.AttributeChanged:Connect(RestoreWhenFree);
end;

if IsAnotherSkyOwnerActive() then
    local u58 = nil;
    u58 = workspace.AttributeChanged:Connect(function(p59: string) -- Line: 341
        -- upvalues: u2 (copy), u10 (ref), IsAnotherSkyOwnerActive (copy), u58 (ref), u30 (copy), Lighting (copy), u11 (copy), u3 (copy), DepthOfField (copy)
        if p59 ~= "CurrentWeatherEvents" and not table.find(u2, p59) then
            return;
        end;

        if u10 or IsAnotherSkyOwnerActive() then
            return;
        end;

        if u58 then
            u58:Disconnect();
            u58 = nil;
        end;

        u30.Lighting = {
            Ambient = Lighting.Ambient,
            Brightness = Lighting.Brightness,
            ExposureCompensation = Lighting.ExposureCompensation,
            GeographicLatitude = Lighting.GeographicLatitude,
            ShadowSoftness = Lighting.ShadowSoftness
        };
        local v60 = u11;
        local v61;

        if v60 then
            local v62 = u3[v60.ClassName];

            if v62 then
                v61 = {};

                for _, v in v62 do
                    v61[v] = v60[v];
                end;
            else
                v61 = nil;
            end;
        else
            v61 = nil;
        end;

        u30.Atmosphere = v61;
        local v63 = DepthOfField;
        local v64;

        if v63 then
            local v65 = u3[v63.ClassName];

            if v65 then
                v64 = {};

                for _, v in v65 do
                    v64[v] = v63[v];
                end;
            else
                v64 = nil;
            end;
        else
            v64 = nil;
        end;

        u30.DepthOfField = v64;
    end);
end;

workspace:GetAttributeChangedSignal("HarvestMoon"):Connect(function() -- Line: 365
    -- upvalues: CreateEvent (copy), ResetEvent (copy)
    if workspace:GetAttribute("HarvestMoon") then
        CreateEvent(workspace:GetAttribute("Instant"));

        return;
    end;

    ResetEvent();
end);

if workspace:GetAttribute("HarvestMoon") then
    task.defer(function() -- Line: 374
        -- upvalues: CreateEvent (copy)
        CreateEvent(true);
    end);
end;

return v1;