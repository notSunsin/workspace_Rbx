-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local DataService = require(ReplicatedStorage.Modules.DataService);
local SettingsRegistry = require(ReplicatedStorage.Data.SettingsRegistry);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
require(ReplicatedStorage.Modules.userprint)("dev_josep");

local function GenerateInstanceHandler(u1) -- Line: 20
    -- upvalues: CreateTagHandler (copy), SettingsService (copy)
    local u2 = {
        List = {},
        Last = {}
    };
    CreateTagHandler({
        Tag = u1,

        OnInstanceAdded = function(p3) -- Line: 28, Name: OnInstanceAdded
            -- upvalues: u2 (copy), SettingsService (ref), u1 (copy)
            if not p3:IsDescendantOf(workspace) then
                return;
            end;

            u2.List[p3] = true;

            if not SettingsService:GetSetting(u1) then
                u2.Last[p3] = p3.Parent;
                p3.Parent = script;
            end;
        end,

        OnInstanceRemoved = function(p4) -- Line: 39, Name: OnInstanceRemoved
            -- upvalues: u2 (copy)
            u2.List[p4] = nil;
        end
    });

    return function(p5) -- Line: 44, Name: OnToggle
        -- upvalues: u2 (copy)
        if not p5 then
            if not p5 then
                for i in u2.List do
                    if not u2.Last[i] then
                        u2.Last[i] = i.Parent;
                        i.Parent = script;
                    end;
                end;
            end;

            return;
        end;

        for i, v in u2.Last do
            i.Parent = v;
        end;

        table.clear(u2.Last);
    end;
end;

