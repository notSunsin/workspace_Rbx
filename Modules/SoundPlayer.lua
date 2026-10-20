-- Decompiled with Potassium's decompiler.

local v1 = {};
local Debris = game:GetService("Debris");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundEffects = workspace:WaitForChild("SoundEffects", 30);
local SFX = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SFX", 30);
local SFX2 = SoundService:WaitForChild("Music"):WaitForChild("SFX");
local PlaySoundNew = ReplicatedStorage.GameEvents.PlaySoundNew;
local u2 = {};

local function _warn(...) -- Line: 48
    if game:GetService("RunService"):IsStudio() then
        warn((`[{script.Name}]: {...}`));
    end;
end;

local function FadeInTween(p3: userdata, p4: table) -- Line: 54
    -- upvalues: TweenService (copy)
    p3.Volume = 0;
    local u5 = TweenService:Create(p3, TweenInfo.new(p4.FadeInDuration or 1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Volume = p4.Volume
    });
    u5:Play();
    u5.Completed:Once(function() -- Line: 59
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);

    return u5;
end;

local function FadeOutTween(p6: userdata, p7: table) -- Line: 66
    -- upvalues: TweenService (copy)
    local u8 = TweenService:Create(p6, TweenInfo.new(p7.FadeInDuration or 1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Volume = 0
    });
    u8:Play();
    u8.Completed:Once(function() -- Line: 70
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);

    return u8;
end;

local function RemoveFromSoundCache(p9: userdata, p10: boolean?) -- Line: 77
    -- upvalues: u2 (copy), Debris (copy)
    if not p10 then
        task.wait(10);
    end;

    if p9.IsPlaying then
        return;
    end;

    local v11 = u2[p9.SoundId];

    if not v11 then
        return;
    end;

    local table_find_ret = table.find(v11, p9);

    if not table_find_ret then
        return;
    end;

    table.remove(v11, table_find_ret);

    if #v11 == 0 then
        u2[p9.SoundId] = nil;
    end;

    if not p10 then
        if p9.Parent and p9.Parent:IsA("Attachment") then
            Debris:AddItem(p9.Parent, 1);
        end;

        p9:AddTag("DestroyedBySoundPlayer");
        Debris:AddItem(p9, 0.5);
    end;
end;

local function GetInactiveSound(p12: string) -- Line: 109
    -- upvalues: u2 (copy), SoundEffects (copy)
    local v13 = nil;
    local v14 = u2[p12];

    if not v14 then
        v14 = {};
        u2[p12] = v14;
    end;

    for _, v in v14 do
        if v and not v.IsPlaying then
            v13 = v;
            break;
        end;
    end;

    if v13 == nil then
        v13 = Instance.new("Sound");
        v13.SoundId = p12;
        table.insert(v14, v13);
    end;

    if v13 then
        local Parent = v13.Parent;

        if Parent and Parent:IsA("Attachment") then
            v13.Parent = SoundEffects;
            Parent:Destroy();
        end;
    end;

    return v13;
end;

local function waitForSoundWithTimeout(u15: userdata, p16: number) -- Line: 151
    local u17 = false;
    task.spawn(function() -- Line: 154
        -- upvalues: u15 (copy), u17 (ref)
        if not u15.IsLoaded then
            u15.Loaded:Wait();
        end;

        u17 = true;
    end);
    local os_clock_ret = os.clock();

    while not u17 and os.clock() - os_clock_ret < p16 do
        task.wait();
    end;

    return u17;
end;

