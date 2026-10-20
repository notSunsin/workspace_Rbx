-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local SharedCycleHandlerData = require(ReplicatedStorage.Data.SharedCycleHandlerData);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local HalloweenEventShop_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Events"):WaitForChild("HalloweenEvent"):WaitForChild("HalloweenEventShop_UI");
local HalloweenMarket = SharedCycleHandlerData.HalloweenMarket;
local u3 = {
    Start = function(p2) -- Line: 21, Name: Start
    end
};
EventRotationClientBinder:Bind({
    EventSet = "HalloweenEvent",
    Script = script,

    OnStart = function() -- Line: 28, Name: OnStart
        -- upvalues: u3 (copy), u1 (copy), HalloweenMarket (copy), GuiController (copy), HalloweenEventShop_UI (copy)
        task.spawn(u3.Start, u3);
        u1:Add(HalloweenMarket.EventEnd:Connect(function() -- Line: 31
            -- upvalues: GuiController (ref), HalloweenEventShop_UI (ref)
            GuiController:Close(HalloweenEventShop_UI);
        end));
    end,

    OnStop = function() -- Line: 35, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u3;