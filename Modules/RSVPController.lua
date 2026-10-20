-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SocialService = game:GetService("SocialService");
local PlatformProvider = require(ReplicatedStorage.Modules.PlatformProvider);
local u4 = {
    Prompt = function(p1: table, u2: string, p3: string) -- Line: 9, Name: Prompt
        -- upvalues: PlatformProvider (copy), SocialService (copy)
        local string_lower_ret = string.lower(PlatformProvider:GetPlatform());

        if not table.find(string.split(p3, "/"), string_lower_ret == "computer" and "pc" or (string_lower_ret == "unknowncomputerormobile" and "mobile" or string_lower_ret)) then
            return;
        end;

        xpcall(function() -- Line: 21
            -- upvalues: SocialService (ref), u2 (copy)
            SocialService:PromptRsvpToEventAsync(u2);
        end, warn);
    end
};

function u4.Start(p5) -- Line: 26
    -- upvalues: ReplicatedStorage (copy), u4 (copy)
    ReplicatedStorage.GameEvents.PromptRSVP.OnClientEvent:Connect(function(p6: string, p7: string, p8: boolean?) -- Line: 27
        -- upvalues: u4 (ref)
        if p8 then
            task.wait(Random.new():NextInteger(30, 120));
        end;

        u4:Prompt(p6, p7);
    end);
end;

task.spawn(u4.Start, u4);

return u4;