local v25 = {
    GearShopButton = function(p6) -- Line: 65
    end,

    PetShopButton = function(p7) -- Line: 69
    end,

    Audio = function(p8) -- Line: 73
        -- upvalues: TweenService (copy), SoundService (copy)
        TweenService:Create(SoundService.Music, TweenInfo.new(0.25), {
            Volume = p8 and 1 or 0
        }):Play();
    end,

    Sounds = function(p9) -- Line: 78
        -- upvalues: TweenService (copy), SoundService (copy)
        TweenService:Create(SoundService.Music.SFX, TweenInfo.new(0.25), {
            Volume = p9 and 1 or 0
        }):Play();
    end,

    Music = function(p10) -- Line: 83
        -- upvalues: TweenService (copy), SoundService (copy)
        TweenService:Create(SoundService.Music.Tunes, TweenInfo.new(0.25), {
            Volume = p10 and 1 or 0
        }):Play();
    end,

    FavoriteIcons = function(p11) -- Line: 89
        -- upvalues: LocalPlayer (copy)
        if LocalPlayer:GetAttribute("FavoriteIconsEnabled") == nil then
            LocalPlayer:SetAttribute("FavoriteIconsEnabled", true);
        end;

        LocalPlayer:SetAttribute("FavoriteIconsEnabled", p11);
    end,

    UIScale = function(p12) -- Line: 96
        -- upvalues: LocalPlayer (copy)
        LocalPlayer:SetAttribute("UIScale", p12);
    end,

    YourFarmIcon = function(p13) -- Line: 110
        -- upvalues: ReplicatedStorage (copy)
        require(ReplicatedStorage.Modules.OwnerTagHandler):SettingUpdated(p13);
    end,

    AutoCloseActivePetsUI = function(p14) -- Line: 114
        game:GetService("Players").LocalPlayer:SetAttribute("AutoCloseActivePetsUI", p14);
    end,

    CropMutationVFX = function(p15) -- Line: 118
        -- upvalues: SettingsService (copy)
        local LocalPlayer2 = game:GetService("Players").LocalPlayer;

        if SettingsService:GetSetting("PerformanceMode") and p15 == true then
            LocalPlayer2:SetAttribute("CropMutationVFX", false);

            return;
        end;

        LocalPlayer2:SetAttribute("CropMutationVFX", p15);
    end,

    PetMutationVFX = function(p16) -- Line: 128
        -- upvalues: SettingsService (copy)
        local LocalPlayer2 = game:GetService("Players").LocalPlayer;

        if SettingsService:GetSetting("PerformanceMode") and p16 == true then
            LocalPlayer2:SetAttribute("PetMutationVFX", false);

            return;
        end;

        LocalPlayer2:SetAttribute("PetMutationVFX", p16);
    end,

    PetScaling = function(p17) -- Line: 138
        game:GetService("Players").LocalPlayer:SetAttribute("PetScaling", p17);
    end,

    HeldPetScaling = function(p18) -- Line: 147
        -- upvalues: LocalPlayer (copy)
        LocalPlayer:SetAttribute("HeldPetScaling", p18);
    end,

    HeldFruitScaling = function(p19) -- Line: 159
        game:GetService("Players").LocalPlayer:SetAttribute("HeldFruitScaling", p19);
    end,

    KeepPetOnGround = function(p20) -- Line: 163
        -- upvalues: SettingsService (copy)
        local LocalPlayer2 = game:GetService("Players").LocalPlayer;

        if SettingsService:GetSetting("PerformanceMode") and p20 == true then
            LocalPlayer2:SetAttribute("KeepPetOnGround", false);

            return;
        end;

        LocalPlayer2:SetAttribute("KeepPetOnGround", p20);
    end,

    LowerPlantFXQuality = function(p21) -- Line: 171
        -- upvalues: SettingsService (copy)
        local LocalPlayer2 = game:GetService("Players").LocalPlayer;

        if SettingsService:GetSetting("PerformanceMode") and p21 == true then
            LocalPlayer2:SetAttribute("LowerPlantFXQuality", false);

            return;
        end;

        LocalPlayer2:SetAttribute("LowerPlantFXQuality", p21);
    end,

    PerformanceMode = function(p22) -- Line: 179
        -- upvalues: LocalPlayer (copy), SettingsService (copy), ConfirmationPromptController (copy)
        local LocalPlayer2 = game:GetService("Players").LocalPlayer;

        if not p22 and LocalPlayer2:GetAttribute("PerformanceMode") == true then
            require(game.ReplicatedStorage.Modules.Notification):CreateNotification("Please rejoin for Performance Mode to be fully disabled!");
        end;

        if not p22 then
            LocalPlayer2:SetAttribute("PerformanceMode", false);

            return;
        end;

        if p22 == true and (LocalPlayer:GetAttribute("PerformanceMode") == false and SettingsService:GetSetting("PerformanceMode") == true) then
            ConfirmationPromptController:Open({
                Title = "Performance Mode",
                Header = "Are you sure you want to enable Performance Mode?",
                Middle = "This should increase FPS but will disable most Mutation, Plant, and Weather VFX!",
                Footer = "(NOTE: If you turn off this mode, You will have to rejoin to fully disable Performance Mode)"
            }, {
                ConfirmCallback = function() -- Line: 208, Name: ConfirmCallback
                    -- upvalues: LocalPlayer2 (copy), SettingsService (ref)
                    LocalPlayer2:SetAttribute("PerformanceMode", true);
                    SettingsService:SetSetting("KeepPetOnGround", true);
                    SettingsService:SetSetting("LowerPlantFXQuality", true);
                    SettingsService:SetSetting("CropMutationVFX", false);
                    SettingsService:SetSetting("PetMutationVFX", false);
                end,

                RejectCallback = function() -- Line: 216, Name: RejectCallback
                    -- upvalues: SettingsService (ref)
                    SettingsService:SetSetting("PerformanceMode", false);
                end
            });

            return;
        end;

        if p22 == true and SettingsService:GetSetting("PerformanceMode") == true then
            LocalPlayer2:SetAttribute("PerformanceMode", true);
            SettingsService:SetSetting("KeepPetOnGround", true);
            SettingsService:SetSetting("LowerPlantFXQuality", true);
            SettingsService:SetSetting("CropMutationVFX", false);
            SettingsService:SetSetting("PetMutationVFX", false);
        end;
    end,

    ToggleNotifications = function(p23) -- Line: 230
        game:GetService("Players").LocalPlayer:SetAttribute("ToggleNotifications", p23);
    end,

    OtherPlayerBeeColonyVisibility = function(p24) -- Line: 235
        -- upvalues: LocalPlayer (copy)
        LocalPlayer:SetAttribute("OtherPlayerBeeColonyVisibility", p24);
    end
};
local v26 = {};

for i in SettingsRegistry do
    local u27 = v25[i];

    if u27 then
        DataService:GetPathSignal((`Settings/{i}`)):Connect(function() -- Line: 242
            -- upvalues: u27 (copy), SettingsService (copy), i (copy)
            u27(SettingsService:GetSetting(i));
        end);

        if i ~= "ShowDetails" then
            u27((SettingsService:GetSetting(i)));
        end;
    end;
end;

return v26;