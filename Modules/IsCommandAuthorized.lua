-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Modules.DumpTable);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local u1 = game.GameId == 7835737630;
local u2 = game.GameId == 7500518143;
local u3 = game.GameId == 7436755782;

return function(u4: userdata) -- Line: 12, Name: IsCommandAuthorized
    -- upvalues: RunService (copy), u1 (copy), GameConfigController (copy), u2 (copy), u3 (copy)
    if not u4 then
        return false;
    end;

    if RunService:IsStudio() then
        return true;
    end;

    local success, result = pcall(function() -- Line: 21
        -- upvalues: u4 (copy)
        return u4:GetRankInGroupAsync(35789249);
    end);
    local v5 = u1 and table.find(GameConfigController:GetConfig("AuthorizedRolesQAGame") or {}, success and result);
    local v6 = u2 and table.find(GameConfigController:GetConfig("AuthorizedUsersDevGame") or {}, u4.UserId);
    local v7 = u3 and table.find(GameConfigController:GetConfig("AuthorizedUsersLiveGame") or {}, u4.UserId);

    return v5 or (v6 or v7);
end;