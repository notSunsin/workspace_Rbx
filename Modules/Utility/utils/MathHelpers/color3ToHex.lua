-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 1, Name: color3ToHex
    local math_floor_ret = math.floor(p1.R * 255);
    local math_floor_ret2 = math.floor(p1.G * 255);
    local math_floor_ret3 = math.floor(p1.B * 255);

    return string.format("#%02X%02X%02X", math_floor_ret, math_floor_ret2, math_floor_ret3);
end;