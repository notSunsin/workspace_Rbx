-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.TradeControllers.TradingController);
require(ReplicatedStorage.Data.TradeData);
local DataService = require(ReplicatedStorage.Modules.DataService);
local TradeMenuHistoryController = require(ReplicatedStorage.Modules.TradeMenu.TradeMenuHistoryController);
local TradeMenuSettingsController = require(ReplicatedStorage.Modules.TradeMenu.TradeMenuSettingsController);
local TradeMenuPlayersController = require(ReplicatedStorage.Modules.TradeMenu.TradeMenuPlayersController);
local TradingPinController = require(ReplicatedStorage.Modules.TradeMenu.TradingPinController);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Comma_Module);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
require(ReplicatedStorage.Modules.UpdateService);
local PlayerGui = (Players.LocalPlayer or Players.PlayerAdded:Wait()).PlayerGui;
local ButtonColors = SeasonPassStaticData.ButtonColors;
local BackpackGui = PlayerGui:WaitForChild("BackpackGui");
local Teleport_UI = PlayerGui.Teleport_UI;
local BuyTokens = PlayerGui:WaitForChild("BuyTokens");
local TokensInfo = PlayerGui:WaitForChild("TokensInfo");
local TradeMenu = PlayerGui:WaitForChild("TradeMenu");
local TopBtns = TradeMenu.TradeMenuFrame.TopBtns;
local FrameSECTIONS = TradeMenu.TradeMenuFrame.FrameSECTIONS;
local v12 = {
    Start = function(p1) -- Line: 37, Name: Start
        -- upvalues: GuiController (copy), TradeMenu (copy), DataService (copy), SoundService (copy), PlayClickSound (copy), TopBtns (copy), FrameSECTIONS (copy), ButtonColors (copy), NumberUtil (copy), BuyTokens (copy), TokensInfo (copy), TradeWorldController (copy), BackpackGui (copy), Teleport_UI (copy), TradeMenuHistoryController (copy), TradeMenuPlayersController (copy), TradeMenuSettingsController (copy), TradingPinController (copy)
        GuiController:UsePopupAnims(TradeMenu);
        local Data = DataService:GetData();

        if not Data then
            warn("TradeMenuController | No player data found");

            return;
        end;

        TradeMenu.TradeMenuFrame.Close.Activated:Connect(function() -- Line: 46
            -- upvalues: GuiController (ref), TradeMenu (ref)
            GuiController:Close(TradeMenu);
        end);

        local function setUpTopButton(u2: userdata) -- Line: 50
            -- upvalues: SoundService (ref), PlayClickSound (ref), TopBtns (ref), FrameSECTIONS (ref), ButtonColors (ref)
            u2.MouseEnter:Connect(function() -- Line: 52
                -- upvalues: SoundService (ref)
                local Hover = SoundService.Hover;
                Hover.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                Hover:Play();
            end);
            u2.Activated:Connect(function() -- Line: 58
                -- upvalues: PlayClickSound (ref), TopBtns (ref), FrameSECTIONS (ref), u2 (copy), ButtonColors (ref)
                PlayClickSound();

                for _, child in TopBtns:GetChildren() do
                    if child:IsA("ImageButton") then
                        local UIStroke = child:FindFirstChild("UIStroke");
                        local UIStroke2 = child:FindFirstChild("TextLabel"):FindFirstChild("UIStroke");
                        local v3 = FrameSECTIONS:FindFirstChild(child.Name);

                        if not v3 then
                            warn((`No related section found for {child.Name}`));

                            return;
                        end;

                        if child.Name == u2.Name then
                            v3.Visible = true;
                            child.BackgroundColor3 = ButtonColors.Yellow.Background;
                            UIStroke2.Color = ButtonColors.Yellow.ButtonStroke;
                            UIStroke.Color = ButtonColors.Yellow.ButtonStroke;
                        else
                            v3.Visible = false;
                            child.BackgroundColor3 = ButtonColors.Green.TextStroke;
                            UIStroke2.Color = ButtonColors.Green.ButtonStroke;
                            UIStroke.Color = ButtonColors.Green.ButtonStroke;
                        end;
                    end;
                end;
            end);
        end;

        local function setupInterfaceToggle(p4, u5, u6) -- Line: 89
            -- upvalues: PlayClickSound (ref), GuiController (ref)
            p4.Activated:Connect(function() -- Line: 90
                -- upvalues: PlayClickSound (ref), u5 (copy), GuiController (ref), u6 (copy)
                PlayClickSound();
                local Close = u5:FindFirstChild("Close", true);

                if Close then
                    Close.Activated:Once(function() -- Line: 94
                        -- upvalues: GuiController (ref), u5 (ref), u6 (ref)
                        GuiController:Close(u5);
                        GuiController:Open(u6);
                    end);
                end;

                GuiController:Open(u5);
            end);
        end;

        for _, child in TopBtns:GetChildren() do
            if child:IsA("ImageButton") then
                setUpTopButton(child);
            end;
        end;

        local TokenCounter = TradeMenu.TradeMenuFrame.TokenCounter;
        TokenCounter.Label.Text = `Tokens: {NumberUtil.Comma(Data.TradeData.Tokens)}`;
        DataService:GetPathSignal("TradeData/Tokens"):Connect(function() -- Line: 115
            -- upvalues: TokenCounter (copy), NumberUtil (ref), Data (copy)
            TokenCounter.Label.Text = `Tokens: {NumberUtil.Comma(Data.TradeData.Tokens)}`;
        end);
        local u7 = BuyTokens;
        local u8 = TradeMenu;
        TokenCounter.Buy.Activated:Connect(function() -- Line: 90
            -- upvalues: PlayClickSound (ref), u7 (copy), GuiController (ref), u8 (copy)
            PlayClickSound();
            local Close = u7:FindFirstChild("Close", true);

            if Close then
                Close.Activated:Once(function() -- Line: 94
                    -- upvalues: GuiController (ref), u7 (ref), u8 (ref)
                    GuiController:Close(u7);
                    GuiController:Open(u8);
                end);
            end;

            GuiController:Open(u7);
        end);
        local u9 = TokensInfo;
        local u10 = TradeMenu;
        TokenCounter.Info.Activated:Connect(function() -- Line: 90
            -- upvalues: PlayClickSound (ref), u9 (copy), GuiController (ref), u10 (copy)
            PlayClickSound();
            local Close = u9:FindFirstChild("Close", true);

            if Close then
                Close.Activated:Once(function() -- Line: 94
                    -- upvalues: GuiController (ref), u9 (ref), u10 (ref)
                    GuiController:Close(u9);
                    GuiController:Open(u10);
                end);
            end;

            GuiController:Open(u9);
        end);
        local MainWorldButton = TradeMenu.TradeMenuFrame.MainWorldButton;
        local TradeWorldButton = TradeMenu.TradeMenuFrame.TradeWorldButton;

        if TradeWorldController:IsInWorld() then
            TradeWorldButton.Visible = false;
            MainWorldButton.Visible = true;
            MainWorldButton.Button.Activated:Connect(function() -- Line: 131
                -- upvalues: TradeWorldController (ref)
                TradeWorldController:TeleportToMainWorld();
            end);
        else
            if not TradeWorldController:IsPlayerANoob() then
                TradeWorldButton.Visible = true;
                MainWorldButton.Visible = false;
            end;

            TradeWorldButton.Button.Activated:Connect(function() -- Line: 140
                -- upvalues: TradeWorldController (ref)
                TradeWorldController:TeleportToTradeWorld();
            end);
        end;

        GuiController:GetStateForGui(TradeMenu).Visible:Observe(function(p11: boolean) -- Line: 146
            -- upvalues: TradeWorldController (ref), TradeWorldButton (copy), MainWorldButton (copy), BackpackGui (ref), Teleport_UI (ref)
            if not p11 then
                BackpackGui.Enabled = true;
                Teleport_UI.Enabled = true;

                return;
            end;

            if not (TradeWorldController:IsPlayerANoob() or TradeWorldController:IsInWorld()) then
                TradeWorldButton.Visible = true;
                MainWorldButton.Visible = false;
            end;

            BackpackGui.Enabled = false;
            Teleport_UI.Enabled = false;
        end);
        task.spawn(TradeMenuHistoryController.SetUpHistoryUI);
        task.spawn(TradeMenuPlayersController.SetUpPlayersUI);
        task.spawn(TradeMenuSettingsController.SetUpSettingsUI);
        task.spawn(TradingPinController.SetUpTradingPinUI, TradingPinController);
    end
};
task.spawn(v12.Start, v12);

return v12;