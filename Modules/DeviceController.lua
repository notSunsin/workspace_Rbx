-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local u2 = {
    DeviceChanged = require(ReplicatedStorage.Modules.Signal).new(),

    GetCurrentDevice = function(p1) -- Line: 13, Name: GetCurrentDevice
        -- upvalues: UserInputService (copy)
        local LastInputType = UserInputService:GetLastInputType();

        return LastInputType == Enum.UserInputType.Touch and "Touch" or ((LastInputType == Enum.UserInputType.Keyboard or string.find(LastInputType.Name, "Mouse", 1, true)) and "PC" or (string.find(LastInputType.Name, "Gamepad", 1, true) and "Gamepad" or "PC"));
    end
};

function u2.Observe(p3: table, u4: function) -- Line: 26
    -- upvalues: u2 (copy)
    local u5 = u2.DeviceChanged:Connect(function() -- Line: 27
        -- upvalues: u4 (copy), u2 (ref)
        task.spawn(u4, u2:GetCurrentDevice());
    end);
    task.spawn(u4, u2:GetCurrentDevice());

    return function() -- Line: 33
        -- upvalues: u5 (copy)
        u5:Disconnect();
    end;
end;

function u2.Start(p6) -- Line: 38
    -- upvalues: u2 (copy), UserInputService (copy)
    local u7 = nil;
    UserInputService.LastInputTypeChanged:Connect(function() -- Line: 40, Name: updateInput
        -- upvalues: u2 (ref), u7 (ref)
        local CurrentDevice = u2:GetCurrentDevice();

        if CurrentDevice == u7 then
            return;
        end;

        u7 = CurrentDevice;
        u2.DeviceChanged:Fire(CurrentDevice);
    end);
    local CurrentDevice = u2:GetCurrentDevice();

    if CurrentDevice ~= u7 then
        u7 = CurrentDevice;
        u2.DeviceChanged:Fire(CurrentDevice);
    end;
end;

task.spawn(u2.Start, u2);

return u2;