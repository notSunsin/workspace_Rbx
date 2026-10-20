-- Decompiled with Potassium's decompiler.

local v1 = not game:GetService("RunService"):IsClient();
assert(v1);
local HttpService = game:GetService("HttpService");
local AssetService = game:GetService("AssetService");
local EncodingService = game:GetService("EncodingService");
require(script.Types);
local script_Easing = require(script.Easing);
local Rect_new_ret = Rect.new(64, 64, 192, 192);
local UDim2_fromScale_ret = UDim2.fromScale(0, 0);
local UDim2_fromScale_ret2 = UDim2.fromScale(1, 1);
local success, result = pcall(require, script.PNG);

if not success then
    result = nil;
end;

local function HexToColor3(p2: string) -- Line: 90
    local string_sub_ret = string.sub(p2, 2, 3);
    local v3 = tonumber(string_sub_ret, 16) or 0;
    local string_sub_ret2 = string.sub(p2, 4, 5);
    local v4 = tonumber(string_sub_ret2, 16) or 0;
    local string_sub_ret3 = string.sub(p2, 6, 7);
    local v5 = tonumber(string_sub_ret3, 16) or 0;

    return Color3.fromRGB(v3, v4, v5);
end;

local function IsPropertyAnimated(p6) -- Line: 97
    if p6 == nil then
        return false;
    end;

    return p6.a == 1;
end;

local function HasAnimatedOpacity(p7) -- Line: 104
    if p7 == nil then
        return false;
    end;

    local o = p7.o;

    if o == nil then
        return false;
    end;

    return o.a == 1;
end;

local function SubdivideCubicBezier(p8: number, p9: number, p10: number, p11: number, p12: number, p13: number, p14: number, p15: number, p16: number, p17: table) -- Line: 113
    for i = 1, p16 do
        local v18 = i / p16;
        local v19 = 1 - v18;
        local v20 = v19 * v19;
        local v21 = v20 * v19;
        local v22 = v18 * v18;
        local v23 = v22 * v18;
        table.insert(p17, { v21 * p8 + v20 * 3 * v18 * p10 + v19 * 3 * v22 * p12 + v23 * p14, v21 * p9 + v20 * 3 * v18 * p11 + v19 * 3 * v22 * p13 + v23 * p15 });
        local _ = i;
    end;
end;

local function BezierShapeToPolyline(p24) -- Line: 139
    -- upvalues: SubdivideCubicBezier (copy)
    local v = p24.v;
    local i = p24.i;
    local o = p24.o;
    local v25 = #v;

    if v25 == 0 then
        return {};
    end;

    local v26 = {
        { v[1][1], v[1][2] }
    };
    local v27;

    if p24.c then
        v27 = v25;
    else
        v27 = v25 - 1;
    end;

    for i2 = 1, v27 do
        local v28 = i2 >= v25 and 1 or i2 + 1;
        local v29 = v[i2];
        local v30 = v[v28];
        local v31 = o[i2];
        local v32 = i[v28];
        local v33 = v29[1];
        local v34 = v29[2];
        local v35 = v33 + v31[1];
        local v36 = v34 + v31[2];
        local v37 = v30[1] + v32[1];
        local v38 = v30[2] + v32[2];
        local v39 = v30[1];
        local v40 = v30[2];
        local v41;

        if math.abs(v31[1]) < 0.01 and (math.abs(v31[2]) < 0.01 and math.abs(v32[1]) < 0.01) then
            v41 = math.abs(v32[2]) < 0.01;
        else
            v41 = false;
        end;

        local v42;

        if v41 then
            table.insert(v26, { v39, v40 });
            v42 = i2;
        else
            SubdivideCubicBezier(v33, v34, v35, v36, v37, v38, v39, v40, 12, v26);
            v42 = i2;
        end;
    end;

    return v26;
end;

local function Cross2D(p43: number, p44: number, p45: number, p46: number, p47: number, p48: number) -- Line: 180
    return (p45 - p43) * (p48 - p44) - (p46 - p44) * (p47 - p43);
end;

local function PointInTriangle(p49: number, p50: number, p51: number, p52: number, p53: number, p54: number, p55: number, p56: number) -- Line: 184
    local v57 = (p51 - p49) * (p54 - p50) - (p52 - p50) * (p53 - p49);
    local v58 = (p53 - p49) * (p56 - p50) - (p54 - p50) * (p55 - p49);
    local v59 = (p55 - p49) * (p52 - p50) - (p56 - p50) * (p51 - p49);

    return not (((v57 < 0 or v58 < 0) and true or v59 < 0) and ((v57 > 0 or v58 > 0) and true or v59 > 0));
end;

local function IsConvexPolygon(p60: table) -- Line: 202
    local v61 = #p60;

    if v61 < 3 then
        return false;
    end;

    local v62 = 0;

    for i = 1, v61 do
        local v63 = i >= v61 and 1 or i + 1;
        local v64 = v63 >= v61 and 1 or v63 + 1;
        local v65 = p60[i][1];
        local v66 = p60[i][2];
        local v67 = (p60[v63][1] - v65) * (p60[v64][2] - v66) - (p60[v63][2] - v66) * (p60[v64][1] - v65);
        local v68;

        if v67 == 0 then
            v68 = i;
        elseif v62 == 0 then
            if v67 > 0 then
                v68 = i;
                v62 = 1;
            else
                v68 = i;
                v62 = -1;
            end;
        else
            if v67 > 0 and v62 < 0 or v67 < 0 and v62 > 0 then
                return false;
            end;

            v68 = i;
        end;
    end;

    return true;
end;

local function TriangulateFan(p69: table) -- Line: 223
    local v70 = {};

    for i = 2, #p69 - 1 do
        table.insert(v70, { p69[1], p69[i], p69[i + 1] });
        local _ = i;
    end;

    return v70;
end;

