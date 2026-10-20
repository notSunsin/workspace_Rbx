-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local FocusState = script.Parent:WaitForChild("FocusState");
UserInputService.WindowFocused:Connect(function() -- Line: 24
    -- upvalues: FocusState (copy)
    FocusState:FireServer(true);
end);
UserInputService.WindowFocusReleased:Connect(function() -- Line: 27
    -- upvalues: FocusState (copy)
    FocusState:FireServer(false);
end);