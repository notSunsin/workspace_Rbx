-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local EventService = require(ReplicatedStorage.Modules.EventService);
require(ReplicatedStorage.Modules.QuestsController);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Code.Spr);
require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.UIComponents.QuestView);
local _ = require(ReplicatedStorage.Data.SharedCycleHandlerData).HeartstruckRain;
require(ReplicatedStorage.Data.DevProductIds);
local script_ConfettiEffect = require(script.ConfettiEffect);
local script_RainbowFlashEffect = require(script.RainbowFlashEffect);
local script_TierPopEffect = require(script.TierPopEffect);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local EFFECTS_UI = PlayerGui:WaitForChild("EFFECTS_UI");
local Shop_UI = PlayerGui:WaitForChild("Shop_UI");
local HarvestPartyEventController = EventService.new("HarvestPartyEventController", "Harvest Party Event");

local function PlayTierEffects(u1: number) -- Line: 49
    -- upvalues: EFFECTS_UI (copy), script_ConfettiEffect (copy), script_RainbowFlashEffect (copy), script_TierPopEffect (copy)
    local u2 = EFFECTS_UI;
    task.spawn(function() -- Line: 51
        -- upvalues: script_ConfettiEffect (ref), u2 (copy), u1 (copy)
        script_ConfettiEffect.Play(u2, u1);
    end);
    task.spawn(function() -- Line: 52
        -- upvalues: script_RainbowFlashEffect (ref), u2 (copy), u1 (copy)
        script_RainbowFlashEffect.Play(u2, u1);
    end);
    task.spawn(function() -- Line: 53
        -- upvalues: script_TierPopEffect (ref), u2 (copy), u1 (copy)
        script_TierPopEffect.Play(u2, u1);
    end);
end;

function HarvestPartyEventController.OnStarted(p3) -- Line: 57
    -- upvalues: Shop_UI (copy), Comma_Module (copy), PlayTierEffects (copy)
    local RichStand = game.Workspace.Interaction:WaitForChild("RichStand", 300);

    if not RichStand then
        return;
    end;

    local StartAParty = Shop_UI:WaitForChild("Frame", 30):WaitForChild("ScrollingFrame", 30):WaitForChild("StartAParty", 30);

    if StartAParty then
        StartAParty.Visible = true;
    end;

    local ProgressBar = RichStand.PrimaryPart:WaitForChild("BillboardGui"):WaitForChild("CanvasGroup"):WaitForChild("ProgressBar");

    local function UpdateProgressBar() -- Line: 74
        -- upvalues: ProgressBar (copy), Comma_Module (ref)
        local Attribute = game.Workspace:GetAttribute("HARVEST_PARTY_COUNT");
        local Attribute2 = game.Workspace:GetAttribute("HARVEST_PARTY_MAX_COUNT");
        local v4 = Attribute or game.Workspace:GetAttributeChangedSignal("HARVEST_PARTY_COUNT"):Wait();
        local v5 = Attribute2 or game.Workspace:GetAttributeChangedSignal("HARVEST_PARTY_MAX_COUNT"):Wait();
        ProgressBar.PROGRESS.Text = Comma_Module.Comma(v4) .. "¢/" .. Comma_Module.Comma(v5) .. "¢<font transparency=\".1\"></font>";
        ProgressBar.PROGRESS_SHADOW.Text = Comma_Module.Comma(v4) .. "¢/" .. Comma_Module.Comma(v5) .. "¢<font transparency=\".1\"></font>";
        ProgressBar.Bar_Actual.Size = UDim2.fromScale(math.clamp(v4 / v5, 0, 1), 1);
    end;

    p3:Bind(game.Workspace:GetAttributeChangedSignal("HARVEST_PARTY_COUNT"):Connect(function() -- Line: 98
        -- upvalues: UpdateProgressBar (copy)
        UpdateProgressBar();
    end));
    p3:Bind(game.Workspace:GetAttributeChangedSignal("HARVEST_PARTY_MAX_COUNT"):Connect(function() -- Line: 104
        -- upvalues: UpdateProgressBar (copy)
        UpdateProgressBar();
    end));
    p3:Bind(game.Workspace:GetAttributeChangedSignal("HARVEST_PARTY_TIER"):Connect(function() -- Line: 110
        -- upvalues: PlayTierEffects (ref), UpdateProgressBar (copy)
        local Attribute = game.Workspace:GetAttribute("HARVEST_PARTY_TIER");

        if Attribute and Attribute > 0 then
            PlayTierEffects(Attribute);
        end;

        UpdateProgressBar();
    end));
    UpdateProgressBar();
end;

function HarvestPartyEventController.OnStopped(p6) -- Line: 127
    -- upvalues: Shop_UI (copy)
    local StartAParty = Shop_UI:WaitForChild("Frame", 30):WaitForChild("ScrollingFrame", 30):WaitForChild("StartAParty", 30);

    if StartAParty then
        StartAParty.Visible = false;
    end;
end;

function HarvestPartyEventController.Open(p7) -- Line: 134
end;

function HarvestPartyEventController.Close(p8) -- Line: 138
end;

return HarvestPartyEventController;