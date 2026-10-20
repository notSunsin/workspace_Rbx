-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);

local function Derive(u1: any, p2: buffer) -- Line: 46
    local BlockSize = u1.BlockSize;

    if BlockSize < buffer.len(p2) then
        p2 = u1.DigestBuffer(p2);
    end;

    local buffer_create_ret = buffer.create(BlockSize);
    buffer.copy(buffer_create_ret, 0, p2);
    local buffer_create_ret2 = buffer.create(BlockSize);
    local buffer_create_ret3 = buffer.create(BlockSize);

    for i = 0, BlockSize - 1 do
        local buffer_readu8_ret = buffer.readu8(buffer_create_ret, i);
        local bit32_bxor_ret = bit32.bxor(buffer_readu8_ret, 92);
        buffer.writeu8(buffer_create_ret2, i, bit32_bxor_ret);
        local bit32_bxor_ret2 = bit32.bxor(buffer_readu8_ret, 54);
        buffer.writeu8(buffer_create_ret3, i, bit32_bxor_ret2);
        local _ = i;
    end;

    local function ComputeHmac(p3: buffer) -- Line: 69
        -- upvalues: BlockSize (copy), buffer_create_ret3 (copy), u1 (copy), buffer_create_ret2 (copy)
        local buffer_create_ret4 = buffer.create(BlockSize + buffer.len(p3));
        buffer.copy(buffer_create_ret4, 0, buffer_create_ret3);
        buffer.copy(buffer_create_ret4, BlockSize, p3);
        local v4 = u1.DigestBuffer(buffer_create_ret4);
        local buffer_create_ret5 = buffer.create(BlockSize + buffer.len(v4));
        buffer.copy(buffer_create_ret5, 0, buffer_create_ret2);
        buffer.copy(buffer_create_ret5, BlockSize, v4);

        return u1.DigestBuffer(buffer_create_ret5);
    end;

    return {
        Name = "HMAC-" .. u1.Name,
        BlockSize = u1.BlockSize,
        OutputSize = u1.OutputSize,

        Digest = function(p5) -- Line: 89, Name: Digest
            -- upvalues: ComputeHmac (copy)
            return buffer.tostring(ComputeHmac(buffer.fromstring(p5)));
        end,

        DigestBuffer = ComputeHmac,

        DigestToBuffer = function(p6) -- Line: 93, Name: DigestToBuffer
            -- upvalues: ComputeHmac (copy)
            return ComputeHmac(buffer.fromstring(p6));
        end
    };
end;

return {
    Derive = Derive,

    DeriveString = function(p7: any, p8: string) -- Line: 108, Name: DeriveString
        -- upvalues: Derive (copy)
        return Derive(p7, buffer.fromstring(p8));
    end
};