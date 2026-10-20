-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");

return {
    Name = "hideotherpeoplesusername",
    Description = "[Client] Hide other peoples usernames!",
    Group = "GameCommands",
    Aliases = { "hopu" },
    Args = {},

    ClientRun = function() -- Line: 12, Name: ClientRun
        -- upvalues: Players (copy)
        local v1 = 0;

        for _, child in workspace.Farm:GetChildren() do
            local Sign = child:FindFirstChild("Sign", true);

            if Sign then
                local SurfaceGui = Sign:FindFirstChild("SurfaceGui", true);

                if SurfaceGui then
                    SurfaceGui:Destroy();
                end;
            end;
        end;

        for _, v in Players:GetPlayers() do
            local Character = v.Character;

            if Character then
                local Humanoid = Character:FindFirstChild("Humanoid");

                if Humanoid then
                    v1 = v1 + 1;
                    Humanoid.NameDisplayDistance = 0;
                    Humanoid.HealthDisplayDistance = 0;
                end;
            end;
        end;

        return `Hidden other people's usernames! {v1}`;
    end
};