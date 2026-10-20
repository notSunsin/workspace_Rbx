-- Decompiled with Potassium's decompiler.

game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local script_CrackManager = require(script.CrackManager);
local script_BufferManager = require(script.BufferManager);
local ParallelTasks = require(script.ParallelWorker.ParallelTasks);
local WeatherVisuals = workspace:WaitForChild("WeatherVisuals");
local workspace_CurrentCamera = workspace.CurrentCamera;
local PlayerGui = Players.LocalPlayer.PlayerGui;
local u1 = {};
u1.__index = u1;
local u2 = script_BufferManager.new(function() -- Line: 25
    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5);
    ViewportFrame.Size = UDim2.new(1, 0, 1, 0);
    ViewportFrame.BackgroundTransparency = 1;

    return ViewportFrame;
end);
local u3 = script_BufferManager.new(function() -- Line: 33
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.ResetOnSpawn = false;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.ClipsDescendants = true;

    return SurfaceGui;
end);
local u4 = script_BufferManager.new(function() -- Line: 41
    return Instance.new("Camera");
end);
local u5 = script_BufferManager.new(function() -- Line: 45
    return Instance.new("Part");
end);

local function SetDefaults(p6) -- Line: 49
    if p6:IsA("Part") then
        p6.Size = Vector3.new(1, 1, 1);
        p6.CFrame = CFrame.new();
        p6.Transparency = 0;
        p6.Anchored = false;
        p6.CanCollide = true;
        p6.CanTouch = true;
        p6.CanQuery = true;
        p6.Color = Color3.new(1, 1, 1);
        p6.Material = Enum.Material.Plastic;
        p6.CastShadow = true;
        p6.Name = "Part";

        return;
    end;

    if not p6:IsA("SurfaceGui") then
        if p6:IsA("ViewportFrame") then
            p6.CurrentCamera = nil;
            p6.AnchorPoint = Vector2.new(0, 0);
            p6.Size = UDim2.new(0, 100, 0, 100);
            p6.Position = UDim2.new(0, 0, 0, 0);
            p6.LightDirection = Vector3.new(-1, -1, -1);
            p6.BackgroundTransparency = 0;
            p6.BorderSizePixel = 1;
            p6.Ambient = Color3.new(1, 1, 1);
            p6.Name = "ViewportFrame";
        end;

        return;
    end;

    p6.Adornee = nil;
    p6.ResetOnSpawn = true;
    p6.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    p6.PixelsPerStud = 50;
    p6.ClipsDescendants = false;
    p6.Face = Enum.NormalId.Front;
    p6.ZIndexBehavior = Enum.ZIndexBehavior.Global;
    p6.Enabled = true;
    p6.Brightness = 1;
    p6.LightInfluence = 1;
    p6.AlwaysOnTop = false;
    p6.ToolPunchThroughDistance = 0;
    p6.Name = "SurfaceGui";
    p6.Parent = nil;
end;

function u1.new(p7: userdata, p8, p9: vector?) -- Line: 92
    -- upvalues: u1 (copy), u3 (copy), SetDefaults (copy), u2 (copy), u5 (copy), u4 (copy), script_CrackManager (copy)
    local v10 = setmetatable({}, u1);
    local v11 = u3:get();
    SetDefaults(v11);
    local v12 = u2:get();
    SetDefaults(v12);
    local v13 = u5:get();
    SetDefaults(v13);
    local v14 = u4:get();
    v10.SurfaceGui = v11;
    v10.Viewport = v12;
    v10.Part = v13;
    v10.vCam = v14;
    v10.Model = p7;
    v10:_setInstanceProps();
    v10:setCFrame(p8 or CFrame.new());
    v10:setSize(p9 or Vector3.new(45, 0.15, 45));
    v10:_updateSurfaceInfo();
    script_CrackManager:add(v10);

    return v10;
end;

