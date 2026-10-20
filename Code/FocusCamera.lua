-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");

return {
    _camera = workspace.CurrentCamera,
    _target = nil,
    _offset = Vector3.new(0, 0, 0),
    _connection = nil,
    _lerpSpeed = 10,

    Focus = function(u1: table, p2: userdata, p3: vector?) -- Line: 12, Name: Focus
        -- upvalues: RunService (copy)
        u1._target = p2;
        u1._offset = p3 or Vector3.new(0, 0, 0);

        if u1._connection then
            u1._connection:Disconnect();
        end;

        u1._connection = RunService.RenderStepped:Connect(function(p4) -- Line: 20
            -- upvalues: u1 (copy)
            if not u1._target then
                return;
            end;

            local _camera = u1._camera;
            local Position = _camera.CFrame.Position;
            local v5 = u1._target:GetPivot():PointToWorldSpace(u1._offset);
            local CFrame_new_ret = CFrame.new(Position, v5);
            _camera.CFrame = _camera.CFrame:Lerp(CFrame_new_ret, (math.clamp(p4 * u1._lerpSpeed, 0, 1)));
        end);
    end,

    Stop = function(p6) -- Line: 34, Name: Stop
        if p6._connection then
            p6._connection:Disconnect();
            p6._connection = nil;
        end;
    end
};