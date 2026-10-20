-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local v1 = {};
local u2 = {
    Color3.fromRGB(255, 80, 80),
    Color3.fromRGB(255, 200, 50),
    Color3.fromRGB(80, 220, 80),
    Color3.fromRGB(80, 160, 255),
    Color3.fromRGB(220, 80, 255),
    Color3.fromRGB(255, 140, 0),
    Color3.fromRGB(255, 255, 80),
    Color3.fromRGB(80, 255, 220)
};

function v1.Play(u3: userdata, u4: number) -- Line: 20
    -- upvalues: u2 (copy), TweenService (copy)
    local math_floor_ret = math.floor(u4 / 16 * 140 + 10);
    local u5 = u4 / 16 * 2 + 1.5;

    for i = 1, math_floor_ret do
        task.spawn(function() -- Line: 25
            -- upvalues: u2 (ref), u3 (copy), u4 (copy), TweenService (ref), u5 (copy)
            local Frame = Instance.new("Frame");
            Frame.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame.BorderSizePixel = 0;
            Frame.BackgroundColor3 = u2[math.random(1, #u2)];
            Frame.ZIndex = 100;
            Frame.Size = UDim2.fromOffset(math.random(14, 28), math.random(14, 28));
            local v6 = math.random(0, 100) / 100;
            Frame.Position = UDim2.new(v6, 0, -0.05, 0);
            Frame.Rotation = math.random(0, 360);
            Frame.Parent = u3;
            task.wait(math.random(0, 60) / 100);
            local v7 = v6 + math.random(-15, 15) / 100;
            local v8 = 1.1 + math.random(0, 30) / 100;
            local v9 = math.random(-720, 720) * (u4 / 16);
            TweenService:Create(Frame, TweenInfo.new(u5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(v7, 0, v8, 0),
                Rotation = Frame.Rotation + v9
            }):Play();
            task.wait(u5);
            Frame:Destroy();
        end);
        local _ = i;
    end;
end;

return v1;