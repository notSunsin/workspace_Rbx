-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local Players = game:GetService("Players");
local Trove = require(ReplicatedStorage.Modules.Trove);
local Observers = require(ReplicatedStorage.Modules.Observers);
local DeviceController = require(ReplicatedStorage.Modules.DeviceController);
local Hover = SoundService.Hover;
local Click = SoundService.Click;
local v5 = {
    Start = function(p1) -- Line: 15, Name: Start
        -- upvalues: DeviceController (copy), Observers (copy), Trove (copy), Hover (copy), Click (copy), Players (copy)
        local CurrentDevice = DeviceController:GetCurrentDevice();
        DeviceController:Observe(function(p2) -- Line: 17
            -- upvalues: CurrentDevice (ref)
            CurrentDevice = p2;
        end);
        Observers.observeTag("Button", function(p3: userdata) -- Line: 21
            -- upvalues: Trove (ref), CurrentDevice (ref), Hover (ref), Click (ref)
            if not p3:IsA("GuiButton") then
                return nil;
            end;

            local v4 = Trove.new();
            v4:Add(p3.MouseEnter:Connect(function() -- Line: 28
                -- upvalues: CurrentDevice (ref), Hover (ref)
                if CurrentDevice ~= "PC" then
                    return;
                end;

                Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                Hover.TimePosition = 0;
                Hover.Playing = true;
            end));
            v4:Add(p3.Activated:Connect(function() -- Line: 38
                -- upvalues: Click (ref)
                Click.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                Click.TimePosition = 0;
                Click.Playing = true;
            end));

            return v4:WrapClean();
        end, { workspace, Players.LocalPlayer.PlayerGui });
    end
};
task.spawn(v5.Start, v5);

return v5;