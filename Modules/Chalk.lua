-- Decompiled with Potassium's decompiler.

local u1 = {
    FONT_COLOR_RGB = {
        Start = "<font color=\"rgb(%s,%s,%s)\">",
        End = "</font>"
    },
    FONT_COLOR_HEX = {
        Start = "<font color=\"#%s\">",
        End = "</font>"
    },
    FONT_SIZE = {
        Start = "<font size=\"%d\">",
        End = "</font>"
    },
    FONT_FACE = {
        Start = "<font face=\"%s\">",
        End = "</font>"
    },
    FONT_FAMILY = {
        Start = "<font family=\"%s\">",
        End = "</font>"
    },
    FONT_WEIGHT = {
        Start = "<font weight=\"%s\">",
        End = "</font>"
    },
    FONT_TRANSPARENCY = {
        Start = "<font transparency=\"%s\">",
        End = "</font>"
    },
    STROKE = {
        Start = "<stroke color=\"#%s\" joins=\"%s\" thickness=\"%s\" transparency=\"%s\">",
        End = "</stroke>"
    },
    BOLD = {
        Start = "<b>",
        End = "</b>"
    },
    ITALIC = {
        Start = "<i>",
        End = "</i>"
    },
    UNDERLINE = {
        Start = "<u>",
        End = "</u>"
    },
    STRIKETHROUGH = {
        Start = "<s>",
        End = "</s>"
    },
    UPPERCASE = {
        Start = "<uppercase>",
        End = "</uppercase>"
    },
    SMALLCAPS = {
        Start = "<smallcaps>",
        End = "</smallcaps>"
    }
};
local u2 = {};
local u3 = {};
u3.__index = u3;

local function GenerateCustomHandlerFunction(u4) -- Line: 92
    -- upvalues: u1 (copy)
    return function(p5) -- Line: 93
        -- upvalues: u1 (ref), u4 (copy)
        local u6 = u1[u4].Start:format(p5);

        return function(p7) -- Line: 96
            -- upvalues: u6 (copy), u1 (ref), u4 (ref)
            return `{u6}{p7}{u1[u4].End}`;
        end;
    end;
end;

local function GenerateChalkDataFunction(u8) -- Line: 102
    -- upvalues: u1 (copy)
    return function(p9) -- Line: 103
        -- upvalues: u1 (ref), u8 (copy)
        local v10 = u1[u8];

        return `{v10.Start}{p9}{v10.End}`;
    end;
end;

local function GenerateColorFunction(u11) -- Line: 109
    -- upvalues: u1 (copy)
    return function(p12) -- Line: 110
        -- upvalues: u11 (copy), u1 (ref)
        local math_floor_ret = math.floor(u11.r * 255);
        local math_floor_ret2 = math.floor(u11.g * 255);
        local math_floor_ret3 = math.floor(u11.b * 255);

        return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p12}{u1.FONT_COLOR_RGB.End}`;
    end;
end;

local function ValidateHex(p13) -- Line: 121
    if typeof(p13) == "string" then
        local v14 = p13:gsub("#", "");

        return string.match(v14, "^%x%x%x%x%x%x$");
    end;
end;

local u15 = {};
local u16 = "FONT_SIZE";

function u15.size(p17) -- Line: 93
    -- upvalues: u1 (copy), u16 (copy)
    local u18 = u1[u16].Start:format(p17);

    return function(p19) -- Line: 96
        -- upvalues: u18 (copy), u1 (ref), u16 (ref)
        return `{u18}{p19}{u1[u16].End}`;
    end;
end;

local u20 = "FONT_FACE";

function u15.face(p21) -- Line: 93
    -- upvalues: u1 (copy), u20 (copy)
    local u22 = u1[u20].Start:format(p21);

    return function(p23) -- Line: 96
        -- upvalues: u22 (copy), u1 (ref), u20 (ref)
        return `{u22}{p23}{u1[u20].End}`;
    end;
end;

local u24 = "FONT_FAMILY";

function u15.family(p25) -- Line: 93
    -- upvalues: u1 (copy), u24 (copy)
    local u26 = u1[u24].Start:format(p25);

    return function(p27) -- Line: 96
        -- upvalues: u26 (copy), u1 (ref), u24 (ref)
        return `{u26}{p27}{u1[u24].End}`;
    end;
end;

local u28 = "FONT_WEIGHT";

function u15.weight(p29) -- Line: 93
    -- upvalues: u1 (copy), u28 (copy)
    local u30 = u1[u28].Start:format(p29);

    return function(p31) -- Line: 96
        -- upvalues: u30 (copy), u1 (ref), u28 (ref)
        return `{u30}{p31}{u1[u28].End}`;
    end;
end;

local u32 = "FONT_TRANSPARENCY";

function u15.transparency(p33) -- Line: 93
    -- upvalues: u1 (copy), u32 (copy)
    local u34 = u1[u32].Start:format(p33);

    return function(p35) -- Line: 96
        -- upvalues: u34 (copy), u1 (ref), u32 (ref)
        return `{u34}{p35}{u1[u32].End}`;
    end;
end;

function u15.stroke(p36) -- Line: 135
    -- upvalues: u1 (copy)
    local v37 = `#{p36.Color:ToHex()}`;
    local u38 = u1.STROKE.Start:format(v37, p36.Joins or "Round", p36.Thickness or 1, p36.Transparency or 0);

    return function(p39) -- Line: 145
        -- upvalues: u38 (copy), u1 (ref)
        return `{u38}{p39}{u1.STROKE.End}`;
    end;
