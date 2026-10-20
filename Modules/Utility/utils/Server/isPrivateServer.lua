-- Decompiled with Potassium's decompiler.

game:GetService("UserInputService");

return function() -- Line: 5, Name: isPrivateServer
    return game.PrivateServerId ~= "";
end;