function u1._setInstanceProps(p15) -- Line: 123
    -- upvalues: PlayerGui (copy), WeatherVisuals (copy)
    local SurfaceGui = p15.SurfaceGui;
    local Viewport = p15.Viewport;
    local Part = p15.Part;
    local vCam = p15.vCam;
    local Model = p15.Model;
    SurfaceGui.Parent = PlayerGui;
    SurfaceGui.Name = "GroundCrackSurfaceGui";
    SurfaceGui.ResetOnSpawn = false;
    SurfaceGui.Adornee = Part;
    SurfaceGui.Face = Enum.NormalId.Top;
    SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    SurfaceGui.MaxDistance = 1000;
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
    SurfaceGui.PixelsPerStud = 1000;
    SurfaceGui.ClipsDescendants = true;
    Viewport.Parent = SurfaceGui;
    Viewport.CurrentCamera = vCam;
    Viewport.AnchorPoint = Vector2.new(0.5, 0.5);
    Viewport.Position = UDim2.new(0.5, 0, 0.5, 0);
    Viewport.Size = UDim2.new(1, 0, 1, 0);
    Viewport.BackgroundTransparency = 1;
    vCam.Parent = Viewport;
    Part.Parent = WeatherVisuals;
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Name = "Crackpart";
    Model.Parent = Viewport;
end;

function u1.setCFrame(p16: table, p17) -- Line: 161
    p16.CFrame = p17;
    p16.Part.CFrame = p16.CFrame;
    p16.Model:PivotTo(p16.Part.CFrame * CFrame.new(0, -p16.Model.PrimaryPart.Size.Y / 2, 0));
    p16:_updateSurfaceInfo();
end;

function u1.getCFrame(p18) -- Line: 168
    return p18.CFrame;
end;

function u1.setSize(p19: table, p20: vector) -- Line: 172
    p19.Size = p20;
    p19.Part.Size = p19.Size;
    p19:_updateSurfaceInfo();
end;

function u1.getSize(p21) -- Line: 178
    return p21.Size;
end;

function u1._updateSurfaceInfo(p22) -- Line: 182
    -- upvalues: ParallelTasks (copy)
    local Part = p22.Part;
    local v23, v24 = ParallelTasks.CalculateSurfaceInfo(Part.CFrame, Part.Size);
    p22.SurfaceInfo = {
        cf = v23,
        size = v24
    };
end;

function u1.updateCamera(p25) -- Line: 193
    -- upvalues: workspace_CurrentCamera (copy), ParallelTasks (copy)
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local cf = p25.SurfaceInfo.cf;
    local size = p25.SurfaceInfo.size;
    local y = workspace_CurrentCamera.ViewportSize.y;

    if not (cf and size) then
        return;
    end;

    local v26, v27, v28, v29, v30 = ParallelTasks.CalculateCameraProperties(CFrame2, cf, size, y);
    local Viewport = p25.Viewport;
    Viewport.Position = UDim2.new(Viewport.AnchorPoint.x - v26, 0, Viewport.AnchorPoint.y - v27, 0);
    Viewport.Size = UDim2.new(v28, 0, v28, 0);
    Viewport.BackgroundColor3 = p25.SurfaceGui.Adornee.Color;
    p25.SurfaceGui.CanvasSize = Vector2.new(y * (size.x / size.y), y);
    p25.vCam.FieldOfView = v30;
    p25.vCam.CFrame = CFrame.new(CFrame2.p) * (cf - cf.p) * CFrame.Angles(0, 3.141592653589793, 0) * v29;
end;

function u1.Destroy(p31) -- Line: 217
    -- upvalues: script_CrackManager (copy), u4 (copy), u2 (copy), u3 (copy), u5 (copy)
    script_CrackManager:remove(p31);
    u4:release(p31.vCam);
    u2:release(p31.Viewport);
    u3:release(p31.SurfaceGui);
    u5:release(p31.Part);
    p31.Model:Destroy();
end;

RunService.PreAnimation:Connect(function(p32) -- Line: 231
    -- upvalues: script_CrackManager (copy)
    script_CrackManager:updateAllCameras();
end);
setmetatable(u1, {
    __index = function(p33, p34) -- Line: 236, Name: __index
        if rawget(p33, p34) then
            return rawget(p33, p34);
        end;

        error(string.format("\'%s\' is not a valid member of \'Crack\'", p34), 2);
    end
});

return u1;