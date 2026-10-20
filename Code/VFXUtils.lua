-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");

return {
    defaultFadeTime = 1,
    defaultEasingStyle = Enum.EasingStyle.Linear,
    defaultEasingDirection = Enum.EasingDirection.Out,

    _createTransparentNumberSequence = function(p1: table, p2: userdata) -- Line: 20, Name: _createTransparentNumberSequence
        local v3 = {};

        for _, v in p2.Keypoints do
            table.insert(v3, NumberSequenceKeypoint.new(v.Time, 1, v.Envelope));
        end;

        return NumberSequence.new(v3);
    end,

    _interpolateNumberSequence = function(p4: table, p5: userdata, p6: number) -- Line: 29, Name: _interpolateNumberSequence
        local v7 = {};

        for _, v in p5.Keypoints do
            table.insert(v7, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * p6, v.Envelope));
        end;

        return NumberSequence.new(v7);
    end,

    _setNumberSequenceTransparency = function(p8: table, p9: userdata, p10: number) -- Line: 39, Name: _setNumberSequenceTransparency
        local v11 = {};

        for _, v in p9.Keypoints do
            table.insert(v11, NumberSequenceKeypoint.new(v.Time, p10, v.Envelope));
        end;

        return NumberSequence.new(v11);
    end,

    _interpolateNumberSequenceToTarget = function(p12: table, p13: userdata, p14: number, p15: number) -- Line: 48, Name: _interpolateNumberSequenceToTarget
        local v16 = {};

        for _, v in p13.Keypoints do
            local Value = v.Value;
            table.insert(v16, NumberSequenceKeypoint.new(v.Time, Value + (p14 - Value) * p15, v.Envelope));
        end;

        return NumberSequence.new(v16);
    end,

    GetDescendantTransparency = function(p17: table, p18: userdata) -- Line: 61, Name: GetDescendantTransparency
        local Descendants = p18:GetDescendants();
        table.insert(Descendants, p18);
        local v19 = { "Transparency", "TextTransparency", "TextStrokeTransparency", "BackgroundTransparency", "ImageTransparency", "ScrollBarImageTransparency" };
        local v20 = {};

        for _, v in Descendants do
            local u21 = v;
            local v22 = {};

            for _, v2 in v19 do
                local success, result = pcall(function() -- Line: 79
                    -- upvalues: u21 (copy), v2 (copy)
                    return u21[v2];
                end);

                if success and result ~= nil then
                    v22[v2] = result;
                end;
            end;

            if next(v22) then
                v20[u21] = v22;
            end;
        end;

        return v20;
    end,

    SetDescendantTransparency = function(u23: table, p24: userdata, p25: any, u26: number?, u27: function?, p28: any, p29: any) -- Line: 96, Name: SetDescendantTransparency
        -- upvalues: TweenService (copy), RunService (copy)
        local Descendants = p24:GetDescendants();
        table.insert(Descendants, p24);
        local v30 = { "Transparency", "TextTransparency", "TextStrokeTransparency", "BackgroundTransparency", "ImageTransparency", "ScrollBarImageTransparency" };

        if u26 and u26 > 0 then
            local u31 = p28 or u23.defaultEasingStyle;
            local u32 = p29 or u23.defaultEasingDirection;
            local TweenInfo_new_ret = TweenInfo.new(u26, u31, u32);
            local v33 = {};
            local u34 = {};

            if typeof(p25) == "number" then
                for _, v in Descendants do
                    local u35 = v;

                    for _, v2 in v30 do
                        local success, result = pcall(function() -- Line: 128
                            -- upvalues: u35 (copy), v2 (copy)
                            return u35[v2];
                        end);

                        if success and result ~= nil then
                            if typeof(result) == "number" then
                                local v36 = TweenService:Create(u35, TweenInfo_new_ret, {
                                    [v2] = p25
                                });
                                table.insert(v33, v36);
                                v36:Play();
                            elseif typeof(result) == "NumberSequence" then
                                local v37 = {
                                    object = u35,
                                    property = v2,
                                    startSequence = result,
                                    targetTransparency = p25,
                                    startTime = os.clock()
                                };
                                table.insert(u34, v37);
                            end;
                        end;
                    end;
                end;
            elseif typeof(p25) == "table" then
                for i, v in p25 do
                    if i and i.Parent then
                        if typeof(v) == "number" then
                            local success, result = pcall(function() -- Line: 162
                                -- upvalues: i (copy)
                                return i.Transparency;
                            end);

                            if success and result ~= nil then
                                if typeof(result) == "number" then
                                    local v38 = TweenService:Create(i, TweenInfo_new_ret, {
                                        Transparency = v
                                    });
                                    table.insert(v33, v38);
                                    v38:Play();
                                elseif typeof(result) == "NumberSequence" then
                                    local v39 = {
                                        property = "Transparency",
                                        object = i,
                                        startSequence = result,
                                        targetSequence = v,
                                        startTime = os.clock()
                                    };
                                    table.insert(u34, v39);
                                end;
                            end;
                        elseif typeof(v) == "NumberSequence" then
                            local success, result = pcall(function() -- Line: 186
                                -- upvalues: i (copy)
                                return i.Transparency;
                            end);

                            if success then
                                local v40 = {
                                    property = "Transparency",
                                    object = i,
                                    startSequence = result,
                                    targetSequence = v,
                                    startTime = os.clock()
                                };
                                table.insert(u34, v40);
                            end;
                        elseif typeof(v) == "table" then
                            local u41 = i;

                            for i2, v2 in v do
                                local success, result = pcall(function() -- Line: 201
                                    -- upvalues: u41 (copy), i2 (copy)
                                    return u41[i2];
                                end);

                                if success and result ~= nil then
                                    if typeof(v2) == "number" and typeof(result) == "number" then
                                        local v42 = TweenService:Create(u41, TweenInfo_new_ret, {
                                            [i2] = v2
                                        });
                                        table.insert(v33, v42);
                                        v42:Play();
                                    elseif typeof(result) == "NumberSequence" then
                                        if typeof(v2) == "number" then
                                            local v43 = {
                                                object = u41,
                                                property = i2,
                                                startSequence = result,
                                                targetTransparency = v2,
                                                startTime = os.clock()
                                            };
                                            table.insert(u34, v43);
                                        elseif typeof(v2) == "NumberSequence" then
                                            local v44 = {
                                                object = u41,
                                                property = i2,
                                                startSequence = result,
                                                targetSequence = v2,
                                                startTime = os.clock()
                                            };
                                            table.insert(u34, v44);
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            if #u34 > 0 then
                local u45 = nil;
                u45 = RunService.Heartbeat:Connect(function() -- Line: 242
                    -- upvalues: u34 (copy), u26 (copy), TweenService (ref), u31 (ref), u32 (ref), u23 (copy), u45 (ref)
                    local os_clock_ret = os.clock();
                    local v46 = true;

                    for i = #u34, 1, -1 do
                        local v47 = u34[i];
                        local math_min_ret = math.min((os_clock_ret - v47.startTime) / u26, 1);
                        local Value = TweenService:GetValue(math_min_ret, u31, u32);
                        local v48;

                        if v47.targetTransparency then
                            v47.object[v47.property] = u23:_interpolateNumberSequenceToTarget(v47.startSequence, v47.targetTransparency, Value);
                            v48 = i;
                        elseif v47.targetSequence then
                            local Keypoints = v47.targetSequence.Keypoints;
                            v48 = i;
                            local v49 = {};

                            for i2, v in v47.startSequence.Keypoints do
                                if Keypoints[i2] then
                                    table.insert(v49, NumberSequenceKeypoint.new(v.Time, v.Value + (Keypoints[i2].Value - v.Value) * Value, v.Envelope));
                                end;
                            end;

                            v47.object[v47.property] = NumberSequence.new(v49);
                        else
                            v48 = i;
                        end;

                        if math_min_ret >= 1 then
                            table.remove(u34, v48);
                        else
                            v46 = false;
                        end;
                    end;

                    if v46 then
                        u45:Disconnect();
                    end;
                end);
            end;

            if u27 then
                task.spawn(function() -- Line: 295
                    -- upvalues: u26 (copy), u27 (copy)
                    task.wait(u26);
                    u27();
                end);
            end;

            return v33;
        end;

        if typeof(p25) == "number" then
            for _, v in Descendants do
                local u50 = v;

                for _, v2 in v30 do
                    local success, result = pcall(function() -- Line: 308
                        -- upvalues: u50 (copy), v2 (copy)
                        return u50[v2];
                    end);

                    if success and result ~= nil then
                        if typeof(result) == "number" then
                            u50[v2] = p25;
                        elseif typeof(result) == "NumberSequence" then
                            u50[v2] = u23:_setNumberSequenceTransparency(result, p25);
                        end;
                    end;
                end;
            end;
        elseif typeof(p25) == "table" then
            for i, v in p25 do
                if i and i.Parent then
                    if typeof(v) == "number" or typeof(v) == "NumberSequence" then
                        pcall(function() -- Line: 326
                            -- upvalues: i (copy), v (copy)
                            i.Transparency = v;
                        end);
                    elseif typeof(v) == "table" then
                        local u51 = i;

                        for i2, v2 in v do
                            pcall(function() -- Line: 347
                                -- upvalues: u51 (copy), i2 (copy), v2 (copy)
                                u51[i2] = v2;
                            end);
                        end;
                    end;
                end;
            end;
        end;

        if u27 then
            u27();
        end;
    end,

    GetRGBfromColor3 = function(p52: table, p53) -- Line: 362, Name: GetRGBfromColor3
        return {
            R = math.floor(p53.R * 255),
            G = math.floor(p53.G * 255),
            B = math.floor(p53.B * 255)
        };
    end
};