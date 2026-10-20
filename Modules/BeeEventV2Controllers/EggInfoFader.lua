-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local v1 = {};
local u2 = {};

local function GetTransparencyProps(p3: userdata) -- Line: 11
    return p3:IsA("UIStroke") and { "Transparency" } or ((p3:IsA("ImageLabel") or p3:IsA("ImageButton")) and { "BackgroundTransparency", "ImageTransparency" } or ((p3:IsA("TextLabel") or (p3:IsA("TextButton") or p3:IsA("TextBox"))) and { "BackgroundTransparency", "TextTransparency", "TextStrokeTransparency" } or (p3:IsA("CanvasGroup") and { "GroupTransparency" } or ((p3:IsA("Frame") or p3:IsA("ScrollingFrame")) and { "BackgroundTransparency" } or nil))));
end;

local function CaptureOriginals(p4: userdata) -- Line: 20
    -- upvalues: u2 (copy), GetTransparencyProps (copy)
    local v5 = u2[p4];

    if v5 then
        return v5;
    end;

    local v6 = {};

    for _, descendant in p4:GetDescendants() do
        local v7 = GetTransparencyProps(descendant);

        if v7 then
            local v8 = descendant;
            local v9 = {};

            for _, v in v7 do
                v9[v] = v8[v];
            end;

            v6[v8] = v9;
        end;
    end;

    local v10 = {
        Originals = v6,
        ActiveTweens = {}
    };
    u2[p4] = v10;

    return v10;
end;

local function CancelActive(p11: table) -- Line: 40
    for _, v in p11.ActiveTweens do
        v:Cancel();
    end;

    table.clear(p11.ActiveTweens);
end;

local function ApplyInstant(p12: table, p13: number) -- Line: 47
    for i, v in p12.Originals do
        if i.Parent then
            local v14 = i;

            for i2, v2 in v do
                v14[i2] = v2 + (1 - v2) * p13;
            end;
        end;
    end;
end;

function v1.Show(p15: userdata) -- Line: 56
    -- upvalues: CaptureOriginals (copy), ApplyInstant (copy), TweenService (copy)
    local v16 = CaptureOriginals(p15);

    for _, v in v16.ActiveTweens do
        v:Cancel();
    end;

    table.clear(v16.ActiveTweens);

    if not p15.Enabled then
        ApplyInstant(v16, 1);
        p15.Enabled = true;
    end;

    local TweenInfo_new_ret = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

    for i, v in v16.Originals do
        if i.Parent then
            local v17 = TweenService:Create(i, TweenInfo_new_ret, v);
            table.insert(v16.ActiveTweens, v17);
            v17:Play();
        end;
    end;
end;

function v1.Hide(u18: userdata) -- Line: 74
    -- upvalues: CaptureOriginals (copy), TweenService (copy), u2 (copy)
    if not u18.Enabled then
        return;
    end;

    local u19 = CaptureOriginals(u18);

    for _, v in u19.ActiveTweens do
        v:Cancel();
    end;

    table.clear(u19.ActiveTweens);
    local TweenInfo_new_ret = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local v20 = nil;

    for i, v in u19.Originals do
        if i.Parent then
            local v21 = {};

            for i2 in v do
                v21[i2] = 1;
            end;

            local v22 = TweenService:Create(i, TweenInfo_new_ret, v21);
            table.insert(u19.ActiveTweens, v22);
            v22:Play();
            v20 = v20 or v22;
        end;
    end;

    if v20 then
        v20.Completed:Connect(function(p23) -- Line: 93
            -- upvalues: u2 (ref), u18 (copy), u19 (copy)
            if p23 == Enum.PlaybackState.Completed and (u2[u18] == u19 and #u19.ActiveTweens > 0) then
                u18.Enabled = false;
            end;
        end);

        return;
    end;

    u18.Enabled = false;
end;

return v1;