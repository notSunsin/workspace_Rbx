-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local SoundEffects = workspace:WaitForChild("SoundEffects");
local u1 = {};

local function GetSound(p2) -- Line: 13
    if typeof(p2) == "string" then
        local Sound = Instance.new("Sound");
        Sound.SoundId = p2;

        return Sound;
    end;

    if typeof(p2) == "Instance" and p2:IsA("Sound") then
        return p2:Clone();
    end;

    warn((`SoundHandler:GetSound | Invalid sound input: {p2}. Must be Sound instance or SoundId string.`));

    return nil;
end;

function u1.PlaySoundOnInstance(p3: table, p4: any, p5: userdata) -- Line: 27
    -- upvalues: GetSound (copy)
    local v6;

    if p5 and (p5:IsA("BasePart") or p5:IsA("Attachment")) then
        v6 = p5;
    else
        v6 = p5 and p5:FindFirstChildWhichIsA("BasePart");

        if not v6 then
            if p5 then
                v6 = p5:FindFirstChildWhichIsA("Attachment");
            else
                v6 = p5;
            end;
        end;

        if not v6 then
            warn((`SoundHandler:PlaySoundOnPart | Invalid part:{p5} provided for sound {p4}. Must BE or CONTAIN a BasePart or Attachment.`));

            return nil;
        end;
    end;

    local u7 = GetSound(p4);

    if not u7 then
        return nil;
    end;

    u7.Parent = v6;
    local success, result = pcall(function() -- Line: 46
        -- upvalues: u7 (copy)
        u7:Play();
    end);

    if success then
        u7.Ended:Connect(function() -- Line: 56
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);

        return u7;
    end;

    warn((`SoundHandler:PlaySoundOnPart | Failed to play sound {p4} on part {v6.Name}: {result}`));
    u7:Destroy();

    return nil;
end;

function u1.PlaySoundAtPosition(p8, p9, p10) -- Line: 64
    -- upvalues: SoundEffects (copy), u1 (copy)
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);

    if typeof(p10) == "Vector3" then
        Part.CFrame = CFrame.new(p10);
    elseif typeof(p10) == "CFrame" then
        Part.CFrame = p10;
    else
        if typeof(p10) ~= "Instance" or not p10:IsA("BasePart") then
            warn((`SoundHandler:PlaySoundAtPosition | Invalid position: {p10}`));
            Part:Destroy();

            return nil;
        end;

        Part.CFrame = p10.CFrame;
    end;

    Part.Parent = SoundEffects;
    local v11 = u1:PlaySoundOnInstance(p9, Part);

    if v11 then
        v11.Ended:Connect(function() -- Line: 87
            -- upvalues: Part (copy)
            Part:Destroy();
        end);

        return v11;
    end;

    Part:Destroy();

    return v11;
end;

function u1.PlaySound(p12, p13) -- Line: 98
    -- upvalues: GetSound (copy), SoundService (copy)
    local u14 = GetSound(p13);

    if not u14 then
        return nil;
    end;

    u14.Parent = SoundService;
    local success, result = pcall(function() -- Line: 105
        -- upvalues: u14 (copy)
        u14:Play();
    end);

    if success then
        u14.Ended:Connect(function() -- Line: 116
            -- upvalues: u14 (copy)
            u14:Destroy();
        end);

        return u14;
    end;

    warn((`SoundHandler:PlaySound | Failed to play sound {p13}: {result}`));
    u14:Destroy();

    return nil;
end;

function u1.FadeOut(p15: table, u16: userdata, u17: number, p18: boolean?) -- Line: 124
    if not (u16 and u16:IsA("Sound")) then
        warn("Invalid sound object provided.");

        return;
    end;

    local u19 = p18 or false;
    task.spawn(function() -- Line: 133
        -- upvalues: u16 (copy), u17 (copy), u19 (ref)
        local v20 = tick();
        local Volume = u16.Volume;

        while tick() - v20 < u17 do
            u16.Volume = Volume * (1 - (tick() - v20) / u17);
            task.wait();
        end;

        u16:Stop();
        u16.Volume = Volume;

        if u19 then
            u16:Destroy();
        end;
    end);
end;

return u1;