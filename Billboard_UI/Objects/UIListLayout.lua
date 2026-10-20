-- Decompiled with Potassium's decompiler.

local GamepadService = game:GetService("GamepadService");
local GuiService = game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local DeviceController = require(ReplicatedStorage.Modules.DeviceController);
local v1 = UserInputService.GamepadEnabled and not (UserInputService.KeyboardEnabled or UserInputService.MouseEnabled) and true or false;

local function updateSpacing() -- Line: 13
    -- upvalues: UserInputService (copy)
    local v2 = script.Parent:FindFirstChildOfClass("UIListLayout");

    if v2 then
        local v3;

        if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
            v3 = UDim.new(0.035, 0);
        else
            v3 = UDim.new(0, 0);
        end;

        v2.Padding = v3;
    end;
end;

UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(updateSpacing);
task.spawn(updateSpacing);

if v1 == true then
    function upd()
        -- upvalues: GamepadService (copy)
        if #script.Parent:GetChildren() == 2 then
            GamepadService:DisableGamepadCursor();

            return;
        end;

        GamepadService:EnableGamepadCursor(script.Parent:FindFirstChildWhichIsA("Frame"));
    end;

    script.Parent.ChildAdded:Connect(upd);
    script.Parent.ChildRemoved:Connect(upd);
end;

local function onChildAdded(u4: userdata) -- Line: 36
    -- upvalues: DeviceController (copy), GuiService (copy)
    if not u4:IsA("Frame") then
        return;
    end;

    if u4.Frame == nil then
        return;
    end;

    u4.MouseEnter:Connect(function() -- Line: 43
        -- upvalues: DeviceController (ref), GuiService (ref), u4 (copy)
        if DeviceController:GetCurrentDevice() ~= "Gamepad" then
            return;
        end;

        GuiService.SelectedObject = u4.Frame.ImageButton;
    end);
    u4.Frame.ImageButton.Selectable = false;
end;

script.Parent.ChildAdded:Connect(onChildAdded);

for _, child in script.Parent:GetChildren() do
    task.spawn(onChildAdded, child);
end;