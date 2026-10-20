-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local TradeBoothController = require(ReplicatedStorage.Modules.TradeBoothControllers.TradeBoothController);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
local TradePlazaIndexController = require(ReplicatedStorage.Modules.TradePlaza.TradePlazaIndexController);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local TradePlazaIndex = PlayerGui:WaitForChild("TradePlazaIndex");
local Teleport_UI = PlayerGui:WaitForChild("Teleport_UI");
local TradePlaza = Teleport_UI.TradePlaza;
local v2 = {
    Start = function(p1) -- Line: 20, Name: Start
        -- upvalues: TradePlaza (copy), PlayClickSound (copy), TradeBoothController (copy), GuiController (copy), PlayerGui (copy), TradePlazaIndex (copy), TradePlazaIndexController (copy), TradeWorldController (copy), Teleport_UI (copy)
        TradePlaza.Booth.Activated:Connect(function() -- Line: 22
            -- upvalues: PlayClickSound (ref), TradeBoothController (ref)
            PlayClickSound();
            TradeBoothController:TeleportToBooth();
        end);
        TradePlaza.Tokens.Activated:Connect(function() -- Line: 28
            -- upvalues: PlayClickSound (ref), GuiController (ref), PlayerGui (ref)
            PlayClickSound();
            GuiController:Toggle(PlayerGui.BuyTokens);
        end);
        TradePlaza.Index.Activated:Connect(function() -- Line: 34
            -- upvalues: PlayClickSound (ref), TradePlazaIndex (ref), TradePlazaIndexController (ref), GuiController (ref)
            PlayClickSound();

            if not TradePlazaIndex.Enabled then
                TradePlazaIndexController.Initialize();
            end;

            GuiController:Toggle(TradePlazaIndex);
        end);

        if TradeWorldController:IsInWorld() then
            Teleport_UI.TradePlaza.Visible = true;
            Teleport_UI.Frame.Visible = false;
        end;
    end
};
task.spawn(v2.Start, v2);

return v2;