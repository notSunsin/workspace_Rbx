-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {
    ["nil"] = "StringValue",
    boolean = "BoolValue",
    BrickColor = "BrickColorValue",
    CFrame = "CFrameValue",
    Color3 = "Color3Value",
    number = "NumberValue",
    Instance = "ObjectValue",
    Ray = "RayValue",
    string = "StringValue",
    Vector3 = "Vector3Value"
};

function v1.GetClassFromType(p3: string) -- Line: 19
    -- upvalues: u2 (copy)
    return u2[p3];
end;

function v1.ConvertTypeToClass(p4: string) -- Line: 23
    -- upvalues: u2 (copy)
    return Instance.new(u2[p4]);
end;

return v1;