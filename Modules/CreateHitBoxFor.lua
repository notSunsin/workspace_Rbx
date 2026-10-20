-- Decompiled with Potassium's decompiler.

local u1 = {
    Properties = {
        Name = "HitBox",
        CanCollide = false,
        CanQuery = true,
        Transparency = 1,
        Anchored = true,
        Color = Color3.fromRGB(255, 0, 0)
    },
    Tags = { "CosmeticHitBox" }
};
local Name = u1.Properties.Name;

local function CreateExactBoundingBox(p2: userdata) -- Line: 17
    -- upvalues: Name (copy)
    if not p2:IsA("Model") then
        warn("Expected a Model, got:", p2);

        return;
    end;

    local v3 = Vector3.new(1, 1, 1) * (1 / 0);
    local v4 = -v3;
    local v5 = 0;
    local Descendants = p2:GetDescendants();

    if #Descendants == 0 then
        return;
    end;

    for _, v in Descendants do
        if v:IsA("BasePart") and v.Name ~= Name then
            local CFrame2 = v.CFrame;
            local Size = v.Size;
            local v6 = Size.X / 2;
            local v7 = Size.Y / 2;
            local v8 = Size.Z / 2;
            local v9 = -v6;
            local v10 = -v7;
            local v11 = -v8;

            for _, v2 in {
                CFrame2 * Vector3.new(v9, v10, v11),
                CFrame2 * Vector3.new(v6, v10, v11),
                CFrame2 * Vector3.new(v9, v7, v11),
                CFrame2 * Vector3.new(v6, v7, v11),
                CFrame2 * Vector3.new(v9, v10, v8),
                CFrame2 * Vector3.new(v6, v10, v8),
                CFrame2 * Vector3.new(v9, v7, v8),
                CFrame2 * Vector3.new(v6, v7, v8)
            } do
                local math_min_ret = math.min(v3.X, v2.X);
                local math_min_ret2 = math.min(v3.Y, v2.Y);
                local math_min_ret3 = math.min(v3.Z, v2.Z);
                v3 = Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
                local math_max_ret = math.max(v4.X, v2.X);
                local math_max_ret2 = math.max(v4.Y, v2.Y);
                local math_max_ret3 = math.max(v4.Z, v2.Z);
                v4 = Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
            end;

            v5 = v5 + 1;
        end;
    end;

    if v5 ~= 0 then
        return v3, v4;
    end;
end;

return function(p12: userdata) -- Line: 73, Name: AssignHitBox
    -- upvalues: CreateExactBoundingBox (copy), Name (copy), u1 (copy)
    if not p12:IsA("Model") then
        warn("Expected a Model, got:", p12);

        return;
    end;

    local v13 = p12:FindFirstChild("HitBox") or p12:FindFirstChild("Hitbox");
    local v14, v15 = CreateExactBoundingBox(p12);

    if v14 then
        local v16 = v13 or Instance.new("Part");
        v16.Name = Name;
        v16.Size = v15 - v14;
        v16.CFrame = CFrame.new((v14 + v15) / 2);

        for i, v in u1.Properties do
            v16[i] = v;
        end;

        for _, v in u1.Tags do
            v16:AddTag(v);
        end;

        v16.Parent = p12;
        p12.PrimaryPart = v16;

        return v16;
    end;

    warn("No valid parts found in model:", p12.Name);
end;