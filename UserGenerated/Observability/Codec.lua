-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Encode = require(ReplicatedStorage.UserGenerated.DataModel.Encode);
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local ValueType = Observability.ValueType;
local MaxStringBytes = Observability.MaxStringBytes;
local u7 = {
    newWriter = Encode.newWriter,

    varuint = function(p1: any, p2: number) -- Line: 26, Name: varuint
        local math_floor_ret = math.floor(p2);
        local math_max_ret = math.max(0, math_floor_ret);

        while math_max_ret >= 128 do
            p1:u8((bit32.bor(math_max_ret % 128, 128)));
            math_max_ret = math_max_ret // 128;
        end;

        p1:u8(math_max_ret);
    end,

    i16 = function(p3: any, p4: number) -- Line: 35, Name: i16
        p3:_ensure(2);
        local buf = p3.buf;
        local len = p3.len;
        local math_round_ret = math.round(p4);
        local math_clamp_ret = math.clamp(math_round_ret, -32768, 32767);
        buffer.writei16(buf, len, math_clamp_ret);
        p3.len = p3.len + 2;
    end,

    i32 = function(p5: any, p6: number) -- Line: 41, Name: i32
        p5:_ensure(4);
        local buf = p5.buf;
        local len = p5.len;
        local math_round_ret = math.round(p6 ~= p6 and 0 or p6);
        local math_clamp_ret = math.clamp(math_round_ret, -2147483648, 2147483647);
        buffer.writei32(buf, len, math_clamp_ret);
        p5.len = p5.len + 4;
    end
};

function u7.str(p8: any, p9: string) -- Line: 50
    -- upvalues: MaxStringBytes (copy), u7 (copy)
    local v10 = #p9;

    if MaxStringBytes < v10 then
        v10 = MaxStringBytes;

        while v10 > 0 do
            local string_byte_ret = string.byte(p9, v10 + 1);

            if bit32.band(string_byte_ret, 192) ~= 128 then
                break;
            end;

            v10 = v10 - 1;
        end;

        p9 = string.sub(p9, 1, v10);
    end;

    u7.varuint(p8, v10);

    if v10 > 0 then
        p8:_ensure(v10);
        buffer.writestring(p8.buf, p8.len, p9);
        p8.len = p8.len + v10;
    end;
end;

local function color(p11: any, p12) -- Line: 68
    local math_floor_ret = math.floor(p12.R * 255 + 0.5);
    p11:u8((math.clamp(math_floor_ret, 0, 255)));
    local math_floor_ret2 = math.floor(p12.G * 255 + 0.5);
    p11:u8((math.clamp(math_floor_ret2, 0, 255)));
    local math_floor_ret3 = math.floor(p12.B * 255 + 0.5);
    p11:u8((math.clamp(math_floor_ret3, 0, 255)));
end;

local function udim(p13: any, p14) -- Line: 74
    -- upvalues: u7 (copy)
    p13:f32(p14.Scale);
    u7.i32(p13, p14.Offset);
end;

function u7.udim2Mask(p15, p16) -- Line: 81
    local X = p15.X;
    local Y = p15.Y;
    local X2 = p16.X;
    local Y2 = p16.Y;

    return (X.Scale == X2.Scale and 0 or 1) + (X.Offset == X2.Offset and 0 or 2) + (Y.Scale == Y2.Scale and 0 or 4) + (Y.Offset == Y2.Offset and 0 or 8);
end;

function u7.udim2Part(p17: any, p18: number, p19) -- Line: 90
    -- upvalues: u7 (copy)
    p17:u8(p18);

    if bit32.btest(p18, 1) then
        p17:f32(p19.X.Scale);
    end;

    if bit32.btest(p18, 2) then
        u7.i32(p17, p19.X.Offset);
    end;

    if bit32.btest(p18, 4) then
        p17:f32(p19.Y.Scale);
    end;

    if bit32.btest(p18, 8) then
        u7.i32(p17, p19.Y.Offset);
    end;
