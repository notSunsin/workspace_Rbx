-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local PolicyService = game:GetService("PolicyService");
local RunService = game:GetService("RunService");
local Cache = require(game.ReplicatedStorage.UserGenerated.Concurrency.Cache);
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local u1 = {
    Discord = 0,
    Facebook = 1,
    Twitch = 2,
    YouTube = 3,
    X = 4,
    GitHub = 5,
    Guilded = 6
};
table.freeze(u1);
local u3 = Cache.new({
    Callback = function(p2) -- Line: 50, Name: Callback
        -- upvalues: Players (copy), PolicyService (copy)
        local PlayerByUserId = Players:GetPlayerByUserId(p2);
        assert(PlayerByUserId, "PlayerNotOnline");

        return PolicyService:GetPolicyInfoForPlayerAsync(PlayerByUserId);
    end,

    AssertKey = Asserts.Integer
});
Players.PlayerRemoving:Connect(function(p4) -- Line: 57
    -- upvalues: Players (copy), u3 (copy)
    local UserId = p4.UserId;
    task.delay(60, function() -- Line: 60
        -- upvalues: Players (ref), UserId (copy), u3 (ref)
        if not Players:GetPlayerByUserId(UserId) then
            u3:Delete(UserId);
        end;
    end);
end);

if RunService:IsServer() then
    Players.PlayerAdded:Connect(function(p5) -- Line: 67
        -- upvalues: u3 (copy)
        u3:GetAsync(p5.UserId);
    end);
end;

return table.freeze({
    ExternalLinkReference = u1,

    ExternalLinkReferencesToInts = function(p6: table) -- Line: 76, Name: ExternalLinkReferencesToInts
        -- upvalues: u1 (copy)
        local v7 = {};

        for _, v in ipairs(p6) do
            local v8 = u1[v];

            if v8 then
                table.insert(v7, v8);
            end;
        end;

        return v7;
    end,

    GetPolicyInfoForPlayerAsync = function(p9: userdata, p10: boolean?) -- Line: 87, Name: GetPolicyInfoForPlayerAsync
        -- upvalues: Asserts (copy), u3 (copy)
        Asserts.Player(p9);
        Asserts.Optional(Asserts.Boolean)(p10);

        if p10 then
            return u3:Get(p9.UserId);
        end;

        return u3:GetAsync(p9.UserId);
    end
});