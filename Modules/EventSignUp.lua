-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SocialService = game:GetService("SocialService");
local RunService = game:GetService("RunService");
local Icon = require(ReplicatedStorage.Modules.Icon);
local _ = game.Players.LocalPlayer.PlayerGui;
local u1 = {
    NextEventId = "8394375636784906838"
};

function u1._getRsvpStatus(p2) -- Line: 27
    -- upvalues: SocialService (copy), u1 (copy), RunService (copy)
    local success, result = pcall(function() -- Line: 28
        -- upvalues: SocialService (ref), u1 (ref)
        return SocialService:GetEventRsvpStatusAsync(u1.NextEventId);
    end);

    if success then
        return result;
    end;

    if RunService:IsStudio() then
        warn((`[STUDIO EventSignUp]: Could not get RSVP status for eventId {u1.NextEventId}!`));
    end;

    return Enum.RsvpStatus.None;
end;

function u1.Start() -- Line: 45
    -- upvalues: Icon (copy), u1 (copy), SocialService (copy)
    local u3 = Icon.new();
    u3:setName("EVENT NOTIFY");
    u3:setOrder(1);
    u3:setLabel("EVENT NOTIFY");
    u3:align("Right");
    u3:setCaption("Get notified for the next event!");

    if u1:_getRsvpStatus() == Enum.RsvpStatus.Going then
        u3:destroy();
    end;

    u3.selected:Connect(function(p4) -- Line: 60
        -- upvalues: u1 (ref), u3 (copy), SocialService (ref)
        if u1.NextEventId == "" or u1.NextEventId == nil then
            warn("[EventSignUp]: Invalid NextEventId!");

            return;
        end;

        u3:deselect();

        if SocialService:PromptRsvpToEventAsync(u1.NextEventId) == Enum.RsvpStatus.Going then
            u3:destroy();
        end;
    end);
end;

task.spawn(u1.Start);

return u1;