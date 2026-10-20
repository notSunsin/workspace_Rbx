-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local _ = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.Modules.PlatformProvider);
require(ReplicatedStorage.Modules.GetFarmAsync);
require(ReplicatedStorage.Modules.userprint);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
require(ReplicatedStorage.Modules.IsDev);
require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.OptimisationControllers.IsBadDeviceHeuristic);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
MutationHandler:GetMutations();
task.spawn(function() -- Line: 23
    -- upvalues: UserInputService (copy)
    UserInputService.InputBegan:Wait();
    task.wait(5);
end);

return {};