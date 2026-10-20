-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local SettingsUI = LocalPlayer.PlayerGui:WaitForChild("SettingsUI");
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local SetupSounds = require(ReplicatedStorage.Modules.SetupSounds);
local SetupBrightnessAnimationFrame = require(ReplicatedStorage.Modules.SetupBrightnessAnimationFrame);
require(ReplicatedStorage.Modules.FindDescendantsWithTag);
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local SettingsRegistry = require(ReplicatedStorage.Data.SettingsRegistry);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local BooleanSetting = require(script.Classes.BooleanSetting);
local MultipleSetting = require(script.Classes.MultipleSetting);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local ClaimableCodeService = require(ReplicatedStorage.Modules.ClaimableCodeService);
local Icon = require(ReplicatedStorage.Modules.Icon);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local ShovelAllPlants = GameEvents:WaitForChild("ShovelAllPlants");
local UnfavoriteAllPlants = GameEvents:WaitForChild("UnfavoriteAllPlants");
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local u2 = {};
local u7 = {
    Boolean = function(p3) -- Line: 38
        -- upvalues: BooleanSetting (copy), u2 (copy)
        local v4 = BooleanSetting.new():SetTitle(p3.Title):SetDescription(p3.Description):SetBackgroundImage(p3.BackgroundTexture):SetId(p3.Name):SetLayoutOrder(p3.LayoutOrder or 1):Complete();
        u2[p3.Name] = v4;
    end,

    Multiple = function(p5) -- Line: 49
        -- upvalues: MultipleSetting (copy), u2 (copy)
        local v6 = MultipleSetting.new(p5.SettingsData.Options):SetTitle(p5.Title):SetDescription(p5.Description):SetBackgroundImage(p5.BackgroundTexture):SetId(p5.Name):SetLayoutOrder(p5.LayoutOrder or 1):Complete();
        u2[p5.Name] = v6;
    end
};
local StateForGui = GuiController:GetStateForGui(SettingsUI);
task.spawn(function() -- Line: 70
    -- upvalues: GuiController (copy), SettingsUI (copy)
    GuiController:UsePopupAnims(SettingsUI);
end);

function u1.Toggle(p8: table, p9: boolean) -- Line: 74
    -- upvalues: StateForGui (copy), GuiController (copy), SettingsUI (copy)
    if p9 == true then
        if not StateForGui.Visible:Get() then
            GuiController:Open(SettingsUI);
        end;
    elseif StateForGui.Visible:Get() then
        GuiController:Close(SettingsUI);
    end;
end;

local function ShouldShowSetting(p10: string) -- Line: 86
    -- upvalues: UpdateService (copy)
    local v11 = not UpdateService:IsHiddenFromUpdate(p10) and not UpdateService:IsHiddenAfterUpdate(p10);

    return v11;
end;

