-- Decompiled with Potassium's decompiler.

local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Music = SoundService.Music.Tunes.Music;
local Tunes = SoundService.Music.Tunes;
local u1 = {};
local u2 = nil;

local function getHighestActive() -- Line: 22
    -- upvalues: u1 (copy)
    local v3 = (-1 / 0);
    local v4 = nil;

    for i, v in u1 do
        local v5 = v.config.priority or 10;

        if v3 < v5 then
            v4 = i;
            v3 = v5;
        end;
    end;

    return v4;
end;

local function tweenTo(p6, p7, p8) -- Line: 34
    -- upvalues: TweenService (copy)
    TweenService:Create(p6, TweenInfo.new(p8, Enum.EasingStyle.Linear), p7):Play();
end;

local function refresh() -- Line: 38
    -- upvalues: u1 (copy), u2 (ref), TweenService (copy), Music (copy)
    local v9 = (-1 / 0);
    local v10 = nil;

    for i, v in u1 do
        local v11 = v.config.priority or 10;

        if v9 < v11 then
            v10 = i;
            v9 = v11;
        end;
    end;

    if v10 == u2 then
        return;
    end;

    if u2 and u1[u2] then
        local v12 = u1[u2];

        if v12.sound and v12.sound.Parent then
            TweenService:Create(v12.sound, TweenInfo.new(v12.config.fadeOut or 1, Enum.EasingStyle.Linear), {
                Volume = 0
            }):Play();
        end;
    end;

    u2 = v10;

    if u2 then
        local v13 = u1[u2];
        local v14 = v13.config.fadeIn or 1;
        TweenService:Create(Music, TweenInfo.new(v14, Enum.EasingStyle.Linear), {
            Volume = 0
        }):Play();

        if v13.sound then
            if not v13.sound.IsPlaying then
                v13.sound.Volume = 0;
                v13.sound:Play();
            end;

            local v15 = {
                Volume = v13.config.volume or 0.5
            };
            TweenService:Create(v13.sound, TweenInfo.new(v14, Enum.EasingStyle.Linear), v15):Play();
        end;
    else
        TweenService:Create(Music, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Volume = 1
        }):Play();
    end;
end;

return {
    Start = function(p16: string, p17: table) -- Line: 71, Name: Start
        -- upvalues: u1 (copy), u2 (ref), Tunes (copy), SoundService (copy), refresh (copy)
        if u1[p16] then
            local v18 = u1[p16];

            if v18.sound and v18.sound.Parent then
                v18.sound:Stop();
                v18.sound:Destroy();
            end;

            u1[p16] = nil;

            if u2 == p16 then
                u2 = nil;
            end;
        end;

        local v19;

        if p17.soundId and p17.soundId ~= "" then
            v19 = Instance.new("Sound");
            v19.Name = "WeatherMusic_" .. p16;
            v19.SoundId = p17.soundId;
            v19.Volume = 0;

            if p17.looped == nil then
                v19.Looped = true;
            else
                v19.Looped = p17.looped;
            end;

            if p17.playbackSpeed then
                v19.PlaybackSpeed = p17.playbackSpeed;
            end;

            if p17.timePosition then
                v19.TimePosition = p17.timePosition;
            end;

            v19.SoundGroup = Tunes;
            v19.Parent = SoundService;
        else
            v19 = nil;
        end;

        u1[p16] = {
            sound = v19,
            config = p17
        };
        refresh();

        return v19;
    end,

    GetSound = function(p20: string) -- Line: 112, Name: GetSound
        -- upvalues: u1 (copy)
        local v21 = u1[p20];

        if v21 then
            return v21.sound;
        end;

        return nil;
    end,

    Stop = function(p22: string) -- Line: 118, Name: Stop
        -- upvalues: u1 (copy), TweenService (copy), refresh (copy)
        local v23 = u1[p22];

        if not v23 then
            return;
        end;

        if v23.sound then
            local v24 = v23.config.fadeOut or 1;
            TweenService:Create(v23.sound, TweenInfo.new(v24, Enum.EasingStyle.Linear), {
                Volume = 0
            }):Play();
            local sound = v23.sound;
            task.delay(v24 + 0.5, function() -- Line: 126
                -- upvalues: sound (copy)
                if sound and sound.Parent then
                    sound:Stop();
                    sound:Destroy();
                end;
            end);
        end;

        u1[p22] = nil;
        refresh();
    end
};