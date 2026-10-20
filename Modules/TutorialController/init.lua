-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local v1 = {};
local TradeWorldController = require(ReplicatedStorage.Modules.TradeControllers.TradeWorldController);
require(ReplicatedStorage.Modules.IsDev);

function v1.Start(p2) -- Line: 12
    -- upvalues: TradeWorldController (copy), ReplicatedStorage (copy)
    if TradeWorldController:IsInWorld() then
        return;
    end;

    local u3 = nil;
    ReplicatedStorage.GameEvents.Tutorial.Start.OnClientEvent:Connect(function(p4: string?) -- Line: 18
        -- upvalues: u3 (ref)
        if type(u3) == "function" then
            u3();
        end;

        local v5 = p4 and script.Variants:FindFirstChild(p4) or script.Variants:FindFirstChild("Variant4");

        if v5 then
            u3 = require(v5)();

            return;
        end;

        warn("No tutorial variant found to start");
    end);
end;

task.spawn(v1.Start, v1);

return v1;