end;

local function finite(p20: number) -- Line: 106
    return (p20 ~= p20 or (p20 <= (-1 / 0) or p20 >= (1 / 0))) and 0 or p20;
end;

local function quantize(p21: number) -- Line: 112
    local math_round_ret = math.round(p21);

    return math.clamp(math_round_ret, -32768, 32767);
end;

local function quantizeRotation(p22) -- Line: 118
    local _, _, _, v23, v24, v25, v26, v27, v28, v29, v30, v31 = p22:GetComponents();

    if v23 == 1 and (v27 == 1 and v31 == 1) then
        return 4, 0, 0, 0;
    end;

    local v32 = v23 + v27 + v31;
    local v33, v34, v35, v36;

    if v32 > 0 then
        local v37 = math.sqrt(1 + v32) * 2;
        v33 = v37 * 0.25;
        v34 = (v30 - v28) / v37;
        v35 = (v25 - v29) / v37;
        v36 = (v26 - v24) / v37;
    elseif v27 < v23 and v31 < v23 then
        local v38 = math.sqrt(1 + v23 - v27 - v31) * 2;
        v33 = (v30 - v28) / v38;
        v34 = v38 * 0.25;
        v35 = (v24 + v26) / v38;
        v36 = (v25 + v29) / v38;
    elseif v31 < v27 then
        local v39 = math.sqrt(1 + v27 - v23 - v31) * 2;
        v33 = (v25 - v29) / v39;
        v34 = (v24 + v26) / v39;
        v35 = v39 * 0.25;
        v36 = (v28 + v30) / v39;
    else
        local v40 = math.sqrt(1 + v31 - v23 - v27) * 2;
        v33 = (v26 - v24) / v40;
        v34 = (v25 + v29) / v40;
        v35 = (v28 + v30) / v40;
        v36 = v40 * 0.25;
    end;

    local v41 = {
        (v34 ~= v34 or (v34 <= (-1 / 0) or v34 >= (1 / 0))) and 0 or v34,
        (v35 ~= v35 or (v35 <= (-1 / 0) or v35 >= (1 / 0))) and 0 or v35,
        (v36 ~= v36 or (v36 <= (-1 / 0) or v36 >= (1 / 0))) and 0 or v36,
        (v33 ~= v33 or (v33 <= (-1 / 0) or v33 >= (1 / 0))) and 0 or v33
    };
    local math_sqrt_ret = math.sqrt(v41[1] * v41[1] + v41[2] * v41[2] + v41[3] * v41[3] + v41[4] * v41[4]);

    if math_sqrt_ret < 1e-6 then
        return 4, 0, 0, 0;
    end;

    local v42 = 1;
    local v43 = math.abs(v41[2]) > math.abs(v41[v42]) and 2 or v42;
    local v44 = math.abs(v41[3]) > math.abs(v41[v43]) and 3 or v43;
    local v45 = math.abs(v41[4]) > math.abs(v41[v44]) and 4 or v44;
    local v46 = (v41[v45] < 0 and -46339.53579827921 or 46339.53579827921) / math_sqrt_ret;
    local v47 = 0;
    local v48 = 0;
    local v49 = 0;
    local v50 = 0;

    for i = 1, 4 do
        local v51;

        if i == v45 then
            v51 = i;
        else
            v47 = v47 + 1;
            local math_round_ret = math.round(v41[i] * v46);
            local math_clamp_ret = math.clamp(math_round_ret, -32768, 32767);

            if v47 == 1 then
                v48 = math_clamp_ret;
                v51 = i;
            elseif v47 == 2 then
                v49 = math_clamp_ret;
                v51 = i;
            else
                v50 = math_clamp_ret;
                v51 = i;
            end;
        end;
    end;

    return v45 - 1, v48, v49, v50;
end;

u7.quantizeRotation = quantizeRotation;

