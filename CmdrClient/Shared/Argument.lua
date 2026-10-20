-- Decompiled with Potassium's decompiler.

local Util = require(script.Parent.Util);

local function unescapeOperators(p1) -- Line: 3
    for _, v in ipairs({ "%.", "%?", "%*", "%*%*" }) do
        p1 = p1:gsub("\\" .. v, v:gsub("%%", ""));
    end;

    return p1;
end;

local u2 = {};
u2.__index = u2;

function u2.new(p3, p4, p5) -- Line: 15
    -- upvalues: Util (copy), u2 (copy)
    local v6 = {
        Type = nil,
        Prefix = "",
        TextSegmentInProgress = "",
        RawSegmentsAreAutocomplete = false,
        Command = p3,
        Name = p4.Name,
        Object = p4
    };
    local v7;

    if p4.Default == nil then
        v7 = p4.Optional ~= true;
    else
        v7 = false;
    end;

    v6.Required = v7;
    v6.Executor = p3.Executor;
    v6.RawValue = p5;
    v6.RawSegments = {};
    v6.TransformedValues = {};

    if type(p4.Type) == "table" then
        v6.Type = p4.Type;
    else
        local v8, v9, v10 = Util.ParsePrefixedUnionType(p3.Cmdr.Registry:GetTypeName(p4.Type), p5);
        v6.Type = p3.Dispatcher.Registry:GetType(v8);
        v6.RawValue = v9;
        v6.Prefix = v10;

        if v6.Type == nil then
            error(string.format("%s has an unregistered type %q", v6.Name or "<none>", v8 or "<none>"));
        end;
    end;

    setmetatable(v6, u2);
    v6:Transform();

    return v6;
end;

function u2.GetDefaultAutocomplete(p11) -- Line: 55
    if not p11.Type.Autocomplete then
        return {};
    end;

    local v12, v13 = p11.Type.Autocomplete(p11:TransformSegment(""));

    return v12, v13 or {};
end;

function u2.Transform(p14) -- Line: 67
    -- upvalues: unescapeOperators (copy), Util (copy)
    if #p14.TransformedValues ~= 0 then
        return;
    end;

    local RawValue = p14.RawValue;

    if p14.Type.ArgumentOperatorAliases then
        RawValue = p14.Type.ArgumentOperatorAliases[RawValue] or RawValue;
    end;

    if RawValue == "." and p14.Type.Default then
        RawValue = p14.Type.Default(p14.Executor) or "";
        p14.RawSegmentsAreAutocomplete = true;
    end;

    if RawValue == "?" and p14.Type.Autocomplete then
        local DefaultAutocomplete, v15 = p14:GetDefaultAutocomplete();

        if not v15.IsPartial and #DefaultAutocomplete > 0 then
            RawValue = DefaultAutocomplete[math.random(1, #DefaultAutocomplete)];
            p14.RawSegmentsAreAutocomplete = true;
        end;
    end;

    if not p14.Type.Listable or #p14.RawValue <= 0 then
        local v16 = unescapeOperators(RawValue);
        p14.RawSegments[1] = unescapeOperators(v16);
        p14.TransformedValues[1] = { p14:TransformSegment(v16) };
        p14.TextSegmentInProgress = p14.RawValue;

        return;
    end;

    local v17 = RawValue:match("^%?(%d+)$");

    if v17 then
        local v18 = tonumber(v17);

        if v18 and v18 > 0 then
            local v19 = {};
            local DefaultAutocomplete, v20 = p14:GetDefaultAutocomplete();

            if not v20.IsPartial and #DefaultAutocomplete > 0 then
                for i = 1, math.min(v18, #DefaultAutocomplete) do
                    table.insert(v19, table.remove(DefaultAutocomplete, math.random(1, #DefaultAutocomplete)));
                    local _ = i;
                end;

                RawValue = table.concat(v19, ",");
                p14.RawSegmentsAreAutocomplete = true;
            end;
        end;
    elseif RawValue == "*" or RawValue == "**" then
        local DefaultAutocomplete, v21 = p14:GetDefaultAutocomplete();

        if not v21.IsPartial and #DefaultAutocomplete > 0 then
            if RawValue == "**" and p14.Type.Default then
                local v22 = p14.Type.Default(p14.Executor) or "";

                for i, v in ipairs(DefaultAutocomplete) do
                    if v == v22 then
                        table.remove(DefaultAutocomplete, i);
                    end;
                end;
            end;

            RawValue = table.concat(DefaultAutocomplete, ",");
            p14.RawSegmentsAreAutocomplete = true;
        end;
    end;

    local v23 = unescapeOperators(RawValue);
    local v24 = Util.SplitStringSimple(v23, ",");
    local v25 = #v24 == 0 and { "" } or v24;

    if v23:sub(#v23, #v23) == "," then
        v25[#v25 + 1] = "";
    end;

    for i, v in ipairs(v25) do
        p14.RawSegments[i] = v;
        p14.TransformedValues[i] = { p14:TransformSegment(v) };
    end;

    p14.TextSegmentInProgress = v25[#v25];
end;

function u2.TransformSegment(p26, p27) -- Line: 159
    if p26.Type.Transform then
        return p26.Type.Transform(p27, p26.Executor);
    end;

    return p27;
end;

function u2.GetTransformedValue(p28, p29) -- Line: 168
    return unpack(p28.TransformedValues[p29]);
end;

function u2.Validate(p30, p31) -- Line: 173
    if p30.RawValue == nil or #p30.RawValue == 0 and p30.Required == false then
        return true;
    end;

    if p30.Required and (p30.RawSegments[1] == nil or #p30.RawSegments[1] == 0) then
        return false, "This argument is required.";
    end;

    if not (p30.Type.Validate or p30.Type.ValidateOnce) then
        return true;
    end;

    for i = 1, #p30.TransformedValues do
        if p30.Type.Validate then
            local v32, v33 = p30.Type.Validate(p30:GetTransformedValue(i));

            if not v32 then
                return v32, v33 or "Invalid value";
            end;
        end;

        local v34;

        if p31 and p30.Type.ValidateOnce then
            local v35, v36 = p30.Type.ValidateOnce(p30:GetTransformedValue(i));

            if not v35 then
                return v35, v36;
            end;

            v34 = i;
        else
            v34 = i;
        end;
    end;

    return true;
end;

function u2.GetAutocomplete(p37) -- Line: 208
    return not p37.Type.Autocomplete and {} or p37.Type.Autocomplete(p37:GetTransformedValue(#p37.TransformedValues));
end;

function u2.ParseValue(p38, p39) -- Line: 216
    if p38.Type.Parse then
        return p38.Type.Parse(p38:GetTransformedValue(p39));
    end;

    return p38:GetTransformedValue(p39);
end;

function u2.GetValue(p40) -- Line: 225
    if #p40.RawValue == 0 and (not p40.Required and p40.Object.Default ~= nil) then
        return p40.Object.Default;
    end;

    if not p40.Type.Listable then
        return p40:ParseValue(1);
    end;

    local v41 = {};

    for i = 1, #p40.TransformedValues do
        local v42 = p40:ParseValue(i);

        if type(v42) ~= "table" then
            error(("Listable types must return a table from Parse (%s)"):format(p40.Type.Name));
        end;

        local _ = i;

        for _, v in pairs(v42) do
            v41[v] = true;
        end;
    end;

    local v43 = {};

    for i in pairs(v41) do
        v43[#v43 + 1] = i;
    end;

    return v43;
end;

return u2;