end;

function u15.color(...) -- Line: 149
    -- upvalues: u1 (copy)
    local v40 = { ... };
    local v41 = v40[1];
    local v42;

    if typeof(v41) == "string" then
        local v43 = v41:gsub("#", "");
        v42 = string.match(v43, "^%x%x%x%x%x%x$");
    else
        v42 = nil;
    end;

    local v44 = typeof(v40[1]) == "Color3";
    local v45 = v40[1];
    local v46 = v44 and v45 and v45 or Color3.fromRGB(v45, v40[2], v40[3]);
    local u47 = v42 and u1.FONT_COLOR_HEX.Start:format(v45:gsub("#", "")) or u1.FONT_COLOR_RGB.Start:format(math.floor(v46.R * 255), math.floor(v46.G * 255), (math.floor(v46.B * 255)));

    return function(p48) -- Line: 163
        -- upvalues: u47 (copy), u1 (ref)
        return `{u47}{p48}{u1.FONT_COLOR_RGB.End}`;
    end;
end;

local u49 = "BOLD";

function u2.bold(p50) -- Line: 103
    -- upvalues: u1 (copy), u49 (copy)
    local v51 = u1[u49];

    return `{v51.Start}{p50}{v51.End}`;
end;

local u52 = "ITALIC";

function u2.italic(p53) -- Line: 103
    -- upvalues: u1 (copy), u52 (copy)
    local v54 = u1[u52];

    return `{v54.Start}{p53}{v54.End}`;
end;

local u55 = "UNDERLINE";

function u2.underline(p56) -- Line: 103
    -- upvalues: u1 (copy), u55 (copy)
    local v57 = u1[u55];

    return `{v57.Start}{p56}{v57.End}`;
end;

local u58 = "STRIKETHROUGH";

function u2.strikethrough(p59) -- Line: 103
    -- upvalues: u1 (copy), u58 (copy)
    local v60 = u1[u58];

    return `{v60.Start}{p59}{v60.End}`;
end;

local u61 = "UPPERCASE";

function u2.uppercase(p62) -- Line: 103
    -- upvalues: u1 (copy), u61 (copy)
    local v63 = u1[u61];

    return `{v63.Start}{p62}{v63.End}`;
end;

local u64 = "SMALLCAPS";

function u2.smallcaps(p65) -- Line: 103
    -- upvalues: u1 (copy), u64 (copy)
    local v66 = u1[u64];

    return `{v66.Start}{p65}{v66.End}`;
end;

local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);

function u2.white(p67) -- Line: 110
    -- upvalues: Color3_fromRGB_ret (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p67}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret2 = Color3.fromRGB(0, 0, 0);

