-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BindToDestroy = require(ReplicatedStorage.Modules.BindToDestroy);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local script_Parent = script.Parent;
local Setting = SettingsService:GetSetting("PerformanceMode");
local u1 = {};
local u2 = false;

for _, child in script_Parent:GetChildren() do
    if child:IsA("Texture") and child:HasTag("Cleanup_Variant") then
        table.insert(u1, child);
    end;
end;

local function CalcTextureTrans(p3: number) -- Line: 27
    if p3 <= 0.8 then
        return math.lerp(0.1, 0.5, p3 / 0.8);
    end;

    return math.lerp(0.5, 1, (p3 - 0.8) / 0.19999999999999996);
end;

local function SyncTextures(p4: number) -- Line: 35
    -- upvalues: u1 (copy)
    local v5;

    if p4 <= 0.8 then
        v5 = math.lerp(0.1, 0.5, p4 / 0.8);
    else
        v5 = math.lerp(0.5, 1, (p4 - 0.8) / 0.19999999999999996);
    end;

    for _, v in u1 do
        v.Transparency = v5;
    end;
end;

local u8 = script_Parent.ChildAdded:Connect(function(p6: userdata) -- Line: 43
    -- upvalues: u1 (copy), script_Parent (copy)
    if p6:IsA("Texture") and p6:HasTag("Cleanup_Variant") then
        table.insert(u1, p6);
        local Transparency = script_Parent.Transparency;
        local v7;

        if Transparency <= 0.8 then
            v7 = math.lerp(0.1, 0.5, Transparency / 0.8);
        else
            v7 = math.lerp(0.5, 1, (Transparency - 0.8) / 0.19999999999999996);
        end;

        p6.Transparency = v7;
    end;
end);

local function UpdateTransparency() -- Line: 52
    -- upvalues: u2 (ref), script_Parent (copy), Setting (copy), u1 (copy)
    if u2 then
        return;
    end;

    u2 = true;
    local Transparency = script_Parent.Transparency;

    if Setting then
        local v9;

        if Transparency <= 0.8 then
            v9 = math.lerp(0.1, 0.5, Transparency / 0.8);
        else
            v9 = math.lerp(0.5, 1, (Transparency - 0.8) / 0.19999999999999996);
        end;

        for _, v in u1 do
            v.Transparency = v9;
        end;
    else
        local v10 = Transparency < 0.8 and 0.8 or Transparency;
        script_Parent.Transparency = v10;
        local v11;

        if v10 <= 0.8 then
            v11 = math.lerp(0.1, 0.5, v10 / 0.8);
        else
            v11 = math.lerp(0.5, 1, (v10 - 0.8) / 0.19999999999999996);
        end;

        for _, v in u1 do
            v.Transparency = v11;
        end;
    end;

    task.delay(0.05, function() -- Line: 68
        -- upvalues: u2 (ref)
        u2 = false;
    end);
end;

local u12 = script_Parent:GetPropertyChangedSignal("Transparency"):Connect(UpdateTransparency);
UpdateTransparency();
BindToDestroy(script, function() -- Line: 77
    -- upvalues: u12 (ref), u8 (ref), Setting (copy), script_Parent (copy)
    u12:Disconnect();
    u12 = nil;
    u8:Disconnect();
    u8 = nil;

    if not Setting then
        script_Parent.Transparency = 0;
    end;
end);