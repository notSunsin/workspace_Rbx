-- Decompiled with Potassium's decompiler.

local u1 = {
    CONFIG_NAME = "PartIcleProperties",
    Types = require(script.TypeData).Types
};

function u1.getTypeFor(p2) -- Line: 26
    -- upvalues: u1 (copy)
    for i, v in pairs(u1.Types) do
        if v.classCheck(p2) then
            return v, i;
        end;
    end;

    return nil, nil;
end;

function u1.getTypeName(p3) -- Line: 35
    -- upvalues: u1 (copy)
    local _, v4 = u1.getTypeFor(p3);

    return v4;
end;

function u1.getConfig(p5) -- Line: 40
    -- upvalues: u1 (copy)
    return p5:FindFirstChild(u1.CONFIG_NAME);
end;

function u1.getAttrName(p6, p7) -- Line: 45
    local v8 = p6.properties[p7];

    if v8 and v8.attrName then
        return v8.attrName;
    end;

    return p7;
end;

function u1.read(u9, u10) -- Line: 54
    -- upvalues: u1 (copy)
    local TypeFor = u1.getTypeFor(u9);

    if not TypeFor then
        return nil;
    end;

    local u11 = TypeFor.properties[u10];

    if not u11 then
        return nil;
    end;

    if TypeFor.directAccess then
        if u11.attribute then
            local Attribute = u9:GetAttribute(u11.attrName or u10);

            if Attribute == nil then
                return u11.default;
            end;

            return Attribute;
        end;

        local success, result = pcall(function() -- Line: 68
            -- upvalues: u9 (copy), u10 (copy)
            return u9[u10];
        end);

        if success and result ~= nil then
            return result;
        end;

        return u11.default;
    end;

    local Config = u1.getConfig(u9);

    if not Config then
        return nil;
    end;

    local Attribute = Config:GetAttribute((u1.getAttrName(TypeFor, u10)));

    if Attribute == nil then
        return u11.default;
    end;

    if u11.type ~= "enum" or type(Attribute) ~= "string" then
        return Attribute;
    end;

    local success, result = pcall(function() -- Line: 83
        -- upvalues: u11 (copy), Attribute (copy)
        return Enum[u11.enumType][Attribute];
    end);

    return success and result and result or u11.default;
end;

local function _bumpPoolGen(p12) -- Line: 93
    local RenderTemplate = p12:FindFirstChild("RenderTemplate");

    if not RenderTemplate then
        return;
    end;

    local u13 = RenderTemplate:GetAttribute("_PoolGen") or 0;
    pcall(function() -- Line: 97
        -- upvalues: RenderTemplate (copy), u13 (copy)
        RenderTemplate:SetAttribute("_PoolGen", u13 + 1);
    end);
end;

function u1.bumpPoolGen(p14) -- Line: 102
    if not p14 then
        return;
    end;

    local RenderTemplate = p14:FindFirstChild("RenderTemplate");

    if not RenderTemplate then
        return;
    end;

    local u15 = RenderTemplate:GetAttribute("_PoolGen") or 0;
    pcall(function() -- Line: 97
        -- upvalues: RenderTemplate (copy), u15 (copy)
        RenderTemplate:SetAttribute("_PoolGen", u15 + 1);
    end);
end;

local function _clampNonNegativeSeq(p16) -- Line: 108
    if typeof(p16) ~= "NumberSequence" then
        return p16;
    end;

    local Keypoints = p16.Keypoints;
    local v17 = false;

    for _, v in ipairs(Keypoints) do
        if v.Value < 0 or v.Envelope > v.Value then
            v17 = true;
            break;
        end;
    end;

    if not v17 then
        return p16;
    end;

    local v18 = {};

    for _, v in ipairs(Keypoints) do
        local math_max_ret = math.max(0, v.Value);
        local math_min_ret = math.min(v.Envelope, math_max_ret);
        local math_max_ret2 = math.max(0, math_min_ret);
        table.insert(v18, NumberSequenceKeypoint.new(v.Time, math_max_ret, math_max_ret2));
    end;

    return NumberSequence.new(v18);
end;

local function _isInvalidNumber(p19) -- Line: 129
    local v20;

    if type(p19) == "number" then
        v20 = (p19 ~= p19 or p19 == (1 / 0)) and true or p19 == (-1 / 0);
    else
        v20 = false;
    end;

    return v20;
end;

local function _isInvalidValue(p21) -- Line: 132
    if type(p21) == "number" then
        local v22;

        if type(p21) == "number" then
            v22 = (p21 ~= p21 or p21 == (1 / 0)) and true or p21 == (-1 / 0);
        else
            v22 = false;
        end;

        return v22;
    end;

    if typeof(p21) == "NumberRange" then
        local Min = p21.Min;
        local v23;

        if type(Min) == "number" then
            v23 = (Min ~= Min or Min == (1 / 0)) and true or Min == (-1 / 0);
        else
            v23 = false;
        end;

        if not v23 then
            local Max = p21.Max;

            if type(Max) == "number" then
                v23 = (Max ~= Max or Max == (1 / 0)) and true or Max == (-1 / 0);
            else
                v23 = false;
            end;
        end;

        return v23;
    end;

    if typeof(p21) ~= "NumberSequence" then
        return false;
    end;

    for _, v in ipairs(p21.Keypoints) do
        local Time = v.Time;
        local v24;

        if type(Time) == "number" then
            v24 = (Time ~= Time or Time == (1 / 0)) and true or Time == (-1 / 0);
        else
            v24 = false;
        end;

        if v24 then
            return true;
        end;

        local Value = v.Value;
        local v25;

        if type(Value) == "number" then
            v25 = (Value ~= Value or Value == (1 / 0)) and true or Value == (-1 / 0);
        else
            v25 = false;
        end;

        if v25 then
            return true;
        end;

        local Envelope = v.Envelope;
        local v26;

        if type(Envelope) == "number" then
            v26 = (Envelope ~= Envelope or Envelope == (1 / 0)) and true or Envelope == (-1 / 0);
        else
            v26 = false;
        end;

        if v26 then
            return true;
        end;

        if v.Time < 0 or v.Time > 1 then
            return true;
        end;
    end;

    return false;
