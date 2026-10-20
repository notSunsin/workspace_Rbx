-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 4
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);

return function(p1, p2) -- Line: 11, Name: GetMouseToWorld
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (ref)
    local MouseLocation = UserInputService:GetMouseLocation();
    local v3 = workspace_CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);

    return workspace:Raycast(v3.Origin, v3.Direction * (p2 or 1000), p1);
end;