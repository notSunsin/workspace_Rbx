-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local SettingsService = require(game.ReplicatedStorage.Modules.Settings.SettingsService);
local DataService = require(game.ReplicatedStorage.Modules.DataService);
local u1 = not SettingsService:GetSetting("PerformanceMode");
local u2 = {};

local function Begin(p3) -- Line: 11
    -- upvalues: u1 (ref), u2 (copy)
    if not u1 then
        return;
    end;

    if not p3:IsDescendantOf(workspace) then
        return;
    end;

    if not u2[p3] then
        local AnimationController = p3:FindFirstChild("AnimationController");

        if not AnimationController then
            return;
        end;

        u2[p3] = AnimationController:LoadAnimation(script.Animation);
    end;

    u2[p3]:Play();
    u2[p3]:AdjustSpeed(0.75);
end;

local u4 = {};

local function InstanceAdded(u5) -- Line: 33
    -- upvalues: u4 (copy), Begin (copy), u2 (copy)
    if not u5 then
        return;
    end;

    if u4[u5] then
        return;
    end;

    Begin(u5);
    u4[u5] = u5.AncestryChanged:Connect(function() -- Line: 39
        -- upvalues: u5 (copy), Begin (ref), u2 (ref)
        if u5:IsDescendantOf(workspace) then
            Begin(u5);

            return;
        end;

        local v6 = u5;

        if not u2[v6] then
            return;
        end;

        u2[v6]:Stop();
    end);
    u5.Destroying:Once(function() -- Line: 47
        -- upvalues: u4 (ref), u5 (copy)
        u4[u5]:Disconnect();
    end);
end;

CollectionService:GetInstanceAddedSignal("SharkSplash"):Connect(InstanceAdded);
CollectionService:GetInstanceRemovedSignal("SharkSplash"):Connect(function(p7) -- Line: 25, Name: End
    -- upvalues: u2 (copy)
    if not u2[p7] then
        return;
    end;

    u2[p7]:Stop();
end);

for _, v in CollectionService:GetTagged("SharkSplash") do
    InstanceAdded(v);
end;

local u8 = nil;
u8 = DataService:GetPathSignal("Settings/@"):Connect(function() -- Line: 60
    -- upvalues: u1 (ref), SettingsService (copy), u2 (copy), u4 (copy), u8 (ref)
    u1 = not SettingsService:GetSetting("PerformanceMode");

    if u1 then
        return;
    end;

    for i, v in u2 do
        v:Stop();
        local v9 = u4[i];

        if v9 then
            v9:Disconnect();
        end;
    end;

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;
end);

return u2;