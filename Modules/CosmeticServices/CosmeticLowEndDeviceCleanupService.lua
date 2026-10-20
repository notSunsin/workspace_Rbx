-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local IsBadDeviceHeuristic = require(ReplicatedStorage.Modules.OptimisationControllers.IsBadDeviceHeuristic);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local Farm = workspace:WaitForChild("Farm");
task.spawn(function() -- Line: 15
    -- upvalues: UserInputService (copy), IsBadDeviceHeuristic (copy), GetFarmAsync (copy), LocalPlayer (copy), Farm (copy)
    UserInputService.InputBegan:Wait();
    task.wait(3);

    if not IsBadDeviceHeuristic() then
        return;
    end;

    local v1 = GetFarmAsync(LocalPlayer);

    for _, child in Farm:GetChildren() do
        if v1 ~= child then
            local Cosmetic_Physical = child.Important.Cosmetic_Physical;

            for _, child2 in Cosmetic_Physical:GetChildren() do
                child2:Destroy();
            end;

            Cosmetic_Physical.ChildAdded:Connect(function(p2) -- Line: 32
                p2:Destroy();
            end);
        end;
    end;
end);

return {};