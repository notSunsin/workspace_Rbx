-- Decompiled with Potassium's decompiler.

game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 6
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);

return function(p1, p2) -- Line: 10, Name: GetMouseToWorld
    -- upvalues: GuiService (copy), workspace_CurrentCamera (ref)
    local GuiInset = GuiService:GetGuiInset();
    local v3 = workspace_CurrentCamera:ScreenPointToRay(p1.X + GuiInset.X, p1.Y - GuiInset.Y);

    return workspace:Raycast(v3.Origin, v3.Direction * (p2 or 1000), RaycastParams);
end;