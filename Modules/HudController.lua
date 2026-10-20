-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("SoundService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local SeasonPassToggler = require(ReplicatedStorage.Modules.SeasonPass.SeasonPassToggler);
local GardenGuideController = require(ReplicatedStorage.Modules.GardenGuideController);
local GardenGuideData = require(ReplicatedStorage.Data.GardenGuideData);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.CountDictionary);
local RebirthUnlocksSharedService = require(ReplicatedStorage.Modules.RebirthUnlocksSharedService);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local Hud_UI = PlayerGui.Hud_UI;
local RebirthConfirmation = PlayerGui:WaitForChild("RebirthConfirmation", 30);
local v7 = {
    Start = function(p1) -- Line: 24, Name: Start
        -- upvalues: SetupButton (copy), Hud_UI (copy), GuiController (copy), PlayerGui (copy), GardenGuideData (copy), LocalPlayer (copy), GardenGuideController (copy), SeasonPassToggler (copy), ReplicatedStorage (copy), DataService (copy), RebirthUnlocksSharedService (copy), Players (copy), RebirthConfirmation (copy), UpdateService (copy)
        SetupButton({
            offset = 0.075,
            instance = Hud_UI.SideBtns.Shop,

            onclick = function() -- Line: 28, Name: onclick
                -- upvalues: GuiController (ref), PlayerGui (ref)
                GuiController:Toggle(PlayerGui.Shop_UI);
            end
        });
        Hud_UI.SideBtns.GardenGuide.Visible = not GardenGuideData.UseTool;
        Hud_UI.SideBtns.GardenGuide.Visible = not LocalPlayer:GetAttribute("FirstTimePlayer");
        LocalPlayer:GetAttributeChangedSignal("FirstTimePlayer"):Connect(function() -- Line: 35
            -- upvalues: Hud_UI (ref), LocalPlayer (ref)
            Hud_UI.SideBtns.GardenGuide.Visible = not LocalPlayer:GetAttribute("FirstTimePlayer");
        end);
        SetupButton({
            offset = 0.075,
            instance = Hud_UI.SideBtns.GardenGuide
        });
        Hud_UI.SideBtns.GardenGuide.Activated:Connect(function() -- Line: 42
            -- upvalues: GardenGuideController (ref)
            GardenGuideController:Toggle();
        end);
        Hud_UI.SideBtns.Pass.Visible = not LocalPlayer:GetAttribute("FirstTimePlayer");
        LocalPlayer:GetAttributeChangedSignal("FirstTimePlayer"):Connect(function() -- Line: 50
            -- upvalues: Hud_UI (ref), LocalPlayer (ref)
            Hud_UI.SideBtns.Pass.Visible = not LocalPlayer:GetAttribute("FirstTimePlayer");
        end);
        SetupButton({
            offset = 0.1,
            instance = Hud_UI.SideBtns.Pass,

            onclick = function() -- Line: 56, Name: onclick
                -- upvalues: SeasonPassToggler (ref)
                SeasonPassToggler:Toggle();
            end
        });
        local AdminQuestUIController = require(ReplicatedStorage.Modules.AdminQuestUIController);

        local function AdminQuestVisible() -- Line: 67
            -- upvalues: LocalPlayer (ref), DataService (ref)
            local v2 = true and not LocalPlayer:GetAttribute("FirstTimePlayer");
            local Data = DataService:GetData();

            if v2 then
                v2 = Data.AdminQuest ~= nil;
            end;

            return v2;
        end;

        local Notify = Hud_UI.SideBtns.AdminQuest.Notify;
        AdminQuestUIController.OnNotifStateChanged:Connect(function() -- Line: 79
            -- upvalues: Notify (copy), AdminQuestUIController (copy)
            Notify.Visible = AdminQuestUIController.Notif;
        end);

        local function UpdateAdminQuestButtonVisibility() -- Line: 83
            -- upvalues: LocalPlayer (ref), DataService (ref), Hud_UI (ref), AdminQuestUIController (copy)
            local v3 = true and not LocalPlayer:GetAttribute("FirstTimePlayer");
            local Data = DataService:GetData();

            if v3 then
                v3 = Data.AdminQuest ~= nil;
            end;

            Hud_UI.SideBtns.AdminQuest.Visible = v3;

            if not v3 then
                AdminQuestUIController:Close();
            end;
        end;

        local v4 = true and not LocalPlayer:GetAttribute("FirstTimePlayer");
        local Data = DataService:GetData();

        if v4 then
            v4 = Data.AdminQuest ~= nil;
        end;

        Hud_UI.SideBtns.AdminQuest.Visible = v4;

        if not v4 then
            AdminQuestUIController:Close();
        end;

        DataService:GetPathSignal("AdminQuest/@"):Connect(UpdateAdminQuestButtonVisibility);
        SetupButton({
            offset = 0.075,
            instance = Hud_UI.SideBtns.AdminQuest,

            onclick = function() -- Line: 96, Name: onclick
                -- upvalues: AdminQuestUIController (copy)
                AdminQuestUIController:Toggle();
            end
        });

        if RebirthUnlocksSharedService:HasBeenAssignedABTest(Players.LocalPlayer) then
            Hud_UI.SideBtns.Ascend.Visible = true;
            SetupButton({
                offset = 0.075,
                instance = Hud_UI.SideBtns.Ascend,

                onclick = function() -- Line: 107, Name: onclick
                    -- upvalues: GuiController (ref), RebirthConfirmation (ref)
                    GuiController:Open(RebirthConfirmation);
                end
            });
            Hud_UI.SideBtns.Ascend.Visible = not LocalPlayer:GetAttribute("FirstTimePlayer");
            local u5 = nil;
            u5 = LocalPlayer:GetAttributeChangedSignal("FirstTimePlayer"):Connect(function() -- Line: 115
                -- upvalues: LocalPlayer (ref), Hud_UI (ref), u5 (ref)
                local v6 = not LocalPlayer:GetAttribute("FirstTimePlayer");
                Hud_UI.SideBtns.Ascend.Visible = v6;

                if v6 and u5 then
                    u5:Disconnect();
                    u5 = nil;
                end;
            end);
        end;

        while UpdateService:IsHiddenFromUpdate("Trade Tokens") do
            task.wait(1);
        end;

        Hud_UI.SideBtns.Trade.Visible = not LocalPlayer:GetAttribute("FirstTimePlayer");
        SetupButton({
            offset = 0.1,
            instance = Hud_UI.SideBtns.Trade,

            onclick = function() -- Line: 137, Name: onclick
                -- upvalues: GuiController (ref), PlayerGui (ref)
                GuiController:Toggle(PlayerGui.TradeMenu);
            end
        });
    end
};
task.spawn(v7.Start, v7);

return v7;