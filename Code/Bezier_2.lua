-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function B(p2: number, p3: number, p4: number)
    local function fact(p5: number) -- Line: 23
        -- upvalues: fact (copy)
        return p5 == 0 and 1 or p5 * fact(p5 - 1);
    end;

    local v6 = p2 == 0 and 1 or p2 * fact(p2 - 1);
    local v7 = p3 == 0 and 1 or p3 * fact(p3 - 1);
    local v8 = p2 - p3;

    return v6 / (v7 * (v8 == 0 and 1 or v8 * fact(v8 - 1))) * p4 ^ p3 * (1 - p4) ^ (p2 - p3);
end;

function u1.new(...) -- Line: 38
    -- upvalues: u1 (copy)
    local v9 = setmetatable({}, u1);
    v9.Points = {};
    v9.LengthIterations = 1000;
    v9.LengthIndeces = {};
    v9.Length = 0;
    v9._connections = {};

    for _, v in pairs({ ... }) do
        if typeof(v) == "Vector3" or typeof(v) == "Instance" and v:IsA("BasePart") then
            v9:AddBezierPoint(v);
        else
            error("The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!");
        end;
    end;

    return v9;
end;

function u1.AddBezierPoint(u10: table, p11: any, p12: number?) -- Line: 70
    if not (p11 and (typeof(p11) == "Instance" and p11:IsA("BasePart"))) and typeof(p11) ~= "Vector3" then
        error("Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!");

        return;
    end;

    local u13 = {
        Type = typeof(p11) == "Vector3" and "StaicPoint" or "BasePartPoint",
        Point = p11
    };

    if u13.Type == "BasePartPoint" then
        local u15 = p11.Changed:Connect(function(p14) -- Line: 84
            -- upvalues: u10 (copy)
            if p14 == "Position" then
                u10:UpdateLength();
            end;
        end);
        local v18 = p11.AncestryChanged:Connect(function(p16, p17) -- Line: 91
            -- upvalues: u10 (copy), u13 (copy), u15 (ref)
            if p17 == nil then
                local table_find_ret = table.find(u10.Points, u13);

                if table_find_ret then
                    table.remove(u10.Points, table_find_ret);
                end;

                u15:Disconnect();
                u15:Disconnect();
            end;
        end);

        if not u10._connections[p11] then
            u10._connections[p11] = {};
        end;

        table.insert(u10._connections[p11], u15);
        table.insert(u10._connections[p11], v18);
    end;

    if p12 and type(p12) == "number" then
        table.insert(u10.Points, p12, u13);
    elseif p12 then
        if type(p12) ~= "number" then
            error("Bezier:AddBezierPoint() only accepts an integer as the second argument!");
        end;
    else
        table.insert(u10.Points, u13);
    end;

    u10:UpdateLength();
end;

function u1.ChangeBezierPoint(p19: table, p20: number, p21: any) -- Line: 137
    if type(p20) ~= "number" then
        error("Bezier:ChangeBezierPoint() only accepts a number index as the first argument!");
    end;

    if not (p21 and (typeof(p21) == "Instance" and p21:IsA("BasePart"))) and typeof(p21) ~= "Vector3" then
        error("Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!");

        return;
    end;

    local v22 = p19.Points[p20];

    if not v22 then
        error("Did not find BezierPoint at index " .. tostring(p20));

        return;
    end;

    v22.Type = typeof(p21) == "Vector3" and "StaicPoint" or "BasePartPoint";
    v22.Point = p21;
    p19:UpdateLength();
end;

function u1.GetAllPoints(p23) -- Line: 171
    local v24 = {};

    for i = 1, #p23.Points do
        table.insert(v24, p23:GetPoint(i));
        local _ = i;
    end;

    return v24;
end;

function u1.GetPoint(p25: table, p26: number) -- Line: 189
    local Points = p25.Points;

    if Points[p26] then
        return typeof(Points[p26].Point) == "Vector3" and Points[p26].Point or Points[p26].Point.Position;
    end;

    error("Did not find a BezierPoint at index " .. tostring(p26) .. "!");
end;

function u1.RemoveBezierPoint(p27: table, p28: number) -- Line: 202
    if p27.Points[p28] then
        local table_remove_ret = table.remove(p27.Points, p28);

        if typeof(table_remove_ret.Point) == "Instance" and table_remove_ret.Point:IsA("BasePart") then
            for _, v in pairs(p27._connections[table_remove_ret.Point]) do
                if v.Connected then
                    v:Disconnect();
                end;
            end;

            p27._connections[table_remove_ret.Point] = nil;
        end;

        p27:UpdateLength();
    end;
end;

