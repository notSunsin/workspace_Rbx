-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {
    Color = "TextColor3",
    StrokeColor = "TextStrokeColor3",
    ImageColor = "ImageColor3"
};
u1.ColorShortcuts = {};
u1.ColorShortcuts.White = Color3.new(1, 1, 1);
u1.ColorShortcuts.Black = Color3.new(0, 0, 0);
u1.ColorShortcuts.Red = Color3.new(1, 0.4, 0.4);
u1.ColorShortcuts.Green = Color3.new(0.4, 1, 0.4);
u1.ColorShortcuts.Blue = Color3.new(0.4, 0.4, 1);
u1.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1);
u1.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2);
u1.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2);
u1.ImageShortcuts = {};
u1.ImageShortcuts.Eggplant = 639588687;
u1.ImageShortcuts.Thinking = 955646496;
u1.ImageShortcuts.Sad = 947900188;
u1.ImageShortcuts.Happy = 414889555;
u1.ImageShortcuts.Despicable = 711674643;
local u3 = {
    ContainerHorizontalAlignment = "Center",
    ContainerVerticalAlignment = "Center",
    TextYAlignment = "Center",
    TextScaled = true,
    TextScaleRelativeTo = "Frame",
    TextScale = 0.6,
    TextSize = 20,
    Font = "SourceSans",
    TextColor3 = "White",
    TextStrokeColor3 = "Black",
    TextTransparency = 0,
    TextStrokeTransparency = 0,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ImageColor3 = "White",
    ImageTransparency = 0,
    ImageRectOffset = "0,0",
    ImageRectSize = "0,0",
    AnimateStepTime = 0,
    AnimateStepGrouping = "Letter",
    AnimateStepFrequency = 4,
    AnimateYield = 0,
    AnimateStyle = "Appear",
    AnimateStyleTime = 0.5,
    AnimateStyleNumPeriods = 3,
    AnimateStyleAmplitude = 0.5
};
local u27 = {
    Appear = function(p4) -- Line: 226, Name: Appear
        p4.Visible = true;
    end,

    Fade = function(p5, p6, p7) -- Line: 230, Name: Fade
        p5.Visible = true;

        if p5:IsA("TextLabel") then
            p5.TextTransparency = 1 - p6 * (1 - p7.TextTransparency);

            return;
        end;

        if p5:IsA("ImageLabel") then
            p5.ImageTransparency = 1 - p6 * (1 - p7.ImageTransparency);
        end;
    end,

    Wiggle = function(p8, p9, p10) -- Line: 239, Name: Wiggle
        p8.Visible = true;
        local v11 = p10.InitialSize.Y.Offset * (1 - p9) * p10.AnimateStyleAmplitude;
        p8.Position = p10.InitialPosition + UDim2.new(0, 0, 0, math.sin(p9 * 3.141592653589793 * 2 * p10.AnimateStyleNumPeriods) * v11 / 2);
    end,

    FallDown = function(p12, p13, p14) -- Line: 245, Name: FallDown
        p12.Visible = true;
        p12.Position = p14.InitialPosition + UDim2.new(0, 0, 0, p14.InitialSize.Y.Offset * (1 - p13) * p14.AnimateStyleAmplitude * -1);
        p12.TextTransparency = 1 - p13;
    end,

    Swing = function(p15, p16, p17) -- Line: 252, Name: Swing
        p15.Visible = true;
        local v18 = 90 * (1 - p16) * p17.AnimateStyleAmplitude;
        p15.Rotation = math.sin(p16 * 3.141592653589793 * 2 * p17.AnimateStyleNumPeriods) * v18;
    end,

    Spin = function(p19, p20, p21) -- Line: 258, Name: Spin
        p19.Visible = true;
        p19.Position = p21.InitialPosition + UDim2.new(0, p21.InitialSize.X.Offset / 2, 0, p21.InitialSize.Y.Offset / 2);
        p19.AnchorPoint = Vector2.new(0.5, 0.5);
        p19.Rotation = p20 * p21.AnimateStyleNumPeriods * 360;
    end,

    Rainbow = function(p22, p23, p24) -- Line: 265, Name: Rainbow
        p22.Visible = true;
        local Color3_fromHSV_ret = Color3.fromHSV(p23 * p24.AnimateStyleNumPeriods % 1, 1, 1);

        if p22:IsA("TextLabel") then
            local v25 = getColorFromString(p24.TextColor3);
            p22.TextColor3 = Color3.new(Color3_fromHSV_ret.r + p23 * (v25.r - Color3_fromHSV_ret.r), Color3_fromHSV_ret.g + p23 * (v25.g - Color3_fromHSV_ret.g), Color3_fromHSV_ret.b + p23 * (v25.b - Color3_fromHSV_ret.b));

            return;
        end;

        local v26 = getColorFromString(p24.ImageColor3);
        p22.ImageColor3 = Color3.new(Color3_fromHSV_ret.r + p23 * (v26.r - Color3_fromHSV_ret.r), Color3_fromHSV_ret.g + p23 * (v26.g - Color3_fromHSV_ret.g), Color3_fromHSV_ret.b + p23 * (v26.b - Color3_fromHSV_ret.b));
    end
};
local TextService = game:GetService("TextService");
local RunService = game:GetService("RunService");
local u28 = 0;

