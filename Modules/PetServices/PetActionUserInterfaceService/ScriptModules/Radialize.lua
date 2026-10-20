-- Decompiled with Potassium's decompiler.

return function(p1: userdata) -- Line: 1, Name: Radialize
    local v2 = workspace.CurrentCamera.ViewportSize.X * 0.05;
    local v3 = {};

    for _, child in p1:GetChildren() do
        if child:IsA("Frame") then
            table.insert(v3, child);
        end;
    end;

    table.sort(v3, function(p4, p5) -- Line: 16
        return p4.AbsoluteSize.X * p4.AbsoluteSize.Y < p5.AbsoluteSize.X * p5.AbsoluteSize.Y;
    end);
    local v6 = #v3;
    local v7 = 6.283185307179586 / v6;
    local v8 = 0.5 + (v6 == 3 and 0.1 or 0);
    local v9 = v2 + v6 * 5;

    for i, v in v3 do
        local v10 = -1.5707963267948966 + (i - 1) * v7;
        local v11 = math.cos(v10) * v9;
        local v12 = math.sin(v10) * v9;
        v.AnchorPoint = Vector2.new(0.5, 0.5);
        v.Position = UDim2.new(0.5, v11, v8, v12);
    end;
end;