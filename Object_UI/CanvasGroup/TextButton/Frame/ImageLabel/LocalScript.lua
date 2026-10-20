-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");

if UserInputService.TouchEnabled == true then
    script.Parent.Visible = false;

    return;
end;

if UserInputService.GamepadEnabled == true then
    script.Parent.PC.Visible = false;
    script.Parent.Console.Visible = true;
    script.Parent.Visible = true;

    return;
end;

script.Parent.PC.Visible = true;
script.Parent.Console.Visible = false;
script.Parent.Visible = true;