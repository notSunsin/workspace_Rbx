-- Decompiled with Potassium's decompiler.

local v1 = {};
local u23 = {
    Disable = function(p2) -- Line: 35, Name: Disable
        local engine = p2.engine;
        local token = p2.token;
        token.Alive = false;

        for _, v in ipairs(token.Loops) do
            pcall(task.cancel, v);
        end;

        token.Loops = {};
        local ActiveEmits = engine.ActiveEmits;

        for i = #ActiveEmits, 1, -1 do
            local v3 = ActiveEmits[i];
            local v4;

            if v3 and v3._playToken == token then
                if v3.VisualPart and v3.VisualPart.Parent then
                    engine:_releaseOrDestroy(v3, v3.VisualPart);
                end;

                if v3._scaleMapKeys and engine._parentScaleMap then
                    v4 = i;

                    for _, v in ipairs(v3._scaleMapKeys) do
                        engine._parentScaleMap[v] = nil;
                    end;
                else
                    v4 = i;
                end;

                local v5 = #ActiveEmits;

                if v4 < v5 then
                    ActiveEmits[v4] = ActiveEmits[v5];
                end;

                ActiveEmits[v5] = nil;
            else
                v4 = i;
            end;
        end;

        for _, v in ipairs(token.Clones) do
            if v and v.Parent then
                pcall(function() -- Line: 61
                    -- upvalues: v (copy)
                    v:Destroy();
                end);
            end;
        end;

        token.Clones = {};
    end,

    SoftDisable = function(p6) -- Line: 68, Name: SoftDisable
        local token = p6.token;
        token.Alive = false;

        for _, v in ipairs(token.Loops) do
            pcall(task.cancel, v);
        end;

        token.Loops = {};
    end,

    SetTimescale = function(p7, p8, p9, p10) -- Line: 79, Name: SetTimescale
        if typeof(p8) ~= "number" then
            return;
        end;

        local engine = p7.engine;
        local token = p7.token;
        local v11;

        if p10 == true then
            v11 = (1 / 0);
        elseif typeof(p9) == "number" and p9 > 0 then
            v11 = os.clock() + p9;
        else
            token.TsOverride = nil;
            token.TsUntil = nil;
            v11 = nil;
        end;

        if v11 == nil or not p8 then
            p8 = nil;
        end;

        token.TsOverride = p8;
        token.TsUntil = v11;
        local ActiveEmits = engine.ActiveEmits;

        for i = 1, #ActiveEmits do
            local v12 = ActiveEmits[i];
            local v13;

            if v12 and v12._playToken == token then
                v12._tsOverride = token.TsOverride;
                v12._tsOverrideUntil = v11;
                v13 = i;
            else
                v13 = i;
            end;
        end;
    end,

    GetParticles = function(p14) -- Line: 106, Name: GetParticles
        local ActiveEmits = p14.engine.ActiveEmits;
        local v15 = {};

        for i = 1, #ActiveEmits do
            local v16 = ActiveEmits[i];
            local v17;

            if v16 and (v16._playToken == p14.token and v16.VisualPart) then
                v15[#v15 + 1] = v16.VisualPart;
                v17 = i;
            else
                v17 = i;
            end;
        end;

        return v15;
    end,

    GetPDatas = function(p18) -- Line: 122, Name: GetPDatas
        local ActiveEmits = p18.engine.ActiveEmits;
        local v19 = {};

        for i = 1, #ActiveEmits do
            local v20 = ActiveEmits[i];
            local v21;

            if v20 and v20._playToken == p18.token then
                v19[#v19 + 1] = v20;
                v21 = i;
            else
                v21 = i;
            end;
        end;

        return v19;
    end,

    IsAlive = function(p22) -- Line: 135, Name: IsAlive
        local ActiveEmits = p22.engine.ActiveEmits;

        for i = 1, #ActiveEmits do
            if ActiveEmits[i] and ActiveEmits[i]._playToken == p22.token then
                return true;
            end;

            local _ = i;
        end;

        for _, v in ipairs(p22.token.Loops) do
            if coroutine.status(v) ~= "dead" then
                return true;
            end;
        end;

        return false;
    end
};
local u26 = {
    __index = function(p24, p25) -- Line: 148
        -- upvalues: u23 (copy)
        if p25 == "Active" then
            return u23.IsAlive(p24);
        end;

        return u23[p25];
    end
};

function v1.new(p27, p28) -- Line: 153
    -- upvalues: u26 (copy)
    return setmetatable({
        engine = p27,
        token = p28,
        Duration = p28.Duration
    }, u26);
end;

return v1;