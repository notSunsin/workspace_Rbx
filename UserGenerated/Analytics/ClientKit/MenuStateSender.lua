-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local MenuState = script.Parent:WaitForChild("MenuState");
GuiService.MenuOpened:Connect(function() -- Line: 24
    -- upvalues: MenuState (copy)
    MenuState:FireServer(true);
end);
GuiService.MenuClosed:Connect(function() -- Line: 27
    -- upvalues: MenuState (copy)
    MenuState:FireServer(false);
end);