local function TriangulateEarClip(p71: table) -- Line: 231
    -- upvalues: IsConvexPolygon (copy), TriangulateFan (copy), PointInTriangle (copy)
    local v72 = #p71;

    if v72 < 3 then
        return {};
    end;

    if v72 == 3 then
        return {
            { p71[1], p71[2], p71[3] }
        };
    end;

    if IsConvexPolygon(p71) then
        return TriangulateFan(p71);
    end;

    local table_create_ret = table.create(v72);
    local v73 = 0;

    for i = 1, v72 do
        table_create_ret[i] = i;
        local v74 = i >= v72 and 1 or i + 1;
        v73 = v73 + (p71[v74][1] - p71[i][1]) * (p71[v74][2] + p71[i][2]);
        local _ = i;
    end;

    local v75;

    if v73 > 0 then
        v75 = table.create(v72);

        for i = 1, v72 do
            v75[i] = table_create_ret[v72 - i + 1];
            local _ = i;
        end;
    else
        v75 = table_create_ret;
    end;

    local v76 = #v75;
    local v77 = v76 * v76;
    local v78 = 0;
    local v79 = 1;
    local v80 = {};

    while true do
        while true do
            if v76 <= 2 or v78 >= v77 then
                return v80;
            end;

            v78 = v78 + 1;
            v79 = v76 < v79 and 1 or v79;
            local v81;

            if v79 > 1 then
                v81 = v79 - 1;
            else
                v81 = v76;
            end;

            local v82 = v79 >= v76 and 1 or v79 + 1;
            local v83 = p71[v75[v81]];
            local v84 = p71[v75[v79]];
            local v85 = p71[v75[v82]];
            local v86 = v83[1];
            local v87 = v83[2];

            if (v84[1] - v86) * (v85[2] - v87) - (v84[2] - v87) * (v85[1] - v86) <= 0 then
                break;
            end;

            local v88 = true;

            for i = 1, v76 do
                if i ~= v81 and (i ~= v79 and (i ~= v82 and PointInTriangle(p71[v75[i]][1], p71[v75[i]][2], v83[1], v83[2], v84[1], v84[2], v85[1], v85[2]))) then
                    v88 = false;
                    break;
                end;

                local _ = i;
            end;

            if v88 then
                table.insert(v80, { v83, v84, v85 });
                table.remove(v75, v79);
                v76 = v76 - 1;

                if v76 < v79 then
                    v79 = 1;
                end;
            else
                v79 = v79 + 1;
            end;
        end;

        v79 = v79 + 1;
    end;
end;

local function CreateWedge(p89: userdata) -- Line: 317
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = "rbxassetid://83051256678409";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.BorderSizePixel = 0;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Parent = p89;

    return ImageLabel;
end;

local function UpdateTriangle(p90: any, p91: number, p92: number, p93: number, p94: number, p95: number, p96: number, p97, p98: number) -- Line: 327
    local v99 = p93 - p91;
    local v100 = p94 - p92;
    local v101 = p95 - p91;
    local v102 = p96 - p92;

    if v99 * v102 - v100 * v101 < 0 then
        v99 = p95 - p91;
        v100 = p96 - p92;
        v101 = p93 - p91;
        v102 = p94 - p92;
    end;

    local math_sqrt_ret = math.sqrt(v99 * v99 + v100 * v100);
    local math_sqrt_ret2 = math.sqrt(v101 * v101 + v102 * v102);

    if math_sqrt_ret < 1e-6 or math_sqrt_ret2 < 1e-6 then
        p90.A.Visible = false;
        p90.B.Visible = false;

        return;
    end;

    local v103 = v99 / math_sqrt_ret;
    local v104 = v100 / math_sqrt_ret;
    local v105 = v101 * v103 + v102 * v104;
    local v106 = v101 - v103 * v105;
    local v107 = v102 - v104 * v105;
    local math_sqrt_ret3 = math.sqrt(v106 * v106 + v107 * v107);

    if math_sqrt_ret3 < 1e-6 then
        p90.A.Visible = false;
        p90.B.Visible = false;

        return;
    end;

    local v108 = math.atan2(v104, v103) * 57.29577951308232;
    local A = p90.A;
    A.Visible = true;
    A.Position = UDim2.fromScale(p91, p92);
    A.Size = UDim2.fromScale(math.max(v105, 0.0001), math_sqrt_ret3);
    A.Rotation = v108;
    A.AnchorPoint = Vector2.zero;
    A.ImageColor3 = p97;
    A.ImageTransparency = p98;
    local B = p90.B;
    local v109 = math_sqrt_ret - v105;
    B.Visible = v109 > 1e-6;

    if B.Visible then
        B.Position = UDim2.fromScale(p91 + v103 * math_sqrt_ret, p92 + v104 * math_sqrt_ret);
        B.Size = UDim2.fromScale(math.max(v109, 0.0001), math_sqrt_ret3);
        B.Rotation = v108 + 180;
        B.AnchorPoint = Vector2.zero;
        B.ImageColor3 = p97;
        B.ImageTransparency = p98;
    end;
end;

local function CreateTrianglePair(p110: userdata) -- Line: 395
    local v111 = {};
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = "rbxassetid://83051256678409";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.BorderSizePixel = 0;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Parent = p110;
    v111.A = ImageLabel;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Image = "rbxassetid://83051256678409";
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.BorderSizePixel = 0;
    ImageLabel2.Size = UDim2.fromScale(1, 1);
    ImageLabel2.Parent = p110;
    v111.B = ImageLabel2;

    return v111;
end;

