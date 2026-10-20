-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local SettingsService = require(game.ReplicatedStorage.Modules.Settings.SettingsService);
local DataService = require(game.ReplicatedStorage.Modules.DataService);
local u1 = not SettingsService:GetSetting("PerformanceMode");
local u2 = {
    Color3.fromRGB(233, 59, 59),
    Color3.fromRGB(21, 223, 68),
    Color3.fromRGB(45, 202, 233),
    Color3.fromRGB(255, 238, 5),
    Color3.fromRGB(192, 43, 233),
    Color3.fromRGB(5, 0, 194)
};
task.spawn(function() -- Line: 21
    -- upvalues: u1 (ref), CollectionService (copy), u2 (copy)
    while u1 do
        for _, v in CollectionService:GetTagged("SpiritSparkleAnimation") do
            v.Color = u2[math.random(1, #u2)];
            task.wait();
        end;

        task.wait(1);
    end;
end);
local u3 = nil;
u3 = DataService:GetPathSignal("Settings/@"):Connect(function() -- Line: 34
    -- upvalues: u1 (ref), SettingsService (copy), u3 (ref)
    u1 = not SettingsService:GetSetting("PerformanceMode");

    if u1 then
        return;
    end;

    if u3 then
        u3:Disconnect();
        u3 = nil;
    end;
end);

return {};