function getLayerCollector(p29)
    if not p29 then
        return nil;
    end;

    if p29:IsA("LayerCollector") then
        return p29;
    end;

    if p29 and p29.Parent then
        return getLayerCollector(p29.Parent);
    end;

    return nil;
end;

function shallowCopy(p30)
    local v31 = {};

    for i, v in pairs(p30) do
        v31[i] = v;
    end;

    return v31;
end;

function getColorFromString(p32)
    -- upvalues: u1 (copy)
    if u1.ColorShortcuts[p32] then
        return u1.ColorShortcuts[p32];
    end;

    local v33, v34, v35 = p32:match("(%d+),(%d+),(%d+)");

    return Color3.new(v33 / 255, v34 / 255, v35 / 255);
end;

function getVector2FromString(p36)
    local v37, v38 = p36:match("(%d+),(%d+)");

    return Vector2.new(v37, v38);
end;

function setHorizontalAlignment(p39, p40)
    if p40 == "Left" then
        p39.AnchorPoint = Vector2.new(0, 0);
        p39.Position = UDim2.new(0, 0, 0, 0);

        return;
    end;

    if p40 ~= "Center" then
        if p40 == "Right" then
            p39.AnchorPoint = Vector2.new(1, 0);
            p39.Position = UDim2.new(1, 0, 0, 0);
        end;

        return;
    end;

    p39.AnchorPoint = Vector2.new(0.5, 0);
    p39.Position = UDim2.new(0.5, 0, 0, 0);
end;

