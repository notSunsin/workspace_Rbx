-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PolicyService = game:GetService("PolicyService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local RetryPcall = require(ReplicatedStorage.Modules.RetryPcall);
local v1 = {};
local u2 = {};
local u3 = {};

function v1.GetPolicyInfoForPlayerAsync(p4: table, u5: userdata) -- Line: 25
    -- upvalues: RunService (copy), Players (copy), u2 (copy), u3 (copy), RetryPcall (copy), PolicyService (copy)
    if RunService:IsClient() and u5 ~= Players.LocalPlayer then
        error("PolicyService:GetPolicyForPlayerAsync can only be called for the LocalPlayer in the client");
    end;

    while u2[u5] and u5:IsDescendantOf(Players) do
        task.wait();
    end;

    if not u5:IsDescendantOf(Players) then
        return nil;
    end;

    local v6 = u3[u5];

    if v6 then
        return v6;
    end;

    u2[u5] = true;
    local v7, v8 = RetryPcall(15, 30, function() -- Line: 47
        -- upvalues: PolicyService (ref), u5 (copy)
        return PolicyService:GetPolicyInfoForPlayerAsync(u5);
    end);
    u2[u5] = nil;

    if not v7 then
        return nil;
    end;

    if u5:IsDescendantOf(Players) then
        u3[u5] = v8;
    end;

    return v8;
end;

if RunService:IsServer() then
    Players.PlayerRemoving:Connect(function(p9: userdata) -- Line: 65
        -- upvalues: u3 (copy)
        u3[p9] = nil;
    end);
end;

return v1;