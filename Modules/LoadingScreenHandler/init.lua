-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game.Players.LocalPlayer;
local v2 = {
    Start = function() -- Line: 13, Name: Start
        -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy)
        if game:GetService("RunService"):IsStudio() then
            game.ReplicatedStorage.GameEvents.Finish_Loading:FireServer();

            return;
        end;

        local ClientABTests = require(ReplicatedStorage.UserGenerated.Client.ClientABTests);
        local v1 = ClientABTests.GetAssignmentsAsync(LocalPlayer, true) and ClientABTests.GetAttributes(LocalPlayer);

        if v1 then
            local _ = v1.AB_LoadingVariant or "Variant1";
        end;

        local LoadingGui = LocalPlayer.PlayerGui.LoadingGui;
        require(script.Variants.Variant5).new(LoadingGui):startLoading();
    end
};
task.spawn(v2.Start);

return v2;