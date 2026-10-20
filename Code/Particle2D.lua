-- Decompiled with Potassium's decompiler.

local u1 = {
    particleList = {}
};
game.Players.LocalPlayer:GetMouse();

local function ScaleToOffset(p2) -- Line: 18
    local ViewportSize = workspace.Camera.ViewportSize;

    return { ViewportSize.X * p2[1], ViewportSize.Y * p2[2] };
end;

local function OffsetX(p3) -- Line: 24
    return p3 / workspace.Camera.ViewportSize.X;
end;

local function OffsetY(p4) -- Line: 29
    return p4 / workspace.Camera.ViewportSize.Y;
end;

function u1.createParticle(p5, p6, p7, p8, p9, p10, p11, p12, p13, p14) -- Line: 34
    -- upvalues: u1 (copy)
    local UDim2_new_ret = UDim2.new(p9.X.Scale + p9.X.Offset / workspace.Camera.ViewportSize.X, 0, p9.Y.Scale + p9.Y.Offset / workspace.Camera.ViewportSize.Y, 0);
    local UDim2_new_ret2 = UDim2.new(p7.X.Scale + p7.X.Offset / workspace.Camera.ViewportSize.X, 0, p7.Y.Scale + p7.Y.Offset / workspace.Camera.ViewportSize.Y, 0);
    local v15 = {
        elapsedTime = 0,
        baseObject = p5,
        lifeSpan = p6,
        initVelocity = UDim2_new_ret2,
        workingVelocity = UDim2_new_ret2,
        rotVelocity = p8,
        acceleration = UDim2_new_ret,
        sizeChange = UDim2.new(p10.X.Scale + p10.X.Offset / workspace.Camera.ViewportSize.X, 0, p10.Y.Scale + p10.Y.Offset / workspace.Camera.ViewportSize.Y, 0),
        transparencyShift = p11,
        movementMode = p12,
        parentObject = p13,
        drag = p14 or 0
    };

    if p13 then
        p5.Parent = p13;
    end;

    local v16 = false;

    if #u1.particleList < 200 then
        table.insert(u1.particleList, v15);

        return #u1.particleList;
    end;

    for i, _ in ipairs(u1.particleList) do
        if not u1.particleList[i + 1] then
            v16 = i + 1;
        end;
    end;

    local v17 = v16 or 1;

    if v17 < 4 then
        u1.particleList[v17] = v15;

        return v17;
    end;

    if v15[1] then
        v15[1]:Destroy();
    end;
end;

function u1.updateParticle(p18) -- Line: 106
    -- upvalues: u1 (copy)
    for i, v in pairs(u1.particleList) do
        if v ~= nil then
            local v19 = 2 ^ (v.elapsedTime * -v.drag);
            v.workingVelocity = UDim2.new(v.workingVelocity.X.Scale * v19, v.workingVelocity.X.Offset * v19, v.workingVelocity.Y.Scale * v19, v.workingVelocity.Y.Offset * v19);
            v.baseObject.Position = v.baseObject.Position + UDim2.new(v.workingVelocity.X.Scale * p18, v.workingVelocity.X.Offset * p18, v.workingVelocity.Y.Scale * p18, v.workingVelocity.Y.Offset * p18);
            u1.particleList[i].workingVelocity = u1.particleList[i].workingVelocity + UDim2.new(v.acceleration.X.Scale * p18, v.acceleration.X.Offset * p18, v.acceleration.Y.Scale * p18, v.acceleration.Y.Offset * p18);

            if v.baseObject.AbsoluteSize.X > 0 or v.baseObject.AbsoluteSize.Y > 0 then
                v.baseObject.Size = v.baseObject.Size + UDim2.new(v.sizeChange.X.Scale * p18, v.sizeChange.X.Offset * p18, v.sizeChange.Y.Scale * p18, v.sizeChange.Y.Offset * p18);
            else
                v.baseObject.Size = UDim2.new(0, 0, 0, 0);
            end;

            v.baseObject.Rotation = v.baseObject.Rotation + v.rotVelocity * p18;
            v.baseObject.ImageTransparency = v.baseObject.ImageTransparency + v.transparencyShift * p18;

            if v.lifeSpan >= 0 then
                u1.particleList[i].lifeSpan = u1.particleList[i].lifeSpan - p18;
                local v20 = u1.particleList[i];
                v20.elapsedTime = v20.elapsedTime + p18;
            else
                v.baseObject:Destroy();
                u1.particleList[i] = nil;
            end;
        end;
    end;
end;

game:GetService("RunService").Heartbeat:Connect(u1.updateParticle);

return u1;