function u7.position(p52: any, p53) -- Line: 169
    local Position = p53.Position;
    local X = Position.X;
    p52:f32((X ~= X or (X <= (-1 / 0) or X >= (1 / 0))) and 0 or X);
    local Y = Position.Y;
    p52:f32((Y ~= Y or (Y <= (-1 / 0) or Y >= (1 / 0))) and 0 or Y);
    local Z = Position.Z;
    p52:f32((Z ~= Z or (Z <= (-1 / 0) or Z >= (1 / 0))) and 0 or Z);
end;

function u7.rotation(p54: any, p55: number, p56: number, p57: number, p58: number) -- Line: 178
    -- upvalues: u7 (copy)
    p54:u8(p55);

    if p55 ~= 4 then
        u7.i16(p54, p56);
        u7.i16(p54, p57);
        u7.i16(p54, p58);
    end;
end;

function u7.cframe(p59: any, p60) -- Line: 188
    -- upvalues: quantizeRotation (copy), u7 (copy)
    local Position = p60.Position;
    local X = Position.X;
    p59:f32((X ~= X or (X <= (-1 / 0) or X >= (1 / 0))) and 0 or X);
    local Y = Position.Y;
    p59:f32((Y ~= Y or (Y <= (-1 / 0) or Y >= (1 / 0))) and 0 or Y);
    local Z = Position.Z;
    p59:f32((Z ~= Z or (Z <= (-1 / 0) or Z >= (1 / 0))) and 0 or Z);
    local v61, v62, v63, v64 = quantizeRotation(p60);
    p59:u8(v61);

    if v61 ~= 4 then
        u7.i16(p59, v62);
        u7.i16(p59, v63);
        u7.i16(p59, v64);
    end;
end;

function u7.zigzag(p65: any, p66: number) -- Line: 194
    -- upvalues: u7 (copy)
    local v67;

    if p66 >= 0 then
        v67 = p66 * 2;
    else
        v67 = -p66 * 2 - 1;
    end;

    u7.varuint(p65, v67);
end;

u7.MaxPositionSteps = 2147483648;
local buffer_create_ret = buffer.create(4);

function u7.stepPosition(p68: number, p69: number) -- Line: 207
    -- upvalues: buffer_create_ret (copy)
    buffer.writef32(buffer_create_ret, 0, p68 + p69 / 1024);

    return buffer.readf32(buffer_create_ret, 0);
end;

function u7.positionSteps(p70: number, p71: number) -- Line: 213
    return math.round((p71 - p70) * 1024);
end;

function u7.cframeDelta(p72: any, p73: number, p74: number, p75: number, p76: number, p77: number, p78: number, p79: number, p80: number, p81: number, p82: number, p83: number) -- Line: 220
    -- upvalues: u7 (copy)
    local v84 = p73 == 0 and (p74 == 0 and p75 == 0) and 0 or 1;
    local v85;

    if p76 == p80 and (p77 == p81 and p78 == p82) then
        v85 = p79 == p83;
    else
        v85 = false;
    end;

    if not v85 then
        if p76 == p80 and (p80 ~= 4 and (math.abs(p81 - p77) <= 8191 and (math.abs(p82 - p78) <= 8191 and math.abs(p83 - p79) <= 8191))) then
            v84 = v84 + 4;
        else
            v84 = v84 + 2;
        end;
    end;

    p72:u8(v84);

    if v84 % 2 == 1 then
        u7.zigzag(p72, p73);
        u7.zigzag(p72, p74);
        u7.zigzag(p72, p75);
    end;

    if not bit32.btest(v84, 4) then
        if bit32.btest(v84, 2) then
            p72:u8(p80);

            if p80 ~= 4 then
                u7.i16(p72, p81);
                u7.i16(p72, p82);
                u7.i16(p72, p83);
            end;
        end;

        return;
    end;

    u7.zigzag(p72, p81 - p77);
    u7.zigzag(p72, p82 - p78);
    u7.zigzag(p72, p83 - p79);