function u1.New(p41, u42, p43, p44, p45, p46) -- Line: 331
    -- upvalues: u2 (copy), u3 (copy), TextService (copy), u1 (copy), u28 (ref), RunService (copy), u27 (copy)
    for _, child in pairs(u42:GetChildren()) do
        child:Destroy();
    end;

    local u47 = p45 == nil and true or p45;
    local u48 = {};
    local u49 = {};

    if p46 then
        p43 = p46.Text;
        p44 = p46.StartingProperties;
    end;

    local u50 = {};
    local u51 = {};
    local u52 = {};
    local u53 = 0;
    local u54 = false;
    local TextLabel = Instance.new("TextLabel");
    local ImageLabel = Instance.new("ImageLabel");
    local u55 = getLayerCollector(u42);
    TextLabel.AutoLocalize = false;
    local u56 = nil;
    local u57 = nil;

    local function applyMarkup(p58, p59) -- Line: 359
        -- upvalues: u2 (ref), u49 (copy), u48 (ref), u56 (ref), u50 (copy), u3 (ref), u57 (ref)
        local v60 = u2[p58] or p58;

        if p59 == "/" then
            if u49[v60] then
                p59 = u49[v60];
            else
                warn("Attempt to default <" .. v60 .. "> to value with no default");
            end;
        end;

        if tonumber(p59) then
            p59 = tonumber(p59);
        elseif p59 == "false" or p59 == "true" then
            p59 = p59 == "true";
        end;

        u48[v60] = p59;

        if not u56(v60, p59) then
            if v60 == "ContainerHorizontalAlignment" and u50[#u50] then
                setHorizontalAlignment(u50[#u50].Container, p59);
            elseif not u3[v60] then
                if v60 ~= "Img" then
                    return false;
                end;

                u57(p59);
            end;
        end;

        return true;
    end;

    u56 = function(u61, p62, p63) -- Line: 390, Name: applyProperty
        -- upvalues: TextLabel (copy), ImageLabel (copy)
        local u64 = nil;
        local v65 = false;

        for _, v in pairs(p63 and { p63 } or { TextLabel, ImageLabel }) do
            if pcall(function() -- Line: 394
                -- upvalues: u64 (ref), v (copy), u61 (copy)
                u64 = typeof(v[u61]);
            end) then
                if u64 == "Color3" then
                    v[u61] = getColorFromString(p62);
                elseif u64 == "Vector2" then
                    v[u61] = getVector2FromString(p62);
                else
                    v[u61] = p62;
                end;

                v65 = true;
            end;
        end;

        return v65;
    end;

    for i, v in pairs(u3) do
        applyMarkup(i, v);
        u49[u2[i] or i] = u48[u2[i] or i];
    end;

    for i, v in pairs(p44 or {}) do
        applyMarkup(i, v);
        u49[u2[i] or i] = u48[u2[i] or i];
    end;

    if p46 then
        u48 = p46.OverflowPickupProperties;

        for i, v in pairs(u48) do
            applyMarkup(i, v);
        end;
    end;

    local function getTextSize() -- Line: 427
        -- upvalues: u48 (ref), u55 (copy), u42 (copy)
        if u48.TextScaled ~= true then
            return u48.TextSize;
        end;

        local v66 = nil;

        if u48.TextScaleRelativeTo == "Screen" then
            v66 = u55.AbsoluteSize.Y;
        elseif u48.TextScaleRelativeTo == "Frame" then
            v66 = u42.AbsoluteSize.Y;
        end;

        return math.min(u48.TextScale * v66, 100);
    end;

    local u67 = 0;

    local function newLine() -- Line: 443
        -- upvalues: u50 (copy), u67 (ref), u47 (ref), u48 (ref), u55 (copy), u42 (copy), u54 (ref), u51 (copy), u53 (ref)
        local v68 = u50[#u50];

        if v68 then
            u67 = u67 + v68.Size.Y.Offset;

            if not u47 then
                local v69;

                if u48.TextScaled == true then
                    local v70 = nil;

                    if u48.TextScaleRelativeTo == "Screen" then
                        v70 = u55.AbsoluteSize.Y;
                    elseif u48.TextScaleRelativeTo == "Frame" then
                        v70 = u42.AbsoluteSize.Y;
                    end;

                    v69 = math.min(u48.TextScale * v70, 100);
                else
                    v69 = u48.TextSize;
                end;

                if u67 + v69 > u42.AbsoluteSize.Y then
                    u54 = true;

                    return;
                end;
            end;
        end;

        local Frame = Instance.new("Frame");
        Frame.Name = string.format("Line%03d", #u50 + 1);
        Frame.Size = UDim2.new(0, 0, 0, 0);
        Frame.BackgroundTransparency = 1;
        local Frame2 = Instance.new("Frame", Frame);
        Frame2.Name = "Container";
        Frame2.Size = UDim2.new(0, 0, 0, 0);
        Frame2.BackgroundTransparency = 1;
        setHorizontalAlignment(Frame2, u48.ContainerHorizontalAlignment);
        Frame.Parent = u42;
        table.insert(u50, Frame);
        u51[#u50] = {};
        u53 = 0;
    end;

    newLine();

    local function addFrameProperties(p71) -- Line: 469
        -- upvalues: u52 (copy), u48 (ref)
        u52[p71] = shallowCopy(u48);
        u52[p71].InitialSize = p71.Size;
        u52[p71].InitialPosition = p71.Position;
        u52[p71].InitialAnchorPoint = p71.AnchorPoint;
    end;

    local function formatLabel(p72, p73, p74, p75) -- Line: 476
        -- upvalues: u50 (copy), u48 (ref), u53 (ref), u42 (copy), u51 (copy), newLine (copy), u52 (copy)
        local v76 = u50[#u50];
        local v77 = tostring(u48.TextYAlignment);

        if v77 == "Top" then
            p72.Position = UDim2.new(0, u53, 0, 0);
            p72.AnchorPoint = Vector2.new(0, 0);
        elseif v77 == "Center" then
            p72.Position = UDim2.new(0, u53, 0.5, 0);
            p72.AnchorPoint = Vector2.new(0, 0.5);
        elseif v77 == "Bottom" then
            p72.Position = UDim2.new(0, u53, 1, 0);
            p72.AnchorPoint = Vector2.new(0, 1);
        end;

        u53 = u53 + p74;

        if u53 > u42.AbsoluteSize.X and u53 ~= p74 then
            p72:Destroy();
            local v78 = u51[#u50][#u51[#u50]];

            if v78:IsA("TextLabel") and v78.Text == " " then
                v76.Container.Size = UDim2.new(0, u53 - p74 - v78.Size.X.Offset, 1, 0);
                v78:Destroy();
                table.remove(u51[#u50]);
            end;

            newLine();
            p75();

            return;
        end;

        p72.Size = UDim2.new(0, p74, 0, p73);
        v76.Container.Size = UDim2.new(0, u53, 1, 0);
        v76.Size = UDim2.new(1, 0, 0, (math.max(v76.Size.Y.Offset, p73)));
        p72.Name = string.format("Group%03d", #u51[#u50] + 1);
        p72.Parent = v76.Container;
        table.insert(u51[#u50], p72);
        u52[p72] = shallowCopy(u48);
        u52[p72].InitialSize = p72.Size;
        u52[p72].InitialPosition = p72.Position;
        u52[p72].InitialAnchorPoint = p72.AnchorPoint;
        u48.AnimateYield = 0;
    end;

    local function printText(u79) -- Line: 516
        -- upvalues: newLine (copy), u53 (ref), u48 (ref), u55 (copy), u42 (copy), TextService (ref), TextLabel (copy), u52 (copy), formatLabel (ref), u54 (ref), printText (ref)
        if u79 == "\n" then
            newLine();

            return;
        end;

        if u79 == " " and u53 == 0 then
            return;
        end;

        local v80;

        if u48.TextScaled == true then
            local v81 = nil;

            if u48.TextScaleRelativeTo == "Screen" then
                v81 = u55.AbsoluteSize.Y;
            elseif u48.TextScaleRelativeTo == "Frame" then
                v81 = u42.AbsoluteSize.Y;
            end;

            v80 = math.min(u48.TextScale * v81, 100);
        else
            v80 = u48.TextSize;
        end;

        local X = TextService:GetTextSize(u79, v80, TextLabel.Font, Vector2.new(u55.AbsoluteSize.X, v80)).X;
        local v82 = TextLabel:Clone();
        v82.TextScaled = false;
        v82.TextSize = v80;
        v82.Text = u79;
        v82.TextTransparency = 1;
        v82.TextStrokeTransparency = 1;
        v82.TextWrapped = false;
        local v83 = 0;
        local v84 = 1;

        for i, v in utf8.graphemes(u79) do
            local string_sub_ret = string.sub(u79, i, v);
            local X2 = TextService:GetTextSize(string_sub_ret, v80, TextLabel.Font, Vector2.new(u55.AbsoluteSize.X, v80)).X;
            local v85 = TextLabel:Clone();
            v85.Text = string_sub_ret;
            v85.TextScaled = false;
            v85.TextSize = v80;
            v85.Position = UDim2.new(0, v83, 0, 0);
            v85.Size = UDim2.new(0, X2 + 1, 0, v80);
            v85.Name = string.format("Char%03d", v84);
            v85.Parent = v82;
            v85.Visible = false;
            u52[v85] = shallowCopy(u48);
            u52[v85].InitialSize = v85.Size;
            u52[v85].InitialPosition = v85.Position;
            u52[v85].InitialAnchorPoint = v85.AnchorPoint;
            v83 = v83 + X2;
            v84 = v84 + 1;
        end;

        formatLabel(v82, v80, X, function() -- Line: 555
            -- upvalues: u54 (ref), printText (ref), u79 (copy)
            if not u54 then
                printText(u79);
            end;
        end);
    end;

    u57 = function(u86) -- Line: 558, Name: printImage
        -- upvalues: u48 (ref), u55 (copy), u42 (copy), ImageLabel (copy), u1 (ref), formatLabel (ref), u54 (ref), u57 (ref)
        local v87;

        if u48.TextScaled == true then
            local v88 = nil;

            if u48.TextScaleRelativeTo == "Screen" then
                v88 = u55.AbsoluteSize.Y;
            elseif u48.TextScaleRelativeTo == "Frame" then
                v88 = u42.AbsoluteSize.Y;
            end;

            v87 = math.min(u48.TextScale * v88, 100);
        else
            v87 = u48.TextSize;
        end;

        local v89 = ImageLabel:Clone();

        if u1.ImageShortcuts[u86] then
            v89.Image = typeof(u1.ImageShortcuts[u86]) == "number" and "rbxassetid://" .. u1.ImageShortcuts[u86] or u1.ImageShortcuts[u86];
        else
            v89.Image = "rbxassetid://" .. u86;
        end;

        v89.Size = UDim2.new(0, v87, 0, v87);
        v89.Visible = false;
        formatLabel(v89, v87, v87, function() -- Line: 572
            -- upvalues: u54 (ref), u57 (ref), u86 (copy)
            if not u54 then
                u57(u86);
            end;
        end);
    end;

    local function printSeries(p90) -- Line: 575
        -- upvalues: applyMarkup (ref), printText (ref)
        for _, v in pairs(p90) do
            local string_match_ret, v91 = string.match(v, "<(.+)=(.+)>");

            if string_match_ret and v91 then
                if not applyMarkup(string_match_ret, v91) then
                    warn("Could not apply markup: ", v);
                end;
            else
                printText(v);
            end;
        end;
    end;

    local v92 = #p43;
    local v93 = {};
    local v94;

    if p46 then
        v94 = p46.OverflowPickupIndex;
    else
        v94 = 1;
    end;

    local v95;

    while true do
        if not v94 or v94 > v92 then
            v95 = v94;
            break;
        end;

        local v96;
        v95, v96 = string.find(p43, "<.->", v94);
        local string_find_ret, v97 = string.find(p43, "[ \t\n]", v94);
        local v98;

        if v95 and (v96 and (not string_find_ret or v95 < string_find_ret)) then
            v98 = nil;
        else
            v95 = string_find_ret or v92 + 1;
            v96 = v97 or v92 + 1;
            v98 = true;
        end;

        local v99;

        if v94 < v95 then
            v99 = string.sub(p43, v94, v95 - 1) or nil;
        else
            v99 = nil;
        end;

        local v100;

        if v95 <= v92 then
            v100 = string.sub(p43, v95, v96) or nil;
        else
            v100 = nil;
        end;

        table.insert(v93, v99);

        if v98 then
            printSeries(v93);

            if u54 then
                v95 = v94;
                break;
            end;

            printSeries({ v100 });

            if u54 then
                break;
            end;

            v93 = {};
        else
            table.insert(v93, v100);
        end;

        v94 = v96 + 1;
    end;

    if not u54 then
        printSeries(v93);
    end;

    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.HorizontalAlignment = u48.ContainerHorizontalAlignment;
    UIListLayout.VerticalAlignment = u48.ContainerVerticalAlignment;
    UIListLayout.Parent = u42;
    local X = u42.AbsoluteSize.X;
    local v101 = 0;
    local v102 = 0;

    for _, v in pairs(u50) do
        v101 = v101 + v.Size.Y.Offset;
        local Container = v.Container;
        local v103 = nil;
        local v104 = nil;

        if Container.AnchorPoint.X == 0 then
            v103 = Container.Position.X.Offset;
            v104 = Container.Size.X.Offset;
        elseif Container.AnchorPoint.X == 0.5 then
            v103 = v.AbsoluteSize.X / 2 - Container.Size.X.Offset / 2;
            v104 = v.AbsoluteSize.X / 2 + Container.Size.X.Offset / 2;
        elseif Container.AnchorPoint.X == 1 then
            v103 = v.AbsoluteSize.X - Container.Size.X.Offset;
            v104 = v.AbsoluteSize.X;
        end;

        X = math.min(X, v103);
        v102 = math.max(v102, v104);
    end;

    u28 = u28 + 1;
    local u105 = false;
    local u106 = false;
    local u107 = false;
    local u108 = "TextAnimation" .. u28;
    local u109 = {};

    local function updateAnimations() -- Line: 673
        -- upvalues: u106 (ref), u109 (ref), u105 (ref), RunService (ref), u108 (copy), u27 (ref)
        if not (u106 and #u109 == 0 or u105) then
            local v110 = tick();

            for i = #u109, 1, -1 do
                local v111 = u109[i];
                local Settings = v111.Settings;
                local v112 = u27[Settings.AnimateStyle];

                if not v112 then
                    warn("No animation style found for: ", Settings.AnimateStyle, ", defaulting to Appear");
                    v112 = u27.Appear;
                end;

                local math_min_ret = math.min((v110 - v111.Start) / Settings.AnimateStyleTime, 1);
                v112(v111.Char, math_min_ret, Settings);
                local v113;

                if math_min_ret >= 1 then
                    table.remove(u109, i);
                    v113 = i;
                else
                    v113 = i;
                end;
            end;

            return;
        end;

        u105 = true;
        RunService:UnbindFromRenderStep(u108);
        u109 = {};
    end;

    local function setFrameToDefault(p114) -- Line: 698
        -- upvalues: u52 (copy), u56 (ref)
        p114.Position = u52[p114].InitialPosition;
        p114.Size = u52[p114].InitialSize;
        p114.AnchorPoint = u52[p114].InitialAnchorPoint;

        for i, v in pairs(u52[p114]) do
            u56(i, v, p114);
        end;
    end;

    local function setGroupVisible(p115, p116) -- Line: 707
        -- upvalues: setFrameToDefault (copy)
        p115.Visible = p116;

        for _, child in pairs(p115:GetChildren()) do
            child.Visible = p116;

            if p116 then
                setFrameToDefault(child);
            end;
        end;

        if p116 and p115:IsA("ImageLabel") then
            setFrameToDefault(p115);
        end;
    end;

    local function animate(p117) -- Line: 720
        -- upvalues: u105 (ref), RunService (ref), u108 (copy), updateAnimations (copy), u51 (copy), u109 (ref), u107 (ref), u52 (copy), u106 (ref)
        u105 = false;
        RunService:BindToRenderStep(u108, Enum.RenderPriority.Last.Value, updateAnimations);
        local u118 = nil;
        local u119 = nil;
        local u120 = nil;
        local v121 = nil;

        for _, v in pairs(u51) do
            for _, v2 in pairs(v) do
                v2.Visible = false;

                for _, child in pairs(v2:GetChildren()) do
                    child.Visible = false;
                end;
            end;
        end;

        local function animateCharacter(p122, p123) -- Line: 736
            -- upvalues: u109 (ref)
            local v124 = {
                Char = p122,
                Settings = p123,
                Start = tick()
            };
            table.insert(u109, v124);
        end;

        local function yield() -- Line: 740
            -- upvalues: u107 (ref), u118 (ref), u119 (ref), u120 (ref)
            if not (u107 or (u118 % u119 ~= 0 or u120 < 0)) then
                wait(u120 > 0 and u120 or nil);
            end;
        end;

        for _, v in pairs(u51) do
            for _, v2 in pairs(v) do
                local v125 = u52[v2];
                u118 = (v125.AnimateStepGrouping ~= v121 or v125.AnimateStepFrequency ~= u119) and 0 or u118;
                v121 = v125.AnimateStepGrouping;
                u120 = v125.AnimateStepTime;
                u119 = v125.AnimateStepFrequency;

                if v125.AnimateYield > 0 then
                    wait(v125.AnimateYield);
                end;

                if v121 == "Word" or v121 == "All" then
                    if v2:IsA("TextLabel") then
                        v2.Visible = true;

                        for _, child in pairs(v2:GetChildren()) do
                            local v126 = {
                                Char = child,
                                Settings = u52[child],
                                Start = tick()
                            };
                            table.insert(u109, v126);
                        end;
                    else
                        local v127 = {
                            Char = v2,
                            Settings = v125,
                            Start = tick()
                        };
                        table.insert(u109, v127);
                    end;

                    if v121 == "Word" then
                        u118 = u118 + 1;

                        if not (u107 or (u118 % u119 ~= 0 or u120 < 0)) then
                            wait(u120 > 0 and u120 or nil);
                        end;
                    end;
                elseif v121 == "Letter" then
                    if v2:IsA("TextLabel") then
                        v2.Visible = true;
                        local _ = v2.Text;
                        local v128 = v2;
                        local v129 = 1;

                        while true do
                            local v130 = v128:FindFirstChild(string.format("Char%03d", v129));

                            if not v130 then
                                break;
                            end;

                            local v131 = {
                                Char = v130,
                                Settings = u52[v130],
                                Start = tick()
                            };
                            table.insert(u109, v131);
                            u118 = u118 + 1;

                            if not (u107 or (u118 % u119 ~= 0 or u120 < 0)) then
                                local v132;

                                if u120 > 0 then
                                    v132 = u120 or nil;
                                else
                                    v132 = nil;
                                end;

                                wait(v132);
                            end;

                            if u105 then
                                return;
                            end;

                            v129 = v129 + 1;
                        end;
                    else
                        local v133 = {
                            Char = v2,
                            Settings = v125,
                            Start = tick()
                        };
                        table.insert(u109, v133);
                        u118 = u118 + 1;

                        if not (u107 or (u118 % u119 ~= 0 or u120 < 0)) then
                            wait(u120 > 0 and u120 or nil);
                        end;
                    end;
                else
                    warn("Invalid step grouping: ", v121);
                end;

                if u105 then
                    return;
                end;
            end;
        end;

        u106 = true;

        if p117 then
            while #u109 > 0 do
                RunService.RenderStepped:Wait();
            end;
        end;
    end;

    local v134 = {
        Overflown = u54,
        OverflowPickupIndex = v95,
        StartingProperties = p44,
        OverflowPickupProperties = u48,
        Text = p43
    };

    if p46 then
        p46.NextTextObject = v134;
    end;

    v134.ContentSize = Vector2.new(v102 - X, v101);

    function v134.Animate(p135, p136) -- Line: 841
        -- upvalues: animate (copy)
        if p136 then
            animate();
        else
            coroutine.wrap(animate)();
        end;

        if p135.NextTextObject then
            p135.NextTextObject:Animate(p136);
        end;
    end;

    function v134.Show(p137, p138) -- Line: 852
        -- upvalues: u107 (ref), u105 (ref), u51 (copy), setFrameToDefault (copy)
        if p138 then
            u107 = true;
        else
            u105 = true;

            for _, v in pairs(u51) do
                for _, v2 in pairs(v) do
                    v2.Visible = true;
                    local v139 = v2;

                    for _, child in pairs(v2:GetChildren()) do
                        child.Visible = true;
                        setFrameToDefault(child);
                    end;

                    if v139:IsA("ImageLabel") then
                        setFrameToDefault(v139);
                    end;
                end;
            end;
        end;

        if p137.NextTextObject then
            p137.NextTextObject:Show(p138);
        end;
    end;

    function v134.Hide(p140) -- Line: 868
        -- upvalues: u105 (ref), u51 (copy)
        u105 = true;

        for _, v in pairs(u51) do
            for _, v2 in pairs(v) do
                v2.Visible = false;

                for _, child in pairs(v2:GetChildren()) do
                    child.Visible = false;
                end;
            end;
        end;

        if p140.NextTextObject then
            p140.NextTextObject:Hide();
        end;
    end;

    return v134;
end;

function u1.ContinueOverflow(p141, p142, p143) -- Line: 884
    -- upvalues: u1 (copy)
    return u1:New(p142, nil, nil, false, p143);
end;

return u1;