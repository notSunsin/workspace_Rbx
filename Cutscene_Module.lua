-- Decompiled with Potassium's decompiler.

local v1 = {};
local TweenService = game:GetService("TweenService");

function v1.Start_Cutscene(p2) -- Line: 5
    local CurrentCamera = game.Workspace.CurrentCamera;
    local v3 = nil;

    for _, child in pairs(game.Workspace.Farm:GetChildren()) do
        if child.Important.Data.Owner == p2.Name then
            v3 = child;
        end;
    end;

    if v3 then
        CurrentCamera.CameraSubject = v3.Cutscene_Model.Orbit_Camera;
        CurrentCamera.CameraType = Enum.CameraType.Fixed;
    end;
end;

function v1.End_Cutscene(p4) -- Line: 19
    local CurrentCamera = game.Workspace.CurrentCamera;
    CurrentCamera.CameraSubject = p4.Character.Humanoid;
    CurrentCamera.CameraType = Enum.CameraType.Fixed;
end;

local Field_Of_View_Module = require(game.ReplicatedStorage.Field_Of_View_Module);

function v1.Flash(p5: number) -- Line: 27
    -- upvalues: TweenService (copy), Field_Of_View_Module (copy)
    local TweenInfo_new_ret = TweenInfo.new(p5, Enum.EasingStyle.Cubic);
    local TweenInfo_new_ret2 = TweenInfo.new(p5 * 4, Enum.EasingStyle.Quad);
    local Frame = game:GetService("Players").LocalPlayer.PlayerGui.Rejoin_UI.Frame;
    TweenService:Create(Frame, TweenInfo_new_ret, {
        BackgroundTransparency = 0
    }):Play();
    Field_Of_View_Module.Change_FOV(90, TweenInfo_new_ret.Time);
    task.delay(TweenInfo_new_ret.Time + 1.5, function() -- Line: 35
        -- upvalues: Field_Of_View_Module (ref), TweenInfo_new_ret2 (copy), TweenService (ref), Frame (copy)
        Field_Of_View_Module.Change_FOV(70, TweenInfo_new_ret2.Time / 2);
        TweenService:Create(Frame, TweenInfo_new_ret2, {
            BackgroundTransparency = 1
        }):Play();
    end);
end;

return v1;