end;

function u1.write(u27, u28, u29) -- Line: 147
    -- upvalues: _isInvalidValue (copy), u1 (copy), _clampNonNegativeSeq (copy)
    if _isInvalidValue(u29) then
        warn("[Part-Icles] TypeRegistry.write rejected invalid value for " .. tostring(u28));

        return;
    end;

    local TypeFor = u1.getTypeFor(u27);

    if not TypeFor then
        return;
    end;

    local v30 = TypeFor.properties[u28];

    if not v30 then
        return;
    end;

    if TypeFor.directAccess then
        if v30.nonNegative then
            u29 = _clampNonNegativeSeq(u29);
        end;

        if v30.attribute then
            u27:SetAttribute(v30.attrName or u28, u29);
        else
            pcall(function() -- Line: 165
                -- upvalues: u27 (copy), u28 (copy), u29 (ref)
                u27[u28] = u29;
            end);
        end;

        local RenderTemplate = u27:FindFirstChild("RenderTemplate");

        if RenderTemplate then
            local u31 = RenderTemplate:GetAttribute("_PoolGen") or 0;
            pcall(function() -- Line: 97
                -- upvalues: RenderTemplate (copy), u31 (copy)
                RenderTemplate:SetAttribute("_PoolGen", u31 + 1);
            end);
        end;

        return;
    end;

    local Config = u1.getConfig(u27);

    if not Config then
        return;
    end;

    local AttrName = u1.getAttrName(TypeFor, u28);

    if v30.type == "enum" then
        if typeof(u29) == "EnumItem" then
            Config:SetAttribute(AttrName, u29.Name);
        else
            Config:SetAttribute(AttrName, (tostring(u29)));
        end;
    else
        if v30.nonNegative and typeof(u29) == "NumberSequence" then
            local Keypoints = u29.Keypoints;
            local v32 = false;

            for _, v in ipairs(Keypoints) do
                if v.Value < 0 or v.Envelope > v.Value then
                    v32 = true;
                    break;
                end;
            end;

            if v32 then
                local v33 = {};

                for _, v in ipairs(Keypoints) do
                    local math_max_ret = math.max(0, v.Value);
                    local math_min_ret = math.min(v.Envelope, math_max_ret);
                    local math_max_ret2 = math.max(0, math_min_ret);
                    table.insert(v33, NumberSequenceKeypoint.new(v.Time, math_max_ret, math_max_ret2));
                end;

                u29 = NumberSequence.new(v33);
            end;
        end;

        Config:SetAttribute(AttrName, u29);
    end;

    local RenderTemplate = u27:FindFirstChild("RenderTemplate");

    if RenderTemplate then
        local u34 = RenderTemplate:GetAttribute("_PoolGen") or 0;
        pcall(function() -- Line: 97
            -- upvalues: RenderTemplate (copy), u34 (copy)
            RenderTemplate:SetAttribute("_PoolGen", u34 + 1);
        end);
    end;
end;

function u1.readAll(p35) -- Line: 206
    -- upvalues: u1 (copy)
    local TypeFor = u1.getTypeFor(p35);

    if not TypeFor then
        return nil;
    end;

    local Config = u1.getConfig(p35);

    if not Config then
        return nil;
    end;

    local v36 = {};

    for i, v in pairs(TypeFor.properties) do
        local Attribute = Config:GetAttribute((u1.getAttrName(TypeFor, i)));

        if Attribute == nil then
            v36[i] = v.default;
        elseif v.type == "enum" and type(Attribute) == "string" then
            v36[i] = Enum[v.enumType][Attribute];
        else
            v36[i] = Attribute;
        end;
    end;

    return v36;
end;

function u1.writeDefaults(p37, p38) -- Line: 228
    for i, v in pairs(p38.properties) do
        local v39 = v.attrName or i;
        local default = v.default;

        if v.type == "enum" then
            p37:SetAttribute(v39, default.Name);
        else
            p37:SetAttribute(v39, default);
        end;
    end;
end;

function u1.createConfig(p40, p41) -- Line: 241
    -- upvalues: u1 (copy)
    local Configuration = Instance.new("Configuration");
    Configuration.Name = u1.CONFIG_NAME;
    u1.writeDefaults(Configuration, p41);
    Configuration.Parent = p40;

    return Configuration;
end;

function u1.isGraph(p42) -- Line: 249
    return p42.type == "NumberSequence" and true or p42.type == "ColorSequence";
end;

function u1.isNonNegative(p43) -- Line: 253
    return p43.nonNegative == true;
end;

function u1.getPropDef(p44, p45) -- Line: 257
    -- upvalues: u1 (copy)
    local v46 = u1.Types[p44];

    if v46 then
        return v46.properties[p45];
    end;

    return nil;
end;

function u1.getDefault(p47, p48) -- Line: 264
    -- upvalues: u1 (copy)
    local v49 = u1.Types[p47];

    if not v49 then
        return nil;
    end;

    local v50 = v49.properties[p48];

    if v50 then
        return v50.default;
    end;

    return nil;
end;

return u1;