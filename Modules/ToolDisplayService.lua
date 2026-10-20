-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
game:GetService("Players");
local v1 = {};

local function CloneVisualsFromTool(p2: userdata) -- Line: 6
    local Model = Instance.new("Model");

    for _, descendant in p2:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("MeshPart") or descendant:IsA("UnionOperation")) then
            local v3 = descendant:Clone();

            for _, child in ipairs(v3:GetChildren()) do
                if not (child:IsA("BasePart") or (child:IsA("MeshPart") or child:IsA("UnionOperation"))) then
                    child:Destroy();
                end;
            end;

            v3.Anchored = true;
            v3.CanCollide = false;
            v3.CanTouch = false;
            v3.CanQuery = false;
            v3.Parent = Model;
        end;
    end;

    return Model;
end;

function v1.DisplayToolModel(p4: table, p5: userdata, p6) -- Line: 30
    -- upvalues: CloneVisualsFromTool (copy)
    local v7;

    if p5 then
        v7 = p5:IsA("Tool");
    else
        v7 = p5;
    end;

    assert(v7, "Invalid Tool");
    local v8 = typeof(p6) == "CFrame";
    assert(v8, "Invalid Position");
    local v9 = `Display_{p5.Name}_{tick()}`;
    local v10 = CloneVisualsFromTool(p5);
    v10.Name = v9;
    local v11 = v10:FindFirstChild("Handle") or v10:FindFirstChildWhichIsA("BasePart");

    if not v11 then
        v10:Destroy();

        return;
    end;

    v10.PrimaryPart = v11;
    local _, v12 = v10:GetBoundingBox();
    v10:SetPrimaryPartCFrame(p6 + Vector3.new(0, v12.Y / 2 + 0.2, 0));
end;

function v1.PreviewCloneModel(p13: table, p14: userdata) -- Line: 52
    -- upvalues: CloneVisualsFromTool (copy)
    if p14 and p14:IsA("Tool") then
        local v15 = CloneVisualsFromTool(p14);

        if #v15:GetChildren() == 0 then
            v15:Destroy();

            return nil;
        end;

        v15.Parent = workspace;

        return v15;
    end;
end;

return v1;