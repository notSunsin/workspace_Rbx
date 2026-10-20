-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local Islands = ReplicatedStorage.Assets.DiggingMinigame.Islands;
local Blocks = ReplicatedStorage.Assets.DiggingMinigame.Blocks;

local function seconds(p1: number) -- Line: 43
    return p1;
end;

local function minutes(p2: number) -- Line: 47
    return p2 * 60;
end;

local function hours(p3: number) -- Line: 51
    return p3 * 60 * 60;
end;

UpdateService:IsUpdateDone();
local u4 = "DISABLED";
local u5 = u4 == "DEFAULT" and true or u4 == "Christmas";
local v6 = {
    DEFAULT = {
        Island = Islands.DiggingIsland,
        Block = Blocks.NormalDigBlock
    },
    HalloweenEvent = {
        Music = "Halloween_Digging",
        Island = Islands.HalloweenIsland,
        Block = Blocks.HalloweenDigBlock
    },
    Christmas = {
        Island = Islands.ChristmasIsland,
        Block = Blocks.SnowDigBlock
    }
};
UpdateService.OnUpdated:Once(function() -- Line: 100, Name: EvaluateTheme
    -- upvalues: u4 (ref), UpdateService (copy), u5 (ref)
    UpdateService:IsUpdateDone();
    u4 = "DISABLED";
    u5 = u4 == "DEFAULT" and true or u4 == "Christmas";

    return u4, u5;
end);

return {
    PREVIOUS_THEME = "DISABLED",
    NEXT_THEME = "DISABLED",
    EVENT_APPEARANCE_TIME = 7200,
    EVENT_ACTIVE_DURATION = 3600,
    HALF_EVENT_TIME = 0,
    PERMANENT_RESET_TIME = 86400,

    IsPermanentEvent = function() -- Line: 117, Name: GetPermanentEventFlag
        -- upvalues: u4 (ref), UpdateService (copy), u5 (ref)
        UpdateService:IsUpdateDone();
        u4 = "DISABLED";
        u5 = u4 == "DEFAULT" and true or u4 == "Christmas";

        return u5;
    end,

    GetCurrentTheme = function() -- Line: 112, Name: GetCurrentTheme
        -- upvalues: u4 (ref), UpdateService (copy), u5 (ref)
        UpdateService:IsUpdateDone();
        u4 = "DISABLED";
        u5 = u4 == "DEFAULT" and true or u4 == "Christmas";

        return u4;
    end,

    THEME_DATA = v6
};