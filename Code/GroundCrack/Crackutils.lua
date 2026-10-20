-- Decompiled with Potassium's decompiler.

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

return {
    CastToMouseCFrame = function(p1: number?, p2: userdata) -- Line: 10, Name: CastToMouseCFrame
        -- upvalues: workspace_CurrentCamera (copy), Mouse (copy)
        local v3 = workspace_CurrentCamera:ScreenPointToRay(Mouse.X, Mouse.Y);
        local v4 = workspace:Raycast(v3.Origin, v3.Direction * (p1 or 1000), p2);

        if v4 then
            return CFrame.new(v4.Position, v4.Position + v4.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        end;

        print("Raycast failed");

        return Mouse.Hit;
    end,

    CastToCharacterGroundPosition = function(p5: number?) -- Line: 22, Name: CastToCharacterGroundPosition
        -- upvalues: LocalPlayer (copy)
        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
            RaycastParams_new_ret.FilterDescendantsInstances = { Character };
            local v6 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -(p5 or 10), 0), RaycastParams_new_ret);

            if v6 then
                return CFrame.new(v6.Position, v6.Position + v6.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
            end;

            print("Raycast failed");

            return HumanoidRootPart.CFrame;
        end;
    end
};