function u1.Synchronize(p12) -- Line: 90
    -- upvalues: DataService (copy), SettingsRegistry (copy), UpdateService (copy), u2 (copy), u7 (copy), SettingsService (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local _ = Data.Settings;

    for i, v in SettingsRegistry do
        if not v.Disabled then
            local v13 = not UpdateService:IsHiddenFromUpdate(i) and not UpdateService:IsHiddenAfterUpdate(i);

            if v13 and not u2[i] then
                local v14 = u7[v.SettingsData.Type];

                if v14 then
                    v14(v);
                end;
            end;
        end;
    end;

    for i, v in SettingsRegistry do
        if not v.Disabled then
            local v15 = not UpdateService:IsHiddenFromUpdate(i) and not UpdateService:IsHiddenAfterUpdate(i);

            if v15 then
                local v16 = u2[i];

                if v16 then
                    v16:Update((SettingsService:GetSetting(i)));
                end;
            end;
        end;
    end;
end;

local v17 = WaitForDescendant(SettingsUI, "EXIT_BUTTON");
SetupSounds(v17);
SetupBrightnessAnimationFrame(v17);
local SENSOR = v17:WaitForChild("SENSOR");
u1:Synchronize();
DataService:GetPathSignal("Settings/@"):Connect(function() -- Line: 125
    -- upvalues: u1 (copy)
    u1:Synchronize();
end);
UpdateService.OnUpdated:Connect(function() -- Line: 129
    -- upvalues: u1 (copy)
    u1:Synchronize();
end);
local u18 = Icon.new();
u18:setImage("rbxassetid://132848201849699");
u18:setName("Settings");
u18:setImageScale(0.8);
u18:setOrder(-6);
u18:setCaption("Toggle Settings");
u18.deselectWhenOtherIconSelected = false;
SENSOR.MouseButton1Click:Connect(function() -- Line: 141
    -- upvalues: u18 (copy)
    u18:deselect();
end);
u18.selected:Connect(function() -- Line: 145
    -- upvalues: u1 (copy)
    u1:Toggle(true);
end);
u18.deselected:Connect(function() -- Line: 148
    -- upvalues: u1 (copy)
    u1:Toggle(false);
end);
local u19 = WaitForDescendant(SettingsUI, "CODE_INPUT_BOX");
local v20 = WaitForDescendant(SettingsUI, "CODE_CLAIM_BUTTON");
SetupSounds(v20);
v20.SENSOR.MouseButton1Click:Connect(function() -- Line: 157
    -- upvalues: ClaimableCodeService (copy), u19 (copy)
    ClaimableCodeService:ClaimCode(u19.Text);
end);
SetupSounds(WaitForDescendant(SettingsUI, "SHOVEL_ALL_BUTTON").Display.TOGGLE_BUTTON_HOLDER.TOGGLE_BUTTON).MouseButton1Click:Connect(function() -- Line: 166
    -- upvalues: ConfirmationPromptController (copy), ShovelAllPlants (copy)
    ConfirmationPromptController:Open({
        Title = "Shovel All Plants",
        Header = "Shovel every plant in this garden?",
        Middle = "This will destroy all plants in your currently selected garden slot (favorited plants and fruit are skipped). This cannot be undone.",
        ConfirmText = "Shovel All",
        RejectText = "Cancel"
    }, {
        ConfirmEvent = ShovelAllPlants
    });
end);

local function CountFavorites() -- Line: 178
    -- upvalues: GetFarm (copy), LocalPlayer (copy)
    local v21 = GetFarm(LocalPlayer);
    local v22 = v21 and v21:FindFirstChild("Important") and v21.Important:FindFirstChild("Plants_Physical");

    if not v22 then
        return 0;
    end;

    local v23 = 0;

    for _, child in v22:GetChildren() do
        if child:GetAttribute("Favorited") then
            v23 = v23 + 1;
        end;

        local Fruits = child:FindFirstChild("Fruits");

        if Fruits then
            for _, child2 in Fruits:GetChildren() do
                if child2:GetAttribute("Favorited") then
                    v23 = v23 + 1;
                end;
            end;
        end;
    end;

    return v23;
end;

SetupSounds(WaitForDescendant(SettingsUI, "UNFAVORITE_ALL_BUTTON").Display.TOGGLE_BUTTON_HOLDER.TOGGLE_BUTTON).MouseButton1Click:Connect(function() -- Line: 198
    -- upvalues: CountFavorites (copy), ConfirmationPromptController (copy), UnfavoriteAllPlants (copy)
    local v24 = CountFavorites();

    if v24 == 0 then
        ConfirmationPromptController:Open(
            {
                Title = "Unfavorite All",
                Header = "Nothing to unfavorite",
                Middle = "You have no favorited plants or fruit in this garden slot.",
                Footer = "",
                HideConfirm = true,
                RejectText = "OK"
            },
            {}
        );

        return;
    end;

    ConfirmationPromptController:Open({
        Title = "Unfavorite All",
        Middle = "Only affects your current garden slot.",
        Footer = "Re-favoriting will cost Favorite Tool uses.",
        ConfirmText = "Unfavorite All",
        RejectText = "Cancel",
        Header = `Unfavorite {v24} plant(s) and fruit?`
    }, {
        ConfirmEvent = UnfavoriteAllPlants
    });
end);
local Settings = game.Players.LocalPlayer.PlayerGui.TopbarStandard.Holders.Left.Settings;
GuiService.MenuOpened:Connect(function() -- Line: 225
    -- upvalues: u18 (copy), Settings (copy)
    u18:deselect();
    Settings.Visible = false;
end);
GuiService.MenuClosed:Connect(function() -- Line: 229
    -- upvalues: Settings (copy)
    Settings.Visible = true;
end);

return u1;