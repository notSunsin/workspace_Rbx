-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ConfigRegistry = require(ReplicatedStorage.Data.ConfigRegistry);
local v1 = {};
local u2 = {};

local function DeepMergeDefaults(p3, p4) -- Line: 15
    -- upvalues: DeepMergeDefaults (copy)
    if typeof(p3) ~= "table" or typeof(p4) ~= "table" then
        return p3;
    end;

    if p3[1] ~= nil or p4[1] ~= nil then
        return p3;
    end;

    for i, v in p4 do
        local v5 = p3[i];

        if v5 == nil then
            p3[i] = v;
        elseif typeof(v5) == "table" and typeof(v) == "table" then
            DeepMergeDefaults(v5, v);
        end;
    end;

    return p3;
end;

function v1.GetConfig(p6: table, p7: userdata) -- Line: 33
    -- upvalues: ConfigRegistry (copy), u2 (copy), HttpService (copy), DeepMergeDefaults (copy)
    local Attribute = workspace:GetAttribute(p7);

    if not Attribute then
        return ConfigRegistry[p7];
    end;

    if typeof(Attribute) == "string" then
        local v8 = u2[p7];

        if v8 and v8.Raw == Attribute then
            return v8.Value;
        end;

        local success, result = pcall(function() -- Line: 46
            -- upvalues: HttpService (ref), Attribute (copy)
            return HttpService:JSONDecode(Attribute);
        end);

        if success then
            local v9 = ConfigRegistry[p7];

            if typeof(result) == "table" and typeof(v9) == "table" then
                DeepMergeDefaults(result, v9);
            end;

            u2[p7] = {
                Raw = Attribute,
                Value = result
            };

            return result;
        end;
    end;

    return Attribute;
end;

return v1;