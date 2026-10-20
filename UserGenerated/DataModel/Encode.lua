-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {};
u2.__index = u2;

function v1.newWriter(p3: number?) -- Line: 34
    -- upvalues: u2 (copy)
    local v4 = p3 or 65536;
    local v5 = {
        len = 0,
        buf = buffer.create(v4),
        cap = v4
    };

    return setmetatable(v5, u2);
end;

function u2._ensure(p6: table, p7: number) -- Line: 43
    local v8 = p6.len + p7;

    if p6.cap < v8 then
        local v9 = p6.cap * 2;

        while v9 < v8 do
            v9 = v9 * 2;
        end;

        local buffer_create_ret = buffer.create(v9);
        buffer.copy(buffer_create_ret, 0, p6.buf, 0, p6.len);
        p6.buf = buffer_create_ret;
        p6.cap = v9;
    end;
end;

function u2.u8(p10: table, p11: number) -- Line: 57
    p10:_ensure(1);
    buffer.writeu8(p10.buf, p10.len, p11);
    p10.len = p10.len + 1;
end;

function u2.u16(p12: table, p13: number) -- Line: 63
    p12:_ensure(2);
    buffer.writeu16(p12.buf, p12.len, p13);
    p12.len = p12.len + 2;
end;

function u2.u32(p14: table, p15: number) -- Line: 69
    p14:_ensure(4);
    buffer.writeu32(p14.buf, p14.len, p15);
    p14.len = p14.len + 4;
end;

function u2.f32(p16: table, p17: number) -- Line: 75
    p16:_ensure(4);
    buffer.writef32(p16.buf, p16.len, p17);
    p16.len = p16.len + 4;
end;

function u2.f64(p18: table, p19: number) -- Line: 81
    p18:_ensure(8);
    buffer.writef64(p18.buf, p18.len, p19);
    p18.len = p18.len + 8;
end;

function u2.strU8(p20: table, p21: string) -- Line: 88
    local v22 = #p21;
    p20:_ensure(v22 + 1);
    buffer.writeu8(p20.buf, p20.len, v22);
    p20.len = p20.len + 1;

    if v22 > 0 then
        buffer.writestring(p20.buf, p20.len, p21);
        p20.len = p20.len + v22;
    end;
end;

function u2.strU16(p23: table, p24: string) -- Line: 100
    local v25 = #p24;

    if v25 > 65535 then
        p24 = string.sub(p24, 1, 65535);
        v25 = 65535;
    end;

    p23:_ensure(v25 + 2);
    buffer.writeu16(p23.buf, p23.len, v25);
    p23.len = p23.len + 2;

    if v25 > 0 then
        buffer.writestring(p23.buf, p23.len, p24);
        p23.len = p23.len + v25;
    end;
end;

function u2.str32(p26: table, p27: string) -- Line: 116
    local v28 = #p27;
    p26:_ensure(v28 + 4);
    buffer.writeu32(p26.buf, p26.len, v28);
    p26.len = p26.len + 4;

    if v28 > 0 then
        buffer.writestring(p26.buf, p26.len, p27);
        p26.len = p26.len + v28;
    end;
end;

function u2.patchU16(p29: table, p30: number, p31: number) -- Line: 127
    buffer.writeu16(p29.buf, p30, p31);
end;

function u2.finish(p32) -- Line: 131
    local buffer_create_ret = buffer.create(p32.len);
    buffer.copy(buffer_create_ret, 0, p32.buf, 0, p32.len);

    return buffer_create_ret;
end;

function v1.writeValue(p33, p34) -- Line: 140
    if p34 == nil then
        p33:u8(0);

        return;
    end;

    local v35 = typeof(p34);

    if v35 == "boolean" then
        p33:u8(p34 and 2 or 1);

        return;
    end;

    if v35 == "number" then
        p33:u8(3);
        p33:f64(p34);

        return;
    end;

    if v35 == "string" then
        p33:u8(4);
        p33:str32(p34);

        return;
    end;

    if v35 == "EnumItem" then
        p33:u8(5);
        p33:str32((tostring(p34)));

        return;
    end;

    if v35 == "Vector2" then
        p33:u8(6);
        p33:f32(p34.X);
        p33:f32(p34.Y);

        return;
    end;

    if v35 == "Vector3" then
        p33:u8(7);
        p33:f32(p34.X);
        p33:f32(p34.Y);
        p33:f32(p34.Z);

        return;
    end;

    if v35 == "Color3" then
        p33:u8(8);
        local math_floor_ret = math.floor(p34.R * 255 + 0.5);
        p33:u8((math.clamp(math_floor_ret, 0, 255)));
        local math_floor_ret2 = math.floor(p34.G * 255 + 0.5);
        p33:u8((math.clamp(math_floor_ret2, 0, 255)));
        local math_floor_ret3 = math.floor(p34.B * 255 + 0.5);
        p33:u8((math.clamp(math_floor_ret3, 0, 255)));

        return;
    end;

    if v35 ~= "CFrame" then
        p33:u8(10);
        p33:str32((tostring(p34)));

        return;
    end;

    p33:u8(9);
    local Components, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46 = p34:GetComponents();
    p33:f32(Components);
    p33:f32(v36);
    p33:f32(v37);
    p33:f32(v38);
    p33:f32(v39);
    p33:f32(v40);
    p33:f32(v41);
    p33:f32(v42);
    p33:f32(v43);
    p33:f32(v44);
    p33:f32(v45);
    p33:f32(v46);
end;

return v1;