-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 23
    function p1._seedTsOverride(p2, p3) -- Line: 26
        if not p3 then
            return;
        end;

        p2._tsOverride = p3:GetAttribute("_tsOverride");
        p2._tsOverrideUntil = p3:GetAttribute("_tsOverrideUntil");
    end;

    local function _setNativePE(u4, u5, p6, p7) -- Line: 33
        if u4:GetAttribute("_origTimeScale") == nil then
            pcall(function() -- Line: 35
                -- upvalues: u4 (copy)
                u4:SetAttribute("_origTimeScale", u4.TimeScale);
            end);
        end;

        pcall(function() -- Line: 37
            -- upvalues: u4 (copy), u5 (copy)
            u4.TimeScale = u5;
        end);
        local u8 = (u4:GetAttribute("_tsGen") or 0) + 1;
        pcall(function() -- Line: 40
            -- upvalues: u4 (copy), u8 (copy)
            u4:SetAttribute("_tsGen", u8);
        end);

        if p7 == true then
            return;
        end;

        task.delay(p6, function() -- Line: 42
            -- upvalues: u4 (copy), u8 (copy)
            if not u4.Parent then
                return;
            end;

            if u4:GetAttribute("_tsGen") ~= u8 then
                return;
            end;

            local Attribute = u4:GetAttribute("_origTimeScale");

            if Attribute ~= nil then
                pcall(function() -- Line: 47
                    -- upvalues: u4 (ref), Attribute (copy)
                    u4.TimeScale = Attribute;
                end);
                pcall(function() -- Line: 48
                    -- upvalues: u4 (ref)
                    u4:SetAttribute("_origTimeScale", nil);
                end);
            end;

            pcall(function() -- Line: 50
                -- upvalues: u4 (ref)
                u4:SetAttribute("_tsGen", nil);
            end);
        end);
    end;

    local function _clearNativePE(u9) -- Line: 54
        local Attribute = u9:GetAttribute("_origTimeScale");

        if Attribute ~= nil then
            pcall(function() -- Line: 57
                -- upvalues: u9 (copy), Attribute (copy)
                u9.TimeScale = Attribute;
            end);
            pcall(function() -- Line: 58
                -- upvalues: u9 (copy)
                u9:SetAttribute("_origTimeScale", nil);
            end);
        end;

        local u10 = (u9:GetAttribute("_tsGen") or 0) + 1;
        pcall(function() -- Line: 62
            -- upvalues: u9 (copy), u10 (copy)
            u9:SetAttribute("_tsGen", u10);
        end);
        pcall(function() -- Line: 63
            -- upvalues: u9 (copy)
            u9:SetAttribute("_tsGen", nil);
        end);
    end;

    function p1.SetTimescale(p11, u12, u13, p14, p15) -- Line: 68
        -- upvalues: _setNativePE (copy)
        if not u12 then
            return;
        end;

        if typeof(u13) ~= "number" then
            return;
        end;

        if p15 == true then
            p14 = nil;
        elseif typeof(p14) ~= "number" or p14 <= 0 then
            p11:ClearTimescale(u12);

            return;
        end;

        if u12:IsA("ParticleEmitter") then
            _setNativePE(u12, u13, p14, p15);

            return;
        end;

        local u16 = p15 == true and (1 / 0) or os.clock() + p14;
        pcall(function() -- Line: 85
            -- upvalues: u12 (copy), u13 (copy), u16 (copy)
            u12:SetAttribute("_tsOverride", u13);
            u12:SetAttribute("_tsOverrideUntil", u16);
        end);
        local ActiveEmits = p11.ActiveEmits;

        for i = 1, #ActiveEmits do
            local v17 = ActiveEmits[i];
            local v18;

            if v17 and v17._sourceItem == u12 then
                v17._tsOverride = u13;
                v17._tsOverrideUntil = u16;
                v18 = i;
            else
                v18 = i;
            end;
        end;
    end;

    function p1.ClearTimescale(p19, u20) -- Line: 101
        -- upvalues: _clearNativePE (copy)
        if not u20 then
            return;
        end;

        if u20:IsA("ParticleEmitter") then
            _clearNativePE(u20);

            return;
        end;

        pcall(function() -- Line: 107
            -- upvalues: u20 (copy)
            u20:SetAttribute("_tsOverride", nil);
            u20:SetAttribute("_tsOverrideUntil", nil);
        end);
        local ActiveEmits = p19.ActiveEmits;

        for i = 1, #ActiveEmits do
            local v21 = ActiveEmits[i];
            local v22;

            if v21 and v21._sourceItem == u20 then
                v21._tsOverride = nil;
                v21._tsOverrideUntil = nil;
                v22 = i;
            else
                v22 = i;
            end;
        end;
    end;

    function p1.AbsoluteSetTimescale(p23, p24, p25, p26, p27) -- Line: 122
        if not p24 then
            return;
        end;

        if p24:GetAttribute("Transformed") then
            p23:SetTimescale(p24, p25, p26, p27);

            return;
        end;

        if p24:IsA("ParticleEmitter") then
            p23:SetTimescale(p24, p25, p26, p27);

            return;
        end;

        for _, child in p24:GetChildren() do
            if not (p24:IsA("BasePart") and (child:IsA("BasePart") and not child:GetAttribute("Transformed"))) then
                p23:AbsoluteSetTimescale(child, p25, p26, p27);
            end;
        end;
    end;

    function p1.AbsoluteClearTimescale(p28, p29) -- Line: 141
        if not p29 then
            return;
        end;

        if p29:GetAttribute("Transformed") then
            p28:ClearTimescale(p29);

            return;
        end;

        if p29:IsA("ParticleEmitter") then
            p28:ClearTimescale(p29);

            return;
        end;

        for _, child in p29:GetChildren() do
            if not (p29:IsA("BasePart") and (child:IsA("BasePart") and not child:GetAttribute("Transformed"))) then
                p28:AbsoluteClearTimescale(child);
            end;
        end;
    end;
end;