local function BuildFilledPath(p112: any, p113: any, p114: userdata, p115: number, p116: number, p117, p118: number) -- Line: 404
    -- upvalues: BezierShapeToPolyline (copy), TriangulateEarClip (copy), UpdateTriangle (copy)
    local v119 = BezierShapeToPolyline(p113);

    if #v119 < 3 then
        return;
    end;

    local table_create_ret = table.create(#v119);

    for i, v in v119 do
        table_create_ret[i] = { v[1] / p115, v[2] / p116 };
    end;

    local v120 = TriangulateEarClip(table_create_ret);
    local v121 = p112.Triangles or {};

    for i, v in v120 do
        local v122;

        if i <= #v121 then
            v122 = v121[i];
        else
            v122 = {};
            local ImageLabel = Instance.new("ImageLabel");
            ImageLabel.Image = "rbxassetid://83051256678409";
            ImageLabel.BackgroundTransparency = 1;
            ImageLabel.BorderSizePixel = 0;
            ImageLabel.Size = UDim2.fromScale(1, 1);
            ImageLabel.Parent = p114;
            v122.A = ImageLabel;
            local ImageLabel2 = Instance.new("ImageLabel");
            ImageLabel2.Image = "rbxassetid://83051256678409";
            ImageLabel2.BackgroundTransparency = 1;
            ImageLabel2.BorderSizePixel = 0;
            ImageLabel2.Size = UDim2.fromScale(1, 1);
            ImageLabel2.Parent = p114;
            v122.B = ImageLabel2;
            table.insert(v121, v122);
        end;

        UpdateTriangle(v122, v[1][1], v[1][2], v[2][1], v[2][2], v[3][1], v[3][2], p117, p118);
    end;

    for i = #v120 + 1, #v121 do
        v121[i].A.Visible = false;
        v121[i].B.Visible = false;
        local _ = i;
    end;

    p112.Triangles = v121;
end;

local function BuildStrokedPath(p123: any, p124: any, p125: userdata, p126: number, p127: number, p128, p129: number, p130: number, p131: table?, p132: number?, p133: number?, p134: number?) -- Line: 455
    -- upvalues: BezierShapeToPolyline (copy), script_Easing (copy)
    local v135 = BezierShapeToPolyline(p124);

    if #v135 < 2 then
        return;
    end;

    local v136 = p123.Segments or {};
    local v137 = 0;
    local v138 = { 0 };
    local v139 = p133 or 100;
    local v140 = p134 or 0;
    local v141 = p132 or 0;

    for i = 2, #v135 do
        local v142 = v135[i][1] - v135[i - 1][1];
        local v143 = v135[i][2] - v135[i - 1][2];
        v137 = v137 + math.sqrt(v142 * v142 + v143 * v143);
        v138[i] = v137;
        local _ = i;
    end;

    local v144 = nil;
    local v145;

    if p131 then
        v145 = {};

        for _, v in p131 do
            if v.v then
                table.insert(v145, script_Easing.EvaluateScalar(v.v, 0));
            end;
        end;

        if #v145 <= 0 then
            v145 = v144;
        end;
    else
        v145 = v144;
    end;

    local v146 = p130 / math.min(p126, p127);
    local v147 = 0;

    for i = 2, #v135 do
        local v148 = v135[i - 1];
        local v149 = v135[i];
        local v150 = v149[1] - v148[1];
        local v151 = v149[2] - v148[2];
        local math_sqrt_ret = math.sqrt(v150 * v150 + v151 * v151);
        local v152;

        if math_sqrt_ret < 0.01 then
            v152 = i;
        else
            local v153 = ((v138[i - 1] + v138[i]) * 0.5 / math.max(v137, 1e-6) * 100 + v140) % 100;

            if v153 < v141 or v139 < v153 then
                v152 = i;
            else
                local v154 = true;

                if v145 then
                    local v155 = v138[i - 1];
                    v152 = i;
                    local v156 = 0;

                    for _, v in v145 do
                        v156 = v156 + v;
                    end;

                    if v156 > 0 then
                        local v157 = v155 % v156;
                        local v158 = 0;

                        for i2, v in v145 do
                            v158 = v158 + v;

                            if v157 < v158 then
                                v154 = i2 % 2 == 1;
                                break;
                            end;
                        end;
                    end;
                else
                    v152 = i;
                end;

                v147 = v147 + 1;
                local v159;

                if v147 <= #v136 then
                    v159 = v136[v147];
                else
                    v159 = Instance.new("Frame");
                    v159.BorderSizePixel = 0;
                    v159.AnchorPoint = Vector2.new(0, 0.5);
                    v159.Parent = p125;
                    table.insert(v136, v159);
                end;

                v159.Visible = v154;

                if v154 then
                    local v160 = math.atan2(v151, v150) * 57.29577951308232;
                    v159.Position = UDim2.fromScale(v148[1] / p126, v148[2] / p127);
                    v159.Size = UDim2.fromScale(math_sqrt_ret / p126, v146);
                    v159.Rotation = v160;
                    v159.BackgroundColor3 = p128;
                    v159.BackgroundTransparency = p129;
                end;
            end;
        end;
    end;

    for i = v147 + 1, #v136 do
        v136[i].Visible = false;
        local _ = i;
    end;

    p123.Segments = v136;
end;

local function BuildLinearGradient(p161: userdata, p162: any, p163: any, p164: any, p165: number) -- Line: 572
    -- upvalues: script_Easing (copy)
    local UIGradient = Instance.new("UIGradient");
    local p = p162.p;
    local v166 = script_Easing.EvaluateVector(p162.k, p165, {});
    local v167 = {};

    for i = 0, p - 1 do
        local v168 = i * 4;
        local v169 = v166[v168 + 1] or i / math.max(p - 1, 1);
        local v170 = v166[v168 + 2] or 1;
        local v171 = v166[v168 + 3] or 1;
        local v172 = v166[v168 + 4] or 1;
        local ColorSequenceKeypoint_new = ColorSequenceKeypoint.new;
        local math_clamp_ret = math.clamp(v169, 0, 1);
        table.insert(v167, ColorSequenceKeypoint_new(math_clamp_ret, Color3.new(v170, v171, v172)));
        local _ = i;
    end;

    local v173 = #v167 < 2 and { ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) } or v167;
    UIGradient.Color = ColorSequence.new(v173);
    local v174 = script_Easing.EvaluateVector(p163, p165, { 0, 0 });
    local v175 = script_Easing.EvaluateVector(p164, p165, { 1, 0 });
    UIGradient.Rotation = math.atan2(v175[2] - v174[2], v175[1] - v174[1]) * 57.29577951308232;
    UIGradient.Parent = p161;

    return UIGradient;
end;

local function BuildRadialGradientApprox(p176: userdata, p177: any, p178: any, p179: any, p180: number, p181: number, p182: number) -- Line: 612
    -- upvalues: script_Easing (copy)
    local p = p177.p;
    local v183 = script_Easing.EvaluateVector(p177.k, p180, {});
    local v184 = script_Easing.EvaluateVector(p178, p180, { p181 / 2, p182 / 2 });
    local v185 = script_Easing.EvaluateVector(p179, p180, { p181, p182 / 2 });
    local v186 = v184[1];
    local v187 = v184[2];
    local v188 = v185[1] - v186;
    local v189 = v185[2] - v187;
    local math_sqrt_ret = math.sqrt(v188 * v188 + v189 * v189);
    local math_min_ret = math.min(p, 6);
    local v190 = {};

    for i = math_min_ret, 1, -1 do
        local v191 = i / math_min_ret;
        local math_floor_ret = math.floor(v191 * (p - 1));
        local v192 = math.min(math_floor_ret, p - 1) * 4;
        local v193 = v183[v192 + 2] or 1;
        local v194 = v183[v192 + 3] or 1;
        local v195 = v183[v192 + 4] or 1;
        local v196 = math_sqrt_ret * 2 * v191;
        local Frame = Instance.new("Frame");
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Position = UDim2.fromScale(v186 / p181, v187 / p182);
        Frame.Size = UDim2.fromScale(v196 / p181, v196 / p182);
        Frame.BackgroundColor3 = Color3.new(v193, v194, v195);
        Frame.BackgroundTransparency = 0;
        Frame.BorderSizePixel = 0;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0.5, 0);
        UICorner.Parent = Frame;
        Frame.Parent = p176;
        table.insert(v190, Frame);
        local _ = i;
    end;

    return v190;
