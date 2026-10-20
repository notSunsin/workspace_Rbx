-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Types.TweenReplicationServiceTypes);
local TweenEvent = ReplicatedStorage.GameEvents.TweenEvent;
local u7 = {
    ProcessTween = function(p1, p2) -- Line: 23, Name: ProcessTween
        -- upvalues: TweenService (copy)
        local PropertiesMap = p2.PropertiesMap;
        local u3 = TweenService:Create(p2.Instance, TweenInfo.new(table.unpack(p2.TweenInfoArray)), PropertiesMap);
        u3.Completed:Connect(function() -- Line: 27
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
        u3:Play();
    end,

    Init = function(p4) -- Line: 34, Name: Init
    end,

    Start = function(u5) -- Line: 38, Name: Start
        -- upvalues: TweenEvent (copy)
        TweenEvent.OnClientEvent:Connect(function(p6) -- Line: 39
            -- upvalues: u5 (copy)
            u5:ProcessTween(p6);
        end);
    end
};
task.spawn(function() -- Line: 44
    -- upvalues: u7 (copy)
    u7:Init();
    u7:Start();
end);

return u7;