function u1.UpdateLength(p29) -- Line: 225
    local AllPoints = p29:GetAllPoints();
    local LengthIterations = p29.LengthIterations;

    if #AllPoints < 2 then
        return 0, { { 0, 0, 0 }, { 0, 0, 0 } };
    end;

    local v30 = 0;
    local v31 = {};

    for i = 1, LengthIterations do
        local v32 = p29:CalculateDerivativeAt((i - 1) / (LengthIterations - 1));
        v30 = v30 + v32.Magnitude * (1 / LengthIterations);
        table.insert(v31, { (i - 1) / (LengthIterations - 1), v30, v32 });
        local _ = i;
    end;

    p29.Length = v30;
    p29.LengthIndeces = v31;
end;

function u1.CalculatePositionAt(p33: table, p34: number) -- Line: 251
    if type(p34) ~= "number" then
        error("Bezier:CalculatePositionAt() only accepts a number, got " .. tostring(p34) .. "!");
    end;

    if #p33.Points > 0 then
        local AllPoints = p33:GetAllPoints();
        local v35 = #AllPoints;
        local Vector3_new_ret = Vector3.new();

        for i = 1, v35 do
            local v36 = AllPoints[i];
            Vector3_new_ret = Vector3_new_ret + B(v35 - 1, i - 1, p34) * v36;
            local _ = i;
        end;

        return Vector3_new_ret;
    end;

    error("Bezier:CalculatePositionAt() only works if there is at least 1 BezierPoint!");
end;

