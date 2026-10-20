-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local TweenService = game:GetService("TweenService");

local function createShimmer(u2: userdata) -- Line: 39
    local Frame = Instance.new("Frame");
    Frame.Name = "UIShimmer";
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame.BackgroundTransparency = 0;
    Frame.ClipsDescendants = true;
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    Frame.Parent = u2;

    local function updateCornerRadius() -- Line: 54
        -- upvalues: u2 (copy), Frame (copy), updateCornerRadius (copy)
        if u2 and u2:FindFirstChildOfClass("UICorner") then
            local v3 = u2:FindFirstChildOfClass("UICorner");
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = v3.CornerRadius;
            UICorner.Parent = Frame;
            UICorner:GetPropertyChangedSignal("CornerRadius"):Connect(updateCornerRadius);
        end;
    end;

    Frame:GetPropertyChangedSignal("Parent"):Connect(updateCornerRadius);
    updateCornerRadius();

    local function updatePaddingOffset() -- Line: 71
        -- upvalues: u2 (copy), Frame (copy), updatePaddingOffset (copy)
        if u2 and u2:FindFirstChildOfClass("UIPadding") then
            local v4 = u2:FindFirstChildOfClass("UIPadding");
            local v5 = v4.PaddingTop.Offset - v4.PaddingBottom.Offset;
            local v6 = v4.PaddingLeft.Offset - v4.PaddingRight.Offset;
            Frame.Size = UDim2.new(1 / (1 - (v4.PaddingLeft.Scale + v4.PaddingRight.Scale)), v4.PaddingLeft.Offset + v4.PaddingRight.Offset, 1 / (1 - (v4.PaddingTop.Scale + v4.PaddingBottom.Scale)), v4.PaddingTop.Offset + v4.PaddingBottom.Offset);
            Frame.Position = UDim2.new(0.5, -v6 / 2, 0.5, -v5 / 2);
            v4:GetPropertyChangedSignal("PaddingLeft"):Connect(updatePaddingOffset);
            v4:GetPropertyChangedSignal("PaddingRight"):Connect(updatePaddingOffset);
            v4:GetPropertyChangedSignal("PaddingTop"):Connect(updatePaddingOffset);
            v4:GetPropertyChangedSignal("PaddingBottom"):Connect(updatePaddingOffset);
        end;
    end;

    Frame:GetPropertyChangedSignal("Parent"):Connect(updatePaddingOffset);
    updatePaddingOffset();
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 15;
    UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1));
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.15, 1),
        NumberSequenceKeypoint.new(0.5, 0.55),
        NumberSequenceKeypoint.new(0.85, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
    UIGradient.Offset = Vector2.new(-1, 0);
    UIGradient.Parent = Frame;

    return Frame;
end;

u1.PlaybackState = nil;

function u1.new(p7: userdata, p8: number?, p9: any, p10: any, p11: number?, p12: boolean?, p13: number?) -- Line: 120
    -- upvalues: u1 (copy), createShimmer (copy), TweenService (copy)
    local v14;

    if typeof(p7) == "Instance" then
        v14 = p7:IsA("GuiObject");
    else
        v14 = false;
    end;

    assert(v14, "Invalid parent argument. Expected GuiObject.");
    local v15 = p8 or 1;
    local v16 = typeof(v15) == "number";
    assert(v16, "Invalid time argument. Expected number.");
    local v17 = p9 or Enum.EasingStyle.Linear;
    local v18;

    if typeof(v17) == "EnumItem" then
        v18 = v17.EnumType == Enum.EasingStyle;
    else
        v18 = false;
    end;

    assert(v18, "Invalid style argument. Expected EasingStyle enum.");
    local v19 = p10 or Enum.EasingDirection.InOut;
    local v20;

    if typeof(v19) == "EnumItem" then
        v20 = v19.EnumType == Enum.EasingDirection;
    else
        v20 = false;
    end;

    assert(v20, "Invalid direction argument. Expected EasingDirection enum.");
    local v21 = p11 or -1;
    local v22 = typeof(v21) == "number";
    assert(v22, "Invalid repeatCount argument. Expected number.");
    local v23 = p12 or false;
    local v24 = typeof(v23) == "boolean";
    assert(v24, "Invalid reverses argument. Expected boolean.");
    local v25 = p13 or 0;
    local v26 = typeof(v25) == "number";
    assert(v26, "Invalid delayTime argument. Expected number.");
    local u27 = setmetatable({}, u1);
    local v28 = v17 or Enum.EasingStyle.Linear;
    local v29 = v19 or Enum.EasingDirection.InOut;
    local v30 = createShimmer(p7);
    u27._frame = v30;
    u27._gradient = v30:FindFirstChildOfClass("UIGradient");
    u27._corner = v30:FindFirstChildOfClass("UICorner");
    u27._tween = TweenService:Create(u27._gradient, TweenInfo.new(v15 or 1, v28, v29, v21 or -1, v23 or false, v25 or 0), {
        Offset = Vector2.new(1, 0)
    });
    u27._tween.Completed:Connect(function() -- Line: 180
        -- upvalues: u27 (copy)
        u27:_TweenCompleted();
    end);

    return u27;
end;

function u1._TweenCompleted(p31) -- Line: 188
    p31._frame.Visible = false;
    p31.PlaybackState = Enum.PlaybackState.Completed;
end;

function u1.GetFrame(p32) -- Line: 194
    return p32._frame;
end;

function u1.GetGradient(p33) -- Line: 199
    return p33._gradient;
end;

function u1.GetCorner(p34) -- Line: 204
    return p34._corner;
end;

function u1.Play(p35) -- Line: 209
    p35.PlaybackState = Enum.PlaybackState.Begin;
    p35._frame.Visible = true;
    p35._tween:Play();
    p35.PlaybackState = Enum.PlaybackState.Playing;
end;

function u1.Pause(p36) -- Line: 217
    if p36.PlaybackState == Enum.PlaybackState.Playing then
        p36._tween:Pause();
        p36.PlaybackState = Enum.PlaybackState.Paused;
    end;
end;

function u1.Cancel(p37) -- Line: 225
    p37._tween:Cancel();
    p37._frame.Visible = false;
    p37.PlaybackState = Enum.PlaybackState.Cancelled;
end;

return u1;