-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
local u1 = { 3411693828, 3411693832, 3411693838, 3411693830, 3411693836, 3411693829, 3411693837, 3411693840, 3411693834, 3411693839 };

return {
    GetAllIds = function() -- Line: 36, Name: GetAllIds
        -- upvalues: u1 (copy)
        return u1;
    end,

    GetSkipAllId = function(p2: number) -- Line: 32, Name: SkipAll
        -- upvalues: u1 (copy)
        local math_ceil_ret = math.ceil(p2 / 5);

        return u1[math.clamp(math_ceil_ret, 1, #u1)];
    end,

    GetSkipTierId = DevProductIds.SkipSeasonPassTier
};