-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("HttpService");
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {
    Detectors = {}
};

function u1.bind(u2: userdata, p3: table?) -- Line: 18
    -- upvalues: Signal (copy), u1 (copy)
    local v4 = p3 or {};
    local u5 = {
        Container = u2,
        Inside = false,
        MaxDistance = v4.MaxDistance or 1000,
        RaycastParams = v4.RaycastParams or RaycastParams.new(),
        GamepadButtons = v4.GamepadButtons or { Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonL2 },
        MouseHoverEnter = Signal.new(),
        MouseHoverLeave = Signal.new(),
        MouseClick = Signal.new()
    };
    u2.Destroying:Connect(function() -- Line: 34
        -- upvalues: u1 (ref), u2 (copy), u5 (copy)
        u1.Detectors[u2] = nil;
        u5.MouseHoverEnter:DisconnectAll();
        u5.MouseHoverLeave:DisconnectAll();
        u5.MouseClick:DisconnectAll();
    end);
    u1.Detectors[u2] = u5;

    return u5;
end;

function u1.get(p6: userdata) -- Line: 47
    -- upvalues: u1 (copy)
    return u1.Detectors[p6];
end;

RunService.PreRender:Connect(function() -- Line: 51
    -- upvalues: u1 (copy), UserInputService (copy)
    for _, v in u1.Detectors do
        local MouseLocation = UserInputService:GetMouseLocation();
        local v7 = workspace.CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);
        local v8 = workspace:Raycast(v7.Origin, v7.Direction * v.MaxDistance, v.RaycastParams);

        if v8 then
            v8 = v8.Instance:IsDescendantOf(v.Container) or v8.Instance == v.Container;
        end;

        if v8 or not v.Inside then
            if v8 and not v.Inside then
                v.MouseHoverEnter:Fire();
                v.Inside = true;
            end;
        else
            v.MouseHoverLeave:Fire();
            v.Inside = false;
        end;
    end;
end);
UserInputService.InputEnded:Connect(function(p9, p10) -- Line: 69
    -- upvalues: u1 (copy)
    for _, v in u1.Detectors do
        local v11;

        if p9.UserInputType == Enum.UserInputType.MouseButton1 or p9.UserInputType == Enum.UserInputType.Touch then
            v11 = true;
        elseif p9.UserInputType == Enum.UserInputType.Gamepad1 then
            v11 = table.find(v.GamepadButtons, p9.KeyCode);
        else
            v11 = false;
        end;

        if v11 and v.Inside then
            v.MouseClick:Fire();
        end;
    end;
end);

return u1;