-- Decompiled with Potassium's decompiler.

local AES = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.AES);
local Base64 = require(game.ReplicatedStorage.UserGenerated.IO.Base64);
local HMAC = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.HMAC);
local ISAAC = require(game.ReplicatedStorage.UserGenerated.Randoms.ISAAC);
local SHA256 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.SHA256);
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local u1 = ISAAC.Unique();

local function GetRandomBytes(p2: number) -- Line: 44
    -- upvalues: u1 (copy)
    local buffer_create_ret = buffer.create(p2);

    for i = 0, p2 - 1 do
        local v3 = u1:NextInteger(0, 255);
        buffer.writeu8(buffer_create_ret, i, v3);
        local _ = i;
    end;

    return buffer_create_ret;
end;

local function PBKDF2(p4: buffer, p5: buffer, p6: number, p7: number, p8: any) -- Line: 62
    -- upvalues: HMAC (copy)
    local v9 = HMAC.Derive(p8, p4);
    local OutputSize = p8.OutputSize;
    local math_ceil_ret = math.ceil(p6 / OutputSize);
    local buffer_create_ret = buffer.create(p6);
    local v10 = 0;

    for i = 1, math_ceil_ret do
        local buffer_create_ret2 = buffer.create(buffer.len(p5) + 4);
        buffer.copy(buffer_create_ret2, 0, p5);
        local buffer_len_ret = buffer.len(p5);
        local bit32_byteswap_ret = bit32.byteswap(i);
        buffer.writeu32(buffer_create_ret2, buffer_len_ret, bit32_byteswap_ret);
        local v11 = v9.DigestBuffer(buffer_create_ret2);
        local buffer_create_ret3 = buffer.create(buffer.len(v11));
        buffer.copy(buffer_create_ret3, 0, v11);
        local _ = i;

        for i2 = 2, p7 do
            v11 = v9.DigestBuffer(v11);
            local _ = i2;

            for i3 = 0, buffer.len(v11) - 1 do
                local buffer_readu8_ret = buffer.readu8(buffer_create_ret3, i3);
                local buffer_readu8_ret2 = buffer.readu8(v11, i3);
                local bit32_bxor_ret = bit32.bxor(buffer_readu8_ret, buffer_readu8_ret2);
                buffer.writeu8(buffer_create_ret3, i3, bit32_bxor_ret);
                local _ = i3;
            end;
        end;

        local math_min_ret = math.min(OutputSize, p6 - v10);
        buffer.copy(buffer_create_ret, v10, buffer_create_ret3, 0, math_min_ret);
        v10 = v10 + math_min_ret;
    end;

    return buffer_create_ret;
end;

local function ApplyPKCS7Padding(p12: buffer) -- Line: 109
    local buffer_len_ret = buffer.len(p12);
    local v13 = 16 - buffer_len_ret % 16;
    local v14 = buffer_len_ret + v13;
    local buffer_create_ret = buffer.create(v14);
    buffer.copy(buffer_create_ret, 0, p12);

    for i = buffer_len_ret, v14 - 1 do
        buffer.writeu8(buffer_create_ret, i, v13);
        local _ = i;
    end;

    return buffer_create_ret;
end;

local function RemovePKCS7Padding(p15: buffer) -- Line: 131
    local buffer_len_ret = buffer.len(p15);

    if buffer_len_ret == 0 then
        error("Invalid padding: empty input");
    end;

    local buffer_readu8_ret = buffer.readu8(p15, buffer_len_ret - 1);

    if buffer_readu8_ret < 1 or buffer_readu8_ret > 16 then
        error("Invalid padding length: " .. buffer_readu8_ret);
    end;

    for i = buffer_len_ret - buffer_readu8_ret, buffer_len_ret - 1 do
        local v16;

        if buffer.readu8(p15, i) == buffer_readu8_ret then
            v16 = i;
        else
            error("Invalid padding");
            v16 = i;
        end;
    end;

    local v17 = buffer_len_ret - buffer_readu8_ret;
    local buffer_create_ret = buffer.create(v17);
    buffer.copy(buffer_create_ret, 0, p15, 0, v17);

    return buffer_create_ret;