function u1.CalculatePositionRelativeToLength(p37: table, p38: number) -- Line: 291
    if type(p38) ~= "number" then
        error("Bezier:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(p38) .. "!");
    end;

    if #p37.Points <= 0 then
        error("Bezier:CalculatePositionRelativeToLength() only works if there is at least 1 BezierPoint!");

        return;
    end;

    local Length = p37.Length;
    local LengthIndeces = p37.LengthIndeces;
    local _ = p37.LengthIterations;

    if #p37:GetAllPoints() <= 1 then
        return p37:CalculatePositionAt(0);
    end;

    local v39 = Length * p38;
    local v40 = nil;
    local v41 = nil;

    for i, v in ipairs(LengthIndeces) do
        if v39 - v[2] <= 0 or i == #LengthIndeces then
            v41 = v;
            v40 = i;
            break;
        end;
    end;

    local v42, v43;

    if LengthIndeces[v40 - 1] then
        v42 = p37:CalculatePositionAt(LengthIndeces[v40 - 1][1]);
        v43 = p37:CalculatePositionAt(v41[1]);
    else
        v42 = p37:CalculatePositionAt(v41[1]);
        v43 = p37:CalculatePositionAt(LengthIndeces[v40 + 1][1]);
    end;

    return v42 + (v43 - v42) * (1 - (v41[2] - v39) / (v43 - v42).Magnitude);
end;

function u1.CalculateDerivativeAt(p44: table, p45: number) -- Line: 357
    if type(p45) ~= "number" then
        error("Bezier:CalculateDerivativeAt() only accepts a number, got " .. tostring(p45) .. "!");
    end;

    if #p44.Points > 1 then
        local AllPoints = p44:GetAllPoints();
        local v46 = #AllPoints;
        local _ = v46 - 1;
        local Vector3_new_ret = Vector3.new();

        for i = 1, v46 - 1 do
            local v47 = (v46 - 1) * (AllPoints[i + 1] - AllPoints[i]);
            Vector3_new_ret = Vector3_new_ret + B(v46 - 2, i - 1, p45) * v47;
            local _ = i;
        end;

        return Vector3_new_ret;
    end;

    error("Bezier:CalculateDerivativeAt() only works if there are at least 2 BezierPoints!");
end;

function u1.CalculateDerivativeRelativeToLength(p48: table, p49: number) -- Line: 400
    if type(p49) ~= "number" then
        error("Bezier:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(p49) .. "!");
    end;

    if #p48.Points <= 1 then
        error("Bezier:CalculateDerivativeRelativeToLength() only works if there are at least 2 BezierPoints!");

        return;
    end;

    local Length = p48.Length;
    local LengthIndeces = p48.LengthIndeces;
    local _ = p48.LengthIterations;
    p48:GetAllPoints();
    local v50 = Length * p49;
    local v51 = nil;
    local v52 = nil;

    for i, v in ipairs(LengthIndeces) do
        if v50 - v[2] <= 0 or i == #LengthIndeces then
            v52 = v;
            v51 = i;
            break;
        end;
    end;

    local v53, v54;

    if LengthIndeces[v51 - 1] then
        v53 = p48:CalculateDerivativeAt(LengthIndeces[v51 - 1][1]);
        v54 = p48:CalculateDerivativeAt(v52[1]);
    else
        v53 = p48:CalculateDerivativeAt(v52[1]);
        v54 = p48:CalculateDerivativeAt(LengthIndeces[v51 + 1][1]);
    end;

    return v53 + (v54 - v53) * (1 - (v52[2] - v50) / (v54 - v53).Magnitude);
end;

function u1.CreateVector3Tween(u55: table, u56: any, u57: table, p58: userdata, u59: boolean?) -- Line: 458
    if #u55.Points == 0 then
        error("Bezier:CreateVector3Tween() only works if there is at least 1 BezierPoint in the Bezier!");
    end;

    if typeof(u56) ~= "Instance" and typeof(u56) ~= "table" then
        error("Bezier:CreateVector3Tween() requires an Instance or a table as the first argument!");
    end;

    if typeof(p58) ~= "TweenInfo" then
        error("Bezier:CreateVector3Tween() requires a TweenInfo object as the third argument!");
    end;

    local success, result = pcall(function() -- Line: 476
        -- upvalues: u57 (copy), u56 (copy)
        for _, v in pairs(u57) do
            if typeof(u56[v]) ~= "Vector3" and typeof(u56[v]) ~= "nil" then
                return false;
            end;
        end;

        return true;
    end);

    if success and result then
        local TweenService = game:GetService("TweenService");
        local NumberValue = Instance.new("NumberValue");
        local u60 = TweenService:Create(NumberValue, p58, {
            Value = 1
        });
        local u61 = nil;
        u60.Changed:Connect(function(p62) -- Line: 493
            -- upvalues: u60 (copy), u61 (ref), NumberValue (copy), u57 (copy), u56 (copy), u59 (copy), u55 (copy)
            if p62 == "PlaybackState" then
                if u60.PlaybackState == Enum.PlaybackState.Playing then
                    u61 = NumberValue.Changed:Connect(function(p63) -- Line: 497
                        -- upvalues: u57 (ref), u56 (ref), u59 (ref), u55 (ref)
                        for _, v in pairs(u57) do
                            u56[v] = u59 and u55:CalculatePositionRelativeToLength(p63) or u55:CalculatePositionAt(p63);
                        end;
                    end);

                    return;
                end;

                if u61 then
                    u61:Disconnect();
                    u61 = nil;
                end;
            end;
        end);

        return u60;
    end;

    error("Bezier:CreateVector3Tween() requires a matching property table with Vector3 or nil property names for the object as the second argument!");
end;

function u1.CreateCFrameTween(u64: table, u65: any, u66: table, p67: userdata, u68: boolean?) -- Line: 519
    if #u64.Points <= 1 then
        error("Bezier:CreateVector3Tween() only works if there are at least 2 BezierPoints in the Bezier!");
    end;

    if typeof(u65) ~= "Instance" and typeof(u65) ~= "table" then
        error("Bezier:CreateCFrameTween() requires an Instance or a table as the first argument!");
    end;

    if typeof(p67) ~= "TweenInfo" then
        error("Bezier:CreateCFrameTween() requires a TweenInfo object as the third argument!");
    end;

    local success, result = pcall(function() -- Line: 537
        -- upvalues: u66 (copy), u65 (copy)
        for _, v in pairs(u66) do
            if typeof(u65[v]) ~= "CFrame" and typeof(u65[v]) ~= "nil" then
                return false;
            end;
        end;

        return true;
    end);

    if success and result then
        local TweenService = game:GetService("TweenService");
        local NumberValue = Instance.new("NumberValue");
        local u69 = TweenService:Create(NumberValue, p67, {
            Value = 1
        });
        local u70 = nil;
        u69.Changed:Connect(function(p71) -- Line: 554
            -- upvalues: u69 (copy), u70 (ref), NumberValue (copy), u66 (copy), u68 (copy), u64 (copy), u65 (copy)
            if p71 == "PlaybackState" then
                if u69.PlaybackState == Enum.PlaybackState.Playing then
                    u70 = NumberValue.Changed:Connect(function(p72) -- Line: 558
                        -- upvalues: u66 (ref), u68 (ref), u64 (ref), u65 (ref)
                        for _, v in pairs(u66) do
                            local v73 = u68 and u64:CalculatePositionRelativeToLength(p72) or u64:CalculatePositionAt(p72);
                            local v74 = u68 and u64:CalculateDerivativeRelativeToLength(p72) or u64:CalculateDerivativeAt(p72);
                            u65[v] = CFrame.new(v73, v73 + v74);
                        end;
                    end);

                    return;
                end;

                if u70 then
                    u70:Disconnect();
                    u70 = nil;
                end;
            end;
        end);

        return u69;
    end;

    error("Bezier:CreateCFrameTween() requires a matching property table with CFrame or nil property names for the object as the second argument!");
end;

return u1;