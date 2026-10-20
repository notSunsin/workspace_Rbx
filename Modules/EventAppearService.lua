-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;

function u1.new(p2: table) -- Line: 19
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.NPC = p2.NPC;
    v3.OriginalParent = p2.OriginalParent;
    v3.OriginalPosition = p2.OriginalPosition;
    v3.ParticleContainer = p2.ParticleContainer;
    v3.TweenDuration = p2.TweenDuration or 5;
    v3.VerticalOffset = p2.VerticalOffset or 20;
    v3.SoundName = p2.SoundName or "Rumble";
    v3.StorageFolder = p2.StorageFolder;
    v3.SkipAnimation = p2.SkipAnimation or false;
    v3.SkipAnimationEmitAmount = p2.SkipAnimationEmitAmount or 1;
    v3.IsActive = false;
    v3.CurrentTween = nil;
    v3.CurrentConnection = nil;
    v3.CurrentAlpha = nil;

    return v3;
end;

function u1.Appear(u4) -- Line: 45
    -- upvalues: TweenService (copy)
    if u4.IsActive then
        u4:_cancelCurrentAnimation();
    end;

    u4.IsActive = true;
    u4.NPC.Parent = u4.OriginalParent;
    u4.NPC:SetAttribute("State", "Entering");

    if u4.SkipAnimation then
        u4.NPC:PivotTo(u4.OriginalPosition);
        u4:_emitParticles(u4.SkipAnimationEmitAmount);
        local v5 = u4.ParticleContainer and u4.ParticleContainer:FindFirstChild(u4.SoundName);

        if v5 then
            v5:Play();
        end;

        u4:_cleanupAnimation();

        return;
    end;

    local u6 = u4.OriginalPosition * CFrame.new(0, -u4.VerticalOffset, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    u4.NPC:PivotTo(u6);
    u4:_toggleParticles(true);
    task.spawn(function() -- Line: 83
        -- upvalues: u4 (copy), TweenService (ref), u6 (copy)
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        u4.CurrentAlpha = NumberValue;
        u4.CurrentTween = TweenService:Create(NumberValue, TweenInfo.new(u4.TweenDuration, Enum.EasingStyle.Linear), {
            Value = 1
        });
        u4.CurrentTween:Play();
        u4.CurrentConnection = NumberValue.Changed:Connect(function(p7) -- Line: 95
            -- upvalues: u4 (ref), u6 (ref)
            if not (u4.NPC and u4.NPC.Parent) then
                u4:_cancelCurrentAnimation();

                return;
            end;

            u4.NPC:PivotTo(u6:Lerp(u4.OriginalPosition, p7));

            if p7 >= 1 then
                u4.NPC:SetAttribute("State", "Entered");
                u4:_toggleParticles(false);
                u4:_cleanupAnimation();
            end;
        end);
    end);
    u4:_playSound();
end;

function u1.Disappear(u8) -- Line: 116
    -- upvalues: TweenService (copy)
    if u8.IsActive then
        u8:_cancelCurrentAnimation();
    end;

    u8.IsActive = true;
    u8.NPC:SetAttribute("State", "Leaving");

    if u8.SkipAnimation then
        if not (u8.NPC and u8.NPC.Parent) then
            u8:_cancelCurrentAnimation();

            return;
        end;

        u8:_emitParticles(u8.SkipAnimationEmitAmount);
        local v9 = u8.ParticleContainer and u8.ParticleContainer:FindFirstChild(u8.SoundName);

        if v9 then
            v9:Play();
        end;

        u8:_cleanupAnimation();
        u8.NPC:SetAttribute("State", "Left");

        if u8.StorageFolder then
            u8.NPC.Parent = u8.StorageFolder;
        end;
    else
        local u10 = u8.OriginalPosition * CFrame.new(0, -u8.VerticalOffset, 0) * CFrame.Angles(0, 3.141592653589793, 0);
        u8.NPC:PivotTo(u8.OriginalPosition);
        u8:_toggleParticles(true);
        task.spawn(function() -- Line: 164
            -- upvalues: u8 (copy), TweenService (ref), u10 (copy)
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 0;
            u8.CurrentAlpha = NumberValue;
            u8.CurrentTween = TweenService:Create(NumberValue, TweenInfo.new(u8.TweenDuration, Enum.EasingStyle.Linear), {
                Value = 1
            });
            u8.CurrentTween:Play();
            u8.CurrentConnection = NumberValue.Changed:Connect(function(p11) -- Line: 176
                -- upvalues: u8 (ref), u10 (ref)
                if not (u8.NPC and u8.NPC.Parent) then
                    u8:_cancelCurrentAnimation();

                    return;
                end;

                u8.NPC:PivotTo(u8.OriginalPosition:Lerp(u10, p11));

                if p11 >= 1 then
                    u8.NPC:SetAttribute("State", "Left");

                    if u8.StorageFolder then
                        u8.NPC.Parent = u8.StorageFolder;
                    end;

                    u8:_toggleParticles(false);
                    u8:_cleanupAnimation();
                end;
            end);
        end);
        u8:_playSound();
    end;
end;

function u1._toggleParticles(p12: table, p13: boolean) -- Line: 203
    if not p12.ParticleContainer then
        return;
    end;

    for _, child in p12.ParticleContainer:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child.Enabled = p13;
        end;
    end;
end;

function u1._emitParticles(p14: table, p15: number) -- Line: 213
    if not p14.ParticleContainer then
        return;
    end;

    for _, child in p14.ParticleContainer:GetChildren() do
        if child:IsA("ParticleEmitter") then
            child:Emit(p15);
        end;
    end;
end;

function u1._playSound(p16) -- Line: 223
    if not p16.ParticleContainer then
        return;
    end;

    local v17 = p16.ParticleContainer:FindFirstChild(p16.SoundName);

    if v17 and v17:IsA("Sound") then
        v17.TimePosition = 0;
        v17:Play();
    end;
end;

function u1._cancelCurrentAnimation(p18) -- Line: 238
    if p18.CurrentConnection then
        p18.CurrentConnection:Disconnect();
        p18.CurrentConnection = nil;
    end;

    if p18.CurrentTween then
        p18.CurrentTween:Cancel();
        p18.CurrentTween = nil;
    end;

    if p18.CurrentAlpha then
        p18.CurrentAlpha:Destroy();
        p18.CurrentAlpha = nil;
    end;

    p18:_toggleParticles(false);
    p18.IsActive = false;
end;

function u1._cleanupAnimation(p19) -- Line: 263
    if p19.CurrentConnection then
        p19.CurrentConnection:Disconnect();
        p19.CurrentConnection = nil;
    end;

    if p19.CurrentAlpha then
        game.Debris:AddItem(p19.CurrentAlpha, 1);
        p19.CurrentAlpha = nil;
    end;

    p19.CurrentTween = nil;
end;

function u1.Destroy(p20) -- Line: 277
    p20:_cancelCurrentAnimation();
end;

return u1;