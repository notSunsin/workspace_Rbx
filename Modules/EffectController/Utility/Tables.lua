-- Decompiled with Potassium's decompiler.

local u1 = {};

function u1.CopyTable(p2: table) -- Line: 3
    -- upvalues: u1 (copy)
    local v3 = {};

    for i, v in p2 do
        local v4;

        if typeof(v) == "table" then
            v4 = u1.CopyTable(v) or v;
        else
            v4 = v;
        end;

        v3[i] = v4;
    end;

    return v3;
end;

function u1.Reconcile(p5: table, p6: table, p7: boolean?) -- Line: 13
    -- upvalues: u1 (copy)
    if p7 then
        p5 = u1.CopyTable(p5) or p5;
    end;

    for i, v in p6 do
        if not p5[i] then
            local v8;

            if typeof(v) == "table" then
                v8 = u1.CopyTable(v) or v;
            else
                v8 = v;
            end;

            p5[i] = v8;
        end;
    end;

    return p5;
end;

function u1.CacheDirectory(p9: userdata, p10: any) -- Line: 28
    -- upvalues: u1 (copy)
    local v11 = {};

    for _, child in p9:GetChildren() do
        local v12;

        if child:IsA("ModuleScript") then
            v12 = p10 and p10(child) or require(child);
        else
            v12 = nil;
        end;

        local Name = child.Name;

        if not (v12 and v12) then
            if child:IsA("Instance") or (child:IsA("Model") or child:IsA("Folder")) then
                v12 = u1.CacheDirectory(child, p10) or nil;
            else
                v12 = nil;
            end;
        end;

        v11[Name] = v12;
    end;

    return v11;
end;

function u1.DeepCopy(p13) -- Line: 43
    -- upvalues: u1 (copy)
    if type(p13) ~= "table" then
        return p13;
    end;

    local v14 = {};

    for i, v in next, p13 do
        v14[u1.DeepCopy(i)] = u1.DeepCopy(v);
    end;

    local DeepCopy = u1.DeepCopy;
    local v15 = getmetatable(p13);
    setmetatable(v14, DeepCopy(v15));

    return v14;
end;

function u1.DeepCopyRecursive(p16, p17) -- Line: 58
    -- upvalues: u1 (copy)
    local v18 = p17 or {};

    if type(p16) ~= "table" then
        return p16;
    end;

    if v18[p16] then
        return v18[p16];
    end;

    local v19 = {};
    v18[p16] = v19;

    for i, v in next, p16 do
        v19[u1.DeepCopyRecursive(i, v18)] = u1.DeepCopyRecursive(v, v18);
    end;

    local DeepCopyRecursive = u1.DeepCopyRecursive;
    local v20 = getmetatable(p16);
    setmetatable(v19, DeepCopyRecursive(v20, v18));

    return v19;
end;

return u1;