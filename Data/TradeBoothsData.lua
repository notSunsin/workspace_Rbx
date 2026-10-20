-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.TradeData);
local Players = game:GetService("Players");

return {
    fee = 1,

    getPlayerId = function(p1: userdata) -- Line: 36, Name: getPlayerId
        return `Player_{p1.UserId}`;
    end,

    getPlayerById = function(p2: string) -- Line: 40, Name: getPlayerById
        -- upvalues: Players (copy)
        local v3 = tonumber(string.match(p2, "Player_(%-*%d+)"));

        if v3 then
            return Players:GetPlayerByUserId(v3);
        end;

        return nil;
    end,

    applyFee = function(p4: number) -- Line: 56, Name: applyFee
        return math.max(p4 * 0.99, 0);
    end
};