-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
game:GetService("ReplicatedStorage");
require(script.ABTestTypes);
local v1 = {};

for _, child in script.Experiments:GetChildren() do
    if child:IsA("ModuleScript") then
        local v2 = require(child);
        local RemoteConfig = v2.RemoteConfig;

        if #RemoteConfig > 16 then
            warn((`RemoteConfig '{RemoteConfig}' is longer than the maximum of 15 characters, skipping '{child.Name}' experiment.`));
        else
            v1[child.Name] = v2;
        end;
    end;
end;

return v1;