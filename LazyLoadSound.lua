-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Observers = require(ReplicatedStorage.Modules.Observers);
local Trove = require(ReplicatedStorage.Modules.Trove);

local function lazyLoad(u1: userdata, u2: any) -- Line: 14
    -- upvalues: RunService (copy)
    if u1.SoundId ~= "rbxassetid://133426881644587" then
        return;
    end;

    local Attribute = u1:GetAttribute("SoundId");

    if not Attribute then
        if RunService:IsStudio() then
            warn((`LazyLoadSound {u1:GetFullName()} is missing its SoundId attribute somehow`));
        end;

        return;
    end;

    local TimePosition = u1.TimePosition;
    u1.SoundId = Attribute;
    u2:Add(task.spawn(function() -- Line: 38
        -- upvalues: u1 (copy), TimePosition (copy), u2 (copy)
        while u1.IsPlaying and not u1.IsLoaded do
            task.wait();
        end;

        u1.TimePosition = TimePosition;
        u2:Clean();
    end));
end;

return Observers.observeTag("LazyLoadSound", function(u3: userdata) -- Line: 52
    -- upvalues: RunService (copy), Trove (copy), lazyLoad (copy)
    if not u3:IsA("Sound") then
        return nil;
    end;

    if RunService:IsServer() then
        if u3.SoundId == "rbxassetid://133426881644587" then
            return nil;
        end;

        u3:SetAttribute("SoundId", u3.SoundId);
        u3.SoundId = "rbxassetid://133426881644587";
    end;

    local u4 = Trove.new();
    u4:Connect(u3:GetPropertyChangedSignal("Playing"), function() -- Line: 70
        -- upvalues: lazyLoad (ref), u3 (copy), u4 (copy)
        lazyLoad(u3, u4);
    end);
    u4:Connect(u3.Played, function() -- Line: 74
        -- upvalues: lazyLoad (ref), u3 (copy), u4 (copy)
        lazyLoad(u3, u4);
    end);

    if u3.IsPlaying or u3.Playing then
        lazyLoad(u3, u4);
    end;

    return u4:WrapClean();
end);