end;

local function ApplyTransform(p197: userdata, p198: any, p199: number, p200: number, p201: number, p202: boolean, p203: number, p204: number) -- Line: 662
    -- upvalues: script_Easing (copy)
    if p198 == nil then
        return;
    end;

    local p = p198.p;
    local v205;

    if p == nil or type(p) ~= "table" then
        v205 = { 0, 0 };
    elseif p.s == true then
        v205 = { script_Easing.EvaluateScalarAtFrame(p.x, p199, 0), (script_Easing.EvaluateScalarAtFrame(p.y, p199, 0)) };
    else
        v205 = script_Easing.EvaluateVector(p, p199, { 0, 0 });
    end;

    local v206 = script_Easing.EvaluateVector(p198.s, p199, { 100, 100 });
    local v207 = script_Easing.EvaluateScalarAtFrame(p198.r, p199, 0);
    local v208 = script_Easing.EvaluateScalarAtFrame(p198.o, p199, 100);
    local v209 = script_Easing.EvaluateVector(p198.a, p199, { 0, 0 });
    local v210 = v206[1] / 100;
    local v211 = v206[2] / 100;
    p197.Position = UDim2.fromScale(v205[1] / p200, v205[2] / p201);
    p197.Rotation = v207;
    p197.Size = UDim2.fromScale(p203 * v210, p204 * v211);

    if p202 then
        p197.GroupTransparency = 1 - v208 / 100;
    end;

    local v212 = p203 * v210 * p200;
    local v213 = p204 * v211 * p201;

    if (v209[1] ~= 0 or v209[2] ~= 0) and (v212 > 0 and v213 > 0) then
        p197.AnchorPoint = Vector2.new(math.clamp(v209[1] / v212, 0, 1), (math.clamp(v209[2] / v213, 0, 1)));
    end;
end;

local function CollectShapeInfo(p214: table) -- Line: 716
    local v215 = nil;
    local v216 = nil;
    local v217 = nil;
    local v218 = nil;
    local v219 = nil;
    local v220 = nil;
    local v221 = nil;
    local v222 = nil;
    local v223 = nil;
    local v224 = nil;
    local v225 = nil;
    local v226 = nil;
    local v227 = nil;

    for _, v in p214 do
        if not v.hd then
            local ty = v.ty;

            if ty == "fl" then
                v220 = v.c;
                v221 = v.o;
            elseif ty == "st" then
                v222 = v.c;
                v223 = v.o;
                v224 = v.w;
                v226 = v.da;
            elseif ty == "sh" then
                v225 = v.ks;
            elseif ty == "tr" then
                v218 = v;
            elseif ty == "tm" then
                v227 = v.s;
                v215 = v.e;
                v216 = v.o;
                v217 = v.m;
            elseif ty == "mm" then
                v219 = v.mm;
            end;
        end;
    end;

    return v220, v221, v222, v223, v224, v225, v226, v227, v215, v216, v217, v218, v219;
end;

