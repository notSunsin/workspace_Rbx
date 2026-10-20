-- Decompiled with Potassium's decompiler.

local u5 = {
    resolve = function(p1, p2, p3) -- Line: 12, Name: resolve
        if p1 then
            p1 = p1:GetAttribute(p2);
        end;

        if typeof(p1) ~= "NumberRange" or p1.Min == 0 and p1.Max == 0 then
            local math_floor_ret = math.floor(p3 or 12);

            return math.max(1, math_floor_ret);
        end;

        local v4 = p1.Min + (p1.Max - p1.Min) * math.random();
        local math_floor_ret = math.floor(v4 + (v4 >= 0 and 0.5 or -0.5));

        if math_floor_ret ~= 0 then
            return math_floor_ret;
        end;

        local math_floor_ret2 = math.floor(p3 or 12);

        return math.max(1, math_floor_ret2);
    end
};

function u5.step(u6, u7, u8, u9, u10) -- Line: 25
    -- upvalues: u5 (copy)
    local math_abs_ret = math.abs(u7);

    local function reroll() -- Line: 27
        -- upvalues: u7 (ref), u5 (ref), u8 (copy), u9 (copy), u10 (copy), math_abs_ret (ref), u6 (ref)
        u7 = u5.resolve(u8, u9, u10);
        math_abs_ret = math.abs(u7);

        if u7 > 0 then
            u6 = 1;

            return;
        end;

        u6 = math_abs_ret;
    end;

    if math_abs_ret == 0 or u6 == 0 then
        u7 = u5.resolve(u8, u9, u10);
        math_abs_ret = math.abs(u7);

        if u7 > 0 then
            u6 = 1;
        else
            u6 = math_abs_ret;
        end;
    elseif u7 > 0 then
        u6 = u6 + 1;

        if math_abs_ret < u6 then
            u7 = u5.resolve(u8, u9, u10);
            math_abs_ret = math.abs(u7);

            if u7 > 0 then
                u6 = 1;
            else
                u6 = math_abs_ret;
            end;
        end;
    else
        u6 = u6 - 1;

        if u6 < 1 then
            u7 = u5.resolve(u8, u9, u10);
            math_abs_ret = math.abs(u7);

            if u7 > 0 then
                u6 = 1;
            else
                u6 = math_abs_ret;
            end;
        end;
    end;

    return u6, u7, math_abs_ret;
end;

function u5.evenFlags(p11) -- Line: 45
    if p11 then
        return (p11:GetAttribute("PosXEven") or (p11:GetAttribute("PosYEven") or p11:GetAttribute("PosZEven"))) == true, (p11:GetAttribute("RotXEven") or (p11:GetAttribute("RotYEven") or p11:GetAttribute("RotZEven"))) == true;
    end;

    return false, false;
end;

function u5.advance(p12, p13, p14, p15, p16, p17) -- Line: 58
    -- upvalues: u5 (copy)
    local v18 = p12[p13];

    if not v18 then
        v18 = { 0, 0, 0, 0 };
        p12[p13] = v18;
    end;

    local v19 = 0;
    local v20 = 0;
    local v21, v22;

    if p16 and u5.isSet(p14, "PositionEvenCycle") then
        local v23, v24;
        v23, v24, v21 = u5.step(v18[1], v18[2], p14, "PositionEvenCycle", p15);
        v18[1] = v23;
        v18[2] = v24;
        v22 = v18[1];
    else
        v22 = 0;
        v21 = 0;
    end;

    if p17 and u5.isSet(p14, "RotationEvenCycle") then
        local v25, v26;
        v25, v26, v20 = u5.step(v18[3], v18[4], p14, "RotationEvenCycle", p15);
        v18[3] = v25;
        v18[4] = v26;
        v19 = v18[3];
    end;

    return v22, v21, v19, v20;
end;

function u5.isSet(p27, p28) -- Line: 78
    if p27 then
        p27 = p27:GetAttribute(p28);
    end;

    local v29;

    if typeof(p27) == "NumberRange" then
        local v30;

        if p27.Min == 0 then
            v30 = p27.Max == 0;
        else
            v30 = false;
        end;

        v29 = not v30;
    else
        v29 = false;
    end;

    return v29;
end;

function u5.clear(p31, p32) -- Line: 84
    if p31 and p32 ~= nil then
        p31[p32] = nil;
    end;
end;

function u5.ensureIds(u33) -- Line: 94
    if u33:GetAttribute("_EvenCycleId") then
        return;
    end;

    local HttpService = game:GetService("HttpService");
    pcall(function() -- Line: 97
        -- upvalues: u33 (copy), HttpService (copy)
        u33:SetAttribute("_EvenCycleId", HttpService:GenerateGUID(false));
    end);
    local RenderTemplate = u33:FindFirstChild("RenderTemplate");

    if not RenderTemplate then
        return;
    end;

    for _, descendant in ipairs(RenderTemplate:GetDescendants()) do
        if descendant:GetAttribute("Transformed") and not descendant:GetAttribute("_EvenCycleId") then
            pcall(function() -- Line: 102
                -- upvalues: descendant (copy), HttpService (copy)
                descendant:SetAttribute("_EvenCycleId", HttpService:GenerateGUID(false));
            end);
        end;
    end;
end;

return u5;