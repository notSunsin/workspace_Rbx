-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local ReplicationChannel = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("ReplicationChannel");
local IsDev = require(ReplicatedStorage.Modules.IsDev);
local v1 = {};
local u2 = {};

local function RequestAsset(p3: string, p4: string) -- Line: 20
    -- upvalues: u2 (copy), ReplicationChannel (copy)
    local v5 = `{p3}/{p4}`;
    local os_clock_ret = os.clock();

    if u2[v5] and os_clock_ret - u2[v5] < 2 then
        return;
    end;

    u2[v5] = os_clock_ret;
    ReplicationChannel:FireServer(p3, p4);
end;

local function FindNamespaceFolder(p6: string) -- Line: 30
    -- upvalues: LocalPlayer (copy)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

    if not PlayerGui then
        warn("PlayerGui did not exist after 4 seconds");

        return;
    end;

    local ReplicatedAssets = PlayerGui:WaitForChild("ReplicatedAssets");

    if ReplicatedAssets then
        local v7 = ReplicatedAssets:WaitForChild(p6, 60);

        if not v7 then
            warn((`[{script.Name}]: Could not find {p6} in ReplicatedAssets after 60 seconds`));
        end;

        return v7;
    end;

    warn("ReplicatedAssets did not exist after 4 seconds");
end;

function v1.GetAssetAsync(p8: table, p9: string, p10: string, p11: number?) -- Line: 42
    -- upvalues: u2 (copy), ReplicationChannel (copy), FindNamespaceFolder (copy), IsDev (copy)
    local v12 = `{p9}/{p10}`;
    local os_clock_ret = os.clock();

    if not u2[v12] or os_clock_ret - u2[v12] >= 2 then
        u2[v12] = os_clock_ret;
        ReplicationChannel:FireServer(p9, p10);
    end;

    local v13 = FindNamespaceFolder(p9);

    if not v13 then
        if IsDev() then
            warn((`[{script.Name}]: Could not find namespace '{p9}'`));
        end;

        return nil;
    end;

    local v14 = v13:FindFirstChild(p10);

    if v14 then
        return v14;
    end;

    local v15;

    if p11 then
        v15 = os.clock() + p11;
    else
        v15 = nil;
    end;

    local v16 = 1;
    local v17 = false;

    while true do
        local v18 = 3;

        if v15 then
            local v19 = v15 - os.clock();
            v18 = math.min(v18, v19);

            if v18 <= 0 then
                return nil;
            end;
        end;

        local v20 = v13:WaitForChild(p10, v18);

        if v20 then
            return v20;
        end;

        if v16 < 5 then
            v16 = v16 + 1;
            local v21 = `{p9}/{p10}`;
            local os_clock_ret2 = os.clock();

            if not u2[v21] or os_clock_ret2 - u2[v21] >= 2 then
                u2[v21] = os_clock_ret2;
                ReplicationChannel:FireServer(p9, p10);
            end;
        elseif not v17 then
            warn((`[{script.Name}]: '{p10}' has not replicated into '{p9}' after {5} requests`));
            v17 = true;
        end;
    end;
end;

return v1;