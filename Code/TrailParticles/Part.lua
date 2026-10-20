-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 5
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.CFrame = CFrame.new();
    v3.Att0 = p2.Att0:Clone();
    v3.Att1 = p2.Att1:Clone();
    v3.Trails = {};
    v3.Att0Pos = v3.Att0.Position;
    v3.Att1Pos = v3.Att1.Position;
    v3.TrailWidth = (p2.Position - v3.Att0Pos).Magnitude + (p2.Position - v3.Att1Pos).Magnitude;
    v3.Att0.Parent = workspace.Terrain;
    v3.Att1.Parent = workspace.Terrain;

    for _, child in ipairs(p2:GetChildren()) do
        if child:IsA("Trail") then
            local v4 = child:Clone();
            v4.Attachment0 = v3.Att0;
            v4.Attachment1 = v3.Att1;
            v4.Parent = workspace.Terrain;
            table.insert(v3.Trails, v4);
        end;
    end;

    return v3;
end;

function u1.UpdateCFrame(p5: table, p6) -- Line: 37
    p5.CFrame = p6;
    p5:Update();
end;

function u1.Update(p7) -- Line: 42
    p7.Att0.WorldPosition = (p7.CFrame * CFrame.new(p7.Att0Pos)).Position;
    p7.Att1.WorldPosition = (p7.CFrame * CFrame.new(p7.Att1Pos)).Position;
end;

function u1.Destroy(p8) -- Line: 50
    p8.Att0:Destroy();
    p8.Att1:Destroy();

    for _, v in ipairs(p8.Trails) do
        v:Destroy();
    end;

    table.clear(p8.Trails);
end;

setmetatable(u1, {
    __index = function(p9, p10) -- Line: 62, Name: __index
        error(string.format("%q is not a valid member of %q", tostring(p10), script.Name), 2);
    end
});

return u1;