function u2.black(p68) -- Line: 110
    -- upvalues: Color3_fromRGB_ret2 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret2.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret2.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret2.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p68}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret3 = Color3.fromRGB(255, 0, 0);

function u2.red(p69) -- Line: 110
    -- upvalues: Color3_fromRGB_ret3 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret3.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret3.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret3.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p69}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret4 = Color3.fromRGB(153, 51, 0);

function u2.brown(p70) -- Line: 110
    -- upvalues: Color3_fromRGB_ret4 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret4.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret4.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret4.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p70}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret5 = Color3.fromRGB(255, 153, 0);

function u2.orange(p71) -- Line: 110
    -- upvalues: Color3_fromRGB_ret5 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret5.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret5.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret5.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p71}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret6 = Color3.fromRGB(255, 255, 0);

function u2.yellow(p72) -- Line: 110
    -- upvalues: Color3_fromRGB_ret6 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret6.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret6.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret6.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p72}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret7 = Color3.fromRGB(153, 255, 0);

function u2.lime(p73) -- Line: 110
    -- upvalues: Color3_fromRGB_ret7 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret7.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret7.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret7.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p73}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret8 = Color3.fromRGB(0, 255, 0);

function u2.green(p74) -- Line: 110
    -- upvalues: Color3_fromRGB_ret8 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret8.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret8.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret8.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p74}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret9 = Color3.fromRGB(0, 0, 255);

function u2.blue(p75) -- Line: 110
    -- upvalues: Color3_fromRGB_ret9 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret9.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret9.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret9.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p75}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret10 = Color3.fromRGB(102, 0, 153);

function u2.purple(p76) -- Line: 110
    -- upvalues: Color3_fromRGB_ret10 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret10.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret10.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret10.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p76}{u1.FONT_COLOR_RGB.End}`;
end;

local Color3_fromRGB_ret11 = Color3.fromRGB(255, 0, 255);

function u2.pink(p77) -- Line: 110
    -- upvalues: Color3_fromRGB_ret11 (copy), u1 (copy)
    local math_floor_ret = math.floor(Color3_fromRGB_ret11.r * 255);
    local math_floor_ret2 = math.floor(Color3_fromRGB_ret11.g * 255);
    local math_floor_ret3 = math.floor(Color3_fromRGB_ret11.b * 255);

    return `{u1.FONT_COLOR_RGB.Start:format(math_floor_ret, math_floor_ret2, math_floor_ret3)}{p77}{u1.FONT_COLOR_RGB.End}`;
end;

function u3.new(p78) -- Line: 188
    -- upvalues: u15 (copy), u2 (copy)
    local v79 = {};
    local v80 = {};
    local u81 = {};
    v79.Formatters = u81;
    local u82 = nil;
    local u83 = nil;

    function v80.__call(p84, ...) -- Line: 196
        -- upvalues: u82 (ref), u81 (copy)
        local v85 = { ... };

        if u82 then
            local v86 = u82;
            u82 = nil;

            return v86(unpack(v85));
        end;

        local v87 = {};

        for _, v in v85 do
            local v88 = v;

            for _, v2 in u81 do
                v88 = v2(v88);
            end;

            table.insert(v87, v88);
        end;

        return unpack(v87);
    end;

    function v80.__index(p89, p90) -- Line: 220
        -- upvalues: u15 (ref), u82 (ref), u81 (copy), u83 (ref), u2 (ref)
        local u91 = u15[p90];

        if u91 then
            u82 = function(...) -- Line: 224
                -- upvalues: u91 (copy), u81 (ref), u83 (ref)
                local v92 = u91(...);
                table.insert(u81, v92);

                return u83;
            end;

            return u83;
        end;

        table.insert(u81, u2[p90]);

        return p89;
    end;

    v80:__index(p78);
    u83 = setmetatable(v79, v80);

    return u83;
end;

return setmetatable({}, {
    __index = function(p93, p94) -- Line: 249, Name: __index
        -- upvalues: u3 (copy)
        return u3.new(p94);
    end,

    __newindex = function() -- Line: 252, Name: __newindex
        return error("Chalk is READONLY");
    end
});