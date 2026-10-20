-- Decompiled with Potassium's decompiler.

return {
    secondsToHHMMSS = function(p1) -- Line: 3, Name: secondsToHHMMSS
        local v2 = p1 // 60;
        local v3 = v2 // 60;
        local v4 = string.format("%02i", v2 - v3 * 60) .. ":" .. string.format("%02i", p1 - v2 * 60);

        return string.format("%02i", v3) .. ":" .. v4;
    end,

    secondsToMMSS = function(p5) -- Line: 13, Name: secondsToMMSS
        local v6 = p5 // 60;

        return string.format("%02i", v6) .. ":" .. string.format("%02i", p5 - v6 * 60);
    end,

    secondsToXhXmXs = function(p7) -- Line: 21, Name: secondsToXhXmXs
        local math_floor_ret = math.floor(p7);
        local v8 = math_floor_ret // 3600;
        local v9 = math_floor_ret % 3600 // 60;
        local v10 = math_floor_ret % 60;

        if v8 > 0 then
            return string.format("%dh %dm %ds", v8, v9, v10);
        end;

        if v9 > 0 then
            return string.format("%dm %ds", v9, v10);
        end;

        return v10 .. "s";
    end
};