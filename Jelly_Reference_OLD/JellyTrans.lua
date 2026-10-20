-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BindToDestroy = require(ReplicatedStorage.Modules.BindToDestroy);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local script_Parent = script.Parent;
local Setting = SettingsService:GetSetting("PerformanceMode");
local u1 = {};
local u2 = Setting and 0.35 or 0;
local u3 = false;

for _, child in script_Parent:GetChildren() do
    if child:IsA("Texture") and child:HasTag("Cleanup_Variant") then
        table.insert(u1, child);
    end;
end;

local u5 = script_Parent.ChildAdded:Connect(function(p4: userdata) -- Line: 27
    -- upvalues: u1 (copy), script_Parent (copy), u2 (copy)
    if p4:IsA("Texture") and p4:HasTag("Cleanup_Variant") then
        table.insert(u1, p4);
        p4.Transparency = math.clamp(script_Parent.Transparency + u2, 0, 1);
    end;
end);

local function SyncTextures(p6: number) -- Line: 35
    -- upvalues: u1 (copy), u2 (copy)
    for _, v in u1 do
        v.Transparency = math.clamp(p6 + u2, 0, 1);
    end;
end;

local function UpdateTransparency() -- Line: 43
    -- upvalues: u3 (ref), script_Parent (copy), Setting (copy), u1 (copy), u2 (copy)
    if u3 then
        return;
    end;

    u3 = true;
    local Transparency = script_Parent.Transparency;

    if Setting then
        for _, v in u1 do
            v.Transparency = math.clamp(Transparency + u2, 0, 1);
        end;
    else
        local v7 = Transparency < 0.8 and 0.8 or Transparency;
        script_Parent.Transparency = v7;

        for _, v in u1 do
            v.Transparency = math.clamp(v7 + u2, 0, 1);
        end;
    end;

    task.delay(0.05, function() -- Line: 59
        -- upvalues: u3 (ref)
        u3 = false;
    end);
end;

local u8 = script_Parent:GetPropertyChangedSignal("Transparency"):Connect(UpdateTransparency);
UpdateTransparency();
BindToDestroy(script, function() -- Line: 68
    -- upvalues: u8 (ref), u5 (ref), Setting (copy), script_Parent (copy)
    u8:Disconnect();
    u8 = nil;
    u5:Disconnect();
    u5 = nil;

    if not Setting then
        script_Parent.Transparency = 0;
    end;
end);