-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("ServerScriptService");
game:GetService("ServerStorage");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local GameEvents = ReplicatedStorage.GameEvents;
require(ReplicatedStorage.Modules.GetFarmAsync);
require(ReplicatedStorage.Data.ExtendedServersConfig);

return {
    DoesPlayerQualify = function(p1: table, p2: userdata) -- Line: 17, Name: DoesPlayerQualify
        -- upvalues: GameConfigController (copy)
        local v3 = false;

        for _, v in GameConfigController:GetConfig("ContentCreators") do
            if v == p2.UserId then
                v3 = true;
            end;
        end;

        return v3;
    end,

    BindVisibilitySign = function(p4, p5) -- Line: 29, Name: BindVisibilitySign
        -- upvalues: ReplicatedStorage (copy), GameEvents (copy)
        local VisibilitySpawn = p5:FindFirstChild("VisibilitySpawn", true);
        local v6 = ReplicatedStorage.Assets.VisibilitySign:Clone();
        v6:PivotTo(VisibilitySpawn:GetPivot());
        v6:FindFirstChild("ProximityPrompt", true).Triggered:Connect(function(p7) -- Line: 37
            -- upvalues: GameEvents (ref)
            GameEvents.ExtendedServers.RequestVisibilityChange:FireServer();
        end);
        v6.Parent = p5;
    end
};