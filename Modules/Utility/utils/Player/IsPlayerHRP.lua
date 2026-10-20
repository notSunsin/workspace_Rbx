-- Decompiled with Potassium's decompiler.

return function(p1: userdata) -- Line: 1, Name: isPlayerHRP
    local Parent = p1.Parent;

    if not Parent then
        return false;
    end;

    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(Parent);

    if PlayerFromCharacter and p1 == Parent:FindFirstChild("HumanoidRootPart") then
        return PlayerFromCharacter;
    end;

    return false;
end;