local function PlaySound(p18: string, u19: table?, p20: vector?, p21: userdata?, p22: table?, p23: table?) -- Line: 169
    -- upvalues: _warn (copy), GetInactiveSound (copy), SoundService (copy), SoundEffects (copy), SFX (copy), SFX2 (copy), u2 (copy), waitForSoundWithTimeout (copy), FadeInTween (copy), FadeOutTween (copy), RemoveFromSoundCache (copy)
    if not p18 then
        _warn("[PlaySound()] SoundID is nil!");

        return nil;
    end;

    if p18 == "rbxassetid://0" then
        _warn("[PlaySound()] SoundID is rbxassetid://0!");

        return nil;
    end;

    local u24 = GetInactiveSound(p18);
    local Attachment = Instance.new("Attachment");
    u24.SoundId = p18;
    u24.SoundGroup = SoundService.Music.SFX;

    if p21 then
        Attachment.Parent = p21;
        u24.Parent = Attachment;
    elseif p20 then
        Attachment.Parent = SoundEffects;
        u24.Parent = Attachment;
    else
        u24.Parent = SFX;
    end;

    if p20 then
        Attachment.WorldCFrame = CFrame.new(p20);
    else
        Attachment.CFrame = CFrame.new(Vector3.new(0, 0, 0));
    end;

    if u19 then
        u24.RollOffMaxDistance = u19.RollOffMaxDistance or 1000;
        u24.RollOffMinDistance = u19.RollOffMinDistance or 10;
        u24.RollOffMode = u19.RollOffMode or Enum.RollOffMode.Inverse;
        u24.Looped = u19.Looped or false;
        u24.PlaybackSpeed = u19.PlaybackSpeed or 1;
        u24.TimePosition = u19.TimePosition or 0;
        u24.Volume = u19.Volume or 0.5;
        u24.SoundGroup = u19.SoundGroup or SFX2;
    end;

    u24.Destroying:Once(function() -- Line: 223
        -- upvalues: u24 (copy), u2 (ref)
        if u24:HasTag("DestroyedBySoundPlayer") then
            return;
        end;

        local v25 = u24;

        if v25.IsPlaying then
            return;
        end;

        local v26 = u2[v25.SoundId];

        if not v26 then
            return;
        end;

        local table_find_ret = table.find(v26, v25);

        if not table_find_ret then
            return;
        end;

        table.remove(v26, table_find_ret);

        if #v26 == 0 then
            u2[v25.SoundId] = nil;
        end;
    end);

    if not waitForSoundWithTimeout(u24, 3) then
        if p18 == "" then
            print("[SoundPlayer]: Sound did not load: Sound Id is an empty string.");

            return u24;
        end;

        warn((`[SoundPlayer]: Sound Id {p18} did not load in time!`));

        return u24;
    end;

    if u19 then
        if u19.FadeInDuration then
            FadeInTween(u24, u19);
        end;

        if u19.FadeOutDuration then
            task.delay((u19.LoopDuration or u24.TimeLength) - u19.FadeOutDuration, function() -- Line: 250
                -- upvalues: u24 (copy), FadeOutTween (ref), u19 (copy)
                if not u24 then
                    return;
                end;

                FadeOutTween(u24, u19);
            end);
        end;
    end;

    if p22 then
        for _, v in p22 do
            u24:AddTag(v);
        end;
    end;

    if p23 then
        for i, v in p23 do
            local Instance_new_ret = Instance.new(i);

            for i2, v2 in v do
                Instance_new_ret[i2] = v2;
            end;

            Instance_new_ret.Parent = u24;
        end;
    end;

    u24.Ended:Once(function() -- Line: 277
        -- upvalues: RemoveFromSoundCache (ref), u24 (copy)
        RemoveFromSoundCache(u24);
    end);
    u24:Play();

    return u24;
end;

function v1.PlaySound(p27: table, p28: string, p29: table?, p30: vector?, p31: userdata?, p32: table?, p33: table?) -- Line: 297
    -- upvalues: PlaySound (copy)
    return PlaySound(p28, p29, p30, p31, p32, p33);
end;

PlaySoundNew.OnClientEvent:Connect(function(...) -- Line: 306
    -- upvalues: PlaySound (copy)
    PlaySound(...);
end);

return v1;