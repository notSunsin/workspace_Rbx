-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");

return function(p1: userdata, u2: table) -- Line: 3, Name: SetupRemotes
    -- upvalues: RunService (copy)
    for _, child in p1:GetChildren() do
        local v3 = child:IsA("RemoteEvent");
        local v4 = child:IsA("RemoteFunction");
        local v5 = child:IsA("UnreliableRemoteEvent");

        if not (v3 or (v4 or v5)) then
            return;
        end;

        local u6 = u2[child.Name];

        if u6 then
            local v7;

            if v4 then
                v7 = nil;
            elseif RunService:IsServer() then
                v7 = child.OnServerEvent;
            else
                v7 = child.OnClientEvent;
            end;

            local function Handler(...) -- Line: 29
                -- upvalues: u6 (copy), u2 (copy)
                return u6(u2, ...);
            end;

            if v3 or v5 then
                v7:Connect(Handler);
            elseif v4 then
                child[RunService:IsServer() and "OnServerInvoke" or "OnClientInvoke"] = Handler;
            end;
        else
            warn(child, "has no associated operation?");
        end;
    end;
end;