end;

local function u86() -- Line: 269
    return nil;
end;

function u7.setRefLookup(p87: function) -- Line: 273
    -- upvalues: u86 (ref)
    u86 = p87;
end;

local u139 = {
    [ValueType.Bool] = function(p88, p89) -- Line: 278
        p88:u8(p89 == true and 1 or 0);
    end,

    [ValueType.Int32] = function(p90, p91) -- Line: 281
        -- upvalues: u7 (copy)
        u7.i32(p90, type(p91) ~= "number" and 0 or p91);
    end,

    [ValueType.Float32] = function(p92, p93) -- Line: 284
        p92:f32(type(p93) ~= "number" and 0 or p93);
    end,

    [ValueType.Float64] = function(p94, p95) -- Line: 287
        p94:f64(type(p95) ~= "number" and 0 or p95);
    end,

    [ValueType.Int64] = function(p96, p97) -- Line: 290
        p96:f64(type(p97) ~= "number" and 0 or p97);
    end,

    [ValueType.String] = function(p98, p99) -- Line: 293
        -- upvalues: u7 (copy)
        u7.str(p98, type(p99) ~= "string" and "" or p99);
    end,

    [ValueType.Enum] = function(p100, p101) -- Line: 296
        -- upvalues: u7 (copy)
        u7.varuint(p100, typeof(p101) ~= "EnumItem" and 0 or p101.Value);
    end,

    [ValueType.UDim] = function(p102, p103) -- Line: 299
        -- upvalues: u7 (copy)
        if typeof(p103) ~= "UDim" then
            p103 = UDim.new();
        end;

        p102:f32(p103.Scale);
        u7.i32(p102, p103.Offset);
    end,

    [ValueType.UDim2] = function(p104, p105) -- Line: 302
        -- upvalues: u7 (copy)
        if typeof(p105) ~= "UDim2" then
            p105 = UDim2.new();
        end;

        local X = p105.X;
        p104:f32(X.Scale);
        u7.i32(p104, X.Offset);
        local Y = p105.Y;
        p104:f32(Y.Scale);
        u7.i32(p104, Y.Offset);
    end,

    [ValueType.Vector2] = function(p106, p107) -- Line: 307
        if typeof(p107) ~= "Vector2" then
            p107 = Vector2.zero;
        end;

        p106:f32(p107.X);
        p106:f32(p107.Y);
    end,

    [ValueType.Vector3] = function(p108, p109) -- Line: 312
        local v110 = typeof(p109) ~= "Vector3" and Vector3.new(0, 0, 0) or p109;
        p108:f32(v110.X);
        p108:f32(v110.Y);
        p108:f32(v110.Z);
    end,

    [ValueType.Color3] = function(p111, p112) -- Line: 318
        -- upvalues: color (copy)
        if typeof(p112) ~= "Color3" then
            p112 = Color3.new();
        end;

        color(p111, p112);
    end,

    [ValueType.Rect] = function(p113, p114) -- Line: 321
        if typeof(p114) ~= "Rect" then
            p114 = Rect.new();
        end;

        p113:f32(p114.Min.X);
        p113:f32(p114.Min.Y);
        p113:f32(p114.Max.X);
        p113:f32(p114.Max.Y);
    end,

    [ValueType.Font] = function(p115, p116) -- Line: 328
        -- upvalues: u7 (copy)
        if typeof(p116) == "Font" then
            u7.str(p115, p116.Family);
            u7.varuint(p115, p116.Weight.Value);
            p115:u8(p116.Style.Value);

            return;
        end;

        u7.str(p115, "");
        u7.varuint(p115, 400);
        p115:u8(0);
    end,

    [ValueType.ColorSequence] = function(p117, p118) -- Line: 339
        -- upvalues: u7 (copy), color (copy)
        local v119 = typeof(p118) ~= "ColorSequence" and {} or p118.Keypoints;
        u7.varuint(p117, #v119);

        for _, v in v119 do
            p117:f32(v.Time);
            color(p117, v.Value);
        end;
    end,

    [ValueType.NumberSequence] = function(p120, p121) -- Line: 347
        -- upvalues: u7 (copy)
        local v122 = typeof(p121) ~= "NumberSequence" and {} or p121.Keypoints;
        u7.varuint(p120, #v122);

        for _, v in v122 do
            p120:f32(v.Time);
            p120:f32(v.Value);
            p120:f32(v.Envelope);
        end;
    end,

    [ValueType.NumberRange] = function(p123, p124) -- Line: 356
        if typeof(p124) ~= "NumberRange" then
            p124 = NumberRange.new(0);
        end;

        p123:f32(p124.Min);
        p123:f32(p124.Max);
    end,

    [ValueType.Content] = function(p125, p126) -- Line: 361
        -- upvalues: u7 (copy)
        local v127;

        if typeof(p126) == "Content" then
            v127 = p126.Uri;
        else
            v127 = nil;
        end;

        u7.str(p125, type(v127) ~= "string" and "" or v127);
    end,

    [ValueType.CFrame] = function(p128, p129) -- Line: 365
        -- upvalues: quantizeRotation (copy), u7 (copy)
        if typeof(p129) ~= "CFrame" then
            p129 = CFrame.identity;
        end;

        local Position = p129.Position;
        local X = Position.X;
        p128:f32((X ~= X or (X <= (-1 / 0) or X >= (1 / 0))) and 0 or X);
        local Y = Position.Y;
        p128:f32((Y ~= Y or (Y <= (-1 / 0) or Y >= (1 / 0))) and 0 or Y);
        local Z = Position.Z;
        p128:f32((Z ~= Z or (Z <= (-1 / 0) or Z >= (1 / 0))) and 0 or Z);
        local v130, v131, v132, v133 = quantizeRotation(p129);
        p128:u8(v130);

        if v130 ~= 4 then
            u7.i16(p128, v131);
            u7.i16(p128, v132);
            u7.i16(p128, v133);
        end;
    end,

    [ValueType.Ref] = function(p134, p135) -- Line: 368
        -- upvalues: u86 (ref), u7 (copy)
        local v136;

        if typeof(p135) == "Instance" then
            v136 = u86(p135);
        else
            v136 = nil;
        end;

        u7.varuint(p134, not v136 and 0 or v136 + 1);
    end,

    [ValueType.Vector2int16] = function(p137, p138) -- Line: 372
        -- upvalues: u7 (copy)
        if typeof(p138) ~= "Vector2int16" then
            p138 = Vector2int16.new();
        end;

        u7.i16(p137, p138.X);
        u7.i16(p137, p138.Y);
    end
};
u7.Writers = u139;

function u7.writeValue(p140: any, p141: number, p142: any) -- Line: 380
    -- upvalues: u139 (copy)
    u139[p141](p140, p142);
end;

u7.EngineTypes = table.freeze({
    bool = ValueType.Bool,
    int = ValueType.Int32,
    int64 = ValueType.Int64,
    float = ValueType.Float32,
    double = ValueType.Float64,
    string = ValueType.String,
    ContentId = ValueType.String,
    Enum = ValueType.Enum,
    UDim = ValueType.UDim,
    UDim2 = ValueType.UDim2,
    Vector2 = ValueType.Vector2,
    Vector3 = ValueType.Vector3,
    Color3 = ValueType.Color3,
    Rect = ValueType.Rect,
    Font = ValueType.Font,
    ColorSequence = ValueType.ColorSequence,
    NumberSequence = ValueType.NumberSequence,
    NumberRange = ValueType.NumberRange,
    Content = ValueType.Content,
    CFrame = ValueType.CFrame,
    Vector2int16 = ValueType.Vector2int16
});

return table.freeze(u7);