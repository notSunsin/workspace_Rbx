-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
ReplicatedStorage:WaitForChild("Modules");
local ReplicationClass = require(ReplicatedStorage.Modules.ReplicationClass);
require(script:WaitForChild("class"));
local Data = ReplicatedStorage:WaitForChild("Data");
require(Data:WaitForChild("DefaultData"));
local LocalPlayer = game:GetService("Players").LocalPlayer;
local v1 = {
    Receiver = ReplicationClass.new((`{LocalPlayer.Name}_DataServiceProfile`))
};
v1.Receiver:YieldUntilData();

function v1.GetPathSignal(p2, p3) -- Line: 33
    local Receiver = p2.Receiver;

    if Receiver then
        Receiver:YieldUntilData(25);

        return Receiver:GetPathSignal(p3);
    end;
end;

function v1.GetData(p4) -- Line: 39
    local Receiver = p4.Receiver;

    if not Receiver then
        return {};
    end;

    Receiver:YieldUntilData();
    local v5 = Receiver:YieldUntilData(10);

    return not v5 and {} or v5.Table;
end;

return v1;