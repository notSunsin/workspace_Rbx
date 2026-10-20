-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

return {
    Name = "nukeworldclient",
    Description = "[Client] Clears the world aside from basepart",
    Group = "GameCommands",
    Aliases = { "nwc" },
    Args = {},

    ClientRun = function() -- Line: 12, Name: ClientRun
        -- upvalues: Players (copy)
        local BasePlate = workspace:WaitForChild("BasePlate");
        local v1 = {};

        for _, v in Players:GetPlayers() do
            if v.Character then
                table.insert(v1, v.Character);
            end;
        end;

        for _, descendant in workspace:GetDescendants() do
            if descendant:IsA("BasePart") and not (descendant:IsA("Terrain") or descendant:IsDescendantOf(BasePlate)) then
                local v2 = descendant;
                local v3 = false;

                for _, v in v1 do
                    if v2:IsDescendantOf(v) then
                        v3 = true;
                        break;
                    end;
                end;

                if not v3 then
                    v2:Destroy();
                end;
            end;
        end;
    end
};