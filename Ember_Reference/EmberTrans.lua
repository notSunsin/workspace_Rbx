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
    return p3 >= 1 and 1 or 0;
end;

local function SyncTextures(p4: number) -- Line: 39
    -- upvalues: u1 (copy)
    local v5 = p4 >= 1 and 1 or 0;

    for _, v in u1 do
        v.Transparency = v5;
    end;
end;

local u7 = script_Parent.ChildAdded:Connect(function(p6: userdata) -- Line: 47
    -- upvalues: u1 (copy), script_Parent (copy)
    if p6:IsA("Texture") and p6:HasTag("Cleanup_Variant") then
        table.insert(u1, p6);
        p6.Transparency = script_Parent.Transparency >= 1 and 1 or 0;
    end;
end);

local function UpdateTransparency() -- Line: 56
    -- upvalues: u2 (ref), script_Parent (copy), Setting (copy), u1 (copy)
    if u2 then
        return;
    end;

    u2 = true;
    local Transparency = script_Parent.Transparency;

    if Setting then
        local v8 = Transparency >= 1 and 1 or 0;

        for _, v in u1 do
            v.Transparency = v8;
        end;
    else
        local v9 = Transparency < 0 and 0 or Transparency;
        script_Parent.Transparency = v9;
        local v10 = v9 >= 1 and 1 or 0;

        for _, v in u1 do
            v.Transparency = v10;
        end;
    end;

    task.delay(0.05, function() -- Line: 72
        -- upvalues: u2 (ref)
        u2 = false;
    end);
end;

local u11 = script_Parent:GetPropertyChangedSignal("Transparency"):Connect(UpdateTransparency);
UpdateTransparency();
BindToDestroy(script, function() -- Line: 81
    -- upvalues: u11 (ref), u7 (ref), Setting (copy), script_Parent (copy)
    u11:Disconnect();
    u11 = nil;
    u7:Disconnect();
    u7 = nil;

    if not Setting then
        script_Parent.Transparency = 0;
    end;
end);