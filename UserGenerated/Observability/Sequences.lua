-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local ValueType = Observability.ValueType;
local Op = Observability.Op;
local u1 = {
    Types = table.freeze({
        [ValueType.ColorSequence] = true,
        [ValueType.NumberSequence] = true
    })
};
local buffer_create_ret = buffer.create(4);

local function f32(p2: number) -- Line: 40
    -- upvalues: buffer_create_ret (copy)
    buffer.writef32(buffer_create_ret, 0, p2);

    return buffer.readf32(buffer_create_ret, 0);
end;

local function _(p3: number) -- Line: 45
    local math_floor_ret = math.floor(p3 * 255 + 0.5);

    return math.clamp(math_floor_ret, 0, 255);
end;

function u1.keypoints(p4: number, p5: any) -- Line: 50
    -- upvalues: ValueType (copy), buffer_create_ret (copy)
    local v6 = {};

    if p4 == ValueType.ColorSequence then
        if typeof(p5) == "ColorSequence" then
            for i, v in p5.Keypoints do
                local Value = v.Value;
                local v7 = {};
                buffer.writef32(buffer_create_ret, 0, v.Time);
                local buffer_readf32_ret = buffer.readf32(buffer_create_ret, 0);
                local math_floor_ret = math.floor(Value.R * 255 + 0.5);
                local math_clamp_ret = math.clamp(math_floor_ret, 0, 255);
                local math_floor_ret2 = math.floor(Value.G * 255 + 0.5);
                local math_clamp_ret2 = math.clamp(math_floor_ret2, 0, 255);
                local math_floor_ret3 = math.floor(Value.B * 255 + 0.5);
                v7[1], v7[2], v7[3], v7[4] = buffer_readf32_ret, math_clamp_ret, math_clamp_ret2, math.clamp(math_floor_ret3, 0, 255);
                v6[i] = v7;
            end;

            return v6;
        end;
    elseif typeof(p5) == "NumberSequence" then
        for i, v in p5.Keypoints do
            local v8 = {};
            buffer.writef32(buffer_create_ret, 0, v.Time);
            local buffer_readf32_ret = buffer.readf32(buffer_create_ret, 0);
            buffer.writef32(buffer_create_ret, 0, v.Value);
            local buffer_readf32_ret2 = buffer.readf32(buffer_create_ret, 0);
            buffer.writef32(buffer_create_ret, 0, v.Envelope);
            v8[1], v8[2], v8[3] = buffer_readf32_ret, buffer_readf32_ret2, buffer.readf32(buffer_create_ret, 0);
            v6[i] = v8;
        end;
    end;

    return v6;
end;

function u1.key(p9: table) -- Line: 68
    local buffer_create_ret2 = buffer.create(#p9 * (p9[1] and #p9[1] or 0) * 4);
    local v10 = 0;

    for _, v in p9 do
        for _, v2 in v do
            buffer.writef32(buffer_create_ret2, v10, v2);
            v10 = v10 + 4;
        end;
    end;

    return buffer.tostring(buffer_create_ret2);
end;

function u1.shift(p11: table, p12: number, p13: table, p14: table) -- Line: 83
    local v15 = #p11;
    local v16 = p12 / 65536;
    local v17 = {};
    local v18 = {};

    for i = 2, v15 - 1 do
        local v19 = p11[i];
        local table_clone_ret = table.clone(v19);
        local v20 = v19[1] + v16;
        local v21;

        if v20 >= 1 then
            table_clone_ret[1] = v20 - 1;
            table.insert(v17, table_clone_ret);
            v21 = i;
        else
            table_clone_ret[1] = v20;
            table.insert(v18, table_clone_ret);
            v21 = i;
        end;
    end;

    local table_clone_ret = table.clone(p13);
    table_clone_ret[1] = p11[1][1];
    local table_clone_ret2 = table.clone(p14);
    table_clone_ret2[1] = p11[v15][1];
    local v22 = { table_clone_ret };
    table.move(v17, 1, #v17, 2, v22);
    table.move(v18, 1, #v18, #v22 + 1, v22);
    table.insert(v22, table_clone_ret2);

    return v22;
end;

local function near(p23: table, p24: table, p25: number) -- Line: 110
    -- upvalues: ValueType (copy)
    if #p23 ~= #p24 then
        return false;
    end;

    local v26 = p25 == ValueType.ColorSequence;

    for i, v in p23 do
        local v27 = p24[i];

        if math.abs(v[1] - v27[1]) > 0.0005 then
            return false;
        end;

        local v28 = v;

        for i2 = 2, #v do
            local v29;

            if v26 then
                v29 = v28[i2] ~= v27[i2];
            else
                v29 = math.abs(v28[i2] - v27[i2]) > 0.0001;
            end;

            if v29 then
                return false;
            end;

            local _ = i2;
        end;
    end;

    return true;
end;

function u1.findShift(p30: table, p31: table, p32: number) -- Line: 131
    -- upvalues: u1 (copy), near (copy)
    local v33 = #p31;

    if v33 < 3 or #p30 ~= v33 then
        return nil, nil;
    end;

    local v34 = p31[2][1];

    for i = 2, v33 - 1 do
        local v35 = math.round((v34 - p30[i][1]) % 1 * 65536) % 65536;
        local v36 = u1.shift(p30, v35, p31[1], p31[v33]);

        if near(v36, p31, p32) then
            return v35, v36;
        end;

        local _ = i;
    end;

    return nil, nil;
end;

local function writeHeader(p37: any, p38: number, p39: number, p40: number, p41: number) -- Line: 147
    -- upvalues: Codec (copy)
    p37:u8(p38);
    Codec.varuint(p37, p39);
    Codec.varuint(p37, p40);
    p37:u8(p41);
end;

local function writeEnd(p42: any, p43: number, p44: table) -- Line: 154
    -- upvalues: ValueType (copy)
    if p43 ~= ValueType.ColorSequence then
        p42:f32(p44[2]);
        p42:f32(p44[3]);

        return;
    end;

    p42:u8(p44[2]);
    p42:u8(p44[3]);
    p42:u8(p44[4]);
end;

function u1.writeCopy(p45: any, p46: number, p47: number, p48: number, p49: number) -- Line: 165
    -- upvalues: Op (copy), Codec (copy)
    p45:u8(Op.SeqCopy);
    Codec.varuint(p45, p46);
    Codec.varuint(p45, p47);
    p45:u8(p48);
    Codec.varuint(p45, p49);
end;

function u1.writeShift(p50: any, p51: number, p52: number, p53: number, p54: number, p55: number, p56: table) -- Line: 170
    -- upvalues: Op (copy), Codec (copy), writeEnd (copy)
    p50:u8(Op.SeqShift);
    Codec.varuint(p50, p51);
    Codec.varuint(p50, p52);
    p50:u8(p53);
    p50:u16(p55);
    writeEnd(p50, p54, p56[1]);
    writeEnd(p50, p54, p56[#p56]);
end;

return table.freeze(u1);