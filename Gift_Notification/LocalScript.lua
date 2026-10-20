-- Decompiled with Potassium's decompiler.

local Holder = script.Parent.Holder;
local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local _ = Holder.Position;
Holder.Position = UDim2.new(1.25, 0, 0.5, 0);
local v1 = TweenService:Create(Holder, TweenInfo_new_ret, {
    Position = UDim2.new(0.5, 0, 0.5, 0)
});
v1:Play();
game.Debris:AddItem(v1, TweenInfo_new_ret.Time);
local v2 = { script.Parent };

for _, descendant in pairs(script.Parent:GetDescendants()) do
    if descendant:IsA("Frame") or (descendant:IsA("TextLabel") or (descendant:IsA("UIStroke") or (descendant:IsA("ImageLabel") or descendant:IsA("TextButton")))) then
        table.insert(v2, descendant);
    end;
end;

local u3 = {};

for _, v in pairs(v2) do
    if v:IsA("TextLabel") then
        local TextTransparency = v.TextTransparency;
        local TextStrokeTransparency = v.TextStrokeTransparency;
        v.TextTransparency = 1;
        v.TextStrokeTransparency = 1;
        local v4 = TweenService:Create(v, TweenInfo_new_ret, {
            TextTransparency = TextTransparency,
            TextStrokeTransparency = TextStrokeTransparency
        });
        v4:Play();
        game.Debris:AddItem(v4, TweenInfo_new_ret.Time);
        local v5 = TweenService:Create(v, TweenInfo_new_ret, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        });
        table.insert(u3, v5);
    elseif v:IsA("Frame") then
        local BackgroundTransparency = v.BackgroundTransparency;
        v.BackgroundTransparency = 1;
        local v6 = TweenService:Create(v, TweenInfo_new_ret, {
            BackgroundTransparency = BackgroundTransparency
        });
        v6:Play();
        game.Debris:AddItem(v6, TweenInfo_new_ret.Time);
        local v7 = TweenService:Create(v, TweenInfo_new_ret, {
            BackgroundTransparency = 1
        });
        table.insert(u3, v7);
    elseif v:IsA("UIStroke") then
        local Transparency = v.Transparency;
        v.Transparency = 1;
        local v8 = TweenService:Create(v, TweenInfo_new_ret, {
            Transparency = Transparency
        });
        v8:Play();
        game.Debris:AddItem(v8, TweenInfo_new_ret.Time);
        local v9 = TweenService:Create(v, TweenInfo_new_ret, {
            Transparency = 1
        });
        table.insert(u3, v9);
    elseif v:IsA("ImageLabel") then
        local ImageTransparency = v.ImageTransparency;
        local BackgroundTransparency = v.BackgroundTransparency;
        v.ImageTransparency = 1;
        v.BackgroundTransparency = 1;
        local v10 = TweenService:Create(v, TweenInfo_new_ret, {
            ImageTransparency = ImageTransparency,
            BackgroundTransparency = BackgroundTransparency
        });
        v10:Play();
        game.Debris:AddItem(v10, TweenInfo_new_ret.Time);
        local v11 = TweenService:Create(v, TweenInfo_new_ret, {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        });
        table.insert(u3, v11);
    elseif v:IsA("TextButton") then
        local TextTransparency = v.TextTransparency;
        local BackgroundTransparency = v.BackgroundTransparency;
        v.TextTransparency = 1;
        v.BackgroundTransparency = 1;
        local v12 = TweenService:Create(v, TweenInfo_new_ret, {
            TextTransparency = TextTransparency,
            BackgroundTransparency = BackgroundTransparency
        });
        v12:Play();
        game.Debris:AddItem(v12, TweenInfo_new_ret.Time);
        local v13 = TweenService:Create(v, TweenInfo_new_ret, {
            TextTransparency = 1,
            BackgroundTransparency = 1
        });
        table.insert(u3, v13);
    end;
end;

task.spawn(function() -- Line: 67
    -- upvalues: u3 (copy), TweenInfo_new_ret (copy)
    task.wait(30);

    if script.Parent then
        for _, v in pairs(u3) do
            v:Play();
        end;

        game.Debris:AddItem(script.Parent, TweenInfo_new_ret.Time);
    end;
end);