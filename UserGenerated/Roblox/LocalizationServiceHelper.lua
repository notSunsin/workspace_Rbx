-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local LocalizationService = game:GetService("LocalizationService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Cache = require(ReplicatedStorage.UserGenerated.Concurrency.Cache);
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts);
local u2 = Cache.new({
    Callback = function(p1) -- Line: 29, Name: Callback
        -- upvalues: Players (copy), LocalizationService (copy)
        local PlayerByUserId = Players:GetPlayerByUserId(p1);
        assert(PlayerByUserId, "PlayerNotOnline");

        return LocalizationService:GetCountryRegionForPlayerAsync(PlayerByUserId);
    end,

    AssertKey = Asserts.Integer
});
Players.PlayerRemoving:Connect(function(p3) -- Line: 36
    -- upvalues: Players (copy), u2 (copy)
    local UserId = p3.UserId;
    task.delay(60, function() -- Line: 39
        -- upvalues: Players (ref), UserId (copy), u2 (ref)
        if not Players:GetPlayerByUserId(UserId) then
            u2:Delete(UserId);
        end;
    end);
end);

if RunService:IsServer() then
    Players.PlayerAdded:Connect(function(p4) -- Line: 46
        -- upvalues: u2 (copy)
        u2:GetAsync(p4.UserId);
    end);
else
    task.spawn(function() -- Line: 50
        -- upvalues: u2 (copy), Players (copy)
        u2:GetAsync(Players.LocalPlayer.UserId);
    end);
end;

return table.freeze({
    GetCountryRegionForPlayerAsync = function(p5: userdata, p6: boolean?) -- Line: 57, Name: GetCountryRegionForPlayerAsync
        -- upvalues: Asserts (copy), u2 (copy)
        Asserts.Player(p5);
        Asserts.Optional(Asserts.Boolean)(p6);

        if p6 then
            return u2:Get(p5.UserId);
        end;

        return u2:GetAsync(p5.UserId);
    end
});