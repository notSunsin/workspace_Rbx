-- Decompiled with Potassium's decompiler.

return function(u1: userdata) -- Line: 20, Name: EmitOnce
    local TimeScale = u1.TimeScale;

    if TimeScale <= 0 then
        return 0;
    end;

    local Rate = u1.Rate;
    local Attribute = u1:GetAttribute("EmitCount");

    if type(Attribute) ~= "number" then
        Attribute = Rate;
    end;

    local math_floor_ret = math.floor(Attribute);
    local v2 = Attribute - math_floor_ret;

    if v2 > 0 and math.random() < v2 then
        math_floor_ret = math_floor_ret + 1;
    end;

    if math_floor_ret < 1 then
        return 0;
    end;

    local Attribute2 = u1:GetAttribute("EmitDelay");
    local v3 = type(Attribute2) ~= "number" and 0 or Attribute2;

    if v3 == (1 / 0) then
        return 0;
    end;

    local math_max_ret = math.max(v3, 0);
    task.delay(math_max_ret, function() -- Line: 51
        -- upvalues: u1 (copy), math_floor_ret (ref)
        u1:Emit(math_floor_ret);
    end);

    return math_max_ret + u1.Lifetime.Max / TimeScale;
end;