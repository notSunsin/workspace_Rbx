-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Replion = require(ReplicatedStorage.FFlags.Packages.Replion);
local Signal = require(ReplicatedStorage.Modules.Signal);
require(script.Parent.Types);
local v29 = {
    _loaded = false,
    _updatedSignal = Signal.new(),
    _loadedSignal = Signal.new(),

    IsLoaded = function(p1) -- Line: 50, Name: IsLoaded
        -- upvalues: Replion (copy)
        return Replion.Client:WaitReplion("FFlags"):Get("Loaded");
    end,

    OnLoad = function(p2, p3) -- Line: 55, Name: OnLoad
        return p2._loadedSignal:Connect(p3);
    end,

    OnUpdate = function(p4, p5) -- Line: 59, Name: OnUpdate
        return p4._updatedSignal:Connect(p5);
    end,

    OnChange = function(p6, p7, p8) -- Line: 63, Name: OnChange
        -- upvalues: Replion (copy)
        return Replion.Client:WaitReplion("FFlags"):OnChange({ "Values", p7 }, p8);
    end,

    Get = function(p9, p10, p11) -- Line: 69, Name: Get
        -- upvalues: Replion (copy)
        local v12 = Replion.Client:WaitReplion("FFlags");

        if not p9:IsLoaded() then
            p9._loadedSignal:Wait();
        end;

        local v13 = v12:Get({ "Values", p10 });

        if v13 == nil then
            return p11;
        end;

        return v13;
    end,

    GetInstant = function(p14, p15, p16) -- Line: 83, Name: GetInstant
        -- upvalues: Replion (copy)
        local Replion2 = Replion.Client:GetReplion("FFlags");

        if not Replion2 then
            return p16;
        end;

        local v17 = Replion2:Get({ "Values", p15 });

        if v17 == nil then
            return p16;
        end;

        return v17;
    end,

    _loadMemoryStore = function(p18) -- Line: 98, Name: _loadMemoryStore
        warn("FFlags:_loadMemoryStore() cannot be used on the client!");

        return false;
    end,

    _loadDataStore = function(p19) -- Line: 103, Name: _loadDataStore
        warn("FFlags:_loadDataStore() cannot be used on the client!");

        return false;
    end,

    Set = function(p20) -- Line: 108, Name: Set
        warn("FFlags:Set() cannot be used on the client!");

        return false;
    end,

    Load = function(p21) -- Line: 113, Name: Load
        warn("FFlags:Load() cannot be used on the client!");

        return false;
    end,

    Start = function(u22) -- Line: 118, Name: Start
        -- upvalues: Replion (copy)
        local u23 = Replion.Client:WaitReplion("FFlags");
        u22._loaded = u23:Get("Loaded");
        local u24 = nil;
        u24 = u23:OnChange("Loaded", function(p25: boolean, p26: boolean) -- Line: 123
            -- upvalues: u22 (copy), u23 (copy), u24 (ref)
            if p25 and not p26 then
                u22._loaded = p25;
                u22._loadedSignal:Fire(u23.Data);

                if u24.Connected then
                    u24:Disconnect();
                end;
            end;
        end);
        u23:OnChange("LastChange", function(p27: number, p28: number) -- Line: 134
            -- upvalues: u22 (copy), u23 (copy)
            u22._updatedSignal:Fire(u23.Data);
        end);
    end
};
task.spawn(v29.Start, v29);

return v29;