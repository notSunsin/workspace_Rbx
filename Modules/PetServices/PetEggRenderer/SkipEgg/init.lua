-- Decompiled with Potassium's decompiler.

local function PlaySound(p1: string) -- Line: 3
    local Sound = Instance.new("Sound");
    Sound.SoundId = p1;
    Sound.Parent = workspace;
    Sound:Play();
    Sound.Ended:Once(function() -- Line: 9
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
end;

return function(p2) -- Line: 14
    -- upvalues: PlaySound (copy)
    local Pivot = p2:GetPivot();
    PlaySound("rbxassetid://80226669144059");

    local function lerp(p3, p4, p5) -- Line: 19
        return p3 + (p4 - p3) * p5;
    end;

    local v6 = script.Part.Attachment:Clone();
    v6.Parent = workspace.Terrain;
    local v7 = 0;

    for _, descendant in v6:GetDescendants() do
        descendant.Enabled = true;
    end;

    v6.WorldCFrame = Pivot * CFrame.Angles(0, 0, 3.141592653589793);

    while v7 < 1.2 do
        v7 = v7 + game:GetService("RunService").Heartbeat:Wait();
        local Value = game:GetService("TweenService"):GetValue(v7 / 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local v8 = Pivot * CFrame.Angles(0, math.rad(Value * 1080), 0);
        local CFrame_Angles = CFrame.Angles;
        local v9 = math.sin(1080 * Value) * 35 * (1 - Value);
        p2:PivotTo(v8 * CFrame_Angles(0, 0, (math.rad(v9))));
    end;

    for _, descendant in v6:GetDescendants() do
        descendant.Enabled = false;
    end;

    game.Debris:AddItem(v6, 5);
end;