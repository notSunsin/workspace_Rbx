-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local v1 = {};
local u2 = {
    Color3.fromRGB(255, 60, 60),
    Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(60, 255, 60),
    Color3.fromRGB(60, 60, 255),
    Color3.fromRGB(180, 60, 255)
};

function v1.Play(p3: userdata, p4: number) -- Line: 18
    -- upvalues: u2 (copy), TweenService (copy)
    local v5 = math.floor(p4 / 16 * 5) + 1;
    local v6 = p4 / 16 * 0.35 + 0.15;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.Position = UDim2.fromScale(0, 0);
    Frame.BorderSizePixel = 0;
    Frame.BackgroundTransparency = 1;
    Frame.ZIndex = 99;
    Frame.Parent = p3;

    for i = 1, v5 do
        local _ = i;

        for _, v in u2 do
            Frame.BackgroundColor3 = v;
            TweenService:Create(Frame, TweenInfo.new(0.12, Enum.EasingStyle.Linear), {
                BackgroundTransparency = 1 - v6
            }):Play();
            task.wait(0.12);
            TweenService:Create(Frame, TweenInfo.new(0.12, Enum.EasingStyle.Linear), {
                BackgroundTransparency = 1
            }):Play();
            task.wait(0.12);
        end;
    end;

    Frame:Destroy();
end;

return v1;