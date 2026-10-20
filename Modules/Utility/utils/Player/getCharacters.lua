-- Decompiled with Potassium's decompiler.

return function() -- Line: 1, Name: getCharacters
    local v1 = {};

    for _, v in pairs(game.Players:GetPlayers()) do
        table.insert(v1, v.Character);
    end;

    return v1;
end;