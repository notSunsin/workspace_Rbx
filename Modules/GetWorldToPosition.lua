-- Decompiled with Potassium's decompiler.

local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 3
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);

return function(p1) -- Line: 7, Name: GetWorldToPosition
    -- upvalues: workspace_CurrentCamera (ref)
    if p1 then
        local v2, v3 = workspace_CurrentCamera:WorldToScreenPoint(p1);

        return UDim2.fromOffset(v2.X, v2.Y), v3;
    end;
end;