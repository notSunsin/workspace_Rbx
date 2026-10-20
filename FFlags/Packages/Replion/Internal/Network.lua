-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Utils = require(script.Parent.Utils);
local v1 = RunService:IsServer();
local u2 = RunService:IsClient();
local u3;

if Utils.ShouldMock then
    u3 = nil;
elseif v1 then
    u3 = Instance.new("Folder");
    u3.Name = "Remotes";
    u3.Parent = script.Parent.Parent;
else
    local Remotes = script.Parent.Parent:WaitForChild("Remotes", 5);
    u3 = assert(Remotes, "Did you forget to require the Replion module on the server?");
end;

return table.freeze({
    get = function(p4: string) -- Line: 34, Name: get
        -- upvalues: u3 (ref), u2 (copy)
        local v5 = u3:FindFirstChild(p4);

        if v5 then
            return v5;
        end;

        if u2 then
            error("Did you forget to require the Replion module on the server?");
        end;

        local RemoteEvent = Instance.new("RemoteEvent");
        RemoteEvent.Name = p4;
        RemoteEvent.Parent = u3;

        return RemoteEvent;
    end,

    create = function(p6: table) -- Line: 49, Name: create
        -- upvalues: u3 (ref), u2 (copy)
        for _, v in p6 do
            if not u3:FindFirstChild(v) then
                if u2 then
                    error("Did you forget to require the Replion module on the server?");
                end;

                local RemoteEvent = Instance.new("RemoteEvent");
                RemoteEvent.Name = v;
                RemoteEvent.Parent = u3;
            end;
        end;
    end,

    sendTo = function(p7: any, p8: string, ...) -- Line: 55, Name: sendTo
        -- upvalues: Utils (copy), u3 (ref), u2 (copy), Players (copy)
        if Utils.ShouldMock then
            return;
        end;

        local v9 = u3:FindFirstChild(p8);

        if not v9 then
            if u2 then
                error("Did you forget to require the Replion module on the server?");
            end;

            v9 = Instance.new("RemoteEvent");
            v9.Name = p8;
            v9.Parent = u3;
        end;

        if p7 == "All" then
            v9:FireAllClients(...);

            return;
        end;

        if type(p7) == "table" then
            for _, v in p7 do
                if v:IsDescendantOf(Players) then
                    v9:FireClient(v, ...);
                end;
            end;

            return;
        end;

        if typeof(p7) == "Instance" and p7:IsA("Player") then
            v9:FireClient(p7, ...);

            return;
        end;

        error("Invalid replicateTo!");
    end
});