local function BuildShapeGroup(p228: any, p229: userdata, p230: number, p231: number, p232: number) -- Line: 782
    -- upvalues: CollectShapeInfo (copy), UDim2_fromScale_ret2 (copy), UDim2_fromScale_ret (copy), ApplyTransform (copy), script_Easing (copy), BuildFilledPath (copy), BuildStrokedPath (copy), BuildLinearGradient (copy), BuildRadialGradientApprox (copy), BuildShapeGroup (copy)
    local v233 = p228.it or {};
    local v234, v235, v236, v237, v238, v239, v240, v241, v242, v243, _, v244, _ = CollectShapeInfo(v233);
    local v245 = false;

    for _, v in v233 do
        if v.ty == "tr" then
            local o = v.o;
            local v246;

            if o == nil then
                v246 = false;
            else
                v246 = o.a == 1;
            end;

            if v246 then
                v245 = true;
                break;
            end;
        end;
    end;

    local v247;

    if v245 then
        v247 = Instance.new("CanvasGroup");
    else
        v247 = Instance.new("Frame");
    end;

    v247.BackgroundTransparency = 1;
    v247.BorderSizePixel = 0;
    v247.Size = UDim2_fromScale_ret2;
    v247.Position = UDim2_fromScale_ret;
    v247.Parent = p229;

    if v244 then
        ApplyTransform(v247, {
            a = v244.a,
            p = v244.p,
            s = v244.s,
            r = v244.r,
            o = v244.o
        }, p232, p230, p231, v245, 1, 1);
    end;

    local v248 = {
        Shape = p228,
        Frame = v247,
        Children = {},
        FillColor = v234,
        FillOpacity = v235,
        StrokeColor = v236,
        StrokeOpacity = v237,
        StrokeWidth = v238,
        PathData = v239
    };
    local v249;

    if v239 == nil then
        v249 = false;
    else
        v249 = v239.a == 1;
    end;

    v248.IsAnimatedPath = v249;
    local v250 = script_Easing.EvaluateColor(v234, p232);
    local v251 = 1 - script_Easing.EvaluateScalarAtFrame(v235, p232, 100) / 100;
    local v252 = script_Easing.EvaluateColor(v236, p232);
    local v253 = 1 - script_Easing.EvaluateScalarAtFrame(v237, p232, 100) / 100;
    local v254 = script_Easing.EvaluateScalarAtFrame(v238, p232, 0);
    local v255 = script_Easing.EvaluateScalarAtFrame(v241, p232, 0);
    local v256 = script_Easing.EvaluateScalarAtFrame(v242, p232, 100);
    local v257 = script_Easing.EvaluateScalarAtFrame(v243, p232, 0);
    local v258 = 0;

    for _, v in v233 do
        if v.ty == "op" and v.a then
            v258 = script_Easing.EvaluateScalarAtFrame(v.a, p232, 0);
        end;
    end;

    for _, v in v233 do
        if not v.hd then
            local ty = v.ty;

            if ty == "sh" then
                local v259 = script_Easing.EvaluateBezierShape(v.ks, p232);

                if v259 and v258 ~= 0 then
                    local v260 = 0;
                    local v261 = 0;

                    for _, v2 in v259.v do
                        v260 = v260 + v2[1];
                        v261 = v261 + v2[2];
                    end;

                    local v262 = v260 / #v259.v;
                    local v263 = v261 / #v259.v;
                    local math_sqrt_ret = math.sqrt((v259.v[1][1] - v262) ^ 2 + (v259.v[1][2] - v263) ^ 2);
                    local v264 = v258 / math.max(math_sqrt_ret, 1) + 1;
                    local table_create_ret = table.create(#v259.v);

                    for i, v2 in v259.v do
                        table_create_ret[i] = { v262 + (v2[1] - v262) * v264, v263 + (v2[2] - v263) * v264 };
                    end;

                    v259 = {
                        v = table_create_ret,
                        i = v259.i,
                        o = v259.o,
                        c = v259.c
                    };
                end;

                if v259 then
                    if v234 then
                        BuildFilledPath(v248, v259, v247, p230, p231, v250, v251);
                    end;

                    if v236 and v254 > 0 then
                        BuildStrokedPath(v248, v259, v247, p230, p231, v252, v253, v254, v240, v255, v256, v257);
                    end;
                end;
            elseif ty == "rc" then
                local Frame = Instance.new("Frame");
                Frame.BorderSizePixel = 0;
                local v265 = script_Easing.EvaluateVector(v.s, p232, { 100, 100 });
                local v266 = script_Easing.EvaluateVector(v.p, p232, { 0, 0 });
                local v267 = script_Easing.EvaluateScalarAtFrame(v.r, p232, 0);
                Frame.Size = UDim2.fromScale(v265[1] / p230, v265[2] / p231);
                Frame.Position = UDim2.fromScale(v266[1] / p230, v266[2] / p231);
                Frame.AnchorPoint = Vector2.new(0.5, 0.5);

                if v234 then
                    Frame.BackgroundColor3 = v250;
                    Frame.BackgroundTransparency = v251;
                else
                    Frame.BackgroundTransparency = 1;
                end;

                if v267 > 0 then
                    local UICorner = Instance.new("UICorner");
                    UICorner.CornerRadius = UDim.new(0, v267);
                    UICorner.Parent = Frame;
                    v248.UICorner = UICorner;
                end;

                if v236 and v254 > 0 then
                    local UIStroke = Instance.new("UIStroke");
                    UIStroke.Color = v252;
                    UIStroke.Transparency = v253;
                    UIStroke.Thickness = v254 / math.min(p230, p231);
                    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;

                    if not pcall(function() -- Line: 928
                        -- upvalues: UIStroke (copy)
                        UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
                    end) then
                        UIStroke.Thickness = v254;
                    end;

                    UIStroke.Parent = Frame;
                    v248.UIStroke = UIStroke;
                end;

                Frame.Parent = v247;
                v248.Frame = Frame;
            elseif ty == "el" then
                local Frame = Instance.new("Frame");
                Frame.BorderSizePixel = 0;
                local v268 = script_Easing.EvaluateVector(v.s, p232, { 100, 100 });
                local v269 = script_Easing.EvaluateVector(v.p, p232, { 0, 0 });
                Frame.Size = UDim2.fromScale(v268[1] / p230, v268[2] / p231);
                Frame.Position = UDim2.fromScale(v269[1] / p230, v269[2] / p231);
                Frame.AnchorPoint = Vector2.new(0.5, 0.5);

                if v234 then
                    Frame.BackgroundColor3 = v250;
                    Frame.BackgroundTransparency = v251;
                else
                    Frame.BackgroundTransparency = 1;
                end;

                local UICorner = Instance.new("UICorner");
                UICorner.CornerRadius = UDim.new(0.5, 0);
                UICorner.Parent = Frame;
                v248.UICorner = UICorner;

                if v236 and v254 > 0 then
                    local UIStroke = Instance.new("UIStroke");
                    UIStroke.Color = v252;
                    UIStroke.Transparency = v253;
                    UIStroke.Thickness = v254 / math.min(p230, p231);
                    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    pcall(function() -- Line: 968
                        -- upvalues: UIStroke (copy)
                        UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize;
                    end);
                    UIStroke.Parent = Frame;
                    v248.UIStroke = UIStroke;
                end;

                Frame.Parent = v247;
                v248.Frame = Frame;
            elseif ty == "gf" or ty == "gs" then
                local v270 = v.t or 1;

                if v.g then
                    if v270 == 1 then
                        v248.UIGradient = BuildLinearGradient(v247, v.g, v.s, v.e, p232);
                    elseif v270 == 2 then
                        BuildRadialGradientApprox(v247, v.g, v.s, v.e, p232, p230, p231);
                    end;
                end;
            elseif ty == "gr" then
                local v271 = BuildShapeGroup(v, v247, p230, p231, p232);

                if v248.Children then
                    table.insert(v248.Children, v271);
                end;
            elseif ty == "rp" then
                local v272 = script_Easing.EvaluateScalarAtFrame(v.c, p232, 1);
                local tr = v.tr;

                if tr and v272 > 1 then
                    local v273 = script_Easing.EvaluateScalarAtFrame(tr.so, p232, 100);
                    local v274 = script_Easing.EvaluateScalarAtFrame(tr.eo, p232, 100);

                    for i = 0, math.floor(v272) - 1 do
                        local Frame = Instance.new("Frame");
                        Frame.BackgroundTransparency = 1;
                        Frame.BorderSizePixel = 0;
                        Frame.Size = UDim2_fromScale_ret2;
                        local v275 = i / math.max(v272 - 1, 1);
                        Frame.BackgroundTransparency = 1 - math.lerp(v273, v274, v275) / 100;
                        local _ = {
                            p = tr.p,
                            s = tr.s,
                            r = tr.r,
                            a = tr.a,
                            o = tr.o
                        };
                        local v276 = script_Easing.EvaluateVector(tr.p, p232, { 0, 0 });
                        script_Easing.EvaluateVector(tr.s, p232, { 100, 100 });
                        local v277 = script_Easing.EvaluateScalarAtFrame(tr.r, p232, 0);
                        Frame.Position = UDim2.fromScale(v276[1] * i / p230, v276[2] * i / p231);
                        Frame.Rotation = v277 * i;
                        Frame.Parent = v247;
                        local _ = i;

                        for _, v2 in v233 do
                            if v2.ty == "gr" and v2 ~= p228 then
                                BuildShapeGroup(v2, Frame, p230, p231, p232);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v248;
end;

local function BuildShapeLayer(p278: any, p279: userdata, p280: number, p281: number, p282: number) -- Line: 1038
    -- upvalues: BuildShapeGroup (copy)
    local shapes = p278.shapes;

    if shapes == nil then
        return {};
    end;

    local v283 = {};

    for i = #shapes, 1, -1 do
        local v284 = shapes[i];
        local v285;

        if v284.hd or v284.ty ~= "gr" then
            v285 = i;
        else
            local v286 = BuildShapeGroup(v284, p279, p280, p281, p282);
            table.insert(v283, v286);
            v285 = i;
        end;
    end;

    return v283;
end;

local function BuildTextLayer(p287: any, p288: userdata, p289: number, p290: number, p291: number) -- Line: 1059
    -- upvalues: UDim2_fromScale_ret2 (copy)
    local t = p287.t;

    if t == nil then
        return nil;
    end;

    local d = t.d;

    if d == nil then
        return nil;
    end;

    local k = d.k;

    if k == nil or #k == 0 then
        return nil;
    end;

    local u292 = nil;

    for _, v in k do
        if v.t == nil or v.t <= p291 then
            u292 = v.s;
        end;
    end;

    if u292 == nil then
        u292 = k[1].s;
    end;

    if u292 == nil then
        return nil;
    end;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.BackgroundTransparency = 1;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Size = UDim2_fromScale_ret2;
    TextLabel.Text = u292.t or "";
    TextLabel.TextScaled = false;
    TextLabel.RichText = false;
    TextLabel.TextSize = (u292.s or 24) / p290 * 100;

    if u292.fc then
        local fc = u292.fc;
        TextLabel.TextColor3 = Color3.new(fc[1] or 1, fc[2] or 1, fc[3] or 1);
    end;

    local v293 = u292.j or 0;

    if v293 == 0 then
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    elseif v293 == 1 then
        TextLabel.TextXAlignment = Enum.TextXAlignment.Right;
    else
        TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    end;

    TextLabel.TextYAlignment = Enum.TextYAlignment.Top;

    if u292.f then
        local success2, result2 = pcall(function() -- Line: 1115
            -- upvalues: u292 (ref)
            return Enum.Font[u292.f];
        end);

        if success2 and result2 then
            TextLabel.Font = result2;
        else
            TextLabel.Font = Enum.Font.GothamMedium;
        end;
    end;

    TextLabel.Parent = p288;

    return TextLabel;
end;

local function BuildImageLayer(p294: any, p295: userdata, p296: table, p297: number, p298: number) -- Line: 1129
    -- upvalues: UDim2_fromScale_ret2 (copy), result (ref), EncodingService (copy), AssetService (copy)
    local refId = p294.refId;

    if refId == nil then
        return nil;
    end;

    local v299 = p296[refId];

    if v299 == nil then
        return nil;
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.BorderSizePixel = 0;
    ImageLabel.Size = UDim2_fromScale_ret2;
    ImageLabel.ScaleType = Enum.ScaleType.Stretch;

    if v299.e == 1 and v299.p then
        local p = v299.p;

        if string.sub(p, 1, 22) == "data:image/png;base64," then
            local string_sub_ret = string.sub(p, 23);

            if result then
                local success2, result2 = pcall(function() -- Line: 1160
                    -- upvalues: EncodingService (ref), string_sub_ret (copy), result (ref)
                    local v300 = EncodingService:Base64Decode(buffer.fromstring(string_sub_ret));

                    return result.decode(v300);
                end);

                if success2 and result2 then
                    local success3, result3 = pcall(function() -- Line: 1167
                        -- upvalues: AssetService (ref), result2 (copy)
                        return AssetService:CreateEditableImage({
                            Size = Vector2.new(result2.width, result2.height)
                        });
                    end);

                    if success3 and (result3 and pcall(function() -- Line: 1171
                        -- upvalues: result3 (copy), result2 (copy)
                        result3:WritePixelsBuffer(Vector2.zero, Vector2.new(result2.width, result2.height), result2.pixels);
                    end)) then
                        ImageLabel.ImageContent = Content.fromObject(result3);
                    end;
                end;
            end;
        elseif string.sub(p, 1, 23) == "data:image/jpeg;base64," then
            warn("[Lottie] Embedded JPEG not supported, skipping image layer:", p294.nm or "");
        end;
    elseif v299.p and not v299.e then
        ImageLabel.Image = v299.p;
    end;

    ImageLabel.Parent = p295;

    return ImageLabel;
end;

local function BuildDropShadow(p301: any, p302: userdata, p303: number, p304: number, p305: number) -- Line: 1195
    -- upvalues: script_Easing (copy), Rect_new_ret (copy)
    local ef = p301.ef;

    if ef == nil then
        return;
    end;

    for _, v in ef do
        if v.ty == 25 then
            local ef2 = v.ef;

            if ef2 ~= nil then
                local Color3_new_ret = Color3.new(0, 0, 0);
                local v306 = 0;
                local v307 = 5;
                local v308 = 5;
                local v309 = 0.5;

                for _, v2 in ef2 do
                    local ty = v2.ty;

                    if ty ~= nil then
                        if ty == 1 then
                            Color3_new_ret = script_Easing.EvaluateColor(v2.v, p305);
                        elseif ty == 0 then
                            v309 = script_Easing.EvaluateScalarAtFrame(v2.v, p305, 128) / 255;
                        elseif ty == 3 then
                            v306 = script_Easing.EvaluateScalarAtFrame(v2.v, p305, 0);
                        elseif ty == 2 then
                            v307 = script_Easing.EvaluateScalarAtFrame(v2.v, p305, 5);
                        elseif ty == 4 then
                            v308 = script_Easing.EvaluateScalarAtFrame(v2.v, p305, 5);
                        end;
                    end;
                end;

                local math_rad_ret = math.rad(v306 + 180);
                local v310 = math.cos(math_rad_ret) * v307 / p303;
                local v311 = math.sin(math_rad_ret) * v307 / p304;
                local v312 = (v308 * 2 + math.max(p303, p304)) / math.max(p303, p304);
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.Image = "rbxassetid://100849323991833";
                ImageLabel.ScaleType = Enum.ScaleType.Slice;
                ImageLabel.SliceCenter = Rect_new_ret;
                ImageLabel.ImageColor3 = Color3_new_ret;
                ImageLabel.ImageTransparency = 1 - v309;
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.BorderSizePixel = 0;
                ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
                ImageLabel.Position = UDim2.fromScale(v310 + 0.5, v311 + 0.5);
                ImageLabel.Size = UDim2.fromScale(v312, v312);
                ImageLabel.ZIndex = -1;
                ImageLabel.Parent = p302;

                return;
            end;
        end;
    end;
end;

local function BuildLayers(p313: table, p314: userdata, p315: table, p316: number, p317: number, p318: number) -- Line: 1260
    -- upvalues: UDim2_fromScale_ret2 (copy), BuildShapeLayer (copy), BuildTextLayer (copy), BuildImageLayer (copy), BuildLayers (copy), BuildDropShadow (copy), script_Easing (copy), ApplyTransform (copy)
    local v319 = {};
    local v320 = {};

    for i = #p313, 1, -1 do
        local v321 = p313[i];
        local v322;

        if v321.hd then
            v322 = i;
        else
            local ty = v321.ty;
            local ks = v321.ks;
            local v323;

            if ks == nil then
                v323 = false;
            else
                local o = ks.o;

                if o == nil then
                    v323 = false;
                else
                    v323 = o.a == 1;
                end;
            end;

            local v324;

            if ty == 1 then
                v324 = Instance.new("Frame");
                v324.BorderSizePixel = 0;
                local v325;

                if v321.sc then
                    local sc = v321.sc;
                    local string_sub_ret = string.sub(sc, 2, 3);
                    local v326 = tonumber(string_sub_ret, 16) or 0;
                    local string_sub_ret2 = string.sub(sc, 4, 5);
                    local v327 = tonumber(string_sub_ret2, 16) or 0;
                    local string_sub_ret3 = string.sub(sc, 6, 7);
                    local v328 = tonumber(string_sub_ret3, 16) or 0;
                    v325 = Color3.fromRGB(v326, v327, v328);
                else
                    v325 = Color3.new(0, 0, 0);
                end;

                v324.BackgroundColor3 = v325;
                v324.BackgroundTransparency = 0;
                v324.Size = UDim2.fromScale((v321.sw or p316) / p316, (v321.sh or p317) / p317);
            elseif v323 then
                v324 = Instance.new("CanvasGroup");
                v324.BackgroundTransparency = 1;
                v324.BorderSizePixel = 0;
                v324.Size = UDim2_fromScale_ret2;
            else
                v324 = Instance.new("Frame");
                v324.BackgroundTransparency = 1;
                v324.BorderSizePixel = 0;
                v324.Size = UDim2_fromScale_ret2;
            end;

            v324.Name = v321.nm or `Layer_{v321.ind or i}`;
            local Scale = v324.Size.X.Scale;
            local Scale2 = v324.Size.Y.Scale;
            local v329 = {
                Layer = v321,
                Frame = v324,
                BaseSizeX = Scale,
                BaseSizeY = Scale2
            };

            if v321.ind then
                v319[v321.ind] = v329;
            end;

            if ty == 4 then
                v329.Shapes = BuildShapeLayer(v321, v324, p316, p317, p318);
            elseif ty == 5 then
                v329.TextLabel = BuildTextLayer(v321, v324, p316, p317, p318);
            elseif ty == 2 then
                v329.ImageLabel = BuildImageLayer(v321, v324, p315, p316, p317);
            elseif ty == 0 then
                local refId = v321.refId;

                if refId and p315[refId] then
                    local v330 = p315[refId];

                    if v330.layers then
                        local v331 = v321.w or (v330.w or p316);
                        local v332 = v321.h or (v330.h or p317);
                        v324.ClipsDescendants = true;
                        v324.Size = UDim2.fromScale(v331 / p316, v332 / p317);
                        v329.Children = BuildLayers(v330.layers, v324, p315, v331, v332, p318);
                    end;
                end;
            end;

            BuildDropShadow(v321, v324, p316, p317, p318);

            if v321.masksProperties then
                v322 = i;

                for _, v in v321.masksProperties do
                    if v.mode == "a" or v.mode == nil then
                        local v333 = script_Easing.EvaluateBezierShape(v.pt, p318);

                        if v333 then
                            local v334 = (1 / 0);
                            local v335 = (1 / 0);
                            local v336 = (-1 / 0);
                            local v337 = (-1 / 0);

                            for _, v2 in v333.v do
                                v334 = math.min(v334, v2[1]);
                                v335 = math.min(v335, v2[2]);
                                v336 = math.max(v336, v2[1]);
                                v337 = math.max(v337, v2[2]);
                            end;

                            local Frame = Instance.new("Frame");
                            Frame.BackgroundTransparency = 1;
                            Frame.BorderSizePixel = 0;
                            Frame.ClipsDescendants = true;
                            Frame.Position = UDim2.fromScale(v334 / p316, v335 / p317);
                            Frame.Size = UDim2.fromScale((v336 - v334) / p316, (v337 - v335) / p317);
                            Frame.Parent = p314;
                            v324.Parent = Frame;
                            v329.MatteClip = Frame;
                        end;
                    end;
                end;
            else
                v322 = i;
            end;

            ApplyTransform(v324, v321.ks, p318, p316, p317, v323, Scale, Scale2);
            local v338 = p318 - (v321.st or 0);
            local v339;

            if v321.ip <= v338 then
                v339 = v338 < v321.op;
            else
                v339 = false;
            end;

            v324.Visible = v339;
            table.insert(v320, v329);
        end;
    end;

    for _, v in v320 do
        local Layer = v.Layer;

        if Layer.parent and v319[Layer.parent] then
            v.Frame.Parent = v319[Layer.parent].Frame;
        elseif v.MatteClip == nil then
            v.Frame.Parent = p314;
        end;
    end;

    for i = 1, #v320 - 1 do
        local v340 = v320[i];
        local v341 = v320[i + 1];
        local v342;

        if v341.Layer.tt then
            v342 = i;
            local v343 = nil;

            for _, v in v340.Shapes or {} do
                if v.PathData then
                    v343 = script_Easing.EvaluateBezierShape(v.PathData, p318);
                    break;
                end;
            end;

            if v343 then
                local v344 = (1 / 0);
                local v345 = (1 / 0);
                local v346 = (-1 / 0);
                local v347 = (-1 / 0);

                for _, v in v343.v do
                    v344 = math.min(v344, v[1]);
                    v345 = math.min(v345, v[2]);
                    v346 = math.max(v346, v[1]);
                    v347 = math.max(v347, v[2]);
                end;

                local Frame = Instance.new("Frame");
                Frame.BackgroundTransparency = 1;
                Frame.BorderSizePixel = 0;
                Frame.ClipsDescendants = true;
                Frame.Position = UDim2.fromScale(v344 / p316, v345 / p317);
                Frame.Size = UDim2.fromScale((v346 - v344) / p316, (v347 - v345) / p317);
                Frame.Parent = p314;
                v341.Frame.Parent = Frame;
                v341.MatteClip = Frame;
                v340.Frame.Visible = false;
            end;
        else
            v342 = i;
        end;
    end;

    return v320;
end;

local u348 = nil;

local function RenderLayerNodes(p349: table, p350: number, p351: number, p352: number) -- Line: 1429
    -- upvalues: ApplyTransform (copy), u348 (ref), script_Easing (copy), RenderLayerNodes (copy)
    for _, v in p349 do
        local Layer = v.Layer;
        local v353 = p350 - (Layer.st or 0);
        local v354;

        if Layer.ip <= v353 then
            v354 = v353 < Layer.op;
        else
            v354 = false;
        end;

        v.Frame.Visible = v354;

        if v354 then
            local v355 = v.Frame:IsA("CanvasGroup");
            ApplyTransform(v.Frame, Layer.ks, v353, p351, p352, v355, v.BaseSizeX, v.BaseSizeY);
            local v356;

            if v.Shapes then
                v356 = v;

                for _, v2 in v.Shapes do
                    u348(v2, v353, p351, p352);
                end;
            else
                v356 = v;
            end;

            if v356.Children then
                local v357 = Layer.w or p351;
                local v358 = Layer.h or p352;
                local v359;

                if Layer.tm then
                    v359 = script_Easing.EvaluateScalarAtFrame(Layer.tm, v353, 0) * (Layer.op - Layer.ip);
                else
                    v359 = v353;
                end;

                RenderLayerNodes(v356.Children, v359, v357, v358);
            end;

            if v356.TextLabel and Layer.t then
                local d = Layer.t.d;

                if d and d.k then
                    local v360 = nil;

                    for _, v2 in d.k do
                        if v2.t == nil or v2.t <= v353 then
                            v360 = v2.s;
                        end;
                    end;

                    if v360 then
                        v356.TextLabel.Text = v360.t or "";

                        if v360.fc then
                            v356.TextLabel.TextColor3 = Color3.new(v360.fc[1] or 1, v360.fc[2] or 1, v360.fc[3] or 1);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

u348 = function(p361: any, p362: number, p363: number, p364: number) -- Line: 1482
    -- upvalues: u348 (ref), script_Easing (copy), BuildFilledPath (copy), BuildStrokedPath (copy)
    if p361.Children then
        for _, v in p361.Children do
            u348(v, p362, p363, p364);
        end;
    end;

    if p361.IsAnimatedPath and p361.PathData then
        local v365 = script_Easing.EvaluateBezierShape(p361.PathData, p362);

        if v365 and p361.Frame then
            local v366 = script_Easing.EvaluateColor(p361.FillColor, p362);
            local v367 = script_Easing.EvaluateScalarAtFrame(p361.FillOpacity, p362, 100);

            if p361.FillColor then
                BuildFilledPath(p361, v365, p361.Frame, p363, p364, v366, 1 - v367 / 100);
            end;

            if p361.StrokeColor then
                local v368 = script_Easing.EvaluateColor(p361.StrokeColor, p362);
                local v369 = script_Easing.EvaluateScalarAtFrame(p361.StrokeOpacity, p362, 100);
                local v370 = script_Easing.EvaluateScalarAtFrame(p361.StrokeWidth, p362, 0);

                if v370 > 0 then
                    BuildStrokedPath(p361, v365, p361.Frame, p363, p364, v368, 1 - v369 / 100, v370);
                end;
            end;
        end;
    elseif p361.FillColor then
        local FillColor = p361.FillColor;
        local v371;

        if FillColor == nil then
            v371 = false;
        else
            v371 = FillColor.a == 1;
        end;

        if v371 then
            local v372 = script_Easing.EvaluateColor(p361.FillColor, p362);
            local v373 = 1 - script_Easing.EvaluateScalarAtFrame(p361.FillOpacity, p362, 100) / 100;

            if p361.Triangles then
                for _, v in p361.Triangles do
                    if v.A.Visible then
                        v.A.ImageColor3 = v372;
                        v.A.ImageTransparency = v373;
                    end;

                    if v.B.Visible then
                        v.B.ImageColor3 = v372;
                        v.B.ImageTransparency = v373;
                    end;
                end;
            end;

            if p361.Frame and p361.Frame.BackgroundTransparency < 1 then
                p361.Frame.BackgroundColor3 = v372;
                p361.Frame.BackgroundTransparency = v373;
            end;
        end;
    end;

    if p361.StrokeColor then
        local StrokeColor = p361.StrokeColor;
        local v374;

        if StrokeColor == nil then
            v374 = false;
        else
            v374 = StrokeColor.a == 1;
        end;

        if v374 then
            local v375 = script_Easing.EvaluateColor(p361.StrokeColor, p362);
            local v376 = script_Easing.EvaluateScalarAtFrame(p361.StrokeOpacity, p362, 100);

            if p361.Segments then
                for _, v in p361.Segments do
                    if v.Visible then
                        v.BackgroundColor3 = v375;
                        v.BackgroundTransparency = 1 - v376 / 100;
                    end;
                end;
            end;

            if p361.UIStroke then
                p361.UIStroke.Color = v375;
                p361.UIStroke.Transparency = 1 - v376 / 100;
            end;
        end;
    end;
end;

return table.freeze({
    Parse = function(p377: string) -- Line: 1551, Name: Parse
        -- upvalues: HttpService (copy)
        return HttpService:JSONDecode(p377);
    end,

    Create = function(p378) -- Line: 1555, Name: Create
        -- upvalues: UDim2_fromScale_ret2 (copy), BuildLayers (copy)
        local w = p378.w;
        local h = p378.h;
        local ip = p378.ip;
        local op = p378.op;
        local fr = p378.fr;
        local Frame = Instance.new("Frame");
        Frame.Name = p378.nm or "LottieAnimation";
        Frame.BackgroundTransparency = 1;
        Frame.BorderSizePixel = 0;
        Frame.ClipsDescendants = true;
        Frame.Size = UDim2_fromScale_ret2;
        local v379 = {};

        if p378.assets then
            for _, v in p378.assets do
                v379[v.id] = v;
            end;
        end;

        return {
            Animation = p378,
            Root = Frame,
            Layers = BuildLayers(p378.layers, Frame, v379, w, h, ip),
            AssetMap = v379,
            Duration = (op - ip) / fr,
            Width = w,
            Height = h
        };
    end,

    Render = function(p380: any, p381: number) -- Line: 1590, Name: Render
        -- upvalues: RenderLayerNodes (copy)
        local Animation = p380.Animation;
        local ip = Animation.ip;
        RenderLayerNodes(p380.Layers, ip + p381 * Animation.fr % (Animation.op - ip), p380.Width, p380.Height);
    end,

    Destroy = function(p382) -- Line: 1601, Name: Destroy
        p382.Root:Destroy();
        table.clear(p382.Layers);
        table.clear(p382.AssetMap);
    end
});