-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
require(ReplicatedStorage.Modules.Chalk);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.Notification);
local AdminMachine = require(ReplicatedStorage.Data.SharedCycleHandlerData).AdminMachine;

if not AdminMachine:IsRunning() then
    AdminMachine:Start();
end;

while task.wait(1) do
    if AdminMachine:IsRunning() then
        local v1 = AdminMachine:GetTimeUntilNext() or 3600;
        local math_floor_ret = math.floor(v1);
        script.Parent.Text = TimeHelper:GenerateTextFromTime(math_floor_ret);
        script.Parent.Parent.Shadow.Text = TimeHelper:GenerateTextFromTime(math_floor_ret);
    end;
end;