end;

local function Encrypt(p18: string, p19: buffer, p20: any) -- Line: 166
    -- upvalues: SHA256 (copy), GetRandomBytes (copy), PBKDF2 (copy), ApplyPKCS7Padding (copy), AES (copy), Base64 (copy)
    local buffer_fromstring_ret = buffer.fromstring(p18);
    local v21 = GetRandomBytes(8);
    local v22 = PBKDF2(p19, v21, 48, 10000, p20 or SHA256);
    local buffer_create_ret = buffer.create(32);
    buffer.copy(buffer_create_ret, 0, v22, 0, 32);
    local buffer_create_ret2 = buffer.create(16);
    buffer.copy(buffer_create_ret2, 0, v22, 32, 16);
    local v23 = ApplyPKCS7Padding(buffer_fromstring_ret);
    local v24 = AES.new(buffer.tostring(buffer_create_ret), AES.modes.CBC, AES.pads.None):Encrypt(v23, nil, buffer_create_ret2);
    local v25 = 16 + buffer.len(v24);
    local buffer_create_ret3 = buffer.create(v25);
    buffer.writestring(buffer_create_ret3, 0, "Salted__");
    buffer.copy(buffer_create_ret3, 8, v21);
    buffer.copy(buffer_create_ret3, 16, v24);

    return buffer.tostring(Base64.EncodeBuffer(buffer_create_ret3));
end;

local function Decrypt(p26: string, p27: buffer, p28: any) -- Line: 220
    -- upvalues: SHA256 (copy), Base64 (copy), PBKDF2 (copy), AES (copy), RemovePKCS7Padding (copy)
    local v29 = Base64.DecodeBuffer(buffer.fromstring(p26));

    if buffer.len(v29) < 16 then
        error("Invalid data: too short");
    end;

    local buffer_create_ret = buffer.create(8);
    buffer.copy(buffer_create_ret, 0, v29, 0, 8);

    if buffer.tostring(buffer_create_ret) ~= "Salted__" then
        error("Invalid data: Missing \'Salted__\' header");
    end;

    local buffer_create_ret2 = buffer.create(8);
    buffer.copy(buffer_create_ret2, 0, v29, 8, 8);
    local v30 = buffer.len(v29) - 16;
    local buffer_create_ret3 = buffer.create(v30);
    buffer.copy(buffer_create_ret3, 0, v29, 16, v30);
    local v31 = PBKDF2(p27, buffer_create_ret2, 48, 10000, p28 or SHA256);
    local buffer_create_ret4 = buffer.create(32);
    buffer.copy(buffer_create_ret4, 0, v31, 0, 32);
    local buffer_create_ret5 = buffer.create(16);
    buffer.copy(buffer_create_ret5, 0, v31, 32, 16);
    local v32 = RemovePKCS7Padding((AES.new(buffer.tostring(buffer_create_ret4), AES.modes.CBC, AES.pads.None):Decrypt(buffer_create_ret3, nil, buffer_create_ret5)));

    return buffer.tostring(v32);
end;

local v39 = {
    Encrypt = Encrypt,
    Decrypt = Decrypt,

    EncryptString = function(p33: string, p34: string, p35: any) -- Line: 281, Name: EncryptString
        -- upvalues: Encrypt (copy)
        return Encrypt(p33, buffer.fromstring(p34), p35);
    end,

    DecryptString = function(p36: string, p37: string, p38: any) -- Line: 294, Name: DecryptString
        -- upvalues: Decrypt (copy)
        return Decrypt(p36, buffer.fromstring(p37), p38);
    end,

    PBKDF2 = PBKDF2,
    GetRandomBytes = GetRandomBytes
};
table.freeze(v39);

return v39;