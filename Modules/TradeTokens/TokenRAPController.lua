-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TokenRAPUtil = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPUtil);
local TokenRAPs = ReplicatedStorage.GameEvents.TradeEvents.TokenRAPs;
local u1 = {};
local u2 = {
    RAPs = {
        Pet = {},
        Holdable = {},
        TradeBoothSkin = {}
    },
    LoadTime = {
        Pet = {},
        Holdable = {},
        TradeBoothSkin = {}
    }
};

function u1.GetRAPById(p3, p4, p5) -- Line: 43
    -- upvalues: u2 (copy), u1 (copy)
    local v6 = u2.RAPs[p4][p5];

    if v6 == -1 then
        return nil;
    end;

    task.defer(u1.GetRAPByIdAsync, u1, p4, p5);

    return v6;
end;

function u1.GetRAP(p7, p8, p9) -- Line: 52
    -- upvalues: TokenRAPUtil (copy), u1 (copy)
    if not TokenRAPUtil.IsValidItem(p8, p9) then
        warn(`Invalid itemType {p8}`, p9);

        return nil;
    end;

    local ItemId = TokenRAPUtil.GetItemId(p8, p9);
    task.defer(u1.GetRAPAsync, u1, p8, p9);

    return p7:GetRAPById(p8, ItemId);
end;

function u1.GetRAPByIdAsync(p10, p11, p12) -- Line: 64
    -- upvalues: u2 (copy), TokenRAPUtil (copy), TokenRAPs (copy)
    local v13 = u2.RAPs[p11][p12];
    local v14 = u2.LoadTime[p11][p12] or 0;

    if v13 == nil and true or workspace:GetServerTimeNow() - v14 >= TokenRAPUtil.RAPCacheLifetime then
        local v15;
        v13, v15 = TokenRAPs.GetItemRAPById:InvokeServer(p11, p12);

        if not v13 and v15 then
            warn(`Failed to GetItemRAP for {p11}: {v15} item:`, p12);
        end;
    end;

    if v13 then
        u2.RAPs[p11][p12] = v13;
        u2.LoadTime[p11][p12] = workspace:GetServerTimeNow();
    end;

    return v13;
end;

function u1.GetRAPAsync(p16, p17, p18) -- Line: 88
    -- upvalues: TokenRAPUtil (copy)
    return p16:GetRAPByIdAsync(p17, (TokenRAPUtil.GetItemId(p17, p18)));
end;

function u1.Start(p19) -- Line: 94
end;

task.spawn(u1.Start, u1);

return u1;